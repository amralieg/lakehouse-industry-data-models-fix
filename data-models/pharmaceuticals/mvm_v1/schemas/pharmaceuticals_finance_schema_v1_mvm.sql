-- Schema for Domain: finance | Business: Pharmaceuticals | Version: v1_mvm
-- Generated on: 2026-05-05 21:10:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`finance` COMMENT 'Owns enterprise financial data including general ledger, accounts payable, accounts receivable, cost accounting, budgeting, R&D capitalization, COGS by product, royalty accounting, and SOX-compliant financial reporting. Integrates with SAP FI/CO modules. Supports P&L by therapeutic area, brand, and geography, return on investment (ROI) for R&D programs, and capital expenditure tracking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` (
    `general_ledger_id` BIGINT COMMENT 'Unique surrogate identifier for each general ledger account balance record in the Silver layer. Serves as the primary key for this data product.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to masterdata.chart_of_accounts. Business justification: GL accounts are defined within a chart of accounts — fundamental master data relationship for account maintenance, financial statement mapping, and SOX compliance reporting in pharma ERP systems.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: GL accounts are assigned to cost centers for R&D cost tracking, overhead allocation, and GMP manufacturing cost reporting. The plain cost_center column is denormalized; FK enables proper cost accounti',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Each GL account belongs to a legal entity (company code) for statutory financial reporting, intercompany reconciliation, and IFRS/US-GAAP consolidation. Pharma finance experts expect every GL account ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.profit_center. Business justification: GL accounts are assigned to profit centers for segment P&L reporting by therapeutic area in pharma. The plain profit_center column is a denormalized code; proper FK enables segment reporting and manag',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Cost center on journal entries drives R&D capitalization decisions, overhead absorption, and pharma program cost reporting. The plain cost_center column is denormalized; FK enables cost center hierarc',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Journal entries related to fixed asset transactions (acquisition, depreciation, disposal, impairment) should reference the specific asset. This is a nullable FK since not all journal entries are asset',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Journal entries post to specific GL accounts. Each JE line item must reference the GL account it impacts. The existing gl_account field is a STRING code; adding general_ledger_id establishes the prope',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Journal entries that charge costs to internal orders should reference the internal order. This is a nullable FK since not all journal entries are internal-order-related. Connects internal_order to jou',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: Invoice posting in SAP FI creates journal entries. Linking journal_entry to invoice provides direct traceability from accounting transactions to the originating invoice document. This supports revenue',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Journal entries are posted within a legal entity for statutory reporting, intercompany elimination, and tax filing. Pharma companies post entries across multiple legal entities; this FK is required fo',
    `payment_run_id` BIGINT COMMENT 'Foreign key linking to finance.payment_run. Business justification: Payment runs in SAP FI generate clearing journal entries when vendor payments are executed. Linking journal_entry to payment_run enables reconciliation between payment execution records and the result',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.profit_center. Business justification: Profit center on journal entries is required for segment P&L reporting by therapeutic area and product line. The plain profit_center column is denormalized; FK enables management reporting and IFRS 8 ',
    `royalty_agreement_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_agreement. Business justification: Journal entries are posted for royalty accruals, royalty payments, and sublicense fee recognition. Linking journal_entry directly to royalty_agreement enables traceability from individual accounting t',
    `amount_group_currency` DECIMAL(18,2) COMMENT 'Monetary amount of the journal entry translated into the corporate group reporting currency (typically USD or EUR) for consolidated P&L reporting by therapeutic area, brand, and geography.',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'Monetary amount of the journal entry translated into the company codes local (functional) currency using the applicable exchange rate. Used for statutory financial reporting and local tax compliance.',
    `amount_transaction_currency` DECIMAL(18,2) COMMENT 'Gross monetary amount of the journal entry in the original transaction currency. For debit entries this is positive; for credit entries this is negative (SAP sign convention). Core monetary fact for the posting.',
    `assignment_field` STRING COMMENT 'SAP assignment field (ZUONR) used for sorting and matching open items in accounts payable, accounts receivable, and bank reconciliation. Typically populated with invoice number, payment reference, or contract number for automated clearing.',
    `business_area` STRING COMMENT 'SAP business area code representing an organizational unit for which an internal balance sheet and P&L can be drawn up. Used for segment reporting across geographies and therapeutic areas.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code` STRING COMMENT 'SAP company code identifying the legal entity for which the journal entry is posted. Enables P&L reporting by legal entity and supports multi-entity consolidation across the pharmaceutical group.. Valid values are `^[A-Z0-9]{4}$`',
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
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Internal orders are created for drug product CMC development, stability studies, and tech transfer activities. Linking internal_order to drug_product enables product-level R&D cost tracking and capita',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Internal orders for R&D projects are created within a legal entity for capitalization eligibility, transfer pricing, and statutory cost reporting. Pharma R&D orders must be entity-attributed for tax c',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Internal orders are owned by organizational units (R&D departments, manufacturing divisions) for program management reporting and budget allocation. Pharma R&D program tracking requires org unit attri',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility associated with this internal order. Relevant for CAPEX orders tied to facility investments or manufacturing overhead orders. Corresponds to WERKS in SAP AUFK.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center organizationally responsible for managing and monitoring this internal order. Corresponds to KOSTV in SAP AUFK. Used for P&L reporting by therapeutic area and organizational unit.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center associated with this internal order, enabling P&L reporting by therapeutic area, brand, or geography. Supports management accounting and ROI analysis for drug development programs.',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Internal orders in pharma R&D are organized by therapeutic area for cost allocation, budget variance reporting, and portfolio investment tracking. therapeutic_area on internal_order is a plain text de',
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
    CONSTRAINT pk_internal_order PRIMARY KEY(`internal_order_id`)
) COMMENT 'SAP CO internal order used to collect, monitor, and settle costs for specific projects, R&D programs, clinical trials, or capital expenditure initiatives. Captures order type (R&D, capex, overhead), settlement rule, budget profile, actual costs, commitment values, responsible cost center, project/WBS reference, and order lifecycle status. References milestone_payment records for contractual obligations but does NOT own milestone payment terms or trigger events. Supports R&D capitalization tracking, ROI analysis for drug development programs, and CAPEX lifecycle governance.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` (
    `accounts_payable_id` BIGINT COMMENT 'Unique surrogate identifier for each accounts payable record in the SAP FI-AP module, representing a single vendor invoice or payment obligation. Role: TRANSACTION_HEADER.',
    `bank_account_id` BIGINT COMMENT 'The identifier of the vendor bank account used for payment execution, referencing the SAP FI-AP bank details record. Sensitive financial data subject to PCI and SOX controls.',
    `cost_center_id` BIGINT COMMENT 'Reference to the internal cost center (e.g., R&D, Manufacturing, Clinical Operations) to which the payable is allocated for P&L reporting by therapeutic area or function.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: AP transactions post to GL accounts (liability accounts, expense accounts). The existing gl_account_code is a STRING; adding general_ledger_id FK links AP to the GL account master record. This further',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: AP invoices are posted within a legal entity for statutory payables reporting, VAT filing, and intercompany AP reconciliation. Pharma companies manage AP across multiple legal entities requiring entit',
    `payment_run_id` BIGINT COMMENT 'The SAP automatic payment program run identifier (F110 run ID) that generated the payment for this invoice. Enables batch payment reconciliation and audit trail for automated payment processing.',
    `royalty_agreement_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_agreement. Business justification: AP invoices for royalty payments (when company is licensee) should reference the governing royalty agreement for compliance, audit, and accrual tracking. Cardinality: Many AP invoices can reference on',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: AP invoices are received from vendors who are business partners (CROs, CMOs, raw material suppliers). Pharma AP processing requires vendor master linkage for payment terms, GMP qualification status, a',
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
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: AR records post to specific GL accounts (revenue, receivables). accounts_receivable has gl_account_code as a denormalized string. Adding general_ledger_id FK normalizes this to the canonical GL accoun',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: AR records belong to a legal entity for revenue recognition, statutory reporting, and intercompany AR elimination. Pharma revenue by legal entity is required for country-level market access and pricin',
    `masterdata_ndc_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.masterdata_ndc_code. Business justification: AR line items in pharma are tied to specific NDC codes for product-level revenue recognition, chargeback reconciliation, and government price reporting (Medicaid best price). The plain product_ndc is ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.profit_center. Business justification: AR is attributed to profit centers for therapeutic area revenue reporting and segment P&L. The plain profit_center column is denormalized; FK enables product-line revenue analytics required for pharma',
    `royalty_agreement_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_agreement. Business justification: AR invoices for royalty receipts (when company is licensor) should reference the governing royalty agreement for revenue recognition and compliance. Cardinality: Many AR invoices can reference one roy',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: AR in pharma tracks revenue by SKU for gross-to-net calculations, chargeback processing, and revenue recognition by product. product_ndc is a denormalized text field on AR; replacing with sku_id FK en',
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
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the General Ledger (GL) account to which this budget line is posted, enabling financial reporting and variance analysis.',
    `cost_center_id` BIGINT COMMENT 'Reference to the organizational cost center responsible for this budget line. Aligns with SAP CO cost center master data.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Budget line items are planned against specific GL accounts for variance reporting and P&L by therapeutic area. Linking budget to general_ledger enables budget-vs-actual analysis at the GL account leve',
    `internal_order_id` BIGINT COMMENT 'Reference to the SAP internal order used for tracking R&D program spend, clinical trial costs, or capital projects at a granular level.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Budgets are approved and tracked at legal entity level for statutory planning, transfer pricing documentation, and country-level P&L management. Pharma budget consolidation requires entity-level attri',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Pharmaceutical budgets are allocated by medicinal product for R&D investment, commercialization spend, and lifecycle management. Product-level budget tracking is fundamental to portfolio financial pla',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Budgets are allocated to organizational units (R&D departments, commercial divisions) for departmental planning and headcount budgeting. Pharma annual operating plan requires org unit budget attributi',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center associated with this budget, enabling P&L planning by therapeutic area, brand, or geography.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Fixed assets are assigned to cost centers for depreciation allocation to R&D or manufacturing cost pools. The plain cost_center_code is denormalized; FK enables asset-to-cost-center depreciation repor',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: GMP manufacturing equipment and dedicated production lines in pharma are allocated to specific drug products for depreciation cost allocation, GMP compliance tracking, and product costing. fixed_asset',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Fixed assets are reconciled to GL accounts (asset accounts, accumulated depreciation accounts) in SAP FI-AA. fixed_asset has gl_account_code as a denormalized string. Adding general_ledger_id FK norma',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Fixed assets acquired or constructed through capital projects are funded via SAP CO internal orders. The internal order collects all costs (materials, labor, overhead) during the asset construction/ac',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Fixed assets are owned by legal entities for statutory balance sheet reporting, tax depreciation, and insurance. Pharma GMP equipment must be entity-attributed for regulatory inspections and asset tra',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Fixed assets are physically located at manufacturing/R&D plants. Required for GMP equipment tracking, physical asset verification audits, site-level depreciation reporting, and regulatory inspection r',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.storage_location. Business justification: GMP-critical pharma equipment must be tracked to specific storage/manufacturing locations for regulatory inspections, qualification records, and physical asset verification. FDA/EMA audit trails requi',
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
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset master record was first created in the SAP FI-AA system. Used for audit trail, data lineage, and SOX compliance purposes.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this asset record (e.g., USD, EUR, GBP, JPY). Supports multi-currency reporting across global pharmaceutical operations.. Valid values are `^[A-Z]{3}$`',
    `deactivation_date` DATE COMMENT 'Date on which the asset was retired, disposed of, or deactivated in the SAP FI-AA asset register. Marks the end of the assets productive life and triggers the retirement posting to remove the asset from the balance sheet.',
    `depreciation_area_code` STRING COMMENT 'SAP FI-AA depreciation area identifier that specifies the valuation basis for the asset (e.g., 01 for book depreciation per local GAAP, 15 for IFRS, 20 for tax depreciation, 30 for cost accounting). Supports parallel accounting under IAS 16 and US GAAP ASC 360.',
    `depreciation_key` STRING COMMENT 'SAP FI-AA depreciation key that defines the depreciation method and calculation rules for the asset (e.g., LINR for straight-line, DGRV for declining balance, MANU for manual). Determines how periodic depreciation amounts are computed.',
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

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` (
    `royalty_agreement_id` BIGINT COMMENT 'Unique surrogate identifier for the royalty and licensing agreement record in the enterprise data platform (Silver Layer). Primary key for this master agreement entity.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Royalty agreements specify GL accounts for accrual and payment posting (gl_account_code is STRING). Adding general_ledger_id FK links the royalty agreement to the GL account master. This connects roya',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Royalty agreements specify governing law jurisdiction for dispute resolution and withholding tax rate determination. The plain governing_law_country is denormalized; FK enables country-level tax treat',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Royalty agreements are executed by specific legal entities as licensee for tax withholding, transfer pricing documentation, and statutory disclosure. Pharma IP licensing requires entity-level royalty ',
    `compound_id` BIGINT COMMENT 'Reference to the specific compound, drug substance (DS), or active pharmaceutical ingredient (API) that is the subject of the royalty agreement. Links to the compound master record in the discovery domain for IP cost tracking of in-licensed compounds.',
    `licensing_agreement_id` BIGINT COMMENT 'Reference to the parent licensing agreement in the intellectual property domain that governs the broader IP relationship, of which this royalty agreement may be a financial component or schedule. Links to intellectual.licensing_agreement.',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: Licensor is a business_partner (bp_role=Licensor). Essential for royalty payment processing, withholding tax calculation, audit rights enforcement, and vendor master data integration. Role-prefixed ',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Royalty agreements in pharma are scoped to therapeutic areas (e.g., oncology license). TA-level royalty reporting for portfolio management and deal economics requires a structured FK. therapeutic_area',
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
    `tier1_threshold_amount` DECIMAL(18,2) COMMENT 'Net sales threshold amount (in the agreement currency) at which the royalty rate transitions from the base rate to the tier 2 rate. For tiered agreements, net sales up to this amount are subject to base_royalty_rate_pct. Null for flat-rate agreements.',
    `tier2_royalty_rate_pct` DECIMAL(18,2) COMMENT 'Royalty rate percentage applicable to the second net sales tier for tiered or stepped royalty structures. Null for flat-rate agreements. Applied when cumulative or annual net sales exceed the tier 1 threshold defined in tier1_threshold_amount.',
    `tier2_threshold_amount` DECIMAL(18,2) COMMENT 'Net sales threshold amount (in the agreement currency) at which the royalty rate transitions from tier 2 to tier 3 rate. Null if the agreement has only two tiers or is flat-rate. Supports up to three-tier royalty structures common in pharmaceutical licensing.',
    `tier3_royalty_rate_pct` DECIMAL(18,2) COMMENT 'Royalty rate percentage applicable to net sales exceeding the tier 2 threshold for three-tier royalty structures. Null for flat-rate or two-tier agreements. Typically the highest rate in escalating structures or lowest in de-escalating structures.',
    `upfront_license_fee_amount` DECIMAL(18,2) COMMENT 'One-time non-refundable upfront payment made to the licensor upon execution of the agreement, separate from ongoing running royalties. Relevant for R&D capitalization assessment under FASB ASC 730 and IP cost tracking for in-licensed compounds.',
    `withholding_tax_rate_pct` DECIMAL(18,2) COMMENT 'Applicable withholding tax rate percentage on royalty payments as determined by the governing tax treaty between the licensor and licensee jurisdictions. Used for net payment calculation and tax reporting. Zero if no withholding tax applies under a treaty exemption.',
    CONSTRAINT pk_royalty_agreement PRIMARY KEY(`royalty_agreement_id`)
) COMMENT 'Master record and periodic accrual lifecycle for royalty and licensing agreements with external partners, universities, and IP licensors. Captures agreement terms (licensor/licensee, licensed compound, royalty rate structure including tiered rates, territory, effective dates, minimum payments, sublicensing rights, audit rights) and periodic accrual calculations (calculation period, net sales base, applicable rate tier, accrued royalty amount, currency, payment due date, settlement status). Serves as SSOT for royalty accounting obligations, IP cost tracking for in-licensed compounds, and royalty payment reconciliation across the pharmaceutical portfolio.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` (
    `milestone_payment_id` BIGINT COMMENT 'Unique system-generated identifier for each milestone payment obligation or receipt record. Primary key for the milestone_payment data product.',
    `business_partner_id` BIGINT COMMENT 'System identifier for the external counterparty (vendor or customer) in the SAP master data. Links to the vendor/customer master record for the partner organization.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the General Ledger account to which this milestone payment is posted in SAP FI. Determines the financial statement line item for the payment.',
    `cost_center_id` BIGINT COMMENT 'Reference to the SAP cost center responsible for this milestone payment obligation. Used for departmental cost allocation and management reporting.',
    `indication_id` BIGINT COMMENT 'Foreign key linking to product.indication. Business justification: Pharma licensing deals structure milestone payments around specific indication approvals (e.g., first oncology approval triggers $50M payment). Finance and BD teams must link each milestone payment to',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Each milestone payment triggers a journal entry for the financial posting. The milestone_payment currently has sap_document_number (STRING) which should be replaced with a proper FK to journal_entry. ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Milestone payments are booked within a legal entity for statutory reporting, transfer pricing compliance, and contingent liability disclosure. Pharma deal accounting requires entity-level milestone tr',
    `licensing_agreement_id` BIGINT COMMENT 'Reference to the parent licensing, collaboration, or partnership agreement under which this milestone payment obligation was established.',
    `profit_center_id` BIGINT COMMENT 'Reference to the SAP profit center for P&L reporting of this milestone payment by business unit, brand, or therapeutic area.',
    `project_id` BIGINT COMMENT 'Foreign key linking to discovery.discovery_project. Business justification: Milestone payments (in/out-licensing) are project-specific; linking enables accrual tracking, contingent liability management, portfolio valuation, and cash flow forecasting essential to pharmaceutica',
    `royalty_agreement_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_agreement. Business justification: Milestone payments in pharma licensing deals are often governed by royalty and licensing agreements. A royalty agreement may specify milestone-based payments (upfront license fees, regulatory approval',
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
    `cost_center_id` BIGINT COMMENT 'Reference to the SAP cost center responsible for the intercompany transfer pricing arrangement. Used for internal P&L allocation and management reporting by therapeutic area or geography.',
    `drug_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product, drug substance (DS), drug product (DP), active pharmaceutical ingredient (API), or finished dosage form (FDF) subject to this transfer price.',
    `site_id` BIGINT COMMENT 'Foreign key linking to manufacturing.site. Business justification: Transfer prices are set between specific manufacturing sites (sending entity) and receiving entities. Linking transfer_price to manufacturing.site enables intercompany pricing reports, tax authority d',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that is the seller or supplier in the intercompany transaction (the entity transferring the product, API, or service).',
    `prior_version_transfer_price_id` BIGINT COMMENT 'Reference to the immediately preceding version of this transfer price record (self-referential). Enables reconstruction of the full price history chain for audit and tax authority documentation purposes.',
    `profit_center_id` BIGINT COMMENT 'Reference to the SAP profit center associated with the intercompany transaction. Enables P&L reporting by therapeutic area, brand, or geography in SAP S/4HANA CO-PCA.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Transfer pricing rules are country-pair specific; the sending country determines applicable tax treaties, APA requirements, and documentation standards. The plain sending_country_code is denormalized;',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Transfer pricing analysis in pharma is segmented by therapeutic area for APA documentation, management reporting, and tax authority submissions. therapeutic_area on transfer_price is a plain text deno',
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
    `record_number` STRING COMMENT 'Externally-known business identifier for the transfer pricing record, used in intercompany agreements, tax authority documentation, and OECD compliance filings. Format: TP-YYYY-NNNNNN.. Valid values are `^TP-[0-9]{4}-[0-9]{6}$`',
    `record_status` STRING COMMENT 'Current lifecycle state of the transfer pricing record. Active records govern live intercompany transactions; superseded records have been replaced by a newer version. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|superseded|expired|cancelled — promote to reference product]',
    `regulatory_doc_ref` STRING COMMENT 'Reference to the formal transfer pricing documentation package (local file, master file, or country-by-country report) filed with tax authorities in accordance with OECD BEPS Action 13 requirements. May reference a Veeva Vault document ID or SAP document number.',
    `review_frequency` STRING COMMENT 'The scheduled frequency at which this transfer price is reviewed and potentially revised to ensure continued arms-length compliance. Annual review is the OECD standard minimum.. Valid values are `annual|semi_annual|quarterly|ad_hoc`',
    `source_system` STRING COMMENT 'The operational system of record from which this transfer price record originates (e.g., SAP S/4HANA FI/CO, manual entry via spreadsheet, or a Regulatory Information Management System). Supports data lineage tracking in the Databricks Silver layer.. Valid values are `SAP_S4HANA|manual|RIMS|other`',
    `tax_ruling_ref` STRING COMMENT 'Reference to any binding tax ruling, private letter ruling, or competent authority agreement issued by a tax authority that specifically governs or validates this transfer pricing arrangement.',
    `transaction_type` STRING COMMENT 'Nature of the intercompany transaction governed by this transfer price: tangible goods (products/APIs), services (manufacturing, R&D, distribution), IP licensing, cost-sharing arrangements, or intercompany loans.. Valid values are `goods|services|IP_license|cost_sharing|loan`',
    `version_number` STRING COMMENT 'Sequential version number of the transfer price record for a given product-entity pair. Incremented each time the price is revised. Enables audit trail and historical price reconstruction for tax authority inquiries.',
    `withholding_tax_applicable` BOOLEAN COMMENT 'Indicates whether withholding tax applies to the intercompany transaction governed by this transfer price (e.g., royalty payments or service fees may be subject to withholding tax under bilateral tax treaties).',
    `withholding_tax_rate_pct` DECIMAL(18,2) COMMENT 'The applicable withholding tax rate (as a decimal percentage) on the intercompany payment, as determined by the bilateral tax treaty between the sending and receiving entity jurisdictions. Null if withholding_tax_applicable is False.',
    CONSTRAINT pk_transfer_price PRIMARY KEY(`transfer_price_id`)
) COMMENT 'Transfer pricing master records governing the prices at which pharmaceutical products, APIs, and services are transacted between related legal entities across jurisdictions. Captures product or service, sending entity, receiving entity, transfer price method (CUP, cost-plus, TNMM), approved price, currency, effective date, and regulatory documentation reference. Supports OECD transfer pricing compliance and tax authority documentation.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key for payment_run',
    `bank_account_id` BIGINT COMMENT 'Reference to the company bank account from which payments in this run will be disbursed.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (operating company or subsidiary) executing this payment run.',
    `prior_payment_run_id` BIGINT COMMENT 'Self-referencing FK on payment_run (prior_payment_run_id)',
    `approval_status` STRING COMMENT 'Current approval state of the payment run within the authorization workflow.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the payment run received final approval to proceed.',
    `confirmation_number` STRING COMMENT 'Confirmation or acknowledgment number received from the bank or payment processor upon successful file receipt.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the payment run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment run (e.g., USD, EUR, GBP).',
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
    `payment_run_description` STRING COMMENT 'Free-text description providing additional context about the purpose or scope of this payment run.',
    `payment_run_status` STRING COMMENT 'Current lifecycle status of the payment run in the payment processing workflow.',
    `processing_priority` STRING COMMENT 'Priority level assigned to the payment run for queue management and execution sequencing.',
    `reconciled_timestamp` TIMESTAMP COMMENT 'Date and time when the payment run was successfully reconciled with banking records.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether the payment run has been reconciled with bank statements and general ledger postings.',
    `run_number` STRING COMMENT 'Business identifier for the payment run, formatted as PR-YYYYMMDD-NNNN for external reference and audit tracking.',
    `run_type` STRING COMMENT 'Classification of the payment run indicating its purpose and processing priority.',
    `scheduled_date` DATE COMMENT 'The planned date when the payment run is scheduled to execute and disburse funds.',
    `total_amount` DECIMAL(18,2) COMMENT 'The aggregate monetary value of all payments in this run before any adjustments or fees.',
    `transmission_timestamp` TIMESTAMP COMMENT 'Date and time when the payment file was transmitted to the bank or payment processor.',
    `value_date` DATE COMMENT 'The effective date when funds are to be available to payees, used for cash flow planning and bank reconciliation.',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Master reference table for payment_run. Referenced by payment_run_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Primary key for bank_account',
    `address_id` BIGINT COMMENT 'Foreign key linking to masterdata.address. Business justification: Bank branch address is required for correspondent banking documentation, regulatory filings, and KYC compliance. The plain branch_address and branch_city columns are denormalized; FK to address master',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for transactions in this bank account.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Bank accounts are held in specific countries for treasury management, FX exposure reporting, and regulatory compliance (FBAR, FATCA). The plain branch_country_code is denormalized; FK enables country-',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Bank accounts are mapped to GL accounts (house bank accounts) in SAP FI for bank reconciliation. bank_account has general_ledger_account_code as a denormalized string. Adding general_ledger_id FK norm',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that owns or controls this bank account.',
    `master_account_bank_account_id` BIGINT COMMENT 'Reference to the master bank account if this is a subsidiary or zero balance account. Null if this is a standalone account.',
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
    `branch_code` STRING COMMENT 'The unique code identifying the bank branch within the financial institutions network.',
    `branch_name` STRING COMMENT 'The name of the specific bank branch where the account is held.',
    `closing_date` DATE COMMENT 'The date when the bank account was closed or deactivated. Null if the account is still open.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code representing the primary currency of the bank account.',
    `current_balance` DECIMAL(18,2) COMMENT 'The current balance of the bank account in the accounts primary currency as of the last reconciliation.',
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
    `business_partner_id` BIGINT COMMENT 'Reference to the customer or organization to whom this invoice is issued.',
    `contract_id` BIGINT COMMENT 'Reference to the master contract or agreement under which this invoice is issued, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Invoices are assigned to cost centers for cost allocation to R&D programs or commercial operations. The plain cost_center column is denormalized; FK enables cost center-level spend reporting and budge',
    `credited_invoice_id` BIGINT COMMENT 'Self-referencing FK on invoice (credited_invoice_id)',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Invoices post to specific GL accounts for revenue recognition and AR/AP accounting. invoice has general_ledger_account as a denormalized string. Adding general_ledger_id FK normalizes this to the cano',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: In SAP FI/CO, invoices can be assigned to internal orders for R&D cost capitalization tracking and project cost collection. invoice has cost_center (STRING) but no internal_order reference. Adding int',
    `address_id` BIGINT COMMENT 'Reference to the billing address where the invoice is sent.',
    `invoice_ship_to_address_id` BIGINT COMMENT 'Reference to the shipping address where the goods or services were delivered.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Invoices are issued by or to legal entities for VAT reporting, revenue recognition, and statutory disclosure. Pharma invoicing across multiple legal entities requires entity attribution for country-le',
    `payment_run_id` BIGINT COMMENT 'Foreign key linking to finance.payment_run. Business justification: Invoices are cleared through payment runs in SAP FI. Linking invoice to payment_run enables tracking of which payment run settled each invoice, supporting payment reconciliation and cash management re',
    `sales_order_id` BIGINT COMMENT 'Reference to the originating sales order that this invoice fulfills.',
    `billing_period_end_date` DATE COMMENT 'The end date of the period covered by this invoice, relevant for subscription or recurring billing.',
    `billing_period_start_date` DATE COMMENT 'The start date of the period covered by this invoice, relevant for subscription or recurring billing.',
    `business_unit` STRING COMMENT 'The business unit or division responsible for this invoice, used for internal financial reporting and cost allocation.',
    `created_by_user` STRING COMMENT 'The username or identifier of the user who created this invoice record.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this invoice is denominated.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total discount amount applied to this invoice, including volume discounts, promotional discounts, or early payment discounts.',
    `dispute_date` DATE COMMENT 'The date on which the customer raised a dispute for this invoice.',
    `dispute_reason` STRING COMMENT 'The reason provided by the customer for disputing this invoice, if applicable.',
    `due_date` DATE COMMENT 'The date by which payment is expected from the customer per the agreed payment terms.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the invoice currency to the companys functional currency at the time of invoice creation.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ADD CONSTRAINT `fk_finance_royalty_agreement_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_prior_version_transfer_price_id` FOREIGN KEY (`prior_version_transfer_price_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_prior_payment_run_id` FOREIGN KEY (`prior_payment_run_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_master_account_bank_account_id` FOREIGN KEY (`master_account_bank_account_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_parent_bank_account_id` FOREIGN KEY (`parent_bank_account_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_credited_invoice_id` FOREIGN KEY (`credited_invoice_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`payment_run`(`payment_run_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `pharmaceuticals_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_subdomain' = 'accounting_control');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'accounting_control');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` SET TAGS ('dbx_subdomain' = 'accounting_control');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Cost Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Account ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Business Partner Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `masterdata_ndc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Ndc Code Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'accounting_control');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
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
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'accounting_control');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Deactivation Date');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area_code` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area Code');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_key` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Key');
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
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` SET TAGS ('dbx_subdomain' = 'partner_licensing');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `compound_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Compound ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Licensor Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` SET TAGS ('dbx_subdomain' = 'partner_licensing');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `milestone_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Payment ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `indication_id` SET TAGS ('dbx_business_glossary_term' = 'Indication Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Project Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` SET TAGS ('dbx_subdomain' = 'partner_licensing');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `transfer_price_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Legal Entity ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `prior_version_transfer_price_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Version Transfer Price ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Record Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `record_number` SET TAGS ('dbx_value_regex' = '^TP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Record Status');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `regulatory_doc_ref` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Documentation Reference');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `regulatory_doc_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Review Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|ad_hoc');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|manual|RIMS|other');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `tax_ruling_ref` SET TAGS ('dbx_business_glossary_term' = 'Tax Ruling Reference');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `tax_ruling_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'goods|services|IP_license|cost_sharing|loan');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Version Number');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `withholding_tax_applicable` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Applicable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `withholding_tax_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ALTER COLUMN `withholding_tax_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ALTER COLUMN `prior_payment_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Address Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `master_account_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `master_account_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `account_manager_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `account_manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ALTER COLUMN `credited_invoice_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ALTER COLUMN `invoice_ship_to_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ALTER COLUMN `invoice_ship_to_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Id (Foreign Key)');
