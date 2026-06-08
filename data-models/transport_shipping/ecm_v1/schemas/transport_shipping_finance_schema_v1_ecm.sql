-- Schema for Domain: finance | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`finance` COMMENT 'SSOT for enterprise financial management including general ledger, cost center accounting, P&L reporting, CAPEX/OPEX budgeting, EBITDA tracking, intercompany settlements, tax filings, audit trails, and regulatory financial reporting. Owns chart of accounts, journal entries, and financial controls aligned to IFRS and SOX requirements. Powered by SAP S/4HANA Finance and interfaces with billing, contract, and procurement domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`ledger` (
    `ledger_id` BIGINT COMMENT 'Unique identifier for the general ledger account. Primary key for the ledger entity. Serves as the system-generated surrogate key for all GL account records in the chart of accounts.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: ledger has gl_account_number (STRING) and account attributes but no FK to chart_of_accounts master. The ledger entity represents GL account balances and MUST reference the chart_of_accounts master. Th',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity or company code that owns this GL account. In SAP S/4HANA, the company code represents the smallest organizational unit for which a complete self-contained set of accounts can be drawn up for external reporting. Links the account to a specific legal entity for statutory reporting and audit trails.',
    `account_description_long` STRING COMMENT 'Extended free-text description providing detailed explanation of the accounts purpose, usage guidelines, and posting rules. Supports user training, audit documentation, and chart of accounts governance. Complements the short account_name with comprehensive business context.',
    `account_status` STRING COMMENT 'Current lifecycle status of the GL account. Active accounts accept postings; inactive accounts are closed to new transactions but retain historical balances; blocked accounts are temporarily suspended; pending_closure accounts are scheduled for archival. Controls whether journal entries can be posted to this account.. Valid values are `active|inactive|blocked|pending_closure`',
    `alternative_account_number` STRING COMMENT 'Secondary or legacy account number used for migration, external reporting, or integration with non-SAP systems. Maintains cross-reference to previous chart of accounts structures or statutory reporting account codes. Facilitates data migration, historical comparisons, and regulatory filings.',
    `blocked_for_posting_flag` BOOLEAN COMMENT 'Temporary block indicator that prevents all postings to this account regardless of user authorization. True when account is under investigation, audit review, or pending correction; false for normal operations. Provides emergency control to freeze account activity during exception handling or compliance reviews.',
    `budget_control_flag` BOOLEAN COMMENT 'Indicates whether this account is subject to budget availability checking before posting. True for CAPEX and OPEX accounts with approved budgets; false for revenue and balance sheet accounts. Enforces budgetary controls and prevents overspending against approved financial plans.',
    `business_area_required_flag` BOOLEAN COMMENT 'Indicates whether a business area (division/segment) assignment is mandatory when posting to this account. True for accounts requiring cross-company-code segment reporting; false for accounts not subject to divisional analysis. Supports matrix reporting and segment disclosure per IFRS 8.',
    `cash_flow_category` STRING COMMENT 'Classification for cash flow statement presentation per IFRS IAS 7. Determines whether cash movements in this account are reported as operating activities (e.g., freight revenue, fuel expense), investing activities (e.g., CAPEX, asset disposals), or financing activities (e.g., debt, equity). Not_applicable for non-cash accounts.. Valid values are `operating|investing|financing|not_applicable`',
    `consolidation_account_number` STRING COMMENT 'The mapped account number in the group chart of accounts used for corporate consolidation and group reporting. Enables translation from local entity chart of accounts to standardized group reporting structure. Critical for multi-entity consolidation, intercompany eliminations, and group financial statements.',
    `cost_center_required_flag` BOOLEAN COMMENT 'Indicates whether a cost center assignment is mandatory when posting to this account. True for expense accounts requiring departmental cost tracking; false for revenue and balance sheet accounts. Enforces cost center accounting discipline and enables OPEX analysis by organizational unit, function, or location.',
    `cost_element_category` STRING COMMENT 'Classification for cost accounting integration. Primary cost elements represent direct postings from financial accounting (e.g., fuel, labor); secondary cost elements represent internal allocations and assessments; revenue elements track income; not_applicable for non-cost accounts. Critical for cost center accounting and profitability analysis.. Valid values are `primary|secondary|revenue|not_applicable`',
    `created_by_user` STRING COMMENT 'User ID of the person who created this GL account master record in the system. Supports audit trail, SOX compliance, and master data governance. Part of the standard change tracking required for financial system controls.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this GL account master record was first created in the system. Immutable audit field required for SOX compliance, master data lineage, and change history tracking. Recorded in UTC or system local time per configuration.',
    `currency_code` STRING COMMENT 'The functional currency in which this account maintains balances. Three-letter ISO 4217 code. For multi-currency environments, specifies the accounts base currency for translation and consolidation. Most accounts use the company codes local currency; some accounts may be designated for specific foreign currencies.. Valid values are `^[A-Z]{3}$`',
    `external_reporting_code` STRING COMMENT 'Standardized code for mapping this account to external regulatory reporting frameworks such as XBRL taxonomy tags, statutory chart of accounts, or industry-specific reporting templates. Examples: IFRS taxonomy element IDs, GAAP codification references, IMO financial reporting codes. Critical for automated regulatory filing and compliance reporting.',
    `field_status_group` STRING COMMENT 'Configuration key that controls which additional fields are required, optional, or suppressed when posting to this account. Examples: G001 (standard), G003 (cost center required), G010 (tax code required). Enforces data entry discipline and ensures consistent posting data quality across the organization.',
    `financial_statement_position` STRING COMMENT 'The specific line item or section code where this account appears on published financial statements. Maps GL accounts to IFRS/GAAP disclosure requirements and standardized financial statement templates. Examples: BS.CA.010 (Balance Sheet, Current Assets, line 010), PL.REV.100 (P&L, Revenue, line 100).',
    `functional_area` STRING COMMENT 'Classification of the account by business function for cost-of-sales accounting and functional expense reporting. Examples: OPERATIONS, SALES_MARKETING, ADMINISTRATION, FINANCE, IT. Enables P&L presentation by function (cost-of-sales method) as an alternative to nature-of-expense classification, per IFRS requirements.',
    `intercompany_clearing_flag` BOOLEAN COMMENT 'Indicates whether this account is used for intercompany transactions and settlements between legal entities within the group. True for intercompany receivables, payables, and clearing accounts that require elimination in consolidated financial statements. Critical for intercompany reconciliation and consolidation controls.',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified this GL account master record. Supports audit trail, change tracking, and accountability for master data changes. Updated automatically on every change to the account configuration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this GL account master record was last modified. Supports change tracking, audit trail, and master data governance. Updated automatically on every change to the account configuration. Critical for SOX compliance and change management controls.',
    `marked_for_deletion_flag` BOOLEAN COMMENT 'Indicates the account is scheduled for archival and removal from the active chart of accounts. True for obsolete accounts with zero balance and no open items; false for active accounts. Supports chart of accounts maintenance and master data governance. Accounts marked for deletion cannot accept new postings.',
    `open_item_management_flag` BOOLEAN COMMENT 'Indicates whether this account uses line-item (open item) management for detailed transaction tracking and clearing. True for accounts like AR, AP, bank clearing where individual line items must be tracked and cleared; false for summary accounts. Enables detailed aging analysis, payment matching, and reconciliation.',
    `planning_level` STRING COMMENT 'Granularity level at which this account is planned and budgeted. Examples: ACCOUNT, COST_CENTER, PROFIT_CENTER, PROJECT. Determines the organizational dimension for budget allocation, forecasting, and variance analysis. Supports multi-dimensional planning and rolling forecasts.',
    `posting_allowed_flag` BOOLEAN COMMENT 'Controls whether direct journal entry postings are permitted to this account. False for summary/rollup accounts that only receive automated allocations or consolidation entries. True for operational accounts that accept manual and automated postings. Enforces chart of accounts design and prevents posting errors.',
    `profit_center_required_flag` BOOLEAN COMMENT 'Indicates whether a profit center assignment is mandatory when posting to this account. True for revenue and expense accounts requiring segment profitability tracking; false for balance sheet accounts or centralized accounts. Enforces management accounting discipline and enables P&L reporting by business unit, service line, or geographic region.',
    `reconciliation_account_flag` BOOLEAN COMMENT 'Indicates whether this is a reconciliation account (subledger control account) that must match the sum of subsidiary ledger balances. True for accounts like Accounts Receivable, Accounts Payable, Fixed Assets where detailed subledger records must reconcile to the GL balance. Critical for SOX controls and audit trails.',
    `retained_earnings_account_flag` BOOLEAN COMMENT 'Indicates whether this is the designated retained earnings account that receives the net profit or loss transfer during year-end closing. True for the single equity account that accumulates undistributed profits; false for all other accounts. Critical for automated year-end closing and equity reconciliation.',
    `sort_key` STRING COMMENT 'Default sorting rule for line items posted to this account. Determines the assignment field used for document number generation, clearing, and reporting. Examples: 001 (posting date), 012 (document number), 014 (invoice reference). Standardizes line item organization and facilitates automated clearing processes.',
    `sustainability_reporting_flag` BOOLEAN COMMENT 'Indicates whether this account is relevant for environmental, social, and governance (ESG) reporting and sustainability disclosures. True for accounts tracking GHG emissions costs, carbon offset purchases, renewable energy investments, sustainability-linked financing, and environmental compliance expenses. Supports EU ETS, CORSIA, and voluntary ESG frameworks.',
    `tax_category` STRING COMMENT 'Tax treatment classification for this account. Determines automatic tax code derivation, VAT reporting category, and tax jurisdiction applicability. Examples: INPUT_VAT, OUTPUT_VAT, NON_TAXABLE, EXEMPT, REVERSE_CHARGE. Critical for customs brokerage, cross-border shipping, and multi-jurisdiction tax compliance.',
    `tolerance_group` STRING COMMENT 'Configuration key that defines posting amount limits, payment difference tolerances, and exchange rate variance thresholds for this account. Controls automated clearing tolerances and approval workflows for large transactions. Examples: STANDARD, HIGH_VALUE, PETTY_CASH. Supports risk management and fraud prevention.',
    `valid_from_date` DATE COMMENT 'The date from which this GL account becomes active and available for posting. Supports time-dependent chart of accounts changes, new account introductions, and fiscal year transitions. Postings before this date are rejected by the system.',
    `valid_to_date` DATE COMMENT 'The date after which this GL account is no longer active for posting. Supports account retirement, chart of accounts restructuring, and controlled phase-out of obsolete accounts. Nullable for accounts with indefinite validity. Postings after this date are rejected by the system.',
    CONSTRAINT pk_ledger PRIMARY KEY(`ledger_id`)
) COMMENT 'General ledger master entity representing the chart of accounts and ledger structure for Transport Shipping. Serves as the SSOT for all GL account definitions, account hierarchies, cost element classifications, and financial reporting structures aligned to IFRS and SOX requirements. Sourced from SAP S/4HANA Finance GL module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the chart of accounts entry. Primary key for this master reference entity.',
    `account_class` STRING COMMENT 'Functional classification indicating the operational role of the account: primary (standard posting), reconciliation (clearing and control), statistical (non-value tracking), or intercompany (inter-entity transactions).. Valid values are `primary|reconciliation|statistical|intercompany`',
    `account_group` STRING COMMENT 'Hierarchical grouping code that clusters related GL accounts together for reporting and analysis purposes. Used to aggregate accounts into meaningful financial statement line items.',
    `account_name` STRING COMMENT 'The full descriptive name of the GL account providing clear business context for the account purpose and usage.',
    `account_short_name` STRING COMMENT 'Abbreviated name or label for the GL account used in condensed reports and user interfaces where space is limited.',
    `account_status` STRING COMMENT 'Current lifecycle status of the GL account indicating whether it is available for posting (active), temporarily restricted (blocked), no longer in use (inactive), or awaiting activation (pending approval).. Valid values are `active|blocked|inactive|pending_approval`',
    `account_type` STRING COMMENT 'Primary classification of the account into fundamental accounting categories: asset, liability, equity, revenue, or expense. Determines the accounts role in financial statements and its normal balance (debit or credit).. Valid values are `asset|liability|equity|revenue|expense`',
    `approval_status` STRING COMMENT 'Current approval workflow status for this chart of accounts entry. Ensures proper governance and authorization before accounts become active for posting.. Valid values are `draft|pending_approval|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this chart of accounts entry was approved. Provides temporal audit trail for governance and compliance reporting.',
    `approved_by_user` STRING COMMENT 'The user ID of the person who approved this chart of accounts entry for activation. Documents authorization in compliance with segregation of duties requirements.',
    `audit_trail_required_flag` BOOLEAN COMMENT 'Indicates whether a complete audit trail of all changes and postings must be maintained for this account. Essential for regulatory compliance and forensic accounting requirements.',
    `balance_sheet_classification` STRING COMMENT 'Classification of balance sheet accounts into current (short-term) or non-current (long-term) categories for assets and liabilities, or equity. Not applicable for P&L accounts.. Valid values are `current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable`',
    `budget_control_flag` BOOLEAN COMMENT 'Indicates whether budget availability checking is enforced for this account. When true, postings are validated against approved budget allocations before commitment.',
    `cash_flow_classification` STRING COMMENT 'Classification of the account for cash flow statement reporting: operating activities, investing activities, financing activities, or not applicable for non-cash accounts.. Valid values are `operating|investing|financing|not_applicable`',
    `company_code` STRING COMMENT 'The four-character company code identifier representing the legal entity to which this chart of accounts entry belongs. Enables multi-entity financial management within the enterprise.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_account` STRING COMMENT 'The corresponding account code in the group consolidation chart of accounts. Maps local entity accounts to standardized group reporting accounts for consolidated financial statements.',
    `control_account_flag` BOOLEAN COMMENT 'Indicates whether this account serves as a control or summary account that aggregates balances from detail accounts. Control accounts typically do not allow direct postings.',
    `cost_element_flag` BOOLEAN COMMENT 'Indicates whether this GL account is also defined as a cost element in the controlling module, enabling cost center and internal order postings for management accounting.',
    `created_by_user` STRING COMMENT 'The user ID of the person who created this chart of accounts entry. Essential for accountability and audit trail in master data management.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this chart of accounts entry was first created in the system. Provides audit trail for master data governance.',
    `currency_type` STRING COMMENT 'Defines the currency management approach for this account: local (company code currency only), group (consolidated reporting currency), transaction (foreign currency allowed), or multiple (multi-currency management).. Valid values are `local|group|transaction|multiple`',
    `default_currency_code` STRING COMMENT 'The default three-letter ISO 4217 currency code for this account when transaction currency is not specified. Typically the local currency of the company code.. Valid values are `^[A-Z]{3}$`',
    `field_status_group` STRING COMMENT 'Configuration key that controls which fields are required, optional, or suppressed when posting to this account. Enforces data quality and compliance requirements at the transaction level.',
    `financial_statement_item` STRING COMMENT 'The specific line item on the financial statement (balance sheet, income statement, cash flow statement) where this accounts balance is reported. Maps GL accounts to external reporting presentation.',
    `functional_area` STRING COMMENT 'Classification of the account by business function or operational area (e.g., sales, operations, administration, logistics) for segment reporting and functional cost analysis.',
    `gaap_classification` STRING COMMENT 'GAAP classification code or category for this account, supporting dual reporting requirements where both IFRS and local GAAP reporting are required.',
    `gl_account_code` STRING COMMENT 'The unique alphanumeric code identifying the GL account within the chart of accounts structure. This is the externally-known business identifier used across all financial transactions and reporting.. Valid values are `^[0-9]{6,10}$`',
    `ifrs_classification` STRING COMMENT 'Detailed IFRS classification code or category for this account, ensuring compliance with international financial reporting standards and enabling IFRS-compliant financial statement generation.',
    `intercompany_indicator` STRING COMMENT 'Indicates whether this account is used for intercompany transactions and the direction: none (not intercompany), payable (amounts owed to related entities), receivable (amounts due from related entities), or both.. Valid values are `none|payable|receivable|both`',
    `last_modified_by_user` STRING COMMENT 'The user ID of the person who last modified this chart of accounts entry. Provides accountability for master data changes and supports audit investigations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this chart of accounts entry was last modified. Tracks the currency of master data and supports change management processes.',
    `line_item_display_flag` BOOLEAN COMMENT 'Indicates whether individual line item details (journal entries) are stored and displayable for this account. Essential for accounts requiring detailed transaction audit trails.',
    `open_item_management_flag` BOOLEAN COMMENT 'Indicates whether this account uses open item management for tracking and clearing individual transactions (e.g., invoices, payments). Critical for accounts receivable, accounts payable, and clearing accounts.',
    `planning_level` STRING COMMENT 'Defines the granularity at which budget planning and forecasting is performed for this account (e.g., annual, quarterly, monthly). Supports CAPEX and OPEX budgeting processes.',
    `posting_allowed_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether direct journal entry postings are permitted to this account. False indicates a control or summary account that only receives automatic postings.',
    `profit_loss_classification` STRING COMMENT 'Detailed classification of revenue and expense accounts within the income statement structure, including operating revenue, cost of goods sold, operating expenses, and non-operating items.',
    `reconciliation_account_flag` BOOLEAN COMMENT 'Indicates whether this is a reconciliation account that serves as a control account for subsidiary ledgers (e.g., accounts receivable, accounts payable, inventory). Reconciliation accounts are automatically updated from sub-ledger transactions.',
    `retained_earnings_account_flag` BOOLEAN COMMENT 'Indicates whether this is the designated retained earnings account that receives the net profit or loss transfer during year-end closing processes.',
    `sort_key` STRING COMMENT 'Default sort key used for organizing and displaying line items within this account (e.g., by posting date, document number, reference). Enhances usability in transaction review and reconciliation.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this account is subject to enhanced SOX internal controls and audit requirements due to materiality or risk profile. Triggers additional approval workflows and audit logging.',
    `tax_relevant_flag` BOOLEAN COMMENT 'Indicates whether postings to this account are subject to tax calculation and reporting. Used to identify accounts that require tax code assignment during transaction entry.',
    `tolerance_group` STRING COMMENT 'Configuration key defining posting and clearing tolerances for this account, including maximum amounts, payment differences, and exchange rate variances permitted during transaction processing.',
    `valid_from_date` DATE COMMENT 'The date from which this chart of accounts entry becomes effective and available for use in financial transactions. Supports time-dependent account structures.',
    `valid_to_date` DATE COMMENT 'The date until which this chart of accounts entry remains valid. Null indicates the account is valid indefinitely. Used for account retirement and historical reporting.',
    CONSTRAINT pk_chart_of_accounts PRIMARY KEY(`chart_of_accounts_id`)
) COMMENT 'Master reference for the enterprise chart of accounts defining all GL account codes, account groups, account types (P&L, balance sheet), financial statement line assignments, and IFRS classification. Governs account structure across all legal entities and company codes within Transport Shipping. Sourced from SAP S/4HANA Finance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center. Primary key for the cost center master entity.',
    `parent_cost_center_id` BIGINT COMMENT 'Identifier of the parent cost center in the cost center hierarchy. Enables roll-up reporting and hierarchical cost aggregation. Null for top-level cost centers.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or employee responsible for this cost center. This person is accountable for budget adherence, cost control, and operational performance of the cost center.',
    `program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Safety programs (driver safety, DG handling, facility safety, contractor safety) are organized as cost centers in transport operations. Finance tracks program costs (training, equipment, audits, perso',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: Warehouse and distribution cost centers operated by 3PL providers require provider attribution for cost allocation, performance management, and 3PL billing reconciliation. Standard in outsourced logis',
    `activity_type` STRING COMMENT 'The primary activity type performed by this cost center for activity-based costing. Examples include machine hours, labor hours, shipment volume, or handling units. Used for internal cost allocation and activity driver analysis.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The default percentage used for proportional cost allocation from this cost center to other cost objects. Expressed as a percentage value between 0 and 100. Null if allocation method is not percentage-based.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'The total approved budget amount for this cost center for the current fiscal year, expressed in the cost centers currency. Used for budget vs actual variance analysis and cost control.',
    `budget_period` STRING COMMENT 'The budgeting cycle period for this cost center. Annual indicates yearly budget planning. Quarterly indicates budget set every quarter. Monthly indicates monthly budget allocation. Determines the frequency of budget vs actual variance reporting.. Valid values are `annual|quarterly|monthly`',
    `budget_version` STRING COMMENT 'The version identifier of the current budget plan. Enables tracking of budget revisions, forecasts, and what-if scenarios. Examples include original budget, revised budget, forecast.',
    `business_area_code` STRING COMMENT 'The business area to which this cost center is assigned. Business area represents a distinct line of business or product segment for cross-company reporting.',
    `company_code` STRING COMMENT 'The company code representing the legal entity to which this cost center is assigned. Used for external financial reporting and legal consolidation.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area_code` STRING COMMENT 'The controlling area to which this cost center belongs. Controlling area is the highest organizational unit in cost accounting, typically representing a legal entity or business unit for internal management reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_allocation_method` STRING COMMENT 'The method used to allocate costs from this cost center to other cost objects or profit centers. Direct indicates costs are directly assigned. Activity-based uses activity drivers. Proportional uses percentage splits. Driver-based uses volume or usage metrics. Fixed percentage uses predetermined allocation keys.. Valid values are `direct|activity_based|proportional|driver_based|fixed_percentage`',
    `cost_center_category` STRING COMMENT 'Functional category of the cost center for management reporting and cost allocation. Production includes operational hubs and sorting centers. Service includes customer support and claims processing. Administrative includes back-office functions. Sales includes business development and account management. Distribution includes warehouses and last-mile delivery. Research and development includes innovation and process improvement. Quality assurance includes compliance and audit. Maintenance includes fleet and facility upkeep. [ENUM-REF-CANDIDATE: production|service|administrative|sales|distribution|research_development|quality_assurance|maintenance — 8 candidates stripped; promote to reference product]',
    `cost_center_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying the cost center in financial systems and reports. Used as the business identifier in chart of accounts and financial postings.. Valid values are `^[A-Z0-9]{4,10}$`',
    `cost_center_description` STRING COMMENT 'Detailed textual description of the cost centers purpose, scope, and responsibilities. Provides additional context beyond the cost center name for reporting and documentation purposes.',
    `cost_center_group` STRING COMMENT 'Grouping classification for aggregating cost centers in management reports. Examples include regional groupings, functional groupings, or business line groupings.',
    `cost_center_name` STRING COMMENT 'The full descriptive name of the cost center, identifying the organizational unit or function to which costs are assigned.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active indicates the cost center is operational and accepting cost postings. Inactive indicates temporary suspension. Blocked prevents new postings. Pending closure indicates scheduled deactivation. Closed indicates the cost center is no longer in use and historical only.. Valid values are `active|inactive|blocked|pending_closure|closed`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by its primary business function. Logistics operations include hubs and sorting facilities, warehouse includes distribution centers, fleet includes vehicle operations, corporate includes headquarters functions, sales includes customer-facing units, administration includes back-office support, support includes IT and HR, revenue-generating includes units with direct revenue attribution, cost-absorbing includes pure cost units. [ENUM-REF-CANDIDATE: logistics_operations|warehouse|fleet|corporate|sales|administration|support|revenue_generating|cost_absorbing — 9 candidates stripped; promote to reference product]',
    `cost_element_group` STRING COMMENT 'The primary cost element group associated with this cost center, defining the types of costs that can be posted. Examples include personnel costs, material costs, services, depreciation, or external services.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the cost center is domiciled. Used for country-level financial reporting and tax compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which this cost centers budget and actual costs are tracked. Typically the local currency of the cost centers operating location.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'The department code to which this cost center belongs within the organizational structure. Used for departmental reporting and organizational hierarchy navigation.',
    `division_code` STRING COMMENT 'The division code representing the highest-level organizational unit to which this cost center belongs. Used for divisional P&L reporting and strategic business unit analysis.',
    `fte_count` DECIMAL(18,2) COMMENT 'The number of full-time equivalent employees assigned to this cost center. Used for productivity analysis, cost per FTE calculations, and workforce planning. Decimal values accommodate part-time and fractional allocations.',
    `functional_area_code` STRING COMMENT 'The functional area classification for this cost center, used for cost-of-sales accounting and functional expense reporting per IFRS requirements.',
    `hierarchy_level` STRING COMMENT 'The level of this cost center in the organizational hierarchy. Level 1 represents top-level cost centers, with increasing numbers representing deeper nesting. Used for hierarchical reporting and drill-down analysis.',
    `is_overhead` BOOLEAN COMMENT 'Boolean flag indicating whether this cost center represents overhead costs that must be allocated to other cost objects. True for administrative, support, and shared service cost centers. False for direct operational cost centers.',
    `is_revenue_generating` BOOLEAN COMMENT 'Boolean flag indicating whether this cost center directly generates revenue. True for cost centers with direct customer billing or revenue attribution. False for pure cost centers. Used for profitability analysis and contribution margin reporting.',
    `last_modified_by_user` STRING COMMENT 'The user ID or username of the person who last modified this cost center record. Used for audit trail and accountability per SOX requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was last updated. Used for change tracking, audit trail, and data quality monitoring.',
    `location_code` STRING COMMENT 'The physical location or site code where this cost center operates. Used for geographic cost analysis and facility-based reporting.',
    `lock_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this cost center is locked for posting. True prevents any new cost postings. False allows normal posting activity. Used during period-end close and audit processes.',
    `planning_group` STRING COMMENT 'The planning group to which this cost center belongs for budget planning and forecasting processes. Enables collaborative planning across related cost centers.',
    `profit_center_code` STRING COMMENT 'The profit center to which this cost center is assigned for segment reporting and profitability analysis. Enables P&L reporting at the profit center level by aggregating revenues and costs.',
    `region_code` STRING COMMENT 'Regional classification code for the cost center, used for regional management reporting and performance analysis.',
    `tax_jurisdiction_code` STRING COMMENT 'The tax jurisdiction code applicable to this cost center for tax reporting and compliance. Used for VAT, GST, and other indirect tax calculations and filings.',
    `valid_from_date` DATE COMMENT 'The date from which this cost center became active and eligible to receive cost postings. Represents the start of the cost centers operational lifecycle.',
    `valid_to_date` DATE COMMENT 'The date until which this cost center remains active. Null for cost centers with no planned end date. Used for cost center lifecycle management and historical reporting.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Master entity for cost center accounting representing organizational units to which costs are assigned. Tracks cost center hierarchy, responsible manager, controlling area, profit center assignment, budget period, and cost center type (logistics operations, warehouse, fleet, corporate). Sourced from SAP S/4HANA Finance CO module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique identifier for the profit center. Primary key for profit center accounting entity representing business segments or service lines for P&L reporting.',
    `business_unit_id` BIGINT COMMENT 'Reference to the business unit or division that owns this profit center (e.g., Express Delivery, Freight Forwarding, Contract Logistics).',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: profit_center has gl_account_id (BIGINT) which appears to be a generic ID. Profit centers may have default GL accounts for P&L reporting and should reference chart_of_accounts master. Replacing generi',
    `company_code_id` BIGINT COMMENT 'Reference to the company code representing the legal entity to which this profit center belongs for financial reporting.',
    `controlling_area_id` BIGINT COMMENT 'Reference to the controlling area to which this profit center is assigned for management accounting and cost control purposes.',
    `cost_center_id` BIGINT COMMENT 'Reference to the default cost center associated with this profit center for cost allocation and overhead tracking.',
    `created_by_user_employee_id` BIGINT COMMENT 'User ID of the person who created this profit center record for audit and accountability purposes.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or manager responsible for the profit centers P&L performance and operational management.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person who last modified this profit center record for audit trail and change tracking.',
    `parent_profit_center_id` BIGINT COMMENT 'Reference to the parent profit center in the profit center hierarchy for roll-up reporting and consolidation. Null for top-level profit centers.',
    `primary_consolidation_profit_center_id` BIGINT COMMENT 'Reference to the consolidation profit center used for group-level financial consolidation and elimination entries.',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Flag indicating whether detailed audit trail logging is enabled for all transactions posted to this profit center (true) or not (false).',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocation for this profit center in local currency for planning and variance analysis.',
    `capex_budget_amount` DECIMAL(18,2) COMMENT 'Annual capital expenditure budget allocated to this profit center for asset investments and infrastructure projects.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country of operation for this profit center.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this profit center record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the profit centers local reporting currency.. Valid values are `^[A-Z]{3}$`',
    `ebitda_reporting_segment` STRING COMMENT 'EBITDA reporting segment classification for management reporting and investor communications (e.g., Express, Freight, Supply Chain, eCommerce).',
    `ebitda_target_amount` DECIMAL(18,2) COMMENT 'Annual EBITDA target for this profit center in local currency for profitability measurement and management incentive tracking.',
    `geographic_region` STRING COMMENT 'Primary geographic region of operation for this profit center (AMER=Americas, EMEA=Europe Middle East Africa, APAC=Asia Pacific, LATAM=Latin America, MEA=Middle East Africa, NAM=North America, EUR=Europe, ASIA=Asia). [ENUM-REF-CANDIDATE: AMER|EMEA|APAC|LATAM|MEA|NAM|EUR|ASIA — 8 candidates stripped; promote to reference product]',
    `hierarchy_level` STRING COMMENT 'Numeric level in the profit center hierarchy (1 = top level, increasing for nested levels) for organizational reporting structure.',
    `intercompany_billing_flag` BOOLEAN COMMENT 'Flag indicating whether this profit center participates in intercompany billing and transfer pricing (true) or not (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this profit center record was last modified or updated.',
    `lock_indicator` BOOLEAN COMMENT 'Flag indicating whether the profit center is locked for new postings (true) or open for transactions (false).',
    `notes` STRING COMMENT 'Free-text notes or comments about this profit center for additional context, special instructions, or operational remarks.',
    `opex_budget_amount` DECIMAL(18,2) COMMENT 'Annual operating expenditure budget for this profit center covering operational costs and recurring expenses.',
    `profit_center_code` STRING COMMENT 'Business identifier code for the profit center used in financial reporting and controlling. Externally-known unique code for this profit center.. Valid values are `^[A-Z0-9]{4,10}$`',
    `profit_center_description` STRING COMMENT 'Detailed description of the profit centers business scope, service offerings, and operational focus.',
    `profit_center_name` STRING COMMENT 'Full business name of the profit center (e.g., Express Parcel Delivery, Freight Forwarding Air, Contract Logistics EMEA).',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center indicating whether it is operational, suspended, or closed.. Valid values are `active|inactive|suspended|closed|planned`',
    `profit_center_type` STRING COMMENT 'Classification of the profit center by organizational structure type (service line, business unit, geographic region, product line, cost center, investment center).. Valid values are `service_line|business_unit|geographic_region|product_line|cost_center|investment_center`',
    `revenue_target_amount` DECIMAL(18,2) COMMENT 'Annual revenue target for this profit center in local currency for performance measurement.',
    `segment_code` STRING COMMENT 'IFRS segment code for external financial reporting and segment disclosure requirements.. Valid values are `^[A-Z0-9]{2,6}$`',
    `service_line` STRING COMMENT 'Primary service line or product category offered by this profit center (e.g., Express Parcel Delivery, Air Freight, Ocean Freight, Warehousing, Last-Mile Delivery).',
    `sox_control_flag` BOOLEAN COMMENT 'Flag indicating whether this profit center is subject to SOX financial controls and audit requirements (true) or not (false).',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code for this profit center used for tax calculation, reporting, and compliance purposes.. Valid values are `^[A-Z0-9]{2,10}$`',
    `valid_from_date` DATE COMMENT 'Effective start date from which this profit center is active and available for financial postings.',
    `valid_to_date` DATE COMMENT 'Effective end date after which this profit center is no longer active for financial postings. Null for open-ended profit centers.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Master entity for profit center accounting representing business segments or service lines (express parcel, freight forwarding, contract logistics, e-commerce fulfillment) for P&L reporting. Tracks profit center hierarchy, assigned business unit, controlling area, and EBITDA reporting segment. Sourced from SAP S/4HANA Finance EC-PCA module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`company_code` (
    `company_code_id` BIGINT COMMENT 'Unique identifier for the company code entity. Primary key. Inferred role: MASTER_RESOURCE (organizational unit for financial reporting).',
    `chart_of_accounts_id` BIGINT COMMENT 'Identifier of the chart of accounts assigned to this company code. The chart of accounts defines the structure of General Ledger (GL) accounts used for financial postings and reporting.',
    `controlling_area_id` BIGINT COMMENT 'Identifier of the controlling area to which this company code is assigned. The controlling area is the organizational unit for cost accounting, profit center accounting, and internal management reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `credit_control_area_id` BIGINT COMMENT 'Identifier of the credit control area responsible for managing customer credit limits and credit risk for this company code.. Valid values are `^[A-Z0-9]{4}$`',
    `parent_company_code_id` BIGINT COMMENT 'Reference to the parent company code in the corporate hierarchy. Used for consolidation and intercompany eliminations in group financial reporting. Null if this is a top-level entity.',
    `employee_id` BIGINT COMMENT 'User ID of the system user who created this company code record. Part of audit trail for accountability and compliance.',
    `retention_policy_id` BIGINT COMMENT 'Foreign key linking to document.retention_policy. Business justification: Retention policies are defined at legal entity (company code) level to comply with jurisdiction-specific regulations (GDPR, SOX, customs record-keeping). Essential for legal compliance, data governanc',
    `address_line_1` STRING COMMENT 'First line of the registered legal address for this company code. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Second line of the registered legal address (suite, floor, building name). Organizational contact data classified as confidential.',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether detailed audit trail logging is enabled for all financial transactions posted to this company code. Required for SOX compliance and regulatory audits.',
    `business_registration_number` STRING COMMENT 'Official business or company registration number issued by the local commercial registry or companies house. Serves as the legal identifier for the entity.',
    `city` STRING COMMENT 'City or municipality of the registered legal address. Organizational contact data classified as confidential.',
    `company_code` STRING COMMENT 'Four-character alphanumeric code uniquely identifying the legal entity or company code within the enterprise. This is the business identifier used across all financial transactions and reporting. Corresponds to SAP S/4HANA Finance BUKRS field.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code_status` STRING COMMENT 'Current operational status of the company code within the enterprise financial system. Active company codes can post transactions; inactive codes are closed for new postings.. Valid values are `active|inactive|pending_closure|dissolved|merged`',
    `company_name` STRING COMMENT 'Full legal name of the company or legal entity represented by this company code. Used for external financial reporting, legal documents, and regulatory filings.',
    `company_name_short` STRING COMMENT 'Abbreviated or short name of the company for internal reporting and display purposes.',
    `consolidation_group_code` STRING COMMENT 'Code identifying the consolidation group or reporting entity to which this company code belongs for group financial statement preparation.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code representing the country of domicile for this legal entity. Determines tax jurisdiction, regulatory reporting requirements, and local GAAP applicability.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this company code record was first created in the financial system. Part of audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the local currency in which this company code maintains its books and records. All financial transactions are recorded in this currency before consolidation.. Valid values are `^[A-Z]{3}$`',
    `email_address` STRING COMMENT 'Primary contact email address for financial and legal correspondence related to this company code. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fiscal_year_variant` STRING COMMENT 'Two-character code defining the fiscal year structure for this company code (e.g., calendar year, April-March, custom periods). Determines posting periods and financial reporting cycles.. Valid values are `^[A-Z0-9]{2}$`',
    `ifrs_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this company code prepares financial statements in accordance with IFRS. True if IFRS applies; False if local GAAP or other standards apply.',
    `intercompany_billing_enabled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether intercompany billing and settlements are enabled for this company code. True if intercompany transactions are processed; False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this company code record was last modified. Part of audit trail for change tracking and compliance.',
    `legal_entity_type` STRING COMMENT 'Classification of the legal structure of the company code (e.g., corporation, LLC, partnership, branch, subsidiary). Determines tax treatment and regulatory obligations.. Valid values are `corporation|limited_liability_company|partnership|sole_proprietorship|branch|subsidiary`',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this company code. Used for documenting exceptions, special configurations, or historical context.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the company code headquarters or registered office. Organizational contact data classified as confidential.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the registered legal address. Organizational contact data classified as confidential.',
    `posting_block_flag` BOOLEAN COMMENT 'Boolean flag indicating whether new financial postings are blocked for this company code. True if posting is blocked (e.g., during period-end close or audit); False if posting is allowed.',
    `responsible_person_email` STRING COMMENT 'Email address of the individual responsible for financial management and reporting for this company code. Personal contact information classified as restricted PII.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_person_name` STRING COMMENT 'Name of the individual responsible for financial management and reporting for this company code (e.g., Chief Financial Officer, Finance Director). Business reference, not direct PII.',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this company code is subject to Sarbanes-Oxley Act internal control and audit requirements. True if SOX controls apply; False otherwise.',
    `state_province` STRING COMMENT 'State, province, or region of the registered legal address. Organizational contact data classified as confidential.',
    `tax_identification_number` STRING COMMENT 'National tax identification number or employer identification number (EIN) assigned by the local tax authority. Used for corporate income tax filings and regulatory reporting.',
    `tax_jurisdiction_code` STRING COMMENT 'Code representing the primary tax jurisdiction under which this company code operates. Determines applicable tax rates, filing requirements, and compliance obligations.',
    `valid_from_date` DATE COMMENT 'Date from which this company code became active and operational within the enterprise financial system. Marks the start of the company code lifecycle.',
    `valid_to_date` DATE COMMENT 'Date until which this company code remains active. Null if the company code is currently active with no planned closure date. Populated when the entity is dissolved, merged, or closed.',
    `vat_registration_number` STRING COMMENT 'VAT or GST registration number assigned by the tax authority for this legal entity. Required for VAT reporting and cross-border trade within VAT jurisdictions.',
    CONSTRAINT pk_company_code PRIMARY KEY(`company_code_id`)
) COMMENT 'Master entity representing legal entities and company codes within the Transport Shipping corporate structure. Defines the organizational unit for which a complete, self-contained set of accounts can be drawn up for external reporting. Includes legal entity name, country, currency, fiscal year variant, and IFRS reporting flag. Sourced from SAP S/4HANA Finance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record. Primary key for the journal entry entity representing the atomic unit of financial recording in SAP S/4HANA Finance FI module.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Manual journal entries for carrier-related adjustments, accruals, or corrections require carrier attribution for audit trail, carrier account reconciliation, and SOX compliance documentation. Enables ',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the general ledger account to which this journal entry line is posted. Represents the chart of accounts classification for financial statement reporting.',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity company code under which this journal entry is recorded. Company code represents the smallest organizational unit for which a complete self-contained set of accounts can be drawn up for external reporting.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center for internal cost allocation and management accounting. Used for OPEX tracking and departmental P&L analysis.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: journal_entry has fiscal_year (INT) and fiscal_period (INT) but no FK to fiscal_period master. Journal entries are posted to fiscal periods and should reference master calendar for period-end close an',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Journal entries are posted to a specific ledger (leading ledger, non-leading ledger, etc.). This is fundamental to SAP S/4HANA multi-ledger accounting.',
    `employee_id` BIGINT COMMENT 'Reference to the user who posted this journal entry. Critical for SOX audit trails and segregation of duties controls.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center for segment reporting and EBITDA tracking. Represents a management-oriented organizational unit for internal profitability analysis.',
    `tax_account_id` BIGINT COMMENT 'Foreign key linking to finance.tax_account. Business justification: journal_entry has tax_code (STRING) and tax_jurisdiction_code (STRING) but no FK to tax_account master. Journal entries with tax implications must reference tax account master.',
    `assignment_reference` STRING COMMENT 'Additional reference field for grouping and sorting journal entries. Often used for payment reference, project number, or internal tracking codes.',
    `business_area_code` STRING COMMENT 'Code representing the business area for cross-company code reporting. Used for segment reporting when profit centers are not sufficient.',
    `clearing_date` DATE COMMENT 'The date on which this journal entry line item was cleared or reconciled. Null if still open.',
    `clearing_document_number` STRING COMMENT 'The accounting document number that cleared this open item. Used for accounts receivable, accounts payable, and GL account reconciliation. Null if not cleared.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The credit amount posted in the document currency. Represents decreases to asset and expense accounts or increases to liability, equity, and revenue accounts.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction currency in which the journal entry amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `debit_amount` DECIMAL(18,2) COMMENT 'The debit amount posted in the document currency. Represents increases to asset and expense accounts or decreases to liability, equity, and revenue accounts.',
    `document_date` DATE COMMENT 'The date on the source document (invoice, receipt, contract) that originated this journal entry. May differ from posting date due to processing delays.',
    `document_number` STRING COMMENT 'The externally-known unique accounting document number assigned by SAP S/4HANA Finance. This is the business identifier used for audit trails, reconciliation, and cross-system references.. Valid values are `^[A-Z0-9]{10}$`',
    `document_type` STRING COMMENT 'Classification code indicating the type of accounting document (SA=GL Account Document, KR=Vendor Invoice, DR=Customer Invoice, DZ=Customer Payment, AB=Accounting Document, KG=Vendor Credit Memo, RE=Invoice Receipt, ZP=Payment Document). Determines posting rules and workflow. [ENUM-REF-CANDIDATE: SA|KR|DR|DZ|AB|KG|RE|ZP — 8 candidates stripped; promote to reference product]',
    `entry_timestamp` TIMESTAMP COMMENT 'The timestamp when this journal entry record was first created in the system. Used for audit trail and data lineage tracking.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate used to convert transaction currency amounts to local currency. Null if transaction currency equals local currency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this journal entry record was last modified. Used for audit trail and change tracking.',
    `line_item_number` STRING COMMENT 'Sequential line item number within the accounting document. Used to identify individual posting lines within a multi-line journal entry.',
    `local_currency_credit_amount` DECIMAL(18,2) COMMENT 'The credit amount converted to the company code local currency for consolidated financial reporting.',
    `local_currency_debit_amount` DECIMAL(18,2) COMMENT 'The debit amount converted to the company code local currency for consolidated financial reporting.',
    `manual_entry_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry was manually created by a user (True) or automatically generated by system integration (False). Used for audit risk assessment.',
    `notes` STRING COMMENT 'Additional free-form notes and comments for audit documentation, special instructions, or business context that does not fit in standard fields.',
    `posting_date` DATE COMMENT 'The date on which the journal entry was posted to the general ledger. This is the principal business event timestamp representing when the financial transaction was recorded in the accounting period.',
    `posting_key` STRING COMMENT 'Two-digit SAP posting key that controls the type of posting (debit/credit) and the account type (GL, customer, vendor, asset). Determines field status and processing rules.. Valid values are `^[0-9]{2}$`',
    `posting_status` STRING COMMENT 'Current lifecycle status of the journal entry (posted=successfully posted to GL, parked=saved but not posted, cleared=settled/reconciled, reversed=reversed by subsequent entry, cancelled=voided before posting).. Valid values are `posted|parked|cleared|reversed|cancelled`',
    `reference_document_number` STRING COMMENT 'The source document number that originated this journal entry (AWB, BOL, invoice number, purchase order, contract number). Provides audit trail linkage to operational transactions.',
    `reference_document_type` STRING COMMENT 'Classification of the source document type (AWB=Air Waybill, BOL=Bill of Lading, INV=Invoice, PO=Purchase Order, CON=Contract, PAY=Payment, ADJ=Adjustment, ACR=Accrual, DEP=Depreciation, REV=Reversal). [ENUM-REF-CANDIDATE: AWB|BOL|INV|PO|CON|PAY|ADJ|ACR|DEP|REV — 10 candidates stripped; promote to reference product]',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a reversal of a previous entry. True if this is a reversal posting, False otherwise.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for reversal (01=Posting Error, 02=Accrual Reversal, 03=Period Adjustment, 04=Duplicate Entry, 05=Other). Null if not a reversal.. Valid values are `01|02|03|04|05`',
    `reversed_document_number` STRING COMMENT 'The accounting document number of the original entry that this journal entry reverses. Null if this is not a reversal posting.',
    `source_system_code` STRING COMMENT 'Code identifying the source system that originated this journal entry (SAP=SAP S/4HANA, ORACLE=Oracle TMS, COUPA=Coupa Procurement, MANUAL=Manual Entry, INTERFACE=External Interface).. Valid values are `SAP|ORACLE|COUPA|MANUAL|INTERFACE`',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is subject to SOX internal control requirements and enhanced audit trail monitoring. True if SOX-controlled, False otherwise.',
    `text_description` STRING COMMENT 'Free-text description providing business context and explanation for the journal entry. Used for audit trails and user understanding.',
    `trading_partner_code` STRING COMMENT 'Code identifying the intercompany trading partner for intercompany transactions and eliminations. Used for consolidated financial statements.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Core transactional entity capturing all accounting journal entries posted to the general ledger. Records debit/credit postings, document type, posting date, fiscal period, reference document (AWB, BOL, invoice, purchase order), posting user, reversal indicator, and SOX audit trail fields. Represents the atomic unit of financial recording in SAP S/4HANA Finance FI module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for this table.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Line-item carrier attribution enables detailed carrier profitability analysis, cost-to-serve modeling, and carrier spend reporting at GL transaction level. Essential for finance analytics and carrier ',
    `company_code_id` BIGINT COMMENT 'Reference to the company code (legal entity) to which this line item belongs. Determines the legal entity for statutory reporting.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which this line item is assigned. Used for internal cost allocation and management accounting.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: journal_entry_line has fiscal_year (INT) and fiscal_period (INT) but no FK to fiscal_period master. Line-level fiscal period assignment enables period-specific reporting and should reference master ca',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Journal entry lines can be posted to internal orders for cost tracking of specific projects or initiatives. This is standard SAP CO integration.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header document. Links this line item to its controlling document.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Journal entry lines inherit the ledger from the header but in parallel ledger scenarios, line items may post to different ledgers. Essential for multi-GAAP reporting.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the general ledger account to which this line item is posted. Determines the financial statement classification and reporting category.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this journal entry line. Used for audit trail and accountability.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center to which this line item is assigned. Used for segment reporting and EBITDA analysis.',
    `tax_account_id` BIGINT COMMENT 'Foreign key linking to finance.tax_account. Business justification: journal_entry_line has tax_code (STRING) and tax_jurisdiction_code (STRING) but no FK to tax_account master. Line-level tax accounting requires reference to tax account master.',
    `partner_id` BIGINT COMMENT 'Reference to the intercompany trading partner for intercompany transactions. Used for intercompany reconciliation and elimination entries.',
    `amount_in_document_currency` DECIMAL(18,2) COMMENT 'The transaction amount in the original document currency. This is the amount as recorded in the source transaction before any currency conversion.',
    `amount_in_group_currency` DECIMAL(18,2) COMMENT 'The transaction amount converted to the group reporting currency. Used for consolidated financial statements and enterprise-wide reporting.',
    `amount_in_local_currency` DECIMAL(18,2) COMMENT 'The transaction amount converted to the local currency of the company code. Used for local statutory reporting and P&L consolidation.',
    `assignment_reference` STRING COMMENT 'Free-text field for additional assignment or reference information. Often used to store shipment numbers, AWB numbers, BOL numbers, or other operational identifiers for traceability.',
    `baseline_date` DATE COMMENT 'The reference date used for payment term calculation. Determines when payment is due based on payment terms.',
    `business_area_code` STRING COMMENT 'Code representing the business area or division for cross-company code reporting. Enables consolidated P&L by business line.. Valid values are `^[A-Z0-9]{4}$`',
    `clearing_date` DATE COMMENT 'The date on which this line item was cleared. Null if the item remains open.',
    `clearing_document_number` STRING COMMENT 'Document number of the clearing document if this line item has been cleared. Used for open item management and reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry line record was first created in the system. Used for audit trail and data lineage.',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this line item is a debit (D) or credit (C) posting. Fundamental accounting classification for double-entry bookkeeping.. Valid values are `D|C`',
    `document_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the document currency. Represents the currency in which the original transaction was denominated.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate used to convert the document currency to local or group currency. Stored as a multiplier factor.',
    `functional_area_code` STRING COMMENT 'Code representing the functional area such as sales, operations, administration, or logistics. Used for cost-of-sales accounting and functional P&L reporting.. Valid values are `^[A-Z0-9]{4,6}$`',
    `group_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the group reporting currency. Typically USD or EUR for multinational enterprises.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry line record was last modified. Used for audit trail and change tracking.',
    `line_item_number` STRING COMMENT 'Sequential line number within the journal entry document. Determines the ordering and position of this line in the entry.',
    `line_item_text` STRING COMMENT 'Descriptive text providing additional context or explanation for this journal entry line. Used for audit trail and user understanding.',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the local currency of the company code. Typically the functional currency for statutory reporting.. Valid values are `^[A-Z]{3}$`',
    `manual_entry_flag` BOOLEAN COMMENT 'Flag indicating whether this line item was manually entered by a user or automatically generated by a system process. Used for audit and control purposes.',
    `payment_term_code` STRING COMMENT 'Code representing the payment terms applicable to this line item. Determines due date calculation and cash discount eligibility.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_key` STRING COMMENT 'Two-digit code that determines whether the line is a debit or credit and controls field status and account type. Standard SAP posting keys include 40 (debit GL), 50 (credit GL), 01 (debit customer), 11 (credit customer), 21 (debit vendor), 31 (credit vendor).. Valid values are `^[0-9]{2}$`',
    `reference_document_number` STRING COMMENT 'External reference document number such as invoice number, purchase order number, or shipment number that originated this journal entry line.',
    `reference_key_1` STRING COMMENT 'First reference key field for additional classification or grouping. Often used for project codes, contract numbers, or custom business identifiers.',
    `reference_key_2` STRING COMMENT 'Second reference key field for additional classification or grouping. Provides flexibility for custom business dimensions.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this line item is part of a reversal document. True if this line reverses a previous posting.',
    `reversed_document_number` STRING COMMENT 'Document number of the original document that this line item reverses. Populated only if reversal_indicator is true.',
    `segment_code` STRING COMMENT 'Code representing the operating segment for IFRS 8 segment reporting. Aligns with management reporting structure and chief operating decision maker view.. Valid values are `^[A-Z0-9]{2,6}$`',
    `sox_control_flag` BOOLEAN COMMENT 'Flag indicating whether this line item is subject to SOX internal controls and requires additional audit trail and approval workflows.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount for this line item in document currency. Represents VAT, sales tax, or other indirect taxes.',
    `value_date` DATE COMMENT 'The date on which the transaction becomes effective for interest calculation or cash flow purposes. May differ from posting date for backdated or forward-dated transactions.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Line-item detail of each journal entry posting, capturing individual debit or credit amounts, GL account, cost center, profit center, business area, tax code, trading partner, and functional area. Enables granular financial analysis and reconciliation at the transaction line level. Sourced from SAP S/4HANA Finance FI line item tables.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` (
    `fiscal_period_id` BIGINT COMMENT 'Unique identifier for the fiscal period. Primary key.',
    `company_code_id` BIGINT COMMENT 'Reference to the company code for which this fiscal period is defined. Fiscal periods can be company-code-specific.',
    `controlling_area_id` BIGINT COMMENT 'Reference to the controlling area that uses this fiscal period for cost center accounting and internal reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the user responsible for executing the period-end close for this fiscal period.',
    `tertiary_fiscal_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this fiscal period record.',
    `ap_posting_allowed_flag` BOOLEAN COMMENT 'Flag indicating whether Accounts Payable postings are allowed in this period (true) or blocked (false).',
    `ar_posting_allowed_flag` BOOLEAN COMMENT 'Flag indicating whether Accounts Receivable postings are allowed in this period (true) or blocked (false).',
    `asset_posting_allowed_flag` BOOLEAN COMMENT 'Flag indicating whether Fixed Asset postings are allowed in this period (true) or blocked (false).',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Flag indicating whether detailed audit logging is enabled for all transactions posted in this period (true) or not (false).',
    `calendar_month` STRING COMMENT 'The calendar month number (1-12) corresponding to this fiscal period.',
    `calendar_year` STRING COMMENT 'The calendar year in which the period falls, used for cross-referencing when fiscal year differs from calendar year.',
    `consolidation_period_flag` BOOLEAN COMMENT 'Flag indicating whether this period is used for group consolidation reporting (true) or not (false).',
    `cost_center_posting_allowed_flag` BOOLEAN COMMENT 'Flag indicating whether Cost Center postings are allowed in this period (true) or blocked (false).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiscal period record was created in the system.',
    `fiscal_period_number` STRING COMMENT 'The sequential period number within the fiscal year (e.g., 1 for January, 12 for December, 13+ for special periods).',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this period belongs, represented as a four-digit year (e.g., 2024).. Valid values are `^[0-9]{4}$`',
    `fiscal_year_variant` STRING COMMENT 'The fiscal year variant code that defines the calendar structure (e.g., K4 for calendar year, V3 for April-March fiscal year). Controls number of periods and special periods.. Valid values are `^[A-Z0-9]{2,4}$`',
    `gl_posting_allowed_flag` BOOLEAN COMMENT 'Flag indicating whether General Ledger postings are allowed in this period (true) or blocked (false).',
    `half_year` STRING COMMENT 'The fiscal half-year number (1 or 2) to which this period belongs within the fiscal year.',
    `ifrs_reporting_period_flag` BOOLEAN COMMENT 'Flag indicating whether this period is used for IFRS financial reporting (true) or not (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiscal period record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about this fiscal period, including special instructions, exceptions, or historical context.',
    `number_of_days` STRING COMMENT 'Total number of calendar days in this fiscal period.',
    `number_of_working_days` STRING COMMENT 'Total number of business working days in this fiscal period, excluding weekends and holidays.',
    `period_description` STRING COMMENT 'Detailed description of the fiscal period, including any special characteristics or usage notes (e.g., Year-end adjustment period for accruals).',
    `period_end_close_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the period-end closing process was completed.',
    `period_end_close_status` STRING COMMENT 'Status of the period-end closing process: not_started, in_progress (closing activities underway), completed (all closing tasks done), verified (closing reviewed and approved).. Valid values are `not_started|in_progress|completed|verified`',
    `period_end_close_verified_timestamp` TIMESTAMP COMMENT 'Timestamp when the period-end closing was verified and approved by finance management.',
    `period_end_date` DATE COMMENT 'The last calendar date of the fiscal period (inclusive).',
    `period_lock_indicator` BOOLEAN COMMENT 'Flag indicating whether the period is locked for all postings (true) or can be reopened (false). Locked periods cannot be reopened without special authorization.',
    `period_name` STRING COMMENT 'Human-readable name of the fiscal period (e.g., January 2024, Q1 FY2024, Special Period 1).',
    `period_start_date` DATE COMMENT 'The first calendar date of the fiscal period (inclusive).',
    `period_status` STRING COMMENT 'Current posting status of the fiscal period: not_opened (future period), open (accepting postings), closed (period-end close completed), locked (permanently closed for audit).. Valid values are `not_opened|open|closed|locked`',
    `period_type` STRING COMMENT 'Classification of the fiscal period: normal (regular monthly period), special (additional period for adjustments), adjustment (mid-year corrections), or year_end_closing (final closing period).. Valid values are `normal|special|adjustment|year_end_closing`',
    `posting_close_date` DATE COMMENT 'The date when the period was closed for posting transactions.',
    `posting_open_date` DATE COMMENT 'The date when the period was opened for posting transactions.',
    `quarter` STRING COMMENT 'The fiscal quarter number (1-4) to which this period belongs within the fiscal year.',
    `sox_control_flag` BOOLEAN COMMENT 'Flag indicating whether this period is subject to SOX internal control requirements (true) or not (false). SOX-controlled periods require additional audit trails and segregation of duties.',
    `tax_reporting_period_flag` BOOLEAN COMMENT 'Flag indicating whether this period is a tax reporting period requiring statutory tax filings (true) or not (false).',
    CONSTRAINT pk_fiscal_period PRIMARY KEY(`fiscal_period_id`)
) COMMENT 'Reference entity defining fiscal periods, fiscal years, and accounting calendars for Transport Shipping. Tracks period open/close status, period type (normal, special, adjustment), fiscal year variant, and period-end close milestones. Controls which periods are open for posting across all company codes. Sourced from SAP S/4HANA Finance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the user or executive who approved this budget.',
    `budget_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this budget record. Audit trail field.',
    `budget_employee_id` BIGINT COMMENT 'Reference to the employee or manager responsible for this budget. The budget holder has authority to approve expenditures against this budget.',
    `budget_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this budget record. Audit trail field.',
    `business_unit_id` BIGINT COMMENT 'Reference to the business unit (e.g., Express Parcel, Freight Forwarding, Warehouse) for segmented budget planning.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the General Ledger account in the chart of accounts to which this budget is assigned.',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity company code for which this budget is defined. Required for statutory reporting.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which this budget is allocated. Cost centers represent organizational units responsible for costs.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center for EBITDA planning and P&L reporting. Profit centers are responsible for both revenue and costs.',
    `program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Safety programs have dedicated annual budgets for training, equipment, audits, and compliance activities. Finance allocates budgets to programs, tracks consumption against plan, and reports variances ',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The portion of the approved budget that has been allocated or committed to specific projects, purchase orders, or cost objects.',
    `approval_date` DATE COMMENT 'The date on which this budget was formally approved by the authorized budget committee or executive.',
    `approved_amount` DECIMAL(18,2) COMMENT 'The total approved budget amount for this fiscal period and cost/profit center. This is the baseline for variance analysis.',
    `available_amount` DECIMAL(18,2) COMMENT 'The remaining budget available for allocation or spending. Calculated as approved_amount minus allocated_amount minus consumed_amount.',
    `budget_category` STRING COMMENT 'High-level categorization of the budget by functional area or spend category. [ENUM-REF-CANDIDATE: personnel|fleet|facility|technology|marketing|operations|administrative — 7 candidates stripped; promote to reference product]',
    `budget_code` STRING COMMENT 'Externally-known unique business identifier for the budget. Used for cross-system reference and reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget record indicating approval and activation state.. Valid values are `draft|submitted|approved|active|frozen|closed`',
    `budget_type` STRING COMMENT 'Classification of budget as Capital Expenditure (CAPEX) for fleet/facility investments or Operating Expenditure (OPEX) for operational costs.. Valid values are `CAPEX|OPEX`',
    `consumed_amount` DECIMAL(18,2) COMMENT 'The actual expenditure or consumption against this budget to date. Used for variance analysis and budget control.',
    `control_method` STRING COMMENT 'The enforcement method for budget overruns: advisory (no restriction), warning (alert but allow), or blocking (prevent overspend).. Valid values are `advisory|warning|blocking`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `ebitda_impact_flag` BOOLEAN COMMENT 'Indicates whether this budget line impacts EBITDA calculation for financial reporting and performance measurement.',
    `effective_from_date` DATE COMMENT 'The date from which this budget becomes active and available for allocation and spending.',
    `effective_to_date` DATE COMMENT 'The date on which this budget expires or is closed. Nullable for open-ended budgets.',
    `fiscal_period` STRING COMMENT 'The fiscal period within the year (Q1-Q4 for quarterly, M01-M12 for monthly, FY for full year).. Valid values are `^(Q[1-4]|M(0[1-9]|1[0-2])|FY)$`',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this budget is planned and allocated. Format: YYYY.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was last modified. Audit trail field.',
    `lock_indicator` BOOLEAN COMMENT 'Indicates whether this budget is locked for changes. Locked budgets cannot be modified without special authorization.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this budget, including justifications, assumptions, or special instructions.',
    `planning_scenario` STRING COMMENT 'The planning scenario or assumption set used for this budget (e.g., base case, optimistic growth, pessimistic downturn).. Valid values are `base|optimistic|pessimistic|stretch`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this budget is subject to SOX financial controls and audit requirements.',
    `subcategory` STRING COMMENT 'Detailed subcategory within the budget category for granular spend tracking (e.g., salaries, vehicle maintenance, warehouse rent).',
    `tolerance_percentage` DECIMAL(18,2) COMMENT 'The allowable percentage variance from the approved budget before control actions are triggered. Expressed as a percentage (e.g., 5.00 for 5%).',
    `version` STRING COMMENT 'Version of the budget indicating whether it is the original approved budget, a revised budget, a forecast, or a rolling budget update.. Valid values are `original|revised|forecast|supplemental|baseline|rolling`',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Master entity for CAPEX and OPEX budget planning and control. Captures approved budget amounts by cost center, profit center, GL account, fiscal year, and budget version (original, revised, forecast). Tracks budget type (CAPEX for fleet/facility investments, OPEX for operational expenditure), approval status, and budget holder. Supports EBITDA planning and variance analysis.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique identifier for the budget line item. Primary key for the budget line product.',
    `budget_id` BIGINT COMMENT 'Reference to the parent budget header or master budget plan to which this line item belongs.',
    `business_unit_id` BIGINT COMMENT 'Reference to the business unit or division responsible for this budget line, enabling segment-level P&L and EBITDA reporting.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the general ledger account to which this budget line is allocated, aligning with the chart of accounts.',
    `commitment_item_id` BIGINT COMMENT 'Reference to the commitment item or budget category used in public sector or fund-based budgeting, enabling compliance with governmental accounting standards.',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity or company code for which this budget line is allocated, enabling multi-entity financial consolidation.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this budget line, enabling departmental and operational cost tracking.',
    `cost_element_id` BIGINT COMMENT 'Reference to the cost element (primary or secondary) that classifies the nature of the expense or revenue for this budget line.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Budget lines have fiscal_year and fiscal_period (INT) but no FK to the fiscal_period entity. Linking enables period-level budget vs actual reporting and period status validation.',
    `fund_id` BIGINT COMMENT 'Reference to the fund or financial source from which this budget line is financed, enabling fund-based budget management.',
    `internal_order_id` BIGINT COMMENT 'Reference to the internal order used for tracking specific operational initiatives or overhead activities, enabling order-based cost control.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or manager responsible for managing and controlling this budget line, enabling accountability and budget ownership.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budget lines can be allocated to profit centers for segment-level budget control. The parent budget has profit_center_id but the line items need their own for granular allocation.',
    `project_id` BIGINT COMMENT 'Reference to the project or capital investment program to which this budget line is allocated, enabling project-based CAPEX tracking.',
    `quaternary_budget_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this budget line record, enabling accountability and audit trail.',
    `tertiary_budget_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this budget line record, enabling accountability and audit trail.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element within a project hierarchy, enabling granular tracking of budget allocations for complex capital projects.',
    `approval_status` STRING COMMENT 'Current approval status of the budget line, indicating whether it is in draft, pending approval, approved, rejected, or locked for the period.. Valid values are `Draft|Pending Approval|Approved|Rejected|Locked`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line was approved, supporting audit trail and financial control requirements.',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Flag indicating whether detailed audit trail logging is enabled for this budget line, capturing all changes for compliance and forensic analysis.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The allocated budget amount for this line item in the specified period and currency, representing the planned expenditure or revenue target.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country to which this budget line applies, enabling country-level budget reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was first created in the system, supporting audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount (e.g., USD, EUR, GBP), enabling multi-currency budget management.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate used to convert the budget amount from transaction currency to local or group currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year for which this budget line applies, typically 1-12 for monthly or 1-4 for quarterly.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this budget line is allocated, typically a four-digit year (e.g., 2024).',
    `geographic_region` STRING COMMENT 'The geographic region or market to which this budget line applies, enabling regional budget analysis and variance tracking.',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'The budget amount converted to the group reporting currency, enabling enterprise-wide consolidation and EBITDA tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was last modified, supporting audit trail and change tracking.',
    `line_sequence_number` STRING COMMENT 'Sequential ordering number of this line item within the parent budget, enabling consistent display and drill-down analysis.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The budget amount converted to the local currency of the company code, enabling consolidated reporting across entities.',
    `lock_indicator` BOOLEAN COMMENT 'Flag indicating whether this budget line is locked and cannot be modified, typically set after period close or final approval.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, justification, or assumptions for this budget line allocation.',
    `quantity` DECIMAL(18,2) COMMENT 'The planned quantity or volume associated with this budget line (e.g., number of shipments, TEU, FTE headcount), enabling unit-based budget analysis.',
    `service_line` STRING COMMENT 'The service line or product category to which this budget line applies (e.g., Express Parcel, Freight Forwarding, Warehousing), enabling service-level budget tracking.',
    `sox_control_flag` BOOLEAN COMMENT 'Flag indicating whether this budget line is subject to SOX financial controls and requires enhanced audit trail and approval workflows.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the budget quantity (e.g., TEU, FTE, shipments, kilometers), providing context for volume-based budgeting.',
    `unit_price` DECIMAL(18,2) COMMENT 'The budgeted price per unit of measure, enabling calculation of total budget amount from quantity and unit price.',
    `valid_from_date` DATE COMMENT 'The start date from which this budget line is effective, enabling time-based budget phasing and validity tracking.',
    `valid_to_date` DATE COMMENT 'The end date until which this budget line is effective, enabling time-based budget phasing and validity tracking.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Line-item detail of budget allocations broken down by period, GL account, cost element, and organizational unit. Enables monthly/quarterly budget phasing, actuals-vs-budget variance tracking, and drill-down analysis for CAPEX fleet acquisitions, warehouse OPEX, and freight forwarding operational costs.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` (
    `accounts_payable_id` BIGINT COMMENT 'Unique identifier for the accounts payable record. Primary key for the accounts payable entity.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Carrier freight invoices are processed through AP for payment of transportation services. Essential for carrier payment processing, freight cost accounting, and carrier spend analysis - core logistics',
    `chart_of_accounts_id` BIGINT COMMENT 'Identifier of the general ledger account to which this payable is posted. Links to the chart of accounts for financial reporting.',
    `company_code_id` BIGINT COMMENT 'Identifier of the legal entity or company code responsible for this payable. Used for financial consolidation and legal reporting.',
    `contractor_safety_prequal_id` BIGINT COMMENT 'Foreign key linking to safety.contractor_safety_prequal. Business justification: Contractor payment authorization requires valid safety prequalification. Finance verifies contractor safety status before processing invoices to ensure compliance with safety policies and reduce liabi',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center to which this expense is allocated. Used for internal cost accounting and management reporting.',
    `document_package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: AP payment approval for freight invoices requires complete document packages (POD, signed BOL, customs clearance) to validate service delivery and resolve disputes. Essential for three-way match, paym',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: accounts_payable has posting_date but no FK to fiscal_period. AP postings occur in fiscal periods and should reference master calendar for period-end close and aging analysis by period.',
    `payment_run_id` BIGINT COMMENT 'Foreign key linking to finance.payment_run. Business justification: accounts_payable has payment_reference_number (STRING) and payment_date but no FK to payment_run. When AP invoices are paid via automated payment run, they should reference the payment_run entity for ',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this accounts payable record. Used for audit trail and accountability.',
    `profit_center_id` BIGINT COMMENT 'Identifier of the profit center responsible for this expense. Used for segment reporting and EBITDA analysis.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier to whom payment is owed. Links to carrier, 3PL/4PL provider, fuel supplier, customs broker, or other service provider.',
    `tax_account_id` BIGINT COMMENT 'Foreign key linking to finance.tax_account. Business justification: accounts_payable has tax_code (STRING) and tax_jurisdiction_code but no FK to tax_account master. Tax accounting requires reference to tax account master for proper tax reporting and compliance. Norma',
    `aging_bucket` STRING COMMENT 'The aging category of the payable based on days outstanding from the due date. Used for cash flow forecasting and vendor relationship management.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Indicates whether detailed audit logging is enabled for this payable record. Required for regulatory compliance and internal controls.',
    `baseline_date` DATE COMMENT 'The reference date from which payment terms are calculated. Typically the invoice date or goods receipt date depending on payment term configuration.',
    `clearing_document_number` STRING COMMENT 'The document number that cleared this open payable item. Used for audit trail and reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this accounts payable record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the invoice amount (e.g., USD, EUR, GBP). Used for multi-currency accounting and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `days_outstanding` STRING COMMENT 'The number of days the invoice has been outstanding since the invoice date. Used for aging analysis and payment prioritization.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The early payment discount amount available if payment is made within the discount period. Calculated based on payment terms.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this invoice is under dispute. Triggers dispute resolution workflow and payment hold.',
    `dispute_reason` STRING COMMENT 'Description of the reason for the invoice dispute. Provides context for resolution and vendor communication.',
    `due_date` DATE COMMENT 'The date by which payment must be made to the vendor to comply with payment terms and avoid late fees.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the invoice currency to the company code local currency. Used for multi-currency transactions.',
    `goods_receipt_number` STRING COMMENT 'The goods receipt document number confirming delivery of goods or services. Used for three-way matching and accrual accounting.',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this payable is an intercompany transaction between legal entities within Transport Shipping. Used for consolidation elimination.',
    `invoice_date` DATE COMMENT 'The date the vendor invoice was issued. Used for aging calculations and payment term determination.',
    `invoice_gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before any deductions, discounts, or adjustments. Represents the full vendor claim.',
    `invoice_number` STRING COMMENT 'The vendor-issued invoice number or document reference. This is the externally-known identifier for the payable transaction.',
    `invoice_receipt_date` DATE COMMENT 'The date the invoice was received by Transport Shipping. Used for internal processing SLA tracking and audit trails.',
    `invoice_type` STRING COMMENT 'The type of invoice document. Distinguishes between standard invoices, credit memos, debit memos, prepayments, and intercompany transactions.. Valid values are `standard|credit_memo|debit_memo|prepayment|intercompany|recurring`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this accounts payable record was last modified. Used for change tracking and audit trail.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The net payable amount converted to the company code local currency using the exchange rate. Used for financial reporting and consolidation.',
    `net_payable_amount` DECIMAL(18,2) COMMENT 'The net amount payable to the vendor after all deductions, discounts, and adjustments. This is the amount that will be paid.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about this payable. Used for communication and documentation.',
    `payable_category` STRING COMMENT 'The business category of the payable. Classifies vendor invoices by service type for spend analysis and vendor management. [ENUM-REF-CANDIDATE: carrier|3pl_4pl|fuel|customs_duty|warehouse|equipment|intercompany|other — 8 candidates stripped; promote to reference product]',
    `payment_block_code` STRING COMMENT 'Code indicating if payment is blocked and the reason for the block (e.g., dispute, missing documentation, approval pending, quality issue). Empty if no block exists.',
    `payment_block_reason` STRING COMMENT 'Detailed explanation of why the payment is blocked. Provides context for resolution and audit purposes.',
    `payment_date` DATE COMMENT 'The actual date payment was made to the vendor. Used for cash flow reporting and vendor payment performance tracking.',
    `payment_method_code` STRING COMMENT 'The method by which payment will be made to the vendor (e.g., wire transfer, ACH, check, electronic funds transfer).',
    `payment_reference_number` STRING COMMENT 'The reference number assigned when payment is made. Links the payable to the actual payment transaction for reconciliation.',
    `payment_status` STRING COMMENT 'The current payment status of the accounts payable record. Tracks the lifecycle from open invoice through payment completion.. Valid values are `open|partially_paid|fully_paid|overdue|blocked|cancelled`',
    `payment_term_code` STRING COMMENT 'The code representing the payment terms agreed with the vendor (e.g., Net 30, Net 60, 2/10 Net 30). Defines due date calculation and early payment discount conditions.',
    `posting_date` DATE COMMENT 'The date the payable was posted to the general ledger. Determines the accounting period for financial reporting.',
    `purchase_order_number` STRING COMMENT 'The purchase order number associated with this payable. Used for three-way matching (PO, goods receipt, invoice) and procurement audit.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this payable is subject to SOX financial controls and requires enhanced audit trail and approval workflow.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount included in the invoice (e.g., VAT, GST, sales tax). Used for tax reporting and reclaim processing.',
    `tax_jurisdiction_code` STRING COMMENT 'The tax jurisdiction code for this transaction. Used for multi-jurisdictional tax reporting and compliance.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax deducted from the vendor payment. Required for cross-border payments and tax compliance.',
    CONSTRAINT pk_accounts_payable PRIMARY KEY(`accounts_payable_id`)
) COMMENT 'Transactional entity managing all vendor payables and supplier invoices within Transport Shipping. Tracks carrier payment obligations, 3PL/4PL vendor invoices, fuel supplier payables, customs duty payables, and intercompany payables. Captures invoice receipt date, due date, payment terms, discount conditions, payment block status, and aging bucket. Sourced from SAP S/4HANA Finance AP module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` (
    `accounts_receivable_id` BIGINT COMMENT 'Unique identifier for the accounts receivable record. Primary key for this entity.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the general ledger account where this receivable is posted. Typically a trade receivables account in the chart of accounts.',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity company code that owns this receivable. Used for financial consolidation and statutory reporting per IFRS requirements.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center associated with this receivable for internal cost allocation and management accounting.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that owes this receivable. Links to the customer master data for B2B enterprise accounts and B2C shippers.',
    `document_package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: AR for freight charges requires complete document packages (signed delivery receipt, POD, customs clearance) for revenue recognition under ASC 606 and collection enforcement. Essential for revenue rec',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: accounts_receivable has posting_date but no FK to fiscal_period. AR postings occur in fiscal periods and should reference master calendar for period-end close and aging analysis by period.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice document that generated this receivable. Links to billing invoice for freight charges, express delivery fees, customs brokerage fees, warehousing charges, or e-commerce fulfillment fees.',
    `employee_id` BIGINT COMMENT 'The user ID of the person or system process that created this receivable record. Used for audit trail and SOX compliance.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center responsible for this receivable. Used for internal P&L reporting and EBITDA tracking by service line or geographic region.',
    `tax_account_id` BIGINT COMMENT 'Foreign key linking to finance.tax_account. Business justification: accounts_receivable has tax_jurisdiction_code (STRING) but no FK to tax_account master. AR tax accounting requires reference to tax account master for proper tax reporting.',
    `aging_bucket` STRING COMMENT 'The aging category of this receivable based on days past due: current (not yet due), 1_30_days, 31_60_days, 61_90_days, over_90_days. Used for credit risk assessment and collection prioritization.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `baseline_date` DATE COMMENT 'The reference date from which payment terms are calculated. Typically the invoice date or goods receipt date depending on contract terms.',
    `business_area_code` STRING COMMENT 'The business area code for segment reporting per IFRS 8. Used to classify receivables by service line: express parcel delivery, freight forwarding, supply chain management, customs brokerage, warehousing, e-commerce fulfillment.. Valid values are `^[A-Z0-9]{2,6}$`',
    `clearing_date` DATE COMMENT 'The date when this receivable was cleared (fully or partially paid). Used for days sales outstanding (DSO) calculation and cash collection analysis.',
    `clearing_document_number` STRING COMMENT 'The document number of the payment or credit memo that cleared this receivable. Populated when receivable status is fully_paid or partially_paid.. Valid values are `^[A-Z0-9]{10,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this accounts receivable record was first created in the system. Used for audit trail and data lineage.',
    `credit_limit_exposure` DECIMAL(18,2) COMMENT 'The portion of the customers credit limit consumed by this receivable. Used for credit risk management and order release decisions.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for this receivable (e.g., USD, EUR, GBP). Used for multi-currency accounting and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'The customer segment classification for this receivable: b2b_enterprise for large corporate accounts, b2b_sme for small/medium business, b2c_individual for consumer shippers, government for public sector, ecommerce_seller for online marketplace sellers.. Valid values are `b2b_enterprise|b2b_sme|b2c_individual|government|ecommerce_seller`',
    `days_past_due` STRING COMMENT 'The number of days this receivable is overdue calculated as current date minus due date. Negative values indicate not yet due. Used for aging analysis and dunning.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The cash discount amount available if the customer pays within the discount period specified in payment terms (e.g., 2% if paid within 10 days).',
    `dispute_flag` BOOLEAN COMMENT 'Flag indicating whether the customer has raised a dispute on this receivable. True when under dispute, requiring resolution before collection.',
    `document_date` DATE COMMENT 'The date on the source invoice or billing document. May differ from posting date due to processing delays.',
    `document_number` STRING COMMENT 'The externally-known unique document number for this receivable in the financial system. Used for audit trails and customer communication.. Valid values are `^[A-Z0-9]{10,20}$`',
    `document_type` STRING COMMENT 'The type of receivable document: invoice for standard billing, credit_memo for customer credits, debit_memo for additional charges, payment_on_account for advance payments, down_payment for partial prepayments.. Valid values are `invoice|credit_memo|debit_memo|payment_on_account|down_payment`',
    `due_date` DATE COMMENT 'The date by which payment is expected from the customer based on agreed payment terms. Used for cash flow forecasting and dunning.',
    `dunning_level` STRING COMMENT 'The current dunning level for this receivable indicating escalation stage of collection efforts (0=no dunning, 1=first reminder, 2=second reminder, 3=final notice, 4=legal action). Used for automated collection workflows.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate used to convert the transaction currency to local currency at the time of posting. Used for foreign currency valuation and revaluation.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total gross amount of the receivable before any discounts, taxes, or adjustments. Includes all freight charges, express delivery fees, customs brokerage fees, warehousing charges, and e-commerce fulfillment fees.',
    `intercompany_flag` BOOLEAN COMMENT 'Flag indicating whether this receivable is from an intercompany transaction between legal entities within Transport Shipping. True for intercompany receivables requiring elimination in consolidation.',
    `invoice_date` DATE COMMENT 'The date the invoice was issued to the customer. Starting point for payment terms calculation and aging analysis.',
    `last_dunning_date` DATE COMMENT 'The date when the last dunning notice was sent to the customer. Used to track collection activity and determine next dunning action.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this accounts receivable record was last modified. Used for change tracking and audit trail.',
    `local_currency_code` STRING COMMENT 'The local currency code of the company code for statutory reporting. Used for currency translation and consolidation per IFRS requirements.. Valid values are `^[A-Z]{3}$`',
    `net_amount` DECIMAL(18,2) COMMENT 'The net amount due from the customer after all discounts and adjustments. This is the amount expected to be collected and used for cash flow forecasting.',
    `notes` STRING COMMENT 'Free-text notes field for additional information about this receivable: special payment arrangements, dispute details, collection actions taken, or other relevant comments.',
    `outstanding_amount` DECIMAL(18,2) COMMENT 'The current outstanding balance on this receivable after partial payments or credits have been applied. Zero when fully paid.',
    `payment_block_indicator` BOOLEAN COMMENT 'Flag indicating whether this receivable is blocked for payment processing due to disputes, compliance holds, or manual review requirements. True when blocked.',
    `payment_method` STRING COMMENT 'The expected or agreed payment method for this receivable: bank transfer, credit card, check, cash, electronic funds transfer, letter of credit, etc. [ENUM-REF-CANDIDATE: bank_transfer|credit_card|debit_card|check|cash|eft|wire_transfer|ach|letter_of_credit|cod — promote to reference product]',
    `payment_terms_code` STRING COMMENT 'The code representing the payment terms agreed with the customer (e.g., NET30, NET60, 2/10NET30 for 2% discount if paid within 10 days).. Valid values are `^[A-Z0-9]{2,10}$`',
    `posting_date` DATE COMMENT 'The date when this receivable was posted to the general ledger. Used for financial period assignment and accounting close processes.',
    `receivable_status` STRING COMMENT 'Current lifecycle status of the receivable: open for unpaid, partially_paid for partial payment received, fully_paid when settled, written_off for bad debt, disputed for customer disputes, under_collection for legal collection process.. Valid values are `open|partially_paid|fully_paid|written_off|disputed|under_collection`',
    `service_line` STRING COMMENT 'The primary service line that generated this receivable. [ENUM-REF-CANDIDATE: express_parcel|air_freight|ocean_freight|road_freight|rail_freight|warehousing|customs_brokerage|ecommerce_fulfillment|contract_logistics|last_mile — promote to reference product]',
    `sox_control_flag` BOOLEAN COMMENT 'Flag indicating whether this receivable is subject to SOX internal controls and audit requirements. True for material receivables requiring enhanced documentation and approval workflows.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount included in this receivable (VAT, GST, sales tax, etc.) based on applicable tax jurisdiction and customer tax classification.',
    `tax_jurisdiction_code` STRING COMMENT 'The tax jurisdiction code applicable to this receivable for VAT, GST, or sales tax reporting. Used for statutory tax filings and compliance.. Valid values are `^[A-Z]{2,6}$`',
    `write_off_date` DATE COMMENT 'The date when this receivable was written off as bad debt. Used for bad debt expense tracking and credit loss reporting per IFRS 9.',
    `write_off_flag` BOOLEAN COMMENT 'Flag indicating whether this receivable has been written off as bad debt. True when deemed uncollectible and removed from active receivables.',
    `write_off_reason_code` STRING COMMENT 'The code indicating the reason for write-off: customer bankruptcy, uncollectible after legal action, small balance write-off, etc. Used for bad debt analysis.. Valid values are `^[A-Z0-9]{2,6}$`',
    CONSTRAINT pk_accounts_receivable PRIMARY KEY(`accounts_receivable_id`)
) COMMENT 'Transactional entity managing all customer receivables for Transport Shipping. Tracks outstanding freight charges, express delivery fees, customs brokerage fees, warehousing charges, and e-commerce fulfillment fees owed by B2B enterprise accounts and B2C shippers. Captures invoice date, due date, payment terms, dunning level, credit limit exposure, and aging bucket. Sourced from SAP S/4HANA Finance AR module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Unique identifier for the payment run execution. Primary key for the payment run entity.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: payment_run has bank_account_number (STRING) and house_bank_id (BIGINT) but no FK to bank_account master. Payment runs execute from specific bank accounts and must reference the bank_account master fo',
    `company_code_id` BIGINT COMMENT 'Reference to the company code executing this payment run. Represents the legal entity making disbursements.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: payment_run has fiscal_year (INT) and fiscal_period (INT) but no FK to fiscal_period master. Payment runs are posted to fiscal periods for cash flow reporting and should reference master calendar.',
    `payment_proposal_id` BIGINT COMMENT 'Reference to the payment proposal that was approved and executed as this payment run. Links to the pre-run selection and approval process.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this payment run for execution. Required for SOX compliance and audit trail.',
    `quaternary_payment_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this payment run record. Part of the audit trail for financial controls.',
    `tertiary_payment_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this payment run record. Part of the audit trail for financial controls.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this payment run required managerial approval before execution due to amount thresholds or policy requirements. True if approval was required.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this payment run was approved for execution. Part of the audit trail for financial controls.',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Indicates whether detailed audit logging is enabled for this payment run, capturing all changes and approvals. True for enhanced audit trail.',
    `bank_confirmation_number` STRING COMMENT 'The confirmation or reference number provided by the bank upon successful receipt and processing of the payment file.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all payments in this run. All disbursements within a single payment run are typically in the same currency.. Valid values are `^[A-Z]{3}$`',
    `error_message` STRING COMMENT 'Detailed error or exception message if the payment run failed or encountered issues during execution. Used for troubleshooting and resolution.',
    `execution_timestamp` TIMESTAMP COMMENT 'The date and time when this payment run was executed and payment file was generated.',
    `invoice_count` STRING COMMENT 'The total number of vendor invoices cleared and paid in this payment run execution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payment run record was last modified or updated.',
    `net_disbursement_amount` DECIMAL(18,2) COMMENT 'The net amount actually disbursed to vendors after discounts, withholding taxes, and other adjustments. Represents the actual cash outflow.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about this payment run. Used for operational communication and documentation.',
    `payment_block_override_flag` BOOLEAN COMMENT 'Indicates whether payment blocks on individual invoices were manually overridden to include them in this payment run. True if overrides were applied.',
    `payment_file_name` STRING COMMENT 'The name of the electronic payment file (e.g., ACH file, wire transfer file) generated for bank transmission. Used for reconciliation and troubleshooting.',
    `payment_file_transmission_timestamp` TIMESTAMP COMMENT 'The date and time when the payment file was transmitted to the bank for processing.',
    `payment_method_code` STRING COMMENT 'The payment instrument used for disbursements in this run. ACH (Automated Clearing House), WIRE (wire transfer), CHECK (paper check), EFT (Electronic Funds Transfer), SEPA (Single Euro Payments Area), BACS (Bankers Automated Clearing Services).. Valid values are `ACH|WIRE|CHECK|EFT|SEPA|BACS`',
    `payment_run_date` DATE COMMENT 'The date on which the payment run was executed. Represents the business event timestamp for the disbursement batch.',
    `payment_run_number` STRING COMMENT 'Business identifier for the payment run execution. Externally visible reference number used in SAP payment program and vendor communications.. Valid values are `^[A-Z0-9]{8,20}$`',
    `payment_run_status` STRING COMMENT 'Current lifecycle status of the payment run execution. Tracks progression from scheduling through completion or failure.. Valid values are `SCHEDULED|IN_PROGRESS|COMPLETED|FAILED|CANCELLED|PARTIALLY_COMPLETED`',
    `payment_run_type` STRING COMMENT 'Classification of the payment run based on its purpose and processing priority. REGULAR (standard scheduled run), URGENT (expedited processing), MANUAL (ad-hoc run), SCHEDULED (automated recurring), INTERCOMPANY (internal settlements).. Valid values are `REGULAR|URGENT|MANUAL|SCHEDULED|INTERCOMPANY`',
    `payment_terms_code` STRING COMMENT 'The standard payment terms applied to invoices in this payment run (e.g., NET30, 2/10NET30). Used for discount calculation and due date determination.',
    `posting_document_number` STRING COMMENT 'The financial document number generated in the general ledger when this payment run was posted. Used for GL reconciliation and audit trail.. Valid values are `^[A-Z0-9]{10,20}$`',
    `reconciliation_date` DATE COMMENT 'The date on which this payment run was fully reconciled with bank statements and confirmed cleared.',
    `reconciliation_status` STRING COMMENT 'Status of bank reconciliation for this payment run. Indicates whether all payments have been confirmed cleared by the bank and matched to bank statements.. Valid values are `PENDING|RECONCILED|DISCREPANCY|UNDER_REVIEW`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this payment run is subject to SOX internal control requirements and enhanced audit trail. True for material payment runs requiring additional controls.',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'The aggregate amount of early payment discounts taken across all invoices cleared in this payment run.',
    `total_payment_amount` DECIMAL(18,2) COMMENT 'The aggregate gross amount of all payments disbursed in this payment run, before any adjustments or fees.',
    `total_withholding_tax_amount` DECIMAL(18,2) COMMENT 'The aggregate amount of withholding tax deducted from vendor payments in this run, as required by tax regulations.',
    `value_date` DATE COMMENT 'The date on which the payment amounts are debited from the companys bank account. May differ from payment run date due to banking processing times.',
    `vendor_count` STRING COMMENT 'The total number of unique vendors receiving payments in this payment run.',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Transactional entity representing automated payment run executions for vendor disbursements. Captures payment run date, payment method (ACH, wire, check), bank account, total payment amount, number of invoices cleared, payment run status, and posting document reference. Supports carrier payment processing, customs duty disbursements, and fuel supplier settlements. Sourced from SAP S/4HANA Finance AP payment program.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` (
    `intercompany_settlement_id` BIGINT COMMENT 'Unique identifier for the intercompany settlement transaction. Primary key.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the consolidation elimination journal entry that offsets this intercompany settlement in the groups consolidated financial statements.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: intercompany_settlement has posting_date but no FK to fiscal_period. Intercompany settlements are posted to fiscal periods and should reference master calendar for period-end close and intercompany re',
    `agreement_id` BIGINT COMMENT 'Reference to the master netting agreement contract that governs the terms and conditions for offsetting intercompany balances between the sender and receiver entities.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved the intercompany settlement transaction for posting. Null if not yet approved or approval not required.',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity or subsidiary that is the sender (debtor) in the intercompany settlement transaction.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center within the sender entity that incurred the cost being settled intercompany.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center within the sender company code that originated the intercompany charge or service.',
    `tax_account_id` BIGINT COMMENT 'Foreign key linking to finance.tax_account. Business justification: intercompany_settlement has tax_jurisdiction_code (STRING), withholding_tax_rate, withholding_tax_amount but no FK to tax_account master. Intercompany tax accounting requires reference to tax account ',
    `tertiary_intercompany_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this intercompany settlement record in the system.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this intercompany settlement requires management approval before posting, typically based on materiality thresholds. True if approval is required.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany settlement was approved for posting. Null if not yet approved or approval not required.',
    `clearing_date` DATE COMMENT 'The date on which the intercompany settlement was cleared through payment or netting. Null if still outstanding.',
    `clearing_document_number` STRING COMMENT 'The document number of the payment or clearing transaction that settled the intercompany receivable/payable balance.. Valid values are `^[A-Z0-9]{8,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this intercompany settlement record was first created in the system.',
    `due_date` DATE COMMENT 'The date by which the intercompany settlement amount is due for payment, calculated based on settlement date and payment terms.',
    `elimination_flag` BOOLEAN COMMENT 'Indicates whether this intercompany settlement requires elimination entries for consolidated financial reporting under IFRS 10. True if elimination is required.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert transaction currency to local or group currency for the settlement date.',
    `gl_account_receiver` STRING COMMENT 'The general ledger account code in the receiver company codes chart of accounts to which the intercompany payable is posted.. Valid values are `^[0-9]{6,10}$`',
    `gl_account_sender` STRING COMMENT 'The general ledger account code in the sender company codes chart of accounts to which the intercompany receivable is posted.. Valid values are `^[0-9]{6,10}$`',
    `group_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code of the corporate groups consolidated reporting currency.. Valid values are `^[A-Z]{3}$`',
    `interest_amount` DECIMAL(18,2) COMMENT 'The calculated interest amount for intercompany loan settlements, based on principal, rate, and period.',
    `interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate percentage applied to intercompany loan settlements. Expressed as a decimal (e.g., 0.0350 for 3.5%).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this intercompany settlement record was last updated in the system.',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code of the sender company codes local reporting currency.. Valid values are `^[A-Z]{3}$`',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'The final settlement amount after applying tax, netting adjustments, and any other modifications. This is the amount posted to intercompany accounts.',
    `netting_run_reference` STRING COMMENT 'Reference identifier for the intercompany netting run batch that processed this settlement. Used to group settlements that were netted together.. Valid values are `^NET[0-9]{8}$`',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or supporting documentation references related to the intercompany settlement transaction.',
    `payment_terms_code` STRING COMMENT 'The payment terms code defining the due date calculation and discount conditions for the intercompany settlement.. Valid values are `^[A-Z0-9]{2,10}$`',
    `posting_date` DATE COMMENT 'The accounting period date when the settlement is posted to the general ledger. May differ from settlement date for period-end adjustments.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversal transaction that cancelled this intercompany settlement. Null if not reversed.. Valid values are `^[A-Z0-9]{8,20}$`',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this intercompany settlement has been reversed due to error correction or period-end adjustment. True if reversed.',
    `reversal_reason_code` STRING COMMENT 'The reason code explaining why this intercompany settlement was reversed. Null if not reversed.. Valid values are `error_correction|period_adjustment|duplicate_entry|incorrect_amount|incorrect_entity|other`',
    `service_category` STRING COMMENT 'Classification of the shared service or resource being settled intercompany. Aligns with Transport Shippings shared service center structure. [ENUM-REF-CANDIDATE: fleet_services|warehouse_services|it_services|hr_services|finance_services|procurement_services|legal_services|other — 8 candidates stripped; promote to reference product]',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the intercompany settlement transaction before any adjustments or netting.',
    `settlement_date` DATE COMMENT 'The business date on which the intercompany settlement transaction is executed and recorded in the general ledger.',
    `settlement_document_number` STRING COMMENT 'Externally-known unique document number for the intercompany settlement, typically generated by SAP S/4HANA Finance. Used for audit trails and cross-system reconciliation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the intercompany settlement transaction. Tracks progression from draft through posting and clearing. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|posted|cleared|reversed|cancelled — 7 candidates stripped; promote to reference product]',
    `settlement_type` STRING COMMENT 'Classification of the intercompany settlement transaction. Determines accounting treatment and reporting requirements.. Valid values are `shared_services|transfer_pricing|intercompany_loan|netting_agreement|elimination_entry|cost_allocation`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this intercompany settlement is subject to SOX internal control requirements and audit procedures. True if SOX controls apply.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applicable to the intercompany settlement, including VAT, GST, or withholding tax as per cross-border tax regulations.',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the intercompany settlement transaction is denominated.. Valid values are `^[A-Z]{3}$`',
    `transfer_pricing_method` STRING COMMENT 'The OECD-compliant transfer pricing methodology applied to determine the arms length price for this intercompany transaction.. Valid values are `comparable_uncontrolled_price|resale_price|cost_plus|profit_split|transactional_net_margin|not_applicable`',
    `value_date` DATE COMMENT 'The effective date for interest calculation and cash flow valuation purposes in intercompany loan settlements.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The calculated withholding tax amount deducted from the settlement amount for cross-border transactions.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'The withholding tax rate percentage applied to cross-border intercompany settlements as per bilateral tax treaties. Expressed as a decimal.',
    CONSTRAINT pk_intercompany_settlement PRIMARY KEY(`intercompany_settlement_id`)
) COMMENT 'Transactional entity managing intercompany financial settlements between Transport Shipping legal entities and subsidiaries. Captures cross-border intercompany charges for shared services (fleet, warehouse, IT), transfer pricing adjustments, intercompany loan interest, netting agreements, and elimination entries for consolidated P&L reporting. Tracks settlement status, netting run reference, and IFRS elimination flag.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`tax_account` (
    `tax_account_id` BIGINT COMMENT 'Unique identifier for the tax account record. Primary key.',
    `certificate_id` BIGINT COMMENT 'Foreign key linking to document.certificate. Business justification: Tax accounts for duty relief, VAT exemptions, or AEO status require certificates as proof of eligibility (origin certificate, AEO certificate, tax exemption certificate). Essential for customs duty re',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: tax_account has gl_account_id (BIGINT) which appears to be a generic ID, not a proper FK to chart_of_accounts. Tax accounts must reference the GL account master for proper tax accounting and financial',
    `company_code_id` BIGINT COMMENT 'Foreign key reference to the company code in SAP S/4HANA Finance to which this tax account is assigned. Represents the legal entity for financial reporting.',
    `controlling_area_id` BIGINT COMMENT 'Foreign key reference to the controlling area in SAP S/4HANA Finance for cost center accounting and internal reporting related to this tax account.',
    `created_by_user_employee_id` BIGINT COMMENT 'Foreign key reference to the user who created this tax account record in SAP S/4HANA Finance.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee or tax manager responsible for managing this tax account, filings, and compliance.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Foreign key reference to the user who last modified this tax account record in SAP S/4HANA Finance.',
    `aeo_status_required_flag` BOOLEAN COMMENT 'Indicates whether Authorized Economic Operator (AEO) status is required to benefit from simplified procedures or reduced rates under this tax account. True if AEO status is required, False otherwise.',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Indicates whether detailed audit trail logging is enabled for all transactions posted to this tax account. True if audit trail is enabled, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax account record was first created in SAP S/4HANA Finance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which tax amounts for this tax account are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deferred_payment_allowed_flag` BOOLEAN COMMENT 'Indicates whether deferred payment of tax is allowed under this tax account (e.g., customs duty deferment). True if deferred payment is allowed, False otherwise.',
    `exemption_certificate_required_flag` BOOLEAN COMMENT 'Indicates whether a tax exemption certificate is required to apply this tax account. True if exemption certificate is required, False otherwise.',
    `hs_code_applicability` STRING COMMENT 'Harmonized System (HS) code or code range to which this tax account applies, relevant for customs duty tax accounts. Used for tariff classification and customs brokerage.',
    `incoterm_applicability` STRING COMMENT 'Incoterms rule(s) under which this tax account is applicable (e.g., DDP, DAP, FOB, CIF, EXW). Relevant for determining tax liability in cross-border shipments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax account record was last modified in SAP S/4HANA Finance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lock_indicator` BOOLEAN COMMENT 'Indicates whether this tax account is locked for posting. True if locked (no new postings allowed), False if unlocked (postings allowed).',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this tax account, including special instructions, historical context, or compliance considerations.',
    `recoverable_flag` BOOLEAN COMMENT 'Indicates whether tax paid under this tax account is recoverable (input tax credit). True if recoverable, False if non-recoverable.',
    `regulatory_framework` STRING COMMENT 'Name of the regulatory framework or compliance standard governing this tax account (e.g., EU VAT Directive, US IRC, WCO Harmonized System, local tax code). [ENUM-REF-CANDIDATE: EU_VAT_Directive|US_IRC|WCO_Harmonized_System|OECD_Transfer_Pricing|Local_Tax_Code|IFRS|SOX|GDPR — promote to reference product]',
    `reverse_charge_flag` BOOLEAN COMMENT 'Indicates whether this tax account is subject to reverse charge mechanism where the recipient (not the supplier) is liable for VAT/GST. True if reverse charge applies, False otherwise.',
    `self_assessment_flag` BOOLEAN COMMENT 'Indicates whether this tax account requires self-assessment by Transport Shipping rather than being assessed by the tax authority. True if self-assessment applies, False otherwise.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this tax account is subject to Sarbanes-Oxley (SOX) internal controls and audit requirements. True if SOX controls apply, False otherwise.',
    `tax_account_code` STRING COMMENT 'Unique business identifier for the tax account used in SAP S/4HANA Finance tax configuration and external reporting. Externally-known code for this tax account.. Valid values are `^[A-Z0-9]{4,20}$`',
    `tax_account_description` STRING COMMENT 'Detailed description of the tax account purpose, scope, and applicability within Transport Shipping operations.',
    `tax_account_name` STRING COMMENT 'Human-readable name of the tax account for display and reporting purposes.',
    `tax_account_status` STRING COMMENT 'Current lifecycle status of the tax account: active (in use), inactive (not currently used), suspended (temporarily halted), pending approval (awaiting activation), or closed (permanently retired).. Valid values are `active|inactive|suspended|pending_approval|closed`',
    `tax_authority_identifier` STRING COMMENT 'Official identifier or registration number assigned by the tax authority for this tax account or tax registration.',
    `tax_authority_name` STRING COMMENT 'Name of the tax authority or regulatory body responsible for this tax account (e.g., HM Revenue & Customs, IRS, local customs authority).',
    `tax_category` STRING COMMENT 'Subcategory of the tax account indicating whether it is input tax (recoverable), output tax (payable), import/export tax, payroll tax, or excise tax.. Valid values are `input_tax|output_tax|import_tax|export_tax|payroll_tax|excise_tax`',
    `tax_filing_method` STRING COMMENT 'Method by which tax returns and filings are submitted to the tax authority: electronic portal, paper submission, Electronic Data Interchange (EDI), or Application Programming Interface (API).. Valid values are `electronic|paper|EDI|API`',
    `tax_jurisdiction_code` STRING COMMENT 'ISO country code or extended jurisdiction code identifying the tax authority jurisdiction (e.g., USA, GBR, DEU-BY for Bavaria). Aligns with WCO and local tax authority requirements.. Valid values are `^[A-Z]{2,3}(-[A-Z0-9]{1,5})?$`',
    `tax_point_rule` STRING COMMENT 'Rule determining the tax point (time of supply) for this tax account: invoice date, delivery date, payment date, or service completion date. Defines when tax liability arises.. Valid values are `invoice_date|delivery_date|payment_date|service_completion_date`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Standard tax rate percentage applicable to this tax account. Expressed as a percentage (e.g., 20.00 for 20%).',
    `tax_reporting_frequency` STRING COMMENT 'Frequency at which tax filings and reports must be submitted to the tax authority for this tax account (monthly, quarterly, annually, semi-annually, or on-demand).. Valid values are `monthly|quarterly|annually|semi_annually|on_demand`',
    `tax_type` STRING COMMENT 'Classification of the tax account by tax type: Value Added Tax (VAT), Goods and Services Tax (GST), customs duty, withholding tax, corporate income tax, or sales tax.. Valid values are `VAT|GST|customs_duty|withholding_tax|corporate_income_tax|sales_tax`',
    `valid_from_date` DATE COMMENT 'Date from which this tax account configuration becomes effective and can be used for tax postings. Format: yyyy-MM-dd.',
    `valid_to_date` DATE COMMENT 'Date until which this tax account configuration remains effective. Null if the tax account is open-ended. Format: yyyy-MM-dd.',
    `withholding_rate` DECIMAL(18,2) COMMENT 'Withholding tax rate percentage applicable to this tax account for payments to non-resident suppliers or contractors. Expressed as a percentage (e.g., 15.00 for 15%). Null if not a withholding tax account.',
    CONSTRAINT pk_tax_account PRIMARY KEY(`tax_account_id`)
) COMMENT 'Master entity for tax account management covering VAT, GST, customs duty tax accounts, withholding tax, and corporate income tax obligations across Transport Shipping jurisdictions. Tracks tax code, tax type, tax rate, jurisdiction, tax authority, reporting frequency, and applicable regulatory framework (WCO, local tax authority). Sourced from SAP S/4HANA Finance tax configuration.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`tax_filing` (
    `tax_filing_id` BIGINT COMMENT 'Unique identifier for the tax filing record. Primary key for the tax filing entity.',
    `certificate_id` BIGINT COMMENT 'Foreign key linking to document.certificate. Business justification: Tax filings for customs duties attach certificates (origin certificate, AEO certificate, phytosanitary certificate) to support duty relief claims and preferential tariff treatment. Essential for custo',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity or company code within Transport Shipping that is the taxpayer for this filing. Links to the organizational structure in SAP S/4HANA Finance.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: tax_filing has filing_period_start_date and filing_period_end_date but no FK to fiscal_period. Tax filings are period-specific and should reference master calendar for tax reporting alignment with fis',
    `original_filing_tax_filing_id` BIGINT COMMENT 'Reference to the original tax filing record that this filing amends or corrects. Null if this is an original filing.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this tax filing record. Part of the audit trail for SOX compliance and internal controls.',
    `tax_account_id` BIGINT COMMENT 'Foreign key linking to finance.tax_account. Business justification: Tax filings are submitted for specific tax accounts (VAT, GST, withholding). This links the filing to the tax account master data. No columns to remove as tax_filing captures filing-specific data.',
    `trade_document_id` BIGINT COMMENT 'Foreign key linking to document.trade_document. Business justification: Tax filings for customs duties, VAT, and import/export taxes reference trade documents (commercial invoice, packing list, certificate of origin) as supporting evidence. Critical for customs tax compli',
    `amendment_flag` BOOLEAN COMMENT 'Indicates whether this filing is an amended or corrected version of a previously submitted filing. True if this is an amendment, false if original filing.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the tax filing was formally approved for submission by the authorized approver. Part of SOX internal control audit trail.',
    `approver_name` STRING COMMENT 'The name of the authorized individual who reviewed and approved the tax filing for submission. Typically a senior finance manager or tax director.',
    `audit_risk_score` DECIMAL(18,2) COMMENT 'An internal risk assessment score indicating the likelihood that this filing may be selected for audit by the tax authority. Higher scores indicate higher risk.',
    `confirmation_number` STRING COMMENT 'The confirmation or acknowledgment number provided by the tax authority upon successful receipt of the filing. Used for proof of submission.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this tax filing record was first created in the system. Part of the audit trail for SOX compliance.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the tax amounts are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `filing_deadline_date` DATE COMMENT 'The statutory deadline by which the tax filing must be submitted to the tax authority to avoid penalties or interest charges.',
    `filing_method` STRING COMMENT 'The method or channel used to submit the tax filing to the tax authority (e.g., electronic portal, paper mail, EDI, API integration).. Valid values are `electronic|paper|edi|api`',
    `filing_period_end_date` DATE COMMENT 'The last date of the tax period covered by this filing. Defines the end of the reporting period for which tax obligations are calculated.',
    `filing_period_start_date` DATE COMMENT 'The first date of the tax period covered by this filing. Defines the beginning of the reporting period for which tax obligations are calculated.',
    `filing_reference_number` STRING COMMENT 'The externally-known unique reference number assigned by the tax authority upon submission or acceptance of the filing. Used for tracking and correspondence with tax authorities.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the tax filing. Tracks the filing through preparation, submission, review, and final acceptance or rejection by the tax authority.. Valid values are `draft|submitted|accepted|rejected|amended|under_review`',
    `filing_type` STRING COMMENT 'The category of tax filing being submitted. Determines the applicable tax regulations, forms, and submission requirements.. Valid values are `vat_return|corporate_income_tax|customs_duty_reconciliation|withholding_tax|excise_tax|payroll_tax`',
    `interest_amount` DECIMAL(18,2) COMMENT 'The interest charges accrued on late or underpaid tax amounts, calculated according to the tax authoritys interest rate schedule.',
    `jurisdiction_code` STRING COMMENT 'The code identifying the tax jurisdiction (country, state, province, or local authority) to which this filing is submitted. Determines applicable tax laws and rates.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this tax filing record was last updated. Part of the audit trail for SOX compliance and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or special circumstances related to this tax filing. Used for internal documentation and audit trail.',
    `payment_due_date` DATE COMMENT 'The date by which the tax liability reported in this filing must be paid to the tax authority to avoid additional penalties or interest.',
    `payment_status` STRING COMMENT 'The current payment status of the tax liability associated with this filing. Tracks whether the obligation has been settled with the tax authority.. Valid values are `unpaid|partially_paid|fully_paid|refunded|waived`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The monetary penalty assessed or accrued for late filing, underpayment, or non-compliance with tax regulations. Zero if no penalty applies.',
    `preparer_contact_email` STRING COMMENT 'The email address of the tax filing preparer for correspondence and audit inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `preparer_name` STRING COMMENT 'The name of the individual or firm responsible for preparing the tax filing. May be an internal tax accountant or external tax advisor.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this tax filing is subject to SOX internal control requirements and audit procedures. True if SOX controls apply, false otherwise.',
    `submission_timestamp` TIMESTAMP COMMENT 'The precise date and time when the tax filing was submitted to the tax authority. Used to verify compliance with filing deadlines and for audit trail purposes.',
    `supporting_document_count` STRING COMMENT 'The number of supporting documents, schedules, or attachments submitted with this tax filing (e.g., invoices, receipts, reconciliation reports).',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax liability or refund amount reported in this filing. Represents the net tax obligation after all adjustments, credits, and deductions.',
    `tax_authority_name` STRING COMMENT 'The name of the governmental tax authority or agency responsible for receiving and processing this filing (e.g., IRS, HMRC, local customs office).',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'The effective tax rate percentage applied to the taxable base to calculate the tax liability. May be a statutory rate or blended rate depending on filing type.',
    `tax_registration_number` STRING COMMENT 'The taxpayer identification number or tax registration number assigned by the tax authority to the company for this jurisdiction (e.g., VAT number, EIN, TIN).',
    `taxable_base_amount` DECIMAL(18,2) COMMENT 'The gross taxable base or revenue amount upon which the tax liability is calculated, before application of tax rates and adjustments.',
    CONSTRAINT pk_tax_filing PRIMARY KEY(`tax_filing_id`)
) COMMENT 'Transactional entity tracking all tax filing submissions and obligations for Transport Shipping across global jurisdictions. Captures filing type (VAT return, corporate tax, customs duty reconciliation, withholding tax), filing period, jurisdiction, filing status (draft, submitted, accepted, amended), tax authority reference number, filing deadline, and penalty exposure. Supports SOX and IFRS regulatory reporting requirements.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key for the fixed asset entity.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Fixed assets are often created from CAPEX projects (asset under construction → capitalized asset). This links the asset to its originating capital investment project.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Leased equipment (containers, trailers, aircraft) from carriers must track lessor for lease accounting (ASC 842/IFRS 16), depreciation calculations, and asset return/maintenance obligations. Critical ',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: fixed_asset has gl_account_code (STRING), depreciation_gl_account_code (STRING), accumulated_depreciation_gl_account_code (STRING) but no FK to chart_of_accounts. Should reference primary asset GL acc',
    `company_code_id` BIGINT COMMENT 'Identifier of the legal entity (company code) that owns this fixed asset. Used for financial consolidation and legal reporting.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center responsible for this asset. Used for internal cost allocation and management reporting.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: fixed_asset has acquisition_date and capitalization_date but no FK to fiscal_period. Asset capitalization occurs in a fiscal period and should reference master calendar for CAPEX reporting by period.',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: Under IFRS 16, leased assets are capitalized as right-of-use assets. This FK links the fixed asset to its lease contract for proper lease accounting.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or manager responsible for the custody and management of this asset. Used for accountability and asset stewardship.',
    `profit_center_id` BIGINT COMMENT 'Identifier of the profit center to which this asset is assigned. Used for segment reporting and EBITDA tracking.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier from whom the asset was purchased. Links to procurement and accounts payable records.',
    `tertiary_fixed_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this fixed asset record. Used for audit trail and accountability.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since the asset was placed in service. Contra-asset account that reduces the gross book value to net book value.',
    `accumulated_depreciation_gl_account_code` STRING COMMENT 'General ledger account code for the accumulated depreciation contra-asset account. Used for balance sheet reporting.. Valid values are `^[0-9]{6,10}$`',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase price or historical cost of the asset including all costs necessary to bring the asset to its intended use (purchase price, delivery, installation, testing). Basis for depreciation calculation.',
    `acquisition_date` DATE COMMENT 'Date when the asset was acquired or purchased by Transport Shipping. Marks the start of the assets lifecycle and is used for depreciation calculation start date.',
    `asset_class_code` STRING COMMENT 'Classification code that categorizes the asset by type (e.g., vehicles, aircraft, vessels, warehouse facilities, material handling equipment, IT infrastructure). Determines depreciation rules, useful life defaults, and GL account assignments.. Valid values are `^[A-Z0-9]{4,8}$`',
    `asset_class_name` STRING COMMENT 'Human-readable name of the asset class (e.g., Delivery Vehicles, Cargo Aircraft, Container Ships, Warehouse Buildings, Forklifts, Servers).',
    `asset_description` STRING COMMENT 'Detailed textual description of the fixed asset including make, model, specifications, and distinguishing characteristics. Used for identification and inventory purposes.',
    `asset_location_code` STRING COMMENT 'Code identifying the physical location where the asset is deployed (e.g., warehouse facility code, airport code, depot code, office location code). Used for asset tracking and inventory management.. Valid values are `^[A-Z0-9]{4,10}$`',
    `asset_location_name` STRING COMMENT 'Human-readable name of the physical location where the asset is deployed (e.g., Chicago Distribution Center, Frankfurt Airport Hub, Singapore Port Terminal).',
    `asset_number` STRING COMMENT 'Externally-known unique business identifier for the fixed asset. Used for asset tracking, reporting, and audit trails. Typically assigned by the Asset Accounting module.. Valid values are `^[A-Z0-9]{8,12}$`',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset. Determines whether depreciation is active and whether the asset is available for operational use.. Valid values are `in_service|under_construction|retired|disposed|impaired|held_for_sale`',
    `asset_sub_number` STRING COMMENT 'Sub-asset identifier used when a main asset has multiple components tracked separately (e.g., engine, avionics, landing gear for an aircraft). Enables component-level depreciation and maintenance tracking.. Valid values are `^[A-Z0-9]{1,4}$`',
    `capex_category` STRING COMMENT 'Classification of the capital expenditure type for budgeting and strategic planning purposes. Distinguishes between growth investments, maintenance, and regulatory compliance.. Valid values are `growth|maintenance|replacement|regulatory|efficiency`',
    `capitalization_date` DATE COMMENT 'Date when the asset was placed in service and capitalized on the balance sheet. Depreciation begins from this date. May differ from acquisition date for assets under construction.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the asset is physically located. Used for tax jurisdiction, regulatory compliance, and geographic reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fixed asset record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts associated with this asset (acquisition cost, net book value, accumulated depreciation).. Valid values are `^[A-Z]{3}$`',
    `depreciation_gl_account_code` STRING COMMENT 'General ledger account code to which depreciation expense is posted. Used for P&L reporting of depreciation charges.. Valid values are `^[0-9]{6,10}$`',
    `depreciation_method` STRING COMMENT 'Accounting method used to allocate the cost of the asset over its useful life. Straight-line is most common for IFRS compliance; declining balance may be used for tax purposes.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits`',
    `disposal_date` DATE COMMENT 'Date when the asset was disposed of, sold, scrapped, or retired from service. Marks the end of the assets lifecycle and triggers gain/loss calculation.',
    `disposal_method` STRING COMMENT 'Method by which the asset was disposed of. Determines accounting treatment for gain/loss recognition and tax implications.. Valid values are `sale|scrap|trade_in|donation|transfer|retirement`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Amount received from the sale or disposal of the asset. Used to calculate gain or loss on disposal (proceeds minus net book value at disposal).',
    `impairment_indicator` BOOLEAN COMMENT 'Flag indicating whether the asset has been tested for impairment and an impairment loss has been recognized. Required under IFRS IAS 36 when carrying value exceeds recoverable amount.',
    `impairment_loss_amount` DECIMAL(18,2) COMMENT 'Amount of impairment loss recognized when the assets recoverable amount falls below its carrying value. Reduces net book value and is recognized as an expense.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number covering this asset against loss, damage, or liability. Used for risk management and claims processing.. Valid values are `^[A-Z0-9]{8,15}$`',
    `invoice_number` STRING COMMENT 'Vendor invoice number associated with the asset acquisition. Links to accounts payable and financial audit trail.. Valid values are `^[A-Z0-9]{8,15}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this fixed asset record was last updated. Used for audit trail and change tracking.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactured or produced the asset (e.g., Boeing, Mercedes-Benz, Maersk, Konecranes).',
    `model_number` STRING COMMENT 'Manufacturers model or type designation for the asset (e.g., Boeing 747-8F, Sprinter 3500, Emma-class container ship).',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the asset on the balance sheet, calculated as acquisition cost minus accumulated depreciation. Represents the remaining unamortized cost.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the asset that does not fit in structured fields.',
    `purchase_order_number` STRING COMMENT 'Purchase order number under which the asset was acquired. Provides audit trail to procurement documentation.. Valid values are `^[A-Z0-9]{8,12}$`',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. The depreciable base is acquisition cost minus salvage value.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number or unique identifier for the physical asset. Used for warranty tracking, maintenance records, and theft prevention.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this asset is subject to SOX internal controls and audit requirements. High-value assets and those affecting financial reporting are typically flagged.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Expected useful economic life of the asset in years. Used to calculate annual depreciation expense. Determined by asset class and regulatory/accounting standards.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Master entity for fixed asset management covering Transport Shippings capital assets including owned vehicles, aircraft, vessels, warehouse facilities, material handling equipment, and IT infrastructure. Tracks asset class, acquisition date, acquisition cost, useful life, depreciation method (straight-line, declining balance per IFRS), net book value, asset location, and disposal status. Sourced from SAP S/4HANA Finance Asset Accounting (AA) module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` (
    `asset_depreciation_id` BIGINT COMMENT 'Unique identifier for the asset depreciation posting record.',
    `capex_project_id` BIGINT COMMENT 'Reference to the CAPEX project that funded the asset acquisition (warehouse expansion, fleet modernization, IT infrastructure upgrade).',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: asset_depreciation has gl_account_depreciation_expense and gl_account_accumulated_depreciation as STRING but no FK to chart_of_accounts. Adding FK to reference the primary depreciation expense GL acco',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: asset_depreciation has company_code as STRING but no FK to company_code master. Legal entity context is essential for depreciation posting and fixed asset accounting by legal entity. Normalizing to FK',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center where the depreciation expense is allocated.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: asset_depreciation has fiscal_year (INT) and fiscal_period (INT) but no FK to fiscal_period master. Depreciation runs are period-specific and should reference the master fiscal calendar for period-end',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset being depreciated (fleet vehicle, warehouse equipment, IT infrastructure, leased facility).',
    `lease_contract_id` BIGINT COMMENT 'Reference to the lease contract if this is IFRS 16 lease depreciation for fleet vehicles, warehouse facilities, or office space.',
    `employee_id` BIGINT COMMENT 'Twelve-character user ID of the system user or batch job that created the depreciation posting.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center for EBITDA and P&L reporting of the depreciation expense.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total accumulated depreciation for the asset after this posting, representing cumulative depreciation since acquisition.',
    `asset_acquisition_date` DATE COMMENT 'Original acquisition or capitalization date of the asset being depreciated.',
    `asset_acquisition_value` DECIMAL(18,2) COMMENT 'Original acquisition or capitalized cost of the asset in the assets local currency.',
    `asset_class` STRING COMMENT 'Eight-digit asset class code categorizing the type of fixed asset (vehicles, buildings, machinery, IT equipment, leasehold improvements).. Valid values are `^[0-9]{8}$`',
    `audit_trail_reference` STRING COMMENT 'Twenty-character unique audit trail identifier for SOX compliance and financial audit tracking.. Valid values are `^[A-Z0-9]{20}$`',
    `business_area_code` STRING COMMENT 'Four-character code identifying the business area or service line (express parcel, freight forwarding, contract logistics, e-commerce fulfillment).. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the depreciation posting record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the depreciation amounts.. Valid values are `^[A-Z]{3}$`',
    `depreciation_amount` DECIMAL(18,2) COMMENT 'Periodic depreciation expense amount posted for this run in the assets local currency.',
    `depreciation_area` STRING COMMENT 'Two-digit code identifying the depreciation area (01=book depreciation, 10=tax depreciation, 15=IFRS 16 lease depreciation, 20=group consolidation, 30=cost accounting).. Valid values are `^[0-9]{2}$`',
    `depreciation_key` STRING COMMENT 'Four-character code defining the depreciation calculation method (straight-line, declining balance, units of production, IFRS 16 lease).. Valid values are `^[A-Z0-9]{4}$`',
    `depreciation_run_date` DATE COMMENT 'Date when the depreciation calculation batch was executed.',
    `document_number` STRING COMMENT 'Ten-digit accounting document number generated for the depreciation posting in the general ledger.. Valid values are `^[0-9]{10}$`',
    `document_type` STRING COMMENT 'Two-character document type code for the depreciation posting (AF=asset posting, SA=GL document).. Valid values are `^[A-Z]{2}$`',
    `gl_account_accumulated_depreciation` STRING COMMENT 'Ten-digit GL account number for posting the accumulated depreciation (credit side of the journal entry, contra-asset account).. Valid values are `^[0-9]{10}$`',
    `gl_account_depreciation_expense` STRING COMMENT 'Ten-digit GL account number for posting the depreciation expense (debit side of the journal entry).. Valid values are `^[0-9]{10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the depreciation posting record was last modified (for corrections or reversals).',
    `lease_indicator` BOOLEAN COMMENT 'Flag indicating whether this depreciation relates to a leased asset under IFRS 16 (true=leased asset, false=owned asset).',
    `net_book_value` DECIMAL(18,2) COMMENT 'Net book value of the asset after this depreciation posting (acquisition value minus accumulated depreciation).',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the depreciation posting, including explanations for adjustments, reversals, or special circumstances.',
    `posting_date` DATE COMMENT 'Accounting date when the depreciation was posted to the general ledger.',
    `posting_status` STRING COMMENT 'Current status of the depreciation posting in the general ledger (posted=successfully posted, pending=awaiting approval, reversed=reversed posting, error=posting failed).. Valid values are `posted|pending|reversed|error`',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this depreciation posting is a reversal of a previous posting (true=reversal, false=original posting).',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for reversal if reversal_indicator is true (01=correction, 02=asset transfer, 03=asset retirement, 04=revaluation, 05=period adjustment).. Valid values are `01|02|03|04|05`',
    `segment_code` STRING COMMENT 'Four-character segment code for IFRS segment reporting and EBITDA tracking by business line.. Valid values are `^[A-Z0-9]{4}$`',
    `sox_control_flag` BOOLEAN COMMENT 'Flag indicating whether this depreciation posting is subject to SOX financial controls and audit requirements (true=SOX controlled, false=not SOX controlled).',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Remaining useful life of the asset in years at the time of this depreciation posting.',
    CONSTRAINT pk_asset_depreciation PRIMARY KEY(`asset_depreciation_id`)
) COMMENT 'Transactional entity recording periodic depreciation postings for fixed assets. Captures depreciation run date, depreciation area (book depreciation, tax depreciation), depreciation amount, accumulated depreciation, net book value after posting, and fiscal period. Supports IFRS 16 lease depreciation for leased fleet and warehouse assets, and CAPEX amortization tracking. Sourced from SAP S/4HANA Finance AA depreciation run.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Unique identifier for the cost allocation record. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Cost allocations post to GL accounts. Linking to chart_of_accounts enables proper GL account validation and reporting for allocation postings.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: cost_allocation has company_code as STRING but no FK to company_code master. Cost allocations occur within legal entities and must reference company code master for proper legal entity context.',
    `cost_element_id` BIGINT COMMENT 'Foreign key linking to finance.cost_element. Business justification: Cost allocations use cost elements to classify the type of cost being allocated. Currently has cost_element_code (STRING) which should be normalized to a FK. The cost_element table has element_code an',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: cost_allocation has fiscal_year (INT) and fiscal_period (INT) but no FK to fiscal_period master. Cost allocation cycles are period-specific and should reference master fiscal calendar.',
    `original_allocation_cost_allocation_id` BIGINT COMMENT 'Foreign key to the original cost allocation record if this is a reversal. Null for original postings.',
    `employee_id` BIGINT COMMENT 'User ID of the person or system account that created or executed the allocation cycle.',
    `cost_center_id` BIGINT COMMENT 'Foreign key to the cost center from which costs are being allocated (the source of the shared cost).',
    `profit_center_id` BIGINT COMMENT 'Foreign key to the profit center receiving the allocated cost. Null if receiver is a cost center. Used for P&L reporting by service line.',
    `tertiary_cost_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person or system account that last modified this allocation record.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The monetary amount allocated from sender to receiver in the transaction currency. This is the core financial value being distributed.',
    `allocation_basis_quantity` DECIMAL(18,2) COMMENT 'The quantity of the allocation basis used for this receiver (e.g., 5.0 FTE, 1200 TEU, 850.5 CBM). Used to calculate proportional share.',
    `allocation_basis_type` STRING COMMENT 'The basis or driver used to allocate costs: FTE (Full-Time Equivalent) headcount, shipment volume, TEU (Twenty-foot Equivalent Unit), CBM (Cubic Meter), revenue, square footage, or fixed percentage. [ENUM-REF-CANDIDATE: fte_headcount|shipment_volume|teu|cbm|revenue|square_footage|fixed_percentage — 7 candidates stripped; promote to reference product]',
    `allocation_basis_unit` STRING COMMENT 'Unit of measure for the allocation basis quantity (e.g., FTE, TEU, CBM, USD, SQM).',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total sender cost allocated to this receiver, calculated based on allocation basis. Sum of all receivers in a cycle should equal 100%.',
    `allocation_reference_text` STRING COMMENT 'Free-text reference or description providing additional context for the allocation (e.g., Q1 IT shared services allocation, Warehouse rent distribution).',
    `allocation_rule_code` STRING COMMENT 'Code identifying the allocation rule or assessment method applied (e.g., distribution key, statistical key figure, activity type). Defines how costs are distributed.',
    `allocation_run_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation cycle was executed and this record was created. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `allocation_status` STRING COMMENT 'Current status of the cost allocation record: draft (not yet posted), posted (active), reversed (corrected), or cancelled.. Valid values are `draft|posted|reversed|cancelled`',
    `allocation_type` STRING COMMENT 'Type of cost allocation method used: assessment (lump-sum), distribution (proportional), periodic reposting, activity allocation, or template allocation.. Valid values are `assessment|distribution|periodic_reposting|activity_allocation|template_allocation`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation was approved for posting. Null if no approval workflow. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Flag indicating whether detailed audit trail logging is enabled for this allocation record (True) or not (False).',
    `business_area_code` STRING COMMENT 'Business area code for segment reporting and cross-company code analysis.',
    `controlling_area_code` STRING COMMENT 'Controlling area in which the allocation is executed. Organizational unit for cost accounting in SAP.',
    `document_number` STRING COMMENT 'Unique document number assigned to the cost allocation posting in SAP CO. Used for audit trail and reversal reference.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this allocation record. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the cost allocation, including business justification, special circumstances, or audit annotations.',
    `posting_date` DATE COMMENT 'Date on which the cost allocation was posted to the general ledger and cost accounting. Format: yyyy-MM-dd.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this allocation record is a reversal of a previous allocation (True) or an original posting (False).',
    `segment_code` STRING COMMENT 'Segment code for IFRS segment reporting. Used for external financial reporting by business segment.',
    `service_line` STRING COMMENT 'Business service line for which the allocation is being performed: express parcel delivery, freight forwarding, warehouse, e-commerce fulfillment, customs brokerage, or contract logistics. Enables P&L reporting by service line.. Valid values are `express|freight|warehouse|fulfillment|customs|contract_logistics`',
    `sox_control_flag` BOOLEAN COMMENT 'Flag indicating whether this allocation is subject to SOX internal control requirements (True) or not (False). Used for audit and compliance tracking.',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocated amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Transactional entity capturing internal cost allocation and assessment cycles distributing shared costs across cost centers and profit centers. Records allocation rule reference, sender cost center, receiver cost center/profit center, allocation basis (FTE headcount, shipment volume, TEU, CBM), allocated amount, and fiscal period. Enables accurate P&L reporting by service line (express, freight, warehouse, fulfillment). Sourced from SAP S/4HANA Finance CO allocation cycles.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` (
    `financial_period_close_id` BIGINT COMMENT 'Unique identifier for the financial period close record.',
    `approver_employee_id` BIGINT COMMENT 'Reference to the employee or user who approved or certified the completion of this close task.',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity or company code for which this close is being performed.',
    `controlling_area_id` BIGINT COMMENT 'Reference to the controlling area (organizational unit for cost accounting) associated with this close.',
    `created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this financial period close record.',
    `document_package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: Period close requires complete document packages (POD, signed BOL, customs clearance) for revenue recognition under ASC 606/IFRS 15. Essential for period-end close checklist, revenue cut-off validatio',
    `employee_id` BIGINT COMMENT 'Reference to the user who locked the financial period. Null if period is not locked.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: financial_period_close has fiscal_year (INT) and fiscal_period (INT) but no FK to fiscal_period master. This is the period close entity - it MUST reference the fiscal_period being closed. This is a cr',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this financial period close record.',
    `ledger_id` BIGINT COMMENT 'Reference to the general ledger or accounting ledger for which this close is being performed (e.g., leading ledger, IFRS ledger, local GAAP ledger).',
    `primary_financial_employee_id` BIGINT COMMENT 'Reference to the employee or user who is the primary owner of this close task.',
    `actual_close_date` DATE COMMENT 'The actual date on which the financial period close process was completed. Null if not yet completed.',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Indicates whether detailed audit trail logging is enabled for this close task (True) or not (False).',
    `blocking_issue` STRING COMMENT 'Description of any issue or exception that is preventing the close task from being completed on schedule. Null if no blocking issues exist.',
    `blocking_issue_severity` STRING COMMENT 'The severity level of the blocking issue: low (minor delay expected), medium (moderate impact), high (significant delay), or critical (close cannot proceed).. Valid values are `low|medium|high|critical`',
    `certification_timestamp` TIMESTAMP COMMENT 'The date and time when the financial period close was certified and approved by authorized finance leadership.',
    `close_completion_timestamp` TIMESTAMP COMMENT 'The date and time when the financial period close process was marked as completed. Null if not yet completed.',
    `close_start_timestamp` TIMESTAMP COMMENT 'The date and time when the financial period close process was initiated.',
    `close_status` STRING COMMENT 'Current status of the financial period close process: not started, in progress, blocked (awaiting resolution), completed (all tasks done), or certified (approved by finance leadership).. Valid values are `not_started|in_progress|blocked|completed|certified`',
    `close_task_type` STRING COMMENT 'The specific type of close task being tracked: accruals posting, depreciation run, intercompany reconciliation, foreign currency revaluation, tax provision calculation, or inventory valuation adjustment.. Valid values are `accruals_posting|depreciation_run|intercompany_reconciliation|foreign_currency_revaluation|tax_provision|inventory_valuation`',
    `close_type` STRING COMMENT 'The type of financial close being performed: month-end, quarter-end, year-end, or special close for ad-hoc reporting requirements.. Valid values are `month_end|quarter_end|year_end|special_close`',
    `consolidation_required_flag` BOOLEAN COMMENT 'Indicates whether this close requires consolidation of financial data across multiple legal entities or business units (True) or is a standalone entity close (False).',
    `country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code for the country in which this close is being performed.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this financial period close record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which financial amounts for this close are reported (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `ebitda_reporting_segment` STRING COMMENT 'The business segment or service line for which EBITDA is being calculated and reported as part of this close.',
    `geographic_region` STRING COMMENT 'The geographic region (e.g., North America, Europe, Asia Pacific) for which this close is being performed.',
    `ifrs_reporting_flag` BOOLEAN COMMENT 'Indicates whether this close is for IFRS-compliant financial reporting (True) or for local GAAP or other standards (False).',
    `intercompany_elimination_flag` BOOLEAN COMMENT 'Indicates whether intercompany transactions and balances need to be eliminated as part of this close (True) or not (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this financial period close record was last updated.',
    `lock_indicator` BOOLEAN COMMENT 'Indicates whether the financial period is locked for further postings (True) or still open for adjustments (False).',
    `lock_timestamp` TIMESTAMP COMMENT 'The date and time when the financial period was locked to prevent further postings. Null if period is not locked.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or documentation related to this financial period close.',
    `planned_close_date` DATE COMMENT 'The target date by which the financial period close process is scheduled to be completed.',
    `resolution_timestamp` TIMESTAMP COMMENT 'The date and time when the blocking issue was resolved, allowing the close task to proceed. Null if issue is unresolved or no issue exists.',
    `responsible_team` STRING COMMENT 'The name or identifier of the finance team responsible for executing this close task (e.g., General Accounting, Cost Accounting, Tax, Treasury).',
    `service_line` STRING COMMENT 'The specific service line or business division (e.g., Express Parcel Delivery, Freight Forwarding, Supply Chain Management) for which this close is being performed.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this close task is subject to SOX internal control requirements and audit trail documentation (True) or not (False).',
    `tax_jurisdiction_code` STRING COMMENT 'The code identifying the tax jurisdiction or authority under which tax provisions and filings are calculated for this close.',
    `variance_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which variances between planned and actual close results must be investigated and documented.',
    `variance_threshold_percentage` DECIMAL(18,2) COMMENT 'The percentage threshold above which variances between planned and actual close results must be investigated and documented.',
    CONSTRAINT pk_financial_period_close PRIMARY KEY(`financial_period_close_id`)
) COMMENT 'Transactional entity tracking the month-end, quarter-end, and year-end financial close process for Transport Shipping. Captures close task type (accruals posting, depreciation run, intercompany reconciliation, foreign currency revaluation, tax provision), responsible team, planned close date, actual completion date, close status, and blocking issues. Supports SOX-compliant financial close governance and audit trail.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`accrual` (
    `accrual_id` BIGINT COMMENT 'Unique identifier for the financial accrual record. Primary key for the accrual entity.',
    `employee_id` BIGINT COMMENT 'User ID of the approver who authorized the accrual posting. Null if not yet approved.',
    `accrual_created_by_user_employee_id` BIGINT COMMENT 'User ID of the person who created the accrual record.',
    `accrual_employee_id` BIGINT COMMENT 'User ID of the finance team member responsible for creating and managing this accrual entry.',
    `accrual_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person who last modified the accrual record.',
    `agreement_id` BIGINT COMMENT 'Reference to the customer or carrier contract governing the accrual terms. Null if not contract-based.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Month-end accruals for carrier freight charges not yet invoiced are standard logistics accounting practice. Required for accurate period-end financial reporting and matching freight costs to revenue p',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: accrual has gl_account_code as STRING but no FK to chart_of_accounts master. GL account is the core of accrual posting - every accrual must reference a valid GL account from the chart of accounts. Thi',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: accrual has company_code as STRING but no FK to company_code master. Legal entity context is essential for accrual accounting and financial reporting. Normalizing to FK enables proper company code mas',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment for which freight revenue or carrier cost is being accrued. Null for non-shipment accruals.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: accrual has cost_center_code as STRING but no FK to cost_center master. Cost center assignment is critical for accrual accounting and management reporting. Normalizing to FK ensures cost center codes ',
    `declaration_id` BIGINT COMMENT 'Reference to the customs declaration for which duty accrual is recorded. Applicable only to customs duty accruals.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: accrual has accrual_period as STRING but no FK to fiscal_period master. Fiscal period assignment is critical for period-end close, accrual reversal timing, and financial statement preparation. Normali',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Accruals can be posted against internal orders for project-specific cost recognition. Common in transport shipping for accruing costs on ongoing projects.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice that will settle this accrual upon final billing. Null if invoice not yet created.',
    `lease_contract_id` BIGINT COMMENT 'Reference to the lease contract for IFRS 16 lease liability accruals (e.g., warehouse, vehicle, equipment leases).',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: accrual has profit_center_code as STRING but no FK to profit_center master. Profit center is essential for P&L reporting and segment analysis of accruals. Normalizing to FK enables proper profit cente',
    `tax_account_id` BIGINT COMMENT 'Foreign key linking to finance.tax_account. Business justification: accrual has tax_jurisdiction_code (STRING) and tax_amount but no FK to tax_account master. Tax accruals must reference tax account master for proper tax accounting.',
    `accrual_description` STRING COMMENT 'Free-text description providing business context for the accrual entry, including reason, calculation basis, and supporting details.',
    `accrual_number` STRING COMMENT 'Business-facing unique document number for the accrual entry, used for audit trails and external references.. Valid values are `^ACR-[0-9]{8,12}$`',
    `accrual_status` STRING COMMENT 'Current lifecycle status of the accrual entry: draft (not yet posted), posted (active in GL), reversed (unwound), cancelled, or adjusted (modified after posting).. Valid values are `draft|posted|reversed|cancelled|adjusted`',
    `accrual_type` STRING COMMENT 'Classification of the accrual by business function: freight revenue accrual, carrier cost accrual, customs duty accrual, fuel surcharge accrual, lease accrual per IFRS 16, or warehouse expense accrual.. Valid values are `freight_revenue|carrier_cost|customs_duty|fuel_surcharge|lease_liability|warehouse_expense`',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the accrual in the transaction currency. Represents the revenue or expense amount being accrued for the period.',
    `approval_status` STRING COMMENT 'Workflow approval status for accruals requiring managerial or controller approval before posting.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the accrual was approved for posting. Null if not yet approved.',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Indicates whether detailed change history and audit logging is enabled for this accrual record.',
    `basis` STRING COMMENT 'Method used to calculate the accrual: time-based (pro-rata over period), event-based (triggered by milestone), percentage of completion, straight-line, or usage-based.. Valid values are `time_based|event_based|percentage_of_completion|straight_line|usage_based`',
    `business_area_code` STRING COMMENT 'Business area classification for cross-company segment reporting (e.g., express parcel, freight forwarding, contract logistics).. Valid values are `^BA-[A-Z0-9]{2,6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the accrual record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the accrual amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'Business date of the accrual transaction, which may differ from the posting date. Used for audit and reconciliation.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert transaction currency to functional currency at the time of accrual posting.',
    `functional_area_code` STRING COMMENT 'Functional area for cost-of-sales accounting and functional P&L reporting (e.g., operations, sales, administration).. Valid values are `^FA-[A-Z0-9]{2,6}$`',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Accrual amount converted to the company code functional currency for consolidated reporting and P&L aggregation.',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this accrual represents an intercompany transaction requiring elimination during consolidation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the accrual record was last updated or adjusted.',
    `notes` STRING COMMENT 'Additional free-text notes or comments for internal use, audit documentation, or special instructions.',
    `posting_date` DATE COMMENT 'Date on which the accrual entry was posted to the general ledger. Determines the fiscal period assignment.',
    `reference_document_number` STRING COMMENT 'External reference number linking the accrual to source documents such as AWB, BOL, purchase order, or customs entry.',
    `reversal_date` DATE COMMENT 'Scheduled date for automatic reversal of the accrual entry, typically the first day of the following accounting period.',
    `reversal_posting_date` DATE COMMENT 'Actual date on which the accrual reversal was posted to the general ledger. Null if not yet reversed.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this accrual is subject to SOX internal control testing and audit requirements.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the accrual amount, if applicable (e.g., VAT on accrued freight revenue).',
    CONSTRAINT pk_accrual PRIMARY KEY(`accrual_id`)
) COMMENT 'Transactional entity managing financial accruals and deferrals for Transport Shipping. Captures accrual type (freight revenue accrual, carrier cost accrual, customs duty accrual, fuel surcharge accrual, lease accrual per IFRS 16), accrual amount, accrual basis, reversal date, GL account, cost center, and posting status. Ensures accurate period-end P&L matching of revenues and expenses.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`currency_rate` (
    `currency_rate_id` BIGINT COMMENT 'Unique identifier for the currency exchange rate record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Reference to the company code for which this exchange rate is applicable. Supports company-specific rate management when different legal entities use different rate sources or rate types.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: currency_rate has fiscal_year (INT) and fiscal_period_number (INT) but no FK to fiscal_period master. Exchange rates are period-specific for financial reporting and should reference master fiscal cale',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this exchange rate for use. Null if approval is not required or rate is pending approval. Supports SOX compliance and audit trail requirements.',
    `tertiary_currency_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this exchange rate record. For automated updates, this may reference a system service account. Supports audit trail and change tracking.',
    `approval_required_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this exchange rate requires formal approval before activation. True indicates approval workflow is required, false indicates automatic activation is permitted.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this exchange rate was formally approved for use. Null if approval is not required or rate is pending approval. Supports audit trail and compliance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this exchange rate record was first created in the system. Supports audit trail and data lineage tracking.',
    `effective_rate_with_spread` DECIMAL(18,2) COMMENT 'The final exchange rate after applying the rate_spread_percentage to the base rate_value. This is the rate used for customer billing and revenue recognition when spreads are applied. Null if no spread is applicable.',
    `exchange_rate_type` STRING COMMENT 'Classification of the exchange rate indicating its purpose and calculation method. Spot rates are real-time market rates, average rates are period averages, closing rates are end-of-period rates, budget rates are planning rates, forecast rates are projected rates, and historical rates are archived past rates.. Valid values are `spot|average|closing|budget|forecast|historical`',
    `from_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the base currency in the exchange rate pair (e.g., USD, EUR, GBP). The currency being converted from.. Valid values are `^[A-Z]{3}$`',
    `hedge_contract_reference` STRING COMMENT 'External reference number or identifier of the foreign exchange hedging contract or forward contract from which this rate is derived. Null if hedging_rate_flag is false. Supports hedge accounting and IFRS 9 compliance.',
    `hedging_rate_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this exchange rate is derived from a foreign exchange hedging contract or forward contract. True indicates hedged rate, false indicates spot or market rate.',
    `ifrs_reporting_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this exchange rate is used for IFRS financial statement consolidation and foreign currency translation. True indicates IFRS reporting use, false indicates operational or management reporting use.',
    `intercompany_rate_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this exchange rate is used for intercompany settlements and transfer pricing between Transport Shipping legal entities. True indicates intercompany use, false indicates external customer/vendor use.',
    `inverse_rate_value` DECIMAL(18,2) COMMENT 'The reciprocal exchange rate value (1 / rate_value) representing the reverse currency pair conversion. If USD to EUR is 0.85, the inverse EUR to USD is 1.176471. Stored for performance optimization in bidirectional conversions.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this exchange rate record was last updated or refreshed from the rate source. Supports audit trail and data freshness monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or context about this exchange rate. May include reasons for manual rate entry, special circumstances, or regulatory justifications.',
    `rate_determination_method` STRING COMMENT 'The method by which the exchange rate was determined. Market rates are from external sources, fixed rates are contractually agreed, negotiated rates are customer-specific, and regulatory rates are mandated by government authorities.. Valid values are `market|fixed|negotiated|regulatory`',
    `rate_source` STRING COMMENT 'The authoritative source from which the exchange rate was obtained. ECB (European Central Bank), Reuters, Bloomberg, OANDA, and XE are external market data providers. Manual indicates rates entered by finance staff. System indicates rates calculated or derived by internal systems. [ENUM-REF-CANDIDATE: ECB|Reuters|Bloomberg|OANDA|XE|Manual|System — 7 candidates stripped; promote to reference product]',
    `rate_source_reference` STRING COMMENT 'External reference identifier or transaction ID from the rate source system, enabling traceability and audit of the rate origin. May contain feed IDs, API transaction references, or manual entry batch numbers.',
    `rate_spread_percentage` DECIMAL(18,2) COMMENT 'The percentage markup or spread applied to the base market rate for internal pricing or margin calculation. Used when Transport Shipping applies a margin to customer-facing currency conversions. Null indicates no spread applied.',
    `rate_status` STRING COMMENT 'Current lifecycle status of the exchange rate record. Active rates are in use, inactive rates are disabled, superseded rates have been replaced by newer rates, pending rates await approval, and expired rates are past their valid_to_date.. Valid values are `active|inactive|superseded|pending|expired`',
    `rate_update_frequency` STRING COMMENT 'The frequency at which this exchange rate type is refreshed or updated from the rate source. Real-time rates update continuously, daily rates update once per business day, and on-demand rates are manually triggered. [ENUM-REF-CANDIDATE: real-time|daily|weekly|monthly|quarterly|annual|on-demand — 7 candidates stripped; promote to reference product]',
    `rate_value` DECIMAL(18,2) COMMENT 'The numerical exchange rate value representing how many units of the to_currency are equivalent to one unit of the from_currency. For example, if USD to EUR rate is 0.85, then 1 USD = 0.85 EUR. Precision of 6 decimal places supports accurate currency conversion.',
    `rate_volatility_indicator` STRING COMMENT 'Classification of the currency pairs historical volatility level. Low volatility indicates stable currency pairs (e.g., USD/EUR), high volatility indicates emerging market or commodity-linked currencies. Used for risk management and hedging decisions.. Valid values are `low|medium|high`',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this exchange rate is subject to SOX financial controls and audit requirements. True indicates SOX-controlled rate requiring enhanced audit trail and approval workflows.',
    `to_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the quote currency in the exchange rate pair (e.g., USD, EUR, GBP). The currency being converted to.. Valid values are `^[A-Z]{3}$`',
    `valid_from_date` DATE COMMENT 'The date from which this exchange rate becomes effective and can be used for currency conversions. Supports temporal validity and historical rate tracking.',
    `valid_to_date` DATE COMMENT 'The date until which this exchange rate remains effective. Null indicates the rate is currently active with no defined end date. Supports temporal validity and rate expiration management.',
    CONSTRAINT pk_currency_rate PRIMARY KEY(`currency_rate_id`)
) COMMENT 'Reference entity storing foreign exchange rates used for multi-currency financial transactions across Transport Shippings global operations. Captures currency pair, exchange rate type (spot, average, closing), valid-from date, rate source (ECB, Reuters), and rate value. Supports multi-currency freight invoicing, intercompany settlements, and IFRS foreign currency translation for consolidated financial statements.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`financial_statement` (
    `financial_statement_id` BIGINT COMMENT 'Unique identifier for the financial statement record. Primary key for the financial statement entity.',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity or company code for which this financial statement is prepared. Links to the company_code master data.',
    `fiscal_period_id` BIGINT COMMENT 'Reference to the fiscal period master data defining the reporting period, quarter, and year-end close status.',
    `employee_id` BIGINT COMMENT 'Reference to the user or officer who approved this financial statement for publication, typically the Chief Financial Officer (CFO) or Controller.',
    `prior_statement_financial_statement_id` BIGINT COMMENT 'Reference to the previous version of this financial statement if this is a restatement or superseding version. Links to the financial_statement_id of the superseded statement.',
    `quaternary_financial_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this financial statement record in the system. Audit trail field for SOX compliance.',
    `quinary_financial_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this financial statement record. Audit trail field for SOX compliance.',
    `tertiary_financial_reviewed_by_user_employee_id` BIGINT COMMENT 'Reference to the user or manager who reviewed this financial statement before approval.',
    `approval_date` DATE COMMENT 'Date on which this financial statement was approved by the board of directors or authorized management for publication.',
    `audit_opinion_date` DATE COMMENT 'Date on which the external auditor issued their audit opinion on this financial statement. Represents the auditor sign-off date.',
    `audit_report_reference` STRING COMMENT 'Reference number or document identifier for the external auditors audit report corresponding to this financial statement.',
    `audit_status` STRING COMMENT 'External audit status of the financial statement. Unaudited indicates no external audit performed; under audit indicates audit in progress; audited indicates clean audit opinion; qualified, adverse, or disclaimer opinions indicate audit exceptions or limitations.. Valid values are `unaudited|under_audit|audited|qualified_opinion|adverse_opinion|disclaimer_of_opinion`',
    `comparative_period_flag` BOOLEAN COMMENT 'Indicates whether this financial statement includes comparative figures from prior periods as required by IFRS IAS 1.',
    `consolidation_group_code` STRING COMMENT 'Code identifying the consolidation group or legal entity group to which this statement belongs, used for group-level financial reporting and intercompany eliminations.',
    `consolidation_scope` STRING COMMENT 'Scope of consolidation for this financial statement. Legal entity represents a single company code; consolidated group represents parent and all subsidiaries; business unit or segment represents a sub-group for management reporting.. Valid values are `legal_entity|consolidated_group|business_unit|segment`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this financial statement record was first created in the system. Audit trail field for SOX compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which this financial statement is presented (e.g., USD, EUR, GBP). All monetary amounts in the statement are expressed in this currency.. Valid values are `^[A-Z]{3}$`',
    `document_url` STRING COMMENT 'URL or file path to the published financial statement document (PDF, XBRL, or other format) stored in the document management system.',
    `ebitda_reporting_segment` STRING COMMENT 'Business segment or service line for which EBITDA is reported in this financial statement (e.g., Express Parcel, Freight Forwarding, Supply Chain Management).',
    `external_auditor_name` STRING COMMENT 'Name of the external audit firm that audited this financial statement (e.g., Deloitte, PwC, EY, KPMG). Required for audited statements under SOX and IFRS.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this financial statement belongs, following the companys fiscal calendar (e.g., 2024).',
    `ifrs_reporting_flag` BOOLEAN COMMENT 'Indicates whether this financial statement is prepared under IFRS standards. True for entities required to report under IFRS.',
    `intercompany_elimination_flag` BOOLEAN COMMENT 'Indicates whether intercompany transactions and balances have been eliminated in this consolidated financial statement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this financial statement record was last modified. Audit trail field for SOX compliance.',
    `lock_indicator` BOOLEAN COMMENT 'Indicates whether this financial statement is locked for editing. True when the statement is finalized and published, preventing further modifications.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this financial statement, used for internal documentation and audit trail purposes.',
    `notes_reference` STRING COMMENT 'Reference or link to the accompanying notes to financial statements that provide detailed disclosures and explanations.',
    `presentation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code used for presentation purposes if different from the functional currency. Used when statements are translated for group consolidation.. Valid values are `^[A-Z]{3}$`',
    `publication_date` DATE COMMENT 'Date on which this financial statement was officially published or released to external stakeholders, regulators, or the public.',
    `regulatory_filing_flag` BOOLEAN COMMENT 'Indicates whether this financial statement is filed with regulatory authorities (e.g., SEC, local securities commissions, tax authorities).',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier for the regulatory filing submission (e.g., SEC EDGAR accession number, tax filing reference).',
    `reporting_period_end_date` DATE COMMENT 'End date of the financial reporting period covered by this statement. Defines the close of the period for which financial performance or position is reported.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the financial reporting period covered by this statement. Defines the beginning of the period for which financial performance or position is reported.',
    `reporting_standard` STRING COMMENT 'Accounting standard framework under which this financial statement is prepared. IFRS (International Financial Reporting Standards) is the global standard; US GAAP applies to US entities; local GAAP and statutory standards apply per jurisdiction.. Valid values are `IFRS|US_GAAP|local_GAAP|statutory`',
    `restatement_flag` BOOLEAN COMMENT 'Indicates whether this financial statement is a restatement of a previously published statement due to error correction or accounting policy change.',
    `restatement_reason` STRING COMMENT 'Explanation of the reason for restatement if restatement_flag is true. Describes the nature of the error or accounting policy change that necessitated the restatement.',
    `segment_reporting_flag` BOOLEAN COMMENT 'Indicates whether this financial statement includes segment reporting disclosures as required by IFRS 8 for operating segments.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this financial statement is subject to SOX internal control requirements and audit trails. True for US public companies and their subsidiaries.',
    `statement_number` STRING COMMENT 'Externally-known unique business identifier for the financial statement, used for reference in audit trails, regulatory filings, and external communications.',
    `statement_status` STRING COMMENT 'Current lifecycle status of the financial statement. Draft indicates work in progress; preliminary indicates management review; final indicates approved for publication; published indicates externally released; restated indicates corrected after initial publication; superseded indicates replaced by a newer version.. Valid values are `draft|preliminary|final|published|restated|superseded`',
    `statement_type` STRING COMMENT 'Type of financial statement being published. Income statement (Profit and Loss / P&L) shows revenue and expenses; balance sheet shows assets, liabilities, and equity; cash flow statement shows cash inflows and outflows; statement of changes in equity shows movements in equity accounts; notes provide supplementary disclosures.. Valid values are `income_statement|balance_sheet|cash_flow_statement|statement_of_changes_in_equity|notes_to_financial_statements`',
    `version_number` STRING COMMENT 'Version number of this financial statement, incremented for each revision or restatement. Version 1 is the original publication.',
    `xbrl_instance_document` STRING COMMENT 'Reference to the XBRL instance document for this financial statement, used for structured regulatory filings.',
    CONSTRAINT pk_financial_statement PRIMARY KEY(`financial_statement_id`)
) COMMENT 'Master entity representing published financial statements for Transport Shipping legal entities and consolidated group. Captures statement type (income statement/P&L, balance sheet, cash flow statement, statement of changes in equity), reporting period, reporting standard (IFRS), consolidation scope, audit status (unaudited, audited, restated), and external auditor sign-off reference. Supports SOX and IFRS regulatory reporting.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` (
    `finance_audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Identifier of the general ledger account affected by the audit finding, if the finding relates to a specific account or transaction type.',
    `company_code_id` BIGINT COMMENT 'Identifier of the legal entity or company code where the audit finding was identified.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center associated with the affected process area or control deficiency.',
    `financial_control_id` BIGINT COMMENT 'Unique identifier of the specific internal control that failed or is deficient, referencing the organizations control framework documentation.',
    `fiscal_period_id` BIGINT COMMENT 'Identifier of the fiscal period during which the audit finding was identified.',
    `previous_finding_finance_audit_finding_id` BIGINT COMMENT 'Identifier of the previous audit finding if this is a repeat finding, linking to the original occurrence.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or manager responsible for executing the remediation plan and ensuring the finding is resolved.',
    `profit_center_id` BIGINT COMMENT 'Identifier of the profit center associated with the affected process area or control deficiency.',
    `quaternary_finance_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the audit finding record.',
    `tertiary_finance_created_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who created the audit finding record in the system.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Audit findings cite specific transport documents (AWB, BOL, CMR) as evidence of control deficiencies—missing documentation, unauthorized changes, compliance violations. Essential for audit evidence tr',
    `version_id` BIGINT COMMENT 'Foreign key linking to document.document_version. Business justification: Audit findings reference specific document versions to demonstrate version control failures, unauthorized amendments, or backdating. Critical for change control validation, audit evidence, and demonst',
    `affected_process_area` STRING COMMENT 'Business process or functional area affected by the audit finding (e.g., Revenue Recognition, Accounts Payable, Freight Billing, Customs Compliance, Payroll Processing, Fixed Asset Management).',
    `audit_period_end_date` DATE COMMENT 'End date of the audit period during which the finding was identified.',
    `audit_period_start_date` DATE COMMENT 'Start date of the audit period during which the finding was identified.',
    `audit_type` STRING COMMENT 'Type of audit during which the finding was identified. SOX compliance audits focus on internal controls over financial reporting; internal audits are conducted by internal audit team; external audits by independent auditors; regulatory audits by government agencies; operational audits assess process efficiency; financial audits verify financial statements; IT audits assess technology controls. [ENUM-REF-CANDIDATE: sox_compliance|internal_audit|external_audit|regulatory_audit|operational_audit|financial_audit|it_audit — 7 candidates stripped; promote to reference product]',
    `auditor_name` STRING COMMENT 'Name of the auditor or audit firm that identified the finding (e.g., internal auditor name or external audit firm name).',
    `auditor_type` STRING COMMENT 'Classification of the auditor who identified the finding. Internal auditors are employees; external auditors are independent third-party firms; regulatory auditors are government or industry body representatives.. Valid values are `internal|external|regulatory`',
    `control_name` STRING COMMENT 'Name or description of the internal control that is deficient or failed.',
    `control_objective` STRING COMMENT 'The intended purpose or objective of the control that was not achieved, describing what the control was designed to prevent or detect.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit finding record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether the finding must be disclosed in external financial reporting or regulatory filings (e.g., material weakness disclosure in 10-K). True if disclosure required; false otherwise.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the finding in the companys reporting currency, representing potential or actual loss, misstatement, or exposure.',
    `finding_description` STRING COMMENT 'Detailed narrative description of the audit finding, including what was observed, the nature of the deficiency, and why it represents a control weakness or compliance issue.',
    `finding_number` STRING COMMENT 'Externally-known unique business identifier for the audit finding, typically formatted as audit-type prefix, year, and sequence number (e.g., SOX-2024-00123, INT-2024-00045).. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{3,5}$`',
    `finding_status` STRING COMMENT 'Current lifecycle status of the audit finding. Open indicates newly identified; in remediation indicates corrective action underway; pending validation indicates awaiting auditor verification; closed indicates resolved and verified; deferred indicates postponed remediation; accepted risk indicates management has formally accepted the risk without remediation.. Valid values are `open|in_remediation|pending_validation|closed|deferred|accepted_risk`',
    `finding_type` STRING COMMENT 'Classification of the audit finding severity and nature. Material weakness indicates a deficiency that could result in material misstatement; significant deficiency is less severe but still important; control gap indicates missing or inadequate controls; observation is informational; best practice opportunity suggests improvement; compliance violation indicates regulatory breach.. Valid values are `material_weakness|significant_deficiency|control_gap|observation|best_practice_opportunity|compliance_violation`',
    `fiscal_year` STRING COMMENT 'Fiscal year during which the audit finding was identified.',
    `identified_date` DATE COMMENT 'Date when the audit finding was first identified and documented by the auditor.',
    `impact_rating` STRING COMMENT 'Assessment of the potential financial or operational impact if the control deficiency is exploited or results in an error.. Valid values are `catastrophic|major|moderate|minor|negligible`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit finding record was last updated or modified.',
    `likelihood_rating` STRING COMMENT 'Assessment of the likelihood that the control deficiency will result in a material misstatement or loss.. Valid values are `very_likely|likely|possible|unlikely|rare`',
    `management_response` STRING COMMENT 'Managements formal response to the audit finding, including agreement or disagreement with the finding and planned corrective actions.',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or context related to the audit finding, remediation progress, or validation.',
    `recommendation` STRING COMMENT 'Auditors recommended corrective action or remediation steps to address the finding and strengthen the control environment.',
    `remediation_completed_date` DATE COMMENT 'Actual date when remediation activities were completed and the control deficiency was addressed.',
    `remediation_due_date` DATE COMMENT 'Target date by which the remediation plan must be completed and the finding resolved.',
    `remediation_owner_name` STRING COMMENT 'Full name of the employee or manager responsible for remediation.',
    `remediation_plan` STRING COMMENT 'Detailed plan outlining the specific actions, milestones, and resources required to remediate the finding and restore effective control.',
    `repeat_finding_flag` BOOLEAN COMMENT 'Indicates whether this finding is a repeat of a previously identified and supposedly remediated issue. True if repeat; false if new finding.',
    `reported_date` DATE COMMENT 'Date when the audit finding was formally reported to management or audit committee.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the finding based on likelihood and impact assessment. Critical indicates immediate threat to financial reporting integrity; high indicates significant risk; medium indicates moderate risk; low indicates minor risk.. Valid values are `critical|high|medium|low`',
    `root_cause_analysis` STRING COMMENT 'Analysis of the underlying root cause(s) of the control deficiency, identifying systemic issues, process gaps, resource constraints, or other factors that led to the finding.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether the finding relates to a SOX-relevant internal control over financial reporting. True if SOX-relevant; false otherwise.',
    `validation_date` DATE COMMENT 'Date when the auditor or internal control team validated that the remediation was effective and the finding can be closed.',
    CONSTRAINT pk_finance_audit_finding PRIMARY KEY(`finance_audit_finding_id`)
) COMMENT 'Transactional entity recording internal and external audit findings, SOX control deficiencies, and financial control exceptions identified during audits of Transport Shippings financial processes. Captures finding type (material weakness, significant deficiency, control gap), affected process area, risk rating, remediation owner, remediation due date, and finding status. Supports SOX Section 302/404 compliance and external auditor management.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`internal_order` (
    `internal_order_id` BIGINT COMMENT 'Unique identifier for the internal order. Primary key for the internal order entity.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Internal orders for capital investments are linked to CAPEX projects. The internal_order has capex_flag and asset_under_construction_number suggesting CAPEX linkage.',
    `company_code_id` BIGINT COMMENT 'Reference to the company code that owns this internal order. Determines legal entity and chart of accounts.',
    `controlling_area_id` BIGINT COMMENT 'Reference to the controlling area for cost accounting and internal reporting purposes.',
    `cost_center_id` BIGINT COMMENT 'Reference to the responsible cost center that manages this internal order. Used for organizational assignment and reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or manager responsible for this internal order and its budget execution.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center for EBITDA reporting and segment analysis. Optional depending on order type.',
    `tertiary_internal_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person who last modified this internal order record.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element if this internal order is part of a larger project structure.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Total actual costs posted to this internal order to date. Updated in real-time as costs are incurred.',
    `asset_under_construction_number` STRING COMMENT 'Asset number for CAPEX orders where costs are accumulated before capitalization as a fixed asset.',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Indicates whether detailed change history and audit logging is enabled for this internal order.',
    `available_budget_amount` DECIMAL(18,2) COMMENT 'Remaining budget available for spending. Calculated as budget minus actual minus committed costs.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget amount allocated to this internal order for cost control and variance analysis.',
    `budget_control_active_flag` BOOLEAN COMMENT 'Indicates whether budget availability checking is enforced for this internal order. When true, postings exceeding budget are blocked.',
    `business_area_code` STRING COMMENT 'Code identifying the business area or division for segment reporting purposes.',
    `capex_flag` BOOLEAN COMMENT 'Indicates whether this internal order tracks capital expenditure that will be capitalized as an asset.',
    `committed_cost_amount` DECIMAL(18,2) COMMENT 'Total committed costs (purchase orders, reservations) against this internal order that have not yet been invoiced.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this internal order record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for budget and cost tracking on this internal order.. Valid values are `^[A-Z]{3}$`',
    `final_settlement_date` DATE COMMENT 'Date when the internal order costs were finally settled to receiving cost objects and the order was closed.',
    `functional_area_code` STRING COMMENT 'Code identifying the functional area (operations, sales, administration) for cost classification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this internal order record was last updated.',
    `lock_indicator` BOOLEAN COMMENT 'Indicates whether this internal order is locked for further postings or changes. Used during period-end close.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, instructions, or context about this internal order.',
    `opex_flag` BOOLEAN COMMENT 'Indicates whether this internal order tracks operating expenditure that will be expensed in the current period.',
    `order_category` STRING COMMENT 'High-level categorization of the internal order for financial reporting and cost allocation purposes.. Valid values are `overhead|investment|accrual|revenue`',
    `order_description` STRING COMMENT 'Detailed business description of the internal order purpose, scope, and objectives.',
    `order_end_date` DATE COMMENT 'Planned or actual end date of the internal order activities. After this date, the order should be settled and closed.',
    `order_number` STRING COMMENT 'Business identifier for the internal order used in SAP and external reporting. Externally-known unique code for tracking and reference.. Valid values are `^[A-Z0-9]{10,12}$`',
    `order_short_text` STRING COMMENT 'Brief descriptive text for the internal order used in reports and transaction displays.',
    `order_start_date` DATE COMMENT 'Planned or actual start date of the internal order activities. Defines the beginning of the cost collection period.',
    `order_status` STRING COMMENT 'Current lifecycle status of the internal order. Controls whether costs can be posted and whether settlement is allowed.. Valid values are `created|released|technically_completed|closed|locked`',
    `order_type` STRING COMMENT 'Classification of the internal order indicating its business purpose. Determines cost tracking rules and settlement behavior.. Valid values are `capex_project|opex_project|marketing_campaign|fleet_overhaul|warehouse_expansion|maintenance_activity`',
    `planning_integrated_flag` BOOLEAN COMMENT 'Indicates whether this internal order is integrated with SAP planning and budgeting processes.',
    `settlement_receiver_reference` STRING COMMENT 'Identifier of the specific cost object (asset number, cost center code, GL account) that receives settled costs.',
    `settlement_receiver_type` STRING COMMENT 'Type of cost object that receives settled costs from this internal order.. Valid values are `asset|cost_center|gl_account|wbs_element|sales_order`',
    `settlement_rule_type` STRING COMMENT 'Method used to settle costs from this internal order to receiving cost objects such as assets, cost centers, or general ledger accounts.. Valid values are `full_settlement|percentage_settlement|equivalence_number|periodic_settlement`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this internal order is subject to SOX financial controls and audit trail requirements.',
    `statistical_order_flag` BOOLEAN COMMENT 'Indicates whether this is a statistical internal order used for informational tracking only without actual cost postings.',
    `technical_completion_date` DATE COMMENT 'Date when the internal order was marked as technically complete. No further primary costs should be posted after this date.',
    CONSTRAINT pk_internal_order PRIMARY KEY(`internal_order_id`)
) COMMENT 'Master entity for SAP internal orders used to track costs for specific projects, capital investments, and temporary cost collection objects within Transport Shipping. Captures internal order type (CAPEX project, marketing campaign, fleet overhaul, warehouse expansion), budget, actual costs, settlement rule, and order status. Enables granular cost tracking below cost center level. Sourced from SAP S/4HANA Finance CO-OPA module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the bank account record. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the general ledger account in the chart of accounts that this bank account is mapped to for financial reporting.',
    `company_code_id` BIGINT COMMENT 'Reference to the company code that owns and operates this bank account within the Transport Shipping organizational structure.',
    `created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this bank account record in the system.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or treasury manager responsible for managing and overseeing this bank account.',
    `house_bank_id` BIGINT COMMENT 'Internal identifier for the house bank configuration in the ERP system, linking this account to payment processing and cash management workflows.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this bank account record.',
    `account_holder_name` STRING COMMENT 'The legal name of the entity or person who holds the bank account, typically the company legal entity name.',
    `account_name` STRING COMMENT 'The official name or title of the bank account as registered with the financial institution.',
    `account_number` STRING COMMENT 'The full bank account number assigned by the financial institution. May be masked for security purposes in operational systems.',
    `account_number_masked` STRING COMMENT 'Partially masked account number for display purposes, showing only last 4 digits (e.g., ****1234).',
    `account_purpose` STRING COMMENT 'Detailed description of the specific business purpose or use case for this bank account within Transport Shipping operations.',
    `account_status` STRING COMMENT 'Current operational status of the bank account indicating whether it is available for transactions.. Valid values are `active|inactive|closed|suspended|pending`',
    `account_type` STRING COMMENT 'Classification of the bank account based on its business purpose (operating for daily transactions, payroll for employee payments, escrow for held funds, tax for tax payments, investment for treasury management, reserve for contingency funds).. Valid values are `operating|payroll|escrow|tax|investment|reserve`',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Indicates whether detailed audit logging is enabled for all transactions and changes to this bank account.',
    `balance_amount` DECIMAL(18,2) COMMENT 'The current available balance in the bank account as of the last reconciliation or statement date, in the account currency.',
    `bank_address_line_1` STRING COMMENT 'First line of the bank branch physical address.',
    `bank_address_line_2` STRING COMMENT 'Second line of the bank branch physical address.',
    `bank_branch_name` STRING COMMENT 'The name of the specific bank branch where the account is held.',
    `bank_city` STRING COMMENT 'City where the bank branch is located.',
    `bank_code` STRING COMMENT 'The unique identifier code for the bank, format varies by country (e.g., routing number in US, sort code in UK, bank code in Germany).',
    `bank_name` STRING COMMENT 'The legal name of the financial institution holding the account.',
    `bank_postal_code` STRING COMMENT 'Postal or ZIP code of the bank branch location.',
    `bank_state_province` STRING COMMENT 'State or province where the bank branch is located.',
    `branch_code` STRING COMMENT 'The code identifying the specific branch of the bank.',
    `carrier_payment_flag` BOOLEAN COMMENT 'Indicates whether this account is designated for making payments to freight carriers and transportation providers.',
    `cash_pool_group` STRING COMMENT 'Identifier for the cash pooling arrangement this account belongs to, used for centralized treasury and liquidity management across multiple accounts or entities.',
    `closed_date` DATE COMMENT 'The date when the bank account was officially closed, if applicable.',
    `collection_method_enabled` STRING COMMENT 'Primary collection method supported by this bank account for incoming payments (wire, ACH, SEPA, lockbox, EFT, direct debit).. Valid values are `wire|ach|sepa|lockbox|eft|direct_debit`',
    `country_code` STRING COMMENT 'Three-letter ISO country code indicating the country where the bank account is domiciled.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO currency code representing the primary currency of the bank account (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_collection_flag` BOOLEAN COMMENT 'Indicates whether this account is designated for receiving customer payments and collections.',
    `iban` STRING COMMENT 'The internationally standardized bank account number used for cross-border payments, particularly in Europe and other SEPA regions.',
    `intercompany_transfer_flag` BOOLEAN COMMENT 'Indicates whether this account is used for intercompany fund transfers between Transport Shipping legal entities.',
    `interest_rate_percentage` DECIMAL(18,2) COMMENT 'The annual interest rate applied to the account balance, expressed as a decimal percentage (e.g., 0.0250 for 2.5%).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this bank account record was last updated or modified.',
    `last_reconciliation_date` DATE COMMENT 'The date of the most recent bank reconciliation performed for this account.',
    `minimum_balance_amount` DECIMAL(18,2) COMMENT 'The minimum balance required to be maintained in the account per bank agreement or internal treasury policy.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the bank account.',
    `opened_date` DATE COMMENT 'The date when the bank account was originally opened with the financial institution.',
    `overdraft_limit_amount` DECIMAL(18,2) COMMENT 'The maximum overdraft or credit facility limit available on this account, if applicable.',
    `payment_method_enabled` STRING COMMENT 'Primary payment method supported by this bank account for outgoing payments (wire transfer, ACH, SEPA, check, EFT, RTGS).. Valid values are `wire|ach|sepa|check|eft|rtgs`',
    `reconciliation_required_flag` BOOLEAN COMMENT 'Indicates whether this account requires regular bank reconciliation processes to match bank statements with internal records.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this bank account is subject to SOX internal control requirements and audit procedures.',
    `swift_bic_code` STRING COMMENT 'The unique identification code for the bank used in international wire transfers and SWIFT messaging. Format: 8 or 11 alphanumeric characters.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `valid_from_date` DATE COMMENT 'The date from which this bank account record became active and valid for use in operations.',
    `valid_to_date` DATE COMMENT 'The date until which this bank account record is valid. Null indicates the account is currently active with no planned end date.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Master entity for Transport Shippings corporate bank accounts used for operational cash management, carrier payments, customer collections, and intercompany transfers. Captures bank name, account number (masked), IBAN, SWIFT/BIC, currency, account type (operating, payroll, escrow), company code assignment, and cash pool group. Supports treasury cash management and payment processing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` (
    `bank_statement_line_id` BIGINT COMMENT 'Unique identifier for the bank statement line item. Primary key for this entity.',
    `bank_account_id` BIGINT COMMENT 'Reference to the specific bank account for this transaction. Links to the master bank account configuration in the financial system.',
    `bank_statement_id` BIGINT COMMENT 'Reference to the parent bank statement header containing this line item. Links to the overall statement document received from the bank.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the GL account used for posting this bank transaction. Links the cash movement to the chart of accounts for financial reporting.',
    `company_code_id` BIGINT COMMENT 'Reference to the company code that owns the bank account for this transaction. Used for multi-entity financial consolidation and reporting.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center assigned to this transaction for internal cost allocation. Used for OPEX (Operating Expenditure) tracking and management reporting.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: bank_statement_line has fiscal_year (INT) and fiscal_period (INT) but no FK to fiscal_period master. Bank statement lines are reconciled to fiscal periods and should reference master calendar.',
    `house_bank_id` BIGINT COMMENT 'Reference to the house bank (Transport Shippings banking partner) where the account is held. Identifies the financial institution managing the account.',
    `employee_id` BIGINT COMMENT 'User ID of the person or system process that created the record. Required for SOX compliance and audit trail.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center for P&L and EBITDA (Earnings Before Interest Taxes Depreciation and Amortization) reporting. Enables segment-level financial analysis.',
    `tax_account_id` BIGINT COMMENT 'Foreign key linking to finance.tax_account. Business justification: bank_statement_line has tax_code (STRING) and tax_amount but no FK to tax_account master. Bank transactions with tax implications must reference tax account master.',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Indicates whether detailed audit logging is enabled for this transaction. Required for regulatory compliance and forensic analysis.',
    `bank_charges` DECIMAL(18,2) COMMENT 'Fees charged by the bank for processing the transaction. Tracked separately for expense analysis and bank fee reconciliation.',
    `bank_transaction_code` STRING COMMENT 'Bank-specific code identifying the type of transaction (e.g., wire transfer, check, direct debit, card payment). Used for automated transaction classification.',
    `business_area_code` STRING COMMENT 'Code identifying the business area or division for this transaction. Used for cross-company code financial reporting and consolidation.',
    `clearing_date` DATE COMMENT 'Date when the bank statement line was reconciled and cleared in the financial system. Critical for audit trail and SOX (Sarbanes-Oxley Act) compliance.',
    `clearing_document_number` STRING COMMENT 'GL document number created when the bank statement line was cleared against open items. Links the bank transaction to the financial posting.',
    `counterparty_account_number` STRING COMMENT 'Bank account number of the counterparty. Used for payment verification and fraud detection. Business-confidential financial information.',
    `counterparty_bank_code` STRING COMMENT 'Bank identifier code (BIC/SWIFT) for the counterpartys financial institution. Used for international payment tracking and reconciliation.',
    `counterparty_name` STRING COMMENT 'Name of the external party involved in the transaction (customer, vendor, or other entity). Used for matching against Accounts Payable (AP) and Accounts Receivable (AR) records.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the bank statement line record was first created in SAP S/4HANA Finance. Audit field for data lineage and compliance.',
    `customer_reference` STRING COMMENT 'Customer account number or identifier extracted from payment reference. Used for matching receipts to customer accounts in AR.',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether the transaction is a debit (outflow) or credit (inflow) to the bank account. Essential for cash flow analysis and reconciliation.. Valid values are `debit|credit`',
    `exception_reason_code` STRING COMMENT 'Code identifying the reason for reconciliation exception or manual review. Enables root cause analysis of reconciliation issues.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert transaction currency to local currency. Critical for multi-currency financial consolidation and reporting.',
    `internal_notes` STRING COMMENT 'Free-text notes added by finance team during reconciliation. Used for documenting manual adjustments, exceptions, and resolution details.',
    `invoice_reference_number` STRING COMMENT 'Invoice number extracted from payment reference or remittance advice. Used for automated AR/AP reconciliation and clearing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the bank statement line record was last updated. Critical for change tracking and audit compliance.',
    `line_item_number` STRING COMMENT 'Sequential line number within the bank statement. Used for ordering and referencing individual transactions within the statement.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Transaction amount converted to the company codes local currency for financial reporting. Used for GL posting and P&L (Profit and Loss) reporting.',
    `local_currency_code` STRING COMMENT 'Three-letter ISO currency code for the local currency amount. Represents the company codes functional currency for financial reporting.. Valid values are `^[A-Z]{3}$`',
    `manual_reconciliation_flag` BOOLEAN COMMENT 'Indicates whether the transaction required manual intervention for reconciliation. Used for process improvement and automation gap analysis.',
    `payment_reference` STRING COMMENT 'Reference number or text provided by the counterparty or bank. Critical for automated matching against invoices, customer accounts, and payment runs.',
    `posting_date` DATE COMMENT 'Date when the transaction is posted to the General Ledger (GL) in SAP S/4HANA Finance. May differ from transaction date due to reconciliation timing.',
    `reconciliation_status` STRING COMMENT 'Current status of the bank statement line in the reconciliation process. Tracks whether the transaction has been matched and cleared against GL accounts.. Valid values are `unreconciled|matched|cleared|exception|manual_review`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this transaction is subject to SOX internal control requirements. Critical for audit trail and financial reporting compliance.',
    `statement_text` STRING COMMENT 'Descriptive text provided by the bank on the statement line. Contains additional transaction details for manual review and reconciliation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount included in or associated with the transaction. Separated for tax reporting and compliance purposes.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the bank transaction in the statement currency. Represents the actual cash movement recorded by the bank.',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO currency code for the transaction amount. Identifies the currency in which the bank recorded the transaction.. Valid values are `^[A-Z]{3}$`',
    `transaction_date` DATE COMMENT 'Date when the transaction was executed by the bank. This is the actual processing date recorded by the financial institution.',
    `transaction_type` STRING COMMENT 'Business classification of the transaction type. Standardized categorization for reporting and reconciliation purposes. [ENUM-REF-CANDIDATE: payment|receipt|transfer|fee|interest|adjustment|reversal — 7 candidates stripped; promote to reference product]',
    `value_date` DATE COMMENT 'Date when the transaction amount becomes available or is debited for interest calculation purposes. Critical for cash position management and treasury operations.',
    `vendor_reference` STRING COMMENT 'Vendor account number or identifier extracted from payment reference. Used for matching payments to vendor accounts in AP.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Withholding tax deducted from the payment. Required for cross-border payment compliance and tax reporting.',
    CONSTRAINT pk_bank_statement_line PRIMARY KEY(`bank_statement_line_id`)
) COMMENT 'Transactional entity capturing individual bank statement line items for reconciliation against Transport Shippings accounts payable and accounts receivable. Records value date, transaction date, debit/credit indicator, transaction amount, currency, bank transaction code, counterparty name, payment reference, and clearing status. Enables automated bank reconciliation and cash position management. Sourced from SAP S/4HANA Finance bank statement processing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`financial_control` (
    `financial_control_id` BIGINT COMMENT 'Unique identifier for the financial control. Primary key for the financial control entity.',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity or company code to which this control applies, enabling multi-entity control frameworks.',
    `controlling_area_id` BIGINT COMMENT 'Reference to the controlling area for management accounting and cost control purposes within the ERP system.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this control record in the system.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who most recently modified this control record.',
    `owner_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `primary_financial_employee_id` BIGINT COMMENT 'Reference to the employee or role responsible for the design, implementation, and ongoing effectiveness of this control.',
    `workflow_id` BIGINT COMMENT 'Foreign key linking to document.document_workflow. Business justification: Financial controls mandate specific document approval workflows (e.g., SOX control requires dual approval for high-value freight invoices, segregation of duties for customs declarations). Essential fo',
    `application_system_name` STRING COMMENT 'Name of the IT application or ERP module where the automated control is configured and executed (e.g., SAP S/4HANA Finance, Oracle Financials).',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Indicates whether detailed audit logging is enabled for this control to track all execution instances and changes for compliance purposes.',
    `compensating_control_flag` BOOLEAN COMMENT 'Indicates whether this control serves as a compensating control to mitigate risk when a primary control cannot be implemented or has failed.',
    `control_category` STRING COMMENT 'Hierarchical classification of the control: entity-level (company-wide governance), transaction-level (specific process controls), IT general controls, or IT application controls.. Valid values are `entity-level|transaction-level|it-general|it-application`',
    `control_code` STRING COMMENT 'Unique business identifier code for the financial control following organizational control numbering convention (e.g., FIN-001, REV-1234).. Valid values are `^[A-Z]{2,4}-[0-9]{3,5}$`',
    `control_deficiency_count` STRING COMMENT 'Number of deficiencies or exceptions identified during the most recent testing period, used to track control performance trends.',
    `control_description` STRING COMMENT 'Detailed narrative description of the control activity, including what is performed, how it is performed, and what evidence is generated.',
    `control_evidence_type` STRING COMMENT 'Type of evidence generated or retained to demonstrate control execution, such as system reports, approval signatures, reconciliation documents, or audit logs.',
    `control_frequency` STRING COMMENT 'How often the control is executed or performed, ranging from continuous monitoring to periodic execution aligned with business cycles. [ENUM-REF-CANDIDATE: continuous|daily|weekly|monthly|quarterly|annually|event-driven — 7 candidates stripped; promote to reference product]',
    `control_name` STRING COMMENT 'Short descriptive name of the financial control for identification and reporting purposes.',
    `control_nature` STRING COMMENT 'Indicates whether the control is executed automatically by system (automated), performed by personnel (manual), or a combination of both (hybrid).. Valid values are `automated|manual|hybrid`',
    `control_objective` STRING COMMENT 'The specific business objective or risk that this control is designed to address, such as ensuring accuracy of revenue recognition or preventing unauthorized disbursements.',
    `control_performer_role` STRING COMMENT 'The job role or position responsible for executing the control activity (may differ from control owner).',
    `control_procedure` STRING COMMENT 'Step-by-step procedure or work instruction for executing the control, including system transactions, approval workflows, and documentation requirements.',
    `control_reviewer_role` STRING COMMENT 'The job role or position responsible for reviewing and approving the control execution results, ensuring segregation of duties.',
    `control_status` STRING COMMENT 'Current lifecycle status of the control indicating whether it is actively enforced, temporarily suspended, under review for changes, or retired from use.. Valid values are `active|inactive|suspended|under-review|retired`',
    `control_type` STRING COMMENT 'Classification of the control based on its nature: preventive (stops errors before they occur), detective (identifies errors after occurrence), corrective (fixes identified errors), or directive (guides behavior).. Valid values are `preventive|detective|corrective|directive`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this control record was first created in the system.',
    `design_effectiveness_rating` STRING COMMENT 'Assessment of whether the control is properly designed to address the identified risk and achieve the control objective if executed as designed.. Valid values are `effective|needs-improvement|ineffective|not-assessed`',
    `ifrs_control_flag` BOOLEAN COMMENT 'Indicates whether this control is specifically designed to ensure compliance with IFRS accounting standards and disclosure requirements.',
    `key_control_flag` BOOLEAN COMMENT 'Indicates whether this control is designated as a key control that directly addresses a significant risk to financial reporting accuracy.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this control record was most recently updated or modified.',
    `last_test_date` DATE COMMENT 'The most recent date when the control was formally tested for design and operating effectiveness by internal audit or external auditors.',
    `last_test_result` STRING COMMENT 'Outcome of the most recent control testing, indicating whether the control passed without exceptions, passed with minor exceptions, or failed to operate effectively.. Valid values are `passed|passed-with-exceptions|failed|not-applicable`',
    `next_test_due_date` DATE COMMENT 'Scheduled date for the next control testing cycle based on control frequency, risk rating, and audit plan requirements.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or context related to the control that do not fit structured fields.',
    `operating_effectiveness_rating` STRING COMMENT 'Assessment of how effectively the control is operating based on testing results, indicating whether it is achieving its control objective consistently.. Valid values are `effective|needs-improvement|ineffective|not-tested`',
    `process_area` STRING COMMENT 'The specific financial process or sub-process that this control governs, such as revenue recognition, accounts payable, accounts receivable, fixed assets, financial close, payroll, or treasury operations.',
    `remediation_due_date` DATE COMMENT 'Target date by which identified control deficiencies must be remediated and the control restored to effective operation.',
    `remediation_plan` STRING COMMENT 'Description of corrective actions planned or in progress to address identified control deficiencies or weaknesses.',
    `risk_rating` STRING COMMENT 'Assessment of the risk level associated with control failure, considering both likelihood and impact on financial reporting and business operations.. Valid values are `critical|high|medium|low`',
    `segregation_of_duties_flag` BOOLEAN COMMENT 'Indicates whether this control enforces segregation of duties principles by ensuring incompatible functions are performed by different individuals.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this control is designated as a key control for SOX compliance and external audit purposes.',
    `system_generated_flag` BOOLEAN COMMENT 'Indicates whether the control is automatically executed and enforced by the ERP or financial system without manual intervention.',
    `test_frequency` STRING COMMENT 'How often the control must be formally tested for effectiveness by internal audit or compliance teams, driven by risk rating and regulatory requirements.. Valid values are `quarterly|semi-annually|annually|bi-annually|ad-hoc`',
    `valid_from_date` DATE COMMENT 'The date from which this control becomes effective and must be executed as part of the internal controls framework.',
    `valid_to_date` DATE COMMENT 'The date until which this control remains effective; nullable for controls with indefinite validity.',
    CONSTRAINT pk_financial_control PRIMARY KEY(`financial_control_id`)
) COMMENT 'Master entity defining SOX and IFRS financial controls governing Transport Shippings financial reporting processes. Captures control ID, control objective, control type (preventive, detective, automated, manual), control frequency, process area (revenue recognition, AP, AR, fixed assets, close), control owner, last test date, and operating effectiveness rating. Serves as the SSOT for the internal controls framework.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`target_allocation` (
    `target_allocation_id` BIGINT COMMENT 'Unique identifier for this target allocation record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically the profit center manager or sustainability lead) who is accountable for achieving this allocated target. Used for reporting and incentive compensation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to the profit center that has been allocated a portion of the sustainability target',
    `target_id` BIGINT COMMENT 'Foreign key linking to the sustainability target being allocated to the profit center',
    `allocated_baseline_value` DECIMAL(18,2) COMMENT 'The baseline measurement value allocated to this profit center based on allocation_percentage and the corporate target baseline. Used as the starting point for measuring this profit centers progress toward the allocated target.',
    `allocated_target_value` DECIMAL(18,2) COMMENT 'The target measurement value allocated to this profit center based on allocation_percentage and the corporate target. This is the value the profit center must achieve by the target year.',
    `allocation_effective_date` DATE COMMENT 'The date from which this target allocation became effective and performance tracking began. Typically aligns with fiscal year start or target program launch date.',
    `allocation_end_date` DATE COMMENT 'The date on which this target allocation ends or ended. Typically aligns with the target_year from the sustainability_target. Null for active ongoing allocations.',
    `allocation_methodology` STRING COMMENT 'Description of the methodology used to allocate this target to the profit center (e.g., proportional to revenue, proportional to baseline emissions, proportional to headcount, strategic allocation). Provides transparency for allocation decisions.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the corporate sustainability target allocated to this profit center for accountability and performance tracking (e.g., 15.50 means this profit center is responsible for 15.5% of the target reduction). Sum of allocation_percentage across all profit centers for a given target should equal 100%.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this target allocation. Active allocations are being tracked and measured. Suspended allocations are temporarily paused. Completed allocations have reached the target year. Cancelled allocations were terminated before completion.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this allocation record was created in the system.',
    `current_performance_value` DECIMAL(18,2) COMMENT 'The most recent actual performance measurement for this profit center against this allocated target. Updated periodically (monthly, quarterly, annually) based on actual emissions, energy consumption, or other sustainability metrics.',
    `incentive_weight` DECIMAL(18,2) COMMENT 'The weight or percentage of this sustainability target allocation in the profit center managers incentive compensation calculation (e.g., 10.00 means 10% of bonus is tied to achieving this target). Enables ESG-linked compensation.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this allocation record was last modified, including updates to performance values or status changes.',
    `notes` STRING COMMENT 'Free-text notes or comments about this target allocation, including context, special considerations, adjustments, or explanations for allocation decisions.',
    `performance_period_end_date` DATE COMMENT 'The end date of the period for which current_performance_value was measured (e.g., end of quarter, end of year). Enables time-series tracking of progress.',
    CONSTRAINT pk_target_allocation PRIMARY KEY(`target_allocation_id`)
) COMMENT 'This association product represents the allocation of corporate sustainability targets to profit centers for performance tracking, accountability, and incentive compensation. Each record links one profit center to one sustainability target with allocation percentages, baseline values, target values, and performance metrics that exist only in the context of this allocation relationship. Enables management reporting on sustainability performance by business unit and supports ESG-linked compensation.. Existence Justification: In logistics operations, corporate sustainability targets (carbon reduction, renewable energy, waste reduction) are allocated across multiple profit centers (express parcel, freight forwarding, contract logistics), and each profit center is accountable for multiple sustainability targets simultaneously. The allocation relationship is actively managed by the sustainability team, with specific allocation percentages, baseline values, target values, and ongoing performance tracking for each profit-center-to-target combination. This allocation data is used for management reporting, ESG disclosure, and incentive compensation calculations.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`lease_contract` (
    `lease_contract_id` BIGINT COMMENT 'Primary key for lease_contract',
    `transport_asset_id` BIGINT COMMENT 'Unique identifier of the leased asset.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Lease contracts belong to a legal entity (company code). Essential for IFRS 16 reporting by entity and proper lease liability recognition.',
    `lessee_id` BIGINT COMMENT 'Unique identifier of the party leasing the asset.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the party providing the asset under lease.',
    `renewed_lease_contract_id` BIGINT COMMENT 'Self-referencing FK on lease_contract (renewed_lease_contract_id)',
    `accounting_standard` STRING COMMENT 'Accounting framework governing lease treatment.',
    `approval_date` DATE COMMENT 'Date when the lease contract received formal approval.',
    `approved_by` STRING COMMENT 'Name or identifier of the user who approved the lease contract.',
    `asset_description` STRING COMMENT 'Human‑readable description of the leased asset.',
    `audit_trail_reference` BIGINT COMMENT 'Reference to the audit trail record capturing change history for this lease contract.',
    `capitalized_amount` DECIMAL(18,2) COMMENT 'Portion of the lease amount that is capitalized on the balance sheet.',
    `compliance_status` STRING COMMENT 'Current compliance status of the lease contract with internal policies and regulations.',
    `contract_document_url` STRING COMMENT 'Link to the electronic copy of the signed lease contract.',
    `contract_name` STRING COMMENT 'Descriptive name of the lease contract for easy identification.',
    `contract_number` STRING COMMENT 'External reference number assigned to the lease contract by the leasing department.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the lease contract record was created in the system.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for lease payments.',
    `depreciation_method` STRING COMMENT 'Method used to depreciate the leased asset for accounting purposes.',
    `depreciation_rate` DECIMAL(18,2) COMMENT 'Annual depreciation rate expressed as a percentage.',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Fee payable if the lease is terminated before the scheduled end date.',
    `effective_end_date` DATE COMMENT 'Date when the lease contract ends or expires; null for open‑ended contracts.',
    `effective_start_date` DATE COMMENT 'Date when the lease contract becomes effective and binding.',
    `extension_option` STRING COMMENT 'Availability of an extension period beyond the original term.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the lease liability.',
    `is_renewable` BOOLEAN COMMENT 'Indicates whether the lease contract can be renewed after its term.',
    `is_sublease_allowed` BOOLEAN COMMENT 'Flag indicating if the lessee is permitted to sub‑lease the asset.',
    `last_amended_date` DATE COMMENT 'Date of the most recent amendment to the lease contract.',
    `lease_amount` DECIMAL(18,2) COMMENT 'Total nominal amount of the lease before any adjustments.',
    `lease_category` STRING COMMENT 'Category of the leased asset, indicating the type of lease (e.g., equipment, vehicle, facility, software).',
    `lease_classification` STRING COMMENT 'Financial classification of the lease according to accounting standards (finance lease vs. operating lease).',
    `lease_term_months` STRING COMMENT 'Total duration of the lease expressed in months.',
    `payment_due_day` STRING COMMENT 'Day of month when each lease payment is due (1‑31).',
    `payment_frequency` STRING COMMENT 'How often lease payments are scheduled.',
    `payment_method` STRING COMMENT 'Method used to settle lease payments.',
    `remarks` STRING COMMENT 'Free‑form comments or notes related to the lease contract.',
    `renewal_option` STRING COMMENT 'Whether the lease includes a renewal provision.',
    `residual_value` DECIMAL(18,2) COMMENT 'Estimated value of the asset at the end of the lease term.',
    `lease_contract_status` STRING COMMENT 'Current lifecycle status of the lease contract.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate for lease payments.',
    `termination_option` STRING COMMENT 'Allowed termination scenarios for the lease.',
    `total_lease_liability` DECIMAL(18,2) COMMENT 'Present value of remaining lease payments recorded as liability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the lease contract record.',
    CONSTRAINT pk_lease_contract PRIMARY KEY(`lease_contract_id`)
) COMMENT 'Master reference table for lease_contract. Referenced by lease_contract_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`capex_project` (
    `capex_project_id` BIGINT COMMENT 'Primary key for capex_project',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: CAPEX projects belong to a legal entity (company code). Essential for CAPEX budget control and financial reporting by entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CAPEX projects are assigned to cost centers for cost tracking. Currently has cost_center_code (STRING) which should be normalized. The cost_center table has cost_center_code.',
    `parent_capex_project_id` BIGINT COMMENT 'Self-referencing FK on capex_project (parent_capex_project_id)',
    `actual_end_date` DATE COMMENT 'Calendar date when the project was actually completed.',
    `actual_spent` DECIMAL(18,2) COMMENT 'Cumulative actual expenditures recorded against the project.',
    `approval_date` DATE COMMENT 'Date on which the project received formal approval to proceed.',
    `asset_tag` STRING COMMENT 'Identifier of the physical asset generated by the project, if applicable.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget for the project expressed in the functional currency.',
    `capitalized_flag` BOOLEAN COMMENT 'Indicates whether the project costs are capitalized on the balance sheet.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the project record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the currency used for budget and actual amounts.',
    `department` STRING COMMENT 'Business department owning the project.',
    `depreciation_method` STRING COMMENT 'Method used to depreciate the asset created by the project.',
    `depreciation_period_years` STRING COMMENT 'Number of years over which the asset will be depreciated.',
    `capex_project_description` STRING COMMENT 'Detailed narrative describing the scope and objectives of the project.',
    `expected_roi_percent` DECIMAL(18,2) COMMENT 'Projected return on investment expressed as a percentage.',
    `financial_year` STRING COMMENT 'Fiscal year to which the projects budget and actuals are assigned.',
    `funding_source` STRING COMMENT 'Origin of the capital used to finance the project.',
    `justification` STRING COMMENT 'Narrative explaining the business need and expected benefits.',
    `location_code` STRING COMMENT 'Code of the primary site or facility where the project is executed.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or observations.',
    `planned_end_date` DATE COMMENT 'Planned calendar date for project completion.',
    `priority` STRING COMMENT 'Relative importance of the project for resource allocation.',
    `project_code` STRING COMMENT 'Business‑defined alphanumeric code that uniquely identifies the project across the enterprise.',
    `project_manager` STRING COMMENT 'Name of the internal manager responsible for overall project delivery.',
    `project_name` STRING COMMENT 'Human‑readable name of the capital project.',
    `project_phase` STRING COMMENT 'Current phase of the project lifecycle.',
    `project_status` STRING COMMENT 'Current lifecycle status of the project.',
    `project_type` STRING COMMENT 'Category describing the nature of the CAPEX project.',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether external regulatory approval is mandatory for the project.',
    `regulatory_approval_status` STRING COMMENT 'Current status of any required regulatory approvals.',
    `risk_level` STRING COMMENT 'Assessed risk exposure of the project.',
    `sponsor_name` STRING COMMENT 'Executive sponsor who champions and funds the project.',
    `start_date` DATE COMMENT 'Planned calendar date when project work is scheduled to commence.',
    `tax_code` STRING COMMENT 'Tax classification code applicable to the projects expenditures.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the project record.',
    CONSTRAINT pk_capex_project PRIMARY KEY(`capex_project_id`)
) COMMENT 'Master reference table for capex_project. Referenced by capex_project_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`house_bank` (
    `house_bank_id` BIGINT COMMENT 'Primary key for house_bank',
    `parent_house_bank_id` BIGINT COMMENT 'Self-referencing FK on house_bank (parent_house_bank_id)',
    `account_number` STRING COMMENT 'Primary account number held with the house bank.',
    `address_line1` STRING COMMENT 'First line of the banks physical address.',
    `address_line2` STRING COMMENT 'Second line of the banks physical address (optional).',
    `bank_country` STRING COMMENT 'Three‑letter country code where the bank is headquartered.',
    `bank_type` STRING COMMENT 'Classification of the bank based on its relationship to the enterprise.',
    `branch_name` STRING COMMENT 'Name of the specific branch of the house bank used for the account.',
    `city` STRING COMMENT 'City where the bank branch is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the house bank record was first created.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for the house bank.',
    `currency` STRING COMMENT 'Default currency used for transactions with this house bank.',
    `house_bank_description` STRING COMMENT 'Free‑form text describing the bank, its services, or special handling notes.',
    `email` STRING COMMENT 'Electronic mail address for bank communications.',
    `iban` STRING COMMENT 'Standardized account number for international transfers.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this bank is the default house bank for the enterprise.',
    `legal_entity_name` STRING COMMENT 'Official legal entity name of the bank as registered.',
    `house_bank_name` STRING COMMENT 'Legal name of the banking institution used as a house bank.',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the bank.',
    `postal_code` STRING COMMENT 'Postal code for the banks address.',
    `processing_time_days` STRING COMMENT 'Typical number of days required to process a transaction with this house bank.',
    `region` STRING COMMENT 'State or region component of the banks address.',
    `routing_number` STRING COMMENT 'Domestic routing identifier for the house bank account.',
    `settlement_method` STRING COMMENT 'Default method used for settling payments through this house bank.',
    `house_bank_status` STRING COMMENT 'Current operational status of the house bank record.',
    `swift_code` STRING COMMENT 'International Bank Identifier Code used for cross‑border payments.',
    `tax_identification_number` STRING COMMENT 'Tax identification number of the bank (e.g., EIN, VAT).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the house bank record.',
    `website` STRING COMMENT 'Public website URL of the bank.',
    CONSTRAINT pk_house_bank PRIMARY KEY(`house_bank_id`)
) COMMENT 'Master reference table for house_bank. Referenced by house_bank_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`bank_statement` (
    `bank_statement_id` BIGINT COMMENT 'Primary key for bank_statement',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Bank statements belong to a specific bank account. Currently has account_number and iban as denormalized strings. The bank_account table has account_number and iban attributes, so these can be removed',
    `bank_id` BIGINT COMMENT 'Reference to the bank entity that issued the statement.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Bank statements belong to a company code (legal entity). This is essential for multi-entity financial reconciliation and reporting.',
    `house_bank_id` BIGINT COMMENT 'Foreign key linking to finance.house_bank. Business justification: Bank statements come from house banks. Currently has swift_code denormalized. The house_bank table has swift_code, so it can be removed from bank_statement.',
    `prior_bank_statement_id` BIGINT COMMENT 'Self-referencing FK on bank_statement (prior_bank_statement_id)',
    `adjustment_reason` STRING COMMENT 'Explanation for any adjustments applied to the statement.',
    `checksum` STRING COMMENT 'Hash value used to verify file integrity.',
    `closing_balance` DECIMAL(18,2) COMMENT 'Account balance at the end of the statement period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the statement record was first loaded into the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the statement currency.',
    `bank_statement_description` STRING COMMENT 'Optional narrative notes about the statement.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert foreign‑currency amounts to the reporting currency.',
    `exchange_rate_date` DATE COMMENT 'Date on which the exchange rate was applicable.',
    `fee_total` DECIMAL(18,2) COMMENT 'Aggregate of all fees charged by the bank for the period.',
    `file_name` STRING COMMENT 'Name of the electronic file containing the statement.',
    `file_path` STRING COMMENT 'Storage location (path) of the electronic statement file.',
    `is_adjusted` BOOLEAN COMMENT 'Indicates whether the statement includes post‑period adjustments.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Account balance at the start of the statement period.',
    `period_end_date` DATE COMMENT 'Last calendar date covered by the statement period.',
    `period_start_date` DATE COMMENT 'First calendar date covered by the statement period.',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the statement was posted to the accounting system.',
    `reconciled_timestamp` TIMESTAMP COMMENT 'Timestamp when the statement was reconciled with internal records.',
    `source_system` STRING COMMENT 'Originating system that supplied the statement data (e.g., SAP S/4HANA).',
    `statement_date` DATE COMMENT 'Date the statement was generated by the bank.',
    `statement_number` STRING COMMENT 'External statement number assigned by the bank or the finance system.',
    `statement_type` STRING COMMENT 'Delivery format of the statement.',
    `statement_version` STRING COMMENT 'Version number for corrected or re‑issued statements.',
    `bank_statement_status` STRING COMMENT 'Current processing status of the statement.',
    `tax_withheld` DECIMAL(18,2) COMMENT 'Total tax amount withheld on the statement period.',
    `total_credits` DECIMAL(18,2) COMMENT 'Aggregate amount of all credit transactions in the period.',
    `total_debits` DECIMAL(18,2) COMMENT 'Aggregate amount of all debit transactions in the period.',
    `transaction_count` STRING COMMENT 'Count of individual transactions recorded on the statement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the statement record.',
    CONSTRAINT pk_bank_statement PRIMARY KEY(`bank_statement_id`)
) COMMENT 'Master reference table for bank_statement. Referenced by bank_statement_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`business_unit` (
    `business_unit_id` BIGINT COMMENT 'Primary key for business_unit',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity to which the business unit belongs.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the business unit manager.',
    `parent_business_unit_id` BIGINT COMMENT 'Identifier of the immediate parent business unit in the organizational hierarchy.',
    `address_line1` STRING COMMENT 'Primary street address of the business unit.',
    `address_line2` STRING COMMENT 'Secondary address information (optional).',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Planned annual budget allocated to the business unit.',
    `city` STRING COMMENT 'City where the business unit is located.',
    `business_unit_code` STRING COMMENT 'Unique alphanumeric code identifying the business unit within the enterprise.',
    `country` STRING COMMENT 'Three-letter ISO country code where the business unit is located.',
    `created_by_user` STRING COMMENT 'User identifier who initially created the business unit record.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code used for financial reporting of the business unit.',
    `business_unit_description` STRING COMMENT 'Free-text description providing additional details about the business unit.',
    `effective_end_date` DATE COMMENT 'Date when the business unit ceased operations, if applicable.',
    `effective_start_date` DATE COMMENT 'Date when the business unit became operational.',
    `email_address` STRING COMMENT 'Primary email address for the business unit.',
    `external_reporting_code` STRING COMMENT 'Code used for external regulatory reporting (e.g., for IFRS).',
    `fiscal_year_start_month` STRING COMMENT 'Month (1-12) when the fiscal year starts for the business unit.',
    `headcount` STRING COMMENT 'Number of employees assigned to the business unit.',
    `is_profit_center` BOOLEAN COMMENT 'Indicates whether the business unit is treated as a profit center.',
    `business_unit_name` STRING COMMENT 'Descriptive name of the business unit.',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the business unit.',
    `postal_code` STRING COMMENT 'Postal code for the business unit address.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the business unit record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the business unit record.',
    `region` STRING COMMENT 'Three-letter code representing the geographic region of the business unit.',
    `business_unit_status` STRING COMMENT 'Current lifecycle status of the business unit.',
    `tax_id_number` STRING COMMENT 'Tax registration number for the business unit (e.g., VAT number).',
    `business_unit_type` STRING COMMENT 'Category of the business unit indicating its organizational role.',
    `updated_by_user` STRING COMMENT 'User identifier who last updated the business unit record.',
    CONSTRAINT pk_business_unit PRIMARY KEY(`business_unit_id`)
) COMMENT 'Master reference table for business_unit. Referenced by business_unit_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`cost_element` (
    `cost_element_id` BIGINT COMMENT 'Primary key for cost_element',
    `parent_cost_element_id` BIGINT COMMENT 'Self-referencing FK on cost_element (parent_cost_element_id)',
    `amortization_period_months` STRING COMMENT 'Number of months over which the cost element is amortized when capitalized.',
    `cost_category` STRING COMMENT 'Higher‑level grouping of cost elements (e.g., Labor, Materials, Services).',
    `cost_center_code` STRING COMMENT 'Organizational cost center to which the cost element is primarily assigned.',
    `cost_subcategory` STRING COMMENT 'More granular classification within a cost category.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost element record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the default rate.',
    `default_allocation_method` STRING COMMENT 'Standard method used to allocate this cost element to cost objects.',
    `default_rate` DECIMAL(18,2) COMMENT 'Default monetary rate applied when the cost element is used without a specific rate.',
    `depreciation_life_years` STRING COMMENT 'Useful life in years for depreciation calculations when the element is capitalized.',
    `depreciation_method` STRING COMMENT 'Method used to calculate depreciation for capitalized cost elements.',
    `effective_from` DATE COMMENT 'Date when the cost element becomes valid for posting.',
    `effective_until` DATE COMMENT 'Date when the cost element is retired; null if still active.',
    `element_code` STRING COMMENT 'Short alphanumeric code used to reference the cost element in financial transactions.',
    `element_description` STRING COMMENT 'Detailed description of the cost element purpose and usage.',
    `element_name` STRING COMMENT 'Human‑readable name of the cost element.',
    `element_type` STRING COMMENT 'Classification of the cost element by accounting nature.',
    `financial_reporting_group` STRING COMMENT 'Group used for external financial reporting (e.g., IFRS, US GAAP).',
    `is_capitalized` BOOLEAN COMMENT 'True if the cost element is treated as a capital expense; otherwise false.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the cost element.',
    `profit_center_code` STRING COMMENT 'Profit center associated with the cost element for profitability reporting.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the cost element must be disclosed in regulatory filings (e.g., SOX).',
    `cost_element_status` STRING COMMENT 'Current lifecycle status of the cost element.',
    `tax_applicable` BOOLEAN COMMENT 'Indicates whether the cost element is subject to tax.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the cost element record.',
    `version_number` STRING COMMENT 'Incremental version of the cost element definition for change management.',
    CONSTRAINT pk_cost_element PRIMARY KEY(`cost_element_id`)
) COMMENT 'Master reference table for cost_element. Referenced by cost_element_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`project` (
    `project_id` BIGINT COMMENT 'Primary key for project',
    `employee_id` BIGINT COMMENT 'Identifier of the employee managing the project.',
    `project_owner_employee_id` BIGINT COMMENT 'Identifier of the employee who owns the project deliverables.',
    `sponsor_employee_id` BIGINT COMMENT 'Identifier of the executive sponsor for the project.',
    `parent_project_id` BIGINT COMMENT 'Self-referencing FK on project (parent_project_id)',
    `actual_duration_days` STRING COMMENT 'Actual elapsed days from start to completion.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Cumulative actual expenditures incurred by the project.',
    `approval_status` STRING COMMENT 'Current status of the projects approval workflow.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the project received formal approval.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget amount for the project.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the project was officially closed.',
    `cost_center_code` STRING COMMENT 'Organizational cost center associated with the project.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the project record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `project_description` STRING COMMENT 'Free‑text description of the projects objectives and scope.',
    `end_date` DATE COMMENT 'Planned or actual date when the project ends; nullable for open‑ended projects.',
    `estimated_duration_days` STRING COMMENT 'Planned duration of the project in calendar days.',
    `external_reference_number` STRING COMMENT 'Reference number linking the project to external contracts or agreements.',
    `financial_year` STRING COMMENT 'Fiscal year to which the project budget is allocated.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter (1‑4) for the projects financial reporting.',
    `funding_source` STRING COMMENT 'Origin of the funds used for the project.',
    `is_capital_expenditure` BOOLEAN COMMENT 'Flag indicating whether the project is classified as CAPEX.',
    `is_internal` BOOLEAN COMMENT 'Flag indicating whether the project is internal to the organization.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal project review.',
    `location_code` STRING COMMENT 'Code of the primary geographic location or facility for the project.',
    `milestone_count` STRING COMMENT 'Number of defined milestones within the project.',
    `priority` STRING COMMENT 'Priority level indicating the importance and urgency of the project.',
    `profit_center_code` STRING COMMENT 'Profit center responsible for the projects financial results.',
    `project_category` STRING COMMENT 'High‑level category describing the nature of the project.',
    `project_code` STRING COMMENT 'Business code used externally to identify the project.',
    `project_name` STRING COMMENT 'Descriptive name of the project.',
    `project_phase` STRING COMMENT 'Current phase of the project lifecycle.',
    `project_status` STRING COMMENT 'Current lifecycle status of the project.',
    `project_status_reason` STRING COMMENT 'Free‑text explanation for the current project status.',
    `project_subcategory` STRING COMMENT 'More detailed classification within the project category.',
    `project_type` STRING COMMENT 'Classification of the project by its nature or purpose.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the project complies with applicable logistics regulations.',
    `risk_level` STRING COMMENT 'Assessed risk exposure of the project.',
    `stakeholder_count` STRING COMMENT 'Total number of identified stakeholders for the project.',
    `start_date` DATE COMMENT 'Date when the project becomes effective.',
    `tax_code` STRING COMMENT 'Tax classification code applicable to the projects expenditures.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the project record.',
    CONSTRAINT pk_project PRIMARY KEY(`project_id`)
) COMMENT 'Master reference table for project. Referenced by project_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'Primary key for wbs_element',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center responsible for the elements costs.',
    `parent_wbs_element_id` BIGINT COMMENT 'Identifier of the immediate parent WBS element in the hierarchy.',
    `project_id` BIGINT COMMENT 'Identifier of the project to which this WBS element belongs.',
    `template_id` BIGINT COMMENT 'Reference to the template WBS element used for cloning.',
    `accounting_period` STRING COMMENT 'Fiscal period (e.g., 2024Q1) to which the elements transactions are posted.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Real cost incurred to date for the element.',
    `actual_duration_days` STRING COMMENT 'Actual elapsed days from start to completion.',
    `approval_status` STRING COMMENT 'Current approval state of the WBS element.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the element was approved.',
    `billing_currency` STRING COMMENT 'Currency used for billing the element.',
    `billing_rate` DECIMAL(18,2) COMMENT 'Rate applied for billing (per unit or hour).',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned budget allocated to the WBS element.',
    `closure_date` DATE COMMENT 'Date when the WBS element was formally closed.',
    `comments` STRING COMMENT 'Free‑form notes or remarks about the element.',
    `cost_allocation_method` STRING COMMENT 'Method used to allocate costs to the element.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the WBS record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `wbs_element_description` STRING COMMENT 'Detailed description of the purpose and scope of the WBS element.',
    `end_date` DATE COMMENT 'Date when the WBS element is scheduled to end (nullable for open‑ended).',
    `estimated_duration_days` STRING COMMENT 'Planned duration of the element in days.',
    `external_reference` STRING COMMENT 'Identifier used in external systems to reference this WBS element.',
    `financial_year` STRING COMMENT 'Fiscal year to which the element belongs.',
    `fiscal_period` STRING COMMENT 'Specific fiscal period (e.g., FY2024Q2).',
    `is_billable` BOOLEAN COMMENT 'Indicates whether costs on this element are billable to a customer.',
    `is_template` BOOLEAN COMMENT 'Indicates whether the element is defined as a reusable template.',
    `last_modified_by` STRING COMMENT 'User identifier who performed the most recent update.',
    `last_review_date` DATE COMMENT 'Date of the most recent governance review.',
    `wbs_element_level` STRING COMMENT 'Depth level of the element within the WBS hierarchy (root = 1).',
    `milestone_date` DATE COMMENT 'Scheduled date for the milestone, if applicable.',
    `milestone_flag` BOOLEAN COMMENT 'True if the element represents a project milestone.',
    `wbs_element_name` STRING COMMENT 'Human‑readable name of the WBS element.',
    `planned_cost` DECIMAL(18,2) COMMENT 'Estimated cost for the element before execution.',
    `priority` STRING COMMENT 'Business priority assigned to the element.',
    `profit_center` STRING COMMENT 'Profit center associated with the WBS element for profitability reporting.',
    `responsible_organization` STRING COMMENT 'Organizational unit accountable for the WBS element.',
    `review_cycle` STRING COMMENT 'Frequency at which the element is reviewed.',
    `risk_level` STRING COMMENT 'Risk assessment level for the element.',
    `start_date` DATE COMMENT 'Date when the WBS element becomes effective.',
    `wbs_element_status` STRING COMMENT 'Current lifecycle status of the WBS element.',
    `tax_code` STRING COMMENT 'Tax classification code applicable to the element.',
    `wbs_element_type` STRING COMMENT 'Classification of the WBS element (e.g., project, activity, cost center).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the WBS record.',
    `wbs_code` STRING COMMENT 'Business identifier for the WBS element, typically hierarchical (e.g., 1.2.3).',
    `created_by` STRING COMMENT 'User identifier who originally created the WBS record.',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Master reference table for wbs_element. Referenced by wbs_element_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`fund` (
    `fund_id` BIGINT COMMENT 'Primary key for fund',
    `tax_account_id` BIGINT COMMENT 'Tax identifier for the funds legal entity.',
    `parent_fund_id` BIGINT COMMENT 'Self-referencing FK on fund (parent_fund_id)',
    `asset_allocation` STRING COMMENT 'Target asset class distribution (e.g., 60% equities, 40% bonds).',
    `benchmark_index` STRING COMMENT 'Reference index used to measure fund performance.',
    `capital_commitment_date` DATE COMMENT 'Date when the capital commitment was signed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fund record was first created.',
    `currency` STRING COMMENT 'ISO 4217 three‑letter currency code in which the fund is denominated.',
    `fund_description` STRING COMMENT 'Free‑text description providing additional context about the fund.',
    `domicile_country` STRING COMMENT 'Three‑letter ISO country code where the fund is domiciled.',
    `domicile_state` STRING COMMENT 'State or province of the funds domicile, if applicable.',
    `expense_ratio` DECIMAL(18,2) COMMENT 'Annual operating expense ratio expressed as a percentage of assets.',
    `fund_code` STRING COMMENT 'External business code used to reference the fund.',
    `fund_name` STRING COMMENT 'Descriptive name of the fund.',
    `fund_status` STRING COMMENT 'Current lifecycle status of the fund.',
    `fund_type` STRING COMMENT 'Category of the fund based on investment strategy.',
    `invested_amount` DECIMAL(18,2) COMMENT 'Cumulative amount that has been invested from the fund.',
    `investment_end_date` DATE COMMENT 'Projected or actual date when the fund will cease new investments.',
    `investment_start_date` DATE COMMENT 'Date when the fund began making investments.',
    `investment_strategy` STRING COMMENT 'Narrative description of the funds investment approach.',
    `is_tax_exempt` BOOLEAN COMMENT 'Indicates whether the fund is exempt from certain taxes.',
    `last_review_date` DATE COMMENT 'Date of the most recent governance or performance review of the fund.',
    `legal_entity` STRING COMMENT 'Legal entity under which the fund is established.',
    `management_fee` DECIMAL(18,2) COMMENT 'Annual fee charged by the manager, expressed as a percentage of assets.',
    `manager_contact_email` STRING COMMENT 'Primary email address for the fund manager.',
    `manager_contact_phone` STRING COMMENT 'Primary phone number for the fund manager.',
    `manager_name` STRING COMMENT 'Name of the individual or entity responsible for managing the fund.',
    `performance_fee` DECIMAL(18,2) COMMENT 'Fee based on fund performance, typically a percentage of profits.',
    `performance_inception` DECIMAL(18,2) COMMENT 'Funds performance percentage since inception.',
    `performance_year_to_date` DECIMAL(18,2) COMMENT 'Funds performance percentage YTD.',
    `regulatory_status` STRING COMMENT 'Regulatory classification of the fund.',
    `risk_rating` STRING COMMENT 'Qualitative risk rating assigned to the fund.',
    `total_commitment_amount` DECIMAL(18,2) COMMENT 'Total capital committed to the fund by investors.',
    `uninvested_amount` DECIMAL(18,2) COMMENT 'Capital that remains unallocated for investment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fund record.',
    CONSTRAINT pk_fund PRIMARY KEY(`fund_id`)
) COMMENT 'Master reference table for fund. Referenced by fund_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`commitment_item` (
    `commitment_item_id` BIGINT COMMENT 'Primary key for commitment_item',
    `parent_commitment_item_id` BIGINT COMMENT 'Self-referencing FK on commitment_item (parent_commitment_item_id)',
    `accounting_period` STRING COMMENT 'Accounting period (e.g., 2024Q1) for financial reporting.',
    `amount` DECIMAL(18,2) COMMENT 'Principal monetary amount committed.',
    `approved_by` STRING COMMENT 'Identifier of the user or role that approved the commitment.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the commitment was formally approved.',
    `commitment_category` STRING COMMENT 'High‑level classification of the commitment purpose.',
    `commitment_name` STRING COMMENT 'Human‑readable name or title of the commitment.',
    `commitment_number` STRING COMMENT 'External business identifier or reference number for the commitment.',
    `commitment_owner` STRING COMMENT 'Internal owner or responsible party for the commitment.',
    `commitment_type` STRING COMMENT 'Category of commitment indicating its nature (e.g., budget, contract).',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier associated with the commitment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the commitment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the commitment amount.',
    `commitment_item_description` STRING COMMENT 'Free‑form description providing context and details about the commitment.',
    `effective_from` DATE COMMENT 'Date when the commitment becomes binding.',
    `effective_until` DATE COMMENT 'Date when the commitment ends or expires (null for open‑ended).',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the commitment is allocated.',
    `is_recurring` BOOLEAN COMMENT 'Flag indicating whether the commitment recurs on a regular schedule.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or process that performed the most recent update.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the commitment.',
    `payment_terms` STRING COMMENT 'Standard payment terms associated with the commitment (e.g., Net 30).',
    `project_code` STRING COMMENT 'Project identifier linked to the commitment, if applicable.',
    `recurrence_interval` STRING COMMENT 'Interval at which a recurring commitment repeats.',
    `renewal_term_months` STRING COMMENT 'Number of months for the renewal term of a recurring commitment.',
    `source_system` STRING COMMENT 'Name of the source system that originated the commitment record.',
    `commitment_item_status` STRING COMMENT 'Current lifecycle status of the commitment.',
    `tax_code` STRING COMMENT 'Tax classification code applicable to the commitment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the commitment record.',
    CONSTRAINT pk_commitment_item PRIMARY KEY(`commitment_item_id`)
) COMMENT 'Master reference table for commitment_item. Referenced by commitment_item_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`controlling_area` (
    `controlling_area_id` BIGINT COMMENT 'Primary key for controlling_area',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the chart of accounts used by this controlling area.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that owns the controlling area.',
    `parent_controlling_area_id` BIGINT COMMENT 'Self-referencing FK on controlling_area (parent_controlling_area_id)',
    `controlling_area_code` STRING COMMENT 'Business identifier code assigned to the controlling area (e.g., CA01).',
    `consolidation_group` STRING COMMENT 'Identifier used to group this controlling area for financial consolidation purposes.',
    `cost_center_grouping` STRING COMMENT 'Logical grouping key for cost centers within the controlling area.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the controlling area record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code used for financial postings in this controlling area.',
    `controlling_area_description` STRING COMMENT 'Free‑text description providing additional context about the controlling area.',
    `effective_from` DATE COMMENT 'Date on which the controlling area becomes operational.',
    `effective_until` DATE COMMENT 'Date on which the controlling area ceases to be operational (null if open‑ended).',
    `fiscal_year_variant` STRING COMMENT 'Identifier of the fiscal year variant applied to the controlling area (e.g., FY2023).',
    `is_deleted` BOOLEAN COMMENT 'Indicates whether the controlling area has been logically deleted (true) or is active (false).',
    `is_intercompany_allowed` BOOLEAN COMMENT 'Indicates whether intercompany postings are permitted in this controlling area.',
    `controlling_area_name` STRING COMMENT 'Human‑readable name of the controlling area used in reports and UI.',
    `profit_center_grouping` STRING COMMENT 'Logical grouping key for profit centers within the controlling area.',
    `region` STRING COMMENT 'Three‑letter region code indicating the primary geographic region of the controlling area.',
    `controlling_area_status` STRING COMMENT 'Current lifecycle status of the controlling area.',
    `tax_jurisdiction_code` STRING COMMENT 'Code of the tax jurisdiction applicable to the controlling area for tax reporting.',
    `controlling_area_type` STRING COMMENT 'Classification of the controlling area indicating whether it tracks cost, profit, or both.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the controlling area record.',
    CONSTRAINT pk_controlling_area PRIMARY KEY(`controlling_area_id`)
) COMMENT 'Master reference table for controlling_area. Referenced by controlling_area_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`credit_control_area` (
    `credit_control_area_id` BIGINT COMMENT 'Primary key for credit_control_area',
    `parent_credit_control_area_id` BIGINT COMMENT 'Self-referencing FK on credit_control_area (parent_credit_control_area_id)',
    `allowed_overdue_days` STRING COMMENT 'Maximum number of days a receivable may be overdue before the area is blocked.',
    `auto_block_flag` BOOLEAN COMMENT 'Indicates whether the system automatically blocks the area when credit limit is exceeded.',
    `block_reason` STRING COMMENT 'Free‑text explanation for why the credit control area was blocked.',
    `block_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit control area was manually blocked.',
    `blocked_by` STRING COMMENT 'User identifier who manually blocked the credit control area.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit control area record was first created in the system.',
    `credit_available_amount` DECIMAL(18,2) COMMENT 'Remaining credit that can be utilized, calculated as limit minus exposure.',
    `credit_check_indicator` STRING COMMENT 'Specifies whether credit checks are mandatory, optional, or not performed for the area.',
    `credit_check_rule` STRING COMMENT 'Identifier of the rule set used during credit assessment.',
    `credit_control_area_code` STRING COMMENT 'External code used to identify the credit control area in financial documents and SAP S/4HANA.',
    `credit_exposure_amount` DECIMAL(18,2) COMMENT 'Total amount of open receivables currently assigned to the credit control area.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for the area, expressed in the functional currency.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the credit limit and related amounts.',
    `credit_control_area_description` STRING COMMENT 'Detailed description of the credit control area purpose and scope.',
    `distribution_channel` STRING COMMENT 'Distribution channel code associated with the credit control area.',
    `dunning_procedure` STRING COMMENT 'Identifier of the dunning strategy applied when payments are overdue.',
    `effective_from` DATE COMMENT 'Date when the credit control area becomes effective.',
    `effective_until` DATE COMMENT 'Date when the credit control area expires; null for open‑ended.',
    `last_review_date` DATE COMMENT 'Date when the credit control area was last reviewed by credit management.',
    `legal_entity` STRING COMMENT 'Company code or legal entity to which the credit control area belongs.',
    `credit_control_area_name` STRING COMMENT 'Human‑readable name of the credit control area.',
    `notes` STRING COMMENT 'Free‑form notes or comments regarding the credit control area.',
    `payment_terms_code` STRING COMMENT 'Standard payment terms applied to transactions under this credit control area.',
    `release_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit control area was released from a block.',
    `review_frequency_days` STRING COMMENT 'Planned interval in days between credit control area reviews.',
    `risk_category` STRING COMMENT 'Risk classification used for credit assessment; follows internal rating scale.',
    `sales_organization` STRING COMMENT 'Sales organization identifier linked to the credit control area.',
    `credit_control_area_status` STRING COMMENT 'Current operational status of the credit control area.',
    `credit_control_area_type` STRING COMMENT 'Category of the credit control area indicating whether it applies to customers, vendors, or internal entities.',
    `updated_by` STRING COMMENT 'User identifier who performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the credit control area record.',
    `created_by` STRING COMMENT 'User identifier who initially created the credit control area record.',
    CONSTRAINT pk_credit_control_area PRIMARY KEY(`credit_control_area_id`)
) COMMENT 'Master reference table for credit_control_area. Referenced by credit_control_area_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`payment_proposal` (
    `payment_proposal_id` BIGINT COMMENT 'Primary key for payment_proposal',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Payment proposals are generated for a specific company code. Essential for payment processing and bank account selection.',
    `created_by_user_employee_id` BIGINT COMMENT 'System user identifier that created the proposal record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the proposal.',
    `party_id` BIGINT COMMENT 'Identifier of the vendor, supplier, or other counterparty associated with the proposal.',
    `revised_payment_proposal_id` BIGINT COMMENT 'Self-referencing FK on payment_proposal (revised_payment_proposal_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the proposal was approved.',
    `comments` STRING COMMENT 'Free‑form comments or notes attached to the proposal.',
    `cost_center_code` STRING COMMENT 'Internal cost center to which the proposal expense is charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment proposal record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the monetary amounts.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discounts granted on the proposal.',
    `due_date` DATE COMMENT 'Date by which the payment must be received.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert original currency to reporting currency.',
    `exchange_rate_date` DATE COMMENT 'Date on which the exchange rate was determined.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, or other adjustments.',
    `invoice_number` STRING COMMENT 'Reference number of the underlying invoice, if applicable.',
    `is_urgent` BOOLEAN COMMENT 'Indicates whether the proposal requires expedited processing.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes and discounts.',
    `original_currency_code` STRING COMMENT 'Currency in which the proposal was originally created.',
    `payment_channel` STRING COMMENT 'Digital channel through which the payment was initiated.',
    `payment_method` STRING COMMENT 'Instrument used to settle the payment.',
    `payment_terms` STRING COMMENT 'Contractual payment terms governing when payment is due.',
    `priority` STRING COMMENT 'Business priority assigned to the proposal.',
    `proposal_date` DATE COMMENT 'Date the payment proposal was issued or became effective.',
    `proposal_number` STRING COMMENT 'External reference number assigned to the payment proposal.',
    `proposal_type` STRING COMMENT 'Classification of the proposal, e.g., invoice, credit note, advance, or refund.',
    `settlement_date` DATE COMMENT 'Date on which the payment was settled.',
    `settlement_status` STRING COMMENT 'Current status of the payment settlement process.',
    `payment_proposal_status` STRING COMMENT 'Current lifecycle status of the payment proposal.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the proposal.',
    `tax_code` STRING COMMENT 'Tax classification code applicable to the proposal.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment proposal record.',
    `vendor_name` STRING COMMENT 'Display name of the counterparty vendor.',
    CONSTRAINT pk_payment_proposal PRIMARY KEY(`payment_proposal_id`)
) COMMENT 'Master reference table for payment_proposal. Referenced by payment_proposal_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
    `parent_legal_entity_id` BIGINT COMMENT 'Self-referencing FK on legal_entity (parent_legal_entity_id)',
    `authorized_share_capital` DECIMAL(18,2) COMMENT 'Maximum amount of share capital that the legal entity is authorized to issue as per its articles of incorporation.',
    `chart_of_accounts_code` STRING COMMENT 'Identifier for the chart of accounts assigned to this legal entity, defining the GL account structure for financial postings.',
    `company_code` STRING COMMENT 'SAP company code uniquely identifying the legal entity within the ERP system. Used as the primary organizational unit for financial accounting.',
    `consolidation_group` STRING COMMENT 'Identifier for the group consolidation hierarchy to which this entity belongs, used for IFRS group reporting and elimination of intercompany transactions.',
    `consolidation_method` STRING COMMENT 'Accounting method used to consolidate this entitys financials into the group, based on level of control or significant influence.',
    `country_of_incorporation` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the legal entity was originally incorporated or registered.',
    `country_of_tax_residence` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the jurisdiction where the entity is tax-resident for corporate income tax purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the legal entity master record was first created in the system of record.',
    `dissolution_date` DATE COMMENT 'Date on which the legal entity was formally dissolved or struck off the corporate register. Null if entity is still active.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique nine-digit identifier for the legal entity, used for credit assessment and supply chain verification.',
    `effective_from_date` DATE COMMENT 'Date from which this legal entity record is considered valid for financial reporting and transactional purposes.',
    `effective_to_date` DATE COMMENT 'Date until which this legal entity record is valid. Null indicates the record is currently effective with no planned end date.',
    `entity_type` STRING COMMENT 'Classification of the legal entity by its corporate structure or formation type.',
    `fiscal_year_variant` STRING COMMENT 'Code defining the fiscal year calendar structure (period start/end dates) used by this legal entity for financial reporting.',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the primary economic environment in which the entity operates, used for financial reporting.',
    `incorporation_date` DATE COMMENT 'Date on which the legal entity was officially incorporated or registered with the relevant government authority.',
    `industry_code` STRING COMMENT 'Standard industry classification code (NAICS or ISIC) representing the primary business activity of the legal entity.',
    `is_intercompany_partner` BOOLEAN COMMENT 'Indicates whether this legal entity participates in intercompany transactions requiring elimination during group consolidation.',
    `is_reporting_entity` BOOLEAN COMMENT 'Indicates whether this legal entity is required to produce standalone statutory financial statements in its jurisdiction.',
    `legal_name` STRING COMMENT 'Full registered legal name of the entity as filed with the relevant corporate registry or government authority.',
    `lei_code` STRING COMMENT 'Global Legal Entity Identifier as defined by ISO 17442, used for regulatory reporting and counterparty identification in financial transactions.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of equity ownership held by the parent entity. Determines consolidation method (full, proportional, or equity method).',
    `paid_up_capital` DECIMAL(18,2) COMMENT 'Amount of share capital that has been fully paid by shareholders, representing the entitys equity base.',
    `parent_entity_id` BIGINT COMMENT 'Reference to the immediate parent legal entity in the corporate ownership hierarchy. Null for the ultimate parent entity.',
    `region_code` STRING COMMENT 'Internal geographic region code for management reporting purposes, grouping legal entities by operational territory.',
    `registered_address` STRING COMMENT 'Full registered office address of the legal entity as filed with the corporate registry. Used for official correspondence and legal service.',
    `registration_number` STRING COMMENT 'Official registration or incorporation number issued by the government authority in the jurisdiction of incorporation.',
    `regulatory_classification` STRING COMMENT 'Classification indicating whether the entity is subject to industry-specific regulatory oversight (e.g., customs brokerage, freight forwarding licenses).',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used for group-level consolidated financial reporting, which may differ from the functional currency.',
    `segment_code` STRING COMMENT 'Code identifying the IFRS 8 operating segment to which this legal entitys results are reported (e.g., express, freight, supply chain).',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this legal entity is within scope for SOX internal controls over financial reporting compliance.',
    `legal_entity_status` STRING COMMENT 'Current lifecycle status of the legal entity indicating its operational and legal standing.',
    `statutory_auditor` STRING COMMENT 'Name of the external audit firm responsible for the statutory audit of this legal entitys financial statements.',
    `tax_group_code` STRING COMMENT 'Identifier for the tax consolidation group to which this entity belongs, enabling group tax filing and loss offset arrangements.',
    `tax_identification_number` STRING COMMENT 'Primary tax identification number assigned by the tax authority in the entitys country of tax residence. Used for tax filings and regulatory reporting.',
    `trading_name` STRING COMMENT 'The commercial or trading name under which the legal entity conducts business, if different from the registered legal name.',
    `transfer_pricing_category` STRING COMMENT 'Functional characterization of the entity for transfer pricing purposes, determining the appropriate intercompany pricing methodology.',
    `vat_registration_number` STRING COMMENT 'VAT or GST registration number for the legal entity, used for indirect tax compliance and intercompany invoicing.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master reference table for legal_entity. Referenced by legal_entity_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`finance`.`party` (
    `party_id` BIGINT COMMENT 'Primary key for party',
    `bank_account_number` STRING COMMENT 'The primary bank account number (IBAN or domestic format) used for payment settlements with this party.',
    `bank_routing_code` STRING COMMENT 'The SWIFT/BIC code or domestic routing number identifying the partys bank for electronic fund transfers and intercompany settlements.',
    `company_code` STRING COMMENT 'The SAP company code representing the legal entity within Transport Shipping that owns the financial relationship with this party. Drives ledger posting and statutory reporting.',
    `country_of_incorporation` STRING COMMENT 'The ISO 3166-1 alpha-3 country code where the party is legally incorporated or registered. Critical for intercompany settlement rules and regulatory reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this party record was first created in the system. Required for audit trail and SOX compliance.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'The maximum credit exposure allowed for this party in the default currency. Used for credit control in accounts receivable and freight billing.',
    `credit_rating` STRING COMMENT 'The external or internal credit rating assigned to the party, used for financial risk assessment and credit limit determination.',
    `default_currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code representing the partys preferred transaction currency for invoicing and settlement.',
    `display_name` STRING COMMENT 'The commonly used or trading name of the party for display purposes in reports and user interfaces. May differ from the legal name.',
    `dunning_procedure_code` STRING COMMENT 'The dunning procedure assigned to this party that governs the escalation levels and timing of overdue payment reminders.',
    `duns_number` STRING COMMENT 'The nine-digit DUNS number assigned by Dun & Bradstreet, used for credit assessment, vendor qualification, and intercompany relationship identification in global logistics.',
    `effective_from_date` DATE COMMENT 'The date from which this party record becomes effective for financial transactions. Supports temporal validity of master data.',
    `effective_to_date` DATE COMMENT 'The date until which this party record remains effective. Null indicates an open-ended validity period.',
    `industry_classification_code` STRING COMMENT 'The standard industry classification code (NAICS, NACE, or SIC) identifying the partys primary business sector. Used for credit risk segmentation and regulatory reporting.',
    `is_intercompany` BOOLEAN COMMENT 'Indicates whether this party is an intercompany entity within the Transport Shipping corporate group. Drives intercompany elimination rules in consolidated financial reporting.',
    `is_related_party` BOOLEAN COMMENT 'Indicates whether this party qualifies as a related party under IAS 24 disclosure requirements. Triggers additional reporting obligations for related party transactions.',
    `kyc_verification_date` DATE COMMENT 'The date when the most recent KYC verification was completed or last renewed for this party.',
    `kyc_verification_status` STRING COMMENT 'The current status of Know Your Customer verification for this party. Required for anti-money laundering compliance in financial transactions.',
    `language_code` STRING COMMENT 'The ISO 639-1 two-letter language code for the partys preferred communication language. Used for invoice generation and financial correspondence.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this party record was last modified. Supports change tracking and audit trail requirements.',
    `legal_name` STRING COMMENT 'The official registered legal name of the party as it appears on incorporation documents, contracts, or government-issued identification.',
    `parent_party_id` BIGINT COMMENT 'Reference to the parent party in the corporate hierarchy. Enables group-level consolidation, credit exposure aggregation, and intercompany relationship mapping.',
    `payment_terms_code` STRING COMMENT 'The standard payment terms code agreed with this party (e.g., NET30, NET60, COD). Drives accounts receivable and payable aging calculations.',
    `primary_email` STRING COMMENT 'The primary email address for financial correspondence including invoice delivery, payment notifications, and audit communications.',
    `primary_phone` STRING COMMENT 'The primary telephone contact number for the party, used for financial and operational communications.',
    `reconciliation_account` STRING COMMENT 'The general ledger reconciliation account number linked to this party for automatic posting of subledger transactions to the general ledger.',
    `registered_address_city` STRING COMMENT 'The city or municipality of the partys registered address.',
    `registered_address_country` STRING COMMENT 'The ISO 3166-1 alpha-3 country code of the partys registered address. Used for jurisdiction determination in tax and regulatory reporting.',
    `registered_address_line1` STRING COMMENT 'The first line of the partys official registered address used for legal correspondence, tax filings, and regulatory submissions.',
    `registered_address_postal_code` STRING COMMENT 'The postal or ZIP code of the partys registered address.',
    `registration_number` STRING COMMENT 'The official company or business registration number issued by the relevant corporate registry or government authority in the country of incorporation.',
    `role` STRING COMMENT 'The primary business role this party plays in relation to Transport Shipping. A party may have multiple roles but this captures the dominant financial relationship.',
    `sanctions_screening_date` DATE COMMENT 'The date of the most recent sanctions and denied-party screening performed on this party. Required for audit trail and compliance evidence.',
    `sanctions_screening_status` STRING COMMENT 'The result of the most recent sanctions and denied-party screening check. Required for trade compliance in international logistics operations.',
    `source_system_code` STRING COMMENT 'Identifier of the operational system of record from which this party master data originated (e.g., SAP S/4HANA Finance module).',
    `source_system_key` STRING COMMENT 'The native primary key or business partner number from the source system, enabling traceability back to the operational system of record.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this party is subject to enhanced SOX financial controls due to materiality thresholds or related-party status.',
    `party_status` STRING COMMENT 'Current lifecycle status of the party record indicating whether the party is active for financial transactions, blocked, pending approval, or archived.',
    `tax_identification_number` STRING COMMENT 'The tax registration number assigned by the relevant tax authority. Used for tax filings, withholding tax calculations, and regulatory financial reporting.',
    `tax_jurisdiction_code` STRING COMMENT 'The tax jurisdiction code applicable to this party, determining which tax rules and rates apply to transactions. Critical for multi-jurisdictional logistics operations.',
    `party_type` STRING COMMENT 'Classification of the party by legal entity type, distinguishing between organizations, individuals, government bodies, consortiums, trusts, and joint ventures.',
    `vat_registration_number` STRING COMMENT 'The VAT or GST registration number for the party, used in cross-border logistics invoicing and tax compliance across multiple jurisdictions.',
    `withholding_tax_code` STRING COMMENT 'The applicable withholding tax code for this party based on jurisdiction and tax treaty agreements. Drives automatic tax deduction during payment processing.',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Master reference table for party. Referenced by party_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `transport_shipping_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `transport_shipping_ecm`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_primary_consolidation_profit_center_id` FOREIGN KEY (`primary_consolidation_profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `transport_shipping_ecm`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_credit_control_area_id` FOREIGN KEY (`credit_control_area_id`) REFERENCES `transport_shipping_ecm`.`finance`.`credit_control_area`(`credit_control_area_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_parent_company_code_id` FOREIGN KEY (`parent_company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `transport_shipping_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_tax_account_id` FOREIGN KEY (`tax_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`tax_account`(`tax_account_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `transport_shipping_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `transport_shipping_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `transport_shipping_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_tax_account_id` FOREIGN KEY (`tax_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`tax_account`(`tax_account_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `transport_shipping_ecm`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `transport_shipping_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `transport_shipping_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `transport_shipping_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_commitment_item_id` FOREIGN KEY (`commitment_item_id`) REFERENCES `transport_shipping_ecm`.`finance`.`commitment_item`(`commitment_item_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `transport_shipping_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_project_id` FOREIGN KEY (`project_id`) REFERENCES `transport_shipping_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `transport_shipping_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `transport_shipping_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_tax_account_id` FOREIGN KEY (`tax_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`tax_account`(`tax_account_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_tax_account_id` FOREIGN KEY (`tax_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`tax_account`(`tax_account_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_payment_proposal_id` FOREIGN KEY (`payment_proposal_id`) REFERENCES `transport_shipping_ecm`.`finance`.`payment_proposal`(`payment_proposal_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `transport_shipping_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_tax_account_id` FOREIGN KEY (`tax_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`tax_account`(`tax_account_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ADD CONSTRAINT `fk_finance_tax_account_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ADD CONSTRAINT `fk_finance_tax_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ADD CONSTRAINT `fk_finance_tax_account_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `transport_shipping_ecm`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ADD CONSTRAINT `fk_finance_tax_filing_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ADD CONSTRAINT `fk_finance_tax_filing_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ADD CONSTRAINT `fk_finance_tax_filing_original_filing_tax_filing_id` FOREIGN KEY (`original_filing_tax_filing_id`) REFERENCES `transport_shipping_ecm`.`finance`.`tax_filing`(`tax_filing_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ADD CONSTRAINT `fk_finance_tax_filing_tax_account_id` FOREIGN KEY (`tax_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`tax_account`(`tax_account_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `transport_shipping_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `transport_shipping_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `transport_shipping_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `transport_shipping_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_original_allocation_cost_allocation_id` FOREIGN KEY (`original_allocation_cost_allocation_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `transport_shipping_ecm`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `transport_shipping_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `transport_shipping_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `transport_shipping_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_tax_account_id` FOREIGN KEY (`tax_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`tax_account`(`tax_account_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ADD CONSTRAINT `fk_finance_currency_rate_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ADD CONSTRAINT `fk_finance_currency_rate_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ADD CONSTRAINT `fk_finance_financial_statement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ADD CONSTRAINT `fk_finance_financial_statement_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ADD CONSTRAINT `fk_finance_financial_statement_prior_statement_financial_statement_id` FOREIGN KEY (`prior_statement_financial_statement_id`) REFERENCES `transport_shipping_ecm`.`finance`.`financial_statement`(`financial_statement_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ADD CONSTRAINT `fk_finance_finance_audit_finding_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ADD CONSTRAINT `fk_finance_finance_audit_finding_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ADD CONSTRAINT `fk_finance_finance_audit_finding_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ADD CONSTRAINT `fk_finance_finance_audit_finding_financial_control_id` FOREIGN KEY (`financial_control_id`) REFERENCES `transport_shipping_ecm`.`finance`.`financial_control`(`financial_control_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ADD CONSTRAINT `fk_finance_finance_audit_finding_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ADD CONSTRAINT `fk_finance_finance_audit_finding_previous_finding_finance_audit_finding_id` FOREIGN KEY (`previous_finding_finance_audit_finding_id`) REFERENCES `transport_shipping_ecm`.`finance`.`finance_audit_finding`(`finance_audit_finding_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ADD CONSTRAINT `fk_finance_finance_audit_finding_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `transport_shipping_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `transport_shipping_ecm`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `transport_shipping_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_house_bank_id` FOREIGN KEY (`house_bank_id`) REFERENCES `transport_shipping_ecm`.`finance`.`house_bank`(`house_bank_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_bank_statement_id` FOREIGN KEY (`bank_statement_id`) REFERENCES `transport_shipping_ecm`.`finance`.`bank_statement`(`bank_statement_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_house_bank_id` FOREIGN KEY (`house_bank_id`) REFERENCES `transport_shipping_ecm`.`finance`.`house_bank`(`house_bank_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_tax_account_id` FOREIGN KEY (`tax_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`tax_account`(`tax_account_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ADD CONSTRAINT `fk_finance_financial_control_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ADD CONSTRAINT `fk_finance_financial_control_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `transport_shipping_ecm`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ADD CONSTRAINT `fk_finance_target_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_renewed_lease_contract_id` FOREIGN KEY (`renewed_lease_contract_id`) REFERENCES `transport_shipping_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_parent_capex_project_id` FOREIGN KEY (`parent_capex_project_id`) REFERENCES `transport_shipping_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ADD CONSTRAINT `fk_finance_house_bank_parent_house_bank_id` FOREIGN KEY (`parent_house_bank_id`) REFERENCES `transport_shipping_ecm`.`finance`.`house_bank`(`house_bank_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement` ADD CONSTRAINT `fk_finance_bank_statement_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement` ADD CONSTRAINT `fk_finance_bank_statement_bank_id` FOREIGN KEY (`bank_id`) REFERENCES `transport_shipping_ecm`.`finance`.`house_bank`(`house_bank_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement` ADD CONSTRAINT `fk_finance_bank_statement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement` ADD CONSTRAINT `fk_finance_bank_statement_house_bank_id` FOREIGN KEY (`house_bank_id`) REFERENCES `transport_shipping_ecm`.`finance`.`house_bank`(`house_bank_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement` ADD CONSTRAINT `fk_finance_bank_statement_prior_bank_statement_id` FOREIGN KEY (`prior_bank_statement_id`) REFERENCES `transport_shipping_ecm`.`finance`.`bank_statement`(`bank_statement_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `transport_shipping_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_parent_business_unit_id` FOREIGN KEY (`parent_business_unit_id`) REFERENCES `transport_shipping_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_element` ADD CONSTRAINT `fk_finance_cost_element_parent_cost_element_id` FOREIGN KEY (`parent_cost_element_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`project` ADD CONSTRAINT `fk_finance_project_parent_project_id` FOREIGN KEY (`parent_project_id`) REFERENCES `transport_shipping_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_parent_wbs_element_id` FOREIGN KEY (`parent_wbs_element_id`) REFERENCES `transport_shipping_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_project_id` FOREIGN KEY (`project_id`) REFERENCES `transport_shipping_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fund` ADD CONSTRAINT `fk_finance_fund_tax_account_id` FOREIGN KEY (`tax_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`tax_account`(`tax_account_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fund` ADD CONSTRAINT `fk_finance_fund_parent_fund_id` FOREIGN KEY (`parent_fund_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`commitment_item` ADD CONSTRAINT `fk_finance_commitment_item_parent_commitment_item_id` FOREIGN KEY (`parent_commitment_item_id`) REFERENCES `transport_shipping_ecm`.`finance`.`commitment_item`(`commitment_item_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`controlling_area` ADD CONSTRAINT `fk_finance_controlling_area_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`controlling_area` ADD CONSTRAINT `fk_finance_controlling_area_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `transport_shipping_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`controlling_area` ADD CONSTRAINT `fk_finance_controlling_area_parent_controlling_area_id` FOREIGN KEY (`parent_controlling_area_id`) REFERENCES `transport_shipping_ecm`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`credit_control_area` ADD CONSTRAINT `fk_finance_credit_control_area_parent_credit_control_area_id` FOREIGN KEY (`parent_credit_control_area_id`) REFERENCES `transport_shipping_ecm`.`finance`.`credit_control_area`(`credit_control_area_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_proposal` ADD CONSTRAINT `fk_finance_payment_proposal_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_proposal` ADD CONSTRAINT `fk_finance_payment_proposal_party_id` FOREIGN KEY (`party_id`) REFERENCES `transport_shipping_ecm`.`finance`.`party`(`party_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_proposal` ADD CONSTRAINT `fk_finance_payment_proposal_revised_payment_proposal_id` FOREIGN KEY (`revised_payment_proposal_id`) REFERENCES `transport_shipping_ecm`.`finance`.`payment_proposal`(`payment_proposal_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `transport_shipping_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `transport_shipping_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `account_description_long` SET TAGS ('dbx_business_glossary_term' = 'Account Description Long');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending_closure');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_business_glossary_term' = 'Alternative Account Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `blocked_for_posting_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocked for Posting Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `budget_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `business_area_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Business Area Required Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `cash_flow_category` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Category');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `cash_flow_category` SET TAGS ('dbx_value_regex' = 'operating|investing|financing|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `cost_center_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Required Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|revenue|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `external_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `field_status_group` SET TAGS ('dbx_business_glossary_term' = 'Field Status Group');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `financial_statement_position` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Position');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `intercompany_clearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Clearing Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `marked_for_deletion_flag` SET TAGS ('dbx_business_glossary_term' = 'Marked for Deletion Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `open_item_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `planning_level` SET TAGS ('dbx_business_glossary_term' = 'Planning Level');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `profit_center_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Required Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `reconciliation_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `retained_earnings_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Retained Earnings Account Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Sort Key');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `sustainability_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Reporting Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `tolerance_group` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Group');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`ledger` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_class` SET TAGS ('dbx_business_glossary_term' = 'Account Class');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_class` SET TAGS ('dbx_value_regex' = 'primary|reconciliation|statistical|intercompany');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'Account Group Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_short_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Short Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|blocked|inactive|pending_approval');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type Classification');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `audit_trail_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Classification');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_value_regex' = 'current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `budget_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Statement Classification');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_value_regex' = 'operating|investing|financing|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `consolidation_account` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `control_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Control Account Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_element_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `currency_type` SET TAGS ('dbx_business_glossary_term' = 'Currency Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `currency_type` SET TAGS ('dbx_value_regex' = 'local|group|transaction|multiple');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `default_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Default Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `default_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `field_status_group` SET TAGS ('dbx_business_glossary_term' = 'Field Status Group');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_item` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Line Item');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `gaap_classification` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Classification');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `ifrs_classification` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Classification');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_value_regex' = 'none|payable|receivable|both');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `line_item_display_flag` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `open_item_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `planning_level` SET TAGS ('dbx_business_glossary_term' = 'Planning Level');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `profit_loss_classification` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Classification');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `reconciliation_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `retained_earnings_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Retained Earnings Account Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Sort Key');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Relevant Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `tolerance_group` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Group');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_period` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|activity_based|proportional|driver_based|fixed_percentage');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending_closure|closed');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Group');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `fte_count` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Count');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `is_overhead` SET TAGS ('dbx_business_glossary_term' = 'Is Overhead');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `is_revenue_generating` SET TAGS ('dbx_business_glossary_term' = 'Is Revenue Generating');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `primary_consolidation_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Profit Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `capex_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Budget Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `capex_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `ebitda_reporting_segment` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Reporting Segment');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `ebitda_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Target Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `ebitda_target_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `intercompany_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Billing Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `opex_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Budget Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `opex_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|planned');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'service_line|business_unit|geographic_region|product_line|cost_center|investment_center');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `revenue_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `revenue_target_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` SET TAGS ('dbx_subdomain' = 'corporate_structure');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO) ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `credit_control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Control Area ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `credit_control_area_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `parent_company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_business_glossary_term' = 'Company Code Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_closure|dissolved|merged');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Company Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `company_name_short` SET TAGS ('dbx_business_glossary_term' = 'Company Short Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `consolidation_group_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `ifrs_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Reporting Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `intercompany_billing_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Billing Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `legal_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `legal_entity_type` SET TAGS ('dbx_value_regex' = 'corporation|limited_liability_company|partnership|sole_proprietorship|branch|subsidiary');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `posting_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Block Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Email');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posting User Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_account_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `assignment_reference` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reference');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entry Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Credit Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Debit Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `manual_entry_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|parked|cleared|reversed|cancelled');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = '01|02|03|04|05');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP|ORACLE|COUPA|MANUAL|INTERFACE');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `text_description` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Text Description');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Header ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_account_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_in_document_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Document Currency');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_in_group_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Group Currency');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_in_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_reference` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reference');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit Credit Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Document Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `manual_entry_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_key_1` SET TAGS ('dbx_business_glossary_term' = 'Reference Key 1');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_key_2` SET TAGS ('dbx_business_glossary_term' = 'Reference Key 2');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Period End Close Responsible User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `tertiary_fiscal_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `tertiary_fiscal_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `tertiary_fiscal_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `ap_posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Posting Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `ar_posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Posting Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `asset_posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Asset Posting Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `calendar_month` SET TAGS ('dbx_business_glossary_term' = 'Calendar Month');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `calendar_year` SET TAGS ('dbx_business_glossary_term' = 'Calendar Year');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `consolidation_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Period Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `cost_center_posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Posting Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_number` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `gl_posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `half_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Half Year');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `ifrs_reporting_period_flag` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Reporting Period Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `number_of_days` SET TAGS ('dbx_business_glossary_term' = 'Number of Days');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `number_of_working_days` SET TAGS ('dbx_business_glossary_term' = 'Number of Working Days');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_description` SET TAGS ('dbx_business_glossary_term' = 'Period Description');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_end_close_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period End Close Completed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_end_close_status` SET TAGS ('dbx_business_glossary_term' = 'Period End Close Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_end_close_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_end_close_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period End Close Verified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Period Lock Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'not_opened|open|closed|locked');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'normal|special|adjustment|year_end_closing');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `posting_close_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Close Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `posting_open_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Open Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ALTER COLUMN `tax_reporting_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Period Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Holder ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `available_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Budget Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|frozen|closed');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `consumed_amount` SET TAGS ('dbx_business_glossary_term' = 'Consumed Budget Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `control_method` SET TAGS ('dbx_business_glossary_term' = 'Budget Control Method');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `control_method` SET TAGS ('dbx_value_regex' = 'advisory|warning|blocking');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `ebitda_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'EBITDA (Earnings Before Interest Taxes Depreciation and Amortization) Impact Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(Q[1-4]|M(0[1-9]|1[0-2])|FY)$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Budget Lock Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_business_glossary_term' = 'Planning Scenario');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_value_regex' = 'base|optimistic|pessimistic|stretch');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Budget Subcategory');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Tolerance Percentage');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|supplemental|baseline|rolling');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `commitment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Commitment Item ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `quaternary_budget_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `quaternary_budget_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `quaternary_budget_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `tertiary_budget_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `tertiary_budget_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `tertiary_budget_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Draft|Pending Approval|Approved|Rejected|Locked');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Budget Quantity');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `contractor_safety_prequal_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Safety Prequal Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `document_package_id` SET TAGS ('dbx_business_glossary_term' = 'Document Package Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `tax_account_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `days_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Outstanding');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Gross Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|intercompany|recurring');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `net_payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payable_category` SET TAGS ('dbx_business_glossary_term' = 'Payable Category');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_block_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'open|partially_paid|fully_paid|overdue|blocked|cancelled');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_package_id` SET TAGS ('dbx_business_glossary_term' = 'Document Package Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `tax_account_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date for Payment Terms');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `credit_limit_exposure` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Exposure');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `credit_limit_exposure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'b2b_enterprise|b2b_sme|b2c_individual|government|ecommerce_seller');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Document Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'invoice|credit_memo|debit_memo|payment_on_account|down_payment');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Receivable Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `last_dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Receivable Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Receivable Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `outstanding_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `receivable_status` SET TAGS ('dbx_business_glossary_term' = 'Receivable Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `receivable_status` SET TAGS ('dbx_value_regex' = 'open|partially_paid|fully_paid|written_off|disputed|under_collection');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Proposal ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `quaternary_payment_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `quaternary_payment_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `quaternary_payment_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `tertiary_payment_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `tertiary_payment_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `tertiary_payment_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `bank_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Confirmation Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `invoice_count` SET TAGS ('dbx_business_glossary_term' = 'Invoice Count');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Disbursement Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_block_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Override Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_file_name` SET TAGS ('dbx_business_glossary_term' = 'Payment File Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_file_transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment File Transmission Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_value_regex' = 'ACH|WIRE|CHECK|EFT|SEPA|BACS');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_status` SET TAGS ('dbx_value_regex' = 'SCHEDULED|IN_PROGRESS|COMPLETED|FAILED|CANCELLED|PARTIALLY_COMPLETED');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_type` SET TAGS ('dbx_value_regex' = 'REGULAR|URGENT|MANUAL|SCHEDULED|INTERCOMPANY');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `posting_document_number` SET TAGS ('dbx_business_glossary_term' = 'Posting Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `posting_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'PENDING|RECONCILED|DISCREPANCY|UNDER_REVIEW');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `total_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `total_withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Withholding Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ALTER COLUMN `vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Vendor Count');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `intercompany_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Settlement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Elimination Journal Entry Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Agreement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Company Code Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Cost Center Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Profit Center Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `tax_account_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `tertiary_intercompany_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `tertiary_intercompany_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `tertiary_intercompany_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Elimination Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `gl_account_receiver` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Receiver');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `gl_account_receiver` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `gl_account_sender` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Sender');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `gl_account_sender` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `netting_run_reference` SET TAGS ('dbx_business_glossary_term' = 'Netting Run Reference');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `netting_run_reference` SET TAGS ('dbx_value_regex' = '^NET[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = 'error_correction|period_adjustment|duplicate_entry|incorrect_amount|incorrect_entity|other');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_document_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'shared_services|transfer_pricing|intercompany_loan|netting_agreement|elimination_entry|cost_allocation');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'comparable_uncontrolled_price|resale_price|cost_plus|profit_split|transactional_net_margin|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` SET TAGS ('dbx_subdomain' = 'asset_compliance');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_account_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `aeo_status_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Status Required Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `deferred_payment_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Deferred Payment Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `exemption_certificate_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Exemption Certificate Required Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `hs_code_applicability` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code Applicability');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `incoterm_applicability` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Applicability');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `recoverable_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Recoverable Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `reverse_charge_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Charge Mechanism Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `self_assessment_flag` SET TAGS ('dbx_business_glossary_term' = 'Self-Assessment Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_account_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_account_description` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Description');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_account_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_account_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|closed');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_authority_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_value_regex' = 'input_tax|output_tax|import_tax|export_tax|payroll_tax|excise_tax');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_filing_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Method');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_filing_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|EDI|API');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}(-[A-Z0-9]{1,5})?$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_point_rule` SET TAGS ('dbx_business_glossary_term' = 'Tax Point Rule');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_point_rule` SET TAGS ('dbx_value_regex' = 'invoice_date|delivery_date|payment_date|service_completion_date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Frequency');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|semi_annually|on_demand');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'VAT|GST|customs_duty|withholding_tax|corporate_income_tax|sales_tax');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ALTER COLUMN `withholding_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` SET TAGS ('dbx_subdomain' = 'asset_compliance');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `tax_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `original_filing_tax_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Original Tax Filing Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `tax_account_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `trade_document_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Approver Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `audit_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Tax Audit Risk Score');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Confirmation Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `filing_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Deadline Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Submission Method');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|edi|api');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `filing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `filing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Filing Reference Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|amended|under_review');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'vat_return|corporate_income_tax|customs_duty_reconciliation|withholding_tax|excise_tax|payroll_tax');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Payment Due Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Payment Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partially_paid|fully_paid|refunded|waived');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `preparer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Preparer Contact Email');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `preparer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `preparer_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `preparer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Preparer Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filing Submission Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `supporting_document_count` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Count');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `tax_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ALTER COLUMN `taxable_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Base Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_compliance');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tertiary_fixed_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tertiary_fixed_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tertiary_fixed_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation_gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_location_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_location_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'in_service|under_construction|retired|disposed|impaired|held_for_sale');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_sub_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Sub-Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_sub_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capex_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Category');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capex_category` SET TAGS ('dbx_value_regex' = 'growth|maintenance|replacement|regulatory|efficiency');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Depreciation General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sale|scrap|trade_in|donation|transfer|retirement');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` SET TAGS ('dbx_subdomain' = 'asset_compliance');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `asset_depreciation_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Depreciation ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Project ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `asset_acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Acquisition Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `asset_acquisition_value` SET TAGS ('dbx_business_glossary_term' = 'Asset Acquisition Value');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_key` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Key');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_run_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `gl_account_accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Accumulated Depreciation');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `gl_account_accumulated_depreciation` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `gl_account_depreciation_expense` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Depreciation Expense');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `gl_account_depreciation_expense` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `lease_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lease Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|error');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = '01|02|03|04|05');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `original_allocation_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Original Allocation ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Cost Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Profit Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `tertiary_cost_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `tertiary_cost_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `tertiary_cost_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Quantity');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_unit` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_reference_text` SET TAGS ('dbx_business_glossary_term' = 'Allocation Reference Text');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Run Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|cancelled');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'assessment|distribution|periodic_reposting|activity_allocation|template_allocation');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `service_line` SET TAGS ('dbx_value_regex' = 'express|freight|warehouse|fulfillment|customs|contract_logistics');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `financial_period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Close ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `document_package_id` SET TAGS ('dbx_business_glossary_term' = 'Document Package Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Locked By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `primary_financial_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `primary_financial_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `primary_financial_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `blocking_issue` SET TAGS ('dbx_business_glossary_term' = 'Blocking Issue');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `blocking_issue_severity` SET TAGS ('dbx_business_glossary_term' = 'Blocking Issue Severity');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `blocking_issue_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `certification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Certification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Close Completion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Close Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_status` SET TAGS ('dbx_business_glossary_term' = 'Close Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|blocked|completed|certified');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_task_type` SET TAGS ('dbx_business_glossary_term' = 'Close Task Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_task_type` SET TAGS ('dbx_value_regex' = 'accruals_posting|depreciation_run|intercompany_reconciliation|foreign_currency_revaluation|tax_provision|inventory_valuation');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_type` SET TAGS ('dbx_business_glossary_term' = 'Close Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `close_type` SET TAGS ('dbx_value_regex' = 'month_end|quarter_end|year_end|special_close');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `consolidation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Required Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `ebitda_reporting_segment` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Reporting Segment');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `ifrs_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Reporting Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `intercompany_elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `lock_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lock Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `planned_close_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Close Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `variance_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ALTER COLUMN `variance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `tax_account_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_description` SET TAGS ('dbx_business_glossary_term' = 'Accrual Description');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_number` SET TAGS ('dbx_business_glossary_term' = 'Accrual Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_number` SET TAGS ('dbx_value_regex' = '^ACR-[0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Posting Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|cancelled|adjusted');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_business_glossary_term' = 'Accrual Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_value_regex' = 'freight_revenue|carrier_cost|customs_duty|fuel_surcharge|lease_liability|warehouse_expense');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Accrual Basis Method');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `basis` SET TAGS ('dbx_value_regex' = 'time_based|event_based|percentage_of_completion|straight_line|usage_based');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^BA-[A-Z0-9]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Document Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^FA-[A-Z0-9]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Accrual Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Reversal Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `reversal_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Posting Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `currency_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Rate ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `tertiary_currency_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `tertiary_currency_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `tertiary_currency_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `effective_rate_with_spread` SET TAGS ('dbx_business_glossary_term' = 'Effective Rate with Spread');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_value_regex' = 'spot|average|closing|budget|forecast|historical');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `from_currency_code` SET TAGS ('dbx_business_glossary_term' = 'From Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `from_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `hedge_contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Hedge Contract Reference');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `hedging_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Hedging Rate Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `ifrs_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS (International Financial Reporting Standards) Reporting Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `intercompany_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Rate Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `inverse_rate_value` SET TAGS ('dbx_business_glossary_term' = 'Inverse Exchange Rate Value');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `rate_determination_method` SET TAGS ('dbx_business_glossary_term' = 'Rate Determination Method');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `rate_determination_method` SET TAGS ('dbx_value_regex' = 'market|fixed|negotiated|regulatory');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `rate_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Source Reference');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `rate_spread_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rate Spread Percentage');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|superseded|pending|expired');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `rate_update_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rate Update Frequency');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Value');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `rate_volatility_indicator` SET TAGS ('dbx_business_glossary_term' = 'Rate Volatility Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `rate_volatility_indicator` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `to_currency_code` SET TAGS ('dbx_business_glossary_term' = 'To Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `to_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `financial_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `prior_statement_financial_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Financial Statement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `quaternary_financial_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `quaternary_financial_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `quaternary_financial_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `quinary_financial_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `quinary_financial_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `quinary_financial_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `tertiary_financial_reviewed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `tertiary_financial_reviewed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `tertiary_financial_reviewed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `audit_opinion_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Opinion Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `audit_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'unaudited|under_audit|audited|qualified_opinion|adverse_opinion|disclaimer_of_opinion');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `comparative_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Comparative Period Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `consolidation_group_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `consolidation_scope` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Scope');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `consolidation_scope` SET TAGS ('dbx_value_regex' = 'legal_entity|consolidated_group|business_unit|segment');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `ebitda_reporting_segment` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Reporting Segment');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `external_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `ifrs_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Reporting Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `intercompany_elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `notes_reference` SET TAGS ('dbx_business_glossary_term' = 'Notes to Financial Statements Reference');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `presentation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Presentation Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `presentation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `regulatory_filing_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Reporting Standard');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_value_regex' = 'IFRS|US_GAAP|local_GAAP|statutory');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `restatement_flag` SET TAGS ('dbx_business_glossary_term' = 'Restatement Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `restatement_reason` SET TAGS ('dbx_business_glossary_term' = 'Restatement Reason');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `segment_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Segment Reporting Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|published|restated|superseded');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_value_regex' = 'income_statement|balance_sheet|cash_flow_statement|statement_of_changes_in_equity|notes_to_financial_statements');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ALTER COLUMN `xbrl_instance_document` SET TAGS ('dbx_business_glossary_term' = 'Extensible Business Reporting Language (XBRL) Instance Document');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `finance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `financial_control_id` SET TAGS ('dbx_business_glossary_term' = 'Control Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `previous_finding_finance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `quaternary_finance_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `quaternary_finance_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `quaternary_finance_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `tertiary_finance_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `tertiary_finance_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `tertiary_finance_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Document Version Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `affected_process_area` SET TAGS ('dbx_business_glossary_term' = 'Affected Process Area');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `auditor_type` SET TAGS ('dbx_business_glossary_term' = 'Auditor Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `auditor_type` SET TAGS ('dbx_value_regex' = 'internal|external|regulatory');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Control Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `control_objective` SET TAGS ('dbx_business_glossary_term' = 'Control Objective');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Required Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Description');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{3,5}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'open|in_remediation|pending_validation|closed|deferred|accepted_risk');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'material_weakness|significant_deficiency|control_gap|observation|best_practice_opportunity|compliance_violation');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Identified Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Impact Rating');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `impact_rating` SET TAGS ('dbx_value_regex' = 'catastrophic|major|moderate|minor|negligible');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Rating');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_value_regex' = 'very_likely|likely|possible|unlikely|rare');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Auditor Recommendation');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `remediation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completed Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `remediation_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `repeat_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Reported Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `tertiary_internal_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `tertiary_internal_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `tertiary_internal_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `asset_under_construction_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Under Construction (AUC) Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `available_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Budget Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_control_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Control Active Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `capex_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `committed_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `final_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Final Settlement Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `opex_flag` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `order_category` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Category');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `order_category` SET TAGS ('dbx_value_regex' = 'overhead|investment|accrual|revenue');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `order_description` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Description');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `order_end_date` SET TAGS ('dbx_business_glossary_term' = 'Order End Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,12}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `order_short_text` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Short Text');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `order_start_date` SET TAGS ('dbx_business_glossary_term' = 'Order Start Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'created|released|technically_completed|closed|locked');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'capex_project|opex_project|marketing_campaign|fleet_overhaul|warehouse_expansion|maintenance_activity');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `planning_integrated_flag` SET TAGS ('dbx_business_glossary_term' = 'Planning Integrated Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_receiver_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Receiver ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_receiver_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Receiver Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_receiver_type` SET TAGS ('dbx_value_regex' = 'asset|cost_center|gl_account|wbs_element|sales_order');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_rule_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_rule_type` SET TAGS ('dbx_value_regex' = 'full_settlement|percentage_settlement|equivalence_number|periodic_settlement');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `statistical_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Order Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ALTER COLUMN `technical_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Technical Completion Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `house_bank_id` SET TAGS ('dbx_business_glossary_term' = 'House Bank Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Masked Bank Account Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `account_purpose` SET TAGS ('dbx_business_glossary_term' = 'Account Purpose');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended|pending');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'operating|payroll|escrow|tax|investment|reserve');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Balance Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Bank Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Bank Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_city` SET TAGS ('dbx_business_glossary_term' = 'Bank City');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Postal Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_state_province` SET TAGS ('dbx_business_glossary_term' = 'Bank State or Province');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `carrier_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payment Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `cash_pool_group` SET TAGS ('dbx_business_glossary_term' = 'Cash Pool Group');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `collection_method_enabled` SET TAGS ('dbx_business_glossary_term' = 'Collection Method Enabled');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `collection_method_enabled` SET TAGS ('dbx_value_regex' = 'wire|ach|sepa|lockbox|eft|direct_debit');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `customer_collection_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Collection Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `intercompany_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transfer Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `minimum_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `payment_method_enabled` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Enabled');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `payment_method_enabled` SET TAGS ('dbx_value_regex' = 'wire|ach|sepa|check|eft|rtgs');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Required Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication Business Identifier Code (SWIFT/BIC)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `bank_statement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Line ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `bank_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `house_bank_id` SET TAGS ('dbx_business_glossary_term' = 'House Bank ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `tax_account_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `bank_charges` SET TAGS ('dbx_business_glossary_term' = 'Bank Charges');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `bank_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Transaction Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Account Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `counterparty_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Bank Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `customer_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Reference');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit Credit Indicator');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `invoice_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Reference Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `manual_reconciliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Reconciliation Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|matched|cleared|exception|manual_review');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `statement_text` SET TAGS ('dbx_business_glossary_term' = 'Statement Text');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `vendor_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Reference');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `financial_control_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Control Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `primary_financial_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `primary_financial_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `primary_financial_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Document Workflow Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `application_system_name` SET TAGS ('dbx_business_glossary_term' = 'Application System Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `compensating_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensating Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_category` SET TAGS ('dbx_business_glossary_term' = 'Control Category');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_category` SET TAGS ('dbx_value_regex' = 'entity-level|transaction-level|it-general|it-application');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Control Code');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{3,5}$');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Control Deficiency Count');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Control Evidence Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Frequency');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Financial Control Name');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_nature` SET TAGS ('dbx_business_glossary_term' = 'Control Nature');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_nature` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_objective` SET TAGS ('dbx_business_glossary_term' = 'Control Objective');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_performer_role` SET TAGS ('dbx_business_glossary_term' = 'Control Performer Role');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_procedure` SET TAGS ('dbx_business_glossary_term' = 'Control Procedure');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_reviewer_role` SET TAGS ('dbx_business_glossary_term' = 'Control Reviewer Role');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under-review|retired');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective|directive');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `design_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Design Effectiveness Rating');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `design_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|needs-improvement|ineffective|not-assessed');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `ifrs_control_flag` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `key_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `last_test_result` SET TAGS ('dbx_business_glossary_term' = 'Last Test Result');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `last_test_result` SET TAGS ('dbx_value_regex' = 'passed|passed-with-exceptions|failed|not-applicable');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `next_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Test Due Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `operating_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Operating Effectiveness Rating');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `operating_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|needs-improvement|ineffective|not-tested');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Financial Process Area');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `segregation_of_duties_flag` SET TAGS ('dbx_business_glossary_term' = 'Segregation of Duties (SOD) Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `system_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'System Generated Flag');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `test_frequency` SET TAGS ('dbx_business_glossary_term' = 'Test Frequency');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `test_frequency` SET TAGS ('dbx_value_regex' = 'quarterly|semi-annually|annually|bi-annually|ad-hoc');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` SET TAGS ('dbx_association_edges' = 'finance.profit_center,sustainability.sustainability_target');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `target_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Target Allocation Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Target Allocation - Profit Center Id');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Target Allocation - Sustainability Target Id');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `allocated_baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Allocated Baseline Value');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `allocated_target_value` SET TAGS ('dbx_business_glossary_term' = 'Allocated Target Value');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `allocation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `allocation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Allocation Methodology');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Allocation Percentage');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `current_performance_value` SET TAGS ('dbx_business_glossary_term' = 'Current Performance Value');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `incentive_weight` SET TAGS ('dbx_business_glossary_term' = 'Incentive Compensation Weight');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ALTER COLUMN `performance_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `transport_shipping_ecm`.`finance`.`lease_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`lease_contract` SET TAGS ('dbx_subdomain' = 'asset_compliance');
