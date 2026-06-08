-- Schema for Domain: finance | Business: Ecommerce | Version: v1_mvm
-- Generated on: 2026-05-05 00:58:24

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`finance` COMMENT 'SSOT for enterprise financial records and reporting. Owns general ledger, accounts payable, accounts receivable, cost center management, budget tracking, GMV-to-revenue reconciliation, and regulatory financial reporting. Integrates with SAP S/4HANA for financial consolidation. Ensures SOX compliance for financial controls and audit trails. Tracks MRR, ARR, and revenue recognition.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`general_ledger` (
    `general_ledger_id` BIGINT COMMENT 'Primary key for general_ledger',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: GL accounts belong to a specific legal entitys chart of accounts. general_ledger.company_code is a denormalized code; adding legal_entity_id provides a proper FK to the legal_entity master, enabling ',
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
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Journal entries are generated from AP invoice postings and payment events. Linking journal_entry to accounts_payable enables AP-to-GL drill-through for three-way match reconciliation and audit trails.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Journal entries are generated from AR invoice postings, cash application, and write-off events. Linking journal_entry to accounts_receivable enables AR-to-GL drill-through for subledger reconciliation',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for the expenditure or revenue captured in this journal entry. Enables cost allocation, departmental P&L reporting, and budget variance analysis.',
    `finance_bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.finance_bank_account. Business justification: Bank-related journal entries (bank receipts, payments, reconciliation postings) reference specific bank accounts. Linking journal_entry to finance_bank_account enables bank-to-GL reconciliation and tr',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Journal entries are posted within a specific legal entitys books. journal_entry.company_code is a denormalized code; adding legal_entity_id provides a proper FK to the legal_entity master for entity-',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Journal entries for COGS, revenue, and line-level tax are posted at the order line level. Finance teams need drill-down from GL journal entries to source order lines for transaction-level audit, COGS ',
    `general_ledger_id` BIGINT COMMENT 'Reference to the General Ledger (GL) account to which this journal entry header is primarily associated. The GL account determines the financial statement line item and chart of accounts classification.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center associated with this journal entry. Supports segment-level profitability reporting, GMV-to-revenue reconciliation, and management accounting.',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to payment.settlement. Business justification: Journal entries for settlement cash postings reference the settlement batch. Finance GL posting process for cash receipts from payment settlements requires tracing journal entries back to the settleme',
    `supplier_id` BIGINT COMMENT 'Reference to the intercompany trading partner entity involved in this journal entry. Required for intercompany elimination during financial consolidation and statutory group reporting.',
    `tax_record_id` BIGINT COMMENT 'Foreign key linking to finance.tax_record. Business justification: Journal entries are generated from tax posting events (tax accruals, remittances, adjustments). Linking journal_entry to tax_record enables tax-to-GL reconciliation and SOX-compliant audit trails for ',
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
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Each journal entry line posts to a specific GL account — this is the fundamental double-entry accounting relationship. The existing gl_account_id FK points to customer.account (cross-domain, semantica',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header that this line item belongs to. Establishes the header-detail relationship for the posting document. Satisfies TRANSACTION_LINE HEADER_REFERENCE category.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Journal entry lines belong to a specific legal entitys books. journal_entry_line.company_code is a denormalized code; adding legal_entity_id provides a proper FK to the legal_entity master for entity',
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
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Cost centers are associated with specific GL accounts for cost allocation and reporting. cost_center.gl_account_code is a denormalized string; adding general_ledger_id provides a proper FK to the GL a',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Cost centers belong to a specific legal entity within the corporate group. cost_center.company_code is a denormalized code; adding legal_entity_id provides a proper FK to the legal_entity master for e',
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
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Profit centers are associated with specific GL accounts for revenue and cost tracking. profit_center.gl_account_code is a denormalized string; adding general_ledger_id provides a proper FK to the GL a',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Profit centers represent autonomous business segments within a legal entity. profit_center.company_code is a denormalized code; adding legal_entity_id provides a proper FK to the legal_entity master f',
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
    `finance_bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.finance_bank_account. Business justification: AP payments are disbursed from specific corporate bank accounts. Linking accounts_payable to finance_bank_account enables payment-to-bank reconciliation, cash flow forecasting, and treasury management',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: AP invoices and payments post to GL accounts. accounts_payable.general_ledger_id links each AP record to its controlling GL account in the chart of accounts, enabling AP subledger-to-GL reconciliation',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: AP obligations belong to a specific legal entity within the corporate group. accounts_payable.company_code is a denormalized code; adding legal_entity_id provides a proper FK to the legal_entity maste',
    `purchase_order_id` BIGINT COMMENT 'Reference to the originating purchase order that generated this payable obligation. Used for three-way match (PO, goods receipt, invoice) validation and PO settlement tracking.',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to payment.settlement. Business justification: Seller/merchant payouts processed through AP reference the settlement batch being paid out. Three-way matching and AP payment processing for marketplace seller disbursements require linking AP invoice',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier master record associated with this payable obligation. Links to the vendor/supplier master entity for counterparty resolution.',
    `supplier_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_invoice. Business justification: Three-way match (PO→GR→Invoice) is the core AP process. AP records originate from supplier invoices; this FK enables invoice verification, dispute resolution, and audit trail reporting. Every e-commer',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_contract. Business justification: AP invoices are processed against governing vendor contracts for contract compliance monitoring, spend-against-contract reporting, and payment terms validation. E-commerce finance teams link payables ',
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
    `gross_amount` DECIMAL(18,2) COMMENT 'The total gross amount of the vendor invoice before any deductions, discounts, or adjustments. Represents the full obligation as stated on the vendor invoice. Used for GMV-to-revenue reconciliation and AP aging analysis.',
    `invoice_date` DATE COMMENT 'The date printed on the vendor invoice document. Serves as the principal business event date for the payable obligation and is the baseline for payment term calculations and aging bucket assignment.',
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
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: B2B e-commerce credit management requires AR records linked to the customer account for credit limit enforcement, outstanding balance reconciliation, and account-level dunning. customer.account carrie',
    `agent_id` BIGINT COMMENT 'Reference to the internal collections agent or team assigned to manage the recovery of this overdue AR balance. Used for workload distribution, collector performance reporting, and escalation tracking in the collections workflow.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AR invoices are attributed to cost centers for internal profitability reporting. accounts_receivable.cost_center_code is a denormalized string; adding cost_center_id provides a proper FK to the cost_c',
    `customer_profile_id` BIGINT COMMENT 'Foreign key linking to customer.customer_profile. Business justification: AR aging reports, dunning workflows, and collections management require direct customer identity on each receivable. E-commerce finance teams run customer-level credit exposure reports and collections',
    `finance_bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.finance_bank_account. Business justification: AR receipts and cash applications are deposited to specific corporate bank accounts. Linking accounts_receivable to finance_bank_account enables receipt-to-bank reconciliation and cash flow management',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: AR invoices post to GL accounts (AR subledger reconciles to GL). accounts_receivable.gl_account_code is a denormalized string; adding general_ledger_id provides a proper FK to the GL account master fo',
    `header_id` BIGINT COMMENT 'Reference to the originating order that generated this AR invoice. Links the receivable to the Order Management System (OMS) for order-to-cash reconciliation and GMV-to-revenue tracing.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: AR balances belong to a specific legal entity. accounts_receivable.company_code is a denormalized code; adding legal_entity_id provides a proper FK to the legal_entity master for entity-level AR repor',
    `aging_bucket` STRING COMMENT 'Aging classification of the outstanding AR balance based on days past due. Used in AR aging reports for credit risk assessment, bad debt provisioning, and executive financial reporting. Recalculated daily based on due_date vs. current date.. Valid values are `current|1_30_days|31_60_days|61_90_days|91_120_days|over_120_days`',
    `amount_paid` DECIMAL(18,2) COMMENT 'Cumulative amount of payments applied to this AR invoice to date. Supports partial payment tracking and open_amount calculation. Updated each time a payment is matched via cash application.',
    `ar_status` STRING COMMENT 'Current lifecycle state of the AR record within the collection and settlement workflow. Drives dunning automation, aging bucket classification, and cash application processes in SAP FI-AR. Transitions: open → partially_paid → paid; open → overdue → written_off; open → disputed.. Valid values are `open|partially_paid|paid|overdue|disputed|written_off`',
    `ar_type` STRING COMMENT 'Classification of the AR record by the nature of the receivable. Distinguishes B2B customer invoicing, marketplace seller fee receivables, advertising revenue receivables, and subscription billing per the product scope. Drives subledger routing and revenue recognition treatment.. Valid values are `customer_invoice|seller_fee|advertising_revenue|subscription_billing|credit_memo`',
    `billing_document_number` STRING COMMENT 'The source billing document number from the Order Management System or SAP SD (Sales and Distribution) that triggered the creation of this AR invoice. Enables order-to-cash traceability and billing dispute resolution.',
    `cash_application_date` DATE COMMENT 'The date on which incoming payment was matched and applied to this AR invoice in the cash application process. Null if no payment has been applied. Used for DSO calculation, bank reconciliation, and revenue recognition confirmation.',
    `company_code` STRING COMMENT 'The SAP company code representing the legal entity under which this AR invoice is posted. Required for multi-entity financial consolidation, intercompany elimination, and statutory reporting. Corresponds to SAP BUKRS field.. Valid values are `^[A-Z0-9]{4}$`',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` (
    `revenue_recognition_id` BIGINT COMMENT 'Unique surrogate identifier for each revenue recognition event or schedule record in the enterprise financial system. Primary key for this table.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Revenue recognition events are triggered by AR invoice activity (e.g., invoice issuance, payment receipt). Linking revenue_recognition to accounts_receivable enables GMV-to-revenue reconciliation and ',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to seller.seller_agreement. Business justification: Under ASC 606/IFRS 15, revenue recognition is triggered by performance obligations defined in seller agreements. Finance teams require contract-level revenue recognition reporting and external audit t',
    `commission_id` BIGINT COMMENT 'Foreign key linking to seller.commission. Business justification: Revenue recognition records contain denormalized commission_amount and commission_rate from seller.commission. ASC 606/IFRS 15 revenue recognition requires tracing recognized amounts to the commission',
    `header_id` BIGINT COMMENT 'Reference to the originating order that generated this revenue recognition event. Links to the Order Management System (OMS) order record.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Revenue recognition events generate journal entries per ASC 606/IFRS 15. revenue_recognition.journal_entry_reference is a denormalized string reference; replacing it with journal_entry_id provides a p',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: ASC 606 requires revenue recognition at the performance obligation level — each order line is a distinct obligation. The existing revenue_recognition.header_id covers order-level; line-level FK is nee',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: ASC 606/IFRS 15 revenue recognition is triggered by payment receipt for cash-basis recognition methods. Revenue recognition records must reference the payment transaction that triggered the recognitio',
    `seller_profile_id` BIGINT COMMENT 'Reference to the marketplace seller whose transaction generated this revenue recognition event. Relevant for marketplace commission recognition. Sourced from the Seller Management Portal.',
    `allocated_transaction_price` DECIMAL(18,2) COMMENT 'The portion of the total contract transaction price allocated to this specific performance obligation, based on relative standalone selling prices per ASC 606 Step 4. May differ from transaction_price when a contract has multiple performance obligations.',
    `approved_by` STRING COMMENT 'The employee ID or username of the finance controller or manager who approved this revenue recognition event. Required for SOX compliance and audit trail. Populated for manual overrides and high-value recognition events.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this revenue recognition event was approved by the authorized finance controller. Part of the SOX-compliant audit trail for financial controls.',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`tax_record` (
    `tax_record_id` BIGINT COMMENT 'Unique surrogate identifier for each tax record entry in the enterprise financial system. Primary key for the tax_record data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tax records are attributed to cost centers for internal cost allocation and reporting. tax_record.cost_center_code is a denormalized string; adding cost_center_id provides a proper FK to the cost_cent',
    `customer_profile_id` BIGINT COMMENT 'Foreign key linking to customer.customer_profile. Business justification: Sales tax nexus reporting, customer tax exemption certificate management, and marketplace facilitator compliance (is_marketplace_facilitator flag on tax_record) require linking tax records to the cust',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Tax obligations post to specific GL accounts. tax_record.gl_account_code is a denormalized string; adding general_ledger_id provides a proper FK to the GL account master. gl_account_code is removed as',
    `header_id` BIGINT COMMENT 'Reference to the e-commerce order associated with this tax record. Enables reconciliation of tax obligations back to the originating Order Management System (OMS) order.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Tax obligations are filed by specific legal entities. tax_record.company_code is a denormalized code; adding legal_entity_id provides a proper FK to the legal_entity master for entity-level tax report',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Tax records must be traceable to specific order lines for itemized tax audit, multi-jurisdiction compliance, and line-level tax exemption verification. The existing tax_record.header_id covers order-l',
    `payment_transaction_id` BIGINT COMMENT 'Reference to the originating financial transaction (order, invoice, payment, or settlement) that generated this tax obligation. Links tax record to its source transaction.',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to payment.settlement. Business justification: Marketplace facilitator tax remittances are funded from and tied to settlement batches. Tax compliance reporting requires linking tax records to the settlement from which tax was withheld and remitted',
    `supplier_invoice_id` BIGINT COMMENT 'Reference to the accounts receivable invoice document associated with this tax record. Supports invoice-level tax reconciliation in SAP S/4HANA AR module.',
    `company_code` STRING COMMENT 'SAP S/4HANA company code identifying the legal entity responsible for this tax obligation. Enables multi-entity tax consolidation and statutory reporting across the enterprise group.',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` (
    `finance_bank_account_id` BIGINT COMMENT 'Unique surrogate identifier for each corporate bank account record in the treasury master data. Primary key for the bank_account data product.',
    `general_ledger_id` BIGINT COMMENT 'Reference to the GL clearing account in the chart of accounts that this bank account maps to for automated bank reconciliation and financial reporting.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the owning legal entity (company code) that holds this bank account. Used for multi-entity financial consolidation and SOX entity-level reporting.',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_finance_bank_account_id` FOREIGN KEY (`finance_bank_account_id`) REFERENCES `ecommerce_ecm`.`finance`.`finance_bank_account`(`finance_bank_account_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_tax_record_id` FOREIGN KEY (`tax_record_id`) REFERENCES `ecommerce_ecm`.`finance`.`tax_record`(`tax_record_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_finance_bank_account_id` FOREIGN KEY (`finance_bank_account_id`) REFERENCES `ecommerce_ecm`.`finance`.`finance_bank_account`(`finance_bank_account_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_finance_bank_account_id` FOREIGN KEY (`finance_bank_account_id`) REFERENCES `ecommerce_ecm`.`finance`.`finance_bank_account`(`finance_bank_account_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ADD CONSTRAINT `fk_finance_finance_bank_account_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ADD CONSTRAINT `fk_finance_finance_bank_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_entity_legal_entity_id` FOREIGN KEY (`parent_entity_legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `ecommerce_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Identifier');
ALTER TABLE `ecommerce_ecm`.`finance`.`general_ledger` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Bank Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`profit_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_subdomain' = 'payable_receivable');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Record ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Bank Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
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
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_subdomain' = 'payable_receivable');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Record ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Agent ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Bank Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` SET TAGS ('dbx_subdomain' = 'payable_receivable');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Agreement Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `commission_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `allocated_transaction_price` SET TAGS ('dbx_business_glossary_term' = 'Allocated Transaction Price');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `allocated_transaction_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `allocated_transaction_price` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
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
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` SET TAGS ('dbx_subdomain' = 'payable_receivable');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Record ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
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
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` SET TAGS ('dbx_subdomain' = 'treasury_compliance');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
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
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'treasury_compliance');
ALTER TABLE `ecommerce_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
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
