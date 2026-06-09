-- Schema for Domain: finance | Business: Grocery | Version: v1_ecm
-- Generated on: 2026-05-04 18:34:56

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`finance` COMMENT 'Financial accounting, general ledger, accounts payable/receivable, cost centers, budgeting, and SOX compliance. Manages COGS, EBITDA reporting, comp sales and same-store sales metrics, shrink financial impact, and financial consolidation. Integrates with SAP FI/CO modules and supports GAAP-compliant regulatory financial disclosures and audit trails.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Primary key for gl_account',
    `account_code` STRING COMMENT 'The externally-known alphanumeric GL account number as defined in the SAP FI Chart of Accounts (SKA1 table). This is the primary business identifier used across all financial postings, journal entries, and regulatory disclosures. Typically a 6–10 digit numeric code aligned with the companys chart of accounts structure.. Valid values are `^[0-9]{6,10}$`',
    `account_group_code` STRING COMMENT 'SAP FI account group (KTOKS) that controls the number range and field status for the GL account. Groups accounts by functional category such as balance sheet accounts, P&L accounts, cost accounts, or reconciliation accounts. Used for mass maintenance and reporting segmentation.',
    `account_hierarchy_level` STRING COMMENT 'Numeric level within the GL account hierarchy structure (e.g., 1=top-level group, 5=detail posting account). Supports financial statement rollup, management reporting hierarchies, and drill-down analytics in EBITDA and comp sales dashboards.',
    `account_long_name` STRING COMMENT 'Extended descriptive name for the GL account providing additional context beyond the short name. Used in detailed financial disclosures, SOX audit documentation, and ERP configuration reports.',
    `account_name` STRING COMMENT 'The human-readable short description or title of the GL account as maintained in SAP FI (SKAT table). Used in financial reports, trial balances, and audit documentation. Example: Cost of Goods Sold – Grocery, Accounts Payable – Trade.',
    `account_status` STRING COMMENT 'Current lifecycle status of the GL account. active accounts accept financial postings; blocked accounts are temporarily restricted from new postings; marked_for_deletion accounts are pending archival; inactive accounts are retired but retained for historical reporting. Corresponds to SAP FI account blocking indicators.. Valid values are `active|blocked|marked_for_deletion|inactive`',
    `account_type` STRING COMMENT 'High-level GAAP classification of the GL account indicating its role in financial statements. Maps to SAP FI KTOKS field. asset and liability accounts appear on the balance sheet; revenue and expense accounts appear on the P&L (income statement); equity accounts appear in the statement of equity.. Valid values are `asset|liability|equity|revenue|expense`',
    `alternative_account_code` STRING COMMENT 'Country-specific or group-level alternative account number used for statutory reporting or financial consolidation mapping. Corresponds to SAP FI ALTKT field. Used when Grocery must report under multiple chart of accounts structures (e.g., local GAAP vs. group GAAP).',
    `balance_sheet_account_indicator` BOOLEAN COMMENT 'Indicates whether this is a balance sheet account (True) or a profit and loss (P&L) income statement account (False). Balance sheet accounts carry forward balances at year-end; P&L accounts are closed to retained earnings. Corresponds to SAP FI XBILK field in SKA1.',
    `chart_of_accounts_code` STRING COMMENT 'The SAP chart of accounts key (e.g., GROC) that this GL account belongs to. Grocery may maintain multiple charts of accounts for different legal entities or country-specific GAAP requirements. Corresponds to the KTOPL field in SAP FI SKA1.. Valid values are `^[A-Z0-9]{4}$`',
    `cogs_account_indicator` BOOLEAN COMMENT 'Indicates whether this GL account is classified as a Cost of Goods Sold (COGS) account. COGS accounts are used in gross margin and GMROI calculations, merchandise planning analysis, and EBITDA reporting. Supports Oracle Retail Merchandising System and SAP FI/CO integration for cost flow tracking.',
    `commitment_management_indicator` BOOLEAN COMMENT 'Indicates whether this GL account participates in SAP CO commitment management, tracking purchase order commitments and budget reservations before actual expenditure. Relevant for capital expenditure accounts, store renovation budgets, and DC equipment procurement.',
    `cost_element_category` STRING COMMENT 'SAP Controlling (CO) cost element category indicating whether this GL account is a primary cost element (direct costs posted from FI, e.g., COGS, labor), a secondary cost element (internal allocations, overhead), or not applicable (balance sheet accounts). Drives cost center accounting, EBITDA reporting, and shrink financial impact analysis.. Valid values are `primary|secondary|not_applicable`',
    `cost_element_type` STRING COMMENT 'Granular classification of the cost element within SAP CO, such as material costs, personnel costs, depreciation, overhead allocation, revenue. Supports detailed cost center reporting and profitability analysis (CO-PA) across store banners. [ENUM-REF-CANDIDATE: material_costs|personnel_costs|depreciation|overhead_allocation|revenue|settlement|assessment|distribution — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this GL account record was first created in the source system (SAP FI). Provides the audit trail creation point required for SOX compliance and data lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code in which this GL account is maintained (e.g., USD). Grocery operates primarily in USD but may maintain foreign currency accounts for international vendor transactions or cross-border operations. Corresponds to SAP FI WAERS field.. Valid values are `^[A-Z]{3}$`',
    `effective_from_date` DATE COMMENT 'The date from which this GL account became active and available for financial postings. Supports time-based account validity controls, ensuring accounts are only used within their authorized period. Corresponds to SAP FI account validity start date.',
    `effective_to_date` DATE COMMENT 'The date after which this GL account is no longer valid for new financial postings. Null indicates the account has no defined end date and remains open-ended. Supports account lifecycle management and year-end close procedures.',
    `field_status_group` STRING COMMENT 'SAP FI field status group (FSTAG) assigned to this GL account, controlling which fields are required, optional, or suppressed during document entry. Ensures data completeness for cost center, profit center, and business area assignments on postings. Critical for CO integration and reporting accuracy.. Valid values are `^G[0-9]{3}$`',
    `financial_statement_section` STRING COMMENT 'The primary financial statement section where this GL account is reported. Drives financial consolidation mapping and GAAP-compliant disclosure preparation. Used in EBITDA reporting, comp sales analysis, and SOX financial reporting controls.. Valid values are `balance_sheet|income_statement|cash_flow|equity_statement`',
    `functional_area` STRING COMMENT 'SAP FI/CO functional area classification used for cost-of-sales accounting and segment reporting. Segments expenses by business function such as manufacturing, sales, administration, research_development. Supports GAAP income statement by function presentation and SEC segment disclosures. [ENUM-REF-CANDIDATE: store_operations|supply_chain|merchandising|pharmacy|administration|marketing|finance|it|fuel_operations — promote to reference product]',
    `gaap_classification` STRING COMMENT 'Detailed GAAP line-item classification for the account, such as Current Assets, Long-Term Liabilities, Cost of Goods Sold (COGS), Selling General and Administrative (SG&A), Depreciation and Amortization. Supports EBITDA calculation, COGS tracking, and SEC financial disclosure. [ENUM-REF-CANDIDATE: current_assets|non_current_assets|current_liabilities|non_current_liabilities|equity|net_revenue|cogs|gross_profit|sga|depreciation_amortization|interest_expense|income_tax|other_income_expense — promote to reference product]',
    `house_bank_account_indicator` BOOLEAN COMMENT 'Indicates whether this GL account is a bank account (house bank) used for cash management and treasury operations. Bank accounts require special reconciliation procedures and are subject to PCI DSS controls for payment processing. Supports daily cash position reporting and bank reconciliation.',
    `ifrs_mapping_code` STRING COMMENT 'IFRS account mapping code for international financial reporting or cross-border consolidation purposes. Used when Grocery operates entities in jurisdictions requiring IFRS reporting alongside US GAAP. Supports dual-ledger accounting in SAP FI parallel ledger configuration.',
    `intercompany_account_indicator` BOOLEAN COMMENT 'Indicates whether this GL account is used for intercompany transactions between Grocerys legal entities (e.g., store banners, distribution centers, pharmacy subsidiaries). Intercompany accounts require elimination during financial consolidation. Supports SOX-compliant consolidation and GAAP ASC 810 requirements.',
    `is_posting_allowed` BOOLEAN COMMENT 'Indicates whether direct financial postings are permitted to this GL account. False for summary/header accounts that only aggregate child accounts, or for accounts blocked for posting. Corresponds to SAP FI XLOEV (account blocked for posting) flag.',
    `is_reconciliation_account` BOOLEAN COMMENT 'Indicates whether this GL account is a reconciliation account for a subledger (Accounts Payable, Accounts Receivable, or Asset Accounting). Reconciliation accounts cannot receive direct manual postings; they are updated automatically from subledger transactions. Critical for AP/AR balance integrity and SOX controls.',
    `is_tax_relevant` BOOLEAN COMMENT 'Indicates whether this GL account is subject to tax reporting obligations. True for accounts involving taxable sales, purchases, or excise duties (e.g., fuel center, alcohol, tobacco). Supports tax compliance reporting and FTC regulatory filings.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this GL account record in the source system. Supports change tracking, SOX audit trail requirements, and incremental data loading in the Databricks Silver Layer pipeline.',
    `line_item_display` BOOLEAN COMMENT 'Indicates whether individual line items are stored and displayable for this GL account in SAP FI. When True, auditors and finance analysts can drill down to individual posting details. Required for SOX audit trails and GAAP disclosure support. Corresponds to SAP FI XKRES field.',
    `open_item_management` BOOLEAN COMMENT 'Indicates whether open item management is activated for this GL account. When True, individual line items remain open until cleared by a matching offsetting entry (e.g., GR/IR clearing accounts, bank clearing accounts). Essential for AP/AR reconciliation and month-end close processes.',
    `parent_account_code` STRING COMMENT 'The account code of the parent/summary account in the GL hierarchy. Enables hierarchical rollup of financial balances for management reporting, financial consolidation, and EBITDA calculation. Null for top-level accounts.',
    `planning_account_indicator` BOOLEAN COMMENT 'Indicates whether this GL account is used in SAP CO budgeting and planning processes. Planning accounts are included in annual budget cycles, labor budget planning (Kronos integration), and Blue Yonder demand planning financial inputs. Supports comp sales and same-store sales budget vs. actual analysis.',
    `profit_loss_statement_account_type` STRING COMMENT 'Classifies P&L accounts into their income statement reporting category for EBITDA calculation, comp sales analysis, and same-store sales reporting. cogs accounts feed COGS tracking; ebitda_component accounts are used in EBITDA reporting. Not applicable for balance sheet accounts. [ENUM-REF-CANDIDATE: net_revenue|cogs|gross_profit|operating_expense|ebitda_component|interest|tax|not_applicable — 8 candidates stripped; promote to reference product]',
    `reconciliation_account_type` STRING COMMENT 'Specifies the subledger type this reconciliation account is linked to. Applicable only when is_reconciliation_account is True. Drives AP/AR aging reports, vendor payment reconciliation, and fixed asset depreciation schedules.. Valid values are `accounts_payable|accounts_receivable|fixed_assets|not_applicable`',
    `shrink_account_indicator` BOOLEAN COMMENT 'Indicates whether this GL account is designated for recording shrink (inventory loss from theft, spoilage, or damage). Shrink accounts are critical for fresh produce and perishable inventory financial impact tracking, GMROI analysis, and loss prevention reporting across store banners.',
    `sort_key` STRING COMMENT 'SAP FI sort key (ZUAWA) that determines the assignment field populated in line items posted to this account. Controls how line items are sorted and displayed in account statements. Common values: 001 (posting date), 003 (document number), 031 (vendor invoice number). Supports efficient account reconciliation.. Valid values are `^[0-9]{3}$`',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this GL account was sourced. Primarily SAP_FI for the SAP Financial Accounting module. Supports data lineage, reconciliation between source systems, and Silver Layer provenance tracking.. Valid values are `SAP_FI|ORACLE_RMS|MANUAL`',
    `sox_relevant_indicator` BOOLEAN COMMENT 'Indicates whether this GL account is in scope for SOX Section 302/404 internal controls testing and audit. SOX-relevant accounts require documented controls, segregation of duties, and periodic reconciliation sign-off. Critical for Grocerys external audit and SEC financial reporting compliance.',
    `tax_category` STRING COMMENT 'SAP FI tax category assigned to the GL account, controlling whether tax codes are required, optional, or not allowed during posting. Relevant for sales tax on grocery transactions, fuel excise tax, and pharmacy prescription tax exemptions. Corresponds to SAP FI MWSKZ field. [ENUM-REF-CANDIDATE: input_tax_required|output_tax_required|tax_optional|no_tax|exempt — promote to reference product]',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'General ledger chart of accounts master for Grocery, aligned with SAP FI module. Defines all GL account codes, account types (P&L, balance sheet), cost element categories, and GAAP classification. Serves as the authoritative account structure for financial consolidation, COGS tracking, EBITDA reporting, and SOX audit compliance across all store banners and legal entities.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Primary key for cost_center',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: cost_center should link to GL account master for proper account hierarchy; gl_account_id replaces gl_account_code.',
    `activity_type_code` STRING COMMENT 'SAP CO activity type code associated with this cost center, representing the primary type of work or service output produced (e.g., LABOR_HRS, MACHINE_HRS, DELIVERY_UNITS). Used for activity-based costing, internal order settlements, and COGS allocation.. Valid values are `^[A-Z0-9_]{1,10}$`',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total approved annual budget allocated to this cost center for the current budget period, expressed in the cost centers operating currency. Used for budget vs. actual variance analysis, EBITDA reporting, and financial planning. Sourced from SAP CO cost center planning (KP06).',
    `budget_period` STRING COMMENT 'The fiscal year for which the current budget plan is active for this cost center (e.g., 2025). Used to scope budget vs. actual variance analysis, EBITDA reporting, and departmental P&L reviews.. Valid values are `^[0-9]{4}$`',
    `business_area_code` STRING COMMENT 'SAP FI business area assigned to this cost center, representing a distinct area of operations for internal balance sheet and P&L reporting (e.g., Grocery Retail, Pharmacy, Fuel). Supports segment-level financial disclosures.. Valid values are `^[A-Z0-9]{1,10}$`',
    `chart_of_accounts_code` STRING COMMENT 'SAP FI chart of accounts code applicable to this cost centers company code. Defines the set of GL accounts available for cost postings. Ensures consistency in financial reporting across Grocerys legal entities.. Valid values are `^[A-Z0-9]{1,10}$`',
    `company_code` STRING COMMENT 'SAP FI company code representing the legal entity to which this cost center belongs. Used for statutory financial reporting, GAAP-compliant disclosures, and SOX audit trails. Enables financial consolidation across Grocerys legal entities.. Valid values are `^[A-Z0-9]{1,10}$`',
    `controlling_area_code` STRING COMMENT 'SAP CO controlling area to which this cost center belongs. The controlling area defines the organizational unit within which cost accounting is performed. All cost centers within a controlling area share the same chart of accounts and fiscal year variant.. Valid values are `^[A-Z0-9]{1,10}$`',
    `cost_center_category` STRING COMMENT 'SAP CO cost center category code (single or two-character) that controls which activity types and statistical key figures can be posted to this cost center. Common values include A (General), B (Administration), F (Production), H (Auxiliary). Governs posting rules and planning behavior in SAP CO.. Valid values are `^[A-Z0-9]{1,2}$`',
    `cost_center_code` STRING COMMENT 'The externally-known alphanumeric code assigned to the cost center in SAP CO, used across financial reporting, budgeting, and interoperability with ERP systems. Serves as the business-facing identifier (e.g., CC-STORE-0042, CC-DC-WEST-01).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `cost_center_name` STRING COMMENT 'Human-readable descriptive name of the cost center as maintained in SAP CO (e.g., Store 042 - Produce Department, Distribution Center West - Receiving, Pharmacy - Store 101). Used in financial reports, P&L statements, and budget dashboards.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. active — open for cost postings and budget planning; inactive — temporarily suspended; locked — blocked for new postings (SAP CO lock indicator); pending_activation — created but not yet effective; closed — permanently decommissioned after validity end date.. Valid values are `active|inactive|locked|pending_activation|closed`',
    `cost_center_type` STRING COMMENT 'Categorical classification of the cost center indicating the type of organizational unit it represents within Grocerys operations. Drives departmental P&L segmentation, shrink financial impact allocation, and labor cost attribution. [ENUM-REF-CANDIDATE: store|distribution_center|pharmacy|fuel_center|corporate|administrative|manufacturing|logistics — promote to reference product if additional types are needed]. Valid values are `store|distribution_center|pharmacy|fuel_center|corporate|administrative`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost center master record was first created in the source system (SAP CO). Used for audit trail, SOX compliance documentation, and data lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost centers operating currency (e.g., USD). Defines the currency in which budget, actual costs, and variances are recorded and reported for this cost center.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Internal department code associated with this cost center, used for departmental P&L reporting and labor cost attribution. Aligns with Grocerys organizational structure (e.g., Produce, Bakery, Deli, Pharmacy, Fuel, Receiving, Corporate Finance).. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `division_code` STRING COMMENT 'Organizational division code to which this cost center belongs (e.g., GROCERY_RETAIL, PHARMACY, FUEL_OPERATIONS, ECOMMERCE). Supports divisional P&L reporting, EBITDA segmentation, and same-store sales analysis by business division.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `fiscal_year_variant` STRING COMMENT 'SAP FI fiscal year variant code that defines the fiscal year structure (number of periods, start/end months) applicable to this cost center. Grocery typically uses a 52/53-week fiscal year. Drives period-based budget and actual cost comparisons.. Valid values are `^[A-Z0-9]{2}$`',
    `functional_area_code` STRING COMMENT 'SAP CO functional area classification used to differentiate cost by business function (e.g., Cost of Goods Sold, Selling, General & Administrative, Research & Development). Enables COGS vs. SG&A split in income statement reporting per GAAP.. Valid values are `^[A-Z0-9_]{1,16}$`',
    `hierarchy_area` STRING COMMENT 'The node within the SAP CO standard cost center hierarchy to which this cost center is assigned. Enables roll-up reporting across organizational levels (e.g., region, division, banner). Used for enterprise-wide P&L consolidation, EBITDA reporting, and comp sales analysis.',
    `is_locked_for_actual` BOOLEAN COMMENT 'Indicates whether this cost center is locked for actual cost postings (True). When locked, no actual costs can be posted to this cost center in SAP CO. Used during period-end close, audit periods, or when a cost center is being decommissioned.',
    `is_locked_for_plan` BOOLEAN COMMENT 'Indicates whether this cost center is locked for plan (budget) postings (True). When locked, no budget updates can be made to this cost center in SAP CO. Used to freeze budgets after approval for SOX compliance.',
    `is_statistical` BOOLEAN COMMENT 'Indicates whether this cost center is a statistical cost center (True) used only for informational/reporting purposes without actual cost postings, or a real cost center (False) that accumulates actual costs. Statistical cost centers are used in SAP CO for parallel reporting structures.',
    `labor_budget_amount` DECIMAL(18,2) COMMENT 'Portion of the annual budget specifically allocated to labor costs (wages, salaries, benefits) for this cost center. Enables labor cost attribution analysis, workforce planning integration with Kronos/Workday HCM, and COGS labor component reporting.',
    `last_changed_by` STRING COMMENT 'SAP user ID of the person who last modified this cost center master record. Required for SOX compliance audit trails to establish accountability for master data changes. Corresponds to SAP CO change document user field.',
    `last_changed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this cost center master record in SAP CO. Used for change tracking, SOX audit trails, and incremental data load processing in the Databricks Silver Layer.',
    `location_type` STRING COMMENT 'Physical location type associated with this cost center. Distinguishes between store-level, DC (Distribution Center), MFC (Micro-Fulfillment Center), corporate office, fuel center, and pharmacy cost centers for geographic and operational segmentation in financial reporting.. Valid values are `store|distribution_center|micro_fulfillment_center|corporate_office|fuel_center|pharmacy`',
    `overhead_rate` DECIMAL(18,2) COMMENT 'The overhead allocation rate applied to this cost center, expressed as a decimal percentage (e.g., 0.1250 = 12.50%). Used in SAP CO overhead costing sheets to allocate indirect costs (e.g., corporate overhead, DC overhead) to store or department cost centers for full-absorption costing and COGS calculation.',
    `profit_center_code` STRING COMMENT 'The SAP CO profit center to which this cost center is assigned. Profit centers represent autonomous business units for internal P&L reporting (e.g., individual stores, pharmacy division, fuel operations). Enables same-store sales and comp sales analysis at the profit center level.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `region_code` STRING COMMENT 'Geographic region code to which this cost center belongs (e.g., NORTHEAST, SOUTHEAST, WEST). Used for regional P&L roll-up, comp sales analysis by region, and regional budget variance reporting.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `settlement_rule_code` STRING COMMENT 'SAP CO settlement rule code that defines how costs accumulated on this cost center are settled (allocated) to other cost objects (e.g., other cost centers, internal orders, profitability segments). Drives period-end cost allocation and COGS calculation.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `short_name` STRING COMMENT 'Abbreviated name of the cost center used in condensed financial reports, POS system displays, and space-constrained UI contexts. Corresponds to the SAP CO short text field (up to 20 characters).. Valid values are `^.{1,20}$`',
    `shrink_allocation_flag` BOOLEAN COMMENT 'Indicates whether this cost center participates in shrink (inventory loss from theft, spoilage, or damage) financial impact allocation (True). When enabled, shrink costs calculated from inventory management systems are allocated to this cost center for departmental P&L and COGS reporting.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this cost center master record was sourced (e.g., SAP_CO for SAP Controlling, SAP_FI for SAP Financial Accounting). Supports data lineage, reconciliation, and Silver Layer provenance tracking.. Valid values are `SAP_CO|SAP_FI|ORACLE_RMS|MANUAL`',
    `validity_end_date` DATE COMMENT 'The date through which this cost center is active and valid for cost postings. Corresponds to the SAP CO validity period end date. A value of 9999-12-31 indicates an open-ended (indefinite) validity. Cost postings after this date are blocked.',
    `validity_start_date` DATE COMMENT 'The date from which this cost center is active and valid for cost postings and budget planning. Corresponds to the SAP CO validity period start date. Cost postings before this date are not permitted.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'SAP CO cost center master representing organizational units responsible for cost accumulation — stores, distribution centers, pharmacy departments, fuel centers, and corporate functions. Tracks cost center hierarchy, responsible manager, controlling area, profit center assignment, and budget period validity. Enables departmental P&L, shrink financial impact allocation, and labor cost attribution.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Primary key for profit_center',
    `banner_code` STRING COMMENT 'The retail banner or brand under which this profit center operates (e.g., KROGER, RALPHS, FREDS, HARRIS). Used for banner-level comp sales and same-store sales reporting.. Valid values are `^[A-Z0-9]{2,6}$`',
    `business_area_code` STRING COMMENT 'SAP business area for cross-company-code reporting and internal financial statements by line of business (e.g., grocery retail, pharmacy, fuel).. Valid values are `^[A-Z0-9]{4}$`',
    `closure_date` DATE COMMENT 'The date this profit center was permanently closed. Null for active profit centers. Used for historical analysis and asset impairment calculations.',
    `comp_sales_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this profit center is eligible for comp sales (comparable store sales) reporting. True if the location has been open for at least 12 months and meets comp sales criteria.',
    `company_code` STRING COMMENT 'The SAP FI company code representing the legal entity to which this profit center belongs. Required for legal consolidation and SOX compliance reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area_code` STRING COMMENT 'The SAP Controlling Area to which this profit center is assigned. Controlling area represents the organizational unit for cost accounting and internal management reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_code` STRING COMMENT 'The default cost center associated with this profit center for overhead allocation and indirect cost assignment.. Valid values are `^[A-Z0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this profit center master record was first created in the SAP CO system. Used for audit trail and SOX compliance.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for this profit centers local currency (e.g., USD, CAD, MXN). Used for multi-currency consolidation and EBITDA reporting.. Valid values are `^[A-Z]{3}$`',
    `department_count` STRING COMMENT 'The number of distinct departments or categories within this profit center (e.g., produce, meat, dairy, bakery, pharmacy, fuel). Used for assortment complexity analysis.',
    `district_code` STRING COMMENT 'The district code within a region, representing a cluster of stores managed by a district manager. Used for district-level P&L roll-up.. Valid values are `^[A-Z0-9]{2,6}$`',
    `employee_count` STRING COMMENT 'The current number of full-time equivalent (FTE) employees assigned to this profit center. Used for labor productivity and EBITDA per employee calculations.',
    `fiscal_year_variant` STRING COMMENT 'SAP fiscal year variant defining the fiscal calendar for this profit center (e.g., K4 for calendar year, V3 for 4-4-5 retail calendar).. Valid values are `^[A-Z0-9]{2}$`',
    `hierarchy_level` STRING COMMENT 'The hierarchical level of this profit center in the organizational structure (1=top-level, 2=division, 3=region, 4=store, etc.). Used for roll-up reporting and consolidation.',
    `last_modified_by_user` STRING COMMENT 'The SAP user ID of the person who last modified this profit center master record. Required for SOX audit trail and segregation of duties compliance.. Valid values are `^[A-Z0-9]{6,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent change to this profit center master record. Used for change tracking and audit trail.',
    `lock_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this profit center is locked for new postings. True when locked (no new transactions allowed), False when open for posting.',
    `market_code` STRING COMMENT 'The market or metropolitan area code (e.g., NYC, LAX, CHI). Used for market-level competitive analysis and same-store sales comparisons.. Valid values are `^[A-Z0-9]{2,6}$`',
    `opening_date` DATE COMMENT 'The date this profit center (store, pharmacy, fuel center) first opened for business. Used to calculate comp sales eligibility and age-based performance metrics.',
    `parent_profit_center_code` STRING COMMENT 'The code of the parent profit center in the hierarchy. Null for top-level profit centers. Enables roll-up of comp sales, same-store sales, and EBITDA by region or division.. Valid values are `^[A-Z0-9]{4,10}$`',
    `profit_center_code` STRING COMMENT 'The externally-known alphanumeric code identifying the profit center in SAP CO. Used in financial reports, general ledger postings, and management accounting documents.. Valid values are `^[A-Z0-9]{4,10}$`',
    `profit_center_description` STRING COMMENT 'Extended text description providing additional context about the profit centers purpose, scope, and business model (e.g., High-volume urban supermarket with full-service pharmacy and fuel center).',
    `profit_center_name` STRING COMMENT 'The full business name of the profit center (e.g., Store 1234 - Downtown Seattle, Pharmacy Division - West Region, Private Label Bakery).',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center: active (operational and posting transactions), inactive (temporarily suspended), planned (future opening), closed (permanently shut down).. Valid values are `active|inactive|planned|closed`',
    `profit_center_type` STRING COMMENT 'Classification of the profit center by business function: store-level P&L, banner-level aggregation, pharmacy operations, fuel center operations, distribution center, private-label brand division, or corporate overhead. [ENUM-REF-CANDIDATE: store|banner|pharmacy|fuel_center|distribution_center|private_label|corporate — 7 candidates stripped; promote to reference product]',
    `region_code` STRING COMMENT 'The geographic region code for this profit center (e.g., WEST, MIDWEST, SOUTH, NORTHEAST). Used for regional performance analysis and comp sales benchmarking.. Valid values are `^[A-Z0-9]{2,6}$`',
    `remodel_date` DATE COMMENT 'The date of the most recent major remodel or renovation. Significant remodels may reset comp sales eligibility timers.',
    `same_store_sales_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this profit center qualifies for same-store sales reporting (revenue comparison for existing locations year-over-year). Typically requires 13+ months of operation without major remodels.',
    `segment_code` STRING COMMENT 'The business segment classification for external financial reporting under IFRS/GAAP segment reporting requirements (e.g., RETAIL, PHARM, FUEL, PRIVLBL).. Valid values are `^[A-Z0-9]{2,6}$`',
    `short_name` STRING COMMENT 'Abbreviated name for the profit center used in reports and dashboards where space is limited.',
    `square_footage` DECIMAL(18,2) COMMENT 'The total retail square footage of the store or facility. Used to calculate sales per square foot and GMROI (Gross Margin Return on Investment) metrics.',
    `valid_from_date` DATE COMMENT 'The date from which this profit center is valid and can accept financial postings. Used for time-dependent master data and historical reporting.',
    `valid_to_date` DATE COMMENT 'The date until which this profit center is valid. Null for open-ended validity. Used to track store closures, division consolidations, and organizational changes.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'SAP CO profit center master representing autonomous business segments for internal profitability reporting — store-level, banner-level, pharmacy, fuel, and private-label divisions. Captures profit center hierarchy, assigned controlling area, segment classification, and validity periods. Supports comp sales, same-store sales, and EBITDA reporting by business unit.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity. Primary key for the legal entity master record.',
    `parent_legal_entity_id` BIGINT COMMENT 'Reference to the parent legal entity in the corporate hierarchy. Null for the ultimate parent holding company.',
    `primary_ultimate_parent_entity_legal_entity_id` BIGINT COMMENT 'Reference to the top-level parent legal entity in the corporate structure. Used for ultimate consolidation and group-level reporting.',
    `audit_firm_name` STRING COMMENT 'Name of the external audit firm responsible for auditing this legal entitys financial statements. Required for SOX-scoped and public entities.',
    `consolidation_group_code` STRING COMMENT 'Code identifying the consolidation group or reporting unit to which this legal entity belongs. Used for financial consolidation and intercompany elimination.. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this legal entity record was first created in the system. Used for audit trail and data lineage.',
    `dissolution_date` DATE COMMENT 'The date on which the legal entity was officially dissolved or ceased operations. Null for active entities.',
    `doing_business_as_name` STRING COMMENT 'Trade name or DBA name under which the legal entity operates. May differ from the legal name for customer-facing operations.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet. Used for credit reporting, vendor registration, and business identity verification.. Valid values are `^[0-9]{9}$`',
    `ein` STRING COMMENT 'Federal tax identification number issued by the IRS. Used for all federal tax filings, payroll, and financial reporting.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `entity_status` STRING COMMENT 'Current operational status of the legal entity. Active entities are operational and filing; inactive or dissolved entities are no longer conducting business.. Valid values are `active|inactive|dissolved|suspended|pending_formation`',
    `entity_type` STRING COMMENT 'The legal structure of the entity (e.g., corporation, LLC, partnership). Determines tax treatment, liability, and governance requirements.. Valid values are `corporation|limited_liability_company|partnership|sole_proprietorship|holding_company|subsidiary`',
    `fiscal_year_end_month` STRING COMMENT 'The month (1-12) in which the legal entitys fiscal year ends. Used for annual financial statement preparation and tax filing deadlines.',
    `fiscal_year_variant` STRING COMMENT 'Code representing the fiscal year calendar used by this legal entity. Determines period structure for financial reporting and consolidation in SAP FI.. Valid values are `^[A-Z0-9]{2,4}$`',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the primary currency in which the legal entity conducts business and maintains its books.. Valid values are `^[A-Z]{3}$`',
    `gaap_reporting_standard` STRING COMMENT 'The accounting standard framework used by this legal entity for financial reporting (US GAAP, IFRS, or local GAAP).. Valid values are `US_GAAP|IFRS|local_gaap`',
    `incorporation_date` DATE COMMENT 'The date on which the legal entity was officially incorporated or registered with the state. Used to calculate entity age and anniversary dates.',
    `last_audit_date` DATE COMMENT 'The date on which the most recent external financial audit was completed for this legal entity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this legal entity record was last updated. Used for change tracking and audit trail.',
    `legal_entity_code` STRING COMMENT 'Short alphanumeric code used to identify the legal entity in financial systems and reporting. Typically used in SAP FI company code configuration.. Valid values are `^[A-Z0-9]{4,20}$`',
    `legal_name` STRING COMMENT 'The full legal name of the entity as registered with the state or jurisdiction of incorporation. Used for all legal documents, contracts, and regulatory filings.',
    `naics_code` STRING COMMENT 'Six-digit code classifying the primary business activity of the legal entity. Used for industry benchmarking and regulatory reporting.. Valid values are `^[0-9]{6}$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for the legal entity.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary business contact or registered agent for the legal entity. Used for official communications and legal notices.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary business contact for the legal entity.. Valid values are `^+?[0-9]{10,15}$`',
    `public_company_flag` BOOLEAN COMMENT 'Indicates whether this legal entity is publicly traded on a stock exchange. Determines SEC reporting requirements and audit obligations.',
    `registered_address_line1` STRING COMMENT 'First line of the legal entitys registered address on file with the state. Used for official correspondence and legal service of process.',
    `registered_address_line2` STRING COMMENT 'Second line of the registered address (suite, floor, building). Optional field for additional address details.',
    `registered_city` STRING COMMENT 'City of the legal entitys registered address.',
    `registered_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the registered address.. Valid values are `^[A-Z]{3}$`',
    `registered_postal_code` STRING COMMENT 'ZIP code of the registered address. Supports 5-digit or 9-digit ZIP+4 format.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `registered_state` STRING COMMENT 'Two-letter US state code of the registered address.. Valid values are `^[A-Z]{2}$`',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code used for consolidated financial reporting. May differ from functional currency for foreign subsidiaries.. Valid values are `^[A-Z]{3}$`',
    `sic_code` STRING COMMENT 'Four-digit code classifying the primary business activity. Legacy classification system still used by SEC and some regulatory bodies.. Valid values are `^[0-9]{4}$`',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this legal entity is within the scope of SOX compliance and internal control testing. True for publicly traded entities and material subsidiaries.',
    `state_of_incorporation` STRING COMMENT 'Two-letter US state code where the legal entity is incorporated or registered. Determines governing law and annual filing requirements.. Valid values are `^[A-Z]{2}$`',
    `stock_exchange_code` STRING COMMENT 'Code identifying the primary stock exchange where the entitys shares are traded (e.g., NYSE, NASDAQ). Null for private entities.. Valid values are `^[A-Z]{3,4}$`',
    `stock_ticker_symbol` STRING COMMENT 'The ticker symbol under which the entitys shares are traded. Null for private entities.. Valid values are `^[A-Z]{1,5}$`',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the primary tax jurisdiction for the legal entity. Determines applicable tax rates and filing requirements.. Valid values are `^[A-Z]{2,3}$`',
    `vat_registration_number` STRING COMMENT 'VAT or sales tax registration number for entities operating in jurisdictions requiring VAT registration. Null for US-only entities without VAT obligations.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master record of all legal entities within the Grocery corporate structure — operating subsidiaries, holding companies, and banner-level legal registrations. Captures EIN, state of incorporation, fiscal year variant, functional currency, consolidation group membership, and SOX reporting scope flag. Drives financial consolidation and intercompany elimination workflows.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`fiscal_period` (
    `fiscal_period_id` BIGINT COMMENT 'Unique identifier for the fiscal period. Primary key.',
    `associate_id` BIGINT COMMENT 'User identifier of the finance team member who executed the period close. Required for SOX audit trail and segregation of duties compliance.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Fiscal periods belong to a legal entity; linking provides entity‑specific calendar context.',
    `prior_year_period_fiscal_period_id` BIGINT COMMENT 'Reference to the corresponding fiscal period in the prior fiscal year. Enables year-over-year comp sales and same-store sales calculations.',
    `budget_version` STRING COMMENT 'Identifier for the budget version applicable to this fiscal period (e.g., Original, Revised_Q2, Forecast). Supports budget vs actual variance analysis.',
    `business_day_count` STRING COMMENT 'Number of business operating days (excluding weekends and holidays) in this fiscal period. Used for labor budgeting and productivity metrics.',
    `calendar_month` STRING COMMENT 'The calendar month number (1-12) in which the fiscal period primarily falls. Supports calendar-based reporting and seasonality analysis.',
    `calendar_year` STRING COMMENT 'The calendar year (Gregorian) in which the majority of this fiscal period falls. Used for calendar-year reporting and external benchmarking.',
    `close_date` DATE COMMENT 'The actual calendar date when the fiscal period was closed and locked for posting. Null if period is still open. Critical for SOX compliance and audit trail.',
    `close_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the fiscal period close process was completed. Used for audit trail and SOX compliance documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiscal period record was first created in the system. Part of audit trail for data lineage.',
    `day_count` STRING COMMENT 'Total number of calendar days in this fiscal period. Used for daily rate calculations and pro-rata adjustments.',
    `exchange_rate_date` DATE COMMENT 'The date used for currency exchange rate determination for this fiscal period. Typically period-end date or average rate date for multi-currency consolidation.',
    `external_audit_required` BOOLEAN COMMENT 'Boolean flag indicating whether this fiscal period is subject to external audit review. Typically true for year-end and quarterly periods for publicly traded companies.',
    `fiscal_period_number` STRING COMMENT 'Sequential period number within the fiscal year (1-13 for 13-period retail calendar or 1-12 for standard calendar). Used for period-over-period comparisons and comp sales calculations.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter number (1-4) to which this period belongs. Supports quarterly financial reporting and EBITDA analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this period belongs (e.g., 2024, 2025). Aligns with Grocerys fiscal calendar and SAP FI fiscal year variant.',
    `gaap_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether financial reporting for this period follows GAAP standards. True for US-based public company reporting.',
    `is_current_period` BOOLEAN COMMENT 'Boolean flag indicating whether this is the current active fiscal period for transaction posting. True if current, false otherwise.',
    `is_leap_year` BOOLEAN COMMENT 'Boolean flag indicating whether the fiscal year containing this period is a leap year. Affects day count calculations and year-over-year comparisons.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiscal period record was last updated. Tracks changes to period status, close dates, and other attributes.',
    `notes` STRING COMMENT 'Free-text notes or comments about this fiscal period. May include information about special events, adjustments, calendar anomalies, or close process issues.',
    `period_end_date` DATE COMMENT 'The last calendar date of the fiscal period. Defines the end of the posting date range for transactions and triggers period-end close processes.',
    `period_name` STRING COMMENT 'Human-readable name or label for the fiscal period (e.g., FY2024-P01, January 2024, Q1-2024). Used in financial reports and dashboards.',
    `period_start_date` DATE COMMENT 'The first calendar date of the fiscal period. Defines the beginning of the posting date range for transactions.',
    `period_status` STRING COMMENT 'Current lifecycle status of the fiscal period. Controls whether transactions can be posted. Open allows posting, closed prevents new postings, locked is permanently closed, pending_close indicates close process is underway.. Valid values are `open|closed|locked|pending_close`',
    `period_type` STRING COMMENT 'Classification of the fiscal period. Regular periods are standard operating periods, adjustment periods are for accruals and corrections, special periods are for extraordinary events, year_end is the final closing period.. Valid values are `regular|adjustment|special|year_end`',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for financial reporting in this period (e.g., USD). Supports multi-currency consolidation and GAAP compliance.. Valid values are `^[A-Z]{3}$`',
    `sox_certification_date` DATE COMMENT 'Date when SOX certification and management attestation were completed for this fiscal period. Required for publicly traded companies.',
    `sox_certification_required` BOOLEAN COMMENT 'Boolean flag indicating whether this fiscal period requires SOX certification and management attestation. True for publicly traded company reporting periods.',
    `week_count` STRING COMMENT 'Number of weeks in this fiscal period. Typically 4 or 5 weeks for 4-4-5 retail calendar. Critical for normalizing comp sales and same-store sales metrics.',
    CONSTRAINT pk_fiscal_period PRIMARY KEY(`fiscal_period_id`)
) COMMENT 'Reference calendar defining Grocerys fiscal year structure — fiscal year, fiscal periods (4-4-5 or 13-period retail calendar), period open/close status, and posting date ranges. Aligned with SAP FI fiscal year variant. Controls period-end close sequencing, budget comparison periods, and comp sales period-over-period calculations.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry document. Primary key for the journal entry product.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each journal entry posts to a GL account; linking enables traceability to the account hierarchy.',
    `associate_id` BIGINT COMMENT 'The user ID of the person who created or entered this journal entry into the system. Used for SOX compliance audit trails and segregation of duties monitoring.',
    `quaternary_journal_posted_by_user_associate_id` BIGINT COMMENT 'The user ID of the person who posted this journal entry to the general ledger. Null if entry is parked but not yet posted. Used for SOX compliance segregation of duties monitoring.',
    `quinary_journal_parking_user_associate_id` BIGINT COMMENT 'The user ID of the person who parked this journal entry (saved without posting). Null if entry was never parked. Used for workflow tracking and segregation of duties monitoring.',
    `tertiary_journal_approved_by_user_associate_id` BIGINT COMMENT 'The user ID of the person who approved this journal entry for posting. Null if approval workflow is not required or entry is not yet approved. Used for SOX compliance segregation of duties and approval workflow tracking.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry was approved for posting. Null if not yet approved or approval not required. Used for approval workflow tracking and SOX compliance monitoring.',
    `baseline_payment_date` DATE COMMENT 'The baseline date used for payment term calculation in accounts payable processing. Typically the invoice date or goods receipt date. Used for payment due date calculation and cash flow forecasting.',
    `batch_input_session` STRING COMMENT 'The batch input session name if this journal entry was created via batch processing. Null for online entries. Used for batch processing tracking and error resolution.',
    `clearing_date` DATE COMMENT 'The date on which this journal entry was cleared or settled. Null if not yet cleared. Used for aging analysis and cash flow forecasting.',
    `clearing_document_number` STRING COMMENT 'The document number of the clearing entry that settled this journal entry. Null if not yet cleared. Used for accounts payable/receivable reconciliation and open item management.',
    `company_code` STRING COMMENT 'The legal entity or company code to which this journal entry belongs. Represents the smallest organizational unit for which a complete self-contained set of accounts can be drawn up for external reporting. Used for financial consolidation and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry record was first created in the system. Audit trail timestamp for SOX compliance and internal control monitoring.',
    `currency_code` STRING COMMENT 'The transaction currency in which the journal entry amounts are denominated. Three-letter ISO 4217 currency code (e.g., USD, EUR, GBP). Used for multi-currency reporting and foreign exchange gain/loss calculation.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date printed on the source document (invoice date, receipt date, contract date). May differ from posting date due to processing delays. Used for aging analysis and vendor/customer reconciliation.',
    `document_number` STRING COMMENT 'The externally-known unique document number assigned by the financial system (SAP FI document number). This is the business identifier used in audit trails and financial reporting.. Valid values are `^[A-Z0-9]{10}$`',
    `document_type` STRING COMMENT 'Classification of the journal entry document type. SA=General Ledger Document, KR=Vendor Invoice, DR=Customer Invoice, AB=Accounting Document, KG=Vendor Credit Memo, DZ=Payment Document. Determines posting rules and account determination logic.. Valid values are `SA|KR|DR|AB|KG|DZ`',
    `entry_date` DATE COMMENT 'The date when the journal entry was first created or entered into the system by the user. Audit trail timestamp for SOX compliance and internal control monitoring.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate used to convert transaction currency amounts to local currency amounts. Null if transaction currency equals local currency. Used for foreign exchange gain/loss calculation and multi-currency consolidation.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year to which this journal entry is assigned. Typically 1-12 for monthly periods, or 1-13 if a 13th adjusting period is used. Critical for period-end close and monthly financial reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this journal entry is assigned. Used for year-end close, annual financial statement preparation, and multi-year comparative reporting.',
    `header_text` STRING COMMENT 'Free-form text description at the document header level providing context or explanation for the journal entry. Used for audit trail documentation and user communication.',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry represents an intercompany transaction between two company codes within the Grocery enterprise. True if intercompany, False otherwise. Used for intercompany reconciliation and elimination entries in consolidated financial statements.',
    `ledger_group` STRING COMMENT 'The ledger or ledger group to which this journal entry is posted. 0L=Leading Ledger (GAAP), 2L=IFRS Ledger, 9Z=Management Reporting Ledger. Supports parallel accounting for multiple accounting standards.. Valid values are `0L|2L|9Z`',
    `local_currency_code` STRING COMMENT 'The local (company code) currency in which amounts are also stored for statutory reporting. Three-letter ISO 4217 currency code. Typically USD for US-based grocery operations.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry was last modified. Null if never modified after creation. Audit trail timestamp for SOX compliance and change tracking.',
    `parking_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry was parked. Null if entry was never parked. Used for workflow tracking and aging analysis of parked documents.',
    `payment_block_code` STRING COMMENT 'Code indicating a payment block preventing automatic payment processing. Null if no block exists. Used for payment exception management and vendor dispute resolution.',
    `payment_method_code` STRING COMMENT 'Code indicating the payment method for this journal entry. C=Check, T=Wire Transfer, W=ACH, Z=Other. Used for payment processing and cash management.. Valid values are `C|T|W|Z`',
    `payment_terms_code` STRING COMMENT 'The payment terms code defining the due date calculation and discount terms for this journal entry. Used for accounts payable aging, cash flow forecasting, and early payment discount analysis.',
    `posted_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry was posted to the general ledger. Null if entry is parked but not yet posted. Used for posting workflow tracking and audit trail analysis.',
    `posting_date` DATE COMMENT 'The date on which the journal entry is posted to the general ledger. This is the principal business event date that determines which fiscal period the transaction affects. Used for period-end close, trial balance, and financial statement generation.',
    `posting_status` STRING COMMENT 'Current lifecycle status of the journal entry. Posted=finalized and affecting GL balances, Parked=saved but not yet posted, Cleared=settled against another document, Reversed=negated by reversal entry, Cancelled=voided before posting.. Valid values are `posted|parked|cleared|reversed|cancelled`',
    `reference_document_number` STRING COMMENT 'External reference number from the source document (vendor invoice number, customer order number, check number, wire transfer reference). Used for reconciliation and audit trail linkage to source documents.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a reversal of a prior entry. True if this document reverses another document, False otherwise. Used for accrual reversal processing and error correction tracking.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for reversal. 01=Accrual Reversal, 02=Error Correction, 03=Period-End Adjustment, 04=Reclassification, 05=Duplicate Entry, 06=Other. Used for internal control monitoring and audit trail analysis.. Valid values are `01|02|03|04|05|06`',
    `reversed_document_number` STRING COMMENT 'The document number of the original journal entry that this entry reverses. Null if this is not a reversal entry. Used to maintain audit trail linkage between original and reversing entries.',
    `source_system_code` STRING COMMENT 'Code identifying the source system or module that originated this journal entry. SAP_FI=Financial Accounting, SAP_CO=Controlling, SAP_MM=Materials Management, SAP_SD=Sales and Distribution, POS=Point of Sale, WMS=Warehouse Management System, MANUAL=Manual Entry. Used for data lineage tracking and reconciliation. [ENUM-REF-CANDIDATE: SAP_FI|SAP_CO|SAP_MM|SAP_SD|POS|WMS|MANUAL — 7 candidates stripped; promote to reference product]',
    `tax_reporting_date` DATE COMMENT 'The date used for tax reporting purposes. May differ from posting date due to tax jurisdiction rules. Used for sales tax remittance reporting, fuel excise tax reporting, and pharmacy dispensing tax compliance.',
    `trading_partner_company_code` STRING COMMENT 'The company code of the intercompany trading partner if this is an intercompany transaction. Null for non-intercompany entries. Used for intercompany reconciliation and automated elimination entry generation.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Core general ledger posting document capturing all financial transactions in the Grocery ledger — standard postings, accruals, reversals, intercompany entries, shrink postings, tax postings (sales tax, fuel excise, pharmacy dispensing tax), and period-end adjustments. Contains both header metadata (document number, document type, posting date, fiscal period, company code, reference, reversal indicator, approval chain, parking status) and line-item detail (line number, debit/credit indicator, GL account, cost center, profit center, WBS element, amount in transaction and local currency, tax code, tax jurisdiction, assignment field, text). The single authoritative audit trail for all financial activity, supporting COGS analysis, EBITDA reporting, SOX compliance, state/local tax remittance reporting, and trial balance generation.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts payable invoice record. Primary key for the AP invoice lifecycle from receipt through payment clearing.',
    `associate_id` BIGINT COMMENT 'Identifier of the associate (manager or finance analyst) who approved the invoice for payment. Supports audit trail and SOX compliance for segregation of duties.',
    `bank_account_id` BIGINT COMMENT 'Identifier of the company bank account from which payment was disbursed. Supports multi-bank operations and cash management reporting.',
    `cost_center_id` BIGINT COMMENT 'The cost center to which this invoice expense is allocated. Used for departmental budgeting, variance analysis, and management accounting. Typically applies to non-merchandise invoices (services, utilities, supplies).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: ap_invoice needs a proper reference to the GL account master; gl_account_id replaces gl_account_code for normalization.',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the warehouse or store goods receipt document used in three-way match. Confirms physical receipt of merchandise or materials before invoice approval.',
    `payment_run_id` BIGINT COMMENT 'Identifier of the SAP automatic payment program run (F110) that processed this invoice. Groups invoices paid together in a batch for reconciliation and audit purposes.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the originating purchase order for three-way match validation (PO, goods receipt, invoice). Null for non-PO invoices such as utility bills, rent, or service agreements.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: Freight Invoice Reconciliation: AP Invoice for carrier freight must reference the Shipment it settles, enabling the Freight Cost Reconciliation report.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier who issued this invoice. Links to the vendor master record for merchandise suppliers, DSD (Direct Store Delivery) vendors, service providers, and operational expense vendors.',
    `approval_date` DATE COMMENT 'The date the invoice was approved for payment. Used to measure approval cycle time and identify bottlenecks in the AP workflow.',
    `approval_status` STRING COMMENT 'Current state of the invoice in the approval workflow. Tracks manager or finance approval for invoices requiring authorization before payment, supporting SOX internal control requirements.. Valid values are `pending|approved|rejected|escalated`',
    `cleared_amount` DECIMAL(18,2) COMMENT 'The actual amount paid to the vendor after applying any last-minute adjustments, discounts taken, or partial payments. May differ from net_amount if early payment discount was exercised.',
    `clearing_date` DATE COMMENT 'The date the invoice was cleared in the GR/IR clearing account, completing the procure-to-pay cycle. Indicates the invoice liability has been settled in the general ledger.',
    `company_code` STRING COMMENT 'The legal entity or subsidiary code within the enterprise structure. Supports multi-entity financial consolidation and SOX (Sarbanes-Oxley) compliance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the accounts payable system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice (e.g., USD, CAD, MXN). Supports multi-currency operations and foreign exchange reporting.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The discount amount available if payment is made within the early payment discount period (e.g., 2% if paid within 10 days). Supports cash flow optimization and vendor relationship management.',
    `discount_taken_amount` DECIMAL(18,2) COMMENT 'The actual early payment discount amount deducted at payment time. Tracks discount capture performance and vendor payment optimization.',
    `due_date` DATE COMMENT 'The date by which payment must be made to the vendor per the agreed payment terms. Calculated from invoice date plus payment term days (e.g., Net 30, Net 60).',
    `edi_810_reference` STRING COMMENT 'Reference number for the EDI 810 electronic invoice transaction received from the vendor. Supports automated invoice processing and vendor integration via EDI (Electronic Data Interchange).',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when the invoice was posted. Supports monthly close processes and period-based accrual accounting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the invoice was posted, based on the posting date. Used for period-based financial reporting and year-over-year analysis.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before any deductions, including merchandise cost, freight, slotting fees, or service charges. Represents the vendors billed amount before tax.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. Used to calculate payment due dates based on payment terms and to determine early payment discount eligibility.',
    `invoice_number` STRING COMMENT 'The external invoice number assigned by the vendor. This is the business identifier printed on the vendors invoice document and referenced in payment correspondence.',
    `invoice_status` STRING COMMENT 'Current state of the invoice in the accounts payable workflow. Tracks progression from receipt through three-way match, approval, payment scheduling, disbursement, and clearing in the GR/IR (Goods Receipt/Invoice Receipt) account. [ENUM-REF-CANDIDATE: received|pending_match|matched|approved|payment_blocked|scheduled|paid|cleared|cancelled|disputed — 10 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice document. Standard invoices are typical vendor bills; credit memos reduce liability; debit memos increase liability; prepayments cover advance payments; recurring invoices are for subscription services.. Valid values are `standard|credit_memo|debit_memo|prepayment|recurring|adjustment`',
    `is_1099_reportable` BOOLEAN COMMENT 'Indicates whether this invoice payment must be reported to the IRS on Form 1099-MISC or 1099-NEC for vendor tax reporting. True for payments to non-corporate vendors exceeding the annual threshold.',
    `match_status` STRING COMMENT 'Indicates whether the invoice has been successfully matched against the purchase order and goods receipt. Three-way match validates quantity, price, and terms alignment before payment approval.. Valid values are `not_applicable|pending|two_way_matched|three_way_matched|exception|override`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last updated. Tracks changes to invoice status, amounts, or payment details for audit and reconciliation purposes.',
    `net_amount` DECIMAL(18,2) COMMENT 'The final payable amount after applying discounts and adding taxes. This is the amount that will be disbursed to the vendor (gross + tax - discount).',
    `payment_block_code` STRING COMMENT 'Code indicating a hold on payment processing. Common blocks include pricing disputes, quantity discrepancies, missing documentation, vendor compliance issues, or manual review requirements. Null when no block is active.',
    `payment_block_reason` STRING COMMENT 'Detailed explanation of why the invoice payment is blocked. Provides context for AP analysts and vendor inquiry resolution.',
    `payment_date` DATE COMMENT 'The date the payment was executed and funds were disbursed to the vendor. Null for unpaid invoices. Used for cash flow reporting and vendor payment tracking.',
    `payment_method` STRING COMMENT 'The disbursement method used or planned for vendor payment. ACH (Automated Clearing House) and EFT (Electronic Funds Transfer) are preferred for cost efficiency and speed.. Valid values are `ach|wire|check|eft|virtual_card|other`',
    `payment_reference_number` STRING COMMENT 'The unique reference number for the payment transaction (check number, ACH trace number, wire confirmation). Used for bank reconciliation and vendor inquiry resolution.',
    `payment_terms_code` STRING COMMENT 'The code representing the negotiated payment terms with the vendor (e.g., Net 30, Net 60, 2/10 Net 30 for 2% discount if paid within 10 days). Drives due date calculation and early payment discount eligibility.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the general ledger. Determines the fiscal period for financial reporting and GAAP-compliant accrual accounting.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charged on the invoice, including sales tax, use tax, VAT, or GST depending on jurisdiction. Used for tax reporting and reconciliation.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the tax jurisdiction (state, province, county) where the tax was assessed. Supports multi-jurisdictional tax reporting and compliance with state and local tax regulations.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts payable lifecycle record covering the full invoice-to-payment cycle for vendor merchandise, DSD deliveries, slotting fees, and operational expenses. Captures invoice receipt (vendor ID, invoice date, PO reference, payment terms, gross/net/tax amounts, three-way match status, EDI 810 reference, GR/IR clearing), payment block and approval workflow, and disbursement execution (payment method — ACH/check/wire, payment date, bank account, cleared amount, discount taken, payment run ID from SAP automatic payment program). Each record tracks the complete AP document lifecycle from posting through clearing. Supports cash flow forecasting, vendor payment processing, early-pay discount optimization, and 1099 reporting.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts receivable invoice record. Primary key for the AR invoice entity.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Order‑to‑Invoice Matching: AR Invoice is generated from a Fulfillment Order; linking them supports the Customer Billing & Revenue Recognition process.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AR invoices record revenue against a GL account; linking provides proper financial posting.',
    `wholesale_account_id` BIGINT COMMENT 'Reference to the customer account (wholesale account, pharmacy insurance payer, fuel fleet account, or vendor for chargebacks) that is billed on this invoice.',
    `aging_bucket` STRING COMMENT 'Classification of invoice age based on days past due date. Used for Days Sales Outstanding (DSO) analysis and bad debt provisioning. Current = not yet due; other buckets represent days overdue.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `bank_deposit_reference` STRING COMMENT 'Bank deposit batch or transaction reference number linking the payment to the bank statement. Used for bank reconciliation.',
    `billing_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period covered by this invoice. Used for revenue recognition period matching and accrual accounting.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period covered by this invoice. Relevant for subscription-based or periodic billing (e.g., fuel fleet monthly billing, pharmacy monthly claims).',
    `clearing_document_number` STRING COMMENT 'SAP FI clearing document number that records the payment application transaction. Links the invoice to the cash receipt document that closed or partially paid it.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the AR system. Used for audit trail and data lineage tracking.',
    `days_outstanding` STRING COMMENT 'Number of days since the invoice date. Used to calculate Days Sales Outstanding (DSO) metrics and identify slow-paying accounts.',
    `days_past_due` STRING COMMENT 'Number of days the invoice is overdue beyond the payment due date. Null or zero if invoice is not yet due. Used for dunning level determination.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the invoice, including early payment discounts, volume discounts, promotional allowances, or negotiated rebates.',
    `dispute_date` DATE COMMENT 'Date the customer formally disputed the invoice. Used to track dispute resolution cycle time.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the customer has disputed this invoice. True if customer has raised a billing dispute, pricing disagreement, or quality claim that blocks payment.',
    `dispute_reason` STRING COMMENT 'Free-text description of the customer dispute reason (e.g., pricing error, quantity discrepancy, damaged goods, service issue). Populated when dispute_flag is true.',
    `due_date` DATE COMMENT 'Date by which payment is expected based on the payment terms. Used for aging bucket classification and dunning trigger.',
    `dunning_level` STRING COMMENT 'Current escalation level in the collections dunning process (0=no dunning, 1=first reminder, 2=second reminder, 3=final notice, 4=legal action). Increments based on days past due and payment history.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year in which the invoice was posted. Typically 1-12 for monthly periods or 1-13 for 4-4-5 retail calendar.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the invoice was posted for financial reporting purposes. Used for period-based financial analysis and SOX compliance reporting.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Shipping and freight charges included in the invoice for delivery of goods to the customer location.',
    `gl_posting_date` DATE COMMENT 'Date the invoice was posted to the general ledger for financial reporting. May differ from invoice date due to period-end cutoffs or batch processing.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before any deductions, discounts, or adjustments. Represents the full billed value of goods or services.',
    `invoice_date` DATE COMMENT 'Date the invoice was issued to the customer. This is the official billing date used for aging calculations and payment term determination.',
    `invoice_number` STRING COMMENT 'Externally-visible unique invoice number assigned by the billing system. Used for customer communication and payment reconciliation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts receivable process. Tracks progression from draft through payment or write-off. [ENUM-REF-CANDIDATE: draft|open|partially_paid|paid|overdue|disputed|written_off|cancelled — 8 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice document type: wholesale invoice for B2B customers, pharmacy claim for PBM insurance billings, fuel fleet invoice for fleet card receivables, vendor chargeback for supplier deductions, debit memo for additional charges, or credit memo for adjustments.. Valid values are `wholesale_invoice|pharmacy_claim|fuel_fleet_invoice|vendor_chargeback|debit_memo|credit_memo`',
    `last_dunning_date` DATE COMMENT 'Date the most recent dunning notice or collection reminder was sent to the customer for this invoice.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the invoice record. Tracks changes to status, amounts, or payment application.',
    `lockbox_number` STRING COMMENT 'Identifier of the bank lockbox service used for automated payment processing. Relevant for high-volume check and remittance processing.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final invoice amount due after applying all discounts, taxes, and freight charges. This is the amount the customer is expected to pay (gross + tax + freight - discount).',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the invoice after applying all cash receipts, credit memos, and adjustments. Zero when invoice is fully paid.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Total amount received and applied against this invoice across all payment transactions. Sum of all cash receipts allocated to this invoice.',
    `payment_date` DATE COMMENT 'Date the payment was received and applied to this invoice. Null if invoice is unpaid. Used for cash flow analysis and DSO calculation.',
    `payment_method` STRING COMMENT 'Primary payment instrument or mechanism used (or expected) for this invoice: ACH (Automated Clearing House), wire transfer, check, credit card, EFT (Electronic Funds Transfer), lockbox processing, or cash. [ENUM-REF-CANDIDATE: ach|wire_transfer|check|credit_card|eft|lockbox|cash — 7 candidates stripped; promote to reference product]',
    `payment_reference_number` STRING COMMENT 'External payment reference provided by the customer (check number, wire confirmation, ACH trace number, or remittance advice reference). Used for cash application matching.',
    `payment_terms_code` STRING COMMENT 'Code representing the negotiated payment terms (e.g., NET30, NET60, 2/10NET30 for 2% discount if paid within 10 days). Determines due date calculation and early payment discount eligibility.. Valid values are `^[A-Z0-9]{2,10}$`',
    `purchase_order_number` STRING COMMENT 'Customer purchase order number provided for this invoice. Used for customer reconciliation and three-way matching in customer accounts payable systems.',
    `sales_order_number` STRING COMMENT 'Reference to the originating sales order or delivery document that generated this invoice. Links AR invoice back to the order fulfillment transaction.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax, VAT, or other applicable taxes charged on the invoice. Calculated based on customer tax jurisdiction and product taxability.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount of the invoice written off as uncollectible bad debt. Recorded when collection efforts are exhausted and the receivable is deemed unrecoverable.',
    `write_off_date` DATE COMMENT 'Date the invoice (or portion thereof) was written off as bad debt. Triggers bad debt expense recognition in the general ledger.',
    `write_off_reason_code` STRING COMMENT 'Reason code for the write-off: customer bankruptcy, deemed uncollectible after collection efforts, small balance not worth pursuing, dispute settlement, goodwill adjustment, or other.. Valid values are `customer_bankruptcy|uncollectible|small_balance|dispute_settlement|goodwill_adjustment|other`',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Accounts receivable lifecycle record covering the full invoice-to-cash cycle for B2B wholesale customers, pharmacy insurance billings (PBM claims), fuel fleet card receivables, and vendor chargebacks/deductions. Captures billing (customer account, invoice date, payment terms, gross/net/tax amounts, billing document type), aging and dunning status, and cash receipt/application (receipt date, payment method, bank deposit reference, lockbox ID, applied invoice amounts, unapplied/on-account cash, clearing document). Supports DSO analysis, receivables aging reports, cash application automation, deduction management, bad debt provisioning, and write-off processing.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Primary key for budget',
    `assortment_plan_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center responsible for this budget. Cost centers represent organizational units that incur costs (e.g., store, department, distribution center).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: budget should reference the GL account master; gl_account_id replaces gl_account_code.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Budget ownership is assigned to a specific associate for financial planning responsibility and audit traceability.',
    `profit_center_id` BIGINT COMMENT 'Identifier of the profit center responsible for this budget. Profit centers represent organizational units that generate revenue and incur costs (e.g., store, region, business unit).',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Compliance Program budgeting requires linking each program to its financial budget for cost planning and reporting.',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual amount spent or incurred to date for this budget line, as recorded in the general ledger. Used for variance analysis (actual vs plan).',
    `approval_date` DATE COMMENT 'The date on which this budget was formally approved by the authorized approver or budget committee.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved this budget (e.g., CFO, Budget Committee Chair, Regional Director).',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this budget record to the audit trail or change log for compliance and SOX reporting. Tracks all modifications to budget amounts and approvals.',
    `available_balance` DECIMAL(18,2) COMMENT 'The remaining budget balance available for spending, calculated as revised_amount minus (committed_amount plus actual_amount). Used for budget consumption monitoring.',
    `budget_category` STRING COMMENT 'Hierarchical category or grouping for the budget line (e.g., Store Operations, Supply Chain, Marketing, IT Infrastructure). Used for rollup reporting and variance analysis.',
    `budget_number` STRING COMMENT 'Externally-known unique business identifier for the budget, typically formatted as BUD-YYYYNNNN where YYYY is fiscal year and NNNN is sequence number.. Valid values are `^BUD-[0-9]{8}$`',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget: draft (in preparation), submitted (awaiting approval), approved (authorized), active (in use), frozen (locked for changes), closed (period ended), or rejected (not approved). [ENUM-REF-CANDIDATE: draft|submitted|approved|active|frozen|closed|rejected — 7 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the budget by functional category: operating expenses, capital expenditures (CapEx), labor costs, marketing spend, administrative overhead, or Cost of Goods Sold (COGS).. Valid values are `operating|capital|labor|marketing|administrative|cogs`',
    `committed_amount` DECIMAL(18,2) COMMENT 'The amount of budget that has been committed through purchase orders, contracts, or other obligations but not yet expensed. Used for encumbrance accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget record (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this budget expires or is no longer active. Typically the last day of the fiscal period or fiscal year.',
    `effective_start_date` DATE COMMENT 'The date from which this budget becomes effective and active for spending authorization and monitoring.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year, typically 1-12 for monthly budgets or 1-52 for weekly budgets.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this budget applies, represented as a four-digit year (e.g., 2024).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was last updated or modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about this budget, including justification for revisions, special instructions, or context for variance explanations.',
    `owner` STRING COMMENT 'Name or identifier of the individual or role responsible for managing and monitoring this budget (e.g., Store Manager, Regional VP, CFO).',
    `planned_amount` DECIMAL(18,2) COMMENT 'The original planned budget amount for the fiscal period, as approved during the annual budgeting process. Represents the baseline target.',
    `revised_amount` DECIMAL(18,2) COMMENT 'The revised budget amount after adjustments, reforecasts, or supplemental allocations. Reflects the current authorized budget target.',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this budget line is subject to SOX internal control requirements and audit trails (True = SOX-controlled, False = not SOX-controlled).',
    `threshold_critical_percentage` DECIMAL(18,2) COMMENT 'The percentage of budget consumption at which a critical alert is triggered and spending may be blocked (e.g., 95.00 means critical alert when 95% of budget is consumed).',
    `threshold_warning_percentage` DECIMAL(18,2) COMMENT 'The percentage of budget consumption at which a warning alert is triggered (e.g., 80.00 means alert when 80% of budget is consumed). Used for proactive budget monitoring.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The variance between planned and actual amounts (actual_amount minus planned_amount). Positive values indicate overspend; negative values indicate underspend.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the planned amount ((actual_amount - planned_amount) / planned_amount * 100). Used for threshold alerts and performance scorecards.',
    `version` STRING COMMENT 'Version type of the budget indicating whether it is the original plan, a revised plan, a forecast, reforecast, supplemental allocation, or final approved version.. Valid values are `original|revised|forecast|reforecast|supplemental|final`',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Financial budget master and period-level allocation detail for Grocery, managed in SAP CO. Captures budget header (version — original/revised/forecast, budget type — operating/capital/labor, responsible cost center or profit center, GL account scope, fiscal year, approval status) and period-level line detail (fiscal period, planned amount, revised amount, committed amount, actuals-to-date, available balance). Supports variance analysis (plan vs actual vs forecast), EBITDA target tracking, store-level operating expense budgeting, category-level COGS planning, capital expenditure governance, and real-time budget consumption monitoring with threshold alerts.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`internal_order` (
    `internal_order_id` BIGINT COMMENT 'Unique identifier for the SAP CO internal order. Primary key for the internal order master data.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center responsible for managing and approving costs on this internal order. The cost center owner is accountable for budget adherence and project completion.',
    `profit_center_id` BIGINT COMMENT 'Identifier of the profit center to which costs and revenues from this internal order are allocated. Used for segment reporting and profitability analysis.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Internal orders are initiated by an associate; linking enables approval workflow and cost accountability.',
    `store_location_id` BIGINT COMMENT 'Identifier of the retail store location if this internal order is store-specific (e.g., store remodel, store opening, store equipment upgrade). Used for store-level CAPEX tracking and profitability analysis.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Total actual costs posted to this internal order to date, in the company code currency. Includes direct costs, allocations, and internal activity charges. Updated in real-time as costs are posted.',
    `actual_end_date` DATE COMMENT 'Actual date when the project or activity was completed and the order was set to technically complete status. Triggers settlement eligibility.',
    `actual_start_date` DATE COMMENT 'Actual date when work began on this internal order, typically when the first cost was posted or the order status changed to released.',
    `approval_date` DATE COMMENT 'Date when the internal order budget was approved by the authorized approver. Used for audit trail and compliance reporting.',
    `approval_status` STRING COMMENT 'Current approval status of the internal order budget request. Orders must be approved before they can be released for cost posting. Workflow-driven based on budget thresholds and organizational hierarchy.. Valid values are `pending|approved|rejected|cancelled`',
    `approver_name` STRING COMMENT 'Full name of the individual who approved the internal order budget. Required for SOX compliance and audit trail documentation.',
    `asset_class` STRING COMMENT 'SAP FI asset class code if this internal order will be settled to a fixed asset. Determines depreciation rules, useful life, and GL account assignments for the resulting asset.. Valid values are `^[A-Z0-9]{4,8}$`',
    `asset_number` STRING COMMENT 'SAP FI fixed asset master number to which this internal order will be settled upon completion. Populated for CAPEX orders that create or enhance fixed assets.. Valid values are `^[A-Z0-9]{1,12}$`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget for this internal order in the company code currency. Used for budget control and variance reporting. Budget may be original, supplemental, or revised.',
    `budget_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount. Typically matches the company code currency but may differ for multi-currency projects.. Valid values are `^[A-Z]{3}$`',
    `capitalization_flag` BOOLEAN COMMENT 'Boolean indicator whether costs on this internal order are capitalized (True) or expensed (False). True for capital investments that will be settled to fixed assets; False for operating expenses settled to cost centers or GL accounts.',
    `committed_cost_amount` DECIMAL(18,2) COMMENT 'Total committed costs (purchase requisitions and purchase orders) against this internal order. Used for funds availability checking and budget consumption reporting.',
    `company_code` STRING COMMENT 'Four-character SAP FI company code representing the legal entity to which this internal order belongs. Used for financial consolidation and legal reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area` STRING COMMENT 'Four-character SAP CO controlling area code. Represents the organizational unit for cost accounting and internal management reporting. Multiple company codes may share a controlling area.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this internal order master record was first created in SAP CO. Used for audit trail and lifecycle tracking.',
    `deletion_flag` BOOLEAN COMMENT 'Boolean indicator whether this internal order has been marked for deletion. True indicates the order is logically deleted but retained for audit purposes; False indicates an active or closed order.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this internal order was created or is active. Used for multi-year project tracking and budget period assignment.',
    `last_modified_by` STRING COMMENT 'SAP user ID of the individual who last modified this internal order master record. Used for change tracking and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this internal order master record was last modified. Used for change tracking and data freshness validation.',
    `order_description` STRING COMMENT 'Free-text description of the internal order purpose, scope, and business justification. Provides context for financial analysts and auditors reviewing project costs.',
    `order_number` STRING COMMENT 'Business identifier for the internal order, externally visible and used in financial reporting and project tracking. Typically a 10-12 character alphanumeric code assigned by SAP CO.. Valid values are `^[A-Z0-9]{10,12}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the internal order. Controls whether costs can be posted, whether the order can be settled, and whether it appears in active project reports. Status progression: created → released → technically_complete → settled → closed.. Valid values are `created|released|technically_complete|closed|settled|deleted`',
    `order_type` STRING COMMENT 'Classification of the internal order by business purpose. Determines cost collection rules, settlement targets, and reporting hierarchy. Common types include capital investments, store remodels, marketing campaigns, maintenance projects, and IT initiatives.. Valid values are `capital_investment|store_remodel|marketing_campaign|maintenance_project|it_project|other`',
    `planned_end_date` DATE COMMENT 'Planned completion date for the project or activity. Used to determine when the order should be technically complete and ready for settlement.',
    `planned_start_date` DATE COMMENT 'Planned start date for the project or activity tracked by this internal order. Used for project scheduling and resource planning.',
    `project_manager_email` STRING COMMENT 'Email address of the project manager for communication and escalation purposes. Used for automated budget alerts and approval workflows.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `project_manager_name` STRING COMMENT 'Full name of the individual responsible for managing this internal order project. Accountable for budget adherence, timeline, and deliverables.',
    `requesting_department` STRING COMMENT 'Name or code of the business department that requested this internal order. Used for chargeback and accountability reporting.',
    `settlement_date` DATE COMMENT 'Date when costs accumulated on this internal order were settled to the final receiver cost object. Marks the financial close of the order.',
    `settlement_receiver_code` STRING COMMENT 'Identifier of the specific cost object (asset number, cost center code, GL account number) to which costs will be settled. Format varies by receiver type.. Valid values are `^[A-Z0-9]{1,18}$`',
    `settlement_receiver_type` STRING COMMENT 'Type of cost object to which this internal order will be settled upon completion. Common receivers include fixed assets (for CAPEX), cost centers (for OPEX), or GL accounts (for period costs).. Valid values are `asset|cost_center|gl_account|profitability_segment|project`',
    `settlement_rule_profile` STRING COMMENT 'Configuration key defining how costs accumulated on this internal order are settled to final cost objects (e.g., asset under construction, cost center, GL account). Determines settlement percentage, receiver type, and settlement period rules.. Valid values are `^[A-Z0-9]{1,6}$`',
    `variance_amount` DECIMAL(18,2) COMMENT 'Calculated variance between budget and actual plus committed costs. Positive values indicate under-budget, negative values indicate over-budget. Used for exception reporting and project controls.',
    `wbs_element_code` BIGINT COMMENT 'Identifier of the WBS element if this internal order is part of a larger project structure. Links the order to a project hierarchy for integrated project and cost management.',
    `created_by` STRING COMMENT 'SAP user ID of the individual who created this internal order master record. Used for audit trail and accountability.',
    CONSTRAINT pk_internal_order PRIMARY KEY(`internal_order_id`)
) COMMENT 'SAP CO internal order master used to track costs for specific projects, capital investments, store remodels, marketing campaigns, and temporary cost collection objects. Captures order type, responsible cost center, settlement rule, budget, actual costs, and order status (created, released, technically complete, settled). Supports CAPEX tracking and project-level profitability.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key for the fixed asset entity.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: fixed_asset needs a foreign key to GL account for asset accounting; gl_account_id replaces gl_account_code.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier from whom the asset was purchased.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since acquisition. This is the cumulative contra-asset amount reducing the net book value.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase price or capitalized cost of the asset in USD. This is the gross base amount for depreciation calculations.',
    `acquisition_date` DATE COMMENT 'The date the asset was acquired or placed in service. This is the principal business event timestamp for the asset lifecycle and determines when depreciation begins.',
    `asset_class` STRING COMMENT 'Classification of the asset type (e.g., store equipment, refrigeration units, fuel pumps, POS terminals, MFC automation systems, delivery vehicles, leasehold improvements). Determines depreciation rules and account assignments.',
    `asset_description` STRING COMMENT 'Detailed textual description of the fixed asset, including make, model, and specific characteristics.',
    `asset_number` STRING COMMENT 'The main asset number assigned in SAP FI Asset Accounting. This is the externally-known unique identifier for the asset across the enterprise.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset. Active assets are in service and depreciating; under construction assets are capitalized but not yet depreciating; retired/disposed assets are no longer in use.. Valid values are `active|inactive|under_construction|retired|disposed|transferred`',
    `asset_sub_number` STRING COMMENT 'Sub-number for assets that are part of a larger asset group or complex asset. Used when a main asset has multiple components tracked separately for depreciation purposes.',
    `asset_tag_number` STRING COMMENT 'Physical tag or barcode identifier affixed to the asset for inventory tracking and physical verification during SOX audits.',
    `capitalization_date` DATE COMMENT 'The date the asset was capitalized in the general ledger. For assets under construction, this may differ from the acquisition date.',
    `cost_center_code` STRING COMMENT 'The cost center to which the asset is assigned for expense allocation and budgeting. Typically represents a store, distribution center, or corporate department.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fixed asset record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost and all monetary amounts (typically USD for US operations).. Valid values are `^[A-Z]{3}$`',
    `current_period_depreciation` DECIMAL(18,2) COMMENT 'Depreciation expense recognized in the current fiscal period (month or quarter). Used for EBITDA reconciliation and P&L reporting.',
    `depreciation_area` STRING COMMENT 'The valuation view for depreciation calculation: book (GAAP financial reporting), tax (IRS tax depreciation), group (consolidated reporting), or IFRS (international standards).. Valid values are `book|tax|group|ifrs`',
    `depreciation_key` STRING COMMENT 'SAP-specific depreciation key that defines the calculation rules, useful life, and period control for depreciation posting.',
    `depreciation_method` STRING COMMENT 'The method used to calculate periodic depreciation expense (e.g., straight-line, declining balance). Aligns with GAAP and tax regulations.. Valid values are `straight_line|declining_balance|sum_of_years_digits|units_of_production`',
    `disposal_date` DATE COMMENT 'The date the asset was retired, sold, or otherwise disposed of, marking the end of its service life.',
    `disposal_gain_loss` DECIMAL(18,2) COMMENT 'Gain or loss recognized on disposal, calculated as disposal proceeds minus net book value at disposal date. Positive values indicate gain; negative values indicate loss.',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Cash or fair value received from the sale or disposal of the asset. Used to calculate gain or loss on disposal.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for the current depreciation posting.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which the current period depreciation and accumulated depreciation are reported.',
    `impairment_amount` DECIMAL(18,2) COMMENT 'Total impairment loss recognized when the assets recoverable amount falls below its net book value, per GAAP impairment testing requirements.',
    `impairment_date` DATE COMMENT 'The date on which an impairment loss was recognized for the asset.',
    `is_leased_asset` BOOLEAN COMMENT 'Flag indicating whether the asset is leased rather than owned. Leased assets follow ASC 842 lease accounting rules.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified the asset record. Required for SOX audit trail and segregation of duties compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this fixed asset record was last updated. Critical for change tracking and SOX audit compliance.',
    `last_physical_inventory_date` DATE COMMENT 'The date of the most recent physical inventory verification of the asset, required for SOX compliance and audit trails.',
    `lease_contract_number` STRING COMMENT 'Reference to the lease agreement contract number if the asset is leased. Links to lease liability and right-of-use asset records.',
    `location_code` STRING COMMENT 'Physical location code where the asset is deployed (store number, DC identifier, or facility code).',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the asset, calculated as acquisition cost minus accumulated depreciation. Represents the remaining capitalized value on the balance sheet.',
    `purchase_order_number` STRING COMMENT 'Reference to the purchase order used to acquire the asset, linking to procurement records.',
    `serial_number` STRING COMMENT 'Manufacturer serial number or unique equipment identifier for physical tracking and warranty management.',
    `tax_accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation recognized for tax purposes to date. Used to track book-tax differences for deferred tax calculations.',
    `tax_depreciation_method` STRING COMMENT 'The IRS-approved depreciation method used for tax reporting, which may differ from book depreciation (e.g., MACRS, Section 179 expensing, bonus depreciation).. Valid values are `macrs|straight_line|section_179|bonus_depreciation`',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Expected useful life of the asset in years, used to calculate depreciation rates. Determined by asset class and IRS guidelines.',
    `warranty_expiration_date` DATE COMMENT 'The date on which the manufacturer or vendor warranty expires, used for maintenance planning and cost forecasting.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master and full depreciation lifecycle record from SAP FI Asset Accounting (AA) covering store equipment, refrigeration units, fuel pumps, POS terminals, MFC automation systems, delivery vehicles, and leasehold improvements. Captures asset master data (asset class, sub-number, serial number, acquisition date/cost, vendor, PO reference, useful life, location/cost center assignment) and periodic depreciation detail (depreciation method/key, depreciation area — book/tax/group, fiscal period amounts, accumulated depreciation, net book value, impairment, disposal proceeds and gain/loss). Supports EBITDA reconciliation (depreciation add-back), CAPEX reporting, tax depreciation vs book variance tracking, asset physical inventory, and SOX fixed asset audit.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique identifier for the intercompany transaction record. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: intercompany_transaction should reference the cost center master; cost_center_id replaces the free‑text cost_center field.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: intercompany_transaction must reference GL account, cost center, and profit center masters for proper posting and allocation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: intercompany_transaction should reference the profit center master; profit_center_id replaces the free‑text profit_center field.',
    `approval_status` STRING COMMENT 'The approval workflow status for the intercompany transaction: pending (awaiting finance approval), approved (authorized for posting), rejected (not authorized, requires correction). Critical for SOX segregation of duties controls.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'The SAP user ID of the finance manager or controller who approved the intercompany transaction for posting. Null if approval is pending or not required. Part of SOX approval control audit trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction was approved. Null if approval is pending or not required. Supports SOX audit trail for authorization controls.',
    `business_area` STRING COMMENT 'The SAP business area classification for segment reporting, such as Retail, Pharmacy, Fuel, or eCommerce. Enables intercompany analysis by line of business.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was first created in the system. Part of the audit trail for SOX compliance and financial controls.',
    `document_date` DATE COMMENT 'The business date of the underlying transaction or invoice that triggered the intercompany posting. May differ from posting_date due to processing lag.',
    `due_date` DATE COMMENT 'The date by which the intercompany transaction amount is due for settlement between entities. Calculated based on posting_date and payment_terms.',
    `elimination_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this intercompany transaction requires elimination during financial consolidation to prevent double-counting of revenue, expenses, or assets across legal entities.',
    `elimination_status` STRING COMMENT 'Current status of the elimination process for this intercompany transaction: pending (awaiting consolidation run), eliminated (successfully removed in consolidated financials), not_required (no elimination needed), manual_review (requires finance team intervention).. Valid values are `pending|eliminated|not_required|manual_review`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert transaction_amount to functional or group currency. Sourced from SAP FI exchange rate table at posting_date.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when the transaction was posted. Typically 1-12 for monthly periods, used for period-end close and consolidation.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the intercompany transaction was posted, following Grocerys fiscal calendar. Used for year-end consolidation and elimination entries.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the functional currency of the sending company code for local statutory reporting. Conversion uses the exchange rate at posting_date.',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the group reporting currency (typically USD) for consolidated financial statements. Critical for intercompany elimination at the corporate level.',
    `intercompany_transaction_description` STRING COMMENT 'Free-text description of the intercompany transaction providing business context, such as DC to Store 1234 inventory allocation for Q1 or Corporate IT shared service charge for January. Supports audit trail and user understanding.',
    `modified_by` STRING COMMENT 'The SAP user ID or system process that last modified the intercompany transaction record. Tracks changes for audit and compliance purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was last modified. Supports change tracking and audit trail requirements under SOX.',
    `netting_amount` DECIMAL(18,2) COMMENT 'The net amount after offsetting reciprocal intercompany balances between sending and receiving entities. Used for intercompany settlement and cash pooling arrangements.',
    `payment_terms` STRING COMMENT 'The agreed payment terms for settlement of the intercompany transaction, such as Net 30, Net 60, or Due on Receipt. Governs intercompany cash flow and working capital management.',
    `posting_date` DATE COMMENT 'The date on which the intercompany transaction was posted to the general ledger in both sending and receiving entities. Critical for period-end close and financial consolidation timing.',
    `receiving_company_code` STRING COMMENT 'SAP company code of the legal entity receiving the intercompany transaction (e.g., distribution center, shared service center, subsidiary). Four-character alphanumeric identifier per SAP FI configuration.. Valid values are `^[A-Z0-9]{4}$`',
    `reconciliation_date` DATE COMMENT 'The date on which the intercompany transaction was successfully reconciled and matched between sending and receiving entities. Null if reconciliation is pending or unmatched.',
    `reconciliation_status` STRING COMMENT 'Status of the intercompany reconciliation process indicating whether the transaction has been confirmed and matched between sending and receiving entities: matched (both sides agree), unmatched (discrepancy exists), partially_matched (amount variance), disputed (under investigation), resolved (discrepancy corrected).. Valid values are `matched|unmatched|partially_matched|disputed|resolved`',
    `reference_document_number` STRING COMMENT 'The source document number that triggered the intercompany transaction, such as an invoice number, purchase order, transfer order, or allocation run ID. Provides audit trail back to originating transaction.',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this intercompany transaction is a reversal of a previously posted transaction. Used for error correction and period-end adjustments.',
    `reversed_document_number` STRING COMMENT 'The transaction_number of the original intercompany transaction that this record reverses. Populated only when reversal_flag is True, providing audit trail for corrections.',
    `sending_company_code` STRING COMMENT 'SAP company code of the legal entity originating the intercompany transaction (e.g., store, distribution center, corporate entity). Four-character alphanumeric identifier per SAP FI configuration.. Valid values are `^[A-Z0-9]{4}$`',
    `settlement_date` DATE COMMENT 'The actual date on which the intercompany transaction was settled through cash transfer, netting, or other payment mechanism. Null if settlement is pending.',
    `settlement_method` STRING COMMENT 'The method used to settle the intercompany transaction: cash_transfer (actual funds moved), netting (offset against reciprocal balances), offset (applied against other intercompany transactions), accrual_only (no cash settlement, accounting entry only).. Valid values are `cash_transfer|netting|offset|accrual_only`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount calculated on the intercompany transaction based on applicable tax_code and jurisdiction rules. May be zero for tax-exempt intercompany transfers.',
    `tax_code` STRING COMMENT 'The tax code applied to the intercompany transaction for VAT, GST, or sales tax purposes. Some intercompany transactions may be tax-exempt depending on jurisdiction and transaction type.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the intercompany transaction in the transaction currency, before any adjustments or eliminations. Represents the amount posted to both sending and receiving entities.',
    `transaction_currency` STRING COMMENT 'The three-letter ISO 4217 currency code in which the intercompany transaction was originally denominated (e.g., USD, CAD, MXN for North American operations).. Valid values are `^[A-Z]{3}$`',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number for intercompany postings, typically following format IC-XXXXXXXXXX for tracking and reconciliation purposes.. Valid values are `^IC-[0-9]{10}$`',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction indicating the nature of the cross-entity posting: cost_allocation (store-to-DC allocations), shared_service_charge (corporate overhead), intercompany_loan (financing arrangements), management_fee (corporate services), inventory_transfer (goods movement), royalty (brand/IP licensing).. Valid values are `cost_allocation|shared_service_charge|intercompany_loan|management_fee|inventory_transfer|royalty`',
    `created_by` STRING COMMENT 'The SAP user ID or system process that created the intercompany transaction record. Critical for SOX audit trail and accountability.',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Intercompany financial transaction record capturing cross-entity postings between Grocery legal entities — store-to-DC cost allocations, shared service charges, intercompany loans, and management fee billings. Records sending and receiving company codes, transaction type, elimination flag, netting amount, and reconciliation status. Critical for financial consolidation and intercompany elimination under GAAP.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Reference to the original cost_allocation_id that this record reverses. Populated only when reversal_indicator is True. Enables tracing of reversal chains for audit purposes.',
    `space_allocation_id` BIGINT COMMENT 'Unique identifier for the cost allocation record. Primary key for the cost allocation transaction.',
    `cost_element_id` BIGINT COMMENT 'Identifier of the cost element (expense category) being allocated. Cost elements represent the nature of the expense (utilities, rent, depreciation, IT services, HR services) and map to general ledger accounts.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center from which costs are being allocated. Sender cost centers typically represent shared service functions (IT, HR, facilities, corporate overhead, distribution center operations) whose costs are distributed to benefiting units.',
    `profit_center_id` BIGINT COMMENT 'Identifier of the profit center receiving the allocated costs. Used when costs are allocated directly to profit centers for segment reporting and profitability analysis. Nullable if allocation targets cost centers only.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Monetary amount allocated from the sender cost center to the receiver cost center or profit center. Represents the share of shared costs assigned to the receiver based on the allocation method and driver quantities. Positive values indicate cost transfers; negative values may represent reversals or corrections.',
    `allocation_cycle_name` STRING COMMENT 'Name or identifier of the periodic cost allocation cycle run in SAP CO (Controlling). Examples include monthly overhead allocation, quarterly shared services distribution, or annual corporate cost assessment cycles.',
    `allocation_method` STRING COMMENT 'Method used to allocate costs from sender to receiver objects. Percentage allocates based on proportional shares, quantity uses driver volumes (e.g., square footage, headcount), fixed uses predetermined amounts, assessment distributes full sender balance, distribution splits based on statistical key figures, direct assigns costs one-to-one, step_down cascades costs sequentially, reciprocal handles mutual service relationships. [ENUM-REF-CANDIDATE: percentage|quantity|fixed|assessment|distribution|direct|step_down|reciprocal — 8 candidates stripped; promote to reference product]',
    `allocation_notes` STRING COMMENT 'Free-text notes or comments regarding the allocation. May include explanations for manual adjustments, special allocation rules, or business justifications for allocation method changes.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of sender cost center total costs allocated to this receiver. Used when allocation_method is percentage. Sum of all allocation_percentage values for a given sender and cycle should equal 100.00. Nullable if allocation method is not percentage-based.',
    `allocation_rate` DECIMAL(18,2) COMMENT 'Rate per unit of driver quantity used to calculate the allocated amount. Calculated as total sender costs divided by total driver quantity across all receivers. allocated_amount = driver_quantity × allocation_rate. Nullable if allocation method is fixed or percentage.',
    `allocation_status` STRING COMMENT 'Current status of the cost allocation record. Posted indicates the allocation has been successfully posted to CO and FI documents. Reversed indicates the allocation was reversed due to error or period-end adjustment. Pending indicates the cycle has run but posting is not yet complete. Error indicates a posting failure. Cancelled indicates the allocation was voided before posting.. Valid values are `posted|reversed|pending|error|cancelled`',
    `co_document_number` STRING COMMENT 'SAP CO document number generated when the allocation was posted. Links this allocation record to the controlling document for audit trail and drill-down analysis.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity for which the allocation was posted. Used for multi-entity consolidation and legal entity reporting.',
    `controlling_area` STRING COMMENT 'SAP controlling area representing the organizational unit for cost accounting. Controlling areas may span multiple company codes for consolidated management reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation record was first created in the system. Supports audit trail and data lineage tracking for SOX compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocated amount. Typically USD for US-based grocery operations, but may vary for international subsidiaries.. Valid values are `^[A-Z]{3}$`',
    `cycle_run_date` DATE COMMENT 'Date when the allocation cycle was executed in SAP CO. May differ from posting_date if the cycle was run in advance and posted later.',
    `driver_quantity` DECIMAL(18,2) COMMENT 'Quantity of the allocation driver (statistical key figure) used to calculate the allocated amount. Examples: square footage, headcount, transaction volume, sales revenue, labor hours. Used when allocation_method is quantity-based. Nullable if allocation method is fixed or percentage.',
    `driver_unit_of_measure` STRING COMMENT 'Unit of measure for the driver quantity. Examples: square_feet, headcount, transactions, dollars, hours. Provides context for interpreting driver_quantity values.',
    `fi_document_number` STRING COMMENT 'SAP FI document number generated when the allocation was posted to the general ledger. Links this allocation record to the financial accounting document for SOX compliance and audit trail.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year when the allocation was posted. Typically 1-12 for monthly periods, may include special periods 13-16 for year-end adjustments.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year in which the cost allocation was executed. Aligns with the companys financial reporting calendar.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person or system process that last modified the allocation record. Supports SOX compliance and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation record was last modified. Supports audit trail and change tracking for SOX compliance and financial reporting accuracy.',
    `posting_date` DATE COMMENT 'Date when the cost allocation transaction was posted to the general ledger and controlling documents. Determines the fiscal period assignment and financial statement impact.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this allocation record is a reversal of a previous allocation. True if this is a reversal transaction, False if this is an original allocation posting.',
    `created_by` STRING COMMENT 'User ID or name of the person or system process that created the allocation record. Supports SOX compliance and audit trail requirements.',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'SAP CO periodic cost allocation and assessment cycle record distributing shared costs (utilities, corporate overhead, DC operating costs) from sender cost centers to receiver cost centers or profit centers. Captures allocation cycle name, fiscal period, sender/receiver objects, allocation method (percentage, quantity, fixed), allocated amount, and cycle run date. Enables accurate store-level and department-level P&L.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the bank account record. Primary key.',
    `concentration_account_id` BIGINT COMMENT 'Foreign key to the master concentration account if this is a zero-balance account. Null for non-ZBA accounts.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the Grocery legal entity that owns this bank account. Links to legal entity master for consolidation and intercompany reconciliation.',
    `account_holder_name` STRING COMMENT 'Legal name of the account holder as registered with the bank. Must match legal entity name for corporate accounts.',
    `account_number` STRING COMMENT 'Full bank account number. Stored in encrypted form for PCI compliance.',
    `account_purpose` STRING COMMENT 'Business purpose of the account: operating (AP/AR), payroll (employee payments), tax (remittances), investment (short-term cash), debt_service (loan payments), escrow (restricted funds).. Valid values are `operating|payroll|tax|investment|debt_service|escrow`',
    `account_status` STRING COMMENT 'Current operational status of the bank account. Active: normal operations. Inactive: temporarily not in use. Closed: permanently closed. Frozen: blocked by bank or legal order. Restricted: limited transaction types allowed.. Valid values are `active|inactive|closed|frozen|restricted`',
    `account_type` STRING COMMENT 'Classification of the bank account by operational purpose: checking (operating accounts), savings (reserve accounts), money_market (short-term investment), zero_balance (subsidiary accounts swept daily), concentration (master cash pooling), payroll (dedicated payroll disbursement), lockbox (AR collection). [ENUM-REF-CANDIDATE: checking|savings|money_market|zero_balance|concentration|payroll|lockbox — 7 candidates stripped; promote to reference product]',
    `available_balance` DECIMAL(18,2) COMMENT 'Current balance minus outstanding checks and holds. Represents funds available for immediate disbursement.',
    `bank_key` STRING COMMENT 'Country-specific bank identifier. In US: ABA routing number (9 digits). In EU: Bank Identifier Code (BIC/SWIFT). Maps to SAP bank key (BNKA-BANKL).',
    `bank_name` STRING COMMENT 'Legal name of the financial institution holding the account.',
    `branch_address` STRING COMMENT 'Full street address of the bank branch.',
    `branch_city` STRING COMMENT 'City where the bank branch is located.',
    `branch_country_code` STRING COMMENT 'Three-letter ISO country code for the bank branch location.. Valid values are `^[A-Z]{3}$`',
    `branch_name` STRING COMMENT 'Name of the bank branch where the account is domiciled.',
    `branch_postal_code` STRING COMMENT 'Postal or ZIP code for the bank branch.',
    `branch_state` STRING COMMENT 'Two-letter state or province code for the bank branch location.. Valid values are `^[A-Z]{2}$`',
    `closing_date` DATE COMMENT 'Date the bank account was closed. Null for active accounts.',
    `company_code` STRING COMMENT 'Four-character SAP FI company code to which this bank account is assigned. Used for GL posting and financial statement consolidation.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the account (e.g., USD, EUR, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'Most recent closing balance from the last processed bank statement. Used for daily cash position reporting.',
    `gl_account_code` STRING COMMENT 'GL account number in the chart of accounts to which bank transactions are posted. Typically a cash or cash-equivalent account.. Valid values are `^[0-9]{6,10}$`',
    `house_bank_code` STRING COMMENT 'SAP-assigned identifier for the house bank configuration. Links to SAP FI bank master (T012).. Valid values are `^[A-Z0-9]{1,5}$`',
    `iban` STRING COMMENT 'International Bank Account Number for SEPA and cross-border payments in Europe and other IBAN-participating countries.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$`',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate earned on positive balances or charged on overdrafts, expressed as a decimal (e.g., 0.0250 for 2.50%).',
    `last_reconciliation_date` DATE COMMENT 'Date of the most recent completed bank reconciliation. Used for SOX compliance monitoring.',
    `last_statement_date` DATE COMMENT 'Date of the most recent bank statement received and processed for this account.',
    `lockbox_indicator` BOOLEAN COMMENT 'True if this account is a lockbox account used for automated AR collection processing. False otherwise.',
    `masked_account_number` STRING COMMENT 'Masked account number showing only last 4 digits for display purposes (e.g., XXXXXX1234).. Valid values are `^X+[0-9]{4}$`',
    `opening_date` DATE COMMENT 'Date the bank account was opened with the financial institution.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'Maximum negative balance allowed by the bank under overdraft protection agreement. Zero if no overdraft facility exists.',
    `routing_number` STRING COMMENT 'Nine-digit ABA routing transit number for US domestic wire and ACH transactions.. Valid values are `^[0-9]{9}$`',
    `signatory_authority_1` STRING COMMENT 'Name of the primary authorized signatory for the account. Required for SOX treasury controls and audit trail.',
    `signatory_authority_2` STRING COMMENT 'Name of the secondary authorized signatory. Used for dual-control requirements on high-value transactions.',
    `signatory_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum transaction amount that can be authorized by a single signatory. Amounts above this require dual approval.',
    `statement_format` STRING COMMENT 'Electronic format in which bank statements are received: MT940 (SWIFT standard), BAI2 (US cash management), CAMT053 (ISO 20022 XML), PDF, CSV.. Valid values are `MT940|BAI2|CAMT053|PDF|CSV`',
    `statement_frequency` STRING COMMENT 'How often bank statements are issued: daily (for high-volume accounts), weekly, monthly.. Valid values are `daily|weekly|monthly`',
    `swift_code` STRING COMMENT 'Bank Identifier Code (BIC) for international wire transfers. 8 or 11 character ISO 9362 code.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank account record was last modified.',
    `zero_balance_indicator` BOOLEAN COMMENT 'True if this is a zero-balance account that is automatically swept to/from a concentration account daily. False otherwise.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Bank account master and electronic bank statement record for all Grocery operating, payroll, concentration, and zero-balance accounts across legal entities. Captures account master data (bank name, masked account number, routing number, account type, currency, SAP house bank ID, signatory authorities) and full statement lifecycle (MT940/BAI2 imports, statement date/sequence, opening/closing balances, individual transaction lines — deposits/withdrawals/fees/lockbox items, bank transaction codes, value date, clearing status against open AR/AP items). Supports cash management, AP payment run bank selection, AR lockbox processing, daily cash position reporting, bank reconciliation, and SOX treasury controls.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`sox_control` (
    `sox_control_id` BIGINT COMMENT 'Unique identifier for the SOX internal control record. Primary key for the sox_control data product.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: SOX controls are defined per GL account; adding gl_account_id links control to the account it governs.',
    `associate_id` BIGINT COMMENT 'Identifier of the associate responsible for the design, execution, and monitoring of this control. Typically a manager or director in Finance, Operations, or IT.',
    `sox_performer_associate_id` BIGINT COMMENT 'Identifier of the associate who actually executes the control activity. May differ from the control owner (e.g., staff accountant performs, manager owns).',
    `assertion_category` STRING COMMENT 'The financial statement assertion this control addresses per audit standards: existence (transactions occurred), completeness (all transactions recorded), accuracy (amounts correct), valuation (proper measurement), rights and obligations (entity owns/owes), presentation and disclosure (proper classification and disclosure).. Valid values are `existence|completeness|accuracy|valuation|rights_and_obligations|presentation_and_disclosure`',
    `auditor_reliance_flag` BOOLEAN COMMENT 'Indicates whether external auditors plan to rely on this control for their financial statement audit, which requires more extensive testing and documentation.',
    `business_process` STRING COMMENT 'The core business process or cycle this control supports (e.g., Revenue Recognition, Inventory Valuation, Accounts Payable, Payroll Processing, Financial Close, Fixed Assets).',
    `company_level_control_flag` BOOLEAN COMMENT 'Indicates whether this is a company-level (entity-level) control that operates across the entire organization (e.g., code of conduct, whistleblower hotline, board oversight) versus a process-level control.',
    `compensating_control_flag` BOOLEAN COMMENT 'Indicates whether this control serves as a compensating control to mitigate risk when a primary control is deficient or not operating effectively.',
    `control_activity_detail` STRING COMMENT 'Step-by-step procedures or specific actions performed as part of the control execution (e.g., Compare system-generated inventory report to physical count sheets; investigate variances exceeding $5,000 or 2%; document resolution in variance log).',
    `control_description` STRING COMMENT 'Detailed narrative describing how the control is performed, what evidence is reviewed, what thresholds or criteria are applied, and what actions are taken when exceptions are identified.',
    `control_frequency` STRING COMMENT 'How often the control is performed or executed (e.g., daily reconciliations, monthly close reviews, quarterly management certifications, event-driven approvals). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annually|event_driven|continuous — 7 candidates stripped; promote to reference product]',
    `control_nature` STRING COMMENT 'Indicates whether the control is performed manually by personnel, fully automated by system, or a hybrid where manual steps depend on IT-generated reports or system configurations.. Valid values are `manual|automated|manual_dependent_on_IT|IT_dependent`',
    `control_number` STRING COMMENT 'Business-facing unique control identifier used in audit documentation and control testing workpapers. Typically follows a pattern like FIN-001, INV-025, REV-100.. Valid values are `^[A-Z]{2,4}-[0-9]{3,5}$`',
    `control_objective` STRING COMMENT 'The specific financial reporting assertion or business objective this control is designed to achieve (e.g., Ensure completeness and accuracy of accounts payable balances, Prevent unauthorized inventory adjustments).',
    `control_owner_name` STRING COMMENT 'Full name of the control owner for reporting and audit trail purposes.',
    `control_performer_name` STRING COMMENT 'Full name of the associate who performs the control for audit documentation and segregation of duties analysis.',
    `control_title` STRING COMMENT 'Short descriptive title of the control activity (e.g., Monthly Bank Reconciliation Review, Inventory Valuation Approval, Revenue Recognition Cut-off Verification).',
    `control_type` STRING COMMENT 'Classification of control based on its timing and purpose: preventive (stops errors before they occur), detective (identifies errors after occurrence), or corrective (remediates identified errors).. Valid values are `preventive|detective|corrective`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this control record was first created in the SOX control repository system.',
    `deficiency_classification` STRING COMMENT 'Severity classification of any identified control deficiency: none (control operating effectively), control deficiency (minor issue not rising to significant deficiency), significant deficiency (important enough to merit attention by those charged with governance), material weakness (reasonable possibility of material misstatement not prevented or detected).. Valid values are `none|control_deficiency|significant_deficiency|material_weakness`',
    `deficiency_description` STRING COMMENT 'Detailed description of the control deficiency identified during testing, including root cause analysis, impact assessment, and specific instances where the control failed to operate as designed.',
    `deficiency_identified_date` DATE COMMENT 'Date when the control deficiency was first identified through testing, self-assessment, or audit procedures.',
    `effective_date` DATE COMMENT 'Date when this control became effective and operational. Used for tracking control lifecycle and determining when testing should begin.',
    `end_date` DATE COMMENT 'Date when this control was retired, superseded, or no longer applicable. Null for active controls.',
    `evidence_of_performance` STRING COMMENT 'Description of the documentation or artifacts that demonstrate the control was performed (e.g., Signed reconciliation workpaper with preparer and reviewer signatures and dates, System-generated approval workflow log, Email confirmation from manager).',
    `financial_statement_line_item` STRING COMMENT 'The specific financial statement account or line item this control impacts (e.g., Revenue, Cost of Goods Sold (COGS), Inventory, Accounts Receivable, Accrued Liabilities).',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this control record and testing results apply. SOX compliance is assessed annually.',
    `it_general_control_flag` BOOLEAN COMMENT 'Indicates whether this is an IT general control (ITGC) covering system access, change management, backup/recovery, or operations versus an application control embedded in business processes.',
    `key_control_flag` BOOLEAN COMMENT 'Indicates whether this is a key control that external auditors rely upon for their financial statement audit opinion. Key controls are subject to more rigorous testing and documentation requirements.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this control record. Critical for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this control record was most recently updated, including changes to control design, ownership, testing results, or deficiency status.',
    `last_test_date` DATE COMMENT 'Date when the control was most recently tested by internal audit, external auditors, or control owners as part of ongoing monitoring or annual SOX compliance testing.',
    `next_test_due_date` DATE COMMENT 'Scheduled date for the next control test based on control frequency and testing plan. Used for test scheduling and compliance monitoring.',
    `remediation_completion_date` DATE COMMENT 'Actual date when remediation activities were completed and the control was redesigned or enhanced to address the identified deficiency.',
    `remediation_plan` STRING COMMENT 'Detailed action plan to address and remediate the identified control deficiency, including specific steps, responsible parties, resources required, and interim compensating controls.',
    `remediation_status` STRING COMMENT 'Current status of remediation efforts: not started (plan approved but work not begun), in progress (remediation underway), completed (remediation actions finished), validated (control retested and operating effectively), closed (deficiency fully resolved and documented).. Valid values are `not_started|in_progress|completed|validated|closed`',
    `remediation_target_date` DATE COMMENT 'Target completion date for remediation activities. Material weaknesses typically require remediation within the fiscal year to avoid adverse audit opinion.',
    `risk_rating` STRING COMMENT 'Assessment of the inherent risk level associated with the business process or account balance this control mitigates. Critical and high-risk controls receive more frequent testing.. Valid values are `critical|high|medium|low`',
    `sec_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether deficiencies in this control must be disclosed in SEC filings (Form 10-K, Form 10-Q) per SOX Section 302 and 404 requirements. Typically true for material weaknesses and significant deficiencies.',
    `sox_control_status` STRING COMMENT 'Current operational status of the control: active (in operation and being tested), inactive (temporarily suspended), under review (being evaluated for design effectiveness), retired (no longer in use).. Valid values are `active|inactive|under_review|retired`',
    `test_sample_size` STRING COMMENT 'Number of control instances or transactions selected for testing during the most recent test cycle. Sample size is determined based on control frequency and risk rating.',
    `testing_status` STRING COMMENT 'Current status of control testing for the fiscal period: not tested (testing not yet started), in progress (testing underway), passed (no deficiencies identified), failed (deficiency identified), not applicable (control not in scope for current period).. Valid values are `not_tested|in_progress|passed|failed|not_applicable`',
    CONSTRAINT pk_sox_control PRIMARY KEY(`sox_control_id`)
) COMMENT 'SOX internal control master record documenting financial reporting controls across Grocerys key business processes — revenue recognition, inventory valuation, AP/AR, payroll, and financial close. Captures control ID, control objective, control type (preventive/detective), frequency, control owner, testing status, deficiency classification (significant deficiency, material weakness), and remediation plan. Supports external auditor reliance and SEC disclosure requirements.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key for payment_run',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or counterparty receiving the payments.',
    `reversed_payment_run_id` BIGINT COMMENT 'Self-referencing FK on payment_run (reversed_payment_run_id)',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual completion time when the payment run finished processing.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual start time when the payment run began processing.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run was approved for execution.',
    `approved_by` STRING COMMENT 'User ID of the person who approved the payment run.',
    `audit_trail` STRING COMMENT 'JSON string capturing audit events for the payment run (e.g., status changes).',
    `business_unit` STRING COMMENT 'Business unit responsible for the payment run.',
    `cost_center_code` STRING COMMENT 'Cost center code associated with the payment run for internal accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amounts.',
    `payment_run_description` STRING COMMENT 'Free-text description or notes about the payment run.',
    `external_reference_code` STRING COMMENT 'External system reference identifier for the payment run (e.g., SAP document number).',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the payment run was generated automatically by the system.',
    `number_of_transactions` STRING COMMENT 'Count of individual payment transactions included in this run.',
    `payment_channel` STRING COMMENT 'Channel through which the payment run was initiated.',
    `payment_method` STRING COMMENT 'Primary method used to execute payments in this run.',
    `run_number` STRING COMMENT 'External reference number for the payment run as assigned by the finance system.',
    `run_type` STRING COMMENT 'Category of payments processed in this run.',
    `scheduled_timestamp` TIMESTAMP COMMENT 'Planned start time for the payment run execution.',
    `payment_run_status` STRING COMMENT 'Current lifecycle status of the payment run.',
    `total_fees_amount` DECIMAL(18,2) COMMENT 'Total fees (e.g., processing fees) for the payment run.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount of all payments before deductions.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Net amount after taxes and fees.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the payments in the run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment run record.',
    `created_by` STRING COMMENT 'User ID of the person who created the payment run record.',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Master reference table for payment_run. Referenced by payment_run_id.';