ALTER TABLE `transport_shipping_ecm`.`finance`.`lease_contract` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`lease_contract` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`lease_contract` ALTER COLUMN `renewed_lease_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`capex_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`capex_project` SET TAGS ('dbx_subdomain' = 'asset_compliance');
ALTER TABLE `transport_shipping_ecm`.`finance`.`capex_project` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`capex_project` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`capex_project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`capex_project` ALTER COLUMN `parent_capex_project_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `house_bank_id` SET TAGS ('dbx_business_glossary_term' = 'House Bank Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `parent_house_bank_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`house_bank` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement` ALTER COLUMN `house_bank_id` SET TAGS ('dbx_business_glossary_term' = 'House Bank Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement` ALTER COLUMN `prior_bank_statement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` SET TAGS ('dbx_subdomain' = 'corporate_structure');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_element` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_element` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_element` ALTER COLUMN `parent_cost_element_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`project` SET TAGS ('dbx_subdomain' = 'asset_compliance');
ALTER TABLE `transport_shipping_ecm`.`finance`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`project` ALTER COLUMN `parent_project_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_subdomain' = 'asset_compliance');
ALTER TABLE `transport_shipping_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fund` SET TAGS ('dbx_subdomain' = 'asset_compliance');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fund` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fund` ALTER COLUMN `tax_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fund` ALTER COLUMN `tax_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fund` ALTER COLUMN `parent_fund_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fund` ALTER COLUMN `manager_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fund` ALTER COLUMN `manager_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fund` ALTER COLUMN `manager_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fund` ALTER COLUMN `manager_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fund` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`fund` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`commitment_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`commitment_item` SET TAGS ('dbx_subdomain' = 'asset_compliance');
ALTER TABLE `transport_shipping_ecm`.`finance`.`commitment_item` ALTER COLUMN `commitment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Commitment Item Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`commitment_item` ALTER COLUMN `parent_commitment_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`controlling_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`controlling_area` SET TAGS ('dbx_subdomain' = 'corporate_structure');
ALTER TABLE `transport_shipping_ecm`.`finance`.`controlling_area` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`controlling_area` ALTER COLUMN `parent_controlling_area_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`credit_control_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`credit_control_area` SET TAGS ('dbx_subdomain' = 'corporate_structure');
ALTER TABLE `transport_shipping_ecm`.`finance`.`credit_control_area` ALTER COLUMN `credit_control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Control Area Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`credit_control_area` ALTER COLUMN `parent_credit_control_area_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_proposal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_proposal` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_proposal` ALTER COLUMN `payment_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Proposal Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_proposal` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_proposal` ALTER COLUMN `revised_payment_proposal_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'corporate_structure');
ALTER TABLE `transport_shipping_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`legal_entity` ALTER COLUMN `parent_legal_entity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`legal_entity` ALTER COLUMN `authorized_share_capital` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`legal_entity` ALTER COLUMN `paid_up_capital` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` SET TAGS ('dbx_subdomain' = 'corporate_structure');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `bank_routing_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `bank_routing_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `registered_address_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `registered_address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `registered_address_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `registered_address_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`finance`.`party` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
