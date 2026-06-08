-- Schema for Domain: finance | Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:47

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`finance` COMMENT 'SSOT for corporate financial management — general ledger, accounts payable, cost accounting, CAPEX/OPEX tracking, budgeting, financial planning, EBITDA analysis, ROI measurement, procurement, financial consolidation, and intercompany transactions. Managed via SAP S/4HANA Finance and Procurement modules.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`general_ledger` (
    `general_ledger_id` BIGINT COMMENT 'Unique identifier for the general ledger account master record. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the chart of accounts to which this GL account belongs. Supports multi-entity consolidation and statutory reporting requirements.',
    `company_code_id` BIGINT COMMENT 'Reference to the company code for which this GL account is configured. Enables company-specific account properties and local statutory reporting.',
    `controlling_area_id` BIGINT COMMENT 'Reference to the controlling area for management accounting and cost center assignment. Links financial accounting to cost accounting for OPEX and CAPEX tracking.',
    `cost_element_id` BIGINT COMMENT 'Reference to the cost element in controlling (CO) module. Links GL account to cost accounting for CAPEX/OPEX tracking and profitability analysis.',
    `functional_area_id` BIGINT COMMENT 'Reference to the functional area for segment reporting and cost-of-sales accounting. Enables classification by business function (e.g., network operations, sales, administration).',
    `house_bank_id` BIGINT COMMENT 'Reference to the house bank associated with this GL account for cash management and bank reconciliation. Applicable to bank clearing accounts.',
    `account_group` STRING COMMENT 'Account group code that controls field status, number range assignment, and screen layout for the GL account. Defines account behavior and validation rules.',
    `account_name_long` STRING COMMENT 'Full descriptive name of the GL account providing complete business context and purpose of the account.',
    `account_name_short` STRING COMMENT 'Short descriptive name of the GL account, typically 20-40 characters, used in reports and user interfaces for quick identification.',
    `account_status` STRING COMMENT 'Current lifecycle status of the GL account. Active accounts accept postings; inactive accounts are retained for historical reporting; blocked accounts prevent new postings; pending closure accounts are scheduled for deactivation.. Valid values are `active|inactive|blocked|pending_closure`',
    `account_type` STRING COMMENT 'Classification of the account into balance sheet (asset, liability, equity) or profit and loss (revenue, expense) categories, or statistical for non-financial tracking.. Valid values are `asset|liability|equity|revenue|expense|statistical`',
    `alternative_account_number` STRING COMMENT 'Alternative or legacy account number used for mapping to external systems, prior chart of accounts, or regulatory reporting requirements.',
    `balance_sheet_account_type` STRING COMMENT 'Sub-classification for balance sheet accounts into current vs. fixed assets, current vs. long-term liabilities, and equity for liquidity analysis and financial ratio calculation.. Valid values are `current_asset|fixed_asset|current_liability|long_term_liability|equity|not_applicable`',
    `cash_flow_relevant_flag` BOOLEAN COMMENT 'Indicates whether postings to this account are relevant for cash flow statement generation. True includes transactions in operating, investing, or financing cash flow categories.',
    `created_by_user` STRING COMMENT 'User ID of the person who created this GL account master record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this GL account master record was created in the system. Supports audit trail and compliance requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the accounts local currency. Determines currency in which balances are maintained and reported.. Valid values are `^[A-Z]{3}$`',
    `field_status_group` STRING COMMENT 'Field status group code that controls which fields are required, optional, or suppressed during posting transactions to this account.',
    `financial_statement_item` STRING COMMENT 'Financial statement line item code to which this GL account maps for balance sheet and income statement reporting. Enables automated financial statement generation.',
    `gl_account_number` STRING COMMENT 'The unique account number in the chart of accounts. Typically 6-10 digit numeric code used as the business identifier for all financial postings and reporting.. Valid values are `^[0-9]{6,10}$`',
    `inflation_key` STRING COMMENT 'Inflation index key used for inflation-adjusted reporting in hyperinflationary economies. Enables IAS 29 compliance for financial statement restatement.',
    `interest_indicator` STRING COMMENT 'Interest calculation indicator code that determines whether and how interest is calculated on balances in this account (e.g., for customer deposits, vendor payables).',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified this GL account master record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this GL account master record was last modified. Tracks change history for audit and compliance.',
    `line_item_display_flag` BOOLEAN COMMENT 'Indicates whether individual line items are stored and can be displayed for this account. True enables drill-down to transaction-level detail; false stores only balances.',
    `open_item_management_flag` BOOLEAN COMMENT 'Indicates whether open item management is active for this account. True enables tracking of open and cleared items for accounts requiring item-level reconciliation.',
    `planning_level` STRING COMMENT 'Planning level code indicating the granularity at which budget planning and forecasting is performed for this account (e.g., cost center, profit center, segment).',
    `posting_block_flag` BOOLEAN COMMENT 'Indicates whether postings to this account are blocked. True prevents any new transactions from being posted to the account.',
    `profit_center_update_flag` BOOLEAN COMMENT 'Indicates whether profit center is a mandatory field for postings to this account. True enforces profit center assignment for segment profitability reporting.',
    `profit_loss_account_type` STRING COMMENT 'Classification for P&L accounts distinguishing between primary costs (direct), secondary costs (allocated), revenue, and other categories for cost accounting and profitability analysis.. Valid values are `primary_cost|secondary_cost|revenue|other`',
    `reconciliation_account_flag` BOOLEAN COMMENT 'Indicates whether this GL account is a reconciliation account for subledgers (accounts receivable, accounts payable, asset accounting). True if subledger postings automatically update this GL account.',
    `sample_account_flag` BOOLEAN COMMENT 'Indicates whether this is a sample or template account used for training or testing purposes. True excludes account from production reporting.',
    `segment_reporting_flag` BOOLEAN COMMENT 'Indicates whether this account is relevant for segment reporting under IFRS 8. True includes account balances in segment-level financial statements.',
    `sort_key` STRING COMMENT 'Default sort key code that determines the assignment number format for postings to this account (e.g., by posting date, document number, or custom logic).',
    `tax_category` STRING COMMENT 'Tax category code indicating whether the account is subject to input tax, output tax, or is tax-exempt. Controls automatic tax calculation on postings.',
    `tolerance_group` STRING COMMENT 'Tolerance group code that defines permissible payment differences, cash discount limits, and exchange rate variances for postings to this account.',
    `valid_from_date` DATE COMMENT 'The date from which this GL account is valid and available for posting transactions. Supports time-dependent account configuration.',
    `valid_to_date` DATE COMMENT 'The date until which this GL account is valid. Null indicates the account is valid indefinitely. Used for account lifecycle management and historical reporting.',
    `valuation_group` STRING COMMENT 'Valuation group code used for foreign currency valuation and mark-to-market adjustments. Determines valuation method for balance sheet accounts.',
    CONSTRAINT pk_general_ledger PRIMARY KEY(`general_ledger_id`)
) COMMENT 'SSOT for the corporate chart of accounts and GL account master data in SAP S/4HANA Finance. Each record represents a single GL account with its account number, description, account type (P&L, balance sheet, statistical), account group, controlling area assignment, currency settings, and tax category. Serves as the foundational reference for all financial postings, trial balance generation, and statutory/management reporting across the telecom enterprise. Does NOT store balances or postings — those reside in journal_entry.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record. Primary key for the journal entry product.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Journal entry is posted to a legal entity. N:1 relationship (many journal entries per company). The company_code_id FK will link to company_code.company_code_id. The existing company_code STRING attri',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entry may be assigned to a cost center for cost tracking. N:1 relationship (many journal entries per cost center). The cost_center_id FK will link to cost_center.cost_center_id. The existing c',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Journal entry may be assigned to a profit center for profitability analysis. N:1 relationship (many journal entries per profit center). The profit_center_id FK will link to profit_center.profit_center',
    `assignment_field` STRING COMMENT 'Free-text field used for additional reference information such as invoice numbers, purchase order numbers, or payment references. Supports reconciliation and audit trail requirements.',
    `baseline_date` DATE COMMENT 'The reference date from which payment due dates and cash discount periods are calculated. Typically the invoice date or goods receipt date.',
    `business_area` STRING COMMENT 'The business segment or division for cross-company code reporting. Enables consolidated financial statements by business line (e.g., wireless, broadband, enterprise services).',
    `clearing_date` DATE COMMENT 'The date on which the journal entry line item was cleared through payment, reconciliation, or offsetting entry. Used for accounts receivable, accounts payable, and balance sheet reconciliation.',
    `clearing_document_number` STRING COMMENT 'The accounting document number that cleared this journal entry line item. Links the original entry to its settlement or reconciliation document.',
    `company_code` STRING COMMENT 'The organizational unit representing the legal entity for which financial statements are prepared. Identifies the company within the SAP S/4HANA system.',
    `cost_center` STRING COMMENT 'The organizational unit responsible for the costs or revenues recorded in the journal entry. Used for internal management accounting, OPEX tracking, and departmental P&L analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the journal entry record was first created in the SAP S/4HANA system. Used for audit trail and data lineage tracking.',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether the journal entry line item is a debit (D) or credit (C) posting. Fundamental accounting classification for double-entry bookkeeping and trial balance generation.. Valid values are `D|C`',
    `document_date` DATE COMMENT 'The date of the original business transaction or source document that triggered the journal entry. May differ from posting date for backdated or delayed entries.',
    `document_number` STRING COMMENT 'The externally-known unique accounting document number assigned by SAP S/4HANA. This is the business identifier for the journal entry used in financial reporting and audit trails.',
    `document_type` STRING COMMENT 'Classification code that categorizes the journal entry by its business purpose (e.g., invoice, payment, accrual, reversal, CAPEX activation, intercompany settlement). Determines posting rules and account determination logic.',
    `due_date` DATE COMMENT 'The date by which payment is due based on payment terms. Used for cash flow forecasting and accounts payable/receivable aging analysis.',
    `entry_date` DATE COMMENT 'The date when the journal entry was physically entered into the SAP S/4HANA system by the user. Used for audit trail and data entry tracking.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year when the journal entry was posted. Supports monthly and quarterly financial reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the journal entry was posted. Used for period-based financial reporting and year-end closing processes.',
    `functional_area` STRING COMMENT 'Classification of the journal entry by business function (e.g., sales, marketing, network operations, customer service, administration). Used for functional cost analysis and EBITDA reporting by function.',
    `gl_account` STRING COMMENT 'The general ledger account number to which the journal entry line item is posted. Represents the chart of accounts classification for financial statement line items (assets, liabilities, equity, revenue, expenses).',
    `group_amount` DECIMAL(18,2) COMMENT 'The monetary amount of the journal entry line item translated into the corporate groups reporting currency. Used for consolidated financial reporting and group-wide analytics.',
    `group_currency` STRING COMMENT 'The three-letter ISO 4217 currency code of the corporate groups reporting currency. Used for consolidated financial statements and group-level EBITDA analysis.. Valid values are `^[A-Z]{3}$`',
    `intercompany_partner` STRING COMMENT 'The company code of the intercompany trading partner for intercompany transactions. Used for intercompany reconciliation and elimination entries in consolidated financial statements.',
    `internal_order` STRING COMMENT 'The internal order number used to collect costs for specific activities, campaigns, or short-term projects. Supports detailed cost tracking for OPEX initiatives and overhead allocation.',
    `ledger_group` STRING COMMENT 'The ledger classification for parallel accounting scenarios (e.g., local GAAP, IFRS, tax ledger). Supports multiple accounting principles within the Universal Journal.',
    `local_amount` DECIMAL(18,2) COMMENT 'The monetary amount of the journal entry line item translated into the company codes local currency. Used for statutory financial statements and local GAAP reporting.',
    `local_currency` STRING COMMENT 'The three-letter ISO 4217 currency code of the company codes local currency. Used for legal entity financial statements and statutory reporting.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the journal entry record was last modified in the SAP S/4HANA system. Used for change tracking and audit compliance.',
    `payment_terms` STRING COMMENT 'The payment terms code defining due date calculation and cash discount conditions. Used for accounts payable and accounts receivable management.',
    `posting_date` DATE COMMENT 'The date on which the journal entry was posted to the general ledger. This is the principal business event timestamp that determines the fiscal period assignment and financial statement impact.',
    `posting_key` STRING COMMENT 'Two-digit code that controls whether a line item is a debit or credit and determines the account type (GL, customer, vendor, asset). Standard SAP posting keys include 40 (debit GL), 50 (credit GL), 01 (debit customer), 11 (credit customer), 31 (debit vendor), 21 (credit vendor).',
    `posting_status` STRING COMMENT 'Current lifecycle status of the journal entry. Posted indicates the entry is final and impacts the general ledger; parked indicates a draft entry pending approval; cleared indicates the entry has been reconciled; reversed indicates the entry has been reversed.. Valid values are `posted|parked|cleared|reversed`',
    `posting_user` STRING COMMENT 'The SAP user ID of the person who posted the journal entry. Used for audit trail, segregation of duties monitoring, and user activity tracking.',
    `profit_center` STRING COMMENT 'The organizational unit for which separate profit and loss statements are prepared. Enables segment reporting and business unit performance analysis for EBITDA decomposition.',
    `reference_key` STRING COMMENT 'Additional reference field for external document numbers, contract references, or cross-system identifiers. Used for traceability to source systems and external documents.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry is a reversal of a previous posting. True if the entry reverses a prior transaction, false otherwise. Used for accrual reversals and error corrections.',
    `reversal_reason` STRING COMMENT 'Code indicating the business reason for the reversal (e.g., error correction, accrual reversal, period-end adjustment). Supports audit requirements and financial control processes.',
    `reversed_document_number` STRING COMMENT 'The accounting document number of the original journal entry that is being reversed by this entry. Populated only when reversal_indicator is true. Maintains audit trail for reversals.',
    `segment` STRING COMMENT 'The reportable segment for external financial reporting under IFRS 8 or ASC 280. Supports segment disclosure requirements for regulatory filings with FCC and SEC.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount in the transaction currency. Represents sales tax, VAT, GST, or other indirect taxes associated with the journal entry.',
    `tax_code` STRING COMMENT 'The tax jurisdiction and rate code applied to the journal entry line item. Determines tax calculation for sales tax, VAT, GST, or other indirect taxes.',
    `text_description` STRING COMMENT 'Free-text description of the journal entry line item providing business context and explanation. Used for audit documentation and financial statement notes.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary amount of the journal entry line item in the transaction currency. Represents the original business transaction value before currency translation.',
    `transaction_currency` STRING COMMENT 'The three-letter ISO 4217 currency code in which the original transaction was denominated (e.g., USD, EUR, GBP). Used for multi-currency accounting and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `wbs_element` STRING COMMENT 'The project or investment program identifier for CAPEX tracking. Links journal entries to capital projects for asset under construction accounting and project cost management.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'SSOT for all financial postings to the general ledger in SAP S/4HANA Universal Journal (ACDOCA). Captures document header (posting date, fiscal period, document type, company code, currency, reference, posting user) and individual line items (GL account, debit/credit amount in transaction/local currency, cost center, profit center, WBS element, tax code, assignment field). Each entry is the atomic unit of financial accounting covering CAPEX activations, OPEX accruals, intercompany settlements, revenue recognition, and period-end adjustments. Supports trial balance generation, P&L/balance sheet reporting, and EBITDA decomposition.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for granular financial transaction tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entry line may be assigned to a cost center for detailed cost tracking. N:1 relationship (many line items per cost center). The cost_center_id FK will link to cost_center.cost_center_id. The e',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Journal entry line posts to a specific GL account. N:1 relationship (many line items per GL account). The general_ledger_id FK will link to general_ledger.general_ledger_id. The existing gl_account_co',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header document. Links this line to the overall posting transaction.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Journal entry line may be assigned to a profit center for detailed profitability analysis. N:1 relationship (many line items per profit center). The profit_center_id FK will link to profit_center.prof',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'The monetary amount of this line item converted to the local reporting currency of the legal entity. Used for statutory reporting and consolidation.',
    `amount_transaction_currency` DECIMAL(18,2) COMMENT 'The monetary amount of this line item in the original transaction currency. Used for multi-currency operations and foreign exchange tracking.',
    `asset_number` STRING COMMENT 'Fixed asset number for asset-related postings. Links journal entries to network infrastructure assets, CAPEX investments, and depreciation schedules.. Valid values are `^[A-Z0-9]{6,12}$`',
    `asset_subnumber` STRING COMMENT 'Sub-asset number for detailed asset component tracking. Enables granular depreciation and asset lifecycle management.. Valid values are `^[0-9]{4}$`',
    `assignment_field` STRING COMMENT 'Free-text assignment field for additional reference information such as invoice numbers, contract IDs, or project phases. Enhances traceability and audit trail.',
    `baseline_date` DATE COMMENT 'Baseline date for payment terms calculation. Determines due date for accounts payable and receivable items.',
    `business_area_code` STRING COMMENT 'Business area classification for cross-company code reporting. Enables consolidated financial statements across multiple legal entities.. Valid values are `^[A-Z0-9]{4}$`',
    `clearing_date` DATE COMMENT 'Date on which this line item was cleared. Indicates when an open item was settled or matched.',
    `clearing_document_number` STRING COMMENT 'Document number of the clearing transaction if this line item has been cleared. Used for accounts payable/receivable reconciliation.. Valid values are `^[0-9]{10}$`',
    `created_by_user` STRING COMMENT 'User ID of the person or system account that created this journal entry line. Supports audit and compliance requirements.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry line record was created in the system. Audit trail for data lineage.',
    `customer_code` STRING COMMENT 'Customer account number for accounts receivable line items. Links revenue postings to customer master data and ARPU analysis.. Valid values are `^[A-Z0-9]{6,10}$`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this line is a debit (D) or credit (C) posting. Fundamental to double-entry bookkeeping.. Valid values are `D|C`',
    `functional_area_code` STRING COMMENT 'Functional area for cost-of-sales accounting and functional P&L reporting. Distinguishes between operations, sales, administration, and R&D costs.. Valid values are `^[A-Z0-9]{4,6}$`',
    `gl_account_code` STRING COMMENT 'The general ledger account number to which this line item is posted. Core dimension for P&L and balance sheet classification.. Valid values are `^[0-9]{6,10}$`',
    `internal_order_number` STRING COMMENT 'Internal order used for tracking specific cost collection objects such as maintenance orders, marketing campaigns, or overhead allocation.. Valid values are `^[A-Z0-9]{6,12}$`',
    `last_modified_by_user` STRING COMMENT 'User ID of the person or system account that last modified this journal entry line. Maintains change history for compliance.. Valid values are `^[A-Z0-9]{6,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry line was last modified. Tracks changes for audit and reconciliation purposes.',
    `line_item_number` STRING COMMENT 'Sequential line number within the journal entry document. Determines the ordering and position of this line in the posting.',
    `line_item_status` STRING COMMENT 'Current processing status of this line item. Tracks lifecycle from initial posting through clearing or blocking.. Valid values are `open|cleared|parked|blocked`',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the local reporting currency. Typically the functional currency of the operating entity.. Valid values are `^[A-Z]{3}$`',
    `material_number` STRING COMMENT 'Material master number for inventory and procurement postings. Links financial transactions to physical goods and CPE inventory.. Valid values are `^[A-Z0-9]{8,18}$`',
    `partner_profit_center_code` STRING COMMENT 'Partner profit center for intercompany and internal transfer pricing postings. Enables elimination entries and internal revenue tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `payment_terms_code` STRING COMMENT 'Payment terms key defining the due date calculation and cash discount conditions for this line item.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_key` STRING COMMENT 'Two-digit posting key that controls the account type, debit/credit indicator, and field status for this line item. Core SAP configuration element.. Valid values are `^[0-9]{2}$`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity posted in this line item for quantity-based accounts. Supports inventory valuation and material consumption tracking.',
    `reference_document_number` STRING COMMENT 'External reference document number such as vendor invoice number, customer billing document, or bank statement reference. Links financial posting to source document.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this line item is a reversal of a previous posting. Used for error correction and period-end adjustments.',
    `reversed_document_number` STRING COMMENT 'Document number of the original posting that this line item reverses. Maintains audit trail for corrections.. Valid values are `^[0-9]{10}$`',
    `segment_code` STRING COMMENT 'Segment for IFRS segment reporting requirements. Typically represents major business lines such as wireless, broadband, enterprise services.. Valid values are `^[A-Z0-9]{4,10}$`',
    `special_gl_indicator` STRING COMMENT 'Special GL indicator for down payments, guarantees, bills of exchange, or other special ledger transactions. Enables specialized financial processing.. Valid values are `^[A-Z]$`',
    `tax_amount_local_currency` DECIMAL(18,2) COMMENT 'The calculated tax amount for this line item in local currency. Supports tax reporting and reconciliation to tax authorities.',
    `tax_code` STRING COMMENT 'Tax code determining the tax treatment of this line item. Drives VAT, sales tax, and GST calculation for compliance and reporting.. Valid values are `^[A-Z0-9]{2,4}$`',
    `text_description` STRING COMMENT 'Descriptive text explaining the business purpose or nature of this journal entry line. Provides context for auditors and financial analysts.',
    `trading_partner_code` STRING COMMENT 'Trading partner company code for intercompany transactions. Essential for consolidation eliminations and intercompany reconciliation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `transaction_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction amount (e.g., USD, EUR, GBP). Enables multi-currency financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity field (e.g., EA for each, KG for kilogram, HR for hours). Standardizes quantity reporting.. Valid values are `^[A-Z]{2,3}$`',
    `value_date` DATE COMMENT 'The value date for this line item, representing when the financial effect takes place. Used for cash flow analysis and interest calculation.',
    `vendor_code` STRING COMMENT 'Vendor account number for accounts payable line items. Enables supplier spend analysis and procurement reporting.. Valid values are `^[A-Z0-9]{6,10}$`',
    `wbs_element_code` STRING COMMENT 'The WBS element for project-related postings. Critical for CAPEX tracking, network infrastructure projects, and capital investment analysis in telecom.. Valid values are `^[A-Z0-9-]{6,24}$`',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual line item within a journal entry posting, representing a debit or credit to a specific GL account, cost center, profit center, or WBS element. Captures amount in transaction and local currency, tax code, assignment field, and controlling object references. Essential for granular P&L and balance sheet analysis, EBITDA decomposition, and CAPEX/OPEX classification in the telecom finance domain.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center in the SAP Controlling (CO) module. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Cost center belongs to a legal entity. N:1 relationship (many cost centers per company). The company_code_id FK will link to company_code.company_code_id. The existing company_code STRING attribute is',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Site-specific cost centers track operational expenses (power, rent, maintenance, security) for individual network sites. Required for site-level opex tracking, cost-per-site KPIs, lease cost allocatio',
    `parent_cost_center_id` BIGINT COMMENT 'Identifier of the parent cost center in the cost center hierarchy. Null for top-level cost centers.',
    `activity_type_code` STRING COMMENT 'The primary activity type code used for activity-based costing and internal service allocation (e.g., labor hours, machine hours, service calls).. Valid values are `^[A-Z0-9]{4,10}$`',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'The cumulative actual costs posted to this cost center in the current fiscal year.',
    `approval_status` STRING COMMENT 'Current approval status of the cost center setup or budget allocation (pending, approved, rejected).. Valid values are `pending|approved|rejected`',
    `approved_by_user` STRING COMMENT 'Username or identifier of the user who approved this cost center or its budget.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center or its budget was approved.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The approved annual budget amount allocated to this cost center for the current fiscal year.',
    `business_area_code` STRING COMMENT 'Business area code for cross-company code reporting and segment analysis (e.g., Wireless, Broadband, Enterprise Services).. Valid values are `^[A-Z0-9]{4}$`',
    `capex_opex_indicator` STRING COMMENT 'Indicates whether costs in this cost center are primarily capital expenditures, operational expenditures, or a mix of both.. Valid values are `CAPEX|OPEX|MIXED`',
    `committed_cost_amount` DECIMAL(18,2) COMMENT 'The amount of costs committed but not yet posted (e.g., purchase orders, reservations) against this cost center.',
    `controlling_area_code` STRING COMMENT 'The controlling area to which this cost center belongs. Controlling area is the highest organizational unit in SAP CO.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_allocation_method` STRING COMMENT 'The method used to allocate costs from this cost center to other cost objects (e.g., direct assignment, activity-based costing, percentage allocation).. Valid values are `direct|indirect|activity_based|percentage|driver_based`',
    `cost_center_category` STRING COMMENT 'Classification of the cost center by functional category. Determines how costs are allocated and reported.. Valid values are `production|service|administration|sales|research_development|support`',
    `cost_center_code` STRING COMMENT 'The externally-known alphanumeric code that uniquely identifies the cost center within the controlling area. Used in financial reporting and budget allocation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `cost_center_description` STRING COMMENT 'Extended textual description of the cost centers purpose, scope, and responsibilities within the organization.',
    `cost_center_name` STRING COMMENT 'The full descriptive name of the cost center (e.g., Network Operations Center, RAN Engineering, Customer Care - Tier 1).',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active cost centers can accept postings; inactive and blocked cannot.. Valid values are `active|inactive|blocked|planned`',
    `cost_center_type` STRING COMMENT 'Type classification indicating whether the cost center is operational (OPEX), capital (CAPEX), shared service, overhead, or revenue-generating.. Valid values are `operational|capital|shared_service|overhead|revenue_generating`',
    `cost_element_group_code` STRING COMMENT 'Default cost element group for categorizing the types of costs posted to this cost center (e.g., personnel, materials, services).. Valid values are `^[A-Z0-9]{4,10}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the cost center is domiciled for regulatory and tax reporting.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this cost center record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which this cost centers budget and actuals are denominated.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Department code within the organizational structure to which this cost center belongs.. Valid values are `^[A-Z0-9]{3,6}$`',
    `functional_area_code` STRING COMMENT 'Functional area classification for cost-of-sales accounting and functional expense reporting (e.g., Operations, Sales, Administration).. Valid values are `^[A-Z0-9]{4}$`',
    `group_code` STRING COMMENT 'Code identifying the cost center group for aggregated reporting and analysis (e.g., all NOC cost centers, all engineering cost centers).. Valid values are `^[A-Z0-9]{4,10}$`',
    `hierarchy_level` STRING COMMENT 'The level of this cost center in the organizational hierarchy (1 = top level, increasing for nested levels).',
    `is_locked_for_posting` BOOLEAN COMMENT 'Indicates whether the cost center is locked for new cost postings (true = locked, false = open for postings).',
    `is_statistical` BOOLEAN COMMENT 'Indicates whether this is a statistical cost center used for reporting purposes only, without actual cost postings (true = statistical, false = real).',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this cost center record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was last modified.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this cost center.',
    `planning_group_code` STRING COMMENT 'Code identifying the planning group responsible for budget planning and forecasting for this cost center.. Valid values are `^[A-Z0-9]{4,10}$`',
    `profit_center_code` STRING COMMENT 'The profit center to which this cost center is assigned for internal profitability analysis and management accounting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `valid_from_date` DATE COMMENT 'The date from which this cost center is valid and can accept cost postings.',
    `valid_to_date` DATE COMMENT 'The date until which this cost center is valid. Null indicates no end date (open-ended validity).',
    `variance_amount` DECIMAL(18,2) COMMENT 'The variance between budgeted and actual costs (budget minus actual). Positive indicates under-budget, negative indicates over-budget.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Organizational unit in SAP Controlling (CO) that represents a distinct area of cost responsibility within the telecom enterprise — e.g., NOC Operations, RAN Engineering, Customer Care, IT Infrastructure, Corporate Finance. Captures cost center hierarchy, responsible manager, controlling area, company code assignment, validity period, and cost center category. Used for OPEX tracking, departmental budgeting, and internal cost allocation.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique identifier for the profit center. Primary key for the profit center master data entity.',
    `company_code_id` BIGINT COMMENT 'Reference to the company code representing the legal entity to which this profit center is assigned for financial accounting purposes.',
    `controlling_area_id` BIGINT COMMENT 'Reference to the controlling area to which this profit center belongs. Controlling area represents the organizational unit for cost accounting and profitability analysis.',
    `cost_center_id` BIGINT COMMENT 'Reference to the default cost center associated with this profit center for cost allocation and overhead tracking purposes.',
    `parent_profit_center_id` BIGINT COMMENT 'Reference to the parent profit center in the organizational hierarchy, enabling multi-level profitability analysis and roll-up reporting. Null for top-level profit centers.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Profit centers own revenue and profitability KPIs (segment ARPU, EBITDA margin, subscriber growth). Telecommunications finance assigns primary KPI accountability to profit centers for business unit sc',
    `segment_id` BIGINT COMMENT 'Reference to the segment for external financial reporting as defined by IFRS 8 Operating Segments. Enables segment reporting for regulatory and investor relations purposes.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Profit centers track revenue and profitability by service territory for market performance analysis, regional ARPU targets, EBITDA by territory, and investment prioritization decisions. Core to territ',
    `arpu_target` DECIMAL(18,2) COMMENT 'Target Average Revenue Per User (ARPU) for this profit center used for performance measurement and business planning. Expressed in the profit centers functional currency.',
    `business_segment` STRING COMMENT 'High-level business segment classification for the profit center indicating the primary market or service category (e.g., Consumer Mobile, Consumer Fixed, Enterprise B2B, Wholesale/Interconnect, Content/IPTV, IoT/M2M).. Valid values are `consumer_mobile|consumer_fixed|enterprise_b2b|wholesale_interconnect|content_iptv|iot_m2m`',
    `capex_budget` DECIMAL(18,2) COMMENT 'Annual Capital Expenditure (CAPEX) budget allocated to this profit center for infrastructure investments, network expansion, and equipment purchases. Expressed in the profit centers functional currency.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary country of operation for this profit center (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this profit center record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this profit center record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the functional currency for this profit centers financial transactions and reporting (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `ebitda_target` DECIMAL(18,2) COMMENT 'Target Earnings Before Interest, Taxes, Depreciation, and Amortization (EBITDA) for this profit center used for profitability measurement and executive reporting. Expressed in the profit centers functional currency.',
    `geographic_region` STRING COMMENT 'Primary geographic region served by this profit center for regional profitability analysis and market segmentation.. Valid values are `north_america|south_america|europe|asia_pacific|middle_east|africa`',
    `hierarchy_level` STRING COMMENT 'Numeric level of this profit center within the organizational hierarchy (e.g., 1 for top-level, 2 for second-level, etc.). Used for hierarchical aggregation and drill-down analysis.',
    `is_consolidation_relevant` BOOLEAN COMMENT 'Boolean flag indicating whether this profit centers financial results are included in corporate consolidation and group reporting processes.',
    `is_intercompany_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this profit center participates in intercompany transactions and transfer pricing arrangements with other profit centers or legal entities.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this profit center record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this profit center record was last updated or modified. Used for change tracking and audit purposes.',
    `opex_budget` DECIMAL(18,2) COMMENT 'Annual Operational Expenditure (OPEX) budget allocated to this profit center for day-to-day operations, maintenance, and recurring costs. Expressed in the profit centers functional currency.',
    `profit_center_code` STRING COMMENT 'Business identifier code for the profit center used in financial reporting and analysis. Externally visible alphanumeric code following organizational naming conventions.. Valid values are `^[A-Z0-9]{4,10}$`',
    `profit_center_description` STRING COMMENT 'Detailed description of the profit centers business purpose, scope of operations, and key responsibilities. Provides context for financial analysis and reporting.',
    `profit_center_group` STRING COMMENT 'Grouping classification for aggregating multiple profit centers for consolidated reporting and analysis (e.g., All Consumer Services, All Enterprise Services, All Wholesale Operations).',
    `profit_center_name` STRING COMMENT 'Full business name of the profit center representing the business segment or product line (e.g., Mobile Consumer, Fixed Broadband, Enterprise B2B, IPTV/Content, Wholesale/Interconnect).',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center indicating whether it is operational, planned for future activation, temporarily inactive, or permanently closed.. Valid values are `active|inactive|planned|closed`',
    `profit_center_type` STRING COMMENT 'Classification of the profit center by organizational dimension (e.g., Product Line, Geographic Region, Customer Segment, Service Type, Channel, Cost Center).. Valid values are `product_line|geographic_region|customer_segment|service_type|channel|cost_center`',
    `revenue_recognition_method` STRING COMMENT 'Method used for revenue recognition for this profit center as per IFRS 15 / ASC 606 standards (e.g., Point in Time, Over Time, Subscription, Usage-Based, Hybrid).. Valid values are `point_in_time|over_time|subscription|usage_based|hybrid`',
    `short_name` STRING COMMENT 'Abbreviated name or acronym for the profit center used in reports and dashboards where space is limited.',
    `tax_jurisdiction` STRING COMMENT 'Primary tax jurisdiction or authority governing the taxation of this profit centers operations. Used for tax planning and compliance reporting.',
    `transfer_pricing_method` STRING COMMENT 'Method used for determining transfer prices for intercompany transactions involving this profit center (e.g., Cost Plus, Market Price, Negotiated, Standard Cost, Not Applicable).. Valid values are `cost_plus|market_price|negotiated|standard_cost|not_applicable`',
    `valid_from_date` DATE COMMENT 'Date from which this profit center becomes effective and can be used for financial postings and profitability analysis.',
    `valid_to_date` DATE COMMENT 'Date until which this profit center remains valid. Null for profit centers with no planned end date. Used for time-dependent organizational changes.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'SAP Controlling profit center master representing a business segment or product line within the telecom enterprise for which profitability is measured independently — e.g., Mobile Consumer, Fixed Broadband, Enterprise B2B, IPTV/Content, Wholesale/Interconnect. Captures profit center hierarchy, responsible manager, controlling area, and segment assignment. Enables ARPU analysis, EBITDA by business unit, and segment reporting.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record in SAP Asset Accounting (FI-AA). Primary key for the fixed asset master data.',
    `capital_project_id` BIGINT COMMENT 'Identifier of the capital project or work breakdown structure (WBS) element under which the asset was acquired. Links asset to strategic investment initiatives.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Fixed asset is owned by a legal entity. N:1 relationship (many assets per company). The company_code_id FK will link to company_code.company_code_id. The existing company_code STRING attribute is a co',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fixed asset is assigned to a cost center for cost allocation and responsibility tracking. N:1 relationship (many assets per cost center). The cost_center_id FK will link to cost_center.cost_center_id.',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Network equipment and CPE assets are physically deployed at enterprise customer sites—critical for asset tracking, depreciation allocation, site-level asset inventory, and insurance claims.',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Network infrastructure assets (towers, shelters, generators, HVAC, power systems) are physically installed at specific sites. Required for asset register maintenance, site-level depreciation tracking,',
    `premise_id` BIGINT COMMENT 'Foreign key linking to location.premise. Business justification: Customer premise equipment (ONTs, modems, set-top boxes, routers) deployed at customer premises are tracked as fixed assets. Required for CPE asset tracking, depreciation by device type, theft/loss ma',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to finance.purchase_order. Business justification: Fixed asset acquisition may reference a purchase order for procurement tracking. N:1 relationship (many assets can be acquired via one PO). The purchase_order_id FK will link to purchase_order.purchas',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or asset custodian responsible for the asset. Used for accountability and asset tracking.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor from whom the asset was purchased. Links to vendor master data for procurement tracking.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized since capitalization date. Represents the cumulative reduction in asset value over time.',
    `acquisition_date` DATE COMMENT 'Date when the fixed asset was acquired or capitalized. Marks the start of the assets useful life and depreciation schedule.',
    `acquisition_value` DECIMAL(18,2) COMMENT 'Original cost or fair value of the fixed asset at acquisition, including purchase price, installation costs, and directly attributable costs. Recorded in functional currency.',
    `asset_category` STRING COMMENT 'High-level categorization of the asset for financial reporting. Distinguishes between tangible assets, intangible assets, and right-of-use assets under IFRS 16.. Valid values are `tangible|intangible|right_of_use`',
    `asset_class` STRING COMMENT 'Classification of the fixed asset type determining depreciation rules, useful life, and accounting treatment. Aligns with chart of depreciation and asset master data structure. [ENUM-REF-CANDIDATE: network_equipment|fiber_infrastructure|customer_premises_equipment|data_center_hardware|vehicles|buildings|land|office_equipment — 8 candidates stripped; promote to reference product]',
    `asset_description` STRING COMMENT 'Detailed business description of the fixed asset including make, model, specifications, and purpose. Used for asset identification and inventory management.',
    `asset_number` STRING COMMENT 'External business identifier for the fixed asset. Unique asset tag or serial number used for physical identification and tracking across the organization.. Valid values are `^[A-Z0-9]{8,12}$`',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset. Determines whether depreciation is active and whether the asset is available for operational use.. Valid values are `in_service|under_construction|retired|disposed|transferred|impaired`',
    `asset_sub_number` STRING COMMENT 'Sub-asset identifier for components or modules within a main asset. Used for tracking individual parts of complex network equipment.. Valid values are `^[0-9]{4}$`',
    `capitalization_date` DATE COMMENT 'Date when the asset was placed in service and capitalized on the balance sheet. Depreciation begins from this date. May differ from acquisition date for assets under construction.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the fixed asset record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the assets acquisition value and financial amounts. Used for multi-currency consolidation.. Valid values are `^[A-Z]{3}$`',
    `depreciation_area` STRING COMMENT 'Valuation view or ledger for which depreciation is calculated. Supports parallel accounting for different reporting standards (IFRS, GAAP, tax).. Valid values are `book_depreciation|tax_depreciation|ifrs_depreciation|gaap_depreciation|management_reporting`',
    `depreciation_method` STRING COMMENT 'Accounting method used to allocate the cost of the asset over its useful life. Determines the pattern of depreciation expense recognition.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits`',
    `disposal_value` DECIMAL(18,2) COMMENT 'Proceeds received from the sale or disposal of the retired asset. Used to calculate gain or loss on disposal.',
    `impairment_amount` DECIMAL(18,2) COMMENT 'Write-down amount recognized when the assets recoverable amount falls below its carrying value. Reflects economic obsolescence or damage.',
    `impairment_date` DATE COMMENT 'Date when the impairment loss was recognized. Marks the adjustment to the assets carrying value.',
    `is_leased` BOOLEAN COMMENT 'Indicates whether the asset is leased rather than owned. True for right-of-use assets under IFRS 16 lease accounting.',
    `last_inventory_date` DATE COMMENT 'Date of the most recent physical inventory verification of the asset. Used for asset reconciliation and audit compliance.',
    `lease_contract_id` BIGINT COMMENT 'Identifier of the lease agreement if the asset is leased. Links to lease contract master data for IFRS 16 compliance.',
    `manufacturer` STRING COMMENT 'Name of the equipment manufacturer or original equipment manufacturer (OEM). Used for warranty claims and spare parts sourcing.',
    `model_number` STRING COMMENT 'Manufacturers model or part number for the asset. Used for technical specifications, compatibility, and replacement planning.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified the fixed asset record. Used for change tracking and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the fixed asset record was last updated. Used for change tracking and audit trail.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the fixed asset calculated as acquisition value minus accumulated depreciation. Represents the assets value on the balance sheet.',
    `retirement_date` DATE COMMENT 'Date when the asset was retired from service or disposed. Marks the end of the assets useful life and depreciation schedule.',
    `revaluation_amount` DECIMAL(18,2) COMMENT 'Adjustment to the assets carrying value based on fair value revaluation. Used when applying the revaluation model under IFRS.',
    `revaluation_date` DATE COMMENT 'Date when the asset was revalued to fair value. Marks the adjustment to the assets carrying value under the revaluation model.',
    `serial_number` STRING COMMENT 'Manufacturers unique serial number for the physical asset. Used for warranty tracking, maintenance, and asset verification.',
    `useful_life_years` STRING COMMENT 'Expected economic useful life of the asset in years. Used to calculate annual depreciation expense. Determined by asset class and regulatory guidelines.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty coverage ends. Used for maintenance planning and extended warranty decisions.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created the fixed asset record. Used for audit trail and accountability.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Master record for capitalized fixed assets in SAP Asset Accounting (FI-AA) — network equipment (OLT, ONT, BTS, RAN nodes), fiber cable infrastructure, CPE, data center hardware, vehicles, and buildings. Captures asset class, acquisition date, acquisition value, useful life, depreciation method, depreciation area, net book value, and physical location. Supports CAPEX tracking, depreciation scheduling, and asset lifecycle management per IFRS/GAAP.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`asset_transaction` (
    `asset_transaction_id` BIGINT COMMENT 'Unique identifier for the asset transaction record. Primary key for the asset transaction entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Asset transaction is posted to a legal entity. N:1 relationship (many transactions per company). The company_code_id FK will link to company_code.company_code_id. The existing company_code STRING attr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Asset transaction may be charged to a cost center for cost tracking. N:1 relationship (many transactions per cost center). The cost_center_id FK will link to cost_center.cost_center_id. The existing c',
    `employee_id` BIGINT COMMENT 'The system user identifier of the person who created or posted the asset transaction. Used for audit trail, accountability, and segregation of duties verification. Links to user master data for access control review.',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Asset movements (installations, transfers, retirements, impairments) at network sites must be tracked for audit trail and inventory control. Required for asset lifecycle tracking, site commissioning/d',
    `partner_id` BIGINT COMMENT 'Identifier of the supplier or vendor from whom the asset was acquired. Used for procurement analytics, vendor performance tracking, and accounts payable reconciliation. Populated for acquisition transactions.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset that is the subject of this transaction. Links to the master asset record in the asset register.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Asset transaction may be charged to a profit center for profitability tracking. N:1 relationship (many transactions per profit center). The profit_center_id FK will link to profit_center.profit_center',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to finance.purchase_order. Business justification: Asset acquisition transaction may reference a purchase order for procurement tracking. N:1 relationship (many asset transactions can reference one PO). The purchase_order_id FK will link to purchase_o',
    `asset_class` STRING COMMENT 'Classification code grouping assets with similar characteristics, depreciation methods, and useful lives. Examples include buildings, network infrastructure, vehicles, IT equipment. Determines default depreciation parameters and account assignments.. Valid values are `^[0-9]{8}$`',
    `asset_subnumber` STRING COMMENT 'Sub-asset identifier used when a main asset is divided into multiple components for separate depreciation tracking. Enables component-based accounting for complex assets such as buildings with separately depreciable components (structure, HVAC, elevators).. Valid values are `^[0-9]{4}$`',
    `asset_value_date` DATE COMMENT 'The effective date from which the asset transaction impacts depreciation calculations and asset valuation. For acquisitions, this is the capitalization date when depreciation begins; for retirements, this is when depreciation ceases. Critical for accurate depreciation computation.',
    `company_code` STRING COMMENT 'Four-character organizational unit identifier representing the legal entity or subsidiary within which the asset transaction is recorded. Used for financial consolidation and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center` STRING COMMENT 'The organizational unit responsible for the asset and its associated costs. Used for internal cost allocation, OPEX tracking, and management reporting. Links asset transactions to operational responsibility centers.. Valid values are `^[A-Z0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when the asset transaction record was first created in the financial system. Used for audit trail, data lineage tracking, and transaction sequencing. Distinct from transaction_date which represents the business event date.',
    `depreciation_area` STRING COMMENT 'Two-digit code identifying the valuation view for the asset transaction. Area 01 typically represents book depreciation for financial reporting; area 15 represents tax depreciation; area 20 represents cost accounting depreciation. Enables parallel valuation for different reporting purposes.. Valid values are `^[0-9]{2}$`',
    `document_number` STRING COMMENT 'Unique accounting document identifier generated by the financial system. Provides audit trail linkage to the source financial document and general ledger posting. Used for reconciliation and compliance verification.. Valid values are `^[A-Z0-9]{10}$`',
    `document_type` STRING COMMENT 'Two-character code classifying the accounting document category. Examples include AA for asset posting, SA for general ledger document, KR for vendor invoice. Controls number ranges and posting rules.. Valid values are `^[A-Z]{2}$`',
    `fiscal_year` STRING COMMENT 'The financial reporting year in which the transaction is recorded. Four-digit year value used for period assignment and financial statement aggregation.',
    `gain_loss_amount` DECIMAL(18,2) COMMENT 'The calculated gain or loss on asset disposal, computed as retirement proceeds minus net book value. Positive values represent gains; negative values represent losses. Posted to income statement and impacts EBITDA calculation.',
    `gl_account` STRING COMMENT 'The general ledger account number to which the asset transaction is posted. For acquisitions, typically an asset account; for depreciation, an accumulated depreciation or expense account; for retirements, a gain/loss account. Ensures proper financial statement classification.. Valid values are `^[0-9]{10}$`',
    `internal_order` STRING COMMENT 'Internal order number used for tracking costs related to specific initiatives, maintenance activities, or short-term projects. Enables cost collection for asset-related activities before capitalization or for OPEX expense tracking.. Valid values are `^[A-Z0-9]{12}$`',
    `invoice_number` STRING COMMENT 'The vendor invoice number associated with the asset acquisition. Provides linkage to accounts payable and enables reconciliation between asset register and financial payables. Used for audit verification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The system timestamp when the asset transaction record was last updated or modified. Used for change tracking, data quality monitoring, and identifying recent adjustments. Updated whenever transaction attributes are changed.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the company code local currency using the exchange rate effective on the transaction date. Used for statutory financial reporting and consolidation.',
    `offset_account` STRING COMMENT 'The contra general ledger account for double-entry bookkeeping. For asset acquisitions, typically accounts payable or cash; for depreciation, accumulated depreciation; for retirements, asset clearing account. Completes the accounting entry pair.. Valid values are `^[0-9]{10}$`',
    `posting_date` DATE COMMENT 'The accounting period date when the transaction was posted to the general ledger. Used for period closing and financial statement preparation. May differ from transaction date due to timing of accounting entries.',
    `posting_period` STRING COMMENT 'The accounting period number within the fiscal year when the transaction was posted. Typically 1-12 for monthly periods, with additional special periods (13-16) for year-end adjustments and closing entries.',
    `profit_center` STRING COMMENT 'The business segment or profit-responsible unit to which the asset is assigned. Used for segment reporting, EBITDA analysis, and profitability evaluation. Enables financial performance measurement by business line.. Valid values are `^[A-Z0-9]{10}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The physical quantity of assets involved in the transaction. Used for assets managed in quantity units such as vehicles, network equipment units, or infrastructure components. Enables unit-based asset tracking and partial retirement processing.',
    `reference_document` STRING COMMENT 'External reference number linking the asset transaction to source documents such as purchase orders, vendor invoices, project completion reports, or disposal authorizations. Provides audit trail to supporting documentation.',
    `reference_key` STRING COMMENT 'Three-character code classifying the type of reference document. Examples include PO for purchase order, INV for invoice, PRJ for project. Used for categorizing transaction source documentation.. Valid values are `^[A-Z0-9]{3}$`',
    `retirement_proceeds` DECIMAL(18,2) COMMENT 'The cash or fair value received from disposal of the asset. Used to calculate gain or loss on disposal by comparing to net book value. Populated for sale and trade-in retirement transactions.',
    `retirement_reason` STRING COMMENT 'Classification of why the asset was retired or disposed. Sale represents disposal with proceeds; scrap represents disposal without value; donation represents charitable transfer; theft represents involuntary loss; obsolescence represents technological replacement; transfer represents movement to another entity. Used for asset lifecycle analysis and disposal reporting.. Valid values are `sale|scrap|donation|theft|obsolescence|transfer`',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this transaction reverses a previous asset transaction. True when the transaction is a correction or cancellation of an earlier posting. Used for audit trail and error correction tracking.',
    `reversed_document_number` STRING COMMENT 'The original document number being reversed by this transaction. Populated when reversal_indicator is true. Provides linkage between reversal and original transaction for reconciliation and audit purposes.. Valid values are `^[A-Z0-9]{10}$`',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary value of the asset transaction in the company code currency. For acquisitions, represents capitalized cost; for retirements, represents net book value disposed; for depreciation, represents periodic expense; for revaluations, represents adjustment amount. Positive values increase asset value; negative values decrease asset value.',
    `transaction_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the transaction amount is denominated. Used for foreign currency translation and multi-currency reporting.. Valid values are `^[A-Z]{3}$`',
    `transaction_date` DATE COMMENT 'The business date on which the asset transaction occurred or became effective. This is the value date for financial reporting and represents when the economic event took place, distinct from the posting date when it was recorded in the system.',
    `transaction_text` STRING COMMENT 'Free-form descriptive text providing additional context about the asset transaction. May include details such as asset description, reason for transaction, approval references, or special handling notes. Used for documentation and audit support.',
    `transaction_type` STRING COMMENT 'Classification of the asset accounting movement. Acquisition represents capitalization of new assets or additions; retirement represents disposal or scrapping; transfer represents movement between asset classes or cost centers; depreciation represents periodic value reduction; revaluation represents fair value adjustment; write_down represents impairment loss recognition.. Valid values are `acquisition|retirement|transfer|depreciation|revaluation|write_down`',
    `unit_of_measure` STRING COMMENT 'The measurement unit for the transaction quantity. Examples include EA for each, KM for kilometers, MT for metric tons. Standardized to ISO unit codes where applicable.. Valid values are `^[A-Z]{2,3}$`',
    `wbs_element` STRING COMMENT 'Project structure element identifier for CAPEX projects. Links asset acquisitions to capital investment projects for project accounting, budget tracking, and ROI analysis. Used when assets are capitalized from project activities.. Valid values are `^[A-Z0-9-]{1,24}$`',
    CONSTRAINT pk_asset_transaction PRIMARY KEY(`asset_transaction_id`)
) COMMENT 'Transactional record of all asset accounting movements in SAP FI-AA — acquisitions, retirements, transfers, write-downs, depreciation postings, and revaluations. Captures transaction type, posting date, amount, asset value date, document reference, and depreciation area impact. Provides the complete financial history of each fixed asset from capitalization through disposal, essential for CAPEX/OPEX reclassification and regulatory asset reporting.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`budget_plan` (
    `budget_plan_id` BIGINT COMMENT 'Unique identifier for the budget plan record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Budget plan is created for a legal entity. N:1 relationship (many budget plans per company). The company_code_id FK will link to company_code.company_code_id. The existing company_code STRING attribut',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget plan may be assigned to a cost center for budget management. N:1 relationship (many budget plans per cost center). The cost_center_id FK will link to cost_center.cost_center_id. The existing co',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budget plan may be assigned to a profit center for profitability planning. N:1 relationship (many budget plans per profit center). The profit_center_id FK will link to profit_center.profit_center_id. ',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Operating budgets are allocated to service territories for regional cost control, resource planning, and market-level financial targets. Essential for territory budget allocation, variance analysis, r',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Budgets are set to achieve specific KPI targets (subscriber growth, churn reduction, ARPU improvement). Telecommunications planning links budget plans to strategic KPIs for goal alignment, variance tr',
    `actual_to_date_amount` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure posted against this budget plan as of the last update. Used for budget vs. actuals variance analysis.',
    `approval_status` STRING COMMENT 'Formal approval state: pending (awaiting decision), approved (fully authorized), rejected (not authorized), conditional (approved with constraints or conditions).. Valid values are `pending|approved|rejected|conditional`',
    `available_budget_amount` DECIMAL(18,2) COMMENT 'Remaining available budget calculated as total_planned_amount minus actual_to_date_amount minus committed_amount.',
    `budget_category` STRING COMMENT 'Primary expenditure classification: CAPEX (Capital Expenditure for network build, IT systems, spectrum acquisition), OPEX (Operational Expenditure for network operations, workforce, marketing, G&A), or mixed (plan contains both CAPEX and OPEX line items).. Valid values are `capex|opex|mixed`',
    `budget_control_level` STRING COMMENT 'Enforcement level for budget overruns: advisory (informational only), warning (alert but allow), blocking (prevent transactions exceeding budget).. Valid values are `advisory|warning|blocking`',
    `budget_owner` STRING COMMENT 'Name or identifier of the manager or executive responsible for managing and executing this budget plan.',
    `budget_plan_status` STRING COMMENT 'Current lifecycle status of the budget plan: draft (in preparation), submitted (awaiting approval), under_review (being evaluated), approved (authorized for execution), rejected (not approved), active (in execution), closed (planning period ended), superseded (replaced by newer version). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|active|closed|superseded — 8 candidates stripped; promote to reference product]',
    `business_unit_code` STRING COMMENT 'Code identifying the primary business unit or division responsible for this budget plan (e.g., Network Operations, Consumer Wireless, Enterprise Services).',
    `commitment_tracking_enabled` BOOLEAN COMMENT 'Indicates whether purchase order commitments and encumbrances are tracked against this budget plan for funds availability checking.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total committed funds (purchase orders, contracts) not yet expensed but encumbered against this budget plan.',
    `consolidation_level` STRING COMMENT 'Level of financial consolidation for this budget plan: entity (single legal entity), business_unit (operational unit), division (multiple business units), corporate (enterprise-wide).. Valid values are `entity|business_unit|division|corporate`',
    `controlling_area` STRING COMMENT 'SAP controlling area for cost and profitability analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget plan (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fiscal_year` STRING COMMENT 'Primary fiscal year for which this budget plan is prepared (e.g., 2024).',
    `gl_account_code` STRING COMMENT 'Primary General Ledger account code for budget classification (e.g., network maintenance, marketing expense, capital equipment). May be aggregated at plan header level.',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this budget plan includes intercompany transactions requiring elimination during consolidation.',
    `is_baseline` BOOLEAN COMMENT 'Indicates whether this version is the baseline (original approved) budget used for variance analysis. Only one version per plan should be marked as baseline.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified the budget plan record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget plan record was last updated.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the budget plan, including assumptions, constraints, and special considerations.',
    `plan_name` STRING COMMENT 'Descriptive name of the budget plan (e.g., FY2024 Network CAPEX Budget, 2024 Marketing OPEX Plan).',
    `plan_number` STRING COMMENT 'Externally-known unique business identifier for the budget plan, formatted as BP-YYYYNNNN where YYYY is fiscal year and NNNN is sequence.. Valid values are `^BP-[0-9]{8}$`',
    `plan_type` STRING COMMENT 'Classification of the budget plan by planning horizon and purpose: annual (single fiscal year), multi_year (strategic multi-year plan), quarterly (short-term operational), project_based (specific initiative), rolling_forecast (continuous planning), supplemental (mid-year adjustment).. Valid values are `annual|multi_year|quarterly|project_based|rolling_forecast|supplemental`',
    `planning_horizon_end_date` DATE COMMENT 'End date of the budget planning period (typically end of fiscal year or project completion).',
    `planning_horizon_start_date` DATE COMMENT 'Start date of the budget planning period (typically beginning of fiscal year or project start).',
    `planning_method` STRING COMMENT 'Methodology used to develop the budget: top_down (executive-driven allocation), bottom_up (department-driven aggregation), zero_based (justify all expenses from zero), incremental (prior year plus adjustment), activity_based (cost driver based).. Valid values are `top_down|bottom_up|zero_based|incremental|activity_based`',
    `reforecast_amount` DECIMAL(18,2) COMMENT 'Updated forecast amount based on year-to-date actuals and revised projections. Used for mid-year budget adjustments and EBITDA reforecasting.',
    `reforecast_date` DATE COMMENT 'Date when the reforecast amount was last updated.',
    `source_system` STRING COMMENT 'Identifier of the source system from which this budget plan originated (e.g., SAP S/4HANA, BPC, Hyperion).',
    `total_planned_amount` DECIMAL(18,2) COMMENT 'Total budgeted amount across all line items in the plan, in the plan currency. Sum of all budget line allocations.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Budget variance calculated as actual_to_date_amount minus total_planned_amount. Positive indicates overspend, negative indicates underspend.',
    `variance_percent` DECIMAL(18,2) COMMENT 'Budget variance as a percentage of planned amount: (actual_to_date_amount / total_planned_amount - 1) * 100.',
    `variance_threshold_amount` DECIMAL(18,2) COMMENT 'Absolute variance threshold in plan currency. Variances exceeding this amount trigger alerts or require explanation.',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'Acceptable variance threshold as a percentage of planned amount. Variances exceeding this threshold trigger alerts or require explanation (e.g., 10.00 means ±10%).',
    `version_number` STRING COMMENT 'Version number of the budget plan. Increments with each revision (1=original, 2=first revision, etc.). Supports budget reforecasting and variance analysis.',
    `version_type` STRING COMMENT 'Classification of the budget version: original (initial approved budget), revised (formal amendment), forecast (updated projection), actual (actuals loaded for comparison).. Valid values are `original|revised|forecast|actual`',
    `created_by` STRING COMMENT 'User ID or name of the person who created the budget plan record.',
    CONSTRAINT pk_budget_plan PRIMARY KEY(`budget_plan_id`)
) COMMENT 'SSOT for annual and multi-year financial budgets in SAP S/4HANA Financial Planning — plan-level metadata and granular line-item allocations. Captures budget header (planning horizon, version, approval status, variance thresholds) and line-level detail (GL account, cost center, profit center, fiscal period, planned amount, CAPEX/OPEX category, actuals-to-budget variance). Covers OPEX budgets (network operations, workforce, marketing, G&A) and CAPEX budgets (network build, IT systems, spectrum). Enables budget monitoring, commitment tracking, and financial planning accuracy assessment across telecom business units.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique identifier for the budget line item. Primary key for the budget line entity.',
    `budget_plan_id` BIGINT COMMENT 'Reference to the parent budget plan that contains this line item. Links the line to the overall budget structure.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget line is allocated to a cost center for detailed budget tracking. N:1 relationship (many budget lines per cost center). The cost_center_id FK will link to cost_center.cost_center_id. The existin',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Budget line is allocated to a GL account for financial planning. N:1 relationship (many budget lines per GL account). The general_ledger_id FK will link to general_ledger.general_ledger_id. The existi',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or manager responsible for this budget line. Establishes accountability for budget execution and variance management.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budget line is allocated to a profit center for detailed profitability planning. N:1 relationship (many budget lines per profit center). The profit_center_id FK will link to profit_center.profit_cente',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual expenditure or revenue recorded against this budget line. Used for variance analysis and budget monitoring.',
    `allocation_method` STRING COMMENT 'Method by which the budget amount was allocated to this line. Indicates whether it was directly assigned, allocated from a pool, distributed across multiple lines, or transferred from another budget.. Valid values are `Direct|Allocated|Distributed|Transferred`',
    `approval_date` DATE COMMENT 'Date when this budget line was formally approved by the authorized approver. Marks the transition from draft to approved status.',
    `budget_category` STRING COMMENT 'Classification of the budget line as Capital Expenditure (CAPEX), Operational Expenditure (OPEX), Revenue, or Other. Critical for financial planning and EBITDA analysis in telecommunications.. Valid values are `CAPEX|OPEX|Revenue|Other`',
    `budget_control_level` STRING COMMENT 'Level of budget control enforcement for this line. Advisory allows overspending with notification, Warning requires justification, Blocking prevents transactions that exceed the budget.. Valid values are `Advisory|Warning|Blocking`',
    `budget_line_description` STRING COMMENT 'Detailed textual description of the purpose and scope of this budget line item. Provides business context for the allocation.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget line. Indicates whether the line is in planning, approved for use, actively monitored, locked from changes, closed for the period, or cancelled.. Valid values are `Draft|Approved|Active|Frozen|Closed|Cancelled`',
    `budget_type` STRING COMMENT 'Classification of the budget line by planning horizon or purpose. Distinguishes between regular periodic budgets and special allocations.. Valid values are `Annual|Quarterly|Monthly|Project|Supplemental`',
    `budget_version` STRING COMMENT 'Version identifier for the budget plan. Enables tracking of multiple budget scenarios (e.g., original, revised, forecast) for comparison and planning accuracy assessment.. Valid values are `^[A-Z0-9]{1,10}$`',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit or division responsible for this budget line. Enables budget tracking across organizational segments in the telecommunications enterprise.. Valid values are `^[A-Z0-9]{2,10}$`',
    `carryforward_amount` DECIMAL(18,2) COMMENT 'Amount of unused budget carried forward from the previous fiscal period. Represents budget authority transferred from prior period allocations.',
    `carryforward_eligible` BOOLEAN COMMENT 'Indicates whether unused budget from this line can be carried forward to the next fiscal period. True if carryforward is allowed, False if budget expires at period end.',
    `committed_amount` DECIMAL(18,2) COMMENT 'The amount committed through purchase orders or contracts but not yet spent. Represents financial obligations that will impact the budget.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget line record was first created in the system. Provides audit trail for budget planning timeline.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the planned amount. Indicates the currency in which the budget is denominated.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date until which this budget line remains effective. After this date, no further commitments or spending are allowed against this line.',
    `effective_start_date` DATE COMMENT 'Date from which this budget line becomes effective and available for commitment and spending. Supports phased budget releases.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year for which this budget line applies. Typically 1-12 for monthly periods or 1-4 for quarterly periods.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this budget line is planned. Represents the annual financial planning period.',
    `functional_area_code` STRING COMMENT 'Code representing the functional area (e.g., Network Operations, Customer Service, Marketing) to which this budget line belongs. Supports functional cost analysis.. Valid values are `^[A-Z0-9]{2,10}$`',
    `fund_code` STRING COMMENT 'Fund or grant identifier if this budget line is financed from a specific funding source. Relevant for government-funded projects or earmarked capital allocations.. Valid values are `^[A-Z0-9]{2,10}$`',
    `gl_account_code` STRING COMMENT 'The general ledger account code for which this budget line is allocated. Represents the financial account classification in the chart of accounts.. Valid values are `^[0-9]{4,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget line record was last updated. Tracks the most recent change to any field in the record.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, justifications, or special instructions related to this budget line. Captures business context not represented in structured fields.',
    `planned_amount` DECIMAL(18,2) COMMENT 'The budgeted financial amount allocated for this line item. Represents the planned expenditure or revenue for the specified GL account, cost center, and fiscal period combination.',
    `project_code` STRING COMMENT 'Project identifier if this budget line is allocated to a specific capital or operational project. Enables project-based budget tracking for network expansion, system implementations, etc.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `reduction_amount` DECIMAL(18,2) COMMENT 'Amount by which the original budget was reduced through budget cuts or reallocations. Tracks mid-period budget decreases.',
    `supplemental_amount` DECIMAL(18,2) COMMENT 'Additional budget amount added to the original planned amount through supplemental budget requests or adjustments. Tracks mid-period budget increases.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between planned amount and actual amount (planned minus actual). Positive values indicate under-spending, negative values indicate over-spending.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the planned amount. Calculated as (variance_amount / planned_amount) * 100. Enables normalized comparison across budget lines of different magnitudes.',
    `wbs_element` STRING COMMENT 'Work Breakdown Structure element code for project-related budget lines. Provides hierarchical project structure for detailed budget planning and control.. Valid values are `^[A-Z0-9.-]{4,24}$`',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Individual line item within a budget plan, representing the planned financial allocation for a specific GL account, cost center, profit center, and fiscal period combination. Captures planned amount, currency, budget category (CAPEX/OPEX), version, and actuals-to-budget variance. Enables granular budget monitoring, commitment tracking, and financial planning accuracy assessment across telecom business units.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` (
    `vendor_invoice_id` BIGINT COMMENT 'Unique identifier for the vendor invoice record. Primary key for the vendor invoice entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Vendor invoice is posted to a legal entity. N:1 relationship (many invoices per company). The company_code_id FK will link to company_code.company_code_id. The existing company_code STRING attribute i',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vendor invoice may be charged to a cost center for expense tracking. N:1 relationship (many invoices per cost center). The cost_center_id FK will link to cost_center.cost_center_id. The existing cost_',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the invoice for payment. Used for approval workflow tracking, segregation of duties compliance, and audit trail purposes.',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Site-specific vendor costs (installation, maintenance, local loop charges) are tracked to enterprise sites for site-level cost analysis and customer billing reconciliation.',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Site-related vendor invoices (construction, maintenance, utilities, rent, security) reference specific sites for cost allocation and accrual. Required for invoice-to-site matching, facilities expense ',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Vendor invoices for third-party services (cloud connectivity, MPLS, equipment maintenance) are allocated to specific managed service instances for cost tracking and margin analysis.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to finance.purchase_order. Business justification: Vendor invoice references a purchase order for 3-way match verification (PO-GR-IR). N:1 relationship (many invoices can reference one PO, though typically 1:1). The purchase_order_id FK will link to p',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor who issued the invoice. Links to the vendor master data for network equipment suppliers (Ericsson, Nokia, Huawei), fiber contractors, IT software vendors, interconnect carriers, and facility lessors.',
    `approval_date` DATE COMMENT 'The date the invoice was approved for payment. Used for approval cycle time analysis and payment processing workflow management.',
    `asset_number` STRING COMMENT 'The fixed asset number if the invoice is for CAPEX and creates or adds value to a capital asset. Used for asset capitalization, depreciation tracking, and asset lifecycle management.',
    `baseline_date` DATE COMMENT 'The reference date from which payment terms are calculated. Typically the invoice date or goods receipt date, depending on payment term configuration. Used to determine the due date and cash discount date.',
    `cash_discount_amount` DECIMAL(18,2) COMMENT 'The discount amount taken for early payment according to the payment terms (e.g., 2% discount if paid within 10 days). Reduces the net payment amount and improves working capital efficiency.',
    `cash_discount_date` DATE COMMENT 'The last date on which the cash discount can be taken. Used for payment run optimization to maximize early payment discounts and reduce procurement costs.',
    `clearing_document_number` STRING COMMENT 'The financial document number that clears the open invoice item in accounts payable. Links the invoice to the payment document for reconciliation and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the invoice record was first created in the system. Used for audit trail, data lineage, and invoice processing cycle time analysis.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, EUR, GBP). Used for multi-currency accounting and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'The date by which payment must be made to the vendor according to the payment terms. Used for cash flow forecasting, payment run scheduling, and aging bucket classification.',
    `expense_category` STRING COMMENT 'Classification of the invoice as capital expenditure (CAPEX) for long-term assets like network equipment and infrastructure, or operational expenditure (OPEX) for recurring costs like software licenses, interconnect settlements, and facility leases. Critical for financial planning, ROI measurement, and EBITDA calculation.. Valid values are `capex|opex`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the invoice was posted. Used for monthly financial reporting, period-over-period analysis, and management accounting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the invoice was posted. Used for financial period reporting, year-over-year analysis, and fiscal year-end closing processes.',
    `gl_account` STRING COMMENT 'The general ledger account code to which the invoice expense is posted. Determines the financial statement line item for P&L reporting, CAPEX/OPEX classification, and EBITDA analysis.',
    `goods_receipt_number` STRING COMMENT 'The goods receipt document number confirming physical receipt of materials or completion of services. Part of the three-way match process to validate invoice accuracy before payment.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before tax. Represents the sum of all line items for goods and services provided by the vendor.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. This is the business event date used for accounting period assignment, aging analysis, and payment term calculation.',
    `invoice_description` STRING COMMENT 'Free-text description of the goods or services covered by the invoice. Provides business context for the invoice purpose, such as network equipment purchase, fiber installation services, software license renewal, interconnect settlement, or facility lease payment.',
    `invoice_number` STRING COMMENT 'The externally-assigned invoice number provided by the vendor. This is the business identifier used for vendor communication, payment reconciliation, and dispute resolution.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the vendor invoice in the accounts payable workflow. Draft invoices are being prepared, pending approval invoices await authorization, approved invoices are ready for posting, posted invoices are recorded in the general ledger, paid invoices have been settled, cancelled invoices are voided, disputed invoices have unresolved issues, and on-hold invoices are temporarily suspended from payment processing. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|posted|paid|cancelled|disputed|on_hold — 8 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice document type. Standard invoices are for goods/services received, credit memos reduce amounts owed, debit memos increase amounts owed, prepayment invoices are advance payments, recurring invoices are for subscription services, and milestone invoices are for project-based deliverables.. Valid values are `standard|credit_memo|debit_memo|prepayment|recurring|milestone`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the invoice record was last modified. Used for change tracking, audit trail, and data quality monitoring.',
    `net_amount` DECIMAL(18,2) COMMENT 'The total invoice amount including tax. This is the amount payable to the vendor and represents the cash outflow for accounts payable and cash flow forecasting.',
    `payment_block_indicator` BOOLEAN COMMENT 'Flag indicating whether the invoice is blocked from payment processing. True if the invoice is on hold due to disputes, missing approvals, or compliance issues. False if the invoice is eligible for payment.',
    `payment_block_reason` STRING COMMENT 'The reason code or description explaining why the invoice is blocked from payment. Common reasons include pending approval, disputed charges, missing documentation, or vendor compliance issues.',
    `payment_date` DATE COMMENT 'The date the payment was executed to the vendor. Used for cash flow analysis, payment performance tracking, and vendor relationship management.',
    `payment_method` STRING COMMENT 'The payment instrument used to settle the invoice. Wire transfer for international payments, ACH for domestic electronic payments, check for paper-based payments, credit card for small purchases, EFT for direct bank transfers, and virtual card for secure one-time payments.. Valid values are `wire_transfer|ach|check|credit_card|electronic_funds_transfer|virtual_card`',
    `payment_reference` STRING COMMENT 'The unique reference number assigned to the payment transaction. Used for bank reconciliation, payment tracking, and audit trail purposes.',
    `payment_terms` STRING COMMENT 'The contractual payment terms agreed with the vendor, typically expressed as net days or discount terms (e.g., Net 30, 2/10 Net 30). Defines the due date calculation and cash discount eligibility.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the general ledger. This determines the fiscal period for financial reporting and EBITDA analysis.',
    `project_code` STRING COMMENT 'The project or work breakdown structure (WBS) element to which the invoice is assigned. Used for project-based cost tracking, milestone billing validation, and capital project management for network expansion and infrastructure deployment.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applied to the invoice, including sales tax, value-added tax (VAT), goods and services tax (GST), or other applicable taxes based on jurisdiction.',
    `three_way_match_status` STRING COMMENT 'Indicates whether the invoice has been successfully matched against the purchase order and goods receipt. Matched invoices pass all validation checks, unmatched invoices have discrepancies, partial matches have some lines matched, variance within tolerance has acceptable differences, and variance exceeds tolerance requires manual review.. Valid values are `matched|unmatched|partial_match|variance_within_tolerance|variance_exceeds_tolerance`',
    `vendor_bank_account` STRING COMMENT 'The bank account number to which payment should be remitted. Used for electronic payment processing and vendor master data validation.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of tax withheld from the vendor payment as required by tax regulations. Reduces the net payment to the vendor and is remitted to tax authorities on behalf of the vendor.',
    CONSTRAINT pk_vendor_invoice PRIMARY KEY(`vendor_invoice_id`)
) COMMENT 'SSOT for the accounts payable lifecycle in SAP S/4HANA — from invoice receipt through payment execution. Covers vendor invoices for network equipment (Ericsson, Nokia, Huawei), fiber contractors, IT software licenses, interconnect settlements, and facility leases. Captures invoice header (vendor ID, invoice date, due date, gross/tax amounts, payment terms, three-way match status) and payment execution details (payment date, method, bank account, clearing reference, cash discount). Supports AP aging analysis, payment run management, cash flow forecasting, and vendor relationship management for the telecom enterprise.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`vendor_payment` (
    `vendor_payment_id` BIGINT COMMENT 'Unique identifier for the vendor payment transaction. Primary key for the vendor payment entity.',
    `bank_account_id` BIGINT COMMENT 'Reference to the telecom enterprise bank account from which the payment was disbursed. Links payment to the source bank account for cash management and reconciliation.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Vendor payment is made by a legal entity. N:1 relationship (many payments per company). The company_code_id FK will link to company_code.company_code_id. The existing company_code STRING attribute is ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vendor payment may be charged to a cost center for expense tracking. N:1 relationship (many payments per cost center). The cost_center_id FK will link to cost_center.cost_center_id. The existing cost_',
    `created_by_user_employee_id` BIGINT COMMENT 'User ID of the person who created the payment record. Used for audit trails and segregation of duties compliance.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved the payment. Used for audit trails and segregation of duties compliance.',
    `modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person who last modified the payment record. Used for audit trails and change management.',
    `payment_run_id` BIGINT COMMENT 'Identifier for the payment run batch that processed this payment. Groups payments executed together in a single payment run for treasury operations and reconciliation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Vendor payment may be charged to a profit center for profitability tracking. N:1 relationship (many payments per profit center). The profit_center_id FK will link to profit_center.profit_center_id. Th',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor receiving the payment. Identifies the payee in the accounts payable transaction.',
    `vendor_invoice_id` BIGINT COMMENT 'Reference to the vendor invoice being paid by this payment transaction. Links payment to the originating invoice for reconciliation and accounts payable tracking.',
    `approval_date` DATE COMMENT 'Date when the payment was approved. Used for audit trails and payment processing timeline tracking.',
    `baseline_date` DATE COMMENT 'Baseline date used to calculate the payment due date per payment terms. Typically the invoice date or goods receipt date.',
    `cash_discount_amount` DECIMAL(18,2) COMMENT 'Cash discount amount taken by the telecom enterprise for early payment. Represents the discount earned per vendor payment terms for prompt payment.',
    `clearing_document_number` STRING COMMENT 'Reference to the clearing document that links the payment to the vendor invoice. Used in accounts payable reconciliation to match payments with open invoices.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system. Used for audit trails and data lineage.',
    `document_date` DATE COMMENT 'Date on the payment document. May differ from posting date for backdated or future-dated payments.',
    `due_date` DATE COMMENT 'Date when the payment was due per the vendor payment terms. Used to track on-time payment performance and cash discount eligibility.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied when payment currency differs from the invoice currency or company code currency. Used for multi-currency payment processing and financial consolidation.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) in which the payment was made. Used for monthly financial reporting and period-end closing.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the payment was made. Used for financial reporting, budgeting, and year-over-year analysis.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the payment is posted. Links payment to the chart of accounts for financial reporting and EBITDA analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was last modified. Used for audit trails and change tracking.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'Net amount actually disbursed to the vendor after applying cash discounts and withholding taxes. Represents the final payment value transferred to the vendor.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Total amount disbursed to the vendor in the payment transaction. Represents the gross payment value before any adjustments or discounts.',
    `payment_approval_status` STRING COMMENT 'Approval status of the payment transaction. Indicates whether the payment is pending approval, approved, or rejected per internal controls.. Valid values are `pending_approval|approved|rejected`',
    `payment_batch_number` STRING COMMENT 'Batch number assigned by the payment processor for grouped payments. Used for payment reconciliation and bank statement matching.',
    `payment_block_indicator` BOOLEAN COMMENT 'Flag indicating whether the payment was blocked for review or approval. Used for payment control and fraud prevention.',
    `payment_block_reason` STRING COMMENT 'Reason code or description for why the payment was blocked. Provides context for payment holds and exceptions.',
    `payment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount. Indicates the currency in which the payment was made (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'Date when the payment was executed and funds were disbursed from the telecom enterprise bank account. Principal business event timestamp for cash flow management and treasury operations.',
    `payment_description` STRING COMMENT 'Free-text description or memo for the payment transaction. Provides additional context about the payment purpose or special instructions.',
    `payment_document_number` STRING COMMENT 'Externally visible payment document number assigned by the financial system. Used for payment tracking, reconciliation, and audit trails.',
    `payment_method` STRING COMMENT 'Method used to disburse payment to the vendor. Indicates the payment instrument or mechanism (ACH, wire transfer, check, EFT, credit card, direct debit).. Valid values are `ACH|wire_transfer|check|electronic_funds_transfer|credit_card|direct_debit`',
    `payment_processor_name` STRING COMMENT 'Name of the payment processor or bank that executed the payment. Used for payment tracking and reconciliation.',
    `payment_reference_number` STRING COMMENT 'External reference number provided by the bank or payment processor. Used for payment tracking and reconciliation with bank statements.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Indicates whether the payment is pending, processed, cleared, cancelled, failed, or reversed.. Valid values are `pending|processed|cleared|cancelled|failed|reversed`',
    `payment_term_code` STRING COMMENT 'Payment term code that governed this payment. Indicates the agreed payment terms with the vendor (e.g., Net 30, 2/10 Net 30).',
    `posting_date` DATE COMMENT 'Date when the payment was posted to the general ledger. Used for financial reporting and period assignment.',
    `reversal_date` DATE COMMENT 'Date when the payment was reversed. Used for audit trails and financial reconciliation.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this payment has been reversed. Used for payment correction and error handling.',
    `reversal_reason` STRING COMMENT 'Reason code or description for why the payment was reversed. Provides context for payment corrections and exceptions.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Withholding tax amount deducted from the payment per tax regulations. Represents tax withheld at source and remitted to tax authorities.',
    CONSTRAINT pk_vendor_payment PRIMARY KEY(`vendor_payment_id`)
) COMMENT 'Accounts payable payment transaction recording the actual disbursement to a vendor from the telecom enterprises bank accounts. Captures payment date, payment method (ACH, wire, check), bank account, payment amount, currency, exchange rate, clearing document reference, and cash discount taken. Links to vendor invoices cleared by the payment. Supports cash flow management, payment run reconciliation, and treasury operations.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order. Primary key.',
    `company_code_id` BIGINT COMMENT 'FK to finance.company_code',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Purchase order may be charged to a cost center for expense tracking. N:1 relationship (many POs per cost center). The cost_center_id FK will link to cost_center.cost_center_id. The existing cost_cente',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Site-specific procurement (CPE, installation services, cabling) is tracked via purchase orders linked to sites for site-level cost management and installation project tracking.',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Equipment and materials purchase orders for site builds/upgrades reference target sites for delivery coordination and cost tracking. Required for procurement-to-site matching, goods receipt verificati',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor from whom goods or services are being procured. Links to vendor master data for payment terms, contact information, and performance history.',
    `approval_date` DATE COMMENT 'Date when the purchase order was approved. Used for procurement cycle time analysis and audit compliance.',
    `approval_status` STRING COMMENT 'Current approval workflow status for the purchase order. Tracks whether the PO requires approval and its current state in the approval chain.. Valid values are `not_required|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the purchase order. Captured for audit trail and compliance reporting.',
    `asset_number` STRING COMMENT 'Fixed asset number for Capital Expenditure (CAPEX) capitalization. Used when procuring network equipment (Optical Line Terminal (OLT), Broadband Network Gateway (BNG), Customer Premises Equipment (CPE)) that will be capitalized as assets.',
    `collective_number` STRING COMMENT 'Grouping identifier for related purchase orders processed together in a procurement campaign or bulk order scenario.',
    `commitment_value` DECIMAL(18,2) COMMENT 'Encumbered budget amount for this purchase order. Used for budget control and funds management to prevent overspending.',
    `contract_number` STRING COMMENT 'Reference to the master contract or framework agreement under which this purchase order is issued. Used for contract compliance and spend aggregation.',
    `cost_center` STRING COMMENT 'Cost center for account assignment and Operational Expenditure (OPEX) tracking. Ten-character alphanumeric code representing the organizational unit bearing the cost.. Valid values are `^[A-Z0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order record was first created in the system. Used for audit trail and procurement cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this purchase order (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_date` DATE COMMENT 'Requested or scheduled date for goods receipt or service completion. Used for supply chain planning and Service Level Agreement (SLA) tracking.',
    `gl_account` STRING COMMENT 'General ledger account number for financial posting. Ten-digit numeric code representing the expense or asset account in the chart of accounts.. Valid values are `^[0-9]{10}$`',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether goods receipt posting is required for this purchase order. True for material procurement, false for service-only orders.',
    `gr_based_invoice_verification` BOOLEAN COMMENT 'Flag indicating whether invoice verification is based on goods receipt rather than purchase order. When true, invoice must match GR quantity and value.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and seller for shipping, insurance, and customs (e.g., FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms clause (e.g., FOB Shanghai, DDP New York).',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether invoice verification is required for this purchase order. Used in three-way match processing (PO, GR, IR).',
    `modified_by` STRING COMMENT 'User ID of the person who last modified the purchase order record. Captured for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order record was last modified. Used for audit trail and change tracking.',
    `net_value` DECIMAL(18,2) COMMENT 'Net monetary value after applying discounts and before taxes. Used for vendor payment calculation and financial reporting.',
    `notes` STRING COMMENT 'Additional comments or notes regarding the purchase order. Free-text field for internal communication and special conditions.',
    `payment_terms` STRING COMMENT 'Payment terms code defining the due date calculation and discount conditions (e.g., net 30, 2/10 net 30). Four-character code from vendor master or negotiated terms.. Valid values are `^[A-Z0-9]{4}$`',
    `plant` STRING COMMENT 'Physical location or facility where goods will be received or services will be rendered. Four-character code representing warehouse, distribution center, Network Operations Center (NOC), or field office.. Valid values are `^[A-Z0-9]{4}$`',
    `po_date` DATE COMMENT 'Date when the purchase order was created and issued to the vendor. Principal business event timestamp for procurement commitment tracking.',
    `po_number` STRING COMMENT 'Externally-known business identifier for the purchase order. Ten-digit numeric code used for vendor communication and three-way match processing.. Valid values are `^[0-9]{10}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order in the procurement workflow. Tracks progression from draft through approval, goods receipt, invoice verification, and closure. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_process|partially_received|fully_received|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order based on procurement scenario: standard (goods procurement), subcontracting (material provided to vendor), consignment (vendor-owned inventory), stock transfer (inter-plant), service (professional services), or framework (blanket agreement).. Valid values are `standard|subcontracting|consignment|stock_transfer|service|framework`',
    `purchasing_group` STRING COMMENT 'Buyer or procurement team responsible for this purchase order. Three-character code identifying the individual or team handling vendor negotiations and order management.. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for procurement activities. Four-character alphanumeric code representing the division or business unit authorized to negotiate and execute purchase agreements.. Valid values are `^[A-Z0-9]{4}$`',
    `quotation_number` STRING COMMENT 'Reference to the vendor quotation or Request for Quotation (RFQ) that preceded this purchase order. Links to the sourcing process.',
    `release_strategy` STRING COMMENT 'Approval workflow strategy code determining the approval path based on PO value, material group, or purchasing organization. Defines the sequence of approvers and thresholds.',
    `requisitioner` STRING COMMENT 'User ID or name of the person who requested the procurement. Links to the originating purchase requisition for accountability.',
    `shipping_instructions` STRING COMMENT 'Special instructions for the vendor regarding packaging, labeling, shipping method, or delivery requirements. Free-text field for logistics coordination.',
    `storage_location` STRING COMMENT 'Specific storage area within the plant where materials will be stocked. Four-character code for inventory management and goods receipt posting.. Valid values are `^[A-Z0-9]{4}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the purchase order based on jurisdiction and tax codes.',
    `total_value` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order including all line items, before taxes and discounts. Used for Capital Expenditure (CAPEX) and Operational Expenditure (OPEX) commitment tracking.',
    `validity_end_date` DATE COMMENT 'Effective end date for framework or blanket purchase orders. Defines the expiration of the procurement agreement period.',
    `validity_start_date` DATE COMMENT 'Effective start date for framework or blanket purchase orders. Defines the beginning of the procurement agreement period.',
    `wbs_element` STRING COMMENT 'Project work breakdown structure element for Capital Expenditure (CAPEX) tracking and project accounting. Used for network infrastructure projects, Radio Access Network (RAN) deployments, and Fiber to the Home (FTTH) rollouts.',
    `created_by` STRING COMMENT 'User ID of the person who created the purchase order record. Captured for audit trail and accountability.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'SSOT for procurement purchase orders in SAP MM/S/4HANA — document header and line-item detail. Covers network hardware (RAN, GPON, CPE), professional services, software licenses, and operational supplies. Captures header attributes (PO type, vendor, plant, purchasing organization, total value, approval status, GR/IR status) and line-level detail (material/service, quantity, unit price, delivery schedule, account assignment to cost center/WBS/asset, commitment value). SSOT for procurement commitment tracking, CAPEX/OPEX spend control, and three-way match processing.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` (
    `purchase_order_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `asset_number` STRING COMMENT 'Fixed asset number if this line item represents a capital asset acquisition. Used for asset accounting and depreciation tracking.',
    `contract_line_number` STRING COMMENT 'Line item number within the referenced contract. Links this purchase order line to specific contract terms and pricing.',
    `contract_number` STRING COMMENT 'Reference to a master contract or blanket purchase agreement under which this line item is procured. Used for contract compliance and spend tracking.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this purchase order line item in the system. Used for accountability and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order line item record was first created in the system. Used for audit trail and procurement cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary values on this line item (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating whether this line item has been marked for deletion. Deleted lines are excluded from further processing but retained for audit purposes.',
    `delivery_date` DATE COMMENT 'Scheduled or requested delivery date for the material or service on this line item. Used for supply chain planning and vendor performance tracking.',
    `expenditure_type` STRING COMMENT 'Classification of the line item as either capital expenditure (CAPEX) for long-term assets or operational expenditure (OPEX) for ongoing operations. Critical for financial planning and EBITDA analysis.. Valid values are `CAPEX|OPEX`',
    `final_invoice_indicator` BOOLEAN COMMENT 'Flag indicating that the final invoice has been received for this line item and no further invoices are expected. Used to close procurement transactions.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the expense or asset value of this line item will be posted. Critical for financial accounting and reporting.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether goods receipt is required for this line item. Controls whether inventory movements must be posted before invoice verification.',
    `incoterms_code` STRING COMMENT 'Incoterms code defining the delivery terms and transfer of risk between buyer and seller (e.g., FOB, CIF, DDP). Used for international procurement.',
    `incoterms_location` STRING COMMENT 'Specific location associated with the Incoterms code (e.g., port of shipment, destination city). Clarifies the point of delivery or risk transfer.',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether invoice receipt is expected for this line item. Controls invoice verification requirements.',
    `item_category_code` STRING COMMENT 'Purchase order item category code that controls the procurement process flow and account assignment for this line (e.g., standard item, consignment, subcontracting, service).',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this purchase order line item. Tracks change history for audit and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order line item record was last updated. Tracks changes for audit and version control purposes.',
    `line_number` STRING COMMENT 'Sequential line item number within the purchase order. Determines the ordering and display sequence of line items.',
    `line_status` STRING COMMENT 'Current lifecycle status of the purchase order line item. Tracks progression from order placement through receipt and closure.. Valid values are `open|partially_received|fully_received|closed|cancelled`',
    `line_text` STRING COMMENT 'Free-form text field for additional notes, specifications, or instructions specific to this purchase order line item.',
    `manufacturer_part_number` STRING COMMENT 'The original equipment manufacturer (OEM) part number for the material. Used for technical specifications and warranty tracking.',
    `material_code` BIGINT COMMENT 'Reference to the material or service being procured. Links to the master material catalog for network equipment, infrastructure components, or operational services.',
    `material_description` STRING COMMENT 'Textual description of the material or service being procured on this line. Provides human-readable context for the procurement item.',
    `material_group_code` STRING COMMENT 'Classification code grouping similar materials or services together for procurement analysis and reporting. Used for spend categorization.',
    `net_order_value` DECIMAL(18,2) COMMENT 'Total net value of this line item before taxes and discounts. Calculated as (quantity_ordered * unit_price / price_unit).',
    `open_quantity` DECIMAL(18,2) COMMENT 'Remaining quantity yet to be received or invoiced. Calculated as quantity_ordered minus the greater of quantity_received or quantity_invoiced.',
    `plant_code` STRING COMMENT 'Code identifying the receiving plant or facility location for the procured material. Used for inventory management and logistics planning.',
    `price_unit` STRING COMMENT 'The quantity of units to which the unit price applies. For example, if price_unit is 100, the unit_price applies to 100 units rather than 1.',
    `purchase_requisition_line_number` STRING COMMENT 'Line item number within the originating purchase requisition. Used for end-to-end procurement tracking from requisition to order.',
    `purchase_requisition_number` STRING COMMENT 'Reference to the originating purchase requisition document that triggered this purchase order line. Provides procurement traceability.',
    `quantity_invoiced` DECIMAL(18,2) COMMENT 'Cumulative quantity invoiced by the vendor against this purchase order line. Updated through invoice receipt transactions.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of material or service units ordered on this line item. Represents the total amount requested from the vendor.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Cumulative quantity of goods or services received against this purchase order line. Updated through goods receipt transactions.',
    `requisitioner_name` STRING COMMENT 'Name of the employee or business user who requested this material or service. Used for procurement tracking and accountability.',
    `storage_location_code` STRING COMMENT 'Code identifying the specific storage location within the plant where the material will be received and stored.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated for this line item based on the tax code and net order value.',
    `tax_code` STRING COMMENT 'Tax classification code determining the tax treatment and rate applicable to this line item. Used for tax calculation and compliance.',
    `unit_of_measure` STRING COMMENT 'The unit in which the ordered quantity is measured (e.g., EA for each, KG for kilogram, HR for hour). Standardizes quantity interpretation.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per single unit of the material or service. Used to calculate the total line item value before taxes and adjustments.',
    `vendor_material_number` STRING COMMENT 'The vendors own material or part number for the procured item. Used for vendor communication and order fulfillment.',
    `wbs_element_code` STRING COMMENT 'Work breakdown structure element code for project-based procurement. Used to track capital expenditure (CAPEX) and project costs for network infrastructure investments.',
    CONSTRAINT pk_purchase_order_line PRIMARY KEY(`purchase_order_line_id`)
) COMMENT 'Individual line item within a procurement purchase order, specifying the material or service being procured, quantity, unit price, delivery schedule, account assignment (cost center, WBS element, asset), and goods receipt/invoice receipt quantities. Enables granular spend tracking by GL account and controlling object, supporting CAPEX/OPEX classification at the line level for telecom infrastructure and operational procurement.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique identifier for the intercompany transaction record. Primary key.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Intercompany transaction posts to a GL account. N:1 relationship (many transactions per GL account). The general_ledger_id FK will link to general_ledger.general_ledger_id. Removes gl_account_descript',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Intercompany transaction originates from a sending legal entity. N:1 relationship (many transactions from one company). The sending_company_code_id FK will link to company_code.company_code_id. Remove',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Intercompany transaction originates from a sending cost center. N:1 relationship (many transactions from one cost center). The sending_cost_center_id FK will link to cost_center.cost_center_id. The ex',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Intercompany transaction originates from a sending profit center. N:1 relationship (many transactions from one profit center). The sending_profit_center_id FK will link to profit_center.profit_center_',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Intercompany charges for shared network infrastructure or services are allocated by territory for transfer pricing and cost allocation. Required for intercompany reconciliation by region, transfer pri',
    `allocation_method` STRING COMMENT 'The methodology used to determine the intercompany charge or allocation amount (e.g., direct cost, percentage allocation, usage-based).. Valid values are `direct_charge|cost_allocation|revenue_share|usage_based|fixed_fee`',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage rate applied for cost or revenue allocation when the allocation method is percentage-based.',
    `approval_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the intercompany transaction requires management approval before posting, typically for transactions above materiality thresholds.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction was approved for posting to the general ledger.',
    `approved_by` STRING COMMENT 'The name or user identifier of the finance manager or controller who approved the intercompany transaction for posting.',
    `business_area` STRING COMMENT 'The business segment or division within the telecom group to which the intercompany transaction is attributed for segment reporting.',
    `capex_opex_indicator` STRING COMMENT 'Classification indicating whether the intercompany transaction represents capital expenditure or operational expenditure for financial analysis and EBITDA calculation.. Valid values are `CAPEX|OPEX`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was first created in the financial system.',
    `document_reference_number` STRING COMMENT 'Reference to the source document or invoice that supports the intercompany transaction for audit trail purposes.',
    `elimination_date` DATE COMMENT 'The date when the intercompany transaction was eliminated during the financial consolidation process.',
    `elimination_status` STRING COMMENT 'Indicates whether the intercompany transaction has been eliminated in the consolidated financial statements to avoid double-counting group revenue and expenses.. Valid values are `not_eliminated|pending_elimination|eliminated|partial_elimination`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert transaction currency to group currency at the time of posting.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year when the transaction is recorded.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the intercompany transaction is recorded for financial reporting purposes.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which the intercompany transaction is posted in the chart of accounts.. Valid values are `^[0-9]{6,10}$`',
    `group_currency` STRING COMMENT 'The three-letter ISO currency code of the corporate group reporting currency (typically USD, EUR, or GBP).. Valid values are `^[A-Z]{3}$`',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the group reporting currency for consolidated financial statements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was last updated or modified in the financial system.',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or special instructions related to the intercompany transaction.',
    `posting_date` DATE COMMENT 'The date when the transaction was posted to the general ledger in the financial system.',
    `profit_center_receiving` STRING COMMENT 'The profit center within the receiving company for internal profitability analysis and segment reporting.. Valid values are `^[A-Z0-9]{6,10}$`',
    `profit_center_sending` STRING COMMENT 'The profit center within the sending company for internal profitability analysis and segment reporting.. Valid values are `^[A-Z0-9]{6,10}$`',
    `receiving_company_code` STRING COMMENT 'The legal entity code of the subsidiary or business unit that is the recipient or creditor in the intercompany transaction.. Valid values are `^[A-Z0-9]{4}$`',
    `receiving_company_name` STRING COMMENT 'The legal name of the receiving company entity for business user reference and reporting.',
    `receiving_cost_center` STRING COMMENT 'The cost center within the receiving company that receives the intercompany revenue or allocation.. Valid values are `^[A-Z0-9]{6,10}$`',
    `reconciliation_reference` STRING COMMENT 'Reference identifier linking this transaction to the corresponding reciprocal entry in the counterparty legal entity for intercompany reconciliation.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether the intercompany transaction has been successfully matched and reconciled with the counterparty entity records.. Valid values are `unreconciled|matched|mismatched|under_investigation|resolved`',
    `reconciliation_variance_amount` DECIMAL(18,2) COMMENT 'The monetary difference between the sending and receiving company records for this intercompany transaction, requiring investigation if non-zero.',
    `sending_company_code` STRING COMMENT 'The legal entity code of the subsidiary or business unit that is the originator or debtor in the intercompany transaction.. Valid values are `^[A-Z0-9]{4}$`',
    `sending_cost_center` STRING COMMENT 'The cost center within the sending company that is charged or allocated the intercompany expense.. Valid values are `^[A-Z0-9]{6,10}$`',
    `service_description` STRING COMMENT 'Detailed description of the service, product, or cost allocation that is the subject of the intercompany transaction.',
    `tax_treatment_code` STRING COMMENT 'Code indicating the tax treatment applicable to the intercompany transaction for transfer pricing and tax compliance purposes.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the intercompany transaction before any adjustments or eliminations.',
    `transaction_currency` STRING COMMENT 'The three-letter ISO currency code in which the intercompany transaction was originally denominated.. Valid values are `^[A-Z]{3}$`',
    `transaction_date` DATE COMMENT 'The business date when the intercompany transaction occurred or was initiated.',
    `transaction_reference_number` STRING COMMENT 'Externally visible unique reference number for the intercompany transaction, used for reconciliation and audit trails across subsidiaries.. Valid values are `^ICT-[0-9]{10}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the intercompany transaction in the financial consolidation workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|posted|reconciled|eliminated|rejected — 7 candidates stripped; promote to reference product]',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction indicating the nature of the financial exchange between legal entities.. Valid values are `shared_service_charge|management_fee|intercompany_loan|roaming_settlement|infrastructure_cost_share|royalty_payment`',
    `transfer_pricing_method` STRING COMMENT 'The transfer pricing methodology applied to determine the arms-length price for the intercompany transaction in compliance with tax regulations.. Valid values are `comparable_uncontrolled_price|resale_price|cost_plus|profit_split|transactional_net_margin`',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Record of financial transactions between legal entities within the telecom group — e.g., shared service charges, intercompany loans, management fee allocations, intragroup roaming settlements, and infrastructure cost sharing between subsidiaries. Captures sending/receiving company codes, transaction type, amount, elimination status, and reconciliation reference. Essential for financial consolidation, intercompany elimination, and group EBITDA reporting.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Unique identifier for the cost allocation transaction record in SAP Controlling (CO) module. Primary key for this entity.',
    `allocation_cycle_id` BIGINT COMMENT 'Business identifier for the periodic assessment or distribution cycle that groups related cost allocation transactions. Corresponds to SAP CO cycle run identifier.. Valid values are `^[A-Z0-9]{8,12}$`',
    `allocation_rule_id` BIGINT COMMENT 'Identifier of the predefined allocation rule or cycle segment that governs this transaction, used for recurring monthly allocations.. Valid values are `^[A-Z0-9]{6,12}$`',
    `company_code_id` BIGINT COMMENT 'FK to finance.company_code',
    `employee_id` BIGINT COMMENT 'The SAP user ID of the manager or controller who approved the allocation transaction, populated when approval workflow is used.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key reference to the corresponding general ledger journal entry line created by this cost allocation, linking CO to FI for financial consolidation.',
    `original_allocation_cost_allocation_id` BIGINT COMMENT 'Reference to the original cost allocation record that this transaction reverses, populated only when reversal_indicator is true.',
    `cost_center_id` BIGINT COMMENT 'The cost center from which costs are being allocated. Typically represents shared infrastructure (NOC, RAN, IT platforms, corporate overhead) whose costs are distributed to beneficiaries.',
    `profit_center_id` BIGINT COMMENT 'The profit center receiving the allocated costs, used for segment P&L reporting and EBITDA analysis by business line (e.g., wireless, broadband, enterprise).',
    `element_id` BIGINT COMMENT 'The WBS element (project phase or deliverable) receiving the allocated costs, used when costs are allocated to capital projects or network expansion initiatives.. Valid values are `^[A-Z0-9-]{6,16}$`',
    `user_employee_id` BIGINT COMMENT 'The SAP user ID of the person or system account that executed the allocation cycle or posted the manual allocation.. Valid values are `^[A-Z0-9]{6,12}$`',
    `activity_quantity` DECIMAL(18,2) COMMENT 'The quantity of activity consumed by the receiver (e.g., 120 support hours, 500 monitoring hours), used with activity rate to calculate allocated amount.',
    `activity_rate` DECIMAL(18,2) COMMENT 'The cost per unit of activity (e.g., USD per support hour, USD per monitoring hour), multiplied by activity quantity to determine allocated amount.',
    `activity_type_code` STRING COMMENT 'The activity type code when using activity-based allocation (e.g., NOC monitoring hours, IT support tickets, network maintenance hours).. Valid values are `^[A-Z0-9]{3,6}$`',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The total cost amount allocated from sender to receiver in the company currency. This is the net amount posted to receiver controlling objects and corresponding journal entry lines.',
    `allocation_basis_type` STRING COMMENT 'The method used to determine how costs are distributed: fixed percentage (pre-defined split), statistical key figure (driver-based), activity quantity (usage-based), headcount, revenue, subscriber count, or network capacity. [ENUM-REF-CANDIDATE: fixed_percentage|statistical_key_figure|activity_quantity|headcount|revenue|subscriber_count|network_capacity — 7 candidates stripped; promote to reference product]',
    `allocation_description` STRING COMMENT 'Free-text description of the allocation transaction, typically auto-generated from cycle definition or manually entered for ad-hoc allocations.',
    `allocation_document_number` STRING COMMENT 'The SAP CO document number generated when the allocation is posted, used for audit trail and drill-down to source transaction.. Valid values are `^[0-9]{10}$`',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of sender costs allocated to this receiver when using fixed percentage allocation basis. Value between 0.00 and 100.00.',
    `allocation_run_timestamp` TIMESTAMP COMMENT 'The date and time when the allocation cycle was executed and this transaction was created in the system.',
    `allocation_status` STRING COMMENT 'Current lifecycle state of the cost allocation transaction: draft (planned but not executed), posted (committed to ledger), reversed (undone), error (failed validation), or cancelled (aborted before posting).. Valid values are `draft|posted|reversed|error|cancelled`',
    `allocation_type` STRING COMMENT 'Classification of the cost allocation method used: assessment (fixed percentage), distribution (variable key figure), periodic repost (sender-receiver), settlement (project/order close), or overhead allocation (activity-based).. Valid values are `assessment|distribution|periodic_repost|settlement|overhead_allocation`',
    `approval_status` STRING COMMENT 'Workflow approval status for allocations requiring management review before posting, particularly for large or non-standard allocations.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the allocation was approved by the designated approver.',
    `business_segment` STRING COMMENT 'The business line or product segment receiving the allocated costs, used for segment P&L and EBITDA reporting (e.g., wireless, broadband, fiber, enterprise, wholesale, IPTV, OTT, 5G). [ENUM-REF-CANDIDATE: wireless|broadband|fiber|enterprise|wholesale|iptv|ott|5g — 8 candidates stripped; promote to reference product]',
    `controlling_area` STRING COMMENT 'The controlling area (management accounting organizational unit) in which the allocation is executed. May span multiple company codes for consolidated cost management.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_category` STRING COMMENT 'Classification of the allocated cost as CAPEX (capital expenditure for network build, infrastructure projects) or OPEX (operational expenditure for ongoing operations and maintenance).. Valid values are `OPEX|CAPEX`',
    `cost_center_code` STRING COMMENT 'Financial cost center code associated with the service territory for operational expenditure (OPEX) tracking and budget allocation. [Moved from service_territory: This attribute in service_territory (Product B) represents a single cost center assignment, which contradicts the M:N reality where a territory receives costs from multiple cost centers. This attribute should be removed from service_territory as it oversimplifies the relationship. The cost_allocation association now properly captures the many-to-many cost center assignments with allocation percentages and methods.]. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost allocation record was first created in the lakehouse, capturing data ingestion time for audit and lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocated amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or custom period) within the fiscal year for this allocation, used for monthly P&L and cost center reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the cost allocation transaction is recorded, derived from posting date and company fiscal calendar.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost allocation record was last updated in the lakehouse, used for change tracking and incremental processing.',
    `posting_date` DATE COMMENT 'The accounting date on which the cost allocation transaction was posted to the general ledger and controlling documents. Determines the fiscal period for financial reporting.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this allocation transaction is a reversal of a previously posted allocation (true) or an original posting (false).',
    `source_system` STRING COMMENT 'Identifier of the source ERP or financial system from which this allocation record originated (e.g., SAP S/4HANA instance ID), used in multi-system landscapes.. Valid values are `^[A-Z0-9]{3,10}$`',
    `statistical_key_figure_code` STRING COMMENT 'The code identifying the statistical key figure used as allocation driver (e.g., subscriber count, network port count, square footage, FTE count).. Valid values are `^[A-Z0-9]{3,6}$`',
    `statistical_key_figure_value` DECIMAL(18,2) COMMENT 'The quantity of the statistical key figure for the receiver, used to calculate proportional allocation (e.g., 50,000 subscribers, 200 FTEs).',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Record of internal cost distribution transactions in SAP Controlling — periodic assessment and distribution cycles that allocate shared infrastructure costs (NOC operations, shared RAN, IT platforms, corporate overhead) from sender cost centers to receiver cost centers, profit centers, or WBS elements. Each record captures the allocation cycle ID, sender/receiver controlling objects, allocation basis (percentage, statistical key figure, activity type/rate), allocated amount, fiscal period, and reversal indicator. Produces corresponding journal_entry_line postings. Essential for accurate product-line P&L, network cost-per-subscriber analysis, and EBITDA by segment.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`company_code` (
    `company_code_id` BIGINT COMMENT 'Unique identifier for the company code record. Primary key.',
    `address_line_1` STRING COMMENT 'First line of the registered legal address of the company code, typically containing street number and street name.',
    `address_line_2` STRING COMMENT 'Second line of the registered legal address, typically containing building name, floor, or suite information.',
    `business_area_required_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether business area assignment is mandatory for all financial postings in this company code. Used for segment reporting under IFRS 8.',
    `business_registration_number` STRING COMMENT 'Official business or company registration number issued by the local government or commercial registry. Used for statutory filings and legal documentation.',
    `chart_of_accounts` STRING COMMENT 'Four-character code identifying the chart of accounts assigned to this company code. The COA defines the structure of General Ledger (GL) accounts used for financial recording and reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `city` STRING COMMENT 'City or municipality where the company code is legally registered.',
    `company_code` STRING COMMENT 'Four-character alphanumeric code uniquely identifying the legal entity within the SAP S/4HANA system. This is the business key used across all financial postings and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code_status` STRING COMMENT 'Current operational status of the company code. Active company codes can post financial transactions; inactive or closed company codes are restricted.. Valid values are `active|inactive|pending_activation|closed`',
    `company_name` STRING COMMENT 'Full legal name of the company code entity as registered with regulatory authorities. Used for statutory reporting, invoices, and legal documentation.',
    `company_name_short` STRING COMMENT 'Abbreviated or short name of the company code for display purposes in reports and user interfaces.',
    `company_type` STRING COMMENT 'Classification of the legal entity type. Determines consolidation treatment, reporting requirements, and intercompany transaction handling.. Valid values are `operating_company|subsidiary|joint_venture|holding_company|branch|representative_office`',
    `consolidation_group` STRING COMMENT 'Code identifying the consolidation group to which this company code belongs for group financial reporting and EBITDA analysis.',
    `controlling_area` STRING COMMENT 'Four-character code identifying the controlling area to which this company code is assigned. The controlling area is the organizational unit in SAP Controlling (CO) used for cost accounting, internal orders, and profitability analysis.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_of_sales_accounting_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this company code uses cost-of-sales accounting (true) or period accounting (false) for profit and loss reporting. Determines GL account assignment logic.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the company code is legally registered and operates. Critical for tax jurisdiction, regulatory reporting, and statutory compliance.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'User ID of the person who created this company code master record in the system.',
    `created_date` DATE COMMENT 'Date when this company code master record was created in the SAP S/4HANA system.',
    `credit_control_area` STRING COMMENT 'Four-character code identifying the credit control area assigned to this company code. Used for managing customer credit limits and credit exposure across one or more company codes.. Valid values are `^[A-Z0-9]{4}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the local currency in which this company code maintains its books and records. All financial postings are recorded in this currency.. Valid values are `^[A-Z]{3}$`',
    `effective_from_date` DATE COMMENT 'Date from which this company code became active and able to post financial transactions. Marks the start of the company codes operational lifecycle.',
    `effective_to_date` DATE COMMENT 'Date on which this company code ceased operations or was closed. Null for currently active company codes.',
    `field_status_variant` STRING COMMENT 'Four-character code defining which fields are required, optional, or suppressed during financial document posting for this company code.. Valid values are `^[A-Z0-9]{4}$`',
    `financial_statement_version` STRING COMMENT 'Code identifying the financial statement version used for external reporting by this company code. Defines the structure and line items of balance sheet and profit & loss statements.',
    `fiscal_year_variant` STRING COMMENT 'Two-character code defining the fiscal year structure for this company code, including the number of posting periods, special periods, and fiscal year start/end dates. Determines how financial periods are structured for reporting.. Valid values are `^[A-Z0-9]{2}$`',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code representing the primary language used for communication and documentation by this company code.. Valid values are `^[a-z]{2}$`',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified this company code master record.',
    `last_modified_date` DATE COMMENT 'Date when this company code master record was last modified.',
    `legal_entity_identifier` STRING COMMENT 'Twenty-character ISO 17442 Legal Entity Identifier uniquely identifying the legal entity in global financial markets. Required for regulatory reporting to financial authorities.. Valid values are `^[A-Z0-9]{20}$`',
    `maximum_exchange_rate_deviation` DECIMAL(18,2) COMMENT 'Maximum allowable percentage deviation from the standard exchange rate for foreign currency transactions. Used for exchange rate validation during posting.',
    `parent_company_code` STRING COMMENT 'Four-character company code of the parent entity in the corporate hierarchy. Used for consolidation and intercompany transaction elimination.. Valid values are `^[A-Z0-9]{4}$`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the registered legal address.',
    `posting_period_variant` STRING COMMENT 'Four-character code defining the posting period control rules for this company code, including open and closed periods for financial postings.. Valid values are `^[A-Z0-9]{4}$`',
    `profit_center_standard_hierarchy` STRING COMMENT 'Code identifying the standard profit center hierarchy assigned to this company code for profitability analysis and segment reporting.',
    `state_province` STRING COMMENT 'State, province, or region where the company code is legally registered. Relevant for jurisdictions with sub-national tax or regulatory requirements.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the primary tax jurisdiction under which this company code operates. Used for tax calculation, withholding tax, and tax reporting compliance.',
    `time_zone` STRING COMMENT 'IANA time zone identifier representing the time zone in which the company code operates. Used for timestamp normalization and scheduling.',
    `vat_registration_number` STRING COMMENT 'VAT or GST registration number assigned by the tax authority. Required for VAT/GST reporting and invoicing in applicable jurisdictions.',
    CONSTRAINT pk_company_code PRIMARY KEY(`company_code_id`)
) COMMENT 'Master record for each legal entity (company code) within the telecom group in SAP S/4HANA — representing distinct operating companies, subsidiaries, and joint ventures across geographies. Captures company code, company name, country, currency, chart of accounts, fiscal year variant, and controlling area assignment. Foundational reference entity for all financial postings, consolidation, and statutory reporting.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` (
    `financial_consolidation_id` BIGINT COMMENT 'Unique identifier for the group-level financial consolidation record. Primary key for the financial consolidation entity.',
    `analytical_subject_area_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_subject_area. Business justification: Consolidated financials feed into analytical subject areas (financial performance, regulatory reporting, investor relations). Telecommunications finance publishes consolidation outputs to analytics fo',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Financial consolidation is performed for a parent entity (legal entity). N:1 relationship (many consolidations for one parent company). The parent_company_code_id FK will link to company_code.company_',
    `employee_id` BIGINT COMMENT 'User identifier of the finance professional who prepared this consolidation record.',
    `accounting_standard` STRING COMMENT 'Primary accounting framework applied for this consolidation: IFRS (International Financial Reporting Standards), US GAAP (Generally Accepted Accounting Principles), or local jurisdiction GAAP.. Valid values are `IFRS|US_GAAP|LOCAL_GAAP`',
    `approval_date` DATE COMMENT 'Date when the consolidation was formally approved by authorized finance leadership.',
    `audit_opinion` STRING COMMENT 'Type of audit opinion issued: unqualified (clean), qualified (exceptions noted), adverse (material misstatement), or disclaimer (unable to form opinion).. Valid values are `unqualified|qualified|adverse|disclaimer`',
    `audit_status` STRING COMMENT 'Status of external audit review for this consolidation: not started, in progress, completed (findings issued), or certified (clean opinion).. Valid values are `not_started|in_progress|completed|certified`',
    `auditor_name` STRING COMMENT 'Name of the external audit firm responsible for auditing this consolidation (e.g., Big Four accounting firm).',
    `capex_consolidated` DECIMAL(18,2) COMMENT 'Consolidated capital expenditure for the period, including network infrastructure, equipment, and technology investments.',
    `consolidation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code used for group-level consolidated reporting (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `consolidation_method` STRING COMMENT 'Technical method used for consolidation: direct (single-step), step acquisition (phased control), or simultaneous (all entities at once).. Valid values are `direct|step_acquisition|simultaneous`',
    `consolidation_notes` STRING COMMENT 'Free-text notes documenting significant consolidation adjustments, assumptions, or explanations for material variances.',
    `consolidation_number` STRING COMMENT 'Business identifier for the consolidation run. Externally-known unique document number used for audit trail and reference.. Valid values are `^CONS-[0-9]{8}$`',
    `consolidation_scope` STRING COMMENT 'Method of consolidation applied: full (100% control), partial (significant influence), equity method (20-50% ownership), or proportionate (joint ventures).. Valid values are `full|partial|equity_method|proportionate`',
    `consolidation_status` STRING COMMENT 'Current lifecycle state of the consolidation process. Tracks workflow from draft through approval to final publication.. Valid values are `draft|in_progress|review|approved|published|closed`',
    `consolidation_type` STRING COMMENT 'Classification of the consolidation purpose: statutory (IFRS/GAAP), management (internal reporting), regulatory (FCC/ITU filings), tax (jurisdiction-specific), or segment (business unit rollup).. Valid values are `statutory|management|regulatory|tax|segment`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this consolidation record was first created in the financial system.',
    `currency_translation_adjustment` DECIMAL(18,2) COMMENT 'Cumulative translation adjustment arising from converting foreign subsidiary financial statements into the consolidation currency. Recorded in other comprehensive income.',
    `ebitda_consolidated` DECIMAL(18,2) COMMENT 'Consolidated EBITDA calculated as operating income before depreciation, amortization, interest, and taxes. Key performance metric for telecom industry.',
    `filing_deadline_date` DATE COMMENT 'Regulatory deadline by which this consolidation must be filed with governing authorities.',
    `filing_submission_date` DATE COMMENT 'Actual date when the consolidation report was submitted to regulatory authorities.',
    `fiscal_period` STRING COMMENT 'Fiscal period number within the fiscal year (1-12 for monthly, 1-4 for quarterly). Aligns with company fiscal calendar.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year to which this consolidation belongs (e.g., 2024).',
    `goodwill_consolidated` DECIMAL(18,2) COMMENT 'Consolidated goodwill arising from business combinations, representing excess of purchase price over fair value of net identifiable assets acquired.',
    `intangible_assets_consolidated` DECIMAL(18,2) COMMENT 'Consolidated intangible assets including spectrum licenses, customer relationships, brand value, and software, expressed in consolidation currency.',
    `intercompany_elimination_amount` DECIMAL(18,2) COMMENT 'Total value of intercompany transactions and balances eliminated during consolidation to avoid double-counting (e.g., intercompany sales, loans, dividends).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this consolidation record was last updated or modified.',
    `minority_interest_amount` DECIMAL(18,2) COMMENT 'Non-controlling interest (minority interest) in consolidated subsidiaries, representing equity attributable to shareholders other than the parent.',
    `net_income_consolidated` DECIMAL(18,2) COMMENT 'Consolidated net income (profit after tax) for the group, expressed in consolidation currency.',
    `number_of_entities_consolidated` STRING COMMENT 'Count of legal entities included in the consolidation scope for this reporting period.',
    `opex_consolidated` DECIMAL(18,2) COMMENT 'Consolidated operational expenditure for the period, including network operations, customer service, and administrative costs.',
    `parent_entity_code` STRING COMMENT 'Legal entity code of the parent company at the top of the consolidation hierarchy. Typically the publicly-traded holding company.. Valid values are `^[A-Z0-9]{4,10}$`',
    `publication_date` DATE COMMENT 'Date when the consolidated financial statements were published to stakeholders (investors, regulators, public).',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this consolidation must be filed with regulatory authorities (FCC, SEC, ITU, national telecom regulators).',
    `reporting_period_end_date` DATE COMMENT 'Last day of the financial reporting period covered by this consolidation (e.g., 2024-03-31 for Q1 2024).',
    `reporting_period_start_date` DATE COMMENT 'First day of the financial reporting period covered by this consolidation (e.g., 2024-01-01 for Q1 2024).',
    `total_assets_consolidated` DECIMAL(18,2) COMMENT 'Consolidated total assets on the group balance sheet after elimination of intercompany balances, expressed in consolidation currency.',
    `total_equity_consolidated` DECIMAL(18,2) COMMENT 'Consolidated total equity (shareholders equity) on the group balance sheet, expressed in consolidation currency.',
    `total_liabilities_consolidated` DECIMAL(18,2) COMMENT 'Consolidated total liabilities on the group balance sheet after elimination of intercompany balances, expressed in consolidation currency.',
    `total_operating_expenses_consolidated` DECIMAL(18,2) COMMENT 'Consolidated total operating expenses (OPEX) for the group after elimination entries, expressed in consolidation currency.',
    `total_revenue_consolidated` DECIMAL(18,2) COMMENT 'Consolidated total revenue for the group after elimination of intercompany transactions, expressed in consolidation currency.',
    CONSTRAINT pk_financial_consolidation PRIMARY KEY(`financial_consolidation_id`)
) COMMENT 'Group-level financial consolidation record capturing the consolidated financial position of the telecom group across all legal entities for a given reporting period. Tracks consolidation scope, elimination entries, currency translation adjustments, minority interest calculations, and consolidated P&L/balance sheet values. Supports IFRS group reporting, EBITDA disclosure, and regulatory financial filings.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`capital_project` (
    `capital_project_id` BIGINT COMMENT 'Primary key for capital_project',
    `employee_id` BIGINT COMMENT 'Identifier of the project manager responsible for day-to-day execution, budget control, and milestone delivery.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Capital project is owned by a legal entity. N:1 relationship (many projects per company). The company_code_id FK will link to company_code.company_code_id. The existing company_code STRING attribute i',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Major capex projects (fiber buildouts, private network deployments) are often customer-specific for large enterprise accounts—required for customer-funded capex tracking and cost recovery.',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Capital projects deliver infrastructure to specific enterprise sites (circuit installation, equipment deployment)—required for site-level capex tracking and asset capitalization.',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Capex projects for tower builds, site upgrades, equipment installations are executed at specific physical sites. Essential for project cost tracking by site, construction milestone management, site co',
    `network_rollout_zone_id` BIGINT COMMENT 'Foreign key linking to location.network_rollout_zone. Business justification: Major capex programs (5G rollout, fiber expansion, rural broadband) are planned and budgeted by rollout zones. Required for program financial tracking, subsidy claim validation, zone-level capex vs. a',
    `primary_capital_approved_by_employee_id` BIGINT COMMENT 'Identifier of the executive or committee member who granted final project approval. Audit trail for governance compliance.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Capital project is assigned to a profit center for profitability tracking. N:1 relationship (many projects per profit center). The profit_center_id FK will link to profit_center.profit_center_id. The ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Capital project is assigned to a responsible cost center for project management and cost tracking. N:1 relationship (many projects per cost center). The responsible_cost_center_id FK will link to cost',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: CapEx projects target specific KPIs (network capacity, coverage improvement, subscriber acquisition cost). Telecommunications finance tracks which KPIs each capital investment improves for ROI analysi',
    `actual_completion_date` DATE COMMENT 'Actual date when project was completed and all deliverables accepted. Triggers final settlement and asset capitalization.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Total actual costs posted to the project from invoices, goods receipts, and internal activity allocations. Real-time spend tracking.',
    `approval_date` DATE COMMENT 'Date when the project business case and budget were formally approved by the investment committee or board.',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Total approved capital budget for the project, including all phases and contingency. Baseline for variance analysis and budget control.',
    `asset_class` STRING COMMENT 'Target asset class for capitalization upon project completion. Determines depreciation method, useful life, and balance sheet classification.. Valid values are `^[A-Z0-9]{8}$`',
    `auc_asset_number` STRING COMMENT 'Asset number for the AuC master record where project costs are capitalized during construction. Converted to fixed asset upon project completion.. Valid values are `^[A-Z0-9]{12}$`',
    `budget_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the approved budget. Typically the local currency of the operating company.. Valid values are `^[A-Z]{3}$`',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'Calculated variance between approved budget and actual costs (approved_budget_amount - actual_cost_amount). Positive indicates under budget.',
    `budget_variance_percentage` DECIMAL(18,2) COMMENT 'Budget variance expressed as percentage of approved budget. Key performance indicator for project financial control.',
    `business_unit_code` STRING COMMENT 'Business unit or operating segment that will benefit from the capital investment. Links project to strategic business objectives.. Valid values are `^[A-Z0-9]{6}$`',
    `capitalization_date` DATE COMMENT 'Date when project costs are transferred from AuC to fixed assets on the balance sheet. Marks the start of depreciation.',
    `committed_cost_amount` DECIMAL(18,2) COMMENT 'Total committed costs from purchase orders, contracts, and reservations. Represents financial obligations not yet invoiced.',
    `controlling_area` STRING COMMENT 'SAP Controlling Area for cost accounting and internal reporting. Links project costs to management accounting structures.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the project record was first created in the system. Audit trail for data lineage and compliance.',
    `environmental_impact_assessment_required` BOOLEAN COMMENT 'Indicates whether the project requires environmental impact assessment under NEPA or state environmental regulations.',
    `forecast_final_cost_amount` DECIMAL(18,2) COMMENT 'Projected total cost at project completion based on current actuals, commitments, and remaining work estimates. Updated monthly.',
    `functional_area` STRING COMMENT 'Business function or division responsible for project delivery. Used for cross-functional portfolio analysis and resource allocation.. Valid values are `network_operations|network_engineering|it_infrastructure|finance|procurement|facilities`',
    `geographic_region` STRING COMMENT 'Primary geographic region or market where the capital investment is deployed. Used for regional portfolio analysis and regulatory reporting.',
    `in_service_date` DATE COMMENT 'Date when the capital asset is placed into operational service and begins generating revenue or operational benefits. Triggers depreciation start.',
    `investment_category` STRING COMMENT 'Strategic investment classification for portfolio management and CAPEX allocation analysis. Aligns with network planning and technology roadmap. [ENUM-REF-CANDIDATE: ran_expansion|core_network|transport_network|access_network|it_systems|facilities|spectrum — 7 candidates stripped; promote to reference product]',
    `irr_percentage` DECIMAL(18,2) COMMENT 'Internal rate of return calculated for the project investment. Used for comparing investment alternatives and portfolio optimization.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the project record. Tracks data currency and change frequency for analytics.',
    `notes` STRING COMMENT 'Free-text field for additional project information, special instructions, or contextual details not captured in structured fields.',
    `npv_amount` DECIMAL(18,2) COMMENT 'Calculated net present value of the project investment based on discounted cash flow analysis. Key metric for capital allocation decisions.',
    `payback_period_months` STRING COMMENT 'Expected number of months to recover the capital investment through operational benefits and revenue generation.',
    `planned_completion_date` DATE COMMENT 'Target date for project completion and final deliverable acceptance. Baseline for schedule variance analysis.',
    `planned_cost_amount` DECIMAL(18,2) COMMENT 'Total planned cost estimate for the project based on detailed engineering and procurement planning. Updated throughout project lifecycle.',
    `priority_level` STRING COMMENT 'Strategic priority ranking for resource allocation and portfolio management. Critical projects receive preferential funding and resources.. Valid values are `critical|high|medium|low`',
    `project_definition_code` STRING COMMENT 'External business identifier for the project definition in SAP PS. Used for cross-system integration and reporting.. Valid values are `^[A-Z0-9]{8,12}$`',
    `project_description` STRING COMMENT 'Detailed business description and scope of the capital project, including objectives, deliverables, and strategic alignment.',
    `project_name` STRING COMMENT 'Full descriptive name of the capital project (e.g., 5G NR Rollout Phase 3 - Metro Region, FTTH Fiber Deployment - Northeast Corridor).',
    `project_phase` STRING COMMENT 'Current execution phase of the project within its lifecycle. Used for milestone tracking and phase-gate governance. [ENUM-REF-CANDIDATE: initiation|planning|design|procurement|construction|testing|commissioning|closeout — 8 candidates stripped; promote to reference product]',
    `project_status` STRING COMMENT 'Current lifecycle status of the capital project. Controls budget availability, settlement processing, and asset capitalization workflow. [ENUM-REF-CANDIDATE: planning|approved|in_progress|on_hold|completed|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `project_type` STRING COMMENT 'Classification of the capital project by investment category. Determines capitalization rules, depreciation schedules, and financial reporting treatment.. Valid values are `network_infrastructure|spectrum_acquisition|data_center|oss_bss_platform|customer_premises_equipment|fiber_deployment`',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether the project requires regulatory approval from FCC, state PUC, or other telecommunications authorities before execution.',
    `risk_rating` STRING COMMENT 'Overall risk assessment for the project considering technical, financial, schedule, and regulatory risks. Determines oversight and contingency requirements.. Valid values are `low|medium|high|critical`',
    `roi_target_percentage` DECIMAL(18,2) COMMENT 'Target ROI percentage established during project approval. Used for investment prioritization and post-implementation review.',
    `settlement_profile` STRING COMMENT 'SAP settlement profile defining rules for transferring project costs to fixed assets (AuC - Assets under Construction) or expense accounts.. Valid values are `^[A-Z0-9]{6}$`',
    `start_date` DATE COMMENT 'Planned or actual start date of project execution. Marks the beginning of budget consumption and resource allocation.',
    `technology_domain` STRING COMMENT 'Primary technology domain or platform that the project delivers or enhances. Critical for technology portfolio management and ROI measurement. [ENUM-REF-CANDIDATE: 5g_nr|lte|ftth_gpon|iptv|ims_volte|sdn_nfv|oss_bss|data_center|spectrum — 9 candidates stripped; promote to reference product]',
    `wbs_root_element` STRING COMMENT 'Top-level WBS element code representing the entire project hierarchy. Parent node for all sub-WBS elements and cost collection.. Valid values are `^[A-Z0-9-]{8,16}$`',
    CONSTRAINT pk_capital_project PRIMARY KEY(`capital_project_id`)
) COMMENT 'SSOT for capital expenditure project tracking in SAP Project System — project master data, Work Breakdown Structure (WBS) hierarchy, and financial progress. Covers major telecom infrastructure investments: 5G NR rollout, FTTH/GPON fiber deployment, data center builds, spectrum acquisitions, and OSS/BSS platform upgrades. Captures project definition (ID, type, sponsor, phase, in-service date, ROI target), WBS hierarchy (element codes, responsible cost center, settlement rules, AuC linkage), and financial tracking (approved budget, committed spend, actual spend, planned vs actual variance). Critical for CAPEX governance, asset capitalization workflow, and investment ROI measurement.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`tax_posting` (
    `tax_posting_id` BIGINT COMMENT 'Unique identifier for the tax posting record. Primary key for the tax posting entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Tax posting is made by a legal entity. N:1 relationship (many tax postings per company). The company_code_id FK will link to company_code.company_code_id. The existing company_code STRING attribute is',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tax posting may be charged to a cost center for cost tracking. N:1 relationship (many tax postings per cost center). The cost_center_id FK will link to cost_center.cost_center_id. The existing cost_ce',
    `customer_account_id` BIGINT COMMENT 'The unique identifier of the customer associated with this tax posting, applicable for output tax scenarios on sales transactions.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Tax postings in GL reference source billing invoices for VAT/GST reconciliation, tax authority audits, and indirect tax compliance. Critical for matching tax collected to tax remitted.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Tax posting may be charged to a profit center for profitability tracking. N:1 relationship (many tax postings per profit center). The profit_center_id FK will link to profit_center.profit_center_id. T',
    `vendor_id` BIGINT COMMENT 'The unique identifier of the vendor or supplier associated with this tax posting, applicable for input tax and withholding tax scenarios.',
    `base_amount` DECIMAL(18,2) COMMENT 'The gross base amount on which the tax is calculated, before tax is applied. This is the taxable amount in the transaction currency.',
    `business_area` STRING COMMENT 'The business area or division code for cross-company reporting and consolidation purposes.',
    `clearing_date` DATE COMMENT 'The date on which the tax liability or receivable was cleared or settled through payment or offset.',
    `clearing_document_number` STRING COMMENT 'The document number of the payment or clearing transaction that settled this tax posting.',
    `company_code` STRING COMMENT 'The legal entity or company code within the enterprise to which this tax posting belongs.',
    `cost_center` STRING COMMENT 'The cost center code associated with this tax posting for internal cost allocation and management reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this tax posting record was first created in the system. Audit trail for record creation.',
    `document_date` DATE COMMENT 'The date on the original tax document or invoice that triggered this tax posting.',
    `document_number` STRING COMMENT 'The externally-known unique document number assigned to this tax posting transaction in the financial system.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year when the tax posting occurred.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the tax posting is recorded for financial reporting purposes.',
    `gl_account` STRING COMMENT 'The general ledger account code to which this tax posting is recorded. Typically a tax payable or tax receivable account.',
    `last_modified_by_user` STRING COMMENT 'The user ID or name of the person who last modified this tax posting record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this tax posting record was last updated or modified. Audit trail for record changes.',
    `local_base_amount` DECIMAL(18,2) COMMENT 'The tax base amount converted to the local reporting currency of the company.',
    `local_currency` STRING COMMENT 'The three-letter ISO 4217 currency code of the companys local reporting currency.. Valid values are `^[A-Z]{3}$`',
    `local_tax_amount` DECIMAL(18,2) COMMENT 'The tax amount converted to the local reporting currency of the company.',
    `posting_date` DATE COMMENT 'The date on which the tax posting was recorded in the financial ledger. This is the principal business event timestamp for the tax transaction.',
    `posting_status` STRING COMMENT 'The current lifecycle status of the tax posting in the financial system workflow.. Valid values are `draft|posted|cleared|reversed|parked`',
    `posting_user` STRING COMMENT 'The user ID or name of the person who created or posted this tax transaction in the financial system.',
    `profit_center` STRING COMMENT 'The profit center code associated with this tax posting for segment reporting and profitability analysis.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this tax posting is a reversal or correction of a previous posting.',
    `reversal_reason` STRING COMMENT 'The reason code or description explaining why this tax posting was reversed or corrected.',
    `reversed_document_number` STRING COMMENT 'The document number of the original tax posting that this record reverses, if applicable.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount for this posting in the transaction currency. This is the principal quantitative result of the tax calculation.',
    `tax_code` STRING COMMENT 'The tax code that defines the tax type, rate, and calculation method applied to this posting. Examples include VAT codes, GST codes, withholding tax codes.',
    `tax_exemption_certificate` STRING COMMENT 'The certificate or authorization number supporting the tax exemption claim for this posting.',
    `tax_exemption_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this transaction qualifies for tax exemption under applicable regulations.',
    `tax_jurisdiction_code` STRING COMMENT 'The tax jurisdiction or authority code under which this tax posting is governed. Identifies the country, state, or local tax authority.',
    `tax_jurisdiction_name` STRING COMMENT 'The human-readable name of the tax jurisdiction or authority (e.g., United States IRS, UK HMRC, India GST Council).',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'The tax rate percentage applied to the base amount to calculate the tax amount. For example, 20.00 for 20% VAT.',
    `tax_reporting_period` STRING COMMENT 'The statutory tax reporting period to which this posting belongs, formatted as YYYY-MM or YYYY-QQ for monthly or quarterly tax returns.',
    `tax_return_reference` STRING COMMENT 'The reference number of the tax return filing in which this tax posting is included. Links the posting to the statutory tax return submission.',
    `tax_return_status` STRING COMMENT 'The current status of the tax return associated with this posting in the tax compliance workflow.. Valid values are `draft|submitted|accepted|rejected|amended|closed`',
    `tax_type` STRING COMMENT 'Classification of the tax transaction indicating whether it is input tax (recoverable), output tax (payable), withholding tax, use tax, reverse charge, or import tax.. Valid values are `input_tax|output_tax|withholding_tax|use_tax|reverse_charge|import_tax`',
    `text_description` STRING COMMENT 'Free-text description or notes providing additional context about the tax posting transaction.',
    `transaction_currency` STRING COMMENT 'The three-letter ISO 4217 currency code in which the tax transaction was originally recorded (e.g., USD, EUR, GBP, INR).. Valid values are `^[A-Z]{3}$`',
    `transfer_pricing_method` STRING COMMENT 'The transfer pricing methodology applied for intercompany transactions subject to tax, as per OECD guidelines.. Valid values are `comparable_uncontrolled_price|resale_price|cost_plus|profit_split|transactional_net_margin`',
    `withholding_tax_certificate` STRING COMMENT 'The certificate number issued for withholding tax deducted, required for vendor tax credit claims.',
    `withholding_tax_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this posting represents withholding tax deducted at source.',
    CONSTRAINT pk_tax_posting PRIMARY KEY(`tax_posting_id`)
) COMMENT 'Tax-related financial posting record capturing VAT, GST, withholding tax, and other indirect tax transactions processed through SAP S/4HANA Tax Management. Captures tax code, tax jurisdiction, base amount, tax amount, tax type (input/output), reporting period, and tax return reference. Supports statutory tax compliance, tax return preparation, and transfer pricing documentation for the telecom enterprise across multiple jurisdictions.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the bank account master record in SAP S/4HANA treasury management. Primary key for the bank account entity.',
    `cash_pool_id` BIGINT COMMENT 'Identifier linking this bank account to a cash pooling arrangement. Cash pooling enables centralized liquidity management by consolidating balances across multiple accounts for interest optimization and overdraft protection.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Bank account is owned by a legal entity. N:1 relationship (many bank accounts per company). The company_code_id FK will link to company_code.company_code_id. The existing company_code STRING attribute',
    `house_bank_id` BIGINT COMMENT 'Internal identifier for the house bank in SAP S/4HANA. House banks are the primary banking partners used for payment processing, cash management, and treasury operations. Links to the house bank master data.. Valid values are `^[A-Z0-9]{5}$`',
    `account_close_date` DATE COMMENT 'The date when the bank account was closed with the financial institution. Null for active accounts. Used for historical reporting and account lifecycle management.',
    `account_currency` STRING COMMENT 'Three-letter ISO currency code representing the native currency of the bank account. All transactions in this account are denominated in this currency. Critical for multi-currency treasury operations and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `account_holder_name` STRING COMMENT 'Legal name of the entity that holds the bank account as registered with the financial institution. Typically matches the company legal name for corporate accounts.',
    `account_id_sap` STRING COMMENT 'Five-character alphanumeric account identifier within the house bank structure in SAP S/4HANA. Used in payment programs, bank statement processing, and cash position reporting.. Valid values are `^[A-Z0-9]{5}$`',
    `account_name` STRING COMMENT 'Descriptive name or title of the bank account as registered with the financial institution. Used for identification in treasury reports, payment processing, and bank reconciliation.',
    `account_open_date` DATE COMMENT 'The date when the bank account was originally opened with the financial institution. Used for relationship tracking and historical analysis.',
    `account_purpose` STRING COMMENT 'Free-text description of the business purpose or use case for this bank account (e.g., payroll disbursements, vendor payments, customer collections, tax payments, intercompany settlements). Used for treasury reporting and account rationalization.',
    `account_status` STRING COMMENT 'Current operational status of the bank account. Active accounts are available for transactions; inactive accounts are temporarily suspended; closed accounts are permanently terminated; blocked accounts have restrictions; dormant accounts have no recent activity.. Valid values are `active|inactive|closed|blocked|dormant`',
    `account_type` STRING COMMENT 'Classification of the bank account based on its operational purpose and banking product type. Determines transaction rules, interest calculation, and cash management behavior.. Valid values are `checking|savings|money_market|sweep|lockbox|zero_balance`',
    `authorized_signatories` STRING COMMENT 'Comma-separated list of employee IDs or names authorized to approve payments and transactions from this bank account. Used for dual-control enforcement and audit trail. Confidential due to internal control sensitivity.',
    `auto_reconciliation_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether automated bank reconciliation is enabled for this account. When true, SAP S/4HANA automatically matches bank statement lines to open GL items using matching rules and algorithms.',
    `available_balance` DECIMAL(18,2) COMMENT 'The balance available for immediate use after accounting for holds, pending transactions, and reserve requirements. Critical for payment processing and overdraft prevention.',
    `bank_account_number` STRING COMMENT 'The unique account number assigned by the financial institution. This is the primary account identifier used for all banking transactions, electronic bank statements, and payment processing. Restricted due to financial sensitivity.. Valid values are `^[A-Z0-9]{8,34}$`',
    `bank_branch_name` STRING COMMENT 'Name of the specific branch or office of the financial institution where the account is domiciled. Relevant for regional banking relationships and local cash management.',
    `bank_country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the bank account is domiciled. Critical for regulatory reporting, tax compliance, and cross-border payment routing.. Valid values are `^[A-Z]{3}$`',
    `bank_key` STRING COMMENT 'Unique identifier for the financial institution in the bank directory. In US context this is the ABA routing number; in European context this is the national bank code. Used for payment processing and bank statement reconciliation.. Valid values are `^[A-Z0-9]{8,15}$`',
    `bank_name` STRING COMMENT 'Full legal name of the financial institution where the account is held. Used for reporting, reconciliation, and correspondence.',
    `cash_pool_type` STRING COMMENT 'Classification of the cash pooling structure this account participates in. Physical pooling involves actual fund transfers; notional pooling calculates interest on aggregated balances without transfers; zero-balance accounts sweep funds daily; target-balance accounts maintain specified levels.. Valid values are `physical|notional|zero_balance|target_balance|none`',
    `created_by_user` STRING COMMENT 'SAP user ID of the person who created this bank account master record in the system. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this bank account master record was first created in SAP S/4HANA. Used for audit trail and data lineage tracking.',
    `current_balance` DECIMAL(18,2) COMMENT 'The real-time or most recently updated balance of the bank account. Reflects all posted transactions and is used for daily cash position reporting and liquidity management.',
    `electronic_format` STRING COMMENT 'The electronic file format used for importing bank statements into SAP S/4HANA. MT940 and CAMT.053 are international standards; BAI2 is common in North America; MT942 is for interim statements; proprietary formats are bank-specific.. Valid values are `MT940|CAMT053|BAI2|SWIFT_MT942|proprietary`',
    `gl_account_code` STRING COMMENT 'General ledger account number in the chart of accounts where bank transactions for this account are posted. Links bank account activity to financial statements and enables automated bank reconciliation.. Valid values are `^[0-9]{6,10}$`',
    `iban` STRING COMMENT 'International Bank Account Number used for cross-border payments and SEPA transactions. Mandatory for European banking operations and increasingly used globally for international wire transfers.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$`',
    `interest_calculation_method` STRING COMMENT 'The method used by the financial institution to calculate interest on this account. Daily balance calculates interest on end-of-day balances; average balance uses the period average; tiered applies different rates to balance ranges; none indicates non-interest-bearing accounts.. Valid values are `daily_balance|average_balance|tiered|none`',
    `interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate applied to this bank account, expressed as a decimal (e.g., 0.0250 for 2.50%). Used for interest accrual calculations and cash flow forecasting. May be positive for deposit accounts or negative for overdraft facilities.',
    `last_modified_by_user` STRING COMMENT 'SAP user ID of the person who last modified this bank account master record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this bank account master record was last modified in SAP S/4HANA. Used for audit trail and change tracking.',
    `last_reconciliation_date` DATE COMMENT 'The date when the most recent bank reconciliation was completed for this account. Used to monitor reconciliation timeliness and compliance with internal controls.',
    `last_statement_balance` DECIMAL(18,2) COMMENT 'The closing balance reported on the most recent bank statement. Used as the reconciliation baseline to match against the general ledger balance and identify unreconciled items.',
    `last_statement_date` DATE COMMENT 'The date of the most recent electronic bank statement (MT940 or CAMT.053 format) imported into SAP S/4HANA. Used to track reconciliation currency and identify gaps in statement processing.',
    `minimum_balance_requirement` DECIMAL(18,2) COMMENT 'The minimum balance that must be maintained in the account to avoid fees or meet contractual obligations. Used for cash positioning and liquidity planning.',
    `opening_balance` DECIMAL(18,2) COMMENT 'The account balance at the beginning of the current reporting period or fiscal year. Used as the starting point for cash flow analysis, reconciliation, and liquidity forecasting.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'The maximum negative balance (credit line) authorized by the financial institution for this account. Used for liquidity management and to prevent payment failures. Confidential due to credit facility sensitivity.',
    `payment_method_enabled` STRING COMMENT 'Comma-separated list of payment methods enabled for this bank account (e.g., wire_transfer, ACH, check, SEPA_credit_transfer, SEPA_direct_debit). Determines which payment formats and channels can be used for outbound payments from this account.',
    `reconciliation_status` STRING COMMENT 'Current state of the bank reconciliation process for this account. Reconciled indicates GL and bank statement balances match; pending indicates reconciliation in progress; variance indicates discrepancies requiring investigation; not_started indicates no reconciliation activity.. Valid values are `reconciled|pending|variance|not_started`',
    `signatory_limit_amount` DECIMAL(18,2) COMMENT 'The maximum transaction amount that can be approved by a single authorized signatory. Transactions exceeding this limit require dual approval or escalation. Critical for fraud prevention and internal controls.',
    `statement_import_frequency` STRING COMMENT 'The frequency at which electronic bank statements are automatically imported from the financial institution. Daily is standard for operational accounts; intraday supports real-time cash management; weekly or monthly may be used for low-activity accounts.. Valid values are `daily|intraday|weekly|monthly|on_demand`',
    `swift_bic_code` STRING COMMENT 'SWIFT Business Identifier Code uniquely identifying the bank and branch for international wire transfers and correspondent banking. Format: 8 or 11 characters (bank code, country code, location code, optional branch code).. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `valid_from_date` DATE COMMENT 'The date from which this bank account record is effective and available for use in SAP S/4HANA. Supports time-dependent master data management and historical reporting.',
    `valid_to_date` DATE COMMENT 'The date until which this bank account record is effective. After this date, the account is no longer available for new transactions. Null or far-future date indicates an open-ended validity period.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'SSOT for corporate treasury and cash management in SAP S/4HANA — bank account master data and transactional activity. Captures account master attributes (bank key, account number, type, currency, SWIFT/BIC, IBAN, cash pool assignment, signatories) and electronic bank statement data (MT940/CAMT.053 imports, opening/closing balances, transaction lines, value dates, auto-matching status). Supports daily cash position reporting, automated bank reconciliation, liquidity forecasting, and payment processing across the telecom groups treasury operations.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`bank_statement` (
    `bank_statement_id` BIGINT COMMENT 'Unique identifier for the bank statement record. Primary key for the bank statement entity.',
    `bank_account_id` BIGINT COMMENT 'Reference to the bank account for which this statement was issued. Links to the bank account master data.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Bank statement is for a legal entity. N:1 relationship (many bank statements per company). The company_code_id FK will link to company_code.company_code_id. The existing company_code STRING attribute ',
    `house_bank_id` BIGINT COMMENT 'SAP house bank identifier linking this statement to the telecommunications enterprises banking partner configuration. Used for payment processing and cash management setup.',
    `account_holder_name` STRING COMMENT 'Legal name of the account holder as registered with the bank. Typically matches the company name for corporate accounts.',
    `account_id_sap` STRING COMMENT 'SAP-internal account identifier used in cash management configuration. Links the external bank account to internal SAP master data.',
    `account_number` STRING COMMENT 'The bank-assigned account number for which this statement was generated. May be in local format or IBAN depending on jurisdiction.',
    `available_balance` DECIMAL(18,2) COMMENT 'The available balance reported by the bank, accounting for holds and pending transactions. Used for liquidity forecasting and cash position analysis.',
    `balance_verification_status` STRING COMMENT 'Indicates whether the opening balance matches the previous statement closing balance. Flags continuity breaks requiring investigation.. Valid values are `VERIFIED|MISMATCH|NOT_CHECKED|PENDING`',
    `bank_identifier_code` STRING COMMENT 'SWIFT BIC code of the bank that issued the statement. Uniquely identifies the financial institution in international transactions.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `bank_name` STRING COMMENT 'Full legal name of the banking institution that issued the statement. Provides human-readable identification of the bank.',
    `closing_balance` DECIMAL(18,2) COMMENT 'The account balance at the end of the statement period. Used for daily cash position reporting and liquidity forecasting.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this statement. Defines the denomination of opening balance, closing balance, and all transaction amounts.. Valid values are `^[A-Z]{3}$`',
    `forward_available_balance` DECIMAL(18,2) COMMENT 'Projected available balance including future-dated transactions. Supports treasury cash flow forecasting and liquidity planning.',
    `iban` STRING COMMENT 'International Bank Account Number in ISO 13616 format. Standardized account identifier used for cross-border payments and reconciliation.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]+$`',
    `import_batch_number` STRING COMMENT 'Identifier for the batch job that imported this statement. Groups statements processed together for operational tracking.',
    `import_file_name` STRING COMMENT 'Name of the source file from which this statement was imported. Provides traceability back to the original electronic banking file.',
    `import_timestamp` TIMESTAMP COMMENT 'Date and time when the bank statement file was imported into SAP S/4HANA Cash Management. Record audit timestamp for data lineage.',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified this statement record. Provides accountability for changes and manual interventions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this bank statement record was last updated. Tracks the most recent change for audit and data lineage purposes.',
    `notes` STRING COMMENT 'Free-text notes or comments added by treasury analysts regarding exceptions, manual adjustments, or special handling for this statement.',
    `opening_balance` DECIMAL(18,2) COMMENT 'The account balance at the start of the statement period. Represents the closing balance from the previous statement.',
    `previous_statement_closing_balance` DECIMAL(18,2) COMMENT 'Closing balance from the immediately preceding statement. Used to validate continuity and detect discrepancies between statements.',
    `reconciled_by_user` STRING COMMENT 'User ID of the treasury analyst who completed or approved the reconciliation. Provides accountability for manual reconciliation decisions.',
    `reconciled_transaction_count` STRING COMMENT 'Number of statement transactions that have been successfully auto-matched to open AR/AP items. Used to track reconciliation progress and efficiency.',
    `reconciliation_date` DATE COMMENT 'Date on which the bank reconciliation process was completed for this statement. Null if reconciliation is not yet complete.',
    `reconciliation_status` STRING COMMENT 'Current status of the automated bank reconciliation process. Indicates whether statement transactions have been matched against open Accounts Receivable (AR) and Accounts Payable (AP) items.. Valid values are `NOT_STARTED|IN_PROGRESS|COMPLETED|EXCEPTION|MANUAL_REVIEW`',
    `reconciliation_variance_amount` DECIMAL(18,2) COMMENT 'Total monetary value of unreconciled transactions. Represents the outstanding variance between bank statement and internal cash ledger.',
    `statement_date` DATE COMMENT 'The date on which the bank statement was generated. Principal business event timestamp for the statement lifecycle.',
    `statement_format` STRING COMMENT 'The electronic format in which the bank statement was received. Indicates the message standard used for import into SAP S/4HANA Cash Management.. Valid values are `MT940|CAMT.053|BAI2|CSV|PDF|PROPRIETARY`',
    `statement_number` STRING COMMENT 'Unique statement number assigned by the bank. External business identifier for the statement, typically sequential per account.',
    `statement_period_end_date` DATE COMMENT 'The last date covered by this statement period. Defines the end of the transaction window included in the statement.',
    `statement_period_start_date` DATE COMMENT 'The first date covered by this statement period. Defines the beginning of the transaction window included in the statement.',
    `statement_sequence_number` STRING COMMENT 'Sequential number of this statement within the account history. Used to detect missing statements and ensure continuity.',
    `statement_status` STRING COMMENT 'Current processing status of the bank statement within the cash management system. Tracks the lifecycle state from import through reconciliation to archival.. Valid values are `IMPORTED|RECONCILED|PARTIALLY_RECONCILED|PENDING|ERROR|ARCHIVED`',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'Sum of all credit transactions on this statement. Represents total inflows to the account during the statement period.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'Sum of all debit transactions on this statement. Represents total outflows from the account during the statement period.',
    `transaction_count` STRING COMMENT 'Total number of individual transaction lines included in this bank statement. Used for validation and reconciliation control.',
    `unreconciled_transaction_count` STRING COMMENT 'Number of statement transactions that remain unmatched and require manual review. Indicates exceptions requiring treasury analyst attention.',
    CONSTRAINT pk_bank_statement PRIMARY KEY(`bank_statement_id`)
) COMMENT 'Electronic bank statement record imported into SAP S/4HANA Cash Management from banking partners via MT940/CAMT.053 formats. Each record represents a single statement for one bank account on one date, containing opening/closing balances and individual transaction lines (credits, debits, fees). Captures statement number, statement date, value dates, transaction codes, payer/payee references, and auto-matching status against open AR/AP items. Supports daily cash position reporting, automated bank reconciliation, and liquidity forecasting for the telecom enterprises treasury operations.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` (
    `accounts_receivable_id` BIGINT COMMENT 'Unique identifier for the accounts receivable record. Primary key for the accounts receivable entity.',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account under which this receivable is managed. Links to the billing account entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Accounts receivable is managed by a legal entity. N:1 relationship (many AR records per company). The company_code_id FK will link to company_code.company_code_id. The existing company_code STRING att',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Accounts receivable posts to a GL account for financial reporting. N:1 relationship (many AR records per GL account). The general_ledger_id FK will link to general_ledger.general_ledger_id. The existi',
    `invoice_id` BIGINT COMMENT 'Reference to the original invoice that generated this receivable balance. Links to the invoice entity.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: AR records track which payments reduced receivable balances. Finance links payments to AR for cash application reconciliation, DSO calculation, and aging bucket accuracy. Standard AR subledger require',
    `payment_plan_id` BIGINT COMMENT 'Reference to the payment plan agreement if this receivable is being paid in installments. Null if not on a payment plan.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Accounts receivable is assigned to a profit center for profitability tracking. N:1 relationship (many AR records per profit center). The profit_center_id FK will link to profit_center.profit_center_id',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: AR aging and collection strategies vary by customer segment (postpaid vs prepaid risk profiles). Telecommunications finance tracks receivables by segment for risk management, collection optimization, ',
    `transferred_from_accounts_receivable_id` BIGINT COMMENT 'Self-referencing FK on accounts_receivable (transferred_from_accounts_receivable_id)',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total amount of manual adjustments applied to this receivable. Includes billing corrections, dispute resolutions, and goodwill adjustments.',
    `aging_bucket` STRING COMMENT 'Classification of the receivable based on the number of days past due. Used for AR aging analysis and collection prioritization. Standard buckets: current, 1-30, 31-60, 61-90, 91-120, 120+ days.. Valid values are `current|1_30_days|31_60_days|61_90_days|91_120_days|over_120_days`',
    `ar_document_number` STRING COMMENT 'External business identifier for the accounts receivable document. Used for reconciliation and reporting purposes.',
    `ar_status` STRING COMMENT 'Current lifecycle status of the accounts receivable record. Indicates whether the receivable is open, paid, disputed, or written off. [ENUM-REF-CANDIDATE: open|partially_paid|paid|written_off|disputed|under_collection|credit_applied|reversed — 8 candidates stripped; promote to reference product]',
    `bad_debt_provision_amount` DECIMAL(18,2) COMMENT 'Amount reserved as allowance for doubtful accounts for this receivable. Used for financial statement preparation and EBITDA (Earnings Before Interest Taxes Depreciation and Amortization) analysis.',
    `baseline_date` DATE COMMENT 'Reference date used to calculate the payment due date based on payment terms. Typically the invoice date or goods receipt date.',
    `business_segment` STRING COMMENT 'Business segment or line of business that generated this receivable. Used for segment reporting and revenue analysis by product line.. Valid values are `consumer_wireless|consumer_broadband|enterprise|wholesale|iot|other`',
    `collection_agency_code` BIGINT COMMENT 'Reference to the external collection agency assigned to this receivable if escalated to third-party collections. Null if managed internally.',
    `collection_status` STRING COMMENT 'Current status of collection activities for this receivable. Indicates whether the account is under active collection, on a payment plan, or in legal proceedings.. Valid values are `not_started|in_progress|payment_plan|legal_action|suspended|closed`',
    `company_code` STRING COMMENT 'Legal entity or company code that owns this receivable. Used for financial consolidation and intercompany reconciliation.',
    `created_by_user` STRING COMMENT 'User ID or name of the person or system that created this receivable record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accounts receivable record was first created in the system. Used for audit trail and data lineage.',
    `credit_memo_amount` DECIMAL(18,2) COMMENT 'Total amount of credit memos applied to reduce this receivable balance. Includes service credits, billing adjustments, and promotional credits.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this receivable record. Supports multi-currency AR management.. Valid values are `^[A-Z]{3}$`',
    `days_past_due` STRING COMMENT 'Number of days the receivable is overdue based on the due date. Calculated as current date minus due date for unpaid balances. Zero or negative for current receivables.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the customer has disputed this receivable. True if the receivable is under dispute investigation, false otherwise.',
    `dispute_reason` STRING COMMENT 'Description of the reason the customer disputed this receivable. Includes billing errors, service quality issues, or pricing disagreements. Null if not disputed.',
    `due_date` DATE COMMENT 'Date by which the receivable amount is expected to be paid according to the payment terms. Used for aging and dunning calculations.',
    `dunning_level` STRING COMMENT 'Current dunning escalation level for this receivable. Indicates the stage of collection activity (e.g., 1=reminder, 2=warning, 3=final notice, 4=legal action). Higher levels indicate more aggressive collection efforts.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year when the receivable was created. Used for monthly AR aging and DSO reporting.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the receivable was created. Used for financial reporting and year-over-year DSO (Days Sales Outstanding) analysis.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this receivable is posted. Used for financial statement preparation and revenue assurance reconciliation.',
    `invoice_date` DATE COMMENT 'Date when the original invoice was issued. Used as the baseline for aging calculations and payment terms.',
    `last_dunning_date` DATE COMMENT 'Date when the most recent dunning notice or collection communication was sent to the customer for this receivable.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person or system that last modified this receivable record. Used for audit trail and change management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this accounts receivable record was last updated. Used for audit trail and change tracking.',
    `last_payment_date` DATE COMMENT 'Date when the most recent payment was received and applied to this receivable. Null if no payments have been received.',
    `notes` STRING COMMENT 'Free-text notes and comments related to this receivable. Includes collection notes, dispute details, and special handling instructions.',
    `original_invoice_amount` DECIMAL(18,2) COMMENT 'Total amount of the original invoice before any payments, credits, or adjustments. Represents the initial receivable balance.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current unpaid balance remaining on the receivable after payments, credits, and adjustments. Key metric for AR aging and DSO (Days Sales Outstanding) calculation.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Total amount paid by the customer against this receivable to date. Sum of all payment allocations applied to this AR record.',
    `payment_plan_flag` BOOLEAN COMMENT 'Indicates whether this receivable is part of a structured payment plan or installment agreement. True if customer is on a payment plan, false otherwise.',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms applicable to this receivable (e.g., NET30, NET60, due on receipt). Determines the due date calculation.',
    `reconciliation_date` DATE COMMENT 'Date when this receivable was last reconciled with the billing system. Used for audit trail and revenue assurance reporting.',
    `reconciliation_status` STRING COMMENT 'Status of reconciliation between AR records and billing system invoices. Used for revenue assurance and financial controls.. Valid values are `reconciled|unreconciled|pending_review|variance_identified`',
    `revenue_type` STRING COMMENT 'Classification of the revenue type that generated this receivable. Distinguishes between service charges, equipment sales, usage fees, and other revenue streams.. Valid values are `service_revenue|equipment_revenue|usage_revenue|activation_fee|late_fee|other`',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount written off as bad debt or uncollectible. Represents the portion of the receivable that has been removed from active collection and charged to bad debt expense.',
    `write_off_date` DATE COMMENT 'Date when the receivable or a portion of it was written off as bad debt. Null if no write-off has occurred.',
    `write_off_reason_code` STRING COMMENT 'Code indicating the reason for writing off the receivable (e.g., bankruptcy, uncollectible, customer deceased, small balance). Used for bad debt analysis.',
    CONSTRAINT pk_accounts_receivable PRIMARY KEY(`accounts_receivable_id`)
) COMMENT 'SSOT for trade receivables and customer financial balances managed by the telecom enterprise finance team — outstanding invoice balances, aging buckets (current, 30/60/90/120+ days), credit memo balances, and write-off records. Captures customer account reference, original invoice amount, outstanding balance, due date, dunning level, collection status, and bad debt provision amount. Supports AR aging analysis, DSO calculation, revenue assurance reconciliation, and financial statement preparation distinct from billing-domain invoice generation.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` (
    `revenue_recognition_id` BIGINT COMMENT 'Unique identifier for the revenue recognition entry. Primary key for the revenue recognition product.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Revenue recognition is performed by a legal entity. N:1 relationship (many revenue recognition entries per company). The company_code_id FK will link to company_code.company_code_id. The existing comp',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue recognition may be assigned to a cost center for cost tracking. N:1 relationship (many revenue recognition entries per cost center). The cost_center_id FK will link to cost_center.cost_center_',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer who is the counterparty to the contract. Links to customer master data for segmentation, credit management, and customer lifetime value analysis.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Revenue recognition posts to a GL account for financial reporting. N:1 relationship (many revenue recognition entries per GL account). The general_ledger_id FK will link to general_ledger.general_ledg',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: IFRS 15 revenue recognition entries must reference specific invoices that triggered recognition events. Finance links performance obligation satisfaction to billing documents for revenue assurance and',
    `journal_entry_id` BIGINT COMMENT 'Reference to the journal entry document that posted this revenue recognition to the general ledger. Provides audit trail to financial accounting records.',
    `original_recognition_revenue_recognition_id` BIGINT COMMENT 'Reference to the original revenue recognition entry that this record reverses or adjusts. Maintains audit trail for revenue corrections.',
    `performance_obligation_id` BIGINT COMMENT 'Identifier for the specific performance obligation within the contract. Telecom contracts often contain multiple performance obligations such as handset delivery, service activation, and ongoing network access.',
    `offering_id` BIGINT COMMENT 'Reference to the product offering catalog entry that defines the commercial product sold. Links to product master data for pricing, features, and bundling rules.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue recognition is assigned to a profit center for profitability tracking. N:1 relationship (many revenue recognition entries per profit center). The profit_center_id FK will link to profit_center',
    `sales_contract_id` BIGINT COMMENT 'Reference to the customer contract that governs this revenue recognition entry. Links to the contract master data containing terms, performance obligations, and transaction price allocations.',
    `subscriber_id` BIGINT COMMENT 'Reference to the active subscription instance that generates this revenue. Links to subscription lifecycle data for churn analysis and ARPU calculation.',
    `prior_estimate_revenue_recognition_id` BIGINT COMMENT 'Self-referencing FK on revenue_recognition (prior_estimate_revenue_recognition_id)',
    `allocation_method` STRING COMMENT 'Method used to allocate transaction price to this performance obligation in bundled arrangements. Relative SSP is most common; residual approach used when SSP is highly variable.. Valid values are `relative_ssp|adjusted_market_assessment|expected_cost_plus_margin|residual`',
    `bundled_arrangement_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition entry is part of a multi-element bundled arrangement requiring transaction price allocation across multiple performance obligations.',
    `constraint_applied_flag` BOOLEAN COMMENT 'Indicates whether the variable consideration constraint has been applied per IFRS 15 / ASC 606 requirements to prevent revenue reversal. True when constraint reduces variable consideration estimate.',
    `contract_asset_balance` DECIMAL(18,2) COMMENT 'Contract asset position where revenue has been recognized but billing has not yet occurred. Common in telecom for handset subsidies and upfront service activations.',
    `contract_modification_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition entry results from a contract modification. Telecom contracts frequently undergo modifications for plan upgrades, device changes, and service additions.',
    `contract_reference_number` STRING COMMENT 'Business identifier for the contract. Human-readable contract number used in billing systems and customer communications.',
    `created_by_user` STRING COMMENT 'User ID of the person or system process that created this revenue recognition record. Audit field for accountability and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition record was first created in the system. Audit field for data lineage and compliance.',
    `cumulative_recognized_amount` DECIMAL(18,2) COMMENT 'Total amount of revenue recognized to date for this performance obligation across all fiscal periods since contract inception.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this revenue recognition entry. Critical for multi-currency operations and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `deferred_revenue_balance` DECIMAL(18,2) COMMENT 'Remaining unearned revenue balance for this performance obligation. Represents the contract liability position where cash has been received but performance obligation is not yet satisfied.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year when revenue is recognized. Enables monthly and quarterly financial close processes.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the revenue is recognized. Used for annual financial reporting, budgeting, and year-over-year performance analysis.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the revenue is posted. Maps to the chart of accounts for financial statement preparation.',
    `handset_subsidy_amount` DECIMAL(18,2) COMMENT 'Amount of handset subsidy embedded in the contract. Telecom-specific field capturing the device discount that must be allocated and recognized over the contract term.',
    `last_modified_by_user` STRING COMMENT 'User ID of the person or system process that last modified this revenue recognition record. Audit field for accountability and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition record was last updated. Audit field for tracking changes and data quality monitoring.',
    `modification_type` STRING COMMENT 'Type of contract modification that triggered this revenue recognition adjustment. Critical for tracking customer behavior and revenue impact of plan changes.. Valid values are `upgrade|downgrade|add_service|remove_service|device_change|price_adjustment`',
    `notes` STRING COMMENT 'Free-text notes providing additional context for the revenue recognition entry. Used for documenting complex allocation decisions, management judgments, and audit explanations.',
    `performance_obligation_description` STRING COMMENT 'Detailed description of the performance obligation being satisfied. Examples include mobile service provision, broadband connectivity, handset subsidy, or bundled entertainment content.',
    `recognition_date` DATE COMMENT 'Date on which the revenue was recognized in the general ledger. Represents the business event timestamp for revenue realization.',
    `recognition_method` STRING COMMENT 'Method by which revenue is recognized for this performance obligation. Over time recognition applies to ongoing services like monthly subscriptions; point in time applies to discrete deliverables like handset sales.. Valid values are `over_time|point_in_time`',
    `recognition_pattern` STRING COMMENT 'Specific pattern used for over-time revenue recognition. Straight-line for subscription services, usage-based for metered consumption, milestone for project-based delivery.. Valid values are `straight_line|usage_based|milestone|output_method|input_method`',
    `recognized_amount` DECIMAL(18,2) COMMENT 'Amount of revenue recognized in the current fiscal period for this performance obligation. Represents the portion of transaction price that has been earned through satisfaction of the obligation.',
    `revenue_recognition_status` STRING COMMENT 'Current lifecycle status of the revenue recognition entry. Tracks whether revenue has been recognized, is pending approval, or has been adjusted or reversed.. Valid values are `draft|pending|recognized|deferred|reversed|adjusted`',
    `revenue_stream_category` STRING COMMENT 'Classification of the revenue stream within the telecommunications business model. Distinguishes between recurring subscription revenue, variable usage charges, and one-time equipment sales.. Valid values are `subscription|usage|equipment|activation|overage|roaming`',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition entry has been reversed due to contract cancellation, billing dispute, or accounting correction.',
    `reversal_reason` STRING COMMENT 'Business reason for revenue reversal. Examples include customer churn, service cancellation, billing error, or contract termination.',
    `service_end_date` DATE COMMENT 'Date when the performance obligation period ends. For over-time recognition, this marks the completion of the revenue recognition period.',
    `service_start_date` DATE COMMENT 'Date when the performance obligation period begins. For over-time recognition, this marks the start of the revenue recognition period.',
    `service_type` STRING COMMENT 'Type of telecommunications service associated with this revenue recognition entry. Enables revenue segmentation by service line for management reporting and regulatory compliance. [ENUM-REF-CANDIDATE: mobile|broadband|fiber|iptv|voip|bundled|enterprise|wholesale|roaming|interconnect — 10 candidates stripped; promote to reference product]',
    `standalone_selling_price` DECIMAL(18,2) COMMENT 'Standalone selling price of the performance obligation used for transaction price allocation in bundled arrangements. Required for IFRS 15 / ASC 606 compliance in multi-element contracts.',
    `transaction_price_allocated` DECIMAL(18,2) COMMENT 'Total transaction price allocated to this performance obligation from the contract. For multi-element arrangements, this represents the standalone selling price allocation per IFRS 15 / ASC 606 requirements.',
    `variable_consideration_estimate` DECIMAL(18,2) COMMENT 'Estimated amount of variable consideration included in the transaction price. Includes usage overages, performance bonuses, volume discounts, and other variable pricing elements subject to constraint.',
    CONSTRAINT pk_revenue_recognition PRIMARY KEY(`revenue_recognition_id`)
) COMMENT 'SSOT for IFRS 15 / ASC 606 revenue recognition entries for the telecom enterprise — contract asset/liability positions, performance obligation satisfaction, variable consideration estimates, and multi-element arrangement allocations across mobile, broadband, and bundled service contracts. Captures contract reference, performance obligation ID, transaction price allocation, recognition method (over time/point in time), recognized amount, deferred revenue balance, and fiscal period. Critical for telecom-specific complexities including handset subsidies, contract modifications, and bundled plan allocations.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`budget_allocation` (
    `budget_allocation_id` BIGINT COMMENT 'Unique identifier for this budget allocation record. Primary key.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to the budget plan that is the source of funding for this allocation',
    `network_rollout_zone_id` BIGINT COMMENT 'Foreign key linking to the network rollout zone receiving budget allocation',
    `actual_spend_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure posted against this specific allocation as of the last update. Enables zone-level budget vs. actual tracking.',
    `allocated_budget_amount` DECIMAL(18,2) COMMENT 'The specific monetary amount allocated from the budget plan to this network rollout zone. Represents the financial commitment for this zone from this plan.',
    `allocation_date` DATE COMMENT 'Date when this budget allocation was created or committed. Used for tracking when funds were assigned to the rollout zone.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this allocation. Active: available for spending, exhausted: fully spent, cancelled: withdrawn, reallocated: funds moved to different zone.',
    `approval_status` STRING COMMENT 'Approval state of this specific allocation. Pending: awaiting decision, approved: authorized for spending, rejected: not authorized, revised: changes requested. Allows zone-level allocation approval independent of overall plan approval.',
    `budget_category` STRING COMMENT 'Classification of this allocation as CAPEX (Capital Expenditure for network build) or OPEX (Operational Expenditure for maintenance and operations). A single rollout zone may receive both CAPEX and OPEX allocations from different plans.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total committed funds (purchase orders, contracts) against this allocation not yet expensed. Tracks encumbrances at the zone-allocation level.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this budget allocation applies. May differ from the budget plans primary fiscal year for multi-year plans.',
    `notes` STRING COMMENT 'Free-text notes explaining the rationale for this allocation, special conditions, or constraints specific to this zone-plan combination.',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'Acceptable variance threshold as a percentage of allocated amount for this specific zone allocation. Overrides plan-level threshold when zone-specific control is needed.',
    CONSTRAINT pk_budget_allocation PRIMARY KEY(`budget_allocation_id`)
) COMMENT 'This association product represents the allocation of budget funds from financial plans to specific network infrastructure rollout zones. It captures the financial commitment linking budget plans to rollout zones, tracking allocated amounts, fiscal periods, budget categories (CAPEX/OPEX), approval status, and variance thresholds. Each record represents a specific funding allocation from one budget plan to one network rollout zone, enabling zone-level budget control, program financial management, and tracking of how capital and operational budgets are distributed across the network infrastructure portfolio.. Existence Justification: In telecommunications network infrastructure programs, budget plans routinely allocate funds to multiple rollout zones (e.g., a FY2024 5G Densification Budget funds 50+ zones across multiple markets), and each rollout zone receives funding from multiple budget plans simultaneously (e.g., a zone receives CAPEX from the fiber build program, OPEX from maintenance budgets, and subsidy funds from government programs). The business actively manages these allocations as distinct financial commitments, tracking allocated amounts, approval status, actual spend, and variance thresholds at the zone-plan level.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` (
    `finance_project_assignment_id` BIGINT COMMENT 'Primary key for finance_project_assignment',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to the capital project to which the employee is assigned',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to the capital project',
    `assignment_id` BIGINT COMMENT 'Unique identifier for the project assignment record. Primary key for the association.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Total actual hours the employee has worked on the capital project to date. Accumulated from time tracking systems. Used for labor cost actuals, project progress measurement, and variance analysis against planned effort.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the employees working time allocated to this capital project. Used for resource capacity planning, labor cost allocation, and multi-project workload balancing. Sum across all assignments for an employee should not exceed 100%.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the project assignment. Controls whether time can be charged, whether the assignment appears in active resource reports, and whether labor costs are being capitalized.',
    `billable_rate` DECIMAL(18,2) COMMENT 'Hourly or daily rate at which the employees time is charged to the capital project budget. May differ from base salary due to overhead allocation, benefits loading, or project-specific rate structures. Used for project cost tracking and labor capitalization calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was created in the system. Used for audit trail and data lineage tracking.',
    `end_date` DATE COMMENT 'Date when the employees assignment to the capital project ends or is planned to end. Null for ongoing assignments. Used for resource release planning and labor cost capitalization cutoff.',
    `role` STRING COMMENT 'The functional role or capacity in which the employee is assigned to the capital project. Determines responsibilities, approval authority, and labor cost classification for capitalization.',
    `start_date` DATE COMMENT 'Date when the employees assignment to the capital project begins. Used for resource planning, labor cost capitalization period determination, and project timeline tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_finance_project_assignment PRIMARY KEY(`finance_project_assignment_id`)
) COMMENT 'This association product represents the Assignment between capital_project and employee. It captures the staffing and resource allocation for capital expenditure projects across the telecommunications enterprise. Each record links one capital_project to one employee with attributes that exist only in the context of this assignment relationship, including role, time allocation, billing rates, and assignment duration.. Existence Justification: In telecommunications capital project execution, projects require multiple employees in different functional roles (project manager, network engineers, field technicians, business analysts) working concurrently, and employees routinely work across multiple capital projects simultaneously with varying time allocations. The business actively manages project staffing through assignment records that track role, allocation percentage, billable rates, and actual hours worked - this is operational project resource management, not analytical correlation.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`budget_approval` (
    `budget_approval_id` BIGINT COMMENT 'Unique identifier for this budget approval record. Primary key.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to the budget plan being approved',
    `delegated_by_employee_id` BIGINT COMMENT 'Reference to the employee who delegated approval authority to this approver. Null if not delegated.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who is the approver',
    `approval_comments` STRING COMMENT 'Free-text comments or notes provided by the approver explaining their decision or requesting clarifications.',
    `approval_date` DATE COMMENT 'Date on which the budget plan was formally approved. [Moved from budget_plan: The approval_date in budget_plan captures only a single approval date, which cannot represent sequential approvals by multiple employees. Each approval has its own timestamp, which belongs in the budget_approval association as approval_timestamp.]',
    `approval_limit_amount` DECIMAL(18,2) COMMENT 'The maximum budget amount this employee can approve in their assigned role. Role-specific authority limit for financial controls.',
    `approval_sequence` STRING COMMENT 'The sequential order of this approval in the workflow (1=first approver, 2=second approver, etc.). Enforces approval hierarchy.',
    `approval_status` STRING COMMENT 'Current status of this approval step: pending (awaiting decision), approved (authorized), rejected (denied), deferred (postponed for revision).',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this employee approved the budget plan. Null if approval is pending.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or committee who approved the budget plan (e.g., CFO, Budget Committee). [Moved from budget_plan: The approved_by attribute in budget_plan captures only a single approver name, which is insufficient for multi-stage approval workflows. This data should be captured in the budget_approval association where each approver is tracked with their role, sequence, and approval details.]',
    `approver_role` STRING COMMENT 'The organizational role in which this employee is approving the budget (e.g., department_head, finance_controller, cfo). Determines approval authority and sequence.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this approval record was created in the workflow.',
    `delegation_flag` BOOLEAN COMMENT 'Indicates whether this approval was delegated to this employee by another approver (true) or is their direct responsibility (false).',
    CONSTRAINT pk_budget_approval PRIMARY KEY(`budget_approval_id`)
) COMMENT 'This association product represents the approval workflow between budget_plan and employee. It captures the multi-stage approval process where budget plans require sequential approvals from multiple employees (department head, finance controller, CFO) with role-specific authority limits and delegation tracking. Each record links one budget_plan to one employee approver with attributes that exist only in the context of this approval relationship.. Existence Justification: In telecommunications budget approval workflows, a single budget plan requires sequential approvals from multiple employees in different roles (department head, finance controller, CFO), each with role-specific authority limits. Simultaneously, each employee approves multiple budget plans across different business units and fiscal periods. The business actively manages approval hierarchies, delegation chains, and approval status tracking as a core financial control process.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`payment_plan` (
    `payment_plan_id` BIGINT COMMENT 'Primary key for payment_plan',
    `restructured_from_payment_plan_id` BIGINT COMMENT 'Self-referencing FK on payment_plan (restructured_from_payment_plan_id)',
    `approval_status` STRING COMMENT 'Current approval state of the payment plan.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan received final approval.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the plan automatically renews at expiry.',
    `billing_cycle_day` STRING COMMENT 'Day of month on which recurring billing occurs.',
    `contract_number` STRING COMMENT 'Reference number of the underlying contract linked to the payment plan.',
    `contract_version` STRING COMMENT 'Version of the contract governing the payment plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `payment_plan_description` STRING COMMENT 'Free‑form text describing the purpose and terms of the plan.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the plan.',
    `discount_type` STRING COMMENT 'Method by which the discount is calculated.',
    `discount_value` DECIMAL(18,2) COMMENT 'Value of the discount (percentage or fixed amount).',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Fee charged if the plan is terminated before the effective end date.',
    `effective_from` DATE COMMENT 'Date when the payment plan becomes binding.',
    `effective_until` DATE COMMENT 'Planned end date of the payment plan; null for open‑ended agreements.',
    `grace_period_days` STRING COMMENT 'Number of days after due date before penalties apply.',
    `installment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of each regular installment.',
    `installment_count` STRING COMMENT 'Total number of scheduled installments.',
    `last_payment_date` DATE COMMENT 'Date when the most recent installment was received.',
    `next_payment_due_date` DATE COMMENT 'Scheduled date for the upcoming installment.',
    `payment_channel` STRING COMMENT 'Customer‑facing channel through which payment is made.',
    `payment_frequency` STRING COMMENT 'How often payments are scheduled under the plan.',
    `payment_method` STRING COMMENT 'Instrument used to settle installments.',
    `penalty_rate` DECIMAL(18,2) COMMENT 'Interest or fee rate applied to overdue payments (e.g., 0.0500 = 5%).',
    `plan_code` STRING COMMENT 'External business identifier for the payment plan used in contracts and billing.',
    `plan_name` STRING COMMENT 'Human‑readable name of the payment plan.',
    `plan_type` STRING COMMENT 'Category of the payment plan indicating its commercial model.',
    `payment_plan_status` STRING COMMENT 'Current lifecycle status of the payment plan.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax component applied to each installment.',
    `tax_included_flag` BOOLEAN COMMENT 'Indicates whether tax is already included in installment amounts.',
    `termination_date` DATE COMMENT 'Actual date when the payment plan was terminated.',
    `termination_reason` STRING COMMENT 'Reason code or description for early termination of the plan.',
    `total_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary value of the entire payment plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment plan record.',
    CONSTRAINT pk_payment_plan PRIMARY KEY(`payment_plan_id`)
) COMMENT 'Master reference table for payment_plan. Referenced by payment_plan_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`cash_pool` (
    `cash_pool_id` BIGINT COMMENT 'Primary key for cash_pool',
    `parent_cash_pool_id` BIGINT COMMENT 'Self-referencing FK on cash_pool (parent_cash_pool_id)',
    `available_balance` DECIMAL(18,2) COMMENT 'Portion of the pool balance that is free for allocation or withdrawal.',
    `committed_balance` DECIMAL(18,2) COMMENT 'Amount of cash already earmarked for pending payments or reservations.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the pool balances are maintained.',
    `cash_pool_description` STRING COMMENT 'Free‑form text describing the purpose, strategy, or special conditions of the cash pool.',
    `effective_from` DATE COMMENT 'Date when the cash pool becomes effective for accounting purposes.',
    `effective_until` DATE COMMENT 'Date when the cash pool is scheduled to terminate or be retired. Null if open‑ended.',
    `interest_accrual_date` DATE COMMENT 'Date on which interest for the cash pool is calculated and posted.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the cash pool balance, expressed as a decimal (e.g., 0.0250 for 2.5%).',
    `owner_department` STRING COMMENT 'Business unit responsible for managing the cash pool.',
    `pool_balance` DECIMAL(18,2) COMMENT 'Total amount of cash currently available in the pool.',
    `pool_code` STRING COMMENT 'External business code used to reference the cash pool in treasury operations.',
    `pool_name` STRING COMMENT 'Human‑readable name of the cash pool.',
    `pool_type` STRING COMMENT 'Category of the cash pool indicating its scope or ownership model.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the cash pool record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cash pool record.',
    `region` STRING COMMENT 'Three‑letter country or region code where the cash pool is primarily managed.',
    `risk_rating` STRING COMMENT 'Risk classification of the cash pool based on liquidity and credit exposure.',
    `cash_pool_status` STRING COMMENT 'Current operational status of the cash pool.',
    CONSTRAINT pk_cash_pool PRIMARY KEY(`cash_pool_id`)
) COMMENT 'Master reference table for cash_pool. Referenced by cash_pool_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`house_bank` (
    `house_bank_id` BIGINT COMMENT 'Primary key for house_bank',
    `parent_house_bank_id` BIGINT COMMENT 'Self-referencing FK on house_bank (parent_house_bank_id)',
    `address_line1` STRING COMMENT 'Primary street address of the bank.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `bank_name` STRING COMMENT 'Legal full name of the bank as used in financial transactions.',
    `bank_routing_number` STRING COMMENT 'Domestic routing number used for ACH transfers (US context).',
    `bank_short_name` STRING COMMENT 'Abbreviated or commonly used name of the bank.',
    `bank_swift_code` STRING COMMENT 'International Bank Identifier Code used for cross‑border payments.',
    `bank_type` STRING COMMENT 'Classification of the bank based on its relationship to the enterprise.',
    `bank_website` STRING COMMENT 'Public website address of the bank.',
    `city` STRING COMMENT 'City where the bank branch is located.',
    `contact_email` STRING COMMENT 'Primary email address for the bank contact.',
    `contact_name` STRING COMMENT 'Name of the primary contact person at the bank.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the bank contact.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the bank is headquartered.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the house bank record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for the house bank.',
    `currency` STRING COMMENT 'Default currency used for settlements with this house bank.',
    `house_bank_description` STRING COMMENT 'Free‑form description or notes about the bank.',
    `effective_from` DATE COMMENT 'Date from which the house bank record becomes effective.',
    `effective_until` DATE COMMENT 'Date after which the house bank record is no longer effective (null if open‑ended).',
    `fee_structure` STRING COMMENT 'Method used by the bank to calculate transaction fees.',
    `iban_prefix` STRING COMMENT 'Country‑specific IBAN prefix for the bank.',
    `is_preferred` BOOLEAN COMMENT 'Flag indicating whether this bank is the preferred house bank for the enterprise.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Date and time when the bank details were last validated.',
    `notes` STRING COMMENT 'Additional remarks or operational notes.',
    `postal_code` STRING COMMENT 'Postal code for the banks address.',
    `settlement_cycle` STRING COMMENT 'Frequency at which payments are settled with the bank.',
    `house_bank_status` STRING COMMENT 'Current operational status of the house bank.',
    `tax_id_number` STRING COMMENT 'Tax registration number of the bank as required for reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the house bank record.',
    CONSTRAINT pk_house_bank PRIMARY KEY(`house_bank_id`)
) COMMENT 'Master reference table for house_bank. Referenced by house_bank_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`allocation_cycle` (
    `allocation_cycle_id` BIGINT COMMENT 'Primary key for allocation_cycle',
    `prior_allocation_cycle_id` BIGINT COMMENT 'Self-referencing FK on allocation_cycle (prior_allocation_cycle_id)',
    `allocation_basis_amount` DECIMAL(18,2) COMMENT 'Monetary amount used as the basis for allocations in this cycle.',
    `allocation_frequency` STRING COMMENT 'How often allocations are performed within the cycle.',
    `allocation_method` STRING COMMENT 'Method used to calculate allocations for the cycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation cycle record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary amounts in the allocation cycle.',
    `cycle_code` STRING COMMENT 'External code used to identify the allocation cycle.',
    `cycle_name` STRING COMMENT 'Human‑readable name of the allocation cycle.',
    `cycle_type` STRING COMMENT 'Category of the allocation cycle (e.g., operational, financial, budget, forecast).',
    `allocation_cycle_description` STRING COMMENT 'Free‑form description providing additional context about the allocation cycle.',
    `effective_from` DATE COMMENT 'Date when the allocation cycle becomes effective.',
    `effective_until` DATE COMMENT 'Date when the allocation cycle ends; null for open‑ended cycles.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter number (1‑4) of the allocation cycle.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the allocation cycle belongs.',
    `period_end_date` DATE COMMENT 'Last calendar date covered by the allocation cycle.',
    `period_start_date` DATE COMMENT 'First calendar date covered by the allocation cycle.',
    `allocation_cycle_status` STRING COMMENT 'Current lifecycle status of the allocation cycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the allocation cycle record.',
    `version_number` STRING COMMENT 'Version of the allocation cycle definition for change‑management purposes.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the allocation cycle record.',
    CONSTRAINT pk_allocation_cycle PRIMARY KEY(`allocation_cycle_id`)
) COMMENT 'Master reference table for allocation_cycle. Referenced by allocation_cycle_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`allocation_rule` (
    `allocation_rule_id` BIGINT COMMENT 'Primary key for allocation_rule',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the rule.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the rule.',
    `parent_allocation_rule_id` BIGINT COMMENT 'Self-referencing FK on allocation_rule (parent_allocation_rule_id)',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount applied when the method is fixed‑amount.',
    `allocation_basis` STRING COMMENT 'Financial or operational metric that drives the allocation.',
    `allocation_method` STRING COMMENT 'Mechanism used to calculate the allocation (e.g., percentage of cost, fixed amount).',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage (0‑100) applied when the method is percentage‑based.',
    `allocation_target_type` STRING COMMENT 'Indicates whether the allocation is applied to internal cost objects or external entities.',
    `applicable_to` STRING COMMENT 'Entity category to which the rule can be applied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `allocation_rule_description` STRING COMMENT 'Detailed free‑text description of the rules purpose and logic.',
    `effective_from` DATE COMMENT 'Date when the rule becomes active.',
    `effective_until` DATE COMMENT 'Date when the rule expires; null if open‑ended.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this rule is the default for its type.',
    `notes` STRING COMMENT 'Additional free‑form remarks or comments.',
    `priority` STRING COMMENT 'Numeric priority determining rule evaluation order; lower numbers have higher precedence.',
    `rule_code` STRING COMMENT 'Business code used to reference the allocation rule in finance systems.',
    `rule_expression` STRING COMMENT 'Technical expression or formula used by downstream systems to compute the allocation.',
    `rule_name` STRING COMMENT 'Human‑readable name of the allocation rule.',
    `rule_type` STRING COMMENT 'Category that defines the primary entity the rule applies to.',
    `allocation_rule_status` STRING COMMENT 'Current lifecycle status of the rule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the rule.',
    `version_number` STRING COMMENT 'Version identifier for change management.',
    CONSTRAINT pk_allocation_rule PRIMARY KEY(`allocation_rule_id`)
) COMMENT 'Master reference table for allocation_rule. Referenced by allocation_rule_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Primary key for vendor',
    `parent_vendor_id` BIGINT COMMENT 'Self-referencing FK on vendor (parent_vendor_id)',
    `address_line1` STRING COMMENT 'First line of the vendors primary mailing address.',
    `address_line2` STRING COMMENT 'Second line of the vendors primary mailing address (optional).',
    `bank_account_number` STRING COMMENT 'Bank account number for payments to the vendor.',
    `bank_routing_number` STRING COMMENT 'Routing number (or SWIFT/BIC) for the vendors bank.',
    `city` STRING COMMENT 'City component of the vendors primary address.',
    `compliance_status` STRING COMMENT 'Current compliance standing of the vendor with internal and regulatory requirements.',
    `contract_end_date` DATE COMMENT 'Date when the current contract with the vendor expires or is terminated.',
    `contract_start_date` DATE COMMENT 'Date when the current contract with the vendor became effective.',
    `country` STRING COMMENT 'Three-letter ISO country code of the vendors primary address.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the vendor record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code used for transactions with the vendor.',
    `deactivation_date` DATE COMMENT 'Date when the vendor relationship was terminated or deactivated.',
    `email_address` STRING COMMENT 'General email address for vendor communications.',
    `industry_classification` STRING COMMENT 'Six‑digit NAICS code representing the vendors primary industry.',
    `is_preferred_vendor` BOOLEAN COMMENT 'Indicates whether the vendor is marked as a preferred supplier.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the most recent payment to the vendor.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment made to the vendor.',
    `notes` STRING COMMENT 'Additional free‑form notes about the vendor.',
    `onboarding_date` DATE COMMENT 'Date when the vendor was first onboarded into the system.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the vendor.',
    `phone_number` STRING COMMENT 'Main telephone number for the vendor organization.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the vendors primary address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary vendor contact.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary individual contact for the vendor.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary vendor contact.',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score based on compliance and financial metrics.',
    `state` STRING COMMENT 'State or province of the vendors primary address.',
    `vendor_status` STRING COMMENT 'Current lifecycle state of the vendor relationship.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the vendor is tax‑exempt for purchases.',
    `tax_identifier` STRING COMMENT 'Government-issued tax identifier (e.g., EIN) for the vendor.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the vendor record.',
    `vendor_code` STRING COMMENT 'Business-assigned unique code for the vendor.',
    `vendor_name` STRING COMMENT 'Full legal name of the vendor organization.',
    `vendor_rating` STRING COMMENT 'Internal rating (1‑5) reflecting vendor performance.',
    `vendor_status_reason` STRING COMMENT 'Free‑text explanation for the current vendor status.',
    `vendor_type` STRING COMMENT 'Category describing the primary nature of the vendors offerings.',
    `website_url` STRING COMMENT 'Public website URL of the vendor.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master reference table for vendor. Referenced by vendor_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`lease_contract` (
    `lease_contract_id` BIGINT COMMENT 'Primary key for lease_contract',
    `fixed_asset_id` BIGINT COMMENT 'Identifier of the leased asset (e.g., network equipment).',
    `guarantor_legal_entity_id` BIGINT COMMENT 'Identifier of guarantor party.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the lessee party (customer) entering the lease.',
    `vendor_id` BIGINT COMMENT 'Identifier of the lessor (telecom company) owning the asset.',
    `renewed_from_lease_contract_id` BIGINT COMMENT 'Self-referencing FK on lease_contract (renewed_from_lease_contract_id)',
    `accounting_code` STRING COMMENT 'Chart of accounts code for financial posting of lease transactions.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the lease contract was approved.',
    `approved_by` STRING COMMENT 'User identifier who approved the lease contract.',
    `asset_type` STRING COMMENT 'Category of the asset being leased.',
    `audit_trail` STRING COMMENT 'Append-only log of significant changes to the lease contract (summary).',
    `billing_cycle` STRING COMMENT 'Billing cycle configuration for the lease.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the lease complies with regulatory requirements (e.g., IFRS 16).',
    `contract_document_url` STRING COMMENT 'URL to the stored lease contract document.',
    `contract_number` STRING COMMENT 'Unique contract number assigned to the lease agreement.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the lease contract.',
    `contract_type` STRING COMMENT 'Classification of lease contract based on purpose.',
    `cost_center_code` STRING COMMENT 'Internal cost center associated with the lease.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lease contract record was created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for lease amounts.',
    `department` STRING COMMENT 'Organizational department responsible for the lease.',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Fee payable if lease is terminated before scheduled end date.',
    `escalation_contact` STRING COMMENT 'Contact person for lease escalations.',
    `guarantor_name` STRING COMMENT 'Name of guarantor providing additional security.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the lease (if finance lease).',
    `invoice_number` STRING COMMENT 'Reference to the first invoice generated for the lease.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent lease payment received.',
    `last_payment_date` DATE COMMENT 'Date of the most recent lease payment.',
    `lease_amount` DECIMAL(18,2) COMMENT 'Total nominal amount of the lease contract.',
    `lease_end_date` DATE COMMENT 'Date when the lease term ends (nullable for open-ended).',
    `lease_rate` DECIMAL(18,2) COMMENT 'Periodic lease rate applied to calculate payment amounts.',
    `lease_start_date` DATE COMMENT 'Date when the lease term begins.',
    `lease_term_months` STRING COMMENT 'Total duration of the lease in months.',
    `next_payment_due` DATE COMMENT 'Date of the upcoming lease payment.',
    `payment_due_date` DATE COMMENT 'Next scheduled payment due date.',
    `payment_frequency` STRING COMMENT 'Scheduled frequency of lease payments.',
    `payment_method` STRING COMMENT 'Method used to remit lease payments.',
    `purchase_option_flag` BOOLEAN COMMENT 'Indicates if the lease includes a purchase option at termination.',
    `region` STRING COMMENT 'Geographic region of the leased asset or contract.',
    `remarks` STRING COMMENT 'Free-text field for additional notes or comments about the lease.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates if the lease can be renewed after term expiry.',
    `residual_value` DECIMAL(18,2) COMMENT 'Estimated value of the asset at lease end.',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'Amount held as security deposit for the lease.',
    `total_lease_cost` DECIMAL(18,2) COMMENT 'Aggregate cost over the lease term including interest.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lease contract record.',
    `version_number` STRING COMMENT 'Version number of the lease contract record for concurrency control.',
    CONSTRAINT pk_lease_contract PRIMARY KEY(`lease_contract_id`)
) COMMENT 'Master reference table for lease_contract. Referenced by lease_contract_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Primary key for chart_of_accounts',
    `parent_chart_of_accounts_id` BIGINT COMMENT 'Self-referencing FK on chart_of_accounts (parent_chart_of_accounts_id)',
    `account_code` STRING COMMENT 'Unique alphanumeric code assigned to the GL account.',
    `account_description` STRING COMMENT 'Detailed textual description of the GL account purpose and usage.',
    `account_group` STRING COMMENT 'Higher‑level grouping of accounts used for financial reporting aggregation.',
    `account_name` STRING COMMENT 'Human readable name of the GL account.',
    `account_subtype` STRING COMMENT 'Secondary classification providing finer granularity of the GL account.',
    `account_type` STRING COMMENT 'Category of the GL account indicating its financial statement classification.',
    `cost_center_code` STRING COMMENT 'Cost center associated with the GL account for internal cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the GL account record was first created in the system.',
    `currency_code` STRING COMMENT 'Currency in which the GL account is denominated.',
    `effective_from` DATE COMMENT 'Date when the GL account becomes effective for posting.',
    `effective_until` DATE COMMENT 'Date when the GL account is retired or becomes inactive.',
    `is_budget_controlled` BOOLEAN COMMENT 'Indicates whether the account is subject to budgetary controls.',
    `is_consolidation_account` BOOLEAN COMMENT 'Indicates if the account is used for group consolidation reporting.',
    `normal_balance` STRING COMMENT 'Indicates whether the account normally carries a debit or credit balance.',
    `posting_restriction` STRING COMMENT 'Controls the posting permissions for the account.',
    `profit_center_code` STRING COMMENT 'Profit center linked to the GL account for profitability analysis.',
    `segment_code` STRING COMMENT 'Reporting segment identifier associated with the GL account.',
    `chart_of_accounts_status` STRING COMMENT 'Current lifecycle status of the GL account.',
    `tax_code` STRING COMMENT 'Tax code associated with the GL account for tax determination.',
    `tax_relevant` BOOLEAN COMMENT 'Indicates whether the account is considered in tax calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the GL account record.',
    CONSTRAINT pk_chart_of_accounts PRIMARY KEY(`chart_of_accounts_id`)
) COMMENT 'Master reference table for chart_of_accounts. Referenced by chart_of_accounts_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`controlling_area` (
    `controlling_area_id` BIGINT COMMENT 'Primary key for controlling_area',
    `parent_controlling_area_id` BIGINT COMMENT 'Self-referencing FK on controlling_area (parent_controlling_area_id)',
    `area_code` STRING COMMENT 'Business identifier code for the controlling area as used in SAP.',
    `area_description` STRING COMMENT 'Longer textual description of the controlling area.',
    `area_name` STRING COMMENT 'Descriptive name of the controlling area.',
    `area_type` STRING COMMENT 'Indicates whether the area is used for cost, profit, or both controlling.',
    `chart_of_accounts` STRING COMMENT 'Key of the chart of accounts assigned to the controlling area.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was initially created in the source system.',
    `currency` STRING COMMENT 'Default currency for the controlling area.',
    `effective_from` DATE COMMENT 'Date when the controlling area became effective.',
    `effective_to` DATE COMMENT 'Date when the controlling area ceases to be effective (nullable).',
    `fiscal_year_variant` STRING COMMENT 'Fiscal year variant used for period accounting in this controlling area.',
    `is_budgeting_enabled` BOOLEAN COMMENT 'Flag indicating if budgeting functionality is enabled for the controlling area.',
    `is_consolidation_enabled` BOOLEAN COMMENT 'Flag indicating if financial consolidation processes include this controlling area.',
    `is_cost_object_active` BOOLEAN COMMENT 'Indicates whether cost objects (e.g., cost centers) are active within this area.',
    `is_intercompany_allowed` BOOLEAN COMMENT 'Flag indicating if intercompany postings are permitted in this controlling area.',
    `is_multi_currency` BOOLEAN COMMENT 'Indicates support for multiple currencies within the controlling area.',
    `is_plant_related` BOOLEAN COMMENT 'Indicates whether plant cost accounting is linked to this controlling area.',
    `is_profit_center_active` BOOLEAN COMMENT 'Indicates whether profit centers are active within this area.',
    `is_reporting_enabled` BOOLEAN COMMENT 'Flag indicating if standard controlling reports are generated for this area.',
    `is_sales_org_linked` BOOLEAN COMMENT 'Indicates whether a sales organization is associated with this controlling area.',
    `is_service_org_linked` BOOLEAN COMMENT 'Indicates whether a service organization is associated with this controlling area.',
    `is_tax_enabled` BOOLEAN COMMENT 'Flag indicating if tax calculation is performed at the controlling area level.',
    `controlling_area_status` STRING COMMENT 'Current lifecycle status of the controlling area.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_controlling_area PRIMARY KEY(`controlling_area_id`)
) COMMENT 'Master reference table for controlling_area. Referenced by controlling_area_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`functional_area` (
    `functional_area_id` BIGINT COMMENT 'Primary key for functional_area',
    `parent_functional_area_id` BIGINT COMMENT 'Self‑reference to the parent functional area for hierarchical grouping.',
    `abbr_name` STRING COMMENT 'Short abbreviation or alias for the functional area name.',
    `audit_status` STRING COMMENT 'Current status of the audit process for this functional area.',
    `budget_owner` STRING COMMENT 'Name or identifier of the person or team responsible for the functional area budget.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the functional area record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the functional area becomes effective for reporting.',
    `effective_until` DATE COMMENT 'Date when the functional area ceases to be effective; null if open‑ended.',
    `external_system_code` STRING COMMENT 'Identifier of the functional area in external ERP or reporting systems.',
    `financial_reporting_code` STRING COMMENT 'Code used in financial reporting extracts to map transactions to this functional area.',
    `functional_area_category` STRING COMMENT 'High‑level business category grouping the functional area.',
    `functional_area_code` STRING COMMENT 'Alphanumeric code used to uniquely identify a functional area within finance.',
    `functional_area_description` STRING COMMENT 'Longer textual description providing context and scope of the functional area.',
    `functional_area_name` STRING COMMENT 'Descriptive name of the functional area, e.g., Accounts Payable, Cost Accounting.',
    `hierarchy_level` STRING COMMENT 'Depth level of the functional area within the hierarchy (0 = top level).',
    `is_audited` BOOLEAN COMMENT 'Indicates whether the functional area is subject to internal audit.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this functional area is a primary classification within finance.',
    `last_review_date` DATE COMMENT 'Date when the functional area definition was last reviewed for accuracy.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the functional area.',
    `review_frequency_months` STRING COMMENT 'Number of months between mandatory reviews of the functional area definition.',
    `functional_area_status` STRING COMMENT 'Current lifecycle status of the functional area.',
    `updated_by` STRING COMMENT 'Identifier of the user or process that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the functional area record.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the record.',
    CONSTRAINT pk_functional_area PRIMARY KEY(`functional_area_id`)
) COMMENT 'Master reference table for functional_area. Referenced by functional_area_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`cost_element` (
    `cost_element_id` BIGINT COMMENT 'Primary key for cost_element',
    `parent_cost_element_id` BIGINT COMMENT 'Identifier of the parent cost element in a hierarchical relationship.',
    `allocation_method` STRING COMMENT 'Method used to allocate costs from this element to cost objects.',
    `cost_element_code` STRING COMMENT 'Unique alphanumeric code that identifies the cost element in financial transactions.',
    `cost_center_code` STRING COMMENT 'Code of the cost center to which this cost element is primarily allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost element record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values of the cost element.',
    `default_amount` DECIMAL(18,2) COMMENT 'Standard monetary amount associated with the cost element for budgeting and planning.',
    `cost_element_description` STRING COMMENT 'Detailed description of the cost element, its purpose and usage guidelines.',
    `effective_from` DATE COMMENT 'Date when the cost element becomes valid for financial posting.',
    `effective_to` DATE COMMENT 'Date when the cost element ceases to be valid (null if open‑ended).',
    `external_system_code` STRING COMMENT 'Identifier of the cost element in an external ERP or budgeting system.',
    `financial_reporting_code` STRING COMMENT 'Code used by finance systems for reporting aggregation.',
    `hierarchy_level` STRING COMMENT 'Numeric level indicating the position of the cost element within a hierarchical cost structure.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether the cost element is subject to tax.',
    `cost_element_name` STRING COMMENT 'Human‑readable name of the cost element used in reports and UI.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the cost element.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the cost element must be disclosed in regulatory filings.',
    `reporting_category` STRING COMMENT 'Category used for financial reporting and analysis (e.g., EBITDA, CAPEX).',
    `cost_element_status` STRING COMMENT 'Current lifecycle state of the cost element.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate (percentage) when the cost element is taxable.',
    `cost_element_type` STRING COMMENT 'Category of the cost element indicating its nature (e.g., direct, indirect, overhead, capital, operating).',
    `updated_by` STRING COMMENT 'User identifier who last modified the cost element record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cost element record.',
    `version_number` STRING COMMENT 'Version of the cost element definition for change management.',
    `created_by` STRING COMMENT 'User identifier who created the cost element record.',
    CONSTRAINT pk_cost_element PRIMARY KEY(`cost_element_id`)
) COMMENT 'Master reference table for cost_element. Referenced by cost_element_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`commitment_item` (
    `commitment_item_id` BIGINT COMMENT 'Primary key for commitment_item',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational department owning the commitment.',
    `capital_project_id` BIGINT COMMENT 'Identifier of the project associated with the commitment.',
    `vendor_id` BIGINT COMMENT 'Identifier of the external vendor or supplier linked to the commitment.',
    `parent_commitment_item_id` BIGINT COMMENT 'Self-referencing FK on commitment_item (parent_commitment_item_id)',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the commitment in the specified currency.',
    `approval_status` STRING COMMENT 'Current status of the commitments approval workflow.',
    `approved_date` DATE COMMENT 'Date on which the commitment was formally approved.',
    `commitment_number` STRING COMMENT 'External business identifier assigned to the commitment, used in contracts and reporting.',
    `commitment_type` STRING COMMENT 'Classification of the commitment by financial nature (e.g., capital expenditure, operating expense).',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier responsible for the commitment expense.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency of the commitment amount.',
    `commitment_item_description` STRING COMMENT 'Free‑text description providing context and details about the commitment.',
    `effective_from` DATE COMMENT 'Date on which the commitment becomes binding.',
    `effective_until` DATE COMMENT 'Date on which the commitment ends or expires; null for open‑ended commitments.',
    `fiscal_period` STRING COMMENT 'Quarter of the fiscal year for the commitment.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the commitment is booked.',
    `is_recurring` BOOLEAN COMMENT 'Flag indicating whether the commitment recurs on a regular schedule.',
    `payment_terms` STRING COMMENT 'Standard payment condition applied to the commitment.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the commitment record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the commitment record.',
    `renewal_term_months` STRING COMMENT 'Number of months for the renewal period when the commitment is recurring.',
    `commitment_item_status` STRING COMMENT 'Current lifecycle state of the commitment item.',
    CONSTRAINT pk_commitment_item PRIMARY KEY(`commitment_item_id`)
) COMMENT 'Master reference table for commitment_item. Referenced by commitment_item_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`performance_obligation` (
    `performance_obligation_id` BIGINT COMMENT 'Primary key for performance_obligation',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer or internal account linked to the obligation.',
    `sales_contract_id` BIGINT COMMENT 'Identifier of the parent contract or master agreement to which this obligation belongs.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `offering_id` BIGINT COMMENT 'Identifier of the product or service that the obligation pertains to.',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `svc_instance_id` BIGINT COMMENT 'Identifier of the specific service component covered by the obligation.',
    `parent_performance_obligation_id` BIGINT COMMENT 'Self-referencing FK on performance_obligation (parent_performance_obligation_id)',
    `actual_value` DECIMAL(18,2) COMMENT 'Measured value of the performance metric to date.',
    `amendment_flag` BOOLEAN COMMENT 'Indicates whether the obligation has been amended after initial creation.',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment applied to the obligation.',
    `billing_frequency` STRING COMMENT 'How often the obligation is billed to the customer.',
    `compliance_indicator` STRING COMMENT 'Indicates whether the obligation complies with relevant financial or regulatory rules.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance obligation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which total_amount is expressed.',
    `performance_obligation_description` STRING COMMENT 'Free‑text description of the performance obligation, including scope and key terms.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the total amount.',
    `effective_from` DATE COMMENT 'Date on which the performance obligation becomes binding.',
    `effective_until` DATE COMMENT 'Date on which the performance obligation expires or is terminated; null for open‑ended obligations.',
    `measurement_period_end` DATE COMMENT 'End date of the measurement period for the performance metric.',
    `measurement_period_start` DATE COMMENT 'Start date of the measurement period for the performance metric.',
    `measurement_unit` STRING COMMENT 'Unit of measure associated with target_value and actual_value (e.g., GB, minutes).',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the performance obligation.',
    `obligation_number` STRING COMMENT 'External business number or code assigned to the performance obligation by the contracting party.',
    `obligation_type` STRING COMMENT 'Category of the performance obligation indicating the nature of the deliverable.',
    `performance_metric` STRING COMMENT 'Metric used to measure fulfillment of the obligation.',
    `performance_obligation_status_detail` STRING COMMENT 'Detailed status indicating progress against the obligation.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units covered by the performance obligation.',
    `recognized_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue amount that has been recognized against the obligation to date.',
    `recognized_revenue_date` DATE COMMENT 'Date on which the most recent revenue was recognized.',
    `remaining_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the obligation that has not yet been recognized as revenue.',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Quantity of the obligation that remains to be delivered or measured.',
    `renewal_date` DATE COMMENT 'Scheduled date for the renewal of the performance obligation.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the obligation is set for automatic renewal.',
    `revenue_recognition_method` STRING COMMENT 'Method used to recognize revenue for the obligation.',
    `revenue_recognition_schedule` STRING COMMENT 'Narrative or code describing the schedule for revenue recognition.',
    `revenue_recognition_status` STRING COMMENT 'Current status of revenue recognition for the obligation.',
    `performance_obligation_status` STRING COMMENT 'Current lifecycle state of the performance obligation.',
    `target_value` DECIMAL(18,2) COMMENT 'Planned value for the performance metric that must be achieved.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax amount calculated for the obligation.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate (percentage) for the obligation.',
    `termination_date` DATE COMMENT 'Date on which the performance obligation was terminated.',
    `termination_reason` STRING COMMENT 'Reason code or description for why the obligation was terminated.',
    `total_amount` DECIMAL(18,2) COMMENT 'Monetary value representing the total consideration promised under the obligation.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of the obligation quantity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the performance obligation record.',
    CONSTRAINT pk_performance_obligation PRIMARY KEY(`performance_obligation_id`)
) COMMENT 'Master reference table for performance_obligation. Referenced by performance_obligation_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key for payment_run',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for initiating or overseeing the run.',
    `reversal_payment_run_id` BIGINT COMMENT 'Self-referencing FK on payment_run (reversal_payment_run_id)',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the run finished processing.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Real start date‑time when the run began processing.',
    `approval_status` STRING COMMENT 'Current approval state of the run before execution.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the payment run was approved for execution.',
    `batch_reference` STRING COMMENT 'Identifier from an external banking or clearing house batch that corresponds to this run.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center code to which the runs expenses are charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the run (e.g., USD, EUR).',
    `payment_run_description` STRING COMMENT 'Free‑form text describing the purpose or special notes for the payment run.',
    `error_flag` BOOLEAN COMMENT 'Indicates whether the run completed with errors (true) or without (false).',
    `error_message` STRING COMMENT 'Detailed error description when error_flag is true.',
    `external_reference_code` STRING COMMENT 'Identifier linking the run to an external system such as a bank or clearing house.',
    `number_of_payments` STRING COMMENT 'Total count of individual payment transactions included in the run.',
    `payment_channel` STRING COMMENT 'Technical channel through which the run was executed.',
    `payment_method` STRING COMMENT 'Primary instrument used for the payments in the run.',
    `priority` STRING COMMENT 'Business priority assigned to the run for scheduling and monitoring.',
    `processing_system` STRING COMMENT 'Source system that generated and processed the payment run (e.g., SAP S/4HANA Finance).',
    `run_number` STRING COMMENT 'Human‑readable identifier or code assigned to the payment run by the finance system.',
    `run_type` STRING COMMENT 'Indicates whether the run is scheduled periodic, ad‑hoc, or a reversal operation.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start date‑time for the payment run as defined in the payment schedule.',
    `settlement_date` DATE COMMENT 'Date on which the financial settlement of the run is recorded.',
    `settlement_status` STRING COMMENT 'Status of the financial settlement after the run has completed.',
    `payment_run_status` STRING COMMENT 'Current processing state of the payment run.',
    `total_adjustments_amount` DECIMAL(18,2) COMMENT 'Aggregate of taxes, fees, discounts, or other adjustments applied to the gross total.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Sum of all payment amounts before any adjustments, expressed in the run currency.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Net amount payable after adjustments, the amount actually transferred.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment run record.',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Master reference table for payment_run. Referenced by payment_run_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
    `parent_legal_entity_id` BIGINT COMMENT 'Identifier of the parent organization, if this entity is a subsidiary or part of a corporate group.',
    `audit_status` STRING COMMENT 'Current status of the most recent financial audit.',
    `business_unit` STRING COMMENT 'Internal business unit or division to which the entity belongs.',
    `city_of_incorporation` STRING COMMENT 'City where the legal entity was incorporated.',
    `classification` STRING COMMENT 'Business classification indicating the entitys relationship to the enterprise.',
    `compliance_status` STRING COMMENT 'Overall compliance standing with regulatory requirements.',
    `cost_center_code` STRING COMMENT 'Cost center identifier used for internal expense allocation.',
    `country_of_incorporation` STRING COMMENT 'Three‑letter ISO country code where the entity was incorporated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the legal entity record was first created.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit exposure approved for the entity.',
    `credit_rating` STRING COMMENT 'External credit rating assigned to the entity. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D — promote to reference product]',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for reporting the entitys financials.',
    `data_classification` STRING COMMENT 'Classification level governing data handling and access.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the entity.',
    `effective_date` DATE COMMENT 'Date when the legal entity became operationally effective.',
    `ein` STRING COMMENT 'U.S. federal tax identifier for the organization.',
    `financial_year_end_month` STRING COMMENT 'Numeric month (1‑12) that marks the end of the entitys fiscal year.',
    `industry_code` STRING COMMENT 'Standard industry code (e.g., NAICS or SIC) describing the entitys primary business.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether the entity is subject to corporate tax.',
    `legal_address` STRING COMMENT 'Primary registered address of the legal entity.',
    `legal_entity_description` STRING COMMENT 'Free‑form description providing additional context about the entity.',
    `legal_entity_type` STRING COMMENT 'Category describing the legal form of the organization.',
    `legal_name` STRING COMMENT 'The full registered legal name of the organization.',
    `mailing_address` STRING COMMENT 'Postal address used for correspondence.',
    `primary_contact_email` STRING COMMENT 'Email address of the main contact person.',
    `primary_contact_name` STRING COMMENT 'Name of the main contact person for the legal entity.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the main contact person.',
    `registration_date` DATE COMMENT 'Date when the entity was officially registered with the governing authority.',
    `registration_number` STRING COMMENT 'Official government registration identifier for the legal entity.',
    `state_of_incorporation` STRING COMMENT 'Two‑letter code of the state or province of incorporation.',
    `legal_entity_status` STRING COMMENT 'Current operational status of the legal entity.',
    `tax_exempt_status` STRING COMMENT 'Indicates whether the entity is exempt from certain taxes.',
    `tax_identifier` STRING COMMENT 'Tax authority identifier used for corporate tax reporting.',
    `tax_residency_country` STRING COMMENT 'Country of tax residence for corporate tax purposes.',
    `termination_date` DATE COMMENT 'Date when the legal entity ceased operations or was dissolved.',
    `trade_name` STRING COMMENT 'The brand or doing‑business‑as name used in the market.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the legal entity record.',
    `vat_number` STRING COMMENT 'VAT registration number for cross‑border tax compliance.',
    `website_url` STRING COMMENT 'Public website address of the legal entity.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master reference table for legal_entity. Referenced by legal_entity_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `telecommunication_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `telecommunication_ecm`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_functional_area_id` FOREIGN KEY (`functional_area_id`) REFERENCES `telecommunication_ecm`.`finance`.`functional_area`(`functional_area_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_house_bank_id` FOREIGN KEY (`house_bank_id`) REFERENCES `telecommunication_ecm`.`finance`.`house_bank`(`house_bank_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `telecommunication_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `telecommunication_ecm`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `telecommunication_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `telecommunication_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `telecommunication_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `telecommunication_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `telecommunication_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `telecommunication_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `telecommunication_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ADD CONSTRAINT `fk_finance_vendor_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `telecommunication_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ADD CONSTRAINT `fk_finance_vendor_payment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ADD CONSTRAINT `fk_finance_vendor_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ADD CONSTRAINT `fk_finance_vendor_payment_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `telecommunication_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ADD CONSTRAINT `fk_finance_vendor_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ADD CONSTRAINT `fk_finance_vendor_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `telecommunication_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ADD CONSTRAINT `fk_finance_vendor_payment_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `telecommunication_ecm`.`finance`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `telecommunication_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ADD CONSTRAINT `fk_finance_purchase_order_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ADD CONSTRAINT `fk_finance_purchase_order_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `telecommunication_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_allocation_cycle_id` FOREIGN KEY (`allocation_cycle_id`) REFERENCES `telecommunication_ecm`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_allocation_rule_id` FOREIGN KEY (`allocation_rule_id`) REFERENCES `telecommunication_ecm`.`finance`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `telecommunication_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_original_allocation_cost_allocation_id` FOREIGN KEY (`original_allocation_cost_allocation_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ADD CONSTRAINT `fk_finance_financial_consolidation_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `telecommunication_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_cash_pool_id` FOREIGN KEY (`cash_pool_id`) REFERENCES `telecommunication_ecm`.`finance`.`cash_pool`(`cash_pool_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_house_bank_id` FOREIGN KEY (`house_bank_id`) REFERENCES `telecommunication_ecm`.`finance`.`house_bank`(`house_bank_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ADD CONSTRAINT `fk_finance_bank_statement_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `telecommunication_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ADD CONSTRAINT `fk_finance_bank_statement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ADD CONSTRAINT `fk_finance_bank_statement_house_bank_id` FOREIGN KEY (`house_bank_id`) REFERENCES `telecommunication_ecm`.`finance`.`house_bank`(`house_bank_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `telecommunication_ecm`.`finance`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_transferred_from_accounts_receivable_id` FOREIGN KEY (`transferred_from_accounts_receivable_id`) REFERENCES `telecommunication_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `telecommunication_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_original_recognition_revenue_recognition_id` FOREIGN KEY (`original_recognition_revenue_recognition_id`) REFERENCES `telecommunication_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `telecommunication_ecm`.`finance`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_prior_estimate_revenue_recognition_id` FOREIGN KEY (`prior_estimate_revenue_recognition_id`) REFERENCES `telecommunication_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` ADD CONSTRAINT `fk_finance_budget_allocation_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `telecommunication_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ADD CONSTRAINT `fk_finance_finance_project_assignment_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ADD CONSTRAINT `fk_finance_budget_approval_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `telecommunication_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`payment_plan` ADD CONSTRAINT `fk_finance_payment_plan_restructured_from_payment_plan_id` FOREIGN KEY (`restructured_from_payment_plan_id`) REFERENCES `telecommunication_ecm`.`finance`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`cash_pool` ADD CONSTRAINT `fk_finance_cash_pool_parent_cash_pool_id` FOREIGN KEY (`parent_cash_pool_id`) REFERENCES `telecommunication_ecm`.`finance`.`cash_pool`(`cash_pool_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ADD CONSTRAINT `fk_finance_house_bank_parent_house_bank_id` FOREIGN KEY (`parent_house_bank_id`) REFERENCES `telecommunication_ecm`.`finance`.`house_bank`(`house_bank_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_prior_allocation_cycle_id` FOREIGN KEY (`prior_allocation_cycle_id`) REFERENCES `telecommunication_ecm`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`allocation_rule` ADD CONSTRAINT `fk_finance_allocation_rule_parent_allocation_rule_id` FOREIGN KEY (`parent_allocation_rule_id`) REFERENCES `telecommunication_ecm`.`finance`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ADD CONSTRAINT `fk_finance_vendor_parent_vendor_id` FOREIGN KEY (`parent_vendor_id`) REFERENCES `telecommunication_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `telecommunication_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_guarantor_legal_entity_id` FOREIGN KEY (`guarantor_legal_entity_id`) REFERENCES `telecommunication_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `telecommunication_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `telecommunication_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_renewed_from_lease_contract_id` FOREIGN KEY (`renewed_from_lease_contract_id`) REFERENCES `telecommunication_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_parent_chart_of_accounts_id` FOREIGN KEY (`parent_chart_of_accounts_id`) REFERENCES `telecommunication_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`controlling_area` ADD CONSTRAINT `fk_finance_controlling_area_parent_controlling_area_id` FOREIGN KEY (`parent_controlling_area_id`) REFERENCES `telecommunication_ecm`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`functional_area` ADD CONSTRAINT `fk_finance_functional_area_parent_functional_area_id` FOREIGN KEY (`parent_functional_area_id`) REFERENCES `telecommunication_ecm`.`finance`.`functional_area`(`functional_area_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_element` ADD CONSTRAINT `fk_finance_cost_element_parent_cost_element_id` FOREIGN KEY (`parent_cost_element_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`commitment_item` ADD CONSTRAINT `fk_finance_commitment_item_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`commitment_item` ADD CONSTRAINT `fk_finance_commitment_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `telecommunication_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`commitment_item` ADD CONSTRAINT `fk_finance_commitment_item_parent_commitment_item_id` FOREIGN KEY (`parent_commitment_item_id`) REFERENCES `telecommunication_ecm`.`finance`.`commitment_item`(`commitment_item_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_parent_performance_obligation_id` FOREIGN KEY (`parent_performance_obligation_id`) REFERENCES `telecommunication_ecm`.`finance`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_reversal_payment_run_id` FOREIGN KEY (`reversal_payment_run_id`) REFERENCES `telecommunication_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `telecommunication_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `telecommunication_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO) ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `functional_area_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Area ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `house_bank_id` SET TAGS ('dbx_business_glossary_term' = 'House Bank ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_name_long` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Long Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_name_short` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Short Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending_closure');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense|statistical');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_business_glossary_term' = 'Alternative General Ledger (GL) Account Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `balance_sheet_account_type` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Account Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `balance_sheet_account_type` SET TAGS ('dbx_value_regex' = 'current_asset|fixed_asset|current_liability|long_term_liability|equity|not_applicable');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `cash_flow_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Relevant Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `field_status_group` SET TAGS ('dbx_business_glossary_term' = 'Field Status Group');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `financial_statement_item` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Item');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `inflation_key` SET TAGS ('dbx_business_glossary_term' = 'Inflation Key');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `interest_indicator` SET TAGS ('dbx_business_glossary_term' = 'Interest Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `line_item_display_flag` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `open_item_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `planning_level` SET TAGS ('dbx_business_glossary_term' = 'Planning Level');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `posting_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Block Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `profit_center_update_flag` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Update Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `profit_loss_account_type` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Account Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `profit_loss_account_type` SET TAGS ('dbx_value_regex' = 'primary_cost|secondary_cost|revenue|other');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `reconciliation_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `sample_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Sample Account Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `segment_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Segment Reporting Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Sort Key');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `tolerance_group` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Group');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`general_ledger` ALTER COLUMN `valuation_group` SET TAGS ('dbx_business_glossary_term' = 'Valuation Group');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `group_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `group_currency` SET TAGS ('dbx_business_glossary_term' = 'Group Currency');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `group_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_partner` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Partner');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `internal_order` SET TAGS ('dbx_business_glossary_term' = 'Internal Order');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|parked|cleared|reversed');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_user` SET TAGS ('dbx_business_glossary_term' = 'Posting User ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_key` SET TAGS ('dbx_business_glossary_term' = 'Reference Key');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `text_description` SET TAGS ('dbx_business_glossary_term' = 'Text Description');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Transaction Currency');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `asset_subnumber` SET TAGS ('dbx_business_glossary_term' = 'Asset Subnumber');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `asset_subnumber` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `customer_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `customer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_status` SET TAGS ('dbx_business_glossary_term' = 'Line Item Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_status` SET TAGS ('dbx_value_regex' = 'open|cleared|parked|blocked');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `partner_profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Profit Center Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `partner_profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `special_gl_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special General Ledger (GL) Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `special_gl_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount in Local Currency');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `text_description` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text Description');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,24}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Type Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) / Operational Expenditure (OPEX) Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX|MIXED');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `committed_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `committed_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|indirect|activity_based|percentage|driver_based');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'production|service|administration|sales|research_development|support');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|planned');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'operational|capital|shared_service|overhead|revenue_generating');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_element_group_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Group Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_element_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `is_locked_for_posting` SET TAGS ('dbx_business_glossary_term' = 'Is Locked for Posting');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `is_statistical` SET TAGS ('dbx_business_glossary_term' = 'Is Statistical');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `planning_group_code` SET TAGS ('dbx_business_glossary_term' = 'Planning Group Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `planning_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO) ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `arpu_target` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per User (ARPU) Target');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `arpu_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `business_segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `business_segment` SET TAGS ('dbx_value_regex' = 'consumer_mobile|consumer_fixed|enterprise_b2b|wholesale_interconnect|content_iptv|iot_m2m');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `capex_budget` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Budget');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `capex_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `ebitda_target` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Target');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `ebitda_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'north_america|south_america|europe|asia_pacific|middle_east|africa');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `is_consolidation_relevant` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Relevant Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `is_intercompany_enabled` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `opex_budget` SET TAGS ('dbx_business_glossary_term' = 'Operational Expenditure (OPEX) Budget');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `opex_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_group` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Group');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'product_line|geographic_region|customer_segment|service_type|channel|cost_center');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|subscription|usage_based|hybrid');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Short Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'cost_plus|market_price|negotiated|standard_cost|not_applicable');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'cash_operations');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Project ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_value` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Value');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_value_regex' = 'tangible|intangible|right_of_use');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'in_service|under_construction|retired|disposed|transferred|impaired');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_sub_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Sub-Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_sub_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_value_regex' = 'book_depreciation|tax_depreciation|ifrs_depreciation|gaap_depreciation|management_reporting');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_value` SET TAGS ('dbx_business_glossary_term' = 'Disposal Value');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_date` SET TAGS ('dbx_business_glossary_term' = 'Impairment Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `is_leased` SET TAGS ('dbx_business_glossary_term' = 'Is Leased');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `revaluation_amount` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `revaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Transaction ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'User ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_subnumber` SET TAGS ('dbx_business_glossary_term' = 'Asset Subnumber');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_subnumber` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_value_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Value Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `gain_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Gain or Loss Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `gl_account` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `internal_order` SET TAGS ('dbx_business_glossary_term' = 'Internal Order');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `internal_order` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `offset_account` SET TAGS ('dbx_business_glossary_term' = 'Offset Account');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `offset_account` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Transaction Quantity');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `reference_document` SET TAGS ('dbx_business_glossary_term' = 'Reference Document');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `reference_key` SET TAGS ('dbx_business_glossary_term' = 'Reference Key');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `reference_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `retirement_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Retirement Proceeds');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_value_regex' = 'sale|scrap|donation|theft|obsolescence|transfer');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_text` SET TAGS ('dbx_business_glossary_term' = 'Transaction Text');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'acquisition|retirement|transfer|depreciation|revaluation|write_down');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,24}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Target Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `actual_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual To Date Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `actual_to_date_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `available_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Budget Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `available_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) / Operational Expenditure (OPEX) Category');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'capex|opex|mixed');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_control_level` SET TAGS ('dbx_business_glossary_term' = 'Budget Control Level');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_control_level` SET TAGS ('dbx_value_regex' = 'advisory|warning|blocking');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_owner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `commitment_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Commitment Tracking Enabled');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Level');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_value_regex' = 'entity|business_unit|division|corporate');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `is_baseline` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Budget');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Notes');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^BP-[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'annual|multi_year|quarterly|project_based|rolling_forecast|supplemental');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `planning_horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `planning_horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `planning_method` SET TAGS ('dbx_business_glossary_term' = 'Budget Planning Method');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `planning_method` SET TAGS ('dbx_value_regex' = 'top_down|bottom_up|zero_based|incremental|activity_based');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `reforecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Reforecast Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `reforecast_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `reforecast_date` SET TAGS ('dbx_business_glossary_term' = 'Reforecast Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `total_planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `total_planned_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `variance_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `variance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|actual');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Manager ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'Direct|Allocated|Distributed|Transferred');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX|Revenue|Other');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_control_level` SET TAGS ('dbx_business_glossary_term' = 'Budget Control Level');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_control_level` SET TAGS ('dbx_value_regex' = 'Advisory|Warning|Blocking');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'Draft|Approved|Active|Frozen|Closed|Cancelled');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'Annual|Quarterly|Monthly|Project|Supplemental');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `carryforward_amount` SET TAGS ('dbx_business_glossary_term' = 'Carryforward Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `carryforward_eligible` SET TAGS ('dbx_business_glossary_term' = 'Carryforward Eligible');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `fund_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `reduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Reduction Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `supplemental_amount` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.-]{4,24}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `cash_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `cash_discount_date` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) / Operational Expenditure (OPEX) Category');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `expense_category` SET TAGS ('dbx_value_regex' = 'capex|opex');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|recurring|milestone');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `payment_block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|electronic_funds_transfer|virtual_card');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partial_match|variance_within_tolerance|variance_exceeds_tolerance');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `vendor_bank_account` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Account Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `vendor_bank_account` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `vendor_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Payment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `cash_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Approval Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire_transfer|check|electronic_funds_transfer|credit_card|direct_debit');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_processor_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|cleared|cancelled|failed|reversed');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` SET TAGS ('dbx_subdomain' = 'cash_operations');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `collective_number` SET TAGS ('dbx_business_glossary_term' = 'Collective Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `commitment_value` SET TAGS ('dbx_business_glossary_term' = 'Commitment Value');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `gl_account` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `gr_based_invoice_verification` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Based Invoice Verification');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `net_value` SET TAGS ('dbx_business_glossary_term' = 'Net Value');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `plant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|subcontracting|consignment|stock_transfer|service|framework');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `quotation_number` SET TAGS ('dbx_business_glossary_term' = 'Quotation Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `release_strategy` SET TAGS ('dbx_business_glossary_term' = 'Release Strategy');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `requisitioner` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_instructions` SET TAGS ('dbx_business_glossary_term' = 'Shipping Instructions');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Value');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` SET TAGS ('dbx_subdomain' = 'cash_operations');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `contract_line_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `expenditure_type` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) / Operational Expenditure (OPEX) Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `expenditure_type` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `final_invoice_indicator` SET TAGS ('dbx_business_glossary_term' = 'Final Invoice Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `item_category_code` SET TAGS ('dbx_business_glossary_term' = 'Item Category Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Item Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|closed|cancelled');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `line_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `open_quantity` SET TAGS ('dbx_business_glossary_term' = 'Open Quantity');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `purchase_requisition_line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Line Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `purchase_requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `quantity_invoiced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Invoiced');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct_charge|cost_allocation|revenue_share|usage_based|fixed_fee');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) / Operational Expenditure (OPEX) Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_date` SET TAGS ('dbx_business_glossary_term' = 'Elimination Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Elimination Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_value_regex' = 'not_eliminated|pending_elimination|eliminated|partial_elimination');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency` SET TAGS ('dbx_business_glossary_term' = 'Group Currency');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_receiving` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Receiving');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_receiving` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_sending` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Sending');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_sending` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Receiving Cost Center');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_reference` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Reference');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|matched|mismatched|under_investigation|resolved');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Variance Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Company Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Sending Cost Center');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_value_regex' = '^ICT-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'shared_service_charge|management_fee|intercompany_loan|roaming_settlement|infrastructure_cost_share|royalty_payment');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'comparable_uncontrolled_price|resale_price|cost_plus|profit_split|transactional_net_margin');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `company_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `original_allocation_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Original Allocation ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Cost Center ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Profit Center ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `element_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,16}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'User ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `user_employee_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `activity_quantity` SET TAGS ('dbx_business_glossary_term' = 'Activity Quantity');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `activity_rate` SET TAGS ('dbx_business_glossary_term' = 'Activity Rate');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Type Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_description` SET TAGS ('dbx_business_glossary_term' = 'Allocation Description');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_document_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Run Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|error|cancelled');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'assessment|distribution|periodic_repost|settlement|overhead_allocation');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `business_segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) / Operational Expenditure (OPEX) Category');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'OPEX|CAPEX');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `statistical_key_figure_code` SET TAGS ('dbx_business_glossary_term' = 'Statistical Key Figure Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `statistical_key_figure_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ALTER COLUMN `statistical_key_figure_value` SET TAGS ('dbx_business_glossary_term' = 'Statistical Key Figure Value');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `business_area_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Business Area Required Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA)');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_business_glossary_term' = 'Company Code Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_activation|closed');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Company Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `company_name_short` SET TAGS ('dbx_business_glossary_term' = 'Company Short Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `company_type` SET TAGS ('dbx_business_glossary_term' = 'Company Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `company_type` SET TAGS ('dbx_value_regex' = 'operating_company|subsidiary|joint_venture|holding_company|branch|representative_office');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `cost_of_sales_accounting_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cost of Sales Accounting Indicator');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_business_glossary_term' = 'Credit Control Area');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `field_status_variant` SET TAGS ('dbx_business_glossary_term' = 'Field Status Variant');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `field_status_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `financial_statement_version` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Version');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `legal_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI)');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `legal_entity_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `maximum_exchange_rate_deviation` SET TAGS ('dbx_business_glossary_term' = 'Maximum Exchange Rate Deviation Percentage');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `parent_company_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `parent_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `posting_period_variant` SET TAGS ('dbx_business_glossary_term' = 'Posting Period Variant');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `posting_period_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `profit_center_standard_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Standard Hierarchy');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`company_code` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `financial_consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Consolidation ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `analytical_subject_area_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Subject Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By User ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'IFRS|US_GAAP|LOCAL_GAAP');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `audit_opinion` SET TAGS ('dbx_business_glossary_term' = 'Audit Opinion');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `audit_opinion` SET TAGS ('dbx_value_regex' = 'unqualified|qualified|adverse|disclaimer');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|certified');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `capex_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Consolidated');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `consolidation_currency` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Currency');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `consolidation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_value_regex' = 'direct|step_acquisition|simultaneous');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `consolidation_notes` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Notes');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `consolidation_number` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `consolidation_number` SET TAGS ('dbx_value_regex' = '^CONS-[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `consolidation_scope` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Scope');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `consolidation_scope` SET TAGS ('dbx_value_regex' = 'full|partial|equity_method|proportionate');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `consolidation_status` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `consolidation_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|review|approved|published|closed');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `consolidation_type` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `consolidation_type` SET TAGS ('dbx_value_regex' = 'statutory|management|regulatory|tax|segment');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `currency_translation_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Currency Translation Adjustment');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `ebitda_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Consolidated');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `filing_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `filing_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Submission Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `goodwill_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Goodwill Consolidated');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `intangible_assets_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Intangible Assets Consolidated');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `intercompany_elimination_amount` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `minority_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Minority Interest Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `net_income_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Net Income Consolidated');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `number_of_entities_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Number of Entities Consolidated');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `opex_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Operational Expenditure (OPEX) Consolidated');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `parent_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `parent_entity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `total_assets_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Total Assets Consolidated');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `total_equity_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Total Equity Consolidated');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `total_liabilities_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Total Liabilities Consolidated');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `total_operating_expenses_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Total Operating Expenses Consolidated');
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ALTER COLUMN `total_revenue_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Consolidated');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `network_rollout_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Network Rollout Zone Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `primary_capital_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `primary_capital_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `primary_capital_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Target Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Project Approval Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `auc_asset_number` SET TAGS ('dbx_business_glossary_term' = 'Assets under Construction (AuC) Asset Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `auc_asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `budget_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `budget_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `committed_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `environmental_impact_assessment_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment Required Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `forecast_final_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast Final Cost Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `functional_area` SET TAGS ('dbx_value_regex' = 'network_operations|network_engineering|it_infrastructure|finance|procurement|facilities');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `investment_category` SET TAGS ('dbx_business_glossary_term' = 'Investment Category');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `irr_percentage` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR) Percentage');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `irr_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Project Notes');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `npv_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `npv_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `payback_period_months` SET TAGS ('dbx_business_glossary_term' = 'Payback Period (Months)');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `planned_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `project_definition_code` SET TAGS ('dbx_business_glossary_term' = 'Project Definition Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `project_definition_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'network_infrastructure|spectrum_acquisition|data_center|oss_bss_platform|customer_premises_equipment|fiber_deployment');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `roi_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Target Percentage');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `settlement_profile` SET TAGS ('dbx_business_glossary_term' = 'Settlement Profile');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `settlement_profile` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `technology_domain` SET TAGS ('dbx_business_glossary_term' = 'Technology Domain');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `wbs_root_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Root Element');
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ALTER COLUMN `wbs_root_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,16}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_posting_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `base_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Base Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Clearing Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Document Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `local_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Base Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `local_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `local_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Tax Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|posted|cleared|reversed|parked');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `posting_user` SET TAGS ('dbx_business_glossary_term' = 'Posting User Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_exemption_certificate` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_exemption_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Indicator Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Period');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_return_reference` SET TAGS ('dbx_business_glossary_term' = 'Tax Return Reference Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_return_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Return Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_return_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|amended|closed');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'input_tax|output_tax|withholding_tax|use_tax|reverse_charge|import_tax');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `text_description` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Description');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'comparable_uncontrolled_price|resale_price|cost_plus|profit_split|transactional_net_margin');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `withholding_tax_certificate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Certificate Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ALTER COLUMN `withholding_tax_indicator` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Indicator Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'cash_operations');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `cash_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Pool ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `house_bank_id` SET TAGS ('dbx_business_glossary_term' = 'House Bank ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `house_bank_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `account_close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `account_currency` SET TAGS ('dbx_business_glossary_term' = 'Account Currency');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `account_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `account_id_sap` SET TAGS ('dbx_business_glossary_term' = 'Account ID (SAP)');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `account_id_sap` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `account_open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `account_purpose` SET TAGS ('dbx_business_glossary_term' = 'Account Purpose');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|blocked|dormant');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'checking|savings|money_market|sweep|lockbox|zero_balance');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `authorized_signatories` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatories');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `authorized_signatories` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `auto_reconciliation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Reconciliation Enabled');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,34}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Country Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_key` SET TAGS ('dbx_business_glossary_term' = 'Bank Key');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `cash_pool_type` SET TAGS ('dbx_business_glossary_term' = 'Cash Pool Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `cash_pool_type` SET TAGS ('dbx_value_regex' = 'physical|notional|zero_balance|target_balance|none');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `electronic_format` SET TAGS ('dbx_business_glossary_term' = 'Electronic Bank Statement Format');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `electronic_format` SET TAGS ('dbx_value_regex' = 'MT940|CAMT053|BAI2|SWIFT_MT942|proprietary');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Calculation Method');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_value_regex' = 'daily_balance|average_balance|tiered|none');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `last_statement_balance` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Balance');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `minimum_balance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Requirement');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `payment_method_enabled` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Enabled');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|pending|variance|not_started');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Signatory Limit Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `statement_import_frequency` SET TAGS ('dbx_business_glossary_term' = 'Statement Import Frequency');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `statement_import_frequency` SET TAGS ('dbx_value_regex' = 'daily|intraday|weekly|monthly|on_demand');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Business Identifier Code (BIC)');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_account` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` SET TAGS ('dbx_subdomain' = 'cash_operations');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `house_bank_id` SET TAGS ('dbx_business_glossary_term' = 'House Bank ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `account_id_sap` SET TAGS ('dbx_business_glossary_term' = 'SAP Account ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `balance_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Verification Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `balance_verification_status` SET TAGS ('dbx_value_regex' = 'VERIFIED|MISMATCH|NOT_CHECKED|PENDING');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_identifier_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_identifier_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `forward_available_balance` SET TAGS ('dbx_business_glossary_term' = 'Forward Available Balance');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]+$');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `iban` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `import_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Import Batch ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `import_file_name` SET TAGS ('dbx_business_glossary_term' = 'Import File Name');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `import_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Import Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Statement Notes');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `previous_statement_closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Previous Statement Closing Balance');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `reconciled_by_user` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `reconciled_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Reconciled Transaction Count');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'NOT_STARTED|IN_PROGRESS|COMPLETED|EXCEPTION|MANUAL_REVIEW');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `reconciliation_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Variance Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `statement_format` SET TAGS ('dbx_business_glossary_term' = 'Statement Format');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `statement_format` SET TAGS ('dbx_value_regex' = 'MT940|CAMT.053|BAI2|CSV|PDF|PROPRIETARY');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `statement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period End Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `statement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period Start Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `statement_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Statement Sequence Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_value_regex' = 'IMPORTED|RECONCILED|PARTIALLY_RECONCILED|PENDING|ERROR|ARCHIVED');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `telecommunication_ecm`.`finance`.`bank_statement` ALTER COLUMN `unreconciled_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Unreconciled Transaction Count');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `transferred_from_accounts_receivable_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|91_120_days|over_120_days');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `ar_document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Document Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `ar_status` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `bad_debt_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Provision Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `business_segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `business_segment` SET TAGS ('dbx_value_regex' = 'consumer_wireless|consumer_broadband|enterprise|wholesale|iot|other');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `collection_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|payment_plan|legal_action|suspended|closed');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `credit_memo_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `last_dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `original_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|unreconciled|pending_review|variance_identified');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `revenue_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `revenue_type` SET TAGS ('dbx_value_regex' = 'service_revenue|equipment_revenue|usage_revenue|activation_fee|late_fee|other');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `original_recognition_revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Original Recognition ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Product Offering ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `prior_estimate_revenue_recognition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'relative_ssp|adjusted_market_assessment|expected_cost_plus_margin|residual');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `bundled_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Bundled Arrangement Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `constraint_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Constraint Applied Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `contract_asset_balance` SET TAGS ('dbx_business_glossary_term' = 'Contract Asset Balance');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `contract_modification_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Modification Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `cumulative_recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Recognized Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `deferred_revenue_balance` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Balance');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `handset_subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Handset Subsidy Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `modification_type` SET TAGS ('dbx_business_glossary_term' = 'Modification Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `modification_type` SET TAGS ('dbx_value_regex' = 'upgrade|downgrade|add_service|remove_service|device_change|price_adjustment');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `performance_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Description');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Recognition Method');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'over_time|point_in_time');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recognition Pattern');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_pattern` SET TAGS ('dbx_value_regex' = 'straight_line|usage_based|milestone|output_method|input_method');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_recognition_status` SET TAGS ('dbx_value_regex' = 'draft|pending|recognized|deferred|reversed|adjusted');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_stream_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Category');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_stream_category` SET TAGS ('dbx_value_regex' = 'subscription|usage|equipment|activation|overage|roaming');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `standalone_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Standalone Selling Price (SSP)');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `transaction_price_allocated` SET TAGS ('dbx_business_glossary_term' = 'Transaction Price Allocated');
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `variable_consideration_estimate` SET TAGS ('dbx_business_glossary_term' = 'Variable Consideration Estimate');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` SET TAGS ('dbx_association_edges' = 'finance.budget_plan,location.network_rollout_zone');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` ALTER COLUMN `budget_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation - Budget Plan Id');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` ALTER COLUMN `network_rollout_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation - Network Rollout Zone Id');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` ALTER COLUMN `actual_spend_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend To Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` ALTER COLUMN `allocated_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` ALTER COLUMN `variance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` SET TAGS ('dbx_association_edges' = 'finance.capital_project,people.employee');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ALTER COLUMN `finance_project_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'finance_project_assignment Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Assignment - Capex Project Id');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Assignment - Employee Id');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Project Assignment Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Time Allocation Percentage');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ALTER COLUMN `billable_rate` SET TAGS ('dbx_business_glossary_term' = 'Billable Rate');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` SET TAGS ('dbx_association_edges' = 'finance.budget_plan,people.employee');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `budget_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval - Budget Plan Id');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `delegated_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Delegated By Employee ID');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `delegated_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `delegated_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval - Employee Id');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `approval_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Limit Amount');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `approval_sequence` SET TAGS ('dbx_business_glossary_term' = 'Approval Sequence');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ALTER COLUMN `delegation_flag` SET TAGS ('dbx_business_glossary_term' = 'Delegation Flag');
ALTER TABLE `telecommunication_ecm`.`finance`.`payment_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`payment_plan` SET TAGS ('dbx_subdomain' = 'cash_operations');
ALTER TABLE `telecommunication_ecm`.`finance`.`payment_plan` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`payment_plan` ALTER COLUMN `restructured_from_payment_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`cash_pool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`cash_pool` SET TAGS ('dbx_subdomain' = 'cash_operations');
ALTER TABLE `telecommunication_ecm`.`finance`.`cash_pool` ALTER COLUMN `cash_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Pool Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`cash_pool` ALTER COLUMN `parent_cash_pool_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` SET TAGS ('dbx_subdomain' = 'cash_operations');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `house_bank_id` SET TAGS ('dbx_business_glossary_term' = 'House Bank Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `parent_house_bank_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `bank_swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `bank_swift_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `iban_prefix` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `iban_prefix` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`house_bank` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`allocation_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`allocation_cycle` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `prior_allocation_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`allocation_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`allocation_rule` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`allocation_rule` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`allocation_rule` ALTER COLUMN `parent_allocation_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `parent_vendor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`lease_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`lease_contract` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`lease_contract` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`lease_contract` ALTER COLUMN `renewed_from_lease_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`lease_contract` ALTER COLUMN `guarantor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`lease_contract` ALTER COLUMN `guarantor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`chart_of_accounts` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`chart_of_accounts` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `telecommunication_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_chart_of_accounts_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`controlling_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`controlling_area` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`controlling_area` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`controlling_area` ALTER COLUMN `parent_controlling_area_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`functional_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`functional_area` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`functional_area` ALTER COLUMN `functional_area_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_element` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_element` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`commitment_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`commitment_item` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `telecommunication_ecm`.`finance`.`commitment_item` ALTER COLUMN `commitment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Commitment Item Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`commitment_item` ALTER COLUMN `parent_commitment_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`commitment_item` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`commitment_item` ALTER COLUMN `amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`performance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`performance_obligation` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `telecommunication_ecm`.`finance`.`performance_obligation` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`performance_obligation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`performance_obligation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`performance_obligation` ALTER COLUMN `parent_performance_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'cash_operations');
ALTER TABLE `telecommunication_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`payment_run` ALTER COLUMN `reversal_payment_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `ein` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `ein` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `mailing_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `mailing_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `vat_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`finance`.`legal_entity` ALTER COLUMN `vat_number` SET TAGS ('dbx_pii_identifier' = 'true');
