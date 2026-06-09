-- Schema for Domain: finance | Business: Pharmaceuticals | Version: v1_ecm
-- Generated on: 2026-05-05 17:50:33

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`finance` COMMENT 'Owns enterprise financial data including general ledger, accounts payable, accounts receivable, cost accounting, budgeting, R&D capitalization, COGS by product, royalty accounting, and SOX-compliant financial reporting. Integrates with SAP FI/CO modules. Supports P&L by therapeutic area, brand, and geography, return on investment (ROI) for R&D programs, and capital expenditure tracking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` (
    `general_ledger_id` BIGINT COMMENT 'Unique surrogate identifier for each general ledger account balance record in the Silver layer. Serves as the primary key for this data product.',
    `ledger_id` BIGINT COMMENT 'SAP ledger identifier distinguishing between parallel ledgers (e.g., 0L for leading ledger, N1 for IFRS non-leading ledger, U1 for US GAAP ledger). Supports multi-GAAP reporting requirements across the pharmaceutical group.. Valid values are `^[A-Z0-9]{2}$`',
    `account_group` STRING COMMENT 'Account group code that controls the number range and field selection for the GL account (e.g., OPEX, CAPX, COGS, RDEX). Used to segment accounts by business function such as R&D expense, COGS, or capital expenditure in pharmaceutical reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the GL account master record: active (postings allowed), blocked (postings temporarily prevented), or marked_for_deletion (pending archival). Supports SOX-compliant account master data governance.. Valid values are `active|blocked|marked_for_deletion`',
    `account_type` STRING COMMENT 'SAP account type classification: A=Assets, D=Customers (Accounts Receivable), K=Vendors (Accounts Payable), M=Materials, S=General Ledger. Determines posting rules and balance sheet/income statement classification.. Valid values are `A|D|K|M|S`',
    `balance_sheet_account` BOOLEAN COMMENT 'Indicates whether the GL account is a balance sheet account (True) or a profit and loss (P&L) income statement account (False). Balance sheet accounts carry forward balances; P&L accounts are reset at year-end. Critical for financial statement classification.',
    `business_area` STRING COMMENT 'SAP business area code used for internal segment reporting across legal entities. Supports cross-company-code P&L and balance sheet reporting by business division (e.g., Pharmaceuticals, Consumer Health, Vaccines).. Valid values are `^[A-Z0-9]{4}$`',
    `chart_of_accounts` STRING COMMENT 'Identifier for the chart of accounts framework applied to this GL account (e.g., INT1 for international, USGP for US GAAP). Supports multi-GAAP reporting across the pharmaceutical group.. Valid values are `^[A-Z0-9]{4}$`',
    `closing_balance` DECIMAL(18,2) COMMENT 'The GL account balance at the end of the fiscal period in transaction currency, calculated as opening balance plus debits minus credits (or vice versa depending on account type). Authoritative balance for trial balance, balance sheet, and income statement reporting.',
    `closing_balance_gc` DECIMAL(18,2) COMMENT 'The GL account closing balance translated into the group consolidation currency. Used for consolidated financial statements, group P&L reporting, and multi-entity consolidation eliminations.',
    `closing_balance_lc` DECIMAL(18,2) COMMENT 'The GL account closing balance translated into the company code local currency. Used for statutory reporting and local GAAP compliance in each legal entitys jurisdiction.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity or organizational unit for which the ledger balance is recorded. Aligns with the legal entity structure of the pharmaceutical group for statutory and consolidated reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `company_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the local (company code) currency in which balances are reported for statutory purposes. Distinct from transaction currency to support currency translation and consolidation eliminations.. Valid values are `^[A-Z]{3}$`',
    `cost_center` STRING COMMENT 'SAP cost center code identifying the organizational unit responsible for the costs recorded in this GL account balance (e.g., a manufacturing plant, clinical operations department, or R&D lab). Supports cost accounting and COGS analysis.. Valid values are `^[A-Z0-9]{1,10}$`',
    `credit_amount` DECIMAL(18,2) COMMENT 'Total credit postings to the GL account during the fiscal period in transaction currency. Sourced from aggregated journal entry postings in SAP FI. Used in trial balance and double-entry bookkeeping validation.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction currency in which the GL balance amounts are originally recorded (e.g., USD, EUR, JPY, GBP). Required for multi-currency pharmaceutical operations across global markets.. Valid values are `^[A-Z]{3}$`',
    `debit_amount` DECIMAL(18,2) COMMENT 'Total debit postings to the GL account during the fiscal period in transaction currency. Sourced from aggregated journal entry postings in SAP FI. Used in trial balance and double-entry bookkeeping validation.',
    `fiscal_period` STRING COMMENT 'The fiscal period number (1–16, where periods 13–16 are special closing periods) within the fiscal year for which the balance is recorded. Supports period-end close, monthly P&L reporting, and SOX-compliant financial close tracking.',
    `fiscal_year` STRING COMMENT 'The fiscal year (e.g., 2024) for which the GL account balance is recorded. Aligns with the companys fiscal year variant as configured in SAP. Used for annual financial close, SOX compliance, and year-over-year comparisons.',
    `fs_item` STRING COMMENT 'Financial statement item code mapping the GL account to a specific line in the balance sheet or income statement (e.g., P&L by therapeutic area, balance sheet line). Supports multi-GAAP consolidation and statutory reporting.',
    `functional_area` STRING COMMENT 'SAP functional area code classifying the GL account balance by business function (e.g., MFGC for manufacturing/COGS, RDEX for R&D expense, SELL for selling expense, GADM for general and administrative). Supports cost-of-goods-sold (COGS) and P&L by function reporting. [ENUM-REF-CANDIDATE: MFGC|RDEX|SELL|GADM|CLIN|REGL|PROC — promote to reference product]',
    `gaap_standard` STRING COMMENT 'The accounting standard under which this ledger balance is reported (US_GAAP, IFRS, LOCAL_GAAP, or IFRS_AND_US_GAAP for dual-reporting ledgers). Supports multi-GAAP reporting requirements for the pharmaceutical groups global legal entities.. Valid values are `US_GAAP|IFRS|LOCAL_GAAP|IFRS_AND_US_GAAP`',
    `gl_account_name` STRING COMMENT 'Short descriptive name of the GL account as defined in the chart of accounts (e.g., Research and Development Expense, API Inventory, Accrued Clinical Trial Costs). Used in financial reports and trial balance outputs.',
    `gl_account_number` STRING COMMENT 'The chart-of-accounts account number uniquely identifying the GL account within the company code. Used as the primary business identifier for account lookup, trial balance, and financial statement mapping.. Valid values are `^[0-9]{6,10}$`',
    `group_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the group (consolidation) currency used in consolidated financial statements (e.g., USD for a US-headquartered pharmaceutical group). Supports group-level P&L and balance sheet consolidation.. Valid values are `^[A-Z]{3}$`',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this GL account balance contains intercompany transactions (True) that require elimination during group consolidation. Supports consolidation eliminations for the pharmaceutical groups multi-entity structure.',
    `last_posted_date` DATE COMMENT 'The most recent date on which a journal entry posting was made to this GL account within the fiscal period. Used for account activity monitoring, dormant account identification, and period-end close validation.',
    `opening_balance` DECIMAL(18,2) COMMENT 'The GL account balance at the start of the fiscal period in transaction currency. Represents the carried-forward closing balance from the prior period. Used in trial balance preparation and period-end close processes.',
    `period_close_status` STRING COMMENT 'Current status of the financial period close process for this GL account balance: open (period active), in_progress (close activities underway), closed (period-end close completed), or locked (period locked against further postings). Supports SOX-compliant financial close tracking.. Valid values are `open|in_progress|closed|locked`',
    `posting_block` BOOLEAN COMMENT 'Indicates whether postings to this GL account are currently blocked (True) at the company code level. A blocked account prevents new journal entries, used during period-end close or account restructuring.',
    `profit_center` STRING COMMENT 'SAP profit center code representing the business unit or therapeutic area (e.g., Oncology, Immunology, Rare Diseases) to which the GL balance is allocated. Enables P&L reporting by therapeutic area, brand, and geography.. Valid values are `^[A-Z0-9]{1,10}$`',
    `rd_capitalization_flag` BOOLEAN COMMENT 'Indicates whether the GL account balance is subject to R&D capitalization rules under IFRS IAS 38 (True) or expensed as incurred under US GAAP ASC 730 (False). Critical for pharmaceutical companies managing the boundary between R&D expense and intangible asset capitalization.',
    `recon_account_type` STRING COMMENT 'Indicates if this GL account is a reconciliation account and its type: D=Accounts Receivable (Customers), K=Accounts Payable (Vendors), A=Assets, or empty for non-reconciliation accounts. Reconciliation accounts aggregate subledger balances into the GL.. Valid values are `D|K|A|`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this GL account balance record was first created in the Silver layer data product. Supports data lineage, audit trail, and SOX-compliant record-keeping requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this GL account balance record was last modified in the Silver layer data product. Supports incremental data loading, change tracking, and SOX-compliant audit trail requirements.',
    `segment` STRING COMMENT 'Segment identifier for IFRS 8 / ASC 280 segment reporting (e.g., Oncology, Immunology, Rare Disease, Consumer Health). Enables disaggregated P&L and asset reporting by operating segment for external financial disclosures.',
    `sox_relevant` BOOLEAN COMMENT 'Indicates whether this GL account is in scope for SOX Section 302/404 internal controls over financial reporting (ICFR). SOX-relevant accounts require documented controls, testing, and sign-off during the annual audit cycle.',
    `tax_code` STRING COMMENT 'SAP tax code associated with the GL account for VAT/GST and withholding tax determination. Relevant for pharmaceutical entities operating across multiple tax jurisdictions. Supports indirect tax reporting and compliance.. Valid values are `^[A-Z0-9]{2}$`',
    `trading_partner` STRING COMMENT 'Company code of the intercompany trading partner for balances involving intercompany transactions. Used to identify and eliminate intercompany balances during group consolidation. Populated only when intercompany_flag is True.. Valid values are `^[A-Z0-9]{1,6}$`',
    CONSTRAINT pk_general_ledger PRIMARY KEY(`general_ledger_id`)
) COMMENT 'Central repository for all financial accounting entries across the enterprise, representing the authoritative chart of accounts, account balances, and period-end ledger positions. Captures account master data (account number, account type, account group, currency), period balances (opening, debit totals, credit totals, closing balance by period), company code, profit center allocations, cost center references, and currency translations as sourced from SAP FI module. Serves as SSOT for trial balance, balance sheet, income statement, and SOX-compliant period-end close processes across all legal entities in the pharmaceutical group. Supports consolidation eliminations, multi-GAAP reporting (US GAAP and IFRS), and financial close status tracking. Does NOT own individual postings (owned by journal_entry) — owns aggregate balances and account structure.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique surrogate identifier for each journal entry record in the general ledger. Primary key for the journal_entry data product in the Databricks Silver Layer.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Journal entries generated by AP postings should reference the source AP document. This is a nullable FK since not all journal entries are AP-related. Strengthens accounts_payable connections to journa',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Journal entries require audit trail linking posting_user to employee master for SOX compliance, segregation of duties controls, and financial audit requirements. Existing posting_user is username stri',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Journal entries related to fixed asset transactions (acquisition, depreciation, disposal, impairment) should reference the specific asset. This is a nullable FK since not all journal entries are asset',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Journal entries post to specific GL accounts. Each JE line item must reference the GL account it impacts. The existing gl_account field is a STRING code; adding general_ledger_id establishes the prope',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Journal entries for inventory receipts and accruals link to goods receipts for inventory accounting audit trail and period-end accrual validation. Essential for pharmaceutical inventory accounting, en',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Journal entries that charge costs to internal orders should reference the internal order. This is a nullable FK since not all journal entries are internal-order-related. Connects internal_order to jou',
    `vendor_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_invoice. Business justification: Journal entries for invoice accruals and postings need vendor invoice traceability for audit trail and invoice-to-GL reconciliation. Critical for pharmaceutical financial close processes, SOX complian',
    `amount_group_currency` DECIMAL(18,2) COMMENT 'Monetary amount of the journal entry translated into the corporate group reporting currency (typically USD or EUR) for consolidated P&L reporting by therapeutic area, brand, and geography.',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'Monetary amount of the journal entry translated into the company codes local (functional) currency using the applicable exchange rate. Used for statutory financial reporting and local tax compliance.',
    `amount_transaction_currency` DECIMAL(18,2) COMMENT 'Gross monetary amount of the journal entry in the original transaction currency. For debit entries this is positive; for credit entries this is negative (SAP sign convention). Core monetary fact for the posting.',
    `assignment_field` STRING COMMENT 'SAP assignment field (ZUONR) used for sorting and matching open items in accounts payable, accounts receivable, and bank reconciliation. Typically populated with invoice number, payment reference, or contract number for automated clearing.',
    `business_area` STRING COMMENT 'SAP business area code representing an organizational unit for which an internal balance sheet and P&L can be drawn up. Used for segment reporting across geographies and therapeutic areas.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code` STRING COMMENT 'SAP company code identifying the legal entity for which the journal entry is posted. Enables P&L reporting by legal entity and supports multi-entity consolidation across the pharmaceutical group.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center` STRING COMMENT 'SAP CO cost center to which the expense or revenue is assigned. Enables cost allocation by department, therapeutic area, or function (e.g., R&D, Manufacturing, Commercial). Supports internal P&L and ROI analysis for drug programs.. Valid values are `^[A-Z0-9]{4,10}$`',
    `debit_credit_indicator` STRING COMMENT 'SAP indicator specifying whether the line item is a debit (S=Soll/Debit) or credit (H=Haben/Credit) posting. Fundamental double-entry bookkeeping attribute required for GL balance validation and trial balance generation.. Valid values are `S|H`',
    `document_date` DATE COMMENT 'The date of the original source document (invoice date, payment date, contract date) that triggered the journal entry. May differ from posting_date; used for aging analysis and vendor/customer terms calculation.',
    `document_number` STRING COMMENT 'SAP-assigned unique accounting document number within the company code and fiscal year. Serves as the externally-known business identifier for the journal entry, used in audit trails and reconciliation.. Valid values are `^[0-9]{10}$`',
    `document_type` STRING COMMENT 'SAP document type code classifying the nature of the journal entry (e.g., SA=General Ledger, KR=Vendor Invoice, DR=Customer Invoice, AA=Asset Posting, ZP=Payment Clearing, ML=Material Ledger). Drives posting rules and account determination. [ENUM-REF-CANDIDATE: SA|KR|DR|AA|ZP|ML|AB|KZ|DZ|WA|WE|RE — promote to reference product]',
    `entry_timestamp` TIMESTAMP COMMENT 'The exact date and time when the journal entry record was created in the system. Supports audit trail requirements under SOX and 21 CFR Part 11 electronic records compliance.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign currency exchange rate applied to translate the transaction currency amount to local currency at the time of posting. Sourced from SAP exchange rate tables per the applicable rate type (e.g., M=standard, B=bank buying rate).',
    `fiscal_period` STRING COMMENT 'The fiscal period (month 01–12, plus special periods 13–16 for year-end adjustments) within the fiscal year. Drives period-end close processes, P&L reporting by period, and financial close calendar management.. Valid values are `^(0[1-9]|1[0-6])$`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which the journal entry belongs, as defined in the SAP fiscal year variant. Used for annual financial reporting, R&D capitalization tracking, and SOX compliance period assignment.. Valid values are `^[0-9]{4}$`',
    `functional_area` STRING COMMENT 'SAP functional area classifying the business function of the posting (e.g., R&D, Manufacturing, Sales & Distribution, General & Administrative). Supports cost-of-goods-sold (COGS) analysis and functional P&L reporting per IFRS. [ENUM-REF-CANDIDATE: R&D|Manufacturing|Sales|Marketing|G&A|Regulatory|Medical Affairs|Supply Chain — promote to reference product]',
    `gl_account` STRING COMMENT 'SAP GL account number to which the journal entry line is posted. Determines the financial statement line item (P&L or balance sheet). Supports COGS by product, R&D capitalization, and therapeutic area P&L analysis.. Valid values are `^[0-9]{6,10}$`',
    `header_text` STRING COMMENT 'Free-text description at the journal entry header level explaining the business purpose of the posting (e.g., Q3 R&D accrual – Oncology Phase III, API procurement – CMO settlement). Supports audit review and financial close documentation.',
    `is_reversal` BOOLEAN COMMENT 'Indicates whether this journal entry is itself a reversal of a prior posting (True) or an original entry (False). Used to filter reversals from net financial reporting and to identify accrual reversal patterns in period-end close.',
    `last_changed_timestamp` TIMESTAMP COMMENT 'The date and time when the journal entry was last modified or reversed. Supports change audit trail requirements under SOX Section 404 and 21 CFR Part 11 for electronic records integrity.',
    `line_item_number` STRING COMMENT 'Sequential line item number within the journal entry document (e.g., 001, 002). Uniquely identifies each debit/credit line within the document for reconciliation, audit, and subledger matching.',
    `line_item_text` STRING COMMENT 'Free-text description at the individual line item level providing context for the specific debit or credit posting (e.g., API batch #XYZ123 – COGS, Phase III trial accrual – CRO milestone). Supports granular audit review.',
    `local_currency` STRING COMMENT 'ISO 4217 three-letter currency code of the company codes local (functional) currency. Used for statutory reporting in the country of the legal entity.. Valid values are `^[A-Z]{3}$`',
    `posting_date` DATE COMMENT 'The date on which the journal entry is posted to the general ledger. Determines the fiscal period and year to which the transaction is assigned. Critical for period-end close and financial reporting.',
    `posting_status` STRING COMMENT 'Current workflow state of the journal entry in the general ledger lifecycle. posted = fully committed to GL; parked = saved but not posted; held = incomplete draft; reversed = offset entry created; cleared = matched against open items; blocked = pending approval.. Valid values are `posted|parked|held|reversed|cleared|blocked`',
    `profit_center` STRING COMMENT 'SAP CO profit center representing the business unit or product line responsible for the financial result. Enables P&L reporting by therapeutic area (oncology, immunology, rare diseases), brand, and geography.. Valid values are `^[A-Z0-9]{4,10}$`',
    `reference_document_number` STRING COMMENT 'External reference number from the source document (e.g., vendor invoice number, purchase order number, contract reference, or regulatory submission reference). Enables cross-system reconciliation and audit traceability.',
    `reversal_document_number` STRING COMMENT 'Document number of the reversing journal entry if this posting has been reversed. Populated only for reversed entries; null otherwise. Supports audit trail completeness and period-end close validation.',
    `subledger_type` STRING COMMENT 'Identifies the subledger from which the journal entry originates: AP (Accounts Payable), AR (Accounts Receivable), asset accounting, tax accounting, material ledger, or none (direct GL posting). Enables subledger-to-GL reconciliation.. Valid values are `AP|AR|asset|tax|material|none`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount (VAT, GST, sales tax) in local currency for the journal entry line. Supports indirect tax return filing, tax provision calculations, and multi-jurisdiction tax compliance reporting.',
    `tax_base_amount` DECIMAL(18,2) COMMENT 'The taxable base amount in local currency on which the tax is calculated. Required for indirect tax return preparation and multi-jurisdiction VAT/GST compliance reporting.',
    `tax_code` STRING COMMENT 'SAP tax code identifying the applicable tax rate and type (e.g., VAT, sales tax, withholding tax) for the posting. Drives automatic tax calculation and links to tax jurisdiction for multi-jurisdiction indirect tax compliance.. Valid values are `^[A-Z0-9]{2}$`',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the tax jurisdiction (country, state, county, city) applicable to the transaction for multi-jurisdiction indirect tax reporting. Required for US sales tax (Vertex/Avalara integration) and international VAT compliance.',
    `tax_return_period` STRING COMMENT 'The reporting period (YYYY-MM) to which this tax posting belongs for indirect tax return filing purposes. May differ from the accounting fiscal period; used for VAT/GST return preparation across multiple tax jurisdictions.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `transaction_currency` STRING COMMENT 'ISO 4217 three-letter currency code of the original transaction (e.g., USD, EUR, JPY, GBP). The currency in which the business transaction was originally denominated, before conversion to local or group currency.. Valid values are `^[A-Z]{3}$`',
    `vat_classification` STRING COMMENT 'Classification of the tax posting type for indirect tax reporting: input VAT (recoverable on purchases), output VAT (collected on sales), deferred VAT (timing difference), exempt, zero-rated, or not applicable. Supports multi-jurisdiction VAT compliance.. Valid values are `input_vat|output_vat|deferred_vat|exempt|zero_rated|not_applicable`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax (WHT) deducted at source for cross-border payments to vendors, royalty recipients, or service providers. Relevant for pharmaceutical royalty accounting, CRO/CMO payments, and international tax treaty compliance.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Individual accounting transactions posted to the general ledger with full header and line-item detail, including tax-specific postings. Header captures posting date, document type, reference number, fiscal year/period, currency, and posting user. Line items capture GL account, cost center, profit center, debit/credit amounts in transaction and local currency, tax code, tax jurisdiction, taxable base amount, tax amount, withholding tax, assignment field, and line item text. Encompasses all subledger postings (AP, AR, asset, tax) and manual adjustments. Tax postings carry additional attributes: tax jurisdiction, tax return reference, VAT/sales tax/deferred tax classification, and indirect tax reporting period for multi-jurisdiction compliance. Supports audit trails required under SOX and 21 CFR Part 11, financial close processes, and granular P&L analysis by therapeutic area, brand, and geography.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` (
    `internal_order_id` BIGINT COMMENT 'Unique surrogate identifier for the SAP CO internal order record in the Databricks Silver layer. Primary key for this data product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: R&D internal orders track initiating employee for approval workflows, budget accountability, and audit trails. Existing created_by_user is username string; FK enables proper authorization controls, Gx',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility associated with this internal order. Relevant for CAPEX orders tied to facility investments or manufacturing overhead orders. Corresponds to WERKS in SAP AUFK.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center organizationally responsible for managing and monitoring this internal order. Corresponds to KOSTV in SAP AUFK. Used for P&L reporting by therapeutic area and organizational unit.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center associated with this internal order, enabling P&L reporting by therapeutic area, brand, or geography. Supports management accounting and ROI analysis for drug development programs.',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: R&D and clinical trial internal orders frequently reference master supply agreements for CMO/CRO services and materials procurement. Essential for cost tracking against contracted rates, budget vs. ac',
    `wbs_element_id` BIGINT COMMENT 'Reference to the SAP PS Work Breakdown Structure element linked to this internal order. Used when the internal order is subordinate to a larger capital or R&D project structure. Corresponds to PSPNR in SAP AUFK.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Cumulative actual costs posted to this internal order to date in the controlling area currency. Sourced from SAP CO actual cost line items (COEP table). Used for budget vs. actual reporting, R&D spend tracking, and CAPEX lifecycle governance.',
    `actual_finish_date` DATE COMMENT 'Actual date on which the internal order activity was completed (technically completed or closed). Used for variance analysis between planned and actual project duration and for R&D capitalization period determination.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget allocated to this internal order in the controlling area currency. Represents the authorized spending limit for the R&D program, capital project, or overhead activity. Used for budget vs. actual variance analysis and availability control.',
    `budget_profile` STRING COMMENT 'SAP CO budget profile code assigned to this internal order, defining the budgeting rules, availability control tolerance levels, and fiscal year distribution method. Corresponds to PROFL in SAP AUFK.. Valid values are `^[A-Z0-9]{1,6}$`',
    `capitalization_eligible` BOOLEAN COMMENT 'Indicates whether costs accumulated on this internal order are eligible for capitalization as an intangible asset under IAS 38 or ASC 350. Typically set to True for Phase 3 clinical development orders meeting the six IAS 38 criteria. Drives R&D capitalization tracking and CAPEX lifecycle governance.',
    `commitment_amount` DECIMAL(18,2) COMMENT 'Total open commitment value (purchase orders, contracts, and reservations) posted against this internal order but not yet invoiced. Represents future obligated spend. Sourced from SAP CO commitment management (COOI table). Critical for total exposure reporting.',
    `company_code` STRING COMMENT 'SAP FI company code representing the legal entity under which this internal order is managed. Enables multi-entity financial consolidation and statutory reporting. Corresponds to BUKRS in SAP AUFK.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area` STRING COMMENT 'SAP CO controlling area code that defines the organizational unit within which cost accounting is performed. Determines the currency and fiscal year variant applicable to this internal order. Corresponds to KOKRS in SAP AUFK.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the internal order record was first created in SAP CO. Corresponds to ERDAT and ERZET fields in SAP AUFK. Used for audit trail and SOX compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the controlling area currency in which budget, actual, commitment, and plan amounts are expressed (e.g., USD, EUR, GBP, JPY). Corresponds to WAERS in SAP AUFK.. Valid values are `^[A-Z]{3}$`',
    `deletion_flag` BOOLEAN COMMENT 'Indicates whether this internal order has been flagged for deletion in SAP CO. Deletion-flagged orders are excluded from active reporting but retained for audit trail purposes. Corresponds to LOEKZ in SAP AUFK.',
    `fiscal_year_variant` STRING COMMENT 'SAP fiscal year variant code defining the fiscal year and period structure applicable to this internal order (e.g., K4 for calendar year, V3 for April–March). Determines period-end processing and budget distribution. Corresponds to PERIV in SAP AUFK.. Valid values are `^[A-Z0-9]{2}$`',
    `functional_area` STRING COMMENT 'SAP functional area classifying the business function of the internal order (e.g., Research and Development, Manufacturing, Sales and Marketing, General and Administrative). Supports P&L by function and R&D capitalization under ASC 730 / IAS 38. [ENUM-REF-CANDIDATE: RD|MFG|SGA|MKTG|CLIN|REG|QA — promote to reference product]',
    `investment_measure_type` STRING COMMENT 'Classifies the internal order as a capital expenditure (CAPEX), operating expense (OPEX), R&D expense (RD_EXPENSE), or capitalizable R&D (RD_CAPITAL) measure. Drives balance sheet vs. P&L treatment and supports CAPEX lifecycle governance and ROI analysis.. Valid values are `CAPEX|OPEX|RD_EXPENSE|RD_CAPITAL`',
    `last_changed_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to this internal order record in SAP CO. Corresponds to AEDAT and AEZET fields in SAP AUFK. Used for change tracking and SOX audit trail.',
    `long_description` STRING COMMENT 'Extended narrative description of the internal order providing full business context, scope, and objectives. Supports R&D capitalization documentation and audit trail requirements under SOX and 21 CFR Part 11.',
    `order_category` STRING COMMENT 'SAP internal order category code distinguishing overhead orders (01), investment orders (04), accrual orders (02), and statistical orders (10/20). Drives settlement and budget management behavior in SAP CO.. Valid values are `01|02|04|10|20`',
    `order_name` STRING COMMENT 'Human-readable short description of the internal order, typically identifying the R&D program, clinical trial phase, capital project, or overhead activity being tracked. Corresponds to KTEXT in SAP AUFK.',
    `order_number` STRING COMMENT 'SAP-assigned alphanumeric identifier for the internal order, used as the externally-known business key across finance, R&D, and project management systems. Corresponds to the AUFNR field in SAP CO table AUFK.. Valid values are `^[0-9]{9,12}$`',
    `order_status` STRING COMMENT 'Current system status of the internal order in SAP CO. CRTD=Created, REL=Released (costs can be posted), TECO=Technically Completed (no further postings), CLSD=Closed (settled and locked), DLT=Deletion Flagged, LKD=Locked. Governs cost posting eligibility and settlement processing.. Valid values are `CRTD|REL|TECO|CLSD|DLT|LKD`',
    `order_type` STRING COMMENT 'SAP order type code classifying the purpose of the internal order (e.g., R&D expense, capital expenditure, overhead, clinical trial cost collection, manufacturing overhead). Corresponds to AUART in SAP AUFK. [ENUM-REF-CANDIDATE: RD01|CAPEX|OVHD|CLIN|MFG|MKTG — promote to reference product]',
    `overhead_key` STRING COMMENT 'SAP CO overhead key assigned to this internal order, determining the overhead surcharge rates applied during overhead calculation (costing sheet). Used for allocating indirect manufacturing or R&D overhead costs to the order. Corresponds to ZUONR in SAP AUFK.. Valid values are `^[A-Z0-9]{1,6}$`',
    `plan_cost_amount` DECIMAL(18,2) COMMENT 'Total planned cost amount for this internal order in the controlling area currency, as entered in SAP CO planning. Supports budget vs. plan vs. actual three-way variance analysis for R&D program financial governance.',
    `planned_finish_date` DATE COMMENT 'Planned completion date for the activity or project represented by this internal order. Used for R&D program milestone tracking, CAPEX project scheduling, and budget period governance. Corresponds to PLSEZ in SAP AUFK.',
    `planned_start_date` DATE COMMENT 'Planned start date for the activity or project represented by this internal order. Used for timeline planning of R&D programs, clinical trials, and capital projects. Corresponds to PLFAZ in SAP AUFK.',
    `program_phase` STRING COMMENT 'Drug development lifecycle phase associated with this internal order. Drives R&D capitalization eligibility (costs may be capitalized from Phase 3 under IAS 38 criteria), ROI analysis, and budget governance. Aligns with ICH M4 eCTD structure.. Valid values are `DISCOVERY|PRECLINICAL|PHASE_1|PHASE_2|PHASE_3|LAUNCH`',
    `release_date` DATE COMMENT 'Date on which the internal order was released in SAP CO (status changed to REL), enabling cost postings to begin. Marks the start of the active cost collection period. Corresponds to IDAT2 in SAP AUFK.',
    `settlement_receiver_type` STRING COMMENT 'Category of the primary settlement receiver for this internal order. CTR=Cost Center, AUC=Asset Under Construction, WBS=WBS Element, PSG=Profitability Segment, GL=G/L Account, ORD=Internal Order. Determines the accounting treatment of settled costs.. Valid values are `CTR|AUC|WBS|PSG|GL|ORD`',
    `settlement_rule_type` STRING COMMENT 'Defines how costs accumulated on this internal order are settled to receivers (cost centers, G/L accounts, assets, WBS elements, profitability segments). FUL=Full settlement, PER=Periodic settlement, MAN=Manual settlement. Governs period-end cost allocation and R&D capitalization postings.. Valid values are `FUL|PER|MAN`',
    `statistical_order_flag` BOOLEAN COMMENT 'Indicates whether this internal order is a statistical order (costs posted in parallel for reporting purposes only, without affecting the primary cost object). Statistical orders are used for management reporting overlays such as therapeutic area P&L without impacting actual cost flows.',
    `therapeutic_area` STRING COMMENT 'Pharmaceutical therapeutic area classification associated with this internal order (e.g., Oncology, Immunology, Rare Diseases, Neuroscience, Cardiovascular). Enables P&L and ROI reporting by therapeutic area as required for management reporting and investor disclosures. [ENUM-REF-CANDIDATE: ONCOLOGY|IMMUNOLOGY|RARE_DISEASE|NEUROSCIENCE|CARDIOVASCULAR|INFECTIOUS_DISEASE — promote to reference product]',
    CONSTRAINT pk_internal_order PRIMARY KEY(`internal_order_id`)
) COMMENT 'SAP CO internal order used to collect, monitor, and settle costs for specific projects, R&D programs, clinical trials, or capital expenditure initiatives. Captures order type (R&D, capex, overhead), settlement rule, budget profile, actual costs, commitment values, responsible cost center, project/WBS reference, and order lifecycle status. References milestone_payment records for contractual obligations but does NOT own milestone payment terms or trigger events. Supports R&D capitalization tracking, ROI analysis for drug development programs, and CAPEX lifecycle governance.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` (
    `accounts_payable_id` BIGINT COMMENT 'Unique surrogate identifier for each accounts payable record in the SAP FI-AP module, representing a single vendor invoice or payment obligation. Role: TRANSACTION_HEADER.',
    `bank_account_id` BIGINT COMMENT 'The identifier of the vendor bank account used for payment execution, referencing the SAP FI-AP bank details record. Sensitive financial data subject to PCI and SOX controls.',
    `cost_center_id` BIGINT COMMENT 'Reference to the internal cost center (e.g., R&D, Manufacturing, Clinical Operations) to which the payable is allocated for P&L reporting by therapeutic area or function.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: AP transactions post to GL accounts (liability accounts, expense accounts). The existing gl_account_code is a STRING; adding general_ledger_id FK links AP to the GL account master record. This further',
    `payment_run_id` BIGINT COMMENT 'The SAP automatic payment program run identifier (F110 run ID) that generated the payment for this invoice. Enables batch payment reconciliation and audit trail for automated payment processing.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the originating purchase order against which this invoice was raised, enabling three-way match (PO, goods receipt, invoice) per SAP MM-FI integration.',
    `royalty_agreement_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_agreement. Business justification: AP invoices for royalty payments (when company is licensee) should reference the governing royalty agreement for compliance, audit, and accrual tracking. Cardinality: Many AP invoices can reference on',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: AP invoices reference master supply contracts for pricing validation, payment terms verification, and contract compliance auditing. Critical for three-way match validation (PO-GR-Invoice) and ensuring',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: AP modification tracking for audit trail, SOX compliance, and payment controls. Enables validation that changes were made by authorized personnel, supports segregation of duties analysis, and provides',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor (supplier, CRO, CMO, CDMO, licensor, or service provider) who issued the invoice. Links to the vendor master record.',
    `vendor_site_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_site. Business justification: AP needs to track which specific vendor site invoiced (manufacturing site vs. warehouse vs. R&D facility) for site-specific payment routing, tax jurisdiction determination, and GMP compliance document',
    `warehouse_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_receipt. Business justification: Three-way match (PO/GR/Invoice) is mandatory in pharma procure-to-pay. AP invoices are verified against goods receipts for quantity/quality confirmation before payment approval. Regulatory and SOX con',
    `clearing_document_number` STRING COMMENT 'The SAP FI clearing document number (AUGBL) that offsets the open payable item upon payment or credit memo application. Used for open item management and reconciliation.',
    `company_code` STRING COMMENT 'The SAP FI company code (BUKRS) representing the legal entity within the pharmaceutical group that is the obligor for this payable. Supports intercompany reconciliation and legal entity P&L reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the accounts payable record was first created in the SAP FI-AP system, used for audit trail and SOX compliance.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code of the vendor invoice (e.g., USD, EUR, GBP, JPY). Supports multi-currency payables for global pharmaceutical supply chain and cross-border licensing transactions.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The cash discount amount captured if payment is made within the discount period defined in the payment terms (e.g., 2% discount for payment within 10 days). Supports working capital optimization analytics.',
    `discount_due_date` DATE COMMENT 'The last date by which payment must be made to qualify for the early payment discount defined in the payment terms. Used by treasury for dynamic discounting and supply chain finance decisions.',
    `due_date` DATE COMMENT 'The date by which payment must be made to the vendor to satisfy the invoice obligation and avoid late payment penalties. Derived from invoice date and payment terms (e.g., Net 30, Net 60).',
    `fiscal_period` STRING COMMENT 'The accounting period (MONAT, 1–16 including special periods) within the fiscal year in which the invoice is posted in SAP FI, used for monthly close and accrual management.',
    `fiscal_year` STRING COMMENT 'The fiscal year (GJAHR) in which the invoice is posted in SAP FI, used for period-end close, annual financial reporting, and SOX compliance.',
    `gl_account_code` STRING COMMENT 'The SAP FI general ledger account (HKONT) to which the invoice line is posted, determining the expense or liability classification in the chart of accounts (e.g., R&D expense, COGS, API raw material).',
    `goods_receipt_number` STRING COMMENT 'The SAP MM goods receipt document number (MBLNR) confirming receipt of goods or services against the purchase order. Required for three-way match (PO-GR-Invoice) in GMP-compliant pharmaceutical procurement.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total gross amount of the vendor invoice before deduction of discounts, withholding tax, or other adjustments, as stated on the invoice document. Represents the full obligation amount.',
    `invoice_date` DATE COMMENT 'The date printed on the vendor invoice document (BLDAT in SAP), representing the principal business event date for the payable obligation. Used for aging analysis and payment term calculation.',
    `invoice_description` STRING COMMENT 'Free-text description of the goods or services invoiced, as provided by the vendor or entered during invoice processing in SAP FI-AP. Supports spend categorization and audit review.',
    `invoice_number` STRING COMMENT 'The externally-assigned invoice number provided by the vendor on the invoice document. Used for three-way match and duplicate invoice detection in SAP FI-AP.',
    `invoice_type` STRING COMMENT 'Classification of the vendor invoice by business nature. Milestone and royalty types are specific to pharmaceutical licensing and CRO/CMO contracts. [ENUM-REF-CANDIDATE: standard|credit_memo|debit_memo|milestone|royalty|advance|recurring — promote to reference product]',
    `is_intercompany` BOOLEAN COMMENT 'Indicates whether this payable is an intercompany transaction between legal entities within the pharmaceutical group, requiring elimination in consolidated financial statements per IFRS 10.',
    `is_rd_capitalized` BOOLEAN COMMENT 'Indicates whether the expenditure represented by this payable has been capitalized as an intangible asset under IAS 38 (development phase costs meeting capitalization criteria), as opposed to expensed immediately as R&D.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net amount payable to the vendor after deducting withholding tax and applicable discounts from the gross invoice amount. Represents the actual cash outflow obligation.',
    `payment_block_indicator` STRING COMMENT 'SAP payment block key (ZLSPR) indicating whether the invoice is blocked from automatic payment processing. Common values: R=Manual review required, B=Blocked by purchasing, A=Blocked for audit, V=Verified/released, blank=Not blocked.. Valid values are `R|B|A|V|`',
    `payment_date` DATE COMMENT 'The date on which the payment was executed and the invoice was cleared in SAP FI-AP. Used for cash flow reporting, days payable outstanding (DPO) calculation, and vendor relationship management.',
    `payment_document_number` STRING COMMENT 'The SAP FI document number of the outgoing payment transaction that cleared this invoice (AUGBL). Populated upon payment execution; null for open/blocked invoices.',
    `payment_method` STRING COMMENT 'The payment instrument used to settle the vendor invoice (e.g., ACH for domestic US transfers, SWIFT/wire for international payments, SEPA for EU transactions, check for legacy vendors).. Valid values are `ACH|wire|check|SEPA|SWIFT|EFT`',
    `payment_status` STRING COMMENT 'Current lifecycle status of the accounts payable record indicating whether the invoice obligation is open, partially settled, fully paid, blocked for payment, cancelled, or under dispute. [ENUM-REF-CANDIDATE: open|partially_paid|paid|blocked|cancelled|disputed — promote to reference product]. Valid values are `open|partially_paid|paid|blocked|cancelled|disputed`',
    `payment_terms_code` STRING COMMENT 'The SAP payment terms key (ZTERM) defining the agreed payment schedule, discount conditions, and due date calculation rules (e.g., NT30 = Net 30 days, 2/10NT30 = 2% discount if paid within 10 days).',
    `posting_date` DATE COMMENT 'The date on which the invoice was posted to the SAP general ledger (BUDAT), determining the accounting period for financial reporting and period-end close.',
    `sap_document_number` STRING COMMENT 'The internal SAP FI document number (BELNR) assigned upon posting of the vendor invoice in the general ledger. Serves as the primary system-of-record identifier within SAP.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The value-added tax (VAT) or sales tax amount included in the vendor invoice, as calculated by SAP FI tax determination. Used for tax reporting and input tax recovery.',
    `therapeutic_area` STRING COMMENT 'The pharmaceutical therapeutic area (e.g., Oncology, Immunology, Rare Diseases, Neuroscience) to which the payable is attributed, enabling P&L reporting and R&D spend analysis by therapeutic area as required by finance leadership.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the accounts payable record in SAP FI-AP, supporting audit trail requirements under SOX and 21 CFR Part 11.',
    `vendor_category` STRING COMMENT 'Pharmaceutical industry classification of the vendor type. Enables spend analytics by vendor category (e.g., CRO spend for clinical operations, CMO/CDMO spend for outsourced manufacturing, licensor for royalty and milestone obligations). [ENUM-REF-CANDIDATE: CRO|CMO|CDMO|raw_material_supplier|licensor|service_provider|logistics|other — promote to reference product]',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax (WHT) deducted from the vendor payment, applicable to royalty payments, milestone payments to licensors, and cross-border service fees per local tax regulations.',
    CONSTRAINT pk_accounts_payable PRIMARY KEY(`accounts_payable_id`)
) COMMENT 'Vendor invoice, payment obligation, and payment execution records managed within SAP FI-AP module. Captures vendor invoice details (invoice number, date, due date, payment terms, gross amount, tax amount, withholding tax, payment block status), payment execution (payment document, payment date, payment method including ACH/wire/check, bank account, clearing document, payment run ID), and settlement status. Covers payables to CROs, CMOs, CDMOs, raw material suppliers, licensors (royalty and milestone payments), and service providers in the pharmaceutical supply chain.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` (
    `accounts_receivable_id` BIGINT COMMENT 'Unique surrogate identifier for each accounts receivable record in the SAP FI-AR module. Serves as the primary key for the silver layer lakehouse table. Entity role: TRANSACTION_HEADER.',
    `business_partner_id` BIGINT COMMENT 'Reference to the customer (wholesaler, distributor, hospital network, or government payer) associated with this receivable record. Maps to the SAP FI-AR customer master (debtor account).',
    `delivery_order_id` BIGINT COMMENT 'Foreign key linking to supply.delivery_order. Business justification: Commercial deliveries trigger AR creation and revenue recognition in pharma order-to-cash. Links physical delivery (proof of transfer of control) to financial receivable. Required for revenue recognit',
    `invoice_id` BIGINT COMMENT 'Reference to the originating customer invoice document that generated this receivable. Links to the billing document in SAP SD/FI.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: AR transactions generate journal entries for revenue recognition and cash application. Adding journal_entry_id FK links each AR record to its corresponding journal entry. This is a standard finance pa',
    `royalty_agreement_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_agreement. Business justification: AR invoices for royalty receipts (when company is licensor) should reference the governing royalty agreement for revenue recognition and compliance. Cardinality: Many AR invoices can reference one roy',
    `ar_status` STRING COMMENT 'Current lifecycle status of the receivable. open = outstanding balance; partially_cleared = partial payment received; cleared = fully paid or offset; disputed = customer dispute raised; written_off = bad debt write-off applied; in_dunning = active dunning process initiated. [ENUM-REF-CANDIDATE: open|partially_cleared|cleared|disputed|written_off|in_dunning — promote to reference product]. Valid values are `open|partially_cleared|cleared|disputed|written_off|in_dunning`',
    `billing_date` DATE COMMENT 'Date on which the customer invoice was issued (billing document date). Used as the principal business event date for revenue recognition under ASC 606 / IFRS 15. Corresponds to SAP BLDAT.',
    `chargeback_amount` DECIMAL(18,2) COMMENT 'Total chargeback deductions claimed by wholesalers or distributors against this invoice, representing the difference between the contract price and the wholesale acquisition cost (WAC). Critical for pharmaceutical gross-to-net revenue calculations.',
    `clearing_date` DATE COMMENT 'Date on which this AR item was fully cleared (settled) in SAP FI-AR. Corresponds to SAP AUGDT. Null for open or partially cleared items. Used for DSO and cash flow reporting.',
    `clearing_document_number` STRING COMMENT 'SAP document number of the clearing transaction (payment, credit memo, or offset) that fully or partially settled this AR item. Corresponds to SAP AUGBL field in BSAD. Null for open items.',
    `company_code` STRING COMMENT 'Four-character SAP company code identifying the legal entity (pharmaceutical subsidiary or affiliate) that owns this AR document. Drives legal entity P&L reporting and SOX compliance segregation.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this AR record was first created in the SAP FI-AR system. Serves as the RECORD_AUDIT_CREATED field for audit trail and SOX compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code of the AR document (e.g., USD, EUR, GBP, JPY). Represents the transaction currency in which the invoice was issued to the customer. Part of the MONETARY_TRIPLET.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Business segment classification of the customer for this receivable. Supports P&L analysis by channel and revenue recognition reporting under ASC 606 / IFRS 15. [ENUM-REF-CANDIDATE: wholesaler|distributor|hospital_network|government_payer|retail_pharmacy|specialty_pharmacy — promote to reference product]. Valid values are `wholesaler|distributor|hospital_network|government_payer|retail_pharmacy|specialty_pharmacy`',
    `days_overdue` STRING COMMENT 'Number of calendar days this AR item is past its due date as of the last refresh date. Calculated as (refresh_date - due_date) for open items. Used for aging bucket classification and credit risk assessment.',
    `document_number` STRING COMMENT 'Externally visible SAP FI-AR accounting document number uniquely identifying this receivable transaction within the general ledger. Corresponds to BELNR in SAP BSID/BSAD tables.',
    `document_type` STRING COMMENT 'Classification of the AR document: customer invoice, credit memo (e.g., chargebacks, rebates), debit memo, down payment request, incoming payment receipt, or revenue accrual entry. Maps to SAP document type (BLART). [ENUM-REF-CANDIDATE: customer_invoice|credit_memo|debit_memo|down_payment|payment_receipt|accrual — promote to reference product]. Valid values are `customer_invoice|credit_memo|debit_memo|down_payment|payment_receipt|accrual`',
    `due_date` DATE COMMENT 'Date by which the customer is contractually required to remit payment per the agreed payment terms. Calculated from billing date and payment terms. Used for dunning and aging analysis.',
    `dunning_date` DATE COMMENT 'Date on which the most recent dunning notice was issued to the customer for this overdue AR item. Corresponds to SAP MAHND. Used to track collections activity and avoid duplicate dunning.',
    `dunning_level` STRING COMMENT 'Current dunning escalation level (0–4) assigned to this AR item by the SAP dunning program. Level 0 = no dunning; higher levels indicate increasing overdue severity. Drives collections escalation for wholesalers and distributors.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied at posting date to translate the document currency amount to local currency. Sourced from SAP exchange rate table (TCURR). Required for multi-currency pharmaceutical operations.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this AR document was posted in SAP FI-AR. Used for period-end close, SOX financial reporting, and P&L by therapeutic area and geography.. Valid values are `^[0-9]{4}$`',
    `gl_account_code` STRING COMMENT 'SAP General Ledger (GL) account number to which this AR document is posted (e.g., trade receivables account, accrued revenue account). Enables reconciliation between the AR subledger and the GL for SOX financial close.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount of the AR document before tax deductions, chargebacks, or rebate adjustments. Represents the face value of the customer invoice in the document currency. Part of the MONETARY_TRIPLET.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this AR record in the SAP FI-AR system. Serves as the RECORD_AUDIT_UPDATED field for change tracking and SOX audit trail. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Net invoice amount translated into the company code local currency (e.g., USD for US entity) using the SAP exchange rate at posting date. Required for consolidated P&L reporting and SOX compliance.',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the company code local currency used for translation of the AR document amount (e.g., USD for US legal entity).. Valid values are `^[A-Z]{3}$`',
    `net_amount` DECIMAL(18,2) COMMENT 'Net receivable amount after deducting tax from the gross amount. Represents the revenue-recognized value for ASC 606 / IFRS 15 reporting. Part of the MONETARY_TRIPLET.',
    `open_amount` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on this AR document at the time of last update. Equals gross_amount minus all clearing payments and credit memos applied. Used for aging reports and collections management.',
    `payment_method` STRING COMMENT 'Method by which the customer remitted payment (e.g., bank transfer, ACH, wire transfer, check). Maps to SAP payment method key (ZLSCH). Used for cash application and treasury reconciliation.. Valid values are `bank_transfer|check|ach|wire|direct_debit|credit_card`',
    `payment_receipt_date` DATE COMMENT 'Date on which the incoming customer payment was received and applied against this AR document. Null if no payment has been received. Used for Days Sales Outstanding (DSO) calculation.',
    `payment_terms_code` STRING COMMENT 'SAP payment terms key (e.g., NT30, NT60, 2/10NET30) defining the discount period, discount percentage, and net due date for this receivable. Drives due date calculation and early payment discount eligibility.',
    `posting_date` DATE COMMENT 'Date on which the AR document was posted to the general ledger in SAP FI. Determines the accounting period for financial reporting. Corresponds to SAP BUDAT.',
    `posting_period` STRING COMMENT 'Accounting period (01–12 for regular months, 13–16 for special closing periods) within the fiscal year in which this AR document was posted. Aligns with SAP FI period control.. Valid values are `^(0[1-9]|1[0-6])$`',
    `product_ndc` STRING COMMENT 'FDA-assigned National Drug Code (NDC) for the pharmaceutical product billed on this invoice. Uniquely identifies the drug product, labeler, and package configuration. Required for government payer reporting and Medicaid rebate calculations.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `profit_center` STRING COMMENT 'SAP CO profit center associated with this AR document, representing the internal organizational unit (brand, therapeutic area, or geography) responsible for the revenue. Supports P&L reporting by brand and therapeutic area.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Contractual rebate amount accrued or applied against this AR document for government payers (Medicaid, Medicare) or commercial payer contracts. Part of gross-to-net revenue deductions under ASC 606.',
    `recognition_date` DATE COMMENT 'Date on which revenue was or is scheduled to be recognized in the income statement per ASC 606 / IFRS 15 performance obligation criteria. May differ from billing date for deferred or accrued revenue entries.',
    `revenue_recognition_type` STRING COMMENT 'Classification of the revenue treatment for this AR record under ASC 606 / IFRS 15: recognized = revenue fully recognized at point of sale; deferred = revenue deferred pending performance obligation fulfillment; accrued = period-end accrual entry; reversed = accrual reversal.. Valid values are `recognized|deferred|accrued|reversed`',
    `reversal_date` DATE COMMENT 'Date on which a period-end revenue accrual entry is scheduled to be automatically reversed in SAP FI. Applicable only to accrual-type AR documents. Null for standard invoices and payments.',
    `sales_territory` STRING COMMENT 'Geographic or organizational sales territory associated with this receivable. Used for P&L reporting by geography and market access analysis. Sourced from SAP SD sales area configuration.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the invoice (VAT, GST, or applicable sales tax) calculated on the gross invoice amount. Corresponds to SAP tax line items in FI-AR. Part of the MONETARY_TRIPLET.',
    `therapeutic_area` STRING COMMENT 'Pharmaceutical therapeutic area (e.g., Oncology, Immunology, Rare Diseases) associated with the product sold on this invoice. Enables P&L reporting by therapeutic area as required by finance domain.',
    CONSTRAINT pk_accounts_receivable PRIMARY KEY(`accounts_receivable_id`)
) COMMENT 'Customer invoice, collection, payment receipt, and revenue accrual records managed within SAP FI-AR module. Captures customer invoices (billing date, due date, payment terms, gross amount, tax, dunning level), incoming payments (receipt date, payment method, clearing document, bank account), and period-end revenue accruals (accrual type, product, customer segment, territory, accrual basis, recognized vs deferred revenue, recognition date, reversal date). Covers receivables from wholesalers, distributors, hospital networks, and government payers. Supports ASC 606 / IFRS 15 revenue recognition compliance for pharmaceutical product sales.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique surrogate identifier for the budget record in the enterprise data lakehouse. Primary key for the budget data product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Budget approvals require employee link for authorization controls, approval workflow validation, and audit trail. Existing approved_by is name string; FK enables proper approval hierarchy validation, ',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the General Ledger (GL) account to which this budget line is posted, enabling financial reporting and variance analysis.',
    `cost_center_id` BIGINT COMMENT 'Reference to the organizational cost center responsible for this budget line. Aligns with SAP CO cost center master data.',
    `internal_order_id` BIGINT COMMENT 'Reference to the SAP internal order used for tracking R&D program spend, clinical trial costs, or capital projects at a granular level.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Pharmaceutical budgets are allocated by medicinal product for R&D investment, commercialization spend, and lifecycle management. Product-level budget tracking is fundamental to portfolio financial pla',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center associated with this budget, enabling P&L planning by therapeutic area, brand, or geography.',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Budgets for contracted services and materials reference master supply agreements for committed spend tracking and budget vs. contract variance analysis. Essential for pharmaceutical operations to moni',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Pharmaceutical companies budget by therapeutic area (oncology, immunology, rare diseases) as primary financial planning dimension. This enables portfolio investment decisions, resource allocation, and',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual expenditure posted against this budget line item to date, sourced from SAP FI actuals. Used to compute budget variance (planned minus actual) for management reporting and SOX compliance.',
    `approval_date` DATE COMMENT 'The date on which the budget was formally approved by the authorized budget owner or finance committee. Required for SOX compliance audit trails and budget governance documentation.',
    `budget_category` STRING COMMENT 'High-level functional category of the budget line item within the pharmaceutical value chain. Enables cross-functional spend analysis and allocation reporting. [ENUM-REF-CANDIDATE: clinical_trials|manufacturing|commercial|medical_affairs|regulatory|rd_discovery|general_admin|supply_chain — promote to reference product]',
    `budget_name` STRING COMMENT 'Human-readable descriptive name for the budget plan (e.g., FY2025 Oncology R&D Operating Budget, Phase III Clinical Trial Budget - Program X). Used in reporting and stakeholder communications.',
    `budget_number` STRING COMMENT 'Externally-known alphanumeric identifier for the budget plan, used in financial reporting, approval workflows, and cross-system references. Follows the enterprise budget numbering convention (e.g., BUD-2025-ONCOL001).. Valid values are `^BUD-[0-9]{4}-[A-Z0-9]{6,12}$`',
    `budget_status` STRING COMMENT 'Current lifecycle state of the budget record within the approval workflow. Transitions from draft through submission, review, and approval to locked (frozen for actuals comparison) or closed (period end). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|locked|closed — promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the budget by expenditure category: opex (operating expenditure), capex (capital expenditure), rd (research and development), headcount, contingency, or other. Drives P&L treatment and financial reporting. [ENUM-REF-CANDIDATE: opex|capex|rd|headcount|contingency|other — promote to reference product]. Valid values are `opex|capex|rd|headcount|contingency|other`',
    `capitalization_stage` STRING COMMENT 'Indicates the R&D stage for capitalization accounting purposes: research (expensed under IFRS IAS 38), development (potentially capitalizable once technical feasibility is established), or not_applicable. Drives correct accounting treatment for pharmaceutical R&D spend.. Valid values are `research|development|not_applicable`',
    `committed_amount` DECIMAL(18,2) COMMENT 'The amount encumbered by open purchase orders, contracts, or obligations not yet invoiced. Represents funds committed but not yet expensed. Supports available budget calculation (planned minus actual minus committed).',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity or subsidiary responsible for this budget. Enables consolidation across global pharmaceutical entities and legal entity-level financial reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_element_code` STRING COMMENT 'SAP CO cost element code that categorizes the nature of the expenditure (e.g., personnel costs, material costs, external services, depreciation). Provides granular cost classification for management accounting and COGS analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was first created in the system, in ISO 8601 format with timezone offset. Provides the audit trail creation event required for SOX compliance and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction currency of this budget line (e.g., USD, EUR, GBP, JPY). Supports multi-currency pharmaceutical operations across global markets.. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'The last date of the period covered by this budget plan. For annual budgets, typically the last day of the fiscal year. Nullable for open-ended multi-year plans.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month 1–12 or 1–13 for 4-4-5 calendars) within the fiscal year to which this budget line applies. Enables period-level variance analysis and phased budget tracking.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget applies (e.g., 2025). Supports annual and multi-year budget planning cycles aligned with the enterprise financial calendar.',
    `geography_code` STRING COMMENT 'ISO 3166-1 alpha-3 country or region code indicating the geographic scope of this budget (e.g., USA, GBR, DEU, JPN). Supports P&L planning by geography and market access financial analysis.. Valid values are `^[A-Z]{3}$`',
    `is_capitalized` BOOLEAN COMMENT 'Indicates whether this budget line relates to R&D expenditure that is subject to capitalization under IFRS IAS 38 or US GAAP ASC 730 (True = capitalized; False = expensed). Critical for R&D capitalization accounting in pharmaceutical development programs.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was most recently modified, in ISO 8601 format with timezone offset. Tracks the latest change event for audit trail, SOX compliance, and incremental data pipeline processing.',
    `notes` STRING COMMENT 'Free-text field for budget planners to document assumptions, justifications, revision rationale, or commentary associated with this budget line. Supports audit trail documentation and budget review discussions.',
    `owner` STRING COMMENT 'Name or employee identifier of the business owner accountable for managing and reporting against this budget. Typically the cost center manager or program lead responsible for spend governance.',
    `planned_amount` DECIMAL(18,2) COMMENT 'The total planned budget amount for this line item in the transaction currency. Represents the approved or forecasted spend for the associated cost center, GL account, and period. Core field for variance analysis against actuals.',
    `planning_horizon` STRING COMMENT 'Indicates the time horizon covered by this budget plan: annual (single fiscal year), multi_year (2–5 year strategic plan), quarterly (quarterly rolling forecast), or rolling_12m (12-month rolling forecast). Supports both short-term operational and long-term R&D investment planning.. Valid values are `annual|multi_year|quarterly|rolling_12m`',
    `program_code` STRING COMMENT 'Internal code identifying the R&D drug development program or commercial brand to which this budget is allocated (e.g., a compound code, IND number reference, or brand identifier). Supports R&D investment planning and program-level ROI tracking.',
    `source_system` STRING COMMENT 'Identifies the originating system from which this budget record was sourced (e.g., SAP_S4HANA for CO/FI module extracts, EXCEL_UPLOAD for offline planning submissions, PLANNING_TOOL for integrated planning applications). Supports data lineage and reconciliation.. Valid values are `SAP_S4HANA|EXCEL_UPLOAD|PLANNING_TOOL|MANUAL`',
    `start_date` DATE COMMENT 'The first date of the period covered by this budget plan. For annual budgets, typically the first day of the fiscal year. For multi-year plans, the start of the planning horizon.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between planned amount and actual amount (planned minus actual) for this budget line. A positive value indicates underspend; negative indicates overspend. Stored as a pre-computed field from SAP CO variance reports to support management reporting without recalculation.',
    `variance_pct` DECIMAL(18,2) COMMENT 'The budget variance expressed as a percentage of the planned amount ((planned minus actual) / planned × 100). Sourced from SAP CO variance reporting. Supports threshold-based exception reporting and management dashboards.',
    `version` STRING COMMENT 'Indicates the iteration of the budget plan: original (initial approved plan), revised (formally amended plan), forecast (rolling in-year estimate), reforecast (mid-year replan), or final (year-end close). Supports variance analysis between versions.. Valid values are `original|revised|forecast|reforecast|final`',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Annual and multi-year financial budget plans with granular line-item detail by cost center, profit center, GL account, cost element, and internal order. Captures budget version (original, revised, forecast), fiscal year, budget type (opex, capex, R&D), line-item breakdowns with planned amounts by period, currency, budget category, approval workflow status, and variance tracking. Supports P&L planning by therapeutic area, R&D program investment planning, clinical trial budget management, and detailed variance analysis between planned and actual spend for drug development, manufacturing, and commercial operations.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique surrogate identifier for each fixed asset record in the enterprise fixed asset register. Primary key for the fixed_asset data product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Asset creation tracking for SOX controls, capitalization audit trail, and GMP equipment accountability. Enables validation that assets were capitalized by authorized finance personnel, supports asset ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Fixed assets acquired or constructed through capital projects are funded via SAP CO internal orders. The internal order collects all costs (materials, labor, overhead) during the asset construction/ac',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Fixed assets are physically located at manufacturing/R&D plants. Required for GMP equipment tracking, physical asset verification audits, site-level depreciation reporting, and regulatory inspection r',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Fixed asset acquisitions (GMP equipment, manufacturing facilities, lab instruments) originate from purchase orders. Essential for capitalization validation, asset acquisition cost tracking, and audit ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Fixed assets track supplying vendor for warranty management, maintenance contracts, equipment qualification documentation, and GMP compliance. Critical for pharmaceutical operations to maintain vendor',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation charged against the asset from the capitalization date to the current reporting period. Expressed as a negative value in SAP FI-AA. Used to calculate net book value and supports IAS 16 / ASC 360 balance sheet disclosures.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original historical cost of the fixed asset at the time of acquisition, including purchase price, import duties, installation costs, and directly attributable costs to bring the asset to its intended use. Expressed in the company code currency. Corresponds to SAP FI-AA Acquisition and Production Costs (APC).',
    `acquisition_date` DATE COMMENT 'Date on which the fixed asset was acquired or placed in service. Used as the start date for depreciation calculations and CAPEX reporting. Corresponds to the Asset Value Date in SAP FI-AA for the initial acquisition posting.',
    `asset_class_code` STRING COMMENT 'SAP FI-AA asset class code that categorizes the asset for depreciation, accounting, and reporting purposes (e.g., manufacturing equipment, laboratory instruments, IT infrastructure, leasehold improvements, vehicles, furniture). Drives default depreciation key and useful life.',
    `asset_class_name` STRING COMMENT 'Descriptive name of the SAP FI-AA asset class (e.g., Manufacturing Equipment, Laboratory Instruments, IT Infrastructure, Leasehold Improvements, Right-of-Use Assets). Supports reporting and analytics without requiring a join to a reference table.',
    `asset_description` STRING COMMENT 'Human-readable description of the fixed asset as recorded in the SAP FI-AA asset master (e.g., HPLC Analytical Instrument - QC Lab Building 4, Bioreactor 2000L - API Manufacturing). Used for identification and reporting.',
    `asset_number` STRING COMMENT 'Externally-known unique asset number assigned in SAP FI-AA (Asset Master record number). Used as the primary business identifier for the asset across finance, operations, and audit processes.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset within the enterprise asset register. Drives inclusion in depreciation runs, CAPEX reporting, and balance sheet presentation. under_construction maps to Assets Under Construction (AuC) in SAP FI-AA.. Valid values are `active|under_construction|retired|transferred|impaired|disposed`',
    `asset_subnumber` STRING COMMENT 'SAP FI-AA sub-number used to track components or additions to a main asset (e.g., a capital improvement to a piece of manufacturing equipment). Enables component-level tracking under a parent asset number.',
    `asset_tag_number` STRING COMMENT 'Physical asset tag or barcode number affixed to the asset for inventory tracking and physical verification purposes. Used during annual physical asset counts and GMP equipment identification audits.',
    `business_area_code` STRING COMMENT 'SAP FI business area code used to segment the asset for internal financial reporting by therapeutic area, product line, or business division (e.g., Oncology, Immunology, Rare Diseases, Consumer Health). Supports P&L reporting by therapeutic area.',
    `capex_project_number` STRING COMMENT 'Capital expenditure (CAPEX) project or appropriation request number under which the asset was approved and funded. Links the asset to the approved capital budget and supports CAPEX tracking and variance reporting.',
    `capitalization_date` DATE COMMENT 'Date on which the asset was formally capitalized and transferred from Assets Under Construction (AuC) to a productive asset class in SAP FI-AA. Marks the start of the depreciation period. May differ from acquisition_date for self-constructed assets.',
    `company_code` STRING COMMENT 'SAP FI company code representing the legal entity that owns the fixed asset. Determines the applicable accounting standards (IFRS or US GAAP), currency, and regulatory reporting requirements for the asset.',
    `cost_center_code` STRING COMMENT 'SAP CO cost center to which the fixed asset is assigned for internal cost accounting and P&L reporting. Enables allocation of depreciation charges to the responsible business unit (e.g., manufacturing, R&D, quality control, commercial). Supports P&L by therapeutic area and geography.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset master record was first created in the SAP FI-AA system. Used for audit trail, data lineage, and SOX compliance purposes.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this asset record (e.g., USD, EUR, GBP, JPY). Supports multi-currency reporting across global pharmaceutical operations.. Valid values are `^[A-Z]{3}$`',
    `deactivation_date` DATE COMMENT 'Date on which the asset was retired, disposed of, or deactivated in the SAP FI-AA asset register. Marks the end of the assets productive life and triggers the retirement posting to remove the asset from the balance sheet.',
    `depreciation_area_code` STRING COMMENT 'SAP FI-AA depreciation area identifier that specifies the valuation basis for the asset (e.g., 01 for book depreciation per local GAAP, 15 for IFRS, 20 for tax depreciation, 30 for cost accounting). Supports parallel accounting under IAS 16 and US GAAP ASC 360.',
    `depreciation_key` STRING COMMENT 'SAP FI-AA depreciation key that defines the depreciation method and calculation rules for the asset (e.g., LINR for straight-line, DGRV for declining balance, MANU for manual). Determines how periodic depreciation amounts are computed.',
    `gl_account_code` STRING COMMENT 'SAP FI General Ledger (GL) account code to which the assets acquisition cost and depreciation are posted (e.g., asset balance sheet account, accumulated depreciation account). Ensures correct financial statement classification.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number under which the fixed asset is covered. Required for insurance valuation, claims processing, and risk management reporting. Particularly relevant for high-value manufacturing equipment and laboratory instruments.',
    `insured_value` DECIMAL(18,2) COMMENT 'Replacement or insured value of the fixed asset as declared to the insurer. May differ from net book value and is used for insurance premium calculation and claims settlement. Stored in SAP FI-AA insurance data fields.',
    `is_gmp_critical` BOOLEAN COMMENT 'Indicates whether the asset is classified as GMP-critical equipment subject to qualification (IQ/OQ/PQ), periodic requalification, and regulatory inspection under 21 CFR Part 211, EU GMP, or PIC/S guidelines. True = GMP-critical; False = non-GMP.',
    `is_rd_equipment` BOOLEAN COMMENT 'Indicates whether the asset is classified as R&D equipment for the purpose of R&D capitalization analysis, tax credit eligibility, and ASC 730 / IAS 38 accounting treatment. True = R&D equipment; False = non-R&D.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the fixed asset master record in SAP FI-AA. Supports change tracking, audit trail requirements, and SOX internal controls over financial reporting.',
    `last_physical_verification_date` DATE COMMENT 'Date of the most recent physical inventory count or asset verification exercise confirming the assets existence and location. Required for SOX compliance and GMP equipment audit readiness. Corresponds to SAP FI-AA Last Inventory Date.',
    `location_code` STRING COMMENT 'Specific physical location code within the plant or facility where the asset is installed or stored (e.g., building, room, floor, warehouse location). Used for physical asset verification, GMP equipment mapping, and insurance purposes.',
    `model_number` STRING COMMENT 'Manufacturers model or part number for the fixed asset. Used for equipment qualification, spare parts identification, and procurement of replacement units in GMP-regulated manufacturing and laboratory environments.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying amount of the fixed asset, calculated as acquisition cost less accumulated depreciation and any accumulated impairment losses. Represents the assets value on the balance sheet as of the last depreciation posting period. Corresponds to SAP FI-AA Book Value.',
    `remaining_useful_life_years` STRING COMMENT 'Remaining useful economic life of the asset in years as of the last review date. Calculated as useful_life_years minus elapsed depreciation periods. Used for impairment testing and residual value assessments under IAS 36 and ASC 360.',
    `residual_value` DECIMAL(18,2) COMMENT 'Estimated amount the enterprise would currently obtain from disposal of the asset at the end of its useful life, after deducting estimated disposal costs. Used in the depreciable amount calculation. Corresponds to SAP FI-AA Scrap Value.',
    `serial_number` STRING COMMENT 'Manufacturers serial number of the fixed asset. Critical for GMP equipment qualification (IQ/OQ/PQ), maintenance tracking, warranty management, and regulatory inspection readiness. Stored in SAP FI-AA Serial Number field.',
    `useful_life_years` STRING COMMENT 'Expected useful economic life of the asset in years, as defined in the SAP FI-AA asset master. Used to calculate the annual depreciation charge under straight-line method. Must be reviewed periodically per IAS 16.51 and ASC 360-10-35-21.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Enterprise fixed asset register with complete lifecycle transaction history managed in SAP FI-AA module, covering manufacturing equipment, laboratory instruments, IT infrastructure, and leasehold improvements. Captures asset master data (asset class, acquisition date, acquisition cost, accumulated depreciation, net book value, depreciation key, useful life, location, cost center assignment) and all lifecycle transactions (acquisitions, retirements, transfers, write-ups, impairments, and periodic depreciation postings with transaction type, posting date, amount, document reference, asset value date, and depreciation area). Supports CAPEX tracking, R&D equipment capitalization, and compliance with IAS 16 / US GAAP ASC 360.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` (
    `rd_capitalization_id` BIGINT COMMENT 'Unique surrogate identifier for each R&D capitalization record in the finance domain. Primary key for the rd_capitalization data product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: R&D capitalization approvals require employee link for authorization controls and audit trail. Existing approved_by is name string; FK enables proper approval hierarchy validation for milestone-trigge',
    `compound_id` BIGINT COMMENT 'Foreign key linking to discovery.compound. Business justification: R&D capitalization decisions are compound-specific; linking capitalized costs to the specific compound enables asset tracking, impairment testing by compound, and capitalization audit trails required ',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Capitalized R&D creates an intangible fixed asset record in the asset register. The rd_capitalization currently has sap_asset_number (STRING) which should be replaced with a proper FK to fixed_asset. ',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: R&D capitalization records post to GL accounts (gl_account_code is STRING). Adding general_ledger_id FK establishes the relationship to the GL account master for capitalized R&D assets. This connects ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: R&D capitalization records should reference the internal order that collected the costs being capitalized. This provides the audit trail from cost collection to capitalization decision. Cardinality: O',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: R&D capitalization events generate journal entries to record the capitalized amount as an intangible asset. Each capitalization record should reference the journal entry that posted it. Population eve',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: R&D capitalization decisions occur at medicinal product level when development milestones are achieved (Phase III completion, regulatory approval). This link enables proper asset recognition, amortiza',
    `project_id` BIGINT COMMENT 'Foreign key linking to discovery.discovery_project. Business justification: R&D capitalization is project-based; linking to discovery projects enables milestone-based capitalization triggers, phase-specific amortization, and project-level asset valuation required for financia',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Capitalized R&D costs often tied to CMO/CRO contracts for development services, clinical trials, and manufacturing scale-up. Essential for capitalization policy compliance, cost allocation validation,',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: R&D capitalization tracking by therapeutic area is essential for segment reporting under IFRS/GAAP, impairment testing by cash-generating unit, and strategic portfolio valuation. Enables CFO to assess',
    `accounting_standard` STRING COMMENT 'The accounting standard framework under which the R&D capitalization is recognized and reported. IAS 38 (IFRS) permits capitalization of development costs meeting specific criteria; ASC 730 (US GAAP) generally requires expensing except for certain software and acquired IPR&D.. Valid values are `IAS_38|ASC_730|IFRS|US_GAAP`',
    `accumulated_amortization` DECIMAL(18,2) COMMENT 'The total amortization charged against the capitalized R&D asset from the amortization start date to the current reporting period. Used to calculate the net book value of the intangible asset.',
    `amortization_method` STRING COMMENT 'The accounting method applied to systematically allocate the capitalized R&D cost over the assets useful life. Straight-line is most common for pharmaceutical intangibles; units-of-production may apply for royalty-bearing assets.. Valid values are `straight_line|units_of_production|declining_balance`',
    `amortization_start_date` DATE COMMENT 'The date on which systematic amortization of the capitalized R&D intangible asset commences, typically aligned with the date the asset is available for use (e.g., regulatory approval date or commercial launch date).',
    `annual_amortization_amount` DECIMAL(18,2) COMMENT 'The annual amortization expense recognized in the income statement for this capitalized R&D asset, calculated based on the capitalized amount, useful life, and amortization method.',
    `approval_date` DATE COMMENT 'The date on which the capitalization decision was formally approved by the authorized finance controller or CFO delegate, as required by SOX internal controls.',
    `asset_class_code` STRING COMMENT 'SAP FI-AA asset class code categorizing the type of intangible asset for fixed asset accounting purposes (e.g., internally generated intangibles, acquired IPR&D, licensed technology).',
    `capitalization_date` DATE COMMENT 'The date on which the R&D expenditure was formally recognized as a capitalized intangible asset on the balance sheet, coinciding with or following the qualifying milestone trigger date.',
    `capitalization_number` STRING COMMENT 'Externally-known business identifier for the capitalization record, used in SAP FI/CO asset accounting and financial reporting. Follows the format CAP-YYYY-NNNNNN.. Valid values are `^CAP-[0-9]{4}-[0-9]{6}$`',
    `capitalization_status` STRING COMMENT 'Current lifecycle state of the R&D capitalization record. Tracks progression from initial recognition through active amortization, impairment, full amortization, or write-off. [ENUM-REF-CANDIDATE: draft|active|impaired|fully_amortized|written_off|under_review — promote to reference product]. Valid values are `draft|active|impaired|fully_amortized|written_off|under_review`',
    `capitalization_type` STRING COMMENT 'Classification of the nature of the capitalized R&D asset. Distinguishes between internally developed assets, acquired in-process R&D (IPR&D), licensed technology, milestone-triggered payments, and software development costs. [ENUM-REF-CANDIDATE: internal_development|acquired_iprd|licensed_technology|milestone_payment|software_development — promote to reference product]. Valid values are `internal_development|acquired_iprd|licensed_technology|milestone_payment|software_development`',
    `capitalized_amount` DECIMAL(18,2) COMMENT 'The gross monetary amount of R&D expenditure recognized as an intangible asset on the balance sheet at the point of initial capitalization, expressed in the reporting currency.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this R&D capitalization record was first created in the system, supporting audit trail requirements under SOX and 21 CFR Part 11 electronic records compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the capitalized amount and all related monetary fields (e.g., USD, EUR, GBP, JPY). Supports multi-currency reporting across FDA, EMA, MHRA, and PMDA jurisdictions.. Valid values are `^[A-Z]{3}$`',
    `development_phase` STRING COMMENT 'The clinical development phase of the drug program at the time of capitalization or as of the current reporting date. Used to assess technical feasibility criteria under IAS 38 and for R&D pipeline reporting. [ENUM-REF-CANDIDATE: preclinical|phase_i|phase_ii|phase_iii|nda_bla_filing|approved|post_approval — promote to reference product]',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The capitalized R&D amount translated into the entitys functional currency for consolidated financial reporting, applying the exchange rate at the capitalization date per IAS 21.',
    `geography_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the primary jurisdiction where the capitalized R&D asset is recognized and reported. Supports P&L reporting by geography and multi-jurisdictional regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `gl_account_code` STRING COMMENT 'SAP FI general ledger account code under which the capitalized R&D intangible asset is recorded on the balance sheet (e.g., intangible assets — development costs account).',
    `impairment_assessment_date` DATE COMMENT 'The date on which the most recent formal impairment assessment was performed for this capitalized R&D asset, as required by IAS 36 or ASC 350 at each reporting period end.',
    `impairment_indicator` BOOLEAN COMMENT 'Flag indicating whether an impairment trigger event has been identified for this capitalized R&D asset (e.g., clinical trial failure, regulatory rejection, competitive obsolescence). Triggers a formal impairment assessment per IAS 36.',
    `impairment_loss_amount` DECIMAL(18,2) COMMENT 'The monetary amount by which the carrying value of the capitalized R&D asset exceeds its recoverable amount, recognized as an impairment loss in the income statement. Null if no impairment has been recognized.',
    `impairment_reason` STRING COMMENT 'Narrative description of the reason for impairment recognition, such as clinical trial failure, regulatory rejection (FDA Complete Response Letter, EMA refusal), patent invalidation, or market withdrawal.',
    `milestone_date` DATE COMMENT 'The date on which the qualifying milestone trigger event occurred, establishing the point at which R&D expenditures meet the IAS 38 or ASC 730 criteria for capitalization.',
    `milestone_trigger` STRING COMMENT 'The specific regulatory or technical feasibility milestone that triggered the transition from expensed research costs to capitalized development costs (e.g., Phase III initiation, NDA filing, BLA submission, EMA MAA submission, IND clearance, proof-of-concept). [ENUM-REF-CANDIDATE: ind_clearance|phase_iii_initiation|nda_filing|bla_submission|maa_submission|proof_of_concept|regulatory_approval — promote to reference product]',
    `net_book_value` DECIMAL(18,2) COMMENT 'The carrying amount of the capitalized R&D intangible asset on the balance sheet, calculated as capitalized amount less accumulated amortization and any accumulated impairment losses. Key metric for financial reporting and SOX compliance.',
    `notes` STRING COMMENT 'Free-text field for additional commentary, qualifications, or disclosures related to the capitalization record, such as assumptions used in useful life estimation, basis for impairment assessment, or regulatory developments affecting the asset.',
    `reporting_entity_code` STRING COMMENT 'Code identifying the legal entity or company code within the pharmaceutical group that owns and reports the capitalized R&D asset, supporting multi-entity consolidated financial reporting.',
    `review_period_end_date` DATE COMMENT 'The financial reporting period end date (e.g., quarter-end or year-end) as of which this capitalization records carrying value, amortization, and impairment status were last reviewed and confirmed.',
    `sox_control_reference` STRING COMMENT 'Reference to the SOX internal control identifier governing the R&D capitalization process, used for audit trail and financial reporting compliance documentation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this R&D capitalization record was most recently modified, supporting change tracking, audit trail, and SOX internal control documentation.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'The estimated useful economic life of the capitalized R&D intangible asset in years, used to calculate the annual amortization charge. Reflects patent life, market exclusivity period, or expected product lifecycle.',
    CONSTRAINT pk_rd_capitalization PRIMARY KEY(`rd_capitalization_id`)
) COMMENT 'Tracks the capitalization of R&D expenditures in accordance with IAS 38 and ASC 730, capturing the transition from expensed research costs to capitalized development costs upon meeting regulatory and technical feasibility criteria. Records drug program, milestone trigger (e.g., Phase III initiation, NDA filing), capitalized amount, amortization start date, useful life, and impairment assessments.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` (
    `cogs_entry_id` BIGINT COMMENT 'Unique surrogate identifier for each COGS entry record in the silver layer lakehouse. Primary key for this data product.',
    `batch_record_id` BIGINT COMMENT 'Reference to the specific manufacturing batch from which this COGS entry originates. Enables batch-level cost traceability and variance analysis per cGMP requirements.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the general ledger account to which this COGS entry is posted. Determines the financial statement line item classification for external and internal reporting.',
    `vendor_id` BIGINT COMMENT 'Reference to the CMO or CDMO vendor record when cmo_indicator is true. Enables COGS analysis by external manufacturing partner and supports vendor performance and cost benchmarking.',
    `cost_center_id` BIGINT COMMENT 'Reference to the SAP CO cost center responsible for incurring the manufacturing costs captured in this entry. Supports cost allocation and P&L reporting by organizational unit.',
    `costing_run_id` BIGINT COMMENT 'Identifier of the SAP CO-PC costing run that generated the standard cost estimate for this entry. Enables traceability of cost roll-up calculations and standard cost updates.',
    `drug_product_id` BIGINT COMMENT 'Reference to the finished drug product (DP) or finished dosage form (FDF) for which this COGS entry is recorded. Enables COGS analysis by product, brand, and therapeutic area.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: COGS entries post to GL accounts for financial reporting. The existing gl_account_code is a STRING; adding general_ledger_id FK establishes the relationship to the GL account master. This connects cog',
    `goods_issue_id` BIGINT COMMENT 'Foreign key linking to supply.goods_issue. Business justification: Goods issues trigger COGS recognition in pharmaceutical accounting. Direct link required for inventory valuation, P&L accuracy, and audit trail from physical movement to financial posting. Standard ER',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: COGS postings triggered by goods receipts need direct linkage for inventory valuation and perpetual inventory accounting. Critical for FIFO/weighted average cost calculation, period-end inventory valu',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: COGS recognition in pharma requires tracing to specific inventory lots for actual cost determination (FIFO/FEFO). Core inventory valuation and P&L process. New FK needed to link financial postings to ',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: COGS entries generate journal entries to record the cost of goods sold and inventory relief. The cogs_entry currently has sap_costing_doc_number (STRING) which should be replaced with a proper FK to j',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or production facility where the drug product batch was produced. Supports COGS analysis by geography and manufacturing site.',
    `profit_center_id` BIGINT COMMENT 'Reference to the SAP CO profit center associated with this COGS entry. Enables P&L reporting by therapeutic area, brand, or business unit as required for management accounting.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: COGS entries for purchased materials and CMO manufacturing services require PO traceability for cost reconciliation. Essential for standard cost vs. actual PO price variance analysis, transfer pricing',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU (Stock Keeping Unit) representing the packaged, market-ready form of the drug product. Enables COGS granularity at the sellable unit level for gross margin and pricing analysis.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'The actual cost incurred for the drug product batch or SKU as recorded in SAP CO-PC actual costing. Reflects real material consumption, labor hours, and overhead absorption during production.',
    `brand_name` STRING COMMENT 'The commercial brand name of the drug product associated with this COGS entry. Supports COGS and gross margin reporting at the brand level for commercial P&L analysis.',
    `capitalization_eligible` BOOLEAN COMMENT 'Flag indicating whether this COGS entry is eligible for R&D capitalization under applicable accounting standards (e.g., IFRS IAS 38 development phase costs). Supports the finance domains R&D capitalization tracking process.',
    `cmo_indicator` BOOLEAN COMMENT 'Flag indicating whether this COGS entry relates to drug product manufactured by a Contract Manufacturing Organization (CMO) or Contract Development and Manufacturing Organization (CDMO) rather than internal manufacturing. Supports make-vs-buy cost analysis.',
    `cost_component_type` STRING COMMENT 'Classification of the cost component captured in this COGS entry. Enables granular COGS decomposition into material (API/excipients), labor, overhead absorption, depreciation, and royalty components for margin analysis. [ENUM-REF-CANDIDATE: material|labor|overhead|depreciation|royalty|contract_manufacturing|quality_control|packaging|other — promote to reference product]. Valid values are `material|labor|overhead|depreciation|royalty|other`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'The calculated cost per unit of drug product (standard or actual, per costing_type) derived from total cost divided by quantity produced. Used for pricing decisions, gross margin analysis, and transfer pricing.',
    `cost_variance_amount` DECIMAL(18,2) COMMENT 'The difference between actual cost and standard cost (actual minus standard) for this COGS entry. Positive variance indicates cost overrun; negative indicates favorable performance. Critical for manufacturing efficiency analysis and pricing decisions.',
    `costing_type` STRING COMMENT 'Classification of the costing methodology applied to this entry. Standard costing uses pre-set rates; actual costing uses real incurred costs. Determines how variances are calculated and reported.. Valid values are `standard|actual|planned|preliminary|modified_standard`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this COGS entry record was first captured in the data platform. Used for audit trail and data lineage tracking per SOX compliance requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all monetary amounts in this COGS entry are expressed (e.g., USD, EUR, JPY). Supports multi-currency COGS reporting across global manufacturing sites.. Valid values are `^[A-Z]{3}$`',
    `entry_status` STRING COMMENT 'Current lifecycle status of the COGS entry within the financial posting workflow. Controls whether the entry is included in period-close reporting and gross margin calculations.. Valid values are `draft|posted|reversed|cancelled|under_review`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month 1–12 or 1–16 depending on fiscal year variant) within the fiscal year to which this COGS entry is attributed. Supports monthly gross margin reporting and period-close reconciliation.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this COGS entry belongs, as defined in the SAP FI fiscal year variant. Used for annual P&L reporting, budget vs. actual comparisons, and SOX period-close controls.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'The cost attributable to direct and indirect labor (production operators, QC analysts, supervisors) involved in manufacturing the batch. Sourced from SAP CO-PC labor cost component and PP work center confirmations.',
    `market_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the market/geography for which this COGS entry is recorded. Enables COGS analysis by geography to support regional P&L reporting and transfer pricing compliance.. Valid values are `^[A-Z]{3}$`',
    `material_cost_amount` DECIMAL(18,2) COMMENT 'The cost attributable to raw materials, active pharmaceutical ingredients (API), excipients, and packaging materials consumed in producing the batch. Sourced from SAP CO-PC material cost component.',
    `ndc_code` STRING COMMENT 'The FDA-assigned National Drug Code (NDC) for the drug product SKU. Enables linkage of COGS data to regulatory product registrations and commercial sales data for gross margin analysis.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `overhead_absorbed_amount` DECIMAL(18,2) COMMENT 'The manufacturing overhead costs (facility, utilities, equipment depreciation, indirect costs) absorbed into the product cost using overhead rates defined in SAP CO. Represents the overhead absorption component of COGS.',
    `posting_date` DATE COMMENT 'The principal real-world financial event date on which the COGS entry was posted to the general ledger in SAP FI/CO. Determines the fiscal period to which the cost is attributed for P&L reporting.',
    `quantity_produced` DECIMAL(18,2) COMMENT 'The quantity of drug product units (tablets, vials, doses, kg) produced in the manufacturing batch to which this COGS entry relates. Used to calculate per-unit cost and yield-adjusted COGS.',
    `quantity_uom` STRING COMMENT 'The unit of measure for the quantity produced field (e.g., EA for each, KG for kilograms, TAB for tablets, VIAL for vials). Aligns with SAP MM base unit of measure for the material. [ENUM-REF-CANDIDATE: EA|KG|L|MG|ML|TAB|VIAL|DOSE — 8 candidates stripped; promote to reference product]',
    `reversal_doc_number` STRING COMMENT 'The SAP FI document number of the reversal posting if this COGS entry has been reversed. Populated only when entry_status is reversed. Supports audit trail and period-close reconciliation.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this COGS entry was sourced (e.g., SAP CO-PC for product costing, SAP PP for production orders, MES for manufacturing execution, or MANUAL for manual journal entries). Supports data lineage and reconciliation.. Valid values are `SAP_CO_PC|SAP_PP|MES|MANUAL`',
    `standard_cost_amount` DECIMAL(18,2) COMMENT 'The pre-determined standard cost for the drug product batch or SKU as calculated by the SAP CO-PC costing run. Represents the expected cost under normal operating conditions and is the baseline for variance analysis.',
    `therapeutic_area` STRING COMMENT 'The therapeutic area classification of the drug product (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular). Enables P&L and COGS analysis by therapeutic area as required for management reporting and R&D investment decisions. [ENUM-REF-CANDIDATE: oncology|immunology|rare_diseases|cardiovascular|neuroscience|infectious_disease|metabolic|respiratory|other — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this COGS entry record was last modified in the data platform. Supports change detection, incremental loads, and SOX audit trail requirements.',
    `variance_category` STRING COMMENT 'Classification of the primary driver of cost variance for this entry. Supports root cause analysis of COGS deviations: price variance (input cost changes), quantity variance (material usage), efficiency variance (labor/machine), mix variance (product mix), or volume variance (absorption).. Valid values are `price|quantity|efficiency|mix|volume|other`',
    CONSTRAINT pk_cogs_entry PRIMARY KEY(`cogs_entry_id`)
) COMMENT 'Cost of Goods Sold records by drug product, SKU, and manufacturing batch, capturing standard cost, actual cost, cost variance, material cost, labor cost, overhead absorption, and period. Sourced from SAP CO-PC (Product Costing) and PP modules. Enables COGS analysis by product, brand, therapeutic area, and geography to support gross margin reporting and pricing decisions.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` (
    `royalty_agreement_id` BIGINT COMMENT 'Unique surrogate identifier for the royalty and licensing agreement record in the enterprise data platform (Silver Layer). Primary key for this master agreement entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Royalty agreement creation tracking for contract management audit trail and licensing governance. Enables validation that agreements were entered by authorized business development or legal personnel,',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Royalty agreements specify GL accounts for accrual and payment posting (gl_account_code is STRING). Adding general_ledger_id FK links the royalty agreement to the GL account master. This connects roya',
    `compound_id` BIGINT COMMENT 'Reference to the specific compound, drug substance (DS), or active pharmaceutical ingredient (API) that is the subject of the royalty agreement. Links to the compound master record in the discovery domain for IP cost tracking of in-licensed compounds.',
    `licensing_agreement_id` BIGINT COMMENT 'Reference to the parent licensing agreement in the intellectual property domain that governs the broader IP relationship, of which this royalty agreement may be a financial component or schedule. Links to intellectual.licensing_agreement.',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: Licensor is a business_partner (bp_role=Licensor). Essential for royalty payment processing, withholding tax calculation, audit rights enforcement, and vendor master data integration. Role-prefixed ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Royalty agreements with licensors who are also vendors (common in pharma for licensed compounds, APIs, or technology). Essential for consolidated vendor spend reporting, payment coordination, and inte',
    `agreement_description` STRING COMMENT 'Free-text description of the royalty agreement summarizing the key commercial terms, licensed rights, and strategic context. Used for business user reference and reporting narratives. Not a substitute for the legal agreement document.',
    `agreement_number` STRING COMMENT 'Externally-known, human-readable agreement reference number assigned at execution (e.g., RA-2024-00123). Used for cross-system reconciliation with SAP FI/CO contract management and legal document repositories. Maps to the BUSINESS_IDENTIFIER category for MASTER_AGREEMENT role.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the royalty agreement. Draft indicates the agreement is under negotiation; active indicates it is fully executed and binding; suspended indicates temporarily paused due to dispute or regulatory hold; terminated indicates early termination by either party; expired indicates the agreement reached its natural end date. Maps to LIFECYCLE_STATUS category.. Valid values are `draft|active|suspended|terminated|expired`',
    `agreement_type` STRING COMMENT 'Classification of the royalty agreement by direction and structure of the licensing relationship. In-license covers compounds or IP acquired from external parties; out-license covers IP granted to third parties; cross-license covers mutual IP sharing; sublicense covers rights granted by a licensee to a third party; co-development covers joint R&D arrangements with shared royalty obligations. Maps to CLASSIFICATION_OR_TYPE category.. Valid values are `in_license|out_license|cross_license|sublicense|co_development`',
    `audit_frequency_years` STRING COMMENT 'Maximum frequency (in years) at which the licensor may exercise audit rights under the agreement (e.g., once every 2 years). Null when audit_rights_flag is False. Used to schedule and track audit obligations.',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether the licensor has the contractual right to audit the licensees books and records to verify royalty calculations and net sales reporting. True if audit rights are granted; False otherwise. Relevant for SOX compliance and royalty audit defense.',
    `base_royalty_rate_pct` DECIMAL(18,2) COMMENT 'The primary or base royalty rate expressed as a percentage of net sales applicable to the first tier or flat rate structure. For tiered agreements, this represents the lowest tier rate. Stored with five decimal places to accommodate fractional rates common in pharmaceutical licensing (e.g., 3.50000%). Used as the default rate in accrual calculations.',
    `cost_center_code` STRING COMMENT 'SAP CO cost center code to which royalty costs are allocated for internal management reporting. Supports P&L analysis by therapeutic area, brand, or R&D program and ROI calculation for in-licensed compounds.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty agreement record was first created in the enterprise data platform. Supports audit trail, data lineage, and SOX compliance requirements. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which royalty obligations, net sales, and payments are denominated under this agreement (e.g., USD, EUR, GBP, JPY). All monetary fields in this record are expressed in this currency. Used for multi-currency royalty accounting and FX translation in SAP FI/CO.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date on which the royalty agreement becomes legally binding and royalty obligations commence. Used to determine the start of royalty accrual periods and minimum payment schedules. Maps to EFFECTIVE_FROM category for MASTER_AGREEMENT role.',
    `execution_date` DATE COMMENT 'Date on which the royalty agreement was formally signed and executed by all parties. May differ from the effective date when agreements are backdated or have a future commencement clause. Critical for SOX audit trail and legal enforceability.',
    `expiration_date` DATE COMMENT 'Date on which the royalty agreement is scheduled to expire and royalty obligations cease. Nullable for perpetual or open-ended agreements. Used for accrual cutoff and renewal planning. Maps to EFFECTIVE_UNTIL category for MASTER_AGREEMENT role.',
    `gl_account_code` STRING COMMENT 'SAP General Ledger (GL) account code to which royalty expense or income is posted for this agreement. Enables P&L reporting by therapeutic area, brand, and geography. Aligns with the chart of accounts in SAP FI/CO for royalty accounting obligations.',
    `governing_law_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction whose laws govern the interpretation and enforcement of the royalty agreement (e.g., USA, GBR, DEU). Relevant for dispute resolution, tax treaty application, and withholding tax obligations.. Valid values are `^[A-Z]{3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty agreement record was most recently modified in the enterprise data platform. Used for change data capture, incremental processing, and audit trail. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `licensee_name` STRING COMMENT 'Legal name of the entity receiving the license rights (licensee). For in-license agreements, this is typically the pharmaceutical company itself or a subsidiary. For out-license agreements, this is the external partner receiving rights.',
    `minimum_annual_royalty_amount` DECIMAL(18,2) COMMENT 'Contractually guaranteed minimum royalty payment due to the licensor per calendar or contract year, regardless of actual net sales. If actual royalties calculated on net sales fall below this floor, the minimum amount is payable. Critical for accrual adequacy assessment and cash flow planning.',
    `net_sales_definition` STRING COMMENT 'Contractual definition of net sales as the royalty base, specifying which deductions are permitted (e.g., trade discounts, chargebacks, returns, freight, taxes, gross-to-net adjustments). Critical for accurate royalty calculation and audit defense. Stored as free text capturing the contractual language or a standardized reference code.',
    `payment_due_days` STRING COMMENT 'Number of calendar days after the close of each reporting period within which the royalty payment must be remitted to the licensor (e.g., 45 days after quarter end). Used to calculate payment due dates for each accrual period and to assess timeliness of settlements.',
    `payment_frequency` STRING COMMENT 'Contractual frequency at which royalty payments must be remitted to the licensor. Drives the accrual period schedule and payment due date calculation in SAP FI accounts payable. Quarterly is the most common frequency in pharmaceutical licensing agreements.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `royalty_rate_type` STRING COMMENT 'Structure of the royalty rate calculation methodology. Flat applies a single fixed percentage to all net sales; tiered applies different rates to different net sales bands; stepped changes the rate at defined cumulative thresholds; running is a continuous percentage; milestone_based triggers payments upon achievement of defined development or commercial milestones.. Valid values are `flat|tiered|stepped|running|milestone_based`',
    `sap_contract_number` STRING COMMENT 'Source system contract or purchase order number from SAP S/4HANA FI/CO module that corresponds to this royalty agreement. Used for financial reconciliation, accounts payable matching, and audit trail between the data lakehouse and the ERP system of record.',
    `sublicense_royalty_rate_pct` DECIMAL(18,2) COMMENT 'Royalty rate percentage applicable to sublicense revenues received by the licensee, payable to the original licensor. Applicable only when sublicensing_rights_flag is True. May differ from the standard net sales royalty rate. Null when sublicensing is not permitted.',
    `sublicensing_rights_flag` BOOLEAN COMMENT 'Indicates whether the licensee has the contractual right to grant sublicenses to third parties under this agreement. True if sublicensing is permitted; False if rights are non-sublicensable. Impacts royalty flow-through obligations and sublicense revenue sharing calculations.',
    `termination_notice_days` STRING COMMENT 'Number of calendar days of advance written notice required by either party to terminate the agreement for convenience or material breach. Used for contract lifecycle management and accrual wind-down planning.',
    `territory` STRING COMMENT 'Geographic scope of the royalty agreement defining the countries or regions where the licensee has rights to commercialize the licensed compound. Expressed as ISO 3166-1 alpha-3 country codes (comma-separated for multi-country) or a named region (e.g., WORLDWIDE, EU, USA). Drives territory-specific royalty rate application and net sales calculation.',
    `therapeutic_area` STRING COMMENT 'Therapeutic area classification of the licensed compound (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular, Neuroscience). Used for P&L reporting by therapeutic area and portfolio-level royalty cost analysis. [ENUM-REF-CANDIDATE: oncology|immunology|rare_diseases|cardiovascular|neuroscience|infectious_diseases|metabolic — promote to reference product]',
    `tier1_threshold_amount` DECIMAL(18,2) COMMENT 'Net sales threshold amount (in the agreement currency) at which the royalty rate transitions from the base rate to the tier 2 rate. For tiered agreements, net sales up to this amount are subject to base_royalty_rate_pct. Null for flat-rate agreements.',
    `tier2_royalty_rate_pct` DECIMAL(18,2) COMMENT 'Royalty rate percentage applicable to the second net sales tier for tiered or stepped royalty structures. Null for flat-rate agreements. Applied when cumulative or annual net sales exceed the tier 1 threshold defined in tier1_threshold_amount.',
    `tier2_threshold_amount` DECIMAL(18,2) COMMENT 'Net sales threshold amount (in the agreement currency) at which the royalty rate transitions from tier 2 to tier 3 rate. Null if the agreement has only two tiers or is flat-rate. Supports up to three-tier royalty structures common in pharmaceutical licensing.',
    `tier3_royalty_rate_pct` DECIMAL(18,2) COMMENT 'Royalty rate percentage applicable to net sales exceeding the tier 2 threshold for three-tier royalty structures. Null for flat-rate or two-tier agreements. Typically the highest rate in escalating structures or lowest in de-escalating structures.',
    `upfront_license_fee_amount` DECIMAL(18,2) COMMENT 'One-time non-refundable upfront payment made to the licensor upon execution of the agreement, separate from ongoing running royalties. Relevant for R&D capitalization assessment under FASB ASC 730 and IP cost tracking for in-licensed compounds.',
    `withholding_tax_rate_pct` DECIMAL(18,2) COMMENT 'Applicable withholding tax rate percentage on royalty payments as determined by the governing tax treaty between the licensor and licensee jurisdictions. Used for net payment calculation and tax reporting. Zero if no withholding tax applies under a treaty exemption.',
    CONSTRAINT pk_royalty_agreement PRIMARY KEY(`royalty_agreement_id`)
) COMMENT 'Master record and periodic accrual lifecycle for royalty and licensing agreements with external partners, universities, and IP licensors. Captures agreement terms (licensor/licensee, licensed compound, royalty rate structure including tiered rates, territory, effective dates, minimum payments, sublicensing rights, audit rights) and periodic accrual calculations (calculation period, net sales base, applicable rate tier, accrued royalty amount, currency, payment due date, settlement status). Serves as SSOT for royalty accounting obligations, IP cost tracking for in-licensed compounds, and royalty payment reconciliation across the pharmaceutical portfolio.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique surrogate identifier for each intercompany transaction record within the pharmaceutical groups consolidated financial system.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Intercompany transaction creation tracking for transfer pricing audit trail and SOX compliance. Enables validation that transactions were created by authorized finance personnel, supports transfer pri',
    `drug_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product (drug substance, drug product, or finished dosage form) involved in an intercompany product sale or transfer pricing transaction.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Intercompany transactions post to GL accounts (gl_account_code is STRING). Adding general_ledger_id FK links intercompany transactions to the GL account master. This further integrates general_ledger ',
    `intercompany_agreement_id` BIGINT COMMENT 'Reference to the master intercompany agreement or service level agreement that governs the terms, pricing, and conditions of this transaction between the two legal entities.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Intercompany transactions generate journal entries in both the sending and receiving entities. Each intercompany transaction should reference the journal entry that posted it (typically the sending en',
    `original_transaction_intercompany_transaction_id` BIGINT COMMENT 'Reference to the original intercompany transaction that this record reverses or amends. Null for original transactions; populated only for reversal or adjustment entries.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity within the pharmaceutical group that initiates and books the intercompany charge, sale, or loan as the originating party.',
    `receiving_entity_legal_entity_id` BIGINT COMMENT 'Reference to the legal entity within the pharmaceutical group that receives the intercompany charge, product, or service and records the corresponding payable or expense.',
    `royalty_agreement_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_agreement. Business justification: Intercompany royalty payments between legal entities within the pharmaceutical group should reference the governing royalty agreement. This is essential for transfer pricing compliance and audit trail',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to supply.shipment. Business justification: Cross-border shipments between affiliates create intercompany transactions for transfer pricing. Links physical movement to financial settlement, customs valuation, and withholding tax calculation. Re',
    `stock_transfer_order_id` BIGINT COMMENT 'Foreign key linking to supply.stock_transfer_order. Business justification: Intercompany stock transfers between legal entities generate IC transactions at transfer prices. Required for legal entity P&L, transfer pricing documentation, and tax compliance. Core pharma supply c',
    `transfer_price_id` BIGINT COMMENT 'Foreign key linking to finance.transfer_price. Business justification: Intercompany transactions for product transfers must reference the applicable transfer pricing record for tax compliance and audit. This is a core transfer pricing requirement. Cardinality: Many IC tr',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustments applied to the gross amount, including withholding tax, discounts, or transfer pricing true-up adjustments. Negative values represent reductions.',
    `cost_center_code` STRING COMMENT 'SAP CO cost center to which the intercompany management fee, cost allocation, or service charge is attributed on the receiving entitys books, enabling P&L reporting by therapeutic area or function.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this intercompany transaction record was first created in the system, used for audit trail and SOX compliance documentation.',
    `document_reference` STRING COMMENT 'Reference to the originating source document number (e.g., SAP FI document number, invoice number, loan agreement reference, or intercompany billing document) that triggered this transaction.',
    `elimination_date` DATE COMMENT 'The date on which the intercompany transaction was eliminated in the group consolidation process. Null if elimination has not yet occurred.',
    `elimination_status` STRING COMMENT 'Indicates whether this intercompany transaction has been eliminated in the consolidated financial statements to avoid double-counting of intra-group revenues and expenses per IFRS 10.. Valid values are `pending|eliminated|partially_eliminated|not_required`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to translate the transaction currency amount into the group reporting currency. Sourced from SAP FI exchange rate tables per IAS 21 requirements.',
    `fiscal_period` STRING COMMENT 'The accounting period (1–12 or 1–16 for special periods) within the fiscal year in which the transaction is recorded in the general ledger.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the intercompany transaction is recognized for financial reporting purposes, aligned with the pharmaceutical groups fiscal calendar.',
    `gl_account_code` STRING COMMENT 'The SAP S/4HANA general ledger account code to which the intercompany transaction is posted on the sending entitys books. Determines P&L or balance sheet classification.. Valid values are `^[0-9]{6,10}$`',
    `gross_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the intercompany transaction before any adjustments, discounts, or withholding taxes, expressed in the transaction currency.',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'The net transaction amount translated into the pharmaceutical groups reporting currency (e.g., USD) using the applicable exchange rate for consolidation and P&L reporting by therapeutic area.',
    `loan_interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applicable to intercompany loan transactions, expressed as a decimal (e.g., 0.035000 = 3.5%). Must comply with arms-length interest rate requirements under OECD BEPS guidelines.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net monetary value of the intercompany transaction after all adjustments (gross_amount + adjustment_amount). This is the amount recorded in the general ledger and used for consolidation elimination.',
    `payment_date` DATE COMMENT 'The date on which the intercompany payment was actually settled between the legal entities. Used to calculate days outstanding and assess compliance with intercompany payment terms.',
    `payment_due_date` DATE COMMENT 'The contractual due date by which the receiving entity must settle the intercompany payable. Used for cash flow forecasting and intercompany aging analysis.',
    `posting_date` DATE COMMENT 'The date on which the intercompany transaction was posted to the general ledger in SAP S/4HANA FI. May differ from transaction_date due to period-end close timing.',
    `profit_center_code` STRING COMMENT 'SAP CO profit center associated with the intercompany transaction, enabling P&L reporting by brand, therapeutic area (e.g., oncology, immunology), or geography.. Valid values are `^[A-Z0-9]{4,10}$`',
    `receiving_company_code` STRING COMMENT 'SAP S/4HANA four-character company code identifying the receiving legal entity. Used for automated intercompany matching and elimination in the consolidation system.. Valid values are `^[A-Z0-9]{4}$`',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this intercompany transaction is a reversal of a previously posted transaction. True for correcting entries or period-end accrual reversals.',
    `sending_company_code` STRING COMMENT 'SAP S/4HANA four-character company code identifying the sending legal entity. Used for automated intercompany matching and elimination in the consolidation system.. Valid values are `^[A-Z0-9]{4}$`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this intercompany transaction is subject to SOX internal control testing and documentation requirements. True for transactions above materiality thresholds or in scope of SOX key controls.',
    `therapeutic_area` STRING COMMENT 'The pharmaceutical therapeutic area associated with the intercompany transaction (e.g., product sale of an oncology drug substance). Enables P&L reporting by therapeutic area as required by segment reporting. [ENUM-REF-CANDIDATE: oncology|immunology|rare_disease|neuroscience|cardiovascular|infectious_disease|other — 7 candidates stripped; promote to reference product]',
    `tp_documentation_ref` STRING COMMENT 'Reference identifier for the transfer pricing documentation file (e.g., master file, local file, or country-by-country report) supporting the arms-length nature of this transaction per OECD BEPS Action 13.',
    `transaction_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the intercompany transaction is denominated (e.g., USD, EUR, JPY). Drives foreign currency translation for consolidation.. Valid values are `^[A-Z]{3}$`',
    `transaction_date` DATE COMMENT 'The principal real-world business event date on which the intercompany transaction was executed or the service/product was delivered between legal entities.',
    `transaction_number` STRING COMMENT 'Externally-known business reference number assigned to the intercompany transaction, used for cross-entity reconciliation and audit trail. Format: ICT-{YYYY}-{8-digit sequence}.. Valid values are `^ICT-[0-9]{4}-[0-9]{8}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle state of the intercompany transaction within the financial close and consolidation workflow. Eliminated indicates the transaction has been removed in consolidated reporting per IFRS 10.. Valid values are `draft|posted|approved|eliminated|reversed|disputed`',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction by its business nature. Drives accounting treatment, transfer pricing documentation requirements, and elimination logic. [ENUM-REF-CANDIDATE: intercompany_loan|transfer_pricing_charge|management_fee|product_sale|royalty|cost_allocation|dividend — promote to reference product]',
    `transfer_price_basis` STRING COMMENT 'The OECD-approved transfer pricing methodology used to determine the arms-length price for this intercompany transaction. CUP=Comparable Uncontrolled Price, RPM=Resale Price Method, CPM=Cost Plus Method, TNMM=Transactional Net Margin Method, PSM=Profit Split Method. [ENUM-REF-CANDIDATE: CUP|CUT|RPM|CPM|TNMM|PSM|other — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this intercompany transaction record was last modified, supporting audit trail requirements and change tracking for SOX compliance.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The monetary amount of withholding tax deducted from the intercompany payment, calculated as gross_amount × withholding_tax_rate. Relevant for royalty payments and intercompany loans.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'The withholding tax rate (as a decimal, e.g., 0.1500 = 15%) applicable to this intercompany transaction under the relevant bilateral tax treaty or domestic tax law.',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Records of financial transactions between legal entities within the pharmaceutical group, including intercompany loans, transfer pricing charges, management fee allocations, and intercompany product sales. Captures sending entity, receiving entity, transaction type, amount, currency, transfer price basis, and elimination status for consolidated financial reporting.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` (
    `tax_posting_id` BIGINT COMMENT 'Unique surrogate identifier for each tax-related financial posting record in the SAP FI-TX module. Serves as the primary key for the tax_posting data product in the Databricks Silver Layer.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Tax postings generated from AP transactions (withholding tax, VAT on purchases) should reference the source AP document. This is a nullable FK since not all tax postings are AP-related. Strengthens ac',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Tax postings generated from AR transactions should reference the source AR document. This is a nullable FK since not all tax postings are AR-related (some are AP, payroll, etc.). Provides additional i',
    `business_partner_id` BIGINT COMMENT 'The SAP vendor (LIFNR) or customer (KUNNR) account number associated with the originating transaction. Identifies the counterparty (e.g., CRO, CMO, CDMO, distributor, wholesaler, or hospital) for the taxable transaction, supporting withholding tax reporting and VAT reclaim processes.',
    `cost_center_id` BIGINT COMMENT 'Reference to the SAP CO cost center (KOSTL) to which the tax posting is allocated. Enables tax cost attribution by therapeutic area (oncology, immunology, rare diseases), manufacturing site, or R&D program for internal P&L reporting and COGS analysis.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tax posting creation tracking for tax compliance audit trail and SOX controls. Enables validation that tax entries were created by authorized tax personnel with proper training, supports tax authority',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Tax postings record to GL accounts (tax_account field is STRING). Adding general_ledger_id FK establishes the relationship to the GL account master. This connects tax_posting to general_ledger. Not re',
    `intercompany_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.intercompany_transaction. Business justification: Tax postings (withholding tax, VAT, deferred tax) related to intercompany transactions should reference the source IC transaction for audit trail and tax compliance. Cardinality: Many tax postings can',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Tax postings are specialized journal entries in SAP FI. Every tax posting generates or is associated with a journal entry that records the tax transaction in the general ledger. This is a standard par',
    `profit_center_id` BIGINT COMMENT 'Reference to the SAP CO profit center (PRCTR) associated with the tax posting. Supports P&L reporting by therapeutic area, brand, or geography and enables segment-level tax analysis for management reporting.',
    `royalty_agreement_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_agreement. Business justification: Tax postings (especially withholding tax) on royalty payments should reference the governing royalty agreement for compliance reporting and treaty benefit tracking. Cardinality: Many tax postings can ',
    `clearing_document_number` STRING COMMENT 'The SAP document number of the clearing entry that settles this tax posting against a tax payment, refund, or offset, if applicable. Populated when posting_status is cleared. Supports tax account reconciliation and cash flow reporting for tax payments.',
    `company_code` STRING COMMENT 'The four-character SAP company code (BUKRS) representing the legal entity or subsidiary within the pharmaceutical enterprise for which the tax posting is recorded. Supports P&L reporting by legal entity and multi-jurisdictional tax compliance.',
    `country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 country code of the tax jurisdiction where the tax liability arises. Used to determine applicable tax authority (FDA/IRS for USA, EMA/national authorities for EU member states, MHRA for GBR, PMDA for JPN, NMPA for CHN) and applicable tax treaty.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the tax posting record was first created in the source SAP FI-TX system. Supports audit trail requirements under SOX Section 404 and 21 CFR Part 11 for electronic records and signatures in pharmaceutical financial systems.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code of the originating transaction document (WAERS in SAP). Identifies the transaction currency for cross-border pharmaceutical sales, royalty payments, and intercompany transfers subject to withholding tax.. Valid values are `^[A-Z]{3}$`',
    `deductible_pct` DECIMAL(18,2) COMMENT 'The percentage of input tax that is recoverable when a pharmaceutical entity makes both taxable and exempt supplies (partial exemption / pro-rata recovery). Calculated per the applicable tax authoritys partial exemption method and applied to determine the recoverable portion of input VAT.',
    `document_date` DATE COMMENT 'The date of the originating business document (BLDAT) such as an invoice, credit memo, or customs declaration that triggered the tax posting. May differ from posting_date and is used for tax point determination under VAT rules.',
    `document_number` STRING COMMENT 'The SAP FI accounting document number (BELNR) that uniquely identifies the financial document containing this tax posting within a company code and fiscal year. Used for cross-referencing with the general ledger and accounts payable/receivable.',
    `document_type` STRING COMMENT 'The SAP document type code (BLART) classifying the originating financial document (e.g., KR=vendor invoice, DR=customer invoice, KZ=vendor payment, SA=general ledger posting). Determines the number range and posting rules for the tax entry.',
    `fiscal_period` STRING COMMENT 'The fiscal posting period (MONAT, 1–16 in SAP) within the fiscal year in which the tax entry is recorded. Supports monthly and quarterly indirect tax reporting and VAT return filing cycles.',
    `fiscal_year` STRING COMMENT 'The fiscal year (GJAHR) in which the tax posting is recorded in SAP FI. Used for period-end tax reporting, annual tax return preparation, and SOX-compliant financial close processes.',
    `is_deductible` BOOLEAN COMMENT 'Indicates whether the input tax amount on this posting is fully deductible (recoverable) from the tax authority. Non-deductible input tax arises on purchases used for exempt pharmaceutical activities (e.g., certain clinical trial services or exempt healthcare supplies). Drives VAT recovery calculations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to the tax posting record in the source SAP FI-TX system. Used for incremental data loading into the Databricks Silver Layer and for change audit trail compliance under SOX and 21 CFR Part 11.',
    `local_currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code of the company code local currency (HWAER in SAP). Used for statutory tax reporting and local tax authority submissions in the jurisdiction of the legal entity.. Valid values are `^[A-Z]{3}$`',
    `plant_code` STRING COMMENT 'The SAP plant code (WERKS) identifying the manufacturing or distribution facility associated with the taxable transaction. Relevant for excise tax, customs duty, and VAT on pharmaceutical manufacturing activities subject to cGMP and GDP regulations.',
    `posting_date` DATE COMMENT 'The date (BUDAT) on which the tax posting is recorded in the SAP general ledger. Determines the fiscal period assignment and is the primary date used for tax period reporting and VAT return preparation.',
    `posting_status` STRING COMMENT 'Current lifecycle status of the tax posting in SAP FI. Posted indicates a confirmed accounting entry; reversed indicates the posting has been cancelled via a reversal document; cleared indicates the tax account has been cleared against a tax payment or refund; parked indicates a preliminary entry pending approval; blocked indicates the posting is held for review.. Valid values are `posted|reversed|cleared|parked|blocked`',
    `posting_type` STRING COMMENT 'Indicates whether the tax posting represents output tax (collected on pharmaceutical product sales), input tax (recoverable on purchases of raw materials, API, or services), withholding tax on royalties or intercompany payments, or deferred tax asset/liability per IFRS IAS 12.. Valid values are `output_tax|input_tax|withholding|deferred_tax_asset|deferred_tax_liability`',
    `reference_document_number` STRING COMMENT 'External reference number (XBLNR in SAP) from the originating business document such as a vendor invoice number, customer purchase order, customs entry number, or intercompany billing document. Used to trace the tax posting back to the source transaction for audit and tax return reconciliation.',
    `reversal_date` DATE COMMENT 'The date on which the reversal document was posted in SAP FI, if this tax posting has been reversed. Used for period-end reconciliation and to ensure reversed postings are excluded from tax return submissions.',
    `reversal_document_number` STRING COMMENT 'The SAP document number of the reversal entry that cancels this tax posting, if applicable. Populated when posting_status is reversed. Supports audit trail requirements under SOX and 21 CFR Part 11 for electronic records integrity.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this tax posting was sourced (e.g., SAP FI-TX, SAP S/4HANA). Supports data lineage tracking in the Databricks Lakehouse Silver Layer and enables multi-system reconciliation during ERP migrations or parallel-run periods.. Valid values are `SAP_FI_TX|SAP_S4HANA|legacy_ERP`',
    `tax_account` STRING COMMENT 'The SAP general ledger account number (HKONT) to which the tax amount is posted. Identifies the specific tax liability or tax receivable account in the chart of accounts, enabling tax account reconciliation and balance sheet reporting under IFRS IAS 12.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount (HWSTE in SAP) in the company code local currency. Represents the actual tax liability or recoverable input tax for this posting. Used for VAT return preparation, tax account reconciliation, and indirect tax compliance reporting.',
    `tax_amount_doc_currency` DECIMAL(18,2) COMMENT 'The tax amount expressed in the original transaction document currency (FWSTE in SAP). Relevant for cross-border pharmaceutical transactions where the invoice currency differs from the company code local currency, supporting foreign currency tax reporting.',
    `tax_base_amount` DECIMAL(18,2) COMMENT 'The net taxable base amount (HWBAS in SAP, in local currency) upon which the tax is calculated. Represents the value of the pharmaceutical product sale, service, or intercompany transaction subject to tax before the tax amount is applied.',
    `tax_code` STRING COMMENT 'The SAP tax code (MWSKZ) that identifies the applicable tax rate, tax type, and tax procedure for the posting. Encodes the combination of tax category (input/output), jurisdiction, and rate applicable to the pharmaceutical product or service transaction.',
    `tax_jurisdiction_code` STRING COMMENT 'The SAP tax jurisdiction code (TXJCD) identifying the specific geographic tax authority (federal, state/province, county, city) to which the tax is owed. Critical for multi-jurisdictional pharmaceutical sales and manufacturing operations across FDA, EMA, MHRA, and PMDA regulated markets.',
    `tax_rate` DECIMAL(18,2) COMMENT 'The applicable tax rate as a percentage (e.g., 20.0000 for 20% VAT) used to calculate the tax amount from the taxable base. Derived from the tax code configuration in SAP FI-TX and varies by jurisdiction, product classification, and applicable tax treaty.',
    `tax_registration_number` STRING COMMENT 'The tax registration number of the counterparty (vendor or customer) involved in the taxable transaction, such as a VAT registration number (EU), Employer Identification Number (US), or equivalent. Required for EC Sales List reporting, Intrastat, and cross-border VAT compliance in pharmaceutical distribution.',
    `tax_reporting_period` STRING COMMENT 'The calendar year and month (YYYY-MM format) of the tax reporting period to which this posting belongs for indirect tax return purposes. May differ from the SAP fiscal period when the company uses a non-calendar fiscal year. Used for VAT return filing, Intrastat reporting, and withholding tax declarations.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `tax_return_reference` STRING COMMENT 'The reference number of the periodic tax return (VAT return, sales tax return, or withholding tax declaration) to which this posting has been assigned. Enables reconciliation between individual tax postings and filed tax returns submitted to FDA-regulated markets, EU member states, HMRC, PMDA, or other tax authorities.',
    `tax_type` STRING COMMENT 'Classification of the tax category applicable to this posting. Distinguishes between Value Added Tax (VAT), sales tax, withholding tax on royalties or intercompany payments, deferred tax, customs duty on API imports, and excise tax on pharmaceutical products. [ENUM-REF-CANDIDATE: VAT|sales_tax|withholding_tax|deferred_tax|customs_duty|excise_tax — promote to reference product]. Valid values are `VAT|sales_tax|withholding_tax|deferred_tax|customs_duty|excise_tax`',
    `therapeutic_area` STRING COMMENT 'The pharmaceutical therapeutic area associated with the product or program that generated the taxable transaction. Enables tax cost allocation and P&L reporting by therapeutic area (e.g., oncology, immunology, rare diseases) as required for management reporting and R&D capitalization analysis. [ENUM-REF-CANDIDATE: oncology|immunology|rare_diseases|neuroscience|cardiovascular|infectious_diseases|other — promote to reference product]',
    CONSTRAINT pk_tax_posting PRIMARY KEY(`tax_posting_id`)
) COMMENT 'Tax-related financial postings including VAT, sales tax, withholding tax, and deferred tax entries managed in SAP FI-TX. Captures tax code, tax jurisdiction, taxable base amount, tax amount, tax account, reporting period, and tax return reference. Supports indirect tax compliance across multiple jurisdictions where pharmaceutical products are sold or manufactured.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` (
    `milestone_payment_id` BIGINT COMMENT 'Unique system-generated identifier for each milestone payment obligation or receipt record. Primary key for the milestone_payment data product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Milestone payment approvals require employee link for authorization controls and audit trail. Existing approved_by is name string; FK enables proper approval hierarchy validation for licensing milesto',
    `business_partner_id` BIGINT COMMENT 'System identifier for the external counterparty (vendor or customer) in the SAP master data. Links to the vendor/customer master record for the partner organization.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the General Ledger account to which this milestone payment is posted in SAP FI. Determines the financial statement line item for the payment.',
    `cost_center_id` BIGINT COMMENT 'Reference to the SAP cost center responsible for this milestone payment obligation. Used for departmental cost allocation and management reporting.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Each milestone payment triggers a journal entry for the financial posting. The milestone_payment currently has sap_document_number (STRING) which should be replaced with a proper FK to journal_entry. ',
    `licensing_agreement_id` BIGINT COMMENT 'Reference to the parent licensing, collaboration, or partnership agreement under which this milestone payment obligation was established.',
    `profit_center_id` BIGINT COMMENT 'Reference to the SAP profit center for P&L reporting of this milestone payment by business unit, brand, or therapeutic area.',
    `project_id` BIGINT COMMENT 'Foreign key linking to discovery.discovery_project. Business justification: Milestone payments (in/out-licensing) are project-specific; linking enables accrual tracking, contingent liability management, portfolio valuation, and cash flow forecasting essential to pharmaceutica',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Milestone payments to CRO/CMO vendors for development and manufacturing milestones require vendor linkage for payment processing, vendor performance tracking, and consolidated spend reporting. Critica',
    `accounting_treatment` STRING COMMENT 'Accounting classification applied to this milestone payment per applicable accounting standards: rd_expense (expensed as R&D), capitalize (capitalized as intangible asset), cogs (recognized as cost of goods sold), deferred_revenue (deferred until performance obligation met), contingent_liability (disclosed as contingent liability until triggered).. Valid values are `rd_expense|capitalize|cogs|deferred_revenue|contingent_liability`',
    `approval_date` DATE COMMENT 'Date on which the milestone payment was formally approved by the authorized approver. Part of the SOX-compliant audit trail for financial disbursements.',
    `approval_status` STRING COMMENT 'Internal approval workflow status for the milestone payment. Tracks whether the payment has been reviewed and authorized by the appropriate financial and legal stakeholders before processing.. Valid values are `pending_approval|approved|rejected|escalated`',
    `company_code` STRING COMMENT 'Four-character SAP company code identifying the legal entity responsible for this milestone payment. Determines the applicable accounting standards, currency, and regulatory jurisdiction.. Valid values are `^[A-Z0-9]{4}$`',
    `contractual_amount` DECIMAL(18,2) COMMENT 'The gross payment amount as specified in the partnership or licensing agreement for this milestone, in the contract currency. This is the base obligation before any adjustments, withholding taxes, or FX conversion.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone payment record was first created in the system. Part of the mandatory audit trail for SOX-compliant financial records.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the contractual milestone payment amount (e.g., USD, EUR, JPY, GBP). Defines the denomination of the contractual_amount field.. Valid values are `^[A-Z]{3}$`',
    `development_stage` STRING COMMENT 'Development stage of the associated drug program at the time the milestone is triggered (e.g., preclinical, Phase 1, Phase 2, Phase 3, NDA/BLA Filed). Used for R&D capitalization assessment and program tracking. [ENUM-REF-CANDIDATE: discovery|preclinical|phase_1|phase_2|phase_3|nda_bla_filed|approved|commercial — promote to reference product]. Valid values are `discovery|preclinical|phase_1|phase_2|phase_3|nda_bla_filed`',
    `expected_trigger_date` DATE COMMENT 'Projected date by which the triggering event is expected to occur, based on current program timelines. Used for contingent liability forecasting and cash flow planning.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Milestone payment amount converted to the companys functional currency (typically USD) using the applicable exchange rate at the time of recognition or payment. Used for consolidated financial reporting.',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the companys functional currency used in the functional_currency_amount field (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert the contractual_amount from contract currency to functional currency at the time of recognition or payment. Sourced from SAP FI treasury rates.',
    `is_capitalized` BOOLEAN COMMENT 'Indicates whether this milestone payment has been capitalized as an intangible asset on the balance sheet rather than expensed. Applicable when the payment relates to a product that has received regulatory approval and meets capitalization criteria.',
    `is_contingent_liability` BOOLEAN COMMENT 'Indicates whether this milestone payment represents a contingent liability that must be disclosed in financial statements prior to the triggering event occurring. True if the payment obligation is contingent on a future uncertain event.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this milestone payment record. Supports audit trail requirements and change tracking for SOX compliance.',
    `milestone_name` STRING COMMENT 'Descriptive name of the milestone payment as defined in the contractual agreement (e.g., Phase II Completion Payment, NDA Approval Milestone, First Commercial Sale Milestone).',
    `milestone_number` STRING COMMENT 'Externally-known business identifier for this milestone payment, typically referenced in the partnership agreement schedule. Format: MS-{YEAR}-{SEQUENCE}.. Valid values are `^MS-[0-9]{4}-[0-9]{4}$`',
    `milestone_type` STRING COMMENT 'Classification of the milestone by the nature of the triggering event: development (e.g., IND filing, Phase completion), regulatory (e.g., NDA/BLA/MAA approval), commercial (e.g., first commercial sale), sales_threshold (e.g., net sales exceeding a defined threshold), or technical (e.g., target validation, candidate nomination). [ENUM-REF-CANDIDATE: development|regulatory|commercial|sales_threshold|technical|preclinical — promote to reference product]. Valid values are `development|regulatory|commercial|sales_threshold|technical`',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'Actual net amount paid or received after deducting withholding taxes and any other contractual adjustments from the contractual_amount. Represents the cash flow impact.',
    `notes` STRING COMMENT 'Free-text field for additional context, legal commentary, dispute details, or operational notes related to this milestone payment record.',
    `payment_date` DATE COMMENT 'Actual date on which the milestone payment was settled (funds transferred or received). Null if payment has not yet been made.',
    `payment_direction` STRING COMMENT 'Indicates whether this milestone payment is an obligation owed by the company to a counterparty (payable) or a receipt due from a counterparty (receivable). Critical for balance sheet classification and contingent liability disclosure.. Valid values are `payable|receivable`',
    `payment_due_date` DATE COMMENT 'Contractually defined date by which the milestone payment must be made or received following the triggering event. Typically calculated as triggering event date plus contractual payment terms (e.g., net 30/60 days).',
    `payment_status` STRING COMMENT 'Current lifecycle state of the milestone payment obligation. Pending: milestone not yet achieved; Triggered: triggering event has occurred and payment is due; Approved: payment approved for processing; Paid: payment has been settled; Waived: contractually waived; Disputed: under dispute resolution.. Valid values are `pending|triggered|approved|paid|waived|disputed`',
    `source_system` STRING COMMENT 'Identifier of the operational system of record from which this milestone payment record originated (e.g., SAP_FI for SAP Finance, VEEVA_VAULT for contract management, MANUAL for manually entered records).. Valid values are `SAP_FI|VEEVA_VAULT|MANUAL|CTMS`',
    `therapeutic_area` STRING COMMENT 'Therapeutic area classification of the drug program associated with this milestone (e.g., Oncology, Immunology, Rare Diseases, Neuroscience). Enables P&L reporting by therapeutic area.',
    `triggering_event` STRING COMMENT 'Description of the specific contractual event that triggers this milestone payment (e.g., IND Filing Accepted by FDA, Phase II Primary Endpoint Met, NDA Approval Received, First Commercial Sale in US, Annual Net Sales Exceed $500M).',
    `triggering_event_date` DATE COMMENT 'The actual date on which the contractual triggering event occurred, confirming the milestone has been achieved and the payment obligation is activated. Null if the milestone has not yet been triggered.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from the milestone payment as required by applicable tax treaties or local tax regulations. Reduces the net payment amount received or paid.',
    CONSTRAINT pk_milestone_payment PRIMARY KEY(`milestone_payment_id`)
) COMMENT 'Tracks contractual milestone-based payment obligations and receipts triggered by development, regulatory, or commercial events in pharmaceutical partnerships. Captures milestone type (e.g., IND filing, Phase II completion, NDA approval, first commercial sale, sales thresholds), triggering event date, contractual payment amount, currency, counterparty, associated internal order, payment status, and accounting treatment. Distinct from internal_order (which collects all costs for a program) — milestone_payment owns the individual contractual obligation record and its trigger-based lifecycle. Critical for R&D partnership financial management and contingent liability disclosure.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` (
    `transfer_price_id` BIGINT COMMENT 'Unique surrogate identifier for the transfer pricing master record governing intercompany transactions between related legal entities.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Transfer price approvals require employee link for authorization controls and audit trail. Existing approved_by is name string; FK enables proper approval hierarchy validation for arms length pricing',
    `cost_center_id` BIGINT COMMENT 'Reference to the SAP cost center responsible for the intercompany transfer pricing arrangement. Used for internal P&L allocation and management reporting by therapeutic area or geography.',
    `drug_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product, drug substance (DS), drug product (DP), active pharmaceutical ingredient (API), or finished dosage form (FDF) subject to this transfer price.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that is the seller or supplier in the intercompany transaction (the entity transferring the product, API, or service).',
    `prior_version_transfer_price_id` BIGINT COMMENT 'Reference to the immediately preceding version of this transfer price record (self-referential). Enables reconstruction of the full price history chain for audit and tax authority documentation purposes.',
    `profit_center_id` BIGINT COMMENT 'Reference to the SAP profit center associated with the intercompany transaction. Enables P&L reporting by therapeutic area, brand, or geography in SAP S/4HANA CO-PCA.',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Intercompany supply contracts reference transfer pricing policies for arms length validation and transfer pricing compliance. Essential for pharmaceutical companies with global manufacturing networks',
    `apa_reference` STRING COMMENT 'Reference to an Advance Pricing Agreement (APA) or bilateral APA (BAPA) concluded with one or more tax authorities that pre-approves the transfer pricing methodology and price range for this transaction. Null if no APA is in place.',
    `approval_date` DATE COMMENT 'The date on which the transfer price was formally approved by the authorized approver (e.g., Head of Tax, CFO, or Transfer Pricing Committee) in accordance with SOX-compliant approval workflows.',
    `approved_price` DECIMAL(18,2) COMMENT 'The arms-length intercompany price approved for the transfer of the product or service per unit, expressed in the transaction currency. This is the operative price used in intercompany invoicing.',
    `arm_length_range_max` DECIMAL(18,2) COMMENT 'The upper bound of the arms-length price range (interquartile range) established through benchmarking analysis. The approved transfer price must fall within this range to satisfy OECD and local tax authority requirements.',
    `arm_length_range_min` DECIMAL(18,2) COMMENT 'The lower bound of the arms-length price range (interquartile range) established through benchmarking analysis. The approved transfer price must fall within this range to satisfy OECD and local tax authority requirements.',
    `benchmarking_study_ref` STRING COMMENT 'Document reference number or identifier for the economic benchmarking study (comparables analysis) that supports the arms-length determination for this transfer price. Links to the transfer pricing documentation file.',
    `cost_base_amount` DECIMAL(18,2) COMMENT 'The total cost base (direct manufacturing cost, overhead, and allocated R&D) used as the starting point for cost-plus or TNMM pricing method calculations. Expressed in the transaction currency.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this transfer price record was first created in the system, in ISO 8601 format with timezone offset. Supports SOX audit trail and 21 CFR Part 11 electronic record requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the approved transfer price is denominated (e.g., USD, EUR, JPY, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date from which this transfer price record becomes binding and operative for intercompany invoicing between the sending and receiving legal entities.',
    `expiry_date` DATE COMMENT 'The date on which this transfer price record ceases to be operative. Null indicates an open-ended record with no defined expiry. Superseded records will have this date set to the day before the successor records effective date.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this transfer price record was most recently modified, in ISO 8601 format with timezone offset. Supports SOX audit trail and change management tracking.',
    `markup_pct` DECIMAL(18,2) COMMENT 'The arms-length markup percentage applied to the cost base to arrive at the approved transfer price under cost-plus or TNMM methodology. Expressed as a decimal percentage (e.g., 15.0000 = 15%).',
    `next_review_date` DATE COMMENT 'The date by which the next periodic review of this transfer price must be completed to maintain arms-length compliance and update the supporting documentation.',
    `notes` STRING COMMENT 'Free-text field for additional commentary, rationale, or context regarding the transfer price determination, including any deviations from standard methodology or special circumstances noted by the transfer pricing team.',
    `price_per_unit_of_measure` STRING COMMENT 'The unit of measure to which the approved transfer price applies (e.g., per kg of API, per vial of drug product, per batch). Aligns with SAP S/4HANA base unit of measure on the material master. [ENUM-REF-CANDIDATE: kg|g|mg|L|mL|unit|vial|tablet|capsule|batch — 10 candidates stripped; promote to reference product]',
    `pricing_method` STRING COMMENT 'OECD-recognized transfer pricing methodology applied to determine the arms-length price. CUP = Comparable Uncontrolled Price; TNMM = Transactional Net Margin Method; RPM = Resale Price Method; PSM = Profit Split Method; cost_plus = Cost-Plus Method.. Valid values are `CUP|cost_plus|TNMM|RPM|PSM`',
    `product_lifecycle_stage` STRING COMMENT 'The commercial lifecycle stage of the pharmaceutical product at the time this transfer price is established. Influences the pricing methodology and markup applied (e.g., pre-launch products may use cost-plus; commercial products may use CUP).. Valid values are `preclinical|clinical|pre_launch|commercial|mature|end_of_life`',
    `product_type` STRING COMMENT 'Classification of the item or service subject to the transfer price. Distinguishes between active pharmaceutical ingredients (API), drug substance (DS), finished drug product (DP), finished dosage form (FDF), contract manufacturing services, or intellectual property royalty arrangements. [ENUM-REF-CANDIDATE: API|drug_substance|drug_product|FDF|service|CMO_service|IP_royalty — promote to reference product]',
    `receiving_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction in which the receiving legal entity is domiciled. Used for bilateral tax treaty analysis and OECD country-by-country reporting.. Valid values are `^[A-Z]{3}$`',
    `record_number` STRING COMMENT 'Externally-known business identifier for the transfer pricing record, used in intercompany agreements, tax authority documentation, and OECD compliance filings. Format: TP-YYYY-NNNNNN.. Valid values are `^TP-[0-9]{4}-[0-9]{6}$`',
    `record_status` STRING COMMENT 'Current lifecycle state of the transfer pricing record. Active records govern live intercompany transactions; superseded records have been replaced by a newer version. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|superseded|expired|cancelled — promote to reference product]',
    `regulatory_doc_ref` STRING COMMENT 'Reference to the formal transfer pricing documentation package (local file, master file, or country-by-country report) filed with tax authorities in accordance with OECD BEPS Action 13 requirements. May reference a Veeva Vault document ID or SAP document number.',
    `review_frequency` STRING COMMENT 'The scheduled frequency at which this transfer price is reviewed and potentially revised to ensure continued arms-length compliance. Annual review is the OECD standard minimum.. Valid values are `annual|semi_annual|quarterly|ad_hoc`',
    `sending_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction in which the sending legal entity is domiciled. Used for bilateral tax treaty analysis and OECD country-by-country reporting.. Valid values are `^[A-Z]{3}$`',
    `source_system` STRING COMMENT 'The operational system of record from which this transfer price record originates (e.g., SAP S/4HANA FI/CO, manual entry via spreadsheet, or a Regulatory Information Management System). Supports data lineage tracking in the Databricks Silver layer.. Valid values are `SAP_S4HANA|manual|RIMS|other`',
    `tax_ruling_ref` STRING COMMENT 'Reference to any binding tax ruling, private letter ruling, or competent authority agreement issued by a tax authority that specifically governs or validates this transfer pricing arrangement.',
    `therapeutic_area` STRING COMMENT 'The therapeutic area classification of the pharmaceutical product subject to the transfer price (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular). Supports P&L reporting by therapeutic area and R&D ROI analysis.',
    `transaction_type` STRING COMMENT 'Nature of the intercompany transaction governed by this transfer price: tangible goods (products/APIs), services (manufacturing, R&D, distribution), IP licensing, cost-sharing arrangements, or intercompany loans.. Valid values are `goods|services|IP_license|cost_sharing|loan`',
    `version_number` STRING COMMENT 'Sequential version number of the transfer price record for a given product-entity pair. Incremented each time the price is revised. Enables audit trail and historical price reconstruction for tax authority inquiries.',
    `withholding_tax_applicable` BOOLEAN COMMENT 'Indicates whether withholding tax applies to the intercompany transaction governed by this transfer price (e.g., royalty payments or service fees may be subject to withholding tax under bilateral tax treaties).',
    `withholding_tax_rate_pct` DECIMAL(18,2) COMMENT 'The applicable withholding tax rate (as a decimal percentage) on the intercompany payment, as determined by the bilateral tax treaty between the sending and receiving entity jurisdictions. Null if withholding_tax_applicable is False.',
    CONSTRAINT pk_transfer_price PRIMARY KEY(`transfer_price_id`)
) COMMENT 'Transfer pricing master records governing the prices at which pharmaceutical products, APIs, and services are transacted between related legal entities across jurisdictions. Captures product or service, sending entity, receiving entity, transfer price method (CUP, cost-plus, TNMM), approved price, currency, effective date, and regulatory documentation reference. Supports OECD transfer pricing compliance and tax authority documentation.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key for payment_run',
    `bank_account_id` BIGINT COMMENT 'Reference to the company bank account from which payments in this run will be disbursed.',
    `created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who initiated and created this payment run.',
    `employee_id` BIGINT COMMENT 'Reference to the user who provided final approval for the payment run execution.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (operating company or subsidiary) executing this payment run.',
    `payment_batch_id` BIGINT COMMENT 'External batch identifier assigned by the banking system or payment processor for tracking and reconciliation.',
    `prior_payment_run_id` BIGINT COMMENT 'Self-referencing FK on payment_run (prior_payment_run_id)',
    `approval_status` STRING COMMENT 'Current approval state of the payment run within the authorization workflow.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the payment run received final approval to proceed.',
    `confirmation_number` STRING COMMENT 'Confirmation or acknowledgment number received from the bank or payment processor upon successful file receipt.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the payment run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment run (e.g., USD, EUR, GBP).',
    `payment_run_description` STRING COMMENT 'Free-text description providing additional context about the purpose or scope of this payment run.',
    `error_count` STRING COMMENT 'Number of payment transactions within the run that encountered errors or failed validation.',
    `error_message` STRING COMMENT 'Consolidated error messages or failure reasons for the payment run, used for troubleshooting and resolution.',
    `execution_timestamp` TIMESTAMP COMMENT 'The precise date and time when the payment run was executed and payments were initiated.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year when this payment run is recorded.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this payment run is recorded for financial reporting purposes.',
    `gl_posting_date` DATE COMMENT 'The accounting period date when the payment run transactions were posted to the general ledger.',
    `is_test_run` BOOLEAN COMMENT 'Boolean flag indicating whether this is a test or simulation run (true) or a live production payment run (false).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the payment run record was last updated or modified.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the payment run for operational reference and audit trail.',
    `payment_category` STRING COMMENT 'Classification of the payment run by recipient type or payment purpose for financial reporting and analysis.',
    `payment_count` STRING COMMENT 'Total number of individual payment transactions included in this payment run.',
    `payment_file_name` STRING COMMENT 'Name of the payment file generated for transmission to the bank or payment processor.',
    `payment_file_path` STRING COMMENT 'Storage location or file path where the payment file is archived for audit and compliance purposes.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used for disbursements in this run (e.g., Automated Clearing House, wire transfer, physical check).',
    `processing_priority` STRING COMMENT 'Priority level assigned to the payment run for queue management and execution sequencing.',
    `reconciled_timestamp` TIMESTAMP COMMENT 'Date and time when the payment run was successfully reconciled with banking records.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether the payment run has been reconciled with bank statements and general ledger postings.',
    `run_number` STRING COMMENT 'Business identifier for the payment run, formatted as PR-YYYYMMDD-NNNN for external reference and audit tracking.',
    `run_type` STRING COMMENT 'Classification of the payment run indicating its purpose and processing priority.',
    `scheduled_date` DATE COMMENT 'The planned date when the payment run is scheduled to execute and disburse funds.',
    `payment_run_status` STRING COMMENT 'Current lifecycle status of the payment run in the payment processing workflow.',
    `total_amount` DECIMAL(18,2) COMMENT 'The aggregate monetary value of all payments in this run before any adjustments or fees.',
    `transmission_timestamp` TIMESTAMP COMMENT 'Date and time when the payment file was transmitted to the bank or payment processor.',
    `value_date` DATE COMMENT 'The effective date when funds are to be available to payees, used for cash flow planning and bank reconciliation.',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Master reference table for payment_run. Referenced by payment_run_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Primary key for bank_account',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for transactions in this bank account.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that owns or controls this bank account.',
    `master_account_id` BIGINT COMMENT 'Reference to the master bank account if this is a subsidiary or zero balance account. Null if this is a standalone account.',
    `parent_bank_account_id` BIGINT COMMENT 'Self-referencing FK on bank_account (parent_bank_account_id)',
    `account_holder_name` STRING COMMENT 'The legal name of the primary account holder as registered with the bank.',
    `account_manager_email` STRING COMMENT 'The email address of the bank relationship manager for this account.',
    `account_manager_name` STRING COMMENT 'The name of the relationship manager or account officer at the bank responsible for this account.',
    `account_manager_phone` STRING COMMENT 'The phone number of the bank relationship manager for this account.',
    `account_name` STRING COMMENT 'The official name or title of the bank account as registered with the financial institution.',
    `account_number` STRING COMMENT 'The unique account number assigned by the financial institution. May be IBAN format for international accounts or domestic format.',
    `account_purpose` STRING COMMENT 'The business purpose or function of the bank account (e.g., operating expenses, payroll disbursement, R&D funding, royalty collections).',
    `account_status` STRING COMMENT 'Current operational status of the bank account in its lifecycle.',
    `account_type` STRING COMMENT 'Classification of the bank account based on its purpose and functionality.',
    `available_balance` DECIMAL(18,2) COMMENT 'The available balance in the bank account after accounting for holds, pending transactions, and reserved funds.',
    `bank_identifier_code` STRING COMMENT 'The BIC or SWIFT code uniquely identifying the financial institution for international transactions.',
    `bank_name` STRING COMMENT 'The legal name of the financial institution holding the account.',
    `branch_address` STRING COMMENT 'The physical address of the bank branch holding the account.',
    `branch_city` STRING COMMENT 'The city where the bank branch is located.',
    `branch_code` STRING COMMENT 'The unique code identifying the bank branch within the financial institutions network.',
    `branch_country_code` STRING COMMENT 'Three-letter ISO country code for the country where the bank branch is located.',
    `branch_name` STRING COMMENT 'The name of the specific bank branch where the account is held.',
    `closing_date` DATE COMMENT 'The date when the bank account was closed or deactivated. Null if the account is still open.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code representing the primary currency of the bank account.',
    `current_balance` DECIMAL(18,2) COMMENT 'The current balance of the bank account in the accounts primary currency as of the last reconciliation.',
    `general_ledger_account_code` STRING COMMENT 'The GL account code in the chart of accounts to which this bank account is mapped for financial reporting.',
    `interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate applied to the bank account balance, expressed as a decimal (e.g., 0.0250 for 2.50%).',
    `is_primary_account` BOOLEAN COMMENT 'Indicates whether this is the primary operating bank account for the legal entity or cost center.',
    `is_zero_balance_account` BOOLEAN COMMENT 'Indicates whether this is a zero balance account that automatically sweeps funds to or from a master account.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was last updated in the system.',
    `last_reconciliation_date` DATE COMMENT 'The date when the bank account was last reconciled with bank statements.',
    `minimum_balance_requirement` DECIMAL(18,2) COMMENT 'The minimum balance that must be maintained in the account to avoid fees or penalties.',
    `next_reconciliation_due_date` DATE COMMENT 'The date by which the next bank reconciliation must be completed.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the bank account.',
    `opening_date` DATE COMMENT 'The date when the bank account was opened and became active.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'The maximum overdraft or credit limit allowed on this bank account. Null if no overdraft facility exists.',
    `routing_number` STRING COMMENT 'The domestic routing number, ABA number, or sort code used to identify the bank branch for electronic transfers.',
    `sox_compliant_flag` BOOLEAN COMMENT 'Indicates whether this bank account is subject to SOX compliance controls and audit requirements.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Master reference table for bank_account. Referenced by bank_account_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Primary key for invoice',
    `address_id` BIGINT COMMENT 'Reference to the billing address where the invoice is sent.',
    `business_partner_id` BIGINT COMMENT 'Reference to the customer or organization to whom this invoice is issued.',
    `contract_id` BIGINT COMMENT 'Reference to the master contract or agreement under which this invoice is issued, if applicable.',
    `sales_order_id` BIGINT COMMENT 'Reference to the originating sales order that this invoice fulfills.',
    `ship_to_address_id` BIGINT COMMENT 'Reference to the shipping address where the goods or services were delivered.',
    `credited_invoice_id` BIGINT COMMENT 'Self-referencing FK on invoice (credited_invoice_id)',
    `billing_period_end_date` DATE COMMENT 'The end date of the period covered by this invoice, relevant for subscription or recurring billing.',
    `billing_period_start_date` DATE COMMENT 'The start date of the period covered by this invoice, relevant for subscription or recurring billing.',
    `business_unit` STRING COMMENT 'The business unit or division responsible for this invoice, used for internal financial reporting and cost allocation.',
    `cost_center` STRING COMMENT 'The cost center to which revenue from this invoice is allocated for internal cost accounting.',
    `created_by_user` STRING COMMENT 'The username or identifier of the user who created this invoice record.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this invoice is denominated.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total discount amount applied to this invoice, including volume discounts, promotional discounts, or early payment discounts.',
    `dispute_date` DATE COMMENT 'The date on which the customer raised a dispute for this invoice.',
    `dispute_reason` STRING COMMENT 'The reason provided by the customer for disputing this invoice, if applicable.',
    `due_date` DATE COMMENT 'The date by which payment is expected from the customer per the agreed payment terms.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the invoice currency to the companys functional currency at the time of invoice creation.',
    `general_ledger_account` STRING COMMENT 'The general ledger account code to which this invoice revenue is posted.',
    `invoice_date` DATE COMMENT 'The date the invoice was issued to the customer. This is the principal business event timestamp for the invoice transaction.',
    `invoice_number` STRING COMMENT 'Externally-known unique business identifier for the invoice, used for customer communication and payment reference.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts receivable workflow.',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on its business purpose: standard sales invoice, credit memo for returns/adjustments, debit memo for additional charges, proforma for advance notification, intercompany for internal transfers, or rebate for volume discounts.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this invoice record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this invoice, such as special instructions, customer requests, or internal remarks.',
    `payment_method` STRING COMMENT 'The payment instrument or method expected or used for settling this invoice.',
    `payment_received_date` DATE COMMENT 'The date on which payment for this invoice was received from the customer.',
    `payment_reference_number` STRING COMMENT 'The reference number or transaction ID associated with the payment received for this invoice.',
    `payment_terms` STRING COMMENT 'The agreed payment terms defining when payment is due and any early payment discounts available.',
    `purchase_order_number` STRING COMMENT 'The customers purchase order number that authorized this invoice, used for payment reconciliation.',
    `revenue_recognition_date` DATE COMMENT 'The date on which revenue from this invoice is recognized in the financial statements per GAAP revenue recognition rules.',
    `shipping_amount` DECIMAL(18,2) COMMENT 'The shipping and handling charges included in this invoice.',
    `sox_compliant_flag` BOOLEAN COMMENT 'Indicates whether this invoice transaction meets SOX compliance requirements for financial controls and audit trails.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'The sum of all line item amounts before taxes, discounts, and adjustments.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applied to this invoice, including sales tax, VAT, or other applicable taxes.',
    `therapeutic_area` STRING COMMENT 'The therapeutic area or product category to which the invoiced products belong, used for P&L analysis by therapeutic area.',
    `total_amount` DECIMAL(18,2) COMMENT 'The final total amount due on this invoice after all taxes, discounts, and adjustments. This is the net amount the customer must pay.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Master reference table for invoice. Referenced by invoice_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`costing_run` (
    `costing_run_id` BIGINT COMMENT 'Primary key for costing_run',
    `prior_costing_run_id` BIGINT COMMENT 'Self-referencing FK on costing_run (prior_costing_run_id)',
    `actual_end_timestamp` TIMESTAMP COMMENT 'The actual date and time when the costing run execution completed or terminated.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'The actual date and time when the costing run execution began.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether this costing run requires formal approval from finance management before results are posted to the general ledger.',
    `approved_by` STRING COMMENT 'The username or employee identifier of the finance manager who approved this costing run for posting. Nullable if not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this costing run was formally approved for posting to financial systems. Nullable if not yet approved.',
    `company_code` STRING COMMENT 'The SAP company code for which this costing run is executed, representing the legal entity in the financial system.',
    `controlling_area` STRING COMMENT 'The SAP controlling area code representing the organizational unit for cost accounting and internal reporting.',
    `cost_center_group` STRING COMMENT 'The grouping of cost centers included in this costing run for aggregated cost allocation and analysis.',
    `costing_method` STRING COMMENT 'The valuation method applied in this costing run: standard cost, actual cost, moving average, first-in-first-out (FIFO), or last-in-first-out (LIFO).',
    `costing_variant` STRING COMMENT 'The SAP costing variant code that defines the costing methodology, valuation strategy, and calculation rules applied in this run.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this costing run record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which costs are calculated and reported for this costing run.',
    `error_count` STRING COMMENT 'The number of errors encountered during the execution of this costing run, used for quality monitoring and troubleshooting.',
    `exchange_rate_type` STRING COMMENT 'The type of foreign exchange rate used for currency conversion in this costing run: period average, period closing, budget rate, or standard rate.',
    `execution_duration_minutes` DECIMAL(18,2) COMMENT 'The total time taken to execute the costing run, measured in minutes from start to completion.',
    `gl_posting_date` DATE COMMENT 'The accounting date on which the costing run results were posted to the general ledger. Nullable if not yet posted.',
    `includes_rnd_capitalization` BOOLEAN COMMENT 'Indicates whether this costing run includes capitalized research and development costs allocated to products under development or newly launched.',
    `includes_royalty_costs` BOOLEAN COMMENT 'Indicates whether this costing run includes royalty and licensing costs associated with intellectual property used in product manufacturing.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this costing run record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes or comments about this costing run, including special circumstances, adjustments made, or issues encountered.',
    `period_month` STRING COMMENT 'The fiscal month within the year for which this costing run is executed, represented as 1-12.',
    `period_quarter` STRING COMMENT 'The fiscal quarter for which this costing run is executed, represented as 1-4.',
    `period_year` STRING COMMENT 'The fiscal year for which this costing run is executed, represented as a four-digit year (e.g., 2024).',
    `plant_code` STRING COMMENT 'The manufacturing plant or site code for which product costs are calculated in this run. Nullable for enterprise-wide runs.',
    `posted_to_gl` BOOLEAN COMMENT 'Indicates whether the costing results from this run have been posted to the general ledger for financial reporting.',
    `product_category` STRING COMMENT 'The category of products included in this costing run: pharmaceutical drugs, vaccines, consumer health products, medical devices, or all categories.',
    `run_number` STRING COMMENT 'Business identifier for the costing run, typically formatted as CR-YYYYMMDD-NNNN for external reference and audit trails.',
    `run_type` STRING COMMENT 'Classification of the costing run indicating its purpose: standard periodic costing, preliminary estimate, adjustment run, year-end closing, or special ad-hoc analysis.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'The planned date and time when the costing run is scheduled to begin execution.',
    `scope` STRING COMMENT 'The organizational or product scope covered by this costing run: global enterprise, specific region, country, manufacturing site, product line, or therapeutic area.',
    `sox_compliant` BOOLEAN COMMENT 'Indicates whether this costing run was executed following SOX-compliant controls and audit trails for financial reporting integrity.',
    `costing_run_status` STRING COMMENT 'Current lifecycle status of the costing run indicating its processing state.',
    `therapeutic_area` STRING COMMENT 'The therapeutic area or disease category for which costs are calculated (e.g., oncology, immunology, rare diseases). Nullable for multi-area runs.',
    `total_cost_amount` DECIMAL(18,2) COMMENT 'The aggregate total cost calculated across all products and cost components in this costing run, expressed in the run currency.',
    `total_products_costed` STRING COMMENT 'The total number of distinct product SKUs or materials for which costs were calculated in this costing run.',
    `valuation_view` STRING COMMENT 'The accounting perspective used for material valuation: legal entity view, group consolidation view, profit center view, or tax reporting view.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The total variance between standard and actual costs identified in this costing run, used for variance analysis and cost control.',
    `warning_count` STRING COMMENT 'The number of warnings generated during the execution of this costing run, indicating potential data quality or configuration issues.',
    CONSTRAINT pk_costing_run PRIMARY KEY(`costing_run_id`)
) COMMENT 'Master reference table for costing_run. Referenced by costing_run_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`ledger` (
    `ledger_id` BIGINT COMMENT 'Primary key for ledger',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the chart of accounts structure used by this ledger. Defines the complete list of general ledger accounts available for posting.',
    `parent_ledger_id` BIGINT COMMENT 'Self-referencing FK on ledger (parent_ledger_id)',
    `accounting_principle` STRING COMMENT 'The accounting standard or principle governing this ledger (e.g., US GAAP, IFRS, local statutory GAAP, tax accounting, management accounting). Determines valuation, recognition, and disclosure rules.',
    `brand_reporting_flag` BOOLEAN COMMENT 'Indicates whether this ledger supports profit and loss reporting segmented by pharmaceutical brand or product line. True if brand dimension is enabled, False otherwise.',
    `cogs_tracking_flag` BOOLEAN COMMENT 'Indicates whether this ledger tracks cost of goods sold by product for pharmaceutical manufacturing and distribution. True if COGS tracking is enabled, False otherwise.',
    `company_code` STRING COMMENT 'Identifier of the legal entity or company code to which this ledger belongs. Represents the smallest organizational unit for which a complete self-contained set of accounts can be drawn up for external reporting.',
    `consolidation_ledger_flag` BOOLEAN COMMENT 'Indicates whether this ledger is used for group consolidation purposes. Consolidation ledgers aggregate financial data from multiple legal entities for consolidated financial statements. True if consolidation ledger, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this ledger record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the functional currency of the ledger (e.g., USD, EUR, GBP, JPY). All transactions in this ledger are recorded in this currency.',
    `ledger_description` STRING COMMENT 'Detailed textual description of the ledgers purpose, scope, and usage. Provides context for financial analysts and auditors on when and how this ledger should be used.',
    `effective_end_date` DATE COMMENT 'The date on which this ledger ceases to be active for new postings. Nullable for ledgers with no planned end date. Used for ledger retirement or fiscal year transitions.',
    `effective_start_date` DATE COMMENT 'The date from which this ledger becomes active and available for financial postings. Represents the beginning of the ledgers operational lifecycle.',
    `fiscal_year_variant` STRING COMMENT 'Code identifying the fiscal year calendar structure used by this ledger (e.g., calendar year, April-March, custom periods). Defines period start/end dates and number of posting periods.',
    `geography_reporting_flag` BOOLEAN COMMENT 'Indicates whether this ledger supports profit and loss reporting segmented by geographic region or country. True if geography dimension is enabled, False otherwise.',
    `leading_ledger_flag` BOOLEAN COMMENT 'Indicates whether this is the leading (primary) ledger for the organization. The leading ledger is the authoritative source for statutory financial reporting and consolidation. True if leading ledger, False otherwise.',
    `ledger_code` STRING COMMENT 'Unique alphanumeric code identifying the ledger in financial systems. Used as the business identifier for external references and reporting.',
    `ledger_name` STRING COMMENT 'Full descriptive name of the ledger (e.g., Corporate General Ledger, IFRS Reporting Ledger, Management Accounting Ledger).',
    `ledger_type` STRING COMMENT 'Classification of the ledger based on its accounting purpose. General ledgers capture all financial transactions; subsidiary ledgers track specific account categories; statistical ledgers hold non-financial data; special purpose ledgers support specific reporting requirements; consolidation ledgers aggregate multi-entity data; management ledgers support internal decision-making.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this ledger record. Supports audit trail and accountability for ledger configuration changes.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this ledger record was last modified. Supports audit trail and change tracking for ledger configuration changes.',
    `parallel_accounting_flag` BOOLEAN COMMENT 'Indicates whether this ledger is part of a parallel accounting setup, where multiple ledgers track the same transactions under different accounting principles (e.g., GAAP and IFRS). True if parallel ledger, False otherwise.',
    `posting_allowed_flag` BOOLEAN COMMENT 'Indicates whether financial postings are currently allowed to this ledger. Used to control posting periods and prevent unauthorized entries during period-end close. True if postings allowed, False otherwise.',
    `profit_loss_account` STRING COMMENT 'General ledger account number used to accumulate net profit or loss for the current period in this ledger. Cleared to retained earnings during year-end close.',
    `rd_capitalization_flag` BOOLEAN COMMENT 'Indicates whether this ledger tracks capitalized research and development costs for pharmaceutical development programs. True if R&D capitalization is tracked, False otherwise.',
    `retained_earnings_account` STRING COMMENT 'General ledger account number used to post retained earnings for this ledger during year-end closing. Represents accumulated profits or losses carried forward from prior periods.',
    `royalty_accounting_flag` BOOLEAN COMMENT 'Indicates whether this ledger tracks royalty payments and revenue related to licensed pharmaceutical intellectual property. True if royalty accounting is enabled, False otherwise.',
    `sox_compliant_flag` BOOLEAN COMMENT 'Indicates whether this ledger is subject to Sarbanes-Oxley Act compliance requirements for internal controls over financial reporting. True if SOX-compliant controls are enforced, False otherwise.',
    `ledger_status` STRING COMMENT 'Current operational status of the ledger. Active ledgers accept postings; inactive ledgers are temporarily disabled; closed ledgers are finalized for a fiscal period; suspended ledgers are under review; archived ledgers are retained for historical reference only.',
    `therapeutic_area_reporting_flag` BOOLEAN COMMENT 'Indicates whether this ledger supports profit and loss reporting segmented by therapeutic area (e.g., oncology, immunology, rare diseases). True if therapeutic area dimension is enabled, False otherwise.',
    `valuation_area` STRING COMMENT 'Defines the valuation perspective for assets and liabilities in this ledger. Legal valuation follows statutory requirements; group valuation supports consolidation; profit center valuation enables segment reporting; tax valuation aligns with tax authority rules.',
    `created_by` STRING COMMENT 'User identifier or system account that created this ledger record. Supports audit trail and accountability for ledger setup.',
    CONSTRAINT pk_ledger PRIMARY KEY(`ledger_id`)
) COMMENT 'Master reference table for ledger. Referenced by ledger_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_agreement` (
    `intercompany_agreement_id` BIGINT COMMENT 'Primary key for intercompany_agreement',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that is the counterparty in this intercompany agreement.',
    `originating_entity_id` BIGINT COMMENT 'Reference to the legal entity that originated or initiated this intercompany agreement.',
    `superseded_intercompany_agreement_id` BIGINT COMMENT 'Self-referencing FK on intercompany_agreement (superseded_intercompany_agreement_id)',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the intercompany agreement, typically used in legal documents and financial reporting.',
    `agreement_type` STRING COMMENT 'Classification of the intercompany agreement based on its business purpose (e.g., cost sharing for R&D, royalty for IP licensing, manufacturing for contract production).',
    `annual_value` DECIMAL(18,2) COMMENT 'Estimated or contracted annual monetary value of the intercompany agreement in the specified currency, used for budgeting and financial planning.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this intercompany agreement received final approval and became active.',
    `contract_owner` STRING COMMENT 'Name or identifier of the business owner responsible for managing and maintaining this intercompany agreement.',
    `cost_allocation_method` STRING COMMENT 'Method used to allocate costs between entities under this intercompany agreement, critical for transfer pricing compliance and cost accounting.',
    `cost_center` STRING COMMENT 'Cost center code responsible for managing and tracking costs associated with this intercompany agreement.',
    `cost_sharing_percentage` DECIMAL(18,2) COMMENT 'Percentage of costs allocated to the counterparty entity under a cost-sharing arrangement, typically used for R&D cost allocation. Nullable if not a cost-sharing agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this intercompany agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for financial transactions under this intercompany agreement.',
    `intercompany_agreement_description` STRING COMMENT 'Detailed textual description of the intercompany agreement scope, purpose, and key terms for business reference and documentation.',
    `effective_date` DATE COMMENT 'Date when the intercompany agreement becomes legally binding and operational.',
    `expiration_date` DATE COMMENT 'Date when the intercompany agreement terminates or expires. Nullable for evergreen agreements.',
    `finance_approver` STRING COMMENT 'Name or identifier of the finance executive who approved this intercompany agreement for financial compliance and budgetary alignment.',
    `geography` STRING COMMENT 'Three-letter ISO country code representing the primary geographic scope or jurisdiction of the intercompany agreement.',
    `gl_account_code` STRING COMMENT 'General ledger account code used to record financial transactions related to this intercompany agreement in the SAP FI/CO system.',
    `legal_approver` STRING COMMENT 'Name or identifier of the legal counsel who approved this intercompany agreement for legal compliance and risk management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this intercompany agreement record was last modified or updated in the system.',
    `notes` STRING COMMENT 'Additional free-form notes or comments related to the intercompany agreement for internal reference and audit trail purposes.',
    `payment_terms` STRING COMMENT 'Standard payment terms governing the settlement of financial obligations under this intercompany agreement.',
    `product_line` STRING COMMENT 'Product line or brand family associated with this intercompany agreement, used for P&L allocation and brand-level financial reporting.',
    `profit_center` STRING COMMENT 'Profit center code used for P&L reporting and profitability analysis related to this intercompany agreement.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether this intercompany agreement is eligible for automatic renewal upon expiration.',
    `royalty_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage rate applied to calculate royalty payments for intellectual property licensing under this intercompany agreement. Nullable if not a royalty agreement.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this intercompany agreement is subject to SOX internal controls and compliance monitoring.',
    `intercompany_agreement_status` STRING COMMENT 'Current lifecycle status of the intercompany agreement indicating its operational state.',
    `tax_jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the primary tax jurisdiction governing this intercompany agreement for tax compliance and reporting.',
    `terminated_timestamp` TIMESTAMP COMMENT 'Timestamp when this intercompany agreement was terminated or cancelled. Nullable if agreement is still active.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required to terminate this intercompany agreement as specified in the contract terms.',
    `therapeutic_area` STRING COMMENT 'Primary therapeutic area or disease category that this intercompany agreement supports, relevant for R&D cost sharing and royalty agreements.',
    `transfer_pricing_method` STRING COMMENT 'OECD-compliant transfer pricing method applied to transactions under this intercompany agreement to ensure arms-length pricing.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'Applicable withholding tax rate percentage for cross-border payments under this intercompany agreement, based on tax treaties and local regulations.',
    CONSTRAINT pk_intercompany_agreement PRIMARY KEY(`intercompany_agreement_id`)
) COMMENT 'Master reference table for intercompany_agreement. Referenced by intercompany_agreement_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'Primary key for wbs_element',
    `business_area_id` BIGINT COMMENT 'Reference to the business area (e.g., Pharmaceuticals, Consumer Health, Vaccines) for segment reporting and cross-company code consolidation.',
    `employee_id` BIGINT COMMENT 'The system user ID of the person who created this WBS element record.',
    `functional_area_id` BIGINT COMMENT 'Reference to the functional area (e.g., Research & Development, Manufacturing, Sales & Marketing) for cost-of-sales accounting and functional reporting.',
    `program_id` BIGINT COMMENT 'Reference to the capital investment program or appropriation request under which this WBS element is funded and tracked.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity company code under which this WBS element operates for financial and statutory reporting purposes.',
    `modified_by_user_employee_id` BIGINT COMMENT 'The system user ID of the person who last modified this WBS element record.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department that requested or initiated the project or work package represented by this WBS element.',
    `parent_wbs_element_id` BIGINT COMMENT 'Reference to the parent WBS element in the hierarchical project structure. Null for top-level WBS elements.',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where work for this WBS element is performed, relevant for capital projects and manufacturing-related R&D.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center to which costs and revenues for this WBS element are allocated for internal P&L reporting.',
    `project_id` BIGINT COMMENT 'Reference to the parent project or program to which this WBS element belongs. Links to the project master data.',
    `project_manager_employee_id` BIGINT COMMENT 'Reference to the employee serving as the project manager or work package owner responsible for this WBS element.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for managing and executing the work defined by this WBS element.',
    `therapeutic_area_id` BIGINT COMMENT 'Reference to the therapeutic area (e.g., Oncology, Immunology, Rare Diseases) to which this WBS elements R&D or commercial activities are aligned.',
    `account_assignment_element_flag` BOOLEAN COMMENT 'Indicates whether this WBS element can be used as an account assignment object for purchase orders, expense reports, and other financial transactions.',
    `approval_date` DATE COMMENT 'The date when this WBS element and its associated budget were formally approved by the appropriate governance body.',
    `billing_element_flag` BOOLEAN COMMENT 'Indicates whether this WBS element is used as a billing element for customer invoicing in contract research or collaborative development projects.',
    `capitalization_eligible_flag` BOOLEAN COMMENT 'Indicates whether costs posted to this WBS element are eligible for capitalization as intangible assets under accounting standards (e.g., IAS 38 for development phase costs).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this WBS element record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which budgets, costs, and financial transactions for this WBS element are denominated.',
    `deletion_flag` BOOLEAN COMMENT 'Indicates whether this WBS element has been marked for deletion. Deleted WBS elements are retained for audit and historical reporting purposes.',
    `end_date` DATE COMMENT 'The planned or actual end date when work on this WBS element is scheduled to complete or has completed.',
    `external_reference_code` STRING COMMENT 'Optional external identifier linking this WBS element to corresponding records in third-party project management, clinical trial management, or contract research systems.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this WBS element record was last modified or updated.',
    `planning_budget_amount` DECIMAL(18,2) COMMENT 'The total approved budget amount allocated to this WBS element for planning and cost control purposes.',
    `planning_element_flag` BOOLEAN COMMENT 'Indicates whether this WBS element is used for project planning activities including resource planning, cost planning, and schedule planning.',
    `priority_code` STRING COMMENT 'Business priority classification of this WBS element indicating its strategic importance and resource allocation precedence.',
    `results_analysis_key` STRING COMMENT 'Key determining the method for calculating work-in-progress (WIP), revenue recognition, and results analysis for this WBS element in project accounting.',
    `settlement_profile_code` STRING COMMENT 'Code defining the rules for periodic settlement of costs from this WBS element to receiving cost objects (e.g., cost centers, assets, general ledger accounts).',
    `start_date` DATE COMMENT 'The planned or actual start date when work on this WBS element begins.',
    `statistical_flag` BOOLEAN COMMENT 'Indicates whether this WBS element is statistical (used for reporting and planning only) and does not accept actual cost postings.',
    `wbs_element_status` STRING COMMENT 'Current lifecycle status of the WBS element indicating its operational state and whether it is available for cost postings and budget consumption.',
    `wbs_element_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying the WBS element in project management and financial systems. Used for cost allocation, budgeting, and reporting.',
    `wbs_element_description` STRING COMMENT 'Detailed description of the WBS elements purpose, scope, and business objectives within the project or program structure.',
    `wbs_element_name` STRING COMMENT 'Human-readable name or title of the WBS element describing the project phase, deliverable, or cost center.',
    `wbs_element_type` STRING COMMENT 'Classification of the WBS element by its functional purpose: planning (for project planning), billing (for customer billing), account_assignment (for cost allocation), or statistical (for reporting only).',
    `wbs_level` STRING COMMENT 'The hierarchical level of this WBS element within the project structure, where 1 is the top level and higher numbers represent deeper nesting.',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Master reference table for wbs_element. Referenced by wbs_element_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`payment_batch` (
    `payment_batch_id` BIGINT COMMENT 'Primary key for payment_batch',
    `prior_payment_batch_id` BIGINT COMMENT 'Self-referencing FK on payment_batch (prior_payment_batch_id)',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the payment batch for processing.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the payment batch was approved by an authorized approver.',
    `bank_account_id` BIGINT COMMENT 'Reference to the company bank account from which payments in this batch are disbursed.',
    `bank_confirmation_number` STRING COMMENT 'Confirmation or reference number provided by the bank upon successful receipt and processing of the payment batch.',
    `batch_number` STRING COMMENT 'Human-readable business identifier for the payment batch, typically formatted as PB followed by 8 digits.',
    `batch_type` STRING COMMENT 'Classification of the payment batch by recipient category or purpose (vendor payments, employee reimbursements, royalty payments, customer rebates, tax remittances, intercompany transfers).',
    `company_code` STRING COMMENT 'SAP FI company code representing the legal entity making the payments, typically 4 alphanumeric characters.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the payment batch record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment batch (e.g., USD, EUR, GBP, JPY).',
    `dual_approval_required` BOOLEAN COMMENT 'Flag indicating whether this payment batch requires approval from two authorized signatories before processing, typically for high-value batches.',
    `error_count` STRING COMMENT 'Number of individual payment transactions within the batch that failed or encountered errors during processing.',
    `error_description` STRING COMMENT 'Summary description of errors encountered during payment batch processing, including error codes and messages from the payment system or bank.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when the payment batch is recorded, typically 1-12.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the payment batch is recorded for financial reporting purposes.',
    `gl_posting_date` DATE COMMENT 'The accounting period date when the payment batch transactions are posted to the general ledger.',
    `is_recurring` BOOLEAN COMMENT 'Flag indicating whether this payment batch is part of a recurring payment schedule (e.g., monthly vendor payments, payroll).',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified the payment batch record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the payment batch record was last updated.',
    `notes` STRING COMMENT 'Free-text notes or comments about the payment batch, including special instructions, exceptions, or audit trail information.',
    `payment_file_format` STRING COMMENT 'Standard format of the payment file transmitted to the bank (NACHA, BAI2, MT940, PAIN.001, CAMT.053, or proprietary format).',
    `payment_file_name` STRING COMMENT 'Name of the electronic payment file generated for bank transmission (e.g., ACH file, NACHA file, SWIFT message).',
    `payment_method` STRING COMMENT 'Payment instrument or mechanism used for disbursement (ACH, wire transfer, check, electronic funds transfer, SEPA, SWIFT).',
    `payment_program_id` STRING COMMENT 'Identifier for the automated payment program or payment run configuration used to generate this batch.',
    `payment_run_date` DATE COMMENT 'The business date on which the payment batch was executed or is scheduled to be executed.',
    `priority_level` STRING COMMENT 'Priority classification for payment batch processing, determining the order and urgency of execution.',
    `processed_timestamp` TIMESTAMP COMMENT 'Date and time when the payment batch processing was completed and payments were transmitted to the bank.',
    `reconciliation_date` DATE COMMENT 'Date when the payment batch was reconciled against bank statements.',
    `reconciliation_status` STRING COMMENT 'Status of the bank reconciliation process for this payment batch, indicating whether payments have been confirmed cleared by the bank.',
    `recurring_schedule_id` BIGINT COMMENT 'Reference to the recurring payment schedule configuration if this batch is part of an automated recurring payment program.',
    `second_approval_timestamp` TIMESTAMP COMMENT 'Date and time when the second approval was granted for dual-authorization payment batches.',
    `second_approver` STRING COMMENT 'User ID or name of the second approver for payment batches requiring dual authorization.',
    `sox_control_flag` BOOLEAN COMMENT 'Flag indicating whether this payment batch is subject to SOX compliance controls and requires additional audit documentation.',
    `payment_batch_status` STRING COMMENT 'Current lifecycle status of the payment batch in the payment processing workflow.',
    `total_amount` DECIMAL(18,2) COMMENT 'Aggregate gross amount of all payments in the batch before any adjustments or fees.',
    `total_payment_count` STRING COMMENT 'Total number of individual payment transactions included in this batch.',
    `value_date` DATE COMMENT 'The effective date when funds are transferred and become available to recipients, used for cash flow and liquidity management.',
    `created_by` STRING COMMENT 'User ID or name of the person who initiated or created the payment batch.',
    CONSTRAINT pk_payment_batch PRIMARY KEY(`payment_batch_id`)
) COMMENT 'Master reference table for payment_batch. Referenced by payment_batch_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_costing_run_id` FOREIGN KEY (`costing_run_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`costing_run`(`costing_run_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ADD CONSTRAINT `fk_finance_royalty_agreement_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_intercompany_agreement_id` FOREIGN KEY (`intercompany_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`intercompany_agreement`(`intercompany_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_original_transaction_intercompany_transaction_id` FOREIGN KEY (`original_transaction_intercompany_transaction_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_transfer_price_id` FOREIGN KEY (`transfer_price_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_intercompany_transaction_id` FOREIGN KEY (`intercompany_transaction_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_prior_version_transfer_price_id` FOREIGN KEY (`prior_version_transfer_price_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_payment_batch_id` FOREIGN KEY (`payment_batch_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`payment_batch`(`payment_batch_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_prior_payment_run_id` FOREIGN KEY (`prior_payment_run_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_master_account_id` FOREIGN KEY (`master_account_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_parent_bank_account_id` FOREIGN KEY (`parent_bank_account_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_credited_invoice_id` FOREIGN KEY (`credited_invoice_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`costing_run` ADD CONSTRAINT `fk_finance_costing_run_prior_costing_run_id` FOREIGN KEY (`prior_costing_run_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`costing_run`(`costing_run_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_parent_ledger_id` FOREIGN KEY (`parent_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_superseded_intercompany_agreement_id` FOREIGN KEY (`superseded_intercompany_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`intercompany_agreement`(`intercompany_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_parent_wbs_element_id` FOREIGN KEY (`parent_wbs_element_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_prior_payment_batch_id` FOREIGN KEY (`prior_payment_batch_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`payment_batch`(`payment_batch_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `pharmaceuticals_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `ledger_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|blocked|marked_for_deletion');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'A|D|K|M|S');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `balance_sheet_account` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Account Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (CoA) Key');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `closing_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `closing_balance_gc` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance in Group Currency (GC)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `closing_balance_gc` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `closing_balance_lc` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance in Local Currency (LC)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `closing_balance_lc` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `company_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `company_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Period Credit Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Period Debit Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `debit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `fs_item` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement (FS) Item');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `gaap_standard` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Standard');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `gaap_standard` SET TAGS ('dbx_value_regex' = 'US_GAAP|IFRS|LOCAL_GAAP|IFRS_AND_US_GAAP');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `last_posted_date` SET TAGS ('dbx_business_glossary_term' = 'Last Posted Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `opening_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `period_close_status` SET TAGS ('dbx_business_glossary_term' = 'Period Close Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `period_close_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|locked');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `posting_block` SET TAGS ('dbx_business_glossary_term' = 'Posting Block Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `rd_capitalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Capitalization Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `recon_account_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `recon_account_type` SET TAGS ('dbx_value_regex' = 'D|K|A|');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Reporting Segment');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `sox_relevant` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Relevant Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `trading_partner` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `trading_partner` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_group_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Group Currency');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_group_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Transaction Currency');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_transaction_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field (ZUONR)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'S|H');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entry Creation Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(0[1-9]|1[0-6])$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `gl_account` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `header_text` SET TAGS ('dbx_business_glossary_term' = 'Document Header Text');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal Entry Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Changed Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency (ISO 4217)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|parked|held|reversed|cleared|blocked');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `subledger_type` SET TAGS ('dbx_business_glossary_term' = 'Subledger Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `subledger_type` SET TAGS ('dbx_value_regex' = 'AP|AR|asset|tax|material|none');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Base Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_base_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_return_period` SET TAGS ('dbx_business_glossary_term' = 'Indirect Tax Return Period');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_return_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency (ISO 4217)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `vat_classification` SET TAGS ('dbx_business_glossary_term' = 'VAT/Sales Tax Classification');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `vat_classification` SET TAGS ('dbx_value_regex' = 'input_vat|output_vat|deferred_vat|exempt|zero_rated|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Cost Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_profile` SET TAGS ('dbx_business_glossary_term' = 'Budget Profile');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_profile` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `capitalization_eligible` SET TAGS ('dbx_business_glossary_term' = 'R&D Capitalization Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Commitment Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `commitment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `deletion_flag` SET TAGS ('dbx_business_glossary_term' = 'Deletion Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `investment_measure_type` SET TAGS ('dbx_business_glossary_term' = 'Investment Measure Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `investment_measure_type` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX|RD_EXPENSE|RD_CAPITAL');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `last_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Changed Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Long Description');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `order_category` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Category');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `order_category` SET TAGS ('dbx_value_regex' = '01|02|04|10|20');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `order_name` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Short Description');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'CRTD|REL|TECO|CLSD|DLT|LKD');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `overhead_key` SET TAGS ('dbx_business_glossary_term' = 'Overhead Costing Key');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `overhead_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `plan_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `plan_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `program_phase` SET TAGS ('dbx_business_glossary_term' = 'Drug Development Program Phase');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `program_phase` SET TAGS ('dbx_value_regex' = 'DISCOVERY|PRECLINICAL|PHASE_1|PHASE_2|PHASE_3|LAUNCH');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Order Release Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_receiver_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Receiver Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_receiver_type` SET TAGS ('dbx_value_regex' = 'CTR|AUC|WBS|PSG|GL|ORD');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_rule_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_rule_type` SET TAGS ('dbx_value_regex' = 'FUL|PER|MAN');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `statistical_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Order Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Account ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `warehouse_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Receipt Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `discount_due_date` SET TAGS ('dbx_business_glossary_term' = 'Discount Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `is_rd_capitalized` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Capitalization Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_block_indicator` SET TAGS ('dbx_value_regex' = 'R|B|A|V|');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Execution Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire|check|SEPA|SWIFT|EFT');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'open|partially_paid|paid|blocked|cancelled|disputed');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `vendor_category` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `ar_status` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `ar_status` SET TAGS ('dbx_value_regex' = 'open|partially_cleared|cleared|disputed|written_off|in_dunning');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `billing_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Document Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'wholesaler|distributor|hospital_network|government_payer|retail_pharmacy|specialty_pharmacy');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'AR Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'AR Document Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'customer_invoice|credit_memo|debit_memo|down_payment|payment_receipt|accrual');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `open_amount` SET TAGS ('dbx_business_glossary_term' = 'Open (Outstanding) AR Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `open_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `open_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|check|ach|wire|direct_debit|credit_card');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Receipt Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `posting_period` SET TAGS ('dbx_value_regex' = '^(0[1-9]|1[0-6])$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `product_ndc` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `product_ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `revenue_recognition_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `revenue_recognition_type` SET TAGS ('dbx_value_regex' = 'recognized|deferred|accrued|reversed');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Reversal Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `sales_territory` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `actual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_value_regex' = '^BUD-[0-9]{4}-[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'opex|capex|rd|headcount|contingency|other');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `capitalization_stage` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Stage');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `capitalization_stage` SET TAGS ('dbx_value_regex' = 'research|development|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget End Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `geography_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `is_capitalized` SET TAGS ('dbx_business_glossary_term' = 'Is Capitalized Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `planned_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_value_regex' = 'annual|multi_year|quarterly|rolling_12m');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'R&D Program Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|EXCEL_UPLOAD|PLANNING_TOOL|MANUAL');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `variance_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|reforecast|final');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Name');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|under_construction|retired|transferred|impaired|disposed');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_subnumber` SET TAGS ('dbx_business_glossary_term' = 'Asset Sub-Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capex_project_number` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Project Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Deactivation Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area_code` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_key` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Key');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insured_value` SET TAGS ('dbx_business_glossary_term' = 'Insured Value');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insured_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `is_gmp_critical` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Critical Equipment Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `is_rd_equipment` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Equipment Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_physical_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Verification Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `residual_value` SET TAGS ('dbx_business_glossary_term' = 'Residual Value');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `residual_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `rd_capitalization_id` SET TAGS ('dbx_business_glossary_term' = 'R&D Capitalization Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `compound_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Project Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'IAS_38|ASC_730|IFRS|US_GAAP');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `accumulated_amortization` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Amortization');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `accumulated_amortization` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `amortization_method` SET TAGS ('dbx_business_glossary_term' = 'Amortization Method');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `amortization_method` SET TAGS ('dbx_value_regex' = 'straight_line|units_of_production|declining_balance');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `amortization_start_date` SET TAGS ('dbx_business_glossary_term' = 'Amortization Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `annual_amortization_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Amortization Charge');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `annual_amortization_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `capitalization_number` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `capitalization_number` SET TAGS ('dbx_value_regex' = '^CAP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `capitalization_status` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `capitalization_status` SET TAGS ('dbx_value_regex' = 'draft|active|impaired|fully_amortized|written_off|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `capitalization_type` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `capitalization_type` SET TAGS ('dbx_value_regex' = 'internal_development|acquired_iprd|licensed_technology|milestone_payment|software_development');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `capitalized_amount` SET TAGS ('dbx_business_glossary_term' = 'Capitalized R&D Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `capitalized_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `development_phase` SET TAGS ('dbx_business_glossary_term' = 'Development Phase');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Capitalized Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `geography_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `impairment_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Impairment Assessment Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `impairment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `impairment_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `impairment_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `impairment_reason` SET TAGS ('dbx_business_glossary_term' = 'Impairment Reason');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Milestone Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `milestone_trigger` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Milestone Trigger');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `net_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Notes');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `reporting_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `sox_control_reference` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Reference');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `cogs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Entry ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Batch ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Manufacturing Organization (CMO) Vendor ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `costing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Costing Run ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product (DP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `capitalization_eligible` SET TAGS ('dbx_business_glossary_term' = 'R&D Capitalization Eligible Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `cmo_indicator` SET TAGS ('dbx_business_glossary_term' = 'Contract Manufacturing Organization (CMO) Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `cost_component_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Component Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `cost_component_type` SET TAGS ('dbx_value_regex' = 'material|labor|overhead|depreciation|royalty|other');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `cost_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `cost_variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `costing_type` SET TAGS ('dbx_business_glossary_term' = 'Costing Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `costing_type` SET TAGS ('dbx_value_regex' = 'standard|actual|planned|preliminary|modified_standard');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'COGS Entry Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|cancelled|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `market_country_code` SET TAGS ('dbx_business_glossary_term' = 'Market Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `market_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `material_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Material Cost Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `material_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `overhead_absorbed_amount` SET TAGS ('dbx_business_glossary_term' = 'Overhead Absorbed Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `overhead_absorbed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `quantity_produced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Produced');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UoM)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `reversal_doc_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_CO_PC|SAP_PP|MES|MANUAL');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `variance_category` SET TAGS ('dbx_business_glossary_term' = 'Variance Category');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ALTER COLUMN `variance_category` SET TAGS ('dbx_value_regex' = 'price|quantity|efficiency|mix|volume|other');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` SET TAGS ('dbx_subdomain' = 'partnership_revenue');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `compound_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Compound ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Licensor Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Description');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `agreement_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'in_license|out_license|cross_license|sublicense|co_development');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `audit_frequency_years` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency Years');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `base_royalty_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Base Royalty Rate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `base_royalty_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Agreement Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Execution Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Country');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `licensee_name` SET TAGS ('dbx_business_glossary_term' = 'Licensee Name');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `licensee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `minimum_annual_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Annual Royalty Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `minimum_annual_royalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `net_sales_definition` SET TAGS ('dbx_business_glossary_term' = 'Net Sales Definition');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `net_sales_definition` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `payment_due_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Days');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `royalty_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `royalty_rate_type` SET TAGS ('dbx_value_regex' = 'flat|tiered|stepped|running|milestone_based');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `sap_contract_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Contract Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `sublicense_royalty_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Royalty Rate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `sublicense_royalty_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `sublicensing_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Rights Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Licensed Territory');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `tier1_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Net Sales Threshold Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `tier1_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `tier2_royalty_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Royalty Rate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `tier2_royalty_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `tier2_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Net Sales Threshold Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `tier2_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `tier3_royalty_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Royalty Rate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `tier3_royalty_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `upfront_license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Upfront License Fee Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `upfront_license_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `withholding_tax_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `withholding_tax_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'partnership_revenue');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Agreement ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `original_transaction_intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Legal Entity ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Legal Entity ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `stock_transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_price_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Elimination Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Elimination Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_value_regex' = 'pending|eliminated|partially_eliminated|not_required');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Rate');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `loan_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Loan Interest Rate');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `loan_interest_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tp_documentation_ref` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing (TP) Documentation Reference');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tp_documentation_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^ICT-[0-9]{4}-[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'draft|posted|approved|eliminated|reversed|disputed');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_price_basis` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Basis Method');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_price_basis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_posting_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor or Customer Account Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Document Currency Code (ISO 4217)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `deductible_pct` SET TAGS ('dbx_business_glossary_term' = 'Deductible Percentage (Pro-Rata)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'SAP Document Type (BLART)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `is_deductible` SET TAGS ('dbx_business_glossary_term' = 'Is Tax Deductible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code (ISO 4217)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Code (WERKS)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|cleared|parked|blocked');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `posting_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `posting_type` SET TAGS ('dbx_value_regex' = 'output_tax|input_tax|withholding|deferred_tax_asset|deferred_tax_liability');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_FI_TX|SAP_S4HANA|legacy_ERP');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_account` SET TAGS ('dbx_business_glossary_term' = 'Tax General Ledger Account');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (Local Currency)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_amount_doc_currency` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (Document Currency)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_amount_doc_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Base Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_base_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (MWSKZ)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code (TXJCD)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (Percentage)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number (VAT/TIN)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Period (YYYY-MM)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_reporting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_return_reference` SET TAGS ('dbx_business_glossary_term' = 'Tax Return Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'VAT|sales_tax|withholding_tax|deferred_tax|customs_duty|excise_tax');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` SET TAGS ('dbx_subdomain' = 'partnership_revenue');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `milestone_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Payment ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Project Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `accounting_treatment` SET TAGS ('dbx_business_glossary_term' = 'Accounting Treatment');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `accounting_treatment` SET TAGS ('dbx_value_regex' = 'rd_expense|capitalize|cogs|deferred_revenue|contingent_liability');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `accounting_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `accounting_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected|escalated');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `contractual_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Milestone Payment Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `contractual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `development_stage` SET TAGS ('dbx_business_glossary_term' = 'Drug Development Stage');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `development_stage` SET TAGS ('dbx_value_regex' = 'discovery|preclinical|phase_1|phase_2|phase_3|nda_bla_filed');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `expected_trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Milestone Trigger Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Milestone Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Rate');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `is_capitalized` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `is_contingent_liability` SET TAGS ('dbx_business_glossary_term' = 'Contingent Liability Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Payment Name');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `milestone_number` SET TAGS ('dbx_business_glossary_term' = 'Milestone Payment Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `milestone_number` SET TAGS ('dbx_value_regex' = '^MS-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Payment Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'development|regulatory|commercial|sales_threshold|technical');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Milestone Payment Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Payment Notes');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Payment Settlement Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `payment_direction` SET TAGS ('dbx_business_glossary_term' = 'Milestone Payment Direction');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `payment_direction` SET TAGS ('dbx_value_regex' = 'payable|receivable');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Payment Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Payment Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|triggered|approved|paid|waived|disputed');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_FI|VEEVA_VAULT|MANUAL|CTMS');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `triggering_event` SET TAGS ('dbx_business_glossary_term' = 'Milestone Triggering Event');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `triggering_event_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Triggering Event Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` SET TAGS ('dbx_subdomain' = 'partnership_revenue');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `transfer_price_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Legal Entity ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `prior_version_transfer_price_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Version Transfer Price ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `apa_reference` SET TAGS ('dbx_business_glossary_term' = 'Advance Pricing Agreement (APA) Reference');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `apa_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `approved_price` SET TAGS ('dbx_business_glossary_term' = 'Approved Transfer Price');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `approved_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `arm_length_range_max` SET TAGS ('dbx_business_glossary_term' = 'Arms Length Range Maximum Price');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `arm_length_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `arm_length_range_min` SET TAGS ('dbx_business_glossary_term' = 'Arms Length Range Minimum Price');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `arm_length_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `benchmarking_study_ref` SET TAGS ('dbx_business_glossary_term' = 'Benchmarking Study Reference');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `benchmarking_study_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `cost_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Base Amount');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `cost_base_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `markup_pct` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `markup_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Notes');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `price_per_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `pricing_method` SET TAGS ('dbx_value_regex' = 'CUP|cost_plus|TNMM|RPM|PSM');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `product_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Stage');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `product_lifecycle_stage` SET TAGS ('dbx_value_regex' = 'preclinical|clinical|pre_launch|commercial|mature|end_of_life');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Product Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `receiving_country_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Entity Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `receiving_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Record Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `record_number` SET TAGS ('dbx_value_regex' = '^TP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Record Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `regulatory_doc_ref` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Documentation Reference');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `regulatory_doc_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Review Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|ad_hoc');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `sending_country_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Entity Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `sending_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|manual|RIMS|other');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `tax_ruling_ref` SET TAGS ('dbx_business_glossary_term' = 'Tax Ruling Reference');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `tax_ruling_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'goods|services|IP_license|cost_sharing|loan');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Version Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `withholding_tax_applicable` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Applicable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `withholding_tax_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `withholding_tax_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ALTER COLUMN `prior_payment_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `account_manager_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `account_manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ALTER COLUMN `credited_invoice_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`costing_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`costing_run` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`costing_run` ALTER COLUMN `costing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Costing Run Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`costing_run` ALTER COLUMN `prior_costing_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`costing_run` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`costing_run` ALTER COLUMN `total_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`costing_run` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`ledger` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`ledger` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`ledger` ALTER COLUMN `parent_ledger_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_agreement` SET TAGS ('dbx_subdomain' = 'partnership_revenue');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_agreement` ALTER COLUMN `intercompany_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Agreement Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_agreement` ALTER COLUMN `superseded_intercompany_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_agreement` ALTER COLUMN `annual_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_agreement` ALTER COLUMN `cost_sharing_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_agreement` ALTER COLUMN `royalty_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_batch` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_batch` ALTER COLUMN `payment_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_batch` ALTER COLUMN `prior_payment_batch_id` SET TAGS ('dbx_self_ref_fk' = 'true');