CREATE OR REPLACE TABLE `grocery_ecm`.`finance`.`cost_element` (
    `cost_element_id` BIGINT COMMENT 'Primary key for cost_element',
    `parent_cost_element_id` BIGINT COMMENT 'Self-referencing FK on cost_element (parent_cost_element_id)',
    `allocation_method` STRING COMMENT 'Method used to allocate costs from this element to cost objects.',
    `cost_element_category` STRING COMMENT 'Higher‑level grouping of cost elements for reporting.',
    `cost_element_code` STRING COMMENT 'Unique alphanumeric code used to identify the cost element in financial systems.',
    `cost_center_code` STRING COMMENT 'Code of the cost center primarily associated with this cost element.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost element record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for the default rate.',
    `default_rate` DECIMAL(18,2) COMMENT 'Default monetary rate (per unit) associated with the cost element.',
    `cost_element_description` STRING COMMENT 'Detailed description of the cost element purpose and usage.',
    `effective_from` DATE COMMENT 'Date when the cost element becomes effective.',
    `effective_until` DATE COMMENT 'Date when the cost element is no longer effective; null if indefinite.',
    `gl_account_number` STRING COMMENT 'GL account number linked to this cost element for posting.',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether the cost element is deprecated and should not be used for new transactions.',
    `cost_element_name` STRING COMMENT 'Human‑readable name of the cost element.',
    `cost_element_status` STRING COMMENT 'Current lifecycle status of the cost element.',
    `tax_applicable` BOOLEAN COMMENT 'Indicates if taxes are applicable to this cost element.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Default tax rate percentage applied to this cost element when tax_applicable is true.',
    `cost_element_type` STRING COMMENT 'Category indicating the nature of the cost element.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cost element record.',
    CONSTRAINT pk_cost_element PRIMARY KEY(`cost_element_id`)
) COMMENT 'Master reference table for cost_element. Referenced by cost_element_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_primary_ultimate_parent_entity_legal_entity_id` FOREIGN KEY (`primary_ultimate_parent_entity_legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_prior_year_period_fiscal_period_id` FOREIGN KEY (`prior_year_period_fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `grocery_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `grocery_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `grocery_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_concentration_account_id` FOREIGN KEY (`concentration_account_id`) REFERENCES `grocery_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_reversed_payment_run_id` FOREIGN KEY (`reversed_payment_run_id`) REFERENCES `grocery_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `grocery_ecm`.`finance`.`cost_element` ADD CONSTRAINT `fk_finance_cost_element_parent_cost_element_id` FOREIGN KEY (`parent_cost_element_id`) REFERENCES `grocery_ecm`.`finance`.`cost_element`(`cost_element_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `grocery_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Identifier');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `account_group_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group Code');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `account_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Hierarchy Level');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `account_long_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Long Description');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|blocked|marked_for_deletion|inactive');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `alternative_account_code` SET TAGS ('dbx_business_glossary_term' = 'Alternative General Ledger (GL) Account Code');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Account Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) Code');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `cogs_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Account Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `commitment_management_indicator` SET TAGS ('dbx_business_glossary_term' = 'Commitment Management Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category (SAP CO)');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|not_applicable');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Type');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Account Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Account Effective From Date');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Account Effective To Date');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `field_status_group` SET TAGS ('dbx_business_glossary_term' = 'Field Status Group Code');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `field_status_group` SET TAGS ('dbx_value_regex' = '^G[0-9]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `financial_statement_section` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Section');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `financial_statement_section` SET TAGS ('dbx_value_regex' = 'balance_sheet|income_statement|cash_flow|equity_statement');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `gaap_classification` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Classification');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `house_bank_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'House Bank Account Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `house_bank_account_indicator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `house_bank_account_indicator` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `ifrs_mapping_code` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Mapping Code');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `intercompany_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Account Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `is_posting_allowed` SET TAGS ('dbx_business_glossary_term' = 'Posting Allowed Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `is_reconciliation_account` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `is_tax_relevant` SET TAGS ('dbx_business_glossary_term' = 'Tax Relevant Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `line_item_display` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `open_item_management` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `parent_account_code` SET TAGS ('dbx_business_glossary_term' = 'Parent General Ledger (GL) Account Code');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `planning_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Planning Account Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `profit_loss_statement_account_type` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Statement Account Type');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Type');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account_type` SET TAGS ('dbx_value_regex' = 'accounts_payable|accounts_receivable|fixed_assets|not_applicable');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `shrink_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Shrink Account Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Sort Key Code');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `sort_key` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_FI|ORACLE_RMS|MANUAL');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `sox_relevant_indicator` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Relevant Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Type Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,10}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period (Fiscal Year)');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO Area) Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category (SAP CO Category)');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,2}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|locked|pending_activation|closed');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'store|distribution_center|pharmacy|fuel_center|corporate|administrative');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `division_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,16}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_area` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Hierarchy Area (Standard Hierarchy Node)');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `is_locked_for_actual` SET TAGS ('dbx_business_glossary_term' = 'Is Locked for Actual Postings Flag');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `is_locked_for_plan` SET TAGS ('dbx_business_glossary_term' = 'Is Locked for Plan Postings Flag');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `is_statistical` SET TAGS ('dbx_business_glossary_term' = 'Is Statistical Cost Center Flag');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `labor_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Amount');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `labor_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `last_changed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Changed By (User ID)');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `last_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Changed Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'store|distribution_center|micro_fulfillment_center|corporate_office|fuel_center|pharmacy');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `overhead_rate` SET TAGS ('dbx_business_glossary_term' = 'Overhead Rate');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `overhead_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `settlement_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `settlement_rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Short Name');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `short_name` SET TAGS ('dbx_value_regex' = '^.{1,20}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `shrink_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Shrink Allocation Flag');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_CO|SAP_FI|ORACLE_RMS|MANUAL');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `grocery_ecm`.`finance`.`cost_center` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `banner_code` SET TAGS ('dbx_business_glossary_term' = 'Banner Code');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `banner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `comp_sales_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Comparable Sales (Comp Sales) Eligible Flag');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO) Code');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `department_count` SET TAGS ('dbx_business_glossary_term' = 'Department Count');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `district_code` SET TAGS ('dbx_business_glossary_term' = 'District Code');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `district_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Level');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `market_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center Code');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `remodel_date` SET TAGS ('dbx_business_glossary_term' = 'Remodel Date');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `same_store_sales_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Same-Store Sales Eligible Flag');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Short Name');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `grocery_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'asset_finance');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `parent_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Legal Entity Identifier');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_ultimate_parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Entity Identifier');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `audit_firm_name` SET TAGS ('dbx_business_glossary_term' = 'External Audit Firm Name');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `audit_firm_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_group_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Code');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Dissolution');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `ein` SET TAGS ('dbx_business_glossary_term' = 'Employer Identification Number (EIN)');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `ein` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `ein` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Status');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|dissolved|suspended|pending_formation');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'corporation|limited_liability_company|partnership|sole_proprietorship|holding_company|subsidiary');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_end_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Month');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `gaap_reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Reporting Standard');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `gaap_reporting_standard` SET TAGS ('dbx_value_regex' = 'US_GAAP|IFRS|local_gaap');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Incorporation');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Completion Date');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Legal Name');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `public_company_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Company Flag');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Country Code');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state` SET TAGS ('dbx_business_glossary_term' = 'Registered State');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scope Flag');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `state_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'State of Incorporation');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `state_of_incorporation` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `stock_exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Code');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `stock_exchange_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,4}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `stock_ticker_symbol` SET TAGS ('dbx_business_glossary_term' = 'Stock Ticker Symbol');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `stock_ticker_symbol` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,5}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `grocery_ecm`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period ID');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By User ID');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `prior_year_period_fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Period ID');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `business_day_count` SET TAGS ('dbx_business_glossary_term' = 'Business Day Count');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `calendar_month` SET TAGS ('dbx_business_glossary_term' = 'Calendar Month');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `calendar_year` SET TAGS ('dbx_business_glossary_term' = 'Calendar Year');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Period Close Date');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `close_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period Close Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `day_count` SET TAGS ('dbx_business_glossary_term' = 'Day Count');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `external_audit_required` SET TAGS ('dbx_business_glossary_term' = 'External Audit Required Flag');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_number` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Number');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `gaap_compliant` SET TAGS ('dbx_business_glossary_term' = 'GAAP (Generally Accepted Accounting Principles) Compliant Flag');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `is_current_period` SET TAGS ('dbx_business_glossary_term' = 'Is Current Period Flag');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `is_leap_year` SET TAGS ('dbx_business_glossary_term' = 'Is Leap Year Flag');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Period Notes');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Name');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'open|closed|locked|pending_close');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'regular|adjustment|special|year_end');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `sox_certification_date` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Certification Date');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `sox_certification_required` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Certification Required Flag');
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ALTER COLUMN `week_count` SET TAGS ('dbx_business_glossary_term' = 'Week Count');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `quaternary_journal_posted_by_user_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By User ID');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `quinary_journal_parking_user_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Parking User ID');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `tertiary_journal_approved_by_user_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `baseline_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Payment Date');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `batch_input_session` SET TAGS ('dbx_business_glossary_term' = 'Batch Input Session');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'SA|KR|DR|AB|KG|DZ');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `header_text` SET TAGS ('dbx_business_glossary_term' = 'Header Text');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_value_regex' = '0L|2L|9Z');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `parking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Parking Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `payment_block_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_value_regex' = 'C|T|W|Z');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|parked|cleared|reversed|cancelled');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = '01|02|03|04|05|06');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Date');
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_company_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Company Code');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'asset_finance');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Associate ID');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Company Bank Account ID');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Automatic Payment Run ID');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `cleared_amount` SET TAGS ('dbx_business_glossary_term' = 'Cleared Payment Amount');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Clearing Date');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Amount');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_taken_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken Amount');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `edi_810_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) 810 Invoice Reference');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Lifecycle Status');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Document Type');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|recurring|adjustment');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `is_1099_reportable` SET TAGS ('dbx_business_glossary_term' = 'IRS Form 1099 Reportable Flag');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|two_way_matched|three_way_matched|exception|override');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_block_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason Description');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Execution Date');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire|check|eft|virtual_card|other');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'asset_finance');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice ID');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `bank_deposit_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Deposit Reference');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `days_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Outstanding');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'wholesale_invoice|pharmacy_claim|fuel_fleet_invoice|vendor_chargeback|debit_memo|credit_memo');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `last_dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `lockbox_number` SET TAGS ('dbx_business_glossary_term' = 'Lockbox ID');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `write_off_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ALTER COLUMN `write_off_reason_code` SET TAGS ('dbx_value_regex' = 'customer_bankruptcy|uncollectible|small_balance|dispute_settlement|goodwill_adjustment|other');
ALTER TABLE `grocery_ecm`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Identifier');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `assortment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_value_regex' = '^BUD-[0-9]{8}$');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'operating|capital|labor|marketing|administrative|cogs');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Amount');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `threshold_critical_percentage` SET TAGS ('dbx_business_glossary_term' = 'Threshold Critical Percentage');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `threshold_warning_percentage` SET TAGS ('dbx_business_glossary_term' = 'Threshold Warning Percentage');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `grocery_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|reforecast|supplemental|final');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order ID');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Cost Center ID');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Number');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,12}$');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `capitalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Flag (CAPEX)');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `committed_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost Amount');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `deletion_flag` SET TAGS ('dbx_business_glossary_term' = 'Deletion Flag');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `order_description` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Description');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,12}$');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Status');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'created|released|technically_complete|closed|settled|deleted');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Type');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'capital_investment|store_remodel|marketing_campaign|maintenance_project|it_project|other');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Email Address');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Name');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_receiver_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Receiver ID');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_receiver_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,18}$');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_receiver_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Receiver Type');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_receiver_type` SET TAGS ('dbx_value_regex' = 'asset|cost_center|gl_account|profitability_segment|project');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_rule_profile` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule Profile');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_rule_profile` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_finance');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|retired|disposed|transferred');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_sub_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Sub-Number');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `current_period_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Current Period Depreciation');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_value_regex' = 'book|tax|group|ifrs');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_key` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Key');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|sum_of_years_digits|units_of_production');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Disposal Gain or Loss');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Amount');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_date` SET TAGS ('dbx_business_glossary_term' = 'Impairment Date');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `is_leased_asset` SET TAGS ('dbx_business_glossary_term' = 'Is Leased Asset');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_physical_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inventory Date');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Number');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Tax Accumulated Depreciation');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Depreciation Method');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_value_regex' = 'macrs|straight_line|section_179|bonus_depreciation');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'asset_finance');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Elimination Flag');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Elimination Status');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_value_regex' = 'pending|eliminated|not_required|manual_review');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_amount` SET TAGS ('dbx_business_glossary_term' = 'Netting Amount');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Code');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partially_matched|disputed|resolved');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Company Code');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'cash_transfer|netting|offset|accrual_only');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Number');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^IC-[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'cost_allocation|shared_service_charge|intercompany_loan|management_fee|inventory_transfer|royalty');
ALTER TABLE `grocery_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Cost Allocation ID');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `space_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation ID');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element ID');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Cost Center ID');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Profit Center ID');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Name');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_rate` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rate');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending|error|cancelled');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `co_document_number` SET TAGS ('dbx_business_glossary_term' = 'Controlling (CO) Document Number');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cycle_run_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Run Date');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `driver_quantity` SET TAGS ('dbx_business_glossary_term' = 'Driver Quantity');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `driver_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Driver Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fi_document_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Accounting (FI) Document Number');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'asset_finance');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `concentration_account_id` SET TAGS ('dbx_business_glossary_term' = 'Concentration Account ID');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Name');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `account_purpose` SET TAGS ('dbx_business_glossary_term' = 'Account Purpose');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `account_purpose` SET TAGS ('dbx_value_regex' = 'operating|payroll|tax|investment|debt_service|escrow');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|frozen|restricted');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_key` SET TAGS ('dbx_business_glossary_term' = 'Bank Key');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_address` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Address');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_city` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch City');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_country_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Country Code');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Postal Code');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_state` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch State');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closing Date');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Account Balance');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `house_bank_code` SET TAGS ('dbx_business_glossary_term' = 'SAP House Bank ID');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `house_bank_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `lockbox_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lockbox Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `masked_account_number` SET TAGS ('dbx_business_glossary_term' = 'Masked Bank Account Number');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `masked_account_number` SET TAGS ('dbx_value_regex' = '^X+[0-9]{4}$');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `masked_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `masked_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opening Date');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'ABA Routing Number');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_authority_1` SET TAGS ('dbx_business_glossary_term' = 'Primary Signatory Authority');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_authority_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_authority_2` SET TAGS ('dbx_business_glossary_term' = 'Secondary Signatory Authority');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_authority_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Signatory Threshold Amount');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `statement_format` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Format');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `statement_format` SET TAGS ('dbx_value_regex' = 'MT940|BAI2|CAMT053|PDF|CSV');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Statement Frequency');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Code (BIC)');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`bank_account` ALTER COLUMN `zero_balance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Zero Balance Account (ZBA) Indicator');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley) Control ID');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Control Owner ID');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `sox_performer_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Control Performer ID');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `assertion_category` SET TAGS ('dbx_business_glossary_term' = 'Assertion Category');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `assertion_category` SET TAGS ('dbx_value_regex' = 'existence|completeness|accuracy|valuation|rights_and_obligations|presentation_and_disclosure');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `auditor_reliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Auditor Reliance Flag');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `business_process` SET TAGS ('dbx_business_glossary_term' = 'Business Process');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `company_level_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Company-Level Control Flag');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `compensating_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensating Control Flag');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `control_activity_detail` SET TAGS ('dbx_business_glossary_term' = 'Control Activity Detail');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `control_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Frequency');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `control_nature` SET TAGS ('dbx_business_glossary_term' = 'Control Nature');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `control_nature` SET TAGS ('dbx_value_regex' = 'manual|automated|manual_dependent_on_IT|IT_dependent');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `control_number` SET TAGS ('dbx_business_glossary_term' = 'Control Number');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `control_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{3,5}$');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `control_objective` SET TAGS ('dbx_business_glossary_term' = 'Control Objective');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `control_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Name');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `control_performer_name` SET TAGS ('dbx_business_glossary_term' = 'Control Performer Name');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `control_title` SET TAGS ('dbx_business_glossary_term' = 'Control Title');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `deficiency_classification` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Classification');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `deficiency_classification` SET TAGS ('dbx_value_regex' = 'none|control_deficiency|significant_deficiency|material_weakness');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `deficiency_identified_date` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Identified Date');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `evidence_of_performance` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Performance');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `financial_statement_line_item` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Line Item');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `it_general_control_flag` SET TAGS ('dbx_business_glossary_term' = 'IT (Information Technology) General Control Flag');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `key_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Control Flag');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `next_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Test Due Date');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|validated|closed');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `remediation_target_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Target Date');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `sec_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'SEC (Securities and Exchange Commission) Disclosure Required Flag');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `sox_control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `sox_control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|retired');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `test_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Test Sample Size');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `testing_status` SET TAGS ('dbx_business_glossary_term' = 'Testing Status');
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ALTER COLUMN `testing_status` SET TAGS ('dbx_value_regex' = 'not_tested|in_progress|passed|failed|not_applicable');
ALTER TABLE `grocery_ecm`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'asset_finance');
ALTER TABLE `grocery_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Identifier');
ALTER TABLE `grocery_ecm`.`finance`.`payment_run` ALTER COLUMN `reversed_payment_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`finance`.`cost_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`finance`.`cost_element` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `grocery_ecm`.`finance`.`cost_element` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Identifier');
ALTER TABLE `grocery_ecm`.`finance`.`cost_element` ALTER COLUMN `parent_cost_element_id` SET TAGS ('dbx_self_ref_fk' = 'true');
