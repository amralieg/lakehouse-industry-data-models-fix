-- Schema for Domain: finance | Business: Travel Hospitality | Version: v1_mvm
-- Generated on: 2026-05-08 06:03:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `travel_hospitality_ecm`.`finance` COMMENT 'Financial management including GL, AP, AR, budgeting, forecasting, and financial reporting per USALI standards and GAAP/IFRS. Manages property-level P&L, departmental accounting, capital expenditure tracking (CapEx, FF&E), and consolidated financial statements. Tracks GOP, EBITDA, NOI calculations. Integrates with SAP S/4HANA. Supports SOX financial controls for publicly traded entities.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`ledger` (
    `ledger_id` BIGINT COMMENT 'Unique identifier for the general ledger account. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Some GL accounts have default cost centers for automatic allocation when no specific cost center is provided on transactions. The cost_center_code STRING should be replaced with a proper FK to cost_ce',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Some GL accounts have default profit centers for automatic allocation when no specific profit center is provided on transactions. The profit_center_code STRING should be replaced with a proper FK to p',
    `property_id` BIGINT COMMENT 'The unique identifier of the property to which this ledger account belongs. Supports property-level chart of accounts and multi-property financial consolidation. Links to the property master entity.',
    `account_category` STRING COMMENT 'The USALI-defined category grouping for the account (e.g., Rooms, Food and Beverage, Other Operated Departments, Administrative and General, Sales and Marketing, Property Operations and Maintenance, Utilities, Fixed Charges). Used for departmental P&L reporting and GOP calculation.',
    `account_name` STRING COMMENT 'The descriptive name of the general ledger account (e.g., Room Revenue, Food and Beverage Cost of Sales, Payroll and Related Expenses, Property Operations and Maintenance).',
    `account_number` STRING COMMENT 'The unique account number assigned to this general ledger account per USALI chart of accounts structure. Typically 4-10 digit numeric code used for financial reporting and transaction posting.. Valid values are `^[0-9]{4,10}$`',
    `account_subcategory` STRING COMMENT 'The detailed subcategory within the USALI account category (e.g., within Food and Beverage: Restaurant Revenue, Banquet Revenue, Room Service Revenue; within Rooms: Payroll and Related, Guest Supplies, Laundry and Linen). Enables granular financial analysis.',
    `account_type` STRING COMMENT 'The fundamental accounting classification of the ledger account: asset, liability, equity, revenue, or expense. Determines placement in financial statements and normal balance behavior.. Valid values are `asset|liability|equity|revenue|expense`',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether detailed audit trail documentation is required for all transactions posted to this account. Used for high-risk accounts, regulatory compliance, and forensic accounting.',
    `balance_sheet_section` STRING COMMENT 'The section of the balance sheet where this account appears (current assets, non-current assets, current liabilities, non-current liabilities, equity). Determines liquidity classification and working capital calculation.. Valid values are `current_assets|non_current_assets|current_liabilities|non_current_liabilities|equity`',
    `cash_flow_classification` STRING COMMENT 'The cash flow statement category for this account: operating activities, investing activities, or financing activities. Used for automated cash flow statement preparation per GAAP/IFRS.. Valid values are `operating|investing|financing`',
    `consolidation_account` STRING COMMENT 'The account number used for consolidation at the corporate or regional level. Maps property-level accounts to standardized corporate chart of accounts for multi-property financial consolidation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ledger account record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this ledger account is denominated (e.g., USD, EUR, GBP). Supports multi-currency accounting for global property portfolios.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this ledger account becomes inactive and no longer accepts new transactions. Null for accounts with no planned end date. Used for account retirement and chart of accounts cleanup.',
    `effective_start_date` DATE COMMENT 'The date from which this ledger account becomes active and available for transaction posting. Supports phased chart of accounts implementation and account structure changes.',
    `functional_area` STRING COMMENT 'The functional area classification for financial statement presentation (e.g., Operating Revenue, Cost of Sales, Operating Expenses, Fixed Charges). Used for USALI-compliant income statement formatting and GOP calculation.',
    `income_statement_section` STRING COMMENT 'The section of the income statement where this account appears per USALI format (e.g., Operated Departments Revenue, Operated Departments Expenses, Undistributed Operating Expenses, Fixed Charges). Supports GOP, EBITDA, and NOI calculation.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the ledger account is currently active and available for transaction posting. Inactive accounts are retained for historical reporting but cannot accept new transactions.',
    `is_control_account` BOOLEAN COMMENT 'Indicates whether this is a control account (summary account) that aggregates balances from subsidiary ledgers (e.g., Accounts Receivable control account summarizing individual guest folios). Control accounts do not accept direct postings.',
    `is_intercompany` BOOLEAN COMMENT 'Indicates whether this account is used for intercompany transactions between properties or legal entities within the hospitality group. Intercompany accounts are eliminated during consolidated financial statement preparation.',
    `is_reconciliation_required` BOOLEAN COMMENT 'Indicates whether this account requires periodic reconciliation (e.g., bank accounts, accounts receivable, inventory accounts). Used for internal control and SOX compliance.',
    `is_statistical` BOOLEAN COMMENT 'Indicates whether this is a statistical account used for non-monetary metrics (e.g., room nights sold, covers served, occupied room count). Statistical accounts support KPI calculation (ADR, RevPAR, GOPPAR) but do not carry monetary balances.',
    `last_posting_date` DATE COMMENT 'The date of the most recent transaction posted to this account. Used for dormant account identification and account usage analysis.',
    `ledger_description` STRING COMMENT 'Extended description of the ledger account purpose, usage guidelines, and posting rules. Provides additional context beyond the account name for accounting staff and auditors.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this ledger account record was last modified. Used for change tracking and audit trail.',
    `normal_balance` STRING COMMENT 'Indicates whether the account normally carries a debit or credit balance. Assets and expenses have debit normal balances; liabilities, equity, and revenue have credit normal balances. Used for transaction validation and financial statement preparation.. Valid values are `debit|credit`',
    `notes` STRING COMMENT 'Free-form notes field for special instructions, reconciliation notes, or account-specific documentation. Used by accounting staff for operational guidance and audit documentation.',
    `posting_block_flag` BOOLEAN COMMENT 'Indicates whether direct posting to this account is blocked. Posting blocks are used for control accounts, summary accounts, or accounts under investigation. Transactions must be posted to subsidiary accounts instead.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this account is subject to SOX internal control testing and documentation requirements. Typically true for material accounts affecting financial statement accuracy for publicly traded hospitality companies.',
    `tax_category` STRING COMMENT 'The tax category or tax line item code associated with this account for tax reporting purposes (e.g., taxable revenue, non-taxable revenue, deductible expense, non-deductible expense). Supports automated tax return preparation.',
    CONSTRAINT pk_ledger PRIMARY KEY(`ledger_id`)
) COMMENT 'General Ledger (GL) master entity representing the chart of accounts structure per USALI (Uniform System of Accounts for the Lodging Industry) standards. Each ledger account defines an account number, account name, account type (asset, liability, equity, revenue, expense), account group, normal balance indicator, and currency. Serves as the authoritative financial record backbone for all property-level and consolidated financial reporting including income statements, balance sheets, cash flow statements, GOP, EBITDA, NOI, and GOPPAR calculations. Supports period-end financial statement generation and multi-property consolidation with intercompany elimination. Sourced from SAP S/4HANA GL module.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center. Primary key.',
    `parent_cost_center_id` BIGINT COMMENT 'Reference to a parent cost center in a hierarchical cost center structure, enabling roll-up reporting and consolidated P&L views. Null if this is a top-level cost center.',
    `property_id` BIGINT COMMENT 'Reference to the property to which this cost center belongs.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'The total annual budgeted amount allocated to this cost center for the current fiscal year, used for variance analysis and financial control.',
    `audit_trail_required_flag` BOOLEAN COMMENT 'Indicates whether all financial transactions posted to this cost center must maintain a full audit trail for compliance and internal control purposes (True) or standard logging is sufficient (False).',
    `budget_allocation_flag` BOOLEAN COMMENT 'Indicates whether this cost center has a dedicated budget allocation and is subject to budget control and variance reporting (True) or operates without a formal budget (False).',
    `company_code` STRING COMMENT 'The SAP company code representing the legal entity to which this cost center belongs, used for consolidated financial reporting and legal compliance.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area` STRING COMMENT 'The SAP controlling area under which this cost center is managed, representing the organizational unit for internal cost accounting and management reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_allocation_method` STRING COMMENT 'The method used to allocate shared costs or overhead to this cost center: direct assignment, activity-based costing, percentage allocation, headcount-based, or square footage-based.. Valid values are `direct|activity_based|percentage|headcount|square_footage`',
    `cost_center_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying the cost center within the property and financial system. Used in GL postings and financial reports.. Valid values are `^[A-Z0-9]{4,12}$`',
    `cost_center_description` STRING COMMENT 'Detailed description of the cost centers purpose, scope, and operational responsibilities.',
    `cost_center_name` STRING COMMENT 'The full business name of the cost center (e.g., Rooms Division, Food and Beverage, Spa Operations, Administration).',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center: active (operational and accepting postings), inactive (temporarily not in use), suspended (blocked for new postings), or closed (permanently retired).. Valid values are `active|inactive|suspended|closed`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by its primary function: revenue-generating departments, support services, administrative functions, or overhead allocation centers.. Valid values are `revenue|support|administrative|overhead`',
    `created_by_user` STRING COMMENT 'The username or employee identifier of the user who created this cost center record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this cost centers financial transactions are recorded (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `department_category` STRING COMMENT 'High-level USALI category: Operated Departments (revenue-generating), Undistributed Operating Expenses (support), or Fixed Charges (property-level overhead).. Valid values are `operated|undistributed|fixed_charges`',
    `effective_end_date` DATE COMMENT 'The date on which this cost center ceased operations or was closed. Null for currently active cost centers.',
    `effective_start_date` DATE COMMENT 'The date from which this cost center became active and began accepting financial postings.',
    `external_reporting_flag` BOOLEAN COMMENT 'Indicates whether this cost centers financial results are included in external financial statements and regulatory filings (True) or used only for internal management reporting (False).',
    `headcount_allocation` STRING COMMENT 'The number of full-time equivalent (FTE) employees allocated to this cost center, used for labor cost analysis and productivity metrics.',
    `hierarchy_level` STRING COMMENT 'The depth of this cost center in the organizational hierarchy (1=top-level, 2=sub-department, etc.), used for roll-up aggregation and reporting.',
    `labor_cost_tracking_flag` BOOLEAN COMMENT 'Indicates whether labor costs (payroll, benefits, overtime) are tracked and allocated to this cost center (True) or excluded from labor cost analysis (False).',
    `last_modified_by_user` STRING COMMENT 'The username or employee identifier of the user who last modified this cost center record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the cost centers operations, budget constraints, or reporting requirements.',
    `revenue_posting_allowed_flag` BOOLEAN COMMENT 'Indicates whether revenue transactions can be posted to this cost center (True for revenue-generating departments) or only expense postings are allowed (False for support/administrative centers).',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this cost center is subject to SOX financial controls and audit requirements (True for publicly traded entities) or exempt (False).',
    `square_footage` DECIMAL(18,2) COMMENT 'The total square footage of physical space occupied by this cost center, used for space-based cost allocation and facility management analysis.',
    `usali_department_code` STRING COMMENT 'The standard USALI departmental code aligning this cost center to the industry-standard chart of accounts for lodging P&L reporting (e.g., 10=Rooms, 20=Food, 30=Beverage, 40=Other Operated Departments, 50=Administrative & General).. Valid values are `^[0-9]{2,4}$`',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Organizational cost center master representing departmental accounting units within each property (e.g., Rooms, F&B, Spa, Administration). Aligns with USALI departmental P&L structure. Used for allocating OpEx, labor costs, and overhead across operating departments. Sourced from SAP S/4HANA Controlling (CO) module.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique identifier for the profit center. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key reference to the primary cost center associated with this profit center for expense allocation and departmental accounting per USALI standards.',
    `ownership_entity_id` BIGINT COMMENT 'Foreign key reference to the legal ownership entity responsible for this profit center. Supports consolidated financial statements across the portfolio and inter-company eliminations.',
    `parent_profit_center_id` BIGINT COMMENT 'Foreign key reference to the parent profit center in a hierarchical profit center structure. Enables roll-up reporting for complex properties with nested profit centers (e.g., a resort with multiple F&B (Food and Beverage) outlets).',
    `property_id` BIGINT COMMENT 'Foreign key reference to the parent property or resort to which this profit center belongs. Enables property-level P&L (Profit and Loss) consolidation and RevPAR (Revenue Per Available Room) contribution analysis.',
    `revenue_center_id` BIGINT COMMENT 'Foreign key reference to the primary revenue center for this profit center. Used for revenue recognition and departmental revenue reporting per USALI.',
    `address_line_1` STRING COMMENT 'Primary street address line for the profit centers physical location. Required for property-level profit centers and standalone F&B (Food and Beverage) or event venues.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, floor, or building information.',
    `brand_code` STRING COMMENT 'Brand or franchise affiliation code for the profit center (e.g., Marriott, Hilton, Hyatt, independent). Used for brand-level performance reporting and franchise fee calculations.',
    `business_area_code` STRING COMMENT 'SAP Business Area code for cross-company-code segment reporting. Enables consolidated reporting across multiple legal entities within the same business segment (e.g., luxury hotels, select-service properties).. Valid values are `^[A-Z0-9]{4}$`',
    `city` STRING COMMENT 'City or municipality where the profit center is located.',
    `closure_date` DATE COMMENT 'The date the profit center was permanently closed. Used for historical analysis and asset disposition reporting.',
    `company_code` STRING COMMENT 'SAP Company Code representing the legal entity for external financial reporting. Links profit center results to the general ledger and statutory financial statements.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area_code` STRING COMMENT 'SAP Controlling Area code to which this profit center is assigned. Defines the organizational boundary for internal cost and revenue accounting.. Valid values are `^[A-Z0-9]{4}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the profit centers location. Used for multi-country consolidation and compliance with local regulatory reporting requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this profit center record was first created in the system. Used for audit trail and data lineage tracking per SOX (Sarbanes-Oxley Act) compliance requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the profit centers local currency. Used for multi-currency consolidation and foreign exchange translation per IFRS/GAAP.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this profit center ceased operations or was closed. Null for currently active profit centers. Used for historical reporting and closed property analysis.',
    `effective_start_date` DATE COMMENT 'The date from which this profit center became active and began contributing to financial statements. Used for time-based reporting and historical analysis.',
    `email_address` STRING COMMENT 'Primary email address for business correspondence related to this profit center. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter functional currency code for financial consolidation. May differ from local currency for properties operating in high-inflation or multi-currency environments.. Valid values are `^[A-Z]{3}$`',
    `hierarchy_level` STRING COMMENT 'The level of this profit center within the profit center hierarchy (1 = top-level property, 2 = department, 3 = sub-department, etc.). Used for recursive roll-up calculations.',
    `is_consolidated` BOOLEAN COMMENT 'Boolean flag indicating whether this profit centers financial results are included in consolidated financial statements. Used for inter-company elimination and segment reporting per IFRS/GAAP.',
    `is_revenue_generating` BOOLEAN COMMENT 'Boolean flag indicating whether this profit center directly generates guest-facing revenue (true) or is a support/overhead center (false). Used for GOP (Gross Operating Profit) and departmental profit analysis per USALI.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this profit center record. Used for change tracking and audit compliance per SOX (Sarbanes-Oxley Act).',
    `opening_date` DATE COMMENT 'The original opening or launch date of the profit center. Used for property age analysis and lifecycle reporting.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the profit center. Organizational contact data classified as confidential.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the profit centers address.',
    `profit_center_code` STRING COMMENT 'The externally-known unique business identifier for the profit center used in financial reporting and consolidation. Typically alphanumeric code assigned per SAP S/4HANA Profit Center Accounting standards.. Valid values are `^[A-Z0-9]{4,12}$`',
    `profit_center_description` STRING COMMENT 'Detailed business description of the profit center, including its purpose, services offered, and unique characteristics. Used for internal documentation and reporting context.',
    `profit_center_name` STRING COMMENT 'The full business name of the profit center (e.g., Grand Plaza Hotel Downtown, Rooftop Bar & Lounge, Convention Center Ballroom A).',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center. Active centers contribute to consolidated financial statements; inactive or closed centers are excluded from operational reporting.. Valid values are `active|inactive|suspended|closed|pending_activation`',
    `profit_center_type` STRING COMMENT 'Classification of the profit center by business unit type. Determines the applicable revenue and cost accounting rules per USALI departmental structure. [ENUM-REF-CANDIDATE: property|fnb_outlet|event_venue|spa|retail|parking|other — 7 candidates stripped; promote to reference product]',
    `room_count` STRING COMMENT 'Total number of guest rooms or keys available at this profit center (applicable only to property-level profit centers). Used for RevPAR (Revenue Per Available Room), GOPPAR (Gross Operating Profit Per Available Room), and occupancy calculations.',
    `seating_capacity` STRING COMMENT 'Maximum seating capacity for F&B (Food and Beverage) outlets or event venues. Used for revenue per seat analysis and capacity utilization reporting.',
    `segment_code` STRING COMMENT 'Business segment classification for the profit center (e.g., luxury, premium, select-service). Aligns with IFRS 8 segment reporting requirements and STR (Smith Travel Research) competitive set definitions.. Valid values are `luxury|premium|select_service|extended_stay|resort|other`',
    `short_name` STRING COMMENT 'Abbreviated or short name for the profit center used in reports and dashboards where space is limited.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total square footage of the profit centers physical space. Used for revenue per square foot analysis and space utilization metrics.',
    `star_rating` DECIMAL(18,2) COMMENT 'Official star rating or quality classification for the profit center (e.g., 3.5, 4.0, 5.0). Used for competitive set analysis and ADR (Average Daily Rate) benchmarking per STR (Smith Travel Research) standards.',
    `state_province_code` STRING COMMENT 'ISO 3166-2 state or province code for the profit centers location. Used for tax jurisdiction determination and regulatory reporting.. Valid values are `^[A-Z]{2,3}$`',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code for sales tax, VAT (Value-Added Tax), or GST (Goods and Services Tax) reporting. Used for compliance with local tax regulations and automated tax calculation.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Profit center master representing revenue-generating business units within the property portfolio (e.g., individual hotels, resorts, F&B outlets, event venues). Enables property-level P&L reporting, RevPAR contribution analysis, and GOPPAR tracking. Supports consolidated financial statements across the portfolio. Sourced from SAP S/4HANA Profit Center Accounting.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record. Primary key for the journal entry transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entries are allocated to cost centers for departmental accounting. The cost_center STRING attribute should be replaced with a proper FK to cost_center.cost_center_id to enable joining to cost ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Journal entries are posted to a specific fiscal period in the GL cycle. The journal_entry table currently stores fiscal_period (INT) and fiscal_year (INT) as raw scalar fields, which are denormalized ',
    `fixed_asset_id` BIGINT COMMENT 'Identifier of the fixed asset or FF&E item to which this journal entry is related, if applicable. Used for asset acquisition, depreciation, and disposal tracking.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Journal entries post to GL accounts in the chart of accounts. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account master data for financi',
    `pos_check_id` BIGINT COMMENT 'Foreign key linking to fnb.pos_check. Business justification: Daily F&B revenue GL posting: Journal entries for daily F&B revenue are sourced from POS check summaries. Direct linkage enables GL-to-source-document audit traceability, revenue recognition verificat',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Journal entries are allocated to profit centers for revenue-generating business unit tracking. The profit_center STRING attribute should be replaced with a proper FK to profit_center.profit_center_id ',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property or resort to which this journal entry is attributed. Enables property-level P&L and financial reporting.',
    `revenue_center_id` BIGINT COMMENT 'Foreign key linking to fnb.revenue_center. Business justification: Manual journal entries often adjust revenue center-specific accounts (accruals, corrections, allocations). JE already links to cost_center and profit_center; adding revenue_center enables direct F&B d',
    `approved_timestamp` TIMESTAMP COMMENT 'System timestamp when this journal entry was approved for posting. Null if not yet approved. Part of the approval workflow audit trail.',
    `audit_trail_notes` STRING COMMENT 'Additional audit trail notes or comments added by approvers, auditors, or system administrators for compliance and review purposes.',
    `capex_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry relates to capital expenditure (CapEx) or furniture, fixtures, and equipment (FF&E) investments. True for CapEx/FF&E entries, False for operating expenditure (OpEx).',
    `company_code` STRING COMMENT 'The legal entity or company code within the enterprise structure to which this journal entry belongs. Used for consolidated financial reporting and intercompany elimination.. Valid values are `^[A-Z0-9]{4,6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this journal entry record was first created in the general ledger system. Part of the complete audit trail for SOX compliance.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The total credit amount for this journal entry in the functional currency. Must balance with debit amount per double-entry accounting principles.',
    `debit_amount` DECIMAL(18,2) COMMENT 'The total debit amount for this journal entry in the functional currency. Must balance with credit amount per double-entry accounting principles.',
    `document_number` STRING COMMENT 'Externally-known unique document number assigned to this journal entry for reference and audit trail purposes. Typically follows format JE followed by numeric sequence.. Valid values are `^JE[0-9]{8,12}$`',
    `document_type` STRING COMMENT 'Classification of the journal entry by its business purpose: standard (regular postings), allocation (cost distribution), intercompany (cross-entity transactions), recurring (template-based periodic entries), accrual (period-end adjustments), reversal (correction entries).. Valid values are `standard|allocation|intercompany|recurring|accrual|reversal`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert transaction currency to functional currency at the time of posting. Null if transaction and functional currencies are the same.',
    `functional_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code representing the functional currency in which this journal entry is recorded (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry represents an intercompany transaction between legal entities within the enterprise. True for intercompany entries requiring elimination in consolidated reporting.',
    `intercompany_partner_code` STRING COMMENT 'The company code of the intercompany partner entity for intercompany transactions. Used for intercompany reconciliation and elimination entries in consolidated financial statements.',
    `journal_entry_description` STRING COMMENT 'Free-text narrative description of the business purpose and nature of this journal entry. Provides context for auditors and financial analysts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this journal entry record was last modified. Tracks all changes for audit and compliance purposes.',
    `posted_timestamp` TIMESTAMP COMMENT 'System timestamp when this journal entry was posted to the general ledger. Null if not yet posted. This is the system processing time, distinct from the posting_date which is the accounting date.',
    `posting_date` DATE COMMENT 'The accounting date when this journal entry is posted to the general ledger. This is the business event date that determines which fiscal period the entry impacts, distinct from the creation or approval timestamps.',
    `posting_status` STRING COMMENT 'Current lifecycle state of the journal entry in the approval and posting workflow. Tracks progression from draft creation through approval to final posting in the general ledger.. Valid values are `draft|pending_approval|approved|posted|reversed|cancelled`',
    `reference_text` STRING COMMENT 'Additional reference information or notes related to this journal entry, such as supporting documentation references, approval notes, or special instructions.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a reversal of a previous entry. True if this is a reversal entry, False otherwise.',
    `reversed_document_number` STRING COMMENT 'The document number of the original journal entry that this entry reverses. Populated only when reversal_indicator is True.',
    `source_document_reference` STRING COMMENT 'Reference number or identifier of the originating source transaction document (e.g., invoice number, payment document, POS check number) that triggered this journal entry.',
    `source_system` STRING COMMENT 'The originating system or module from which this journal entry was created or interfaced (e.g., SAP FI for manual entries, OPERA AR for accounts receivable postings, MICROS POS for point-of-sale revenue).. Valid values are `SAP_FI|OPERA_AR|MICROS_POS|MANUAL|INTERFACE|OTHER`',
    `tax_code` STRING COMMENT 'The tax code or tax jurisdiction code applicable to this journal entry, if the entry involves tax-related postings (sales tax, VAT, occupancy tax, etc.).',
    `transaction_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code of the original transaction currency if different from functional currency. Used for foreign exchange tracking.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'General Ledger journal entry transactional record capturing all financial postings including accruals, adjustments, intercompany transfers, expense allocations, and period-end closing entries. Each entry carries debit/credit totals, posting date, fiscal period, document type (standard, allocation, intercompany, recurring), reference to source transaction, and full audit trail (created by, approved by, posting timestamp). Supports SOX audit trail requirements, intercompany elimination tracking, and GAAP/IFRS compliance. Sourced from SAP S/4HANA GL.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for granular financial transaction analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each journal entry line is allocated to a specific cost center for departmental accounting. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to enable join',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Individual GL journal entry lines can post directly to fixed assets (depreciation postings, CapEx capitalization, asset disposal entries). The journal_entry_line table currently stores asset_number (S',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header. Links this line to the overall journal entry batch and posting context.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Each journal entry line posts to a specific GL account. The gl_account_code and gl_account_name STRING attributes should be replaced with a proper FK to ledger.ledger_id to enable joining to the autho',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Each journal entry line is allocated to a specific profit center for revenue-generating business unit tracking. The profit_center_code STRING should be replaced with a proper FK to profit_center.profi',
    `amount_group_currency` DECIMAL(18,2) COMMENT 'Line item amount converted to the corporate group reporting currency. Used for consolidated financial statements and EBITDA reporting.',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'Line item amount converted to the property or entity local currency. Used for property-level P&L and GOP calculation.',
    `amount_transaction_currency` DECIMAL(18,2) COMMENT 'Line item amount in the original transaction currency. Supports multi-currency operations for international properties.',
    `assignment_field` STRING COMMENT 'Assignment field for additional sorting and grouping. Used for payment clearing, reconciliation, and sub-ledger matching.. Valid values are `^[A-Z0-9]{1,18}$`',
    `baseline_payment_date` DATE COMMENT 'Baseline date for payment terms calculation. Used for AP aging and cash flow forecasting.',
    `business_area_code` STRING COMMENT 'Business area classification for segment reporting. Used for brand, region, or business unit financial consolidation.. Valid values are `^[A-Z0-9]{2,8}$`',
    `capex_indicator` BOOLEAN COMMENT 'Indicates whether this line item represents capital expenditure (CapEx or FF&E). Used for asset capitalization and depreciation tracking.',
    `clearing_date` DATE COMMENT 'Date when this open item was cleared. Critical for cash application and AR/AP aging analysis.',
    `clearing_document_number` STRING COMMENT 'Document number that cleared this open item. Used for payment reconciliation and AR/AP management.. Valid values are `^[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this journal entry line record was created in the system. Audit trail for data lineage and SOX compliance.',
    `customer_code` STRING COMMENT 'Customer or guest account code for AR line items. Links GL entry to customer master for receivables management.. Valid values are `^[A-Z0-9]{6,10}$`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this line is a debit (D) or credit (C) entry. Fundamental to double-entry bookkeeping and GL balancing.. Valid values are `D|C`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert transaction currency to local or group currency. Critical for multi-currency financial accuracy.',
    `functional_area_code` STRING COMMENT 'Functional area classification for cost-of-sales and functional expense reporting per USALI standards.. Valid values are `^[A-Z0-9]{2,8}$`',
    `group_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the group reporting currency. Used for consolidated financial reporting.. Valid values are `^[A-Z]{3}$`',
    `line_item_text` STRING COMMENT 'Free-text description of the line item. Provides business context for the transaction for audit and analysis purposes.',
    `line_number` STRING COMMENT 'Sequential line number within the journal entry. Determines the order of line items for display and audit purposes.',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the local currency amount. Typically the property operating currency.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this journal entry line record was last modified. Audit trail for change tracking and SOX compliance.',
    `payment_terms_code` STRING COMMENT 'Payment terms code for AP/AR line items. Determines due date calculation and discount eligibility.. Valid values are `^[A-Z0-9]{2,6}$`',
    `posting_key` STRING COMMENT 'SAP posting key that controls the account type and debit/credit behavior. Standard SAP GL posting control mechanism.. Valid values are `^[0-9]{2}$`',
    `project_code` STRING COMMENT 'Project or work breakdown structure (WBS) element for capital projects, renovations, or PIP (Property Improvement Plan) tracking.. Valid values are `^[A-Z0-9]{4,12}$`',
    `property_code` STRING COMMENT 'Property identifier for multi-property financial consolidation. Enables property-level P&L, GOP, and NOI reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
    `reference_document_number` STRING COMMENT 'External reference document number (invoice, receipt, PO). Links GL entry to source operational transaction.. Valid values are `^[A-Z0-9]{1,16}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this line item is a reversal entry. Used for error correction and period-end adjustments.',
    `reversed_document_number` STRING COMMENT 'Document number of the original entry that this line reverses. Maintains audit trail for corrections.. Valid values are `^[0-9]{10}$`',
    `segment_code` STRING COMMENT 'Segment code for IFRS segment reporting. Supports brand, geography, or service-line financial disclosure.. Valid values are `^[A-Z0-9]{2,8}$`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this line item is subject to SOX financial controls. Required for publicly traded hospitality companies.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount calculated for this line item. Supports tax reporting and compliance requirements.',
    `tax_code` STRING COMMENT 'Tax code applied to this line item. Determines tax treatment for VAT, sales tax, occupancy tax, or other jurisdiction-specific taxes.. Valid values are `^[A-Z0-9]{2,6}$`',
    `trading_partner_code` STRING COMMENT 'Trading partner or intercompany entity code. Enables intercompany elimination and consolidation for multi-entity groups.. Valid values are `^[A-Z0-9]{4,10}$`',
    `transaction_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction amount. Enables multi-currency financial reporting.. Valid values are `^[A-Z]{3}$`',
    `usali_department_code` STRING COMMENT 'USALI-compliant department code for hospitality-specific P&L reporting (rooms, F&B, GOP, undistributed expenses).. Valid values are `^[A-Z0-9]{2,6}$`',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual line item within a GL journal entry, capturing the specific account, cost center, profit center, debit/credit indicator, amount in transaction and local currency, tax code, and business area. Enables granular financial analysis at the account-line level. Required for USALI departmental reporting and SOX controls. Sourced from SAP S/4HANA GL line items.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts payable invoice record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Marketing AP invoices (agency fees, media buys, production costs) are reconciled against campaigns for budget-vs-actual spend reporting. Finance controllers in hospitality routinely code vendor invoic',
    `certification_id` BIGINT COMMENT 'Foreign key linking to property.certification. Business justification: Certification and permit fees (health permits, fire safety audits, brand quality audits) generate AP invoices. certification.permit_fee_amount indicates fee tracking exists; linking AP invoices to cer',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AP invoices are allocated to cost centers for departmental accounting per USALI standards. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to enable joini',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: AP invoices are posted to a specific fiscal period for USALI/GAAP accounting. The ap_invoice table currently stores fiscal_period (INT) and fiscal_year (INT) as denormalized scalar fields. Adding fisc',
    `franchise_agreement_id` BIGINT COMMENT 'Foreign key linking to property.franchise_agreement. Business justification: Franchise fee invoices (royalty, marketing, reservation fees) reference specific franchise agreements for rate validation and compliance tracking. Real AP processing verifies fees against agreement te',
    `inventory_item_id` BIGINT COMMENT 'Foreign key linking to fnb.inventory_item. Business justification: F&B supplier invoice-to-item matching: AP invoices for F&B supplies reference specific inventory items for three-way match, cost variance analysis, and vendor price compliance. Hospitality F&B control',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: AP invoices post to GL accounts in the chart of accounts. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account master data (account_name, ',
    `management_fee_id` BIGINT COMMENT 'Foreign key linking to finance.management_fee. Business justification: Management fees calculated under HMA contracts generate AP invoices for payment to the hotel management company. Linking ap_invoice to management_fee establishes the direct traceability from the fee c',
    `property_id` BIGINT COMMENT 'Identifier of the property to which this invoice is assigned. Links to the property master.',
    `revenue_center_id` BIGINT COMMENT 'Foreign key linking to fnb.revenue_center. Business justification: Outlet-specific AP invoices (supplies, equipment, services) must allocate to revenue centers for departmental P&L accuracy. Enables USALI-compliant expense allocation, supports outlet-level profitabil',
    `ap_invoice_description` STRING COMMENT 'Free-text description of the goods or services covered by this invoice. Provides business context for the procurement.',
    `approval_status` STRING COMMENT 'Current approval status of the invoice in the multi-level approval workflow. Supports SOX financial controls.. Valid values are `pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the invoice. Supports audit trail and SOX compliance.',
    `approved_date` DATE COMMENT 'The date the invoice was approved for payment. Key milestone in the AP workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early payment discount or negotiated discount amount applied to the invoice.',
    `dispute_date` DATE COMMENT 'The date the invoice was flagged as disputed. Null if no dispute exists.',
    `dispute_reason` STRING COMMENT 'Reason for disputing the invoice (e.g., pricing discrepancy, quantity mismatch, quality issue). Populated when invoice_status is disputed.',
    `due_date` DATE COMMENT 'The date by which payment is due to the vendor per the payment terms.',
    `expense_category` STRING COMMENT 'Classification of the expense type. OpEx (Operating Expenditure) for recurring costs, CapEx (Capital Expenditure) for long-term assets, FF&E (Furniture Fixtures and Equipment) for property improvements.. Valid values are `opex|capex|ffe`',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before taxes and adjustments. Base amount for goods or services procured.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. Principal business event timestamp for the invoice.',
    `invoice_number` STRING COMMENT 'The externally-known unique invoice number assigned by the vendor. Business identifier for the invoice.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the AP workflow. Tracks approval and payment state. [ENUM-REF-CANDIDATE: pending|approved|rejected|paid|cancelled|on_hold|disputed — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice type. Standard invoices represent normal purchases; credit memos represent vendor credits or returns.. Valid values are `standard|credit_memo|debit_memo|prepayment|recurring`',
    `is_recurring` BOOLEAN COMMENT 'Flag indicating whether this is a recurring invoice (e.g., monthly utilities, annual subscriptions). True if recurring, False otherwise.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last modified. Audit trail field for change tracking.',
    `net_amount` DECIMAL(18,2) COMMENT 'The final payable amount after applying taxes, discounts, and adjustments. This is the amount due to the vendor.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the invoice. Used for special instructions, exceptions, or internal communication.',
    `outstanding_amount` DECIMAL(18,2) COMMENT 'The remaining unpaid balance on the invoice. Calculated as net_amount minus paid_amount.',
    `paid_amount` DECIMAL(18,2) COMMENT 'The total amount paid against this invoice to date. May be partial or full payment.',
    `payment_date` DATE COMMENT 'The date the payment was issued to the vendor. Null if invoice is unpaid.',
    `payment_method` STRING COMMENT 'The payment instrument used to pay the invoice (check, ACH, wire transfer, credit card, electronic funds transfer).. Valid values are `check|ach|wire_transfer|credit_card|eft`',
    `payment_reference_number` STRING COMMENT 'The reference number or transaction ID for the payment made against this invoice (e.g., check number, ACH trace number).',
    `payment_terms` STRING COMMENT 'The payment terms negotiated with the vendor (e.g., Net 30, Net 60, 2/10 Net 30). Defines discount and due date calculation.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the general ledger. May differ from invoice date for period-end accruals.',
    `received_date` DATE COMMENT 'The date the invoice was received by the property or corporate AP department.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice (sales tax, VAT, GST, etc.).',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match validation (PO, goods receipt, invoice). Ensures invoice accuracy and prevents duplicate payments.. Valid values are `matched|unmatched|exception`',
    `vendor_tax_number` STRING COMMENT 'The tax identification number (TIN, EIN, VAT number) of the vendor. Required for 1099 reporting and tax compliance.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts Payable invoice master representing vendor invoices received for goods and services procured by the property (FF&E, OTA commissions, utilities, F&B supplies). Tracks invoice number, vendor, PO reference, invoice date, due date, payment terms, gross amount, tax amount, and approval status. Sourced from SAP S/4HANA AP module. Supports CPOR analysis and OpEx management.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'Unique identifier for the accounts payable payment transaction. Primary key.',
    `ap_invoice_id` BIGINT COMMENT 'Reference to the AP invoice being paid by this payment transaction.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: AP payments are recorded against a fiscal period for cash disbursement reporting and period-close reconciliation. The ap_payment table currently stores fiscal_period (INT) and fiscal_year (INT) as den',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: AP payments post to the General Ledger (cash/bank clearing accounts) and should reference the ledger for GL account classification and reporting. While ap_invoice already has ledger_id, the payment it',
    `original_payment_ap_payment_id` BIGINT COMMENT 'Reference to the original payment transaction if this is a reversal or correction payment.',
    `bank_account_id` BIGINT COMMENT 'Reference to the company bank account from which this payment was disbursed.',
    `property_id` BIGINT COMMENT 'Reference to the property from which this payment originates.',
    `approval_status` STRING COMMENT 'Workflow approval status indicating whether the payment has been authorized for processing.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved this payment for processing, supporting SOX compliance and audit trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was approved, supporting audit trail and SOX compliance requirements.',
    `bank_fee_amount` DECIMAL(18,2) COMMENT 'Transaction fees charged by the bank or payment processor for executing this payment.',
    `base_currency_amount` DECIMAL(18,2) COMMENT 'Payment amount converted to the company base currency using the exchange rate for consolidated reporting.',
    `base_currency_code` STRING COMMENT 'Three-letter ISO 4217 code for the company base currency used for financial reporting and consolidation.. Valid values are `^[A-Z]{3}$`',
    `check_number` STRING COMMENT 'Physical check number when payment method is check, used for reconciliation and audit trail.',
    `clearing_date` DATE COMMENT 'The date on which the payment cleared the bank and was confirmed as successfully processed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment record was first created in the system.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early payment discount or cash discount amount taken on this payment, reducing the total amount paid.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied when payment currency differs from the company base currency or invoice currency.',
    `gl_posting_date` DATE COMMENT 'The accounting period date when this payment transaction was posted to the general ledger.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this payment record, supporting audit trail requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payment record was last updated or modified.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The final net amount disbursed to the vendor after all discounts, withholdings, and fees are applied.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The gross amount disbursed to the vendor in the payment currency before any adjustments or fees.',
    `payment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment transaction (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The date on which the payment was issued or executed. Principal business event timestamp for this transaction.',
    `payment_description` STRING COMMENT 'Free-text description or memo providing additional context about the payment purpose or details.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used to disburse funds to the vendor (e.g., ACH, wire transfer, check, EFT).. Valid values are `ACH|wire_transfer|check|electronic_funds_transfer|credit_card|cash`',
    `payment_number` STRING COMMENT 'Externally-known unique payment document number assigned by the payment system or payment run.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction indicating its processing state.. Valid values are `pending|processed|cleared|failed|cancelled|reversed`',
    `payment_terms` STRING COMMENT 'Payment terms applied to this transaction (e.g., Net 30, 2/10 Net 30) indicating discount and due date conditions.',
    `payment_type` STRING COMMENT 'Classification of the payment transaction indicating its purpose or nature within the AP lifecycle.. Valid values are `standard|advance|partial|final|refund|reversal`',
    `reference_number` STRING COMMENT 'External reference number or transaction ID provided by the bank or payment processor for tracking and reconciliation.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this payment has been reversed or cancelled after initial processing.',
    `reversal_reason` STRING COMMENT 'Explanation or reason code for why the payment was reversed, supporting audit and reconciliation processes.',
    `value_date` DATE COMMENT 'The date on which the payment amount is debited from the company bank account and becomes effective for cash flow purposes.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount withheld from the payment as required by tax regulations, reducing the net amount paid to vendor.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this payment record, supporting audit trail requirements.',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Accounts Payable payment transaction recording disbursements made to vendors against AP invoices. Captures payment date, payment method (ACH, wire, check), bank account, cleared amount, exchange rate for foreign currency payments, and payment run reference. Supports cash flow management and vendor reconciliation. Sourced from SAP S/4HANA AP payment runs.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts receivable invoice record. Primary key.',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: AR invoices for offer-discounted stays must reference the campaign offer that drove the discount for revenue recognition and discount reconciliation reporting. Hospitality finance teams audit offer-dr',
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate account for direct-bill invoices. Null for non-corporate invoices.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile associated with this invoice. Null for non-guest invoices.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: AR invoices post to GL accounts for revenue recognition. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account master data for financial re',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Group/event billing invoices reference specific meeting spaces for USALI event department revenue recognition and space utilization reporting. A hospitality revenue accountant expects AR invoices for ',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where charges were incurred and invoice was generated.',
    `property_outlet_id` BIGINT COMMENT 'Foreign key linking to property.property_outlet. Business justification: Corporate account F&B invoices (private dining, group catering) reference specific outlets for USALI F&B revenue recognition and outlet-level accounts receivable aging. Outlet attribution on AR invoic',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the primary reservation associated with this invoice. Null for non-room invoices.',
    `stay_history_id` BIGINT COMMENT 'Foreign key linking to guest.stay_history. Business justification: Folio reconciliation and revenue recognition require linking each AR invoice to the originating stay. One stay can produce multiple invoices (split folios, late charges, adjustments). Hospitality fina',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total post-billing adjustments including service recovery credits, billing corrections, and dispute resolutions. Can be positive or negative.',
    `aging_bucket` STRING COMMENT 'Categorization of invoice age for accounts receivable aging reports and collection workflow assignment.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `ancillary_revenue_amount` DECIMAL(18,2) COMMENT 'Total ancillary service charges including spa, parking, resort fees, minibar, laundry, and other guest services.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address for the entity being invoiced.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (suite, apartment, building).',
    `billing_city` STRING COMMENT 'City of the billing address.',
    `billing_contact_email` STRING COMMENT 'Email address for invoice delivery and billing correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_phone` STRING COMMENT 'Phone number for billing inquiries and collection contact.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address.. Valid values are `^[A-Z]{3}$`',
    `billing_entity_name` STRING COMMENT 'Legal name of the entity being billed (guest, company, agency, or OTA partner).',
    `billing_entity_type` STRING COMMENT 'Type of entity being billed. Used for segmentation and credit policy application. [ENUM-REF-CANDIDATE: individual|corporate|travel_agency|ota|group|government|other — 7 candidates stripped; promote to reference product]',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code of the billing address.',
    `billing_state_province` STRING COMMENT 'State or province of the billing address.',
    `collection_status` STRING COMMENT 'Current status of collection efforts for overdue invoices.. Valid values are `not_started|in_progress|on_hold|escalated|legal|resolved`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this invoice.. Valid values are `^[A-Z]{3}$`',
    `days_outstanding` STRING COMMENT 'Number of days since invoice date. Used for aging analysis and collection prioritization.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discounts applied to this invoice including promotional discounts, loyalty rewards, and negotiated rate adjustments.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this invoice is currently under dispute by the billing entity.',
    `dispute_reason` STRING COMMENT 'Description of the reason for invoice dispute if dispute_flag is true.',
    `due_date` DATE COMMENT 'The date by which payment is expected based on payment terms. Used for aging and collection prioritization.',
    `event_revenue_amount` DECIMAL(18,2) COMMENT 'Total event and meeting charges including space rental, audio-visual, and catering for Meetings, Incentives, Conferences, and Exhibitions (MICE).',
    `fnb_revenue_amount` DECIMAL(18,2) COMMENT 'Total food and beverage charges on this invoice from restaurants, bars, room service, and banquets.',
    `folio_number` STRING COMMENT 'The externally-known unique folio number assigned to this invoice in the Property Management System (PMS). Used for guest and accounting reference.. Valid values are `^[A-Z0-9]{6,20}$`',
    `invoice_date` DATE COMMENT 'The date the invoice was issued. Used for revenue recognition and aging calculations.',
    `invoice_number` STRING COMMENT 'The official invoice number used for accounting and legal purposes. May differ from folio number for consolidated billing.. Valid values are `^INV-[0-9]{8,12}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts receivable workflow. [ENUM-REF-CANDIDATE: draft|open|sent|partially_paid|paid|overdue|disputed|written_off|cancelled — 9 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on the billing entity type. Determines billing workflow and collection procedures. [ENUM-REF-CANDIDATE: guest|corporate|group|travel_agency|ota|event|direct_bill — 7 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'User ID or system identifier that last modified this invoice record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was last modified.',
    `notes` STRING COMMENT 'Free-text notes and comments related to this invoice for internal reference and customer communication.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on this invoice (total_amount minus paid_amount). Used for aging and collection prioritization.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Total amount paid against this invoice to date. Updated as payments are received and applied.',
    `payment_method` STRING COMMENT 'Primary payment instrument type used or expected for this invoice. [ENUM-REF-CANDIDATE: credit_card|debit_card|bank_transfer|check|cash|direct_bill|virtual_card|other — 8 candidates stripped; promote to reference product]',
    `payment_terms` STRING COMMENT 'The agreed payment terms for this invoice. Determines due date calculation and collection procedures. [ENUM-REF-CANDIDATE: due_on_receipt|net_15|net_30|net_45|net_60|net_90|custom — 7 candidates stripped; promote to reference product]',
    `revenue_recognition_date` DATE COMMENT 'Date revenue was recognized for this invoice per GAAP/IFRS revenue recognition standards (ASC 606 / IFRS 15).',
    `room_revenue_amount` DECIMAL(18,2) COMMENT 'Total room and accommodation charges on this invoice. Key component of Average Daily Rate (ADR) and Revenue Per Available Room (RevPAR) calculations.',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'Total service charges and gratuities applied to this invoice, typically for F&B and event services.',
    `service_end_date` DATE COMMENT 'The last date of service covered by this invoice (e.g., check-out date for room charges).',
    `service_start_date` DATE COMMENT 'The first date of service covered by this invoice (e.g., check-in date for room charges).',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all revenue line items before taxes and fees. Used for tax calculation base.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total taxes applied to this invoice including occupancy tax, sales tax, VAT, and local jurisdiction taxes.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final invoice total including all charges, taxes, fees, discounts, and adjustments. This is the amount due from the billing entity.',
    `write_off_date` DATE COMMENT 'Date the invoice was written off if write_off_flag is true.',
    `write_off_flag` BOOLEAN COMMENT 'Indicates whether this invoice has been written off as uncollectible bad debt.',
    `write_off_reason` STRING COMMENT 'Business justification for writing off this invoice.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this invoice record.',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Accounts Receivable invoice representing charges billed to guests, corporate accounts, travel agencies, and OTA partners for hotel stays, F&B, events, and ancillary services. Tracks folio number, billing entity, invoice date, due date, total charges, taxes, outstanding balance, and collection status. Sourced from Oracle OPERA PMS AR module and SAP S/4HANA AR. Supports ADR and TRevPAR revenue recognition.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` (
    `ar_payment_id` BIGINT COMMENT 'Unique identifier for the accounts receivable payment transaction. Primary key.',
    `ar_invoice_id` BIGINT COMMENT 'Reference to the AR invoice against which this payment is applied. Links payment to the originating invoice for reconciliation and revenue recognition.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: AR payments (guest and corporate account collections) are deposited into specific bank accounts for cash management and reconciliation. The ar_payment table has deposit_date and settlement_date fields',
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate account making the payment. Applicable for direct bill corporate payments.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AR payments are allocated to cost centers for departmental cash receipt tracking. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to enable joining to cos',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile who made the payment. Applicable for individual guest payments.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: AR payments post to GL accounts for cash receipt and accounts receivable tracking. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account ma',
    `ota_partner_id` BIGINT COMMENT 'Reference to the OTA partner remitting payment. Applicable for OTA settlement payments.',
    `property_id` BIGINT COMMENT 'Reference to the property where the payment was received. Supports property-level financial reporting and reconciliation.',
    `reversed_payment_ar_payment_id` BIGINT COMMENT 'Reference to the original payment that this payment reverses. Creates audit trail for payment corrections and chargebacks.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has been applied to specific AR invoices. May differ from payment amount if payment is partially applied or unapplied.',
    `authorization_code` STRING COMMENT 'Authorization code provided by payment processor or card issuer confirming approval of the payment transaction. Used for reconciliation and dispute resolution.',
    `base_currency_amount` DECIMAL(18,2) COMMENT 'The payment amount converted to the property base currency using the exchange rate. Used for consolidated financial reporting.',
    `base_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the property base currency. Standard currency for property-level financial reporting.. Valid values are `^[A-Z]{3}$`',
    `card_last_four` STRING COMMENT 'The last four digits of the payment card number. Used for payment identification while maintaining PCI DSS compliance.. Valid values are `^[0-9]{4}$`',
    `card_type` STRING COMMENT 'The credit or debit card brand used for the payment. Applicable only for card-based payment methods. [ENUM-REF-CANDIDATE: visa|mastercard|amex|discover|jcb|diners|unionpay — 7 candidates stripped; promote to reference product]',
    `cardholder_name` STRING COMMENT 'The name of the cardholder as it appears on the payment card. Used for verification and reconciliation purposes.',
    `check_number` STRING COMMENT 'The check number for check-based payments. Used for tracking and reconciliation with bank deposits.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and SOX compliance.',
    `deposit_date` DATE COMMENT 'The date on which the payment was deposited to the property bank account. Used for cash flow tracking and bank reconciliation.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the payment currency to the property base currency. Used for multi-currency payment processing.',
    `is_advance_deposit` BOOLEAN COMMENT 'Boolean flag indicating whether this payment is an advance deposit received prior to guest arrival or service delivery. Used for revenue recognition timing.',
    `is_refund` BOOLEAN COMMENT 'Boolean flag indicating whether this payment represents a refund to the guest or customer. True if refund, False if collection.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking per SOX requirements.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The net amount received after deducting transaction fees. Represents actual cash collected by the property.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The gross amount received in the payment transaction, in the payment currency. Represents the total collected before any adjustments or fees.',
    `payment_channel` STRING COMMENT 'The interface or touchpoint through which the payment was received. Includes front desk, online portal, mobile app, call center, self-service kiosk, or mail.. Valid values are `front_desk|online|mobile_app|call_center|kiosk|mail`',
    `payment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount. Indicates the currency in which the payment was received.. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The business date on which the payment was received or posted. Used for revenue recognition and cash flow reporting per USALI standards.',
    `payment_method` STRING COMMENT 'The instrument or mechanism used to make the payment. Includes credit card, debit card, cash, check, wire transfer, ACH, or direct bill settlement. [ENUM-REF-CANDIDATE: credit_card|debit_card|cash|check|wire_transfer|ach|direct_bill — 7 candidates stripped; promote to reference product]',
    `payment_notes` STRING COMMENT 'Free-text notes or comments about the payment transaction. Used to capture special instructions, exceptions, or additional context.',
    `payment_number` STRING COMMENT 'Externally visible unique payment reference number used for tracking and reconciliation. Generated by PMS or financial system.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Tracks progression from authorization through settlement or failure. [ENUM-REF-CANDIDATE: pending|authorized|captured|settled|failed|reversed|refunded — 7 candidates stripped; promote to reference product]',
    `payment_timestamp` TIMESTAMP COMMENT 'The precise date and time when the payment transaction was recorded in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `reference_number` STRING COMMENT 'External reference number provided by the payer or payment processor. Used for cross-referencing with external systems and statements.',
    `reversal_reason` STRING COMMENT 'The reason for payment reversal if the payment status is reversed. Includes chargeback, error correction, guest dispute, etc.',
    `settlement_date` DATE COMMENT 'The date on which the payment processor settled funds to the property account. Used for reconciliation with processor settlement reports.',
    `shift_code` BIGINT COMMENT 'Reference to the cashier shift during which the payment was processed. Used for shift reconciliation and cash drawer balancing.',
    `transaction_fee` DECIMAL(18,2) COMMENT 'Processing fee charged by payment processor or financial institution for the transaction. Includes credit card merchant fees, wire transfer fees, etc.',
    `transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the payment processor or gateway. Used for tracking and reconciliation with processor settlement reports.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has not yet been applied to specific AR invoices. Represents credit on account or overpayment.',
    CONSTRAINT pk_ar_payment PRIMARY KEY(`ar_payment_id`)
) COMMENT 'Accounts Receivable payment transaction recording collections received from guests, corporate accounts, and OTA partners against AR invoices. Captures payment date, payment method (credit card, direct bill, OTA settlement), amount received, currency, exchange rate, and application to specific invoices. Supports revenue recognition and cash management. Sourced from Oracle OPERA PMS cashiering and SAP S/4HANA AR.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the finance budget record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Hospitality finance formally allocates marketing budget dollars to specific campaigns during annual budgeting. This FK enables budget-vs-actual campaign spend reporting — a standard process in hotel m',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Financial budgets are allocated to cost centers for departmental budget planning. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to enable joining to cos',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Financial budgets are defined for specific fiscal periods. The finance_budget table currently stores fiscal_period (STRING) and fiscal_year (INT) as denormalized scalar fields. Adding fiscal_period_id',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Outlet-level F&B budget: Finance budgets are created at the F&B outlet level for revenue and cost planning. Hospitality GMs and F&B directors require outlet-specific budgets for performance management',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to property.hierarchy. Business justification: Consolidated budgets are built at hierarchy node level (regional, brand, cluster) for multi-property financial planning. Regional finance teams submit budgets at hierarchy nodes that roll up to corpor',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Financial budgets are planned for specific GL accounts in the chart of accounts. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account mast',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Financial budgets are allocated to profit centers for revenue-generating business unit budget planning. The profit_center_code STRING should be replaced with a proper FK to profit_center.profit_center',
    `program_id` BIGINT COMMENT 'Foreign key linking to experience.program. Business justification: Hotels budget annually for experience programs (SALT programs, loyalty amenity packages, curated guest experiences) as distinct budget line items. Linking finance_budget to program enables budget vs. ',
    `property_id` BIGINT COMMENT 'Reference to the property for which this budget applies. Links to property master data.',
    `seasonal_calendar_id` BIGINT COMMENT 'Foreign key linking to property.seasonal_calendar. Business justification: Annual budget construction in hospitality is driven by seasonal demand patterns. Revenue managers and finance directors build room revenue and occupancy budgets by season; linking finance_budget to se',
    `amount` DECIMAL(18,2) COMMENT 'The planned or forecasted monetary amount for this budget line item. Represents the target financial value for the specified GL account, cost center, and fiscal period combination.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or committee who approved this budget. Supports SOX financial controls and audit trail.',
    `approved_date` DATE COMMENT 'The date on which this budget was formally approved. Critical for audit trail and SOX compliance.',
    `budget_category` STRING COMMENT 'High-level classification of the budget line: revenue (rooms, F&B, events), operating expense (utilities, supplies), labor expense (wages, benefits), capital expenditure (CapEx), or furniture, fixtures, and equipment (FF&E) reserve.. Valid values are `revenue|operating_expense|labor_expense|capex|ffe_reserve`',
    `budget_name` STRING COMMENT 'Descriptive name of the budget (e.g., FY2024 Annual Operating Budget, Q2 2024 Reforecast).',
    `budget_number` STRING COMMENT 'Externally-known unique identifier for this budget document. Used for reference in management reports and approvals.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget: draft (in preparation), submitted (awaiting approval), under review (being evaluated), approved (finalized), active (in use), closed (period ended), or superseded (replaced by newer version). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|active|closed|superseded — 7 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the budget by planning cycle: annual operating budget, quarterly forecast, monthly budget, rolling forecast, reforecast, or capital expenditure budget.. Valid values are `annual|quarterly|monthly|rolling_forecast|reforecast|capital`',
    `budgeted_adr` DECIMAL(18,2) COMMENT 'Forecasted Average Daily Rate for the budget period. Calculated as rooms revenue divided by rooms sold. Key rooms division KPI.',
    `budgeted_available_rooms` STRING COMMENT 'Forecasted total number of room nights available for sale during the budget period. Accounts for planned renovations and out-of-order rooms.',
    `budgeted_covers` STRING COMMENT 'Forecasted total number of F&B covers (guests served) for the budget period. Key volume metric for food and beverage operations.',
    `budgeted_cpor` DECIMAL(18,2) COMMENT 'Forecasted Cost Per Occupied Room for the budget period. Calculated as total departmental expenses divided by rooms sold. Measures cost efficiency.',
    `budgeted_ebitda` DECIMAL(18,2) COMMENT 'Forecasted EBITDA for the budget period. Represents operating profitability before financing and non-cash charges.',
    `budgeted_events_revenue` DECIMAL(18,2) COMMENT 'Forecasted total events and meetings revenue for the budget period. Includes MICE (Meetings, Incentives, Conferences, Exhibitions) revenue.',
    `budgeted_fnb_revenue` DECIMAL(18,2) COMMENT 'Forecasted total food and beverage revenue for the budget period. Includes restaurant, bar, banquet, and room service revenue.',
    `budgeted_gop` DECIMAL(18,2) COMMENT 'Forecasted Gross Operating Profit for the budget period. Calculated as total revenue minus departmental expenses and undistributed operating expenses. Key profitability metric per USALI.',
    `budgeted_goppar` DECIMAL(18,2) COMMENT 'Forecasted Gross Operating Profit Per Available Room for the budget period. Calculated as GOP divided by available rooms. Measures profitability efficiency.',
    `budgeted_labor_expense` DECIMAL(18,2) COMMENT 'Forecasted total labor costs including wages, salaries, benefits, and payroll taxes for the budget period.',
    `budgeted_noi` DECIMAL(18,2) COMMENT 'Forecasted Net Operating Income for the budget period. Represents property-level profitability after all operating expenses but before debt service and taxes.',
    `budgeted_occupancy_rate` DECIMAL(18,2) COMMENT 'Forecasted occupancy rate as a percentage for the budget period. Calculated as rooms sold divided by rooms available. Key demand metric.',
    `budgeted_operating_expense` DECIMAL(18,2) COMMENT 'Forecasted total operating expenses excluding labor for the budget period. Includes utilities, supplies, maintenance, and other departmental expenses.',
    `budgeted_other_revenue` DECIMAL(18,2) COMMENT 'Forecasted revenue from other sources (spa, parking, telecommunications, etc.) for the budget period.',
    `budgeted_revpar` DECIMAL(18,2) COMMENT 'Forecasted Revenue Per Available Room for the budget period. Calculated as rooms revenue divided by available rooms, or ADR multiplied by occupancy rate. Primary revenue performance metric.',
    `budgeted_room_nights` STRING COMMENT 'Forecasted total number of room nights sold for the budget period. Key volume metric for rooms division.',
    `budgeted_rooms_revenue` DECIMAL(18,2) COMMENT 'Forecasted total rooms revenue for the budget period. Key metric for rooms division performance planning.',
    `budgeted_total_revenue` DECIMAL(18,2) COMMENT 'Forecasted total revenue across all departments for the budget period. Sum of rooms, F&B, events, and other revenue.',
    `budgeted_trevpar` DECIMAL(18,2) COMMENT 'Forecasted Total Revenue Per Available Room for the budget period. Calculated as total property revenue divided by available rooms. Measures total revenue productivity.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this budget ceases to be effective. Null for open-ended budgets.',
    `effective_start_date` DATE COMMENT 'The date from which this budget becomes effective and active for planning and variance analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was last updated. Supports change tracking and audit trail.',
    `notes` STRING COMMENT 'Free-text notes and commentary regarding budget assumptions, variances from prior periods, strategic initiatives, or special considerations.',
    `version` STRING COMMENT 'Version identifier for the budget (e.g., V1.0, V2.1 Reforecast). Supports tracking of budget revisions and reforecasts.',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Annual and periodic financial budget master representing planned and forecasted financial targets at both header and line-item granularity. Each budget contains line items by GL account, cost center, profit center, and fiscal period combination. Supports approved annual budgets, rolling forecasts, and reforecasts (distinguished by budget type/version). Captures budgeted revenue (rooms, F&B, events), budgeted expenses (labor, CPOR, FF&E reserve contributions), and budgeted KPIs (ADR, OCC, RevPAR, GOP, EBITDA, NOI). Enables granular budget-vs-actual and forecast-vs-actual variance analysis at the account, department, and property level. Supports USALI departmental budget reporting and management review. Sourced from SAP S/4HANA Planning and Budgeting module.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique identifier for the budget line item. Primary key.',
    `budget_id` BIGINT COMMENT 'Reference to the parent budget header to which this line item belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget lines are allocated to cost centers for departmental budget planning. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to enable joining to cost cen',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Budget line items are allocated to specific fiscal periods for granular period-level budget tracking. The budget_line table currently stores fiscal_period (INT) and fiscal_year (INT) as denormalized s',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Outlet-level budget allocation: F&B budget lines are allocated to specific outlets for departmental P&L budgeting, USALI outlet-level reporting, and budget vs. actual variance analysis. Hospitality fi',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Budget lines are planned for specific GL accounts in the chart of accounts. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account master da',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budget lines are allocated to profit centers for revenue-generating business unit budget planning. The profit_center_code STRING should be replaced with a proper FK to profit_center.profit_center_id t',
    `property_id` BIGINT COMMENT 'Reference to the property for which this budget line is planned. Enables property-level budget tracking and consolidation.',
    `allocation_driver` STRING COMMENT 'The driver or basis used for allocation if allocation_method is driver-based. Examples include room nights, square footage, headcount, or revenue percentage.',
    `allocation_method` STRING COMMENT 'The method used to allocate this budget line to the cost center or profit center. Supports transparency in budget allocation logic.. Valid values are `direct|allocated|prorated|driver_based`',
    `approval_status` STRING COMMENT 'The current approval status of this budget line. Supports budget workflow and SOX financial controls.. Valid values are `draft|pending_approval|approved|rejected|locked`',
    `approved_by` STRING COMMENT 'The name or identifier of the individual who approved this budget line. Supports audit trail and SOX compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this budget line was approved. Supports audit trail and SOX compliance.',
    `budget_category` STRING COMMENT 'High-level classification of the budget line. Distinguishes between revenue, operating expenses, fixed expenses, and capital expenditures per USALI standards.. Valid values are `revenue|operating_expense|fixed_expense|capital_expenditure`',
    `budget_owner` STRING COMMENT 'The name or identifier of the individual or role responsible for this budget line. Supports accountability and budget governance.',
    `budget_type` STRING COMMENT 'The type of budget this line belongs to. Supports multiple budget scenarios for planning and variance analysis.. Valid values are `original|revised|forecast|rolling_forecast|stretch`',
    `budget_version` STRING COMMENT 'The version identifier for this budget line. Supports multiple budget scenarios such as original budget, revised budget, forecast, or rolling forecast.. Valid values are `^[A-Z0-9_]{1,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget line record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the planned amount. Supports multi-currency budget planning and consolidation.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'The department code to which this budget line is allocated. Aligns with USALI departmental structure such as Rooms, Food and Beverage, Sales and Marketing, Property Operations and Maintenance.. Valid values are `^[A-Z0-9]{2,10}$`',
    `effective_end_date` DATE COMMENT 'The date until which this budget line remains effective. Null indicates the budget line is currently active.',
    `effective_start_date` DATE COMMENT 'The date from which this budget line becomes effective. Supports temporal budget management and mid-year budget changes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget line record was last modified. Supports audit trail and change tracking.',
    `line_item_number` STRING COMMENT 'Sequential line item number within the parent budget. Used for ordering and referencing individual budget lines.',
    `locked_flag` BOOLEAN COMMENT 'Indicates whether this budget line is locked from further edits. True if locked, False if editable. Supports budget freeze and SOX controls.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context or justification for this budget line. Used for management review and audit trail.',
    `planned_amount` DECIMAL(18,2) COMMENT 'The budgeted monetary amount for this GL account, cost center, profit center, and fiscal period combination. Represents the planned expense or revenue target.',
    `prior_year_actual_amount` DECIMAL(18,2) COMMENT 'The actual amount from the prior fiscal year for the same GL account, cost center, and fiscal period. Used for year-over-year budget comparison and trend analysis.',
    `quantity` DECIMAL(18,2) COMMENT 'The planned quantity associated with this budget line, if applicable. Used for volume-based budgeting such as room nights, covers, or headcount.',
    `source_system` STRING COMMENT 'The name of the source system from which this budget line was loaded. Typically SAP S/4HANA or other ERP system.',
    `source_system_code` STRING COMMENT 'The unique identifier of this budget line in the source system. Supports data lineage and reconciliation.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the budget quantity field. Examples include ROOM_NIGHTS, COVERS, FTE (Full-Time Equivalent), UNITS.. Valid values are `^[A-Z]{2,10}$`',
    `unit_price` DECIMAL(18,2) COMMENT 'The planned unit price or rate used to calculate the planned amount. Derived from planned_amount divided by quantity.',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'The acceptable variance threshold percentage for this budget line. Used to flag significant budget-vs-actual variances for management review.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Individual budget line item within a financial budget, capturing the planned amount for a specific GL account, cost center, profit center, and fiscal period combination. Enables granular budget-vs-actual variance analysis at the account and department level. Supports USALI departmental budget reporting and management review. Sourced from SAP S/4HANA budget line items.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key for the fixed asset master data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fixed assets are allocated to cost centers for departmental asset tracking and depreciation allocation. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Fixed assets post to GL accounts for asset capitalization and depreciation tracking. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account ',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Capital assets (built-in AV, movable partitions, staging equipment) are attributed to specific meeting spaces for USALI departmental depreciation and capex tracking. A hospitality finance controller e',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Fixed assets (HVAC, kitchen equipment, pool systems) are physically located in specific facilities. Real asset management requires location tracking for maintenance scheduling, depreciation allocation',
    `property_id` BIGINT COMMENT 'Reference to the property or business unit where this fixed asset is located and capitalized.',
    `property_outlet_id` BIGINT COMMENT 'Foreign key linking to property.property_outlet. Business justification: Kitchen equipment, POS hardware, and F&B furniture are fixed assets attributed to specific outlets for USALI F&B department depreciation and capex reporting. Outlet-level asset tracking is standard in',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since the asset was placed in service.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total capitalized cost of acquiring the fixed asset, including purchase price, installation, and directly attributable costs.',
    `acquisition_date` DATE COMMENT 'Date when the fixed asset was acquired or placed into service for accounting purposes.',
    `asset_category` STRING COMMENT 'Detailed sub-classification or category within the asset class for granular reporting and analysis.',
    `asset_class` STRING COMMENT 'Classification of the fixed asset type. FF&E refers to Furniture, Fixtures, and Equipment. [ENUM-REF-CANDIDATE: building|ffe|technology_system|leasehold_improvement|land|vehicle|equipment — 7 candidates stripped; promote to reference product]',
    `asset_name` STRING COMMENT 'Human-readable name or description of the fixed asset.',
    `asset_number` STRING COMMENT 'Externally-known unique asset tag or identification number assigned to the fixed asset for tracking and inventory purposes.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset indicating its operational state and accounting treatment. [ENUM-REF-CANDIDATE: active|in_service|under_construction|retired|disposed|impaired|held_for_sale — 7 candidates stripped; promote to reference product]',
    `capex_approval_status` STRING COMMENT 'Approval status of the CapEx request associated with this fixed asset acquisition.. Valid values are `pending|approved|rejected|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixed asset record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost and financial amounts.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate depreciation expense for this fixed asset.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits`',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation calculation begins for this fixed asset, typically the in-service date.',
    `disposal_date` DATE COMMENT 'Date when the fixed asset was disposed of, sold, retired, or otherwise removed from service.',
    `disposal_method` STRING COMMENT 'Method by which the fixed asset was disposed of or removed from the asset register.. Valid values are `sale|scrap|donation|trade_in|retirement`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Amount received from the sale or disposal of the fixed asset.',
    `ffe_reserve_eligible` BOOLEAN COMMENT 'Indicates whether this asset is eligible for FF&E reserve funding, typically used for planned replacement programs.',
    `gain_loss_on_disposal` DECIMAL(18,2) COMMENT 'Calculated gain or loss on disposal, computed as disposal proceeds minus net book value at disposal date.',
    `impairment_indicator` BOOLEAN COMMENT 'Flag indicating whether the asset has been tested for impairment or shows indicators of impairment.',
    `impairment_loss` DECIMAL(18,2) COMMENT 'Amount of impairment loss recognized when the recoverable amount of the asset is less than its carrying value.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number covering this fixed asset, if separately insured.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance or service performed on the fixed asset.',
    `location_description` STRING COMMENT 'Physical location or room number where the fixed asset is installed or stored within the property.',
    `manufacturer` STRING COMMENT 'Name of the manufacturer or brand of the fixed asset.',
    `model_number` STRING COMMENT 'Model number or product code of the fixed asset as designated by the manufacturer.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixed asset record was last modified or updated.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the fixed asset calculated as acquisition cost minus accumulated depreciation.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the fixed asset, including special handling, history, or other relevant information.',
    `pip_reference` STRING COMMENT 'Reference to the Property Improvement Plan under which this asset was acquired or renovated, if applicable.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life, not subject to depreciation.',
    `serial_number` STRING COMMENT 'Manufacturer serial number or unique identifier for the physical asset, if applicable.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the fixed asset in years for depreciation calculation purposes.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or vendor warranty for this fixed asset expires.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master representing the full lifecycle of capitalized property assets from CapEx request through acquisition, depreciation, and disposal. Covers buildings, FF&E (Furniture, Fixtures and Equipment), technology systems, and leasehold improvements. Tracks asset class, PIP (Property Improvement Plan) reference, CapEx approval status, acquisition date, acquisition cost, useful life, depreciation method and schedule, accumulated depreciation, net book value, and disposal status. Supports CapEx planning, depreciation posting to GL, EBITDA calculation (D&A add-back), FF&E reserve tracking, and IFRS/GAAP asset reporting. Sourced from SAP S/4HANA Asset Accounting (FI-AA).';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` (
    `tax_posting_id` BIGINT COMMENT 'Unique identifier for the tax posting transaction record.',
    `banquet_event_order_id` BIGINT COMMENT 'Foreign key linking to fnb.banquet_event_order. Business justification: Event tax compliance: Banquet events involve complex tax scenarios (service charges, gratuity, food vs. beverage tax rates). Tax postings must reference the source BEO for tax filing, audit defense, a',
    `booking_package_id` BIGINT COMMENT 'Foreign key linking to reservation.booking_package. Business justification: Bundled packages (room + F&B + spa) have distinct tax treatments per component under tax compliance rules. Linking tax_posting to booking_package enables package-level tax allocation reporting, audit ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tax postings are allocated to cost centers for departmental tax expense tracking. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to enable joining to cos',
    `discount_id` BIGINT COMMENT 'Foreign key linking to fnb.discount. Business justification: Discount tax base reconciliation: F&B discounts reduce the taxable base amount. Tax postings on discounted transactions must reference the applied discount for tax authority audits, accurate tax base ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Tax postings (VAT/GST, occupancy tax) are recorded against fiscal periods for tax filing and period-close reporting. The tax_posting table currently stores fiscal_period (INT) and fiscal_year (INT) as',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Tax postings post to GL accounts for tax liability and expense tracking. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account master data ',
    `pos_check_id` BIGINT COMMENT 'Foreign key linking to fnb.pos_check. Business justification: Tax compliance and audit: F&B tax postings must be traceable to the originating POS check for USALI tax reconciliation, sales tax filing, and internal audit. Hospitality tax auditors routinely require',
    `pos_check_line_id` BIGINT COMMENT 'Foreign key linking to fnb.pos_check_line. Business justification: Line-level tax audit traceability: Detailed tax postings (e.g., split tax rates by item category) must reference the specific POS check line. Required for itemized tax returns, tax authority audits, a',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile for occupancy tax and transient occupancy tax postings.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Tax postings reference revenue centers for tax allocation. The revenue_center_code STRING should be replaced with a proper FK. Note: The target is profit_center because the existing FK profit_center.r',
    `property_id` BIGINT COMMENT 'Reference to the property where the tax transaction originated.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the reservation for room-related tax postings.',
    `reservation_group_block_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_group_block. Business justification: Group master folios generate tax postings at the block level (attrition penalties, master billing taxes). Linking tax_posting to reservation_group_block enables group-level tax compliance reporting, s',
    `reversed_posting_tax_posting_id` BIGINT COMMENT 'Reference to the original tax posting ID that this record reverses, if applicable.',
    `room_service_order_id` BIGINT COMMENT 'Foreign key linking to fnb.room_service_order. Business justification: Room service tax traceability: Tax postings on room service revenue must reference the source order for tax compliance, audit, and reconciliation of in-room dining tax obligations. Standard hospitalit',
    `stay_history_id` BIGINT COMMENT 'Foreign key linking to guest.stay_history. Business justification: Occupancy tax, city tax, and VAT postings are generated per stay for government regulatory filing. tax_posting already has reservation_booking_id and profile_id but lacks a direct stay_history link ne',
    `void_transaction_id` BIGINT COMMENT 'Foreign key linking to fnb.void_transaction. Business justification: Void tax reversal traceability: When F&B transactions are voided, tax postings must be reversed and linked to the void transaction for tax audit defense, period-close tax reconciliation, and regulator',
    `adjustment_reason` STRING COMMENT 'Explanation for any adjustment, correction, or reversal of the tax posting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this tax posting record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the tax amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `document_number` STRING COMMENT 'The externally-known unique document number for this tax posting, used for audit trail and reconciliation.',
    `due_date` DATE COMMENT 'The regulatory due date by which this tax must be filed and paid to avoid penalties.',
    `exemption_certificate_number` STRING COMMENT 'The certificate or authorization number supporting the tax exemption claim, if applicable.',
    `exemption_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this transaction qualifies for tax exemption.',
    `filing_date` DATE COMMENT 'The date when the tax return or report was filed with the tax authority.',
    `filing_status` STRING COMMENT 'The current status of the tax filing and payment lifecycle: pending (not yet filed), filed (submitted to authority), paid (remitted), overdue (past due date), disputed (under review), or adjusted (corrected after filing).. Valid values are `pending|filed|paid|overdue|disputed|adjusted`',
    `jurisdiction_code` STRING COMMENT 'The standardized code representing the tax jurisdiction for system processing and reporting.',
    `modified_by` STRING COMMENT 'The user ID or system identifier that last modified this tax posting record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this tax posting record was last modified in the system.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to this tax posting for audit and compliance purposes.',
    `payment_date` DATE COMMENT 'The date when the tax amount was remitted to the tax authority.',
    `posting_date` DATE COMMENT 'The date when the tax transaction was posted to the general ledger.',
    `reporting_period` STRING COMMENT 'The tax reporting period identifier (e.g., monthly, quarterly, annually) for regulatory filing purposes.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this tax posting is a reversal or correction of a previous posting.',
    `source_document_number` STRING COMMENT 'The reference number of the source document (e.g., folio number, invoice number, check number) that originated this tax transaction.',
    `source_document_type` STRING COMMENT 'The type of source document that generated this tax posting: guest folio (room charges), F&B check, event invoice, vendor invoice, adjustment, or other.. Valid values are `guest_folio|fnb_check|event_invoice|vendor_invoice|adjustment|other`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount posted to the general ledger for this transaction.',
    `tax_base_amount` DECIMAL(18,2) COMMENT 'The gross taxable amount upon which the tax is calculated, before tax is applied.',
    `tax_code` STRING COMMENT 'The tax code identifier that defines the tax type, rate, and calculation method (e.g., VAT, GST, TOT, sales tax).',
    `tax_jurisdiction` STRING COMMENT 'The governmental jurisdiction or authority to which this tax is owed (e.g., federal, state, county, city, municipality).',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'The tax rate percentage applied to the tax base amount to calculate the tax amount.',
    `tax_type` STRING COMMENT 'The category of tax being posted: VAT (Value Added Tax), GST (Goods and Services Tax), occupancy tax, TOT (Transient Occupancy Tax), sales tax on F&B and events, withholding tax on vendor payments, service tax, resort fee tax, or other. [ENUM-REF-CANDIDATE: VAT|GST|occupancy_tax|TOT|sales_tax|withholding_tax|service_tax|resort_fee_tax|other — 9 candidates stripped; promote to reference product]',
    `transaction_date` DATE COMMENT 'The actual business date when the taxable transaction occurred (e.g., guest check-out date, F&B sale date).',
    `created_by` STRING COMMENT 'The user ID or system identifier that created this tax posting record.',
    CONSTRAINT pk_tax_posting PRIMARY KEY(`tax_posting_id`)
) COMMENT 'Tax transaction record capturing all tax-related financial postings including VAT/GST, occupancy tax, transient occupancy tax (TOT), sales tax on F&B and events, and withholding tax on vendor payments. Tracks tax code, tax base amount, tax amount, tax jurisdiction, reporting period, and filing status. Supports regulatory tax compliance and multi-jurisdiction reporting. Sourced from SAP S/4HANA Tax module.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the bank account record. Primary key.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Bank accounts are linked to GL accounts for bank reconciliation and cash management. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account ',
    `master_account_bank_account_id` BIGINT COMMENT 'Reference to the master bank account for zero balance account (ZBA) cash pooling arrangements. Null if this is not a ZBA or if this is the master account.',
    `ownership_entity_id` BIGINT COMMENT 'Foreign key linking to property.ownership_entity. Business justification: Bank accounts are held by legal ownership entities (REITs, LLCs, investment vehicles). Treasury management and entity-level cash reporting require bank accounts to be attributed to ownership entities ',
    `property_id` BIGINT COMMENT 'Reference to the property or corporate entity that owns this bank account. Links to property master data.',
    `account_closed_date` DATE COMMENT 'The date the bank account was closed, if applicable. Null for active accounts.',
    `account_name` STRING COMMENT 'The legal name or title of the bank account as registered with the financial institution.',
    `account_number` STRING COMMENT 'The full bank account number. Stored in masked or encrypted format for security and PCI DSS compliance.',
    `account_number_masked` STRING COMMENT 'Partially masked account number for display purposes (e.g., ****1234). Used in reports and user interfaces to protect sensitive data.',
    `account_opened_date` DATE COMMENT 'The date the bank account was originally opened with the financial institution.',
    `account_purpose` STRING COMMENT 'Description of the primary business purpose or use case for this bank account (e.g., AP disbursements, AR collections, payroll funding, property operating account).',
    `account_status` STRING COMMENT 'Current lifecycle status of the bank account. Active accounts are available for transactions; inactive or closed accounts are not.. Valid values are `active|inactive|closed|suspended|pending_activation`',
    `account_type` STRING COMMENT 'Classification of the bank account by its primary purpose (checking, savings, money market, payroll, escrow, investment).. Valid values are `checking|savings|money_market|payroll|escrow|investment`',
    `ach_enabled` BOOLEAN COMMENT 'Indicates whether ACH transactions (direct deposits, electronic payments) are enabled for this account.',
    `available_balance` DECIMAL(18,2) COMMENT 'The available balance for disbursements, net of holds, pending transactions, and minimum balance requirements.',
    `bank_branch_name` STRING COMMENT 'The name of the specific bank branch where the account is held.',
    `bank_code` STRING COMMENT 'Unique identifier or code for the bank, often used in internal systems or for integration with treasury management systems.',
    `bank_contact_email` STRING COMMENT 'The email address of the primary bank contact. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `bank_contact_name` STRING COMMENT 'The name of the primary contact person at the bank for account inquiries and issue resolution.',
    `bank_contact_phone` STRING COMMENT 'The phone number of the primary bank contact. Organizational contact data classified as confidential.',
    `bank_name` STRING COMMENT 'The legal name of the financial institution holding the account.',
    `company_code` STRING COMMENT 'The SAP company code or equivalent organizational unit to which this bank account is assigned. Used for financial consolidation and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the account (e.g., USD, EUR, GBP). Supports multi-currency cash pooling and treasury management.. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'The current balance of the bank account as of the last update or reconciliation. Reflects all posted transactions.',
    `electronic_banking_enabled` BOOLEAN COMMENT 'Indicates whether electronic banking services (ACH, wire transfers, electronic statements) are enabled for this account.',
    `iban` STRING COMMENT 'The International Bank Account Number for accounts in jurisdictions that use IBAN for international transactions.',
    `interest_bearing` BOOLEAN COMMENT 'Indicates whether this account earns interest on deposited funds.',
    `interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate applied to the account balance, expressed as a decimal (e.g., 0.0250 for 2.50%). Null for non-interest-bearing accounts.',
    `is_primary_account` BOOLEAN COMMENT 'Indicates whether this is the primary operating bank account for the property or company code. Used for default account selection in AP and AR processes.',
    `is_zero_balance_account` BOOLEAN COMMENT 'Indicates whether this is a zero balance account that automatically sweeps funds to or from a master account for cash concentration.',
    `last_reconciliation_date` DATE COMMENT 'The date of the most recent bank reconciliation for this account. Critical for SOX compliance and financial controls.',
    `last_statement_balance` DECIMAL(18,2) COMMENT 'The ending balance reported on the most recent bank statement. Used as the baseline for reconciliation.',
    `last_statement_date` DATE COMMENT 'The date of the most recent bank statement received for this account. Used for reconciliation and cash flow tracking.',
    `minimum_balance_required` DECIMAL(18,2) COMMENT 'The minimum balance that must be maintained in the account per bank agreement or internal treasury policy.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or comments about the bank account.',
    `opening_balance` DECIMAL(18,2) COMMENT 'The opening balance of the bank account at the start of the current fiscal period or reconciliation cycle.',
    `positive_pay_enabled` BOOLEAN COMMENT 'Indicates whether positive pay fraud prevention service is enabled. Positive pay matches issued checks against a list to prevent fraudulent checks from clearing.',
    `reconciliation_status` STRING COMMENT 'Current status of the bank reconciliation process. Tracks whether the account has been reconciled, has discrepancies, or is pending review.. Valid values are `reconciled|pending|discrepancy|not_started`',
    `routing_number` STRING COMMENT 'The ABA routing number (US) or equivalent bank routing code used for electronic funds transfers and wire transactions.',
    `swift_code` STRING COMMENT 'The SWIFT/BIC code for international wire transfers. Used for cross-border payments and multi-currency transactions.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `wire_transfer_enabled` BOOLEAN COMMENT 'Indicates whether domestic and international wire transfers are enabled for this account.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Bank account master representing property and corporate bank accounts used for cash management, AP disbursements, AR collections, and payroll funding. Tracks bank name, account number (masked), account type, currency, bank routing details, account status, assigned company code, last reconciliation date, reconciliation status, opening/closing balances, and reconciliation history. Supports treasury management, cash flow visibility, automated bank statement reconciliation (SOX control evidence), multi-currency cash pooling, and daily cash position reporting. Sourced from SAP S/4HANA Bank Master Data and Electronic Bank Statement module.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`management_fee` (
    `management_fee_id` BIGINT COMMENT 'Unique identifier for the management fee calculation record. Primary key. Role: TRANSACTION_HEADER.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Management fees are allocated to cost centers for departmental expense tracking. The cost_center_code STRING should be replaced with a proper FK to cost_center.cost_center_id to enable joining to cost',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Management fees are calculated and recorded on a periodic basis aligned to fiscal periods. The management_fee table currently stores fiscal_period (INT) and fiscal_year (INT) as denormalized scalar fi',
    `hma_contract_id` BIGINT COMMENT 'Reference to the Hotel Management Agreement contract that governs the terms and conditions of this management fee.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Management fees post to GL accounts for expense tracking and P&L reporting. The gl_account_code STRING should be replaced with a proper FK to ledger.ledger_id to enable joining to GL account master da',
    `ownership_entity_id` BIGINT COMMENT 'Reference to the property owner entity that is being charged the management fee under the Hotel Management Agreement (HMA).',
    `primary_reversed_fee_management_fee_id` BIGINT COMMENT 'Reference to the original management fee record that this entry reverses, if applicable.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Management fees are allocated to profit centers for revenue-generating business unit expense tracking. The profit_center_code STRING should be replaced with a proper FK to profit_center.profit_center_',
    `property_id` BIGINT COMMENT 'Reference to the hotel property for which the management fee is calculated.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any adjustments applied to the calculated management fee (e.g., prior period corrections, contractual adjustments, dispute resolutions).',
    `adjustment_reason` STRING COMMENT 'Business reason or explanation for any adjustment applied to the management fee amount.',
    `approval_status` STRING COMMENT 'Approval status of the management fee calculation, indicating whether it has been reviewed and approved by authorized personnel.. Valid values are `pending|approved|rejected|under_review`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the management fee calculation was approved.',
    `basis_amount` DECIMAL(18,2) COMMENT 'The actual financial amount (gross revenue, GOP, NOI, etc.) used as the calculation basis for this management fee, in the propertys functional currency.',
    `calculation_basis` STRING COMMENT 'The financial metric used as the basis for calculating the management fee amount, as defined in the Hotel Management Agreement (HMA). [ENUM-REF-CANDIDATE: gross_revenue|total_revenue|rooms_revenue|gop|noi|ebitda|adjusted_gop|custom — 8 candidates stripped; promote to reference product]',
    `calculation_date` DATE COMMENT 'Date when the management fee was calculated, representing the principal business event timestamp for this transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this management fee record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the management fee transaction.. Valid values are `^[A-Z]{3}$`',
    `fee_amount` DECIMAL(18,2) COMMENT 'The calculated management fee amount charged to the property owner, in the propertys functional currency.',
    `fee_number` STRING COMMENT 'Externally-known unique identifier or document number for this management fee calculation, used for owner reporting and audit trail.',
    `fee_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage rate applied to the calculation basis to determine the management fee amount, as specified in the Hotel Management Agreement (HMA).',
    `fee_status` STRING COMMENT 'Current lifecycle status of the management fee calculation and payment process. [ENUM-REF-CANDIDATE: draft|calculated|approved|invoiced|paid|disputed|reversed — 7 candidates stripped; promote to reference product]',
    `fee_type` STRING COMMENT 'Classification of the management fee type per the Hotel Management Agreement (HMA). Base fee is typically a percentage of gross revenue; incentive fee is typically a percentage of GOP (Gross Operating Profit) or NOI (Net Operating Income).. Valid values are `base_fee|incentive_fee|combined_fee|special_fee|termination_fee|transition_fee`',
    `intercompany_indicator` BOOLEAN COMMENT 'Flag indicating whether this management fee represents an intercompany transaction requiring elimination in consolidated financial statements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this management fee record was last modified or updated.',
    `net_fee_amount` DECIMAL(18,2) COMMENT 'Final net management fee amount after all adjustments, representing the amount due to the management company.',
    `notes` STRING COMMENT 'Additional notes, comments, or explanations related to the management fee calculation, payment, or any special circumstances.',
    `payment_date` DATE COMMENT 'Actual date when the management fee was paid by the property owner.',
    `payment_due_date` DATE COMMENT 'Date by which the management fee payment is due from the property owner per the Hotel Management Agreement (HMA) payment terms.',
    `payment_reference_number` STRING COMMENT 'Reference number or transaction identifier for the payment received from the property owner.',
    `payment_status` STRING COMMENT 'Current payment status of the management fee, tracking whether the owner has remitted payment.. Valid values are `pending|paid|partial|overdue|waived|disputed`',
    `period_end_date` DATE COMMENT 'End date of the performance period covered by this management fee calculation.',
    `period_start_date` DATE COMMENT 'Start date of the performance period covered by this management fee calculation.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this management fee record represents a reversal or correction of a previously recorded fee.',
    `reversal_reason` STRING COMMENT 'Business reason or explanation for reversing the management fee calculation.',
    `source_document_reference` STRING COMMENT 'Reference to the source document or transaction in the originating system that generated this management fee record.',
    `source_system` STRING COMMENT 'Name of the source system from which the management fee record originated (e.g., SAP S/4HANA, owner accounting system).',
    `sox_control_flag` BOOLEAN COMMENT 'Flag indicating whether this management fee transaction is subject to SOX financial controls and audit requirements for publicly traded entities.',
    CONSTRAINT pk_management_fee PRIMARY KEY(`management_fee_id`)
) COMMENT 'Management fee calculation record representing periodic fees charged by the hotel management company to property owners under Hotel Management Agreements (HMA). Tracks fee type (base fee as % of gross revenue, incentive fee as % of GOP/NOI), calculation basis, fee amount, payment schedule, owner entity, and fiscal period. Critical for owner reporting, P&L accuracy, and intercompany elimination in consolidated statements. Sourced from SAP S/4HANA and owner accounting systems.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`hma_contract` (
    `hma_contract_id` BIGINT COMMENT 'Primary key for hma_contract',
    `brand_id` BIGINT COMMENT 'Identifier of the hotel brand under which the property operates as specified in the management agreement.',
    `ownership_entity_id` BIGINT COMMENT 'Identifier of the property owner party who is the counterparty to this hotel management agreement contract.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property or resort covered under this management agreement contract.',
    `superseded_hma_contract_id` BIGINT COMMENT 'Self-referencing FK on hma_contract (superseded_hma_contract_id)',
    `accounting_standard` STRING COMMENT 'Financial accounting standard framework required for property financial reporting under the contract, such as USALI, US GAAP, or IFRS.',
    `amendment_count` STRING COMMENT 'Total number of formal amendments or modifications executed since the original contract signing.',
    `assignment_rights_flag` BOOLEAN COMMENT 'Indicates whether either party has the right to assign or transfer the contract to a third party without consent.',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether the owner has contractual rights to audit the operators books and records related to property operations and fee calculations.',
    `base_management_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of gross operating revenue or other defined base that the operator receives as base management fee under the contract terms.',
    `budget_approval_authority` STRING COMMENT 'Party or governance structure with authority to approve annual operating budgets and capital expenditure plans for the property.',
    `capital_expenditure_reserve_percentage` DECIMAL(18,2) COMMENT 'Percentage of gross revenue required to be set aside annually for capital expenditure and furniture, fixtures, and equipment (FF&E) reserves.',
    `confidentiality_period_years` STRING COMMENT 'Duration in years that confidentiality obligations survive after contract termination or expiration.',
    `contract_name` STRING COMMENT 'Human-readable name or title of the hotel management agreement contract, typically including property name and agreement type.',
    `contract_notes` STRING COMMENT 'Free-form text field for additional notes, special provisions, or contextual information about the hotel management agreement contract.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the hotel management agreement contract, typically formatted as HMA- followed by numeric sequence.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the hotel management agreement contract indicating its operational state.',
    `contract_type` STRING COMMENT 'Classification of the hotel management agreement type defining the operational and financial relationship structure between parties.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which contract fees and financial obligations are denominated.',
    `data_classification` STRING COMMENT 'Classification level of the contract data indicating sensitivity and access control requirements per organizational data governance policy.',
    `dispute_resolution_method` STRING COMMENT 'Primary method specified in the contract for resolving disputes between owner and operator parties.',
    `effective_date` DATE COMMENT 'Date when the hotel management agreement contract becomes legally binding and operational obligations commence.',
    `expiration_date` DATE COMMENT 'Date when the hotel management agreement contract term ends and obligations cease, unless renewed or extended. Nullable for evergreen contracts.',
    `fee_calculation_basis` STRING COMMENT 'The financial metric or basis upon which management fees are calculated, such as gross operating revenue, gross operating profit, or adjusted gross operating profit.',
    `force_majeure_clause_flag` BOOLEAN COMMENT 'Indicates whether the contract includes force majeure provisions that excuse performance obligations during extraordinary events beyond parties control.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law specified in the contract for dispute resolution and contract interpretation.',
    `incentive_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of gross operating profit (GOP) or adjusted gross operating profit (AGOP) that the operator receives as incentive fee when performance thresholds are met.',
    `indemnification_cap_amount` DECIMAL(18,2) COMMENT 'Maximum liability amount for indemnification obligations between parties under the contract terms, if capped.',
    `insurance_responsibility` STRING COMMENT 'Party responsible for procuring and maintaining required property and liability insurance coverage under the contract.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the original contract terms, if any amendments have been executed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was most recently updated or modified in the system.',
    `minimum_annual_fee_amount` DECIMAL(18,2) COMMENT 'Guaranteed minimum annual management fee amount payable to the operator regardless of property performance, if applicable.',
    `non_compete_period_years` STRING COMMENT 'Duration in years of non-compete restrictions applicable to parties after contract termination, if specified.',
    `performance_test_flag` BOOLEAN COMMENT 'Indicates whether the contract includes performance test provisions that allow the owner to terminate if specified performance metrics are not met.',
    `renewal_option_count` STRING COMMENT 'Number of renewal option periods available to extend the contract beyond the initial term.',
    `renewal_option_years` STRING COMMENT 'Duration in years of each renewal option period if the contract is extended.',
    `reporting_frequency` STRING COMMENT 'Required frequency for financial and operational reporting from operator to owner under the contract terms.',
    `signed_date` DATE COMMENT 'Date when the hotel management agreement contract was executed and signed by all parties.',
    `term_years` STRING COMMENT 'Initial term duration of the hotel management agreement contract expressed in years.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the contract under standard termination provisions.',
    `working_capital_amount` DECIMAL(18,2) COMMENT 'Initial working capital amount required to be provided or maintained for property operations under the contract terms.',
    CONSTRAINT pk_hma_contract PRIMARY KEY(`hma_contract_id`)
) COMMENT 'Master reference table for hma_contract. Referenced by hma_contract_id.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`finance`.`fiscal_period` (
    `fiscal_period_id` BIGINT COMMENT 'Primary key for fiscal_period',
    `primary_prior_year_period_fiscal_period_id` BIGINT COMMENT 'Reference to the corresponding fiscal period in the prior year. Used for year-over-year variance analysis and comparative financial reporting.',
    `budget_version` STRING COMMENT 'The budget version or scenario associated with this fiscal period (e.g., Original Budget, Revised Budget, Forecast). Used for budget vs actual variance analysis.',
    `business_days_in_period` STRING COMMENT 'Total number of business days (excluding weekends and holidays) in this fiscal period. Used for operational metrics and productivity calculations.',
    `calendar_month` STRING COMMENT 'The calendar month number (1-12) in which the period starts. Used for calendar-based reporting and seasonality analysis.',
    `calendar_quarter` STRING COMMENT 'The calendar quarter number (1-4) in which the period starts. Used for calendar-based comparisons and external benchmarking.',
    `calendar_year` STRING COMMENT 'The calendar year in which the period starts (e.g., 2024). May differ from fiscal_year for companies with non-calendar fiscal years.',
    `close_date` DATE COMMENT 'The actual date when the fiscal period was closed for transaction posting. Null if period is still open. Used for financial close tracking and SOX compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fiscal period record was first created in the system. Used for audit trail and data lineage tracking.',
    `days_in_period` STRING COMMENT 'Total number of calendar days in this fiscal period. Used for daily average calculations (e.g., Average Daily Rate, Revenue Per Available Room).',
    `end_date` DATE COMMENT 'The last calendar date included in this fiscal period. Defines the end boundary for transaction posting and financial reporting.',
    `fiscal_month` STRING COMMENT 'The fiscal month number within the fiscal year (1-12). Null for non-monthly periods. Used for monthly financial close and management reporting.',
    `fiscal_period_description` STRING COMMENT 'Additional descriptive text or notes about this fiscal period, including special circumstances, adjustments, or reporting considerations.',
    `fiscal_period_status` STRING COMMENT 'Current lifecycle status of the fiscal period. Open: period is active and transactions can be posted. Closed: period is closed for regular posting but can be reopened. Locked: period is finalized and cannot accept new transactions without special authorization. Archived: period is archived for historical reference only.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter number within the fiscal year (1-4). Null for non-quarterly periods. Used for quarterly financial reporting and SEC filings.',
    `fiscal_week` STRING COMMENT 'The fiscal week number within the fiscal year (1-52 or 1-53). Null for non-weekly periods. Used for weekly operational and revenue reporting in hospitality operations.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this period belongs (e.g., 2024). Used for year-over-year comparisons and annual financial statement consolidation.',
    `is_adjustment_period` BOOLEAN COMMENT 'Indicates whether this is a special adjustment period (e.g., Period 13) used for year-end adjustments and accruals. True if adjustment period, False if regular operating period.',
    `is_leap_year` BOOLEAN COMMENT 'Indicates whether this fiscal period falls within a leap year. True if leap year, False otherwise. Used for accurate daily average calculations.',
    `lock_date` DATE COMMENT 'The date when the fiscal period was locked and finalized. Null if period is not yet locked. Used for audit trail and financial statement finalization.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this fiscal period record was last modified. Used for audit trail and change tracking.',
    `period_code` STRING COMMENT 'Business identifier code for the fiscal period, typically formatted as YYYY-MM or YYYY-Pnn (e.g., 2024-01, 2024-P01). Used in financial reports and external communications.',
    `period_name` STRING COMMENT 'Human-readable name of the fiscal period (e.g., January 2024, Q1 2024, FY2024-P01). Used for display in reports and dashboards.',
    `period_number` STRING COMMENT 'Sequential period number within the fiscal year (e.g., 1-12 for monthly periods, 1-4 for quarterly periods). Used for period-to-period comparisons and trend analysis.',
    `period_type` STRING COMMENT 'Classification of the fiscal period granularity: month (standard monthly period), quarter (quarterly period), year (annual fiscal year), week (weekly period for operational reporting), or custom (non-standard period for special reporting needs).',
    `reopen_date` DATE COMMENT 'The date when a previously closed period was reopened for adjustments. Null if period has never been reopened. Used for audit trail and SOX compliance monitoring.',
    `reporting_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code used for financial reporting in this period (e.g., USD, EUR, GBP). Used for multi-currency consolidation.',
    `start_date` DATE COMMENT 'The first calendar date included in this fiscal period. Defines the beginning of the period for transaction posting and financial reporting.',
    CONSTRAINT pk_fiscal_period PRIMARY KEY(`fiscal_period_id`)
) COMMENT 'Master reference table for fiscal_period. Referenced by fiscal_period_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_management_fee_id` FOREIGN KEY (`management_fee_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`management_fee`(`management_fee_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_original_payment_ap_payment_id` FOREIGN KEY (`original_payment_ap_payment_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ap_payment`(`ap_payment_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_reversed_payment_ar_payment_id` FOREIGN KEY (`reversed_payment_ar_payment_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_payment`(`ar_payment_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_reversed_posting_tax_posting_id` FOREIGN KEY (`reversed_posting_tax_posting_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`tax_posting`(`tax_posting_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_master_account_bank_account_id` FOREIGN KEY (`master_account_bank_account_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_hma_contract_id` FOREIGN KEY (`hma_contract_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`hma_contract`(`hma_contract_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_primary_reversed_fee_management_fee_id` FOREIGN KEY (`primary_reversed_fee_management_fee_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`management_fee`(`management_fee_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`hma_contract` ADD CONSTRAINT `fk_finance_hma_contract_superseded_hma_contract_id` FOREIGN KEY (`superseded_hma_contract_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`hma_contract`(`hma_contract_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_primary_prior_year_period_fiscal_period_id` FOREIGN KEY (`primary_prior_year_period_fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= TAGS =========
ALTER SCHEMA `travel_hospitality_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `travel_hospitality_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` SET TAGS ('dbx_subdomain' = 'accounting_structure');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `account_category` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Category');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `account_subcategory` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Subcategory');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `balance_sheet_section` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Section');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `balance_sheet_section` SET TAGS ('dbx_value_regex' = 'current_assets|non_current_assets|current_liabilities|non_current_liabilities|equity');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Statement Classification');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_value_regex' = 'operating|investing|financing');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `consolidation_account` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `income_statement_section` SET TAGS ('dbx_business_glossary_term' = 'Income Statement Section');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `is_control_account` SET TAGS ('dbx_business_glossary_term' = 'Control Account Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Account Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `is_reconciliation_required` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Required Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `is_statistical` SET TAGS ('dbx_business_glossary_term' = 'Statistical Account Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `last_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Last Posting Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `ledger_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `normal_balance` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `normal_balance` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `posting_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Block Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'accounting_structure');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `audit_trail_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|activity_based|percentage|headcount|square_footage');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'revenue|support|administrative|overhead');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `department_category` SET TAGS ('dbx_business_glossary_term' = 'Department Category');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `department_category` SET TAGS ('dbx_value_regex' = 'operated|undistributed|fixed_charges');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `external_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `headcount_allocation` SET TAGS ('dbx_business_glossary_term' = 'Headcount Allocation');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `labor_cost_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Tracking Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `revenue_posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Posting Allowed Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform System of Accounts for the Lodging Industry (USALI) Department Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2,4}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'accounting_structure');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `ownership_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ownership Entity ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `revenue_center_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `is_revenue_generating` SET TAGS ('dbx_business_glossary_term' = 'Is Revenue Generating Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending_activation');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `room_count` SET TAGS ('dbx_business_glossary_term' = 'Room Count');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = 'luxury|premium|select_service|extended_stay|resort|other');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Short Name');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `star_rating` SET TAGS ('dbx_business_glossary_term' = 'Star Rating');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Check Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `revenue_center_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `capex_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Document Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^JE[0-9]{8,12}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Document Type');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'standard|allocation|intercompany|recurring|accrual|reversal');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Rate');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Partner Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Description');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Posting Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Posting Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|reversed|cancelled');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_text` SET TAGS ('dbx_business_glossary_term' = 'Reference Text');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_FI|OPERA_AR|MICROS_POS|MANUAL|INTERFACE|OTHER');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_group_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Group Currency');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Transaction Currency');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_field` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,18}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `baseline_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Payment Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `capex_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `customer_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `customer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit Credit Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `property_code` SET TAGS ('dbx_business_glossary_term' = 'Property Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `property_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,16}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform System of Accounts for the Lodging Industry (USALI) Department Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `inventory_item_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Item Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `management_fee_id` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `revenue_center_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Expense Category');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `expense_category` SET TAGS ('dbx_value_regex' = 'opex|capex|ffe');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|recurring');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Invoice');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `outstanding_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|wire_transfer|credit_card|eft');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|exception');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `vendor_tax_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tax Identification Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ALTER COLUMN `vendor_tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Payment ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `original_payment_ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Payment ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Bank Fee Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire_transfer|check|electronic_funds_transfer|credit_card|cash');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|cleared|failed|cancelled|reversed');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'standard|advance|partial|final|refund|reversal');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Offer Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `property_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Property Outlet Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay History Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `ancillary_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Revenue Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Phone');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Entity Name');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Entity Type');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|on_hold|escalated|legal|resolved');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `days_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Outstanding');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `event_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Event Revenue Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `fnb_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Revenue Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `folio_number` SET TAGS ('dbx_business_glossary_term' = 'Folio Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `folio_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{8,12}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `room_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Room Revenue Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `write_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Payment ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `ota_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Online Travel Agency (OTA) Partner ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `reversed_payment_ar_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Payment ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `is_advance_deposit` SET TAGS ('dbx_business_glossary_term' = 'Is Advance Deposit');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `is_refund` SET TAGS ('dbx_business_glossary_term' = 'Is Refund');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'front_desk|online|mobile_app|call_center|kiosk|mail');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `transaction_fee` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `seasonal_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Calendar Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'revenue|operating_expense|labor_expense|capex|ffe_reserve');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|rolling_forecast|reforecast|capital');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_adr` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Average Daily Rate (ADR)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_available_rooms` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Available Rooms');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_covers` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Covers');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_cpor` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost Per Occupied Room (CPOR)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_ebitda` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Earnings Before Interest, Taxes, Depreciation, and Amortization (EBITDA)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_events_revenue` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Events Revenue');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_fnb_revenue` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Food and Beverage (F&B) Revenue');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_gop` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Gross Operating Profit (GOP)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_goppar` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Gross Operating Profit Per Available Room (GOPPAR)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_labor_expense` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Labor Expense');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_noi` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Net Operating Income (NOI)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_occupancy_rate` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Occupancy Rate (OCC)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_operating_expense` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Operating Expense (OpEx)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_other_revenue` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Other Revenue');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_revpar` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Revenue Per Available Room (RevPAR)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_room_nights` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Room Nights');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_rooms_revenue` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Rooms Revenue');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_total_revenue` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Total Revenue');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_trevpar` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Total Revenue Per Available Room (TRevPAR)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_driver` SET TAGS ('dbx_business_glossary_term' = 'Allocation Driver');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|allocated|prorated|driver_based');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|locked');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'revenue|operating_expense|fixed_expense|capital_expenditure');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|rolling_forecast|stretch');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,10}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `locked_flag` SET TAGS ('dbx_business_glossary_term' = 'Locked Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `prior_year_actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Actual Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Budget Quantity');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percent');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_banking');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `property_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Property Outlet Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capex_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Approval Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capex_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sale|scrap|donation|trade_in|retirement');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `ffe_reserve_eligible` SET TAGS ('dbx_business_glossary_term' = 'Furniture Fixtures and Equipment (FF&E) Reserve Eligible');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `gain_loss_on_disposal` SET TAGS ('dbx_business_glossary_term' = 'Gain or Loss on Disposal');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `pip_reference` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Reference');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_posting_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `banquet_event_order_id` SET TAGS ('dbx_business_glossary_term' = 'Banquet Event Order Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `booking_package_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Package Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `discount_id` SET TAGS ('dbx_business_glossary_term' = 'Discount Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Check Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `pos_check_line_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Check Line Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `reservation_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Group Block Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `reversed_posting_tax_posting_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Tax Posting ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `room_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Room Service Order Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay History Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `void_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Void Transaction Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Adjustment Reason');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Document Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Due Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `exemption_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `exemption_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `exemption_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'pending|filed|paid|overdue|disputed|adjusted');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Notes');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Payment Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Period');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Reversal Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `source_document_number` SET TAGS ('dbx_business_glossary_term' = 'Source Document Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `source_document_type` SET TAGS ('dbx_business_glossary_term' = 'Source Document Type');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `source_document_type` SET TAGS ('dbx_value_regex' = 'guest_folio|fnb_check|event_invoice|vendor_invoice|adjustment|other');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Base Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Transaction Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'asset_banking');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `master_account_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Master Account ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `master_account_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `master_account_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `ownership_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ownership Entity Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `account_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Masked Bank Account Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `account_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `account_purpose` SET TAGS ('dbx_business_glossary_term' = 'Account Purpose');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended|pending_activation');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'checking|savings|money_market|payroll|escrow|investment');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `ach_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Enabled Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Email Address');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Name');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Phone Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `electronic_banking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Electronic Banking Enabled Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_bearing` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `is_primary_account` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Account Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `is_zero_balance_account` SET TAGS ('dbx_business_glossary_term' = 'Is Zero Balance Account (ZBA) Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `last_statement_balance` SET TAGS ('dbx_business_glossary_term' = 'Last Bank Statement Balance');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Bank Statement Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `minimum_balance_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Required');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `positive_pay_enabled` SET TAGS ('dbx_business_glossary_term' = 'Positive Pay Enabled Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|pending|discrepancy|not_started');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ALTER COLUMN `wire_transfer_enabled` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Enabled Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `management_fee_id` SET TAGS ('dbx_business_glossary_term' = 'Management Fee ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `hma_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Hotel Management Agreement (HMA) Contract ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `ownership_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Entity ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `primary_reversed_fee_management_fee_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Management Fee ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Adjustment Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Fee Adjustment Reason');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Approval Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fee Approval Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Basis Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Calculation Basis');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Calculation Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `fee_number` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `fee_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Rate Percentage');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `fee_status` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Type');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'base_fee|incentive_fee|combined_fee|special_fee|termination_fee|transition_fee');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `net_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Management Fee Amount');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Notes');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Due Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Reference Number');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Status');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|partial|overdue|waived|disputed');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Period End Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Period Start Date');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fee Reversal Indicator');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Fee Reversal Reason');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`hma_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`hma_contract` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`hma_contract` ALTER COLUMN `hma_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Hma Contract Identifier');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`hma_contract` ALTER COLUMN `superseded_hma_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_subdomain' = 'accounting_structure');
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Identifier');
