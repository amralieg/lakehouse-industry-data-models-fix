-- Schema for Domain: finance | Business: Life Insurance | Version: v1_ecm
-- Generated on: 2026-05-04 03:46:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `life_insurance_ecm`.`finance` COMMENT 'Owns general ledger, statutory (SAP) and GAAP financial reporting, IFRS 17 reporting, RBC calculations, cost center management, DAC asset tracking, intercompany settlement, budget vs. actual variance, and SOX-controlled financial close processes. Manages FASB ASC 944 / LDTI financial statement impacts, chart of accounts, journal entries, and external audit support. Serves as SSOT for all enterprise financial positions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`general_ledger` (
    `general_ledger_id` BIGINT COMMENT 'Unique identifier for the general ledger entry. Primary key for the general ledger data product.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: general_ledger IS the instance of a chart_of_accounts account with balances. All master data attributes (account_name, account_type, normal_balance, hierarchy, classifications, flags, etc.) should com',
    `cost_center_id` BIGINT COMMENT 'Identifier for the cost center associated with this account. Used for expense allocation, departmental reporting, and management accounting. Null for balance sheet accounts.',
    `legal_entity_id` BIGINT COMMENT 'Identifier for the legal entity to which this general ledger entry belongs. Links to the legal entity master for multi-entity consolidation and statutory reporting.',
    `account_code` STRING COMMENT 'The unique account code from the chart of accounts (COA). Serves as the primary business identifier for the GL account. Typically 4-10 digit numeric code following the enterprise COA structure.. Valid values are `^[0-9]{4,10}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the general ledger account. Inactive or closed accounts cannot accept new postings but retain historical balances.. Valid values are `active|inactive|suspended|closed`',
    `cohort_code` STRING COMMENT 'The IFRS 17 cohort identifier for insurance contract grouping. Used for Contractual Service Margin (CSM) tracking and IFRS 17 measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this general ledger account record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for this account. Supports multi-currency accounting and foreign exchange reporting.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this account becomes inactive and no longer accepts new postings. Null for currently active accounts. Supports historical reporting and COA governance.',
    `effective_start_date` DATE COMMENT 'The date from which this account becomes active and available for posting. Supports chart of accounts change management and version control.',
    `functional_currency_code` STRING COMMENT 'The three-letter ISO 4217 functional currency code for the legal entity. Used for currency translation and consolidation under ASC 830.. Valid values are `^[A-Z]{3}$`',
    `modified_by` STRING COMMENT 'The user ID or system identifier that last modified this general ledger account record. Supports accountability and audit trail requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this general ledger account record was last modified. Critical for change tracking and SOX compliance.',
    `product_line_code` STRING COMMENT 'The insurance product line associated with this account (e.g., WL for Whole Life, UL for Universal Life, SPIA for Single Premium Immediate Annuity). Enables product-level profitability analysis.',
    `source_system` STRING COMMENT 'The name or identifier of the source system from which this general ledger account originated. Supports data lineage and integration troubleshooting.',
    `source_system_key` STRING COMMENT 'The natural key or unique identifier for this account in the source system. Enables traceability back to the originating system of record.',
    `created_by` STRING COMMENT 'The user ID or system identifier that created this general ledger account record. Supports accountability and audit trail requirements.',
    CONSTRAINT pk_general_ledger PRIMARY KEY(`general_ledger_id`)
) COMMENT 'SSOT for all enterprise general ledger accounts, balances, and chart of accounts (COA) hierarchy. Owns account codes, account names, account type classifications (asset, liability, equity, revenue, expense, contra), normal balance direction (debit/credit), financial statement line mapping, SAP and GAAP dual-basis account mappings, IFRS 17 cohort account linkages, statutory vs. GAAP account designations, RBC line mapping, and account active/inactive governance with effective date ranges. Includes COA change management, account hierarchy (parent-child), account group definitions, and COA governance processes. Manages period open/close governance, close milestone tracking, and SOX-controlled financial close processes. Serves as the authoritative financial position record and chart of accounts master for all legal entities. Supports external audit support and regulatory filing account mapping.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record. Primary key for the journal entry entity.',
    `employee_id` BIGINT COMMENT 'User identifier of the individual who approved the journal entry for posting. Used to enforce segregation of duties (approver must differ from preparer) and document authorization for SOX compliance.',
    `claim_id` BIGINT COMMENT 'Reference to the specific claim associated with this journal entry. Populated for claim payment entries, claim reserve adjustments, and IBNR (Incurred But Not Reported) reserve entries.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the specific insurance policy or annuity contract associated with this journal entry. Populated for policy-level transactions such as premium revenue recognition, claim payments, surrender processing, and policy-specific reserve adjustments.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: journal_entry has legal_entity_code (STRING) and should FK to legal_entity. Journal entries are posted within a legal entity; FK is essential for legal entity financial statements and consolidation.',
    `primary_journal_employee_id` BIGINT COMMENT 'User identifier of the individual who prepared or created the journal entry. Used for audit trails, segregation of duties monitoring, and SOX compliance documentation.',
    `reversed_entry_journal_entry_id` BIGINT COMMENT 'Reference to the original journal entry that this entry reverses. Populated when this entry is a reversing entry, creating an audit trail back to the original transaction.',
    `accounting_basis` STRING COMMENT 'The accounting framework under which this journal entry is recorded. SAP = Statutory Accounting Principles (regulatory), GAAP = Generally Accepted Accounting Principles (US GAAP), IFRS17 = International Financial Reporting Standards 17 (insurance contracts), TAX = Tax basis reporting.. Valid values are `SAP|GAAP|IFRS17|TAX`',
    `accounting_period` STRING COMMENT 'The fiscal period to which this journal entry is assigned, typically in YYYY-MM format (e.g., 2024-03 for March 2024). Used for period-end close processes and financial reporting.',
    `approval_date` DATE COMMENT 'The date on which the journal entry was approved for posting. Used to track approval workflow timing and ensure timely financial close processes.',
    `approver_name` STRING COMMENT 'Full name of the individual who approved the journal entry. Used for financial close workflow tracking and audit documentation.',
    `batch_number` STRING COMMENT 'Identifier for the batch or group of journal entries processed together. Used for bulk posting operations, system-generated entries from upstream processes, and batch-level reconciliation.',
    `cost_center_code` STRING COMMENT 'Code identifying the organizational cost center responsible for this journal entry. Used for management reporting, budget vs. actual variance analysis, and expense allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the journal entry record was first created in the database. Used for audit trails and data lineage tracking.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The total credit amount for this journal entry header. In double-entry accounting, this must equal debit_amount to maintain balance. Represents increases to liability, equity, and revenue accounts or decreases to asset and expense accounts.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the journal entry amounts. Typically USD for US-domiciled life insurance companies, but may include other currencies for international operations or foreign investments.. Valid values are `^[A-Z]{3}$`',
    `debit_amount` DECIMAL(18,2) COMMENT 'The total debit amount for this journal entry header. In double-entry accounting, this must equal credit_amount to maintain balance. Represents increases to asset and expense accounts or decreases to liability, equity, and revenue accounts.',
    `entry_category` STRING COMMENT 'High-level business classification of the journal entry purpose. Examples: Premium Revenue, DAC Amortization, Reserve Movement, Claim Payment, Commission Accrual, Investment Income, Intercompany Settlement, Reinsurance Cession, Policy Acquisition Cost, Benefit Payment, Surrender Processing, LDTI Adjustment, PBR Reserve Entry.',
    `entry_date` DATE COMMENT 'The calendar date on which the journal entry was created or recorded in the system. May differ from posting_date for adjusting or backdated entries.',
    `entry_number` STRING COMMENT 'Business-facing unique journal entry number assigned by the general ledger system. Used for external audit trails and financial close documentation.',
    `entry_status` STRING COMMENT 'Current workflow status of the journal entry. Draft = in preparation, Pending Approval = submitted for review, Approved = authorized but not yet posted, Posted = committed to general ledger, Reversed = entry has been reversed, Rejected = not approved for posting.. Valid values are `draft|pending_approval|approved|posted|reversed|rejected`',
    `entry_type` STRING COMMENT 'Classification of the journal entry based on its purpose in the accounting cycle. Standard = routine operational entries, Adjusting = period-end accruals and deferrals, Reversing = automatic reversal of prior period adjusting entries, Closing = period-end closing entries, Opening = beginning of period entries, Reclassification = reallocation between accounts.. Valid values are `standard|adjusting|reversing|closing|opening|reclassification`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert transaction currency amounts to functional currency. Populated only for entries involving foreign currency transactions.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this journal entry belongs. Used for annual financial statement preparation and multi-year comparative reporting.',
    `functional_currency_credit` DECIMAL(18,2) COMMENT 'The credit amount converted to the companys functional currency (typically USD) using the applicable exchange rate. Used for consolidated financial reporting when original entry is in a foreign currency.',
    `functional_currency_debit` DECIMAL(18,2) COMMENT 'The debit amount converted to the companys functional currency (typically USD) using the applicable exchange rate. Used for consolidated financial reporting when original entry is in a foreign currency.',
    `ifrs17_measurement_model` STRING COMMENT 'The IFRS 17 measurement model applied to this journal entry for insurance contract accounting. GMM = General Measurement Model (building block approach), PAA = Premium Allocation Approach (simplified for short-duration contracts), VFA = Variable Fee Approach (for participating contracts with investment components).. Valid values are `GMM|PAA|VFA`',
    `intercompany_entity_code` STRING COMMENT 'Code identifying the counterparty legal entity for intercompany transactions. Used for intercompany reconciliation and consolidated financial statement elimination entries. Populated only when intercompany_indicator is True.',
    `intercompany_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry involves intercompany transactions between legal entities within the insurance group. True = entry requires intercompany elimination for consolidated reporting, False = intra-entity entry.',
    `journal_entry_description` STRING COMMENT 'Detailed narrative description of the journal entry purpose, business rationale, and supporting documentation references. Used for audit trails, financial close documentation, and regulatory examinations.',
    `ldti_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry is related to FASB ASU 2018-12 Long Duration Targeted Improvements (LDTI) accounting changes. True = entry is part of LDTI implementation (e.g., transition adjustments, updated DAC amortization, market risk benefit remeasurement), False = standard entry not impacted by LDTI.',
    `pbr_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry relates to Principle-Based Reserving (PBR) calculations under VM-20 and VM-21. True = entry records PBR reserves, stochastic reserve adjustments, or deterministic reserve calculations, False = entry not related to PBR.',
    `posted_timestamp` TIMESTAMP COMMENT 'The system timestamp when the journal entry was committed to the general ledger. Used for audit trails and to track financial close process timing.',
    `posting_date` DATE COMMENT 'The accounting date on which the journal entry is posted to the general ledger. This is the effective date for financial statement impact and determines the accounting period assignment.',
    `preparer_name` STRING COMMENT 'Full name of the individual who prepared the journal entry. Used for financial close workflow tracking and audit documentation.',
    `product_line_code` STRING COMMENT 'Code identifying the insurance product line to which this journal entry relates. Examples: Term Life, Whole Life, Universal Life, Variable Universal Life, Fixed Annuity, Variable Annuity, Indexed Annuity. Used for product-level profitability analysis and segment reporting.',
    `reversal_date` DATE COMMENT 'The accounting date on which this journal entry will be or was automatically reversed. Populated only when reversal_indicator is True.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry is configured to automatically reverse in the subsequent accounting period. True = entry will auto-reverse, False = entry is permanent. Commonly used for accruals and deferrals.',
    `source_system` STRING COMMENT 'The upstream system or module that originated this journal entry. Examples include Policy Administration System, Claims Management System, Billing System, Actuarial Valuation System, Investment Management System, or Manual Entry for finance-initiated entries.',
    `sox_control_reference` STRING COMMENT 'Reference to the SOX internal control that governs this journal entry. Used to document control testing, segregation of duties, and audit evidence for SOX 404 compliance. Examples: JE-001 (Standard Entries), JE-002 (Manual Adjusting Entries), JE-003 (Management Review Entries).',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the journal entry record was last modified. Used for audit trails, change tracking, and data quality monitoring.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Captures all double-entry accounting journal entries posted to the general ledger. Includes entries for premium revenue recognition, DAC amortization, reserve movements, claim payments, commission accruals, investment income, intercompany settlements, and period-end adjusting entries. Tracks SAP vs. GAAP basis, IFRS 17 measurement model (GMM/PAA/VFA), posting period, reversal indicators, SOX control reference, and preparer/approver workflow for financial close. Supports LDTI transition adjustments and PBR reserve entries.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for the journal entry line product.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: journal_entry_line has gl_account_code (STRING) but should FK to chart_of_accounts for referential integrity and to retrieve account metadata via JOIN. gl_account_name is redundant and can be retrieve',
    `claim_id` BIGINT COMMENT 'Reference to the specific claim associated with this journal entry line, if applicable. Links claim payments and reserves to general ledger entries.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: journal_entry_line has cost_center_code (STRING) and should FK to cost_center. Line-level cost center allocation is standard for expense management; FK enables cost center reporting and variance analy',
    `dac_asset_id` BIGINT COMMENT 'Reference to the DAC asset record if this journal entry line relates to deferred acquisition cost capitalization or amortization under GAAP or LDTI.',
    `ifrs17_contract_group_id` BIGINT COMMENT 'Reference to the IFRS 17 insurance contract group for entities reporting under IFRS 17. Links journal entries to contractual service margin (CSM) and liability for remaining coverage (LRC) calculations.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the specific insurance policy or annuity contract associated with this journal entry line, if applicable. Enables drill-down from financial statements to policy-level detail.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_invoice. Business justification: Line-level journal entries need direct reference to source vendor invoices for detailed audit trail, expense substantiation, and external audit support. Required for SOX compliance and financial state',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header that contains this line item. Links line-level detail to the header-level journal entry.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: journal_entry_line has legal_entity_code (STRING) and should FK to legal_entity. Line-level legal entity is required for intercompany entries where different lines post to different legal entities; FK',
    `employee_id` BIGINT COMMENT 'User identifier of the person who approved this journal entry line. Supports SOX audit trail and segregation of duties requirements.',
    `reinsurance_treaty_id` BIGINT COMMENT 'Reference to the reinsurance treaty associated with this journal entry line, if applicable. Tracks ceded and assumed reinsurance transactions.',
    `reversed_line_journal_entry_line_id` BIGINT COMMENT 'Reference to the original journal entry line that this entry reverses, if applicable. Creates audit trail for corrections and reversals.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Individual GL line items require specific supporting documents (invoices, contracts, actuarial reports) for substantiation during account reconciliation and variance investigation. Auditors trace line',
    `tertiary_journal_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified this journal entry line. Tracks changes for audit and control purposes.',
    `accounting_standard` STRING COMMENT 'The accounting standard under which this journal entry line is recorded: GAAP (Generally Accepted Accounting Principles), SAP (Statutory Accounting Principles), or IFRS (International Financial Reporting Standards).. Valid values are `GAAP|SAP|IFRS`',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the reason for adjusting or correcting journal entries. Supports audit trail and management reporting on financial statement adjustments.',
    `approval_status` STRING COMMENT 'Current approval status of this journal entry line within the financial close workflow. Ensures proper authorization controls per SOX requirements.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry line was approved. Part of the SOX-compliant audit trail for financial close process.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry line record was first created in the system. Part of the complete audit trail.',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this line item is a debit or credit entry. Fundamental accounting classification for double-entry bookkeeping.. Valid values are `debit|credit`',
    `effective_date` DATE COMMENT 'The business effective date of the underlying transaction. May differ from posting date for backdated or future-dated transactions.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate used to convert functional currency amount to reporting currency amount. Null if functional and reporting currencies are the same.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The monetary amount of this journal entry line in the functional currency of the legal entity. This is the primary amount used for statutory and GAAP reporting.',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the functional currency in which the amount is recorded (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this line item is posted. Represents the specific account in the chart of accounts (e.g., asset, liability, revenue, expense account).',
    `intercompany_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry line represents an intercompany transaction that must be eliminated during consolidation.',
    `intercompany_partner_code` STRING COMMENT 'Code identifying the intercompany partner legal entity for intercompany transactions. Used for intercompany reconciliation and elimination entries.',
    `journal_entry_type` STRING COMMENT 'Classification of the journal entry type: standard (routine operational entries), adjusting (period-end adjustments), closing (year-end closing entries), reversing (entries that reverse in the next period), reclassification (reclassifying between accounts), or elimination (intercompany elimination entries).. Valid values are `standard|adjusting|closing|reversing|reclassification|elimination`',
    `journal_source_system` STRING COMMENT 'The source system or module that originated this journal entry line (e.g., policy administration, claims, billing, actuarial, investment management). Enables source system reconciliation and audit trail.',
    `line_description` STRING COMMENT 'Detailed textual description of the business purpose and nature of this journal entry line item. Provides context for financial statement users and auditors.',
    `line_number` STRING COMMENT 'Sequential line number within the journal entry. Determines the ordering and display sequence of line items within a single journal entry.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry line record was last modified. Enables change tracking and audit trail.',
    `posting_date` DATE COMMENT 'The accounting date on which this journal entry line was posted to the general ledger. Determines the financial reporting period in which the transaction is recognized.',
    `product_line_code` STRING COMMENT 'Code identifying the insurance product line (e.g., term life, whole life, universal life, annuities) to which this transaction relates. Enables product-level profitability analysis.',
    `reinsurance_indicator` STRING COMMENT 'Indicates whether this transaction represents direct business, ceded reinsurance, or assumed reinsurance. Critical for statutory reporting and reinsurance recoverables tracking.. Valid values are `direct|ceded|assumed`',
    `reporting_currency_amount` DECIMAL(18,2) COMMENT 'The monetary amount of this journal entry line translated into the reporting currency for consolidated financial reporting purposes.',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the reporting currency for consolidated financial statements (typically the parent company currency).. Valid values are `^[A-Z]{3}$`',
    `reversal_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry line is a reversal of a previous entry. Used to track corrections and adjustments.',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry line is subject to SOX internal control testing and certification requirements.',
    `transaction_reference_number` STRING COMMENT 'Reference number or identifier from the source transaction system that originated this journal entry line. Enables drill-back to source transaction detail.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit and credit line items within a journal entry. Captures account code, cost center, legal entity, product line, debit/credit amount in functional and reporting currency, IFRS 17 insurance contract group reference, reinsurance ceded/assumed indicator, and intercompany elimination flag. Enables granular drill-down from financial statements to source transactions. Supports multi-currency translation and FX revaluation entries.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the chart of accounts entry. Primary key for the chart of accounts master reference.',
    `account_code` STRING COMMENT 'The unique alphanumeric code identifying the general ledger account. This is the externally-known business identifier used in all financial transactions and reporting.. Valid values are `^[A-Z0-9]{4,20}$`',
    `account_name` STRING COMMENT 'The full descriptive name of the general ledger account. Human-readable label used in financial statements and reports.',
    `account_subtype` STRING COMMENT 'Secondary classification providing additional granularity within the account type (e.g., current asset, fixed asset, long-term liability, operating expense).',
    `account_type` STRING COMMENT 'The fundamental accounting classification of the account. Determines the accounts position in the balance sheet or income statement and its behavior in the accounting equation.. Valid values are `asset|liability|equity|revenue|expense|contra`',
    `approval_required_indicator` BOOLEAN COMMENT 'Flag indicating whether changes to this account definition require formal approval workflow due to materiality, regulatory impact, or SOX controls.',
    `budget_indicator` BOOLEAN COMMENT 'Flag indicating whether this account participates in the annual budgeting process and budget vs. actual variance reporting.',
    `cash_flow_statement_category` STRING COMMENT 'The section of the cash flow statement (operating, investing, or financing activities) where transactions in this account are classified.. Valid values are `operating|investing|financing`',
    `chart_of_accounts_description` STRING COMMENT 'Extended business description of the accounts purpose, usage guidelines, and the types of transactions that should be posted to this account.',
    `chart_of_accounts_status` STRING COMMENT 'Current lifecycle status of the chart of accounts entry. Active accounts are available for posting; inactive accounts are retained for historical reporting but closed to new transactions.. Valid values are `active|inactive|pending|closed`',
    `cost_center_required_indicator` BOOLEAN COMMENT 'Flag indicating whether a cost center dimension is required when posting transactions to this account for expense tracking and allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this chart of accounts entry was first created in the system. Supports audit trail and change management.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for accounts denominated in a specific currency. Null for accounts that aggregate multi-currency balances.. Valid values are `^[A-Z]{3}$`',
    `dac_eligible_indicator` BOOLEAN COMMENT 'Flag indicating whether this account is eligible for deferred acquisition cost (DAC) asset tracking and amortization under insurance accounting standards.',
    `effective_date` DATE COMMENT 'The date when this account became active and available for use in the general ledger. Supports chart of accounts change management and historical analysis.',
    `expiration_date` DATE COMMENT 'The date when this account was or will be inactivated and closed to new postings. Null for accounts that remain active indefinitely.',
    `external_reporting_code` STRING COMMENT 'The mapping code used to translate this internal account to external regulatory reporting formats (NAIC Annual Statement, SEC 10-K, state insurance department filings).',
    `financial_statement_line` STRING COMMENT 'The specific line item on the financial statement (balance sheet, income statement, cash flow statement) where this accounts balance is reported.',
    `gaap_classification` STRING COMMENT 'The classification of this account under US GAAP for external financial reporting and SEC filings.',
    `hierarchy_level` STRING COMMENT 'The depth level of this account in the chart of accounts hierarchy. Level 1 represents top-level summary accounts; higher numbers represent more detailed sub-accounts.',
    `ifrs17_classification` STRING COMMENT 'The classification of this account under IFRS 17 insurance contracts standard for international financial reporting. Includes insurance finance income/expense designation.',
    `intercompany_indicator` BOOLEAN COMMENT 'Flag indicating whether this account is used for intercompany transactions requiring elimination in consolidated financial statements.',
    `ldti_indicator` BOOLEAN COMMENT 'Flag indicating whether this account is impacted by FASB ASC 944 Long Duration Targeted Improvements (LDTI) accounting standard changes effective 2023.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified this chart of accounts entry. Supports audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this chart of accounts entry was last modified. Supports audit trail and change management.',
    `normal_balance` STRING COMMENT 'Indicates whether the account normally carries a debit or credit balance. Assets and expenses typically have debit balances; liabilities, equity, and revenue have credit balances.. Valid values are `debit|credit`',
    `parent_account_code` STRING COMMENT 'The account code of the parent account in the chart of accounts hierarchy. Used to build roll-up structures for financial reporting and consolidation.',
    `posting_allowed_indicator` BOOLEAN COMMENT 'Flag indicating whether direct journal entry postings are allowed to this account. Summary accounts typically do not allow direct posting.',
    `product_line_required_indicator` BOOLEAN COMMENT 'Flag indicating whether a product line dimension is required when posting transactions to this account for product profitability analysis.',
    `rbc_line_mapping` STRING COMMENT 'The specific line item on the NAIC Risk-Based Capital calculation where this accounts balance is reported for regulatory capital adequacy assessment.',
    `reconciliation_frequency` STRING COMMENT 'The required frequency for formal reconciliation of this account balance to supporting documentation or sub-ledgers.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `reconciliation_required_indicator` BOOLEAN COMMENT 'Flag indicating whether this account requires formal balance sheet reconciliation as part of the monthly or quarterly financial close process.',
    `rollup_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a summary/rollup account that aggregates balances from child accounts, or a detail/posting account that receives direct journal entries.',
    `sap_classification` STRING COMMENT 'The classification of this account under NAIC Statutory Accounting Principles for regulatory financial reporting to state insurance departments.',
    `sox_control_indicator` BOOLEAN COMMENT 'Flag indicating whether this account is subject to enhanced Sarbanes-Oxley Act (SOX) internal controls and audit procedures due to materiality or risk.',
    `tax_reporting_category` STRING COMMENT 'The classification of this account for federal and state tax return preparation and IRS reporting under IRC Section 7702 and other tax regulations.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this chart of accounts entry. Supports audit trail and accountability.',
    CONSTRAINT pk_chart_of_accounts PRIMARY KEY(`chart_of_accounts_id`)
) COMMENT 'Master reference for the enterprise chart of accounts hierarchy. Defines account codes, account names, account type (asset, liability, equity, revenue, expense, contra), normal balance (debit/credit), financial statement line mapping, SAP vs. GAAP classification, IFRS 17 insurance finance income/expense designation, RBC line mapping, and account active/inactive status. Governs all COA governance and change management processes.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center. Primary key for the cost center master entity.',
    `org_unit_id` BIGINT COMMENT 'Reference to the business unit or division that owns this cost center. Used for management reporting and segment analysis.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: cost_center has gl_account_code (STRING) representing the default GL account for postings to this cost center. FK to chart_of_accounts provides referential integrity for expense allocation rules.',
    `distribution_channel_id` BIGINT COMMENT 'Reference to the distribution channel associated with this cost center. Used for channel profitability and commission expense tracking. Null for non-distribution cost centers.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or manager responsible for budget management and expense approval for this cost center.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity to which this cost center belongs. Required for statutory reporting and intercompany settlement.',
    `parent_cost_center_id` BIGINT COMMENT 'Reference to the parent cost center in the organizational hierarchy. Supports roll-up reporting and hierarchical expense allocation. Null for top-level cost centers.',
    `product_line_id` BIGINT COMMENT 'Reference to the product line associated with this cost center. Used for product profitability analysis and management reporting. Null for shared service cost centers.',
    `queue_id` BIGINT COMMENT 'Foreign key linking to correspondence.correspondence_queue. Business justification: Cost centers own correspondence queues for expense allocation, budgeting, and operational management. Customer service departments are cost centers managing queues. Essential for operational expense t',
    `allocation_basis` STRING COMMENT 'The basis used for allocating expenses from this cost center to other cost centers or products. Determines the driver for expense distribution in management accounting.. Valid values are `headcount|premium_volume|policy_count|aum|square_footage|direct`',
    `allocation_method` STRING COMMENT 'The method used for allocating expenses from this cost center. Direct assigns to final cost objects; step-down cascades through service centers; reciprocal handles mutual services; activity-based uses cost drivers.. Valid values are `direct|step_down|reciprocal|activity_based`',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total annual budget allocated to this cost center for the current fiscal year. Used for budget vs. actual variance reporting.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget amount. Supports multi-currency budget management.. Valid values are `^[A-Z]{3}$`',
    `budget_entity_flag` BOOLEAN COMMENT 'Indicates whether this cost center is a budget-holding entity with its own budget allocation and variance tracking. True if budget is assigned at this level.',
    `cost_center_code` STRING COMMENT 'Business identifier code for the cost center used in financial reporting and general ledger posting. Externally visible code used across financial systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `cost_center_description` STRING COMMENT 'Detailed description of the cost centers purpose, scope, and responsibilities within the organizational structure.',
    `cost_center_name` STRING COMMENT 'Full descriptive name of the cost center for reporting and identification purposes.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Only active cost centers accept expense postings.. Valid values are `active|inactive|pending|closed`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by functional category. Determines expense allocation rules and reporting hierarchy.. Valid values are `operational|administrative|distribution|product|investment|claims`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost center record was first created in the system. Used for audit trail and data lineage.',
    `dac_eligible_flag` BOOLEAN COMMENT 'Indicates whether expenses posted to this cost center are eligible for deferral as acquisition costs under GAAP ASC 944 and LDTI standards. True if DAC-eligible.',
    `effective_date` DATE COMMENT 'Date from which this cost center becomes active and can accept expense postings. Start of the cost centers validity period.',
    `expiration_date` DATE COMMENT 'Date on which this cost center becomes inactive and no longer accepts expense postings. Null for cost centers with no planned end date.',
    `external_reporting_code` STRING COMMENT 'Code used for external regulatory and statutory reporting to NAIC, SEC, or other governing bodies. May differ from internal cost center code.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the budget amount is applicable. Four-digit year (e.g., 2024).',
    `gaap_expense_category` STRING COMMENT 'GAAP financial statement expense category for this cost center. Used for ASC 944 and LDTI reporting.',
    `gl_account_code` STRING COMMENT 'Default general ledger account code associated with this cost center for expense posting. Used in chart of accounts mapping.. Valid values are `^[0-9]{4,10}$`',
    `hierarchy_level` STRING COMMENT 'Numeric level of this cost center in the organizational hierarchy. Level 1 is top-level, increasing numbers indicate deeper nesting. Used for roll-up reporting.',
    `intercompany_settlement_flag` BOOLEAN COMMENT 'Indicates whether expenses from this cost center require intercompany settlement and elimination entries. True if intercompany settlement applies.',
    `notes` STRING COMMENT 'Free-text notes and comments about the cost center for internal reference and documentation purposes.',
    `rbc_category` STRING COMMENT 'NAIC Risk-Based Capital category for expenses from this cost center. Used in RBC calculation and capital adequacy reporting.. Valid values are `c1|c2|c3|c4|not_applicable`',
    `sap_expense_exhibit` STRING COMMENT 'NAIC Annual Statement expense exhibit line item to which expenses from this cost center are reported for statutory accounting purposes.',
    `sox_controlled_flag` BOOLEAN COMMENT 'Indicates whether this cost center is subject to SOX internal control requirements for financial close and reporting. True if SOX-controlled.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost center record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Master entity for enterprise cost center management and expense allocation. Defines organizational cost centers aligned to business units, functional departments, product lines, and distribution channels. Captures cost center code, description, responsible manager, parent cost center hierarchy, allocation basis (headcount, premium volume, policy count, AUM), allocation method (direct, step-down, reciprocal), budget entity flag, legal entity assignment, and effective date range. Supports expense allocation rule definition, budget vs. actual variance reporting, management reporting by organizational unit, product profitability analysis, and statutory expense exhibit reporting to NAIC.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity within the insurance holding company structure. Primary key.',
    `parent_legal_entity_id` BIGINT COMMENT 'Reference to the immediate parent legal entity in the holding company organizational hierarchy. Null for the ultimate parent holding company.',
    `primary_ultimate_parent_entity_legal_entity_id` BIGINT COMMENT 'Reference to the top-level parent entity in the holding company structure for consolidated reporting purposes.',
    `am_best_rating` STRING COMMENT 'Current A.M. Best financial strength rating assigned to the entity, if applicable. Uses A.M. Best rating scale (e.g., A++, A+, A, A-, B++, etc.).',
    `am_best_rating_date` DATE COMMENT 'The effective date of the current A.M. Best financial strength rating.',
    `consolidation_method` STRING COMMENT 'The accounting method used to consolidate this entity into the parent holding company financial statements.. Valid values are `full|proportional|equity_method|not_consolidated`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this legal entity record was first created in the system.',
    `domicile_country` STRING COMMENT 'Three-letter ISO country code representing the country of domicile for the legal entity.. Valid values are `^[A-Z]{3}$`',
    `domicile_state` STRING COMMENT 'The state or jurisdiction where the entity is legally domiciled and subject to primary regulatory oversight. Uses two-letter state code for US states or jurisdiction name for non-US entities.',
    `effective_date` DATE COMMENT 'The date from which this legal entity record became effective in the enterprise system of record.',
    `entity_status` STRING COMMENT 'Current operational and legal status of the entity within the holding company structure.. Valid values are `active|inactive|dissolved|merged|in_runoff|suspended`',
    `entity_type` STRING COMMENT 'Classification of the legal entity based on its primary business function within the holding company structure.. Valid values are `life_insurer|holding_company|reinsurer|broker_dealer|service_company|investment_subsidiary`',
    `fein` STRING COMMENT 'Federal Employer Identification Number (also known as Taxpayer Identification Number or TIN) issued by the IRS for tax reporting purposes.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `finra_member_flag` BOOLEAN COMMENT 'Indicates whether this entity is a FINRA member broker-dealer subject to FINRA oversight and compliance requirements.',
    `functional_currency` STRING COMMENT 'Three-letter ISO currency code representing the primary currency in which the entity conducts its business operations and maintains its books and records.. Valid values are `^[A-Z]{3}$`',
    `gaap_reporting_entity_flag` BOOLEAN COMMENT 'Indicates whether this entity prepares standalone GAAP financial statements or is included only in consolidated GAAP reporting.',
    `ifrs17_reporting_entity_flag` BOOLEAN COMMENT 'Indicates whether this entity is subject to IFRS 17 insurance contracts accounting standard for international financial reporting.',
    `incorporation_date` DATE COMMENT 'The date on which the legal entity was incorporated or established under applicable law.',
    `intercompany_elimination_group` STRING COMMENT 'Code identifying the group of entities for which intercompany transactions and balances must be eliminated during consolidation.',
    `legal_entity_name` STRING COMMENT 'The full legal name of the entity as registered with regulatory authorities and appearing on statutory filings.',
    `lei_code` STRING COMMENT '20-character alphanumeric Legal Entity Identifier code issued by a Local Operating Unit under the Global LEI System for financial transaction reporting and regulatory compliance.. Valid values are `^[A-Z0-9]{20}$`',
    `lei_registration_date` DATE COMMENT 'The date on which the LEI code was initially registered for this entity.',
    `lei_renewal_date` DATE COMMENT 'The date by which the LEI code must be renewed to maintain active status.',
    `license_effective_date` DATE COMMENT 'The date on which the regulatory license or certificate of authority became effective.',
    `license_expiration_date` DATE COMMENT 'The date on which the regulatory license or certificate of authority expires, if applicable.',
    `naic_company_code` STRING COMMENT 'Five-digit NAIC company code assigned by the National Association of Insurance Commissioners for statutory reporting and regulatory identification.. Valid values are `^[0-9]{5}$`',
    `primary_regulator` STRING COMMENT 'Name of the primary regulatory body with oversight authority over this entity (e.g., state insurance department, SEC, FINRA).',
    `rbc_filing_entity_flag` BOOLEAN COMMENT 'Indicates whether this entity is required to file Risk-Based Capital reports with state insurance regulators.',
    `registered_address_line1` STRING COMMENT 'First line of the legal registered address of the entity as filed with regulatory authorities.',
    `registered_address_line2` STRING COMMENT 'Second line of the legal registered address (suite, floor, building name, etc.).',
    `registered_city` STRING COMMENT 'City of the legal registered address.',
    `registered_country` STRING COMMENT 'Three-letter ISO country code of the legal registered address.. Valid values are `^[A-Z]{3}$`',
    `registered_postal_code` STRING COMMENT 'Postal or ZIP code of the legal registered address.',
    `registered_state` STRING COMMENT 'State or province of the legal registered address.',
    `regulatory_license_number` STRING COMMENT 'Primary license or certificate of authority number issued by the domicile state or primary regulator.',
    `reporting_currency` STRING COMMENT 'Three-letter ISO currency code representing the currency used for external financial reporting and regulatory filings.. Valid values are `^[A-Z]{3}$`',
    `sap_reporting_entity_flag` BOOLEAN COMMENT 'Indicates whether this entity is required to prepare statutory financial statements under SAP for state insurance department filing.',
    `sec_registrant_flag` BOOLEAN COMMENT 'Indicates whether this entity is registered with the SEC and subject to SEC reporting requirements for variable products or as a publicly traded entity.',
    `short_name` STRING COMMENT 'Abbreviated or common name used for internal reporting and operational reference.',
    `sox_scope_entity_flag` BOOLEAN COMMENT 'Indicates whether this entity is within the scope of SOX internal control testing and certification requirements.',
    `termination_date` DATE COMMENT 'The date on which the legal entity ceased operations, was dissolved, or was merged into another entity. Null for active entities.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this legal entity record was last modified in the system.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master record for all legal entities within the insurance holding company structure. Captures legal entity name, domicile state/jurisdiction, NAIC company code, FEIN/TIN, entity type (life insurer, holding company, reinsurer, broker-dealer, service company), state of domicile, RBC filing entity flag, SEC registrant flag, FINRA member flag, intercompany elimination group, consolidation method (full, proportional, equity method), and functional currency. Supports statutory filing by entity, GAAP consolidation hierarchy, intercompany settlement and elimination, and regulatory capital reporting. Serves as the reference master for all finance products requiring legal entity context.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`dac_asset` (
    `dac_asset_id` BIGINT COMMENT 'Unique identifier for the DAC asset record. Primary key for the DAC asset entity.',
    `assumption_set_id` BIGINT COMMENT 'Reference to the actuarial assumption set used for DAC amortization calculations, including mortality, lapse, expense, and interest rate assumptions.',
    `cohort_definition_id` BIGINT COMMENT 'Reference to the LDTI cohort grouping for DAC amortization purposes. Cohorts are defined by product line, issue year, and underwriting characteristics.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy or policy cohort to which this DAC asset is associated.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: dac_asset has legal_entity_code (STRING) and should FK to legal_entity. DAC assets are owned by legal entities; FK is essential for statutory reporting, RBC calculations, and consolidation.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: DAC assets are capitalized and amortized by product for GAAP reporting. Required for LDTI cohort tracking, financial statement preparation, and product profitability analysis. Links DAC balance to spe',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: DAC calculations require retention of original policy illustrations, commission schedules, and actuarial memoranda per GAAP/LDTI requirements. Annual DAC amortization audits and assumption change docu',
    `valuation_run_id` BIGINT COMMENT 'Reference to the actuarial valuation run that produced this DAC asset position and amortization schedule.',
    `accounting_period` STRING COMMENT 'Accounting period (YYYY-MM) for which this DAC asset position and amortization are recorded.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `actual_amortization_amount` DECIMAL(18,2) COMMENT 'Actual amortization expense recognized in the current accounting period. May differ from scheduled due to experience adjustments, policy lapses, or surrenders.',
    `amortization_method` STRING COMMENT 'Method used to amortize the DAC asset. GAAP Interest-Related follows pre-LDTI guidance; LDTI Straight-Line follows ASU 2018-12; IFRS 17 CSM-Based follows IFRS 17 insurance acquisition cash flow guidance.. Valid values are `GAAP Interest-Related|LDTI Straight-Line|IFRS 17 CSM-Based|Other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DAC asset record was first created in the system.',
    `cumulative_amortization_balance` DECIMAL(18,2) COMMENT 'Total cumulative amortization recognized from policy issuance through the current accounting period.',
    `dac_asset_status` STRING COMMENT 'Current lifecycle status of the DAC asset. Active indicates ongoing amortization; Fully Amortized indicates complete amortization; Impaired indicates recognized impairment; Terminated indicates policy lapse or surrender.. Valid values are `Active|Fully Amortized|Impaired|Terminated|Under Review`',
    `dac_capitalized_amount` DECIMAL(18,2) COMMENT 'Total amount of acquisition costs capitalized as a DAC asset at policy issuance or acquisition. Includes commissions, underwriting costs, policy issuance expenses, and other directly attributable costs.',
    `effective_date` DATE COMMENT 'Date on which this DAC asset record became effective, typically the policy issue date or acquisition date.',
    `external_audit_reviewed_flag` BOOLEAN COMMENT 'Flag indicating whether this DAC asset has been reviewed by external auditors in the current audit cycle.',
    `gaap_reporting_basis` STRING COMMENT 'Accounting reporting basis under which this DAC asset is recorded. US GAAP follows FASB ASC 944; IFRS follows IFRS 17; Statutory follows NAIC SAP.. Valid values are `US GAAP|IFRS|Statutory|Other`',
    `ifrs17_acquisition_cash_flow_asset` DECIMAL(18,2) COMMENT 'Insurance acquisition cash flow asset recognized under IFRS 17 for acquisition costs directly attributable to a group of insurance contracts.',
    `ifrs17_acquisition_cash_flow_release` DECIMAL(18,2) COMMENT 'Amount of insurance acquisition cash flow asset released to profit or loss in the current period under IFRS 17.',
    `impairment_indicator_flag` BOOLEAN COMMENT 'Flag indicating whether an impairment indicator exists for this DAC asset. True if adverse experience, policy lapses, or other factors suggest the asset may not be recoverable.',
    `impairment_loss_amount` DECIMAL(18,2) COMMENT 'Impairment loss recognized in the current period if the DAC asset is determined to be unrecoverable.',
    `interest_accretion_amount` DECIMAL(18,2) COMMENT 'Interest accretion recognized on the DAC asset balance for the current period under interest-related amortization methods.',
    `issue_year` STRING COMMENT 'Calendar year in which the underlying policies were issued. Used for cohort grouping and amortization tracking.',
    `last_amortization_date` DATE COMMENT 'Date of the most recent amortization transaction for this DAC asset.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this DAC asset record was last modified.',
    `ldti_cohort_grouping_key` STRING COMMENT 'Composite key identifying the LDTI cohort grouping for this DAC asset. Cohorts are defined by product type, issue year, underwriting class, and other contract characteristics.',
    `product_line_code` STRING COMMENT 'Code identifying the product line (e.g., Term Life, Whole Life, Universal Life, Variable Annuity) to which this DAC asset belongs.',
    `reconciliation_status` STRING COMMENT 'Status of the actuarial-to-finance reconciliation for this DAC asset. Reconciled indicates agreement between actuarial and finance systems; Variance Identified indicates discrepancies requiring resolution.. Valid values are `Reconciled|Pending|Variance Identified|Under Investigation`',
    `scheduled_amortization_amount` DECIMAL(18,2) COMMENT 'Planned or scheduled amortization amount for the current accounting period based on the amortization method and actuarial assumptions.',
    `shadow_dac_adjustment` DECIMAL(18,2) COMMENT 'Shadow DAC adjustment for unrealized gains or losses on available-for-sale securities or other comprehensive income items that affect DAC amortization under GAAP.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this DAC asset record originated (e.g., actuarial valuation system, policy administration system, general ledger).',
    `sox_control_flag` BOOLEAN COMMENT 'Flag indicating whether this DAC asset is subject to SOX financial reporting controls. True for material DAC balances requiring enhanced audit and control procedures.',
    `termination_date` DATE COMMENT 'Date on which this DAC asset was fully amortized, impaired, or terminated due to policy lapse or surrender. Null if still active.',
    `unamortized_dac_balance` DECIMAL(18,2) COMMENT 'Remaining unamortized DAC asset balance as of the accounting period end. Calculated as capitalized amount minus cumulative amortization.',
    `variance_from_prior_period` DECIMAL(18,2) COMMENT 'Variance in unamortized DAC balance from the prior accounting period. Calculated as current period unamortized balance minus prior period unamortized balance.',
    `voba_amortization_amount` DECIMAL(18,2) COMMENT 'Amortization expense recognized in the current period for the VOBA component of the DAC asset.',
    `voba_component_amount` DECIMAL(18,2) COMMENT 'Value of Business Acquired component included in the DAC asset, arising from business combinations or block acquisitions. Amortized separately from internally generated DAC.',
    CONSTRAINT pk_dac_asset PRIMARY KEY(`dac_asset_id`)
) COMMENT 'SSOT for Deferred Acquisition Cost (DAC) assets and all periodic amortization transactions by policy cohort, product line, issue year, legal entity, and accounting period. Captures DAC capitalized amount, amortization method (GAAP interest-related vs. LDTI straight-line), scheduled and actual periodic amortization amounts, cumulative amortization balance, unamortized DAC balance, VOBA (Value of Business Acquired) component and amortization, shadow DAC adjustment for unrealized gains/losses, IFRS 17 insurance acquisition cash flow asset and release, interest accretion, DAC impairment indicators, LDTI cohort grouping, and variance from prior period. Owns both the asset position and the transactional amortization history. Supports FASB ASC 944 / LDTI DAC amortization schedules, IFRS 17 acquisition cost reporting, and actuarial-to-finance reconciliation.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`dac_amortization` (
    `dac_amortization_id` BIGINT COMMENT 'Primary key for dac_amortization',
    `valuation_run_id` BIGINT COMMENT 'Reference to the actuarial valuation run that produced the amortization schedule and assumptions used for this DAC amortization calculation.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: dac_amortization has gl_account_code (STRING) and should FK to chart_of_accounts. Amortization entries post to specific GL accounts; FK is essential for financial statement mapping and audit trail.',
    `cohort_definition_id` BIGINT COMMENT 'Reference to the LDTI cohort grouping for this DAC amortization. Cohorts group contracts issued in the same year with similar characteristics per FASB ASC 944 LDTI requirements.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: dac_amortization has cost_center_code (STRING) and should FK to cost_center. Amortization is allocated to cost centers for expense management; FK is essential for cost allocation and variance analysis',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the insurance policy associated with this DAC amortization entry.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: dac_amortization has journal_entry_number (STRING) representing the JE that posted the amortization. FK to journal_entry provides critical audit trail linking actuarial calculation to financial postin',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: DAC amortization schedules are product-specific under LDTI rules. Required for quarterly financial close, variance analysis by product, and actuarial assumption review. Links amortization expense to p',
    `accounting_period` STRING COMMENT 'The accounting period (YYYY-MM format) for which this DAC amortization entry is recorded.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `actual_amortization_amount` DECIMAL(18,2) COMMENT 'The actual DAC amortization amount posted to the general ledger for this period. May differ from scheduled due to true-ups or adjustments.',
    `adjustment_description` STRING COMMENT 'Detailed narrative description of the reason for any adjustment or variance from scheduled amortization, providing audit trail and business context.',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the reason for this DAC amortization entry. Scheduled entries are routine periodic amortization; other codes indicate adjustments or corrections.. Valid values are `scheduled|true_up|assumption_change|cohort_reclass|error_correction|policy_termination`',
    `amortization_date` DATE COMMENT 'The specific date on which the DAC amortization was posted to the general ledger.',
    `amortization_method` STRING COMMENT 'The method used to calculate DAC amortization for this entry. Common methods include straight-line, proportional to premium revenue, proportional to estimated gross profits (EGP), or proportional to estimated gross margin.. Valid values are `straight_line|proportional_to_premium|proportional_to_egp|proportional_to_margin`',
    `approval_status` STRING COMMENT 'The approval workflow status of this DAC amortization entry. Entries must be approved before posting to the general ledger per SOX controls.. Valid values are `draft|pending_review|approved|posted|rejected`',
    `approved_by` STRING COMMENT 'The user ID or name of the finance manager or controller who approved this DAC amortization entry for posting.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this DAC amortization entry was approved for posting to the general ledger.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this DAC amortization record was first created in the system.',
    `cumulative_amortization_balance` DECIMAL(18,2) COMMENT 'The total cumulative DAC amortization balance from policy inception through the current period. Represents the total amount of DAC that has been expensed to date.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts in this DAC amortization record.. Valid values are `^[A-Z]{3}$`',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1-4) to which this DAC amortization entry belongs, used for quarterly financial reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this DAC amortization entry belongs, used for annual financial reporting and budget tracking.',
    `gaap_amortization_amount` DECIMAL(18,2) COMMENT 'The DAC amortization amount calculated under GAAP accounting standards (FASB ASC 944), used for financial statement reporting.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this DAC amortization expense is posted. Typically an expense account in the chart of accounts.. Valid values are `^[0-9]{4,10}$`',
    `ifrs17_amortization_amount` DECIMAL(18,2) COMMENT 'The insurance acquisition cash flow amortization amount under IFRS 17 accounting standard, representing the release of acquisition costs allocated to the contractual service margin.',
    `interest_accretion_amount` DECIMAL(18,2) COMMENT 'The interest accretion component applied to the DAC asset balance for this period, representing the time value of money on deferred costs.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this DAC amortization record was last modified or updated.',
    `posted_timestamp` TIMESTAMP COMMENT 'The date and time when this DAC amortization entry was successfully posted to the general ledger system.',
    `product_line` STRING COMMENT 'The insurance product line category for which this DAC amortization applies. Different product lines may have different amortization patterns and regulatory treatment. [ENUM-REF-CANDIDATE: term_life|whole_life|universal_life|variable_universal_life|indexed_universal_life|fixed_annuity|variable_annuity|fixed_indexed_annuity — 8 candidates stripped; promote to reference product]',
    `remaining_dac_balance` DECIMAL(18,2) COMMENT 'The unamortized DAC asset balance remaining on the balance sheet after this periods amortization. Calculated as original DAC less cumulative amortization.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this DAC amortization entry is a reversal of a prior period entry. True if this is a reversal transaction, False otherwise.',
    `sap_amortization_amount` DECIMAL(18,2) COMMENT 'The DAC amortization amount calculated under Statutory Accounting Principles for regulatory reporting to state insurance departments. SAP typically expenses acquisition costs immediately rather than deferring them.',
    `scheduled_amortization_amount` DECIMAL(18,2) COMMENT 'The planned or scheduled DAC amortization amount for this period based on actuarial projections and amortization schedules.',
    `shadow_dac_adjustment` DECIMAL(18,2) COMMENT 'Adjustment to DAC amortization for unrealized gains or losses on investments backing insurance liabilities, ensuring consistency between asset and liability measurement under shadow accounting principles.',
    `source_system` STRING COMMENT 'The name of the source system that generated this DAC amortization entry (e.g., actuarial valuation system, policy administration system, or manual entry).',
    `variance_from_prior_period` DECIMAL(18,2) COMMENT 'The difference between current period actual amortization and prior period actual amortization, used for trend analysis and variance reporting.',
    `voba_amortization_amount` DECIMAL(18,2) COMMENT 'The amortization amount for Value of Business Acquired intangible asset, tracked separately from DAC but often managed in parallel for acquired blocks of business.',
    CONSTRAINT pk_dac_amortization PRIMARY KEY(`dac_amortization_id`)
) COMMENT 'Transactional record of periodic DAC amortization entries by cohort and accounting period. Captures scheduled amortization amount, actual amortization posted, cumulative amortization balance, LDTI cohort grouping, interest accretion component, shadow DAC adjustment, VOBA amortization, and variance from prior period. Supports FASB ASC 944 / LDTI DAC amortization schedules, IFRS 17 insurance acquisition cash flow release, and actuarial-to-finance reconciliation.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` (
    `statutory_reserve_id` BIGINT COMMENT 'Unique identifier for the statutory reserve record. Primary key for the statutory reserve entity.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy for which this statutory reserve is held. Links to the policy master record.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (insurance company) that holds this statutory reserve. Required for multi-entity consolidated reporting.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Statutory reserves are calculated by product for Annual Statement Exhibit 5 and RBC C2 insurance risk component. Required for regulatory reporting, reserve adequacy testing, and product profitability ',
    `employee_id` BIGINT COMMENT 'The user ID of the finance team member who created this statutory reserve record. Part of SOX-controlled audit trail.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Statutory reserves are calculated and valued for specific reporting periods. Required for NAIC Annual Statement preparation and quarterly statutory filings. Domain experts expect reserves to be period',
    `valuation_run_id` BIGINT COMMENT 'Reference to the actuarial valuation run that produced the reserve calculation handed off to finance for booking. Links to the actuarial domain source computation.',
    `actuarial_sign_off_date` DATE COMMENT 'The date when the appointed actuary signed off on the reserve calculation, certifying its adequacy and compliance with statutory requirements.',
    `amount` DECIMAL(18,2) COMMENT 'The total statutory reserve amount booked by finance for this policy cohort and reporting period, expressed in USD. This is the finance-booked position after actuarial hand-off and management sign-off.',
    `appointed_actuary_name` STRING COMMENT 'The name of the appointed actuary who certified the reserve adequacy for this reporting period. Required for NAIC actuarial opinion filing.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this reserve record to the audit trail documentation, including actuarial memorandum, management approval, and journal entry support. Required for external audit.',
    `booking_date` DATE COMMENT 'The date when the statutory reserve was booked in the general ledger by the finance team. Represents the official finance record date.',
    `carvm_reserve_amount` DECIMAL(18,2) COMMENT 'The CARVM reserve component for annuity contracts calculated using Commissioners Annuity Reserve Valuation Method. Null if not applicable to the product line.',
    `cohort_identifier` STRING COMMENT 'Identifier for the policy cohort grouping used for reserve aggregation. Cohorts are typically defined by issue year, product type, and underwriting class for reserve modeling purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this statutory reserve record was first created in the finance system. Part of the audit trail for record lineage.',
    `crvm_reserve_amount` DECIMAL(18,2) COMMENT 'The CRVM reserve component for life insurance policies calculated using Commissioners Reserve Valuation Method. Null if not applicable to the product line.',
    `cso_mortality_table_code` STRING COMMENT 'The CSO mortality table used for statutory reserve valuation. Values: 2017CSO (2017 Commissioners Standard Ordinary), 2001CSO (2001 CSO), 1980CSO (1980 CSO), 2012IAM (2012 Individual Annuity Mortality), CUSTOM (Custom approved table).. Valid values are `2017CSO|2001CSO|1980CSO|2012IAM|CUSTOM`',
    `deficiency_reserve_amount` DECIMAL(18,2) COMMENT 'Additional reserve held when the statutory reserve basis produces a reserve lower than the net premium reserve, ensuring reserve adequacy. Required under NAIC guidelines when deficiency exists.',
    `exhibit_line_number` STRING COMMENT 'The specific line number on the NAIC annual statement exhibit (Exhibit 5, 6, 7, or 8) where this reserve is reported. Used for regulatory filing reconciliation.',
    `gaap_reserve_amount` DECIMAL(18,2) COMMENT 'The reserve amount calculated under GAAP (FASB ASC 944) for financial statement reporting. Differs from statutory reserve due to different recognition and measurement principles.',
    `ifrs17_reserve_amount` DECIMAL(18,2) COMMENT 'The reserve amount calculated under IFRS 17 for international financial reporting. Applicable for companies reporting under IFRS standards.',
    `management_approval_date` DATE COMMENT 'The date when management approved the statutory reserve amount for booking in the general ledger. Part of the SOX-controlled financial close process.',
    `net_amount_at_risk` DECIMAL(18,2) COMMENT 'The net amount at risk (NAR) for life insurance policies, calculated as death benefit minus account value or cash surrender value. Represents the insurance companys exposure to mortality risk.',
    `net_statutory_reserve_amount` DECIMAL(18,2) COMMENT 'The net statutory reserve amount after reinsurance ceded, calculated as statutory_reserve_amount minus reinsurance_ceded_reserve_amount. This is the net position reported on the balance sheet.',
    `pbr_reserve_amount` DECIMAL(18,2) COMMENT 'The PBR reserve component calculated per VM-20 (life) or VM-21 (variable annuity) for policies subject to principle-based reserving. Null if policy is not subject to PBR.',
    `prior_period_reserve_amount` DECIMAL(18,2) COMMENT 'The statutory reserve amount from the prior reporting period for this same policy cohort. Used for reserve movement analysis and variance reporting.',
    `product_line_code` STRING COMMENT 'Code representing the product line for reserve segmentation. Values: WL (Whole Life), UL (Universal Life), IUL (Indexed Universal Life), VUL (Variable Universal Life), TERM (Term Life), SPIA (Single Premium Immediate Annuity), FIA (Fixed Indexed Annuity), VA (Variable Annuity), LTCI (Long-Term Care Insurance), DI (Disability Income). [ENUM-REF-CANDIDATE: WL|UL|IUL|VUL|TERM|SPIA|FIA|VA|LTCI|DI — 10 candidates stripped; promote to reference product]',
    `rbc_contribution_amount` DECIMAL(18,2) COMMENT 'The contribution of this reserve to the companys Risk-Based Capital (RBC) calculation. Used for regulatory capital adequacy assessment under NAIC RBC framework.',
    `reinsurance_ceded_reserve_amount` DECIMAL(18,2) COMMENT 'The portion of statutory reserve ceded to reinsurers under reinsurance treaties. Reduces the net statutory reserve position of the ceding company.',
    `reserve_adequacy_margin` DECIMAL(18,2) COMMENT 'The margin held above the minimum statutory reserve requirement to ensure reserve adequacy under adverse scenarios. Part of PBR stochastic reserve calculations.',
    `reserve_basis_code` STRING COMMENT 'The statutory reserve methodology basis. Values: PBR (Principle-Based Reserving per VM-20/VM-21), CRVM (Commissioners Reserve Valuation Method for life), CARVM (Commissioners Annuity Reserve Valuation Method), NET_PREMIUM (Net Premium Reserve), MODIFIED_RESERVE (Modified Reserve Method).. Valid values are `PBR|CRVM|CARVM|NET_PREMIUM|MODIFIED_RESERVE`',
    `reserve_calculation_method_description` STRING COMMENT 'Detailed description of the reserve calculation methodology applied, including any company-specific adjustments or assumptions beyond standard statutory methods.',
    `reserve_category` STRING COMMENT 'High-level reserve category for NAIC annual statement exhibit classification. Values: LIFE (life insurance reserves), ANNUITY (annuity reserves), ACCIDENT_HEALTH (accident and health reserves), DEPOSIT_TYPE (deposit-type contract reserves).. Valid values are `LIFE|ANNUITY|ACCIDENT_HEALTH|DEPOSIT_TYPE`',
    `reserve_change_amount` DECIMAL(18,2) COMMENT 'The change in statutory reserve from the prior period to the current period, calculated as statutory_reserve_amount minus prior_period_reserve_amount. Represents reserve strengthening or release.',
    `reserve_change_reason_code` STRING COMMENT 'Code indicating the primary driver of reserve change. Values: NEW_BUSINESS (new policy issuance), MORTALITY (mortality experience), LAPSE (lapse/surrender activity), INTEREST (interest rate changes), ASSUMPTION_CHANGE (assumption updates), REINSURANCE (reinsurance treaty changes).. Valid values are `NEW_BUSINESS|MORTALITY|LAPSE|INTEREST|ASSUMPTION_CHANGE|REINSURANCE`',
    `reserve_status` STRING COMMENT 'The status of the statutory reserve booking. Values: PRELIMINARY (initial actuarial calculation), FINAL (management approved and booked), ADJUSTED (post-close adjustment), RESTATED (prior period restatement).. Valid values are `PRELIMINARY|FINAL|ADJUSTED|RESTATED`',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this reserve record is subject to SOX internal controls over financial reporting. True for material reserve balances requiring enhanced control testing.',
    `state_of_domicile_code` STRING COMMENT 'Two-letter US state code representing the state of domicile for the legal entity holding this reserve. Determines which state Department of Insurance has primary regulatory authority.',
    `tax_reserve_amount` DECIMAL(18,2) COMMENT 'The reserve amount calculated for federal income tax purposes under IRC Section 807. May differ from statutory reserve due to different valuation methods and assumptions.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this statutory reserve record was last updated. Tracks modifications for audit and reconciliation purposes.',
    `valuation_interest_rate` DECIMAL(18,2) COMMENT 'The statutory valuation interest rate used for discounting future cash flows in reserve calculations, expressed as a decimal (e.g., 0.0350 for 3.50%). Prescribed by state law and NAIC guidelines.',
    CONSTRAINT pk_statutory_reserve PRIMARY KEY(`statutory_reserve_id`)
) COMMENT 'SSOT for finance-booked statutory (SAP) reserve balances by policy cohort, product line, valuation basis, legal entity, and reporting period. Captures statutory reserve amount, PBR (Principle-Based Reserving) reserve per VM-20 (life) and VM-21 (variable annuity), CARVM reserve (annuity), CRVM reserve (life), reserve basis (CSO mortality table, valuation interest rate), reinsurance ceded reserve, net amount at risk (NAR), and reserve adequacy margin. Reported to state DOIs and NAIC on the annual statement Exhibits 5-8. Distinct from actuarial domain reserve calculations which are the source computations — this product owns the finance-booked statutory reserve position after actuarial hand-off and management sign-off.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` (
    `gaap_reserve_id` BIGINT COMMENT 'Unique identifier for the GAAP reserve record.',
    `ifrs17_contract_group_id` BIGINT COMMENT 'Reference to the insurance contract grouping for GAAP reporting purposes under LDTI cohort methodology.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the insurance policy contract associated with this reserve.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: GAAP reserve calculations require documentation of assumption changes, cash flow models, and management approval memos per LDTI standards. Quarterly financial close and external audit processes depend',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: GAAP/LDTI reserves are tracked by product cohort for financial statement preparation. Required for quarterly earnings reporting, assumption unlock analysis, and product profitability measurement. Link',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: GAAP reserves are measured and disclosed for specific reporting periods. Essential for financial statement preparation, LDTI compliance, and external audit. Period linkage enables reserve roll-forward',
    `valuation_run_id` BIGINT COMMENT 'Reference to the actuarial valuation run that produced this reserve calculation, linking to the actuarial system of record.',
    `actual_experience_effect_amount` DECIMAL(18,2) COMMENT 'The financial impact on the reserve balance resulting from actual experience differing from expected assumptions (e.g., actual mortality vs. expected mortality).',
    `approval_date` DATE COMMENT 'The date when this reserve balance was approved by the Chief Actuary or designated authority for inclusion in financial statements.',
    `approver_name` STRING COMMENT 'The name of the individual (typically Chief Actuary or Finance Officer) who approved this reserve calculation.',
    `assumption_change_effect_amount` DECIMAL(18,2) COMMENT 'The financial impact (increase or decrease) on the reserve balance resulting from changes in actuarial assumptions during the reporting period, as required by LDTI disclosure.',
    `assumption_update_date` DATE COMMENT 'The date when the cash flow assumptions were last updated or reviewed for this reserve calculation.',
    `cash_flow_assumption_version` STRING COMMENT 'Version identifier for the set of actuarial assumptions (mortality, lapse, expense, etc.) used to project future cash flows for this reserve calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this reserve record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the reserve amount.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `dac_asset_amount` DECIMAL(18,2) COMMENT 'The deferred acquisition cost asset balance associated with this contract group, amortized over the life of the contracts under GAAP.',
    `discount_rate_percentage` DECIMAL(18,2) COMMENT 'The discount rate percentage applied to calculate the net present value of future policy benefits, expressed as a decimal (e.g., 0.04500 for 4.5%).',
    `discount_rate_type` STRING COMMENT 'The type of discount rate applied to calculate the present value of future cash flows. LOCKED_IN=original cohort rate locked at issue, UPPER_MEDIUM_GRADE=current upper-medium grade fixed income instrument rate, CURRENT_MARKET=current market observable rate.. Valid values are `LOCKED_IN|UPPER_MEDIUM_GRADE|CURRENT_MARKET`',
    `expense_assumption_per_policy` DECIMAL(18,2) COMMENT 'The assumed annual maintenance expense per policy used in the cash flow projections for this reserve calculation.',
    `external_audit_review_flag` BOOLEAN COMMENT 'Indicates whether this reserve balance has been reviewed and validated by external auditors as part of the annual financial statement audit.',
    `face_amount_total` DECIMAL(18,2) COMMENT 'The total face amount (death benefit or account value) of all policies included in this reserve calculation.',
    `gaap_vs_statutory_difference_amount` DECIMAL(18,2) COMMENT 'The difference between the GAAP reserve balance and the corresponding statutory reserve balance for the same contract group, used for reconciliation and regulatory reporting.',
    `lapse_rate_assumption_percentage` DECIMAL(18,2) COMMENT 'The assumed annual lapse (policy termination) rate used in the cash flow projections for this reserve calculation, expressed as a decimal.',
    `ldti_cohort_year` STRING COMMENT 'The calendar year in which the insurance contracts were issued, used for LDTI cohort grouping under FASB ASC 944-40.',
    `ldti_transition_adjustment_amount` DECIMAL(18,2) COMMENT 'The cumulative adjustment to the reserve balance resulting from the transition to LDTI accounting standards (ASU 2018-12), typically recorded as a cumulative effect adjustment to retained earnings.',
    `mortality_table_code` STRING COMMENT 'The mortality table used in the reserve calculation (e.g., 2017 CSO, 2012 IAM, Annuity 2012).',
    `mrb_fair_value_amount` DECIMAL(18,2) COMMENT 'The fair value measurement of market risk benefits (e.g., GMDB, GMIB, GMWB) embedded in variable annuity and variable life contracts, measured at fair value under LDTI.',
    `mrb_instrument_credit_risk_adjustment` DECIMAL(18,2) COMMENT 'The adjustment to MRB fair value reflecting the companys own credit risk (non-performance risk) as required under fair value measurement guidance.',
    `net_reserve_amount` DECIMAL(18,2) COMMENT 'The net GAAP reserve balance after deducting reinsurance recoverables (reserve_amount minus reinsurance_recoverable_amount).',
    `notes` STRING COMMENT 'Free-text field for additional notes, explanations, or commentary regarding this reserve calculation, including any unusual adjustments or methodology changes.',
    `policy_count` STRING COMMENT 'The number of in-force insurance policies included in this reserve calculation for the contract group and reporting period.',
    `premium_deficiency_reserve_amount` DECIMAL(18,2) COMMENT 'Additional reserve established when a loss recognition event is identified (i.e., when the present value of expected future cash flows exceeds the existing reserve plus anticipated future premiums).',
    `product_line_code` STRING COMMENT 'Insurance product line classification. WL=Whole Life, UL=Universal Life, IUL=Indexed Universal Life, VUL=Variable Universal Life, TERM=Term Life, SPIA=Single Premium Immediate Annuity, FIA=Fixed Indexed Annuity, VA=Variable Annuity, DI=Disability Income, LTC=Long-Term Care. [ENUM-REF-CANDIDATE: WL|UL|IUL|VUL|TERM|SPIA|FIA|VA|DI|LTC — 10 candidates stripped; promote to reference product]',
    `reinsurance_recoverable_amount` DECIMAL(18,2) COMMENT 'The amount of reserve liability that is recoverable from reinsurers under reinsurance treaties, reducing the net reserve position.',
    `reserve_adequacy_test_date` DATE COMMENT 'The date when the most recent reserve adequacy test was performed.',
    `reserve_adequacy_test_status` STRING COMMENT 'The result of the most recent reserve adequacy testing (loss recognition testing) performed to ensure reserves are sufficient to cover expected future obligations.. Valid values are `PASSED|FAILED|NOT_TESTED|IN_PROGRESS`',
    `reserve_amount` DECIMAL(18,2) COMMENT 'The total GAAP reserve balance amount for this contract group and reporting period, measured in accordance with FASB ASC 944 and LDTI standards.',
    `reserve_calculation_method` STRING COMMENT 'The actuarial methodology used to calculate the reserve balance (e.g., net premium method, gross premium method, benefit reserve method, fair value measurement).. Valid values are `NET_PREMIUM|GROSS_PREMIUM|BENEFIT_RESERVE|UNEARNED_PREMIUM|FAIR_VALUE`',
    `reserve_category` STRING COMMENT 'Classification of the GAAP reserve type. FPB=Future Policy Benefit, PAB=Policyholder Account Balance, MRB=Market Risk Benefit, CLAIM=Claim Reserve, IBNR=Incurred But Not Reported, UNEARNED=Unearned Premium Reserve.. Valid values are `FPB|PAB|MRB|CLAIM|IBNR|UNEARNED`',
    `reserve_status` STRING COMMENT 'The current status of this reserve calculation in the financial close process. PRELIMINARY=initial calculation, FINAL=approved for financial statements, ADJUSTED=post-close adjustment, RESTATED=prior period restatement.. Valid values are `PRELIMINARY|FINAL|ADJUSTED|RESTATED`',
    `sox_control_certification_flag` BOOLEAN COMMENT 'Indicates whether this reserve balance has been certified under SOX internal controls for financial reporting accuracy and completeness.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this reserve record was last modified.',
    CONSTRAINT pk_gaap_reserve PRIMARY KEY(`gaap_reserve_id`)
) COMMENT 'GAAP reserve balances by insurance contract group, product line, and reporting period under FASB ASC 944 and LDTI. Captures future policy benefit (FPB) reserve, policyholder account balance (PAB), market risk benefit (MRB) fair value, LDTI cohort grouping, discount rate (locked-in vs. upper-medium grade), cash flow assumption update, effect of assumption changes, and reinsurance recoverable. Distinct from statutory_reserve as it reflects GAAP measurement basis including LDTI transition adjustments.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` (
    `ifrs17_contract_group_id` BIGINT COMMENT 'Unique identifier for the IFRS 17 insurance contract group. Represents the unit of account for measurement and disclosure under IFRS 17.',
    `cohort_definition_id` BIGINT COMMENT 'Foreign key linking to actuarial.cohort_definition. Business justification: IFRS17 contract groups ARE cohorts under the standard (annual cohorts of onerous/non-onerous contracts). Direct link enables cohort-level CSM tracking, loss component management, and regulatory disclo',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: IFRS 17 contract grouping decisions require documented policies, cohort definitions, and onerous contract assessments. IFRS 17 disclosure preparation and audit depend on linking contract groups to sup',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: IFRS 17 contract groups are defined by product and cohort year for international financial reporting. Required for CSM calculation, insurance revenue recognition, and onerous contract testing. Links c',
    `reinsurance_contract_group_id` BIGINT COMMENT 'Reference to the reinsurance contract group held that covers this direct insurance contract group, if applicable.',
    `closing_csm_balance` DECIMAL(18,2) COMMENT 'The unearned profit component at the end of the reporting period after all movements including release, interest accretion, and adjustments.',
    `closing_fcf_estimate` DECIMAL(18,2) COMMENT 'The present value of future cash flows at the end of the reporting period after all movements and adjustments.',
    `contract_boundary_assessment` STRING COMMENT 'Description of the contract boundary determination, identifying the point at which the entity has the practical ability to reassess risks and can set a price that reflects those risks.',
    `contract_group_code` STRING COMMENT 'Business identifier code for the contract group used in financial reporting and actuarial systems.',
    `coverage_period` STRING COMMENT 'Indicates whether this measurement relates to the liability for remaining coverage or the liability for incurred claims.. Valid values are `remaining_coverage|incurred_claims`',
    `coverage_units_closing` DECIMAL(18,2) COMMENT 'The quantity of coverage units at the end of the period after adjustments for service provided and changes in expected coverage.',
    `coverage_units_opening` DECIMAL(18,2) COMMENT 'The quantity of coverage units at the beginning of the period, used to determine the pattern of CSM release. Coverage units represent the quantity of service provided by the contracts.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this contract group record was first created in the system.',
    `csm_assumption_change_impact` DECIMAL(18,2) COMMENT 'Adjustments to CSM resulting from changes in estimates of future cash flows relating to future service, excluding changes in financial assumptions when the entity has chosen to disaggregate insurance finance income or expense.',
    `csm_currency_exchange_impact` DECIMAL(18,2) COMMENT 'The effect of changes in foreign exchange rates on the CSM for contracts denominated in foreign currencies.',
    `csm_experience_variance` DECIMAL(18,2) COMMENT 'Adjustments to CSM for differences between expected and actual cash flows relating to future service.',
    `csm_interest_accretion` DECIMAL(18,2) COMMENT 'The interest accreted on the CSM balance during the period using discount rates determined at initial recognition.',
    `csm_new_business_addition` DECIMAL(18,2) COMMENT 'The CSM arising from new contracts added to the group during the period.',
    `csm_release_amount` DECIMAL(18,2) COMMENT 'The amount of CSM recognized as insurance revenue in the current period based on coverage units provided.',
    `derecognition_date` DATE COMMENT 'The date when the contract group was derecognized from the statement of financial position, when all rights and obligations are extinguished or transferred.',
    `discount_rate_closing` DECIMAL(18,2) COMMENT 'The discount rate applied to the fulfilment cash flows at the end of the reporting period.',
    `discount_rate_opening` DECIMAL(18,2) COMMENT 'The discount rate applied to the fulfilment cash flows at the beginning of the reporting period, reflecting the time value of money and financial risk.',
    `functional_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code of the primary economic environment in which the entity operates for this contract group.. Valid values are `^[A-Z]{3}$`',
    `ifrs17_contract_group_status` STRING COMMENT 'The current lifecycle status of the contract group: active (in force), closed (no longer accepting new contracts but existing contracts remain), or derecognized (fully extinguished).. Valid values are `active|closed|derecognized`',
    `initial_recognition_date` DATE COMMENT 'The date when the contract group was first recognized in the financial statements, typically the earliest of: beginning of coverage period, first payment due, or when the group becomes onerous.',
    `insurance_finance_income_expense` DECIMAL(18,2) COMMENT 'The change in the carrying amount of the group of insurance contracts arising from the time value of money, financial risk, and changes in financial risk.',
    `insurance_revenue_recognized` DECIMAL(18,2) COMMENT 'The amount of insurance revenue recognized in profit or loss during the period, comprising the release of CSM, risk adjustment, and expected incurred claims.',
    `insurance_service_expense` DECIMAL(18,2) COMMENT 'The total insurance service expenses recognized in profit or loss, including incurred claims, other incurred expenses, amortization of insurance acquisition cash flows, and losses on onerous contracts.',
    `loss_component_closing` DECIMAL(18,2) COMMENT 'The closing balance of the loss component for onerous contract groups after movements during the period.',
    `loss_component_opening` DECIMAL(18,2) COMMENT 'The opening balance of the loss component for onerous contract groups. Represents the extent to which the fulfilment cash flows exceed the carrying amount of the liability for remaining coverage.',
    `measurement_model` STRING COMMENT 'The IFRS 17 measurement model applied to this contract group: General Measurement Model (GMM), Premium Allocation Approach (PAA), or Variable Fee Approach (VFA) for direct participating contracts.. Valid values are `GMM|PAA|VFA`',
    `oci_amount` DECIMAL(18,2) COMMENT 'The portion of insurance finance income or expense recognized in other comprehensive income when the entity has elected to disaggregate insurance finance income or expense.',
    `oci_pl_allocation_election` STRING COMMENT 'The accounting policy choice for presenting insurance finance income or expense: entirely in profit or loss, or disaggregated between profit or loss and OCI.. Valid values are `full_pl|oci_disaggregation`',
    `opening_csm_balance` DECIMAL(18,2) COMMENT 'The unearned profit component at the beginning of the reporting period. Represents the unearned profit the entity will recognize as it provides services under the insurance contracts.',
    `opening_fcf_estimate` DECIMAL(18,2) COMMENT 'The present value of future cash flows at the beginning of the reporting period. Comprises estimates of future cash flows, discount rate adjustment, and risk adjustment for non-financial risk.',
    `profitability_classification` STRING COMMENT 'Classification of the contract group based on initial recognition assessment: onerous (expected to be loss-making), not onerous (profitable), or no significant possibility of becoming onerous.. Valid values are `onerous|not_onerous|no_significant_possibility_of_becoming_onerous`',
    `reporting_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the contract group measurements are reported.. Valid values are `^[A-Z]{3}$`',
    `reporting_period_end_date` DATE COMMENT 'The last day of the reporting period for which this contract group measurement applies.',
    `reporting_period_start_date` DATE COMMENT 'The first day of the reporting period for which this contract group measurement applies.',
    `risk_adjustment_closing` DECIMAL(18,2) COMMENT 'The compensation the entity requires for bearing the uncertainty about the amount and timing of cash flows from non-financial risk at the end of the period.',
    `risk_adjustment_opening` DECIMAL(18,2) COMMENT 'The compensation the entity requires for bearing the uncertainty about the amount and timing of cash flows from non-financial risk at the beginning of the period.',
    `risk_adjustment_release` DECIMAL(18,2) COMMENT 'The amount of risk adjustment recognized in profit or loss as the entity is released from risk during the period.',
    `transition_approach` STRING COMMENT 'The transition method applied when IFRS 17 was first adopted for this contract group: full retrospective application, modified retrospective approach, or fair value approach.. Valid values are `full_retrospective|modified_retrospective|fair_value`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this contract group record was last modified.',
    CONSTRAINT pk_ifrs17_contract_group PRIMARY KEY(`ifrs17_contract_group_id`)
) COMMENT 'SSOT for IFRS 17 insurance contract group definitions and periodic measurement roll-forwards. Defines the unit of account: portfolio identifier, cohort year, profitability classification (onerous, not onerous, remaining coverage), measurement model (GMM, PAA, VFA), and reinsurance contract group linkage. Records all periodic measurement roll-forwards: opening/closing fulfilment cash flows (FCF), contractual service margin (CSM) opening/closing balance, release pattern, and movement analysis, risk adjustment for non-financial risk and movement, loss component for onerous groups, insurance revenue recognized, insurance service expense, insurance finance income/expense, OCI vs. P&L allocation election, experience variance, assumption change impact, and reinsurance held measurement. Serves as SSOT for IFRS 17 contract group definitions, measurement disclosures, and statement of financial position / profit or loss reporting.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` (
    `ifrs17_measurement_id` BIGINT COMMENT 'Unique identifier for the IFRS 17 measurement record.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: CSM releases and risk adjustment changes require supporting actuarial reports and assumption change documentation. Quarterly IFRS 17 measurement and disclosure processes depend on linking measurements',
    `ifrs17_contract_group_id` BIGINT COMMENT 'Identifier for the insurance contract group to which this measurement applies. Contract groups are portfolios of insurance contracts managed together under IFRS 17.',
    `report_period_id` BIGINT COMMENT 'Identifier for the financial reporting period (month, quarter, year) to which this measurement applies.',
    `valuation_run_id` BIGINT COMMENT 'Identifier for the actuarial valuation run that produced this measurement, linking to the actuarial system for audit trail and reconciliation.',
    `acquisition_expense` DECIMAL(18,2) COMMENT 'Expenses incurred during the reporting period for acquiring new insurance contracts, including commissions and underwriting costs.',
    `approved_by` STRING COMMENT 'The user ID or name of the individual who approved this measurement for financial reporting, supporting SOX compliance and audit trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this measurement was approved for financial reporting.',
    `assumption_change_impact` DECIMAL(18,2) COMMENT 'The total impact on the insurance contract liability from changes in actuarial assumptions during the reporting period.',
    `closing_csm` DECIMAL(18,2) COMMENT 'The closing balance of the Contractual Service Margin at the end of the reporting period.',
    `closing_fcf_estimate` DECIMAL(18,2) COMMENT 'The closing balance of the present value of future cash flows at the end of the reporting period.',
    `closing_risk_adjustment` DECIMAL(18,2) COMMENT 'The closing balance of the risk adjustment for non-financial risk at the end of the reporting period.',
    `cohort_year` STRING COMMENT 'The year in which the insurance contracts in this group were initially recognized, used for cohort-based measurement under IFRS 17.',
    `coverage_units` DECIMAL(18,2) COMMENT 'The quantity of coverage units provided during the reporting period, used to allocate CSM release. Coverage units reflect the quantity of benefits provided under the insurance contracts.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this measurement record was first created in the system.',
    `csm_assumption_change` DECIMAL(18,2) COMMENT 'Adjustment to CSM arising from changes in estimates of future cash flows that relate to future service (e.g., changes in mortality, lapse, expense assumptions).',
    `csm_experience_adjustment` DECIMAL(18,2) COMMENT 'Adjustment to CSM arising from differences between actual experience and previous estimates (experience variances) that relate to future service.',
    `csm_interest_accretion` DECIMAL(18,2) COMMENT 'The interest accreted on the CSM balance during the reporting period, calculated using the discount rate locked in at initial recognition.',
    `csm_release_for_service` DECIMAL(18,2) COMMENT 'The amount of CSM released to profit or loss as insurance revenue during the reporting period, reflecting the insurance service provided.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the measurement amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `discount_rate` DECIMAL(18,2) COMMENT 'The discount rate applied to future cash flows for this measurement, reflecting the time value of money and characteristics of the cash flows.',
    `experience_variance` DECIMAL(18,2) COMMENT 'The difference between actual experience and previous estimates during the reporting period, recognized immediately in profit or loss for past service.',
    `finance_oci_component` DECIMAL(18,2) COMMENT 'The portion of insurance finance income or expense recognized in other comprehensive income (OCI) during the reporting period, when the entity elects the OCI option.',
    `finance_pl_component` DECIMAL(18,2) COMMENT 'The portion of insurance finance income or expense recognized in profit or loss during the reporting period.',
    `incurred_claims` DECIMAL(18,2) COMMENT 'The amount of claims incurred during the reporting period, including claims paid and changes in claims liabilities.',
    `insurance_finance_expense` DECIMAL(18,2) COMMENT 'Finance expense recognized during the reporting period from the unwinding of discount on insurance contract liabilities and changes in discount rates.',
    `insurance_finance_income` DECIMAL(18,2) COMMENT 'Finance income recognized during the reporting period from the unwinding of discount on insurance contract liabilities and changes in discount rates.',
    `insurance_revenue` DECIMAL(18,2) COMMENT 'Total insurance revenue recognized in profit or loss during the reporting period, comprising CSM release, risk adjustment release, and expected claims and expenses.',
    `insurance_service_expense` DECIMAL(18,2) COMMENT 'Total insurance service expenses recognized in profit or loss during the reporting period, including incurred claims, acquisition expenses, and other directly attributable expenses.',
    `loss_component` DECIMAL(18,2) COMMENT 'The loss component balance for onerous contract groups, tracked separately to determine the allocation of subsequent changes in fulfilment cash flows.',
    `measurement_date` DATE COMMENT 'The date as of which the IFRS 17 measurement is performed, typically the reporting period end date.',
    `measurement_model` STRING COMMENT 'The IFRS 17 measurement model applied to this contract group: General Measurement Model (GMM), Premium Allocation Approach (PAA), or Variable Fee Approach (VFA).. Valid values are `General Measurement Model|Premium Allocation Approach|Variable Fee Approach`',
    `measurement_status` STRING COMMENT 'The status of this measurement record in the financial close process: Draft (work in progress), Preliminary (under review), Final (approved for reporting), or Restated (corrected after initial reporting).. Valid values are `Draft|Preliminary|Final|Restated`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this measurement record was last modified.',
    `onerous_contract_loss` DECIMAL(18,2) COMMENT 'Loss recognized immediately in profit or loss when a group of insurance contracts becomes onerous (i.e., the fulfilment cash flows exceed any remaining CSM).',
    `opening_csm` DECIMAL(18,2) COMMENT 'The opening balance of the Contractual Service Margin at the beginning of the reporting period. CSM represents the unearned profit that will be recognized as insurance revenue over the coverage period.',
    `opening_fcf_estimate` DECIMAL(18,2) COMMENT 'The opening balance of the present value of future cash flows (estimates of future cash inflows and outflows) at the beginning of the reporting period.',
    `opening_risk_adjustment` DECIMAL(18,2) COMMENT 'The opening balance of the risk adjustment for non-financial risk at the beginning of the reporting period. Risk adjustment represents the compensation required for bearing uncertainty about the amount and timing of cash flows.',
    `reinsurance_held_csm` DECIMAL(18,2) COMMENT 'The CSM for reinsurance contracts held, representing the unearned benefit from reinsurance coverage.',
    `reinsurance_held_fcf` DECIMAL(18,2) COMMENT 'The present value of future cash flows for reinsurance contracts held, representing the reinsurance asset or liability.',
    `reinsurance_held_risk_adjustment` DECIMAL(18,2) COMMENT 'The risk adjustment for non-financial risk on reinsurance contracts held.',
    `risk_adjustment_change` DECIMAL(18,2) COMMENT 'Change in risk adjustment during the period due to changes in estimates of non-financial risk.',
    `risk_adjustment_release` DECIMAL(18,2) COMMENT 'The amount of risk adjustment released to profit or loss during the reporting period as risk is reduced through the passage of time and claim settlement.',
    CONSTRAINT pk_ifrs17_measurement PRIMARY KEY(`ifrs17_measurement_id`)
) COMMENT 'Periodic IFRS 17 measurement roll-forward by insurance contract group and reporting period. Captures opening/closing fulfilment cash flows (FCF), contractual service margin (CSM) movement, risk adjustment movement, insurance revenue recognized, insurance service expense, insurance finance income/expense, OCI vs. P&L allocation, experience variance, assumption change impact, and reinsurance held measurement. Supports IFRS 17 statement of financial position and statement of profit or loss disclosures.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` (
    `rbc_calculation_id` BIGINT COMMENT 'Unique identifier for the RBC calculation record. Primary key.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: RBC filings require supporting schedules, investment listings, and reinsurance attestations filed with state regulators. Annual RBC filing and regulatory compliance depend on linking calculations to f',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity for which RBC is calculated. Links to the legal entity master.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: RBC C2 insurance risk component is calculated by product line for regulatory capital adequacy reporting. Required for Annual Statement Schedule S filing, capital planning, and product pricing. Links R',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: RBC calculations are statutory regulatory filings to state insurance departments requiring appointed actuary or qualified preparer signature. Regulatory accountability mandates employee tracking. Repl',
    `report_period_id` BIGINT COMMENT 'Identifier of the reporting period (quarter/year) for this RBC calculation.',
    `valuation_run_id` BIGINT COMMENT 'Foreign key linking to actuarial.valuation_run. Business justification: RBC C2 insurance risk component calculations depend on actuarial reserve valuations (statutory reserves, PBR reserves). Direct link enables reconciliation between RBC filings and actuarial memorandums',
    `action_level_trigger` STRING COMMENT 'Indicates which regulatory action level threshold has been triggered based on the RBC ratio (no_action, company_action, regulatory_action, authorized_control, mandatory_control).. Valid values are `no_action|company_action|regulatory_action|authorized_control|mandatory_control`',
    `audit_opinion` STRING COMMENT 'The auditors opinion on the RBC calculation if reviewed (unqualified, qualified, adverse, disclaimer, not_audited).. Valid values are `unqualified|qualified|adverse|disclaimer|not_audited`',
    `auditor_reviewed_flag` BOOLEAN COMMENT 'Indicates whether the RBC calculation has been reviewed by external auditors as part of the financial statement audit.',
    `authorized_control_level_rbc` DECIMAL(18,2) COMMENT 'The authorized control level RBC amount. Represents the minimum capital threshold below which regulatory control is authorized.',
    `c0_asset_risk_affiliates` DECIMAL(18,2) COMMENT 'RBC charge for asset risk related to investments in affiliates and subsidiaries.',
    `c1_asset_risk_equity` DECIMAL(18,2) COMMENT 'RBC charge for asset risk on equity investments and common stock.',
    `c1_asset_risk_fixed_income` DECIMAL(18,2) COMMENT 'RBC charge for asset default risk on fixed income securities (bonds, mortgages).',
    `c1_asset_risk_other` DECIMAL(18,2) COMMENT 'RBC charge for asset risk on other invested assets not classified elsewhere.',
    `c1_asset_risk_real_estate` DECIMAL(18,2) COMMENT 'RBC charge for asset risk on real estate holdings and property investments.',
    `c2_insurance_risk` DECIMAL(18,2) COMMENT 'RBC charge for underwriting and pricing risk related to insurance liabilities and reserves.',
    `c3_interest_rate_risk` DECIMAL(18,2) COMMENT 'RBC charge for interest rate and asset-liability mismatch risk.',
    `c3_market_risk` DECIMAL(18,2) COMMENT 'RBC charge for market risk on variable annuity guarantees and other market-sensitive products.',
    `c4_business_risk` DECIMAL(18,2) COMMENT 'RBC charge for general business risk including administrative expenses and guaranty fund assessments.',
    `calculation_date` DATE COMMENT 'The date on which the RBC calculation was performed.',
    `calculation_methodology` STRING COMMENT 'The methodology used for RBC calculation (formula_based, scenario_based, stochastic, hybrid).. Valid values are `formula_based|scenario_based|stochastic|hybrid`',
    `calculation_status` STRING COMMENT 'Current lifecycle status of the RBC calculation (draft, preliminary, final, filed, amended, superseded).. Valid values are `draft|preliminary|final|filed|amended|superseded`',
    `calculation_type` STRING COMMENT 'Type of RBC calculation based on insurance line of business (life, property/casualty, health).. Valid values are `life|property_casualty|health`',
    `company_action_level_rbc` DECIMAL(18,2) COMMENT 'The company action level RBC amount. Represents the threshold at which the company must submit a corrective action plan.',
    `covariance_adjustment` DECIMAL(18,2) COMMENT 'Adjustment factor applied to recognize diversification benefits across risk categories using the NAIC covariance formula.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RBC calculation record was first created in the system.',
    `filed_with_regulator_flag` BOOLEAN COMMENT 'Indicates whether this RBC calculation has been officially filed with the state insurance regulator.',
    `filing_date` DATE COMMENT 'The date on which the RBC report was filed with the state insurance department.',
    `filing_method` STRING COMMENT 'Method used to file the RBC report with the regulator (electronic, paper, exempt).. Valid values are `electronic|paper|exempt`',
    `mandatory_control_level_rbc` DECIMAL(18,2) COMMENT 'The mandatory control level RBC amount. Represents the threshold at which the regulator must place the company under regulatory control.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this RBC calculation record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this RBC calculation record was last modified.',
    `notes` STRING COMMENT 'Free-text notes and commentary regarding the RBC calculation, including assumptions, adjustments, or special circumstances.',
    `orsa_alignment_flag` BOOLEAN COMMENT 'Indicates whether this RBC calculation aligns with the companys ORSA capital assessment and risk management framework.',
    `rbc_ratio` DECIMAL(18,2) COMMENT 'The ratio of Total Adjusted Capital to Authorized Control Level RBC, expressed as a percentage. Key metric for regulatory capital adequacy.',
    `regulator_jurisdiction` STRING COMMENT 'The state or jurisdiction code of the primary insurance regulator (e.g., NY, CA, TX).',
    `regulatory_action_level_rbc` DECIMAL(18,2) COMMENT 'The regulatory action level RBC amount. Represents the threshold at which the regulator may take corrective action.',
    `reporting_quarter` STRING COMMENT 'The quarter within the reporting year (1-4). Null for annual-only calculations.',
    `reporting_year` STRING COMMENT 'The calendar year for which RBC is being reported.',
    `total_adjusted_capital` DECIMAL(18,2) COMMENT 'Total adjusted capital available to support risk. Calculated as statutory capital and surplus plus other adjustments per NAIC formula.',
    `total_rbc_after_covariance` DECIMAL(18,2) COMMENT 'Total RBC requirement after applying the covariance adjustment for diversification.',
    `total_rbc_before_covariance` DECIMAL(18,2) COMMENT 'Sum of all RBC risk components (C-0 through C-4) before applying the covariance adjustment.',
    `trend_test_result` STRING COMMENT 'Result of the RBC trend test comparing current year to prior year capital adequacy (pass, fail, not_applicable).. Valid values are `pass|fail|not_applicable`',
    CONSTRAINT pk_rbc_calculation PRIMARY KEY(`rbc_calculation_id`)
) COMMENT 'Risk-Based Capital (RBC) calculation records by legal entity and reporting period. Captures total adjusted capital (TAC), authorized control level (ACL) RBC, company action level (CAL) RBC, C-0 (asset default) risk, C-1 (asset risk), C-2 (insurance/pricing risk), C-3 (interest rate/market risk), C-4 (business risk), covariance adjustment, RBC ratio, and regulatory action level trigger flags. Supports NAIC RBC filing, state DOI capital adequacy reporting, and ORSA capital planning.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` (
    `intercompany_settlement_id` BIGINT COMMENT 'Unique identifier for the intercompany settlement transaction record.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Intercompany transactions require service agreements, transfer pricing documentation, and settlement confirmations. Monthly intercompany reconciliation and tax compliance depend on linking settlements',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: intercompany_settlement has gl_account_code (STRING) and should FK to chart_of_accounts. Settlements post to GL accounts; FK is essential for intercompany elimination entries and consolidation.',
    `claim_id` BIGINT COMMENT 'Identifier of the insurance claim associated with this intercompany settlement, applicable when the transaction relates to claim reinsurance or claim expense allocation.',
    `communication_id` BIGINT COMMENT 'Unique identifier of the transaction in the source system, enabling traceability back to the originating system for audit and reconciliation purposes.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: intercompany_settlement has cost_center_code (STRING) and should FK to cost_center. Settlements are allocated to cost centers for transfer pricing and expense allocation; FK is essential.',
    `in_force_policy_id` BIGINT COMMENT 'Identifier of the insurance policy or annuity contract associated with this intercompany settlement, if the transaction is policy-specific.',
    `investment_transaction_id` BIGINT COMMENT 'Identifier of the investment transaction associated with this intercompany settlement, applicable when transaction type is investment income transfer or investment management fee.',
    `netting_group_id` BIGINT COMMENT 'Identifier for the netting group or pool to which this settlement belongs, used to aggregate offsetting intercompany balances for consolidated settlement.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity initiating or originating the intercompany transaction within the holding company group.',
    `receiving_legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity receiving or benefiting from the intercompany transaction within the holding company group.',
    `reinsurance_treaty_id` BIGINT COMMENT 'Identifier of the reinsurance treaty associated with this intercompany settlement, applicable when transaction type is reinsurance premium or reinsurance recoverable.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Intercompany settlements are recorded in specific accounting periods for consolidation reporting. Required for intercompany elimination entries, consolidated financial statement preparation, and trans',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Intercompany transactions may involve external vendors providing shared services across legal entities (e.g., TPA serving multiple subsidiaries). Required for transfer pricing, intercompany reconcilia',
    `approval_date` DATE COMMENT 'Date on which the intercompany settlement transaction was approved by authorized personnel, as required by SOX internal control procedures.',
    `approved_by` STRING COMMENT 'User identifier or name of the authorized individual who approved the intercompany settlement transaction for processing.',
    `business_unit_code` STRING COMMENT 'Business unit or division code associated with the originating side of the intercompany settlement for segment reporting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this intercompany settlement record was first created in the data platform, supporting audit trail and data lineage requirements.',
    `elimination_entry_reference` STRING COMMENT 'Reference number or identifier linking this intercompany settlement to the corresponding consolidation elimination journal entry in GAAP consolidated financial statements.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert settlement amount from settlement currency to functional currency, if currencies differ.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Settlement amount converted to the functional currency of the originating legal entity for consolidated financial reporting purposes.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this intercompany settlement transaction is posted in the originating legal entitys chart of accounts.',
    `intercompany_settlement_description` STRING COMMENT 'Detailed textual description of the intercompany settlement transaction, providing business context and explanation of the financial flow.',
    `netting_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this settlement transaction is subject to intercompany netting arrangements where offsetting balances are consolidated before settlement.',
    `notes` STRING COMMENT 'Additional free-form notes or comments related to the intercompany settlement, capturing special circumstances, exceptions, or follow-up actions required.',
    `payment_reference_number` STRING COMMENT 'External payment system reference number or wire transfer confirmation number for intercompany settlements executed via cash transfer.',
    `product_line_code` STRING COMMENT 'Product line or line of business code associated with the intercompany settlement, used for profitability analysis and product-level financial reporting.',
    `reconciliation_date` DATE COMMENT 'Date on which the intercompany settlement was reconciled and confirmed by both originating and receiving legal entities.',
    `reconciliation_status` STRING COMMENT 'Status of the reconciliation process for this intercompany settlement, tracking whether balances have been confirmed and agreed by both parties.. Valid values are `not_started|in_progress|reconciled|variance_identified|resolved`',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Monetary value of the intercompany settlement transaction in the settlement currency, representing the gross amount transferred or allocated between legal entities.',
    `settlement_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the intercompany settlement is denominated and executed.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'Date on which the intercompany settlement transaction was executed or is scheduled to be executed, representing the effective date of the financial transfer.',
    `settlement_method` STRING COMMENT 'Method by which the intercompany settlement is executed, indicating whether it involves actual cash movement, accounting entry only, or offsetting arrangement.. Valid values are `cash_transfer|journal_entry|offset|accrual`',
    `settlement_number` STRING COMMENT 'Business-assigned unique reference number or code for the intercompany settlement transaction, used for tracking and reconciliation purposes.',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the intercompany settlement transaction indicating its position in the settlement and reconciliation workflow.. Valid values are `pending|approved|settled|reconciled|disputed|cancelled`',
    `source_system` STRING COMMENT 'Name or identifier of the source system from which this intercompany settlement transaction originated, supporting data lineage and audit requirements.',
    `statutory_line_of_business` STRING COMMENT 'Statutory line of business classification for this intercompany settlement as required for NAIC Annual Statement reporting and statutory accounting purposes.',
    `tax_treatment_code` STRING COMMENT 'Code indicating the tax treatment of this intercompany settlement for income tax and transfer pricing purposes, ensuring compliance with IRS regulations.',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction indicating the nature of the financial flow between legal entities. [ENUM-REF-CANDIDATE: expense_allocation|reinsurance_premium|investment_income_transfer|management_fee|capital_contribution|dividend_payment|service_fee|royalty_payment|loan_advance|loan_repayment|tax_allocation — promote to reference product]. Valid values are `expense_allocation|reinsurance_premium|investment_income_transfer|management_fee|capital_contribution|dividend_payment`',
    `transfer_pricing_method` STRING COMMENT 'Transfer pricing methodology applied to determine the arms length price for this intercompany transaction, as required by IRS and international tax regulations.. Valid values are `comparable_uncontrolled_price|resale_price|cost_plus|profit_split|transactional_net_margin|not_applicable`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this intercompany settlement record was last modified in the data platform, supporting change tracking and audit requirements.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary amount of any variance or discrepancy identified during intercompany reconciliation between originating and receiving entity records.',
    `variance_reason` STRING COMMENT 'Textual explanation of the reason for any reconciliation variance, documenting the root cause of the discrepancy for audit and resolution purposes.',
    CONSTRAINT pk_intercompany_settlement PRIMARY KEY(`intercompany_settlement_id`)
) COMMENT 'Records intercompany financial transactions and settlements between legal entities within the holding company group. Captures originating legal entity, receiving legal entity, transaction type (expense allocation, reinsurance premium, investment income transfer, management fee, capital contribution), settlement amount, settlement currency, netting indicator, elimination entry reference, and settlement status. Supports intercompany elimination in GAAP consolidation and statutory intercompany balances reporting.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'FK to finance.chart_of_accounts',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: budget has cost_center_code (STRING) and should FK to cost_center for referential integrity. Budget records are allocated by cost center; FK is essential for budget management and variance analysis.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: budget has legal_entity_code (STRING) and should FK to legal_entity for referential integrity. Budgets are prepared by legal entity; FK is essential for consolidation and reporting.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Budgets are set by product line for revenue and expense planning. Required for management reporting, variance analysis, and product profitability forecasting. Links budget targets to specific product ',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Budgets are prepared for specific reporting periods to enable budget-to-actual variance analysis. Essential for management reporting, financial planning cycles, and performance measurement. Period lin',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Budget submissions require supporting business cases, headcount justifications, and management approval memos. Annual budget cycle and variance analysis depend on linking budgets to supporting documen',
    `actual_amount` DECIMAL(18,2) COMMENT 'Actual financial amount posted to the general ledger for this line item and period. Expressed in the reporting currency. Used to calculate variance from budget.',
    `approval_status` STRING COMMENT 'Current approval status of the budget line item or version. Supports SOX-controlled financial close processes and budget governance.. Valid values are `DRAFT|PENDING_APPROVAL|APPROVED|REJECTED|REVISED`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved this budget line item or version. Supports audit trail and SOX compliance.',
    `approved_date` DATE COMMENT 'Date on which this budget line item or version was approved. Supports audit trail and financial close timeline tracking.',
    `budget_category` STRING COMMENT 'High-level categorization of the budget line item: Revenue (premium income, investment income), Expense (claims, operating expense, Deferred Acquisition Cost (DAC) amortization), Capital (capital expenditures), Reserve (reserve movements), or Investment (portfolio allocation). Supports financial statement rollup and executive reporting.. Valid values are `REVENUE|EXPENSE|CAPITAL|RESERVE|INVESTMENT`',
    `budgeted_amount` DECIMAL(18,2) COMMENT 'Planned or budgeted financial amount for this line item and period. Expressed in the reporting currency. Basis for budget vs. actual variance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget record (e.g., USD, EUR, GBP). Supports multi-currency budget consolidation.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date from which this budget record is effective. Supports temporal budget tracking and version control.',
    `expiration_date` DATE COMMENT 'Date on which this budget record expires or is superseded by a new version. Null for currently active budgets. Supports temporal budget tracking and version control.',
    `gl_account_code` STRING COMMENT 'General ledger account code from the chart of accounts. Identifies the financial statement line item (e.g., premium income, claims expense, operating expense, investment income, Deferred Acquisition Cost (DAC) capitalization, reserve movement).',
    `is_capital_expenditure` BOOLEAN COMMENT 'Boolean flag indicating whether this budget line item represents a capital expenditure (True) or an operating expense (False). Supports capital budgeting and asset tracking.',
    `is_controllable` BOOLEAN COMMENT 'Boolean flag indicating whether this budget line item is controllable by the budget owner (True) or is a non-controllable allocation or corporate charge (False). Supports performance evaluation and accountability.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was last modified. Supports audit trail and change tracking.',
    `line_item_description` STRING COMMENT 'Detailed description of the budget line item, providing additional context beyond the GL account name. Supports granular budget tracking and management commentary.',
    `management_commentary` STRING COMMENT 'Executive or management commentary on the budget line item, variance, or reforecast. Provides strategic context for CFO reporting and board-level financial oversight.',
    `notes` STRING COMMENT 'Additional notes or assumptions related to this budget line item. Supports budget documentation and audit trail.',
    `owner_email` STRING COMMENT 'Email address of the budget owner for communication regarding variances and reforecasts.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_name` STRING COMMENT 'Name of the individual or role responsible for this budget line item. Supports budget accountability and variance resolution tracking.',
    `product_line_code` STRING COMMENT 'Product line or line of business (e.g., Term Life, Whole Life (WL), Universal Life (UL), Indexed Universal Life (IUL), Variable Universal Life (VUL), Fixed Indexed Annuity (FIA), Single Premium Immediate Annuity (SPIA)) to which this budget applies. Supports product-level profitability and budget analysis.',
    `reforecast_amount` DECIMAL(18,2) COMMENT 'Updated forecast amount for this line item and period, reflecting revised expectations based on actual performance and business conditions. Supports dynamic financial planning and rolling forecasts.',
    `reporting_basis` STRING COMMENT 'Accounting basis for this budget line item: Generally Accepted Accounting Principles (GAAP), Statutory Accounting Principles (SAP), International Financial Reporting Standards (IFRS) 17, or Tax basis. Supports multi-basis financial reporting and Risk-Based Capital (RBC) calculations.. Valid values are `GAAP|SAP|IFRS17|TAX`',
    `variance_amount` DECIMAL(18,2) COMMENT 'Absolute variance between actual and budgeted amounts (actual minus budget). Positive values indicate over-budget (unfavorable for expenses, favorable for revenue); negative values indicate under-budget.',
    `variance_explanation` STRING COMMENT 'Narrative explanation provided by the budget owner or finance team describing the root cause of the variance. Supports management action tracking and board-level financial oversight.',
    `variance_indicator` STRING COMMENT 'Qualitative assessment of variance favorability. Favorable: actual revenue exceeds budget or actual expense is below budget. Unfavorable: actual revenue is below budget or actual expense exceeds budget. Neutral: variance within acceptable tolerance. Not Applicable: variance assessment not meaningful for this line item.. Valid values are `FAVORABLE|UNFAVORABLE|NEUTRAL|NOT_APPLICABLE`',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between actual and budgeted amounts, calculated as (actual - budget) / budget * 100. Enables relative variance comparison across line items of different magnitudes.',
    `version_code` STRING COMMENT 'Version type of the budget: original annual budget, revised budget, forecast, reforecast, or board-approved version. Supports multi-version budget tracking and variance analysis.. Valid values are `ORIGINAL|REVISED|FORECAST|REFORECAST|BOARD_APPROVED`',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Annual and multi-year financial budget master with integrated variance tracking and reforecasting by cost center, legal entity, product line, and GL account. Captures budget version (original, revised, forecast), budget year/period, budgeted amounts by line item (premium income, claims, operating expense, investment income, DAC capitalization, reserve movement), budget approval status, and budget owner. Records periodic budget vs. actual variance: actual amount posted, variance amount and percentage, favorable/unfavorable indicator, variance explanation narrative, reforecast amount, and management commentary. Supports financial planning, budget vs. actual variance analysis, CFO reporting, board-level financial oversight, and management action tracking on unfavorable variances.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`budget_variance` (
    `budget_variance_id` BIGINT COMMENT 'Unique identifier for the budget variance record. Primary key for the budget variance entity.',
    `org_unit_id` BIGINT COMMENT 'Reference to the business unit or division responsible for this budget variance. Enables segment reporting and divisional performance analysis.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: budget_variance has gl_account_code (STRING) and should FK to chart_of_accounts for referential integrity. Variance tracking is by GL account; FK enables account hierarchy rollup and classification.',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to correspondence.complaint. Business justification: Budget variances in customer service cost centers analyzed against complaint volumes for operational efficiency and staffing decisions. Management reporting correlates service costs with complaint-dri',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center for which this budget variance is recorded. Links to the cost center master data.',
    `distribution_channel_id` BIGINT COMMENT 'Reference to the distribution channel (e.g., agency, broker, direct) associated with this budget variance. Enables channel-level financial performance tracking.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity to which this budget variance record belongs. Supports consolidated and statutory financial reporting across multiple legal entities.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Variance analysis is performed by product to track actual vs. budget performance. Required for management review, product profitability assessment, and strategic planning. Links variance explanations ',
    `employee_id` BIGINT COMMENT 'Reference to the manager or executive responsible for this cost center and accountable for the budget variance. Supports accountability and escalation workflows.',
    `product_line_id` BIGINT COMMENT 'Reference to the product line (e.g., term life, whole life, annuities) associated with this budget variance. Supports product-level profitability and performance analysis.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Budget variances are calculated for specific reporting periods. Critical for management reporting, variance analysis reports, and financial performance monitoring. Period linkage enables consistent va',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual amount posted to the general ledger for the cost center and GL account during the specified period. Represents realized financial performance.',
    `approval_date` DATE COMMENT 'The date on which the variance explanation and management commentary were approved by the responsible manager or CFO. Format: yyyy-MM-dd.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The originally budgeted or planned amount for the cost center and GL account for the specified period. Represents the financial plan baseline.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget variance record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the budget, actual, variance, and reforecast amounts are denominated. Supports multi-currency financial reporting.. Valid values are `^[A-Z]{3}$`',
    `dac_eligible_flag` BOOLEAN COMMENT 'Indicates whether the expenses in this variance record are eligible for deferral as Deferred Acquisition Costs (DAC) under GAAP. True if eligible, False otherwise.',
    `favorable_unfavorable_indicator` STRING COMMENT 'Indicates whether the variance is favorable (under-budget for expenses, over-budget for revenue), unfavorable (over-budget for expenses, under-budget for revenue), or neutral. Provides business context for variance interpretation.. Valid values are `favorable|unfavorable|neutral`',
    `gaap_expense_category` STRING COMMENT 'The GAAP expense category classification for this variance. Supports FASB ASC 944 and LDTI financial reporting requirements.',
    `gl_account_code` STRING COMMENT 'The general ledger account code against which the budget and actual amounts are tracked. Represents the chart of accounts classification.. Valid values are `^[0-9]{4,10}$`',
    `intercompany_settlement_flag` BOOLEAN COMMENT 'Indicates whether this variance involves intercompany transactions requiring settlement between legal entities. True if intercompany, False otherwise.',
    `management_commentary` STRING COMMENT 'Additional commentary from senior management or the CFO office regarding the variance, including strategic context, corrective actions, or board-level insights. Supports executive reporting and governance.',
    `notes` STRING COMMENT 'Additional free-form notes or comments related to the budget variance. Provides supplementary context for analysts, auditors, or management.',
    `rbc_category` STRING COMMENT 'The Risk-Based Capital (RBC) category classification for expenses or revenues in this variance. Supports NAIC RBC calculations and capital adequacy reporting.',
    `reforecast_amount` DECIMAL(18,2) COMMENT 'The revised forecast amount for the cost center and GL account, updated based on actual performance and forward-looking expectations. Used for rolling forecasts and budget adjustments.',
    `reporting_category` STRING COMMENT 'High-level financial reporting category for the variance. Aligns with statutory and GAAP financial statement line items and supports regulatory reporting requirements.. Valid values are `operating_expense|acquisition_cost|claim_expense|investment_expense|administrative_expense|other`',
    `sap_expense_exhibit` STRING COMMENT 'The NAIC Statutory Accounting Principles (SAP) expense exhibit classification for this variance. Required for state insurance department regulatory reporting.',
    `sox_controlled_flag` BOOLEAN COMMENT 'Indicates whether this budget variance record is subject to SOX internal controls and audit requirements. True if SOX-controlled, False otherwise.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget variance record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports audit trail and change tracking.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The absolute variance amount calculated as the difference between actual and budget (actual_amount - budget_amount). Positive values indicate over-budget, negative values indicate under-budget.',
    `variance_explanation` STRING COMMENT 'Narrative explanation provided by the cost center manager or financial analyst describing the root cause of the variance. Supports management commentary and audit trail requirements.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the budget amount. Calculated as (variance_amount / budget_amount) * 100. Enables relative performance comparison across cost centers.',
    `variance_status` STRING COMMENT 'The current workflow status of the budget variance record. Tracks the review and approval lifecycle from initial identification through management closure.. Valid values are `draft|pending_review|approved|escalated|closed`',
    `variance_threshold_exceeded_flag` BOOLEAN COMMENT 'Indicates whether the variance amount or percentage exceeds the predefined management threshold requiring escalation or additional review. True if threshold exceeded, False otherwise.',
    CONSTRAINT pk_budget_variance PRIMARY KEY(`budget_variance_id`)
) COMMENT 'Periodic budget vs. actual variance records by cost center, account, and financial period. Captures budgeted amount, actual amount posted, variance amount, variance percentage, favorable/unfavorable indicator, variance explanation narrative, reforecast amount, and management commentary. Supports financial performance management, CFO reporting, and board-level financial oversight. Distinct from budget (the plan) as this captures the comparison outcome.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`tax_provision` (
    `tax_provision_id` BIGINT COMMENT 'Unique identifier for the income tax provision record. Primary key for the tax provision entity.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity for which this tax provision is recorded. Each legal entity files separate tax returns and maintains separate tax positions.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tax provisions require named preparer for SOX compliance and audit trails. IRS and state tax filings mandate accountability. Replaces denormalized prepared_by text with proper employee FK for regulato',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Tax provisions are calculated for specific accounting periods as part of financial statement close. Required for GAAP financial reporting, effective tax rate calculation, and deferred tax position dis',
    `audit_status` STRING COMMENT 'Current status of tax authority audit or examination for this tax period. Tracks IRS or state tax authority review lifecycle.. Valid values are `not started|in progress|completed|settled`',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when this tax provision calculation was performed. Used for audit trail and version control.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this tax provision record was first created in the system. Part of standard audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this tax provision record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `current_tax_expense` DECIMAL(18,2) COMMENT 'The portion of total income tax expense attributable to taxes currently payable or refundable for the reporting period. Represents cash tax impact.',
    `dac_temporary_difference` DECIMAL(18,2) COMMENT 'Temporary difference arising from DAC capitalization for GAAP versus immediate deduction for tax. Major source of deferred tax liability for life insurance companies.',
    `deferred_tax_expense` DECIMAL(18,2) COMMENT 'The portion of total income tax expense attributable to changes in deferred tax assets and liabilities. Positive values represent expense; negative values represent benefit.',
    `dta_balance` DECIMAL(18,2) COMMENT 'Total deferred tax asset balance as of the reporting period end. Represents future tax benefits from temporary differences, NOL carryforwards, and tax credit carryforwards.',
    `dtl_balance` DECIMAL(18,2) COMMENT 'Total deferred tax liability balance as of the reporting period end. Represents future tax obligations from temporary differences such as accelerated depreciation and DAC capitalization.',
    `effective_tax_rate` DECIMAL(18,2) COMMENT 'The ratio of total income tax expense to pretax income, expressed as a decimal (e.g., 0.2100 for 21%). Key metric for tax efficiency analysis and rate reconciliation disclosure.',
    `external_auditor_reviewed_flag` BOOLEAN COMMENT 'Indicates whether this tax provision has been reviewed by external auditors as part of financial statement audit procedures.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this tax provision applies (e.g., 2024). Used for multi-year tax analysis and trend reporting.',
    `foreign_tax_expense` DECIMAL(18,2) COMMENT 'Income tax expense attributable to foreign jurisdictions. Includes taxes paid to foreign governments on international operations and investments.',
    `gaap_reporting_basis` STRING COMMENT 'The accounting framework under which this tax provision was prepared (US GAAP, IFRS, or Statutory Accounting Principles).. Valid values are `US GAAP|IFRS|SAP`',
    `irc_7702_adjustment` DECIMAL(18,2) COMMENT 'Tax provision adjustment related to IRC Section 7702 life insurance contract qualification testing. Ensures products meet tax-favored treatment requirements.',
    `ldti_tax_impact` DECIMAL(18,2) COMMENT 'Tax provision impact from FASB ASU 2018-12 LDTI implementation. Captures deferred tax effects of changes in insurance liability measurement and DAC amortization.',
    `net_deferred_tax_position` DECIMAL(18,2) COMMENT 'Net deferred tax asset or liability, calculated as DTA balance minus DTL balance. Positive values indicate net asset; negative values indicate net liability.',
    `nol_carryforward` DECIMAL(18,2) COMMENT 'Tax net operating loss carryforward available to offset future taxable income. Generates deferred tax asset based on expected utilization and statutory tax rate.',
    `notes` STRING COMMENT 'Free-text field for documenting significant assumptions, judgments, tax planning strategies, or unusual items affecting the tax provision. Supports audit documentation requirements.',
    `permanent_difference_adjustment` DECIMAL(18,2) COMMENT 'Tax provision impact from permanent book-tax differences that do not reverse over time (e.g., tax-exempt interest, non-deductible expenses, dividends received deduction).',
    `pretax_income` DECIMAL(18,2) COMMENT 'Income before income taxes per GAAP financial statements. Used as the base for effective tax rate calculation.',
    `provision_date` DATE COMMENT 'The date on which the tax provision was calculated and recorded. Represents the business event timestamp for this tax calculation.',
    `provision_method` STRING COMMENT 'The methodology used to calculate the tax provision for interim periods. Discrete method treats each period independently; annual effective rate method estimates full-year rate.. Valid values are `discrete|annual effective rate|interim estimate`',
    `provision_status` STRING COMMENT 'Current lifecycle status of the tax provision record. Tracks progression from initial draft through final audited state.. Valid values are `draft|preliminary|final|amended|audited`',
    `rate_change_impact` DECIMAL(18,2) COMMENT 'Impact on deferred tax balances from changes in enacted tax rates. Requires remeasurement of deferred tax assets and liabilities at new rates.',
    `reserve_temporary_difference` DECIMAL(18,2) COMMENT 'Temporary difference between GAAP insurance reserves and tax reserves. Reflects differences in reserve calculation methodologies between financial reporting and tax compliance.',
    `return_to_provision_adjustment` DECIMAL(18,2) COMMENT 'Adjustment to reconcile prior period tax provision estimates to actual amounts reported on filed tax returns. Recorded when tax returns are finalized.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the senior tax professional who reviewed and approved this tax provision. Required for segregation of duties.',
    `sox_control_certification` BOOLEAN COMMENT 'Indicates whether this tax provision has been reviewed and certified under SOX Section 404 internal control requirements. Required for public companies.',
    `state_tax_expense` DECIMAL(18,2) COMMENT 'Income tax expense attributable to state and local jurisdictions. Tracked separately from federal tax for rate reconciliation and multi-state tax planning.',
    `statutory_tax_rate` DECIMAL(18,2) COMMENT 'The federal statutory corporate income tax rate applicable to the reporting period (e.g., 0.2100 for 21% under IRC Section 11). Starting point for effective tax rate reconciliation.',
    `tax_credit_carryforward` DECIMAL(18,2) COMMENT 'Tax credits available to reduce future tax liabilities, including general business credits, foreign tax credits, and alternative minimum tax credits. Generates deferred tax asset.',
    `tax_return_filed_flag` BOOLEAN COMMENT 'Indicates whether the tax return for this period has been filed with tax authorities. True when return is filed; False when provision is estimated.',
    `total_tax_expense` DECIMAL(18,2) COMMENT 'Total income tax expense for the period, calculated as the sum of current tax expense and deferred tax expense. Reported on the GAAP income statement.',
    `unrealized_gain_temporary_difference` DECIMAL(18,2) COMMENT 'Temporary difference from unrealized gains and losses on investments recognized in GAAP financial statements but not yet taxable. Includes available-for-sale securities and fair value adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this tax provision record was last modified. Tracks all subsequent changes after initial creation.',
    `utp_reserve` DECIMAL(18,2) COMMENT 'Reserve for unrecognized tax benefits under ASC 740-10 (formerly FIN 48). Represents tax positions that do not meet the more-likely-than-not recognition threshold.',
    `valuation_allowance` DECIMAL(18,2) COMMENT 'Contra-asset account reducing deferred tax assets to the amount that is more-likely-than-not to be realized. Reflects management judgment on future taxable income sufficiency.',
    CONSTRAINT pk_tax_provision PRIMARY KEY(`tax_provision_id`)
) COMMENT 'Income tax provision records by legal entity and reporting period. Captures current tax expense, deferred tax expense/benefit, effective tax rate, deferred tax asset (DTA) balance, deferred tax liability (DTL) balance, valuation allowance, uncertain tax position (UTP) reserve under ASC 740-10, temporary difference components (DAC, reserves, unrealized gains), IRC Section 7702 tax compliance impact, and tax return-to-provision true-up. Supports GAAP income tax footnote disclosure and statutory tax exhibit.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` (
    `reinsurance_recoverable_id` BIGINT COMMENT 'Primary key for reinsurance_recoverable',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: reinsurance_recoverable has gl_account_code (STRING) and should FK to chart_of_accounts. Recoverables are booked to GL accounts; FK is essential for financial statement classification and RBC reportin',
    `claim_id` BIGINT COMMENT 'Identifier of the underlying claim to which this recoverable relates, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: reinsurance_recoverable has cost_center_code (STRING) and should FK to cost_center. Recoverables are allocated to cost centers for expense management; FK enables cost allocation tracking.',
    `in_force_policy_id` BIGINT COMMENT 'Identifier of the underlying insurance policy to which this recoverable relates, if applicable.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: reinsurance_recoverable has journal_entry_number (STRING) representing the JE that posted the recoverable. FK to journal_entry provides critical audit trail linking reinsurance accounting to financial',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: reinsurance_recoverable has legal_entity_code (STRING) and should FK to legal_entity. Recoverables are owned by legal entities; FK is essential for statutory reporting, RBC calculations, and credit ri',
    `reinsurance_treaty_id` BIGINT COMMENT 'Identifier of the reinsurance treaty under which this recoverable arises.',
    `reinsurer_id` BIGINT COMMENT 'Identifier of the reinsurer counterparty from whom the recoverable is due.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Reinsurance recoverables require treaty documents, bordereaux, and collateral agreements for collectibility assessment. Quarterly reinsurance accounting and credit risk assessment depend on linking re',
    `accounting_basis` STRING COMMENT 'The accounting framework under which this recoverable balance is reported: Statutory Accounting Principles (SAP), Generally Accepted Accounting Principles (GAAP), International Financial Reporting Standards 17 (IFRS17), or tax basis.. Valid values are `SAP|GAAP|IFRS17|tax`',
    `accounting_period` STRING COMMENT 'The accounting period (YYYY-MM format) to which this recoverable balance applies.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `aging_bucket` STRING COMMENT 'The aging category of the recoverable based on the number of days outstanding since the recoverable became due.. Valid values are `current|30_days|60_days|90_days|over_90_days`',
    `allowance_for_uncollectible` DECIMAL(18,2) COMMENT 'The estimated amount of the gross recoverable that may not be collectible due to reinsurer credit risk, recorded as a contra-asset.',
    `approval_status` STRING COMMENT 'The approval workflow status of this recoverable balance entry: draft, pending approval, approved, or rejected.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'The name or identifier of the individual who approved this recoverable balance for financial reporting.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this recoverable balance was approved for financial reporting.',
    `collateral_held_amount` DECIMAL(18,2) COMMENT 'The total value of collateral held to secure the recoverable, including letters of credit, trust accounts, and funds withheld.',
    `collateral_type` STRING COMMENT 'The form of collateral securing the recoverable: letter of credit (LOC), trust account, funds withheld at source, or none.. Valid values are `letter_of_credit|trust_account|funds_withheld|none`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this recoverable balance record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the recoverable amounts are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `days_outstanding` STRING COMMENT 'The number of calendar days the recoverable has been outstanding since it became due for payment.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (Q1, Q2, Q3, Q4) to which this recoverable balance applies for quarterly financial reporting.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this recoverable balance applies for annual financial reporting.',
    `gaap_classification` STRING COMMENT 'The balance sheet classification of the recoverable under GAAP: current asset (collectible within 12 months) or non-current asset.. Valid values are `current_asset|non_current_asset`',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this recoverable balance is posted in the chart of accounts.',
    `gross_recoverable_amount` DECIMAL(18,2) COMMENT 'The total amount recoverable from the reinsurer before any allowance for uncollectible reinsurance or offsets.',
    `ifrs17_csm_impact` DECIMAL(18,2) COMMENT 'The impact of this recoverable on the Contractual Service Margin under IFRS 17 accounting for insurance contracts.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this recoverable balance record was last modified or updated.',
    `net_recoverable_amount` DECIMAL(18,2) COMMENT 'The net recoverable balance after deducting the allowance for uncollectible reinsurance from the gross recoverable amount.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, explanations, or special circumstances related to this recoverable balance.',
    `posted_timestamp` TIMESTAMP COMMENT 'The date and time when this recoverable balance was posted to the general ledger.',
    `product_line_code` STRING COMMENT 'The product line code (e.g., term life, whole life, annuity) to which this recoverable relates for segment reporting.',
    `rbc_category` STRING COMMENT 'The Risk-Based Capital category assigned to this recoverable for statutory capital adequacy calculations.',
    `recoverable_status` STRING COMMENT 'The current lifecycle status of the recoverable: billed to reinsurer, unbilled (accrued but not yet invoiced), disputed, collected, or written off.. Valid values are `billed|unbilled|disputed|collected|written_off`',
    `recoverable_type` STRING COMMENT 'Classification of the recoverable by its nature: ceded reserve, ceded claim payment, ceded premium refund, ceded benefit, or ceded commission.. Valid values are `ceded_reserve|ceded_claim|ceded_premium|ceded_benefit|ceded_commission`',
    `reinsurer_credit_rating` STRING COMMENT 'The financial strength rating of the reinsurer as assigned by AM Best or equivalent rating agency (e.g., A++, A+, A, B++, NR for not rated).. Valid values are `^[A-D][+-]?$|NR`',
    `sap_exhibit_line` STRING COMMENT 'The specific line item on the NAIC Annual Statement Schedule F or other exhibit where this recoverable is reported.',
    `source_system` STRING COMMENT 'The name or code of the source system from which this recoverable balance originated (e.g., reinsurance management system, actuarial valuation system).',
    `sox_controlled_flag` BOOLEAN COMMENT 'Indicates whether this recoverable balance is subject to SOX internal control testing and audit procedures.',
    `valuation_date` DATE COMMENT 'The as-of date for which this recoverable balance was calculated and recorded.',
    CONSTRAINT pk_reinsurance_recoverable PRIMARY KEY(`reinsurance_recoverable_id`)
) COMMENT 'SSOT for finance-booked reinsurance recoverable balances from ceded reinsurance treaties. Captures reinsurer name, treaty reference, recoverable type (ceded reserve, ceded claim, ceded premium), gross recoverable amount, allowance for uncollectible reinsurance, net recoverable balance, credit quality of reinsurer (AM Best rating), collateral held (LOC, trust, funds withheld), SAP vs. GAAP recoverable basis, and aging of recoverable. Supports statutory balance sheet Schedule F reporting, GAAP reinsurance accounting under ASC 944, and counterparty credit risk management. Distinct from reinsurance domain treaty administration — this product owns the finance-booked recoverable position for financial statement presentation.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`embedded_value` (
    `embedded_value_id` BIGINT COMMENT 'Unique identifier for the embedded value record. Primary key for the embedded value data product.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Embedded value calculations require detailed actuarial reports, assumption documentation, and board presentation materials. Annual EV reporting for investor disclosure depends on linking calculations ',
    `employee_id` BIGINT COMMENT 'Reference to the user (typically CFO, Chief Actuary, or designated approver) who approved this embedded value calculation for reporting.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity for which embedded value is calculated. Links to the legal entity master data.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Embedded value calculations are product-specific for investor reporting and M&A valuations. Required for value of in-force (VIF) calculation, new business value reporting, and strategic product portfo',
    `report_period_id` BIGINT COMMENT 'Reference to the reporting period for this embedded value calculation. Links to the reporting period dimension.',
    `valuation_run_id` BIGINT COMMENT 'Reference to the actuarial valuation run that produced the cash flow projections and assumptions used in this embedded value calculation.',
    `prior_period_embedded_value_id` BIGINT COMMENT 'Self-referencing FK on embedded_value (prior_period_embedded_value_id)',
    `adjusted_net_worth` DECIMAL(18,2) COMMENT 'The market value of shareholders net assets allocated to the covered business, adjusted for inadmissible assets and other regulatory restrictions. Represents the tangible equity supporting the in-force business.',
    `approval_date` DATE COMMENT 'The date on which this embedded value calculation was formally approved by management or the appointed actuary for reporting purposes.',
    `assumption_change_impact` DECIMAL(18,2) COMMENT 'The change in embedded value resulting from updates to actuarial assumptions (mortality tables, lapse rates, expense levels, discount rates) applied to the in-force business.',
    `calculation_status` STRING COMMENT 'Current status of the embedded value calculation in the approval workflow. Tracks progression from draft through review, approval, and publication.. Valid values are `Draft|Under Review|Approved|Published|Restated`',
    `capital_movements` DECIMAL(18,2) COMMENT 'Net capital injections or distributions during the reporting period, including dividends paid, capital contributions, and intercompany transfers affecting embedded value.',
    `closing_embedded_value` DECIMAL(18,2) COMMENT 'The embedded value at the end of the reporting period. Sum of adjusted net worth and value of in-force business.',
    `cost_of_required_capital` DECIMAL(18,2) COMMENT 'The cost of holding required capital above the risk-free rate, reflecting the frictional cost of capital that cannot be freely distributed. Deducted from VIF calculation.',
    `covered_business_indicator` BOOLEAN COMMENT 'Flag indicating whether this business segment is included in the embedded value covered business scope. True if included in EV calculation, False if excluded.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this embedded value record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the embedded value amounts (e.g., USD, EUR, GBP). All monetary values in this record are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `economic_variance` DECIMAL(18,2) COMMENT 'The change in embedded value due to changes in economic conditions, including interest rate movements, equity market performance, credit spreads, and foreign exchange rates.',
    `expected_return` DECIMAL(18,2) COMMENT 'The expected increase in embedded value from unwinding of discount rates and expected in-force business performance, assuming no changes in assumptions or experience.',
    `experience_variance` DECIMAL(18,2) COMMENT 'The change in embedded value due to differences between actual experience and expected assumptions (mortality, lapse, expense, investment returns) during the reporting period.',
    `external_audit_reviewed_flag` BOOLEAN COMMENT 'Indicates whether this embedded value calculation has been reviewed by external auditors. True if audited, False if not yet reviewed.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter within the year for this embedded value calculation (Q1, Q2, Q3, Q4). Some companies report embedded value quarterly, others annually.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this embedded value calculation applies, typically matching the calendar year for insurance companies.',
    `free_surplus` DECIMAL(18,2) COMMENT 'The portion of adjusted net worth that exceeds required capital and is available for distribution to shareholders or investment in new business.',
    `frictional_costs` DECIMAL(18,2) COMMENT 'The present value of costs associated with holding required capital, including investment management expenses, tax on investment income, and other costs that reduce distributable earnings.',
    `investor_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this embedded value calculation has been publicly disclosed to investors in financial reports or investor presentations. True if disclosed, False if internal only.',
    `new_business_value` DECIMAL(18,2) COMMENT 'The value added from new business written during the reporting period, calculated as the present value of future profits from new policies net of required capital costs.',
    `notes` STRING COMMENT 'Free-text field for additional commentary, explanations of significant movements, methodology notes, or other relevant information about this embedded value calculation.',
    `opening_embedded_value` DECIMAL(18,2) COMMENT 'The embedded value at the beginning of the reporting period. Starting point for the embedded value movement analysis.',
    `other_operating_variance` DECIMAL(18,2) COMMENT 'Changes in embedded value from other operating items not classified elsewhere, including model changes, methodology refinements, and one-time adjustments.',
    `product_line_code` STRING COMMENT 'Code identifying the product line segment for which embedded value is reported (e.g., term life, whole life, universal life, annuities, group insurance).',
    `reference_rate` DECIMAL(18,2) COMMENT 'The risk-free reference rate used to discount future cash flows in the embedded value calculation, typically based on government bond yields or swap rates.',
    `reporting_basis` STRING COMMENT 'The embedded value methodology applied: Market Consistent Embedded Value (MCEV), European Embedded Value (EEV), Traditional Embedded Value, or Appraisal Value.. Valid values are `MCEV|EEV|Traditional EV|Appraisal Value`',
    `required_capital_amount` DECIMAL(18,2) COMMENT 'The amount of capital required to support the in-force business, based on regulatory requirements (RBC), economic capital models, or internal capital adequacy standards.',
    `risk_discount_rate` DECIMAL(18,2) COMMENT 'The discount rate applied to non-hedgeable risks in the embedded value calculation, reflecting the cost of capital for insurance risk, operational risk, and other non-market risks.',
    `sensitivity_test_performed_flag` BOOLEAN COMMENT 'Indicates whether sensitivity testing has been performed on this embedded value calculation to assess impact of assumption changes and economic shocks. True if sensitivity analysis completed.',
    `stochastic_scenario_count` STRING COMMENT 'The number of stochastic economic scenarios used to calculate the time value of financial options and guarantees (TVFOG). Typically 1,000 to 10,000 scenarios for market-consistent valuation.',
    `time_value_financial_options_guarantees` DECIMAL(18,2) COMMENT 'The market-consistent value of embedded options and guarantees in insurance contracts (e.g., minimum death benefits, guaranteed annuity rates, surrender options), calculated using stochastic modeling.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this embedded value record was last modified. Audit trail for tracking changes to the calculation.',
    `valuation_date` DATE COMMENT 'The as-of date for which the embedded value is calculated. Typically the end of a reporting period (quarter-end or year-end).',
    `value_of_in_force` DECIMAL(18,2) COMMENT 'The present value of future distributable earnings from the in-force covered business, net of cost of required capital and frictional costs. Core component of embedded value representing future profit streams.',
    CONSTRAINT pk_embedded_value PRIMARY KEY(`embedded_value_id`)
) COMMENT 'Embedded value and Market Consistent Embedded Value (MCEV) reporting by legal entity, product line, and reporting period. Captures value of in-force (VIF), adjusted net worth (ANW), cost of required capital, time value of financial options and guarantees (TVFOG), frictional costs, new business value (NBV), and movement analysis (opening to closing EV). Supports international reporting standards (CFO Forum MCEV Principles), investor disclosures, and management value-based performance metrics for life insurance operations.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` (
    `entity_vendor_contract_id` BIGINT COMMENT 'Unique identifier for this legal entity-vendor contractual relationship',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to the legal entity that has entered into the vendor contract',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing services under this contract',
    `contract_end_date` DATE COMMENT 'The date when the contract between this legal entity and vendor expires or terminates',
    `contract_owner_name` STRING COMMENT 'The name of the business owner or relationship manager within the legal entity responsible for this vendor relationship',
    `contract_start_date` DATE COMMENT 'The date when the contract between this legal entity and vendor becomes effective',
    `contract_status` STRING COMMENT 'Current lifecycle status of this specific legal entity-vendor contract',
    `payment_terms` STRING COMMENT 'Entity-specific payment terms negotiated for this vendor relationship, indicating payment timing obligations',
    `preferred_status` BOOLEAN COMMENT 'Indicates whether this vendor holds preferred status for this legal entity, affecting procurement priority and terms',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether this vendor relationship must be disclosed in statutory filings or regulatory reports for this legal entity',
    `service_category` STRING COMMENT 'The category of services this vendor provides to this specific legal entity under this contract',
    `spend_amount` DECIMAL(18,2) COMMENT 'The total annual spend or contract value for this legal entity-vendor relationship, used for consolidated reporting and vendor risk assessment',
    CONSTRAINT pk_entity_vendor_contract PRIMARY KEY(`entity_vendor_contract_id`)
) COMMENT 'This association product represents the contractual relationship between a legal entity within the insurance holding company structure and an external vendor or service provider. It captures entity-specific contract terms, payment arrangements, service scope, and spend tracking. Each record links one legal entity to one vendor with attributes that exist only in the context of this specific engagement, supporting multi-entity vendor management, consolidated spend reporting, and regulatory vendor oversight.. Existence Justification: In life insurance holding company structures, multiple legal entities (life insurers, reinsurers, broker-dealers, service companies) routinely contract with the same vendors (medical exam providers, TPAs, custodians, data providers) for services, and each vendor serves multiple legal entities across the holding company. Each legal entity-vendor relationship has distinct contract terms, payment arrangements, service scope, and spend tracking requirements driven by separate legal liability, entity-specific regulatory reporting, and statutory accounting by entity.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` (
    `cost_center_vendor_engagement_id` BIGINT COMMENT 'Unique identifier for this cost center-vendor engagement relationship. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to the cost center that engages this vendor',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor engaged by this cost center',
    `approval_authority` STRING COMMENT 'The employee ID or role authorized to approve vendor engagements and expenditures for this cost center-vendor relationship. May differ from the cost center manager for specialized vendor relationships.',
    `budget_allocation` DECIMAL(18,2) COMMENT 'The budget amount allocated by this cost center for this specific vendor relationship for the current fiscal period. Supports departmental vendor budget tracking and variance analysis.',
    `engagement_end_date` DATE COMMENT 'The date when this cost center ceased engaging this vendor, if applicable. Null indicates an active ongoing relationship.',
    `engagement_start_date` DATE COMMENT 'The date when this cost center began engaging this vendor for services. Supports historical tracking of vendor relationships by department.',
    `engagement_status` STRING COMMENT 'Current lifecycle status of this cost center-vendor engagement relationship.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which the budget allocation and spend amount are applicable. Four-digit year (e.g., 2024).',
    `notes` STRING COMMENT 'Free-text notes about this specific cost center-vendor engagement relationship for internal reference and documentation.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is designated as a preferred vendor for this cost center for the specified service category. Supports procurement policy enforcement and vendor consolidation strategies.',
    `service_category` STRING COMMENT 'The category of services this vendor provides to this specific cost center. A vendor may provide different service categories to different cost centers (e.g., IT services to operations, consulting to corporate).',
    `spend_amount` DECIMAL(18,2) COMMENT 'The actual amount spent by this cost center with this vendor during the current fiscal period. Used for budget vs. actual variance reporting and vendor spend analysis by department.',
    CONSTRAINT pk_cost_center_vendor_engagement PRIMARY KEY(`cost_center_vendor_engagement_id`)
) COMMENT 'This association product represents the operational engagement relationship between cost centers and vendors in the life insurance enterprise. It captures departmental vendor assignments, budget allocations, spend tracking, service categorization, and approval authority for vendor relationships at the cost center level. Each record links one cost center to one vendor with attributes that exist only in the context of this specific engagement relationship, supporting expense allocation, vendor management, and departmental procurement oversight.. Existence Justification: In life insurance operations, cost centers (departments, business units, product lines, distribution channels) engage multiple vendors for different services - IT may use multiple software vendors, underwriting may use multiple medical exam providers, and investment operations may use multiple custodians. Conversely, vendors serve multiple cost centers across the enterprise - ExamOne provides services to multiple underwriting departments, a reinsurance intermediary serves multiple product lines, and an IT vendor supports multiple business units. The business actively manages these relationships with cost center-specific budgets, spend tracking, service categorization, and approval authorities.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`finance`.`netting_group` (
    `netting_group_id` BIGINT COMMENT 'Primary key for netting_group',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for managing and reconciling this netting group.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the primary legal entity that owns or manages this netting group for statutory reporting purposes.',
    `parent_netting_group_id` BIGINT COMMENT 'Reference to a parent netting group if this group is part of a hierarchical netting structure. Null for top-level groups.',
    `approval_status` STRING COMMENT 'Current approval workflow status for the netting group configuration, ensuring proper authorization before activation.',
    `approved_by` STRING COMMENT 'Name or identifier of the user who approved the netting group configuration for use in financial processing.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the netting group configuration was approved, supporting audit trail requirements.',
    `netting_group_code` STRING COMMENT 'Business identifier code for the netting group used in financial reporting and intercompany settlement processes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the netting group record was first created in the system.',
    `dac_asset_tracking_flag` BOOLEAN COMMENT 'Indicates whether this netting group is used to track Deferred Acquisition Cost (DAC) assets for amortization and reporting.',
    `netting_group_description` STRING COMMENT 'Detailed description of the netting group purpose, scope, and business rationale for grouping entities or accounts.',
    `effective_date` DATE COMMENT 'Date from which the netting group becomes active and applicable for financial transactions and reporting.',
    `expiration_date` DATE COMMENT 'Date on which the netting group ceases to be active. Null for open-ended netting groups.',
    `external_reference_code` STRING COMMENT 'External system or third-party identifier for this netting group, used for reconciliation with external platforms.',
    `gaap_reporting_flag` BOOLEAN COMMENT 'Indicates whether this netting group is included in GAAP financial reporting for external stakeholders.',
    `gl_account_code` STRING COMMENT 'Chart of accounts code to which netting group balances are posted in the general ledger.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the netting group hierarchy, with 1 representing the top level and increasing numbers for nested groups.',
    `ifrs17_reporting_flag` BOOLEAN COMMENT 'Indicates whether this netting group is included in IFRS 17 insurance contract reporting.',
    `intercompany_settlement_flag` BOOLEAN COMMENT 'Indicates whether this netting group is used for intercompany settlement and elimination entries.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the netting group record was last modified, supporting change tracking and audit requirements.',
    `netting_group_name` STRING COMMENT 'Full descriptive name of the netting group for human-readable identification in financial statements and reports.',
    `netting_method` STRING COMMENT 'The methodology applied for netting transactions within this group, defining how offsetting positions are calculated.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special instructions, or context related to the netting group.',
    `rbc_calculation_flag` BOOLEAN COMMENT 'Indicates whether this netting group is included in Risk-Based Capital (RBC) regulatory calculations.',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which netting group balances are reported for financial statements.',
    `sap_reporting_flag` BOOLEAN COMMENT 'Indicates whether this netting group is included in statutory (SAP) financial reporting to insurance regulators.',
    `settlement_frequency` STRING COMMENT 'Frequency at which netting group balances are settled between participating entities or accounts.',
    `sox_controlled_flag` BOOLEAN COMMENT 'Indicates whether this netting group is subject to SOX internal controls and audit requirements.',
    `netting_group_status` STRING COMMENT 'Current lifecycle status of the netting group indicating whether it is actively used in financial processing.',
    `netting_group_type` STRING COMMENT 'Classification of the netting group based on its functional purpose within the financial close and settlement processes.',
    CONSTRAINT pk_netting_group PRIMARY KEY(`netting_group_id`)
) COMMENT 'Master reference table for netting_group. Referenced by netting_group_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_reversed_entry_journal_entry_id` FOREIGN KEY (`reversed_entry_journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_dac_asset_id` FOREIGN KEY (`dac_asset_id`) REFERENCES `life_insurance_ecm`.`finance`.`dac_asset`(`dac_asset_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_ifrs17_contract_group_id` FOREIGN KEY (`ifrs17_contract_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`ifrs17_contract_group`(`ifrs17_contract_group_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_reversed_line_journal_entry_line_id` FOREIGN KEY (`reversed_line_journal_entry_line_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_primary_ultimate_parent_entity_legal_entity_id` FOREIGN KEY (`primary_ultimate_parent_entity_legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ADD CONSTRAINT `fk_finance_dac_amortization_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ADD CONSTRAINT `fk_finance_dac_amortization_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ADD CONSTRAINT `fk_finance_dac_amortization_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ADD CONSTRAINT `fk_finance_gaap_reserve_ifrs17_contract_group_id` FOREIGN KEY (`ifrs17_contract_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`ifrs17_contract_group`(`ifrs17_contract_group_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ADD CONSTRAINT `fk_finance_ifrs17_contract_group_reinsurance_contract_group_id` FOREIGN KEY (`reinsurance_contract_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`ifrs17_contract_group`(`ifrs17_contract_group_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ADD CONSTRAINT `fk_finance_ifrs17_measurement_ifrs17_contract_group_id` FOREIGN KEY (`ifrs17_contract_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`ifrs17_contract_group`(`ifrs17_contract_group_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ADD CONSTRAINT `fk_finance_rbc_calculation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_netting_group_id` FOREIGN KEY (`netting_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`netting_group`(`netting_group_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_receiving_legal_entity_id` FOREIGN KEY (`receiving_legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ADD CONSTRAINT `fk_finance_budget_variance_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ADD CONSTRAINT `fk_finance_budget_variance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ADD CONSTRAINT `fk_finance_budget_variance_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ADD CONSTRAINT `fk_finance_reinsurance_recoverable_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ADD CONSTRAINT `fk_finance_reinsurance_recoverable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ADD CONSTRAINT `fk_finance_reinsurance_recoverable_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ADD CONSTRAINT `fk_finance_reinsurance_recoverable_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ADD CONSTRAINT `fk_finance_embedded_value_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ADD CONSTRAINT `fk_finance_embedded_value_prior_period_embedded_value_id` FOREIGN KEY (`prior_period_embedded_value_id`) REFERENCES `life_insurance_ecm`.`finance`.`embedded_value`(`embedded_value_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` ADD CONSTRAINT `fk_finance_entity_vendor_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` ADD CONSTRAINT `fk_finance_cost_center_vendor_engagement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`netting_group` ADD CONSTRAINT `fk_finance_netting_group_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`netting_group` ADD CONSTRAINT `fk_finance_netting_group_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`netting_group` ADD CONSTRAINT `fk_finance_netting_group_parent_netting_group_id` FOREIGN KEY (`parent_netting_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`netting_group`(`netting_group_id`);

