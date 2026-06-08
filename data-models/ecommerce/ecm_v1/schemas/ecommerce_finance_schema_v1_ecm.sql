-- Schema for Domain: finance | Business: Ecommerce | Version: v1_ecm
-- Generated on: 2026-05-04 23:24:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`finance` COMMENT 'SSOT for enterprise financial records and reporting. Owns general ledger, accounts payable, accounts receivable, cost center management, budget tracking, GMV-to-revenue reconciliation, and regulatory financial reporting. Integrates with SAP S/4HANA for financial consolidation. Ensures SOX compliance for financial controls and audit trails. Tracks MRR, ARR, and revenue recognition.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`general_ledger` (
    `general_ledger_id` BIGINT COMMENT 'Primary key for general_ledger',
    `account_balance_gc` DECIMAL(18,2) COMMENT 'Current cumulative balance of the GL account in the group/consolidation currency. Used for multi-entity financial consolidation, group-level reporting, and GMV-to-revenue reconciliation across all company codes. Supports MRR and ARR tracking at the enterprise level.',
    `account_balance_lc` DECIMAL(18,2) COMMENT 'Current cumulative balance of the GL account in the company code local currency. Represents the net of all debit and credit postings to this account for the current fiscal period. Used for trial balance generation, financial statement preparation, and period-end close reporting.',
    `account_category` STRING COMMENT 'Secondary classification grouping GL accounts into functional categories such as cash and equivalents, accounts receivable, inventory, fixed assets, accounts payable, accrued liabilities, deferred revenue, cost of goods sold, operating expenses, etc. Supports financial statement line-item grouping and management reporting. [ENUM-REF-CANDIDATE: cash_and_equivalents|accounts_receivable|inventory|fixed_assets|accounts_payable|accrued_liabilities|deferred_revenue|cost_of_goods_sold|operating_expenses|other — promote to reference product]',
    `account_description` STRING COMMENT 'Detailed narrative description of the GL accounts business purpose, the types of transactions it records, and any special posting rules or restrictions. Used for financial governance documentation, new employee training, and SOX control documentation.',
    `account_effective_from` DATE COMMENT 'The date from which this GL account became active and available for financial postings. Used for account lifecycle management, historical reporting, and SOX audit trails. Postings with a document date before this date are not permitted.',
    `account_effective_until` DATE COMMENT 'The date after which this GL account is no longer available for financial postings. Null for accounts with no planned end date. Used for account decommissioning, chart of accounts rationalization, and SOX-compliant account lifecycle management.',
    `account_group` STRING COMMENT 'Organizational grouping of GL accounts within the chart of accounts that controls the number range and field selection for account master data maintenance. Corresponds to SAP S/4HANA account group (KTOKS). Examples include balance sheet accounts, P&L accounts, cost accounts.',
    `account_long_name` STRING COMMENT 'Full descriptive name of the GL account providing complete context for financial reporting and audit purposes. Corresponds to the SAP S/4HANA GL account long text (TXT50). Used in detailed financial statements and regulatory filings.',
    `account_name` STRING COMMENT 'Short descriptive name of the GL account as displayed in financial reports, trial balances, and the chart of accounts. Corresponds to the SAP S/4HANA GL account short text (TXT20).',
    `account_number` STRING COMMENT 'The externally-known, human-readable GL account number as defined in the chart of accounts. Used in all financial postings, journal entries, and financial statement line items. Corresponds to the SAP S/4HANA GL account key (SAKNR).. Valid values are `^[0-9]{6,10}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the GL account master record. Active accounts accept financial postings; blocked accounts are temporarily restricted from new postings; marked_for_deletion accounts are pending archival after period-end close. Corresponds to SAP S/4HANA account blocking indicators.. Valid values are `active|inactive|blocked|marked_for_deletion`',
    `account_type` STRING COMMENT 'Fundamental financial classification of the GL account per the accounting equation. Determines how the account appears on financial statements: asset and liability/equity accounts appear on the balance sheet; revenue and expense accounts appear on the income statement. Corresponds to SAP S/4HANA account type (KTOKS).. Valid values are `asset|liability|equity|revenue|expense`',
    `alternative_account_number` STRING COMMENT 'Alternative or country-specific account number used for local statutory reporting requirements. Enables mapping between the operational chart of accounts and country-specific or group chart of accounts. Supports multi-GAAP reporting and local statutory compliance.',
    `chart_of_accounts_code` STRING COMMENT 'Identifier for the chart of accounts grouping to which this GL account belongs. In SAP S/4HANA, a chart of accounts is a classified directory of all GL accounts used by one or more company codes. Enables multi-COA structures for operational and group reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code` STRING COMMENT 'SAP S/4HANA company code representing the legal entity or organizational unit for which the GL account is defined. Supports multi-company-code chart of accounts and financial consolidation across the enterprise.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA cost center code linked to this GL account for cost center accounting. Enables expense tracking and allocation by organizational unit, department, or function. Supports management reporting and budget variance analysis.',
    `cost_element_category` STRING COMMENT 'Indicates whether this GL account is also defined as a cost element in SAP Controlling (CO) module. Primary cost elements correspond to GL expense/revenue accounts; secondary cost elements are used for internal cost allocations and have no corresponding GL account. Drives cost center accounting and profitability analysis.. Valid values are `primary|secondary|none`',
    `created_by_user` STRING COMMENT 'SAP S/4HANA user ID of the person who created this GL account master record. Required for SOX-compliant audit trails, segregation of duties controls, and financial governance. Corresponds to SAP S/4HANA ERNAM field.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this GL account master record was first created in the system. Provides the audit trail creation point for SOX compliance and data lineage tracking. Corresponds to SAP S/4HANA creation date and time fields.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the account currency. When set, all postings to this account must be in this currency. If null, the account accepts postings in any currency and balances are maintained in the company code currency. Critical for multi-currency financial reporting and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `field_status_group` STRING COMMENT 'SAP S/4HANA field status group code assigned to this GL account that controls which fields are required, optional, or suppressed during document entry for postings to this account. Ensures data completeness and consistency for financial postings.. Valid values are `^G[0-9]{3}$`',
    `financial_statement_section` STRING COMMENT 'Identifies which primary financial statement this GL account contributes to. Drives automated financial statement preparation and regulatory reporting. Critical for SOX-compliant period-end close and IFRS/GAAP financial reporting.. Valid values are `balance_sheet|income_statement|cash_flow_statement|statement_of_equity`',
    `fiscal_period` STRING COMMENT 'The fiscal period (accounting period) within the fiscal year to which the current account balance applies. Typically 1-12 for monthly periods, with additional special periods (13-16) for year-end adjustments. Corresponds to SAP S/4HANA posting period (MONAT).',
    `fiscal_year` STRING COMMENT 'The fiscal year to which the current account balance and period-end close data applies. Supports multi-year financial reporting, year-over-year comparisons, and SOX-compliant audit trails. Corresponds to SAP S/4HANA fiscal year (GJAHR).',
    `fiscal_year_variant` STRING COMMENT 'SAP S/4HANA fiscal year variant code that defines the fiscal year structure (calendar year, non-calendar year, or shortened fiscal year) and the number of posting periods. Determines how fiscal periods map to calendar months for financial reporting.. Valid values are `^[A-Z][0-9]$`',
    `functional_area` STRING COMMENT 'SAP S/4HANA functional area classification that categorizes GL accounts by business function (e.g., sales, marketing, production, administration, research and development). Enables cost-of-sales accounting and functional income statement reporting per IFRS IAS 1.',
    `hierarchy_level` STRING COMMENT 'Numeric level of this GL account within the account hierarchy tree, where level 1 represents the top-most grouping (e.g., total assets) and higher numbers represent more granular accounts. Used for financial statement rollup logic and management reporting drill-down.',
    `is_balance_sheet_relevant` BOOLEAN COMMENT 'Indicates whether this GL account carries a balance that is reported on the balance sheet. Balance sheet accounts (assets, liabilities, equity) carry forward their balances at year-end; P&L accounts are reset to zero. Drives automated year-end closing and balance carryforward processes.',
    `is_posting_allowed` BOOLEAN COMMENT 'Indicates whether direct financial postings are permitted to this GL account. When false, the account is a summary/header account used only for hierarchical reporting and cannot receive direct journal entry postings. Corresponds to SAP S/4HANA posting block indicator.',
    `is_reconciliation_account` BOOLEAN COMMENT 'Indicates whether this GL account is a reconciliation account that is automatically updated when postings are made to subledger accounts (accounts receivable, accounts payable, asset accounting). Reconciliation accounts cannot receive direct manual postings. Critical for AR/AP subledger-to-GL reconciliation.',
    `last_posting_date` DATE COMMENT 'The date of the most recent financial posting made to this GL account. Used for account activity monitoring, dormant account identification, and chart of accounts maintenance. Supports period-end close validation and SOX control testing.',
    `line_item_display` BOOLEAN COMMENT 'Indicates whether individual line items posted to this GL account are stored and displayable for audit and analysis purposes. When true, each posting line is retained for drill-down reporting. Required for SOX audit trails and financial investigation. Corresponds to SAP S/4HANA line item display indicator (XKRES).',
    `normal_balance` STRING COMMENT 'Indicates whether the GL account normally carries a debit or credit balance per double-entry bookkeeping rules. Assets and expenses normally carry debit balances; liabilities, equity, and revenue normally carry credit balances. Used for trial balance validation and automated posting rules.. Valid values are `debit|credit`',
    `open_item_management` BOOLEAN COMMENT 'Indicates whether open item management is activated for this GL account. When true, individual line items remain open until they are cleared against offsetting entries (e.g., payment clearing for bank accounts, GR/IR clearing accounts). Essential for bank reconciliation and clearing account management.',
    `parent_account_number` STRING COMMENT 'Account number of the parent GL account in the account hierarchy. Enables multi-level account hierarchies for financial reporting rollups, management reporting, and financial consolidation. Null for top-level accounts in the hierarchy.. Valid values are `^[0-9]{6,10}$`',
    `profit_center_code` STRING COMMENT 'SAP S/4HANA profit center code associated with this GL account for profitability analysis and segment reporting. Enables revenue and cost attribution to business segments, product lines, or geographic regions. Supports IFRS 8 operating segment disclosures.',
    `reconciliation_account_type` STRING COMMENT 'Specifies the subledger type this reconciliation account is linked to. Determines which subledger transactions automatically update this GL account. Null or none for non-reconciliation accounts. Corresponds to SAP S/4HANA reconciliation account type (MITKZ).. Valid values are `accounts_receivable|accounts_payable|fixed_assets|none`',
    `segment_code` STRING COMMENT 'Business segment identifier associated with this GL account for segment reporting. Supports IFRS 8 and US GAAP ASC 280 operating segment disclosures. Enables financial reporting by business segment such as marketplace, fulfillment, advertising, or subscription services.',
    `sort_key` STRING COMMENT 'SAP S/4HANA sort key code that determines which field is used to populate the allocation field in line items posted to this account. Controls how line items are sorted and displayed in account statements. Examples: 001 (posting date), 003 (document number), 031 (order number).. Valid values are `^[0-9]{3}$`',
    `tax_category` STRING COMMENT 'Specifies the tax treatment applicable to postings on this GL account. Controls whether tax codes are required, optional, or not applicable for journal entries. Relevant for VAT/GST compliance, sales tax reporting, and indirect tax management. Corresponds to SAP S/4HANA tax category (MWSKZ). [ENUM-REF-CANDIDATE: input_tax|output_tax|not_relevant|all_tax_codes|minus_sign — promote to reference product]',
    `tolerance_group` STRING COMMENT 'SAP S/4HANA tolerance group assigned to this GL account that defines the permitted payment differences and rounding tolerances for clearing transactions. Controls automatic write-off of small differences during payment processing and bank reconciliation. Supports SOX controls over financial accuracy.',
    `updated_by_user` STRING COMMENT 'SAP S/4HANA user ID of the person who last modified this GL account master record. Required for SOX-compliant audit trails, change management controls, and financial governance. Corresponds to SAP S/4HANA AENAM field.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this GL account master record. Tracks changes to account attributes for SOX-compliant audit trails and data lineage. Essential for change management controls and period-end close integrity.',
    CONSTRAINT pk_general_ledger PRIMARY KEY(`general_ledger_id`)
) COMMENT 'SSOT for the enterprise chart of accounts and GL account master data. Defines account codes, account types (asset, liability, equity, revenue, expense), account hierarchies, and natural account groupings. Serves as the structural backbone for all financial postings, trial balance generation, and financial statement preparation. Integrates with SAP S/4HANA GL for multi-company-code chart of accounts and supports SOX-compliant period-end close.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique surrogate identifier for each journal entry record in the general ledger. Serves as the primary key for the journal_entry data product in the Databricks Silver Layer.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for the expenditure or revenue captured in this journal entry. Enables cost allocation, departmental P&L reporting, and budget variance analysis.',
    `general_ledger_id` BIGINT COMMENT 'Reference to the General Ledger (GL) account to which this journal entry header is primarily associated. The GL account determines the financial statement line item and chart of accounts classification.',
    `ledger_id` BIGINT COMMENT 'Identifier of the SAP ledger to which the journal entry is posted (e.g., 0L for leading ledger, 2L for IFRS parallel ledger, 3L for local GAAP ledger). Supports parallel accounting under multiple accounting standards.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center associated with this journal entry. Supports segment-level profitability reporting, GMV-to-revenue reconciliation, and management accounting.',
    `supplier_id` BIGINT COMMENT 'Reference to the intercompany trading partner entity involved in this journal entry. Required for intercompany elimination during financial consolidation and statutory group reporting.',
    `assignment_number` STRING COMMENT 'A free-form alphanumeric field used to group or sort journal entry line items for reconciliation and reporting purposes (e.g., payment run ID, clearing document number, batch reference). Supports open item management and account clearing workflows.',
    `business_area` STRING COMMENT 'SAP business area code representing a distinct operational segment of the enterprise (e.g., marketplace, fulfillment, advertising). Enables cross-company-code financial reporting by business segment.',
    `clearing_date` DATE COMMENT 'The date on which the open item represented by this journal entry line was cleared (offset by a payment or contra-entry). Used for aging analysis, DSO (Days Sales Outstanding) calculation, and AR/AP reconciliation.',
    `clearing_document_number` STRING COMMENT 'The SAP document number of the clearing transaction that offset this open item (e.g., payment clearing an invoice). Populated when the journal entry line has been cleared. Supports accounts receivable and accounts payable reconciliation workflows.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity or organizational unit for which the journal entry is posted. Used for entity-level financial consolidation and statutory reporting.',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether the journal entry line represents a debit (D) or credit (C) posting in double-entry accounting. Every journal entry must balance such that total debits equal total credits, enforcing the fundamental accounting equation.. Valid values are `D|C`',
    `document_date` DATE COMMENT 'The date of the original source document (invoice, receipt, contract) that triggered the journal entry. May differ from the posting date for accruals, reversals, or late-arriving documents.',
    `document_type` STRING COMMENT 'SAP document type code classifying the nature of the journal entry (e.g., SA=General Ledger, KR=Vendor Invoice, DR=Customer Invoice, AB=Accounting Document, ZP=Payment Posting, AA=Asset Posting). Drives posting rules and account determination. [ENUM-REF-CANDIDATE: SA|KR|DR|AB|ZP|AA|RE|RV|WA|WE — promote to reference product]',
    `entry_timestamp` TIMESTAMP COMMENT 'The precise date and time when the journal entry record was first created and captured in the system. Used for SOX audit trails, data lineage, and period-end close monitoring.',
    `entry_type` STRING COMMENT 'Business classification of the journal entry indicating its accounting purpose: original posting, reversal of a prior entry, period-end accrual, asset depreciation run, currency revaluation, or intercompany elimination.. Valid values are `original|reversal|accrual|depreciation|revaluation|intercompany`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign currency exchange rate applied to convert the transaction currency amount to the local currency at the time of posting. Critical for multi-currency reconciliation, currency revaluation, and GAAP/IFRS IAS 21 compliance.',
    `fiscal_period` STRING COMMENT 'The accounting period (1–16) within the fiscal year to which the journal entry belongs. Periods 13–16 are typically used for special period-end adjustments, accruals, and audit postings.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the journal entry is recorded (e.g., 2024). Used for annual financial reporting, SOX compliance, and year-end close processes.',
    `group_amount` DECIMAL(18,2) COMMENT 'The monetary amount of the journal entry converted to the group (consolidation) currency. Used for consolidated financial statements, MRR/ARR tracking, and enterprise-level GMV-to-revenue reconciliation.',
    `group_currency` STRING COMMENT 'ISO 4217 three-letter currency code of the enterprise groups reporting currency (e.g., USD). Used for consolidated financial statements and cross-entity comparisons.. Valid values are `^[A-Z]{3}$`',
    `header_text` STRING COMMENT 'Free-text description at the journal entry header level explaining the business purpose or context of the posting (e.g., Q4 Accrual - Marketplace Seller Commissions, Monthly Depreciation Run). Used for audit review and financial close documentation.',
    `is_intercompany` BOOLEAN COMMENT 'Flag indicating whether this journal entry represents an intercompany transaction between two legal entities within the same corporate group (True) or an external third-party transaction (False). Intercompany entries require elimination during group financial consolidation.',
    `is_statistical` BOOLEAN COMMENT 'Flag indicating whether this journal entry is a statistical (non-real) posting used for management reporting and cost allocation purposes only (True), as opposed to a real posting that updates actual financial balances (False). Statistical postings do not affect the balance sheet.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when the journal entry record was last modified. Supports change tracking, audit trails, and incremental data pipeline processing in the Databricks Silver Layer.',
    `line_item_number` STRING COMMENT 'Sequential line number within the journal entry document identifying the position of each debit or credit line. Used to uniquely reference individual line items within a multi-line journal entry for reconciliation and audit purposes.',
    `line_item_text` STRING COMMENT 'Free-text description at the individual line item level providing additional context for the specific debit or credit posting (e.g., Accrued seller commission - Nov 2024, Revenue recognition - Order #ORD-98765). Supports granular audit trails and reconciliation.',
    `local_amount` DECIMAL(18,2) COMMENT 'The monetary amount of the journal entry converted to the local (company code) currency. Used for statutory financial reporting and local GAAP compliance in the jurisdiction of the legal entity.',
    `local_currency` STRING COMMENT 'ISO 4217 three-letter currency code of the company codes local (functional) currency (e.g., USD for US entities, EUR for EU entities). Used for local statutory reporting and tax filings.. Valid values are `^[A-Z]{3}$`',
    `posting_date` DATE COMMENT 'The principal real-world accounting date on which the journal entry is posted to the general ledger. Determines the fiscal period assignment and is the primary date used for period-end close, financial reporting, and regulatory submissions.',
    `posting_key` STRING COMMENT 'SAP two-digit posting key that determines the account type, debit/credit assignment, and field selection for the journal entry line (e.g., 40=GL Debit, 50=GL Credit, 01=Customer Invoice, 31=Vendor Invoice). Drives account determination and field status.',
    `posting_status` STRING COMMENT 'Current lifecycle state of the journal entry in the general ledger workflow. Draft entries are pending approval; posted entries are final; reversed entries have been offset by a counter-entry; parked entries await completion; held entries are saved but not yet posted; error entries failed validation.. Valid values are `draft|posted|reversed|parked|held|error`',
    `reference_document_type` STRING COMMENT 'The type of source business document that originated this journal entry (e.g., order, payment, invoice, purchase_order, return, shipment). Enables traceability from the GL back to the originating operational transaction.. Valid values are `order|payment|invoice|purchase_order|return|shipment`',
    `reversal_date` DATE COMMENT 'The date on which the reversal of this journal entry is scheduled or was executed. Used for automated period-end accrual reversals and audit trail completeness.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry is a reversal of a previously posted entry (True) or an original posting (False). Reversal entries offset prior postings and are critical for period-end close accuracy and SOX audit trails.',
    `reversed_document_number` STRING COMMENT 'The SAP document number of the original journal entry that this entry reverses. Populated only when reversal_indicator is True. Enables audit trail linkage between original and reversal postings.',
    `sap_document_number` STRING COMMENT 'The externally-known accounting document number assigned by SAP S/4HANA upon posting. This is the primary business identifier used by finance teams to reference a journal entry across systems, audit trails, and reconciliation workflows.',
    `source_system` STRING COMMENT 'Identifies the operational system of record that originated this journal entry (e.g., SAP_S4HANA for ERP-generated entries, OMS for order management system auto-postings, PAYMENT_GATEWAY for payment settlement entries, WMS for inventory adjustments, MANUAL for manually entered entries). Supports data lineage and audit trail requirements.. Valid values are `SAP_S4HANA|OMS|PAYMENT_GATEWAY|WMS|MANUAL`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount (VAT, GST, or sales tax) associated with this journal entry in the transaction currency. Used for tax liability reporting, tax reconciliation, and regulatory filings.',
    `tax_code` STRING COMMENT 'SAP tax code identifying the applicable tax rate and tax category (e.g., VAT, GST, sales tax) for the journal entry line. Drives automatic tax calculation and tax reporting to regulatory authorities.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The gross monetary amount of the journal entry in the transaction currency (the currency of the originating business event). Used as the base amount before currency conversion for multi-currency reconciliation.',
    `transaction_currency` STRING COMMENT 'ISO 4217 three-letter currency code of the originating transaction (e.g., USD, EUR, GBP). Represents the currency in which the business event was denominated before conversion to local or group currency.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Authoritative record of all double-entry accounting transactions posted to the general ledger, including both header-level metadata and line-level debit/credit detail. Header captures posting dates, fiscal periods, document types, reference documents (order IDs, payment IDs, invoice numbers), reversal indicators, and SAP document numbers. Each line item captures GL account, cost center, profit center, amount in transaction and local currency, tax code, business area, and trading partner. Supports SOX audit trails, automated period-end close postings (accruals, depreciation, revaluations), and granular reconciliation workflows. Every entry must balance (total debits = total credits).';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual debit or credit line item within a journal entry. Serves as the primary key for this entity in the Databricks Silver Layer.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this expenditure or revenue posting. Used for internal management accounting, departmental P&L reporting, and budget variance analysis.',
    `account_id` BIGINT COMMENT 'Reference to the General Ledger account to which this line item is posted. The GL account determines the financial statement classification (asset, liability, equity, revenue, expense). Satisfies TRANSACTION_LINE RESOURCE_REFERENCE category.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header that this line item belongs to. Establishes the header-detail relationship for the posting document. Satisfies TRANSACTION_LINE HEADER_REFERENCE category.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center associated with this posting line. Enables profitability analysis by business segment, product line, or geographic region within the enterprise.',
    `account_type` STRING COMMENT 'SAP account type indicator for this line item: A=Asset, D=Customer (Debtor), K=Vendor (Creditor), M=Material, S=General Ledger. Determines which subledger the posting affects. Corresponds to KOART in SAP S/4HANA.. Valid values are `A|D|K|M|S`',
    `amount` DECIMAL(18,2) COMMENT 'The monetary amount of this journal entry line in the transaction currency. Always stored as a positive value; the debit_credit_indicator determines the sign direction. Satisfies TRANSACTION_LINE LINE_VALUE_OR_RESULT category. Corresponds to WRBTR in SAP S/4HANA.',
    `amount_group_currency` DECIMAL(18,2) COMMENT 'The monetary amount of this line item translated into the group (consolidation) currency for enterprise-wide financial consolidation and consolidated financial statement preparation. Corresponds to KZBTR in SAP S/4HANA.',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'The monetary amount of this line item translated into the company code local currency (functional currency). Used for statutory financial reporting in the entitys home jurisdiction. Corresponds to DMBTR in SAP S/4HANA.',
    `assignment_number` STRING COMMENT 'Alphanumeric assignment field used for sorting and matching open items in accounts receivable and accounts payable clearing. Typically populated with the customer/vendor reference or payment advice number. Corresponds to ZUONR in SAP S/4HANA.',
    `business_area` STRING COMMENT 'SAP business area code representing a distinct area of operations or responsibility within the enterprise (e.g., marketplace, fulfillment, logistics). Enables cross-company-code financial reporting by business segment. Corresponds to GSBER in SAP S/4HANA.. Valid values are `^[A-Z0-9]{1,4}$`',
    `clearing_date` DATE COMMENT 'The date on which this open item was cleared (matched and offset) against a payment or credit memo. Null if the item remains open. Used for aging analysis and DSO (Days Sales Outstanding) calculations. Corresponds to AUGDT in SAP S/4HANA.',
    `clearing_document_number` STRING COMMENT 'The accounting document number that cleared (offset) this open item in accounts receivable or accounts payable. Populated when an invoice is matched against a payment. Corresponds to AUGBL in SAP S/4HANA.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity or organizational unit for which this journal entry line is posted. Enables multi-entity financial consolidation and legal reporting. Corresponds to BUKRS in SAP S/4HANA.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry line record was created in the system. Provides the audit trail creation timestamp required for SOX compliance and financial record integrity. Corresponds to CPUDT/CPUTM in SAP S/4HANA.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction amount on this line item (e.g., USD, EUR, GBP). Enables multi-currency financial reporting and foreign exchange revaluation. Corresponds to WAERS in SAP S/4HANA.. Valid values are `^[A-Z]{3}$`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this line item is a debit (D) or credit (C) posting. Fundamental to double-entry bookkeeping; every journal entry must have equal debits and credits. Corresponds to SHKZG in SAP S/4HANA.. Valid values are `D|C`',
    `document_date` DATE COMMENT 'The date of the original source document (invoice, receipt, contract) that triggered this journal entry line. May differ from the posting date when documents are processed with a lag. Corresponds to BLDAT in SAP S/4HANA.',
    `document_type` STRING COMMENT 'Two-character SAP document type classifying the nature of the accounting document (e.g., SA=GL posting, KR=vendor invoice, DR=customer invoice, ZP=payment, AB=asset posting). Controls number range assignment and account types allowed. Corresponds to BLART in SAP S/4HANA.. Valid values are `^[A-Z0-9]{2}$`',
    `due_date` DATE COMMENT 'The calculated due date for payment of this line item based on the document date and payment terms. Used for cash flow forecasting, payment run scheduling, and overdue item identification. Corresponds to FAEDT in SAP S/4HANA.',
    `fiscal_period` STRING COMMENT 'The fiscal period (accounting period, typically 1–12 for monthly, or 1–16 including special periods) within the fiscal year for this posting. Enables period-level financial reporting and month-end close tracking. Corresponds to POPER in SAP S/4HANA.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this journal entry line is recorded for financial reporting purposes. Used for annual financial statement preparation and year-over-year comparisons. Corresponds to GJAHR in SAP S/4HANA.',
    `functional_area` STRING COMMENT 'Functional area classification for this posting line, used to categorize expenses by business function (e.g., cost of goods sold, selling, general and administrative, research and development) for income statement presentation. Corresponds to FKBER in SAP S/4HANA.',
    `is_cleared` BOOLEAN COMMENT 'Boolean flag indicating whether this open item has been cleared (True) or remains open (False) in the subledger. Drives open item management reporting for AR and AP aging analysis.',
    `line_item_text` STRING COMMENT 'Free-text description of this individual journal entry line item, providing business context for the posting (e.g., Q3 marketplace commission accrual, FBA fulfillment fee reversal). Corresponds to SGTXT in SAP S/4HANA.',
    `line_number` STRING COMMENT 'Sequential line number within the parent journal entry, used to order and uniquely identify each posting line within a document. Satisfies TRANSACTION_LINE LINE_SEQUENCE category. Corresponds to BUZEI in SAP S/4HANA ACDOCA.',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the company code local (functional) currency. Enables reconciliation between transaction currency and statutory reporting currency. Corresponds to HWAER in SAP S/4HANA.. Valid values are `^[A-Z]{3}$`',
    `payment_terms` STRING COMMENT 'Payment terms key applicable to this line item, defining the due date calculation and any early payment discount conditions (e.g., NET30, 2/10NET30). Relevant for vendor invoice and customer invoice line items. Corresponds to ZTERM in SAP S/4HANA.. Valid values are `^[A-Z0-9]{1,4}$`',
    `posting_date` DATE COMMENT 'The date on which this journal entry line is posted to the General Ledger. Determines the fiscal period assignment and is the primary date used for financial reporting and period-end close. Corresponds to BUDAT in SAP S/4HANA. Satisfies TRANSACTION_LINE LINE_VALUE_OR_RESULT temporal component.',
    `posting_key` STRING COMMENT 'Two-digit SAP posting key that controls the account type, debit/credit direction, and field selection for this line item (e.g., 40=GL debit, 50=GL credit, 01=customer invoice, 31=vendor invoice). Corresponds to BSCHL in SAP S/4HANA.. Valid values are `^[0-9]{2}$`',
    `profit_center_partner` STRING COMMENT 'The partner profit center for intercompany or intra-company eliminations in profit center accounting. Used to eliminate internal transactions during segment and consolidated financial reporting. Corresponds to PRCTR_PARTNER in SAP S/4HANA.',
    `reference_document_number` STRING COMMENT 'External reference number from the originating source document (e.g., vendor invoice number, purchase order number, payment reference). Enables traceability from the GL posting back to the originating business transaction. Corresponds to XBLNR in SAP S/4HANA.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry line is a reversal posting (True) that offsets a previously posted entry. Critical for audit trail integrity and period-end close accuracy under SOX controls.',
    `reversal_reason_code` STRING COMMENT 'Code identifying the business reason for reversing this journal entry line (e.g., incorrect account, wrong period, duplicate posting, accrual reversal). Supports audit trail documentation and SOX compliance. Corresponds to STGRD in SAP S/4HANA.',
    `segment` STRING COMMENT 'Financial reporting segment assigned to this line item for segment-level P&L reporting under IFRS 8 or ASC 280. Represents a distinct business unit such as B2C marketplace, B2B wholesale, or third-party logistics. Corresponds to SEGMENT in SAP S/4HANA.',
    `source_ledger` STRING COMMENT 'The SAP ledger from which this journal entry line originates (e.g., 0L=Leading Ledger GAAP, 1L=Local GAAP extension ledger, 2L=IFRS extension ledger). Supports parallel accounting under multiple accounting standards. Corresponds to RLDNR in SAP S/4HANA.. Valid values are `0L|1L|2L|3L`',
    `special_gl_indicator` STRING COMMENT 'SAP special GL indicator used to classify non-standard postings such as down payments, guarantees, bills of exchange, or statistical postings. Enables separate reporting of these items from standard AR/AP balances. Corresponds to UMSKZ in SAP S/4HANA.. Valid values are `^[A-Z0-9]?$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount (VAT, GST, or sales tax) associated with this journal entry line in the transaction currency. Used for tax reporting, VAT return preparation, and tax reconciliation workflows.',
    `tax_code` STRING COMMENT 'Tax code assigned to this line item, determining the applicable tax rate and tax account for VAT, GST, or sales tax calculations. Drives automatic tax line generation in SAP S/4HANA. Corresponds to MWSKZ in SAP S/4HANA.. Valid values are `^[A-Z0-9]{1,4}$`',
    `trading_partner` STRING COMMENT 'Company code of the intercompany trading partner for intercompany transaction identification and elimination during group financial consolidation. Corresponds to VBUND in SAP S/4HANA.. Valid values are `^[A-Z0-9]{1,6}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry line record was last modified in the source system or Silver Layer. Supports change data capture, reconciliation workflows, and audit trail completeness.',
    `value_date` DATE COMMENT 'The date on which the financial value of this posting becomes effective for cash flow and liquidity management purposes. Particularly relevant for bank postings and payment transactions. Corresponds to VALUT in SAP S/4HANA.',
    `created_by` STRING COMMENT 'SAP user ID of the person or system process that created this journal entry line. Essential for SOX audit trail, segregation of duties compliance, and financial control monitoring. Corresponds to USNAM in SAP S/4HANA.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit or credit line items within a journal entry. Captures GL account, cost center, profit center, amount, currency, tax code, and business area for each posting line. Enables granular financial analysis at the line-item level and supports reconciliation workflows in SAP S/4HANA.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique surrogate identifier for the cost center record in the enterprise data platform. Primary key for the cost_center master data product.',
    `agent_id` BIGINT COMMENT 'Employee ID of the manager accountable for this cost centers budget, expenditures, and financial performance. Used for budget approval workflows, variance reporting, and SOX control ownership assignment.',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `activity_type_code` STRING COMMENT 'SAP CO activity type code associated with this cost center for activity-based costing. Activity types define the unit of output (e.g., machine hours, labor hours, API calls) used to allocate costs to cost objects such as orders or projects.. Valid values are `^[A-Z0-9_-]{1,10}$`',
    `actual_posting_allowed` BOOLEAN COMMENT 'Indicates whether actual cost postings (from FI, MM, HR, etc.) are permitted to this cost center. Controls financial transaction authorization at the cost center level in SAP CO.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total approved annual budget allocated to this cost center in the controlling currency. Represents the planned expenditure ceiling for the fiscal year. Used for budget vs. actual variance analysis and financial planning.',
    `budget_allocation_code` STRING COMMENT 'Code that links this cost center to its approved budget allocation in the annual planning cycle. Used to match actual expenditures against planned budgets in SAP CO-PA and for variance analysis in financial reporting.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `business_unit` STRING COMMENT 'Top-level business unit to which this cost center belongs. Supports P&L reporting segmented by Marketplace, Direct-to-Consumer (DTC), Business-to-Business (B2B), Fulfillment, Technology, and Corporate functions. Enables GMV-to-revenue reconciliation at the segment level.. Valid values are `marketplace|dtc|b2b|fulfillment|technology|corporate`',
    `center_type` STRING COMMENT 'Classifies whether the center tracks costs only (cost center), revenues and costs for P&L (profit center), capital investment accountability (investment center), or revenue generation only (revenue center). Drives how SAP EC-PCA profitability analysis is applied.. Valid values are `cost|profit|investment|revenue`',
    `commitment_posting_allowed` BOOLEAN COMMENT 'Indicates whether commitment postings (purchase orders, purchase requisitions) are permitted to this cost center. Enables funds management and purchase order commitment tracking against the cost center budget.',
    `company_code` STRING COMMENT 'SAP FI company code to which this cost center is assigned. Represents the legal entity for financial accounting and statutory reporting. Used for SOX compliance and inter-company reconciliation.. Valid values are `^[A-Z0-9]{1,4}$`',
    `controlling_area_code` STRING COMMENT 'SAP CO controlling area code that defines the organizational unit within which cost accounting is performed. All cost centers belong to exactly one controlling area, which determines the currency and fiscal year variant for internal reporting.. Valid values are `^[A-Z0-9]{1,4}$`',
    `cost_allocation_method` STRING COMMENT 'Method used to allocate or distribute costs from this cost center to other cost objects. Direct allocation posts costs directly; assessment uses statistical keys; distribution reallocates primary costs; activity-based costing uses activity types. Configured in SAP CO-OM cycle definitions.. Valid values are `direct|assessment|distribution|activity_based`',
    `cost_center_category` STRING COMMENT 'SAP CO cost center category code (e.g., E for administration, F for production, H for auxiliary) that classifies the functional nature of the cost center for internal cost allocation and reporting. [ENUM-REF-CANDIDATE: administration|production|auxiliary|sales|marketing|logistics|technology|finance — promote to reference product]',
    `cost_center_code` STRING COMMENT 'Externally-known alphanumeric code that uniquely identifies the cost center within the controlling area. Sourced from SAP S/4HANA CO module and used across ERP, finance reporting, and budget systems for cross-system reconciliation.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `cost_center_description` STRING COMMENT 'Detailed narrative description of the cost centers business purpose, scope of operations, and the types of expenses it tracks. Supports financial governance and audit documentation.',
    `cost_center_name` STRING COMMENT 'Human-readable name of the cost center as defined in the SAP CO module. Used in financial reports, P&L statements, and budget dashboards to identify the organizational unit.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active centers accept postings; locked centers are frozen for new transactions; archived centers are closed and retained for historical reporting only. Aligns with SAP CO activation status.. Valid values are `active|inactive|locked|pending_approval|archived`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where this cost center operates. Used for statutory reporting, tax jurisdiction assignment, and GDPR/CCPA data residency compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost center master data record was first created in the source system (SAP S/4HANA CO). Used for audit trail, data lineage, and SOX compliance evidence of record creation.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost centers controlling currency (e.g., USD, EUR, GBP). Determines the currency in which cost center budgets, actuals, and variances are reported.. Valid values are `^[A-Z]{3}$`',
    `department` STRING COMMENT 'Functional department within the business unit that owns this cost center (e.g., Engineering, Finance, Marketing, Operations, Logistics). Used for departmental budget tracking and headcount cost allocation.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which the cost centers budget and validity are defined. Aligns with the SAP fiscal year variant configured for the controlling area. Used to scope budget allocations and financial reporting periods.',
    `functional_area_code` STRING COMMENT 'SAP FI functional area code assigned to this cost center, used to classify costs by business function (e.g., Sales, Administration, Production, R&D) for cost-of-sales accounting and segment reporting under GAAP and IFRS.. Valid values are `^[A-Z0-9_-]{1,16}$`',
    `gdpr_relevant` BOOLEAN COMMENT 'Indicates whether this cost center processes or is associated with personal data subject to GDPR obligations. Used for data protection impact assessments and privacy-by-design compliance tracking.',
    `geographic_region` STRING COMMENT 'Geographic region or country code (ISO 3166-1 alpha-3) associated with this cost center. Used for regional P&L reporting, transfer pricing compliance, and multi-currency consolidation in international operations.',
    `gl_account_code` STRING COMMENT 'Primary General Ledger (GL) account code associated with this cost center for financial consolidation in SAP FI-CO. Used to map cost center postings to the chart of accounts for statutory and management reporting.. Valid values are `^[0-9]{6,10}$`',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this cost center within the organizational cost center hierarchy. Level 1 represents the top of the hierarchy (enterprise); higher numbers represent more granular organizational units. Used for hierarchical roll-up and drill-down in financial reporting.',
    `hierarchy_node_code` STRING COMMENT 'Code of the parent node in the standard cost center hierarchy (SAP CO standard hierarchy). Enables roll-up reporting from individual cost centers to department, business unit, and enterprise levels for consolidated financial reporting.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `internal_order_code` STRING COMMENT 'SAP CO internal order code linked to this cost center for project-based or campaign-based cost tracking. Internal orders provide a more granular cost collection object within the cost center for specific initiatives (e.g., a marketing campaign or technology project).. Valid values are `^[A-Z0-9_-]{1,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this cost center master data record in the source system. Used for change detection in ETL pipelines, audit trails, and SOX compliance evidence of record changes.',
    `lock_indicator` BOOLEAN COMMENT 'Indicates whether the cost center is locked for new financial postings. When True, no new actual or plan postings are permitted. Used during period-end close, audits, or organizational restructuring to prevent unauthorized transactions.',
    `mrr_tracking_enabled` BOOLEAN COMMENT 'Indicates whether this cost center is configured to track Monthly Recurring Revenue (MRR) contributions for subscription-based revenue recognition. Relevant for B2B and marketplace seller subscription fee revenue streams.',
    `parent_cost_center_code` STRING COMMENT 'Code of the parent cost center in a self-referencing hierarchy, enabling recursive organizational roll-up for management reporting. Null for top-level cost centers.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `plan_posting_allowed` BOOLEAN COMMENT 'Indicates whether planning postings (budget and forecast entries) are permitted to this cost center. Controls whether the cost center participates in the annual planning and rolling forecast cycles in SAP CO-OM.',
    `responsible_manager_name` STRING COMMENT 'Full name of the manager responsible for this cost center. Stored as a denormalized display field for financial reports and budget dashboards without requiring a join to the HR system.',
    `segment_code` STRING COMMENT 'Reporting segment code assigned to this cost center for IFRS 8 and GAAP ASC 280 segment disclosures. Enables GMV-to-revenue reconciliation and P&L reporting at the segment level (e.g., Marketplace, DTC, B2B).. Valid values are `^[A-Z0-9_-]{1,10}$`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this cost center master data was sourced. Primarily SAP S/4HANA CO module. Used for data lineage tracking and ETL reconciliation in the Silver layer.. Valid values are `sap_s4hana|erp_legacy|manual|migration`',
    `sox_relevant` BOOLEAN COMMENT 'Indicates whether this cost center is in scope for Sarbanes-Oxley (SOX) internal controls over financial reporting. SOX-relevant cost centers require documented control procedures, segregation of duties, and periodic audit evidence.',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code assigned to this cost center for indirect tax (VAT/GST/sales tax) determination and reporting. Used in SAP FI-TX for tax calculation on cost center-related procurement and expense transactions.. Valid values are `^[A-Z0-9_-]{1,15}$`',
    `wbs_element_code` STRING COMMENT 'SAP PS Work Breakdown Structure (WBS) element code associated with this cost center for project cost tracking. Enables project-level cost reporting and capital expenditure (CapEx) vs. operating expenditure (OpEx) classification.. Valid values are `^[A-Z0-9._-]{1,24}$`',
    `valid_from` DATE COMMENT 'The date from which this cost center is active and can accept financial postings. Corresponds to the SAP CO validity period start date. Cost center records are time-sliced; this field defines the start of the current validity interval.',
    `valid_to` DATE COMMENT 'The date until which this cost center is active and can accept financial postings. Corresponds to the SAP CO validity period end date. A null or far-future date (e.g., 9999-12-31) indicates an open-ended validity period.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Master data for organizational cost centers and profit centers used to track, allocate, and report on operational expenses and internal profitability across business units, departments, and functions. Owns cost/profit center hierarchy, center type (cost-only or profit-tracking), responsible managers, budget allocation codes, and validity periods. Supports GMV-to-revenue reconciliation at the segment level and P&L reporting by business unit (marketplace, DTC, B2B). Integrates with SAP S/4HANA CO module for internal cost controlling and EC-PCA for profitability analysis.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique surrogate identifier for the profit center record in the enterprise data lakehouse. Primary key for the profit_center master data product.',
    `allocation_method` STRING COMMENT 'Method used to allocate shared costs and overhead to this profit center in SAP CO. direct = costs posted directly; assessment = allocated via assessment cycles; distribution = allocated via distribution cycles; settlement = settled from internal orders or projects.. Valid values are `direct|assessment|distribution|settlement`',
    `annual_cost_budget` DECIMAL(18,2) COMMENT 'Planned annual operating cost allocation for this profit center in the profit centers primary currency. Supports cost center management, overhead allocation, and budget adherence tracking.',
    `annual_revenue_budget` DECIMAL(18,2) COMMENT 'Planned annual revenue target for this profit center in the profit centers primary currency. Used for budget vs. actuals variance analysis and segment-level P&L reporting.',
    `budget_fiscal_year` STRING COMMENT 'The fiscal year for which the current budget allocation is defined for this profit center. Used to align budget tracking with the enterprise fiscal calendar in SAP S/4HANA.',
    `change_reason` STRING COMMENT 'Business justification or reason code for the most recent change to this profit centers master data (e.g., Organizational restructuring, New business segment launch, Merger integration). Required for SOX audit trail documentation.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity to which this profit center is assigned for financial consolidation and statutory reporting. Corresponds to the BUKRS field in SAP S/4HANA.. Valid values are `^[A-Z0-9]{1,4}$`',
    `controlling_area_code` STRING COMMENT 'SAP Controlling (CO) area code to which this profit center belongs. The controlling area defines the organizational unit within which cost and profit center accounting is performed. Corresponds to the KOKRS field in SAP.. Valid values are `^[A-Z0-9]{1,4}$`',
    `cost_center_code` STRING COMMENT 'Associated cost center code in SAP CO for tracking operating expenses attributable to this profit center. Enables cost allocation and margin analysis at the segment level.. Valid values are `^[A-Z0-9_-]{2,10}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary country of operation for this profit center. Used for statutory reporting, tax jurisdiction assignment, and regulatory compliance (GDPR, CCPA).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this profit center record was first created in the enterprise data lakehouse. Supports audit trail requirements and data lineage tracking per SOX and ISO 27001 controls.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the primary transaction currency for this profit center (e.g., USD, EUR, GBP). Used for financial postings, P&L reporting, and GMV-to-revenue reconciliation.. Valid values are `^[A-Z]{3}$`',
    `data_privacy_classification` STRING COMMENT 'Data classification level assigned to financial data associated with this profit center per enterprise data governance policy. Drives access control, data masking, and retention policies in the lakehouse.. Valid values are `public|internal|confidential|restricted`',
    `deactivation_date` DATE COMMENT 'The date on which this profit center was deactivated or archived. Null if the profit center is currently active. Used for historical reporting, audit trails, and ensuring no new postings are made to deactivated profit centers.',
    `department_code` STRING COMMENT 'Organizational department code associated with this profit center. Links the profit center to the enterprise organizational structure for headcount allocation and overhead cost distribution.. Valid values are `^[A-Z0-9_-]{2,15}$`',
    `erp_profit_center_code` STRING COMMENT 'Native profit center identifier as stored in the source ERP system (SAP S/4HANA). Enables traceability and reconciliation between the lakehouse silver layer and the operational SAP system of record.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `fiscal_year_variant` STRING COMMENT 'SAP fiscal year variant code defining the fiscal year calendar applicable to this profit center (e.g., K4 for calendar year, V3 for April-March). Determines period mapping for financial reporting and budget tracking.. Valid values are `^[A-Z0-9]{2}$`',
    `geographic_region` STRING COMMENT 'Geographic region or market associated with this profit center (e.g., North America, EMEA, APAC, LATAM). Supports regional P&L segmentation and cross-border revenue reporting. [ENUM-REF-CANDIDATE: north_america|emea|apac|latam|global — promote to reference product]',
    `gl_account_code` STRING COMMENT 'Primary General Ledger account code associated with this profit center for revenue and cost postings. Links profit center activity to the chart of accounts in SAP S/4HANA FI-GL for financial consolidation.. Valid values are `^[0-9]{6,10}$`',
    `gmv_to_revenue_ratio` DECIMAL(18,2) COMMENT 'The standard ratio used to convert Gross Merchandise Value (GMV) to recognized net revenue for this profit center. For marketplace segments, this reflects the take rate (commission percentage). Critical for GMV-to-revenue reconciliation in financial reporting.',
    `group_code` STRING COMMENT 'Code of the profit center group (node in the standard hierarchy) to which this profit center belongs. Profit center groups enable aggregated reporting across multiple profit centers in SAP EC-PCA.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `hierarchy_level` STRING COMMENT 'Numeric level of the profit center within the enterprise organizational hierarchy (e.g., 1 = top-level division, 2 = business unit, 3 = sub-segment). Supports roll-up reporting in SAP EC-PCA standard hierarchy.',
    `intercompany_trading_partner` STRING COMMENT 'SAP trading partner code identifying the affiliated company for intercompany transactions originating from this profit center. Required for intercompany elimination during financial consolidation. Corresponds to the VBUND field in SAP.. Valid values are `^[A-Z0-9]{1,6}$`',
    `is_dummy` BOOLEAN COMMENT 'Indicates whether this is the dummy profit center used to capture postings that cannot be assigned to a real profit center. Each controlling area has exactly one dummy profit center. Corresponds to the DUMMY field in SAP EC-PCA.',
    `is_statistical` BOOLEAN COMMENT 'Indicates whether this profit center is used for statistical (informational) postings only and does not carry actual financial balances. Statistical profit centers are used for internal management reporting without affecting the general ledger.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this profit center record. Used for change data capture (CDC), audit trail compliance, and detecting unauthorized modifications per SOX internal control requirements.',
    `mrr_applicable` BOOLEAN COMMENT 'Indicates whether this profit center tracks Monthly Recurring Revenue (MRR) as a primary financial metric. Applicable to subscription-based or SaaS business segments. Drives MRR and ARR reporting in financial dashboards.',
    `parent_profit_center_code` STRING COMMENT 'Business code of the parent profit center in the organizational hierarchy. Enables hierarchical roll-up of P&L data for consolidated segment reporting. Self-referencing relationship within the profit center hierarchy.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `profit_center_category` STRING COMMENT 'Functional classification of the profit center indicating whether it is primarily a revenue-generating, cost-bearing, or investment unit. Used for internal profitability analysis and capital allocation decisions.. Valid values are `revenue|cost|investment`',
    `profit_center_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the profit center as defined in SAP S/4HANA EC-PCA. Used in financial postings, journal entries, and segment reporting. Corresponds to the PRCTR field in SAP.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `profit_center_description` STRING COMMENT 'Detailed narrative description of the profit centers business scope, revenue streams, and cost responsibilities. Provides context for financial analysts and auditors.',
    `profit_center_name` STRING COMMENT 'Human-readable business name of the profit center (e.g., Marketplace - North America, DTC - Apparel, B2B - Enterprise). Used in P&L reports and management dashboards.',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center in SAP EC-PCA. active = operational and accepting postings; inactive = temporarily suspended; locked = blocked for new postings (SOX control); pending_activation = created but not yet approved; archived = historical, no longer in use.. Valid values are `active|inactive|locked|pending_activation|archived`',
    `responsible_manager` STRING COMMENT 'Name or employee ID of the business manager accountable for the profit centers financial performance, budget adherence, and P&L outcomes. Used for management reporting and SOX accountability assignments.',
    `revenue_recognition_method` STRING COMMENT 'Accounting method applied for revenue recognition within this profit center. Determines how GMV converts to recognized revenue. point_in_time for standard product sales; over_time for subscription/SaaS; percentage_completion for long-term contracts; milestone for project-based billing.. Valid values are `point_in_time|over_time|percentage_completion|milestone`',
    `segment_type` STRING COMMENT 'Classification of the profit center by primary business model or channel. Drives segment-level P&L reporting and GMV-to-revenue reconciliation. Values: marketplace (third-party seller platform), dtc (Direct to Consumer), b2b (Business to Business), b2c (Business to Consumer), c2c (Consumer to Consumer), fulfillment (logistics/fulfillment services), advertising (ad revenue segment). [ENUM-REF-CANDIDATE: marketplace|dtc|b2b|b2c|c2c|fulfillment|advertising — promote to reference product]',
    `short_name` STRING COMMENT 'Abbreviated display name for the profit center used in condensed financial reports, dashboards, and column headers where space is limited. Corresponds to the KTEXT field in SAP EC-PCA.. Valid values are `^[A-Za-z0-9 _-]{1,20}$`',
    `sox_control_relevant` BOOLEAN COMMENT 'Indicates whether this profit center is subject to Sarbanes-Oxley (SOX) internal control requirements. SOX-relevant profit centers require enhanced audit trails, segregation of duties, and periodic management sign-off on financial balances.',
    `take_rate_pct` DECIMAL(18,2) COMMENT 'The commission percentage charged to marketplace sellers on each transaction, representing the portion of GMV retained as revenue by the platform. Applicable to marketplace and seller-facing profit centers. Used in GMV-to-revenue reconciliation.',
    `target_margin_pct` DECIMAL(18,2) COMMENT 'Planned profit margin percentage target for this profit center, expressed as a percentage of revenue. Used as a KPI benchmark for segment-level profitability reporting and management performance evaluation.',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code assigned to this profit center for tax calculation and reporting purposes. Determines applicable tax rates and rules for revenue and cost postings. Relevant for multi-jurisdiction e-commerce operations.. Valid values are `^[A-Z0-9]{2,15}$`',
    `valid_from_date` DATE COMMENT 'The date from which this profit center becomes effective and can receive financial postings. Defines the start of the profit centers validity period in SAP EC-PCA. Corresponds to the DATAB field in SAP.',
    `valid_to_date` DATE COMMENT 'The date until which this profit center remains valid for financial postings. Null or 9999-12-31 indicates an open-ended validity period. Corresponds to the DATBI field in SAP EC-PCA.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Master data for profit centers representing autonomous business segments for internal profitability reporting. Tracks revenue, costs, and margins by business unit (e.g., marketplace, DTC, B2B). Supports GMV-to-revenue reconciliation and segment-level P&L reporting in SAP S/4HANA EC-PCA module.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`accounts_payable` (
    `accounts_payable_id` BIGINT COMMENT 'Unique surrogate identifier for each accounts payable record in the AP subledger. Primary key for the accounts_payable data product. Entity role: TRANSACTION_HEADER — represents a discrete AP invoice or payable obligation with a full lifecycle.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this payable obligation. Used for internal cost allocation, budget tracking, and financial reporting.',
    `payment_batch_id` BIGINT COMMENT 'Identifier of the automated payment run batch in which this invoice was included for payment processing. Corresponds to the SAP F110 payment run identifier. Used for payment reconciliation, bank statement matching, and audit trail.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the originating purchase order that generated this payable obligation. Used for three-way match (PO, goods receipt, invoice) validation and PO settlement tracking.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier master record associated with this payable obligation. Links to the vendor/supplier master entity for counterparty resolution.',
    `aging_bucket` STRING COMMENT 'Aging classification of the outstanding payable based on the number of days past the invoice date or due date. Used for AP aging reports, cash flow forecasting, vendor relationship management, and SOX financial disclosure. Recalculated daily during Silver layer processing.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `ap_status` STRING COMMENT 'Current lifecycle status of the AP record within the payment workflow. Drives aging analysis, payment run eligibility, and cash flow forecasting. [ENUM-REF-CANDIDATE: open|pending_approval|approved|scheduled|paid|disputed|cancelled — promote to reference product]',
    `approval_status` STRING COMMENT 'The current approval workflow status of the invoice within the AP approval chain. Invoices must be approved before payment release. Supports segregation of duties controls required for SOX compliance.. Valid values are `pending|approved|rejected|escalated`',
    `approved_by` STRING COMMENT 'The username or employee ID of the individual who approved the invoice for payment. Required for SOX segregation of duties audit trail and internal controls documentation.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the invoice was approved for payment processing. Part of the SOX-required audit trail for AP internal controls. Distinct from posting date and payment date.',
    `base_currency_amount` DECIMAL(18,2) COMMENT 'The net payable amount converted to the company code base currency (typically USD) using the exchange rate at posting date. Required for consolidated financial reporting, GL posting, and multi-currency AP subledger reconciliation. Corresponds to DMBTR in SAP FI-AP.',
    `company_code` STRING COMMENT 'The SAP company code representing the legal entity or organizational unit responsible for this payable obligation. Required for multi-entity financial consolidation, intercompany elimination, and entity-level SOX reporting. Corresponds to BUKRS in SAP FI-AP.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the AP record was first created in the system. Used for audit trail, SOX compliance, and data lineage tracking. Corresponds to CPUDT/CPUTM in SAP FI-AP.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the invoice amount (e.g., USD, EUR, GBP). Required for multi-currency AP management, foreign exchange revaluation, and cross-border vendor payment processing.. Valid values are `^[A-Z]{3}$`',
    `days_past_due` STRING COMMENT 'Number of calendar days the invoice has exceeded its payment due date. Negative values indicate days until due. Zero indicates due today. Used for AP aging analysis, vendor penalty calculations, and cash flow management. Recalculated daily.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The cash discount amount available if payment is made within the early payment discount window defined in the payment terms (e.g., 2/10 net 30). Supports working capital optimization and dynamic discounting programs.',
    `discount_due_date` DATE COMMENT 'The last date by which payment must be made to qualify for the early payment discount. Calculated from invoice date plus discount period days in the payment terms. Drives dynamic discounting and working capital optimization decisions.',
    `dispute_reason` STRING COMMENT 'The reason code for placing an invoice in disputed status. Populated when ap_status is disputed. Drives dispute resolution workflows, vendor communication, and root cause analysis for AP exception management.. Valid values are `price_discrepancy|quantity_mismatch|duplicate_invoice|missing_gr|quality_issue|unauthorized_charge`',
    `due_date` DATE COMMENT 'The date by which payment must be made to the vendor to satisfy the invoice obligation and comply with agreed payment terms. Calculated from invoice date plus payment term days. Critical for cash flow planning and avoiding late payment penalties.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the invoice currency amount to the company code base currency at the time of posting. Required for foreign currency AP revaluation, FX gain/loss reporting, and multi-currency reconciliation. Corresponds to KURSF in SAP FI-AP.',
    `fiscal_period` STRING COMMENT 'The fiscal posting period (01–12 for regular periods, 13–16 for special closing periods) within the fiscal year. Used for period-end close, monthly AP subledger reconciliation, and financial reporting. Corresponds to MONAT in SAP FI-AP.. Valid values are `^(0[1-9]|1[0-6])$`',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this AP document is posted. Used for period-end close, financial reporting, and year-over-year AP analysis. Corresponds to GJAHR in SAP FI-AP.. Valid values are `^[0-9]{4}$`',
    `goods_receipt_number` STRING COMMENT 'The goods receipt document number from the Warehouse Management System confirming physical receipt of goods or services associated with this invoice. Required for three-way match validation. Corresponds to LFBNR in SAP FI-AP.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total gross amount of the vendor invoice before any deductions, discounts, or adjustments. Represents the full obligation as stated on the vendor invoice. Used for GMV-to-revenue reconciliation and AP aging analysis.',
    `invoice_date` DATE COMMENT 'The date printed on the vendor invoice document. Serves as the principal business event date for the payable obligation and is the baseline for payment term calculations and aging bucket assignment.',
    `invoice_number` STRING COMMENT 'The externally-assigned invoice number provided by the vendor or supplier on the source invoice document. Used as the primary business identifier for matching, dispute resolution, and audit trails. Corresponds to BELNR in SAP FI-AP.',
    `invoice_type` STRING COMMENT 'Classification of the AP document type. Standard invoices represent normal vendor payables; credit memos reduce outstanding balances; debit memos increase obligations; recurring invoices are for subscription/SaaS vendors; prepayments are advance payments; intercompany invoices are for internal entity transactions. Corresponds to BLART in SAP FI-AP.. Valid values are `standard|credit_memo|debit_memo|recurring|prepayment|intercompany`',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this invoice is part of a recurring payment schedule (e.g., SaaS subscriptions, lease payments, maintenance contracts). Recurring invoices are auto-generated by SAP recurring entry programs. Used for MRR/ARR tracking and cash flow forecasting.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net amount payable to the vendor after deducting applicable discounts, credits, and adjustments from the gross invoice amount. Represents the actual cash outflow obligation. Used for payment run execution and cash flow forecasting.',
    `payment_block_code` STRING COMMENT 'SAP FI-AP payment block indicator that prevents automatic payment processing when set. Common values: R (manual review), A (disputed), B (blocked by purchasing), V (verified pending). Empty string indicates no block. Corresponds to ZLSPR in SAP FI-AP.. Valid values are `R|A|B|V|`',
    `payment_date` DATE COMMENT 'The actual date on which payment was executed and disbursed to the vendor. Populated upon successful payment run completion. Used for cash flow reporting, bank reconciliation, and vendor account statement generation.',
    `payment_method` STRING COMMENT 'The method by which payment will be or was made to the vendor (e.g., ACH, wire transfer, check, virtual card, EFT, SEPA). Corresponds to ZLSCH in SAP FI-AP. Used for payment run configuration and bank reconciliation.. Valid values are `ACH|wire|check|virtual_card|EFT|SEPA`',
    `payment_reference` STRING COMMENT 'The bank or payment gateway reference number assigned when payment was executed. Used for bank statement reconciliation, payment confirmation, and vendor remittance advice. Corresponds to AUGBL in SAP FI-AP.',
    `payment_terms_code` STRING COMMENT 'The vendor-agreed payment terms code defining the payment schedule, discount periods, and due date calculation rules (e.g., NET30, 2/10NET30, NET60). Corresponds to ZTERM in SAP FI-AP. Drives automated due date and discount date calculation.',
    `posting_date` DATE COMMENT 'The date on which the AP document was posted to the general ledger in SAP S/4HANA. Determines the accounting period for financial reporting and revenue recognition. Corresponds to BUDAT in SAP FI-AP.',
    `sap_document_number` STRING COMMENT 'The SAP FI document number (BELNR) assigned upon posting to the general ledger. Serves as the system-of-record identifier in SAP S/4HANA for cross-referencing between the AP subledger and the general ledger. Required for audit trail and financial reconciliation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax component of the vendor invoice, including VAT, GST, or applicable sales tax. Separated from gross amount for tax reporting, input tax credit recovery, and compliance with tax authority requirements.',
    `three_way_match_status` STRING COMMENT 'Result of the three-way match validation comparing the purchase order, goods receipt (GR), and vendor invoice. A matched status is required before invoice approval and payment release. Exceptions trigger manual review workflows. Critical for AP internal controls and SOX compliance.. Valid values are `matched|partial_match|unmatched|exception|not_applicable`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the AP record. Supports change tracking, audit trails, and incremental data pipeline processing for the Silver layer.',
    `vendor_invoice_receipt_date` DATE COMMENT 'The date on which the vendor invoice was physically or electronically received by the AP department. Distinct from invoice date (vendor-stamped) and posting date (system-stamped). Used for SLA compliance tracking and payment term baseline calculations where terms start from receipt date.',
    `vendor_type` STRING COMMENT 'Classification of the vendor category for this payable. Distinguishes between product suppliers, 3PL carrier invoices, marketplace seller disbursement obligations, SaaS vendor subscriptions, intercompany entities, and utility providers. Drives routing rules, approval workflows, and reporting segmentation.. Valid values are `supplier|3pl_carrier|marketplace_seller|saas_vendor|intercompany|utility`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The withholding tax amount deducted from the vendor payment at source, as required by applicable tax regulations (e.g., 1099 reporting in the US, WHT for cross-border payments). Corresponds to QSSHB in SAP FI-AP. Required for tax compliance reporting.',
    CONSTRAINT pk_accounts_payable PRIMARY KEY(`accounts_payable_id`)
) COMMENT 'SSOT for vendor and supplier payable obligations and AP subledger management. Tracks AP invoices, credit memos, payment terms, due dates, payment status, aging buckets, three-way match results, and payment batch execution. Covers 3PL carrier invoices, marketplace seller disbursement obligations, SaaS vendor subscriptions, and supplier PO settlements. Integrates with SAP S/4HANA FI-AP for automated payment runs and vendor account reconciliation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` (
    `accounts_receivable_id` BIGINT COMMENT 'Unique surrogate primary key for each accounts receivable record in the AR subledger. Serves as the system-of-record identifier for all AR transactions within the finance domain. Entity role: TRANSACTION_HEADER.',
    `agent_id` BIGINT COMMENT 'Reference to the internal collections agent or team assigned to manage the recovery of this overdue AR balance. Used for workload distribution, collector performance reporting, and escalation tracking in the collections workflow.',
    `header_id` BIGINT COMMENT 'Reference to the originating order that generated this AR invoice. Links the receivable to the Order Management System (OMS) for order-to-cash reconciliation and GMV-to-revenue tracing.',
    `seller_profile_id` BIGINT COMMENT 'Reference to the marketplace seller for whom a fee receivable or commission receivable is tracked. Applicable for marketplace seller fee receivables and advertising revenue receivables. Null for direct B2C customer invoices.',
    `aging_bucket` STRING COMMENT 'Aging classification of the outstanding AR balance based on days past due. Used in AR aging reports for credit risk assessment, bad debt provisioning, and executive financial reporting. Recalculated daily based on due_date vs. current date.. Valid values are `current|1_30_days|31_60_days|61_90_days|91_120_days|over_120_days`',
    `amount_paid` DECIMAL(18,2) COMMENT 'Cumulative amount of payments applied to this AR invoice to date. Supports partial payment tracking and open_amount calculation. Updated each time a payment is matched via cash application.',
    `ar_status` STRING COMMENT 'Current lifecycle state of the AR record within the collection and settlement workflow. Drives dunning automation, aging bucket classification, and cash application processes in SAP FI-AR. Transitions: open → partially_paid → paid; open → overdue → written_off; open → disputed.. Valid values are `open|partially_paid|paid|overdue|disputed|written_off`',
    `ar_type` STRING COMMENT 'Classification of the AR record by the nature of the receivable. Distinguishes B2B customer invoicing, marketplace seller fee receivables, advertising revenue receivables, and subscription billing per the product scope. Drives subledger routing and revenue recognition treatment.. Valid values are `customer_invoice|seller_fee|advertising_revenue|subscription_billing|credit_memo`',
    `billing_document_number` STRING COMMENT 'The source billing document number from the Order Management System or SAP SD (Sales and Distribution) that triggered the creation of this AR invoice. Enables order-to-cash traceability and billing dispute resolution.',
    `cash_application_date` DATE COMMENT 'The date on which incoming payment was matched and applied to this AR invoice in the cash application process. Null if no payment has been applied. Used for DSO calculation, bank reconciliation, and revenue recognition confirmation.',
    `company_code` STRING COMMENT 'The SAP company code representing the legal entity under which this AR invoice is posted. Required for multi-entity financial consolidation, intercompany elimination, and statutory reporting. Corresponds to SAP BUKRS field.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_code` STRING COMMENT 'The cost center to which the AR revenue is attributed for internal management reporting and P&L allocation. Corresponds to SAP CO-PA KOSTL field. Used for segment reporting and profitability analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the AR record was first created in the system of record (SAP FI-AR posting timestamp). Used for audit trail, SOX compliance, and data lineage tracking. Corresponds to SAP CPUDT/CPUTM fields.',
    `credit_memo_amount` DECIMAL(18,2) COMMENT 'The monetary value of the credit memo applied against this AR invoice. Reduces the net receivable balance. Null if no credit memo has been applied. Used in AR reconciliation and revenue adjustment reporting.',
    `credit_memo_number` STRING COMMENT 'Reference number of the credit memo issued against this AR invoice, if applicable. Used for returns, billing adjustments, and dispute resolutions. Links to the credit memo document in SAP FI-AR for offset processing.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the invoice is denominated (e.g., USD, EUR, GBP). Required for multi-currency AR management, FX translation to functional currency, and international trade compliance.. Valid values are `^[A-Z]{3}$`',
    `days_past_due` STRING COMMENT 'Number of calendar days the AR invoice is past its due_date as of the last calculation date. Zero or negative for current invoices. Drives aging_bucket assignment, dunning escalation, and bad debt reserve calculations.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the invoice, including early payment discounts (cash discounts), promotional discounts, and contractual volume discounts. Reduces the net amount due from the customer.',
    `dispute_reason` STRING COMMENT 'Standardized reason code for the customer dispute raised against this AR invoice. Used for root cause analysis, dispute trend reporting, and process improvement in billing and order fulfillment. [ENUM-REF-CANDIDATE: pricing_error|duplicate_invoice|goods_not_received|quality_issue|unauthorized_charge|other — promote to reference product if additional codes are needed]. Valid values are `pricing_error|duplicate_invoice|goods_not_received|quality_issue|unauthorized_charge|other`',
    `dispute_status` STRING COMMENT 'Current status of any billing dispute raised by the customer against this AR invoice. Drives dunning_block activation, collection hold, and dispute resolution workflow routing. Integrates with the Customer Data Platform for dispute case management.. Valid values are `no_dispute|under_review|escalated|resolved|rejected`',
    `due_date` DATE COMMENT 'The contractual date by which the customer must remit payment in full. Calculated from invoice_date plus the applicable payment term days. Drives dunning level escalation, overdue classification, and SLA breach alerts.',
    `dunning_block` BOOLEAN COMMENT 'Flag indicating whether automated dunning is blocked for this AR record (e.g., due to active dispute, customer agreement, or manual hold). When True, the dunning run in SAP FI-AR will skip this record. Corresponds to SAP MANSP field.',
    `dunning_date` DATE COMMENT 'The date on which the most recent dunning notice was issued to the customer for this AR record. Used to enforce minimum dunning intervals and track collection activity history. Corresponds to SAP FI-AR MAHND field.',
    `dunning_level` STRING COMMENT 'Current dunning escalation level for overdue AR, ranging from 0 (no dunning) to 4 (final notice / legal escalation). Incremented by the automated dunning run in SAP FI-AR. Drives collection workflow routing and customer communication templates. Corresponds to SAP MAHNS field.',
    `fiscal_period` STRING COMMENT 'The fiscal accounting period (1–12 or 1–16 for special periods) within the fiscal year in which the AR invoice is posted. Used for monthly close, period-over-period AR trend analysis, and MRR/ARR revenue tracking. Corresponds to SAP MONAT field.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the AR invoice is recognized for financial reporting purposes. Used for period-end close, annual financial statements, and SOX-controlled period locking. Corresponds to SAP GJAHR field.',
    `gl_account_code` STRING COMMENT 'The General Ledger (GL) account code to which this AR transaction is posted in SAP S/4HANA FI. Used for financial consolidation, trial balance, and regulatory financial reporting. Corresponds to SAP HKONT (GL Account) field.. Valid values are `^[0-9]{6,10}$`',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total gross amount billed to the customer or counterparty before any discounts, credits, or adjustments. Represents the face value of the invoice. Used in GMV-to-revenue reconciliation and AR aging analysis.',
    `invoice_date` DATE COMMENT 'The principal business event date on which the invoice was issued to the customer or counterparty. Used as the baseline for payment term calculation, aging analysis, and revenue recognition. Corresponds to SAP FI-AR BLDAT (Document Date).',
    `invoice_number` STRING COMMENT 'Externally-visible, human-readable invoice reference number assigned to the AR document. Used in customer-facing communications, remittance matching, and audit trails. Corresponds to the SAP FI-AR BELNR (Accounting Document Number) field.. Valid values are `^INV-[0-9]{4}-[0-9]{8}$`',
    `net_amount` DECIMAL(18,2) COMMENT 'The net amount due from the customer after applying discounts and adjustments (gross_amount - discount_amount). Represents the actual receivable balance for this invoice. Used in aging buckets and collection workflows.',
    `open_amount` DECIMAL(18,2) COMMENT 'The current outstanding balance remaining on the AR invoice after partial payments, credit memo applications, and cash applications. Equals net_amount minus total payments applied. Drives collection prioritization and DSO calculation.',
    `payment_block` BOOLEAN COMMENT 'Flag indicating whether this AR invoice has been blocked from automated payment clearing (e.g., pending dispute resolution, credit hold, or manual review). When True, the automatic payment program in SAP FI-AR will not clear this item. Corresponds to SAP ZLSPR field.',
    `payment_method` STRING COMMENT 'The payment instrument or method by which the customer is expected to or has settled the invoice. Drives cash application routing, reconciliation logic, and payment gateway integration. Corresponds to SAP FI-AR ZLSCH (Payment Method) field.. Valid values are `bank_transfer|credit_card|direct_debit|check|platform_credit|marketplace_settlement`',
    `payment_terms_code` STRING COMMENT 'The payment terms code governing when payment is due and any early payment discount conditions (e.g., NET30, NET60, 2/10NET30). Corresponds to SAP FI-AR ZTERM field. Determines due_date calculation and cash discount eligibility.. Valid values are `^[A-Z0-9]{2,10}$`',
    `payment_terms_days` STRING COMMENT 'The number of days from invoice date within which payment is due, as defined by the payment terms code. Stored explicitly for aging bucket calculation and DSO (Days Sales Outstanding) analytics without requiring a join to payment terms reference data.',
    `promised_payment_date` DATE COMMENT 'The date on which the customer has committed to making payment, as captured during a collection contact or payment arrangement. Used to track promise-to-pay (PTP) agreements and measure collection effectiveness.',
    `revenue_recognition_date` DATE COMMENT 'The date on which revenue associated with this AR invoice is recognized per ASC 606 / IFRS 15 five-step model. May differ from invoice_date for subscription billing, milestone-based contracts, or deferred revenue scenarios.',
    `source_system` STRING COMMENT 'Identifies the originating operational system that generated this AR record. Supports data lineage, reconciliation between systems, and multi-source AR consolidation in the Silver layer lakehouse.. Valid values are `SAP_S4HANA|OMS|MARKETPLACE_PORTAL|SUBSCRIPTION_PLATFORM|ADVERTISING_PLATFORM`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax component of the invoice, including VAT, GST, or sales tax as applicable by jurisdiction. Separated from gross amount for tax reporting, remittance, and regulatory compliance purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the AR record, including status changes, payment applications, dispute updates, or write-off processing. Essential for change data capture (CDC) and SOX audit trail requirements.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'The amount of the AR balance that has been written off as uncollectible bad debt. Populated when ar_status transitions to written_off. Used for bad debt expense reporting, allowance for doubtful accounts, and SOX-controlled write-off approval workflows.',
    `write_off_date` DATE COMMENT 'The date on which the AR balance was formally written off as uncollectible. Required for bad debt expense period recognition, tax deduction timing, and SOX audit trail. Null if no write-off has occurred.',
    `write_off_reason` STRING COMMENT 'Standardized reason code explaining why the AR balance was written off. Required for SOX-controlled write-off approval documentation and bad debt analytics.. Valid values are `bad_debt|bankruptcy|settlement|statute_of_limitations|other`',
    CONSTRAINT pk_accounts_receivable PRIMARY KEY(`accounts_receivable_id`)
) COMMENT 'SSOT for customer and platform receivable balances and AR subledger management. Tracks AR invoices, credit memos, customer payment terms, collection workflows, dunning levels, aging analysis, cash application, and write-off processing. Covers B2B customer invoicing, marketplace seller fee receivables, advertising revenue receivables, and subscription billing. Integrates with SAP S/4HANA FI-AR for automated dunning and payment matching.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique system-generated identifier for each budget record in the enterprise financial planning system. Serves as the primary key for the budget data product.',
    `agent_id` BIGINT COMMENT 'Identifier of the employee or manager who owns and is accountable for this budget. The budget owner is responsible for spend authorization, variance explanations, and forecast updates. Maps to the HR employee master in SAP S/4HANA.',
    `approved_by_agent_id` BIGINT COMMENT 'Identifier of the finance authority (CFO, VP Finance, or delegated approver) who formally authorized this budget. Required for SOX audit trail of budget approval controls.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget allocations are made per cost center; linking provides hierarchy and removes redundant cost_center_code.',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `relevance_config_id` BIGINT COMMENT 'Foreign key linking to search.relevance_config. Business justification: Finance tracks spend on relevance tuning; FK to relevance_config enables precise cost attribution and compliance reporting.',
    `actuals_amount` DECIMAL(18,2) COMMENT 'The actual expenditure or revenue posted against this budget to date, sourced from SAP S/4HANA General Ledger postings. Used for budget-to-actuals variance analysis and remaining budget calculation.',
    `approval_date` DATE COMMENT 'The calendar date on which the budget was formally approved by the authorized approver. Establishes the effective start of budget authorization and is required for SOX audit trail documentation.',
    `approved_amount` DECIMAL(18,2) COMMENT 'The total authorized budget amount for the period as approved by the budget governance process. Represents the baseline against which actuals and variances are measured. Denominated in the currency specified by currency_code.',
    `availability_control_active` BOOLEAN COMMENT 'Indicates whether SAP S/4HANA Funds Management budget availability control is active for this budget, preventing expenditures that would exceed the approved amount. True enables hard stop or warning controls; False allows unrestricted posting.',
    `budget_name` STRING COMMENT 'Descriptive human-readable name for the budget plan (e.g., FY2024 Marketing Annual Budget, Q3 2024 Logistics Operating Budget). Used in financial dashboards and reporting.',
    `budget_number` STRING COMMENT 'Externally-known, human-readable business identifier for the budget plan (e.g., BDG-2024-000123). Used in financial reporting, audit trails, and cross-system references with SAP S/4HANA.. Valid values are `^BDG-[0-9]{4}-[0-9]{6}$`',
    `budget_status` STRING COMMENT 'Current lifecycle state of the budget record within the financial planning and approval workflow. Draft indicates work-in-progress; submitted awaits approval; approved is authorized but not yet active; active is the current operating budget; frozen prevents further changes; closed is the completed period budget; cancelled is voided. [ENUM-REF-CANDIDATE: draft|submitted|approved|active|frozen|closed|cancelled — promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the budget by its financial purpose. Operating budgets cover day-to-day expenses; capital budgets cover long-term investments; headcount budgets cover personnel costs; project budgets are scoped to specific initiatives; contingency budgets are reserve allocations; rolling forecasts are continuously updated plans.. Valid values are `operating|capital|headcount|project|contingency|rolling_forecast`',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit or division responsible for this budget (e.g., BU-ECOM for E-Commerce, BU-LOG for Logistics, BU-MKT for Marketing). Enables cross-BU budget consolidation and performance management.',
    `commitment_amount` DECIMAL(18,2) COMMENT 'Funds earmarked against the budget for internal commitments such as approved purchase requisitions or internal orders that have not yet been converted to purchase orders. Distinct from encumbrances which are legally binding. Sourced from SAP S/4HANA Commitment Management.',
    `company_code` STRING COMMENT 'SAP S/4HANA company code representing the legal entity for which this budget is maintained (e.g., 1000 for Ecommerce Inc. US, 2000 for Ecommerce EU GmbH). Required for legal entity-level financial consolidation and SOX reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides the audit trail creation event required for SOX financial controls and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which budget amounts are denominated (e.g., USD, EUR, GBP). Required for multi-currency budget consolidation and foreign exchange variance analysis.. Valid values are `^[A-Z]{3}$`',
    `encumbrance_amount` DECIMAL(18,2) COMMENT 'Funds reserved against the budget for obligations that have been legally committed but not yet invoiced or paid (e.g., purchase orders raised but not yet received). Reduces available budget. Sourced from SAP S/4HANA Funds Management.',
    `expense_category` STRING COMMENT 'High-level classification of the budget by expense type for management reporting and KPI tracking. Personnel covers headcount and compensation; technology covers software/hardware; marketing covers advertising and promotions (ROAS, CAC tracking); logistics covers fulfillment and 3PL costs; facilities covers real estate and utilities. [ENUM-REF-CANDIDATE: personnel|technology|marketing|logistics|facilities|professional_services|other — promote to reference product]',
    `fiscal_period` STRING COMMENT 'The fiscal period granularity covered by this budget record. Annual covers the full fiscal year; H1/H2 are semi-annual halves; Q1–Q4 are quarterly periods. Enables drill-down from annual to quarterly budget analysis. [ENUM-REF-CANDIDATE: annual|H1|H2|Q1|Q2|Q3|Q4 — 7 candidates stripped; promote to reference product]',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget applies (e.g., 2024). Aligns with the enterprise fiscal calendar defined in SAP S/4HANA for financial consolidation and year-end reporting.',
    `forecast_amount` DECIMAL(18,2) COMMENT 'The latest rolling forecast estimate of expected spend or revenue for the period, updated periodically based on actuals-to-date and forward-looking projections. Supports rolling forecast updates and MRR/ARR tracking.',
    `gl_account_code` STRING COMMENT 'SAP S/4HANA General Ledger account code to which this budget line is mapped (e.g., 600100 for Marketing Expense, 700200 for Logistics Cost). Enables GL-level budget-to-actuals reconciliation and financial statement alignment.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the budget record is locked against further modifications. True means the budget is frozen and no amendments can be made; False means the budget is open for updates. Typically set to True after period-close or year-end freeze.',
    `last_revised_date` DATE COMMENT 'The most recent date on which the budget amounts were formally revised or amended. Null if no revisions have occurred since original approval. Used to track the currency of budget data and trigger re-approval workflows.',
    `notes` STRING COMMENT 'Free-text field for budget owners and finance managers to document assumptions, justifications, revision rationale, or special instructions associated with this budget record. Supports audit trail documentation for SOX compliance.',
    `original_amount` DECIMAL(18,2) COMMENT 'The initial budget amount as approved at the start of the fiscal period before any revisions or amendments. Preserved for variance analysis between original plan and revised/forecast versions. Denominated in currency_code.',
    `period_end_date` DATE COMMENT 'The calendar date on which the budget period expires and spending authorization ends. Null for open-ended rolling forecasts. Used for period-close processes and budget expiry controls.',
    `period_start_date` DATE COMMENT 'The calendar date on which the budget period becomes effective and spending against this budget is authorized to begin. Used for temporal filtering in variance analysis and financial reporting.',
    `remaining_amount` DECIMAL(18,2) COMMENT 'The unspent and uncommitted budget balance available for new spending authorizations, calculated as approved_amount minus actuals_amount minus encumbrance_amount minus commitment_amount. Critical for budget availability checks and spend controls.',
    `revised_amount` DECIMAL(18,2) COMMENT 'The budget amount after formal amendments or mid-period revisions have been approved. Null if no revisions have been made. Used to track budget changes and calculate revision variance vs. original_amount.',
    `revision_count` STRING COMMENT 'The total number of formal revisions or amendments applied to this budget since original approval. A high revision count may indicate planning instability and is tracked for governance and audit purposes.',
    `sap_budget_code` STRING COMMENT 'The native budget object identifier from SAP S/4HANA Funds Management or Controlling module. Used for cross-system reconciliation between the lakehouse silver layer and the ERP system of record. Enables traceability back to the source transaction.',
    `source_system` STRING COMMENT 'Identifies the originating system from which this budget record was sourced or created. SAP_S4HANA indicates direct ERP entry; PLANNING_TOOL indicates integrated planning software; MANUAL indicates direct data entry; SPREADSHEET_IMPORT indicates bulk upload from Excel/CSV. Supports data lineage and audit traceability.. Valid values are `SAP_S4HANA|PLANNING_TOOL|MANUAL|SPREADSHEET_IMPORT`',
    `submission_date` DATE COMMENT 'The date on which the budget was formally submitted for approval by the budget owner. Used to track adherence to the annual budget calendar and planning cycle SLAs.',
    `tolerance_pct` DECIMAL(18,2) COMMENT 'The allowable overspend tolerance percentage above the approved budget before a hard block is triggered in SAP S/4HANA availability control (e.g., 5.00 means 5% overspend is permitted before blocking). Used to configure budget control thresholds.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this budget record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Required for change data capture, incremental ETL processing, and SOX audit trail of budget modifications.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The absolute monetary difference between the approved budget amount and actuals-to-date (approved_amount minus actuals_amount). Positive values indicate underspend; negative values indicate overspend. Used in variance analysis reporting.',
    `variance_pct` DECIMAL(18,2) COMMENT 'The percentage difference between approved budget and actuals-to-date expressed as a ratio (variance_amount / approved_amount * 100). Enables proportional comparison across cost centers and business units of different sizes.',
    `version` STRING COMMENT 'Indicates the iteration or revision state of the budget plan. Original is the first approved plan; revised reflects approved amendments; forecast is the latest rolling estimate; final is the locked year-end version; supplemental covers additional approved allocations.. Valid values are `original|revised|forecast|final|supplemental`',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Annual and periodic budget plans with granular line-item allocations by cost center, profit center, GL account, and fiscal period. Tracks approved budget amounts at both summary and line-item levels, budget versions (original, revised, forecast), monthly/quarterly allocations, actuals-to-date, encumbrances, commitments, and remaining budget. Supports variance analysis (price, volume, mix), rolling forecast updates, and drill-down from summary to individual account-level allocations. Enables financial planning, headcount budgeting, and performance management across all business units.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique surrogate identifier for each granular budget line item record within the enterprise financial planning system. Primary key for the budget_line data product.',
    `agent_id` BIGINT COMMENT 'Reference to the employee or manager who owns and is accountable for this budget line. Used for budget responsibility assignment, approval routing, and variance accountability reporting.',
    `approved_by_agent_id` BIGINT COMMENT 'Reference to the employee or manager who formally approved this budget line through the budget workflow. Required for SOX segregation of duties and audit trail documentation.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Budget line items belong to a budget; adding FK enables proper aggregation and removes need for separate budget_line_number as identifier of parent.',
    `cost_center_id` BIGINT COMMENT 'Reference to the organizational cost center responsible for this budget line. Enables departmental budget tracking, variance analysis, and cost allocation reporting.',
    `experiment_id` BIGINT COMMENT 'Foreign key linking to search.experiment. Business justification: Budget allocation for A/B testing experiments requires finance to track spend per experiment for reporting and cost control.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center associated with this budget line. Enables profitability analysis and P&L reporting at the profit center level within SAP S/4HANA (CO-PCA).',
    `relevance_config_id` BIGINT COMMENT 'Foreign key linking to search.relevance_config. Business justification: Finance budgets for relevance configuration changes need a FK to the specific relevance_config to allocate costs and audit spend.',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual expenditure or revenue recorded against this budget line to date for the fiscal period. Sourced from SAP S/4HANA GL postings. Used in actuals-to-budget variance analysis and financial reporting.',
    `allocation_method` STRING COMMENT 'The methodology used to allocate the budget amount to this line item: direct assignment, proportional distribution, top-down allocation, bottom-up build, or zero-based budgeting. Supports budget process transparency and audit.. Valid values are `direct|proportional|top_down|bottom_up|zero_based`',
    `approved_date` DATE COMMENT 'The date on which this budget line was formally approved through the budget workflow. Required for SOX audit trail and financial controls documentation.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The approved budget allocation amount for this line item in the specified currency and fiscal period. Represents the planned financial commitment as approved through the budget workflow. Core field for variance analysis.',
    `budget_category` STRING COMMENT 'High-level classification of the budget line by expenditure category: Capital Expenditure (CapEx), Operating Expenditure (OpEx), headcount, marketing, technology, or logistics. Drives financial reporting segmentation and cost type analysis. [ENUM-REF-CANDIDATE: capex|opex|headcount|marketing|technology|logistics|other — promote to reference product]. Valid values are `capex|opex|headcount|marketing|technology|logistics`',
    `budget_line_description` STRING COMMENT 'Free-text description of the budget line item explaining the business purpose, initiative, or expenditure being budgeted. Provides context for financial reviewers and auditors.',
    `budget_line_number` STRING COMMENT 'Externally-known, human-readable business identifier for the budget line item as assigned by the Enterprise Resource Planning (ERP) system (SAP S/4HANA). Used in financial reports, audit trails, and cross-system reconciliation.. Valid values are `^BL-[0-9]{4}-[0-9]{6}$`',
    `budget_line_status` STRING COMMENT 'Current lifecycle status of the budget line record. Tracks the approval workflow from initial draft through submission, approval, rejection, closure, or cancellation. Supports SOX audit trail requirements. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|closed|cancelled — promote to reference product]. Valid values are `draft|submitted|approved|rejected|closed|cancelled`',
    `budget_type` STRING COMMENT 'Classifies the budget line as an expense budget, revenue budget, headcount budget, or investment budget. Determines how the line is treated in financial consolidation and P&L reporting.. Valid values are `expense|revenue|headcount|investment`',
    `budget_version` STRING COMMENT 'Identifies the version of the budget line: original approved budget, revised budget after amendments, rolling forecast, or supplemental allocation. Enables comparison across budget iterations and supports rolling forecast adjustments.. Valid values are `original|revised|forecast|supplemental`',
    `business_area` STRING COMMENT 'SAP S/4HANA business area code representing a distinct operational segment (e.g., Marketplace, Fulfillment, Advertising) for cross-company-code financial reporting and segment analysis.',
    `company_code` STRING COMMENT 'SAP S/4HANA company code representing the legal entity or subsidiary to which this budget line belongs. Supports multi-entity financial consolidation and intercompany reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area` STRING COMMENT 'SAP S/4HANA controlling area code that groups company codes for management accounting and cost controlling purposes. Defines the organizational scope for internal cost reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget line record was first created in the system. Provides the audit trail creation marker required for SOX financial controls and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this budget line (e.g., USD, EUR, GBP). Supports multi-currency financial consolidation and FX reporting.. Valid values are `^[A-Z]{3}$`',
    `encumbrance_amount` DECIMAL(18,2) COMMENT 'The amount of the budget that has been committed or reserved through purchase orders (POs) or other obligations but not yet invoiced or paid. Reduces available budget and prevents over-commitment. Key for funds management in SAP S/4HANA.',
    `fiscal_period` STRING COMMENT 'The fiscal period number (1–12 for monthly, 1–4 for quarterly) within the fiscal year to which this budget line applies. Supports monthly and quarterly budget drill-down and rolling forecast adjustments.',
    `fiscal_year` STRING COMMENT 'The fiscal year (e.g., 2024) to which this budget line belongs. Used for annual budget planning cycles, year-over-year comparisons, and SOX financial period controls.',
    `forecast_amount` DECIMAL(18,2) COMMENT 'The latest rolling forecast amount for this budget line, reflecting updated projections based on actuals-to-date and anticipated future spend. Supports rolling forecast adjustments and financial planning cycles.',
    `functional_area` STRING COMMENT 'SAP S/4HANA functional area classification (e.g., Sales, Marketing, Operations, Finance, Technology) used for segment reporting and cost-of-sales accounting. Supports P&L reporting by business function.',
    `fund_code` STRING COMMENT 'The fund identifier from SAP S/4HANA Funds Management (FM) that this budget line is allocated to. Used for ring-fenced budget tracking, grant management, and restricted fund reporting.',
    `internal_order_number` BIGINT COMMENT 'Reference to the SAP S/4HANA internal order used for collecting costs for a specific purpose (e.g., a marketing campaign, a technology initiative). Enables granular cost tracking below cost center level.',
    `is_carry_forward` BOOLEAN COMMENT 'Indicates whether unspent budget from a prior period has been carried forward into this budget line. True means this line includes a carry-forward balance from the previous fiscal period or year.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether this budget line has been locked to prevent further modifications after period close or final approval. A value of True means the line is frozen and no amendments are permitted without an unlock workflow.',
    `justification_notes` STRING COMMENT 'Narrative justification provided by the budget owner explaining the rationale for the budget request, including business case, expected ROI, or regulatory requirement. Supports budget review and SOX audit documentation.',
    `last_revised_date` DATE COMMENT 'The most recent date on which the budget line amount or attributes were revised or amended. Tracks the history of budget adjustments for audit and variance analysis purposes.',
    `period_end_date` DATE COMMENT 'The calendar end date of the fiscal period covered by this budget line (e.g., 2024-01-31 for January). Defines the effective end of the budget allocation window.',
    `period_start_date` DATE COMMENT 'The calendar start date of the fiscal period covered by this budget line (e.g., 2024-01-01 for January). Defines the effective start of the budget allocation window.',
    `period_type` STRING COMMENT 'Indicates whether this budget line represents a monthly, quarterly, or annual budget allocation. Determines the granularity of budget tracking and variance reporting.. Valid values are `monthly|quarterly|annual`',
    `prior_year_actual_amount` DECIMAL(18,2) COMMENT 'The actual expenditure recorded for the equivalent GL account and cost center in the prior fiscal year. Used as a baseline for year-over-year budget variance analysis and trend reporting.',
    `remaining_amount` DECIMAL(18,2) COMMENT 'The unspent and uncommitted budget remaining for this line item, calculated as budget_amount minus actual_amount minus encumbrance_amount. Represents available spending authority for the period. Critical for budget control and over-spend prevention.',
    `source_system` STRING COMMENT 'Identifies the originating system from which this budget line record was sourced: SAP S/4HANA ERP, manual entry, a dedicated budget planning tool, or Excel upload. Supports data lineage and reconciliation.. Valid values are `SAP_S4HANA|MANUAL|BUDGET_TOOL|EXCEL_UPLOAD`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this budget line record. Tracks the last change event for audit trail, SOX compliance, and incremental data pipeline processing.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The monetary difference between the approved budget amount and the actual amount for this line item (budget_amount minus actual_amount). A positive value indicates underspend; negative indicates overspend. Stored as a pre-computed field from SAP S/4HANA for reporting performance.',
    `variance_pct` DECIMAL(18,2) COMMENT 'The percentage variance between the approved budget amount and the actual amount, expressed as a decimal (e.g., 0.1250 = 12.50%). Sourced from SAP S/4HANA variance reporting. Enables proportional comparison across budget lines of different sizes.',
    `wbs_element` STRING COMMENT 'Work Breakdown Structure (WBS) element code from SAP S/4HANA Project System (PS) linking this budget line to a specific project or capital investment. Enables project-level budget tracking and CapEx management.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Granular line-item breakdown of budget allocations by GL account, cost center, and fiscal period. Captures monthly/quarterly budget amounts, actuals-to-date, encumbrances, and remaining budget. Enables drill-down variance analysis and supports rolling forecast adjustments at the account level.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` (
    `revenue_recognition_id` BIGINT COMMENT 'Unique surrogate identifier for each revenue recognition event or schedule record in the enterprise financial system. Primary key for this table.',
    `header_id` BIGINT COMMENT 'Reference to the originating order that generated this revenue recognition event. Links to the Order Management System (OMS) order record.',
    `seller_profile_id` BIGINT COMMENT 'Reference to the marketplace seller whose transaction generated this revenue recognition event. Relevant for marketplace commission recognition. Sourced from the Seller Management Portal.',
    `vendor_contract_id` BIGINT COMMENT 'Reference to the underlying customer contract or agreement governing this revenue recognition event, as maintained in SAP S/4HANA contract management.',
    `allocated_transaction_price` DECIMAL(18,2) COMMENT 'The portion of the total contract transaction price allocated to this specific performance obligation, based on relative standalone selling prices per ASC 606 Step 4. May differ from transaction_price when a contract has multiple performance obligations.',
    `approved_by` STRING COMMENT 'The employee ID or username of the finance controller or manager who approved this revenue recognition event. Required for SOX compliance and audit trail. Populated for manual overrides and high-value recognition events.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this revenue recognition event was approved by the authorized finance controller. Part of the SOX-compliant audit trail for financial controls.',
    `commission_amount` DECIMAL(18,2) COMMENT 'The absolute commission amount earned from the marketplace seller for this transaction. Represents the net revenue recognized by the platform as agent/principal in marketplace transactions per ASC 606 principal vs. agent guidance.',
    `commission_rate` DECIMAL(18,2) COMMENT 'The percentage commission rate charged to the marketplace seller on this transaction. Used to calculate marketplace commission revenue recognized. Sourced from the Seller Management Portal commission schedule.',
    `constraint_applied` BOOLEAN COMMENT 'Indicates whether the variable consideration constraint was applied to limit the recognized amount, preventing a significant revenue reversal per ASC 606. True = constraint applied; False = full variable consideration included.',
    `contract_modification_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition event was triggered or affected by a contract modification (e.g., order amendment, subscription upgrade/downgrade, price renegotiation). True = contract modification involved; False = original contract terms.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this revenue recognition record was first created in the system. Audit trail field for SOX compliance and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this recognition record (e.g., USD, EUR, GBP). Supports multi-currency operations across international marketplace transactions.. Valid values are `^[A-Z]{3}$`',
    `deferred_amount` DECIMAL(18,2) COMMENT 'The portion of the transaction price that has been received or billed but not yet recognized as revenue, deferred to future accounting periods. Represents the deferred revenue liability balance for this obligation.',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the revenue recognition trigger event occurred (e.g., delivery confirmed timestamp, subscription period end timestamp). This is the principal real-world business event time, distinct from record audit timestamps.',
    `fiscal_period` STRING COMMENT 'The fiscal accounting period (year-quarter or year-month) to which this recognized revenue is attributed in the General Ledger (GL). Format: YYYY-QN (quarterly) or YYYY-MM (monthly). Used for period-close reporting and SOX financial controls.. Valid values are `^[0-9]{4}-(Q[1-4]|[0-9]{2})$`',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the entitys functional currency used for financial consolidation in SAP S/4HANA. Amounts may be converted from transaction currency to functional currency for GL posting.. Valid values are `^[A-Z]{3}$`',
    `fx_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert transaction currency amounts to the functional currency at the time of recognition. Sourced from SAP S/4HANA currency tables. Relevant for cross-border marketplace transactions.',
    `gmv_amount` DECIMAL(18,2) COMMENT 'The total Gross Merchandise Value (GMV) of the transaction before any deductions. Starting point of the GMV-to-net-revenue waterfall. Represents the full face value of goods/services transacted on the platform.',
    `journal_entry_reference` STRING COMMENT 'The SAP S/4HANA General Ledger journal entry document number associated with the posting of this recognized revenue. Provides the audit trail link between the revenue recognition record and the financial ledger entry for SOX compliance.. Valid values are `^JE-[0-9]{12}$`',
    `net_recognized_amount` DECIMAL(18,2) COMMENT 'The net revenue amount recognized after applying promotional discounts, refund adjustments, and other variable consideration adjustments. Equals recognized_amount minus promotional_discount_amount minus refund_adjustment_amount. Bottom line of the GMV-to-net-revenue waterfall.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the finance team regarding this revenue recognition event. Used to document manual overrides, contract modification rationale, or audit observations.',
    `percentage_complete` DECIMAL(18,2) COMMENT 'The estimated percentage of the performance obligation that has been satisfied as of the recognition event date. Used for over-time revenue recognition to calculate the recognized amount. Range: 0.00 to 100.00.',
    `performance_obligation_description` STRING COMMENT 'Human-readable description of the distinct performance obligation being satisfied in this recognition event (e.g., Delivery of physical goods, Monthly SaaS subscription access, Marketplace listing service).',
    `principal_agent_indicator` STRING COMMENT 'Indicates whether the entity is acting as principal (recognizes gross revenue) or agent (recognizes net commission) for this transaction. Critical for marketplace revenue recognition and GMV-to-net-revenue waterfall. Determined per ASC 606 B34-B38.. Valid values are `principal|agent`',
    `promotional_discount_amount` DECIMAL(18,2) COMMENT 'The value of promotional discounts, coupons, or price reductions applied to this transaction that reduce the recognized revenue amount. Part of the GMV-to-net-revenue waterfall adjustment. Sourced from Pricing and Promotions Management.',
    `recognition_event_number` STRING COMMENT 'Externally referenceable business identifier for this revenue recognition event, used in financial reporting, audit correspondence, and reconciliation with SAP S/4HANA journal entries.. Valid values are `^RR-[0-9]{10}$`',
    `recognition_method` STRING COMMENT 'The accounting method used to measure progress toward complete satisfaction of the performance obligation for over-time recognition. Output methods measure results achieved; input methods measure effort expended. [ENUM-REF-CANDIDATE: output_method|input_method|straight_line|usage_based|milestone_based|residual_approach — promote to reference product]. Valid values are `output_method|input_method|straight_line|usage_based|milestone_based`',
    `recognition_period_end_date` DATE COMMENT 'End date of the accounting period over which revenue is recognized. For point-in-time recognition, this equals the event date. For over-time recognition (e.g., subscription ARR), this is the end of the service period.',
    `recognition_period_start_date` DATE COMMENT 'Start date of the accounting period over which revenue is recognized. For point-in-time recognition, this equals the event date. For over-time recognition (e.g., subscription MRR), this is the start of the service period.',
    `recognition_status` STRING COMMENT 'Current lifecycle state of the revenue recognition event. pending = awaiting trigger; recognized = revenue fully recognized; deferred = revenue deferred to future period; partially_recognized = portion recognized; reversed = recognition reversed; cancelled = event voided.. Valid values are `pending|recognized|deferred|partially_recognized|reversed|cancelled`',
    `recognition_trigger` STRING COMMENT 'The business event that triggered this revenue recognition. Examples: delivery confirmation from TMS/WMS, subscription billing period elapsed, customer acceptance, refund/return window expiry, or manual finance override. [ENUM-REF-CANDIDATE: delivery_confirmed|subscription_period_elapsed|milestone_achieved|customer_acceptance|refund_period_expired|manual_override|partial_shipment|contract_modification — promote to reference product]. Valid values are `delivery_confirmed|subscription_period_elapsed|milestone_achieved|customer_acceptance|refund_period_expired|manual_override`',
    `recognition_type` STRING COMMENT 'Indicates whether revenue is recognized at a single point in time (e.g., product delivery) or over time (e.g., subscription MRR/ARR, service contracts), per ASC 606 / IFRS 15 criteria.. Valid values are `point_in_time|over_time`',
    `recognized_amount` DECIMAL(18,2) COMMENT 'The gross revenue amount recognized in this event or for this period. For partial recognition, this is the portion recognized in the current period. Core field in the GMV-to-net-revenue waterfall.',
    `refund_adjustment_amount` DECIMAL(18,2) COMMENT 'The amount of revenue reversed or adjusted due to customer returns, refunds, or Return Merchandise Authorization (RMA) events. Reduces recognized revenue in the GMV-to-net-revenue waterfall. Negative values indicate revenue reduction.',
    `revenue_category` STRING COMMENT 'Business classification of the revenue stream being recognized. Covers GMV-to-net-revenue waterfall components: direct product sales, marketplace seller commissions, subscription MRR/ARR, advertising revenue, fulfillment fees, and other. [ENUM-REF-CANDIDATE: product_sale|marketplace_commission|subscription|advertising|fulfillment_fee|data_licensing|other — promote to reference product]. Valid values are `product_sale|marketplace_commission|subscription|advertising|fulfillment_fee|other`',
    `source_system` STRING COMMENT 'The operational system of record that originated this revenue recognition event. Supports data lineage and reconciliation across OMS, SAP S/4HANA, Payment Gateway, Seller Portal, and Subscription Platform.. Valid values are `OMS|SAP_S4HANA|PAYMENT_GATEWAY|SELLER_PORTAL|SUBSCRIPTION_PLATFORM`',
    `source_transaction_reference` STRING COMMENT 'The native transaction identifier from the originating source system (e.g., OMS order number, payment gateway transaction ID, SAP document number). Enables end-to-end reconciliation and audit trail across systems.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition record is subject to SOX internal control review and audit. True = SOX-controlled record requiring documented approval and audit trail; False = non-SOX-controlled record.',
    `standalone_selling_price` DECIMAL(18,2) COMMENT 'The price at which the entity would sell this performance obligation separately to a customer. Used as the basis for allocating the transaction price across multiple performance obligations per ASC 606 Step 4.',
    `subscription_mrr_amount` DECIMAL(18,2) COMMENT 'The Monthly Recurring Revenue (MRR) amount recognized for subscription-based services in this period. Applicable when revenue_category = subscription. Used for MRR/ARR tracking and SaaS revenue reporting.',
    `transaction_price` DECIMAL(18,2) COMMENT 'The total transaction price allocated to this performance obligation per ASC 606 Step 4. Represents the amount of consideration the business expects to receive in exchange for satisfying this performance obligation, before adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this revenue recognition record was last modified. Tracks changes to recognition status, amounts, or approvals for SOX audit trail and data lineage.',
    `variable_consideration_estimate` DECIMAL(18,2) COMMENT 'The estimated amount of variable consideration (e.g., volume discounts, rebates, returns allowance, performance bonuses) included in the transaction price per ASC 606 Step 3. Subject to the constraint that a significant revenue reversal is not probable.',
    CONSTRAINT pk_revenue_recognition PRIMARY KEY(`revenue_recognition_id`)
) COMMENT 'Tracks revenue recognition events and schedules per ASC 606 / IFRS 15 standards. Captures performance obligation identification, transaction price allocation, recognition trigger events, recognized amounts, and deferred revenue balances. Covers GMV-to-net-revenue waterfall, marketplace commission recognition, subscription MRR/ARR recognition, and promotional discount adjustments.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` (
    `gmv_reconciliation_id` BIGINT COMMENT 'Primary key for gmv_reconciliation',
    `gmv_daily_snapshot_id` BIGINT COMMENT 'Unique surrogate primary key for each GMV-to-net-revenue reconciliation record in the finance domain. Serves as the system-of-record identifier for financial close, SOX audit trails, and investor reporting.',
    `cost_center_id` BIGINT COMMENT 'Reference to the SAP S/4HANA cost center responsible for this reconciliation record, enabling P&L attribution, budget tracking, and internal financial reporting.',
    `indexed_document_id` BIGINT COMMENT 'Foreign key linking to search.indexed_document. Business justification: GMV reconciliation per product listing requires linking each reconciliation record to the indexed_document representing that SKU.',
    `fiscal_period_id` BIGINT COMMENT 'Reference to the fiscal period (month/quarter/year) to which this reconciliation record belongs. Drives financial close scheduling, MRR/ARR roll-ups, and period-over-period variance reporting.',
    `seller_profile_id` BIGINT COMMENT 'Reference to the marketplace seller whose transactions are included in this reconciliation record. Enables seller-level GMV attribution, commission calculation, and settlement reporting via the Seller Management Portal.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the finance controller who approved this reconciliation record during the financial close workflow. Distinct from SOX attestation — this is the operational approval step.',
    `attestation_timestamp` TIMESTAMP COMMENT 'Date and time when SOX attestation was formally recorded for this reconciliation record. Provides the precise audit trail timestamp required for regulatory compliance and external auditor review.',
    `attested_by` STRING COMMENT 'Name or employee identifier of the finance controller or CFO who provided SOX attestation for this reconciliation record. Captured as part of the audit trail for regulatory compliance.',
    `cancelled_order_amount` DECIMAL(18,2) COMMENT 'Total value of orders cancelled within the reconciliation period, deducted from gross GMV to arrive at net GMV. Sourced from the Order Management System order lifecycle tracking.',
    `channel` STRING COMMENT 'The sales channel through which the GMV was generated: web (desktop/browser), mobile_app, bopis (Buy Online Pick Up In Store), api (API-driven B2B orders), edl (Electronic Data Interchange). Supports channel-level revenue attribution and reporting.. Valid values are `web|mobile_app|bopis|api|edl`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this GMV reconciliation record was first created in the data platform. Provides the audit trail creation marker required for SOX compliance and data lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all monetary amounts on this reconciliation record are denominated (e.g., USD, EUR, GBP). Supports multi-currency operations and FX reporting.. Valid values are `^[A-Z]{3}$`',
    `fx_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert transaction amounts from the transaction currency to the reporting currency (USD) for this reconciliation period. Sourced from SAP S/4HANA FI currency translation tables.',
    `gl_account_code` STRING COMMENT 'SAP S/4HANA General Ledger account code to which the recognized net revenue is posted. Enables drill-through from financial statements to reconciliation detail and supports SOX audit trail requirements.. Valid values are `^[0-9]{6,10}$`',
    `gl_posting_date` DATE COMMENT 'The date on which the reconciliation amounts were posted to the SAP S/4HANA General Ledger. Determines the accounting period for revenue recognition and is critical for period-end cut-off compliance.',
    `gross_gmv_amount` DECIMAL(18,2) COMMENT 'Total face value of all orders placed within the reconciliation period before any deductions. Represents the top-line GMV figure used in investor reporting, KPI dashboards, and GMV-to-revenue bridge calculations. Sourced from the Order Management System.',
    `is_sox_attested` BOOLEAN COMMENT 'Indicates whether this reconciliation record has received formal SOX-compliant management attestation (True) or is pending attestation (False). Required for financial close gate and external audit evidence packages.',
    `journal_entry_number` STRING COMMENT 'SAP S/4HANA accounting document number for the journal entry posting this reconciliation to the General Ledger. Provides the audit trail link between the reconciliation record and the posted GL entry for SOX compliance.',
    `logistics_cost_amount` DECIMAL(18,2) COMMENT 'Total last-mile delivery and fulfillment costs incurred within the reconciliation period, including 3PL charges, carrier fees, and FBA-style fulfillment costs. Sourced from the Transportation Management System and SAP S/4HANA AP.',
    `marketplace_segment` STRING COMMENT 'Business model segment classification for this reconciliation record: b2c (Business to Consumer), b2b (Business to Business), c2c (Consumer to Consumer), or dtc (Direct to Consumer). Enables segment-level revenue reporting and investor disclosures.. Valid values are `b2c|b2b|c2c|dtc`',
    `materiality_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary materiality threshold applied to this reconciliation record for SOX purposes. Variances exceeding this amount require escalation, formal explanation, and controller sign-off before the period can be closed.',
    `net_gmv_amount` DECIMAL(18,2) COMMENT 'Gross GMV less cancelled orders and returns/refunds. Represents the value of successfully completed transactions before revenue deductions. Key intermediate figure in the GMV-to-revenue bridge used in investor reporting.',
    `notes` STRING COMMENT 'Free-text field for finance team annotations, adjustment explanations, or audit comments associated with this reconciliation record. Supports the financial close review process and provides context for auditors.',
    `order_count` STRING COMMENT 'Total number of orders included in the gross GMV figure for this reconciliation record. Supports Average Order Value (AOV) calculation and volume-based variance analysis during financial close.',
    `payment_processing_fee_amount` DECIMAL(18,2) COMMENT 'Total fees charged by payment processors and card networks (e.g., interchange, gateway fees) within the reconciliation period. Deducted from gross revenue to arrive at net revenue. Sourced from the Payment Gateway and Processing Platform.',
    `period_end_date` DATE COMMENT 'The last calendar date of the reporting period covered by this reconciliation record. Defines the GMV measurement window close boundary for financial reporting and audit.',
    `period_start_date` DATE COMMENT 'The first calendar date of the reporting period covered by this reconciliation record. Used to define the GMV measurement window for financial close and revenue recognition.',
    `platform_fee_amount` DECIMAL(18,2) COMMENT 'Total fixed and variable platform service fees charged to sellers or buyers within the reconciliation period (e.g., listing fees, fulfillment fees, subscription fees). Distinct from commission-based revenue. Sourced from SAP S/4HANA AR.',
    `promotional_discount_amount` DECIMAL(18,2) COMMENT 'Total value of promotional discounts, coupons, and price reductions applied to orders within the reconciliation period. Deducted from gross GMV in the revenue bridge. Sourced from the Marketing Automation Platform and Order Management System.',
    `recognized_net_revenue_amount` DECIMAL(18,2) COMMENT 'Final net revenue recognized for the period after all deductions: net GMV minus promotional discounts, minus payment processing fees, minus logistics costs, plus platform fees and seller commissions earned. Posted to the SAP S/4HANA General Ledger as the period revenue figure for SOX-compliant financial reporting.',
    `recognized_net_revenue_reporting_ccy` DECIMAL(18,2) COMMENT 'Recognized net revenue amount translated into the reporting currency using the period fx_rate. Used for consolidated financial statements, investor reporting, and MRR/ARR calculations in the reporting currency.',
    `reconciliation_reference_number` STRING COMMENT 'Externally-known, human-readable business identifier for this reconciliation record, used in financial close packages, investor reports, and SOX attestation documentation. Format: REC-YYYY-MM-XXXXXXXX.. Valid values are `^REC-[0-9]{4}-[0-9]{2}-[0-9]{8}$`',
    `reconciliation_status` STRING COMMENT 'Current lifecycle state of the GMV reconciliation record within the financial close workflow. draft = initial capture; in_review = under finance team review; approved = controller sign-off obtained; posted = posted to general ledger in SAP S/4HANA; disputed = variance flagged for investigation; closed = period locked.. Valid values are `draft|in_review|approved|posted|disputed|closed`',
    `reconciliation_type` STRING COMMENT 'Classification of the reconciliation cadence: monthly for standard MRR close, quarterly for investor reporting, annual for ARR and audited financials, ad_hoc for out-of-cycle adjustments or restatements.. Valid values are `monthly|quarterly|annual|ad_hoc`',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 code for the functional/reporting currency to which all amounts are translated for consolidated financial reporting (e.g., USD). Distinct from currency_code which reflects the transaction currency.. Valid values are `^[A-Z]{3}$`',
    `return_order_count` STRING COMMENT 'Total number of Return Merchandise Authorization (RMA) orders processed within the reconciliation period. Used to calculate return rate and validate the returns_refunds_amount deduction.',
    `returns_refunds_amount` DECIMAL(18,2) COMMENT 'Total monetary value of approved returns and refunds processed via the Return Merchandise Authorization (RMA) workflow within the period. Deducted from gross GMV in the revenue bridge. Sourced from the Order Management System and Payment Gateway.',
    `revenue_recognition_method` STRING COMMENT 'The GAAP ASC 606 revenue recognition method applied to this reconciliation record: point_in_time for standard product sales, over_time for subscription or service revenue, milestone_based for project-based arrangements.. Valid values are `point_in_time|over_time|milestone_based`',
    `seller_commission_amount` DECIMAL(18,2) COMMENT 'Total marketplace commission fees earned from sellers on transactions within the reconciliation period. Represents platform revenue earned on GMV and is a key component of the GMV-to-net-revenue bridge. Sourced from the Seller Management Portal.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this reconciliation record was sourced or initiated: SAP_S4HANA (ERP financial consolidation), OMS (Order Management System), PAYMENT_GATEWAY (Payment Gateway and Processing Platform), SELLER_PORTAL (Seller Management Portal), MANUAL (manual finance entry). Supports data lineage and ETL audit trails.. Valid values are `SAP_S4HANA|OMS|PAYMENT_GATEWAY|SELLER_PORTAL|MANUAL`',
    `tax_collected_amount` DECIMAL(18,2) COMMENT 'Total sales tax, VAT, or GST collected from buyers on orders within the reconciliation period. Excluded from net revenue recognition as a pass-through liability. Sourced from the Payment Gateway and SAP S/4HANA Tax module.',
    `tax_remitted_amount` DECIMAL(18,2) COMMENT 'Total tax amounts remitted to tax authorities within the reconciliation period. Reconciled against tax_collected_amount to identify timing differences and tax liability balances in SAP S/4HANA AP.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to this GMV reconciliation record. Tracks changes during the financial close review cycle and supports SOX change audit trail requirements.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary difference between the expected net revenue (as per budget or prior period) and the actual recognized net revenue for this reconciliation record. A non-zero variance triggers investigation and may require SOX-compliant explanatory notes.',
    `variance_explanation` STRING COMMENT 'Free-text narrative explaining the root cause of any material reconciliation variance. Required for SOX attestation when variance_amount exceeds the materiality threshold. Captured by the finance controller during the review workflow.',
    `voucher_discount_amount` DECIMAL(18,2) COMMENT 'Total value of platform-funded vouchers and coupon redemptions applied within the reconciliation period. Tracked separately from seller-funded promotional discounts for accurate P&L attribution and marketing spend reporting.',
    CONSTRAINT pk_gmv_reconciliation PRIMARY KEY(`gmv_reconciliation_id`)
) COMMENT 'Reconciliation records mapping Gross Merchandise Value (GMV) to net revenue. Tracks gross order value, seller commissions, platform fees, promotional discounts, returns/refunds deductions, tax adjustments, and final recognized net revenue per period. Supports financial close, investor reporting, and SOX-compliant revenue attestation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` (
    `seller_disbursement_id` BIGINT COMMENT 'Primary key for seller_disbursement',
    `seller_performance_snapshot_id` BIGINT COMMENT 'Unique system-generated primary key identifying each seller disbursement record in the marketplace accounts payable ledger.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Seller payouts must comply with tax‑withholding and payment‑security regulations, captured as a compliance obligation.',
    `payment_transaction_id` BIGINT COMMENT 'Reference to the settlement execution record in the Payment Gateway and Processing Platform that executed this disbursement transaction.',
    `seller_profile_id` BIGINT COMMENT 'Reference to the marketplace seller or third-party merchant receiving this disbursement. Links to the seller master record in the Seller Management Portal.',
    `actual_disbursement_date` DATE COMMENT 'The actual calendar date on which the disbursement was successfully transferred to the sellers bank account. May differ from scheduled date due to banking delays, holidays, or processing issues. Used for SLA compliance tracking.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Net monetary adjustment applied to the disbursement for corrections, promotional credits, dispute resolutions, or other one-time modifications. Can be positive (credit to seller) or negative (debit from seller).',
    `approval_status` STRING COMMENT 'Approval workflow status for this disbursement. SOX-compliant disbursements above defined thresholds require explicit approval before processing. Tracks whether the disbursement has been reviewed and authorized.. Valid values are `pending_approval|approved|rejected|auto_approved`',
    `approved_by` STRING COMMENT 'Employee ID or system username of the finance team member who approved this disbursement. Required for SOX-compliant dual-control authorization and audit trail. Null for auto-approved disbursements below threshold.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the disbursement was formally approved by an authorized finance team member. Part of the SOX-compliant audit trail for financial controls.',
    `bank_account_last4` STRING COMMENT 'Last four digits of the sellers bank account number to which the disbursement was sent. Stored as a masked reference for reconciliation and audit purposes without exposing full account details per PCI DSS requirements.. Valid values are `^[0-9]{4}$`',
    `bank_routing_code` STRING COMMENT 'Bank routing number, SWIFT/BIC code, or IBAN prefix identifying the destination financial institution for the disbursement. Used for payment routing and reconciliation with the payment gateway.',
    `commission_deduction_amount` DECIMAL(18,2) COMMENT 'Total marketplace commission fees deducted from the gross disbursement amount. Represents the platforms revenue share withheld from the seller payout per the seller agreement.',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA cost center code associated with this disbursement for internal financial reporting, budget tracking, and departmental cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp when this disbursement record was first created in the system. Used for data lineage, SOX audit trails, and reconciliation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this disbursement record (e.g., USD, EUR, GBP). Supports multi-currency marketplace operations and cross-border seller payouts.. Valid values are `^[A-Z]{3}$`',
    `disbursement_reference` STRING COMMENT 'Externally-visible alphanumeric reference code assigned to this disbursement, used in seller-facing remittance advice and reconciliation communications.. Valid values are `^DISB-[A-Z0-9]{8,20}$`',
    `disbursement_status` STRING COMMENT 'Current lifecycle state of the disbursement. Tracks progression from pending approval through processing to completed settlement or failure/reversal. [ENUM-REF-CANDIDATE: pending|processing|completed|failed|reversed|on_hold — promote to reference product if additional states are needed]. Valid values are `pending|processing|completed|failed|reversed|on_hold`',
    `disbursement_type` STRING COMMENT 'Classification of the disbursement by payout mechanism or trigger. Standard disbursements follow the regular settlement cycle; accelerated are expedited payouts; manual are operator-initiated; adjustment corrects prior disbursements; reversal claws back funds; advance is a pre-settlement payout. [ENUM-REF-CANDIDATE: standard|accelerated|manual|adjustment|reversal|advance — promote to reference product if additional types are needed]. Valid values are `standard|accelerated|manual|adjustment|reversal|advance`',
    `failure_reason` STRING COMMENT 'Descriptive reason code or message explaining why a disbursement failed or was placed on hold (e.g., invalid bank account, insufficient funds, compliance hold, fraud flag). Null for successful disbursements.',
    `fee_deduction_amount` DECIMAL(18,2) COMMENT 'Total platform service fees deducted from the gross disbursement, including fulfillment fees, storage fees, listing fees, and other operational charges billed to the seller.',
    `fx_conversion_date` DATE COMMENT 'The date on which the foreign exchange rate was fixed for currency conversion in this disbursement. Used for FX gain/loss accounting and cross-border financial reporting.',
    `fx_conversion_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert the disbursement amount from the marketplace transaction currency to the sellers payout currency. Applicable for cross-border sellers operating in multiple currencies. Null if no conversion was required.',
    `gl_account_code` STRING COMMENT 'SAP S/4HANA General Ledger account code to which this disbursement is posted. Enables financial consolidation, P&L reporting, and SOX-compliant audit trails within the enterprise ERP.',
    `gmv_amount` DECIMAL(18,2) COMMENT 'Total Gross Merchandise Value (GMV) of all orders settled in this disbursement period, representing the full customer-facing transaction value before platform deductions. Used for GMV-to-revenue reconciliation and marketplace financial reporting.',
    `gross_disbursement_amount` DECIMAL(18,2) COMMENT 'Total gross amount owed to the seller before any deductions, representing the sum of all settled order revenues attributed to the seller within the settlement period. Core component of the monetary triplet for AP reconciliation and GMV-to-revenue reporting.',
    `initiated_timestamp` TIMESTAMP COMMENT 'The real-world business event timestamp when the disbursement was initiated and entered the payment queue. Distinct from system audit timestamps. Used for SLA measurement and settlement cycle reporting.',
    `marketplace_region` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the marketplace region in which the sellers sales were generated. Drives tax withholding rules, currency conversion, and regulatory reporting requirements.. Valid values are `^[A-Z]{3}$`',
    `net_disbursement_amount` DECIMAL(18,2) COMMENT 'Final net amount actually disbursed to the seller after all deductions (commission, fees, tax withholding, refunds, adjustments). This is the actual payout amount transferred to the sellers bank account. Core net-total component of the monetary triplet.',
    `net_payout_amount` DECIMAL(18,2) COMMENT 'Net disbursement amount expressed in the sellers payout currency after FX conversion. Equals net_disbursement_amount multiplied by fx_conversion_rate. Null if no currency conversion was applied.',
    `notes` STRING COMMENT 'Free-text field for finance team annotations, special handling instructions, or contextual information about this disbursement. Used for manual disbursements, adjustments, and exception handling documentation.',
    `on_hold_reason` STRING COMMENT 'Reason code explaining why a disbursement has been placed on hold (e.g., seller account under review, tax documentation pending, dispute investigation, compliance verification). Null when disbursement is not on hold.',
    `order_count` STRING COMMENT 'Number of individual customer orders included in this disbursements settlement period. Used for reconciliation, seller performance reporting, and GMV-to-disbursement ratio analysis.',
    `payment_method` STRING COMMENT 'The financial instrument or channel used to transfer funds to the seller. Determines the settlement rail and associated processing timelines. [ENUM-REF-CANDIDATE: bank_transfer|payoneer|paypal|check|wire_transfer|virtual_account — promote to reference product if additional methods are needed]. Valid values are `bank_transfer|payoneer|paypal|check|wire_transfer|virtual_account`',
    `payout_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code of the currency in which the seller actually receives the disbursement. May differ from currency_code when FX conversion is applied for cross-border sellers.. Valid values are `^[A-Z]{3}$`',
    `refund_deduction_amount` DECIMAL(18,2) COMMENT 'Total amount deducted from the disbursement to recover costs associated with customer refunds and returns (RMA) processed during the settlement period and charged back to the seller.',
    `remittance_advice_sent` BOOLEAN COMMENT 'Indicates whether a remittance advice notification has been sent to the seller detailing the disbursement breakdown (gross amount, deductions, net payout). Supports seller reconciliation and dispute prevention.',
    `remittance_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when the remittance advice notification was dispatched to the seller. Used for seller communication tracking and SLA compliance measurement.',
    `reversal_reference` STRING COMMENT 'Reference to the original disbursement_reference that this record reverses or corrects. Populated only for disbursements of type reversal or adjustment. Enables full audit trail of disbursement corrections.',
    `scheduled_disbursement_date` DATE COMMENT 'The planned calendar date on which the disbursement is scheduled to be transferred to the sellers bank account. Used for cash flow planning and seller expectation management.',
    `seller_entity_type` STRING COMMENT 'Legal entity classification of the seller receiving the disbursement. Determines applicable tax withholding rates, regulatory reporting obligations (e.g., IRS 1099-K thresholds), and KYC/AML compliance requirements.. Valid values are `individual|business|enterprise|non_profit`',
    `settlement_period_end_date` DATE COMMENT 'The end date of the settlement period covered by this disbursement. Defines the closing boundary of the window during which seller sales transactions are aggregated for payout calculation.',
    `settlement_period_start_date` DATE COMMENT 'The start date of the settlement period covered by this disbursement. Defines the beginning of the window during which seller sales transactions are aggregated for payout calculation.',
    `tax_form_type` STRING COMMENT 'Type of tax reporting form associated with this disbursement for regulatory compliance. Determines the applicable tax reporting obligation based on seller entity type and jurisdiction. [ENUM-REF-CANDIDATE: 1099-K|1042-S|W-9|W-8BEN|VAT|GST|none — promote to reference product if additional form types are needed]',
    `tax_withholding_amount` DECIMAL(18,2) COMMENT 'Amount of tax withheld from the seller disbursement in compliance with applicable tax regulations (e.g., VAT, GST, income tax withholding for cross-border sellers). Reported to tax authorities as required.',
    `transaction_reference` STRING COMMENT 'External transaction reference number returned by the bank or payment processor confirming the fund transfer. Used for bank reconciliation, dispute resolution, and audit trail in SAP S/4HANA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp when this disbursement record was last modified. Tracks status changes, corrections, and reversals for SOX compliance and audit trail integrity.',
    CONSTRAINT pk_seller_disbursement PRIMARY KEY(`seller_disbursement_id`)
) COMMENT 'Records of financial disbursements made to marketplace sellers and third-party merchants. Tracks disbursement amounts, settlement periods, commission deductions, fee withholdings, tax withholdings, payment method, and disbursement status. Integrates with the seller domain for payee identity and the payment domain for settlement execution. Supports marketplace AP reconciliation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`tax_record` (
    `tax_record_id` BIGINT COMMENT 'Unique surrogate identifier for each tax record entry in the enterprise financial system. Primary key for the tax_record data product.',
    `header_id` BIGINT COMMENT 'Reference to the e-commerce order associated with this tax record. Enables reconciliation of tax obligations back to the originating Order Management System (OMS) order.',
    `supplier_invoice_id` BIGINT COMMENT 'Reference to the accounts receivable invoice document associated with this tax record. Supports invoice-level tax reconciliation in SAP S/4HANA AR module.',
    `payment_transaction_id` BIGINT COMMENT 'Reference to the originating financial transaction (order, invoice, payment, or settlement) that generated this tax obligation. Links tax record to its source transaction.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Tax filing requires each tax record to be linked to the specific regulation (e.g., VAT) that mandates the filing, essential for compliance reporting.',
    `seller_profile_id` BIGINT COMMENT 'Reference to the marketplace seller responsible for the taxable transaction. Required for marketplace facilitator tax compliance where the platform collects and remits tax on behalf of sellers.',
    `company_code` STRING COMMENT 'SAP S/4HANA company code identifying the legal entity responsible for this tax obligation. Enables multi-entity tax consolidation and statutory reporting across the enterprise group.',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA cost center code to which the tax expense is allocated for internal management accounting and cost reporting. Supports cost center-level tax burden analysis.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the tax jurisdiction country. Used for international tax compliance, GDPR territorial scoping, and cross-border transaction reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax record was first captured in the enterprise data platform. Used for audit trail, SOX compliance, and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction currency in which taxable_amount, tax_amount, and net_amount are denominated (e.g., USD, EUR, GBP). Required for multi-currency tax reconciliation and international financial reporting.. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'The statutory deadline by which the tax must be remitted to the tax authority. Used for cash flow planning, penalty risk monitoring, and compliance SLA tracking.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign currency exchange rate applied to convert transaction currency amounts to local reporting currency at the time of the taxable event. Sourced from SAP S/4HANA exchange rate tables.',
    `exemption_certificate_number` STRING COMMENT 'Reference number of the tax exemption certificate provided by the buyer or seller to justify a zero or reduced tax rate. Required for audit substantiation when is_tax_exempt is True. Confidential business document reference.',
    `filing_date` DATE COMMENT 'The date on which the tax return or remittance was filed with the relevant tax authority. Null if not yet filed. Used to track compliance with filing deadlines and SLA obligations.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the tax record within the filing workflow. Tracks progression from pending obligation through filed, accepted by authority, rejected, amended, or voided. Drives compliance monitoring and SOX audit controls.. Valid values are `pending|filed|accepted|rejected|amended|voided`',
    `fiscal_period` STRING COMMENT 'The fiscal period number within the fiscal year (1–12 for monthly, 1–4 for quarterly) to which this tax record is attributed. Used for period-end close, tax accrual, and financial consolidation in SAP S/4HANA.',
    `fiscal_year` STRING COMMENT 'The fiscal year (e.g., 2024) to which this tax record is attributed for financial reporting and tax filing purposes. Aligns with SAP S/4HANA fiscal year variant configuration.',
    `gl_account_code` STRING COMMENT 'The General Ledger (GL) account code in SAP S/4HANA to which the tax amount is posted (e.g., tax payable account, input VAT recoverable account). Enables financial consolidation and balance sheet reconciliation.',
    `is_marketplace_facilitator` BOOLEAN COMMENT 'Indicates whether the tax was collected and remitted by the e-commerce platform acting as a marketplace facilitator (True) rather than by the individual seller (False). Relevant for US marketplace facilitator tax laws and similar international regulations.',
    `is_tax_exempt` BOOLEAN COMMENT 'Indicates whether the transaction or customer is tax-exempt (True), resulting in a zero tax amount. Requires a valid exemption certificate on file. Used for B2B tax exemption processing and audit compliance.',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the legal entitys local reporting currency (e.g., USD for US entities). Used to denominate tax_amount_local_currency for statutory reporting.. Valid values are `^[A-Z]{3}$`',
    `net_amount` DECIMAL(18,2) COMMENT 'The total net amount inclusive of tax (taxable_amount + tax_amount), expressed in the transaction currency. Represents the gross total component of the MONETARY_TRIPLET. Used for revenue recognition, GMV-to-revenue reconciliation, and financial reporting.',
    `notes` STRING COMMENT 'Free-text field for tax analyst or compliance officer annotations, adjustment explanations, audit findings, or correspondence references related to this tax record. Supports SOX audit documentation requirements.',
    `remittance_date` DATE COMMENT 'The actual date on which the tax amount was remitted (paid) to the tax authority. Null if not yet remitted. Used to confirm payment completion and calculate late payment penalties.',
    `source_system` STRING COMMENT 'Identifies the operational system of record that originated this tax record (e.g., SAP S/4HANA ERP, Order Management System, Payment Gateway). Supports data lineage, reconciliation, and audit trail requirements.. Valid values are `SAP_S4HANA|OMS|PAYMENT_GATEWAY|MARKETPLACE|MANUAL`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount charged or withheld on the transaction, expressed in the transaction currency. Represents the tax adjustment component of the MONETARY_TRIPLET. May differ from taxable_amount × tax_rate due to rounding rules or tax authority adjustments.',
    `tax_amount_local_currency` DECIMAL(18,2) COMMENT 'Tax amount converted to the local reporting currency of the legal entity, using the exchange rate at the time of the taxable event. Required for statutory financial reporting, SOX compliance, and SAP S/4HANA parallel ledger reconciliation.',
    `tax_authority_name` STRING COMMENT 'Name of the government tax authority to which the tax is owed or has been filed (e.g., IRS, HMRC, EU VAT Authority, California CDTFA). Used for filing routing and regulatory correspondence.',
    `tax_code` STRING COMMENT 'SAP S/4HANA tax condition code (e.g., A1, V5) that encapsulates the tax type, rate, and jurisdiction configuration. Used for tax determination, GL account assignment, and tax reporting in the ERP system.',
    `tax_document_number` STRING COMMENT 'Externally-known tax document reference number assigned by SAP S/4HANA FI-TX module or the tax authority. Used for audit trails, tax filings, and cross-referencing with regulatory submissions. Serves as the BUSINESS_IDENTIFIER for this transaction.',
    `tax_event_timestamp` TIMESTAMP COMMENT 'The principal real-world timestamp when the taxable event occurred (e.g., point of sale, invoice issuance, payment settlement). Distinct from record audit timestamps. Determines the applicable tax period and rate under tax authority rules.',
    `tax_jurisdiction_code` STRING COMMENT 'Standardized code identifying the tax jurisdiction (country, state, province, county, or municipality) where the tax obligation arises. Follows ISO 3166-1 alpha-3 for country-level and ISO 3166-2 for sub-national jurisdictions. Drives tax rate lookup and filing routing.',
    `tax_jurisdiction_level` STRING COMMENT 'Hierarchical level of the tax jurisdiction at which the tax is levied. Supports multi-level tax stacking (e.g., federal + state + county + city sales tax in the US) and jurisdiction hierarchy reporting.. Valid values are `country|state|county|city|district`',
    `tax_jurisdiction_name` STRING COMMENT 'Human-readable name of the tax jurisdiction (e.g., California, United Kingdom, European Union VAT Area). Complements the jurisdiction code for reporting and business user readability.',
    `tax_period_end_date` DATE COMMENT 'End date of the tax reporting period to which this tax record belongs. Together with tax_period_start_date, defines the fiscal period boundary for tax filing and financial consolidation.',
    `tax_period_start_date` DATE COMMENT 'Start date of the tax reporting period (month, quarter, or year) to which this tax record belongs. Determines the filing period for tax authority submissions and financial period-end close.',
    `tax_rate` DECIMAL(18,2) COMMENT 'The applicable tax rate expressed as a decimal fraction (e.g., 0.085000 for 8.5%). Sourced from SAP S/4HANA tax condition records for the applicable jurisdiction and tax type at the time of the taxable event.',
    `tax_registration_number` STRING COMMENT 'The companys tax registration or identification number with the relevant tax authority (e.g., VAT registration number, EIN, GST registration). Required for tax invoice compliance and regulatory filings. Confidential business identifier.',
    `tax_treatment` STRING COMMENT 'The VAT/GST tax treatment applied to the transaction line, determining how the tax is calculated and reported. Drives tax return categorization and compliance with EU VAT Directive and OECD guidelines.. Valid values are `standard|reduced|zero_rated|exempt|reverse_charge|out_of_scope`',
    `tax_type` STRING COMMENT 'Classification of the tax obligation by tax regime type. Determines the applicable regulatory framework, filing requirements, and remittance rules. [ENUM-REF-CANDIDATE: VAT|GST|sales_tax|withholding_tax|customs_duty|excise_tax|use_tax|digital_services_tax — promote to reference product]. Valid values are `VAT|GST|sales_tax|withholding_tax|customs_duty|excise_tax`',
    `taxable_amount` DECIMAL(18,2) COMMENT 'The gross base amount subject to taxation before tax is applied, expressed in the transaction currency. Forms the basis for tax calculation: tax_amount = taxable_amount × tax_rate. Core component of the MONETARY_TRIPLET.',
    `transaction_type` STRING COMMENT 'Classification of the underlying business transaction that generated the tax record. Determines the direction of tax flow (payable vs. receivable) and applicable reporting treatment.. Valid values are `sale|refund|adjustment|withholding|import|export`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax record was last modified in the enterprise data platform. Supports change tracking, SOX audit controls, and incremental ETL processing.',
    CONSTRAINT pk_tax_record PRIMARY KEY(`tax_record_id`)
) COMMENT 'SSOT for all tax obligations, filings, and tax line-item records across transactions. Captures tax type (VAT, GST, sales tax, withholding tax), tax jurisdiction, tax rate applied, taxable amount, tax amount, tax period, and filing status. Supports compliance with FTC, GDPR, and international tax regulations. Integrates with SAP S/4HANA tax determination.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`financial_period_close` (
    `financial_period_close_id` BIGINT COMMENT 'Unique surrogate identifier for each financial period close record in the enterprise data lakehouse. Primary key for this entity.',
    `agent_id` BIGINT COMMENT 'The employee identifier of the CFO, VP Finance, or designated approver who provides final sign-off on the period close. Required for SOX-compliant attestation workflow.',
    `legal_entity_id` BIGINT COMMENT 'FK to finance.legal_entity',
    `primary_financial_agent_id` BIGINT COMMENT 'The employee identifier of the finance controller or close manager who owns and is accountable for the successful completion of this period close cycle. Primary party reference for the close workflow.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Period‑close is executed under a SOX compliance program; linking ensures auditability of close tasks against the program.',
    `accruals_posted` BOOLEAN COMMENT 'Indicates whether all period-end accrual journal entries (e.g., accrued expenses, deferred revenue, accrued liabilities) have been posted to the general ledger. True = all accruals posted; False = pending.',
    `actual_close_date` DATE COMMENT 'The calendar date on which the period close was formally completed and all sign-offs obtained. Compared against target_close_date to compute close cycle variance and report on close efficiency KPIs.',
    `approval_timestamp` TIMESTAMP COMMENT 'The precise date and time when the final sign-off approval was granted for this period close. Critical for SOX audit trail — establishes the exact moment of management certification.',
    `approver_name` STRING COMMENT 'The full name of the CFO or designated approver who signed off on the period close. Retained in the record for audit trail and SOX attestation documentation.',
    `bank_reconciliation_complete` BOOLEAN COMMENT 'Indicates whether all bank account reconciliations have been completed and approved for this period. True = all bank reconciliations complete; False = one or more pending. Key SOX cash control.',
    `close_completed_timestamp` TIMESTAMP COMMENT 'The precise date and time when the period close was marked as fully completed and all required approvals were obtained. Used for audit trail and close cycle duration analytics.',
    `close_cycle_days` STRING COMMENT 'The number of calendar days elapsed from period_end_date to actual_close_date, representing the total close cycle duration. Used as a KPI to benchmark close efficiency and drive continuous improvement initiatives.',
    `close_initiated_timestamp` TIMESTAMP COMMENT 'The precise date and time when the period close workflow was formally initiated in the system. Serves as the principal business event timestamp for the close cycle lifecycle. Stored in ISO 8601 format with timezone offset.',
    `close_notes` STRING COMMENT 'Free-text field for the close owner to document significant events, exceptions, judgments, or issues encountered during the period close (e.g., Q4 close delayed due to year-end inventory count discrepancy). Supports audit documentation and knowledge transfer.',
    `close_owner_name` STRING COMMENT 'The full name of the finance controller or close manager responsible for this period close. Retained for audit documentation and SOX attestation records independent of HR system changes.',
    `close_reference_number` STRING COMMENT 'Externally-known business identifier for the period close cycle, used in SAP S/4HANA and cross-system references (e.g., FPC-2024-12-ANN-0001). Enables traceability across ERP, audit, and reporting systems.. Valid values are `^FPC-[0-9]{4}-[0-9]{2}-[A-Z]{1,3}-[0-9]{4}$`',
    `close_status` STRING COMMENT 'Current workflow state of the period close cycle. Tracks progression from open through in-progress task execution, pending CFO/controller approval, final closed state, or reopened for adjustments. Core lifecycle field for SOX governance.. Valid values are `open|in_progress|pending_approval|closed|reopened`',
    `close_variance_days` STRING COMMENT 'The difference in calendar days between actual_close_date and target_close_date (positive = late, negative = early). Measures SLA adherence and is used to identify systemic close delays for process improvement.',
    `completed_tasks` STRING COMMENT 'The number of close tasks that have been completed and signed off as of the last update. Compared against total_close_tasks to derive completion progress for dashboard reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this financial period close record was first created in the enterprise data platform. Supports audit trail and data lineage requirements under SOX.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for the reporting currency of this period close (e.g., USD, EUR, GBP). Determines the currency in which GMV-to-revenue reconciliation and financial statements are expressed.. Valid values are `^[A-Z]{3}$`',
    `depreciation_run_complete` BOOLEAN COMMENT 'Indicates whether the fixed asset depreciation run has been executed and posted for this period in SAP S/4HANA Asset Accounting. True = depreciation run complete; False = pending.',
    `external_audit_flag` BOOLEAN COMMENT 'Indicates whether this period close is subject to external auditor review (e.g., Q4 annual audit, quarterly review). True = external audit scope; False = internal close only. Triggers additional documentation and evidence retention requirements.',
    `fiscal_period` STRING COMMENT 'The fiscal period number within the fiscal year (1–12 for monthly, 1–4 for quarterly, or 13/16 for special periods in SAP). Identifies the specific accounting period being closed.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this period close belongs (e.g., 2024). Aligns with the enterprise fiscal calendar defined in SAP S/4HANA and used for SOX financial reporting.',
    `gl_period_locked` BOOLEAN COMMENT 'Indicates whether the general ledger posting period has been locked in SAP S/4HANA, preventing further journal entries. True = period is locked; False = period is still open for postings. Critical SOX control.',
    `gl_posting_cutoff_date` DATE COMMENT 'The last date on which journal entries and transactions may be posted to the general ledger for this period. After this date, the posting period is locked in SAP S/4HANA to prevent unauthorized entries.',
    `gmv_to_revenue_reconciled` BOOLEAN COMMENT 'Indicates whether the GMV-to-net-revenue reconciliation has been completed for this period, accounting for seller commissions, returns, refunds, and marketplace fees. True = reconciled; False = pending. Core e-commerce finance control.',
    `intercompany_eliminations_complete` BOOLEAN COMMENT 'Indicates whether all intercompany transaction eliminations have been processed for consolidated financial reporting. True = eliminations complete; False = pending. Required for multi-entity SOX consolidation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this financial period close record was most recently modified. Tracks the latest state change for audit trail and SOX compliance purposes.',
    `open_blocking_items` STRING COMMENT 'The number of unresolved issues or open items that are currently blocking the period close from progressing to the next stage or final approval. A non-zero value indicates the close is at risk.',
    `period_end_date` DATE COMMENT 'The last calendar date of the accounting period being closed (e.g., 2024-12-31 for December close). Defines the inclusive end boundary for all transactions posted to this period.',
    `period_start_date` DATE COMMENT 'The first calendar date of the accounting period being closed (e.g., 2024-12-01 for December close). Defines the inclusive start boundary for all transactions posted to this period.',
    `period_type` STRING COMMENT 'Classification of the close cycle: monthly (standard month-end), quarterly (Q1–Q4 close), annual (year-end close), or special (adjustment/correction period). Drives the scope of close tasks and sign-off requirements.. Valid values are `monthly|quarterly|annual|special`',
    `reopen_authorized_by` STRING COMMENT 'The name and title of the senior finance officer who authorized the reopening of a closed period. Retained as a string for audit documentation. Populated only when close_status = reopened.',
    `reopen_reason` STRING COMMENT 'Free-text description of the business justification for reopening a previously closed period (e.g., Material error in revenue recognition for marketplace seller commissions). Populated only when close_status = reopened. Required for SOX audit trail.',
    `reporting_standard` STRING COMMENT 'The accounting standard under which this period close is being executed and reported. GAAP = US Generally Accepted Accounting Principles, IFRS = International Financial Reporting Standards, GAAP_IFRS_DUAL = dual reporting for multi-jurisdiction entities.. Valid values are `GAAP|IFRS|GAAP_IFRS_DUAL`',
    `revenue_recognition_complete` BOOLEAN COMMENT 'Indicates whether all revenue recognition entries for the period have been processed and validated per ASC 606 / IFRS 15 standards. True = revenue recognition is complete; False = pending. Required for accurate MRR and ARR reporting.',
    `sox_attestation_status` STRING COMMENT 'The current status of the SOX management attestation for this period close. Tracks whether the required CEO/CFO certification of internal controls over financial reporting has been completed, is in progress, or has noted exceptions requiring remediation.. Valid values are `not_started|in_progress|attested|exceptions_noted`',
    `target_close_date` DATE COMMENT 'The planned calendar date by which the period close must be completed, as defined in the close calendar. Used to measure close cycle efficiency and SLA adherence against actual close date.',
    `tax_provision_complete` BOOLEAN COMMENT 'Indicates whether the income tax provision calculation and journal entry have been completed for this period. True = tax provision posted; False = pending. Required for accurate net income reporting.',
    `total_close_tasks` STRING COMMENT 'The total number of close tasks (activities) defined in the close checklist for this period close cycle. Used to compute task completion percentage and monitor close progress.',
    CONSTRAINT pk_financial_period_close PRIMARY KEY(`financial_period_close_id`)
) COMMENT 'Tracks the status and workflow of monthly, quarterly, and annual financial period-close activities. Captures close task assignments, completion status, sign-off approvals, open items blocking close, and close date actuals vs. targets. Supports SOX-compliant close process governance and audit trail for financial attestation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique surrogate identifier for each intercompany transaction record within the Ecommerce corporate group. Serves as the primary key for this entity in the Silver Layer lakehouse.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for the intercompany charge on the receiving entity side, used for internal cost allocation and management reporting.',
    `general_ledger_id` BIGINT COMMENT 'Reference to the General Ledger account code under which this intercompany transaction is posted in the chart of accounts, enabling financial consolidation and GL-level reporting.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Intercompany pricing must satisfy transfer‑pricing regulatory obligations, tracked via a compliance obligation record.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity within the Ecommerce corporate group that originates and bills the intercompany transaction (the seller/creditor side of the intercompany entry).',
    `receiving_entity_legal_entity_id` BIGINT COMMENT 'Reference to the legal entity within the Ecommerce corporate group that receives and is charged for the intercompany transaction (the buyer/debtor side of the intercompany entry).',
    `agreement_reference` STRING COMMENT 'Reference to the intercompany service agreement, master service agreement (MSA), or transfer pricing agreement that governs this transaction. Links to the legal framework authorizing the charge.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total shared cost allocated to the receiving entity for cost_allocation transaction types. Must sum to 100% across all receiving entities for a given allocation event.',
    `approval_status` STRING COMMENT 'Current approval workflow status for the intercompany transaction: pending (awaiting review), approved (authorized by required approvers), rejected (declined and requires correction), escalated (referred to senior management for decision).. Valid values are `pending|approved|rejected|escalated`',
    `approved_by` STRING COMMENT 'The name or employee identifier of the authorized approver who approved this intercompany transaction. Required for SOX audit trail and segregation of duties compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time at which the intercompany transaction received final authorization from the designated approver. Part of the SOX-compliant audit trail.',
    `cost_allocation_basis` STRING COMMENT 'The allocation driver used to apportion shared costs across entities for cost_allocation transaction types: headcount (employee count), revenue (proportional to entity revenue), usage (actual consumption), fixed (predetermined fixed amount), square_footage (facility area), transaction_volume (number of transactions processed).. Valid values are `headcount|revenue|usage|fixed|square_footage|transaction_volume`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this intercompany transaction record was first created in the system. Part of the mandatory audit trail for SOX compliance and data lineage tracking in the Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the intercompany transaction is denominated (e.g., USD, EUR, GBP). Distinct from the functional currency of either entity.. Valid values are `^[A-Z]{3}$`',
    `document_reference` STRING COMMENT 'Reference to the originating source document (e.g., intercompany invoice number, purchase order number, or service agreement reference) that supports this intercompany transaction for audit purposes.',
    `elimination_date` DATE COMMENT 'The date on which this intercompany transaction was eliminated during the group consolidation process. Null if elimination has not yet occurred.',
    `elimination_status` STRING COMMENT 'Indicates whether this intercompany transaction has been eliminated in the consolidated financial statements to avoid double-counting of intra-group revenues and expenses. Required for IFRS 10 consolidation.. Valid values are `pending|eliminated|partially_eliminated|not_required`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the transaction currency amount to the functional or group currency at the transaction date. Sourced from the SAP S/4HANA exchange rate table.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month number 1–12 or 1–16 for special periods) within the fiscal year in which this intercompany transaction is recognized, used for period-end close and MRR/ARR reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this intercompany transaction is recognized for financial reporting purposes, aligned with the Ecommerce corporate fiscal calendar.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The net transaction amount converted to the functional currency of the sending entity, using the exchange rate applied at the transaction date. Required for local statutory reporting and GL posting.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the intercompany transaction before any adjustments, discounts, or withholding taxes, expressed in the transaction currency. Represents the billed amount from the sending entity.',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'The net transaction amount converted to the Ecommerce group reporting currency (e.g., USD) for consolidated financial reporting and GMV-to-revenue reconciliation.',
    `intercompany_transaction_description` STRING COMMENT 'Free-text narrative describing the business purpose and nature of the intercompany transaction (e.g., Q3 shared IT infrastructure cost recharge from Ecommerce Tech Ltd to Ecommerce Retail Ltd). Used for audit documentation and reconciliation.',
    `loan_interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate (as a percentage) applied to intercompany loan transactions. Must comply with arms-length pricing requirements per OECD guidelines. Null for non-loan transaction types.',
    `loan_maturity_date` DATE COMMENT 'The contractual maturity date by which an intercompany loan must be repaid. Applicable only to loan transaction types. Null for non-loan transactions.',
    `matched_transaction_number` STRING COMMENT 'The transaction_number of the corresponding intercompany transaction recorded by the receiving entity. Used to confirm bilateral matching in the SAP ICR reconciliation process.. Valid values are `^ICT-[0-9]{4}-[0-9]{8}$`',
    `matching_status` STRING COMMENT 'Status of the intercompany reconciliation matching process between the sending and receiving entity records. Unmatched transactions require investigation before period-end close.. Valid values are `unmatched|matched|partially_matched|disputed`',
    `materiality_threshold_breached` BOOLEAN COMMENT 'Indicates whether the transaction amount exceeds the defined materiality threshold for intercompany reconciliation and SOX reporting purposes. Transactions breaching the threshold require additional approval and documentation.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net monetary value of the intercompany transaction after deducting adjustments and taxes from the gross amount. This is the amount recognized in the consolidated financial statements before elimination.',
    `notes` STRING COMMENT 'Additional operational notes or comments added by finance team members regarding disputes, adjustments, or special circumstances related to this intercompany transaction.',
    `posting_date` DATE COMMENT 'The date on which the intercompany transaction was posted to the General Ledger. May differ from transaction_date due to period-end cut-off adjustments or late postings.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this intercompany transaction is a reversal (correcting) entry for a previously posted transaction. True if this is a reversal; False for original postings.',
    `reversed_transaction_number` STRING COMMENT 'The transaction_number of the original intercompany transaction that this entry reverses. Populated only when reversal_indicator is True, enabling audit trail traceability.. Valid values are `^ICT-[0-9]{4}-[0-9]{8}$`',
    `source_system` STRING COMMENT 'The operational system of record from which this intercompany transaction record originated: SAP_S4HANA (primary ERP), ERP (generic ERP), MANUAL (manually entered), CONSOLIDATION_TOOL (group consolidation platform).. Valid values are `SAP_S4HANA|ERP|MANUAL|CONSOLIDATION_TOOL`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this intercompany transaction is subject to a Sarbanes-Oxley (SOX) key internal control review. True for transactions above the materiality threshold or flagged for SOX audit scope.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax component (VAT, GST, withholding tax, or other applicable taxes) applied to the intercompany transaction. May be zero for intra-group transactions exempt from indirect tax.',
    `transaction_date` DATE COMMENT 'The principal business event date on which the intercompany transaction was initiated or the service/goods were delivered between entities. Used as the primary date for period-end close and revenue recognition.',
    `transaction_number` STRING COMMENT 'Externally-known, human-readable business identifier for the intercompany transaction, used in reconciliation reports, audit trails, and intercompany billing correspondence. Format: ICT-{YYYY}-{8-digit sequence}.. Valid values are `^ICT-[0-9]{4}-[0-9]{8}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle state of the intercompany transaction: draft (initiated, not yet posted), posted (recorded in GL), matched (confirmed by counterparty entity), disputed (discrepancy raised), eliminated (removed in consolidation), reversed (correcting entry applied).. Valid values are `draft|posted|matched|disputed|eliminated|reversed`',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction by its business nature: billing (services/goods invoiced between entities), cost_allocation (shared cost recharge), loan (intercompany financing), transfer_pricing (cross-border goods/services at arms-length price), dividend (profit distribution), royalty (IP licensing charge). [ENUM-REF-CANDIDATE: billing|cost_allocation|loan|transfer_pricing|dividend|royalty|management_fee|reimbursement — promote to reference product]. Valid values are `billing|cost_allocation|loan|transfer_pricing|dividend|royalty`',
    `transfer_price_method` STRING COMMENT 'The OECD-approved transfer pricing methodology used to establish the arms-length price for this intercompany transaction: CUP (Comparable Uncontrolled Price), RPM (Resale Price Method), CPM (Cost Plus Method), TNMM (Transactional Net Margin Method), PSM (Profit Split Method), or not_applicable for non-transfer-pricing transactions.. Valid values are `CUP|RPM|CPM|TNMM|PSM|not_applicable`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this intercompany transaction record was most recently modified. Tracks changes for audit trail purposes and Silver Layer incremental processing.',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Records of financial transactions between legal entities within the Ecommerce corporate group. Tracks intercompany billing, cost allocations, loans, and transfer pricing entries. Captures sending entity, receiving entity, transaction type, amount, currency, and elimination status for consolidated financial reporting. Supports SOX intercompany reconciliation and IFRS consolidation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique surrogate identifier for each fixed asset record in the enterprise asset register. Primary key for the fixed_asset data product.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier from whom the asset was purchased. Links to the vendor master in SAP S/4HANA for AP reconciliation, warranty management, and supplier performance tracking.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense charged against the asset from the acquisition date to the current reporting period. Represents the cumulative reduction in the assets carrying value. Used to calculate net book value. Sourced from SAP FI-AA depreciation postings.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original capitalized cost of the fixed asset at the time of acquisition, including purchase price, import duties, installation costs, and any directly attributable costs to bring the asset to its intended use. Recorded in the functional currency. Corresponds to SAP FI-AA acquisition value.',
    `acquisition_date` DATE COMMENT 'Date on which the fixed asset was acquired, purchased, or placed in service. This is the date used to commence depreciation calculations and establish the assets capitalization date in the general ledger. Corresponds to the SAP FI-AA asset value date.',
    `asset_category` STRING COMMENT 'High-level classification of the asset type for balance sheet presentation and accounting treatment. Tangible assets include physical equipment; intangible assets include software licenses; right-of-use assets arise from IFRS 16/ASC 842 lease accounting.. Valid values are `tangible|intangible|right_of_use|leasehold_improvement|construction_in_progress`',
    `asset_class_code` STRING COMMENT 'SAP FI-AA asset class code that categorizes the asset for depreciation rules, GL account determination, and financial reporting (e.g., 3000 for machinery, 4000 for IT equipment, 5000 for vehicles). Drives automatic posting to the correct balance sheet accounts.',
    `asset_class_name` STRING COMMENT 'Human-readable name of the asset class corresponding to the asset_class_code (e.g., Machinery and Equipment, IT Hardware, Leasehold Improvements, Vehicles). Used in financial statements and management reporting.',
    `asset_description` STRING COMMENT 'Detailed textual description of the fixed asset including specifications, model details, and operational purpose. Supports asset identification during audits and insurance valuations.',
    `asset_location_code` STRING COMMENT 'Code identifying the physical location where the asset is installed or deployed (e.g., fulfillment center ID, warehouse code, data center identifier, office location code). Used for physical asset verification, insurance, and logistics planning.',
    `asset_location_name` STRING COMMENT 'Human-readable name of the physical location where the asset resides (e.g., Seattle Fulfillment Center, AWS Data Center - US-East-1, Corporate HQ - Floor 3). Used in asset registers, insurance schedules, and physical audit reports.',
    `asset_name` STRING COMMENT 'Human-readable descriptive name of the fixed asset (e.g., Conveyor Belt System - FC Seattle, Dell PowerEdge R750 Server). Used in financial reports, depreciation schedules, and asset registers.',
    `asset_number` STRING COMMENT 'Externally-known unique asset identification number assigned by the ERP system (SAP S/4HANA FI-AA). Serves as the business-facing identifier used in procurement, finance, and audit documentation. Corresponds to the SAP Asset Master Number.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset within the enterprise asset register. active indicates the asset is in service and depreciating; under_construction indicates capital work in progress (CWIP); disposed and retired indicate the asset has been removed from service; transferred indicates inter-company or inter-location transfer; impaired indicates a recognized impairment loss.. Valid values are `active|under_construction|disposed|retired|transferred|impaired`',
    `asset_tag` STRING COMMENT 'Physical barcode or RFID tag label affixed to the asset for inventory tracking and physical verification during annual asset audits. Used by warehouse and fulfillment center operations teams.',
    `business_area` STRING COMMENT 'SAP S/4HANA business area representing the operational segment or division responsible for the asset (e.g., Fulfillment Operations, Technology Infrastructure, Marketplace Platform). Supports segment-level financial reporting and management accounting.',
    `capitalization_date` DATE COMMENT 'Date on which the asset was formally capitalized and transferred from capital work in progress (CWIP) to the fixed asset register. May differ from acquisition_date for assets under construction. Triggers the start of depreciation in SAP FI-AA.',
    `capitalized_by` STRING COMMENT 'User ID or name of the finance team member who approved and posted the asset capitalization in SAP S/4HANA. Required for SOX audit trail and segregation of duties controls.',
    `company_code` STRING COMMENT 'SAP S/4HANA company code representing the legal entity that owns the fixed asset. Used for inter-company asset transfers, legal entity financial reporting, and statutory compliance. Essential for multi-entity e-commerce group structures.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the asset is physically located. Used for multi-jurisdictional tax depreciation rules, insurance coverage, and regulatory compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset record was first created in the enterprise data platform (Silver Layer). Supports data lineage, audit trail, and SOX compliance requirements for financial record integrity.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this asset record (acquisition cost, net book value, depreciation amounts). Supports multi-currency reporting for international fulfillment center assets.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Accounting method used to allocate the depreciable cost of the asset over its useful life. Straight-line is most common for warehouse infrastructure; units-of-production may apply to fulfillment equipment with measurable output. Configured in SAP FI-AA depreciation key.. Valid values are `straight_line|declining_balance|double_declining_balance|units_of_production|sum_of_years_digits`',
    `depreciation_start_date` DATE COMMENT 'Date from which depreciation charges begin to be calculated and posted to the general ledger. Typically aligned with the capitalization date or the first day of the following month depending on company depreciation convention configured in SAP FI-AA.',
    `disposal_date` DATE COMMENT 'Date on which the fixed asset was disposed of, sold, scrapped, or retired from service. Null for assets still in service. Used to calculate gain or loss on disposal and to cease depreciation postings in SAP FI-AA.',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Net cash proceeds received upon disposal or sale of the fixed asset. Used to calculate the gain or loss on disposal (disposal proceeds minus net book value at disposal date). Null for assets still in service or scrapped with no proceeds.',
    `gl_account_code` STRING COMMENT 'SAP S/4HANA General Ledger account code to which the assets acquisition cost and depreciation are posted. Determined by the asset class configuration. Used for financial consolidation, balance sheet reporting, and SOX audit trail.',
    `impairment_loss` DECIMAL(18,2) COMMENT 'Cumulative impairment loss recognized on the asset when its recoverable amount falls below its carrying amount. Recorded in accordance with IAS 36 / ASC 360 impairment testing. Reduces the net book value and is posted to the P&L impairment charge account.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the insurance policy covering this fixed asset against loss, damage, or theft. Used for insurance claims processing, coverage verification, and risk management reporting.',
    `insured_value` DECIMAL(18,2) COMMENT 'Declared insured value of the fixed asset for insurance coverage purposes. May differ from net book value as it typically reflects replacement cost. Used for insurance premium calculations and claims settlement.',
    `last_physical_verification_date` DATE COMMENT 'Date of the most recent physical inventory count or asset verification exercise confirming the assets existence and condition at its recorded location. Required for SOX compliance and annual audit procedures.',
    `lease_end_date` DATE COMMENT 'Contractual end date of the lease agreement for right-of-use assets. Null for owned assets. Used to determine the lease term for IFRS 16/ASC 842 ROU asset amortization and lease liability calculations.',
    `lease_indicator` BOOLEAN COMMENT 'Flag indicating whether this asset is a right-of-use (ROU) asset arising from a lease arrangement accounted for under IFRS 16 or ASC 842. True indicates a leased asset; False indicates an owned asset. Drives different accounting treatment and disclosure requirements.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer or OEM of the fixed asset. Used for warranty management, maintenance contracts, spare parts procurement, and vendor relationship management.',
    `model_number` STRING COMMENT 'Manufacturers model or part number for the fixed asset. Used for maintenance planning, spare parts ordering, and asset standardization across fulfillment centers and technology infrastructure.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying amount of the fixed asset on the balance sheet, calculated as acquisition cost minus accumulated depreciation minus any accumulated impairment losses. Represents the assets remaining economic value as recognized in the financial statements. Sourced from SAP FI-AA.',
    `purchase_order_number` STRING COMMENT 'Reference to the Purchase Order (PO) number in SAP S/4HANA MM (Materials Management) used to procure the asset. Provides the procurement-to-asset audit trail required for SOX controls and AP reconciliation.',
    `remaining_useful_life_months` STRING COMMENT 'Number of months remaining in the assets useful life as of the last reporting date. Calculated as useful_life_months minus elapsed depreciation months. Used for capital planning, asset replacement forecasting, and impairment assessments.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the fixed asset at the end of its useful life, representing the amount the company expects to recover upon disposal. Used in depreciation calculations as the depreciable base equals acquisition cost minus salvage value. Also referred to as residual value under IFRS.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number for the fixed asset. Used for warranty claims, maintenance tracking, insurance documentation, and physical asset verification during audits. Particularly important for IT hardware and fulfillment equipment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fixed asset record in the enterprise data platform. Used for change data capture (CDC), data freshness monitoring, and SOX audit trail requirements.',
    `useful_life_months` STRING COMMENT 'Estimated total useful economic life of the fixed asset expressed in months. Used to calculate the periodic depreciation charge. Determined at acquisition based on asset class policy and management judgment. Stored in SAP FI-AA as the depreciation period.',
    `warranty_expiry_date` DATE COMMENT 'Date on which the manufacturers or vendors warranty for the fixed asset expires. Used to trigger maintenance contract renewals, plan preventive maintenance, and manage warranty claims before expiration.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Master data for all capitalized fixed assets including warehouse equipment, fulfillment center infrastructure, technology hardware, and leased assets. Tracks asset class, acquisition cost, accumulated depreciation, net book value, useful life, depreciation method, and asset location. Integrates with SAP S/4HANA FI-AA module for asset lifecycle management.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Unique surrogate identifier for each regulatory filing record in the enterprise financial compliance system. Primary key for the regulatory_filing data product.',
    `financial_period_close_id` BIGINT COMMENT 'Reference to the financial close task in the period-end close calendar that must be completed before this regulatory filing can be submitted. Enforces task dependency governance ensuring all close activities complete before filings are submitted.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity responsible for submitting this regulatory filing. Aligns with the SAP S/4HANA company code structure for financial consolidation.',
    `original_filing_regulatory_filing_id` BIGINT COMMENT 'Reference to the original regulatory_filing record that this amended filing supersedes. Null for original (non-amended) filings. Enables amendment chain tracking for audit and restatement analysis.',
    `agent_id` BIGINT COMMENT 'Reference to the employee or system user responsible for preparing and assembling this regulatory filing. Supports SOX Section 302 certification requirements and internal controls accountability.',
    `reviewer_agent_id` BIGINT COMMENT 'Reference to the employee responsible for reviewing this regulatory filing prior to submission. Part of the dual-control governance framework required under SOX internal controls.',
    `acceptance_timestamp` TIMESTAMP COMMENT 'The date and time at which the governing authority confirmed acceptance of the regulatory filing. Null if the filing has not yet been accepted. Used to close the compliance obligation lifecycle.',
    `certification_date` DATE COMMENT 'The date on which the certifying officer formally signed off and certified this regulatory filing. Required for SOX Section 302 attestation and SEC annual/quarterly report submissions.',
    `confirmation_reference` STRING COMMENT 'The official confirmation number, acknowledgement code, or receipt reference issued by the governing authority upon successful submission of the filing. Serves as the authoritative proof of submission for audit and compliance purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this regulatory filing record was first created in the system. Provides the audit trail creation marker required for SOX internal controls and ISO 27001 information security management.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the monetary amounts reported in this regulatory filing. Supports multi-currency financial reporting for international e-commerce operations.. Valid values are `^[A-Z]{3}$`',
    `external_auditor_ref` STRING COMMENT 'The reference number or identifier assigned by the external auditor (e.g., Big Four audit firm) to their review of this regulatory filing. Required for SOX Section 404 external auditor attestation of internal controls.',
    `filing_description` STRING COMMENT 'Free-text description of the regulatory filing, including its scope, key disclosures, and any material items or qualifications noted by the preparer or certifying officer.',
    `filing_method` STRING COMMENT 'The channel or method used to submit this regulatory filing to the governing authority. Electronic Data Interchange (EDI) and API submissions are common for large-scale e-commerce regulatory reporting.. Valid values are `electronic|paper|edi|api|portal`',
    `filing_number` STRING COMMENT 'Externally-known unique reference number assigned to this regulatory filing, used for tracking with regulatory authorities and internal audit trails. Corresponds to the filing reference number issued by the governing body or generated by the ERP system.. Valid values are `^[A-Z0-9-]{4,50}$`',
    `filing_period_end_date` DATE COMMENT 'The last calendar date of the reporting period covered by this regulatory filing. Defines the period boundary for financial close calendar management and regulatory scope.',
    `filing_period_start_date` DATE COMMENT 'The first calendar date of the reporting period covered by this regulatory filing. Used to define the financial period scope for period-end close governance and regulatory obligation tracking.',
    `filing_status` STRING COMMENT 'Current lifecycle state of the regulatory filing, tracking progression from initial draft through submission and regulatory acceptance or rejection.. Valid values are `draft|pending_review|submitted|accepted|rejected|overdue`',
    `filing_type` STRING COMMENT 'Classification of the regulatory filing by its mandatory obligation category. Examples include SOX attestation, VAT return, annual report, SEC filing, transfer pricing documentation, GDPR data processing record, PCI DSS compliance report, and CCPA privacy report. [ENUM-REF-CANDIDATE: sox_attestation|vat_return|annual_report|sec_filing|transfer_pricing|gdpr_record|pci_dss_report|ccpa_report|customs_declaration|income_tax_return — promote to reference product]',
    `filing_version` STRING COMMENT 'Version number of this regulatory filing, incremented each time an amended or corrected filing is submitted. Version 1 represents the original submission; subsequent versions represent amendments or restatements.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month number within the fiscal year, 1–16 including special periods) within the fiscal year to which this filing applies. Aligns with SAP S/4HANA period-end close calendar.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this regulatory filing pertains, as defined in the SAP S/4HANA fiscal year variant. Used for financial consolidation, MRR/ARR tracking, and period-end close governance.',
    `governing_body` STRING COMMENT 'The regulatory authority or governing body to which this filing is submitted. Examples include SEC, FTC, IRS, HMRC, EU VAT authority, PCI SSC, ISO certification body, or national data protection authority. [ENUM-REF-CANDIDATE: SEC|FTC|IRS|HMRC|EU_VAT|PCI_SSC|GDPR_DPA|CCPA_AG|CPSC|WTO|NIST — promote to reference product]',
    `is_amended` BOOLEAN COMMENT 'Indicates whether this filing is an amendment or correction to a previously submitted regulatory filing. True when filing_version is greater than 1 and the filing supersedes a prior submission.',
    `jurisdiction_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the legal jurisdiction under which this regulatory filing obligation arises. Supports multi-jurisdictional compliance tracking for international e-commerce operations.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Internal notes and commentary recorded by the preparer, reviewer, or certifying officer regarding this regulatory filing. May include explanations for open items, escalation notes, or instructions for resubmission.',
    `open_items_count` STRING COMMENT 'Number of unresolved open items or blocking issues that are preventing the completion of this regulatory filing. A non-zero value indicates the filing cannot be submitted until all open items are resolved.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Any financial penalty or fine assessed by the governing authority in connection with this regulatory filing, such as late submission penalties or compliance violations. Expressed in the currency defined by currency_code.',
    `period_lock_status` STRING COMMENT 'Indicates the lock state of the financial period associated with this regulatory filing. Hard-locked periods prevent any further journal entries in SAP S/4HANA, ensuring data integrity for submitted filings.. Valid values are `open|soft_locked|hard_locked|closed`',
    `rejection_reason` STRING COMMENT 'Textual description of the reason provided by the governing authority for rejecting this regulatory filing. Populated only when filing_status is rejected. Supports remediation tracking and resubmission workflows.',
    `reported_amount` DECIMAL(18,2) COMMENT 'The principal monetary amount declared in this regulatory filing, such as taxable revenue for a VAT return, GMV for a financial report, or assessed liability for a tax filing. Expressed in the currency defined by currency_code.',
    `source_system` STRING COMMENT 'The operational system of record from which this regulatory filing data was originated or extracted. Primarily SAP S/4HANA for financial filings, but may include tax engines, GRC platforms, or manual submissions for specialized filings.. Valid values are `sap_s4hana|oms|erp|manual|tax_engine|grc_platform`',
    `sox_control_ref` STRING COMMENT 'The SOX Section 404 internal control reference number or control ID associated with this filing. Links the filing to the specific internal control being attested, supporting the annual management assessment of internal controls over financial reporting.',
    `submission_date` DATE COMMENT 'The actual calendar date on which this regulatory filing was submitted to the governing authority. Compared against submission_deadline to determine on-time or late submission status for SOX audit trail purposes.',
    `submission_deadline` DATE COMMENT 'The mandatory deadline date by which this regulatory filing must be submitted to the governing authority. Used for SLA tracking, close calendar management, and escalation triggers when filings are at risk of being overdue.',
    `submission_timestamp` TIMESTAMP COMMENT 'The precise date and time (with timezone) at which this regulatory filing was electronically submitted to the governing authority. Provides the authoritative business event timestamp for audit trail and SLA compliance measurement.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax liability or tax credit amount declared in this regulatory filing, applicable for VAT returns, income tax filings, and other tax-related submissions. Expressed in the currency defined by currency_code.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this regulatory filing record was most recently modified. Tracks the last update event for audit trail completeness and change management governance under SOX.',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'SSOT for all mandatory financial regulatory filings, compliance submissions, and period-end close governance. Captures filing type (SOX attestation, VAT return, annual report, SEC filing, transfer pricing documentation), filing period, submission deadlines, responsible legal entity, and submission confirmations. Manages the complete financial close calendar including close task assignments, task dependencies, completion status, sign-off approvals, open items blocking close, close date actuals vs. targets, and period lock status. Supports SOX Section 404 internal controls attestation, international financial reporting obligations, and provides the governance framework ensuring all close activities complete before filings are submitted.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` (
    `finance_bank_account_id` BIGINT COMMENT 'Unique surrogate identifier for each corporate bank account record in the treasury master data. Primary key for the bank_account data product.',
    `general_ledger_id` BIGINT COMMENT 'Reference to the GL clearing account in the chart of accounts that this bank account maps to for automated bank reconciliation and financial reporting.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the owning legal entity (company code) that holds this bank account. Used for multi-entity financial consolidation and SOX entity-level reporting.',
    `account_id` BIGINT COMMENT 'SAP S/4HANA account ID within the house bank (e.g., CHK01, SAV01). Together with house_bank_id, uniquely identifies the bank account in SAP payment programs and electronic bank statement processing.',
    `account_name` STRING COMMENT 'Descriptive name assigned to the bank account for internal identification and treasury reporting (e.g., Ecommerce US Operating Account - JPMorgan). Used in cash position dashboards and SAP S/4HANA bank account master.',
    `account_number_masked` STRING COMMENT 'Masked representation of the bank account number showing only the last 4 digits (e.g., XXXXXXXX1234). Full account number is stored in a separate secrets vault per PCI DSS requirements. Used for display, reconciliation matching, and audit trail.. Valid values are `^[X*]{1,12}[0-9]{4}$`',
    `account_purpose` STRING COMMENT 'Free-text description of the specific business purpose of this account (e.g., Marketplace seller escrow disbursements - APAC region, US payroll funding account). Provides operational context beyond the account_type classification.',
    `account_status` STRING COMMENT 'Current lifecycle status of the bank account. Active: fully operational. Inactive: temporarily not in use. Frozen: blocked by bank or regulatory order. Closed: permanently deactivated. Pending_activation: account opened but not yet confirmed by bank.. Valid values are `active|inactive|frozen|closed|pending_activation`',
    `account_type` STRING COMMENT 'Functional classification of the bank account within the corporate treasury structure. Operating: day-to-day business transactions. Payroll: employee salary disbursements. Escrow: held funds for marketplace seller settlements. Concentration: cash pooling/sweeping. Disbursement: outbound payments only. Collection: inbound receipts only. [ENUM-REF-CANDIDATE: operating|payroll|escrow|concentration|disbursement|collection — promote to reference product]. Valid values are `operating|payroll|escrow|concentration|disbursement|collection`',
    `bank_branch_address` STRING COMMENT 'Full street address of the bank branch. Used for payment instructions, correspondence, and regulatory filings. Classified as confidential organizational contact data.',
    `bank_branch_name` STRING COMMENT 'Name of the specific bank branch where the account is held (e.g., New York Midtown Branch). Used for correspondence, wire transfer instructions, and bank relationship management.',
    `bank_contact_email` STRING COMMENT 'Email address of the primary bank relationship manager or contact for this account. Used for electronic correspondence, statement delivery notifications, and escalation. Classified as confidential organizational contact data.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `bank_contact_name` STRING COMMENT 'Name of the primary relationship manager or contact person at the bank for this account. Used for escalation, issue resolution, and bank relationship management.',
    `bank_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the bank branch is domiciled (e.g., USA, GBR, DEU). Drives currency controls, regulatory reporting jurisdiction, and cross-border payment rules.. Valid values are `^[A-Z]{3}$`',
    `bank_name` STRING COMMENT 'Full legal name of the financial institution holding this account (e.g., JPMorgan Chase Bank, N.A.). Used for treasury reporting, bank relationship management, and counterparty risk assessment.',
    `book_balance` DECIMAL(18,2) COMMENT 'Internal GL book balance for this bank account as recorded in SAP S/4HANA general ledger, in the accounts base currency. Compared against current_balance during bank reconciliation to identify timing differences and unrecorded items.',
    `closing_date` DATE COMMENT 'Date on which the bank account was officially closed. Null for active accounts. Used for account lifecycle management, historical reporting, and SOX audit trail.',
    `company_code` STRING COMMENT 'Four-character SAP company code identifying the legal entity in SAP S/4HANA for financial consolidation, GL posting, and regulatory reporting. Aligns with the owning legal entity for SOX compliance.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank account master record was first created in the data platform. Used for audit trail, data lineage, and SOX record-keeping requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the accounts primary operating currency (e.g., USD, EUR, GBP). Determines the base currency for all statement balances, transaction amounts, and FX conversion in treasury reporting.. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'Most recent confirmed closing balance of the bank account as reported on the latest electronic bank statement, in the accounts base currency. Used for daily cash position reporting and liquidity forecasting.',
    `dual_control_required` BOOLEAN COMMENT 'Indicates whether this bank account requires dual authorization (two-person rule) for payment initiation per treasury policy and SOX segregation of duties controls. True: dual approval mandatory. False: single authorization permitted.',
    `house_bank_code` STRING COMMENT 'SAP S/4HANA house bank identifier that groups bank accounts under a single banking relationship. Used for payment program configuration, bank statement import, and electronic bank reconciliation in SAP FI-BL.. Valid values are `^[A-Z0-9]{1,5}$`',
    `iban` STRING COMMENT 'International Bank Account Number (IBAN) assigned to this account per ISO 13616 standard. Used for cross-border payment instructions, SEPA transactions, and international treasury operations. Nullable for non-IBAN jurisdictions.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$`',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate (as a decimal percentage, e.g., 0.0425 = 4.25%) applicable to this bank account for credit balances or overdraft facilities. Used in treasury yield analysis and cost-of-funds reporting.',
    `is_pooling_header` BOOLEAN COMMENT 'Indicates whether this account serves as the header/master account in a cash concentration or notional pooling structure. True: this is the concentration account that receives sweeps from subsidiary accounts. False: standard account.',
    `last_reconciled_date` DATE COMMENT 'Date on which the most recent successful automated bank reconciliation was completed for this account in SAP S/4HANA. Used for cash position accuracy monitoring and SOX reconciliation controls.',
    `last_statement_date` DATE COMMENT 'Date of the most recently received and processed electronic bank statement (EBS) for this account. Used to monitor statement receipt timeliness and identify gaps in automated bank reconciliation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this bank account master record. Used for change tracking, incremental ETL processing, and SOX audit trail.',
    `opening_date` DATE COMMENT 'Date on which the bank account was officially opened and activated by the financial institution. Used for account tenure analysis, regulatory reporting, and audit trail.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'Maximum overdraft facility amount authorized by the bank for this account, in the accounts base currency. Used in daily cash position reporting and liquidity forecasting to determine available credit headroom.',
    `payment_limit` DECIMAL(18,2) COMMENT 'Maximum amount in the accounts base currency that can be authorized for a single payment transaction from this account without escalated approval. Enforces treasury payment controls and SOX segregation of duties.',
    `payment_method_codes` STRING COMMENT 'Comma-separated list of SAP payment method codes authorized for use with this bank account (e.g., T,U,C for wire transfer, ACH, check). Controls which payment programs can use this account in SAP automatic payment runs.',
    `reconciliation_status` STRING COMMENT 'Current reconciliation status of the bank account as of the last statement processing cycle. Reconciled: all items matched. Unreconciled: outstanding items exist. In_progress: reconciliation run is active. Exception: unresolvable discrepancies requiring manual review.. Valid values are `reconciled|unreconciled|in_progress|exception`',
    `routing_number` STRING COMMENT 'ABA routing transit number (9-digit) identifying the US financial institution for domestic ACH and wire transfers. Used in payment processing and settlement runs. Applicable for US-domiciled accounts only.. Valid values are `^[0-9]{9}$`',
    `signatory_names` STRING COMMENT 'Comma-separated list of names of individuals authorized to sign on this bank account per the bank mandate. Used for treasury governance, audit, and SOX segregation of duties controls.',
    `source_system` STRING COMMENT 'Originating system from which this bank account master record was sourced. SAP_S4HANA: extracted from SAP S/4HANA Bank Account Management. MANUAL: manually entered by treasury team. BANK_PORTAL: imported from banks online portal.. Valid values are `SAP_S4HANA|MANUAL|BANK_PORTAL`',
    `statement_delivery_method` STRING COMMENT 'Method by which electronic bank statements are delivered from the bank to the ERP system. SWIFT: via SWIFT network. SFTP: secure file transfer. API: direct bank API integration. Email: email attachment. Manual: manual upload.. Valid values are `swift|sftp|api|email|manual`',
    `statement_format` STRING COMMENT 'Format of the electronic bank statement (EBS) received from the bank for automated import into SAP S/4HANA. MT940: SWIFT legacy format. CAMT053: ISO 20022 XML format. BAI2: US cash management format. OFX: Open Financial Exchange. CSV: flat file.. Valid values are `MT940|CAMT053|BAI2|OFX|CSV`',
    `swift_bic` STRING COMMENT 'SWIFT/BIC code identifying the bank and branch for international wire transfers and correspondent banking. Conforms to ISO 9362 standard. Required for cross-border payment routing in the Transportation Management System and ERP payment runs.. Valid values are `^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `target_balance` DECIMAL(18,2) COMMENT 'Desired minimum or target cash balance for this account as set by treasury policy. Used in cash concentration/sweeping rules and liquidity forecasting to trigger inter-account transfers.',
    CONSTRAINT pk_finance_bank_account PRIMARY KEY(`finance_bank_account_id`)
) COMMENT 'Master data and complete transaction history for all corporate bank accounts used in treasury operations. Tracks bank name, account identifiers (masked account number, IBAN/SWIFT), currency, account type (operating, payroll, escrow, concentration), account status, and owning legal entity. Includes electronic bank statement records with statement dates, opening/closing balances, individual transaction lines (credits and debits), value dates, and reconciliation status. Supports automated bank reconciliation, daily cash position reporting, cash flow management, and liquidity forecasting in SAP S/4HANA treasury.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`bank_statement` (
    `bank_statement_id` BIGINT COMMENT 'Unique surrogate identifier for each bank statement record in the enterprise data lakehouse. Primary key for the bank_statement data product.',
    `general_ledger_id` BIGINT COMMENT 'Reference to the General Ledger (GL) cash account associated with this bank statement. Links the bank statement to the corresponding GL account for reconciliation in SAP S/4HANA.',
    `account_type` STRING COMMENT 'Classification of the corporate bank account type. Determines cash management rules, interest treatment, and reconciliation procedures. Zero-balance accounts (ZBA) are common in e-commerce treasury structures.. Valid values are `current|savings|escrow|payroll|concentration|zero_balance`',
    `auto_reconciled_count` STRING COMMENT 'Number of transaction lines on this statement that were automatically matched and reconciled by the SAP S/4HANA automated bank reconciliation engine without manual intervention. Used to measure automation efficiency.',
    `available_balance` DECIMAL(18,2) COMMENT 'The funds available for immediate use at the statement date, net of holds, pending transactions, and float. May differ from closing_balance due to uncleared items. Used for liquidity management and cash forecasting.',
    `bank_account_number` STRING COMMENT 'The bank account number associated with this statement as held at the banking institution. Masked or tokenized in non-restricted environments per PCI DSS requirements. Used to identify the corporate cash account.',
    `bank_bic_code` STRING COMMENT 'SWIFT Bank Identifier Code (BIC) / Business Identifier Code uniquely identifying the banking institution and branch. Conforms to ISO 9362 standard. Used for international wire transfers and bank identification in SAP S/4HANA.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `bank_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the banking institution where the account is held. Used for regulatory jurisdiction determination, cross-border reporting, and GDPR/CCPA applicability assessment.. Valid values are `^[A-Z]{3}$`',
    `bank_name` STRING COMMENT 'Full legal name of the banking institution that issued the statement (e.g., JPMorgan Chase, Bank of America, HSBC). Used for counterparty identification in cash management and treasury reporting.',
    `bank_reference` STRING COMMENT 'Unique reference number assigned by the banking institution to this statement transmission or file. Used for bank-side traceability, dispute resolution, and re-import identification.',
    `closing_balance` DECIMAL(18,2) COMMENT 'The account balance at the end of the statement period as reported by the banking institution. Represents the final cash position for the period. Used for cash flow reporting and GL reconciliation.',
    `company_code` STRING COMMENT 'SAP S/4HANA company code identifying the legal entity that owns the bank account. Used for financial consolidation and intercompany reconciliation.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bank statement record was first imported and created in the enterprise data platform. Supports audit trail requirements under SOX and provides data lineage for the Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the bank account statement (e.g., USD, EUR, GBP). All monetary amounts on this statement are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `exception_count` STRING COMMENT 'Number of individual transaction lines on this statement that could not be automatically matched to GL entries and require manual investigation. Used for reconciliation quality monitoring and workload management.',
    `fiscal_period` STRING COMMENT 'The fiscal accounting period (1–12 for monthly, or 1–4 for quarterly) within the fiscal year to which this statement is assigned. Aligns with SAP S/4HANA posting periods for GL reconciliation.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this bank statement belongs for financial reporting and GL period assignment in SAP S/4HANA. Used for annual financial close, SOX reporting, and MRR/ARR reconciliation.',
    `gl_posting_date` DATE COMMENT 'The date on which the bank statement was posted to the General Ledger (GL) in SAP S/4HANA. May differ from statement_date due to processing lag. Used for period-end close and financial reporting accuracy.',
    `iban` STRING COMMENT 'International Bank Account Number (IBAN) for the corporate bank account per ISO 13616 standard. Used for cross-border payment identification and reconciliation in international treasury operations.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$`',
    `import_timestamp` TIMESTAMP COMMENT 'Timestamp when the bank statement file was electronically received and imported into SAP S/4HANA or the data platform via EDI, SWIFT, or API. Used for SLA monitoring of bank data feeds and processing latency tracking.',
    `is_intercompany` BOOLEAN COMMENT 'Indicates whether the bank account is used for intercompany transactions between legal entities within the Ecommerce enterprise group. Intercompany statements require elimination entries during financial consolidation.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the bank statement record has been locked to prevent further modifications after period-end close or SOX audit sign-off. Locked statements cannot be altered without an authorized unlock workflow.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the bank statement record, including reconciliation status changes, balance corrections, or posting updates. Required for SOX audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for finance team annotations regarding the bank statement, such as reconciliation exceptions, manual adjustments, or special handling instructions. Supports audit documentation requirements.',
    `opening_balance` DECIMAL(18,2) COMMENT 'The account balance at the start of the statement period as reported by the banking institution. Used as the baseline for reconciliation; must equal the prior statement closing balance for continuity validation.',
    `period_end_date` DATE COMMENT 'The last calendar date of the bank statement coverage period. Defines the closing boundary of the statement window. Typically aligns with the statement_date for end-of-period statements.',
    `period_start_date` DATE COMMENT 'The first calendar date of the bank statement coverage period. Together with period_end_date, defines the statement window for which transactions are reported. Used for period-based cash flow analysis.',
    `reconciled_by` STRING COMMENT 'Username or employee identifier of the finance team member who completed and approved the bank reconciliation. Required for SOX segregation of duties (SoD) controls and audit trail documentation.',
    `reconciliation_date` DATE COMMENT 'The date on which the bank statement reconciliation was completed and approved. Null if reconciliation is still in progress. Used for period-end close tracking and SOX control evidence.',
    `reconciliation_status` STRING COMMENT 'Current lifecycle status of the bank statement reconciliation workflow. Tracks progression from import through automated matching to final posting in SAP S/4HANA. [ENUM-REF-CANDIDATE: unreconciled|in_progress|reconciled|exception|posted|cancelled — promote to reference product]. Valid values are `unreconciled|in_progress|reconciled|exception|posted|cancelled`',
    `source_system` STRING COMMENT 'Identifies the originating system or channel through which the bank statement was received and imported. Used for data lineage tracking, ETL audit, and troubleshooting import failures.. Valid values are `SAP_S4HANA|SWIFT|BANK_DIRECT|EDI|API|MANUAL`',
    `statement_date` DATE COMMENT 'The official date of the bank statement as issued by the banking institution. Represents the business event date for the statement period end. Used as the primary date for cash flow reporting and reconciliation.',
    `statement_format` STRING COMMENT 'Electronic file format in which the bank statement was received from the banking institution. Determines the parsing and import logic applied during ETL ingestion into SAP S/4HANA and the data lakehouse.. Valid values are `MT940|MT942|camt.053|camt.052|BAI2|OFX|CSV`',
    `statement_number` STRING COMMENT 'Externally assigned statement number issued by the banking institution. Serves as the primary business identifier for the statement as received from the bank. Used for matching and audit trail.',
    `statement_type` STRING COMMENT 'Classification of the bank statement by reporting frequency or finality. Determines processing rules and reconciliation cadence in SAP S/4HANA. Intraday statements support real-time cash visibility.. Valid values are `daily|weekly|monthly|intraday|final|interim`',
    `total_credits` DECIMAL(18,2) COMMENT 'Aggregate sum of all credit (inflow) transactions on the statement for the period. Used for cash inflow analysis, revenue reconciliation, and GMV-to-cash settlement validation.',
    `total_debits` DECIMAL(18,2) COMMENT 'Aggregate sum of all debit (outflow) transactions on the statement for the period. Used for cash outflow analysis, accounts payable settlement validation, and expense reconciliation.',
    `transaction_count` STRING COMMENT 'Total number of individual transaction lines reported on the bank statement for the period. Used for completeness validation during import and reconciliation to ensure all lines are processed.',
    `unreconciled_amount` DECIMAL(18,2) COMMENT 'The monetary difference between the bank statement closing balance and the corresponding GL cash account balance that remains unmatched after automated reconciliation. A non-zero value triggers exception handling and investigation.',
    CONSTRAINT pk_bank_statement PRIMARY KEY(`bank_statement_id`)
) COMMENT 'Electronic bank statement records imported from banking institutions for cash reconciliation. Captures statement date, bank account, opening/closing balance, transaction lines (credits and debits), value dates, and reconciliation status. Supports automated bank reconciliation in SAP S/4HANA and cash flow management.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
    `consolidation_group_id` BIGINT COMMENT 'Reference to the consolidation group this legal entity belongs to, used for consolidated financial reporting and intercompany eliminations.',
    `parent_entity_legal_entity_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediate parent legal entity in the corporate ownership hierarchy. Null for the ultimate holding company.',
    `accounting_standard` STRING COMMENT 'Financial reporting standard under which this legal entity prepares its statutory financial statements (IFRS, US GAAP, or local GAAP). Determines accounting policies, disclosure requirements, and consolidation adjustments.. Valid values are `IFRS|US_GAAP|local_gaap`',
    `business_activity_description` STRING COMMENT 'Narrative description of the primary business activities conducted by this legal entity (e.g., marketplace operations, fulfillment services, technology platform, financial services). Used for regulatory filings and transfer pricing documentation.',
    `chart_of_accounts_code` STRING COMMENT 'Code identifying the chart of accounts assigned to this legal entity in SAP S/4HANA. Defines the set of general ledger accounts available for financial postings and ensures consistency in financial reporting across the group.',
    `company_code` STRING COMMENT 'Four-character SAP S/4HANA company code assigned to this legal entity. Serves as the primary organizational unit for financial accounting in the ERP system and links to the general ledger, accounts payable, and accounts receivable modules.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_method` STRING COMMENT 'Accounting method applied when consolidating this entity into the group financial statements. Drives intercompany elimination logic and ownership percentage calculations.. Valid values are `full_consolidation|proportional|equity_method|not_consolidated`',
    `controlling_area_code` STRING COMMENT 'SAP S/4HANA controlling area code associated with this legal entity. Defines the organizational unit for management accounting, cost center hierarchies, and internal order management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity master data record was first created in the system. Supports audit trail requirements under SOX and data lineage tracking in the Databricks Silver Layer.',
    `dissolution_date` DATE COMMENT 'Date on which the legal entity was formally dissolved, wound up, or deregistered with the relevant government authority. Null for active entities.',
    `effective_from_date` DATE COMMENT 'Date from which this legal entity record is considered active and valid for financial transactions, intercompany postings, and regulatory filings within the Ecommerce corporate group.',
    `effective_to_date` DATE COMMENT 'Date on which this legal entity record ceases to be valid for new transactions. Null for currently active entities. Populated upon dissolution, merger, or deregistration.',
    `entity_name` STRING COMMENT 'Full registered legal name of the entity as recorded with the relevant government or regulatory authority in the jurisdiction of incorporation.',
    `entity_status` STRING COMMENT 'Current lifecycle status of the legal entity. Drives inclusion or exclusion in consolidation runs, intercompany transaction eligibility, and regulatory filing requirements.. Valid values are `active|inactive|dormant|dissolved|in_liquidation|pending`',
    `entity_type` STRING COMMENT 'Classification of the legal entity by its structural role within the corporate group. [ENUM-REF-CANDIDATE: holding_company|operating_company|subsidiary|joint_venture|branch|partnership|special_purpose_vehicle|associate — promote to reference product]. Valid values are `holding_company|operating_company|subsidiary|joint_venture|branch|partnership`',
    `fiscal_year_variant` STRING COMMENT 'SAP fiscal year variant code defining the fiscal year calendar for this entity (e.g., K4 for calendar year, V3 for April–March). Determines period mapping for financial reporting and budget cycles.',
    `functional_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the primary currency of the economic environment in which the entity operates. Used for local financial statement preparation and SAP S/4HANA company code currency assignment.. Valid values are `^[A-Z]{3}$`',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether this legal entity is subject to GDPR data privacy obligations, either as a data controller or data processor. True for entities operating in or processing data of EU residents.',
    `gmv_to_revenue_ratio` DECIMAL(18,2) COMMENT 'The ratio of net revenue recognized to Gross Merchandise Value (GMV) processed by this legal entity. Used for GMV-to-revenue reconciliation in consolidated financial reporting and take-rate analysis. Value between 0.0000 and 1.0000.',
    `incorporation_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country in which the legal entity was incorporated or registered.. Valid values are `^[A-Z]{3}$`',
    `incorporation_date` DATE COMMENT 'Date on which the legal entity was formally incorporated or registered with the relevant government authority. Used for entity age calculations and regulatory filing timelines.',
    `industry_classification_code` STRING COMMENT 'Standard industry classification code (NAICS or SIC) assigned to this legal entity based on its primary business activity. Used for regulatory reporting, benchmarking, and transfer pricing comparability analysis.',
    `intercompany_trading_partner_code` STRING COMMENT 'SAP S/4HANA trading partner code assigned to this legal entity for intercompany transaction identification and elimination during group consolidation. Enables automated intercompany reconciliation.',
    `jurisdiction` STRING COMMENT 'Specific legal jurisdiction (state, province, or territory) within the country of incorporation where the entity is registered. Relevant for sub-national regulatory compliance (e.g., Delaware, California, Ontario).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this legal entity master data record. Used for change data capture (CDC), audit trail compliance, and data freshness monitoring in the Silver Layer.',
    `legal_form` STRING COMMENT 'Legal structure or form of the entity as defined by the jurisdiction of incorporation (e.g., LLC, PLC, GmbH, S.A., Pvt Ltd, Corp). Determines governance, liability, and reporting obligations.',
    `lei_code` STRING COMMENT '20-character alphanumeric Legal Entity Identifier (LEI) code assigned by a Local Operating Unit (LOU) accredited by the Global LEI Foundation (GLEIF). Used for regulatory reporting and counterparty identification in financial transactions.. Valid values are `^[A-Z0-9]{18}[0-9]{2}$`',
    `operating_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the primary country where the entity conducts its business operations. May differ from the country of incorporation for tax-optimized structures.. Valid values are `^[A-Z]{3}$`',
    `ownership_pct` DECIMAL(18,2) COMMENT 'Percentage of the legal entity owned by the immediate parent entity in the corporate hierarchy. Used to determine consolidation scope and minority interest calculations. Value between 0.00 and 100.00.',
    `pci_dss_applicable` BOOLEAN COMMENT 'Indicates whether this legal entity is subject to PCI DSS compliance requirements due to processing, storing, or transmitting payment card data. Drives scope of PCI DSS audit and certification.',
    `registered_address_city` STRING COMMENT 'City of the official registered address of the legal entity. Used for regulatory filings, tax jurisdiction determination, and legal correspondence.',
    `registered_address_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country of the entitys registered address. May differ from the country of incorporation for branch offices.. Valid values are `^[A-Z]{3}$`',
    `registered_address_line1` STRING COMMENT 'First line of the official registered address of the legal entity as recorded with the government authority. Used for regulatory correspondence, tax filings, and legal notices.',
    `registered_address_postal_code` STRING COMMENT 'Postal or ZIP code of the official registered address. Used for tax jurisdiction mapping, regulatory filings, and last-mile logistics planning for entity-level shipments.',
    `registration_number` STRING COMMENT 'Official company registration number assigned by the government authority in the jurisdiction of incorporation (e.g., Companies House number in the UK, EIN in the US).',
    `reporting_currency` STRING COMMENT 'Three-letter ISO 4217 currency code used for presenting the entitys financial statements in consolidated group reporting. Typically the groups presentation currency (e.g., USD for a US-listed parent).. Valid values are `^[A-Z]{3}$`',
    `revenue_recognition_standard` STRING COMMENT 'Accounting standard applied for revenue recognition by this legal entity. Determines how and when revenue from e-commerce transactions, marketplace fees, and fulfillment services is recognized.. Valid values are `IFRS_15|ASC_606|local_gaap`',
    `short_name` STRING COMMENT 'Abbreviated or trading name of the legal entity used in internal reporting, system displays, and intercompany references.',
    `sox_in_scope` BOOLEAN COMMENT 'Indicates whether this legal entity is within the scope of Sarbanes-Oxley (SOX) internal controls assessment and financial reporting requirements. True for entities that are material to the consolidated groups financial statements.',
    `tax_id_number` STRING COMMENT 'Government-issued Tax Identification Number (TIN) or Employer Identification Number (EIN) used for tax filings, regulatory reporting, and financial settlements. Classified as restricted due to sensitivity of tax data.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the tax jurisdiction applicable to this legal entity for indirect tax (VAT/GST) determination, withholding tax, and transfer pricing compliance. Aligns with SAP S/4HANA tax jurisdiction configuration.',
    `vat_registration_number` STRING COMMENT 'Value Added Tax (VAT) or Goods and Services Tax (GST) registration number issued by the tax authority in the entitys operating jurisdiction. Required for cross-border e-commerce tax compliance.',
    `voting_rights_pct` DECIMAL(18,2) COMMENT 'Percentage of voting rights held by the parent entity in this legal entity. May differ from ownership percentage in dual-class share structures. Determines control assessment under IFRS 10.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master data for all legal entities within the Ecommerce corporate group. Tracks entity name, registration number, jurisdiction, country of incorporation, functional currency, tax identification number, and consolidation group membership. Serves as the organizational anchor for intercompany transactions, regulatory filings, and consolidated financial reporting.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`accrual` (
    `accrual_id` BIGINT COMMENT 'Unique system-generated identifier for the accrual record.',
    `agent_id` BIGINT COMMENT 'Identifier of the user who approved the accrual.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center associated with the accrual.',
    `general_ledger_id` BIGINT COMMENT 'GL account to which the accrual amount is posted.',
    `header_id` BIGINT COMMENT 'Identifier of the order that triggered the accrual, if applicable.',
    `legal_entity_id` BIGINT COMMENT 'Legal entity (company) that owns the accrual.',
    `profit_center_id` BIGINT COMMENT 'Identifier of the profit center linked to the accrual.',
    `vendor_contract_id` BIGINT COMMENT 'Identifier of the contract associated with the accrual, if applicable.',
    `supplier_invoice_id` BIGINT COMMENT 'Identifier of the invoice linked to the accrual, if applicable.',
    `reversal_accrual_id` BIGINT COMMENT 'Self-referencing FK on accrual (reversal_accrual_id)',
    `accrual_date` TIMESTAMP COMMENT 'Timestamp when the accrual was recorded (business event time).',
    `accrual_method` STRING COMMENT 'Method by which the accrual was created.. Valid values are `manual|automated|system_generated`',
    `accrual_number` STRING COMMENT 'Business identifier assigned to the accrual (e.g., ACCR-2023-0001).',
    `accrual_status` STRING COMMENT 'Current lifecycle status of the accrual.. Valid values are `pending|approved|reversed|closed|cancelled`',
    `accrual_type` STRING COMMENT 'Category of the accrual indicating its nature (expense, revenue deferral, provision for returns, warranty reserve, bonus).. Valid values are `expense|revenue|provision|warranty|bonus`',
    `amount` DECIMAL(18,2) COMMENT 'Gross monetary amount of the accrual before adjustments.',
    `approval_status` STRING COMMENT 'Current approval state of the accrual.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the accrual was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the accrual record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the accrual amount.',
    `data_privacy_classification` STRING COMMENT 'Classification of the accrual data for privacy and security handling.. Valid values are `public|internal|confidential|restricted`',
    `effective_from` DATE COMMENT 'Start date when the accrual becomes effective.',
    `effective_until` DATE COMMENT 'End date when the accrual ceases to be effective (nullable).',
    `fiscal_period` STRING COMMENT 'Fiscal period (e.g., month) within the fiscal year.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the accrual belongs.',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates if GDPR privacy considerations apply to this accrual record.',
    `is_estimated` BOOLEAN COMMENT 'Indicates whether the accrual amount is an estimate.',
    `justification_narrative` STRING COMMENT 'Narrative explanation for why the accrual was created.',
    `net_accrual_amount` DECIMAL(18,2) COMMENT 'Net amount after tax and other adjustments.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the accrual.',
    `period_end` DATE COMMENT 'End date of the accounting period the accrual covers.',
    `period_start` DATE COMMENT 'Start date of the accounting period the accrual covers.',
    `reversal_date` DATE COMMENT 'Date on which the accrual was reversed, if applicable.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether the accrual has been reversed.',
    `sequence` STRING COMMENT 'Sequential number to order accruals within the same period.',
    `source_system` STRING COMMENT 'Originating system that created the accrual record.. Valid values are `sap|erp|oms|custom`',
    `sox_control_relevant` BOOLEAN COMMENT 'Flag indicating whether the accrual is subject to SOX internal control requirements.',
    `status_detail` STRING COMMENT 'Additional free‑text detail about the accruals current status.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the accrual (adjustment).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the accrual record.',
    CONSTRAINT pk_accrual PRIMARY KEY(`accrual_id`)
) COMMENT 'SSOT for financial accruals, provisions, and deferred items recorded during month-end and quarter-end close. Tracks accrual type (expense accrual, revenue deferral, provision for returns, warranty reserve, bonus accrual), accrual amount, reversal date, GL account, cost center, justification narrative, and approval status. Supports ASC 450 contingency provisions and IAS 37 compliance. Enables accurate period-end financial statements by recognizing obligations and income in the correct fiscal period regardless of cash timing.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`payment_batch` (
    `payment_batch_id` BIGINT COMMENT 'Primary key for payment_batch',
    `party_id` BIGINT COMMENT 'Identifier of the party (e.g., merchant or internal finance unit) associated with the batch.',
    `consolidated_from_payment_batch_id` BIGINT COMMENT 'Self-referencing FK on payment_batch (consolidated_from_payment_batch_id)',
    `approval_status` STRING COMMENT 'Approval outcome for the batch.',
    `batch_number` STRING COMMENT 'External business identifier assigned to the payment batch.',
    `batch_type` STRING COMMENT 'Classification of the payment batch purpose.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the batch amounts.',
    `payment_batch_description` STRING COMMENT 'Free-text description or notes about the payment batch.',
    `error_code` STRING COMMENT 'Code representing any processing error encountered for the batch.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment batch was initiated.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Aggregate fees or adjustments applied to the batch.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the batch was generated automatically by the system.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after fees, representing the amount to be settled.',
    `payment_channel` STRING COMMENT 'Channel through which the batch payments were submitted.',
    `payment_method` STRING COMMENT 'Payment instrument used for the batch transactions.',
    `processed_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch processing completed.',
    `retry_count` STRING COMMENT 'Number of retry attempts performed for failed batch processing.',
    `scheduled_date` DATE COMMENT 'Planned date for the batch processing.',
    `settlement_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch was settled with the financial institution.',
    `source_system` STRING COMMENT 'Name of the source system that originated the batch record.',
    `payment_batch_status` STRING COMMENT 'Current lifecycle status of the payment batch.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total gross monetary amount of all payments in the batch before adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the batch record.',
    CONSTRAINT pk_payment_batch PRIMARY KEY(`payment_batch_id`)
) COMMENT 'Master reference table for payment_batch. Referenced by payment_batch_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`fiscal_period` (
    `fiscal_period_id` BIGINT COMMENT 'Primary key for fiscal_period',
    `prior_fiscal_period_id` BIGINT COMMENT 'Self-referencing FK on fiscal_period (prior_fiscal_period_id)',
    `calendar_month` STRING COMMENT 'Numeric month (1‑12) of the periods start date in the Gregorian calendar.',
    `calendar_type` STRING COMMENT 'Indicates whether the period follows the standard Gregorian calendar or a custom fiscal calendar.',
    `calendar_year` STRING COMMENT 'Four‑digit calendar year of the periods start date.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fiscal period record was first created in the system.',
    `days_in_period` STRING COMMENT 'Total number of calendar days covered by the period.',
    `fiscal_period_description` STRING COMMENT 'Optional free‑text description providing context or notes about the period.',
    `fiscal_quarter` STRING COMMENT 'Quarter number (1‑4) within the fiscal year.',
    `fiscal_week` STRING COMMENT 'Week number within the fiscal year, useful for weekly reporting.',
    `fiscal_year` STRING COMMENT 'Four‑digit year to which the period belongs, based on the companys fiscal calendar.',
    `is_closed` BOOLEAN COMMENT 'True when all postings for the period are finalized and no further adjustments are allowed.',
    `is_current` BOOLEAN COMMENT 'True if this period is the active fiscal period for ongoing transactions.',
    `month_number` STRING COMMENT 'Numeric month (1‑12) of the periods start date.',
    `period_end_date` DATE COMMENT 'Last calendar date of the fiscal period.',
    `period_name` STRING COMMENT 'Human‑readable name of the fiscal period, e.g., "FY2024 Q1" or "2024‑01".',
    `period_sequence` STRING COMMENT 'Sequential order of the period within the fiscal year (e.g., 1 for Jan, 2 for Feb).',
    `period_start_date` DATE COMMENT 'First calendar date of the fiscal period.',
    `period_status` STRING COMMENT 'Current lifecycle status of the period for reporting and posting purposes.',
    `period_type` STRING COMMENT 'Category of the period indicating its granularity (month, quarter, year, etc.).',
    `quarter_number` STRING COMMENT 'Calendar quarter (1‑4) derived from the start date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fiscal period record.',
    CONSTRAINT pk_fiscal_period PRIMARY KEY(`fiscal_period_id`)
) COMMENT 'Master reference table for fiscal_period. Referenced by period_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`consolidation_group` (
    `consolidation_group_id` BIGINT COMMENT 'Primary key for consolidation_group',
    `parent_group_id` BIGINT COMMENT 'Identifier of the parent consolidation group for hierarchical grouping.',
    `parent_consolidation_group_id` BIGINT COMMENT 'Self-referencing FK on consolidation_group (parent_consolidation_group_id)',
    `consolidation_method` STRING COMMENT 'Method used to consolidate financial results for the group.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consolidation group record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code used for group financial reporting.',
    `consolidation_group_description` STRING COMMENT 'Free‑form description providing additional context about the group.',
    `effective_from` DATE COMMENT 'Date when the consolidation group becomes effective for reporting.',
    `effective_until` DATE COMMENT 'Date when the consolidation group ceases to be effective (null for open‑ended).',
    `fiscal_year_end_month` STRING COMMENT 'Numeric month (1‑12) when the groups fiscal year ends.',
    `fiscal_year_start_month` STRING COMMENT 'Numeric month (1‑12) when the groups fiscal year starts.',
    `group_code` STRING COMMENT 'Business identifier code used to reference the consolidation group in financial systems.',
    `group_name` STRING COMMENT 'Human‑readable name of the consolidation group.',
    `group_type` STRING COMMENT 'Classification of the group indicating its purpose or scope.',
    `is_external` BOOLEAN COMMENT 'Flag indicating whether the consolidation group includes external entities.',
    `legal_entity_count` STRING COMMENT 'Number of legal entities that belong to the consolidation group.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the group.',
    `reporting_frequency` STRING COMMENT 'How often the group reports consolidated financial results.',
    `consolidation_group_status` STRING COMMENT 'Current lifecycle status of the consolidation group.',
    `total_assets` DECIMAL(18,2) COMMENT 'Aggregated asset value for the consolidation group.',
    `total_liabilities` DECIMAL(18,2) COMMENT 'Aggregated liabilities amount for the consolidation group.',
    `total_revenue` DECIMAL(18,2) COMMENT 'Aggregated revenue amount for the consolidation group in the reporting currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consolidation group record.',
    CONSTRAINT pk_consolidation_group PRIMARY KEY(`consolidation_group_id`)
) COMMENT 'Master reference table for consolidation_group. Referenced by consolidation_group_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_payment_batch_id` FOREIGN KEY (`payment_batch_id`) REFERENCES `ecommerce_ecm`.`finance`.`payment_batch`(`payment_batch_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ecommerce_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ADD CONSTRAINT `fk_finance_gmv_reconciliation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ADD CONSTRAINT `fk_finance_gmv_reconciliation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ecommerce_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_receiving_entity_legal_entity_id` FOREIGN KEY (`receiving_entity_legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ADD CONSTRAINT `fk_finance_regulatory_filing_financial_period_close_id` FOREIGN KEY (`financial_period_close_id`) REFERENCES `ecommerce_ecm`.`finance`.`financial_period_close`(`financial_period_close_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ADD CONSTRAINT `fk_finance_regulatory_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ADD CONSTRAINT `fk_finance_regulatory_filing_original_filing_regulatory_filing_id` FOREIGN KEY (`original_filing_regulatory_filing_id`) REFERENCES `ecommerce_ecm`.`finance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ADD CONSTRAINT `fk_finance_finance_bank_account_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ADD CONSTRAINT `fk_finance_finance_bank_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ADD CONSTRAINT `fk_finance_bank_statement_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_consolidation_group_id` FOREIGN KEY (`consolidation_group_id`) REFERENCES `ecommerce_ecm`.`finance`.`consolidation_group`(`consolidation_group_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_entity_legal_entity_id` FOREIGN KEY (`parent_entity_legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_reversal_accrual_id` FOREIGN KEY (`reversal_accrual_id`) REFERENCES `ecommerce_ecm`.`finance`.`accrual`(`accrual_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_consolidated_from_payment_batch_id` FOREIGN KEY (`consolidated_from_payment_batch_id`) REFERENCES `ecommerce_ecm`.`finance`.`payment_batch`(`payment_batch_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_prior_fiscal_period_id` FOREIGN KEY (`prior_fiscal_period_id`) REFERENCES `ecommerce_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`consolidation_group` ADD CONSTRAINT `fk_finance_consolidation_group_parent_group_id` FOREIGN KEY (`parent_group_id`) REFERENCES `ecommerce_ecm`.`finance`.`consolidation_group`(`consolidation_group_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`consolidation_group` ADD CONSTRAINT `fk_finance_consolidation_group_parent_consolidation_group_id` FOREIGN KEY (`parent_consolidation_group_id`) REFERENCES `ecommerce_ecm`.`finance`.`consolidation_group`(`consolidation_group_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `ecommerce_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Identifier');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_balance_gc` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Balance in Group Currency');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_balance_gc` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_balance_lc` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Balance in Local Currency');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_balance_lc` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_category` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Category');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_description` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Description');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_effective_from` SET TAGS ('dbx_business_glossary_term' = 'Account Effective From Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_effective_until` SET TAGS ('dbx_business_glossary_term' = 'Account Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_long_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Long Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|marked_for_deletion');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_business_glossary_term' = 'Alternative General Ledger (GL) Account Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|none');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Account Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `field_status_group` SET TAGS ('dbx_business_glossary_term' = 'Field Status Group');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `field_status_group` SET TAGS ('dbx_value_regex' = '^G[0-9]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `financial_statement_section` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Section');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `financial_statement_section` SET TAGS ('dbx_value_regex' = 'balance_sheet|income_statement|cash_flow_statement|statement_of_equity');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]$');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Level');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `is_balance_sheet_relevant` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Relevant Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `is_posting_allowed` SET TAGS ('dbx_business_glossary_term' = 'Posting Allowed Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `is_reconciliation_account` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `last_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Last Posting Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `line_item_display` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `normal_balance` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance Side');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `normal_balance` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `open_item_management` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `parent_account_number` SET TAGS ('dbx_business_glossary_term' = 'Parent General Ledger (GL) Account Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `parent_account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `parent_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `parent_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `reconciliation_account_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `reconciliation_account_type` SET TAGS ('dbx_value_regex' = 'accounts_receivable|accounts_payable|fixed_assets|none');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Sort Key');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `sort_key` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `tolerance_group` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Group');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entry Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'original|reversal|accrual|depreciation|revaluation|intercompany');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `group_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `group_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `group_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `group_currency` SET TAGS ('dbx_business_glossary_term' = 'Group Currency');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `group_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `header_text` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Header Text');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `is_statistical` SET TAGS ('dbx_business_glossary_term' = 'Statistical Posting Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|parked|held|error');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_value_regex' = 'order|payment|invoice|purchase_order|return|shipment');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Document Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|OMS|PAYMENT_GATEWAY|WMS|MANUAL');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'A|D|K|M|S');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_group_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Group Currency');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_group_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_group_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `is_cleared` SET TAGS ('dbx_business_glossary_term' = 'Is Cleared Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_partner` SET TAGS ('dbx_business_glossary_term' = 'Partner Profit Center');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `source_ledger` SET TAGS ('dbx_business_glossary_term' = 'Source Ledger');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `source_ledger` SET TAGS ('dbx_value_regex' = '0L|1L|2L|3L');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `special_gl_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special General Ledger (GL) Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `special_gl_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]?$');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Company Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Type Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,10}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `actual_posting_allowed` SET TAGS ('dbx_business_glossary_term' = 'Actual Posting Allowed');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_allocation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `business_unit` SET TAGS ('dbx_value_regex' = 'marketplace|dtc|b2b|fulfillment|technology|corporate');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost/Profit Center Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `center_type` SET TAGS ('dbx_value_regex' = 'cost|profit|investment|revenue');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `commitment_posting_allowed` SET TAGS ('dbx_business_glossary_term' = 'Commitment Posting Allowed');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|assessment|distribution|activity_based');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|locked|pending_approval|archived');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,16}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `gdpr_relevant` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Relevant');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_node_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Hierarchy Node Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `internal_order_code` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `internal_order_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,12}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `mrr_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Monthly Recurring Revenue (MRR) Tracking Enabled');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `plan_posting_allowed` SET TAGS ('dbx_business_glossary_term' = 'Plan Posting Allowed');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `responsible_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,10}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'sap_s4hana|erp_legacy|manual|migration');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `sox_relevant` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Relevant');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,15}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,24}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|assessment|distribution|settlement');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `annual_cost_budget` SET TAGS ('dbx_business_glossary_term' = 'Annual Cost Budget');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `annual_cost_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `annual_revenue_budget` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Budget');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `annual_revenue_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `budget_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO) Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,10}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `data_privacy_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Classification');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `data_privacy_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Deactivation Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,15}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `erp_profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Profit Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `erp_profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `gmv_to_revenue_ratio` SET TAGS ('dbx_business_glossary_term' = 'Gross Merchandise Value (GMV) to Revenue Ratio');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `gmv_to_revenue_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Group Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Level');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `intercompany_trading_partner` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Trading Partner Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `intercompany_trading_partner` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `is_dummy` SET TAGS ('dbx_business_glossary_term' = 'Is Dummy Profit Center Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `is_statistical` SET TAGS ('dbx_business_glossary_term' = 'Is Statistical Profit Center Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `mrr_applicable` SET TAGS ('dbx_business_glossary_term' = 'Monthly Recurring Revenue (MRR) Applicable Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_category` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Category');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_category` SET TAGS ('dbx_value_regex' = 'revenue|cost|investment');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|locked|pending_activation|archived');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `responsible_manager` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|percentage_completion|milestone');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Business Segment Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Short Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9 _-]{1,20}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `sox_control_relevant` SET TAGS ('dbx_business_glossary_term' = 'SOX Control Relevant Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `take_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Take Rate Percentage');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `take_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `target_margin_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Margin Percentage');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `target_margin_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,15}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Record ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Aging Bucket');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `ap_status` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Approval Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `discount_due_date` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Due Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute Reason');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_value_regex' = 'price_discrepancy|quantity_mismatch|duplicate_invoice|missing_gr|quality_issue|unauthorized_charge');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Rate');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(0[1-9]|1[0-6])$');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|recurring|prepayment|intercompany');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Invoice Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_block_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_block_code` SET TAGS ('dbx_value_regex' = 'R|A|B|V|');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire|check|virtual_card|EFT|SEPA');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Document Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|partial_match|unmatched|exception|not_applicable');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `vendor_invoice_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Receipt Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'supplier|3pl_carrier|marketplace_seller|saas_vendor|intercompany|utility');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Record ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Agent ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'AR Aging Bucket');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|91_120_days|over_120_days');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `amount_paid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `amount_paid` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `ar_status` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `ar_status` SET TAGS ('dbx_value_regex' = 'open|partially_paid|paid|overdue|disputed|written_off');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `ar_type` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `ar_type` SET TAGS ('dbx_value_regex' = 'customer_invoice|seller_fee|advertising_revenue|subscription_billing|credit_memo');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `billing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Document Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `cash_application_date` SET TAGS ('dbx_business_glossary_term' = 'Cash Application Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `credit_memo_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `credit_memo_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `credit_memo_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due (DPD)');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_value_regex' = 'pricing_error|duplicate_invoice|goods_not_received|quality_issue|unauthorized_charge|other');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'no_dispute|under_review|escalated|resolved|rejected');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dunning_block` SET TAGS ('dbx_business_glossary_term' = 'Dunning Block Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'AR Invoice Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{4}-[0-9]{8}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `open_amount` SET TAGS ('dbx_business_glossary_term' = 'Open (Outstanding) AR Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `open_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `open_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_block` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|credit_card|direct_debit|check|platform_credit|marketplace_settlement');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `promised_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Payment Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|OMS|MARKETPLACE_PORTAL|SUBSCRIPTION_PLATFORM|ADVERTISING_PLATFORM');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_value_regex' = 'bad_debt|bankruptcy|settlement|statute_of_limitations|other');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `approved_by_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `relevance_config_id` SET TAGS ('dbx_business_glossary_term' = 'Relevance Config Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `actuals_amount` SET TAGS ('dbx_business_glossary_term' = 'Actuals Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `actuals_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `availability_control_active` SET TAGS ('dbx_business_glossary_term' = 'Budget Availability Control Active Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_value_regex' = '^BDG-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'operating|capital|headcount|project|contingency|rolling_forecast');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Commitment Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `commitment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `encumbrance_amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `encumbrance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Expense Category');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast Budget Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Budget Locked Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `last_revised_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revised Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `original_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `revision_count` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Count');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `sap_budget_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Budget ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|PLANNING_TOOL|MANUAL|SPREADSHEET_IMPORT');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Submission Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Budget Tolerance Percentage');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `variance_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|final|supplemental');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `approved_by_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `relevance_config_id` SET TAGS ('dbx_business_glossary_term' = 'Relevance Config Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Method');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|proportional|top_down|bottom_up|zero_based');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'capex|opex|headcount|marketing|technology|logistics');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_number` SET TAGS ('dbx_value_regex' = '^BL-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|closed|cancelled');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'expense|revenue|headcount|investment');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_version` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|supplemental');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `encumbrance_amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `encumbrance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `is_carry_forward` SET TAGS ('dbx_business_glossary_term' = 'Budget Carry Forward Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Locked Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `justification_notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Justification Notes');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `last_revised_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revised Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `prior_year_actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Actual Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `prior_year_actual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|MANUAL|BUDGET_TOOL|EXCEL_UPLOAD');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `allocated_transaction_price` SET TAGS ('dbx_business_glossary_term' = 'Allocated Transaction Price');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `allocated_transaction_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `allocated_transaction_price` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Commission Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `commission_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Commission Rate');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `constraint_applied` SET TAGS ('dbx_business_glossary_term' = 'Variable Consideration Constraint Applied');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `contract_modification_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Modification Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `deferred_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `deferred_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `deferred_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|[0-9]{2})$');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `gmv_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Merchandise Value (GMV) Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `gmv_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `gmv_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `journal_entry_reference` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Reference');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `journal_entry_reference` SET TAGS ('dbx_value_regex' = '^JE-[0-9]{12}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `net_recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Recognized Revenue Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `net_recognized_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `net_recognized_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Notes');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `percentage_complete` SET TAGS ('dbx_business_glossary_term' = 'Percentage of Completion');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `performance_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Description');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `principal_agent_indicator` SET TAGS ('dbx_business_glossary_term' = 'Principal vs Agent Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `principal_agent_indicator` SET TAGS ('dbx_value_regex' = 'principal|agent');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `promotional_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Discount Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `promotional_discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `promotional_discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_event_number` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_event_number` SET TAGS ('dbx_value_regex' = '^RR-[0-9]{10}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'output_method|input_method|straight_line|usage_based|milestone_based');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Period End Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Period Start Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_status` SET TAGS ('dbx_value_regex' = 'pending|recognized|deferred|partially_recognized|reversed|cancelled');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_trigger` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Trigger');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_trigger` SET TAGS ('dbx_value_regex' = 'delivery_confirmed|subscription_period_elapsed|milestone_achieved|customer_acceptance|refund_period_expired|manual_override');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_type` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Revenue Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `refund_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Adjustment Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `refund_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `refund_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_category` SET TAGS ('dbx_value_regex' = 'product_sale|marketplace_commission|subscription|advertising|fulfillment_fee|other');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'OMS|SAP_S4HANA|PAYMENT_GATEWAY|SELLER_PORTAL|SUBSCRIPTION_PLATFORM');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction Reference');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `standalone_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Standalone Selling Price (SSP)');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `standalone_selling_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `standalone_selling_price` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `subscription_mrr_amount` SET TAGS ('dbx_business_glossary_term' = 'Subscription Monthly Recurring Revenue (MRR) Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `subscription_mrr_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `subscription_mrr_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `transaction_price` SET TAGS ('dbx_business_glossary_term' = 'Transaction Price');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `transaction_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `transaction_price` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `variable_consideration_estimate` SET TAGS ('dbx_business_glossary_term' = 'Variable Consideration Estimate');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `variable_consideration_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `variable_consideration_estimate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` SET TAGS ('dbx_subdomain' = 'cash_management');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `gmv_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Gmv Reconciliation Identifier');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `gmv_daily_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Gross Merchandise Value (GMV) Reconciliation ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `indexed_document_id` SET TAGS ('dbx_business_glossary_term' = 'Indexed Document Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (Finance Controller)');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `attestation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Attestation Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `attested_by` SET TAGS ('dbx_business_glossary_term' = 'Attested By (Controller Name)');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `cancelled_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Order Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `cancelled_order_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|bopis|api|edl');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `gross_gmv_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Merchandise Value (GMV) Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `gross_gmv_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `is_sox_attested` SET TAGS ('dbx_business_glossary_term' = 'SOX Attestation Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `journal_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `logistics_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Logistics Cost Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `logistics_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `marketplace_segment` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Segment');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `marketplace_segment` SET TAGS ('dbx_value_regex' = 'b2c|b2b|c2c|dtc');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `materiality_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Materiality Threshold Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `materiality_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `net_gmv_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Gross Merchandise Value (GMV) Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `net_gmv_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `order_count` SET TAGS ('dbx_business_glossary_term' = 'Order Count');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `payment_processing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Processing Fee Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `payment_processing_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `platform_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `platform_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `promotional_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Discount Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `promotional_discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `recognized_net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Net Revenue Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `recognized_net_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `recognized_net_revenue_reporting_ccy` SET TAGS ('dbx_business_glossary_term' = 'Recognized Net Revenue in Reporting Currency');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `recognized_net_revenue_reporting_ccy` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `reconciliation_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Reference Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `reconciliation_reference_number` SET TAGS ('dbx_value_regex' = '^REC-[0-9]{4}-[0-9]{2}-[0-9]{8}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|posted|disputed|closed');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|ad_hoc');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `return_order_count` SET TAGS ('dbx_business_glossary_term' = 'Return Order Count');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `returns_refunds_amount` SET TAGS ('dbx_business_glossary_term' = 'Returns and Refunds (RMA) Deduction Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `returns_refunds_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|milestone_based');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `seller_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Seller Commission Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `seller_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|OMS|PAYMENT_GATEWAY|SELLER_PORTAL|MANUAL');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `tax_collected_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Collected Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `tax_collected_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `tax_remitted_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Remitted Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `tax_remitted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Variance Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `variance_explanation` SET TAGS ('dbx_business_glossary_term' = 'Variance Explanation');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `voucher_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Voucher and Coupon Discount Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ALTER COLUMN `voucher_discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` SET TAGS ('dbx_subdomain' = 'cash_management');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `seller_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Disbursement Identifier');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `seller_performance_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Disbursement ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `actual_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Disbursement Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Adjustment Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Approval Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected|auto_approved');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (Employee ID or Username)');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Approved Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `bank_account_last4` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Last 4 Digits');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `bank_account_last4` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `bank_account_last4` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `bank_account_last4` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `bank_routing_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `bank_routing_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `commission_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Deduction Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `commission_deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `commission_deduction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `disbursement_reference` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Reference Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `disbursement_reference` SET TAGS ('dbx_value_regex' = '^DISB-[A-Z0-9]{8,20}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_value_regex' = 'pending|processing|completed|failed|reversed|on_hold');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_value_regex' = 'standard|accelerated|manual|adjustment|reversal|advance');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Failure Reason');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `fee_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Deduction Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `fee_deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `fee_deduction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `fx_conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Conversion Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `fx_conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Conversion Rate');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `gmv_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Merchandise Value (GMV) Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `gmv_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `gmv_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `gross_disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Disbursement Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `gross_disbursement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `gross_disbursement_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Initiated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `marketplace_region` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Region Country Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `marketplace_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Disbursement Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `net_payout_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payout Amount (Payout Currency)');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `net_payout_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `net_payout_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Notes');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `on_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Disbursement On-Hold Reason');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `order_count` SET TAGS ('dbx_business_glossary_term' = 'Settled Order Count');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Payment Method');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|payoneer|paypal|check|wire_transfer|virtual_account');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `payout_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payout Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `payout_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `refund_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Deduction Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `refund_deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `refund_deduction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `remittance_advice_sent` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `remittance_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `reversal_reference` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Reversal Reference');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `scheduled_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Disbursement Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `seller_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Seller Entity Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `seller_entity_type` SET TAGS ('dbx_value_regex' = 'individual|business|enterprise|non_profit');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `settlement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `settlement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `tax_form_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Form Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Transaction Reference');
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Record ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Due Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `exemption_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `exemption_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'pending|filed|accepted|rejected|amended|voided');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `is_marketplace_facilitator` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Facilitator Tax Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `is_tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Notes');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `remittance_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Remittance Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|OMS|PAYMENT_GATEWAY|MARKETPLACE|MANUAL');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount in Local Currency');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_amount_local_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_amount_local_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_document_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Document Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tax Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_jurisdiction_level` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Level');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_jurisdiction_level` SET TAGS ('dbx_value_regex' = 'country|state|county|city|district');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Period End Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Period Start Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_value_regex' = 'standard|reduced|zero_rated|exempt|reverse_charge|out_of_scope');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'VAT|GST|sales_tax|withholding_tax|customs_duty|excise_tax');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `taxable_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `taxable_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `taxable_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Transaction Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'sale|refund|adjustment|withholding|import|export');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `financial_period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Close ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Close Approver Employee ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `primary_financial_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Close Owner Employee ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `accruals_posted` SET TAGS ('dbx_business_glossary_term' = 'Accruals Posted Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Close Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Close Approver Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `bank_reconciliation_complete` SET TAGS ('dbx_business_glossary_term' = 'Bank Reconciliation Complete Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Close Completed Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Close Cycle Duration Days');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Close Initiated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_notes` SET TAGS ('dbx_business_glossary_term' = 'Period Close Notes');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Close Owner Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Close Reference Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_reference_number` SET TAGS ('dbx_value_regex' = '^FPC-[0-9]{4}-[0-9]{2}-[A-Z]{1,3}-[0-9]{4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Close Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_approval|closed|reopened');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Close Variance Days');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `completed_tasks` SET TAGS ('dbx_business_glossary_term' = 'Completed Close Tasks Count');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `depreciation_run_complete` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Complete Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `external_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Period Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `gl_period_locked` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Period Locked Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `gl_posting_cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Cutoff Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `gmv_to_revenue_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Gross Merchandise Value (GMV) to Revenue Reconciliation Complete Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `intercompany_eliminations_complete` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Eliminations Complete Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `open_blocking_items` SET TAGS ('dbx_business_glossary_term' = 'Open Blocking Items Count');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Period End Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Start Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|special');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `reopen_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Period Reopen Authorized By');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `reopen_reason` SET TAGS ('dbx_business_glossary_term' = 'Period Reopen Reason');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Standard');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_value_regex' = 'GAAP|IFRS|GAAP_IFRS_DUAL');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `revenue_recognition_complete` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Complete Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `sox_attestation_status` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Attestation Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `sox_attestation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|attested|exceptions_noted');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `target_close_date` SET TAGS ('dbx_business_glossary_term' = 'Target Close Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `tax_provision_complete` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Complete Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ALTER COLUMN `total_close_tasks` SET TAGS ('dbx_business_glossary_term' = 'Total Close Tasks Count');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Legal Entity ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Legal Entity ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Agreement Reference');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Approval Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Basis');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_allocation_basis` SET TAGS ('dbx_value_regex' = 'headcount|revenue|usage|fixed|square_footage|transaction_volume');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Elimination Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Elimination Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_value_regex' = 'pending|eliminated|partially_eliminated|not_required');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Rate');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `loan_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Loan Interest Rate');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `loan_interest_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `loan_maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Loan Maturity Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `matched_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Matched Counterparty Transaction Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `matched_transaction_number` SET TAGS ('dbx_value_regex' = '^ICT-[0-9]{4}-[0-9]{8}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `matching_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Matching Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `matching_status` SET TAGS ('dbx_value_regex' = 'unmatched|matched|partially_matched|disputed');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `materiality_threshold_breached` SET TAGS ('dbx_business_glossary_term' = 'Materiality Threshold Breached Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'GL Posting Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversed_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Transaction Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversed_transaction_number` SET TAGS ('dbx_value_regex' = '^ICT-[0-9]{4}-[0-9]{8}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|ERP|MANUAL|CONSOLIDATION_TOOL');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX Internal Control Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^ICT-[0-9]{4}-[0-9]{8}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'draft|posted|matched|disputed|eliminated|reversed');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'billing|cost_allocation|loan|transfer_pricing|dividend|royalty');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_price_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_price_method` SET TAGS ('dbx_value_regex' = 'CUP|RPM|CPM|TNMM|PSM|not_applicable');
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_value_regex' = 'tangible|intangible|right_of_use|leasehold_improvement|construction_in_progress');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_location_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_location_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|under_construction|disposed|retired|transferred|impaired');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalized_by` SET TAGS ('dbx_business_glossary_term' = 'Capitalized By');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|double_declining_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insured_value` SET TAGS ('dbx_business_glossary_term' = 'Insured Value');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insured_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_physical_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Verification Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease End Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lease Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `remaining_useful_life_months` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Months)');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_months` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Months)');
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `financial_period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Close Task ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `original_filing_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Original Filing ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `reviewer_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `confirmation_reference` SET TAGS ('dbx_business_glossary_term' = 'Submission Confirmation Reference');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `external_auditor_ref` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Reference');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `filing_description` SET TAGS ('dbx_business_glossary_term' = 'Filing Description');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Method');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|edi|api|portal');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,50}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `filing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `filing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|submitted|accepted|rejected|overdue');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `filing_version` SET TAGS ('dbx_business_glossary_term' = 'Filing Version');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `is_amended` SET TAGS ('dbx_business_glossary_term' = 'Is Amended Filing');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Filing Notes');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `open_items_count` SET TAGS ('dbx_business_glossary_term' = 'Open Items Count');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `period_lock_status` SET TAGS ('dbx_business_glossary_term' = 'Period Lock Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `period_lock_status` SET TAGS ('dbx_value_regex' = 'open|soft_locked|hard_locked|closed');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `reported_amount` SET TAGS ('dbx_business_glossary_term' = 'Reported Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `reported_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'sap_s4hana|oms|erp|manual|tax_engine|grc_platform');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `sox_control_ref` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Internal Control Reference');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` SET TAGS ('dbx_subdomain' = 'cash_management');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'SAP House Bank Account ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Masked Bank Account Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_value_regex' = '^[X*]{1,12}[0-9]{4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `account_purpose` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Purpose');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|frozen|closed|pending_activation');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'operating|payroll|escrow|concentration|disbursement|collection');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Address');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Bank Relationship Contact Email');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Relationship Contact Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Country Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `book_balance` SET TAGS ('dbx_business_glossary_term' = 'Book Balance');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `book_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closing Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Account Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Bank Balance');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `dual_control_required` SET TAGS ('dbx_business_glossary_term' = 'Dual Control Required Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `house_bank_code` SET TAGS ('dbx_business_glossary_term' = 'SAP House Bank ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `house_bank_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Account Interest Rate');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `is_pooling_header` SET TAGS ('dbx_business_glossary_term' = 'Cash Pooling Header Account Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `last_reconciled_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciled Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Bank Statement Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opening Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `payment_limit` SET TAGS ('dbx_business_glossary_term' = 'Single Payment Authorization Limit');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `payment_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `payment_method_codes` SET TAGS ('dbx_business_glossary_term' = 'Allowed Payment Method Codes');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Reconciliation Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|unreconciled|in_progress|exception');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number (ABA)');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `signatory_names` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Names');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `signatory_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|MANUAL|BANK_PORTAL');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `statement_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Delivery Method');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `statement_delivery_method` SET TAGS ('dbx_value_regex' = 'swift|sftp|api|email|manual');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `statement_format` SET TAGS ('dbx_business_glossary_term' = 'Electronic Bank Statement Format');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `statement_format` SET TAGS ('dbx_value_regex' = 'MT940|CAMT053|BAI2|OFX|CSV');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `swift_bic` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Bank Identifier Code (BIC)');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `swift_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `swift_bic` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `swift_bic` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `target_balance` SET TAGS ('dbx_business_glossary_term' = 'Target Balance');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `target_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` SET TAGS ('dbx_subdomain' = 'cash_management');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'current|savings|escrow|payroll|concentration|zero_balance');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `auto_reconciled_count` SET TAGS ('dbx_business_glossary_term' = 'Auto-Reconciled Transaction Count');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_bic_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_bic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Country Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Reference Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Exception Count');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `iban` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `import_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Statement Import Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Is Intercompany Account Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Is Locked Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Statement Notes');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period End Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period Start Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `reconciled_by` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By User');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Completion Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|in_progress|reconciled|exception|posted|cancelled');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|SWIFT|BANK_DIRECT|EDI|API|MANUAL');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `statement_format` SET TAGS ('dbx_business_glossary_term' = 'Statement Format');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `statement_format` SET TAGS ('dbx_value_regex' = 'MT940|MT942|camt.053|camt.052|BAI2|OFX|CSV');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Statement Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|intraday|final|interim');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `total_credits` SET TAGS ('dbx_business_glossary_term' = 'Total Credits');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `total_debits` SET TAGS ('dbx_business_glossary_term' = 'Total Debits');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `ecommerce_ecm`.`finance`.`bank_statement` ALTER COLUMN `unreconciled_amount` SET TAGS ('dbx_business_glossary_term' = 'Unreconciled Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Legal Entity ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'IFRS|US_GAAP|local_gaap');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `business_activity_description` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Activity Description');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_value_regex' = 'full_consolidation|proportional|equity_method|not_consolidated');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Controlling Area Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|dormant|dissolved|in_liquidation|pending');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'holding_company|operating_company|subsidiary|joint_venture|branch|partnership');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `functional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `gmv_to_revenue_ratio` SET TAGS ('dbx_business_glossary_term' = 'Gross Merchandise Value (GMV) to Revenue Ratio');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `gmv_to_revenue_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `incorporation_country_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Incorporation (ISO 3166-1 Alpha-3)');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `incorporation_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Incorporation');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `industry_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Code (NAICS/SIC)');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `intercompany_trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Trading Partner Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction of Incorporation');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_form` SET TAGS ('dbx_business_glossary_term' = 'Legal Form');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{18}[0-9]{2}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `operating_country_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Operating Country (ISO 3166-1 Alpha-3)');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `operating_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `ownership_pct` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `ownership_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `pci_dss_applicable` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Industry Data Security Standard (PCI DSS) Applicable Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_city` SET TAGS ('dbx_business_glossary_term' = 'Registered Address City');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_country_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Country (ISO 3166-1 Alpha-3)');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Postal Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Company Registration Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `revenue_recognition_standard` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Standard');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `revenue_recognition_standard` SET TAGS ('dbx_value_regex' = 'IFRS_15|ASC_606|local_gaap');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Short Name');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `sox_in_scope` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) In-Scope Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `voting_rights_pct` SET TAGS ('dbx_business_glossary_term' = 'Voting Rights Percentage');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `voting_rights_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Related Order ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Related Contract ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Related Invoice ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `reversal_accrual_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'manual|automated|system_generated');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_number` SET TAGS ('dbx_business_glossary_term' = 'Accrual Number');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_value_regex' = 'pending|approved|reversed|closed|cancelled');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_business_glossary_term' = 'Accrual Type');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_value_regex' = 'expense|revenue|provision|warranty|bonus');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `data_privacy_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Classification');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `data_privacy_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'GDPR Applicable');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated Flag');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `justification_narrative` SET TAGS ('dbx_business_glossary_term' = 'Justification Narrative');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `net_accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Accrual Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period End Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period Start Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Accrual Sequence');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'sap|erp|oms|custom');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `sox_control_relevant` SET TAGS ('dbx_business_glossary_term' = 'SOX Control Relevant');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `status_detail` SET TAGS ('dbx_business_glossary_term' = 'Accrual Status Detail');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`finance`.`payment_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`payment_batch` SET TAGS ('dbx_subdomain' = 'cash_management');
ALTER TABLE `ecommerce_ecm`.`finance`.`payment_batch` ALTER COLUMN `payment_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Identifier');
ALTER TABLE `ecommerce_ecm`.`finance`.`payment_batch` ALTER COLUMN `consolidated_from_payment_batch_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `ecommerce_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Identifier');
ALTER TABLE `ecommerce_ecm`.`finance`.`fiscal_period` ALTER COLUMN `prior_fiscal_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`consolidation_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`consolidation_group` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`consolidation_group` ALTER COLUMN `consolidation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Identifier');
ALTER TABLE `ecommerce_ecm`.`finance`.`consolidation_group` ALTER COLUMN `parent_consolidation_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`consolidation_group` ALTER COLUMN `total_assets` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`consolidation_group` ALTER COLUMN `total_liabilities` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`consolidation_group` ALTER COLUMN `total_revenue` SET TAGS ('dbx_confidential' = 'true');
