-- Schema for Domain: finance | Business: Media Broadcasting | Version: v1_mvm
-- Generated on: 2026-05-08 19:23:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `media_broadcasting_ecm`.`finance` COMMENT 'Manages enterprise financial reporting, general ledger, cost centers, production budgets, EBITDA tracking, and financial reconciliation across all revenue streams (advertising, subscription, carriage fees, syndication). Integrates with SAP S/4HANA (FI/CO modules) for chart of accounts, period-end close, intercompany eliminations, and SOX-compliant financial controls. Provides the authoritative financial data layer for revenue assurance and corporate reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the chart of accounts entry. Primary key for the chart of accounts master data.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: GL accounts are defined per legal entity in SAP S/4HANA. The company_code is a business key reference to legal_entity. FK enables proper chart of accounts management per legal entity.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Chart of accounts structures must comply with regulatory reporting requirements (SOX, GAAP, IFRS, FCC financial reporting formats). The sox_control_classification attribute indicates regulatory compli',
    `account_currency` STRING COMMENT 'The primary currency in which this account is maintained, using ISO 4217 three-letter currency codes (e.g., USD, EUR, GBP). Determines the currency for postings and balance reporting.. Valid values are `^[A-Z]{3}$`',
    `account_group` STRING COMMENT 'SAP account group classification that controls field status, number range assignment, and screen layout for the account. Groups accounts with similar characteristics and processing rules (e.g., REVENUE, COGS, OPEX, CAPEX).',
    `account_name` STRING COMMENT 'The full descriptive name of the general ledger account, providing clear business context for the accounts purpose (e.g., Advertising Revenue - Linear TV, Content Production Costs, Subscription Revenue - SVOD).',
    `account_notes` STRING COMMENT 'Free-text field for additional notes, usage guidelines, or special instructions related to this account. Used to document account-specific policies, restrictions, or business context.',
    `account_short_text` STRING COMMENT 'Abbreviated name or short description of the account used in reports and transaction displays where space is limited.',
    `account_status` STRING COMMENT 'Current lifecycle status of the account: active (available for posting), inactive (not available for new postings but retains history), blocked (temporarily suspended), or pending_approval (awaiting activation approval).. Valid values are `active|inactive|blocked|pending_approval`',
    `account_type` STRING COMMENT 'High-level classification of the account into fundamental accounting categories: asset (balance sheet), liability (balance sheet), equity (balance sheet), revenue (P&L), or expense (P&L). Determines which financial statement the account appears on.. Valid values are `asset|liability|equity|revenue|expense`',
    `alternative_account_number` STRING COMMENT 'An alternative or legacy account number used for mapping to previous chart of accounts structures, external reporting systems, or consolidation systems. Supports migration and integration scenarios.',
    `balance_sheet_classification` STRING COMMENT 'For balance sheet accounts, specifies whether the account is classified as current asset, non-current asset, current liability, non-current liability, or equity. Not applicable for P&L accounts.. Valid values are `current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable`',
    `chart_of_accounts_code` STRING COMMENT 'The chart of accounts identifier to which this account belongs. Media Broadcasting may maintain multiple charts of accounts for different regions or business units (e.g., USGA for US GAAP, IFRS for international operations).. Valid values are `^[A-Z0-9]{4}$`',
    `company_code` STRING COMMENT 'The SAP company code (legal entity) to which this chart of accounts entry applies. Supports multi-entity environments where different legal entities may have entity-specific account configurations.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_account` STRING COMMENT 'The consolidation account code used for corporate consolidation and intercompany eliminations. Maps local entity accounts to group-level chart of accounts for consolidated financial reporting.',
    `cost_center_required` BOOLEAN COMMENT 'Indicates whether a cost center must be specified when posting to this account. True for expense accounts requiring cost center assignment; false for balance sheet and revenue accounts.',
    `cost_element_category` STRING COMMENT 'Classification of the account as a cost element for controlling purposes: primary (direct posting from FI), secondary (internal allocations/assessments), revenue (revenue postings), or none (not a cost element). Links financial accounting to management accounting.. Valid values are `primary|secondary|revenue|none`',
    `created_by_user` STRING COMMENT 'The user ID of the person who created this chart of accounts entry in SAP S/4HANA. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this chart of accounts entry was first created in the system. Part of the audit trail for master data governance.',
    `financial_statement_item` STRING COMMENT 'The line item code on the financial statement (balance sheet or income statement) where this accounts balance is reported. Used for financial statement generation and external reporting.',
    `functional_area` STRING COMMENT 'SAP functional area classification used for segment reporting and cost-of-sales accounting. Represents business functions such as Content Production, Distribution, Sales & Marketing, Technology, Corporate. Enables P&L reporting by business function per IFRS requirements.',
    `gl_account_number` STRING COMMENT 'The unique account code used to identify this general ledger account across all financial postings. This is the authoritative account identifier used in SAP S/4HANA FI module for all financial transactions.. Valid values are `^[0-9]{6,10}$`',
    `last_modified_by_user` STRING COMMENT 'The user ID of the person who last modified this chart of accounts entry. Used for change tracking and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this chart of accounts entry was last modified. Part of the audit trail for master data change management.',
    `line_item_display_allowed` BOOLEAN COMMENT 'Indicates whether individual line items (transaction details) can be displayed for this account. True enables drill-down to transaction level; false shows only account balance. Typically true for balance sheet accounts, false for P&L accounts.',
    `materiality_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which transactions or balances in this account are considered material for audit and control purposes. Used to determine testing scope and control frequency for SOX compliance.',
    `open_item_management` BOOLEAN COMMENT 'Indicates whether this account uses open item management, tracking individual postings until they are cleared (e.g., for receivables, payables, clearing accounts). True enables clearing transactions; false for standard balance accounts.',
    `pl_statement_classification` STRING COMMENT 'For P&L accounts, specifies the detailed classification within the income statement (e.g., Operating Revenue, Cost of Sales, Operating Expenses, Depreciation, Interest Expense, Tax Expense). Not applicable for balance sheet accounts.',
    `planning_level` STRING COMMENT 'The planning level or budget category assigned to this account for financial planning and budgeting purposes. Links the account to budget planning hierarchies and enables budget vs. actual reporting.',
    `posting_blocked` BOOLEAN COMMENT 'Indicates whether direct postings to this account are currently blocked. True prevents new transactions; false allows normal posting. Used to freeze accounts during period-end close or for inactive accounts.',
    `profit_center_required` BOOLEAN COMMENT 'Indicates whether a profit center must be specified when posting to this account. True for accounts requiring segment profitability tracking; false otherwise.',
    `reconciliation_account_type` STRING COMMENT 'Identifies if this is a reconciliation account (subledger control account) and its type: customer (accounts receivable), vendor (accounts payable), asset (fixed assets), or none (standard GL account). Reconciliation accounts are automatically posted from subledgers.. Valid values are `customer|vendor|asset|none`',
    `sox_control_classification` STRING COMMENT 'Classification of the account for SOX compliance purposes: key_control (critical accounts requiring enhanced controls and testing), supporting_control (accounts with standard controls), or not_in_scope (accounts outside SOX scope). Drives audit testing requirements.. Valid values are `key_control|supporting_control|not_in_scope`',
    `tax_category` STRING COMMENT 'The tax category classification for this account, determining how tax is calculated and posted (e.g., Input Tax, Output Tax, Non-Taxable, Tax Exempt). Used for VAT/GST/sales tax processing.',
    `trading_partner_required` BOOLEAN COMMENT 'Indicates whether a trading partner (intercompany entity) must be specified when posting to this account. True for intercompany accounts requiring elimination tracking; false for standard accounts.',
    `valid_from_date` DATE COMMENT 'The date from which this account becomes active and available for posting. Supports time-dependent chart of accounts changes and new account activation.',
    `valid_to_date` DATE COMMENT 'The date until which this account remains active. After this date, the account is no longer available for posting. Null indicates the account is currently active with no planned end date.',
    CONSTRAINT pk_chart_of_accounts PRIMARY KEY(`chart_of_accounts_id`)
) COMMENT 'SAP S/4HANA FI-authoritative chart of accounts defining the complete hierarchy of general ledger account codes used across all Media Broadcasting entities. Captures account number, account type (P&L, balance sheet), account group, functional area, cost element category, currency, consolidation account mapping, and SOX control classification. Serves as the foundational reference for all financial postings, period-end close, and intercompany eliminations.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center. Primary key.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Cost centers belong to legal entities in SAP CO organizational structure. The company_code is a business key reference to legal_entity.',
    `parent_cost_center_id` BIGINT COMMENT 'Reference to the parent cost center in the organizational hierarchy, enabling hierarchical cost roll-ups and departmental P&L aggregation.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center to which this cost center is assigned for internal management reporting and EBITDA tracking.',
    `activity_type` STRING COMMENT 'The primary activity type or service provided by this cost center for internal cost allocation purposes (e.g., Studio Hours, Editing Hours, Transmission Hours).',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'The total annual budget allocated to this cost center for the current fiscal year, in the cost centers currency.',
    `budget_allocation_reference` STRING COMMENT 'Reference identifier to the annual or periodic budget allocation document for this cost center, used for budget vs. actual variance analysis.',
    `business_area` STRING COMMENT 'The business area or division within Media Broadcasting to which this cost center belongs (e.g., Linear Broadcasting, Streaming Platforms, News Division, Sports Division).',
    `company_code` STRING COMMENT 'The SAP company code representing the legal entity to which this cost center is assigned for financial reporting purposes.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area` STRING COMMENT 'The SAP Controlling Area code to which this cost center belongs. Controlling area represents the organizational unit for cost accounting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_allocation_method` STRING COMMENT 'The method used to allocate costs from this cost center to other cost objects (e.g., direct assignment, activity-based costing, percentage allocation, driver-based).. Valid values are `direct|activity_based|percentage|driver_based`',
    `cost_center_category` STRING COMMENT 'Classification of the cost center by cost behavior: direct costs attributable to specific content/programs, indirect costs supporting operations, overhead, or capital expenditure.. Valid values are `direct|indirect|overhead|capital`',
    `cost_center_code` STRING COMMENT 'The business identifier code for the cost center as defined in SAP Controlling (CO) module. Used for financial reporting and budget tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `cost_center_description` STRING COMMENT 'Detailed description of the cost centers purpose, scope, and responsibilities within the organization.',
    `cost_center_name` STRING COMMENT 'The full descriptive name of the cost center (e.g., Digital Platform Operations, News Production Studio A, Ad Sales Northeast Region).',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center indicating whether it is operational and available for cost posting.. Valid values are `active|inactive|blocked|pending_closure`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by functional area within the media broadcasting business. [ENUM-REF-CANDIDATE: production|operations|sales|distribution|corporate|technology|content_acquisition — 7 candidates stripped; promote to reference product]',
    `cost_element_group` STRING COMMENT 'The primary cost element group or category that this cost center typically incurs (e.g., Personnel Costs, Production Costs, Technology Costs, Rights & Licensing).',
    `created_by_user` STRING COMMENT 'The user ID of the person who created this cost center record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this cost centers budget and actual costs are tracked (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'The department code within the organizational structure to which this cost center is assigned.',
    `ebitda_reporting_segment` STRING COMMENT 'The EBITDA reporting segment to which this cost centers costs are allocated for executive and investor reporting.',
    `functional_area` STRING COMMENT 'The functional classification of the cost center for financial statement reporting (e.g., Production, Distribution, Sales & Marketing, General & Administrative).',
    `hierarchy_node` STRING COMMENT 'The position of this cost center within the organizational cost center hierarchy, used for roll-up reporting and consolidation.',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this cost center participates in intercompany transactions requiring elimination entries during consolidation.',
    `is_revenue_generating` BOOLEAN COMMENT 'Flag indicating whether this cost center directly generates revenue (e.g., Ad Sales regions) or is purely a cost-incurring unit.',
    `last_modified_by_user` STRING COMMENT 'The user ID of the person who last modified this cost center record in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was last updated in the system.',
    `location_code` STRING COMMENT 'The physical location or facility code where this cost center operates (e.g., studio location, broadcast center, regional office).',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about this cost centers purpose or operational considerations.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this cost center is subject to SOX financial controls and requires enhanced audit trail and approval workflows.',
    `valid_from_date` DATE COMMENT 'The date from which this cost center becomes active and available for cost posting in the financial system.',
    `valid_to_date` DATE COMMENT 'The date until which this cost center remains active. Null indicates an open-ended validity period.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'SAP CO-authoritative cost center master data representing organizational units responsible for incurring costs across Media Broadcasting — including production studios, broadcast operations, digital platforms, sales regions, and corporate functions. Tracks cost center code, hierarchy node, responsible manager, controlling area, profit center assignment, currency, validity period, and budget allocation reference. Enables granular cost tracking for EBITDA reporting and departmental P&L.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique system identifier for the profit center record. Primary key.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Profit centers align with licensed stations for financial and regulatory reporting. License-level EBITDA is required for debt covenants, ownership attribution rules, and FCC financial qualification re',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Profit centers belong to legal entities in SAP CO organizational structure. The company_code is a business key reference to legal_entity. This is essential for P&L consolidation.',
    `activation_date` DATE COMMENT 'The date on which this profit center was activated and began accepting financial postings. Used for historical analysis and lifecycle tracking.',
    `budget_allocation_method` STRING COMMENT 'The methodology used for allocating budgets to this profit center. Top-down allocates from corporate targets; bottom-up aggregates from operational plans; zero-based requires justification of all expenses; incremental adjusts prior year budgets.. Valid values are `top_down|bottom_up|zero_based|incremental`',
    `business_unit` STRING COMMENT 'The higher-level business unit or division to which this profit center belongs. Used for hierarchical rollup in management reporting. Examples: Digital Media, Broadcast Networks, Content Production.',
    `closure_date` DATE COMMENT 'The date on which this profit center was closed and ceased operations. Null for active profit centers. Used for historical reporting and archival.',
    `company_code` STRING COMMENT 'The company code representing the legal entity to which this profit center belongs. Used for financial statement preparation and legal reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area_code` STRING COMMENT 'The controlling area to which this profit center is assigned. Controlling area is the organizational unit in SAP CO that represents a closed system for cost accounting purposes.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_assignment_flag` BOOLEAN COMMENT 'Indicates whether cost centers can be directly assigned to this profit center for cost allocation and internal charging purposes.',
    `country_code` STRING COMMENT 'The primary country of operation for this profit center. Three-letter ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this profit center record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The functional currency in which this profit center conducts its operations and reports financial results. Three-letter ISO 4217 code.. Valid values are `^[A-Z]{3}$`',
    `ebitda_reporting_flag` BOOLEAN COMMENT 'Indicates whether this profit center is included in EBITDA segment reporting for management and investor communications. EBITDA is a key profitability metric in media broadcasting.',
    `geographic_region` STRING COMMENT 'The primary geographic region or market in which this profit center operates. Used for regional performance analysis and geographic segment reporting. Examples: North America, EMEA, APAC, Latin America.',
    `hierarchy_node` STRING COMMENT 'The node identifier within the profit center standard hierarchy. Used for multi-level aggregation and drill-down reporting in management accounting.',
    `intercompany_elimination_flag` BOOLEAN COMMENT 'Indicates whether transactions involving this profit center require intercompany elimination adjustments during financial consolidation. Used in multi-entity corporate structures.',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this profit center record. Used for accountability and audit trail purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this profit center record was last updated. Used for change tracking and audit compliance.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context, special instructions, or historical information about the profit center. Used by finance teams for operational reference.',
    `parent_profit_center_code` STRING COMMENT 'The code of the parent profit center in the organizational hierarchy, if this profit center rolls up to another. Enables hierarchical consolidation for segment EBITDA and management reporting.',
    `profit_center_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying the profit center within the controlling area. Used in SAP CO for segment reporting and management accounting. Examples: SVOD-US, LINEAR-UK, ADSALES-NA.. Valid values are `^[A-Z0-9]{4,10}$`',
    `profit_center_description` STRING COMMENT 'Detailed textual description of the profit centers business purpose, scope of operations, and strategic role within the enterprise. Used for documentation and onboarding.',
    `profit_center_name` STRING COMMENT 'The full business name of the profit center. Human-readable label used in financial reports and management dashboards.',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center. Active profit centers are operational and accept postings; inactive are temporarily suspended; planned are future entities; closed are historical and no longer accept transactions.. Valid values are `active|inactive|planned|closed`',
    `profit_center_type` STRING COMMENT 'Classification of the profit center based on its accountability model. Revenue centers are responsible for revenue generation; cost centers for cost control; investment centers for return on invested capital; service centers provide internal services.. Valid values are `revenue_center|cost_center|investment_center|service_center`',
    `revenue_posting_flag` BOOLEAN COMMENT 'Indicates whether revenue transactions can be posted directly to this profit center. Used to control which profit centers participate in revenue recognition workflows.',
    `segment_code` STRING COMMENT 'The segment classification for external segment reporting under IFRS 8 and US GAAP. Segments represent distinguishable components of the business for which discrete financial information is available and regularly reviewed by the chief operating decision maker. Examples: Streaming, Linear Broadcasting, Advertising, Syndication.',
    `short_name` STRING COMMENT 'Abbreviated name or acronym for the profit center, used in condensed reports and system displays where space is limited.',
    `sox_control_scope_flag` BOOLEAN COMMENT 'Indicates whether this profit center is within the scope of SOX financial controls and requires enhanced audit trails and segregation of duties for financial postings.',
    `transfer_pricing_method` STRING COMMENT 'The method used for pricing internal transactions between this profit center and other organizational units. Examples: cost-plus, market-based, negotiated. Critical for accurate profit center performance measurement.',
    `valid_from_date` DATE COMMENT 'The date from which this profit center configuration is effective. Used for time-dependent master data versioning in SAP CO.',
    `valid_to_date` DATE COMMENT 'The date until which this profit center configuration is effective. Null indicates open-ended validity. Used for time-dependent master data versioning.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'SAP CO-authoritative profit center master representing autonomous business units within Media Broadcasting that are evaluated on profitability — such as SVOD platform, linear broadcast network, advertising sales division, and syndication unit. Captures profit center code, hierarchy, controlling area, responsible manager, currency, and segment classification. Underpins segment reporting, EBITDA tracking, and management accounting.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` (
    `general_ledger_id` BIGINT COMMENT 'Unique identifier for the general ledger record. Primary key for the general ledger data product.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: GL entries reference chart of accounts for account metadata. The gl_account STRING is a business key that should be supplemented with FK to chart_of_accounts.chart_of_accounts_id. The gl_account_descr',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: General ledger entries belong to legal entities in SAP S/4HANA FI. The company_code is a business key reference to legal_entity. This is the foundational relationship for financial consolidation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: GL entries can be allocated to cost centers for cost tracking. The cost_center STRING column will be replaced by FK to cost_center.cost_center_id.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: GL entries can be allocated to profit centers for P&L tracking. The profit_center STRING column will be replaced by FK to profit_center.profit_center_id.',
    `account_type` STRING COMMENT 'High-level classification of the general ledger account into one of the five fundamental accounting categories: asset, liability, equity, revenue, or expense. Used for financial statement preparation and trial balance categorization.. Valid values are `asset|liability|equity|revenue|expense`',
    `budget_amount_functional_currency` DECIMAL(18,2) COMMENT 'Budgeted amount allocated to the general ledger account for the fiscal period, expressed in functional currency. Used for budget vs. actual variance analysis and financial planning. Particularly relevant for production budgets, content acquisition costs, and operational expense management.',
    `business_area` STRING COMMENT 'Four-character code representing the business area or division for cross-company code reporting. Enables consolidated financial statements across multiple legal entities within the same business segment (e.g., linear broadcasting, streaming platforms, syndication).. Valid values are `^[A-Z0-9]{4}$`',
    `closing_balance_functional_currency` DECIMAL(18,2) COMMENT 'Closing balance of the general ledger account at the end of the fiscal period, expressed in functional currency. Calculated as opening balance plus net period activity. Represents the ending position for trial balance and financial statement generation.',
    `company_code` STRING COMMENT 'Four-character alphanumeric identifier for the legal entity within the Media Broadcasting enterprise. Represents the organizational unit for which separate financial statements are prepared. Maps to SAP S/4HANA company code structure.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_unit` STRING COMMENT 'Consolidation unit code representing the entity for group consolidation and statutory reporting. Used for multi-entity financial consolidation, intercompany eliminations, and corporate-level financial statement preparation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `credit_amount_functional_currency` DECIMAL(18,2) COMMENT 'Total credit amount posted to the general ledger account for the period, expressed in the functional currency of the company code. Represents increases to liability, equity, and revenue accounts or decreases to asset and expense accounts.',
    `credit_amount_transaction_currency` DECIMAL(18,2) COMMENT 'Total credit amount posted to the general ledger account for the period, expressed in the original transaction currency. Maintained for audit trail and foreign exchange reconciliation purposes.',
    `debit_amount_functional_currency` DECIMAL(18,2) COMMENT 'Total debit amount posted to the general ledger account for the period, expressed in the functional currency of the company code. Represents increases to asset and expense accounts or decreases to liability, equity, and revenue accounts.',
    `debit_amount_transaction_currency` DECIMAL(18,2) COMMENT 'Total debit amount posted to the general ledger account for the period, expressed in the original transaction currency. Maintained for audit trail and foreign exchange reconciliation purposes.',
    `document_type` STRING COMMENT 'Two-character code representing the type of accounting document that generated the general ledger entry (e.g., SA for G/L account document, DR for customer invoice, KR for vendor invoice, DZ for payment). Used for document classification and posting control.. Valid values are `^[A-Z]{2}$`',
    `ebitda_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the general ledger account is included in EBITDA calculation for management reporting and investor disclosures. True if the account contributes to EBITDA (operating revenues and expenses), false if excluded (interest, taxes, depreciation, amortization).',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year for which the general ledger balance is recorded. Represents the accounting period year aligned with the companys financial reporting calendar.',
    `functional_area` STRING COMMENT 'Functional area code representing the business function or operational domain (e.g., content production, advertising sales, distribution, subscriber management). Used for cross-organizational reporting and functional cost analysis.. Valid values are `^[A-Z0-9]{4,6}$`',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the functional currency of the company code (e.g., USD, GBP, EUR). The functional currency is the primary currency in which the legal entity conducts business and prepares financial statements.. Valid values are `^[A-Z]{3}$`',
    `gl_account` STRING COMMENT 'General ledger account number from the chart of accounts. Represents the specific account classification (asset, liability, equity, revenue, expense) for financial transactions. Structured according to the enterprise chart of accounts hierarchy.. Valid values are `^[0-9]{6,10}$`',
    `last_posting_date` DATE COMMENT 'Date of the most recent transaction posted to this general ledger account within the fiscal period. Used for audit trail and period-end reconciliation validation.',
    `ledger_group` STRING COMMENT 'Ledger group code representing the accounting principle or reporting standard (e.g., 0L for leading ledger, 2L for IFRS, 3L for US GAAP). Enables parallel accounting for multiple reporting frameworks within a single system.. Valid values are `^[A-Z0-9]{2}$`',
    `net_balance_functional_currency` DECIMAL(18,2) COMMENT 'Net balance of the general ledger account for the period, calculated as debit amount minus credit amount (or vice versa depending on account type), expressed in the functional currency. Represents the aggregated account state for trial balance and financial statement generation.',
    `opening_balance_functional_currency` DECIMAL(18,2) COMMENT 'Opening balance of the general ledger account at the beginning of the fiscal period, expressed in functional currency. Represents the carried-forward balance from the previous period for balance sheet accounts.',
    `period_lock_status` STRING COMMENT 'Status of the posting period indicating whether the period is open for new postings, closed for regular postings but open for adjustments, or locked for all postings. Used for period-end close control and financial statement finalization.. Valid values are `open|closed|locked`',
    `posting_key` STRING COMMENT 'Two-digit numeric code that controls the posting behavior and determines whether the entry is a debit or credit (e.g., 40 for debit, 50 for credit). Used for transaction validation and account determination logic.. Valid values are `^[0-9]{2}$`',
    `posting_period` STRING COMMENT 'Numeric posting period within the fiscal year (typically 1-12 for monthly periods, with additional special periods 13-16 for year-end adjustments). Represents the accounting period for transaction posting and period-end close.',
    `reconciliation_account_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the general ledger account is a reconciliation account (subledger control account) that must reconcile with subsidiary ledgers such as accounts receivable, accounts payable, or fixed assets. True if reconciliation account, false otherwise.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the general ledger record was first created in the system. Represents the initial capture time for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the general ledger record was last modified. Represents the most recent change time for audit trail and change tracking. Updated whenever period balances are adjusted or corrected.',
    `revenue_stream_category` STRING COMMENT 'Classification of revenue accounts by primary revenue stream type for Media Broadcasting business. Categories include advertising (linear and digital ad sales), subscription (SVOD/AVOD), carriage fees (MVPD/vMVPD distribution), syndication (content resale), licensing (rights monetization), transactional (TVOD), and other. Used for revenue assurance and segment reporting. [ENUM-REF-CANDIDATE: advertising|subscription|carriage_fees|syndication|licensing|transactional|other — 7 candidates stripped; promote to reference product]',
    `segment` STRING COMMENT 'Segment code for external segment reporting as required by IFRS 8 and US GAAP. Represents reportable business segments for statutory financial reporting and investor disclosures (e.g., content production, advertising, subscription services).. Valid values are `^[A-Z0-9]{6,10}$`',
    `source_system` STRING COMMENT 'Identifier of the source system that originated the general ledger data. Typically SAP S/4HANA FI module, but may include other ERP systems or consolidation platforms for multi-system environments. Used for data lineage and reconciliation.',
    `sox_control_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the general ledger account is subject to Sarbanes-Oxley Act internal control requirements and audit procedures. True if SOX-controlled account requiring enhanced documentation and approval workflows, false otherwise.',
    `trading_partner` STRING COMMENT 'Trading partner code identifying the intercompany counterparty for intercompany transactions. Used for intercompany eliminations and consolidated financial statement preparation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the original transaction currency if different from functional currency. Used for multi-currency transactions requiring foreign exchange conversion and revaluation.. Valid values are `^[A-Z]{3}$`',
    `variance_amount_functional_currency` DECIMAL(18,2) COMMENT 'Variance between actual net balance and budgeted amount for the fiscal period, expressed in functional currency. Calculated as actual minus budget. Positive variance indicates over-budget for expense accounts or under-budget for revenue accounts.',
    CONSTRAINT pk_general_ledger PRIMARY KEY(`general_ledger_id`)
) COMMENT 'SAP FI general ledger representing period-level account balances and individual line items for all Media Broadcasting legal entities. Each record captures a GL account balance within a company code, fiscal year, and posting period — storing debit/credit totals, functional and transaction currency amounts, document type references, and SOX control indicators. Serves as the authoritative source for trial balance generation, statutory financial statements, and period-end close validation. Distinguished from journal_entry (which holds individual postings) by representing the aggregated account state.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record. Primary key for the journal entry entity.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: In SAP FI, every journal entry document is posted against GL accounts that belong to a specific chart of accounts. The journal_entry table currently has no direct FK to chart_of_accounts despite havin',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Journal entries belong to legal entities in SAP S/4HANA FI. The company_code is a business key reference to legal_entity. This is essential for financial consolidation and SOX controls.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entries in media broadcasting post to cost centers for production cost allocation, departmental expense tracking, and budget monitoring. Enables drill-down from GL to cost center detail for va',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Journal entries are the source documents that drive general ledger period balances in SAP FI. Each journal entry posts to a specific GL account/period combination represented by a general_ledger recor',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Journal entries for revenue recognition, intercompany eliminations, and P&L postings require profit center assignment for segment reporting and EBITDA calculation. Critical for media broadcasting busi',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Journal entries support regulatory filings (ownership change accounting, financial certifications in license applications, spectrum auction payments). Audit trail from filing to supporting GL entries ',
    `accrual_reversal_date` DATE COMMENT 'The future posting date on which this accrual entry will automatically reverse. Populated only when accrual_reversal_indicator is True.',
    `accrual_reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is an automatic accrual reversal. True if this entry will automatically reverse in the subsequent period.',
    `adjustment_type` STRING COMMENT 'Classification of the journal entry by its accounting purpose: standard operational posting, period-end accrual, prepayment amortization, account reclassification, intercompany elimination, or error correction.. Valid values are `standard|accrual|prepayment|reclassification|elimination|correction`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the journal entry was approved by the designated approver. Null if no approval was required or entry is still pending approval.',
    `batch_input_session` STRING COMMENT 'The name of the batch input session if this journal entry was posted via batch processing rather than manual entry. Empty for manually posted entries.',
    `company_code` STRING COMMENT 'Four-character code identifying the legal entity within the Media Broadcasting enterprise for which this journal entry is posted. Represents the smallest organizational unit for which a complete self-contained set of accounts can be drawn up for purposes of external reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the journal entry amounts are denominated (e.g., USD, GBP, EUR). All line items within this document share this currency.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date of the original source document (invoice, receipt, contract) that gave rise to this journal entry. May differ from posting date when entries are posted retrospectively.',
    `document_header_text` STRING COMMENT 'Descriptive text at the document header level providing context or explanation for the journal entry, such as the business purpose, transaction description, or special instructions.',
    `document_number` STRING COMMENT 'The externally-known SAP document number assigned to this journal entry at posting time. This is the business identifier used across financial reporting and audit trails.. Valid values are `^[0-9]{10}$`',
    `document_type` STRING COMMENT 'Two-character code classifying the nature of the accounting document (e.g., SA=General Ledger Document, DR=Customer Invoice, KR=Vendor Invoice, DZ=Customer Payment, KZ=Vendor Payment, AB=Accounting Document). Controls the number range and field status for the entry.. Valid values are `^[A-Z]{2}$`',
    `entry_date` DATE COMMENT 'The calendar date when the journal entry was physically entered into the SAP system by the user, which may differ from both document date and posting date.',
    `entry_time` TIMESTAMP COMMENT 'The precise date and time when the journal entry was created in the SAP system. Provides audit trail for record creation.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert document currency amounts to local currency amounts at the time of posting. Expressed as local currency per one unit of document currency.',
    `exchange_rate_type` STRING COMMENT 'Single-character code indicating the type of exchange rate used (e.g., M=Average Rate, B=Bank Buying Rate, G=Bank Selling Rate). Determines which rate table is consulted for currency conversion.. Valid values are `^[A-Z]{1}$`',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this journal entry is posted, following the companys financial calendar. Used for period-end close and annual financial reporting.',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry represents an intercompany transaction between different legal entities within Media Broadcasting. True for intercompany entries requiring elimination in consolidated reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the journal entry record was last modified in the system. Used for change tracking and audit compliance.',
    `ledger_group` STRING COMMENT 'Two-character code identifying the ledger group to which this journal entry belongs. Supports parallel accounting for different accounting principles (e.g., 0L=Leading Ledger, 2L=IFRS Ledger, 3L=Tax Ledger).. Valid values are `^[A-Z0-9]{2}$`',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the local currency of the company code. Used for parallel accounting and statutory reporting.. Valid values are `^[A-Z]{3}$`',
    `parked_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is in parked status (saved but not yet posted). True if parked, False if fully posted.',
    `posting_date` DATE COMMENT 'The date on which the journal entry was posted to the general ledger. This is the accounting date that determines the fiscal period and is used for financial statement reporting. Represents the principal business event timestamp for this transaction.',
    `posting_period` STRING COMMENT 'The accounting period (typically 1-12 for monthly periods, with additional special periods 13-16 for year-end adjustments) within the fiscal year when this entry was posted.',
    `recurring_entry_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is part of a recurring entry template (e.g., monthly depreciation, rent accruals). True if generated from a recurring template.',
    `reference_number` STRING COMMENT 'Free-text reference field used to store external document identifiers such as invoice numbers, purchase order numbers, contract references, or other source system identifiers that link this journal entry to originating business transactions.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a reversal of a previously posted document. True if this entry reverses another entry, False otherwise.',
    `reversal_reason_code` STRING COMMENT 'Two-digit code indicating the business reason for reversing the original document (e.g., 01=Error Correction, 02=Accrual Reversal, 03=Period-End Adjustment). Populated only when reversal_indicator is True.. Valid values are `^[0-9]{2}$`',
    `reversed_document_number` STRING COMMENT 'The document number of the original journal entry that this entry reverses. Populated only when reversal_indicator is True.',
    `source_system_code` STRING COMMENT 'Code identifying the originating system from which this journal entry was interfaced into SAP S/4HANA (e.g., WideOrbit for advertising revenue, Zuora for subscription billing, Rightsline for royalty accruals). Empty for entries created directly in SAP.',
    `trading_partner_company_code` STRING COMMENT 'The company code of the intercompany trading partner for intercompany transactions. Populated only when intercompany_indicator is True. Used for intercompany reconciliation and consolidation eliminations.',
    `transaction_code` STRING COMMENT 'The SAP transaction code (T-Code) used to post this journal entry (e.g., FB01, FB50, F-02). Indicates the posting interface and provides context for the entry method.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `workflow_status` STRING COMMENT 'Current status of the journal entry within the SOX-compliant approval workflow. Tracks the document through draft, approval, posting, and potential reversal stages.. Valid values are `draft|pending_approval|approved|rejected|posted|reversed`',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Individual accounting document posted to the SAP S/4HANA general ledger capturing all financial transactions across Media Broadcasting — including revenue recognition postings, accruals, prepayments, intercompany charges, and period-end adjustments. Records document number, company code, posting date, document date, document type, reference, reversal indicator, posting user, and SOX approval workflow status. The atomic unit of financial record-keeping.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`finance`.`production_budget` (
    `production_budget_id` BIGINT COMMENT 'Primary key for production_budget',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Production budgets in broadcasting operate under specific broadcast licenses. Regulatory cost allocation, license-specific content production tracking, and FCC financial reporting require direct budge',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Production budget line items (above-the-line, below-the-line, VFX, music licensing, facilities, post-production amounts) are posted against specific GL accounts defined in the chart of accounts. Addin',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Production budgets are financial instruments approved and managed at the legal entity level for SAP CO internal order management. The production_budget table currently has no direct FK to legal_entity',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production budgets are allocated to cost centers for expense tracking. The cost_center_code STRING column will be replaced by FK to cost_center.cost_center_id.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Production budgets include line items for music licensing, archive footage licensing, and rights acquisitions governed by license agreements. Required for production cost tracking, budget variance ana',
    `project_id` BIGINT COMMENT 'Reference to the production project (scripted series, film, live event, news programming, digital original) for which this budget is allocated.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: In SAP CO, production budgets (internal orders) are assigned to profit centers for P&L reporting and EBITDA tracking. The production_budget table currently has cost_center_id but no profit_center_id, ',
    `above_the_line_amount` DECIMAL(18,2) COMMENT 'Budget allocated to above-the-line costs including key creative talent (writers, directors, producers, lead actors). These are typically negotiated individually and represent significant budget items.',
    `actual_spend_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure against this budget as of the last financial update. Used for variance tracking and budget performance monitoring.',
    `approval_date` DATE COMMENT 'The date on which this production budget was formally approved for spending.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or financial authority who approved this production budget.',
    `below_the_line_amount` DECIMAL(18,2) COMMENT 'Budget allocated to below-the-line costs including crew, equipment, facilities, and production support. These are standard production costs not tied to key creative talent.',
    `budget_effective_date` DATE COMMENT 'The date from which this budget version becomes effective and spending authorization begins.',
    `budget_expiry_date` DATE COMMENT 'The date on which this budget version expires or is superseded by a new version. Null for open-ended budgets.',
    `budget_notes` STRING COMMENT 'Free-text notes and comments regarding this budget version, including justification for revisions, special conditions, or approval stipulations.',
    `budget_number` STRING COMMENT 'Externally-known unique identifier for the production budget, used for tracking and reference in financial systems and production workflows.. Valid values are `^[A-Z0-9]{6,20}$`',
    `budget_status` STRING COMMENT 'Current lifecycle status of the production budget. Tracks progression from draft through approval to active spending and final closure. [ENUM-REF-CANDIDATE: draft|submitted|approved|active|revised|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the production budget by content type. Different content types have different cost structures and budget approval workflows. [ENUM-REF-CANDIDATE: scripted_series|film|live_event|news_programming|digital_original|documentary|sports|reality|animation — 9 candidates stripped; promote to reference product]',
    `budget_version` STRING COMMENT 'Version number of the budget. Budgets are revised throughout the production lifecycle; this field tracks the iteration (e.g., 1 for initial, 2 for first revision).. Valid values are `^[0-9]{1,3}$`',
    `committed_amount` DECIMAL(18,2) COMMENT 'Amount committed through purchase orders and contracts but not yet invoiced or paid. Used for funds reservation and budget availability calculation.',
    `contingency_amount` DECIMAL(18,2) COMMENT 'Contingency reserve allocated for unforeseen production costs and budget overruns. Typically 5-10% of total budget.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production budget record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget record (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `facilities_amount` DECIMAL(18,2) COMMENT 'Budget allocated to production facilities including studio rental, location fees, set construction, and production office space.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this production budget is allocated. Used for annual financial planning and reporting.. Valid values are `^[0-9]{4}$`',
    `internal_order_number` STRING COMMENT 'SAP CO internal order number used for production cost control and tracking actual expenditures against this budget.. Valid values are `^[A-Z0-9]{6,15}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this production budget record was last updated. Used for change tracking and audit trail.',
    `music_licensing_amount` DECIMAL(18,2) COMMENT 'Budget allocated to music licensing, original score composition, and music rights clearance for the production.',
    `post_production_amount` DECIMAL(18,2) COMMENT 'Budget allocated to post-production activities including editing, color correction, sound design, mixing, and final mastering.',
    `production_end_date` DATE COMMENT 'Planned or actual end date of production for this project. Used for budget closure and final cost reconciliation.',
    `production_start_date` DATE COMMENT 'Planned or actual start date of production for this project. Used for budget phasing and cash flow planning.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this budget is subject to SOX financial controls and audit requirements. True for budgets above materiality thresholds.',
    `total_approved_amount` DECIMAL(18,2) COMMENT 'Total approved budget amount for the production project across all cost categories. This is the authorized spending limit.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Calculated variance between approved budget and actual spend (approved amount minus actual spend). Positive values indicate under-budget, negative values indicate over-budget.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Variance expressed as a percentage of the approved budget. Used for budget performance dashboards and exception reporting.',
    `vfx_amount` DECIMAL(18,2) COMMENT 'Budget allocated to visual effects production. VFX is often a significant cost category for scripted series, films, and high-production-value content.',
    CONSTRAINT pk_production_budget PRIMARY KEY(`production_budget_id`)
) COMMENT 'Financial budget allocated to individual content production projects — covering scripted series, films, live events, news programming, and digital originals. Tracks approved budget amount by cost category (above-the-line talent, below-the-line crew, facilities, post-production, VFX, music licensing), budget version, fiscal year, production project reference, cost center, currency, approval status, and variance-to-actual tracking. Integrates with SAP CO internal orders for production cost control.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` (
    `revenue_stream_id` BIGINT COMMENT 'Unique identifier for the revenue stream. Primary key for this entity.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Revenue streams in broadcasting are fundamentally tied to licensed operations. Each broadcast license generates distinct revenue streams (advertising, retransmission consent, subscription). FCC financ',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Revenue streams map to GL accounts for revenue posting. The gl_account_code STRING is a business key that should be supplemented with FK to chart_of_accounts.chart_of_accounts_id.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Revenue streams in Media Broadcasting are managed at the legal entity level — advertising revenue, subscription fees, carriage fees, and syndication revenue are recognized by specific legal entities (',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue streams can be associated with cost centers for revenue tracking. The cost_center_code STRING is a business key that should be supplemented with FK to cost_center.cost_center_id.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue streams are associated with profit centers for P&L attribution. The profit_center_code STRING is a business key that should be supplemented with FK to profit_center.profit_center_id.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Revenue recognition methods must comply with specific regulatory obligations (ASC 606, IFRS 15, SOX controls, FCC reporting rules). Revenue_stream tracks accounting_standard and sox_control_flag, indi',
    `accounting_standard` STRING COMMENT 'The accounting standard governing revenue recognition for this stream (ASC 606 for US GAAP, IFRS 15 for international, or local GAAP variants).. Valid values are `ASC_606|IFRS_15|GAAP|local_GAAP`',
    `audience_measurement_source` STRING COMMENT 'Primary audience measurement provider used for revenue validation and guarantees (e.g., Nielsen, Comscore, Adobe Analytics). Critical for advertising revenue streams with audience guarantees.',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether detailed audit trail and supporting documentation must be maintained for all transactions in this revenue stream (True for high-risk or regulated streams).',
    `business_unit` STRING COMMENT 'Business unit or division responsible for generating this revenue stream (e.g., Broadcast Networks, Digital Platforms, Studios).',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Standard commission rate percentage paid to sales representatives or agencies for revenue generated through this stream.',
    `content_type` STRING COMMENT 'Type of content delivery associated with this revenue stream: live, on-demand, linear (scheduled), non-linear, simulcast, catch-up, or archive. [ENUM-REF-CANDIDATE: live|on_demand|linear|non_linear|simulcast|catch_up|archive — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Type of contractual arrangement governing this revenue stream: upfront (advance commitment), scatter (spot market), guaranteed delivery, non-guaranteed, fixed fee, variable fee, or hybrid. [ENUM-REF-CANDIDATE: upfront|scatter|guaranteed|non_guaranteed|fixed_fee|variable_fee|hybrid — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue stream record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for revenue transactions in this stream (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this revenue stream classification ceased to be effective. Null for currently active streams. Used for historical analysis and sunset planning.',
    `effective_start_date` DATE COMMENT 'Date when this revenue stream classification became effective and began generating revenue. Used for historical revenue analysis and period-over-period comparisons.',
    `gl_account_code` STRING COMMENT 'General ledger account code in the chart of accounts where revenue from this stream is posted.. Valid values are `^[0-9]{4,10}$`',
    `is_deferred` BOOLEAN COMMENT 'Indicates whether revenue from this stream is initially recorded as deferred revenue and recognized over time (True for advance payments, subscriptions; False for immediate recognition).',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this revenue stream generates recurring revenue (True for subscriptions, carriage fees; False for one-time transactions, spot advertising).',
    `makegoods_policy` STRING COMMENT 'Policy for providing makegoods (compensatory ad spots) when delivery guarantees are not met: automatic, negotiated, none, audience-based, or technical failure only.. Valid values are `automatic|negotiated|none|audience_based|technical_failure`',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this revenue stream record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue stream record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional business context, special handling instructions, or historical notes about this revenue stream classification.',
    `payment_terms_days` STRING COMMENT 'Standard payment terms in days for this revenue stream (e.g., Net 30, Net 60). Used for accounts receivable aging and cash flow forecasting.',
    `performance_obligation` STRING COMMENT 'Description of the performance obligation that must be satisfied for revenue recognition per ASC 606 / IFRS 15 (e.g., delivery of ad impressions, provision of streaming access, content licensing rights transfer).',
    `platform_type` STRING COMMENT 'Distribution platform type for this revenue stream: linear broadcast, OTT (Over-The-Top), MVPD (Multichannel Video Programming Distributor), vMVPD (Virtual MVPD), FAST (Free Ad-Supported Streaming TV), VOD, theatrical, syndication, or digital. [ENUM-REF-CANDIDATE: linear|OTT|MVPD|vMVPD|FAST|VOD|theatrical|syndication|digital — 9 candidates stripped; promote to reference product]',
    `pricing_model` STRING COMMENT 'Pricing structure for this revenue stream: CPM (Cost Per Mille for advertising), flat rate, tiered pricing, usage-based, revenue share, or hybrid model.. Valid values are `CPM|flat_rate|tiered|usage_based|revenue_share|hybrid`',
    `recognition_method` STRING COMMENT 'Method by which revenue is recognized per accounting standards: point in time (transactional), over time (subscription), usage-based (consumption), or milestone-based (licensing).. Valid values are `point_in_time|over_time|usage_based|milestone_based`',
    `reporting_segment` STRING COMMENT 'Corporate reporting segment for external financial reporting (e.g., Linear Broadcasting, Streaming Services, Content Licensing). Used for segment disclosure per ASC 280 / IFRS 8.',
    `revenue_category` STRING COMMENT 'High-level classification of revenue type: advertising (upfront, scatter, DAI), subscription (SVOD, AVOD, TVOD), carriage fees, syndication, content licensing, ancillary, or transactional. [ENUM-REF-CANDIDATE: advertising|subscription|carriage|syndication|licensing|ancillary|transactional — 7 candidates stripped; promote to reference product]',
    `revenue_stream_status` STRING COMMENT 'Current lifecycle status of the revenue stream: active (currently generating revenue), inactive (not in use), suspended (temporarily halted), pending approval (awaiting finance approval), or deprecated (phased out).. Valid values are `active|inactive|suspended|pending_approval|deprecated`',
    `revenue_subcategory` STRING COMMENT 'Detailed sub-classification within the revenue category (e.g., Upfront, Scatter, Programmatic for advertising; SVOD, AVOD, TVOD for subscription; Linear Carriage, OTT Carriage for carriage fees).',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this revenue stream is subject to SOX internal controls and requires additional audit documentation (True for material revenue streams, False for immaterial).',
    `stream_code` STRING COMMENT 'Business identifier code for the revenue stream (e.g., ADV-UPFRONT, SVOD-PREM, CARRIAGE-FEE). Used across financial systems and reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `stream_name` STRING COMMENT 'Full descriptive name of the revenue stream (e.g., Upfront Advertising Sales, Premium SVOD Subscription, Syndication License Fees).',
    `tax_jurisdiction` STRING COMMENT 'Primary tax jurisdiction for this revenue stream using ISO 3166-1 alpha-2 or alpha-3 country codes (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{2,3}$`',
    `tax_treatment` STRING COMMENT 'Tax treatment classification for this revenue stream: taxable (subject to VAT/GST/sales tax), exempt, zero-rated, or out of scope.. Valid values are `taxable|exempt|zero_rated|out_of_scope`',
    `created_by` STRING COMMENT 'User ID or name of the person who created this revenue stream record. Used for audit trail and accountability.',
    CONSTRAINT pk_revenue_stream PRIMARY KEY(`revenue_stream_id`)
) COMMENT 'Master classification of all revenue-generating streams across Media Broadcasting — advertising (upfront, scatter, DAI), subscription (SVOD, AVOD, TVOD), carriage fees, syndication license fees, content licensing, and ancillary revenues. Defines stream code, stream name, revenue category, recognition method (ASC 606 / IFRS 15), associated profit center, tax treatment, and reporting segment. Serves as the authoritative revenue taxonomy for financial reconciliation and EBITDA reporting.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` (
    `revenue_recognition_event_id` BIGINT COMMENT 'Unique identifier for the revenue recognition event. Primary key for this transactional record of revenue posting in SAP S/4HANA.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Revenue recognition events post to GL accounts. The gl_account_code STRING is a business key that should be supplemented with FK to chart_of_accounts.chart_of_accounts_id.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Revenue recognition events belong to legal entities for financial reporting. The company_code is a business key reference to legal_entity.',
    `title_id` BIGINT COMMENT 'Reference to the content title (series, episode, film, program) associated with this revenue recognition event. Enables revenue attribution by content asset for rights and royalties management.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue can be allocated to cost centers for revenue tracking. The cost_center_code STRING column will be replaced by FK to cost_center.cost_center_id.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Revenue recognition events post to specific GL account/period combinations in SAP FI. The revenue_recognition_event table already has chart_of_accounts_id, cost_center_id, and profit_center_id, but no',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Revenue recognition events are triggered by specific rights grants being exercised (e.g., a broadcast window opening under a grant). Grant-level revenue tracking enables rights exploitation revenue re',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice issued to the customer for this revenue. Links revenue recognition to accounts receivable and cash collection for revenue assurance.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Every revenue recognition event in SAP S/4HANA generates a corresponding FI journal entry document. The revenue_recognition_event table has accounting_document_number (a string reference) but no forma',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Revenue recognition events in media broadcasting are tied to specific license agreements — the contract under which revenue is recognized per ASC 606/IFRS 15. Contract-level revenue recognition report',
    `original_recognition_event_revenue_recognition_event_id` BIGINT COMMENT 'Reference to the original revenue recognition event ID if this record represents a reversal or adjustment. Enables full audit trail of revenue corrections.',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Per-episode licensing revenue is recognized at episode delivery under episodic deal structures. Finance tracks which production episode triggered each recognition event for episodic deal accounting an',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue is allocated to profit centers for P&L tracking and EBITDA reporting. The profit_center_code STRING column will be replaced by FK to profit_center.profit_center_id.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Revenue recognition events are classified by revenue stream (advertising, subscription, carriage fees, syndication). The revenue_stream_type STRING column will be replaced by FK to revenue_stream.reve',
    `subscriber_id` BIGINT COMMENT 'Reference to the customer (advertiser, subscriber, distributor, licensee) who is the counterparty to the revenue-generating contract. Links to the master customer entity.',
    `accounting_document_number` STRING COMMENT 'The SAP S/4HANA accounting document number (FI document) that records this revenue recognition event. Provides full audit trail and drill-back capability to source transactions.',
    `asc_606_compliant_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) confirming that this revenue recognition event was processed in accordance with ASC 606 (US GAAP) revenue recognition standards.',
    `company_code` STRING COMMENT 'SAP S/4HANA company code representing the legal entity or business unit that recognized this revenue. Used for intercompany eliminations and consolidated financial reporting.',
    `contract_modification_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this revenue recognition event resulted from a contract modification. ASC 606 requires specific accounting treatment for modified contracts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition event record was first created in the system. Critical for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the recognized and deferred amounts (e.g., USD, GBP, EUR). Critical for multi-currency financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `deferred_amount` DECIMAL(18,2) COMMENT 'The monetary amount of revenue deferred (not yet recognized) as of this event. Represents unearned revenue that will be recognized in future periods as performance obligations are satisfied.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year in which this revenue recognition event was posted. Critical for monthly financial reporting and revenue trending.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this revenue recognition event was posted. Used for period-end close, annual financial statements, and year-over-year revenue analysis.',
    `gl_account_code` STRING COMMENT 'The general ledger account code in SAP S/4HANA chart of accounts to which this revenue recognition event was posted. Enables financial statement mapping and SOX-compliant audit trails.',
    `ifrs_15_compliant_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) confirming that this revenue recognition event was processed in accordance with IFRS 15 (International Financial Reporting Standards) revenue recognition standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition event record was last modified. Tracks changes for SOX compliance and financial audit requirements.',
    `notes` STRING COMMENT 'Free-text notes providing additional context or explanation for this revenue recognition event. Used for audit documentation, special accounting treatments, or manual adjustments.',
    `platform_type` STRING COMMENT 'The distribution platform or channel through which the revenue was generated: linear (traditional broadcast), OTT (over-the-top streaming), VOD (video on demand), SVOD (subscription VOD), AVOD (ad-supported VOD), TVOD (transactional VOD), FAST (free ad-supported streaming TV), MVPD (multichannel video programming distributor), vMVPD (virtual MVPD), or syndication (content resale). [ENUM-REF-CANDIDATE: linear|ott|vod|svod|avod|tvod|fast|mvpd|vmvpd|syndication — 10 candidates stripped; promote to reference product]',
    `recognition_date` DATE COMMENT 'The accounting date on which this revenue was recognized in the general ledger. This is the principal business event timestamp for financial reporting and period-end close.',
    `recognition_method` STRING COMMENT 'The revenue recognition method applied: point_in_time (recognized at a single moment, e.g., ad spot delivery), over_time (recognized ratably over contract term, e.g., subscription), milestone (recognized upon achievement of contractual milestones), or percentage_of_completion (recognized based on progress toward completion).. Valid values are `point_in_time|over_time|milestone|percentage_of_completion`',
    `recognition_status` STRING COMMENT 'Current lifecycle status of this revenue recognition event: recognized (fully posted to GL), deferred (not yet earned), partially_recognized (over-time recognition in progress), reversed (corrected or cancelled), or adjusted (modified post-recognition).. Valid values are `recognized|deferred|partially_recognized|reversed|adjusted`',
    `recognized_amount` DECIMAL(18,2) COMMENT 'The monetary amount of revenue recognized in this event and posted to the general ledger. Represents the earned portion of the transaction price allocated to the performance obligation.',
    `revenue_assurance_status` STRING COMMENT 'Status of revenue assurance validation for this recognition event: verified (passed all controls), pending_verification (awaiting reconciliation), discrepancy_identified (variance detected), or reconciled (discrepancy resolved).. Valid values are `verified|pending_verification|discrepancy_identified|reconciled`',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for revenue reversal or adjustment if recognition_status is reversed or adjusted. Examples: contract cancellation, pricing correction, performance obligation not met, billing error.',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this revenue recognition event is subject to Sarbanes-Oxley (SOX) internal control testing and audit requirements.',
    `transaction_date` DATE COMMENT 'The original business transaction date (e.g., ad spot air date, subscription activation date, content delivery date) that triggered the revenue recognition event. May differ from recognition_date for deferred or over-time recognition scenarios.',
    CONSTRAINT pk_revenue_recognition_event PRIMARY KEY(`revenue_recognition_event_id`)
) COMMENT 'Transactional record of each revenue recognition event posted in SAP S/4HANA for Media Broadcasting revenue streams — capturing the point-in-time or over-time recognition of advertising revenue, subscription fees, carriage fees, and content licensing income. Stores recognition date, recognized amount, deferred amount, performance obligation reference, contract modification flag, revenue stream, GL account, company code, and ASC 606 / IFRS 15 compliance indicators.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` (
    `accounts_receivable_id` BIGINT COMMENT 'Unique identifier for the accounts receivable record. Primary key for this entity.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: AR records must link to the billing account for customer-level AR aging, credit limit management, and collections workflow. Media broadcasters manage AR at account level across multiple invoices for d',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: AR postings reference GL accounts from the chart of accounts. The gl_account STRING is a business key that should be supplemented with FK to chart_of_accounts.chart_of_accounts_id.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Accounts receivable records must be associated with a legal entity for consolidation and reporting. The company_code is a business key reference to legal_entity. FK enables proper legal entity consoli',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AR records can be allocated to cost centers for revenue tracking. The cost_center STRING column will be replaced by FK to cost_center.cost_center_id.',
    `credit_memo_id` BIGINT COMMENT 'Foreign key linking to billing.credit_memo. Business justification: AR records must link to credit memos that adjust them, required for dispute resolution tracking, bad debt analysis, and financial close. Advertising billing frequently involves makegoods and credits t',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: In SAP FI, the AR subledger reconciles to GL reconciliation accounts at the period level. Each AR record posts to a specific GL account/period combination. Adding general_ledger_id to accounts_receiva',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice document that originated this receivable entry.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: SAP FI-AR records are created from FI journal entry documents — each AR open item corresponds to a specific accounting document posted to the subledger. The accounts_receivable table has document_numb',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: AR entries for license fees are directly tied to license agreements. AR aging reports, collections management, and dispute resolution in media broadcasting require knowing which license agreement an A',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: AR records must link to payments that clear them, required for cash application, aging analysis, and dunning process. Media broadcasters need to track which payments cleared which AR line items for re',
    `political_ad_record_id` BIGINT COMMENT 'Foreign key linking to compliance.political_ad_record. Business justification: Political advertising receivables require public file disclosure with payment details and rate compliance (lowest unit charge rules). AR aging and collection for political ads must be tracked separate',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: AR records track profit center for revenue attribution and EBITDA reporting. The profit_center STRING column will be replaced by FK to profit_center.profit_center_id.',
    `refund_id` BIGINT COMMENT 'Foreign key linking to billing.refund. Business justification: AR records must link to refunds that reverse them, required for churn analysis, revenue reversal tracking, and cash flow reporting. Subscription businesses need to track which AR line items were rever',
    `revenue_recognition_event_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition_event. Business justification: In Media Broadcasting, AR records are generated from revenue recognition events — when advertising revenue, subscription fees, or carriage fees are recognized under ASC 606/IFRS 15, a corresponding AR',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: AR is classified by revenue stream type (advertising, subscription, carriage fees, syndication). The revenue_stream STRING column will be replaced by FK to revenue_stream.revenue_stream_id for proper ',
    `subscriber_id` BIGINT COMMENT 'Identifier of the customer (advertiser, MVPD, syndication partner, or content licensee) who owes the receivable amount.',
    `aging_bucket` STRING COMMENT 'The aging category of the receivable based on days past due (current, 1-30 days, 31-60 days, 61-90 days, over 90 days).. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `assignment_field` STRING COMMENT 'Free-text assignment field used for additional sorting, grouping, or reconciliation purposes in SAP FI-AR.',
    `baseline_date` DATE COMMENT 'The reference date used to calculate payment terms and due date, typically the document date or posting date.',
    `business_unit` STRING COMMENT 'The business unit or division within Media Broadcasting that owns this receivable (e.g., Linear TV, Streaming, News, Sports).',
    `clearing_date` DATE COMMENT 'The date when the receivable was fully cleared through payment or other settlement mechanism. Null if still open.',
    `clearing_status` STRING COMMENT 'Current clearing status of the receivable indicating whether it is open, partially cleared, fully cleared, disputed, or written off.. Valid values are `open|partially_cleared|fully_cleared|disputed|written_off`',
    `company_code` STRING COMMENT 'The SAP company code representing the legal entity that holds this receivable.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this accounts receivable record was first created in the system.',
    `days_past_due` STRING COMMENT 'The number of days the receivable is overdue, calculated as the difference between current date and due date. Zero or negative if not yet due.',
    `dispute_date` DATE COMMENT 'The date when the customer formally disputed this receivable.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether the customer has disputed this receivable (True = disputed, False = not disputed).',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason the customer has disputed this receivable, if applicable.',
    `document_currency` STRING COMMENT 'The three-letter ISO 4217 currency code in which the receivable was originally denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date on the original business document (invoice date, credit memo date) that created this receivable.',
    `document_number` STRING COMMENT 'The externally-known business document number for this receivable entry, typically the SAP FI-AR document number.',
    `document_type` STRING COMMENT 'Classification of the receivable document type (invoice, credit memo, debit memo, payment, down payment, adjustment).. Valid values are `invoice|credit_memo|debit_memo|payment|down_payment|adjustment`',
    `due_date` DATE COMMENT 'The date by which payment is expected from the customer based on payment terms.',
    `dunning_date` DATE COMMENT 'The date when the most recent dunning notice was sent to the customer for this receivable.',
    `dunning_level` STRING COMMENT 'The current dunning level indicating the escalation stage of collection efforts (0 = no dunning, 1-9 = escalating levels).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate used to convert document currency to local currency at the time of posting.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when this receivable was posted.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this receivable was posted, used for period-end close and financial reporting.',
    `gl_account` STRING COMMENT 'The general ledger account code to which this receivable is posted in the chart of accounts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this accounts receivable record was last updated or modified.',
    `local_currency` STRING COMMENT 'The three-letter ISO 4217 currency code of the companys local reporting currency.. Valid values are `^[A-Z]{3}$`',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The receivable amount converted to the companys local reporting currency for consolidation and financial reporting.',
    `open_amount` DECIMAL(18,2) COMMENT 'The current outstanding amount still owed by the customer in document currency after partial payments or adjustments.',
    `original_amount` DECIMAL(18,2) COMMENT 'The original gross amount of the receivable in document currency when first posted.',
    `payment_method` STRING COMMENT 'The expected or actual payment method for settling this receivable (wire transfer, check, ACH, credit card, direct debit, cash).. Valid values are `wire_transfer|check|ach|credit_card|direct_debit|cash`',
    `payment_terms` STRING COMMENT 'The payment terms code defining the due date calculation, discount periods, and payment conditions (e.g., Net 30, 2/10 Net 30).',
    `posting_date` DATE COMMENT 'The date when the receivable was posted to the general ledger in the financial system.',
    `reference_document` STRING COMMENT 'External reference document number such as customer purchase order number, contract number, or other business reference.',
    `text_description` STRING COMMENT 'Free-text description or memo field providing additional context about this receivable entry.',
    CONSTRAINT pk_accounts_receivable PRIMARY KEY(`accounts_receivable_id`)
) COMMENT 'SAP FI-AR authoritative record of outstanding receivables owed to Media Broadcasting from advertisers, MVPDs, syndication partners, and content licensees. Captures customer account, invoice reference, due date, open amount, currency, payment terms, dunning level, clearing status, aging bucket, and dispute flag. Supports cash flow forecasting, revenue assurance, and period-end close reconciliation.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` (
    `accounts_payable_id` BIGINT COMMENT 'Unique identifier for the accounts payable record. Primary key for the accounts payable entity.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: AP postings reference GL accounts from the chart of accounts. The gl_account STRING is a business key that should be supplemented with FK to chart_of_accounts.chart_of_accounts_id for referential inte',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Accounts payable records must be associated with a legal entity for consolidation and reporting. The company_code is a business key reference to legal_entity. FK will enable proper legal entity consol',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AP records can be allocated to cost centers for expense tracking. The cost_center STRING column will be replaced by FK to cost_center.cost_center_id, enabling proper cost allocation and budget trackin',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: In SAP FI, the AP subledger reconciles to GL reconciliation accounts at the period level. Each AP record posts to a specific GL account/period combination. Adding general_ledger_id to accounts_payable',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: SAP FI-AP records are created from FI journal entry documents — each AP open item corresponds to a specific accounting document. The accounts_payable table has document_number (string) but no formal F',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: In SAP FI-AP, payable documents are assigned to profit centers for P&L allocation — critical in Media Broadcasting where talent agency fees, production vendor payments, and distribution costs must be ',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor to whom payment is owed. Links to talent agencies, production vendors, content licensors, technology providers, and distribution partners.',
    `assignment_reference` STRING COMMENT 'Free-text reference field for additional assignment information (e.g., production code, content title, project ID). Used for detailed cost tracking.',
    `baseline_date` DATE COMMENT 'Date from which payment terms are calculated. Typically the document date or goods receipt date, used to determine the due date.',
    `clearing_date` DATE COMMENT 'Date when the payable was fully cleared (paid). Null if still open or partially cleared.',
    `clearing_document_number` STRING COMMENT 'SAP FI document number of the payment document that cleared this payable. Null if not yet cleared.. Valid values are `^[0-9]{10}$`',
    `clearing_status` STRING COMMENT 'Current clearing status of the payable. Open=unpaid, Partially Cleared=partial payment applied, Fully Cleared=completely paid.. Valid values are `open|partially_cleared|fully_cleared`',
    `company_code` STRING COMMENT 'Four-character SAP company code representing the legal entity responsible for this payable. Used for financial consolidation and reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accounts payable record was first created in the SAP FI-AP system. Used for audit trail and data lineage.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Potential cash discount amount available if payment is made by the discount due date, in document currency.',
    `discount_due_date` DATE COMMENT 'Date by which payment must be made to qualify for early payment discount. Null if no discount terms apply.',
    `document_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice (e.g., USD, EUR, GBP). Currency in which the vendor billed.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'Date on the vendor invoice or credit memo. Typically the invoice date provided by the vendor.',
    `document_number` STRING COMMENT 'Ten-digit SAP FI document number uniquely identifying this payable within the company code and fiscal year. The externally-known business identifier for this payable.. Valid values are `^[0-9]{10}$`',
    `document_type` STRING COMMENT 'SAP document type code classifying the nature of the payable. KR=Vendor Invoice, KG=Vendor Credit Memo, KN=Net Vendor Invoice, RE=Invoice Receipt, DR=Debit Memo.. Valid values are `KR|KG|KN|RE|DR`',
    `due_date` DATE COMMENT 'Date by which payment is due to the vendor. Calculated from baseline date and payment terms. Critical for cash management and avoiding late payment penalties.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert document currency to local currency at posting date. Null if document currency equals local currency.',
    `fiscal_period` STRING COMMENT 'Fiscal period (1-12 or 1-16 for special periods) within the fiscal year when the document was posted. Used for monthly financial close.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year in which the document was posted. Used for period-end close and financial reporting.',
    `gl_account` STRING COMMENT 'Ten-digit general ledger account number to which this payable is posted. Determines the expense or asset classification in the chart of accounts.. Valid values are `^[0-9]{10}$`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before any deductions, in document currency. Represents the full amount billed by the vendor.',
    `invoice_reference` STRING COMMENT 'Vendor-provided invoice number or reference identifier. Used for vendor reconciliation and payment matching.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this accounts payable record was last modified (e.g., payment block added, partial payment applied). Used for audit trail.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Net payable amount converted to the company code local currency for general ledger posting and financial reporting.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount payable to vendor after all deductions (discounts, withholding tax), in document currency. This is the amount that will be paid.',
    `open_amount` DECIMAL(18,2) COMMENT 'Outstanding unpaid amount remaining on this payable, in document currency. Reduced as partial payments are applied. Zero when fully cleared.',
    `payment_block` STRING COMMENT 'Single-character code indicating if payment is blocked (e.g., A=Blocked for Payment, R=Blocked for Review, blank=Not Blocked). Prevents automatic payment until resolved.. Valid values are `^[A-Z]{1}$`',
    `payment_block_reason` STRING COMMENT 'Free-text explanation for why payment is blocked (e.g., pending approval, invoice dispute, missing documentation). Null if not blocked.',
    `payment_method` STRING COMMENT 'Single-character code indicating the payment method (e.g., C=Check, T=Wire Transfer, E=Electronic Funds Transfer, A=ACH). Determines payment run processing.. Valid values are `^[A-Z]{1}$`',
    `payment_terms` STRING COMMENT 'Four-character code defining the payment terms negotiated with the vendor (e.g., net 30, 2/10 net 30). Determines due date and cash discount eligibility.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'Date when the accounts payable document was posted to the general ledger. Determines the fiscal period for financial reporting.',
    `purchase_order_number` STRING COMMENT 'Ten-digit purchase order number if this payable originated from a PO-based procurement. Used for three-way match (PO, goods receipt, invoice).. Valid values are `^[0-9]{10}$`',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this payable is subject to SOX financial controls and requires additional approval workflows. True for material transactions.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount included in the invoice (VAT, sales tax, GST), in document currency. May include multiple tax jurisdictions.',
    `text_description` STRING COMMENT 'Free-text description of the payable, typically describing the goods or services invoiced (e.g., Q4 2023 content licensing fees, Studio equipment rental).',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from vendor payment per tax regulations (e.g., talent residuals withholding, foreign vendor withholding), in document currency.',
    `withholding_tax_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether withholding tax applies to this payable. True if withholding tax is calculated and deducted.',
    CONSTRAINT pk_accounts_payable PRIMARY KEY(`accounts_payable_id`)
) COMMENT 'SAP FI-AP authoritative record of outstanding payables owed by Media Broadcasting to talent agencies, production vendors, content licensors, technology providers, and distribution partners. Captures vendor account, invoice reference, due date, open amount, currency, payment terms, payment block status, withholding tax indicator, and clearing status. Supports cash management, vendor payment runs, and period-end close.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
    `parent_entity_legal_entity_id` BIGINT COMMENT 'Reference to the parent legal entity in the corporate hierarchy. Used to establish organizational structure and consolidation relationships. Null for the ultimate parent entity.',
    `accounting_standard` STRING COMMENT 'Primary accounting standard or framework used for financial reporting by this legal entity. Determines recognition, measurement, and disclosure requirements.. Valid values are `GAAP|IFRS|local_statutory`',
    `activation_date` DATE COMMENT 'The date on which the legal entity became active and began conducting business operations. Used for financial reporting period determination.',
    `broadcast_license_holder_flag` BOOLEAN COMMENT 'Indicates whether this legal entity holds one or more broadcast licenses issued by the FCC or equivalent regulatory authority. True if the entity is a licensed broadcaster.',
    `chart_of_accounts` STRING COMMENT 'Four-character code identifying the chart of accounts assigned to this legal entity in SAP S/4HANA. Defines the structure of general ledger accounts used for financial postings.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code` STRING COMMENT 'Four-character alphanumeric code uniquely identifying the legal entity within the SAP S/4HANA FI module. Used as the organizational unit for financial accounting and the smallest organizational unit for which a complete self-contained set of accounts can be drawn up for purposes of external reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_group` STRING COMMENT 'Identifier for the consolidation group or reporting unit to which this legal entity belongs. Used for corporate consolidation, intercompany eliminations, and segment reporting.',
    `country_of_incorporation` STRING COMMENT 'Three-letter ISO country code representing the country where the legal entity is incorporated and registered. Determines primary legal jurisdiction and regulatory framework.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this legal entity record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_control_area` STRING COMMENT 'Four-character code identifying the credit control area assigned to this legal entity in SAP S/4HANA. Used for credit management and accounts receivable monitoring.. Valid values are `^[A-Z0-9]{4}$`',
    `deactivation_date` DATE COMMENT 'The date on which the legal entity ceased active operations or was dissolved. Null for active entities. Used to determine the end of financial reporting obligations.',
    `ebitda_reporting_flag` BOOLEAN COMMENT 'Indicates whether this legal entity is included in corporate EBITDA calculations and segment performance reporting. True if the entity contributes to consolidated EBITDA metrics.',
    `entity_status` STRING COMMENT 'Current operational status of the legal entity. Active indicates the entity is conducting business; inactive indicates temporary suspension; dormant indicates no current operations but entity remains registered; liquidation indicates entity is being wound down; dissolved indicates entity has been formally closed.. Valid values are `active|inactive|dormant|liquidation|dissolved`',
    `entity_type` STRING COMMENT 'Classification of the legal entity based on its primary business function within the Media Broadcasting corporate structure. Determines the operational model and reporting requirements.. Valid values are `broadcast_network|streaming_platform|production_studio|holding_company|subsidiary|joint_venture`',
    `fiscal_year_variant` STRING COMMENT 'Two-character code defining the fiscal year structure for this legal entity, including the number of periods, period start and end dates, and year-end closing rules. Used for period-based financial reporting.. Valid values are `^[A-Z0-9]{2}$`',
    `functional_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the primary currency in which the entity conducts its business and maintains its books of account. Used for financial statement preparation and consolidation.. Valid values are `^[A-Z]{3}$`',
    `incorporation_date` DATE COMMENT 'The date on which the legal entity was officially incorporated or registered with the governing authority.',
    `intercompany_elimination_group` STRING COMMENT 'Code identifying the group of entities for which intercompany transactions must be eliminated during consolidation. Used to ensure accurate consolidated financial statements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this legal entity record was last updated. Used for change tracking and audit compliance.',
    `legal_entity_name` STRING COMMENT 'Full legal name of the entity as registered with the governing authority. This is the official name used in all legal documents, contracts, regulatory filings, and financial statements.',
    `legal_form` STRING COMMENT 'The legal structure or incorporation type of the entity (e.g., Corporation, Limited Liability Company, Partnership, Public Limited Company). Determines liability, taxation, and regulatory obligations.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of equity ownership held by the parent entity. Used for consolidation calculations and minority interest determination. Range: 0.00 to 100.00.',
    `primary_contact_email` STRING COMMENT 'Primary email address for official correspondence with the legal entity. Used for regulatory notifications and corporate communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the legal entity. Used for official business communications.',
    `registered_address_line1` STRING COMMENT 'First line of the official registered address of the legal entity as filed with the incorporation authority. Used for legal correspondence and regulatory filings.',
    `registered_address_line2` STRING COMMENT 'Second line of the official registered address (suite, floor, building name). Optional field for additional address details.',
    `registered_city` STRING COMMENT 'City or municipality of the registered address.',
    `registered_country` STRING COMMENT 'Three-letter ISO country code for the registered address. Typically matches the country of incorporation.. Valid values are `^[A-Z]{3}$`',
    `registered_postal_code` STRING COMMENT 'Postal or ZIP code of the registered address.',
    `registered_state_province` STRING COMMENT 'State, province, or region of the registered address. Uses standard postal abbreviations where applicable.',
    `registration_number` STRING COMMENT 'Official registration or incorporation number assigned by the government authority in the country of incorporation. Used for legal identification and regulatory compliance.',
    `regulatory_reporting_obligations` STRING COMMENT 'Comma-separated list of regulatory reporting frameworks and obligations applicable to this legal entity (e.g., SEC 10-K, FCC Form 323, Ofcom Annual Return). Determines mandatory filings and disclosure requirements.',
    `reporting_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency used for external financial reporting and consolidation at the corporate level.. Valid values are `^[A-Z]{3}$`',
    `short_name` STRING COMMENT 'Abbreviated or trade name of the legal entity used for internal reporting and operational purposes.',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this legal entity is within the scope of SOX compliance and internal control testing. True if the entity is material to consolidated financial statements and subject to SOX Section 404 requirements.',
    `tax_identification_number` STRING COMMENT 'Primary tax identification number assigned by the tax authority in the country of incorporation. Used for all tax filings, withholding, and revenue reporting.',
    `vat_registration_number` STRING COMMENT 'VAT or GST registration number for entities operating in jurisdictions requiring VAT registration. Used for VAT reporting and cross-border transactions.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master record of each legal entity, company code, and reporting unit within the Media Broadcasting corporate structure — including broadcast networks, streaming platforms, production studios, and holding companies. Captures company code, legal entity name, country of incorporation, functional currency, fiscal year variant, chart of accounts assignment, consolidation group, tax registration numbers, and regulatory reporting obligations (SOX, IFRS, GAAP). The organizational anchor for all financial postings.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ADD CONSTRAINT `fk_finance_revenue_stream_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ADD CONSTRAINT `fk_finance_revenue_stream_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ADD CONSTRAINT `fk_finance_revenue_stream_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ADD CONSTRAINT `fk_finance_revenue_stream_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_original_recognition_event_revenue_recognition_event_id` FOREIGN KEY (`original_recognition_event_revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_entity_legal_entity_id` FOREIGN KEY (`parent_entity_legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= TAGS =========
ALTER SCHEMA `media_broadcasting_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `media_broadcasting_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` SET TAGS ('dbx_subdomain' = 'accounting_structure');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_currency` SET TAGS ('dbx_business_glossary_term' = 'Account Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'Account Group Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_short_text` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Short Text');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending_approval');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type Classification');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_business_glossary_term' = 'Alternative Account Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Classification');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_value_regex' = 'current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `consolidation_account` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Mapping');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_center_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|revenue|none');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_item` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Item Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `line_item_display_allowed` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Allowed Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `materiality_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Materiality Threshold Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `open_item_management` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `pl_statement_classification` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Statement Classification');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `planning_level` SET TAGS ('dbx_business_glossary_term' = 'Planning Level Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `posting_blocked` SET TAGS ('dbx_business_glossary_term' = 'Posting Blocked Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `profit_center_required` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `reconciliation_account_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `reconciliation_account_type` SET TAGS ('dbx_value_regex' = 'customer|vendor|asset|none');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `sox_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Classification');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `sox_control_classification` SET TAGS ('dbx_value_regex' = 'key_control|supporting_control|not_in_scope');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `trading_partner_required` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'accounting_structure');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_allocation_reference` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Reference');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|activity_based|percentage|driver_based');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'direct|indirect|overhead|capital');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending_closure');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Group');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `ebitda_reporting_segment` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Reporting Segment');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_node` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Hierarchy Node');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `is_revenue_generating` SET TAGS ('dbx_business_glossary_term' = 'Is Revenue Generating');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Notes');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'accounting_structure');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `budget_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Method');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `budget_allocation_method` SET TAGS ('dbx_value_regex' = 'top_down|bottom_up|zero_based|incremental');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_assignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Assignment Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `ebitda_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Reporting Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `hierarchy_node` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Node');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `intercompany_elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Notes');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'revenue_center|cost_center|investment_center|service_center');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `revenue_posting_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Posting Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Short Name');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `sox_control_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Scope Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_subdomain' = 'transaction_recording');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `budget_amount_functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount in Functional Currency');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `closing_balance_functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance in Functional Currency');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `consolidation_unit` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Unit');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `consolidation_unit` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `credit_amount_functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount in Functional Currency');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `credit_amount_transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount in Transaction Currency');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `debit_amount_functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount in Functional Currency');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `debit_amount_transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount in Transaction Currency');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `ebitda_indicator` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Indicator');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `functional_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `last_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Last Posting Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `ledger_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `net_balance_functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Net Balance in Functional Currency');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `opening_balance_functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance in Functional Currency');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `period_lock_status` SET TAGS ('dbx_business_glossary_term' = 'Period Lock Status');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `period_lock_status` SET TAGS ('dbx_value_regex' = 'open|closed|locked');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `reconciliation_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Indicator');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `revenue_stream_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Category');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `sox_control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Indicator');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `trading_partner` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `trading_partner` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`general_ledger` ALTER COLUMN `variance_amount_functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount in Functional Currency');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'transaction_recording');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `accrual_reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Reversal Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `accrual_reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Accrual Reversal Indicator');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'standard|accrual|prepayment|reclassification|elimination|correction');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `batch_input_session` SET TAGS ('dbx_business_glossary_term' = 'Batch Input Session Name');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Document Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_header_text` SET TAGS ('dbx_business_glossary_term' = 'Document Header Text');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_time` SET TAGS ('dbx_business_glossary_term' = 'Entry Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Indicator');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `parked_indicator` SET TAGS ('dbx_business_glossary_term' = 'Parked Document Indicator');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `recurring_entry_indicator` SET TAGS ('dbx_business_glossary_term' = 'Recurring Entry Indicator');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_company_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Company Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Code (T-Code)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ALTER COLUMN `workflow_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|posted|reversed');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` SET TAGS ('dbx_subdomain' = 'revenue_planning');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `production_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget Identifier');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `above_the_line_amount` SET TAGS ('dbx_business_glossary_term' = 'Above-The-Line Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `actual_spend_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend To Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `below_the_line_amount` SET TAGS ('dbx_business_glossary_term' = 'Below-The-Line Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `budget_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `budget_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `budget_notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `budget_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `facilities_amount` SET TAGS ('dbx_business_glossary_term' = 'Facilities Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `music_licensing_amount` SET TAGS ('dbx_business_glossary_term' = 'Music Licensing Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `post_production_amount` SET TAGS ('dbx_business_glossary_term' = 'Post-Production Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `production_end_date` SET TAGS ('dbx_business_glossary_term' = 'Production End Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Start Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `total_approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ALTER COLUMN `vfx_amount` SET TAGS ('dbx_business_glossary_term' = 'Visual Effects (VFX) Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` SET TAGS ('dbx_subdomain' = 'revenue_planning');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'ASC_606|IFRS_15|GAAP|local_GAAP');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `audience_measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Audience Measurement Source');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percent');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `is_deferred` SET TAGS ('dbx_business_glossary_term' = 'Is Deferred Revenue');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Revenue');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `makegoods_policy` SET TAGS ('dbx_business_glossary_term' = 'Makegoods Policy');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `makegoods_policy` SET TAGS ('dbx_value_regex' = 'automatic|negotiated|none|audience_based|technical_failure');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Notes');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `performance_obligation` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'CPM|flat_rate|tiered|usage_based|revenue_share|hybrid');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|usage_based|milestone_based');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `reporting_segment` SET TAGS ('dbx_business_glossary_term' = 'Reporting Segment');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `revenue_stream_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Status');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `revenue_stream_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|deprecated');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `revenue_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Revenue Subcategory');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Control Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `stream_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `stream_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `stream_name` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Name');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_value_regex' = 'taxable|exempt|zero_rated|out_of_scope');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` SET TAGS ('dbx_subdomain' = 'revenue_planning');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `original_recognition_event_revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Original Recognition Event ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `accounting_document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `asc_606_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'ASC 606 Compliant Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `contract_modification_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Modification Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `deferred_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `ifrs_15_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS 15 Compliant Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Recognition Notes');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Recognition Method');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|milestone|percentage_of_completion');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Recognition Status');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_status` SET TAGS ('dbx_value_regex' = 'recognized|deferred|partially_recognized|reversed|adjusted');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `revenue_assurance_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Assurance Status');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `revenue_assurance_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|discrepancy_identified|reconciled');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX Control Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_subdomain' = 'transaction_recording');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `credit_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `political_ad_record_id` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Record Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'open|partially_cleared|fully_cleared|disputed|written_off');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_currency` SET TAGS ('dbx_business_glossary_term' = 'Document Currency');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Document Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'invoice|credit_memo|debit_memo|payment|down_payment|adjustment');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Dunning Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `open_amount` SET TAGS ('dbx_business_glossary_term' = 'Open Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|ach|credit_card|direct_debit|cash');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `reference_document` SET TAGS ('dbx_business_glossary_term' = 'Reference Document');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `text_description` SET TAGS ('dbx_business_glossary_term' = 'Text Description');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_subdomain' = 'transaction_recording');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `assignment_reference` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reference');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'open|partially_cleared|fully_cleared');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `discount_due_date` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Due Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `document_currency` SET TAGS ('dbx_business_glossary_term' = 'Document Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `document_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Document Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'KR|KG|KN|RE|DR');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gl_account` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Invoice Reference Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `open_amount` SET TAGS ('dbx_business_glossary_term' = 'Open Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_block` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_block` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `text_description` SET TAGS ('dbx_business_glossary_term' = 'Document Text Description');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ALTER COLUMN `withholding_tax_indicator` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Indicator');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'accounting_structure');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity ID');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'GAAP|IFRS|local_statutory');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `broadcast_license_holder_flag` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Holder Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Country of Incorporation');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_business_glossary_term' = 'Credit Control Area');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `ebitda_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Reporting Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_business_glossary_term' = 'Entity Status');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|dormant|liquidation|dissolved');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'broadcast_network|streaming_platform|production_studio|holding_company|subsidiary|joint_venture');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `functional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `intercompany_elimination_group` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Group');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_form` SET TAGS ('dbx_business_glossary_term' = 'Legal Form');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country` SET TAGS ('dbx_business_glossary_term' = 'Registered Country');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_business_glossary_term' = 'Registered State or Province');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `regulatory_reporting_obligations` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Obligations');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Short Name');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scope Flag');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `media_broadcasting_ecm`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