-- ========= TAGS =========
ALTER SCHEMA `life_insurance_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `life_insurance_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Entry ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `cohort_code` SET TAGS ('dbx_business_glossary_term' = 'IFRS 17 Cohort Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `source_system_key` SET TAGS ('dbx_business_glossary_term' = 'Source System Natural Key');
ALTER TABLE `life_insurance_ecm`.`finance`.`general_ledger` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_entry_journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Journal Entry Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `accounting_basis` SET TAGS ('dbx_business_glossary_term' = 'Accounting Basis');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `accounting_basis` SET TAGS ('dbx_value_regex' = 'SAP|GAAP|IFRS17|TAX');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_category` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Category');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Number');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|reversed|rejected');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Type');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'standard|adjusting|reversing|closing|opening|reclassification');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_currency_credit` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Credit Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_currency_debit` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Debit Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `ifrs17_measurement_model` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) 17 Measurement Model');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `ifrs17_measurement_model` SET TAGS ('dbx_value_regex' = 'GMM|PAA|VFA');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Entity Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Description');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `ldti_indicator` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `pbr_indicator` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `preparer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `sox_control_reference` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Reference');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `dac_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Asset Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `ifrs17_contract_group_id` SET TAGS ('dbx_business_glossary_term' = 'IFRS 17 Insurance Contract Group Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reinsurance_treaty_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Treaty Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_line_journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Journal Entry Line Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tertiary_journal_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tertiary_journal_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tertiary_journal_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'GAAP|SAP|IFRS');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit Credit Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `intercompany_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Partner Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_type` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Type');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_type` SET TAGS ('dbx_value_regex' = 'standard|adjusting|closing|reversing|reclassification|elimination');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_source_system` SET TAGS ('dbx_business_glossary_term' = 'Journal Source System');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reinsurance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reinsurance_indicator` SET TAGS ('dbx_value_regex' = 'direct|ceded|assumed');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reporting_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'Account Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_subtype` SET TAGS ('dbx_business_glossary_term' = 'Account Subtype');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense|contra');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `approval_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `budget_indicator` SET TAGS ('dbx_business_glossary_term' = 'Budget Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cash_flow_statement_category` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Statement Category');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cash_flow_statement_category` SET TAGS ('dbx_value_regex' = 'operating|investing|financing');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_center_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Required Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `dac_eligible_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Eligible Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `external_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_line` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Line');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `gaap_classification` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Classification');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `ifrs17_classification` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) 17 Classification');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `ldti_indicator` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `normal_balance` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `normal_balance` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_account_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `posting_allowed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Posting Allowed Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `product_line_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Product Line Required Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `rbc_line_mapping` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Line Mapping');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `reconciliation_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Required Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `rollup_indicator` SET TAGS ('dbx_business_glossary_term' = 'Rollup Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `sap_classification` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Classification');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `sox_control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Category');
ALTER TABLE `life_insurance_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `distribution_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `product_line_id` SET TAGS ('dbx_business_glossary_term' = 'Product Line Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `queue_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Queue Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'headcount|premium_volume|policy_count|aum|square_footage|direct');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|step_down|reciprocal|activity_based');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_entity_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Entity Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'operational|administrative|distribution|product|investment|claims');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `dac_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `external_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `gaap_expense_category` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Expense Category');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Hierarchy Level');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `intercompany_settlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Settlement Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Notes');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `rbc_category` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Category');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `rbc_category` SET TAGS ('dbx_value_regex' = 'c1|c2|c3|c4|not_applicable');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `sap_expense_exhibit` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Expense Exhibit');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `sox_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Controlled Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `parent_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Legal Entity Identifier');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_ultimate_parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Entity Identifier');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `am_best_rating` SET TAGS ('dbx_business_glossary_term' = 'A.M. Best Financial Strength Rating');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `am_best_rating_date` SET TAGS ('dbx_business_glossary_term' = 'A.M. Best Rating Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_value_regex' = 'full|proportional|equity_method|not_consolidated');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `domicile_country` SET TAGS ('dbx_business_glossary_term' = 'Domicile Country');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `domicile_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `domicile_state` SET TAGS ('dbx_business_glossary_term' = 'Domicile State or Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_business_glossary_term' = 'Entity Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|dissolved|merged|in_runoff|suspended');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'life_insurer|holding_company|reinsurer|broker_dealer|service_company|investment_subsidiary');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `fein` SET TAGS ('dbx_business_glossary_term' = 'Federal Employer Identification Number (FEIN)');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `fein` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `fein` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `fein` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `finra_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Member Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `functional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `gaap_reporting_entity_flag` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Reporting Entity Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `ifrs17_reporting_entity_flag` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) 17 Reporting Entity Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `intercompany_elimination_group` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Group');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `lei_registration_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Registration Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `lei_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Renewal Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `license_effective_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Company Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_regulator` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Authority');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `rbc_filing_entity_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Filing Entity Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country` SET TAGS ('dbx_business_glossary_term' = 'Registered Country');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state` SET TAGS ('dbx_business_glossary_term' = 'Registered State or Province');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `regulatory_license_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory License Number');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `sap_reporting_entity_flag` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Reporting Entity Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `sec_registrant_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Registrant Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Short Name');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `sox_scope_entity_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Scope Entity Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`legal_entity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` SET TAGS ('dbx_subdomain' = 'insurance_valuation');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `dac_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Asset ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Assumption Set ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `actual_amortization_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amortization Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `amortization_method` SET TAGS ('dbx_business_glossary_term' = 'Amortization Method');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `amortization_method` SET TAGS ('dbx_value_regex' = 'GAAP Interest-Related|LDTI Straight-Line|IFRS 17 CSM-Based|Other');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `cumulative_amortization_balance` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Amortization Balance');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `dac_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Asset Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `dac_asset_status` SET TAGS ('dbx_value_regex' = 'Active|Fully Amortized|Impaired|Terminated|Under Review');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `dac_capitalized_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Capitalized Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `external_audit_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Reviewed Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `gaap_reporting_basis` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Reporting Basis');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `gaap_reporting_basis` SET TAGS ('dbx_value_regex' = 'US GAAP|IFRS|Statutory|Other');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `ifrs17_acquisition_cash_flow_asset` SET TAGS ('dbx_business_glossary_term' = 'IFRS 17 Insurance Acquisition Cash Flow Asset');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `ifrs17_acquisition_cash_flow_release` SET TAGS ('dbx_business_glossary_term' = 'IFRS 17 Insurance Acquisition Cash Flow Release');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `impairment_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `impairment_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `interest_accretion_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Accretion Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `issue_year` SET TAGS ('dbx_business_glossary_term' = 'Issue Year');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `last_amortization_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amortization Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `ldti_cohort_grouping_key` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Cohort Grouping Key');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'Reconciled|Pending|Variance Identified|Under Investigation');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `scheduled_amortization_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Amortization Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `shadow_dac_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Shadow Deferred Acquisition Cost (DAC) Adjustment');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `unamortized_dac_balance` SET TAGS ('dbx_business_glossary_term' = 'Unamortized Deferred Acquisition Cost (DAC) Balance');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `variance_from_prior_period` SET TAGS ('dbx_business_glossary_term' = 'Variance from Prior Period');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `voba_amortization_amount` SET TAGS ('dbx_business_glossary_term' = 'Value of Business Acquired (VOBA) Amortization Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ALTER COLUMN `voba_component_amount` SET TAGS ('dbx_business_glossary_term' = 'Value of Business Acquired (VOBA) Component Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` SET TAGS ('dbx_subdomain' = 'insurance_valuation');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `dac_amortization_id` SET TAGS ('dbx_business_glossary_term' = 'Dac Amortization Identifier');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Valuation Run ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Cohort ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `actual_amortization_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amortization Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `adjustment_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Description');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = 'scheduled|true_up|assumption_change|cohort_reclass|error_correction|policy_termination');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `amortization_date` SET TAGS ('dbx_business_glossary_term' = 'Amortization Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `amortization_method` SET TAGS ('dbx_business_glossary_term' = 'Amortization Method');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `amortization_method` SET TAGS ('dbx_value_regex' = 'straight_line|proportional_to_premium|proportional_to_egp|proportional_to_margin');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|posted|rejected');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `cumulative_amortization_balance` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Amortization Balance');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `gaap_amortization_amount` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Amortization Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `ifrs17_amortization_amount` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) 17 Amortization Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `interest_accretion_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Accretion Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `remaining_dac_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Deferred Acquisition Cost (DAC) Balance');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `sap_amortization_amount` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Amortization Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `scheduled_amortization_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Amortization Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `shadow_dac_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Shadow Deferred Acquisition Cost (DAC) Adjustment');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `variance_from_prior_period` SET TAGS ('dbx_business_glossary_term' = 'Variance from Prior Period');
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ALTER COLUMN `voba_amortization_amount` SET TAGS ('dbx_business_glossary_term' = 'Value of Business Acquired (VOBA) Amortization Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` SET TAGS ('dbx_subdomain' = 'insurance_valuation');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `statutory_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Reserve ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `actuarial_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Sign-Off Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Statutory Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `appointed_actuary_name` SET TAGS ('dbx_business_glossary_term' = 'Appointed Actuary Name');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `appointed_actuary_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `carvm_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Commissioners Annuity Reserve Valuation Method (CARVM) Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `cohort_identifier` SET TAGS ('dbx_business_glossary_term' = 'Cohort Identifier');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `crvm_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Commissioners Reserve Valuation Method (CRVM) Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `cso_mortality_table_code` SET TAGS ('dbx_business_glossary_term' = 'Commissioners Standard Ordinary (CSO) Mortality Table Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `cso_mortality_table_code` SET TAGS ('dbx_value_regex' = '2017CSO|2001CSO|1980CSO|2012IAM|CUSTOM');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `deficiency_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `exhibit_line_number` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Line Number');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `gaap_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `ifrs17_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards 17 (IFRS 17) Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `management_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Management Approval Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `net_amount_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR)');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `net_statutory_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Statutory Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `pbr_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `prior_period_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `rbc_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Contribution Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `reinsurance_ceded_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Ceded Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `reserve_adequacy_margin` SET TAGS ('dbx_business_glossary_term' = 'Reserve Adequacy Margin');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `reserve_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Reserve Basis Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `reserve_basis_code` SET TAGS ('dbx_value_regex' = 'PBR|CRVM|CARVM|NET_PREMIUM|MODIFIED_RESERVE');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `reserve_calculation_method_description` SET TAGS ('dbx_business_glossary_term' = 'Reserve Calculation Method Description');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `reserve_category` SET TAGS ('dbx_business_glossary_term' = 'Reserve Category');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `reserve_category` SET TAGS ('dbx_value_regex' = 'LIFE|ANNUITY|ACCIDENT_HEALTH|DEPOSIT_TYPE');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `reserve_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Change Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `reserve_change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reserve Change Reason Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `reserve_change_reason_code` SET TAGS ('dbx_value_regex' = 'NEW_BUSINESS|MORTALITY|LAPSE|INTEREST|ASSUMPTION_CHANGE|REINSURANCE');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `reserve_status` SET TAGS ('dbx_business_glossary_term' = 'Reserve Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `reserve_status` SET TAGS ('dbx_value_regex' = 'PRELIMINARY|FINAL|ADJUSTED|RESTATED');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `state_of_domicile_code` SET TAGS ('dbx_business_glossary_term' = 'State of Domicile Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `tax_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ALTER COLUMN `valuation_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Valuation Interest Rate');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` SET TAGS ('dbx_subdomain' = 'insurance_valuation');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `gaap_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Reserve ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `ifrs17_contract_group_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Group ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Documentation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `actual_experience_effect_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Experience Effect Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `assumption_change_effect_amount` SET TAGS ('dbx_business_glossary_term' = 'Assumption Change Effect Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `assumption_update_date` SET TAGS ('dbx_business_glossary_term' = 'Assumption Update Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `cash_flow_assumption_version` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Assumption Version');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `dac_asset_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Asset Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `discount_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percentage');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `discount_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Type');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `discount_rate_type` SET TAGS ('dbx_value_regex' = 'LOCKED_IN|UPPER_MEDIUM_GRADE|CURRENT_MARKET');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `expense_assumption_per_policy` SET TAGS ('dbx_business_glossary_term' = 'Expense Assumption Per Policy');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `external_audit_review_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Review Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `face_amount_total` SET TAGS ('dbx_business_glossary_term' = 'Face Amount Total');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `gaap_vs_statutory_difference_amount` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) vs Statutory Accounting Principles (SAP) Difference Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `lapse_rate_assumption_percentage` SET TAGS ('dbx_business_glossary_term' = 'Lapse Rate Assumption Percentage');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `ldti_cohort_year` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Cohort Year');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `ldti_transition_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Transition Adjustment Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `mortality_table_code` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `mrb_fair_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Market Risk Benefit (MRB) Fair Value Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `mrb_instrument_credit_risk_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Market Risk Benefit (MRB) Instrument Credit Risk Adjustment');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `net_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reserve Calculation Notes');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `policy_count` SET TAGS ('dbx_business_glossary_term' = 'Policy Count');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `premium_deficiency_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Deficiency Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `reinsurance_recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Recoverable Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `reserve_adequacy_test_date` SET TAGS ('dbx_business_glossary_term' = 'Reserve Adequacy Test Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `reserve_adequacy_test_status` SET TAGS ('dbx_business_glossary_term' = 'Reserve Adequacy Test Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `reserve_adequacy_test_status` SET TAGS ('dbx_value_regex' = 'PASSED|FAILED|NOT_TESTED|IN_PROGRESS');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `reserve_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Reserve Calculation Method');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `reserve_calculation_method` SET TAGS ('dbx_value_regex' = 'NET_PREMIUM|GROSS_PREMIUM|BENEFIT_RESERVE|UNEARNED_PREMIUM|FAIR_VALUE');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `reserve_category` SET TAGS ('dbx_business_glossary_term' = 'Reserve Category');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `reserve_category` SET TAGS ('dbx_value_regex' = 'FPB|PAB|MRB|CLAIM|IBNR|UNEARNED');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `reserve_status` SET TAGS ('dbx_business_glossary_term' = 'Reserve Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `reserve_status` SET TAGS ('dbx_value_regex' = 'PRELIMINARY|FINAL|ADJUSTED|RESTATED');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `sox_control_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Certification Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` SET TAGS ('dbx_subdomain' = 'insurance_valuation');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `ifrs17_contract_group_id` SET TAGS ('dbx_business_glossary_term' = 'IFRS 17 Contract Group Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Grouping Policy Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `reinsurance_contract_group_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Contract Group Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `closing_csm_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Contractual Service Margin (CSM) Balance');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `closing_csm_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `closing_fcf_estimate` SET TAGS ('dbx_business_glossary_term' = 'Closing Fulfilment Cash Flows (FCF) Estimate');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `closing_fcf_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `contract_boundary_assessment` SET TAGS ('dbx_business_glossary_term' = 'Contract Boundary Assessment');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `contract_group_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Group Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `coverage_period` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period Component');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `coverage_period` SET TAGS ('dbx_value_regex' = 'remaining_coverage|incurred_claims');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `coverage_units_closing` SET TAGS ('dbx_business_glossary_term' = 'Coverage Units Closing');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `coverage_units_opening` SET TAGS ('dbx_business_glossary_term' = 'Coverage Units Opening');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `csm_assumption_change_impact` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) Assumption Change Impact');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `csm_assumption_change_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `csm_currency_exchange_impact` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) Currency Exchange Impact');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `csm_currency_exchange_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `csm_experience_variance` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) Experience Variance');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `csm_experience_variance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `csm_interest_accretion` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) Interest Accretion');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `csm_interest_accretion` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `csm_new_business_addition` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) New Business Addition');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `csm_new_business_addition` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `csm_release_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) Release Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `csm_release_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `derecognition_date` SET TAGS ('dbx_business_glossary_term' = 'Derecognition Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `discount_rate_closing` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Closing');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `discount_rate_opening` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Opening');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `ifrs17_contract_group_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Group Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `ifrs17_contract_group_status` SET TAGS ('dbx_value_regex' = 'active|closed|derecognized');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `initial_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Recognition Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `insurance_finance_income_expense` SET TAGS ('dbx_business_glossary_term' = 'Insurance Finance Income or Expense');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `insurance_finance_income_expense` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `insurance_revenue_recognized` SET TAGS ('dbx_business_glossary_term' = 'Insurance Revenue Recognized');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `insurance_revenue_recognized` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `insurance_service_expense` SET TAGS ('dbx_business_glossary_term' = 'Insurance Service Expense');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `insurance_service_expense` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `loss_component_closing` SET TAGS ('dbx_business_glossary_term' = 'Loss Component Closing Balance');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `loss_component_closing` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `loss_component_opening` SET TAGS ('dbx_business_glossary_term' = 'Loss Component Opening Balance');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `loss_component_opening` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `measurement_model` SET TAGS ('dbx_business_glossary_term' = 'Measurement Model');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `measurement_model` SET TAGS ('dbx_value_regex' = 'GMM|PAA|VFA');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `oci_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Comprehensive Income (OCI) Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `oci_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `oci_pl_allocation_election` SET TAGS ('dbx_business_glossary_term' = 'Other Comprehensive Income (OCI) vs Profit or Loss (P&L) Allocation Election');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `oci_pl_allocation_election` SET TAGS ('dbx_value_regex' = 'full_pl|oci_disaggregation');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `opening_csm_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Contractual Service Margin (CSM) Balance');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `opening_csm_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `opening_fcf_estimate` SET TAGS ('dbx_business_glossary_term' = 'Opening Fulfilment Cash Flows (FCF) Estimate');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `opening_fcf_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `profitability_classification` SET TAGS ('dbx_business_glossary_term' = 'Profitability Classification');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `profitability_classification` SET TAGS ('dbx_value_regex' = 'onerous|not_onerous|no_significant_possibility_of_becoming_onerous');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `risk_adjustment_closing` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment for Non-Financial Risk Closing Balance');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `risk_adjustment_closing` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `risk_adjustment_opening` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment for Non-Financial Risk Opening Balance');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `risk_adjustment_opening` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `risk_adjustment_release` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Release');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `risk_adjustment_release` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `transition_approach` SET TAGS ('dbx_business_glossary_term' = 'Transition Approach');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `transition_approach` SET TAGS ('dbx_value_regex' = 'full_retrospective|modified_retrospective|fair_value');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` SET TAGS ('dbx_subdomain' = 'insurance_valuation');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `ifrs17_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'IFRS 17 Measurement ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Report Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `ifrs17_contract_group_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Contract Group ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `acquisition_expense` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Expense');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `assumption_change_impact` SET TAGS ('dbx_business_glossary_term' = 'Assumption Change Impact');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `closing_csm` SET TAGS ('dbx_business_glossary_term' = 'Closing Contractual Service Margin (CSM)');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `closing_fcf_estimate` SET TAGS ('dbx_business_glossary_term' = 'Closing Fulfilment Cash Flows (FCF) Estimate');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `closing_risk_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Closing Risk Adjustment');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `cohort_year` SET TAGS ('dbx_business_glossary_term' = 'Cohort Year');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `coverage_units` SET TAGS ('dbx_business_glossary_term' = 'Coverage Units');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `csm_assumption_change` SET TAGS ('dbx_business_glossary_term' = 'CSM Assumption Change Impact');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `csm_experience_adjustment` SET TAGS ('dbx_business_glossary_term' = 'CSM Experience Adjustment');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `csm_interest_accretion` SET TAGS ('dbx_business_glossary_term' = 'CSM Interest Accretion');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `csm_release_for_service` SET TAGS ('dbx_business_glossary_term' = 'CSM Release for Service Provided');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `experience_variance` SET TAGS ('dbx_business_glossary_term' = 'Experience Variance');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `finance_oci_component` SET TAGS ('dbx_business_glossary_term' = 'Finance Other Comprehensive Income (OCI) Component');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `finance_pl_component` SET TAGS ('dbx_business_glossary_term' = 'Finance Profit or Loss (P&L) Component');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `incurred_claims` SET TAGS ('dbx_business_glossary_term' = 'Incurred Claims');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `insurance_finance_expense` SET TAGS ('dbx_business_glossary_term' = 'Insurance Finance Expense');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `insurance_finance_income` SET TAGS ('dbx_business_glossary_term' = 'Insurance Finance Income');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `insurance_revenue` SET TAGS ('dbx_business_glossary_term' = 'Insurance Revenue');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `insurance_service_expense` SET TAGS ('dbx_business_glossary_term' = 'Insurance Service Expense');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `loss_component` SET TAGS ('dbx_business_glossary_term' = 'Loss Component');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `measurement_model` SET TAGS ('dbx_business_glossary_term' = 'IFRS 17 Measurement Model');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `measurement_model` SET TAGS ('dbx_value_regex' = 'General Measurement Model|Premium Allocation Approach|Variable Fee Approach');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'Draft|Preliminary|Final|Restated');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `onerous_contract_loss` SET TAGS ('dbx_business_glossary_term' = 'Onerous Contract Loss');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `opening_csm` SET TAGS ('dbx_business_glossary_term' = 'Opening Contractual Service Margin (CSM)');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `opening_fcf_estimate` SET TAGS ('dbx_business_glossary_term' = 'Opening Fulfilment Cash Flows (FCF) Estimate');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `opening_risk_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Opening Risk Adjustment');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `reinsurance_held_csm` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Held Contractual Service Margin (CSM)');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `reinsurance_held_fcf` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Held Fulfilment Cash Flows (FCF)');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `reinsurance_held_risk_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Held Risk Adjustment');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `risk_adjustment_change` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Change');
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ALTER COLUMN `risk_adjustment_release` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Release');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` SET TAGS ('dbx_subdomain' = 'planning_performance');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `rbc_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Calculation ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `action_level_trigger` SET TAGS ('dbx_business_glossary_term' = 'Action Level Trigger');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `action_level_trigger` SET TAGS ('dbx_value_regex' = 'no_action|company_action|regulatory_action|authorized_control|mandatory_control');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `audit_opinion` SET TAGS ('dbx_business_glossary_term' = 'Audit Opinion');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `audit_opinion` SET TAGS ('dbx_value_regex' = 'unqualified|qualified|adverse|disclaimer|not_audited');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `auditor_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Auditor Reviewed Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `authorized_control_level_rbc` SET TAGS ('dbx_business_glossary_term' = 'Authorized Control Level (ACL) Risk-Based Capital (RBC)');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `c0_asset_risk_affiliates` SET TAGS ('dbx_business_glossary_term' = 'C-0 Asset Risk - Affiliates');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `c1_asset_risk_equity` SET TAGS ('dbx_business_glossary_term' = 'C-1 Asset Risk - Equity');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `c1_asset_risk_fixed_income` SET TAGS ('dbx_business_glossary_term' = 'C-1 Asset Risk - Fixed Income');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `c1_asset_risk_other` SET TAGS ('dbx_business_glossary_term' = 'C-1 Asset Risk - Other');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `c1_asset_risk_real_estate` SET TAGS ('dbx_business_glossary_term' = 'C-1 Asset Risk - Real Estate');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `c2_insurance_risk` SET TAGS ('dbx_business_glossary_term' = 'C-2 Insurance Risk');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `c3_interest_rate_risk` SET TAGS ('dbx_business_glossary_term' = 'C-3 Interest Rate Risk');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `c3_market_risk` SET TAGS ('dbx_business_glossary_term' = 'C-3 Market Risk');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `c4_business_risk` SET TAGS ('dbx_business_glossary_term' = 'C-4 Business Risk');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_value_regex' = 'formula_based|scenario_based|stochastic|hybrid');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'Calculation Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `calculation_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|filed|amended|superseded');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `calculation_type` SET TAGS ('dbx_business_glossary_term' = 'Calculation Type');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `calculation_type` SET TAGS ('dbx_value_regex' = 'life|property_casualty|health');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `company_action_level_rbc` SET TAGS ('dbx_business_glossary_term' = 'Company Action Level (CAL) Risk-Based Capital (RBC)');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `covariance_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Covariance Adjustment');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `filed_with_regulator_flag` SET TAGS ('dbx_business_glossary_term' = 'Filed With Regulator Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Method');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|exempt');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `mandatory_control_level_rbc` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Control Level Risk-Based Capital (RBC)');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Calculation Notes');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `orsa_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Own Risk and Solvency Assessment (ORSA) Alignment Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `rbc_ratio` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Ratio');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `regulator_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulator Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `regulatory_action_level_rbc` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Level Risk-Based Capital (RBC)');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `reporting_quarter` SET TAGS ('dbx_business_glossary_term' = 'Reporting Quarter');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `total_adjusted_capital` SET TAGS ('dbx_business_glossary_term' = 'Total Adjusted Capital (TAC)');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `total_rbc_after_covariance` SET TAGS ('dbx_business_glossary_term' = 'Total Risk-Based Capital (RBC) After Covariance');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `total_rbc_before_covariance` SET TAGS ('dbx_business_glossary_term' = 'Total Risk-Based Capital (RBC) Before Covariance');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `trend_test_result` SET TAGS ('dbx_business_glossary_term' = 'Trend Test Result');
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ALTER COLUMN `trend_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `intercompany_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Settlement Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `investment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Transaction Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `netting_group_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Group Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Legal Entity Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `receiving_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Legal Entity Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `reinsurance_treaty_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Treaty Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `elimination_entry_reference` SET TAGS ('dbx_business_glossary_term' = 'Elimination Entry Reference Number');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `intercompany_settlement_description` SET TAGS ('dbx_business_glossary_term' = 'Settlement Description');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `netting_indicator` SET TAGS ('dbx_business_glossary_term' = 'Netting Indicator Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|reconciled|variance_identified|resolved');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'cash_transfer|journal_entry|offset|accrual');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Transaction Number');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|approved|settled|reconciled|disputed|cancelled');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `statutory_line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Line of Business');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'expense_allocation|reinsurance_premium|investment_income_transfer|management_fee|capital_contribution|dividend_payment');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'comparable_uncontrolled_price|resale_price|cost_plus|profit_split|transactional_net_margin|not_applicable');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Variance Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Description');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'planning_performance');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'DRAFT|PENDING_APPROVAL|APPROVED|REJECTED|REVISED');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'REVENUE|EXPENSE|CAPITAL|RESERVE|INVESTMENT');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `is_capital_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Is Capital Expenditure Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `is_controllable` SET TAGS ('dbx_business_glossary_term' = 'Is Controllable Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `line_item_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Item Description');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `management_commentary` SET TAGS ('dbx_business_glossary_term' = 'Management Commentary');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Email Address');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Name');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `reforecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Reforecast Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `reporting_basis` SET TAGS ('dbx_business_glossary_term' = 'Reporting Basis');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `reporting_basis` SET TAGS ('dbx_value_regex' = 'GAAP|SAP|IFRS17|TAX');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `variance_explanation` SET TAGS ('dbx_business_glossary_term' = 'Variance Explanation');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `variance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Variance Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `variance_indicator` SET TAGS ('dbx_value_regex' = 'FAVORABLE|UNFAVORABLE|NEUTRAL|NOT_APPLICABLE');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `version_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ALTER COLUMN `version_code` SET TAGS ('dbx_value_regex' = 'ORIGINAL|REVISED|FORECAST|REFORECAST|BOARD_APPROVED');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` SET TAGS ('dbx_subdomain' = 'planning_performance');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `budget_variance_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `distribution_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `product_line_id` SET TAGS ('dbx_business_glossary_term' = 'Product Line Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `dac_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `favorable_unfavorable_indicator` SET TAGS ('dbx_business_glossary_term' = 'Favorable/Unfavorable Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `favorable_unfavorable_indicator` SET TAGS ('dbx_value_regex' = 'favorable|unfavorable|neutral');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `gaap_expense_category` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Expense Category');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `intercompany_settlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Settlement Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `management_commentary` SET TAGS ('dbx_business_glossary_term' = 'Management Commentary');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `rbc_category` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Category');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `reforecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Reforecast Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Reporting Category');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `reporting_category` SET TAGS ('dbx_value_regex' = 'operating_expense|acquisition_cost|claim_expense|investment_expense|administrative_expense|other');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `sap_expense_exhibit` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Expense Exhibit');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `sox_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Controlled Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `variance_explanation` SET TAGS ('dbx_business_glossary_term' = 'Variance Explanation');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `variance_status` SET TAGS ('dbx_business_glossary_term' = 'Variance Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `variance_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|escalated|closed');
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ALTER COLUMN `variance_threshold_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Exceeded Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` SET TAGS ('dbx_subdomain' = 'planning_performance');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Audit Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'not started|in progress|completed|settled');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Calculation Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `current_tax_expense` SET TAGS ('dbx_business_glossary_term' = 'Current Tax Expense');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `dac_temporary_difference` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Temporary Difference');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `deferred_tax_expense` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Expense (Benefit)');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `dta_balance` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Asset (DTA) Balance');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `dtl_balance` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Liability (DTL) Balance');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `effective_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Effective Tax Rate (ETR)');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `external_auditor_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Reviewed Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `foreign_tax_expense` SET TAGS ('dbx_business_glossary_term' = 'Foreign Income Tax Expense');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `gaap_reporting_basis` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Reporting Basis');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `gaap_reporting_basis` SET TAGS ('dbx_value_regex' = 'US GAAP|IFRS|SAP');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `irc_7702_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 7702 Tax Compliance Adjustment');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `ldti_tax_impact` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Tax Impact');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `net_deferred_tax_position` SET TAGS ('dbx_business_glossary_term' = 'Net Deferred Tax Position');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `nol_carryforward` SET TAGS ('dbx_business_glossary_term' = 'Net Operating Loss (NOL) Carryforward');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Notes');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `permanent_difference_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Permanent Difference Adjustment');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `pretax_income` SET TAGS ('dbx_business_glossary_term' = 'Pretax Income (Book Income)');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `provision_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `provision_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Calculation Method');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `provision_method` SET TAGS ('dbx_value_regex' = 'discrete|annual effective rate|interim estimate');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `provision_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `provision_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|amended|audited');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `rate_change_impact` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Change Impact');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `reserve_temporary_difference` SET TAGS ('dbx_business_glossary_term' = 'Reserve Temporary Difference');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `return_to_provision_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Provision True-Up Adjustment');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Reviewed By');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `sox_control_certification` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Certification');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `state_tax_expense` SET TAGS ('dbx_business_glossary_term' = 'State Income Tax Expense');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `statutory_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Statutory Tax Rate');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_credit_carryforward` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Carryforward');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_return_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Return Filed Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `total_tax_expense` SET TAGS ('dbx_business_glossary_term' = 'Total Income Tax Expense');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `unrealized_gain_temporary_difference` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain (Loss) Temporary Difference');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `utp_reserve` SET TAGS ('dbx_business_glossary_term' = 'Uncertain Tax Position (UTP) Reserve');
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ALTER COLUMN `valuation_allowance` SET TAGS ('dbx_business_glossary_term' = 'Valuation Allowance');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` SET TAGS ('dbx_subdomain' = 'insurance_valuation');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `reinsurance_recoverable_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Recoverable Identifier');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `reinsurance_treaty_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Treaty ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `reinsurer_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Treaty Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `accounting_basis` SET TAGS ('dbx_business_glossary_term' = 'Accounting Basis');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `accounting_basis` SET TAGS ('dbx_value_regex' = 'SAP|GAAP|IFRS17|tax');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|30_days|60_days|90_days|over_90_days');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `allowance_for_uncollectible` SET TAGS ('dbx_business_glossary_term' = 'Allowance for Uncollectible Reinsurance');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `collateral_held_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Held Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `collateral_type` SET TAGS ('dbx_value_regex' = 'letter_of_credit|trust_account|funds_withheld|none');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `days_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Outstanding');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `gaap_classification` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Classification');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `gaap_classification` SET TAGS ('dbx_value_regex' = 'current_asset|non_current_asset');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `gross_recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Recoverable Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `ifrs17_csm_impact` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards 17 (IFRS17) Contractual Service Margin (CSM) Impact');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `net_recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Recoverable Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `rbc_category` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Category');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `recoverable_status` SET TAGS ('dbx_business_glossary_term' = 'Recoverable Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `recoverable_status` SET TAGS ('dbx_value_regex' = 'billed|unbilled|disputed|collected|written_off');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `recoverable_type` SET TAGS ('dbx_business_glossary_term' = 'Recoverable Type');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `recoverable_type` SET TAGS ('dbx_value_regex' = 'ceded_reserve|ceded_claim|ceded_premium|ceded_benefit|ceded_commission');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `reinsurer_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Credit Rating');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `reinsurer_credit_rating` SET TAGS ('dbx_value_regex' = '^[A-D][+-]?$|NR');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `sap_exhibit_line` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Exhibit Line');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `sox_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Controlled Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` SET TAGS ('dbx_subdomain' = 'insurance_valuation');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `embedded_value_id` SET TAGS ('dbx_business_glossary_term' = 'Embedded Value (EV) ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Report Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `prior_period_embedded_value_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `adjusted_net_worth` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Net Worth (ANW)');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `assumption_change_impact` SET TAGS ('dbx_business_glossary_term' = 'Assumption Change Impact');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'Calculation Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `calculation_status` SET TAGS ('dbx_value_regex' = 'Draft|Under Review|Approved|Published|Restated');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `capital_movements` SET TAGS ('dbx_business_glossary_term' = 'Capital Movements');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `closing_embedded_value` SET TAGS ('dbx_business_glossary_term' = 'Closing Embedded Value (EV)');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `cost_of_required_capital` SET TAGS ('dbx_business_glossary_term' = 'Cost of Required Capital (CoRC)');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `covered_business_indicator` SET TAGS ('dbx_business_glossary_term' = 'Covered Business Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `economic_variance` SET TAGS ('dbx_business_glossary_term' = 'Economic Variance');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `expected_return` SET TAGS ('dbx_business_glossary_term' = 'Expected Return on Embedded Value');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `experience_variance` SET TAGS ('dbx_business_glossary_term' = 'Experience Variance');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `external_audit_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Reviewed Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `free_surplus` SET TAGS ('dbx_business_glossary_term' = 'Free Surplus');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `frictional_costs` SET TAGS ('dbx_business_glossary_term' = 'Frictional Costs');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `investor_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Investor Disclosure Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `new_business_value` SET TAGS ('dbx_business_glossary_term' = 'New Business Value (NBV)');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `opening_embedded_value` SET TAGS ('dbx_business_glossary_term' = 'Opening Embedded Value (EV)');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `other_operating_variance` SET TAGS ('dbx_business_glossary_term' = 'Other Operating Variance');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `reference_rate` SET TAGS ('dbx_business_glossary_term' = 'Reference Discount Rate');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `reporting_basis` SET TAGS ('dbx_business_glossary_term' = 'Reporting Basis');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `reporting_basis` SET TAGS ('dbx_value_regex' = 'MCEV|EEV|Traditional EV|Appraisal Value');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `required_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Required Capital Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `risk_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Risk Discount Rate');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `sensitivity_test_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity Test Performed Flag');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `stochastic_scenario_count` SET TAGS ('dbx_business_glossary_term' = 'Stochastic Scenario Count');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `time_value_financial_options_guarantees` SET TAGS ('dbx_business_glossary_term' = 'Time Value of Financial Options and Guarantees (TVFOG)');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ALTER COLUMN `value_of_in_force` SET TAGS ('dbx_business_glossary_term' = 'Value of In-Force (VIF)');
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` SET TAGS ('dbx_subdomain' = 'planning_performance');
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` SET TAGS ('dbx_association_edges' = 'finance.legal_entity,vendor.vendor');
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` ALTER COLUMN `entity_vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Entity Vendor Contract ID');
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Entity Vendor Contract - Legal Entity Id');
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Entity Vendor Contract - Vendor Id');
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` ALTER COLUMN `contract_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner');
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` ALTER COLUMN `preferred_status` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` SET TAGS ('dbx_subdomain' = 'planning_performance');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` SET TAGS ('dbx_association_edges' = 'finance.cost_center,vendor.vendor');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` ALTER COLUMN `cost_center_vendor_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Vendor Engagement Identifier');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Vendor Engagement - Cost Center Id');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Vendor Engagement - Vendor Id');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` ALTER COLUMN `budget_allocation` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Engagement Notes');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Indicator');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `life_insurance_ecm`.`finance`.`netting_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`finance`.`netting_group` SET TAGS ('dbx_subdomain' = 'planning_performance');
ALTER TABLE `life_insurance_ecm`.`finance`.`netting_group` ALTER COLUMN `netting_group_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Group Identifier');
