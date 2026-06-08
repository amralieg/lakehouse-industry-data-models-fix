-- Schema for Domain: ledger | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`ledger` COMMENT 'General ledger and financial accounting system of record covering chart of accounts, journal entries, subledgers, cost centers, intercompany eliminations, AP/AR, financial close, consolidation, and trial balance. Supports SOX financial controls and IFRS/GAAP reporting. Primary system of record aligned with Oracle Financials / SAP S/4HANA.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the general ledger account in the chart of accounts master registry.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Chart of accounts must specify native currency for each account to support multi-currency GL operations, currency-specific reporting, and FX revaluation processes required in global banking operations',
    `reporting_code_id` BIGINT COMMENT 'Foreign key linking to reference.reporting_code. Business justification: Chart of accounts maps to GAAP reporting codes for regulatory filing; this link enables automated financial statement preparation and US GAAP compliance reporting.',
    `account_code` STRING COMMENT 'The unique alphanumeric code identifying the general ledger account. This is the externally-known business identifier used in all journal entries and financial reports. Typically follows a hierarchical numbering scheme (e.g., 1000-1999 for assets, 2000-2999 for liabilities).. Valid values are `^[0-9]{4,10}$`',
    `account_description` STRING COMMENT 'A detailed description of the purpose, usage guidelines, and business rules for this account. Provides additional context beyond the account name for users posting journal entries and for auditors reviewing account activity.',
    `account_level` STRING COMMENT 'The level of this account in the chart of accounts hierarchy (e.g., 1 for top-level summary accounts, 2 for sub-categories, 3 for detail accounts). Used for drill-down reporting and financial statement presentation at different levels of detail.',
    `account_name` STRING COMMENT 'The full descriptive name of the general ledger account (e.g., Cash and Cash Equivalents, Accounts Receivable - Trade, Interest Income on Loans). This is the human-readable label used in financial statements and reports.',
    `account_status` STRING COMMENT 'The current lifecycle status of the general ledger account. Active accounts accept postings; inactive accounts are closed and do not accept new postings; blocked accounts are temporarily suspended; pending closure accounts are in the process of being closed after final reconciliation.. Valid values are `active|inactive|blocked|pending_closure`',
    `account_subtype` STRING COMMENT 'A more granular classification within the account type (e.g., current asset, fixed asset, current liability, long-term liability, operating revenue, non-operating revenue, operating expense, non-operating expense). Used for detailed financial statement presentation and analysis.',
    `account_type` STRING COMMENT 'The fundamental accounting classification of the account determining its placement in the financial statements and its normal balance direction. Asset and expense accounts have debit normal balances; liability, equity, and revenue accounts have credit normal balances.. Valid values are `asset|liability|equity|revenue|expense`',
    `alternate_account_code` STRING COMMENT 'An alternate or legacy account code used for cross-reference purposes during system migrations, mergers and acquisitions (M&A), or for mapping to external reporting frameworks. Allows historical data to be linked to the current chart of accounts structure.',
    `consolidation_group` STRING COMMENT 'The consolidation grouping code used for multi-entity financial consolidation and elimination of intercompany transactions. Identifies which legal entities or business units this account applies to and how it should be treated in consolidated financial statements.',
    `cost_center_code` STRING COMMENT 'The default cost center or responsibility center associated with this account for management accounting and internal reporting. Used for departmental P&L, budget tracking, and variance analysis.',
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
    `legal_entity_code` STRING COMMENT 'The code identifying the legal entity or subsidiary to which this account belongs. Used for multi-entity accounting, statutory reporting by legal entity, and intercompany elimination processing.',
    `normal_balance` STRING COMMENT 'Indicates whether the account normally carries a debit or credit balance. Asset and expense accounts have debit normal balances; liability, equity, and revenue accounts have credit normal balances. Used for validation of journal entries and trial balance preparation.. Valid values are `debit|credit`',
    `parent_account_code` STRING COMMENT 'The account code of the parent account in a hierarchical chart of accounts structure. Used for roll-up reporting and financial statement aggregation. Null for top-level accounts.',
    `posting_allowed_flag` BOOLEAN COMMENT 'Indicates whether direct manual journal entries are allowed to this account, or whether it is a control/summary account that only receives automated postings from subledgers. Control accounts typically have this flag set to false to prevent manual posting errors.',
    `profit_center_code` STRING COMMENT 'The default profit center or business unit associated with this account for segment reporting and profitability analysis. Used for line of business (LOB) reporting and RAROC calculations.',
    `reconciliation_required_flag` BOOLEAN COMMENT 'Indicates whether this account requires periodic reconciliation to external statements or subledger systems (e.g., bank statements, loan subledger, securities positions). Accounts flagged for reconciliation are subject to monthly close procedures and variance investigation.',
    `regulatory_reporting_category` STRING COMMENT 'The classification of this account for banking regulatory reports such as Call Reports (FFIEC 031/041), FR Y-9C, Basel III capital adequacy reporting, and liquidity coverage ratio (LCR) calculations. Maps GL accounts to regulatory reporting line items.',
    `risk_weighted_asset_category` STRING COMMENT 'The Basel III risk-weighted asset category for this account, used in capital adequacy calculations (e.g., credit risk - corporate exposures, credit risk - retail exposures, market risk, operational risk). Determines the risk weighting applied for Common Equity Tier 1 (CET1) ratio calculations.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this account is subject to Sarbanes-Oxley Act (SOX) internal control testing and documentation requirements. Accounts flagged as SOX-controlled require additional review, approval workflows, and audit trail documentation for all journal entries.',
    `statistical_account_flag` BOOLEAN COMMENT 'Indicates whether this is a statistical (non-monetary) account used to track quantities, headcount, or other non-financial metrics for management reporting and ratio analysis (e.g., number of employees, number of accounts, transaction volumes). Statistical accounts do not appear in financial statements but support KPI calculations.',
    `subledger_source` STRING COMMENT 'The name of the subledger system that feeds detailed transactions into this GL account (e.g., Loan Origination System, Trading System, Accounts Payable, Accounts Receivable, Fixed Assets). Used for subledger-to-GL reconciliation and drill-down analysis.',
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
    `org_unit_id` BIGINT COMMENT 'Reference to the business unit or line of business (LOB) to which this account belongs. Supports divisional reporting and performance measurement.',
    `parent_account_gl_account_id` BIGINT COMMENT 'Reference to the parent account in the account hierarchy. Enables roll-up reporting and hierarchical financial analysis.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center for internal profitability analysis. Used for segment reporting and management decision-making.',
    `reporting_code_id` BIGINT COMMENT 'Foreign key linking to reference.reporting_code. Business justification: GL accounts are tagged with regulatory reporting codes for automated regulatory report generation; this link enables Basel III, CCAR, DFAST, and other prudential reporting.',
    `set_id` BIGINT COMMENT 'Reference to the ledger set (primary, secondary, reporting, tax) to which this account belongs. Supports multiple accounting bases (GAAP, IFRS, tax) and parallel ledgers.',
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
    `employee_id` BIGINT COMMENT 'User ID or employee identifier of the person who approved the journal entry, supporting SOX approval workflow and segregation of duties.',
    `batch_id` BIGINT COMMENT 'Batch or group identifier for journal entries processed together, supporting bulk posting, import tracking, and operational efficiency.',
    `breach_id` BIGINT COMMENT 'Foreign key linking to compliance.breach. Business justification: Compliance breaches often require corrective journal entries for customer restitution accruals, regulatory penalty provisions, and remediation cost reserves. Enables tracking of financial impact, audi',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Journal entries are denominated in transaction currencies; this link is required for FX gain/loss calculation, multi-currency reporting, and currency translation per IAS 21 in banking operations.',
    `primary_journal_employee_id` BIGINT COMMENT 'User ID or employee identifier of the person who prepared or created the journal entry, supporting SOX segregation of duties controls.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (subsidiary, branch, operating company) to which this journal entry belongs for consolidation and statutory reporting.',
    `recurring_template_id` BIGINT COMMENT 'Reference to the recurring journal entry template from which this entry was generated, if applicable. Null for non-recurring entries.',
    `reversed_journal_entry_id` BIGINT COMMENT 'Reference to the original journal entry that this entry reverses, establishing the reversal relationship for audit trail. Null if not a reversal.',
    `set_id` BIGINT COMMENT 'Reference to the ledger (primary, secondary, adjustment, statutory, management, tax) in which this journal entry is recorded.',
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
    `batch_id` BIGINT COMMENT 'Batch identifier for grouped postings from automated interfaces. Supports reconciliation and error investigation.',
    `cost_center_id` BIGINT COMMENT 'FK to ledger.cost_center',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Individual journal lines may be entered in currencies different from header; this link supports multi-currency transaction processing, line-level FX calculation, and detailed currency reporting in ban',
    `gl_account_id` BIGINT COMMENT 'FK to ledger.gl_account',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Securities transactions (purchases, sales, mark-to-market adjustments, coupon accruals) post to GL at line level. IFRS 9, Basel III regulatory capital, and investment accounting require instrument-lev',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header. Links this line to the batch-level posting event.',
    `employee_id` BIGINT COMMENT 'User ID of the person or system account that created this journal entry line. Supports SOX audit trail and maker-checker controls.',
    `profit_center_id` BIGINT COMMENT 'FK to ledger.profit_center',
    `reversed_line_journal_entry_line_id` BIGINT COMMENT 'Reference to the original journal entry line being reversed. Maintains audit trail for reversing entries.',
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
    `subledger_reference_code` STRING COMMENT 'Reference identifier to the originating subledger transaction. Enables drill-back to source documents for audit and reconciliation.',
    `subledger_type` STRING COMMENT 'Type of subledger that originated this posting. Links GL to operational systems such as AP, AR, loan origination, or trading platforms. [ENUM-REF-CANDIDATE: accounts_payable|accounts_receivable|fixed_assets|cash_management|loan|deposit|securities|none — 8 candidates stripped; promote to reference product]',
    `tax_code` STRING COMMENT 'Tax code for VAT, GST, or other tax treatment. Supports tax reporting and compliance with FATCA and CRS requirements.. Valid values are `^[A-Z0-9]{2,10}$`',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit or credit line within a journal entry, representing the atomic posting to a specific GL account. Captures line number, GL account code, cost center, profit center, segment, project code, intercompany entity, debit amount, credit amount, functional currency amount, entered currency, exchange rate, exchange rate type, description, tax code, and subledger reference. Supports full dimensional analysis for IFRS/GAAP reporting and SOX audit trail requirements.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`accounting_period` (
    `accounting_period_id` BIGINT COMMENT 'Unique identifier for the accounting period record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the user who last updated this accounting period record. Supports audit trail and accountability.',
    `holiday_calendar_id` BIGINT COMMENT 'Reference to the fiscal calendar definition that governs this accounting period. Supports multiple fiscal calendars for different legal entities or reporting requirements.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity for which this accounting period is defined. Supports multi-entity consolidation and statutory reporting.',
    `primary_accounting_employee_id` BIGINT COMMENT 'Reference to the user who opened the accounting period. Supports audit trail and SOX compliance for period status changes.',
    `quaternary_accounting_sox_certified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who certified the period for SOX compliance. Supports audit trail and accountability.',
    `quinary_accounting_record_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this accounting period record. Supports audit trail and accountability.',
    `regulatory_calendar_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_calendar. Business justification: Regulatory filings are tied to accounting periods (Call Reports quarterly, FR Y-9C annually, FFIEC 101 monthly). Enables automated filing schedule management, period close coordination with regulatory',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Regulatory exams scope specific accounting periods for transaction testing, control evaluation, and financial statement validation. Enables period-specific exam finding remediation tracking, lookback ',
    `set_id` BIGINT COMMENT 'Reference to the general ledger or ledger set to which this accounting period belongs. Links to the primary or secondary ledger in multi-ledger environments (e.g., statutory, management, tax ledgers).',
    `tertiary_accounting_permanently_closed_by_user_employee_id` BIGINT COMMENT 'Reference to the user who permanently closed the accounting period. Supports audit trail and SOX compliance for period status changes.',
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
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Cost centers in retail banking are frequently aligned to physical branches for P&L attribution, expense allocation, and branch profitability reporting. Essential for management accounting and branch p',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Cost center budgets are set in specific currencies; this link enables budget vs. actual reporting in correct currency, budget translation for consolidation, and multi-currency budget management.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Cost centers are located in specific countries for regulatory reporting and transfer pricing; this link enables country-level cost analysis, regulatory reporting, and geographic profitability tracking',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity to which this cost center belongs. Used for statutory reporting and consolidation.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the business unit or division to which this cost center is assigned.',
    `parent_cost_center_id` BIGINT COMMENT 'Identifier of the parent cost center in the organizational hierarchy. Null for top-level units. Enables hierarchical roll-up of costs and revenues.',
    `employee_id` BIGINT COMMENT 'FK to hr.employee',
    `tertiary_cost_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person who last modified this cost center record. Used for audit trail and SOX compliance.',
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
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Compliance obligations apply to specific legal entities based on charter type, jurisdiction, and regulatory scope (e.g., Dodd-Frank applies to bank holding companies >$50B assets). Enables entity-spec',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Legal entities are incorporated in specific jurisdictions; this link enables regulatory reporting, legal structure analysis, corporate governance tracking, and jurisdiction-specific compliance in bank',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Every legal entity has a functional currency per IAS 21; this is mandatory for IFRS consolidation, currency translation, and financial statement preparation in multi-entity banking groups.',
    `parent_legal_entity_id` BIGINT COMMENT 'Foreign key reference to the immediate parent legal entity within the banking group hierarchy. Null for the ultimate parent entity. Used for consolidation, intercompany eliminations, and organizational reporting.',
    `primary_ultimate_parent_legal_entity_id` BIGINT COMMENT 'Foreign key reference to the top-level parent legal entity (holding company) of the entire banking group. Used for ultimate consolidation and group-level regulatory reporting.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Exams target specific legal entities based on charter type and regulatory jurisdiction. Fundamental for exam scoping, CAMELS rating assignment, entity-level MRA tracking, and coordinating responses ac',
    `regulatory_taxonomy_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_taxonomy. Business justification: Legal entities follow specific accounting standards (IFRS, US GAAP); this link enables taxonomy-driven financial reporting, regulatory filing automation, and accounting standard compliance tracking.',
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
    `jurisdiction_of_incorporation` STRING COMMENT 'Legal jurisdiction (state, province, or country) where the entity is incorporated or registered. Determines applicable corporate law, tax regime, and regulatory oversight.',
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

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`set` (
    `set_id` BIGINT COMMENT 'Unique identifier for the ledger set configuration within the financial accounting system.',
    `accounting_calendar_id` BIGINT COMMENT 'Reference to the fiscal calendar defining the period structure (months, quarters, years) used for financial reporting and period close processes in this ledger.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the chart of accounts structure assigned to this ledger set, defining the account hierarchy and classification scheme for financial transactions.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Each ledger set operates in a functional currency for consolidation purposes; this link enables multi-ledger consolidation, currency translation, and IFRS-compliant financial reporting.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the primary legal entity or group of entities for which this ledger set maintains financial records. Each legal entity must post to at least one primary ledger.',
    `accounting_standard` STRING COMMENT 'The accounting framework and principles applied in this ledger set for transaction recognition, measurement, and financial statement presentation. Enables simultaneous multi-GAAP reporting through secondary ledgers.. Valid values are `US_GAAP|IFRS|local_GAAP|statutory|regulatory|tax`',
    `average_balance_processing_flag` BOOLEAN COMMENT 'Indicates whether this ledger set maintains daily average balance calculations for balance sheet accounts, required for Net Interest Margin (NIM) and Funds Transfer Pricing (FTP) analytics in banking.',
    `budget_control_enabled_flag` BOOLEAN COMMENT 'Indicates whether budgetary control and funds checking are enforced for transactions posted to this ledger set, preventing overspending against approved budgets.',
    `cecl_compliant_flag` BOOLEAN COMMENT 'Indicates whether this ledger set applies FASB ASC 326 Current Expected Credit Losses (CECL) methodology for estimating lifetime credit losses on financial instruments.',
    `consolidation_method` STRING COMMENT 'The method used to consolidate this ledger set into group financial statements. Full consolidation for subsidiaries, proportionate for joint ventures, equity method for associates, none for standalone entities.. Valid values are `full|proportionate|equity|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ledger set configuration record was initially created in the financial system.',
    `effective_end_date` DATE COMMENT 'The date on which this ledger set configuration was deactivated or superseded. Null for currently active ledger sets.',
    `effective_start_date` DATE COMMENT 'The date from which this ledger set configuration became active and available for transaction posting and financial reporting.',
    `encumbrance_accounting_flag` BOOLEAN COMMENT 'Indicates whether this ledger set records purchase orders and commitments as encumbrances, reserving budget funds before actual expenditure occurs.',
    `first_posted_period` STRING COMMENT 'The earliest accounting period in which transactions were posted to this ledger set, establishing the beginning of the financial history.',
    `ifrs_9_compliant_flag` BOOLEAN COMMENT 'Indicates whether this ledger set applies IFRS 9 Financial Instruments standard for classification, measurement, and Expected Credit Loss (ECL) impairment of financial assets.',
    `intercompany_elimination_flag` BOOLEAN COMMENT 'Indicates whether intercompany transactions and balances are automatically eliminated during consolidation processing for this ledger set.',
    `journal_approval_required_flag` BOOLEAN COMMENT 'Indicates whether manual journal entries posted to this ledger set require supervisory approval before posting, supporting Sarbanes-Oxley Act (SOX) internal control requirements.',
    `last_updated_by` STRING COMMENT 'User identifier of the system administrator or financial controller who most recently modified this ledger set configuration.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this ledger set configuration record was most recently modified in the financial system.',
    `latest_closed_period` STRING COMMENT 'The most recent accounting period that has completed the period close process, including all reconciliations, adjustments, and financial statement generation.',
    `latest_opened_period` STRING COMMENT 'The most recent accounting period that has been opened for transaction posting in this ledger set. Subsequent periods remain closed until explicitly opened.',
    `ledger_name` STRING COMMENT 'Business name of the ledger set used for identification and reporting purposes within the financial system.',
    `ledger_short_name` STRING COMMENT 'Abbreviated name or code for the ledger set used in system displays and reports.',
    `ledger_status` STRING COMMENT 'Current operational status of the ledger set indicating whether it is available for transaction posting and financial reporting.. Valid values are `active|inactive|closed|suspended`',
    `ledger_type` STRING COMMENT 'Classification of the ledger set indicating its purpose within the financial accounting architecture. Primary ledgers represent the official books of record; secondary ledgers enable parallel accounting under different standards; reporting ledgers support management reporting; adjustment ledgers track post-close adjustments; simulation ledgers support scenario planning; consolidation ledgers aggregate multiple legal entities.. Valid values are `primary|secondary|reporting|adjustment|simulation|consolidation`',
    `period_close_tolerance_amount` DECIMAL(18,2) COMMENT 'The maximum out-of-balance amount permitted during period close reconciliation before the close process is blocked. Supports financial close controls and accuracy requirements.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this ledger set is designated as the source of truth for regulatory capital, liquidity, and prudential reporting submissions to banking supervisors (Fed, OCC, EBA, PRA).',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the currency in which consolidated financial statements and management reports are presented. May differ from functional currency for multinational entities.. Valid values are `^[A-Z]{3}$`',
    `retained_earnings_account` STRING COMMENT 'The general ledger account code designated to receive net income or loss transfers during the year-end close process for this ledger set.',
    `revaluation_method` STRING COMMENT 'The frequency and method for revaluing foreign currency balances to reflect current exchange rates. Period-end revaluation occurs at month close; daily revaluation supports mark-to-market trading book requirements.. Valid values are `period_end|daily|none`',
    `segment_value_security_enabled_flag` BOOLEAN COMMENT 'Indicates whether data-level security rules restrict user access to specific chart of accounts segment values (e.g., cost centers, business units) within this ledger set.',
    `set_description` STRING COMMENT 'Detailed business description of the ledger set purpose, scope, and usage within the financial accounting architecture.',
    `sox_control_ledger_flag` BOOLEAN COMMENT 'Indicates whether this ledger set is subject to Sarbanes-Oxley Act Section 404 internal control testing and audit requirements for financial reporting accuracy.',
    `subledger_accounting_method` STRING COMMENT 'The accounting basis and recognition method applied when subledger transactions (AP, AR, FA, etc.) are transferred to the general ledger. Defines timing of revenue and expense recognition.. Valid values are `accrual|cash|modified_cash|commitment`',
    `suspense_account` STRING COMMENT 'The general ledger account code used to temporarily hold unbalanced or unidentified transactions pending investigation and reclassification.',
    `translation_method` STRING COMMENT 'The method used to translate foreign currency balances into the reporting currency for consolidation. Current rate method translates all assets and liabilities at the closing rate; temporal method uses historical rates for non-monetary items.. Valid values are `current_rate|temporal|monetary_nonmonetary`',
    `created_by` STRING COMMENT 'User identifier of the system administrator or financial controller who created this ledger set configuration.',
    CONSTRAINT pk_set PRIMARY KEY(`set_id`)
) COMMENT 'Configuration of a primary or secondary ledger within the financial accounting system, defining the accounting representation for a legal entity or group of entities. Captures ledger name, ledger type (primary, secondary, reporting), currency, accounting calendar, chart of accounts assignment, subledger accounting method, GAAP standard (IFRS, US GAAP, local GAAP), and associated legal entities. Each legal entity posts to at least one primary ledger; secondary ledgers enable simultaneous multi-GAAP reporting and multi-currency consolidation. Core configuration entity in Oracle Financials / SAP S/4HANA.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`subledger` (
    `subledger_id` BIGINT COMMENT 'Unique identifier for the subledger configuration and reconciliation record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: subledger currently stores accounting_period as STRING but should FK to accounting_period table to properly link subledger reconciliation records to the formal accounting period definition. Enables pe',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Subledgers (card processing, ATM networks, digital banking platforms) are inherently channel-specific. Reconciliation, GL posting, and operational risk management require channel attribution. Standard',
    `compliance_sox_control_id` BIGINT COMMENT 'Identifier of the Sarbanes-Oxley (SOX) financial control that this reconciliation supports as evidence.',
    `gl_account_id` BIGINT COMMENT 'FK to ledger.gl_account',
    `cost_center_id` BIGINT COMMENT 'FK to ledger.cost_center',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Subledgers track balances in specific currencies before GL posting; this link enables subledger-to-GL reconciliation in correct currency and supports multi-currency subledger accounting.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Securities subledgers (trading book, investment portfolio, collateral register) track positions by instrument and reconcile to GL. Required for daily P&L attribution, risk-weighted asset calculations,',
    `legal_entity_id` BIGINT COMMENT 'FK to ledger.legal_entity',
    `employee_id` BIGINT COMMENT 'User identifier of the individual who reviewed the subledger reconciliation.',
    `subledger_employee_id` BIGINT COMMENT 'User identifier of the individual who prepared the subledger reconciliation.',
    `subledger_reconciliation_id` BIGINT COMMENT 'Unique identifier for the period-end reconciliation execution run linking subledger balances to General Ledger (GL) posted balances.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this subledger configuration is currently active (True) or has been decommissioned (False).',
    `approval_date` DATE COMMENT 'Date on which the subledger reconciliation was formally approved by the reviewer.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this reconciliation to external audit work papers or internal audit evidence repository.',
    `auto_reconciliation_flag` BOOLEAN COMMENT 'Indicates whether the reconciliation was performed automatically by the system (True) or required manual intervention (False).',
    `balance_amount` DECIMAL(18,2) COMMENT 'Aggregate balance amount from the subledger module for the reconciliation period, in the reporting currency.',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit or line of business (LOB) responsible for this subledger.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this subledger configuration or reconciliation record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which this subledger configuration was decommissioned or ceased feeding the General Ledger (GL). Null if still active.',
    `effective_start_date` DATE COMMENT 'Date from which this subledger configuration became effective and began feeding the General Ledger (GL).',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 code representing the functional currency of the legal entity or business unit to which this subledger belongs.. Valid values are `^[A-Z]{3}$`',
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

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` (
    `subledger_reconciliation_id` BIGINT COMMENT 'Unique identifier for the subledger reconciliation record. Primary key.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: subledger_reconciliation stores accounting_period as STRING but should FK to accounting_period for referential integrity. Reconciliations are performed for specific accounting periods and need to refe',
    `employee_id` BIGINT COMMENT 'Identifier of the individual who approved the reconciliation. Required for SOX authorization controls and final sign-off evidence.',
    `compliance_sox_control_id` BIGINT COMMENT 'Reference to the specific SOX control that this reconciliation satisfies. Links the reconciliation to the control framework for audit and compliance testing.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Reconciliations compare balances in specific currencies; this link enables currency-specific variance analysis and supports SOX controls for multi-currency subledger reconciliation.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: subledger_reconciliation has journal_entry_reference STRING attribute that stores reference to journal entries created to resolve reconciliation variances. Should be proper FK to journal_entry table f',
    `primary_subledger_employee_id` BIGINT COMMENT 'Identifier of the individual who prepared the reconciliation. Required for SOX segregation of duties controls.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the individual who reviewed the reconciliation. Required for SOX segregation of duties controls and independent review evidence.',
    `approval_date` DATE COMMENT 'The date on which the reconciliation was formally approved. Critical for period-end close governance and SOX control evidence.',
    `approver_name` STRING COMMENT 'Full name of the individual who approved the reconciliation. Used for audit trail and accountability.',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit or division responsible for the reconciliation. Used for segment reporting and management accountability.',
    `cost_center_code` STRING COMMENT 'Code identifying the cost center responsible for the reconciliation activity. Used for internal management reporting and cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation record was first created in the system. Used for audit trail and data lineage.',
    `exception_count` STRING COMMENT 'The number of individual exceptions or discrepancies identified during the reconciliation process. Used for control effectiveness monitoring.',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter functional currency code for the reporting entity. Used for foreign currency translation and consolidation per GAAP/IFRS.. Valid values are `^[A-Z]{3}$`',
    `gl_account_range_end` STRING COMMENT 'The ending GL account code in the range being reconciled. Defines the scope of GL accounts included in this reconciliation run.',
    `gl_account_range_start` STRING COMMENT 'The starting GL account code in the range being reconciled. Defines the scope of GL accounts included in this reconciliation run.',
    `gl_balance` DECIMAL(18,2) COMMENT 'The total balance from the general ledger for the specified period and account range. Represents the GL system balance to be reconciled.',
    `gl_system_name` STRING COMMENT 'Name of the general ledger system from which the GL balance was extracted. Used for data lineage and system integration monitoring.',
    `is_material_variance` BOOLEAN COMMENT 'Boolean flag indicating whether the variance exceeds the materiality threshold and requires escalation. Used for exception reporting and control monitoring.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation record was last modified. Used for audit trail and change tracking.',
    `legal_entity_code` STRING COMMENT 'Code identifying the legal entity for which the reconciliation is performed. Required for multi-entity consolidation and intercompany eliminations.',
    `materiality_threshold` DECIMAL(18,2) COMMENT 'The predetermined threshold amount for variance materiality. Variances exceeding this threshold require escalation and detailed investigation per SOX controls.',
    `preparer_name` STRING COMMENT 'Full name of the individual who prepared the reconciliation. Used for audit trail and accountability.',
    `reconciliation_date` DATE COMMENT 'The date on which the reconciliation was performed. Used for audit trail and SOX control testing.',
    `reconciliation_frequency` STRING COMMENT 'The scheduled frequency at which this reconciliation is performed. Defines the control cadence per SOX control design.. Valid values are `daily|weekly|monthly|quarterly|annual|ad_hoc`',
    `reconciliation_method` STRING COMMENT 'The method used to perform the reconciliation. Indicates the level of automation and manual intervention required.. Valid values are `automated|manual|semi_automated`',
    `reconciliation_notes` STRING COMMENT 'Additional notes or comments related to the reconciliation process, including special circumstances, assumptions, or follow-up actions required.',
    `reconciliation_number` STRING COMMENT 'Business-facing unique identifier for the reconciliation run, typically formatted as a human-readable reference number for audit trail and SOX control evidence.',
    `reconciliation_status` STRING COMMENT 'Current status of the reconciliation process. Tracks the lifecycle from initiation through approval or exception resolution.. Valid values are `reconciled|in_progress|exception|pending_review|approved|rejected`',
    `requires_journal_entry` BOOLEAN COMMENT 'Boolean flag indicating whether a correcting journal entry is required to resolve the variance. Used for workflow routing and period-end close tracking.',
    `resolution_action` STRING COMMENT 'Description of the corrective action taken or planned to resolve identified variances. Includes journal entry references, system corrections, or process improvements.',
    `resolution_date` DATE COMMENT 'The date on which the variance was resolved and the reconciliation was brought to a reconciled state. Used for aging analysis and control timeliness metrics.',
    `review_date` DATE COMMENT 'The date on which the reconciliation was reviewed. Used for control timeliness testing and SOX compliance evidence.',
    `reviewer_name` STRING COMMENT 'Full name of the individual who reviewed the reconciliation. Used for audit trail and accountability.',
    `source_system_name` STRING COMMENT 'Name of the subledger source system from which the subledger balance was extracted. Used for data lineage and system integration monitoring.',
    `sox_control_evidence_reference` STRING COMMENT 'Reference to the supporting documentation or evidence repository for this reconciliation. Used by internal and external auditors for SOX testing.',
    `subledger_balance` DECIMAL(18,2) COMMENT 'The total balance from the subledger system for the specified period and account range. Represents the source system balance to be reconciled.',
    `subledger_type` STRING COMMENT 'Type of subledger being reconciled to the general ledger. Identifies the source subledger system module.. Valid values are `accounts_payable|accounts_receivable|fixed_assets|inventory|payroll|cash_management`',
    `variance_amount` DECIMAL(18,2) COMMENT 'The calculated difference between the subledger balance and the GL balance. Positive values indicate subledger exceeds GL; negative values indicate GL exceeds subledger.',
    `variance_explanation` STRING COMMENT 'Detailed explanation of the identified variance, including root cause analysis and supporting documentation references. Required for SOX control evidence.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance amount expressed as a percentage of the GL balance. Used for materiality assessment and exception threshold testing.',
    CONSTRAINT pk_subledger_reconciliation PRIMARY KEY(`subledger_reconciliation_id`)
) COMMENT 'Operational record of a subledger-to-GL reconciliation run for a specific period, capturing reconciliation status, identified variances, and resolution actions. Captures subledger type, accounting period, GL account range, subledger balance, GL balance, variance amount, variance explanation, reconciliation status (reconciled, in-progress, exception), preparer, reviewer, approval date, and SOX control evidence reference. Critical for SOX financial controls and period-end close governance.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`trial_balance` (
    `trial_balance_id` BIGINT COMMENT 'Unique identifier for the trial balance record. Primary key for this entity.',
    `accounting_period_id` BIGINT COMMENT 'Reference to the accounting period (month, quarter, year) for which this trial balance snapshot is captured. Supports period-end close and financial reporting cycles.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center or business unit dimension for management accounting and internal reporting. May be null for balance sheet accounts not allocated to cost centers.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Trial balance reports are currency-specific; this link enables accurate currency-specific balance reporting and supports multi-currency trial balance preparation for financial close.',
    `gl_account_id` BIGINT COMMENT 'Reference to the chart of accounts GL account for which this balance is reported. Links to the account master defining account type, category, and financial statement line item.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Trial balance reporting by instrument supports portfolio valuation, investment performance measurement, and regulatory capital calculations. Required for IFRS 9 expected credit loss modeling, Basel II',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity for which this trial balance is prepared. Critical for consolidation and regulatory reporting under IFRS/GAAP.',
    `set_id` BIGINT COMMENT 'Reference to the general ledger to which this trial balance belongs (e.g., corporate ledger, statutory ledger, management ledger).',
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
    `journal_entry_id` BIGINT COMMENT 'Identifier of the consolidation journal entry that eliminated this intercompany transaction during the financial close process.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the intercompany transaction in accordance with delegation of authority policies.',
    `matched_transaction_id` BIGINT COMMENT 'Identifier of the corresponding intercompany transaction record in the counterparty legal entity that matches this transaction for reconciliation purposes.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity that initiated or originated the intercompany transaction.',
    `primary_intercompany_counterparty_legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity that is the counterparty or receiving entity in the intercompany transaction.',
    `reversed_transaction_intercompany_transaction_id` BIGINT COMMENT 'Identifier of the original intercompany transaction that this record reverses, if applicable.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Intercompany transactions are subject to specific tax jurisdictions for withholding tax and transfer pricing compliance; this link enables accurate tax calculation and regulatory reporting.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Intercompany transactions occur in specific currencies; this link enables accurate intercompany reconciliation, elimination processing, and transfer pricing documentation in multi-currency banking gro',
    `approval_status` STRING COMMENT 'Current approval status of the intercompany transaction within the internal control and authorization workflow.. Valid values are `draft|pending_approval|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction was approved by the authorized user.',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit or division within the originating legal entity responsible for the intercompany transaction.',
    `cost_center_code` STRING COMMENT 'The cost center or business unit code associated with the originating side of the intercompany transaction for management reporting.',
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
    `originating_gl_account_code` STRING COMMENT 'The general ledger account code in the originating legal entity where the intercompany transaction is recorded.',
    `payment_reference_number` STRING COMMENT 'Reference number of the payment transaction used to settle the intercompany obligation, if applicable.',
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

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`intercompany_elimination` (
    `intercompany_elimination_id` BIGINT COMMENT 'Unique identifier for the intercompany elimination record.',
    `consolidation_run_id` BIGINT COMMENT 'Reference to the consolidation run in which this elimination was processed.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: intercompany_elimination stores elimination_period as STRING but should FK to accounting_period. Eliminations are processed for specific accounting periods during consolidation. Using descriptive FK n',
    `intercompany_transaction_id` BIGINT COMMENT 'Reference to the underlying intercompany transaction being eliminated.',
    `legal_entity_id` BIGINT COMMENT 'Legal entity that initiated the intercompany transaction.',
    `primary_intercompany_counterparty_legal_entity_id` BIGINT COMMENT 'Legal entity that is the counterparty to the intercompany transaction.',
    `employee_id` BIGINT COMMENT 'User ID of the person who approved the elimination entry.',
    `tertiary_intercompany_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person who last modified the elimination record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Elimination entries track original transaction currency; this link enables accurate elimination variance analysis and supports multi-currency intercompany reconciliation in banking consolidation.',
    `accounting_standard` STRING COMMENT 'Accounting standard under which the elimination is recorded (IFRS, US GAAP, or local GAAP).. Valid values are `IFRS|US_GAAP|local_GAAP`',
    `approval_status` STRING COMMENT 'Approval status of the elimination entry for SOX compliance and financial control purposes.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the elimination entry was approved.',
    `counterparty_gl_account_code` STRING COMMENT 'General ledger account code on the counterparty entitys books.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the elimination record was first created in the system.',
    `dispute_reason` STRING COMMENT 'Reason for dispute if the intercompany transaction is in disputed status.',
    `dispute_resolution_date` DATE COMMENT 'Date when the intercompany transaction dispute was resolved.',
    `elimination_amount` DECIMAL(18,2) COMMENT 'Amount of the elimination entry in functional currency.',
    `elimination_gl_account_code` STRING COMMENT 'General ledger account code used for the consolidation elimination entry.',
    `elimination_method` STRING COMMENT 'Method used for consolidation elimination: full consolidation, proportional consolidation, equity method, or no elimination.. Valid values are `full|proportional|equity_method|none`',
    `elimination_reference_number` STRING COMMENT 'Business identifier for the elimination entry, typically the journal entry number in the consolidation system.',
    `elimination_status` STRING COMMENT 'Current status of the elimination entry in the consolidation workflow.. Valid values are `draft|pending_approval|approved|posted|reversed|rejected`',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter in which the elimination is recorded (1-4).',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the elimination is recorded.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Transaction amount converted to functional currency for consolidation purposes.',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code of the reporting entitys functional currency.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the elimination record was last modified.',
    `match_status` STRING COMMENT 'Status of the intercompany transaction matching and reconciliation process.. Valid values are `matched|unmatched|partially_matched|disputed|reconciled`',
    `netting_agreement_reference` STRING COMMENT 'Reference to the intercompany netting agreement governing this transaction, if applicable.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the elimination entry.',
    `originating_gl_account_code` STRING COMMENT 'General ledger account code on the originating entitys books.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership interest used to calculate proportional elimination, expressed as a percentage (e.g., 75.50 for 75.5%).',
    `posting_date` DATE COMMENT 'Date when the elimination entry was posted to the consolidated general ledger.',
    `reversal_date` DATE COMMENT 'Date when the elimination entry was reversed, if applicable.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this elimination entry has been reversed.',
    `reversal_reason` STRING COMMENT 'Reason for reversing the elimination entry.',
    `sox_control_reference` STRING COMMENT 'Reference to the SOX financial control that governs this elimination entry.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Original amount of the intercompany transaction in transaction currency.',
    `transaction_date` DATE COMMENT 'Date when the original intercompany transaction occurred.',
    `transaction_type` STRING COMMENT 'Type of intercompany transaction being eliminated. [ENUM-REF-CANDIDATE: loan|fee|dividend|transfer|recharge|service_charge|management_fee — 7 candidates stripped; promote to reference product]',
    `transfer_pricing_documentation_reference` STRING COMMENT 'Reference to transfer pricing documentation supporting the intercompany transaction pricing.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Amount of variance identified between originating and counterparty transaction records.',
    CONSTRAINT pk_intercompany_elimination PRIMARY KEY(`intercompany_elimination_id`)
) COMMENT 'Complete record of intercompany financial transactions between legal entities within the banking group and their corresponding consolidation elimination entries. Covers the full intercompany lifecycle: transaction origination (originating entity, counterparty entity, transaction type including loan, fee, dividend, transfer, recharge, service charge, management fee, transaction date, currency, amount, GL accounts on both sides, netting agreement reference), intercompany matching and reconciliation (match status, variance identification, dispute resolution), and elimination processing (elimination journal reference, elimination GL accounts, elimination amount, elimination method such as full or proportional, consolidation run reference, elimination status, elimination period, approval status). Supports IFRS 10 / ASC 810 consolidation, intercompany netting, transfer pricing documentation, and consolidated financial statement preparation. This product is the single source of truth for all intercompany activity — from initial transaction capture through final elimination posting.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`financial_close_task` (
    `financial_close_task_id` BIGINT COMMENT 'Unique identifier for the financial close task within the period-end close checklist.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: financial_close_task currently stores accounting_period as STRING but should reference the accounting_period table via FK for referential integrity and to enable joins for period metadata (dates, stat',
    `employee_id` BIGINT COMMENT 'Reference to the user who last modified this close task record, establishing accountability for changes.',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Branch-level close tasks (vault counts, teller reconciliations, safe deposit box audits) are standard in retail banking month-end close processes. Required for branch-specific SOX controls and operati',
    `compliance_sox_control_id` BIGINT COMMENT 'Reference to the SOX control identifier that this close task supports or evidences, linking task execution to internal control framework.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center or business unit responsible for this close task, enabling departmental accountability.',
    `gl_account_id` BIGINT COMMENT 'Reference to the primary general ledger account associated with this close task, if task is account-specific (e.g., reconciliation of a specific GL account).',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity for which this close task is being performed, supporting multi-entity consolidation and reporting.',
    `primary_financial_employee_id` BIGINT COMMENT 'Reference to the employee or user responsible for completing this close task, establishing clear ownership and accountability.',
    `quaternary_financial_task_approver_employee_id` BIGINT COMMENT 'Reference to the employee with authority to approve and sign off on the completed task, typically a manager or controller.',
    `quinary_financial_waiver_approved_by_employee_id` BIGINT COMMENT 'Reference to the senior manager or controller who approved the waiver of this close task, establishing accountability for exceptions.',
    `task_template_id` BIGINT COMMENT 'Reference to the master task template from which this instance was created, enabling standardization and version control of close procedures.',
    `tertiary_financial_task_reviewer_employee_id` BIGINT COMMENT 'Reference to the employee responsible for reviewing the completed task before final approval, supporting segregation of duties.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual number of hours spent completing this close task, used for performance analysis and future estimation refinement.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'The actual date and time when work on this close task was initiated, used for cycle time analysis and performance tracking.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this close task was formally approved and signed off by the designated approver.',
    `blocking_issue_description` STRING COMMENT 'Description of any issue or dependency that is preventing this close task from being completed, used for escalation and resolution tracking.',
    `comments` STRING COMMENT 'Free-form comments and notes related to the execution, review, or approval of this close task, providing additional context and audit trail.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Estimated percentage of task completion (0.00 to 100.00), providing progress visibility for tasks in progress.',
    `completion_timestamp` TIMESTAMP COMMENT 'The date and time when this close task was marked as completed by the task owner or preparer.',
    `control_objective` STRING COMMENT 'Description of the internal control objective that this close task is designed to achieve, supporting SOX compliance documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this close task record was first created in the system, supporting audit trail and data lineage.',
    `due_date` DATE COMMENT 'The target date by which this close task must be completed to meet the financial close timeline and reporting deadlines.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Estimated number of hours required to complete this close task, used for capacity planning and resource allocation.',
    `evidence_document_ids` STRING COMMENT 'Comma-separated list of document IDs representing supporting evidence attachments (reconciliations, approvals, analysis) for this close task.',
    `evidence_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether documentary evidence of task completion must be attached for audit and compliance purposes.',
    `financial_close_task_status` STRING COMMENT 'Current status of the close task in its lifecycle: not started, in progress, completed, overdue, waived (approved exception), or blocked (awaiting dependency).. Valid values are `not_started|in_progress|completed|overdue|waived|blocked`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this close task belongs, supporting multi-year close tracking and historical analysis.',
    `is_key_control` BOOLEAN COMMENT 'Boolean flag indicating whether this close task represents a key control for SOX compliance (True) or a supporting control (False).',
    `is_recurring` BOOLEAN COMMENT 'Boolean flag indicating whether this close task recurs every period (True) or is a one-time task (False), supporting task template management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this close task record was last updated, tracking changes for audit and compliance purposes.',
    `predecessor_task_ids` STRING COMMENT 'Comma-separated list of financial_close_task_id values representing tasks that must be completed before this task can begin, establishing task dependencies.',
    `priority` STRING COMMENT 'Priority level assigned to this close task, indicating urgency and importance for resource allocation and escalation.. Valid values are `critical|high|medium|low`',
    `review_timestamp` TIMESTAMP COMMENT 'The date and time when this close task was reviewed by the designated reviewer, supporting audit trail requirements.',
    `scheduled_start_date` DATE COMMENT 'The planned date when work on this close task should begin, supporting close calendar planning and resource allocation.',
    `task_code` STRING COMMENT 'Unique business identifier or code assigned to the close task for reference and tracking purposes (e.g., JE-001, RECON-GL-001).. Valid values are `^[A-Z0-9]{4,12}$`',
    `task_description` STRING COMMENT 'Detailed description of the close task including specific activities, scope, and deliverables required for completion.',
    `task_name` STRING COMMENT 'Short descriptive name of the financial close task (e.g., Post Accrual Journal Entries, Reconcile Cash Accounts).',
    `task_type` STRING COMMENT 'Classification of the close task by activity type: journal posting, reconciliation, accrual review, approval, sign-off, or flux analysis.. Valid values are `journal_posting|reconciliation|accrual_review|approval|sign_off|flux_analysis`',
    `waiver_approval_timestamp` TIMESTAMP COMMENT 'The date and time when the waiver for this close task was formally approved by authorized management.',
    `waiver_reason` STRING COMMENT 'Explanation and business justification for waiving this close task if status is set to waived, requiring management approval.',
    CONSTRAINT pk_financial_close_task PRIMARY KEY(`financial_close_task_id`)
) COMMENT 'Individual task within the period-end financial close checklist, representing a discrete control activity required before an accounting period can be closed. Captures task name, description, type (journal posting, reconciliation, accrual review, approval, sign-off, flux analysis), accounting period, legal entity, responsible owner, due date, completion date, status (not started, in progress, completed, overdue, waived), predecessor dependencies, SOX control reference, and evidence attachment. Orchestrates the financial close management process and provides audit evidence for SOX Section 302/404 certification.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`consolidation_run` (
    `consolidation_run_id` BIGINT COMMENT 'Unique identifier for the consolidation run execution record.',
    `accounting_period_id` BIGINT COMMENT 'Identifier of the financial reporting period (month, quarter, year) for which consolidation was performed.',
    `consolidation_group_id` BIGINT COMMENT 'Identifier of the consolidation group or reporting entity scope for which this run was executed.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Consolidation runs aggregate in a functional currency; this link enables multi-entity consolidation, currency translation processing, and IFRS-compliant consolidated financial statement preparation.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the consolidation run, if approval was required and granted.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Bank holding company exams extensively review consolidated financials, intercompany elimination methodology, and capital adequacy calculations. Examiners validate consolidation scope, minority interes',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this consolidation run requires formal approval before finalization.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the consolidation run was formally approved.',
    `consolidation_adjustments_count` STRING COMMENT 'Number of manual or automated consolidation adjustment journal entries posted during this run.',
    `consolidation_engine_version` STRING COMMENT 'Version identifier of the consolidation software or engine used to execute this run.',
    `consolidation_method` STRING COMMENT 'Method applied for consolidation: full consolidation, proportionate consolidation, equity method, or cost method.. Valid values are `FULL|PROPORTIONATE|EQUITY|COST`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the consolidation run record was first created in the system.',
    `currency_translation_adjustment_amount` DECIMAL(18,2) COMMENT 'Total currency translation adjustment amount arising from translating foreign subsidiary financial statements into presentation currency.',
    `entities_included_count` STRING COMMENT 'Number of legal entities or subsidiaries included in the consolidation scope for this run.',
    `error_message` STRING COMMENT 'Detailed error or failure message if the consolidation run encountered issues or failed.',
    `goodwill_adjustment_amount` DECIMAL(18,2) COMMENT 'Total goodwill adjustments applied during consolidation, including impairment or acquisition-related adjustments.',
    `intercompany_eliminations_amount` DECIMAL(18,2) COMMENT 'Total monetary value of intercompany eliminations applied during consolidation, in presentation currency.',
    `intercompany_eliminations_applied_flag` BOOLEAN COMMENT 'Indicates whether intercompany transactions and balances were eliminated during this consolidation run.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the consolidation run record was last updated or modified.',
    `minority_interest_amount` DECIMAL(18,2) COMMENT 'Total non-controlling interest (minority interest) calculated and recognized in consolidated equity for this run.',
    `net_income_consolidated` DECIMAL(18,2) COMMENT 'Consolidated net income for the reporting period after all eliminations and adjustments, in presentation currency.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the consolidation run, including special circumstances or manual interventions.',
    `presentation_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which consolidated financial statements are presented.. Valid values are `^[A-Z]{3}$`',
    `reference` STRING COMMENT 'Business-facing reference number or code for the consolidation run, used for tracking and audit purposes.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this consolidation run is intended for regulatory submission (e.g., FR Y-9C, Basel III reporting).',
    `regulatory_submission_type` STRING COMMENT 'Type of regulatory submission this consolidation supports (e.g., FR Y-9C, CCAR, DFAST, Basel III Pillar 3).',
    `reporting_standard` STRING COMMENT 'Accounting standard applied for this consolidation run (IFRS, US GAAP, local GAAP, regulatory, or management reporting).. Valid values are `IFRS|US_GAAP|LOCAL_GAAP|REGULATORY|MANAGEMENT`',
    `run_duration_seconds` STRING COMMENT 'Total processing time for the consolidation run measured in seconds.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Date and time when the consolidation run processing was completed or terminated.',
    `run_mode` STRING COMMENT 'Execution mode of the consolidation run: manual, scheduled, or automated.. Valid values are `MANUAL|SCHEDULED|AUTOMATED`',
    `run_start_timestamp` TIMESTAMP COMMENT 'Date and time when the consolidation run processing was initiated.',
    `run_status` STRING COMMENT 'Current lifecycle status of the consolidation run: initiated, in progress, completed, approved, rejected, or failed.. Valid values are `INITIATED|IN_PROGRESS|COMPLETED|APPROVED|REJECTED|FAILED`',
    `run_type` STRING COMMENT 'Type of consolidation run: preliminary, final, restatement, forecast, or budget consolidation.. Valid values are `PRELIMINARY|FINAL|RESTATEMENT|FORECAST|BUDGET`',
    `total_assets_consolidated` DECIMAL(18,2) COMMENT 'Total consolidated assets after all eliminations, adjustments, and translations, in presentation currency.',
    `total_equity_consolidated` DECIMAL(18,2) COMMENT 'Total consolidated equity including non-controlling interest, after all consolidation adjustments, in presentation currency.',
    `total_liabilities_consolidated` DECIMAL(18,2) COMMENT 'Total consolidated liabilities after all eliminations, adjustments, and translations, in presentation currency.',
    `validation_errors_count` STRING COMMENT 'Number of validation errors or exceptions identified during post-consolidation validation.',
    `validation_status` STRING COMMENT 'Status of post-consolidation validation checks: passed, failed, warning, or not validated.. Valid values are `PASSED|FAILED|WARNING|NOT_VALIDATED`',
    CONSTRAINT pk_consolidation_run PRIMARY KEY(`consolidation_run_id`)
) COMMENT 'Execution record of a group financial consolidation for a specific reporting period, capturing scope, processing steps, and outcome. Captures consolidation run reference, period, consolidation group, reporting standard (IFRS, US GAAP), method, entities included, intercompany eliminations applied, currency translation adjustments (CTA), minority/non-controlling interest calculations, goodwill adjustments, run status (in progress, completed, approved), run date, and approver. Drives IFRS 10 group reporting, regulatory consolidated submissions (e.g., FR Y-9C), and management consolidation.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`ledger_sox_control` (
    `ledger_sox_control_id` BIGINT COMMENT 'Unique identifier for the SOX internal control over financial reporting (ICFR) record within the ledger domain.',
    `compliance_sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Ledger domain maintains operational SOX controls that reference the enterprise compliance control library. Enables centralized control testing coordination, audit evidence aggregation, and cross-domai',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for executing and maintaining the control activity.',
    `quaternary_ledger_created_by_employee_id` BIGINT COMMENT 'Identifier of the employee who initially created this control record.',
    `quinary_ledger_control_owner_employee_id` BIGINT COMMENT 'FK to hr.employee',
    `tertiary_ledger_last_updated_by_employee_id` BIGINT COMMENT 'Identifier of the employee who most recently modified this control record.',
    `control_description` STRING COMMENT 'Detailed description of the control activity, including what is performed, by whom, and the expected outcome.',
    `control_documentation_link` STRING COMMENT 'URL or file path to the detailed control documentation, including process narratives, flowcharts, and control matrices.',
    `control_effective_date` DATE COMMENT 'The date when this control was first implemented and became operational.',
    `control_frequency` STRING COMMENT 'How often the control activity is performed (daily, weekly, monthly, quarterly, annual, or event-driven based on specific triggers).. Valid values are `daily|weekly|monthly|quarterly|annual|event-driven`',
    `control_name` STRING COMMENT 'Short descriptive name of the control activity (e.g., Journal Entry Approval, Bank Reconciliation Review).',
    `control_nature` STRING COMMENT 'Indicates whether the control is performed manually by personnel, fully automated by system, or semi-automated (combination of system and manual steps).. Valid values are `manual|automated|semi-automated`',
    `control_number` STRING COMMENT 'Business-assigned unique control identifier used for external auditor reference and internal tracking (e.g., GL-001, AP-015).',
    `control_objective` STRING COMMENT 'The specific risk or financial reporting objective this control is designed to mitigate or achieve.',
    `control_retirement_date` DATE COMMENT 'The date when this control was retired or decommissioned, if applicable.',
    `control_status` STRING COMMENT 'Current lifecycle status of the control: active (currently in operation), inactive (temporarily suspended), retired (no longer applicable), or under review (being evaluated for changes).. Valid values are `active|inactive|retired|under review`',
    `control_type` STRING COMMENT 'Classification of the control based on its timing and purpose: preventive (stops errors before they occur), detective (identifies errors after occurrence), or corrective (remediates identified errors).. Valid values are `preventive|detective|corrective`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this control record was first created in the system.',
    `entity_level_control_indicator` BOOLEAN COMMENT 'Flag indicating whether this is an entity-level control (true) that operates across the organization (e.g., tone at the top, code of conduct, risk assessment), or a process-level control (false).',
    `external_auditor_reference` STRING COMMENT 'Reference number or identifier used by the external auditor (e.g., Big Four firm) to track this control in their audit workpapers and PCAOB inspection documentation.',
    `gl_process_area` STRING COMMENT 'The specific general ledger process or sub-ledger area this control applies to (e.g., Journal Entries, Accounts Payable, Accounts Receivable, Fixed Assets, Intercompany Eliminations, Financial Close, Consolidation).',
    `it_dependent_indicator` BOOLEAN COMMENT 'Flag indicating whether this control relies on IT general controls (ITGC) or automated system controls for its effectiveness.',
    `key_control_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a key control (true) that directly addresses a significant risk to financial reporting, or a supporting control (false).',
    `last_test_date` DATE COMMENT 'The date when the control was most recently tested for operating effectiveness.',
    `last_test_result` STRING COMMENT 'The outcome of the most recent control test: effective (operating as designed), deficiency (minor issue), significant deficiency (important enough to merit attention), material weakness (reasonable possibility of material misstatement), or not tested.. Valid values are `effective|deficiency|significant deficiency|material weakness|not tested`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this control record was most recently modified.',
    `remediation_due_date` DATE COMMENT 'Target date by which the remediation plan must be completed and the control deficiency resolved.',
    `remediation_plan` STRING COMMENT 'Detailed description of the corrective action plan to address identified control deficiencies, significant deficiencies, or material weaknesses.',
    `remediation_status` STRING COMMENT 'Current status of the remediation effort: not required (control effective), planned (remediation designed), in progress (being implemented), completed (actions finished), or validated (effectiveness confirmed).. Valid values are `not required|planned|in progress|completed|validated`',
    `risk_assertion` STRING COMMENT 'The financial statement assertion this control addresses: completeness (all transactions recorded), accuracy (amounts correct), existence (assets/liabilities exist), valuation (proper measurement), presentation (proper classification and disclosure), or rights and obligations (entity has legal claim).. Valid values are `completeness|accuracy|existence|valuation|presentation|rights and obligations`',
    `scoping_decision` STRING COMMENT 'Indicates whether this control is in scope for SOX 404 testing (in scope), excluded from testing (out of scope), or currently being evaluated for inclusion (under evaluation).. Valid values are `in scope|out of scope|under evaluation`',
    `scoping_rationale` STRING COMMENT 'Business justification for the scoping decision, including materiality considerations, risk assessment, and process significance.',
    `test_exceptions_count` STRING COMMENT 'The number of exceptions or deviations identified during the most recent control test.',
    `test_sample_size` STRING COMMENT 'The number of control instances or transactions tested during the most recent control effectiveness test.',
    `testing_frequency` STRING COMMENT 'How often the control is tested for effectiveness by internal audit or external auditors.. Valid values are `quarterly|semi-annual|annual`',
    `testing_method` STRING COMMENT 'The audit procedure used to test control effectiveness: inquiry (asking personnel), observation (watching control execution), inspection (examining documentation), reperformance (auditor executes control), or walkthrough (tracing transaction through process).. Valid values are `inquiry|observation|inspection|reperformance|walkthrough`',
    CONSTRAINT pk_ledger_sox_control PRIMARY KEY(`ledger_sox_control_id`)
) COMMENT 'SOX (Sarbanes-Oxley Act) internal control over financial reporting (ICFR) record defining a specific control activity within the ledger domain. Captures control ID, control name, description, type (preventive, detective), frequency (daily, monthly, quarterly, annual), control owner, GL process area, risk assertion (completeness, accuracy, existence, valuation, presentation, rights and obligations), testing method, last test date, test result (effective, deficiency, significant deficiency, material weakness), remediation plan, remediation status, remediation due date, and external auditor reference. Supports SOX Section 302/404 compliance, PCAOB inspection readiness, and internal audit coordination.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique identifier for the profit center. Primary key for the profit center entity.',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Profit centers track revenue and cost by branch for IFRS 8 segment reporting, branch performance scorecards, and executive dashboards. Fundamental to retail banking financial reporting and branch netw',
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

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`ledger_budget` (
    `ledger_budget_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: ledger_budget stores accounting_period as STRING but should FK to accounting_period. Budget records are allocated to specific accounting periods and need proper FK to period master for period-based bu',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Branch budgets are foundational to retail banking financial planning. Budget vs. actual variance analysis is performed at branch level for performance management, resource allocation, and branch netwo',
    `cost_center_id` BIGINT COMMENT 'FK to ledger.cost_center',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Budgets are set in specific currencies; this link enables budget vs. actual variance analysis in correct currency and supports multi-currency budget consolidation in banking operations.',
    `gl_account_id` BIGINT COMMENT 'FK to ledger.gl_account',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity for which this budget is defined.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or executive responsible for this budget.',
    `primary_ledger_employee_id` BIGINT COMMENT 'Identifier of the user who approved this budget record.',
    `profit_center_id` BIGINT COMMENT 'FK to ledger.profit_center',
    `set_id` BIGINT COMMENT 'Reference to the ledger set to which this budget belongs.',
    `tertiary_ledger_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this budget record.',
    `previous_ledger_budget_id` BIGINT COMMENT 'Self-referencing FK on ledger_budget (previous_ledger_budget_id)',
    `actual_amount` DECIMAL(18,2) COMMENT 'Actual amount spent or earned against this budget for variance tracking.',
    `allocation_driver` STRING COMMENT 'The business driver or metric used as the basis for budget allocation (e.g., headcount, revenue, square footage).',
    `allocation_method` STRING COMMENT 'Method used to allocate the budget across cost centers or profit centers.. Valid values are `direct|proportional|activity_based|driver_based`',
    `amount` DECIMAL(18,2) COMMENT 'The budgeted amount allocated for this account, cost center, and period.',
    `approval_date` DATE COMMENT 'Date on which the budget was formally approved by authorized personnel.',
    `budget_category` STRING COMMENT 'High-level financial statement category for the budget (revenue, expense, asset, liability).. Valid values are `revenue|expense|asset|liability`',
    `budget_status` STRING COMMENT 'Current approval and lifecycle status of the budget record.. Valid values are `draft|submitted|approved|rejected|locked|revised`',
    `budget_type` STRING COMMENT 'Classification of the budget type (operating expense, capital expenditure, project-based, strategic initiative).. Valid values are `operating|capital|project|strategic`',
    `business_unit_code` STRING COMMENT 'The business unit or line of business (LOB) for which this budget applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which this budget record ceases to be effective.',
    `effective_start_date` DATE COMMENT 'Date from which this budget record becomes effective.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget applies.',
    `forecast_amount` DECIMAL(18,2) COMMENT 'Updated forecast amount for the period based on current trends and projections.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Budget amount converted to the legal entitys functional currency.',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter functional currency code of the legal entity.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was last updated.',
    `lock_flag` BOOLEAN COMMENT 'Indicates whether this budget record is locked and cannot be modified.',
    `locked_date` DATE COMMENT 'Date on which the budget was locked for changes.',
    `notes` STRING COMMENT 'Free-text notes or comments explaining budget assumptions, adjustments, or special considerations.',
    `period_number` STRING COMMENT 'Sequential period number within the fiscal year (1-12 for monthly, 1-4 for quarterly).',
    `prior_year_actual_amount` DECIMAL(18,2) COMMENT 'Actual amount from the same period in the prior fiscal year for comparative analysis.',
    `quarter_number` STRING COMMENT 'Fiscal quarter number (1-4) to which this budget period belongs.',
    `scenario` STRING COMMENT 'Scenario classification for the budget (base case, optimistic, pessimistic, stress scenario).. Valid values are `base|optimistic|pessimistic|stress`',
    `submitted_date` DATE COMMENT 'Date on which the budget was submitted for approval.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Calculated variance between budgeted and actual amounts (actual minus budget).',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Variance expressed as a percentage of the budgeted amount.',
    `version` STRING COMMENT 'Version identifier for the budget (e.g., Original, Revised, Forecast, Reforecast).',
    CONSTRAINT pk_ledger_budget PRIMARY KEY(`ledger_budget_id`)
) COMMENT 'Annual and periodic budget record by cost center, profit center, and GL account. Captures budget amount, budget version, approval status, and variance tracking against actuals.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`tax_provision` (
    `tax_provision_id` BIGINT COMMENT 'Unique identifier for the tax provision record. Primary key.',
    `accounting_period_id` BIGINT COMMENT 'Reference to the accounting period for which this tax provision applies.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the tax provision for posting.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Tax provisions are calculated in functional currency; this link enables accurate tax expense calculation, deferred tax tracking, and IFRS/US GAAP tax accounting in banking operations.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Tax provisions on securities income (dividends, interest, capital gains) require instrument-level tracking for jurisdiction-specific tax rates, treaty benefits, withholding tax calculations, and defer',
    `journal_entry_id` BIGINT COMMENT 'Reference to the general ledger journal entry created for this tax provision.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity for which this tax provision is calculated.',
    `primary_tax_employee_id` BIGINT COMMENT 'Identifier of the user who prepared the tax provision calculation.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Tax provisions are frequently examined by IRS and state tax authorities. Linking provisions to exam findings enables tracking of tax-related MRAs, uncertain tax position challenges, and effective tax ',
    `reviewer_user_employee_id` BIGINT COMMENT 'Identifier of the user who reviewed the tax provision calculation.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Tax provisions are calculated by jurisdiction for regulatory filing; this link enables country-specific tax reporting, effective tax rate analysis, and multi-jurisdictional tax compliance.',
    `previous_tax_provision_id` BIGINT COMMENT 'Self-referencing FK on tax_provision (previous_tax_provision_id)',
    `accounting_standard` STRING COMMENT 'Accounting standard framework applied for tax provision calculation (US GAAP, IFRS, or local GAAP).. Valid values are `US_GAAP|IFRS|local_GAAP`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the tax provision was approved.',
    `audit_evidence_reference` STRING COMMENT 'Reference identifier for audit documentation and supporting evidence for the tax provision.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the tax provision record was first created in the system.',
    `current_tax_expense_amount` DECIMAL(18,2) COMMENT 'Current period tax expense based on taxable income and applicable tax rates.',
    `deferred_tax_asset_amount` DECIMAL(18,2) COMMENT 'Cumulative deferred tax asset balance arising from deductible temporary differences and tax loss carryforwards.',
    `deferred_tax_expense_amount` DECIMAL(18,2) COMMENT 'Deferred tax expense or benefit arising from temporary differences between book and tax basis.',
    `deferred_tax_liability_amount` DECIMAL(18,2) COMMENT 'Cumulative deferred tax liability balance arising from taxable temporary differences.',
    `effective_tax_rate_percent` DECIMAL(18,2) COMMENT 'Effective tax rate calculated as total tax expense divided by pretax income, expressed as a percentage.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter within the year (1-4) for interim tax provisions.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the tax provision is calculated.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the tax provision record was last updated.',
    `net_deferred_tax_position_amount` DECIMAL(18,2) COMMENT 'Net deferred tax position calculated as deferred tax assets minus deferred tax liabilities.',
    `notes` STRING COMMENT 'Free-form notes and commentary regarding the tax provision calculation, assumptions, or adjustments.',
    `permanent_difference_amount` DECIMAL(18,2) COMMENT 'Total permanent differences between book income and taxable income that will never reverse.',
    `posting_date` DATE COMMENT 'Date when the tax provision was posted to the general ledger.',
    `pretax_income_amount` DECIMAL(18,2) COMMENT 'Income before tax expense for the period, used as the basis for tax provision calculation.',
    `provision_date` DATE COMMENT 'Date on which the tax provision calculation was performed.',
    `provision_reference_number` STRING COMMENT 'Business-assigned unique reference number for the tax provision calculation.',
    `provision_status` STRING COMMENT 'Current lifecycle status of the tax provision record.. Valid values are `draft|pending_review|approved|posted|adjusted|finalized`',
    `provision_type` STRING COMMENT 'Classification of the tax provision calculation type.. Valid values are `current|deferred|total|interim|annual`',
    `rate_reconciliation_amount` DECIMAL(18,2) COMMENT 'Total reconciling amount between statutory tax expense and actual tax expense, representing permanent differences and rate adjustments.',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for consolidated reporting purposes.. Valid values are `^[A-Z]{3}$`',
    `sox_control_reference` STRING COMMENT 'Reference to the SOX control framework applied to this tax provision calculation.',
    `statutory_tax_rate_percent` DECIMAL(18,2) COMMENT 'Statutory corporate income tax rate applicable to the legal entitys jurisdiction.',
    `tax_credit_carryforward_amount` DECIMAL(18,2) COMMENT 'Cumulative tax credits available to offset future tax liabilities.',
    `tax_loss_carryforward_amount` DECIMAL(18,2) COMMENT 'Cumulative tax loss carryforwards available to offset future taxable income.',
    `temporary_difference_amount` DECIMAL(18,2) COMMENT 'Total temporary differences between book basis and tax basis of assets and liabilities that will reverse in future periods.',
    `total_tax_expense_amount` DECIMAL(18,2) COMMENT 'Total income tax expense for the period, sum of current and deferred tax expense.',
    `unrecognized_tax_benefit_amount` DECIMAL(18,2) COMMENT 'Amount of tax benefit from uncertain tax positions that does not meet the recognition threshold under FIN 48 / IFRIC 23.',
    `valuation_allowance_amount` DECIMAL(18,2) COMMENT 'Valuation allowance established to reduce deferred tax assets to the amount that is more likely than not to be realized.',
    CONSTRAINT pk_tax_provision PRIMARY KEY(`tax_provision_id`)
) COMMENT 'Tax provision and deferred tax calculation record. Captures current tax expense, deferred tax assets/liabilities, effective tax rate, and reconciliation to statutory rate.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`account_testing_scope` (
    `account_testing_scope_id` BIGINT COMMENT 'Unique identifier for this account testing scope record',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to the internal audit engagement under which this account is being tested',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to the general ledger account selected for testing in this engagement',
    `account_testing_status` STRING COMMENT 'Current status of testing for this GL account within this engagement lifecycle',
    `auditor_notes` STRING COMMENT 'Free-text notes documenting observations, issues, or context specific to testing this GL account during this engagement',
    `findings_count` STRING COMMENT 'Number of audit findings or exceptions identified during testing of this GL account in this engagement',
    `materiality_threshold` DECIMAL(18,2) COMMENT 'Monetary threshold used to determine the significance of misstatements or control deficiencies identified in this GL account during this engagement',
    `risk_rating` STRING COMMENT 'Risk rating assigned to this specific GL account within the context of this engagement, reflecting inherent risk, control risk, and detection risk',
    `sample_size` STRING COMMENT 'Number of transactions or journal entries selected for detailed testing from this GL account during this engagement',
    `sampling_methodology` STRING COMMENT 'The audit sampling approach applied to this GL account for this engagement, such as statistical sampling, judgmental sampling, or monetary unit sampling',
    `scope_rationale` STRING COMMENT 'Business justification for including this GL account in the engagement scope, such as materiality, risk profile, regulatory requirement, or prior audit findings',
    `testing_completion_date` DATE COMMENT 'Date when audit testing procedures for this GL account were completed for this engagement',
    `testing_period_end_date` DATE COMMENT 'End date of the period for which transactions in this GL account will be tested during this engagement',
    `testing_period_start_date` DATE COMMENT 'Start date of the period for which transactions in this GL account will be tested during this engagement',
    `testing_procedures` STRING COMMENT 'Specific audit procedures to be performed on this GL account during this engagement, such as substantive testing, control testing, reconciliation review, or analytical procedures',
    CONSTRAINT pk_account_testing_scope PRIMARY KEY(`account_testing_scope_id`)
) COMMENT 'This association product represents the audit scope relationship between gl_account and engagement. It captures the specific GL accounts selected for testing within each internal audit engagement, including the rationale for inclusion, risk assessment, sampling methodology, testing period, and materiality thresholds. Each record links one GL account to one engagement with attributes that exist only in the context of this specific audit scope decision.. Existence Justification: In banking internal audit operations, each audit engagement tests multiple GL accounts based on risk assessment, materiality, and regulatory requirements, and each GL account may be tested across multiple engagements over time (annual audits, SOX testing, regulatory exams, targeted reviews). The audit team actively manages the scope selection for each engagement, documenting why specific accounts are included, the risk rating for each account in that engagement context, the sampling approach, testing period, and materiality thresholds. This is a recognized business process called audit scope definition or account testing scope.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`consolidation_group` (
    `consolidation_group_id` BIGINT COMMENT 'Primary key for consolidation_group',
    `cost_center_id` BIGINT COMMENT 'Reference to the primary cost center associated with this consolidation group for management accounting and cost allocation purposes.',
    `parent_consolidation_group_id` BIGINT COMMENT 'Reference to the parent consolidation group in the organizational hierarchy. Null for top-level consolidation groups. Enables multi-level consolidation structures.',
    `profit_center_id` BIGINT COMMENT 'Reference to the primary profit center associated with this consolidation group for profitability analysis and performance measurement.',
    `accounting_standard` STRING COMMENT 'Primary accounting standard framework applied to this consolidation group for financial reporting. IFRS for International Financial Reporting Standards, US_GAAP for United States Generally Accepted Accounting Principles, or local_GAAP for jurisdiction-specific standards.',
    `acquisition_date` DATE COMMENT 'Date on which control, joint control, or significant influence was obtained over this consolidation group. Used for business combination accounting and goodwill calculation under IFRS 3.',
    `approval_status` STRING COMMENT 'Current approval status of this consolidation group configuration. Draft indicates work in progress, pending_approval indicates submitted for review, approved indicates ready for use in consolidation, rejected indicates changes required.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this consolidation group configuration was approved. Used for audit trail and compliance documentation.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved this consolidation group configuration. Required for SOX compliance and segregation of duties in financial reporting.',
    `business_line` STRING COMMENT 'Primary business line or product category associated with this consolidation group. Used for management reporting and segment analysis. Examples include Retail Banking, Investment Banking, Asset Management, Wealth Management.',
    `consolidation_group_code` STRING COMMENT 'Business identifier code for the consolidation group used in financial reporting and external communications. Unique alphanumeric code following organizational standards.',
    `consolidation_group_name` STRING COMMENT 'Full business name of the consolidation group as it appears in financial statements and regulatory filings.',
    `consolidation_group_type` STRING COMMENT 'Classification of the consolidation group indicating the organizational dimension it represents (legal entity structure, business unit, geographic region, product line, functional area, or custom grouping).',
    `consolidation_level` STRING COMMENT 'Hierarchical level of this consolidation group within the overall consolidation structure. Level 1 represents the top-level consolidated entity, with increasing numbers for lower levels.',
    `consolidation_method` STRING COMMENT 'The accounting method used for consolidating financial results of entities within this group. Full consolidation for subsidiaries, proportionate for joint ventures, equity method for associates, cost method for investments, or none for non-consolidated entities.',
    `consolidation_status` STRING COMMENT 'Current lifecycle status of the consolidation group. Active groups are included in current period consolidation, inactive groups are excluded, pending groups are awaiting activation, suspended groups are temporarily excluded, dissolved groups are permanently closed.',
    `control_indicator` BOOLEAN COMMENT 'Flag indicating whether the parent entity has control over this consolidation group as defined by IFRS 10. True indicates control exists, requiring full consolidation regardless of ownership percentage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consolidation group record was first created in the system. Used for audit trail and data lineage tracking.',
    `consolidation_group_description` STRING COMMENT 'Detailed textual description of the consolidation group including its business purpose, scope of operations, and any special consolidation considerations or adjustments required.',
    `disposal_date` DATE COMMENT 'Date on which control, joint control, or significant influence was lost over this consolidation group. Used for deconsolidation accounting and gain/loss calculation under IFRS 10.',
    `effective_end_date` DATE COMMENT 'Date on which this consolidation group ceases to be effective for financial consolidation purposes. Null for currently active groups. Transactions after this date are excluded from consolidated results.',
    `effective_start_date` DATE COMMENT 'Date from which this consolidation group becomes effective for financial consolidation purposes. Transactions on or after this date are included in consolidated results.',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the primary economic environment in which this consolidation group operates. Used for initial measurement before translation to reporting currency.',
    `geographic_region` STRING COMMENT 'Geographic region classification for this consolidation group used in segment reporting and management reporting. Examples include North America, Europe, Asia Pacific, Latin America, Middle East Africa.',
    `intercompany_elimination_required` BOOLEAN COMMENT 'Flag indicating whether intercompany transactions and balances must be eliminated during consolidation for this group. True for fully consolidated entities, false for equity method or non-consolidated entities.',
    `joint_control_indicator` BOOLEAN COMMENT 'Flag indicating whether this consolidation group is subject to joint control by multiple parties as defined by IFRS 11. True indicates joint control arrangement exists.',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary legal and tax jurisdiction for this consolidation group. Used for regulatory reporting and tax consolidation purposes.',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this consolidation group record. Used for audit trail and accountability in SOX-compliant environments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this consolidation group record was last updated. Used for audit trail, change tracking, and data quality monitoring.',
    `legal_entity_identifier` STRING COMMENT 'ISO 17442 Legal Entity Identifier for the primary legal entity associated with this consolidation group. 20-character alphanumeric code used for regulatory reporting and entity identification in financial markets.',
    `minority_interest_applicable` BOOLEAN COMMENT 'Flag indicating whether non-controlling (minority) interest calculations are required for this consolidation group. True when ownership is less than 100% but control exists.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the consolidation treatment of this group. May include information about complex ownership structures, special consolidation adjustments, or regulatory considerations.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership or control that the parent entity holds in this consolidation group. Used to determine consolidation method and minority interest calculations. Range 0.00 to 100.00.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Flag indicating whether this consolidation group is subject to regulatory reporting requirements such as Basel III, Solvency II, or other banking/insurance regulations. True indicates regulatory reporting obligations exist.',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code used for financial reporting within this consolidation group. All financial results are translated to this currency for consolidation purposes.',
    `segment_reporting_code` STRING COMMENT 'Code identifying the operating segment or reportable segment to which this consolidation group belongs for IFRS 8 segment reporting purposes.',
    `significant_influence_indicator` BOOLEAN COMMENT 'Flag indicating whether the parent entity has significant influence over this consolidation group as defined by IAS 28. True indicates significant influence exists, typically requiring equity method accounting.',
    `sox_scope_indicator` BOOLEAN COMMENT 'Flag indicating whether this consolidation group is within the scope of Sarbanes-Oxley Act compliance and internal control testing. True for entities subject to SOX Section 404 requirements.',
    `tax_consolidation_group_code` STRING COMMENT 'Identifier for the tax consolidation group to which this entity belongs. Used for tax reporting and consolidated tax return preparation. May differ from financial consolidation grouping.',
    `version_number` STRING COMMENT 'Version number of this consolidation group record. Incremented with each modification to support change tracking and audit requirements. Used for optimistic locking in concurrent update scenarios.',
    `voting_rights_percentage` DECIMAL(18,2) COMMENT 'Percentage of voting rights held by the parent entity in this consolidation group. May differ from ownership percentage in cases of non-voting shares or special voting arrangements. Range 0.00 to 100.00.',
    CONSTRAINT pk_consolidation_group PRIMARY KEY(`consolidation_group_id`)
) COMMENT 'Master reference table for consolidation_group. Referenced by consolidation_group_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`task_template` (
    `task_template_id` BIGINT COMMENT 'Primary key for task_template',
    `approved_by_user_employee_id` BIGINT COMMENT 'Reference to the user who approved this task template for production use, supporting SOX control requirements.',
    `cost_center_id` BIGINT COMMENT 'Reference to the organizational cost center responsible for executing tasks created from this template.',
    `employee_id` BIGINT COMMENT 'Reference to the user who originally created this task template record.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who most recently modified this task template record.',
    `parent_template_id` BIGINT COMMENT 'Reference to the previous version of this task template, supporting version history and lineage tracking. Null for initial versions.',
    `previous_task_template_id` BIGINT COMMENT 'Self-referencing FK on task_template (previous_task_template_id)',
    `accounting_standard` STRING COMMENT 'The financial reporting standard framework that this task template supports, either Generally Accepted Accounting Principles (GAAP), International Financial Reporting Standards (IFRS), or both.',
    `approval_level_count` STRING COMMENT 'Number of sequential approval levels required for tasks generated from this template, supporting segregation of duties requirements.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this task template was approved for production use.',
    `archived_timestamp` TIMESTAMP COMMENT 'Date and time when this task template was archived and removed from active use. Null for active templates.',
    `automation_eligible` BOOLEAN COMMENT 'Indicates whether tasks created from this template are candidates for robotic process automation or system automation.',
    `automation_script_path` STRING COMMENT 'File system path or repository location of the automation script or workflow definition for this task template.',
    `control_objective` STRING COMMENT 'Statement of the internal control objective that this task template is designed to achieve, supporting compliance and audit requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this task template record was first created in the system.',
    `task_template_description` STRING COMMENT 'Detailed business description of the task template including its purpose, scope, and usage guidelines for financial accounting staff.',
    `document_retention_years` STRING COMMENT 'Number of years that documentation for tasks created from this template must be retained to meet regulatory and audit requirements.',
    `documentation_required` BOOLEAN COMMENT 'Indicates whether supporting documentation must be attached to task instances created from this template for audit trail purposes.',
    `effective_end_date` DATE COMMENT 'Date after which this task template is no longer active and should not be used for new task creation. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this task template becomes active and available for use in financial close processes.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Expected time in hours required to complete a task instance created from this template, used for resource planning and scheduling.',
    `frequency` STRING COMMENT 'Scheduled recurrence pattern for tasks created from this template within the financial close calendar.',
    `gl_account_category` STRING COMMENT 'Primary financial statement category that this task template typically affects within the chart of accounts structure.',
    `instructions` STRING COMMENT 'Detailed step-by-step instructions for completing tasks created from this template, including system navigation, data sources, and calculation methods.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this task template record was most recently updated in the system.',
    `last_used_date` DATE COMMENT 'Most recent date when a task instance was created from this template, used to identify obsolete templates.',
    `materiality_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the materiality threshold amount.',
    `materiality_threshold_amount` DECIMAL(18,2) COMMENT 'Monetary threshold above which variances or errors in tasks from this template require escalation and additional review.',
    `priority_level` STRING COMMENT 'Business priority classification indicating the urgency and importance of tasks generated from this template.',
    `requires_approval` BOOLEAN COMMENT 'Indicates whether tasks created from this template require managerial or supervisory approval before completion, supporting SOX compliance controls.',
    `responsible_role` STRING COMMENT 'Job role or function responsible for executing tasks generated from this template, such as Staff Accountant, Controller, or Financial Analyst.',
    `reviewer_role` STRING COMMENT 'Job role or function responsible for reviewing and approving tasks generated from this template, supporting segregation of duties.',
    `risk_rating` STRING COMMENT 'Assessment of the financial or operational risk associated with errors or omissions in tasks created from this template.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this task template is part of a SOX-mandated internal control over financial reporting, requiring enhanced documentation and audit trail.',
    `task_template_status` STRING COMMENT 'Current lifecycle status of the task template indicating its availability for use in financial close processes.',
    `subledger_type` STRING COMMENT 'The subsidiary ledger system that this task template integrates with or reconciles to the general ledger.',
    `system_of_record` STRING COMMENT 'Name of the primary financial system where tasks from this template are executed, such as Oracle Financials or SAP S/4HANA.',
    `template_code` STRING COMMENT 'Unique business identifier code for the task template used for external reference and system integration.',
    `template_name` STRING COMMENT 'Human-readable name of the task template describing its purpose and function within the financial close process.',
    `template_type` STRING COMMENT 'Classification of the task template by its functional purpose within the general ledger and financial accounting workflow.',
    `usage_count` STRING COMMENT 'Total number of task instances that have been created from this template, used for template effectiveness analysis.',
    `version_number` STRING COMMENT 'Sequential version number of this task template, incremented with each revision to support change tracking and audit trail.',
    CONSTRAINT pk_task_template PRIMARY KEY(`task_template_id`)
) COMMENT 'Master reference table for task_template. Referenced by task_template_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`recurring_template` (
    `recurring_template_id` BIGINT COMMENT 'Primary key for recurring_template',
    `org_unit_id` BIGINT COMMENT 'Business unit or division to which this recurring template belongs, used for organizational segmentation and consolidation reporting.',
    `ledger_sox_control_id` BIGINT COMMENT 'Reference identifier to the SOX internal control documentation that governs this recurring template. Nullable if not SOX-controlled.',
    `cost_center_id` BIGINT COMMENT 'Default cost center to be used for journal entries generated from this template. Used for management reporting and cost allocation.',
    `legal_entity_id` BIGINT COMMENT 'Legal entity for which journal entries from this template are recorded, critical for statutory reporting and intercompany eliminations.',
    `previous_recurring_template_id` BIGINT COMMENT 'Self-referencing FK on recurring_template (previous_recurring_template_id)',
    `amount_calculation_method` STRING COMMENT 'Method used to determine the journal entry amount at execution time: fixed uses default_amount, formula applies a calculation rule, percentage applies a rate, variable requires manual input.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether journal entries generated from this template require managerial approval before posting. True requires approval workflow, False allows direct posting.',
    `approved_by` STRING COMMENT 'User identifier of the manager or controller who approved this recurring template for production use. Nullable if approval not yet granted.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this recurring template was approved for production use. Nullable if approval not yet granted.',
    `auto_post_flag` BOOLEAN COMMENT 'Indicates whether journal entries generated from this template should be automatically posted to the general ledger without manual review. True for automatic posting, False for manual review required.',
    `calculation_formula` STRING COMMENT 'Mathematical or business rule formula used to calculate journal entry amounts when amount_calculation_method is formula or percentage. Nullable for fixed amounts.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this recurring template record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary amounts in journal entries generated from this template.',
    `default_amount` DECIMAL(18,2) COMMENT 'Standard monetary amount to be used when generating journal entries from this template. May be overridden at execution time.',
    `recurring_template_description` STRING COMMENT 'Detailed business description of the recurring template purpose, accounting treatment, and usage guidelines for finance team reference.',
    `effective_end_date` DATE COMMENT 'Date after which the recurring template is no longer active and will not generate new journal entries. Nullable for indefinite templates.',
    `effective_start_date` DATE COMMENT 'Date from which the recurring template becomes active and eligible for automated journal entry generation.',
    `execution_count` STRING COMMENT 'Total number of times this template has been executed to generate journal entries since activation.',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this template generates intercompany transactions requiring elimination during consolidation. True for intercompany, False for intra-entity.',
    `journal_category` STRING COMMENT 'Accounting category classification for journal entries generated from this template, used for reporting and audit trail purposes.',
    `journal_source` STRING COMMENT 'Source system or module identifier that originates the recurring journal entries generated from this template.',
    `last_execution_date` DATE COMMENT 'Date when the template was last used to generate a journal entry. Nullable if never executed.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified this recurring template record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this recurring template record was last modified in the system.',
    `next_execution_date` DATE COMMENT 'Scheduled date for the next automated journal entry generation from this template.',
    `notes` STRING COMMENT 'Additional operational notes, special instructions, or audit comments related to the recurring template setup and maintenance.',
    `recurrence_day` STRING COMMENT 'Specific day of the period (month, week, etc.) on which the recurring journal entry should be generated. For monthly templates, values 1-31; for weekly, values 1-7.',
    `recurrence_frequency` STRING COMMENT 'Frequency at which the template automatically generates journal entries in the general ledger system.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether journal entries generated from this template should automatically create reversing entries in the subsequent period. True for automatic reversal, False for standard entries.',
    `reversal_period_offset` STRING COMMENT 'Number of periods after the original entry date when the reversing entry should be created. Typically 1 for next-period reversal. Nullable if reversal_flag is False.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this recurring template is subject to Sarbanes-Oxley internal control testing and documentation requirements. True for SOX-controlled templates.',
    `recurring_template_status` STRING COMMENT 'Current lifecycle status of the recurring template indicating whether it is available for use in journal entry generation.',
    `template_code` STRING COMMENT 'Unique business identifier code for the recurring template used for external reference and reporting.',
    `template_name` STRING COMMENT 'Descriptive name of the recurring journal entry template for identification and reporting purposes.',
    `template_type` STRING COMMENT 'Classification of the recurring template based on its accounting purpose and processing behavior.',
    `created_by` STRING COMMENT 'User identifier of the person who created this recurring template record in the system.',
    CONSTRAINT pk_recurring_template PRIMARY KEY(`recurring_template_id`)
) COMMENT 'Master reference table for recurring_template. Referenced by recurring_template_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`ledger`.`accounting_calendar` (
    `accounting_calendar_id` BIGINT COMMENT 'Primary key for accounting_calendar',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that owns or uses this accounting calendar. Supports multi-entity financial consolidation.',
    `parent_calendar_id` BIGINT COMMENT 'Reference to a parent accounting calendar for hierarchical calendar structures. Supports subsidiary calendar inheritance.',
    `parent_accounting_calendar_id` BIGINT COMMENT 'Self-referencing FK on accounting_calendar (parent_accounting_calendar_id)',
    `adjustment_period_flag` BOOLEAN COMMENT 'Indicates whether the calendar includes an adjustment period (Period 13) for year-end closing entries and corrections.',
    `approval_status` STRING COMMENT 'Current approval workflow status for the accounting calendar. Ensures proper authorization before calendar activation.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the accounting calendar was approved. Establishes the authorization timeline for audit purposes.',
    `approved_by` STRING COMMENT 'User identifier or name of the person who approved the accounting calendar for use. Documents authorization for SOX compliance.',
    `budget_calendar_flag` BOOLEAN COMMENT 'Indicates whether this calendar is used for budgeting and planning activities. True for calendars aligned with budget cycles.',
    `calendar_code` STRING COMMENT 'Unique business identifier code for the accounting calendar. Used for external references and system integration.',
    `calendar_name` STRING COMMENT 'Human-readable name of the accounting calendar. Describes the calendar purpose or organizational scope.',
    `calendar_type` STRING COMMENT 'Classification of the calendar structure. Defines the period structure and calculation methodology used for financial reporting.',
    `consolidation_calendar_flag` BOOLEAN COMMENT 'Indicates whether this calendar is used for corporate consolidation and group reporting. True for parent company calendars.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the accounting calendar record was first created in the system. Supports audit and compliance tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the primary reporting currency of this calendar. Used for financial statement presentation.',
    `accounting_calendar_description` STRING COMMENT 'Detailed description of the accounting calendar purpose, scope, and usage guidelines. Provides context for calendar selection.',
    `effective_end_date` DATE COMMENT 'Date when the accounting calendar expires and is no longer available for new transactions. Nullable for open-ended calendars.',
    `effective_start_date` DATE COMMENT 'Date when the accounting calendar becomes active and available for transaction posting. Marks the beginning of calendar validity.',
    `fiscal_year_start_day` STRING COMMENT 'Day of month (1-31) when the fiscal year begins. Combined with start month to define fiscal year boundaries.',
    `fiscal_year_start_month` STRING COMMENT 'Month number (1-12) when the fiscal year begins. Used to calculate fiscal periods and year-end reporting cycles.',
    `intercompany_elimination_flag` BOOLEAN COMMENT 'Indicates whether this calendar supports intercompany elimination processing for consolidated financial statements.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last updated the accounting calendar record. Tracks change responsibility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the accounting calendar record was last updated. Supports change tracking and audit requirements.',
    `leap_year_handling` STRING COMMENT 'Method for handling leap year extra day in period calculations. Defines how February 29th is allocated to accounting periods.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the accounting calendar. Captures implementation guidance.',
    `number_of_periods` STRING COMMENT 'Total number of accounting periods in the fiscal year. Typically 12 for monthly, 13 for 4-week cycles, or 52/53 for weekly calendars.',
    `period_type` STRING COMMENT 'Frequency and duration of accounting periods within the calendar. Defines how the fiscal year is subdivided for reporting.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this calendar is used for regulatory compliance reporting to banking authorities and supervisory bodies.',
    `accounting_calendar_status` STRING COMMENT 'Current lifecycle status of the accounting calendar. Determines whether the calendar is available for transaction posting and reporting.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the calendar. Determines period cutoff times and transaction posting deadlines.',
    `version_number` STRING COMMENT 'Version number of the accounting calendar configuration. Incremented with each approved change to support version control.',
    `week_start_day` STRING COMMENT 'Day of the week when accounting weeks begin. Relevant for weekly and 4-4-5 calendar structures.',
    `year_end_close_period` STRING COMMENT 'Period number designated for year-end closing activities. Typically period 13 for adjustment entries and final reconciliations.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the accounting calendar record. Supports audit trail requirements.',
    CONSTRAINT pk_accounting_calendar PRIMARY KEY(`accounting_calendar_id`)
) COMMENT 'Master reference table for accounting_calendar. Referenced by accounting_calendar_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `banking_ecm`.`ledger`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_parent_account_gl_account_id` FOREIGN KEY (`parent_account_gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_set_id` FOREIGN KEY (`set_id`) REFERENCES `banking_ecm`.`ledger`.`set`(`set_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_recurring_template_id` FOREIGN KEY (`recurring_template_id`) REFERENCES `banking_ecm`.`ledger`.`recurring_template`(`recurring_template_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_reversed_journal_entry_id` FOREIGN KEY (`reversed_journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_set_id` FOREIGN KEY (`set_id`) REFERENCES `banking_ecm`.`ledger`.`set`(`set_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_reversed_line_journal_entry_line_id` FOREIGN KEY (`reversed_line_journal_entry_line_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_set_id` FOREIGN KEY (`set_id`) REFERENCES `banking_ecm`.`ledger`.`set`(`set_id`);
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ADD CONSTRAINT `fk_ledger_cost_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ADD CONSTRAINT `fk_ledger_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_primary_ultimate_parent_legal_entity_id` FOREIGN KEY (`primary_ultimate_parent_legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`set` ADD CONSTRAINT `fk_ledger_set_accounting_calendar_id` FOREIGN KEY (`accounting_calendar_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_calendar`(`accounting_calendar_id`);
ALTER TABLE `banking_ecm`.`ledger`.`set` ADD CONSTRAINT `fk_ledger_set_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `banking_ecm`.`ledger`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `banking_ecm`.`ledger`.`set` ADD CONSTRAINT `fk_ledger_set_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_subledger_reconciliation_id` FOREIGN KEY (`subledger_reconciliation_id`) REFERENCES `banking_ecm`.`ledger`.`subledger_reconciliation`(`subledger_reconciliation_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ADD CONSTRAINT `fk_ledger_subledger_reconciliation_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ADD CONSTRAINT `fk_ledger_subledger_reconciliation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ADD CONSTRAINT `fk_ledger_trial_balance_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ADD CONSTRAINT `fk_ledger_trial_balance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ADD CONSTRAINT `fk_ledger_trial_balance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ADD CONSTRAINT `fk_ledger_trial_balance_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ADD CONSTRAINT `fk_ledger_trial_balance_set_id` FOREIGN KEY (`set_id`) REFERENCES `banking_ecm`.`ledger`.`set`(`set_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_matched_transaction_id` FOREIGN KEY (`matched_transaction_id`) REFERENCES `banking_ecm`.`ledger`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_primary_intercompany_counterparty_legal_entity_id` FOREIGN KEY (`primary_intercompany_counterparty_legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_reversed_transaction_intercompany_transaction_id` FOREIGN KEY (`reversed_transaction_intercompany_transaction_id`) REFERENCES `banking_ecm`.`ledger`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ADD CONSTRAINT `fk_ledger_intercompany_elimination_consolidation_run_id` FOREIGN KEY (`consolidation_run_id`) REFERENCES `banking_ecm`.`ledger`.`consolidation_run`(`consolidation_run_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ADD CONSTRAINT `fk_ledger_intercompany_elimination_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ADD CONSTRAINT `fk_ledger_intercompany_elimination_intercompany_transaction_id` FOREIGN KEY (`intercompany_transaction_id`) REFERENCES `banking_ecm`.`ledger`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ADD CONSTRAINT `fk_ledger_intercompany_elimination_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ADD CONSTRAINT `fk_ledger_intercompany_elimination_primary_intercompany_counterparty_legal_entity_id` FOREIGN KEY (`primary_intercompany_counterparty_legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ADD CONSTRAINT `fk_ledger_financial_close_task_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ADD CONSTRAINT `fk_ledger_financial_close_task_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ADD CONSTRAINT `fk_ledger_financial_close_task_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ADD CONSTRAINT `fk_ledger_financial_close_task_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ADD CONSTRAINT `fk_ledger_financial_close_task_task_template_id` FOREIGN KEY (`task_template_id`) REFERENCES `banking_ecm`.`ledger`.`task_template`(`task_template_id`);
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ADD CONSTRAINT `fk_ledger_consolidation_run_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ADD CONSTRAINT `fk_ledger_consolidation_run_consolidation_group_id` FOREIGN KEY (`consolidation_group_id`) REFERENCES `banking_ecm`.`ledger`.`consolidation_group`(`consolidation_group_id`);
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ADD CONSTRAINT `fk_ledger_profit_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ADD CONSTRAINT `fk_ledger_profit_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ADD CONSTRAINT `fk_ledger_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ADD CONSTRAINT `fk_ledger_ledger_budget_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ADD CONSTRAINT `fk_ledger_ledger_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ADD CONSTRAINT `fk_ledger_ledger_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ADD CONSTRAINT `fk_ledger_ledger_budget_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ADD CONSTRAINT `fk_ledger_ledger_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ADD CONSTRAINT `fk_ledger_ledger_budget_set_id` FOREIGN KEY (`set_id`) REFERENCES `banking_ecm`.`ledger`.`set`(`set_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ADD CONSTRAINT `fk_ledger_ledger_budget_previous_ledger_budget_id` FOREIGN KEY (`previous_ledger_budget_id`) REFERENCES `banking_ecm`.`ledger`.`ledger_budget`(`ledger_budget_id`);
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ADD CONSTRAINT `fk_ledger_tax_provision_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ADD CONSTRAINT `fk_ledger_tax_provision_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ADD CONSTRAINT `fk_ledger_tax_provision_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ADD CONSTRAINT `fk_ledger_tax_provision_previous_tax_provision_id` FOREIGN KEY (`previous_tax_provision_id`) REFERENCES `banking_ecm`.`ledger`.`tax_provision`(`tax_provision_id`);
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ADD CONSTRAINT `fk_ledger_account_testing_scope_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_group` ADD CONSTRAINT `fk_ledger_consolidation_group_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_group` ADD CONSTRAINT `fk_ledger_consolidation_group_parent_consolidation_group_id` FOREIGN KEY (`parent_consolidation_group_id`) REFERENCES `banking_ecm`.`ledger`.`consolidation_group`(`consolidation_group_id`);
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_group` ADD CONSTRAINT `fk_ledger_consolidation_group_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`task_template` ADD CONSTRAINT `fk_ledger_task_template_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`task_template` ADD CONSTRAINT `fk_ledger_task_template_parent_template_id` FOREIGN KEY (`parent_template_id`) REFERENCES `banking_ecm`.`ledger`.`task_template`(`task_template_id`);
ALTER TABLE `banking_ecm`.`ledger`.`task_template` ADD CONSTRAINT `fk_ledger_task_template_previous_task_template_id` FOREIGN KEY (`previous_task_template_id`) REFERENCES `banking_ecm`.`ledger`.`task_template`(`task_template_id`);
ALTER TABLE `banking_ecm`.`ledger`.`recurring_template` ADD CONSTRAINT `fk_ledger_recurring_template_ledger_sox_control_id` FOREIGN KEY (`ledger_sox_control_id`) REFERENCES `banking_ecm`.`ledger`.`ledger_sox_control`(`ledger_sox_control_id`);
ALTER TABLE `banking_ecm`.`ledger`.`recurring_template` ADD CONSTRAINT `fk_ledger_recurring_template_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`ledger`.`recurring_template` ADD CONSTRAINT `fk_ledger_recurring_template_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`recurring_template` ADD CONSTRAINT `fk_ledger_recurring_template_previous_recurring_template_id` FOREIGN KEY (`previous_recurring_template_id`) REFERENCES `banking_ecm`.`ledger`.`recurring_template`(`recurring_template_id`);
ALTER TABLE `banking_ecm`.`ledger`.`accounting_calendar` ADD CONSTRAINT `fk_ledger_accounting_calendar_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`ledger`.`accounting_calendar` ADD CONSTRAINT `fk_ledger_accounting_calendar_parent_calendar_id` FOREIGN KEY (`parent_calendar_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_calendar`(`accounting_calendar_id`);
ALTER TABLE `banking_ecm`.`ledger`.`accounting_calendar` ADD CONSTRAINT `fk_ledger_accounting_calendar_parent_accounting_calendar_id` FOREIGN KEY (`parent_accounting_calendar_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_calendar`(`accounting_calendar_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`ledger` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `banking_ecm`.`ledger` SET TAGS ('dbx_domain' = 'ledger');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Account Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `reporting_code_id` SET TAGS ('dbx_business_glossary_term' = 'Gaap Classification Reporting Code Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
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
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `normal_balance` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance Direction');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `normal_balance` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `parent_account_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Code');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Posting Allowed Flag');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `reconciliation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Required Flag');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `risk_weighted_asset_category` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Asset (RWA) Category');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `statistical_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Account Flag');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `subledger_source` SET TAGS ('dbx_business_glossary_term' = 'Subledger Source System');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `tax_line_mapping` SET TAGS ('dbx_business_glossary_term' = 'Tax Return Line Item Mapping');
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) ID');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit ID');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `parent_account_gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account ID');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `reporting_code_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger ID');
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
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer User Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `recurring_template_id` SET TAGS ('dbx_business_glossary_term' = 'Recurring Template Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `reversed_journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Journal Entry Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Identifier (ID)');
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
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Entered Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `reversed_line_journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Line Identifier (ID)');
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
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `subledger_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Subledger Reference Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `subledger_type` SET TAGS ('dbx_business_glossary_term' = 'Subledger Type');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Calendar Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `primary_accounting_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Opened By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `primary_accounting_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `primary_accounting_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `quaternary_accounting_sox_certified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Certified By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `quaternary_accounting_sox_certified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `quaternary_accounting_sox_certified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `quinary_accounting_record_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `quinary_accounting_record_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `quinary_accounting_record_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `regulatory_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `tertiary_accounting_permanently_closed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Permanently Closed By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `tertiary_accounting_permanently_closed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ALTER COLUMN `tertiary_accounting_permanently_closed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit ID');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `tertiary_cost_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `tertiary_cost_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ALTER COLUMN `tertiary_cost_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Of Incorporation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `parent_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Legal Entity Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `primary_ultimate_parent_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Legal Entity Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard Taxonomy Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ALTER COLUMN `jurisdiction_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction of Incorporation');
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
ALTER TABLE `banking_ecm`.`ledger`.`set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`set` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Set Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `accounting_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Calendar Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Standard');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'US_GAAP|IFRS|local_GAAP|statutory|regulatory|tax');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `average_balance_processing_flag` SET TAGS ('dbx_business_glossary_term' = 'Average Balance Processing Flag');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `budget_control_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Control Enabled Flag');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `cecl_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Current Expected Credit Losses (CECL) Compliant Flag');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_value_regex' = 'full|proportionate|equity|none');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `encumbrance_accounting_flag` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Accounting Flag');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `first_posted_period` SET TAGS ('dbx_business_glossary_term' = 'First Posted Period');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `ifrs_9_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standard 9 (IFRS 9) Compliant Flag');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `intercompany_elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Flag');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `journal_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Journal Approval Required Flag');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `latest_closed_period` SET TAGS ('dbx_business_glossary_term' = 'Latest Closed Period');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `latest_opened_period` SET TAGS ('dbx_business_glossary_term' = 'Latest Opened Period');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `ledger_name` SET TAGS ('dbx_business_glossary_term' = 'Ledger Name');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `ledger_short_name` SET TAGS ('dbx_business_glossary_term' = 'Ledger Short Name');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `ledger_status` SET TAGS ('dbx_business_glossary_term' = 'Ledger Status');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `ledger_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `ledger_type` SET TAGS ('dbx_business_glossary_term' = 'Ledger Type');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `ledger_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|reporting|adjustment|simulation|consolidation');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `period_close_tolerance_amount` SET TAGS ('dbx_business_glossary_term' = 'Period Close Tolerance Amount');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `retained_earnings_account` SET TAGS ('dbx_business_glossary_term' = 'Retained Earnings Account');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `revaluation_method` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Revaluation Method');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `revaluation_method` SET TAGS ('dbx_value_regex' = 'period_end|daily|none');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `segment_value_security_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Segment Value Security Enabled Flag');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `set_description` SET TAGS ('dbx_business_glossary_term' = 'Ledger Set Description');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `sox_control_ledger_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Ledger Flag');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `subledger_accounting_method` SET TAGS ('dbx_business_glossary_term' = 'Subledger Accounting Method (SLA)');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `subledger_accounting_method` SET TAGS ('dbx_value_regex' = 'accrual|cash|modified_cash|commitment');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `suspense_account` SET TAGS ('dbx_business_glossary_term' = 'Suspense Account');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `translation_method` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Translation Method');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `translation_method` SET TAGS ('dbx_value_regex' = 'current_rate|temporal|monetary_nonmonetary');
ALTER TABLE `banking_ecm`.`ledger`.`set` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `subledger_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Banking Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer User Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `subledger_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer User Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `subledger_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `subledger_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `subledger_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Run Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `auto_reconciliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Reconciliation Flag');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Subledger Balance Amount');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `subledger_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Reconciliation ID');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control ID');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `primary_subledger_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer ID');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `primary_subledger_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `primary_subledger_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `gl_account_range_end` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Range End');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `gl_account_range_start` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Range Start');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `gl_balance` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Balance');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `gl_system_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) System Name');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `is_material_variance` SET TAGS ('dbx_business_glossary_term' = 'Is Material Variance');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `materiality_threshold` SET TAGS ('dbx_business_glossary_term' = 'Materiality Threshold');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|ad_hoc');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Method');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_value_regex' = 'automated|manual|semi_automated');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `reconciliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Number');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|in_progress|exception|pending_review|approved|rejected');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `requires_journal_entry` SET TAGS ('dbx_business_glossary_term' = 'Requires Journal Entry');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `sox_control_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Evidence Reference');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `subledger_balance` SET TAGS ('dbx_business_glossary_term' = 'Subledger Balance');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `subledger_type` SET TAGS ('dbx_business_glossary_term' = 'Subledger Type');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `subledger_type` SET TAGS ('dbx_value_regex' = 'accounts_payable|accounts_receivable|fixed_assets|inventory|payroll|cash_management');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `variance_explanation` SET TAGS ('dbx_business_glossary_term' = 'Variance Explanation');
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `trial_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Balance ID');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period ID');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger ID');
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
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'consolidation_operations');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Elimination Journal Entry ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `matched_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Transaction ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Legal Entity ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `primary_intercompany_counterparty_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Legal Entity ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `reversed_transaction_intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Transaction ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
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
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `originating_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Originating General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
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
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` SET TAGS ('dbx_subdomain' = 'consolidation_operations');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `intercompany_elimination_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `consolidation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Run ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Elimination Period Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Legal Entity ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `primary_intercompany_counterparty_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Legal Entity ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `tertiary_intercompany_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `tertiary_intercompany_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `tertiary_intercompany_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'IFRS|US_GAAP|local_GAAP');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `counterparty_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Counterparty General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `elimination_amount` SET TAGS ('dbx_business_glossary_term' = 'Elimination Amount');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `elimination_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Elimination General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `elimination_method` SET TAGS ('dbx_business_glossary_term' = 'Elimination Method');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `elimination_method` SET TAGS ('dbx_value_regex' = 'full|proportional|equity_method|none');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `elimination_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Elimination Reference Number');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Elimination Status');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `elimination_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|reversed|rejected');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partially_matched|disputed|reconciled');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `netting_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Netting Agreement Reference');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Elimination Notes');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `originating_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Originating General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `sox_control_reference` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Reference');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `transfer_pricing_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Documentation Reference');
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` SET TAGS ('dbx_subdomain' = 'consolidation_operations');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `financial_close_task_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Close Task Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `primary_financial_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Task Owner Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `primary_financial_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `primary_financial_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `quaternary_financial_task_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Task Approver Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `quaternary_financial_task_approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `quaternary_financial_task_approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `quinary_financial_waiver_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `quinary_financial_waiver_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `quinary_financial_waiver_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `task_template_id` SET TAGS ('dbx_business_glossary_term' = 'Task Template Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `tertiary_financial_task_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Task Reviewer Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `tertiary_financial_task_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `tertiary_financial_task_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `blocking_issue_description` SET TAGS ('dbx_business_glossary_term' = 'Blocking Issue Description');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Task Comments');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `control_objective` SET TAGS ('dbx_business_glossary_term' = 'Control Objective');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `evidence_document_ids` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Identifiers (IDs)');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `evidence_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence Required Flag');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `financial_close_task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `financial_close_task_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue|waived|blocked');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `is_key_control` SET TAGS ('dbx_business_glossary_term' = 'Is Key Control Flag');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Task Flag');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `predecessor_task_ids` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Task Identifiers (IDs)');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Task Priority');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `task_code` SET TAGS ('dbx_business_glossary_term' = 'Task Code');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `task_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Task Name');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'journal_posting|reconciliation|accrual_review|approval|sign_off|flux_analysis');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `waiver_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` SET TAGS ('dbx_subdomain' = 'consolidation_operations');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `consolidation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Run Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `consolidation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `consolidation_adjustments_count` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Adjustments Count');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `consolidation_engine_version` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Engine Version');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_value_regex' = 'FULL|PROPORTIONATE|EQUITY|COST');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `currency_translation_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Currency Translation Adjustment (CTA) Amount');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `entities_included_count` SET TAGS ('dbx_business_glossary_term' = 'Entities Included Count');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `goodwill_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Goodwill Adjustment Amount');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `intercompany_eliminations_amount` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Eliminations Amount');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `intercompany_eliminations_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Eliminations Applied Flag');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `minority_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Minority Interest Amount');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `net_income_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Net Income Consolidated');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Run Notes');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `presentation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Presentation Currency Code');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `presentation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Run Reference Number');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `regulatory_submission_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Type');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Reporting Standard');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_value_regex' = 'IFRS|US_GAAP|LOCAL_GAAP|REGULATORY|MANAGEMENT');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `run_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Run Duration in Seconds');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `run_mode` SET TAGS ('dbx_business_glossary_term' = 'Run Mode');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `run_mode` SET TAGS ('dbx_value_regex' = 'MANUAL|SCHEDULED|AUTOMATED');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Run Status');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'INITIATED|IN_PROGRESS|COMPLETED|APPROVED|REJECTED|FAILED');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Run Type');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'PRELIMINARY|FINAL|RESTATEMENT|FORECAST|BUDGET');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `total_assets_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Total Assets Consolidated');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `total_equity_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Total Equity Consolidated');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `total_liabilities_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Total Liabilities Consolidated');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `validation_errors_count` SET TAGS ('dbx_business_glossary_term' = 'Validation Errors Count');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'PASSED|FAILED|WARNING|NOT_VALIDATED');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` SET TAGS ('dbx_subdomain' = 'regulatory_controls');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `ledger_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger SOX (Sarbanes-Oxley Act) Control ID');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Sox Control Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Control Owner ID');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `quaternary_ledger_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `quaternary_ledger_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `quaternary_ledger_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `quinary_ledger_control_owner_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `tertiary_ledger_last_updated_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By ID');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `tertiary_ledger_last_updated_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `tertiary_ledger_last_updated_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `control_documentation_link` SET TAGS ('dbx_business_glossary_term' = 'Control Documentation Link');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `control_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Control Effective Date');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `control_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Frequency');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `control_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|event-driven');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Control Name');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `control_nature` SET TAGS ('dbx_business_glossary_term' = 'Control Nature');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `control_nature` SET TAGS ('dbx_value_regex' = 'manual|automated|semi-automated');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `control_number` SET TAGS ('dbx_business_glossary_term' = 'Control Number');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `control_objective` SET TAGS ('dbx_business_glossary_term' = 'Control Objective');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `control_retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Control Retirement Date');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|under review');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `entity_level_control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Entity Level Control Indicator');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `external_auditor_reference` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Reference');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `gl_process_area` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Process Area');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `it_dependent_indicator` SET TAGS ('dbx_business_glossary_term' = 'IT (Information Technology) Dependent Indicator');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `key_control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Key Control Indicator');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `last_test_result` SET TAGS ('dbx_business_glossary_term' = 'Last Test Result');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `last_test_result` SET TAGS ('dbx_value_regex' = 'effective|deficiency|significant deficiency|material weakness|not tested');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not required|planned|in progress|completed|validated');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `risk_assertion` SET TAGS ('dbx_business_glossary_term' = 'Risk Assertion');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `risk_assertion` SET TAGS ('dbx_value_regex' = 'completeness|accuracy|existence|valuation|presentation|rights and obligations');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `scoping_decision` SET TAGS ('dbx_business_glossary_term' = 'Scoping Decision');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `scoping_decision` SET TAGS ('dbx_value_regex' = 'in scope|out of scope|under evaluation');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `scoping_rationale` SET TAGS ('dbx_business_glossary_term' = 'Scoping Rationale');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `test_exceptions_count` SET TAGS ('dbx_business_glossary_term' = 'Test Exceptions Count');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `test_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Test Sample Size');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `testing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Testing Frequency');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `testing_frequency` SET TAGS ('dbx_value_regex' = 'quarterly|semi-annual|annual');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `testing_method` SET TAGS ('dbx_business_glossary_term' = 'Testing Method');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ALTER COLUMN `testing_method` SET TAGS ('dbx_value_regex' = 'inquiry|observation|inspection|reperformance|walkthrough');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `ledger_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Budget ID');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner ID');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `primary_ledger_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `primary_ledger_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `primary_ledger_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger ID');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `tertiary_ledger_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `tertiary_ledger_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `tertiary_ledger_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `previous_ledger_budget_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `allocation_driver` SET TAGS ('dbx_business_glossary_term' = 'Allocation Driver');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|proportional|activity_based|driver_based');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'revenue|expense|asset|liability');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|locked|revised');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'operating|capital|project|strategic');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast Amount');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `lock_flag` SET TAGS ('dbx_business_glossary_term' = 'Lock Flag');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `locked_date` SET TAGS ('dbx_business_glossary_term' = 'Locked Date');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Period Number');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `prior_year_actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Actual Amount');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `quarter_number` SET TAGS ('dbx_business_glossary_term' = 'Quarter Number');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `scenario` SET TAGS ('dbx_business_glossary_term' = 'Budget Scenario');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `scenario` SET TAGS ('dbx_value_regex' = 'base|optimistic|pessimistic|stress');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Submitted Date');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `tax_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `primary_tax_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer User Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `primary_tax_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `primary_tax_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `reviewer_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer User Identifier (ID)');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `reviewer_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `reviewer_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `previous_tax_provision_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'US_GAAP|IFRS|local_GAAP');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `audit_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Evidence Reference');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `current_tax_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Tax Expense Amount');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `deferred_tax_asset_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Asset (DTA) Amount');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `deferred_tax_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Expense Amount');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `deferred_tax_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Liability (DTL) Amount');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `effective_tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Effective Tax Rate (ETR) Percent');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `net_deferred_tax_position_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Deferred Tax Position Amount');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Notes');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `permanent_difference_amount` SET TAGS ('dbx_business_glossary_term' = 'Permanent Difference Amount');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `pretax_income_amount` SET TAGS ('dbx_business_glossary_term' = 'Pretax Income Amount');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `provision_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Date');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `provision_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Reference Number');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `provision_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Status');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `provision_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|posted|adjusted|finalized');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `provision_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Type');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `provision_type` SET TAGS ('dbx_value_regex' = 'current|deferred|total|interim|annual');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `rate_reconciliation_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Reconciliation Amount');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `sox_control_reference` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Reference');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `statutory_tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Statutory Tax Rate Percent');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `tax_credit_carryforward_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Carryforward Amount');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `tax_loss_carryforward_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Loss Carryforward Amount');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `temporary_difference_amount` SET TAGS ('dbx_business_glossary_term' = 'Temporary Difference Amount');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `total_tax_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Expense Amount');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `unrecognized_tax_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Unrecognized Tax Benefit (UTB) Amount');
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ALTER COLUMN `valuation_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Allowance Amount');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` SET TAGS ('dbx_association_edges' = 'ledger.gl_account,audit.engagement');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ALTER COLUMN `account_testing_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Account Testing Scope ID');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Account Testing Scope - Engagement Id');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Testing Scope - Gl Account Id');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ALTER COLUMN `account_testing_status` SET TAGS ('dbx_business_glossary_term' = 'Account Testing Status');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ALTER COLUMN `auditor_notes` SET TAGS ('dbx_business_glossary_term' = 'Auditor Notes');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Count');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ALTER COLUMN `materiality_threshold` SET TAGS ('dbx_business_glossary_term' = 'Materiality Threshold');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Account Risk Rating');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ALTER COLUMN `sampling_methodology` SET TAGS ('dbx_business_glossary_term' = 'Sampling Methodology');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ALTER COLUMN `scope_rationale` SET TAGS ('dbx_business_glossary_term' = 'Scope Rationale');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ALTER COLUMN `testing_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Testing Completion Date');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ALTER COLUMN `testing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Testing Period End Date');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ALTER COLUMN `testing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Testing Period Start Date');
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ALTER COLUMN `testing_procedures` SET TAGS ('dbx_business_glossary_term' = 'Testing Procedures');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_group` SET TAGS ('dbx_subdomain' = 'consolidation_operations');
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_group` ALTER COLUMN `consolidation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`task_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`task_template` SET TAGS ('dbx_subdomain' = 'regulatory_controls');
ALTER TABLE `banking_ecm`.`ledger`.`task_template` ALTER COLUMN `task_template_id` SET TAGS ('dbx_business_glossary_term' = 'Task Template Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`task_template` ALTER COLUMN `previous_task_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`task_template` ALTER COLUMN `materiality_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`recurring_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`recurring_template` SET TAGS ('dbx_subdomain' = 'regulatory_controls');
ALTER TABLE `banking_ecm`.`ledger`.`recurring_template` ALTER COLUMN `recurring_template_id` SET TAGS ('dbx_business_glossary_term' = 'Recurring Template Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`recurring_template` ALTER COLUMN `previous_recurring_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`recurring_template` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`recurring_template` ALTER COLUMN `modified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`recurring_template` ALTER COLUMN `created_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_calendar` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_calendar` ALTER COLUMN `accounting_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Calendar Identifier');
ALTER TABLE `banking_ecm`.`ledger`.`accounting_calendar` ALTER COLUMN `parent_accounting_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
