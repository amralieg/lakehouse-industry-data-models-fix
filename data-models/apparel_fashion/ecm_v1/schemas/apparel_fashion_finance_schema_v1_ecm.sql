-- Schema for Domain: finance | Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`finance` COMMENT 'Core financial ledger handling financial planning, budgeting, cost accounting (COGS), revenue recognition, AP/AR, general ledger, statutory reporting per IFRS/GAAP, and EBITDA analysis. Manages EOM close, financial consolidation, GMROI, margin analysis, landed cost (LDP) accounting, and profitability analysis by channel, product, and region via SAP S/4HANA FI/CO.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Cost centers belong to a legal entity (company code). Normalizing STRING company_code to FK company_code_id → company_code.company_code_id. Remove redundant company_code STRING column.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Compliance costs (certifications, testing, legal) are allocated to specific cost centers (quality, sourcing, legal) in apparel operations. Enables cost center managers to track compliance spending aga',
    `employee_id` BIGINT COMMENT 'The employee ID or personnel number of the manager responsible for this cost centers budget, spending, and performance.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Cost centers can be linked to profit centers for profitability analysis. Normalizing STRING profit_center_number to FK profit_center_id → profit_center.profit_center_id. Remove redundant profit_center',
    `activity_type` STRING COMMENT 'The primary activity type or cost driver associated with this cost center (e.g., Machine Hours, Labor Hours, Square Footage, Headcount). Used for activity-based costing and allocation.',
    `actual_cost_ytd` DECIMAL(18,2) COMMENT 'The cumulative actual costs posted to this cost center from the beginning of the fiscal year to the current period. Used for budget variance and EOM close reporting.',
    `allocation_cycle_code` STRING COMMENT 'The identifier of the allocation cycle in which this cost center participates as sender or receiver. Used for overhead distribution and internal cost allocation.',
    `brand_code` STRING COMMENT 'The brand or label to which this cost center is aligned (e.g., MAIN, PREMIUM, OUTLET). Used for brand-level profitability analysis.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The approved annual budget amount allocated to this cost center for the current fiscal year. Used for budget control and variance analysis.',
    `budget_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the budget amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `business_area` STRING COMMENT 'The business area or division to which this cost center is assigned (e.g., Apparel, Footwear, Accessories). Used for segment reporting.',
    `channel_code` STRING COMMENT 'The sales or distribution channel to which this cost center is aligned: DTC (Direct-to-Consumer), wholesale, retail (brick-and-mortar stores), ecommerce (digital storefront), outlet (off-price).. Valid values are `dtc|wholesale|retail|ecommerce|outlet`',
    `committed_cost_ytd` DECIMAL(18,2) COMMENT 'The cumulative committed costs (purchase orders, contracts) against this cost center from the beginning of the fiscal year to the current period. Used for funds availability and budget control.',
    `controlling_area` STRING COMMENT 'The SAP Controlling Area (CO) code to which this cost center belongs. Controlling area is the organizational unit in SAP FI/CO for cost accounting and internal reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_allocation_method` STRING COMMENT 'The method used to allocate costs from this cost center to other cost objects: direct (traced to specific receivers), assessment (fixed allocation), distribution (variable allocation), activity-based (driver-based), percentage (proportional split).. Valid values are `direct|assessment|distribution|activity_based|percentage`',
    `cost_center_description` STRING COMMENT 'Extended textual description of the cost centers purpose, scope, and responsibilities. Used for documentation and user guidance.',
    `cost_center_name` STRING COMMENT 'The descriptive name of the cost center (e.g., Design Studio NYC, Warehouse Operations LA, Marketing Digital).',
    `cost_center_number` STRING COMMENT 'The externally-known unique alphanumeric code identifying the cost center in SAP S/4HANA FI/CO. Used for posting, reporting, and budget control.. Valid values are `^[A-Z0-9]{4,10}$`',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active: operational and accepting postings. Inactive: closed, no new postings. Blocked: temporarily suspended. Planned: future cost center not yet operational.. Valid values are `active|inactive|blocked|planned`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by functional purpose: production (manufacturing/CMT), service (support functions), administration (overhead), sales (retail/wholesale), marketing (brand/campaigns), distribution (logistics/3PL), research and development (PLM/design). [ENUM-REF-CANDIDATE: production|service|administration|sales|marketing|distribution|research_development — 7 candidates stripped; promote to reference product]',
    `cost_element_group` STRING COMMENT 'The cost element group or category to which the majority of costs in this cost center belong (e.g., Labor, Materials, Overhead, Depreciation). Used for COGS buildup and cost-of-sales reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was first created in the system. Used for audit trail and data lineage.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for which the actual cost and committed cost figures are reported. Used for monthly close and period-over-period analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which the budget and actual cost figures are reported. Used for year-over-year analysis and EOM close.',
    `functional_area` STRING COMMENT 'The functional classification of the cost center (e.g., Manufacturing, Logistics, Sales, Marketing, Administration). Used for cost-of-sales accounting and COGS buildup.',
    `hierarchy_node` STRING COMMENT 'The hierarchical node or group to which this cost center belongs in the organizational cost center hierarchy. Used for roll-up reporting and consolidation.',
    `is_locked_for_posting` BOOLEAN COMMENT 'Boolean flag indicating whether this cost center is locked and cannot accept new cost postings. Used during period close and cost center deactivation.',
    `is_overhead_receiver` BOOLEAN COMMENT 'Boolean flag indicating whether this cost center receives allocated overhead costs from other cost centers. True if this cost center is a receiver in allocation cycles.',
    `is_overhead_sender` BOOLEAN COMMENT 'Boolean flag indicating whether this cost center sends (distributes) overhead costs to other cost centers or cost objects. True if this cost center is a sender in allocation cycles.',
    `last_modified_by` STRING COMMENT 'The user ID or name of the person who last modified this cost center record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was last updated. Used for change tracking and audit compliance.',
    `location_code` STRING COMMENT 'The physical location or site code where this cost center operates (e.g., warehouse code, store code, office code).',
    `product_line_code` STRING COMMENT 'The product line or category to which this cost center is aligned (e.g., MENS, WOMENS, KIDS, ATHLETIC). Used for product-level cost allocation.',
    `region_code` STRING COMMENT 'The geographic region or market to which this cost center is assigned (e.g., NORAM, EMEA, APAC, LATAM). Used for regional profitability and cost analysis.',
    `source_system` STRING COMMENT 'The name or code of the source system from which this cost center record originated (e.g., SAP_S4HANA_FICO, ANAPLAN). Used for data lineage and reconciliation.',
    `valid_from_date` DATE COMMENT 'The date from which this cost center is valid and operational. Used for time-dependent cost center master data.',
    `valid_to_date` DATE COMMENT 'The date until which this cost center is valid. Null or far-future date indicates open-ended validity. Used for cost center closure and historical reporting.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The budget variance amount (budget minus actual cost YTD). Positive indicates under-budget, negative indicates over-budget.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The budget variance expressed as a percentage of the budget amount. Used for KPI dashboards and management reporting.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Unified organizational cost and profit object master in SAP S/4HANA FI/CO, representing cost centers (overhead allocation receivers), profit centers (autonomous profitability segments), and the allocation cycles that distribute costs between them. Captures organizational attributes (number, name, hierarchy, responsible manager, controlling area, company code, validity period, activity type, segment classification by brand/channel/product line/region) and allocation transactions (cycle, sender, receiver, method, allocated amount, fiscal period). Supports overhead allocation, COGS buildup, budget control, channel-level profitability (DTC vs. wholesale vs. retail), EBITDA reporting, and internal cost distribution for apparel operations.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique identifier for the profit center in SAP S/4HANA CO-PCA. Primary key for the profit center master record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Profit centers belong to a legal entity (company code). Normalizing STRING company_code to FK company_code_id → company_code.company_code_id. Remove redundant company_code STRING column.',
    `allocation_method` STRING COMMENT 'Method used for allocating shared costs and overhead to this profit center. Direct for directly traceable costs; step-down for sequential allocation; reciprocal for mutual service allocation; activity-based for ABC costing.. Valid values are `direct|step_down|reciprocal|activity_based`',
    `analysis_period` STRING COMMENT 'Fiscal period for which profit center performance is analyzed. Format YYYYMM (e.g., 202312 for December 2023). Used for period-over-period EBITDA and margin analysis.. Valid values are `^[0-9]{4}(0[1-9]|1[0-2])$`',
    `brand_code` STRING COMMENT 'Brand identifier for brand-level profit centers in multi-brand apparel fashion companies. Used for brand profitability and EBITDA contribution analysis.. Valid values are `^[A-Z0-9]{2,6}$`',
    `business_area_code` STRING COMMENT 'SAP Business Area code for cross-company code reporting. Enables consolidated financial statements across multiple legal entities for a specific business segment.. Valid values are `^[A-Z0-9]{4}$`',
    `channel_type` STRING COMMENT 'Sales channel classification for channel-level profitability analysis. DTC includes owned stores and brand.com; wholesale includes department stores and specialty retailers; retail includes franchise and licensed stores; ecommerce includes third-party digital platforms; marketplace includes Amazon, Zalando, etc.. Valid values are `dtc|wholesale|retail|ecommerce|marketplace`',
    `consolidation_unit_code` STRING COMMENT 'Code identifying the consolidation unit for group-level financial consolidation. Used for eliminating intercompany transactions and preparing consolidated financial statements.. Valid values are `^[A-Z0-9]{4,10}$`',
    `controlling_area_code` STRING COMMENT 'SAP Controlling Area to which this profit center is assigned. Controlling area represents the organizational unit for cost accounting and profitability analysis.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_group_code` STRING COMMENT 'Code identifying the group of cost centers that roll up into this profit center for cost allocation and overhead absorption in COGS calculation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_by_user` STRING COMMENT 'User ID of the person who created the profit center master record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the profit center master record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the profit centers local currency. Used for revenue recognition, COGS accounting, and margin analysis before consolidation.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Department code for store-level or functional profit centers. Used for department-level profitability in multi-department retail stores.. Valid values are `^[A-Z0-9]{3,6}$`',
    `geographic_region` STRING COMMENT 'Geographic region for regional profit centers. Used for regional profitability analysis and landed cost (LDP) accounting by market.. Valid values are `north_america|emea|apac|latam|greater_china`',
    `hierarchy_code` STRING COMMENT 'Code identifying the profit center hierarchy (standard hierarchy) to which this profit center belongs. Used for multi-level profitability reporting and roll-up analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified the profit center master record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the profit center master record was last updated. Used for change tracking and audit trail.',
    `lock_indicator` BOOLEAN COMMENT 'Flag indicating whether the profit center is locked for transaction posting. True when locked (no new postings allowed); False when unlocked (normal operations). Used during EOM close and financial consolidation.',
    `notes` STRING COMMENT 'Free-text notes and comments about the profit center configuration, special accounting treatments, or organizational changes. Used for audit trail and knowledge management.',
    `planning_level` STRING COMMENT 'Planning granularity level for financial planning and budgeting. Strategic for division-level; tactical for brand/channel-level; operational for store/product-line level.. Valid values are `strategic|tactical|operational`',
    `product_category` STRING COMMENT 'Primary product category for product-line profit centers. Used for GMROI and margin analysis by category.. Valid values are `footwear|apparel|accessories|equipment|licensed_products`',
    `profit_center_code` STRING COMMENT 'Business identifier for the profit center used in SAP S/4HANA. Externally-known alphanumeric code representing the autonomous business segment (e.g., brand, channel, product line, region).. Valid values are `^[A-Z0-9]{4,10}$`',
    `profit_center_name` STRING COMMENT 'Full descriptive name of the profit center. Human-readable label identifying the business segment (e.g., Mens Footwear DTC, Womens Apparel Wholesale, EMEA Retail Operations).',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center. Active profit centers are operational and accumulate financial transactions; planned profit centers are configured but not yet operational; inactive profit centers are temporarily suspended; closed profit centers are permanently retired.. Valid values are `active|inactive|planned|closed`',
    `profit_center_type` STRING COMMENT 'Classification of the profit center by organizational dimension. Indicates whether the profit center represents a brand, sales channel (DTC/wholesale/retail), product line, geographic region, individual store, or business division.. Valid values are `brand|channel|product_line|region|store|division`',
    `responsible_person_email` STRING COMMENT 'Email address of the profit center manager for financial reporting notifications and EBITDA analysis distribution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_person_name` STRING COMMENT 'Name of the business leader or manager accountable for the profit centers financial performance. Typically a brand director, channel head, regional VP, or product line manager.',
    `segment_code` STRING COMMENT 'IFRS segment code for segment reporting under IFRS 8. Represents operating segments for external financial reporting and investor disclosures.. Valid values are `^[A-Z0-9]{4,10}$`',
    `short_name` STRING COMMENT 'Abbreviated name or acronym for the profit center used in reports and dashboards for space-constrained displays.',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code for statutory tax reporting and compliance. Used for VAT/GST reporting and transfer pricing documentation.. Valid values are `^[A-Z]{2,3}$`',
    `transfer_pricing_method` STRING COMMENT 'Transfer pricing method for intercompany transactions between profit centers. Used for internal revenue recognition and OECD transfer pricing compliance.. Valid values are `cost_plus|market_price|negotiated|arms_length`',
    `valid_from_date` DATE COMMENT 'Date from which the profit center becomes effective and begins accumulating financial transactions. Used for time-dependent profit center master data.',
    `valid_to_date` DATE COMMENT 'Date until which the profit center remains effective. Nullable for open-ended profit centers. Used for profit center lifecycle management and historical analysis.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Master record for profit centers in SAP S/4HANA CO-PCA, representing autonomous business segments (e.g., brand, channel, product line, region) for which profitability is measured independently. Tracks revenue, COGS, gross margin, and EBITDA contribution by profit center. Essential for channel-level (DTC vs. wholesale vs. retail) and product-line profitability analysis in apparel fashion.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the general ledger account record in the chart of accounts.',
    `company_code_id` BIGINT COMMENT 'FK to finance.company_code',
    `account_group` STRING COMMENT 'Account group classification code that controls field status, number range, and account behavior in SAP FI. Groups accounts with similar characteristics and posting rules.. Valid values are `^[A-Z0-9]{2,6}$`',
    `account_long_text` STRING COMMENT 'Extended description providing detailed explanation of the account purpose, usage guidelines, and posting rules.',
    `account_name` STRING COMMENT 'Short descriptive name of the general ledger account for display and reporting purposes.',
    `account_number` STRING COMMENT 'The externally-known unique account number used in SAP S/4HANA FI for posting transactions. Typically 4-10 digit numeric code per chart of accounts structure.. Valid values are `^[0-9]{4,10}$`',
    `account_type` STRING COMMENT 'High-level classification of the account into balance sheet (asset, liability, equity) or profit and loss (revenue, expense) categories.. Valid values are `asset|liability|equity|revenue|expense`',
    `balance_sheet_classification` STRING COMMENT 'Classification for balance sheet accounts distinguishing current vs non-current assets and liabilities. Not applicable for P&L accounts.. Valid values are `current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable`',
    `blocked_for_posting_flag` BOOLEAN COMMENT 'Indicates whether the account is currently blocked for all postings. Used to prevent transactions to obsolete or suspended accounts.',
    `cash_flow_classification` STRING COMMENT 'Classification of the account for cash flow statement preparation per IFRS/GAAP. Categorizes cash movements into operating, investing, or financing activities.. Valid values are `operating|investing|financing|not_applicable`',
    `channel_classification` STRING COMMENT 'Classification of the account by sales channel (DTC, wholesale, e-commerce, retail store) for channel-specific profitability analysis in apparel fashion business.',
    `chart_of_accounts_code` STRING COMMENT 'Four-character code identifying the chart of accounts to which this account belongs. Supports multi-COA scenarios for global enterprises.. Valid values are `^[A-Z0-9]{4}$`',
    `cogs_relevant_flag` BOOLEAN COMMENT 'Indicates whether this account is included in COGS calculation. Essential for gross margin analysis and inventory valuation in apparel manufacturing and retail.',
    `consolidation_account` STRING COMMENT 'Account number in the group chart of accounts used for financial consolidation and elimination of intercompany transactions at corporate level.',
    `cost_center_required_flag` BOOLEAN COMMENT 'Indicates whether a cost center assignment is mandatory when posting to this account. Enforces cost allocation discipline for expense accounts.',
    `cost_element_category` STRING COMMENT 'Classification of cost element as primary (posted from FI) or secondary (internal CO allocations). Not applicable for non-cost-element accounts.. Valid values are `primary|secondary|not_applicable`',
    `cost_element_flag` BOOLEAN COMMENT 'Indicates whether this account is relevant for Controlling (CO) module and functions as a cost element for cost center accounting, internal orders, or profitability analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the general ledger account record was first created in the system. Part of audit trail for chart of accounts governance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for accounts denominated in a specific currency. Blank for accounts managed in company code currency.. Valid values are `^[A-Z]{3}$`',
    `ebitda_relevant_flag` BOOLEAN COMMENT 'Indicates whether postings to this account are included in EBITDA calculation. Critical for apparel fashion profitability analysis and investor reporting.',
    `field_status_group` STRING COMMENT 'Four-character code defining which fields are required, optional, or suppressed when posting to this account. Controls data entry behavior in SAP FI.. Valid values are `^[A-Z0-9]{4}$`',
    `financial_statement_category` STRING COMMENT 'Detailed financial statement line item classification for statutory reporting. Maps account to specific line items in balance sheet, income statement, or cash flow statement per IFRS/GAAP requirements.',
    `functional_area` STRING COMMENT 'Classification of the account by business function (e.g., production, sales, administration, R&D) for functional cost-of-sales reporting per IFRS requirements.',
    `gaap_classification` STRING COMMENT 'US GAAP classification code for accounts used in US statutory reporting. Supports dual-reporting requirements for multinational apparel companies.',
    `gl_account_status` STRING COMMENT 'Current lifecycle status of the general ledger account indicating whether it is actively used, retired, or awaiting approval for use.. Valid values are `active|inactive|obsolete|pending_approval`',
    `gmroi_category` STRING COMMENT 'Classification for GMROI analysis in apparel merchandising. Links account to inventory investment and margin performance metrics by product category or channel.',
    `ifrs_classification` STRING COMMENT 'Detailed IFRS standard and paragraph reference for account classification. Ensures compliance with international accounting standards for statutory reporting.',
    `interest_calculation_indicator` STRING COMMENT 'Code indicating whether and how interest is calculated on balances in this account. Used for customer/vendor interest calculation and treasury management.',
    `landed_cost_component` STRING COMMENT 'Classification of the account as a component of landed cost calculation (freight, duty, insurance, customs). Critical for apparel import cost accounting and FOB to LDP reconciliation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the account master data. Supports change tracking and compliance audit requirements.',
    `line_item_display_flag` BOOLEAN COMMENT 'Indicates whether individual line items are stored and displayable for this account. Required for detailed transaction analysis and audit trails.',
    `open_item_management_flag` BOOLEAN COMMENT 'Indicates whether the account is managed on an open item basis, requiring explicit clearing of line items. Essential for AP, AR, and clearing accounts.',
    `planning_level` STRING COMMENT 'Defines the organizational level at which budget planning and control is performed for this account (e.g., company code, profit center, cost center).',
    `posting_allowed_flag` BOOLEAN COMMENT 'Indicates whether direct manual or automated postings are permitted to this account. Some accounts may be restricted to system-only postings or blocked entirely.',
    `profit_center_required_flag` BOOLEAN COMMENT 'Indicates whether a profit center assignment is mandatory when posting to this account. Used to enforce segment reporting and profitability analysis by business unit.',
    `profit_loss_classification` STRING COMMENT 'Detailed classification for income statement accounts including COGS, operating expenses, EBITDA components, and non-operating items. Used for margin analysis and profitability reporting.',
    `reconciliation_account_flag` BOOLEAN COMMENT 'Indicates whether this is a reconciliation account (subledger control account) that summarizes detailed postings from subsidiary ledgers such as Accounts Payable (AP), Accounts Receivable (AR), or asset accounting.',
    `sort_key` STRING COMMENT 'Three-character code controlling the allocation and sorting of line items within the account. Used for automatic payment programs and dunning.. Valid values are `^[A-Z0-9]{3}$`',
    `tax_category` STRING COMMENT 'Tax classification code indicating whether the account is subject to input tax, output tax, non-taxable, or tax-exempt treatment. Used for VAT/GST reporting and compliance.',
    `tolerance_group` STRING COMMENT 'Four-character code defining posting and clearing tolerances for the account. Controls maximum amounts and variances permitted in transactions.. Valid values are `^[A-Z0-9]{4}$`',
    `valid_from_date` DATE COMMENT 'Date from which the account is valid and available for posting. Supports time-dependent chart of accounts changes.',
    `valid_to_date` DATE COMMENT 'Date until which the account is valid. Null for accounts with indefinite validity. Used to phase out obsolete accounts.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'Chart of accounts master defining every general ledger account used in SAP S/4HANA FI for the apparel fashion enterprise. Includes account number, account type (P&L vs. balance sheet), account group, reconciliation account flag, currency, tax category, IFRS/GAAP classification, and controlling relevance. Underpins all journal entries, statutory reporting, and financial consolidation.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`ledger` (
    `ledger_id` BIGINT COMMENT 'Unique identifier for the accounting ledger in SAP S/4HANA FI. Primary key for the ledger entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Ledgers belong to a legal entity (company code). Normalizing STRING company_code to FK company_code_id → company_code.company_code_id. Remove redundant company_code STRING column.',
    `accounting_principle` STRING COMMENT 'The accounting standard or framework applied in this ledger (e.g., IFRS, US GAAP, local country GAAP, management accounting, tax accounting). Determines valuation rules, recognition policies, and reporting requirements.. Valid values are `ifrs|us_gaap|local_gaap|management|tax`',
    `accrual_posting_status` STRING COMMENT 'Status of accrual and deferral postings for the current period. Accruals ensure expenses and revenues are recognized in the correct period per the applicable accounting principle (IFRS, GAAP). Pending indicates accruals not yet posted; complete indicates all accruals posted; partial indicates some accruals posted.. Valid values are `pending|complete|partial`',
    `base_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the primary currency for this ledger (e.g., USD, EUR, GBP). All financial amounts in this ledger are expressed or translated into this currency.. Valid values are `^[A-Z]{3}$`',
    `chart_of_accounts` STRING COMMENT 'The chart of accounts used in this ledger, defining the structure and numbering of general ledger (GL) accounts. Supports operational, group, and country-specific charts of accounts.. Valid values are `^[A-Z0-9]{4}$`',
    `close_blocking_reason` STRING COMMENT 'Free-text description of the issue preventing period close completion when close_checklist_status is blocked. Examples: unreconciled intercompany balances, missing accruals, pending depreciation run, outstanding approvals.',
    `close_calendar_template` STRING COMMENT 'Identifier or name of the close calendar template defining the structured sequence of close tasks, milestones, and deadlines for this ledger. Templates standardize close processes across periods and company codes.',
    `close_checklist_status` STRING COMMENT 'Overall status of the period-end close checklist for the current period. Not started indicates close has not begun; in progress indicates active close tasks; complete indicates all steps finished and approved; blocked indicates close is halted due to issues.. Valid values are `not_started|in_progress|complete|blocked`',
    `close_responsible_owner` STRING COMMENT 'Name or identifier of the finance team member or role responsible for managing the period-end close process for this ledger. Accountable for completing close checklist steps and obtaining sign-off approvals.',
    `consolidation_group` STRING COMMENT 'Identifier of the consolidation group or reporting entity to which this ledger belongs. Used for group-level financial consolidation and statutory reporting across multiple company codes and legal entities.',
    `consolidation_ledger_flag` BOOLEAN COMMENT 'Indicates whether this ledger is used for group consolidation and statutory reporting. True if the ledger feeds consolidation systems; false for local or management ledgers.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ledger record was first created in SAP S/4HANA FI. Audit field for configuration change tracking.',
    `currency_type` STRING COMMENT 'Defines the currency perspective for this ledger. Company code currency is local operational currency; group currency is the consolidation currency; hard currency is a stable reference currency; index currency supports inflation-adjusted reporting.. Valid values are `company_code|group|hard|index|global`',
    `current_fiscal_year` STRING COMMENT 'The fiscal year currently active for posting and reporting in this ledger (e.g., 2024). Updated at fiscal year rollover.',
    `current_posting_period` STRING COMMENT 'The posting period currently open for transaction entry in this ledger (1-16, where 1-12 are regular periods and 13-16 are special periods for adjustments). Controlled by period-end close process.',
    `depreciation_run_status` STRING COMMENT 'Status of the periodic depreciation calculation and posting run for fixed assets in this ledger. Depreciation run is a mandatory step in the End of Month (EOM) close process.. Valid values are `pending|running|complete|failed`',
    `effective_end_date` DATE COMMENT 'The date on which this ledger was closed or deactivated. Null for active ledgers. Used for historical ledgers that have been archived or replaced.',
    `effective_start_date` DATE COMMENT 'The date from which this ledger became active and began accepting financial postings. Represents the go-live date for the ledger.',
    `fiscal_year_variant` STRING COMMENT 'SAP fiscal year variant code defining the fiscal calendar structure for this ledger (number of periods, period start/end dates, year-end date). Supports calendar year, non-calendar year, and special period configurations.. Valid values are `^[A-Z0-9]{2,4}$`',
    `intercompany_reconciliation_status` STRING COMMENT 'Status of intercompany balance reconciliation for the current period. Reconciled indicates all intercompany transactions match between trading partners; variance identified indicates discrepancies requiring resolution before close.. Valid values are `pending|in_progress|reconciled|variance_identified`',
    `last_close_date` DATE COMMENT 'The date on which the most recent period close was completed and signed off. Represents the last successful End of Month (EOM) close milestone.',
    `last_closed_period` STRING COMMENT 'The most recent posting period that has completed the End of Month (EOM) close process and is locked for further postings. Used to track close progress and enforce period controls.',
    `leading_ledger_flag` BOOLEAN COMMENT 'Indicates whether this is the leading ledger (primary book of record) for the organization. True for the leading ledger; false for extension or special purpose ledgers. Only one leading ledger is permitted per client.',
    `ledger_code` STRING COMMENT 'Short alphanumeric code identifying the ledger in SAP S/4HANA (e.g., 0L for leading ledger, 2L for IFRS ledger). Used as the business identifier for the ledger across financial transactions and reporting.. Valid values are `^[A-Z0-9]{2,4}$`',
    `ledger_name` STRING COMMENT 'Full descriptive name of the accounting ledger (e.g., Leading Ledger, IFRS Ledger, Management Accounting Ledger). Human-readable label for business users.',
    `ledger_status` STRING COMMENT 'Current operational status of the ledger. Active ledgers accept postings; inactive ledgers are configured but not yet in use; closed ledgers are archived and read-only; suspended ledgers are temporarily blocked.. Valid values are `active|inactive|closed|suspended`',
    `ledger_type` STRING COMMENT 'Classification of the ledger role in the accounting architecture. Leading ledger is the primary book of record; extension ledgers support parallel accounting views (IFRS, local GAAP); special purpose ledgers support management accounting or simulation scenarios.. Valid values are `leading|extension|special_purpose`',
    `modified_by` STRING COMMENT 'SAP user ID of the person who last modified this ledger configuration. Used for audit trail and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ledger record was last modified in SAP S/4HANA FI. Audit field for configuration change tracking.',
    `multi_gaap_compliance_flag` BOOLEAN COMMENT 'Indicates whether this ledger is part of a multi-GAAP parallel accounting setup, supporting simultaneous compliance with multiple accounting standards (e.g., IFRS and US GAAP). True if multi-GAAP; false if single standard.',
    `next_close_due_date` DATE COMMENT 'The target date by which the next period close must be completed. Drives the close calendar and task scheduling for depreciation runs, accruals, intercompany reconciliation, and statutory reporting milestones.',
    `notes` STRING COMMENT 'Free-text field for additional comments, configuration notes, or special instructions related to this ledger. Used for documentation and knowledge transfer.',
    `parallel_accounting_scenario` STRING COMMENT 'Describes the specific parallel accounting use case this ledger supports (e.g., IFRS 16 Leases, US GAAP Revenue Recognition, Local Tax Reporting). Free-text field for business context.',
    `period_lock_status` STRING COMMENT 'Indicates whether the current posting period is open for all users, locked to prevent further postings, or partially locked (open only for specific user groups or account ranges). Managed during End of Month (EOM) close.. Valid values are `open|locked|partially_locked`',
    `posting_period_variant` STRING COMMENT 'SAP posting period variant controlling the number of posting periods and special periods (e.g., 12 regular periods plus 4 special periods for year-end adjustments). Governs period open/close controls.. Valid values are `^[A-Z0-9]{2,4}$`',
    `sign_off_approver` STRING COMMENT 'Name or identifier of the senior finance leader (e.g., CFO, Controller, Finance Director) responsible for final approval and sign-off of the period close for this ledger. Approval confirms financial statements are complete and accurate.',
    `sign_off_date` DATE COMMENT 'The date on which the sign-off approver formally approved the period close and financial statements for this ledger. Marks the official completion of the close process.',
    `statutory_reporting_status` STRING COMMENT 'Status of statutory financial reporting deliverables for this ledger and period (e.g., balance sheet, income statement, cash flow statement per IFRS or local GAAP). Not started indicates reports not yet generated; submitted indicates reports filed with authorities; approved indicates reports signed off by auditors or management.. Valid values are `not_started|in_progress|submitted|approved`',
    `valuation_method` STRING COMMENT 'The valuation approach applied in this ledger. Legal valuation follows local statutory rules; group valuation applies corporate consolidation policies; profit center and segment valuations support internal management reporting.. Valid values are `legal|group|profit_center|segment`',
    `created_by` STRING COMMENT 'SAP user ID of the person who created this ledger configuration in the system. Used for audit trail and configuration governance.',
    CONSTRAINT pk_ledger PRIMARY KEY(`ledger_id`)
) COMMENT 'Represents parallel accounting ledgers in SAP S/4HANA FI for the apparel fashion group, supporting IFRS, local GAAP, and management accounting views simultaneously. Captures ledger type, accounting principle, currency, fiscal year variant, and posting period controls. Includes complete period-end close management: EOM close checklist steps, responsible owners, planned/actual completion dates, status (open, in-progress, complete, blocked), blocking reasons, sign-off approvals, and the structured close calendar including depreciation runs, accruals, intercompany reconciliation, and statutory reporting milestones for each fiscal period and company code. Enables statutory reporting, financial consolidation, and multi-GAAP compliance across global markets.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry document in SAP S/4HANA FI. Primary key for the journal entry record.',
    `carbon_offset_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset. Business justification: Links offset purchases to GL postings. Enables financial/ESG reconciliation of carbon credit transactions, net-zero accounting verification, and audit trail for voluntary carbon market purchases—requi',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Journal entries are posted to a legal entity (company code). Normalizing STRING company_code to FK company_code_id → company_code.company_code_id. Remove redundant company_code STRING column.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entries can be allocated to cost centers for cost tracking. Normalizing STRING cost_center to FK cost_center_id → cost_center.cost_center_id. Remove redundant cost_center STRING column.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Journal entries post to GL accounts for financial reporting. Normalizing STRING gl_account to FK gl_account_id → gl_account.gl_account_id. Remove redundant gl_account STRING column.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Journal entries are posted to a ledger for parallel accounting. Normalizing STRING ledger_group to FK ledger_id → ledger.ledger_id. Remove redundant ledger_group STRING column.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Journal entries can be allocated to profit centers for profitability analysis. Normalizing STRING profit_center to FK profit_center_id → profit_center.profit_center_id. Remove redundant profit_center ',
    `accounting_principle` STRING COMMENT 'The accounting standard under which this journal entry is classified (IFRS, GAAP, LOCAL_GAAP, TAX). Supports parallel accounting and multi-GAAP reporting requirements.. Valid values are `IFRS|GAAP|LOCAL_GAAP|TAX`',
    `amount_document_currency` DECIMAL(18,2) COMMENT 'The monetary amount of the journal entry line item in the document currency (transaction currency). Used for multi-currency reporting and reconciliation.',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'The monetary amount of the journal entry line item in the company codes local currency. Used for statutory financial statements and local GAAP reporting.',
    `assignment_field` STRING COMMENT 'Free-text field used for additional sorting and grouping of line items. Often contains purchase order numbers, project codes, or other business references for reconciliation.',
    `business_area` STRING COMMENT 'Four-character code representing a business segment or division for internal management reporting. Enables profitability analysis by business unit across company codes.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this journal entry record was first created in the SAP system. Used for audit trail and process performance monitoring.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the document currency (transaction currency). All line items in the document are posted in this currency.. Valid values are `^[A-Z]{3}$`',
    `debit_credit_indicator` STRING COMMENT 'Indicator for debit (S=Soll/debit) or credit (H=Haben/credit) posting. Fundamental accounting classification for double-entry bookkeeping.. Valid values are `S|H`',
    `document_date` DATE COMMENT 'The date on the source document (invoice, receipt, etc.) that originated this journal entry. May differ from posting date due to processing delays.',
    `document_header_text` STRING COMMENT 'Free-text description at the journal entry header level. Provides business context for the entire document (e.g., Month-end accrual for freight costs, Intercompany elimination Q1 2024).',
    `document_number` STRING COMMENT 'The externally-known accounting document number assigned by SAP S/4HANA FI. Unique within company code and fiscal year. Used for audit trail and cross-reference.. Valid values are `^[A-Z0-9]{10}$`',
    `document_type` STRING COMMENT 'Two-character code classifying the journal entry by business transaction type (e.g., SA=GL account document, DR=customer invoice, KR=vendor invoice, AB=accounting document). Controls number ranges and posting rules.. Valid values are `^[A-Z]{2}$`',
    `entry_date` DATE COMMENT 'The date when the journal entry was physically entered into the SAP system by the user. Used for audit trail and process monitoring.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate used to convert document currency to local currency. Applied at document header level for all line items.',
    `exchange_rate_type` STRING COMMENT 'Code identifying the type of exchange rate used (e.g., M=average rate, B=bank buying rate, G=bank selling rate). Determines which rate table is used for currency conversion.. Valid values are `^[A-Z]{1,4}$`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when the entry was posted. Typically 1-12 for regular periods, 13-16 for special closing periods.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the journal entry was posted. Used for period-based financial reporting and statutory compliance.',
    `functional_area` STRING COMMENT 'Classification of costs and revenues by business function (e.g., production, sales, administration, R&D). Required for cost-of-sales accounting and functional P&L statements per IFRS.. Valid values are `^[A-Z0-9]{4}$`',
    `intercompany_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry represents an intercompany transaction requiring elimination during financial consolidation. True for intercompany, False for external transactions.',
    `last_modified_by` STRING COMMENT 'SAP user ID of the person who last modified this journal entry. Used for change tracking and audit compliance.. Valid values are `^[A-Z0-9]{8,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this journal entry record was last modified. Tracks the most recent change for audit and compliance purposes.',
    `line_item_text` STRING COMMENT 'Free-text description at the line item level providing business context for the specific posting (e.g., Accrued freight for shipment #12345, COGS adjustment for SKU ABC123).',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the company codes local currency. Used for statutory reporting and local GAAP compliance.. Valid values are `^[A-Z]{3}$`',
    `posting_date` DATE COMMENT 'The date on which the journal entry was posted to the general ledger. This is the accounting date that determines the fiscal period and affects financial statement balances. Critical for period-end close (EOM) and financial reporting.',
    `posting_key` STRING COMMENT 'Two-digit code that controls the type of posting (debit/credit) and the account type (GL, customer, vendor, asset). Determines field status and posting behavior in SAP.. Valid values are `^[0-9]{2}$`',
    `reference_document_number` STRING COMMENT 'External reference number from source document (invoice number, PO number, etc.). Used for reconciliation and cross-reference to operational documents.',
    `reversal_date` DATE COMMENT 'The date on which this journal entry was reversed, if applicable. Null if not reversed. Used for tracking accrual reversals and corrections.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry has been reversed. True if reversed, False if active. Used for period-end adjustments and error corrections.',
    `segment` STRING COMMENT 'Organizational unit for segment reporting per IFRS 8. Represents an operating segment for which discrete financial information is available and regularly reviewed by chief operating decision maker.. Valid values are `^[A-Z0-9]{10}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount for this line item in local currency. Automatically derived from tax code and base amount.',
    `tax_code` STRING COMMENT 'Two-character code identifying the tax rate and tax type (VAT, sales tax, use tax) applied to this line item. Drives automatic tax calculation and tax reporting.. Valid values are `^[A-Z0-9]{2}$`',
    `trading_partner` STRING COMMENT 'Identifier for the intercompany trading partner in intercompany transactions. Used for intercompany eliminations and consolidation in multi-entity organizations.. Valid values are `^[A-Z0-9]{6}$`',
    `transaction_code` STRING COMMENT 'The SAP transaction code (T-code) used to create this journal entry (e.g., FB01, FB50, F-02). Indicates whether entry was manual or automated from SD/MM/PP modules.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `translation_date` DATE COMMENT 'The date used to determine the exchange rate for currency translation. Typically the posting date or document date.',
    `wbs_element` STRING COMMENT 'Project Systems work breakdown structure element for project-related postings. Enables project cost tracking and capital expenditure management.. Valid values are `^[A-Z0-9-]{8,24}$`',
    `created_by` STRING COMMENT 'SAP user ID of the person who created this journal entry. Used for audit trail, segregation of duties monitoring, and compliance with SOX controls.. Valid values are `^[A-Z0-9]{8,12}$`',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Core accounting document in SAP S/4HANA FI capturing every financial posting at both header and line-item granularity. Header attributes include document number, posting date, fiscal period, ledger, company code, currency, reversal status, and IFRS/GAAP classification. Line items capture GL account, cost center, profit center, debit/credit amounts in transaction and local currency, tax code, assignment field, WBS element, and business area. Covers manual journal entries, automated postings from SD/MM/PP, period-end accruals, reclassifications, and intercompany eliminations. Provides the complete authoritative audit trail for all financial movements in the apparel fashion enterprise.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for the journal entry line detail record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entry lines can be allocated to cost centers for cost tracking. Normalizing STRING cost_center_code to FK cost_center_id → cost_center.cost_center_id. Remove redundant cost_center_code STRING ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Journal entry lines post to GL accounts for financial reporting. Normalizing STRING gl_account_code to FK gl_account_id → gl_account.gl_account_id. Remove redundant gl_account_code STRING column.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry document header. Links this line item to its controlling document.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Journal entry lines can be allocated to profit centers for profitability analysis. Normalizing STRING profit_center_code to FK profit_center_id → profit_center.profit_center_id. Remove redundant profi',
    `amount_group_currency` DECIMAL(18,2) COMMENT 'Monetary amount of the line item converted to the corporate group reporting currency. Used for consolidated financial statements and group-level EBITDA analysis.',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'Monetary amount of the line item converted to the company code local currency. Used for statutory reporting and local GAAP compliance.',
    `amount_transaction_currency` DECIMAL(18,2) COMMENT 'Monetary amount of the line item in the original transaction currency. Used for multi-currency operations and foreign exchange tracking.',
    `assignment_field` STRING COMMENT 'Free-text assignment field for additional sorting and grouping criteria. Often used to store reference numbers, batch identifiers, or custom allocation keys.',
    `baseline_date` DATE COMMENT 'Baseline date for payment terms calculation. Starting point for determining due dates and cash discount periods in AP/AR processing.',
    `business_area_code` STRING COMMENT 'Business area classification for cross-company code segment reporting. Used for creating separate balance sheets and P&L statements by business division.. Valid values are `^[A-Z0-9]{4}$`',
    `clearing_date` DATE COMMENT 'Date when this line item was cleared or settled. Used for open item management in AP/AR and reconciliation processes.',
    `clearing_document_number` STRING COMMENT 'Document number of the clearing transaction that settled this line item. Links open items to their corresponding payment or offset entries.. Valid values are `^[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry line item record was first created in the system. Audit trail for data lineage and compliance.',
    `customer_code` STRING COMMENT 'Customer account number for accounts receivable postings. Links financial transactions to customer master data for AR aging and revenue recognition.. Valid values are `^[A-Z0-9]{6,10}$`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this line item represents a debit or credit entry in the general ledger. Fundamental accounting classification for double-entry bookkeeping.. Valid values are `debit|credit`',
    `functional_area_code` STRING COMMENT 'Functional area classification for cost-of-sales accounting. Distinguishes between production, sales, administration, and other functional cost categories per IFRS/GAAP requirements.. Valid values are `^[A-Z0-9]{4,10}$`',
    `group_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the corporate group reporting currency. Used for consolidation and group-level financial analysis.. Valid values are `^[A-Z]{3}$`',
    `internal_order_number` STRING COMMENT 'Internal order number for overhead cost collection and allocation. Used for tracking costs of internal activities, events, or short-term projects.. Valid values are `^[0-9]{10,12}$`',
    `line_item_text` STRING COMMENT 'Descriptive text explaining the business purpose or nature of this journal entry line. Provides context for auditors and financial analysts.',
    `line_number` STRING COMMENT 'Sequential line item number within the journal entry document. Determines the ordering and position of this line in the posting.',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the company code local currency. Typically the statutory reporting currency for the legal entity.. Valid values are `^[A-Z]{3}$`',
    `material_number` STRING COMMENT 'Material or SKU number for inventory-related postings. Links financial transactions to specific products for COGS analysis and inventory valuation.. Valid values are `^[A-Z0-9]{6,18}$`',
    `payment_terms_code` STRING COMMENT 'Payment terms code defining due date calculation and cash discount conditions. Used for cash flow forecasting and working capital management.. Valid values are `^[A-Z0-9]{4}$`',
    `plant_code` STRING COMMENT 'Manufacturing plant or distribution center code for location-specific cost allocation. Used for multi-site COGS analysis and supply chain cost tracking.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_key` STRING COMMENT 'Two-digit code that controls whether the line is a debit or credit and determines account type behavior (asset, liability, revenue, expense). Standard SAP posting keys include 40 (debit GL), 50 (credit GL), 01 (debit customer), 11 (credit customer), 21 (debit vendor), 31 (credit vendor).. Valid values are `^[0-9]{2}$`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of goods or materials associated with this line item. Used for inventory movements, COGS calculation, and unit cost analysis.',
    `reference_key_1` STRING COMMENT 'First reference key field for linking to source documents or external systems. Commonly used for invoice numbers, PO numbers, or EDI transaction references.',
    `reference_key_2` STRING COMMENT 'Second reference key field for additional cross-reference tracking. Supports multi-level document traceability and reconciliation.',
    `reference_key_3` STRING COMMENT 'Third reference key field for extended reference data. Used in complex allocation scenarios or multi-system integration environments.',
    `reversal_document_number` STRING COMMENT 'Document number of the reversal transaction if this line item was reversed. Maintains complete audit trail for corrected entries.. Valid values are `^[0-9]{10}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this line item has been reversed. Used for audit trail and error correction tracking in financial accounting.',
    `storage_location_code` STRING COMMENT 'Storage location within a plant for detailed inventory tracking. Enables warehouse-level cost allocation and inventory valuation.. Valid values are `^[A-Z0-9]{4}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Calculated tax amount for this line item in local currency. Automatically derived from tax code and base amount for indirect tax compliance.',
    `tax_code` STRING COMMENT 'Tax code that determines the tax type, rate, and GL accounts for automatic tax calculation and posting. Supports VAT, sales tax, and other indirect tax requirements.. Valid values are `^[A-Z0-9]{2,4}$`',
    `trading_partner_code` STRING COMMENT 'Trading partner company code for intercompany transactions. Identifies the counterparty legal entity in cross-company postings for consolidation elimination.. Valid values are `^[A-Z0-9]{4,10}$`',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount. Represents the currency in which the original business transaction occurred.. Valid values are `^[A-Z]{3}$`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity field. Standard codes include EA (each), KG (kilogram), M (meter), PC (piece), etc.. Valid values are `^[A-Z]{2,3}$`',
    `value_date` DATE COMMENT 'Value date for cash management and bank reconciliation. Represents the effective date when funds are available or debited.',
    `vendor_code` STRING COMMENT 'Vendor account number for accounts payable postings. Links financial transactions to supplier master data for AP aging and payment processing.. Valid values are `^[A-Z0-9]{6,10}$`',
    `wbs_element_code` STRING COMMENT 'WBS element for project-related postings. Links financial transactions to specific project phases or deliverables in PLM and capital project accounting.. Valid values are `^[A-Z0-9-]{6,24}$`',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit or credit line item within a journal entry document in SAP S/4HANA FI. Captures GL account, cost center, profit center, WBS element, business area, amount in transaction and local currency, tax code, assignment field, and line item text. Provides the granular posting detail required for cost allocation, COGS analysis, and statutory reporting in apparel fashion.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts payable invoice record in SAP S/4HANA FI-AP.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Third-party audit invoices (social compliance, factory safety, quality audits) are routine AP transactions in apparel. Links audit service costs to specific audit events for cost tracking and vendor p',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: AP invoices are posted to a legal entity (company code). Normalizing STRING company_code to FK company_code_id → company_code.company_code_id. Remove redundant company_code STRING column.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AP invoices can be allocated to cost centers for cost tracking. Normalizing STRING cost_center_code to FK cost_center_id → cost_center.cost_center_id. Remove redundant cost_center_code STRING column.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: AP invoices for employee expense reimbursements (travel, samples, trade shows) must link to employee for expense tracking and approval workflows. Common in apparel for buyer travel and showroom expens',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AP invoices post to GL accounts for financial reporting. Normalizing STRING gl_account_code to FK gl_account_id → gl_account.gl_account_id. Remove redundant gl_account_code STRING column.',
    `order_purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order against which this invoice is matched in the three-way match process (PO/GR/IR).',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: AP invoices can be allocated to profit centers for profitability analysis. Normalizing STRING profit_center_code to FK profit_center_id → profit_center.profit_center_id. Remove redundant profit_center',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor who issued this invoice. Links to the supplier master data.',
    `approved_by` STRING COMMENT 'The user ID or name of the person who approved this invoice for payment.',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice was approved for payment in the accounts payable workflow.',
    `baseline_date` DATE COMMENT 'The date from which payment terms are calculated. Typically the invoice date or goods receipt date, depending on payment terms configuration.',
    `cogs_recognition_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this invoice is recognized as part of COGS for apparel sourcing and manufacturing costs.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the SAP S/4HANA FI-AP system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The cash discount amount available if payment is made within the discount period per payment terms (e.g., 2% if paid within 10 days).',
    `discount_due_date` DATE COMMENT 'The last date by which payment must be made to qualify for the cash discount per payment terms.',
    `due_date` DATE COMMENT 'The date by which payment is due to the vendor per the agreed payment terms. Used for cash flow planning and payables aging analysis.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the invoice currency to the company code currency at the time of posting.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year to which this invoice is assigned for EOM (End of Month) close and financial reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this invoice is assigned for financial reporting and period closing purposes.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before any deductions, including all line items, freight, and other charges but before tax.',
    `ifrs_accrual_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this invoice has been accrued for IFRS financial reporting purposes prior to receipt of the vendor invoice.',
    `invoice_category` STRING COMMENT 'The business category of the invoice expense: raw materials, CMT (Cut Make Trim) services, freight, operating expenses, capital expenditure, or other.. Valid values are `raw_materials|cmt_services|freight|operating_expense|capital_expenditure|other`',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. This is the principal business event timestamp for the invoice.',
    `invoice_number` STRING COMMENT 'The vendor-provided invoice number as printed on the invoice document. This is the external business identifier for the invoice.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts payable workflow. [ENUM-REF-CANDIDATE: draft|posted|blocked|approved|paid|cancelled|disputed — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'The type of invoice document: standard invoice, credit memo (vendor refund), debit memo (additional charge), prepayment, or recurring invoice.. Valid values are `standard|credit_memo|debit_memo|prepayment|recurring`',
    `landed_cost_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this invoice contributes to landed cost (LDP) accounting for imported goods, including freight, duties, and customs charges.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last modified in the SAP S/4HANA FI-AP system.',
    `net_amount` DECIMAL(18,2) COMMENT 'The total amount payable to the vendor after applying all taxes, discounts, and adjustments. This is the final payment amount.',
    `payment_block_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether payment for this invoice is currently blocked pending resolution of discrepancies or approval.',
    `payment_block_reason` STRING COMMENT 'The reason code or description explaining why payment is blocked (e.g., price variance, quantity variance, missing goods receipt, pending approval).',
    `payment_date` DATE COMMENT 'The actual date on which payment was made to the vendor. Null if invoice is unpaid.',
    `payment_method` STRING COMMENT 'The method by which payment will be made to the vendor (e.g., wire transfer, check, ACH, EFT, letter of credit).. Valid values are `wire_transfer|check|ach|eft|letter_of_credit|cash`',
    `payment_reference_number` STRING COMMENT 'The reference number assigned when payment is made, linking the invoice to the payment transaction for reconciliation.',
    `payment_terms_code` STRING COMMENT 'The code representing the payment terms agreed with the vendor (e.g., Net 30, Net 60, 2/10 Net 30). Determines due date and discount eligibility.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the general ledger in SAP S/4HANA FI. Used for period assignment and financial reporting.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount charged on the invoice, including VAT, GST, or other applicable taxes per jurisdiction.',
    `tax_jurisdiction_code` STRING COMMENT 'The tax jurisdiction code determining which tax rates and rules apply to this invoice (e.g., country, state, or region).',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match process comparing purchase order (PO), goods receipt (GR), and invoice receipt (IR). Critical for invoice approval and payment release.. Valid values are `matched|unmatched|partial_match|variance_within_tolerance|variance_exceeds_tolerance`',
    `vendor_reference_number` STRING COMMENT 'An additional reference number provided by the vendor for their internal tracking or cross-reference purposes.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax deducted from the payment to the vendor per local tax regulations.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts payable invoice record in SAP S/4HANA FI-AP capturing vendor invoices for raw materials, CMT services, freight, and operating expenses. Stores vendor reference, invoice date, due date, payment terms, gross amount, tax amount, discount terms, three-way match status (PO/GR/IR), payment block reason, and IFRS accrual flag. Central to landed cost (LDP) accounting and COGS recognition for apparel sourcing.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts receivable invoice record in SAP S/4HANA FI-AR. Primary key for the invoice entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: AR invoices are posted to a legal entity (company code). Normalizing STRING company_code to FK company_code_id → company_code.company_code_id. Remove redundant company_code STRING column.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AR invoices can be allocated to cost centers. Normalizing STRING cost_center to FK cost_center_id → cost_center.cost_center_id. Remove redundant cost_center STRING column.',
    `profile_id` BIGINT COMMENT 'Reference to the customer account being billed. Links to the customer master data for wholesale, DTC (Direct-to-Consumer), or retail channel customers.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: AR invoices track profitability by profit center. Normalizing STRING profit_center to FK profit_center_id → profit_center.profit_center_id. Remove redundant profit_center STRING column.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to order.sales_order. Business justification: AR invoices are generated from sales orders in the order-to-cash process. This link enables revenue recognition reconciliation, invoice dispute resolution tracing back to original order terms, and fin',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: B2B invoices in apparel wholesale operations are issued to wholesale accounts (department stores, specialty retailers, distributors), not individual profiles. Required for trade receivables aging, cre',
    `billing_block_reason` STRING COMMENT 'Free-text or coded reason if the invoice was blocked from posting. Common reasons include credit limit exceeded, pricing errors, incomplete delivery, or customer account on hold. Null for unblocked invoices.',
    `billing_date` DATE COMMENT 'The date the invoice was issued to the customer. Serves as the baseline for payment terms calculation and revenue recognition timing per IFRS 15.',
    `business_area` STRING COMMENT 'SAP business area code for segment reporting and profitability analysis. Typically represents product divisions (e.g., athletic, lifestyle, luxury) or geographic regions for EBITDA (Earnings Before Interest Taxes Depreciation and Amortization) analysis.. Valid values are `^[A-Z0-9]{4}$`',
    `clearing_date` DATE COMMENT 'The date the invoice was fully paid and cleared from open items in SAP S/4HANA FI-AR. Null for unpaid or partially paid invoices. Used to calculate actual DSO and payment cycle metrics.',
    `clearing_document_number` STRING COMMENT 'SAP document number of the payment or clearing transaction that settled this invoice. Links the invoice to the corresponding payment record for reconciliation and audit purposes.. Valid values are `^[A-Z0-9]{8,20}$`',
    `created_by_user` STRING COMMENT 'SAP user ID of the person or system process that created the invoice record. Required for SOX (Sarbanes-Oxley) compliance and segregation of duties audits.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the invoice record was first created in SAP S/4HANA FI-AR. Used for audit trails and data lineage tracking per GDPR and CCPA compliance requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice transaction (e.g., USD, EUR, GBP). All monetary amounts on this invoice are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total trade discounts, volume discounts, and promotional allowances deducted from the gross amount. Includes early payment discounts if taken. Critical for MD (Markdown) analysis and IMU (Initial Markup) vs MMU (Maintained Markup) tracking.',
    `due_date` DATE COMMENT 'The date by which payment is expected from the customer based on agreed payment terms. Used for cash flow forecasting, dunning process triggers, and overdue analysis.',
    `dunning_date` DATE COMMENT 'The date the most recent dunning notice was sent to the customer for this overdue invoice. Used to track collections activity and determine next dunning action timing.',
    `dunning_level` STRING COMMENT 'Current dunning (collections reminder) level for overdue invoices. Typically ranges from 0 (no dunning) to 3+ (final notice before legal action). Increments with each escalation cycle.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year to which this invoice is assigned. Typically 1-12 for monthly periods or 1-13 for special closing periods. Critical for monthly financial close and period-based revenue recognition.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this invoice is assigned based on posting date. Used for period-based financial reporting, EOM close processes, and year-over-year revenue analysis.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Shipping, freight, and logistics charges billed to the customer. May be based on FOB (Free on Board) terms or LDP (Landed Duty Paid) pricing depending on Incoterms.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before any deductions, including all line items at list price. Represents the initial billing value before tax, discounts, or rebates.',
    `incoterms` STRING COMMENT 'Three-letter Incoterms 2020 code defining the division of costs and risks between buyer and seller (e.g., FOB, CIF, DDP, EXW). Critical for international wholesale transactions and landed cost calculation.. Valid values are `^[A-Z]{3}$`',
    `invoice_notes` STRING COMMENT 'Free-text field for additional invoice-level comments, special instructions, or customer-specific billing notes. May include payment instructions, dispute details, or special handling requirements.',
    `invoice_number` STRING COMMENT 'Externally-visible unique invoice document number assigned by SAP S/4HANA FI-AR. Used for customer communication, payment reconciliation, and audit trails.. Valid values are `^[A-Z0-9]{8,20}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice. Tracks progression from draft through posting, payment collection, and final clearing or write-off. Critical for DSO (Days Sales Outstanding) tracking and AR aging analysis. [ENUM-REF-CANDIDATE: draft|posted|partially_paid|fully_paid|overdue|written_off|cancelled — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice document type. Standard invoices represent normal sales billing, credit memos represent returns or adjustments, debit memos represent additional charges, proforma invoices are preliminary, and intercompany invoices are for internal transfers.. Valid values are `standard|credit_memo|debit_memo|proforma|intercompany`',
    `modified_by_user` STRING COMMENT 'SAP user ID of the person or system process that last modified the invoice record. Supports audit trail requirements and change tracking for financial data integrity.. Valid values are `^[A-Z0-9]{6,12}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the invoice record was last updated in SAP S/4HANA FI-AR. Tracks changes for audit compliance and data quality monitoring.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final invoice total after all discounts, rebates, taxes, and freight charges. This is the amount the customer is obligated to pay and the basis for revenue recognition per IFRS 15.',
    `outstanding_amount` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the invoice. Equals net_amount minus any payments received. Used for AR aging reports, DSO calculation, and cash collection forecasting.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism the customer will use to settle the invoice. Letter of Credit (LC) is common for international wholesale orders. Wire transfer and ACH are standard for B2B. Credit card is typical for DTC.. Valid values are `wire_transfer|ach|credit_card|check|letter_of_credit|cash`',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code from SAP master data defining the number of days until payment is due and any early payment discount conditions (e.g., Net 30, 2/10 Net 30).. Valid values are `^[A-Z0-9]{2,10}$`',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the general ledger in SAP S/4HANA FI. May differ from billing date due to period-end processing or backdated entries. Critical for financial period assignment and EOM (End of Month) close.',
    `purchase_order_number` STRING COMMENT 'The customers purchase order number provided at time of order. Required for wholesale and B2B transactions for customer reconciliation and EDI (Electronic Data Interchange) matching.. Valid values are `^[A-Z0-9]{8,30}$`',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Customer rebates and retrospective discounts accrued or applied to this invoice. Common in wholesale channel for volume-based incentives. Tracked separately from standard discounts for rebate accrual accounting.',
    `revenue_recognition_date` DATE COMMENT 'The date revenue from this invoice is recognized in the general ledger per IFRS 15 criteria. May differ from billing date based on performance obligation fulfillment (e.g., shipment date, delivery date, or service completion date).',
    `revenue_recognition_method` STRING COMMENT 'The accounting method used to recognize revenue from this invoice per IFRS 15. Point-in-time is standard for product sales at shipment or delivery. Over-time applies to service contracts. Deferred applies to advance payments. Milestone applies to custom manufacturing or ODM (Original Design Manufacturer) contracts.. Valid values are `point_in_time|over_time|deferred|milestone`',
    `sales_channel` STRING COMMENT 'The channel through which the sale was made. Wholesale represents B2B sales to retailers, DTC (Direct-to-Consumer) online represents e-commerce sales, DTC store represents company-owned retail, retail represents third-party retail, and marketplace represents platform sales. Critical for channel profitability analysis and GMROI (Gross Margin Return on Investment) calculation.. Valid values are `wholesale|dtc_online|dtc_store|retail|marketplace`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax, VAT (Value Added Tax), or GST (Goods and Services Tax) charged on the invoice. Calculated based on customer location, product tax classification, and applicable tax jurisdiction rules.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the tax authority and jurisdiction for this invoice (e.g., state, province, country). Used for tax calculation, remittance, and compliance reporting per local regulations.. Valid values are `^[A-Z0-9]{2,10}$`',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Accounts receivable invoice record in SAP S/4HANA FI-AR capturing customer billing documents for wholesale, DTC, and retail channel sales. Stores customer account, billing date, due date, payment terms, gross amount, tax amount, discount and rebate deductions, dunning level, clearing status, and revenue recognition method per IFRS 15. Drives revenue recognition, DSO tracking, and channel profitability analysis.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` (
    `finance_payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction record. Primary key.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Payments are made from/to bank accounts. Normalizing STRING bank_account_number to FK bank_account_id → bank_account.bank_account_id. Remove redundant bank_account_number and house_bank_id STRING colu',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Payments are posted to a legal entity (company code). Normalizing STRING company_code to FK company_code_id → company_code.company_code_id. Remove redundant company_code STRING column.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payments can be allocated to cost centers for cost tracking. Normalizing STRING cost_center to FK cost_center_id → cost_center.cost_center_id. Remove redundant cost_center STRING column.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Payments to employees (expense reimbursements, advances, commissions) must link to employee for payment tracking and reconciliation. Apparel sales teams receive commission payments requiring employee→',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Payments post to GL accounts for financial reporting. Normalizing STRING gl_account_code to FK gl_account_id → gl_account.gl_account_id. Remove redundant gl_account_code STRING column.',
    `letter_of_credit_id` BIGINT COMMENT 'Foreign key linking to finance.letter_of_credit. Business justification: Payments can be linked to letters of credit for trade finance. Normalizing STRING lc_number to FK letter_of_credit_id → letter_of_credit.letter_of_credit_id. Remove redundant lc_number and lc_issuing_',
    `amount` DECIMAL(18,2) COMMENT 'The gross payment amount in the transaction currency before any adjustments, fees, or exchange rate conversions.',
    `bank_charges` DECIMAL(18,2) COMMENT 'Fees charged by the bank for processing the payment transaction, including wire transfer fees, LC handling fees, or foreign exchange fees.',
    `bank_statement_date` DATE COMMENT 'The date on which this payment appeared on the bank statement, used for bank reconciliation and cash positioning.',
    `beneficiary_bank_name` STRING COMMENT 'The name of the beneficiarys bank institution receiving or sending the payment.',
    `beneficiary_bank_swift_code` STRING COMMENT 'The SWIFT/BIC code of the beneficiarys bank, used for international wire transfers and cross-border payments.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `beneficiary_name` STRING COMMENT 'The name of the payment recipient (vendor, supplier, or customer). For outgoing payments, this is the payee; for incoming receipts, this is the payer.',
    `block_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the payment is blocked for processing due to approval requirements, compliance holds, or dispute resolution. True if blocked, False if released.',
    `block_reason` STRING COMMENT 'Free-text explanation for why the payment is blocked, such as pending approval, invoice dispute, compliance review, or missing documentation.',
    `business_area` STRING COMMENT 'The business area or division within the company responsible for the payment, enabling profitability analysis by channel, product line, or region.. Valid values are `^[A-Z0-9]{4}$`',
    `clearing_document_number` STRING COMMENT 'Reference to the SAP FI clearing document that links this payment to the original invoice or receivable, enabling Accounts Payable (AP) or Accounts Receivable (AR) clearing.. Valid values are `^[A-Z0-9]{10,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment record was first created in the system. Used for audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment transaction (e.g., USD, EUR, GBP, CNY). Represents the currency in which the payment was executed.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early payment discount amount taken by the payer or granted to the payee, reducing the net payment amount. Common in vendor payment terms (e.g., 2/10 net 30).',
    `document_number` STRING COMMENT 'The externally-known unique document number assigned to this payment in SAP S/4HANA FI. Used for audit trails and reconciliation.. Valid values are `^[A-Z0-9]{10,20}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied at payment date to convert payment currency to local currency. Critical for multi-currency payment processing and landed cost (LDP) accounting.',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this payment is an intercompany transaction between legal entities within the same corporate group. True for intercompany, False for external.',
    `local_amount` DECIMAL(18,2) COMMENT 'The payment amount converted to the companys local reporting currency for consolidation and statutory reporting per IFRS/GAAP requirements.',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the companys local reporting currency used in financial consolidation and statutory reporting.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment record was last modified or updated. Critical for change tracking and audit compliance.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The final net amount transferred after applying discounts and deducting bank charges. Represents the actual cash movement.',
    `payment_date` DATE COMMENT 'The business date when the payment transaction was executed or processed. Distinct from value date and posting date.',
    `payment_method` STRING COMMENT 'The instrument or mechanism used to execute the payment: wire transfer, ACH (Automated Clearing House), SEPA (Single Euro Payments Area), check, Letter of Credit (LC), electronic funds transfer, or cash. [ENUM-REF-CANDIDATE: wire_transfer|ach|sepa|check|lc|electronic_funds_transfer|cash — 7 candidates stripped; promote to reference product]',
    `payment_run_number` STRING COMMENT 'Identifier for the automated payment run batch in SAP S/4HANA FI that grouped multiple payments for processing. Used for batch reconciliation and audit trails.. Valid values are `^[A-Z0-9]{8,15}$`',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment: pending approval, cleared through bank, reconciled with bank statement, failed processing, cancelled, or in transit.. Valid values are `pending|cleared|reconciled|failed|cancelled|in_transit`',
    `payment_type` STRING COMMENT 'Classification of the payment transaction: outgoing vendor payments, incoming customer receipts, intercompany netting settlements, Letter of Credit (LC) settlements, bank transfers, or refunds.. Valid values are `outgoing_vendor|incoming_customer|intercompany_netting|lc_settlement|bank_transfer|refund`',
    `posting_date` DATE COMMENT 'The accounting period date when the payment was posted to the General Ledger (GL) in SAP S/4HANA FI. Used for period-end close (EOM) and financial consolidation.',
    `priority` STRING COMMENT 'The priority level assigned to the payment for processing sequence in payment runs: urgent, high, normal, or low.. Valid values are `urgent|high|normal|low`',
    `reconciliation_date` DATE COMMENT 'The date when this payment was successfully reconciled with the bank statement, completing the cash management cycle.',
    `reconciliation_status` STRING COMMENT 'Status of bank statement reconciliation: matched to bank statement, unmatched, partially matched, or under review by treasury team.. Valid values are `matched|unmatched|partially_matched|under_review`',
    `reference_number` STRING COMMENT 'External reference number or remittance advice identifier provided by the payer or payee for payment tracking and reconciliation purposes.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount (VAT, GST, withholding tax) associated with the payment transaction, if applicable. Used for tax reporting and compliance.',
    `tax_code` STRING COMMENT 'The tax code applied to the payment transaction in SAP S/4HANA FI, determining tax calculation rules and reporting requirements.. Valid values are `^[A-Z0-9]{2,4}$`',
    `terms` STRING COMMENT 'The agreed payment terms between buyer and seller (e.g., Net 30, 2/10 Net 30, FOB, DDP). Influences discount eligibility and cash flow timing.',
    `value_date` DATE COMMENT 'The effective date when funds are available or debited for interest calculation and cash positioning purposes. Critical for treasury management and cash flow analysis.',
    CONSTRAINT pk_finance_payment PRIMARY KEY(`finance_payment_id`)
) COMMENT 'Records outgoing vendor payments and incoming customer receipts processed through SAP S/4HANA FI, including wire transfers, Letters of Credit (LC), ACH/SEPA, checks, and intercompany netting settlements. Captures payment method, house bank and bank account, value date, clearing document reference, exchange rate at payment date, payment run ID, reconciliation status, and bank statement matching result. Supports AP/AR clearing, cash positioning, LC settlement for apparel import transactions, and bank reconciliation.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budgets are allocated to cost centers for cost planning. Normalizing STRING cost_center_code to FK cost_center_id → cost_center.cost_center_id. Remove redundant cost_center_code STRING column.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Budgets are planned by GL account for financial planning. Normalizing STRING gl_account_code to FK gl_account_id → gl_account.gl_account_id. Remove redundant gl_account_code STRING column.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_initiative. Business justification: Links initiative funding to financial planning. Enables ESG capex tracking, sustainability ROI analysis, and budget variance reporting for decarbonization projects—standard for integrated financial/su',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Annual compliance budgets are planned by obligation type (CPSIA testing, REACH compliance, factory audits) in apparel. Links budget allocation to specific regulatory requirements for compliance spend ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Budget ownership must link to employee for accountability, approval workflows, and budget variance responsibility. Apparel companies require budget_owner FK for budget approval routing and performance',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budgets are allocated to profit centers for profitability planning. Normalizing STRING profit_center_code to FK profit_center_id → profit_center.profit_center_id. Remove redundant profit_center_code S',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual amount spent or incurred against this budget to date. Updated from financial actuals in the general ledger.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The amount of budget that has been allocated or distributed to specific cost centers, projects, or line items.',
    `approval_date` DATE COMMENT 'The date on which this budget was formally approved by the authorized approver or budget committee.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved this budget (e.g., CFO, Finance Director, Budget Committee Chair).',
    `budget_name` STRING COMMENT 'Descriptive name of the budget plan (e.g., FY2024 OPEX Budget, Spring Collection COGS Budget).',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget plan in the approval and execution workflow. [ENUM-REF-CANDIDATE: DRAFT|SUBMITTED|APPROVED|REJECTED|ACTIVE|CLOSED|REVISED — 7 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of budget type: OPEX (Operating Expenses), CAPEX (Capital Expenditures), COGS (Cost of Goods Sold), OTB (Open-to-Buy), REVENUE, or EBITDA (Earnings Before Interest Taxes Depreciation and Amortization).. Valid values are `OPEX|CAPEX|COGS|OTB|REVENUE|EBITDA`',
    `channel` STRING COMMENT 'The sales or distribution channel for which this budget applies. DTC stands for Direct-to-Consumer.. Valid values are `RETAIL|ECOMMERCE|WHOLESALE|DTC|OUTLET|FRANCHISE`',
    `committed_amount` DECIMAL(18,2) COMMENT 'The amount of budget that has been committed through purchase orders or contractual obligations but not yet spent.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'The effective end date of the budget period (e.g., 2024-12-31 for FY2024 annual budget).',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this budget applies (e.g., 2024).',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this budget is currently active and in use for financial tracking and reporting. True for active, False for inactive or superseded budgets.',
    `is_baseline` BOOLEAN COMMENT 'Flag indicating whether this is the baseline (original approved) budget version. True for baseline, False for revised versions.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text notes or comments about the budget, including assumptions, constraints, or special considerations.',
    `period_type` STRING COMMENT 'The granularity of budget period allocation: MONTHLY (12 periods), QUARTERLY (4 periods), or ANNUAL (1 period).. Valid values are `MONTHLY|QUARTERLY|ANNUAL`',
    `region_code` STRING COMMENT 'Geographic region code for budget allocation (e.g., USA, EUR, APAC). Uses ISO 3166-1 alpha-3 country codes or regional abbreviations.. Valid values are `^[A-Z]{2,3}$`',
    `revision_number` STRING COMMENT 'Sequential revision number tracking changes to the budget. Starts at 0 for original budget, increments with each revision.',
    `revision_reason` STRING COMMENT 'Business justification or reason for budget revision (e.g., Market Conditions Change, Strategic Initiative, Cost Overrun, Revenue Shortfall).',
    `source_system` STRING COMMENT 'The system of record from which this budget data originated (e.g., SAP S/4HANA CO for controlling budgets, Anaplan for merchandise financial planning).. Valid values are `SAP_S4HANA_CO|ANAPLAN|ORACLE_EBS|MANUAL`',
    `source_system_code` STRING COMMENT 'The unique identifier of this budget record in the source system (e.g., SAP budget document number, Anaplan budget ID).',
    `start_date` DATE COMMENT 'The effective start date of the budget period (e.g., 2024-01-01 for FY2024 annual budget).',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'The total planned budget amount for the entire fiscal period, in the specified currency. Sum of all period-level allocations.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The variance between budgeted and actual amounts (calculated as total_budget_amount minus actual_amount). Positive indicates under-budget, negative indicates over-budget.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the total budget amount. Calculated as (variance_amount / total_budget_amount) * 100.',
    `version` STRING COMMENT 'Version identifier for the budget (e.g., V1, V2, REVISED, FINAL). Supports multiple iterations of budget planning cycles.. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Financial budget plan in SAP S/4HANA CO and Anaplan capturing budget header (version, fiscal year, type, owner, approval status) and granular period-level line allocations (monthly/quarterly amounts by GL account, cost center, profit center, channel). Supports budget types including OPEX, CAPEX, COGS, and OTB (Open-to-Buy). Each line stores planned, revised, committed, and actual amounts with variance calculations at the period level. Enables merchandise financial planning, OTB management, budget vs. actual tracking, and EBITDA target-setting for apparel fashion operations.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique identifier for the budget line item. Primary key.',
    `budget_id` BIGINT COMMENT 'Reference to the parent budget plan that contains this line item.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget lines are allocated to cost centers at granular level. Normalizing STRING cost_center_code to FK cost_center_id → cost_center.cost_center_id. Remove redundant cost_center_code STRING column.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Budget lines are planned by GL account at granular level. Normalizing STRING gl_account_code to FK gl_account_id → gl_account.gl_account_id. Remove redundant gl_account_code STRING column.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Budget lines track monthly/quarterly compliance spending by obligation (certifications, audits, testing programs). Enables period-level compliance budget tracking, variance reporting, and spend author',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budget lines are allocated to profit centers at granular level. Normalizing STRING profit_center_code to FK profit_center_id → profit_center.profit_center_id. Remove redundant profit_center_code STRIN',
    `actual_amount` DECIMAL(18,2) COMMENT 'Actual amount spent to date against this budget line, based on posted financial transactions.',
    `approval_status` STRING COMMENT 'Approval workflow status for this budget line (pending management review, approved, rejected).. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the user who approved this budget line.',
    `approved_date` DATE COMMENT 'Date when this budget line was approved.',
    `available_amount` DECIMAL(18,2) COMMENT 'Remaining budget available for spending (revised_amount - committed_amount - actual_amount). Used for Open-to-Buy (OTB) management.',
    `budget_category` STRING COMMENT 'High-level budget category classification (Cost of Goods Sold, operating expense, capital expenditure, marketing, payroll, overhead).. Valid values are `cogs|operating_expense|capital_expenditure|marketing|payroll|overhead`',
    `budget_line_status` STRING COMMENT 'Current lifecycle status of the budget line (draft, approved, active, frozen for no further changes, closed at period end).. Valid values are `draft|approved|active|frozen|closed`',
    `budget_type` STRING COMMENT 'Type of budget allocation (operational, capital, project-based, discretionary).. Valid values are `operational|capital|project|discretionary`',
    `channel_code` STRING COMMENT 'Sales channel to which this budget line applies (retail stores, wholesale, e-commerce, direct-to-consumer, outlet).. Valid values are `retail|wholesale|ecommerce|dtc|outlet`',
    `committed_amount` DECIMAL(18,2) COMMENT 'Amount committed through purchase orders or contractual obligations but not yet spent.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget line (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fiscal_period` STRING COMMENT 'Fiscal period within the year (monthly M01-M12, quarterly Q1-Q4, or half-yearly H1-H2).. Valid values are `^(Q[1-4]|M(0[1-9]|1[0-2])|H[1-2])$`',
    `fiscal_year` STRING COMMENT 'Fiscal year for which this budget line is planned (e.g., 2024).',
    `is_locked` BOOLEAN COMMENT 'Indicates whether this budget line is locked from further edits or reallocations (True/False).',
    `is_otb_controlled` BOOLEAN COMMENT 'Indicates whether this budget line is subject to Open-to-Buy controls for merchandise purchasing (True/False).',
    `line_number` STRING COMMENT 'Sequential line number within the budget plan for ordering and reference.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget line record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, justification, or instructions for this budget line.',
    `period_end_date` DATE COMMENT 'End date of the fiscal period covered by this budget line.',
    `period_start_date` DATE COMMENT 'Start date of the fiscal period covered by this budget line.',
    `planned_amount` DECIMAL(18,2) COMMENT 'Original planned budget amount allocated to this line for the period.',
    `revised_amount` DECIMAL(18,2) COMMENT 'Revised budget amount after adjustments, reallocations, or amendments during the fiscal period.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Variance between revised budget and actual spend (revised_amount - actual_amount). Positive indicates under-spend, negative indicates over-spend.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Variance as a percentage of the revised budget ((variance_amount / revised_amount) * 100).',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Granular budget line item within a budget plan, capturing period-level (monthly/quarterly) allocations by GL account, cost center, profit center, and channel. Stores planned amount, revised amount, committed amount, actual spend to date, variance, and period. Enables detailed budget vs. actual tracking, OTB management, and financial planning drill-down for apparel merchandise and operations.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` (
    `cogs_entry_id` BIGINT COMMENT 'Unique identifier for the COGS accounting entry. Primary key for the COGS entry record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: COGS entries are allocated to cost centers for cost tracking. Normalizing STRING cost_center_code to FK cost_center_id → cost_center.cost_center_id. Remove redundant cost_center_code STRING column.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: COGS entries post to GL accounts for financial reporting. Normalizing STRING gl_account_code to FK gl_account_id → gl_account.gl_account_id. Remove redundant gl_account_code STRING column.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: COGS recognition requires traceability to production lot for FIFO/LIFO costing methods and margin analysis by batch quality/origin. Essential for apparel cost accounting and inventory valuation compli',
    `original_entry_cogs_entry_id` BIGINT COMMENT 'Reference to the original COGS entry ID if this entry is a reversal or adjustment, supporting audit trail and reconciliation.',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: Safety testing costs (lead, flammability, chemical restrictions) are allocated to COGS for specific SKUs in apparel. Enables accurate product costing including mandatory compliance testing expenses fo',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: COGS entries are allocated to profit centers for profitability analysis. Normalizing STRING profit_center_code to FK profit_center_id → profit_center.profit_center_id. Remove redundant profit_center_c',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store where the sale occurred, if applicable to retail channel transactions.',
    `sales_order_id` BIGINT COMMENT 'Reference to the sales order that triggered this COGS recognition event.',
    `sales_order_line_id` BIGINT COMMENT 'Reference to the specific sales order line item for which COGS is being recognized.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or manufacturer who produced this product, supporting supplier profitability analysis.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center from which the product was fulfilled.',
    `actual_cost` DECIMAL(18,2) COMMENT 'The actual cost per unit incurred for this SKU, including all manufacturing and procurement costs.',
    `collection_code` STRING COMMENT 'The collection or line code for the product, supporting collection-level margin and IMU/MMU tracking.',
    `colorway_code` STRING COMMENT 'The color variant code for the product style.',
    `cost_variance` DECIMAL(18,2) COMMENT 'The difference between standard cost and actual cost per unit, used for cost control and variance analysis.',
    `costing_method` STRING COMMENT 'The inventory costing method applied to calculate the COGS for this entry (standard, average, FIFO, LIFO, or specific identification).. Valid values are `standard|average|fifo|lifo|specific_identification`',
    `created_by_user` STRING COMMENT 'The user ID or system process that created this COGS entry record.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this COGS entry record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts in this COGS entry.. Valid values are `^[A-Z]{3}$`',
    `document_number` STRING COMMENT 'The accounting document number in the financial system for this COGS posting, supporting audit and reconciliation.',
    `duty_cost` DECIMAL(18,2) COMMENT 'The customs duty and tariff cost component allocated to this unit for international shipments.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for this COGS entry, supporting EOM close and period reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this COGS entry is recognized for financial reporting purposes.',
    `fob_cost` DECIMAL(18,2) COMMENT 'The FOB cost component representing the cost of goods at the point of shipment from the supplier or manufacturer.',
    `freight_cost` DECIMAL(18,2) COMMENT 'The freight and transportation cost component allocated to this unit for shipping from origin to destination.',
    `last_modified_by_user` STRING COMMENT 'The user ID or system process that last modified this COGS entry record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this COGS entry record was last modified or updated.',
    `ldp_cost` DECIMAL(18,2) COMMENT 'The total landed cost including FOB, freight, duty, and all other costs to deliver the product to the final destination.',
    `posting_date` DATE COMMENT 'The date on which this COGS entry was posted to the general ledger, which may differ from recognition date due to period-end adjustments.',
    `product_category_code` STRING COMMENT 'The merchandise category code for the product, enabling category-level profitability analysis.',
    `purchase_order_number` STRING COMMENT 'The purchase order number under which this product was procured, linking COGS to procurement transactions.',
    `quantity_sold` DECIMAL(18,2) COMMENT 'The quantity of units sold for this SKU in this transaction, triggering the COGS recognition.',
    `recognition_date` DATE COMMENT 'The accounting date on which the COGS was recognized, typically aligned with revenue recognition per IFRS 15 or GAAP ASC 606.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this COGS entry is a reversal or adjustment of a previous entry.',
    `sales_channel` STRING COMMENT 'The sales channel through which the product was sold, enabling channel-specific GMROI and margin analysis.. Valid values are `retail|wholesale|ecommerce|dtc|marketplace`',
    `sales_region_code` STRING COMMENT 'The geographic region code where the sale occurred, enabling regional profitability analysis.',
    `season_code` STRING COMMENT 'The merchandising season code for the product sold, enabling seasonal profitability and GMROI analysis.',
    `size_code` STRING COMMENT 'The size code for the product (e.g., XS, S, M, L, XL, or numeric sizing).',
    `sku` STRING COMMENT 'The unique SKU identifier for the apparel product sold, representing the specific style, colorway, and size combination.',
    `standard_cost` DECIMAL(18,2) COMMENT 'The predetermined standard cost per unit for this SKU as maintained in the cost accounting system, used for variance analysis.',
    `style_code` STRING COMMENT 'The style identifier for the apparel product, representing the base design before colorway and size variations.',
    `total_cogs_amount` DECIMAL(18,2) COMMENT 'The total COGS amount for this entry, calculated as actual cost multiplied by quantity sold.',
    `valuation_class` STRING COMMENT 'The SAP valuation class used for inventory valuation and COGS calculation, supporting material ledger accounting.',
    CONSTRAINT pk_cogs_entry PRIMARY KEY(`cogs_entry_id`)
) COMMENT 'Cost of Goods Sold accounting entry capturing the COGS recognition event for each apparel product sold, derived from SAP S/4HANA MM/PP and SD integration. Stores SKU, style, colorway, size, sales order reference, quantity sold, standard cost, actual cost, cost variance, landed cost components (FOB, freight, duty, LDP), and COGS GL account. Foundational for gross margin analysis, GMROI calculation, and IMU/MMU tracking by product and channel.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` (
    `landed_cost_id` BIGINT COMMENT 'Primary key for landed_cost',
    `asn_id` BIGINT COMMENT 'Foreign key linking to inventory.asn. Business justification: Landed cost calculation (duty, freight, insurance) is triggered by ASN receipt and must trace to specific advance shipment notice for accurate cost allocation to received goods. Standard apparel impor',
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: Links freight/duty costs to transportation emissions. Enables Scope 3 Category 4 (upstream transportation) allocation to specific shipments for CDP disclosure and carbon-adjusted landed cost analysis ',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Landed cost records represent imported goods cost breakdowns and must be tied to a legal entity (company code) for proper financial accounting, statutory reporting, and consolidation. This FK is essen',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document that triggered the landed cost calculation. Links to the inbound inventory receipt event in SAP S/4HANA MM.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Landed costs must be allocated to production lots for accurate unit cost calculation and COGS recognition. Apparel costing requires lot-level traceability for dye lots, factory batches, and origin-spe',
    `order_purchase_order_id` BIGINT COMMENT 'Reference to the purchase order for which this landed cost is calculated. Links to the originating procurement transaction in SAP S/4HANA MM.',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: Testing costs are a component of total landed cost for apparel imports. Links safety test expenses to shipment-level landed cost calculations for accurate duty-paid cost determination and inventory va',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment or consignment that transported the goods. Links to logistics and transportation records.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU for which the landed cost is being calculated. Identifies the product at the most granular inventory level.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor from whom the goods were sourced. Links to the supplier master record.',
    `air_freight_amount` DECIMAL(18,2) COMMENT 'The cost of air freight transportation if goods were shipped by air. Component of landed cost for expedited shipments.',
    `calculation_date` DATE COMMENT 'The date on which the landed cost calculation was performed. Used for financial period assignment and audit purposes.',
    `cost_allocation_method` STRING COMMENT 'The method used to allocate shared costs (freight, insurance) across multiple SKUs in a shipment. Common methods: weight-based, volume-based, value-based, unit count.. Valid values are `weight|volume|value|unit_count`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this landed cost record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this landed cost record. Typically the functional currency of the importing entity.. Valid values are `^[A-Z]{3}$`',
    `customs_brokerage_amount` DECIMAL(18,2) COMMENT 'The fee paid to customs brokers for handling import documentation and customs clearance procedures.',
    `customs_duty_amount` DECIMAL(18,2) COMMENT 'The customs duty paid to import the goods into the destination country. Calculated based on HS code tariff rate and customs value.',
    `customs_value_amount` DECIMAL(18,2) COMMENT 'The declared value of the goods for customs purposes. Basis for calculating customs duty and import taxes.',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the destination country where the goods are imported. Determines applicable tariff rates and customs regulations.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert supplier invoice amounts to the functional currency. Used when FOB price is in a different currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the landed cost was recognized. Used for monthly financial close and reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the landed cost was recognized for financial reporting purposes.',
    `fob_price_amount` DECIMAL(18,2) COMMENT 'The FOB price of the goods as agreed with the supplier. Represents the cost of goods before international freight and insurance.',
    `gl_posting_date` DATE COMMENT 'The date on which the landed cost was posted to the general ledger. Determines the financial period for COGS recognition and inventory valuation.',
    `goods_receipt_date` DATE COMMENT 'The date on which the goods were physically received into inventory. Determines the accounting period for cost recognition.',
    `gsp_preference_applied` BOOLEAN COMMENT 'Indicates whether a GSP tariff preference was applied to reduce or eliminate customs duty. True if GSP benefits were utilized.',
    `gsp_preference_rate_percent` DECIMAL(18,2) COMMENT 'The reduced tariff rate percentage applied under GSP preference. Null if no GSP preference was applied.',
    `hs_code` STRING COMMENT 'The Harmonized System tariff classification code for the imported goods. Determines the applicable customs duty rate and trade regulations.. Valid values are `^[0-9]{6,10}$`',
    `incoterm_code` STRING COMMENT 'The Incoterms 2020 code defining the terms of delivery and cost responsibility between buyer and seller. Common values: FOB, CIF, EXW, FCA, CPT, CIP, DAP, DPU, DDP. [ENUM-REF-CANDIDATE: FOB|CIF|EXW|FCA|CPT|CIP|DAP|DPU|DDP — 9 candidates stripped; promote to reference product]',
    `inland_freight_amount` DECIMAL(18,2) COMMENT 'The cost of domestic transportation from the port of discharge to the final warehouse or distribution center.',
    `insurance_amount` DECIMAL(18,2) COMMENT 'The cost of cargo insurance covering the goods during international transit. Component of landed cost.',
    `landed_cost_number` STRING COMMENT 'Business identifier for the landed cost calculation. Human-readable reference number used in financial reporting and audit trails.. Valid values are `^LC-[0-9]{8,12}$`',
    `landed_cost_status` STRING COMMENT 'The current status of the landed cost record in the financial workflow. Values: draft (initial calculation), calculated (computation complete), approved (reviewed and approved), posted (recorded to general ledger), reversed (corrected or cancelled).. Valid values are `draft|calculated|approved|posted|reversed`',
    `letter_of_credit_number` STRING COMMENT 'The letter of credit number used to secure payment for this shipment. Links to trade finance instruments.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this landed cost record was last modified. Audit trail for record updates and corrections.',
    `ocean_freight_amount` DECIMAL(18,2) COMMENT 'The cost of ocean freight transportation from the port of loading to the port of discharge. Component of landed cost.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country of manufacture or origin for the goods. Used for customs duty calculation and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `other_charges_amount` DECIMAL(18,2) COMMENT 'Miscellaneous charges not categorized elsewhere, such as inspection fees, fumigation costs, or special handling charges.',
    `port_handling_amount` DECIMAL(18,2) COMMENT 'The cost of port handling services including unloading, storage, and terminal fees at the port of discharge.',
    `port_of_discharge` STRING COMMENT 'The seaport or airport where the goods were unloaded upon arrival. Used for customs clearance and port handling cost allocation.',
    `port_of_loading` STRING COMMENT 'The seaport or airport from which the goods were shipped. Used for freight cost allocation and logistics tracking.',
    `quantity_received` DECIMAL(18,2) COMMENT 'The quantity of goods received in this shipment. Used to calculate unit landed cost and allocate costs across units.',
    `tariff_rate_percent` DECIMAL(18,2) COMMENT 'The customs duty rate percentage applied to the goods based on the HS code and origin country. Used to calculate the customs duty amount.',
    `total_landed_cost_amount` DECIMAL(18,2) COMMENT 'The total landed duty paid cost per unit or shipment. Sum of FOB price, freight, insurance, customs duty, and all other charges. Authoritative cost basis for inventory valuation and COGS.',
    `unit_landed_cost_amount` DECIMAL(18,2) COMMENT 'The landed cost per individual unit of the SKU. Calculated by dividing total landed cost by quantity received. Used for per-unit inventory valuation.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity received. Standard units include EA (each), PC (piece), KG (kilogram), LB (pound), M (meter), YD (yard), PAIR, SET, BOX, CASE. [ENUM-REF-CANDIDATE: EA|PC|KG|LB|M|YD|PAIR|SET|BOX|CASE — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_landed_cost PRIMARY KEY(`landed_cost_id`)
) COMMENT 'Captures the full landed duty paid (LDP) cost breakdown for imported apparel goods, including FOB price, ocean/air freight, insurance, customs duty, HS code tariff rate, GSP preference utilization, port handling, and inland freight. Linked to purchase orders and goods receipts in SAP S/4HANA MM. Provides the authoritative LDP cost basis for inventory valuation, COGS recognition, and margin analysis by sourcing origin.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`company_code` (
    `company_code_id` BIGINT COMMENT 'Unique identifier for the company code record. Primary key. Inferred role: MASTER_RESOURCE (legal entity as a managed organizational resource).',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: Links legal entities to ESG disclosures. Enables consolidated ESG reporting aligned with financial reporting boundaries—required for SEC climate disclosure, CSRD, and ensuring ESG scope matches financ',
    `accounting_principle` STRING COMMENT 'Primary accounting standard applied for statutory financial reporting. Options include IFRS (International Financial Reporting Standards), US GAAP (Generally Accepted Accounting Principles), local GAAP, or hybrid approaches for dual reporting.. Valid values are `IFRS|US_GAAP|LOCAL_GAAP|HYBRID`',
    `activation_date` DATE COMMENT 'Date on which the company code was activated in the SAP S/4HANA FI system and began posting financial transactions.',
    `address_line_1` STRING COMMENT 'First line of the registered legal address for the company code. Includes street number and street name.',
    `address_line_2` STRING COMMENT 'Second line of the registered legal address for the company code. Includes building name, suite, or floor information.',
    `business_segment` STRING COMMENT 'Primary business segment classification for this company code within the apparel fashion group. Used for segment reporting, profitability analysis, and strategic planning.. Valid values are `ATHLETIC|LIFESTYLE|LUXURY|ACCESSORIES|FOOTWEAR`',
    `chart_of_accounts` STRING COMMENT 'Four-character code identifying the chart of accounts assigned to this company code. The COA defines the structure of General Ledger (GL) accounts used for recording financial transactions.. Valid values are `^[A-Z0-9]{4}$`',
    `city` STRING COMMENT 'City or municipality of the registered legal address for the company code.',
    `company_code` STRING COMMENT 'Four-character alphanumeric code uniquely identifying the legal entity within the SAP S/4HANA FI system. This is the business identifier used across all financial transactions and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `company_name` STRING COMMENT 'Full legal name of the company as registered with statutory authorities. Used for financial statements, tax filings, and legal documentation.',
    `company_name_short` STRING COMMENT 'Abbreviated or trading name of the company used for internal reporting and operational displays.',
    `company_status` STRING COMMENT 'Current operational status of the company code. Active indicates the entity is operational and posting transactions. Inactive, dormant, liquidation, or merged indicate non-operational states.. Valid values are `ACTIVE|INACTIVE|DORMANT|LIQUIDATION|MERGED`',
    `consolidation_entity_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this company code is included in group-level financial consolidation. True indicates the entity participates in consolidated financial statements.',
    `consolidation_group_code` STRING COMMENT 'Code identifying the consolidation group or reporting entity to which this company code belongs. Used for multi-level consolidation hierarchies and segment reporting.',
    `controlling_area` STRING COMMENT 'Four-character code identifying the Controlling (CO) area to which this company code is assigned. The controlling area is the organizational unit for cost accounting, profitability analysis, and internal management reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_of_sales_accounting_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this company code uses cost-of-sales accounting (income statement by function) or period accounting (income statement by nature). True indicates cost-of-sales method.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country of domicile for the legal entity. Determines tax jurisdiction, statutory reporting requirements, and local GAAP applicability.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this company code record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_control_area` STRING COMMENT 'Four-character code identifying the credit control area responsible for managing customer credit limits and credit exposure for this company code.. Valid values are `^[A-Z0-9]{4}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the local currency of the company code. All financial transactions for this entity are recorded in this currency before consolidation.. Valid values are `^[A-Z]{3}$`',
    `deactivation_date` DATE COMMENT 'Date on which the company code was deactivated or ceased operations. Null if the entity is still active.',
    `email_address` STRING COMMENT 'Primary email address for official correspondence with the company code.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the company code, if applicable. Used for formal legal and regulatory correspondence.',
    `field_status_variant` STRING COMMENT 'Four-character code defining the field status variant that controls which fields are required, optional, or suppressed during financial document posting for this company code.. Valid values are `^[A-Z0-9]{4}$`',
    `fiscal_year_variant` STRING COMMENT 'Two-character code defining the fiscal year structure for this company code, including the number of posting periods, special periods for year-end adjustments, and fiscal year start/end dates.. Valid values are `^[A-Z0-9]{2}$`',
    `geographic_region` STRING COMMENT 'Geographic region classification for this company code. Used for regional performance analysis, geographic segment reporting, and market-based strategic decisions.. Valid values are `NORTH_AMERICA|EUROPE|ASIA_PACIFIC|LATIN_AMERICA|MIDDLE_EAST_AFRICA`',
    `incorporation_date` DATE COMMENT 'Date on which the legal entity was incorporated or registered with the statutory authority. Used for legal compliance and entity lifecycle tracking.',
    `intercompany_clearing_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this company code participates in automated intercompany clearing and reconciliation processes. True indicates intercompany transactions are tracked and cleared.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the primary language used for financial reporting and communication for this company code.. Valid values are `^[a-z]{2}$`',
    `modified_by_user` STRING COMMENT 'User ID or username of the person who last modified this company code record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this company code record was last modified. Used for audit trail and change tracking.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the company code headquarters or registered office.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the registered legal address for the company code.',
    `posting_period_variant` STRING COMMENT 'Four-character code defining the posting period variant that controls which posting periods are open or closed for transaction posting in this company code.. Valid values are `^[A-Z0-9]{4}$`',
    `profit_center_standard_hierarchy` STRING COMMENT 'Code identifying the standard profit center hierarchy used for profitability analysis and internal management reporting for this company code.',
    `state_province` STRING COMMENT 'State, province, or administrative region of the registered legal address for the company code.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the primary tax jurisdiction applicable to this company code. Determines tax calculation rules, tax reporting requirements, and compliance with local tax authorities.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the company code location. Used for timestamp normalization and cross-entity transaction reconciliation.',
    `vat_registration_number` STRING COMMENT 'VAT or sales tax registration number assigned by the local tax authority. Required for VAT reporting and cross-border transactions within VAT jurisdictions.',
    CONSTRAINT pk_company_code PRIMARY KEY(`company_code_id`)
) COMMENT 'Master record for each legal entity (company code) within the apparel fashion group as defined in SAP S/4HANA FI. Captures company code, company name, country, currency, chart of accounts, fiscal year variant, controlling area, tax jurisdiction, and IFRS/local GAAP accounting principle. Serves as the organizational anchor for statutory reporting, financial consolidation, and intercompany accounting.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique identifier for the intercompany transaction record. Primary key for the intercompany transaction entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Intercompany transactions can be allocated to cost centers for cost tracking. Normalizing STRING cost_center_code to FK cost_center_id → cost_center.cost_center_id. Remove redundant cost_center_code S',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Intercompany transactions post to GL accounts for financial reporting. Normalizing STRING gl_account_code to FK gl_account_id → gl_account.gl_account_id. Remove redundant gl_account_code STRING column',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Intercompany transactions track sending legal entity for intercompany reconciliation. Normalizing STRING sending_company_code to FK sending_company_code_id → company_code.company_code_id (first FK to ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Intercompany transactions track sending profit center for segment reporting. Normalizing STRING sending_profit_center_code to FK sending_profit_center_id → profit_center.profit_center_id (first FK to ',
    `brand_code` STRING COMMENT 'The brand code associated with the intercompany transaction, particularly relevant for royalty and license fee transactions. Used for brand-level financial analysis.',
    `channel_type` STRING COMMENT 'The sales or distribution channel associated with the intercompany transaction. Wholesale for B2B distribution; retail for owned stores; ecommerce for digital; franchise for licensed operations; outlet for clearance channels.. Valid values are `wholesale|retail|ecommerce|franchise|outlet`',
    `consolidation_unit_code` STRING COMMENT 'The consolidation unit or reporting entity code used in the financial consolidation system. Identifies the level at which this transaction is eliminated in the consolidation hierarchy.',
    `created_by_user` STRING COMMENT 'The user ID or name of the person who created the intercompany transaction record in the system. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the intercompany transaction record was first created in the system. Used for audit trail and data lineage tracking.',
    `elimination_date` DATE COMMENT 'The date when the intercompany transaction was eliminated during the financial consolidation process. Null if elimination is still pending.',
    `elimination_status` STRING COMMENT 'The current status of the intercompany transaction in the consolidation elimination process. Pending indicates awaiting elimination; eliminated means fully removed from consolidated statements; partially eliminated for complex multi-step transactions; exception for transactions requiring manual review.. Valid values are `pending|eliminated|partially_eliminated|exception`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate used to convert the transaction amount from transaction currency to group currency. Typically the rate effective on the transaction date.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when the intercompany transaction is recorded, typically 1-12 for monthly periods or 1-13 including adjustments.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the intercompany transaction is recorded, used for financial reporting and consolidation purposes.',
    `geographic_region_code` STRING COMMENT 'The geographic region code associated with the intercompany transaction, used for regional segment reporting and transfer pricing documentation by jurisdiction.',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'The monetary value of the intercompany transaction translated into the group reporting currency using the applicable exchange rate. Used for consolidated financial reporting.',
    `group_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code of the corporate group reporting currency. All intercompany transactions are translated to this currency for consolidation purposes.. Valid values are `^[A-Z]{3}$`',
    `last_modified_by_user` STRING COMMENT 'The user ID or name of the person who last modified the intercompany transaction record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the intercompany transaction record was last modified or updated. Used for audit trail and change tracking.',
    `netting_position` STRING COMMENT 'Indicates the settlement position of the intercompany transaction from the group perspective. Payable means the sending entity owes the receiving entity; receivable means the opposite; settled indicates payment completed; offset means netted against other transactions.. Valid values are `payable|receivable|settled|offset`',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context about the intercompany transaction, including special circumstances, adjustments, or audit findings.',
    `posting_date` DATE COMMENT 'The date when the intercompany transaction was posted to the general ledger in the financial system. May differ from transaction date due to period-end processing or adjustments.',
    `product_category_code` STRING COMMENT 'The product category or merchandise hierarchy code associated with the intercompany transaction, particularly relevant for goods transfers. Used for category-level profitability analysis.',
    `receiving_company_code` STRING COMMENT 'The company code of the legal entity that is the receiver or consumer in the intercompany transaction. Represents the entity being charged or receiving goods/services. Typically a 4-character alphanumeric code per SAP standard.. Valid values are `^[A-Z0-9]{4}$`',
    `receiving_profit_center_code` STRING COMMENT 'The profit center code within the receiving company that is charged for the intercompany transaction. Used for internal profitability analysis and segment reporting.',
    `reconciliation_date` DATE COMMENT 'The date when the intercompany transaction was reconciled and confirmed between the sending and receiving entities. Null if reconciliation is pending or disputed.',
    `reconciliation_status` STRING COMMENT 'The current reconciliation status between the sending and receiving entities. Matched indicates both sides agree; unmatched for discrepancies; disputed for contested amounts; resolved for cleared disputes.. Valid values are `matched|unmatched|disputed|resolved`',
    `reference_document_number` STRING COMMENT 'The reference number of the source document that triggered the intercompany transaction, such as a purchase order, invoice, or service agreement number. Used for audit trail and reconciliation.',
    `settlement_date` DATE COMMENT 'The date when the intercompany transaction was settled through cash payment, netting, or other settlement mechanism between the legal entities. Null if settlement is pending.',
    `settlement_method` STRING COMMENT 'The mechanism used to settle the intercompany transaction. Cash payment for direct fund transfer; netting for multilateral settlement; offset against other balances; loan conversion for capitalization; waiver for forgiveness.. Valid values are `cash_payment|netting|offset|loan_conversion|waiver`',
    `tax_jurisdiction_code` STRING COMMENT 'The tax jurisdiction code applicable to the intercompany transaction, used for transfer pricing compliance and tax reporting. Critical for OECD BEPS documentation.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary value of the intercompany transaction in the transaction currency. Represents the gross amount charged or transferred before any adjustments.',
    `transaction_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the intercompany transaction was originally denominated and executed between the two legal entities.. Valid values are `^[A-Z]{3}$`',
    `transaction_date` DATE COMMENT 'The business date when the intercompany transaction occurred or was recognized. This is the accounting effective date used for financial period assignment and consolidation.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number for the intercompany transaction, typically following format IC followed by 10 digits. Used for external reference and audit trails.. Valid values are `^IC[0-9]{10}$`',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction indicating the nature of the business activity between legal entities. Goods transfer represents finished goods or materials moved between entities; service charge for shared services; royalty and license fees for intellectual property usage; management fees for corporate overhead; loan and interest for financing arrangements; dividend for profit distribution; allocation for cost sharing. [ENUM-REF-CANDIDATE: goods_transfer|service_charge|royalty|license_fee|management_fee|loan|interest|dividend|allocation — 9 candidates stripped; promote to reference product]',
    `transfer_price_adjustment_amount` DECIMAL(18,2) COMMENT 'Any adjustment amount applied to the intercompany transaction to align with transfer pricing policy and arms-length principles. Positive values indicate upward adjustments; negative values indicate downward adjustments.',
    `transfer_pricing_method` STRING COMMENT 'The OECD-compliant transfer pricing methodology applied to determine the arms-length price for this intercompany transaction. Comparable uncontrolled price uses market benchmarks; resale price based on resale margin; cost plus adds markup to cost; transactional net margin compares net margins; profit split allocates combined profits.. Valid values are `comparable_uncontrolled_price|resale_price|cost_plus|transactional_net_margin|profit_split`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax applied to the intercompany transaction, particularly relevant for cross-border royalty, interest, and service fee payments. Recorded in transaction currency.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'The withholding tax rate percentage applied to the intercompany transaction based on applicable tax treaties and local regulations. Expressed as a percentage (e.g., 5.00 for 5%).',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Records intercompany financial transactions between legal entities within the apparel fashion group, including intercompany sales of finished goods (e.g., sourcing entity to retail entity), royalty and license fee charges, shared service allocations, management fees, and intercompany loans. Captures sending and receiving company codes, transaction type, amount in transaction and group currency, elimination status, netting position, transfer pricing method, and IFRS 10 consolidation treatment. Essential for financial consolidation, transfer pricing documentation (OECD guidelines), and group statutory reporting.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`tax_item` (
    `tax_item_id` BIGINT COMMENT 'Unique identifier for the tax line item record in the financial system.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Tax items are posted to a legal entity (company code). Normalizing STRING company_code to FK company_code_id → company_code.company_code_id. Remove redundant company_code STRING column.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tax items can be allocated to cost centers for cost tracking. Normalizing STRING cost_center_number to FK cost_center_id → cost_center.cost_center_id. Remove redundant cost_center_number STRING column',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Tax items post to GL accounts for financial reporting. Normalizing STRING gl_account_code to FK gl_account_id → gl_account.gl_account_id. Remove redundant gl_account_code STRING column.',
    `original_tax_item_id` BIGINT COMMENT 'Reference to the original tax item record if this entry is a reversal or adjustment, enabling audit trail and reconciliation.',
    `profile_id` BIGINT COMMENT 'Reference to the customer associated with this tax item, relevant for sales tax and output tax scenarios.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Tax items can be allocated to profit centers for profitability analysis. Normalizing STRING profit_center_code to FK profit_center_id → profit_center.profit_center_id. Remove redundant profit_center_c',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Regulatory filing fees and compliance service taxes generate tax items in apparel operations. Enables tax accounting for compliance expenditures and supports VAT/GST recovery on certification and test',
    `asset_transaction_id` BIGINT COMMENT 'Reference to the parent financial transaction (invoice, payment, purchase order) to which this tax item applies.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier associated with this tax item, relevant for withholding tax and input tax scenarios.',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: Tax items for B2B wholesale transactions need wholesale account reference for VAT exemption certificate validation, resale certificate tracking, cross-border tax compliance (EU intra-community supply,',
    `business_area_code` STRING COMMENT 'Code identifying the business area or segment (e.g., retail, wholesale, e-commerce) to which this tax item is allocated for internal reporting.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the tax obligation arises (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'User ID or username of the person or system process that created this tax item record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax item record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the tax amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customs_entry_number` STRING COMMENT 'The customs declaration or entry number associated with import duty tax items, used for customs clearance tracking.',
    `document_date` DATE COMMENT 'The date on the source document (invoice date, receipt date) that triggered this tax obligation.',
    `document_number` STRING COMMENT 'The externally-known financial document number (invoice number, receipt number, or accounting document number) associated with this tax item.',
    `filing_status` STRING COMMENT 'Current status of this tax item in the filing and payment lifecycle: pending (not yet filed), filed (submitted to authorities), paid (payment completed), reconciled (confirmed by authorities), or disputed (under review or appeal).. Valid values are `pending|filed|paid|reconciled|disputed`',
    `fiscal_period` STRING COMMENT 'The fiscal period number within the fiscal year (1-12 for monthly, 1-4 for quarterly) when this tax item is recorded.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this tax item is recorded for financial and statutory reporting purposes.',
    `hs_code` STRING COMMENT 'The Harmonized System code used for customs classification of goods, relevant for import duty and customs tax calculations.',
    `landed_cost_component` STRING COMMENT 'Identifies which component of landed cost this tax item represents: duty (import tax), freight (shipping tax), insurance (insurance premium tax), or handling (processing fees).. Valid values are `duty|freight|insurance|handling`',
    `last_modified_by_user` STRING COMMENT 'User ID or username of the person or system process that last modified this tax item record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax item record was last updated or modified.',
    `line_item_number` STRING COMMENT 'Sequential line item number within the parent financial document, used for ordering and referencing individual tax entries.',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or special instructions related to this tax item.',
    `payment_date` DATE COMMENT 'The date when the tax amount was paid to the tax authority, if applicable.',
    `posting_date` DATE COMMENT 'The date when this tax item was posted to the general ledger for accounting purposes.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this tax item is a reversal or correction of a previously posted tax entry.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount for this line item, derived from taxable base amount multiplied by tax rate.',
    `tax_code` STRING COMMENT 'The tax code identifier that determines the tax type, rate, and calculation method applied to this transaction line (e.g., V1 for standard VAT, I0 for import duty).',
    `tax_determination_date` DATE COMMENT 'The date used to determine the applicable tax rate and rules, typically the transaction date or delivery date.',
    `tax_direction` STRING COMMENT 'Indicates whether this is input tax (tax paid on purchases, recoverable) or output tax (tax collected on sales, payable to authorities).. Valid values are `input_tax|output_tax`',
    `tax_exemption_certificate_number` STRING COMMENT 'The certificate or authorization number supporting the tax exemption claim, required for audit and compliance verification.',
    `tax_exemption_code` STRING COMMENT 'Code indicating the reason for tax exemption or reduced rate, if applicable (e.g., export exemption, diplomatic exemption, zero-rated goods).',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the tax authority or jurisdiction where this tax is applicable (e.g., country code, state code, or customs territory).',
    `tax_jurisdiction_name` STRING COMMENT 'Full name of the tax jurisdiction or authority (e.g., United States - California, European Union, HM Revenue & Customs UK).',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage rate applied to calculate the tax amount (e.g., 20.00 for 20% VAT, 5.50 for 5.5% import duty).',
    `tax_reporting_period` STRING COMMENT 'The fiscal period or reporting period to which this tax item belongs (e.g., 2024-Q1, 2024-03, 2024-FY).',
    `tax_return_reference` STRING COMMENT 'Reference number or identifier of the tax return filing in which this tax item is included for statutory reporting to tax authorities.',
    `tax_type` STRING COMMENT 'The category of tax applied: VAT (Value Added Tax), sales tax, import duty, excise duty, withholding tax, or GST (Goods and Services Tax).. Valid values are `VAT|sales_tax|import_duty|excise_duty|withholding_tax|GST`',
    `taxable_base_amount` DECIMAL(18,2) COMMENT 'The base amount on which the tax is calculated, before tax is applied. Represents the net value subject to taxation.',
    `withholding_tax_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this tax item represents withholding tax deducted at source from vendor payments.',
    CONSTRAINT pk_tax_item PRIMARY KEY(`tax_item_id`)
) COMMENT 'Captures tax line items associated with financial transactions in SAP S/4HANA FI, including VAT, sales tax, import duty, withholding tax, and GST. Stores tax code, tax type, taxable base amount, tax amount, tax jurisdiction, reporting period, tax return reference, and filing status. Supports indirect tax compliance, statutory tax reporting, and customs duty reconciliation for apparel fashion global operations.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key for the fixed asset master data in SAP S/4HANA FI-AA.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Factory equipment and facilities are verified during safety and social compliance audits in apparel manufacturing. Links asset records to audit findings for capital expenditure planning and compliance',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Fixed assets belong to a legal entity (company code). Normalizing STRING company_code to FK company_code_id → company_code.company_code_id. Remove redundant company_code STRING column.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `employee_id` BIGINT COMMENT 'Employee identifier for the person responsible for the fixed asset. Used for asset custody tracking and accountability.',
    `vendor_id` BIGINT COMMENT 'FK to supplier.vendor',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_location. Business justification: Fixed assets (racking systems, conveyors, RFID gates, sortation equipment) are assigned to specific warehouse locations for depreciation allocation, asset tracking, and maintenance scheduling. Standar',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation posted to date since acquisition. Used to calculate net book value and track asset consumption over time.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original acquisition cost of the fixed asset including purchase price, installation costs, and any directly attributable costs to bring the asset to working condition. Basis for depreciation calculation.',
    `acquisition_date` DATE COMMENT 'Date when the fixed asset was acquired or placed in service. Start date for depreciation calculation and useful life tracking.',
    `asset_class_code` STRING COMMENT 'Classification code defining the type of fixed asset (e.g., store fixtures, manufacturing equipment, warehouse racking, IT infrastructure, leasehold improvements). Determines depreciation method, useful life, and GL account assignment in SAP FI-AA.. Valid values are `^[A-Z0-9]{4,8}$`',
    `asset_description` STRING COMMENT 'Detailed business description of the fixed asset including make, model, specifications, and purpose. Used for asset identification and audit trail.',
    `asset_group_code` STRING COMMENT 'Grouping code for aggregating similar assets for reporting and analysis. Supports portfolio management and CAPEX planning by asset category.. Valid values are `^[A-Z0-9]{4,8}$`',
    `asset_number` STRING COMMENT 'Business identifier for the fixed asset. The externally-known unique asset number used across SAP S/4HANA FI-AA for asset tracking, depreciation runs, and financial reporting.. Valid values are `^[A-Z0-9]{8,12}$`',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset. Determines whether depreciation is active and whether the asset is included in financial reporting.. Valid values are `active|inactive|under_construction|retired|disposed|transferred`',
    `asset_subnumber` STRING COMMENT 'SAP asset subnumber for tracking components or sub-assets within a main asset. Enables detailed tracking of complex assets with multiple depreciable components.. Valid values are `^[0-9]{4}$`',
    `asset_tag_number` STRING COMMENT 'Physical asset tag or barcode number affixed to the asset for identification during physical inventory counts and asset verification audits.. Valid values are `^[A-Z0-9]{6,12}$`',
    `business_area_code` STRING COMMENT 'Business area code for segment reporting and profitability analysis. Enables CAPEX tracking and asset analysis by channel, product line, or region.. Valid values are `^[A-Z0-9]{4}$`',
    `capitalization_date` DATE COMMENT 'Date when the asset was capitalized and added to the fixed asset register. May differ from acquisition date for assets under construction.',
    `created_by_user` STRING COMMENT 'User ID of the person who created the fixed asset record. Supports audit trail and data governance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset record was first created in SAP S/4HANA FI-AA. Provides audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for acquisition cost and net book value. Used for multi-currency consolidation and IFRS reporting.. Valid values are `^[A-Z]{3}$`',
    `depreciation_area` STRING COMMENT 'SAP depreciation area code (e.g., 01 for book depreciation, 15 for tax depreciation). Enables parallel valuation for IFRS, GAAP, and local statutory reporting requirements.. Valid values are `^[A-Z0-9]{2}$`',
    `depreciation_method` STRING COMMENT 'Depreciation calculation method applied to the fixed asset. Determines how acquisition cost is systematically allocated over useful life per IAS 16.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits`',
    `impairment_amount` DECIMAL(18,2) COMMENT 'Total impairment loss recognized on the fixed asset per IAS 36. Reduces net book value when recoverable amount falls below carrying amount.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number covering the fixed asset. Supports risk management and insurance claim processing.',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified the fixed asset record. Supports audit trail and accountability for data changes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset record was last modified. Tracks data currency and supports change audit trail.',
    `last_physical_inventory_date` DATE COMMENT 'Date of the most recent physical inventory verification for the fixed asset. Supports audit compliance and asset existence verification.',
    `lease_contract_number` STRING COMMENT 'Contract number for leased assets. Links fixed asset to lease liability and supports IFRS 16 compliance reporting for right-of-use assets.',
    `lease_indicator` BOOLEAN COMMENT 'Flag indicating whether the asset is held under a lease agreement. Used for IFRS 16 lease accounting and right-of-use asset tracking.',
    `maintenance_schedule_code` STRING COMMENT 'Code identifying the preventive maintenance schedule for the fixed asset. Links to maintenance planning and asset reliability programs.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current net book value of the fixed asset calculated as acquisition cost minus accumulated depreciation. Represents the carrying amount on the balance sheet per IAS 16.',
    `notes` STRING COMMENT 'Free-text notes and comments about the fixed asset. Captures additional context, special handling instructions, or historical information.',
    `purchase_order_number` STRING COMMENT 'Purchase order number used to acquire the fixed asset. Links asset acquisition to procurement process and provides audit trail for CAPEX tracking.. Valid values are `^[A-Z0-9]{10}$`',
    `retirement_date` DATE COMMENT 'Date when the fixed asset was retired, disposed, or scrapped. Marks the end of the asset lifecycle and depreciation posting.',
    `retirement_reason` STRING COMMENT 'Business reason for asset retirement. Supports audit trail and asset lifecycle analysis for CAPEX planning and replacement strategies.. Valid values are `sale|scrap|donation|obsolete|damaged|end_of_life`',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the fixed asset at the end of its useful life. Subtracted from acquisition cost to determine depreciable amount per IAS 16.',
    `serial_number` STRING COMMENT 'Manufacturer serial number or unique identifier for the physical asset. Used for warranty tracking, maintenance scheduling, and physical inventory verification.',
    `tax_depreciation_method` STRING COMMENT 'Depreciation method used for tax reporting purposes. May differ from book depreciation method to comply with local tax regulations.. Valid values are `straight_line|declining_balance|macrs|accelerated`',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Expected useful life of the fixed asset in years. Used for depreciation calculation and asset lifecycle planning. May include fractional years for precision.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty expires. Used for maintenance planning and cost forecasting.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Master record and complete lifecycle history for fixed assets in SAP S/4HANA FI-AA, including retail store fixtures, manufacturing equipment, warehouse racking, IT infrastructure, and leasehold improvements. Captures asset master attributes (asset class, acquisition date, cost, useful life, depreciation method, net book value, location, company code) and all lifecycle transactions (acquisitions, transfers, retirements, write-downs, depreciation postings with transaction type, posting date, amount, depreciation area, and document reference). Provides the complete audit trail for fixed asset movements. Supports CAPEX tracking, depreciation runs, IFRS 16 lease accounting, and IAS 16 compliance reporting for apparel fashion.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` (
    `asset_transaction_id` BIGINT COMMENT 'Unique identifier for the asset transaction record. Primary key for the asset transaction entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Asset transactions are posted to a legal entity (company code). Normalizing STRING company_code to FK company_code_id → company_code.company_code_id. Remove redundant company_code STRING column.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Asset transactions can be allocated to cost centers. Normalizing STRING cost_center_code to FK cost_center_id → cost_center.cost_center_id. Remove redundant cost_center_code STRING column.',
    `employee_id` BIGINT COMMENT 'SAP user ID of the person who created or posted the asset transaction. Supports audit trail and segregation of duties compliance.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset master record involved in this transaction. Links to the asset master data in FI-AA.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Asset transactions post to GL accounts for financial reporting. Normalizing STRING gl_account_code to FK gl_account_id → gl_account.gl_account_id. Remove redundant gl_account_code STRING column.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Asset transactions can be allocated to profit centers. Normalizing STRING profit_center_code to FK profit_center_id → profit_center.profit_center_id. Remove redundant profit_center_code STRING column.',
    `asset_class_code` STRING COMMENT 'Classification code defining the type of fixed asset (e.g., buildings, machinery, vehicles, IT equipment, leasehold improvements). Determines depreciation rules and GL account assignment.',
    `asset_sub_number` STRING COMMENT 'Sub-asset number for assets with multiple components tracked separately (e.g., building structure vs. HVAC system). Supports component depreciation per IFRS IAS 16.',
    `asset_value_date` DATE COMMENT 'Date from which the asset transaction becomes effective for asset valuation and depreciation calculation purposes. May differ from posting date for backdated transactions.',
    `business_area_code` STRING COMMENT 'Business area classification for cross-company code segment reporting and internal financial statements.',
    `customer_code` STRING COMMENT 'Customer code for asset retirements involving sale or transfer to external parties. Links to accounts receivable.',
    `depreciation_area_code` STRING COMMENT 'Code identifying the depreciation area (book depreciation, tax depreciation, IFRS, group consolidation) for which this transaction is recorded. Supports parallel valuation per IFRS and local GAAP.',
    `document_line_item` STRING COMMENT 'Line item number within the financial document that corresponds to this asset transaction entry.',
    `document_number` STRING COMMENT 'Unique financial document number assigned by SAP S/4HANA FI for this asset transaction. Provides audit trail linkage to source accounting documents.',
    `entry_timestamp` TIMESTAMP COMMENT 'System timestamp when the asset transaction record was created in SAP S/4HANA FI-AA. Provides audit trail for transaction entry time.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate used to convert transaction currency to local or group currency at the time of posting.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year when the transaction was posted. Supports monthly financial close and EOM (End of Month) reporting.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the asset transaction was posted, used for period-based financial reporting and statutory compliance.',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'Transaction amount converted to the corporate group reporting currency for consolidated financial statements and EBITDA analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the asset transaction record was last modified. Tracks changes for audit and compliance purposes.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Transaction amount converted to the company code local currency for statutory reporting and consolidation.',
    `posting_date` DATE COMMENT 'Date when the asset transaction was posted to the general ledger. This is the accounting date that determines the fiscal period for financial reporting.',
    `quantity` DECIMAL(18,2) COMMENT 'Physical quantity of assets involved in the transaction (e.g., number of units acquired, transferred, or retired). Used for quantity-based asset tracking.',
    `reason_code` STRING COMMENT 'Code indicating the business reason for the asset transaction (e.g., normal depreciation, impairment, damage, obsolescence, sale, donation, scrap).',
    `reference_document_number` STRING COMMENT 'External reference document number such as purchase order (PO), invoice number, or vendor document that originated the asset transaction.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this transaction is a reversal of a previously posted asset transaction. True if reversal, False otherwise.',
    `reversed_document_number` STRING COMMENT 'Document number of the original transaction that this reversal transaction is canceling. Populated only when reversal_indicator is True.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which the asset transaction originated (e.g., SAP S/4HANA, legacy ERP, interface system). Supports data lineage and multi-system integration.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary value of the asset transaction in the transaction currency. Represents acquisition cost, depreciation expense, write-down amount, or retirement proceeds depending on transaction type.',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `transaction_status` STRING COMMENT 'Current processing status of the asset transaction in the financial system workflow.. Valid values are `posted|pending|reversed|cancelled|parked`',
    `transaction_text` STRING COMMENT 'Free-text description or memo providing additional context about the asset transaction. Used for audit trail and user notes.',
    `transaction_type_code` STRING COMMENT 'Code representing the type of asset transaction: ACQ (Acquisition), TRF (Transfer), RET (Retirement), DEP (Depreciation), WDN (Write-Down), REV (Revaluation), COR (Correction), ADJ (Adjustment). [ENUM-REF-CANDIDATE: ACQ|TRF|RET|DEP|WDN|REV|COR|ADJ — 8 candidates stripped; promote to reference product]',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the asset quantity (e.g., EA for each, M2 for square meters, KG for kilograms).',
    `vendor_code` STRING COMMENT 'Vendor or supplier code for asset acquisitions. Links to accounts payable and procurement records.',
    CONSTRAINT pk_asset_transaction PRIMARY KEY(`asset_transaction_id`)
) COMMENT 'Transactional record capturing all asset lifecycle events in SAP S/4HANA FI-AA, including acquisitions, transfers, retirements, write-downs, and depreciation postings. Stores transaction type, posting date, asset value date, amount, depreciation area, document reference, and GL account. Provides the complete audit trail for fixed asset movements and supports IFRS IAS 16/IFRS 16 compliance reporting.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Unique identifier for the cost allocation record. Primary key for the cost allocation entity.',
    `allocation_cycle_id` BIGINT COMMENT 'Identifier for the allocation cycle or run executed in SAP S/4HANA CO. Groups multiple allocation records processed together in a single execution.. Valid values are `^[A-Z0-9]{6,20}$`',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Cost allocations are posted to a legal entity (company code). Normalizing STRING company_code to FK company_code_id → company_code.company_code_id. Remove redundant company_code STRING column.',
    `original_allocation_cost_allocation_id` BIGINT COMMENT 'Reference to the original cost allocation record if this is a reversal or correction. Links reversal documents to their original transactions.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Cost allocations can be allocated to profit centers for profitability analysis. Normalizing STRING receiver_profit_center_code to FK receiver_profit_center_id → profit_center.profit_center_id. Remove ',
    `sender_cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocations track sender cost center for internal cost distribution. Normalizing STRING sender_cost_center_code to FK sender_cost_center_id → cost_center.cost_center_id (first FK to cost_center w',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Monetary amount allocated from sender to receiver in the transaction currency. Represents the portion of shared cost assigned to the receiver.',
    `allocation_method` STRING COMMENT 'Method used to distribute costs from sender to receiver. Percentage allocates by fixed ratio, quantity by volume or count, equivalence by weighted factors, direct by explicit assignment, activity-based by activity driver consumption, driver-based by cost driver metrics.. Valid values are `percentage|quantity|equivalence|direct|activity_based|driver_based`',
    `allocation_notes` STRING COMMENT 'Free-text notes or comments explaining the allocation rationale, special circumstances, or business justification. Used for audit and review purposes.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of sender cost allocated to this receiver when using percentage-based allocation method. Value between 0 and 100.',
    `allocation_quantity` DECIMAL(18,2) COMMENT 'Quantity or volume used as the basis for allocation when using quantity-based or driver-based methods. Unit depends on allocation driver.',
    `allocation_run_date` DATE COMMENT 'Date when the allocation cycle was executed. May differ from posting date if allocation is run retrospectively or in batch.',
    `allocation_status` STRING COMMENT 'Current status of the cost allocation record. Posted indicates successfully posted to CO/FI, reversed indicates reversal document created, pending indicates awaiting approval, error indicates posting failure, cancelled indicates allocation was voided.. Valid values are `posted|reversed|pending|error|cancelled`',
    `allocation_unit` STRING COMMENT 'Unit of measure for the allocation quantity (e.g., hours, square meters, headcount, transactions). Defines the driver metric.',
    `brand_code` STRING COMMENT 'Brand code to which the allocated cost is assigned. Supports brand-level profitability and GMROI analysis.. Valid values are `^[A-Z0-9]{2,6}$`',
    `channel_code` STRING COMMENT 'Sales or distribution channel code (e.g., retail, wholesale, e-commerce, DTC) to which the allocated cost is assigned. Enables channel-level profitability analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `controlling_area_code` STRING COMMENT 'Controlling area in which the cost allocation is executed. Represents the organizational unit for cost accounting and internal reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_element_code` STRING COMMENT 'Cost element (account assignment) under which the allocated cost is posted. Represents the nature of the cost being distributed (e.g., overhead, logistics, marketing).. Valid values are `^[A-Z0-9]{6,10}$`',
    `cost_element_name` STRING COMMENT 'Descriptive name of the cost element being allocated. Provides business-readable context for the type of cost.',
    `created_by_user` STRING COMMENT 'User ID of the person or system account that created the cost allocation record. Part of audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost allocation record was created in the system. Part of audit trail for compliance and data lineage.',
    `document_number` STRING COMMENT 'Controlling document number generated in SAP S/4HANA CO when the allocation is posted. Provides audit trail and traceability.. Valid values are `^[A-Z0-9]{10,20}$`',
    `equivalence_number` DECIMAL(18,2) COMMENT 'Weighting factor used in equivalence-based allocation. Represents the relative consumption or benefit received by the receiver.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year when the allocation is posted. Typically 1-12 for monthly periods, supports EOM close processes.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the cost allocation is posted. Used for period-based financial reporting and EBITDA analysis.',
    `last_modified_by_user` STRING COMMENT 'User ID of the person or system account that last modified the cost allocation record. Part of audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost allocation record was last modified. Part of audit trail for compliance and change tracking.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Allocated amount converted to the company code local currency for statutory reporting and consolidation.',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the company code local currency.. Valid values are `^[A-Z]{3}$`',
    `posting_date` DATE COMMENT 'Date when the cost allocation was posted to the general ledger and controlling documents. Used for period assignment and audit trail.',
    `product_line_code` STRING COMMENT 'Product line or category code to which the allocated cost is assigned. Enables product-level profitability and COGS analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `reference_document_number` STRING COMMENT 'External or cross-reference document number for traceability. May reference source documents, approval workflows, or related transactions.',
    `region_code` STRING COMMENT 'Geographic region code to which the allocated cost is assigned. Enables regional profitability and landed cost analysis.. Valid values are `^[A-Z0-9]{2,6}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this allocation record is a reversal of a previous allocation. True if this is a reversal document.',
    `segment_code` STRING COMMENT 'Business segment code for segment reporting under IFRS 8. Enables profitability analysis by reportable segment.. Valid values are `^[A-Z0-9]{4,10}$`',
    `source_system` STRING COMMENT 'Identifier of the source system from which the cost allocation record originated. Typically SAP S/4HANA CO module identifier.',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the allocated amount is denominated. Typically the controlling area currency.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Records internal cost allocation and assessment cycles executed in SAP S/4HANA CO, distributing shared costs (overhead, logistics, marketing) across cost centers, profit centers, and product lines. Captures allocation cycle, sender cost center, receiver cost center or profit center, allocation method (percentage, quantity, equivalence), allocated amount, and fiscal period. Enables accurate product-level and channel-level profitability analysis and EBITDA reporting.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`margin_record` (
    `margin_record_id` BIGINT COMMENT 'Unique identifier for the margin record. Primary key for the authoritative profitability analysis record capturing the complete cost-to-margin chain from landed cost through COGS to realized margin at SKU/transaction level.',
    `environmental_impact_id` BIGINT COMMENT 'Foreign key linking to sustainability.environmental_impact. Business justification: Links product profitability to lifecycle environmental footprint. Enables true-cost accounting (financial + environmental), sustainable product portfolio optimization, and eco-margin analysis—emerging',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Actual cost per unit based on real landed cost inputs. Used to calculate cost variance against standard cost.',
    `air_freight_cost` DECIMAL(18,2) COMMENT 'Air shipping cost component of landed cost. Used when expedited shipping is required, impacting margin significantly.',
    `asp_amount` DECIMAL(18,2) COMMENT 'Average selling price per unit at gross revenue level before markdowns. Used to track pricing strategy effectiveness.',
    `aur_amount` DECIMAL(18,2) COMMENT 'Average selling price per unit after markdowns and discounts. Key metric for pricing effectiveness and markdown impact analysis.',
    `brand_code` STRING COMMENT 'Brand identifier for multi-brand portfolio margin analysis. Enables brand-level profitability comparison and GMROI benchmarking.. Valid values are `^[A-Z0-9]{2,10}$`',
    `channel_type` STRING COMMENT 'Sales channel through which the transaction occurred. Critical dimension for channel-level profitability analysis and GMROI calculation.. Valid values are `wholesale|retail|ecommerce|dtc|outlet|marketplace`',
    `cogs_amount` DECIMAL(18,2) COMMENT 'Total cost of goods sold recognized for this transaction. The cost basis subtracted from net revenue to calculate gross margin.',
    `contribution_margin_amount` DECIMAL(18,2) COMMENT 'Gross margin minus variable selling expenses. Used for break-even analysis and channel profitability assessment.',
    `cost_variance_amount` DECIMAL(18,2) COMMENT 'Difference between actual cost and standard cost. Positive variance indicates cost overrun impacting margin negatively.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this margin record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this margin record. Essential for multi-currency consolidation.. Valid values are `^[A-Z]{3}$`',
    `customs_duty_amount` DECIMAL(18,2) COMMENT 'Import duty paid at customs based on HS code classification and tariff rate. Critical component of landed cost impacting gross margin.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Promotional discount or customer-specific discount applied to the transaction. Reduces net revenue and impacts gross margin.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for this margin record. Used for EOM close and period-level profitability analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this margin record is recognized for financial reporting purposes.',
    `fob_cost_amount` DECIMAL(18,2) COMMENT 'Factory gate cost before freight, insurance, and duties. First component of the landed duty paid cost breakdown. Sourced from purchase order or standard costing.',
    `gmroi_ratio` DECIMAL(18,2) COMMENT 'Gross margin dollars returned for every dollar of inventory investment. Critical metric for inventory productivity and buying decisions.',
    `gross_margin_amount` DECIMAL(18,2) COMMENT 'Net revenue minus COGS. The primary profitability metric for product-level margin analysis.',
    `gross_margin_percentage` DECIMAL(18,2) COMMENT 'Gross margin as a percentage of net revenue. Key performance indicator for profitability analysis by SKU, channel, and region.',
    `gross_revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue before discounts and markdowns. The starting point for margin calculation.',
    `gsp_preference_indicator` BOOLEAN COMMENT 'Flag indicating whether GSP tariff preference was applied to reduce or eliminate customs duty. Impacts landed cost and margin calculation.',
    `hs_code` STRING COMMENT 'International product classification code used to determine customs duty rates. Essential for accurate landed cost calculation and tariff management.. Valid values are `^[0-9]{6,10}$`',
    `imu_percentage` DECIMAL(18,2) COMMENT 'Initial markup percentage from cost to original retail price. Measures the starting margin before markdowns.',
    `inland_freight_cost` DECIMAL(18,2) COMMENT 'Domestic transportation cost from port to distribution center or store. Final component of the full LDP cost breakdown.',
    `insurance_cost` DECIMAL(18,2) COMMENT 'Cargo insurance cost component of landed cost. Part of the full LDP cost breakdown.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this margin record was last updated. Tracks changes to cost components or margin calculations due to adjustments or corrections.',
    `markdown_amount` DECIMAL(18,2) COMMENT 'Price reduction from original retail price. Critical for calculating maintained markup and understanding margin erosion.',
    `mmu_percentage` DECIMAL(18,2) COMMENT 'Maintained markup percentage after markdowns and discounts. The realized margin percentage that accounts for all price reductions.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue after markdowns and discounts. The revenue figure used to calculate gross margin and contribution margin.',
    `ocean_freight_cost` DECIMAL(18,2) COMMENT 'Ocean shipping cost component of landed cost. Part of the full LDP cost breakdown for margin calculation.',
    `port_handling_cost` DECIMAL(18,2) COMMENT 'Port and terminal handling charges component of landed cost. Includes unloading, storage, and customs clearance fees.',
    `product_category_code` STRING COMMENT 'Product category classification for category-level margin analysis. Links to merchandise hierarchy for aggregated profitability reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
    `quantity_sold` DECIMAL(18,2) COMMENT 'Number of units sold in this transaction. Used to calculate unit-level margin metrics and contribution to sell-through rate.',
    `region_code` STRING COMMENT 'Geographic region code where the sale occurred. Enables regional profitability analysis and landed cost variance tracking by destination market.. Valid values are `^[A-Z]{2,3}$`',
    `sales_order_number` STRING COMMENT 'Reference to the sales order document that triggered the COGS recognition event. Links to the originating transaction in SAP SD.. Valid values are `^SO[0-9]{10}$`',
    `season_code` STRING COMMENT 'Fashion season identifier (e.g., SS2024, FW2024) for the product. Essential for seasonal margin analysis, markdown tracking, and sell-through rate contribution.. Valid values are `^[A-Z]{2}[0-9]{4}$`',
    `sku_code` STRING COMMENT 'Unique product identifier at the SKU level for which margin is calculated. Links to the specific product variant (style-color-size combination) in the product master.. Valid values are `^[A-Z0-9]{8,20}$`',
    `source_system` STRING COMMENT 'Originating system that provided the margin record data. Typically SAP S/4HANA CO-PA or Oracle Retail for profitability analysis.',
    `standard_cost_amount` DECIMAL(18,2) COMMENT 'Predetermined standard cost per unit used for inventory valuation and initial COGS recognition. Basis for cost variance analysis.',
    `str_contribution` DECIMAL(18,2) COMMENT 'Contribution of this transaction to the overall sell-through rate for the SKU/season. Used to assess inventory turn and markdown risk.',
    `tariff_rate_percentage` DECIMAL(18,2) COMMENT 'Customs duty rate percentage applied to this product based on HS code and country of origin. Used to calculate customs duty amount.',
    `total_ldp_cost` DECIMAL(18,2) COMMENT 'Complete landed cost including FOB, freight, insurance, duties, and inland transportation. The total cost basis for COGS and margin calculation.',
    `transaction_date` DATE COMMENT 'The business date when the revenue and COGS were recognized for this margin record. Represents the point-of-sale or shipment date depending on revenue recognition policy.',
    CONSTRAINT pk_margin_record PRIMARY KEY(`margin_record_id`)
) COMMENT 'Authoritative profitability analysis record in SAP S/4HANA CO-PA capturing the complete cost-to-margin chain from landed cost inputs through COGS recognition to realized margin outputs. At the SKU/transaction level by channel, region, and season, stores: full landed duty paid (LDP) cost breakdown (FOB, ocean/air freight, insurance, customs duty, HS code tariff rate, GSP preference, port handling, inland freight), COGS recognition event (standard cost, actual cost, cost variance, quantity sold, sales order reference), and margin outputs (net revenue, gross margin, contribution margin, AUR, ASP, IMU, MMU, STR contribution, GMROI, markdown amount, discount amount). The single source of truth for product-level profitability from sourcing origin through gross margin analysis in apparel fashion.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`period_close` (
    `period_close_id` BIGINT COMMENT 'Unique identifier for the period close record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Period close ownership must link to employee for close process accountability, task assignment, and audit trail. Apparel companies require close_owner FK for SOX compliance and close process managemen',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Period close is performed per legal entity (company code). Normalizing STRING company_code to FK company_code_id → company_code.company_code_id. Remove redundant company_code STRING column.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Period close is performed per ledger for parallel accounting. Normalizing STRING ledger_group to FK ledger_id → ledger.ledger_id. Remove redundant ledger_group STRING column.',
    `accrual_posting_status` STRING COMMENT 'Status of accrual postings for expenses and revenues that need to be recognized in the current period per IFRS/GAAP accrual accounting principles.. Valid values are `not_started|in_progress|completed|failed`',
    `actual_close_date` DATE COMMENT 'The actual date on which the period close process was completed and signed off. Null if close is not yet complete.',
    `blocked_steps` STRING COMMENT 'The number of checklist steps that are currently blocked and cannot proceed due to issues or dependencies.',
    `blocking_reason` STRING COMMENT 'A description of the reason why the period close is blocked or delayed, such as missing data, unreconciled accounts, or pending approvals. Null if close is not blocked.',
    `checklist_template_code` STRING COMMENT 'The code or identifier of the close checklist template used for this period close, defining the standard steps and milestones (e.g., depreciation run, accruals, intercompany reconciliation, statutory reporting).',
    `close_completion_timestamp` TIMESTAMP COMMENT 'The date and time when the period close process was marked as complete and all checklist steps were finished.',
    `close_start_timestamp` TIMESTAMP COMMENT 'The date and time when the period close process was initiated and status changed from open to in_progress.',
    `close_status` STRING COMMENT 'Current status of the period close process. Open indicates not started, in_progress indicates close activities underway, complete indicates all steps finished and signed off, blocked indicates close cannot proceed due to issues, reopened indicates a previously closed period has been reopened for adjustments.. Valid values are `open|in_progress|complete|blocked|reopened`',
    `close_type` STRING COMMENT 'The purpose or scope of the close: operational for internal management reporting, statutory for regulatory and external reporting per IFRS/GAAP, management for internal KPI and EBITDA analysis, consolidation for group-level financial consolidation.. Valid values are `operational|statutory|management|consolidation`',
    `cogs_recognition_status` STRING COMMENT 'Status of COGS recognition and inventory valuation adjustments for the period, ensuring proper matching of costs to revenues.. Valid values are `not_started|in_progress|completed|failed`',
    `completed_steps` STRING COMMENT 'The number of checklist steps that have been completed and signed off as of the current state.',
    `controlling_area_code` STRING COMMENT 'The controlling area code in SAP S/4HANA FI/CO that governs cost accounting and profitability analysis for this period close.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this period close record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code representing the reporting currency for this period close (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `depreciation_run_status` STRING COMMENT 'Status of the depreciation calculation and posting run for fixed assets as part of the period close process.. Valid values are `not_started|in_progress|completed|failed`',
    `fiscal_period` STRING COMMENT 'The fiscal period number within the fiscal year (e.g., 1-12 for monthly periods, 1-4 for quarterly periods). Represents the accounting period being closed.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which the period close is being performed, typically a four-digit year (e.g., 2024).',
    `intercompany_reconciliation_status` STRING COMMENT 'Status of intercompany account reconciliation and elimination entries required for group consolidation.. Valid values are `not_started|in_progress|completed|failed`',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this period close record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this period close record was last updated or modified.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, observations, or special instructions related to this period close process.',
    `period_lock_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the fiscal period has been locked in SAP S/4HANA FI/CO to prevent further postings. True if locked, False if open for postings.',
    `period_type` STRING COMMENT 'The type of accounting period being closed: monthly for regular month-end close, quarterly for quarter-end, annual for year-end, or special for ad-hoc adjustments.. Valid values are `monthly|quarterly|annual|special`',
    `planned_close_date` DATE COMMENT 'The target date by which the period close process is scheduled to be completed, as defined in the close calendar.',
    `reopen_approved_by` STRING COMMENT 'The name of the senior finance executive who approved the reopening of a previously closed period. Null if period has not been reopened.',
    `reopen_reason` STRING COMMENT 'The business justification or reason for reopening a previously closed period, such as error correction, audit adjustment, or late invoice receipt. Null if period has not been reopened.',
    `reopen_timestamp` TIMESTAMP COMMENT 'The date and time when the period was reopened for additional postings or adjustments. Null if period has not been reopened.',
    `revenue_recognition_status` STRING COMMENT 'Status of revenue recognition adjustments and deferrals to ensure compliance with IFRS 15 or GAAP ASC 606 revenue recognition standards.. Valid values are `not_started|in_progress|completed|failed`',
    `sign_off_approver_email` STRING COMMENT 'The email address of the sign-off approver who provided final approval for the period close.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sign_off_approver_name` STRING COMMENT 'The full name of the senior finance executive (e.g., CFO, Controller) who provided final sign-off approval for the period close.',
    `sign_off_timestamp` TIMESTAMP COMMENT 'The date and time when the sign-off approver formally approved and signed off on the period close, marking it as officially complete.',
    `source_system` STRING COMMENT 'The name or identifier of the source ERP system from which this period close record originated, typically SAP S/4HANA FI/CO.',
    `source_system_code` STRING COMMENT 'The unique identifier or key of this period close record in the source ERP system.',
    `statutory_reporting_status` STRING COMMENT 'Status of statutory financial statement preparation and regulatory reporting submissions required for this period.. Valid values are `not_started|in_progress|completed|failed`',
    `total_checklist_steps` STRING COMMENT 'The total number of checklist steps or tasks defined for this period close process.',
    `variance_explanation` STRING COMMENT 'Explanation or commentary on significant variances identified during the close process, such as budget vs actual variances, prior period comparisons, or unusual transactions.',
    CONSTRAINT pk_period_close PRIMARY KEY(`period_close_id`)
) COMMENT 'Tracks the EOM (End of Month) and period-end financial close process for each company code and fiscal period in SAP S/4HANA FI/CO. Captures close checklist step, responsible owner, planned close date, actual completion date, status (open, in-progress, complete, blocked), blocking reason, and sign-off approver. Manages the structured close calendar including depreciation runs, accruals, intercompany reconciliation, and statutory reporting milestones.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the bank account record. Primary key for the bank account master data entity.',
    `account_id` BIGINT COMMENT 'Internal account identifier within the house bank structure. Used in combination with house_bank_id to uniquely identify the account in SAP.. Valid values are `^[A-Z0-9]{3,15}$`',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Bank accounts belong to a legal entity (company code). Normalizing STRING company_code to FK company_code_id → company_code.company_code_id. Remove redundant company_code STRING column.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Bank accounts are linked to GL accounts for reconciliation and financial reporting. Normalizing STRING gl_account_code to FK gl_account_id → gl_account.gl_account_id. Remove redundant gl_account_code ',
    `cash_pool_header_bank_account_id` BIGINT COMMENT 'Self-referencing FK on bank_account (cash_pool_header_bank_account_id)',
    `account_closing_date` DATE COMMENT 'Date when the bank account was officially closed. Null for active accounts.',
    `account_holder_name` STRING COMMENT 'Legal name of the account holder as registered with the bank. Typically matches the company legal entity name.',
    `account_number` STRING COMMENT 'The actual bank account number as assigned by the financial institution. Format varies by country and banking system.',
    `account_opening_date` DATE COMMENT 'Date when the bank account was officially opened and activated with the financial institution.',
    `account_purpose_description` STRING COMMENT 'Free-text description of the business purpose and usage of this bank account. Provides context for treasury management and audit purposes.',
    `account_status` STRING COMMENT 'Current operational status of the bank account. Active accounts are in use, inactive are temporarily suspended, closed are permanently terminated, blocked are restricted by bank or company, dormant have no recent activity.. Valid values are `active|inactive|closed|blocked|dormant`',
    `account_type` STRING COMMENT 'Classification of the bank account based on its business purpose. Operating accounts handle day-to-day transactions, payroll accounts for employee payments, Letter of Credit (LC) accounts for trade finance, cash pooling for treasury optimization, escrow for held funds, and transit for in-process payments.. Valid values are `operating|payroll|letter_of_credit|cash_pooling|escrow|transit`',
    `available_balance_amount` DECIMAL(18,2) COMMENT 'Available balance after accounting for holds, pending transactions, and reserved funds. Represents actual spendable cash.',
    `bank_address_line_1` STRING COMMENT 'First line of the bank branch physical address. Organizational contact data classified as confidential.',
    `bank_address_line_2` STRING COMMENT 'Second line of the bank branch physical address (suite, floor, building). Organizational contact data classified as confidential.',
    `bank_branch_name` STRING COMMENT 'Name of the specific bank branch where the account is maintained.',
    `bank_city` STRING COMMENT 'City where the bank branch is located. Organizational contact data classified as confidential.',
    `bank_key` STRING COMMENT 'Country-specific bank identifier code (e.g., routing number in USA, sort code in UK, bank code in other countries). Used for domestic payment processing.',
    `bank_name` STRING COMMENT 'Full legal name of the financial institution where the account is held.',
    `bank_phone_number` STRING COMMENT 'Primary contact phone number for the bank branch. Organizational contact data classified as confidential.',
    `bank_postal_code` STRING COMMENT 'Postal or ZIP code of the bank branch location. Organizational contact data classified as confidential.',
    `bank_state_province` STRING COMMENT 'State or province where the bank branch is located. Organizational contact data classified as confidential.',
    `cash_pooling_indicator` BOOLEAN COMMENT 'Flag indicating whether this account participates in a cash pooling arrangement for treasury optimization across multiple entities or accounts.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the bank account is domiciled. Important for regulatory reporting and tax compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank account master record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code representing the primary currency denomination of the bank account.. Valid values are `^[A-Z]{3}$`',
    `current_balance_amount` DECIMAL(18,2) COMMENT 'Current available balance in the bank account as of the last reconciliation or statement date. Used for cash flow management and liquidity analysis.',
    `house_bank_code` STRING COMMENT 'Unique identifier for the house bank in SAP S/4HANA FI. Represents the companys banking partner where the account is maintained.. Valid values are `^[A-Z0-9]{3,10}$`',
    `iban` STRING COMMENT 'International Bank Account Number used for cross-border payments and international transactions. Standardized format for global banking.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$`',
    `interest_rate_percentage` DECIMAL(18,2) COMMENT 'Annual interest rate percentage applied to the account balance. May be positive for interest-bearing accounts or negative for certain treasury accounts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank account master record was last updated in the system.',
    `last_reconciliation_date` DATE COMMENT 'Date when the last bank reconciliation was completed for this account. Critical for End of Month (EOM) close and financial reporting accuracy.',
    `last_statement_date` DATE COMMENT 'Date of the most recent bank statement received and processed for this account. Used for reconciliation tracking.',
    `lc_facility_indicator` BOOLEAN COMMENT 'Flag indicating whether this account is designated for Letter of Credit (LC) issuance and settlement. Critical for apparel fashion global sourcing and Free on Board (FOB) payment terms.',
    `lc_limit_amount` DECIMAL(18,2) COMMENT 'Maximum Letter of Credit facility limit available on this account. Used for managing trade finance capacity for international supplier payments.',
    `minimum_balance_amount` DECIMAL(18,2) COMMENT 'Minimum balance requirement set by the bank or company policy to avoid fees or maintain account status.',
    `overdraft_limit_amount` DECIMAL(18,2) COMMENT 'Maximum overdraft or credit facility limit extended by the bank for this account. Zero if no overdraft facility exists.',
    `payment_method_supported` STRING COMMENT 'Comma-separated list of payment methods supported by this account (e.g., wire transfer, ACH, check, EDI, SWIFT). Used for payment run configuration.',
    `relationship_manager_email` STRING COMMENT 'Email address of the bank relationship manager. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `relationship_manager_name` STRING COMMENT 'Name of the bank relationship manager or account officer responsible for this account. Key contact for banking services and issue resolution.',
    `relationship_manager_phone` STRING COMMENT 'Phone number of the bank relationship manager. Organizational contact data classified as confidential.',
    `swift_code` STRING COMMENT 'SWIFT/BIC code identifying the bank and branch for international wire transfers and Letter of Credit (LC) transactions.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Master record for bank accounts maintained in SAP S/4HANA FI (house banks and account IDs) used for payment processing, cash pooling, and treasury management. Captures bank key, account number, IBAN, SWIFT/BIC, currency, GL reconciliation account, account type (operating, payroll, LC), daily balance, and bank relationship details. Essential for cash flow management, payment run configuration, and Letter of Credit settlement in apparel fashion global operations.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` (
    `consolidation_entry_id` BIGINT COMMENT 'Unique identifier for the consolidation entry record. Primary key for the consolidation entry entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Consolidation entries can be allocated to cost centers for cost tracking. Normalizing STRING cost_center_code to FK cost_center_id → cost_center.cost_center_id. Remove redundant cost_center_code STRIN',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Consolidation entry creation must link to employee for audit trail and SOX compliance. Apparel companies with multiple entities require created_by FK for consolidation journal entry audit and maker-ch',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Consolidation entries post to GL accounts for group reporting. Normalizing STRING gl_account_code to FK gl_account_id → gl_account.gl_account_id. Remove redundant gl_account_code STRING column.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Consolidation entries are posted to specific ledgers (group ledger, IFRS ledger, GAAP ledger, etc.) in SAP S/4HANA for parallel accounting and group reporting. Each consolidation entry must be associa',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Consolidation entries can be allocated to profit centers for segment reporting. Normalizing STRING profit_center_code to FK profit_center_id → profit_center.profit_center_id. Remove redundant profit_c',
    `reversed_entry_consolidation_entry_id` BIGINT COMMENT 'Reference to the original consolidation entry that is being reversed by this entry. Null if not a reversal.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Consolidation entries track source legal entity for intercompany eliminations. Normalizing STRING source_company_code to FK source_company_code_id → company_code.company_code_id (first FK to company_c',
    `reversal_consolidation_entry_id` BIGINT COMMENT 'Self-referencing FK on consolidation_entry (reversal_consolidation_entry_id)',
    `accounting_principle` STRING COMMENT 'Accounting standard or principle under which the consolidation entry is prepared. Determines the treatment and disclosure requirements.. Valid values are `IFRS|GAAP|LOCAL_GAAP|STATUTORY`',
    `approved_by_user` STRING COMMENT 'User identifier of the person who approved the consolidation entry for posting. Null if not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the consolidation entry was approved. Null if not yet approved. Supports segregation of duties controls.',
    `brand_code` STRING COMMENT 'Brand code associated with the consolidation entry. Enables brand-level profitability analysis in multi-brand apparel fashion groups.',
    `business_area_code` STRING COMMENT 'Business area code for segment or divisional reporting. Enables cross-company code reporting by business line.',
    `channel_type` STRING COMMENT 'Sales or distribution channel associated with the consolidation entry. Used for channel-level segment reporting and analysis.. Valid values are `retail|wholesale|ecommerce|dtc|outlet`',
    `consolidation_group_code` STRING COMMENT 'Code identifying the consolidation group or reporting entity hierarchy to which this entry belongs. Used for multi-level consolidation structures.',
    `consolidation_unit_code` STRING COMMENT 'Code identifying the consolidation unit or group entity for which this entry is recorded. Represents the reporting entity in the group structure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consolidation entry record was first created in the system. Supports audit trail and data lineage.',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether the consolidation entry is a debit or credit posting. Determines the direction of the accounting impact.. Valid values are `debit|credit`',
    `elimination_method` STRING COMMENT 'Method used for eliminating intercompany transactions or consolidating subsidiary results. Determines the calculation approach for the consolidation entry.. Valid values are `full_elimination|proportional_elimination|equity_method|cost_method`',
    `entry_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the consolidation entry in the transaction currency. Represents the value of the adjustment or elimination.',
    `entry_date` DATE COMMENT 'Date on which the consolidation entry was created or entered into the system. May differ from posting date.',
    `entry_description` STRING COMMENT 'Detailed textual description of the consolidation entry explaining the business purpose and nature of the adjustment or elimination.',
    `entry_number` STRING COMMENT 'Business identifier for the consolidation entry document. Externally-known reference number used for tracking and audit purposes.',
    `entry_status` STRING COMMENT 'Current lifecycle status of the consolidation entry in the approval and posting workflow.. Valid values are `draft|submitted|approved|posted|reversed|rejected`',
    `entry_type` STRING COMMENT 'Classification of the consolidation entry indicating the nature of the adjustment. Determines the accounting treatment and reporting requirements.. Valid values are `intercompany_elimination|currency_translation|minority_interest|fair_value_adjustment|goodwill_impairment|consolidation_adjustment`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate used to translate the transaction currency amount to the group currency amount. Applied at the time of consolidation.',
    `exchange_rate_type` STRING COMMENT 'Type of exchange rate applied for currency translation. Determines the rate selection methodology per accounting standards.. Valid values are `spot|average|closing|historical`',
    `fiscal_period` STRING COMMENT 'Fiscal period within the fiscal year for which the consolidation entry is recorded. Typically represents a month or quarter.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the consolidation entry is recorded. Aligns with the group reporting calendar.',
    `geographic_region_code` STRING COMMENT 'Geographic region code for the consolidation entry. Supports geographic segment reporting per IFRS 8 and GAAP ASC 280.',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'Consolidation entry amount translated into the group reporting currency. Used for consolidated financial statement preparation.',
    `group_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code of the group reporting currency. Typically the parent companys functional currency.',
    `last_modified_by_user` STRING COMMENT 'User identifier of the person who last modified the consolidation entry. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the consolidation entry was last modified. Supports audit trail and change tracking.',
    `minority_interest_percentage` DECIMAL(18,2) COMMENT 'Percentage of non-controlling interest in the subsidiary for which the consolidation entry is recorded. Used for minority interest calculations.',
    `notes` STRING COMMENT 'Additional notes or comments related to the consolidation entry. Used for documentation and audit purposes.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership interest held by the parent in the subsidiary. Determines the consolidation method and elimination scope.',
    `posting_date` DATE COMMENT 'Date on which the consolidation entry is posted to the group ledger. Represents the accounting effective date for the adjustment.',
    `reference_document_number` STRING COMMENT 'External reference document number or source transaction identifier that triggered the consolidation entry. Provides audit trail linkage.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this consolidation entry is a reversal of a previously posted entry. True if reversal, False otherwise.',
    `segment_code` STRING COMMENT 'Segment code for IFRS 8 or GAAP segment reporting. Identifies the operating segment to which the consolidation entry relates.',
    `target_company_code` STRING COMMENT 'Company code of the receiving entity in an intercompany transaction or consolidation adjustment. Represents the receiving or crediting entity.',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the consolidation entry amount is denominated.',
    CONSTRAINT pk_consolidation_entry PRIMARY KEY(`consolidation_entry_id`)
) COMMENT 'Records financial consolidation adjustments and elimination entries for group reporting in SAP S/4HANA Group Reporting or BPC. Captures consolidation unit, elimination method, adjustment type (IC elimination, currency translation, minority interest), source and target company codes, consolidation group, reporting period, and IFRS/GAAP treatment. Supports statutory group financial statements and segment reporting for multi-entity apparel fashion groups.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` (
    `letter_of_credit_id` BIGINT COMMENT 'Unique identifier for the letter of credit record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Letters of credit are issued by a legal entity (company code). Normalizing STRING company_code to FK company_code_id → company_code.company_code_id. Remove redundant company_code STRING column.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Letters of credit are issued through a specific bank account maintained in SAP S/4HANA FI. Currently the issuing bank is captured as denormalized STRING fields (issuing_bank_name, issuing_bank_swift_c',
    `order_purchase_order_id` BIGINT COMMENT 'Foreign key linking to order.purchase_order. Business justification: Letters of credit secure payment for international purchase orders in apparel sourcing. This link enables LC utilization tracking, compliance verification that shipments match LC terms, and procure-to',
    `vendor_id` BIGINT COMMENT 'Foreign key reference to the supplier master data. Links the LC beneficiary to the internal supplier record for procurement and payment tracking.',
    `amended_letter_of_credit_id` BIGINT COMMENT 'Self-referencing FK on letter_of_credit (amended_letter_of_credit_id)',
    `advising_bank_name` STRING COMMENT 'The name of the bank that advises the letter of credit to the beneficiary, typically located in the beneficiarys country.',
    `advising_bank_swift_code` STRING COMMENT 'The SWIFT/BIC code of the advising bank for international communication and document handling.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `amendment_date` DATE COMMENT 'The date of the most recent amendment to the letter of credit terms.',
    `amendment_number` STRING COMMENT 'Sequential number tracking amendments made to the original letter of credit. Zero indicates the original LC with no amendments.',
    `applicant_address` STRING COMMENT 'The full business address of the applicant party requesting the letter of credit.',
    `applicant_name` STRING COMMENT 'The name of the party (buyer/importer) who requests the issuing bank to open the letter of credit.',
    `available_amount` DECIMAL(18,2) COMMENT 'The remaining credit amount available for utilization under the letter of credit.',
    `beneficiary_address` STRING COMMENT 'The full business address of the beneficiary party entitled to receive payment under the letter of credit.',
    `beneficiary_name` STRING COMMENT 'The name of the party (seller/exporter/supplier) in whose favor the letter of credit is issued and who is entitled to draw under it.',
    `charges_account` STRING COMMENT 'Indicates which party (applicant or beneficiary) is responsible for paying the letter of credit charges and fees.. Valid values are `applicant|beneficiary|shared`',
    `confirming_bank_name` STRING COMMENT 'The name of the bank that adds its confirmation to the letter of credit, providing additional payment guarantee to the beneficiary.',
    `created_by_user` STRING COMMENT 'The user ID or name of the person who created this letter of credit record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this letter of credit record was first created in the system. Record audit trail for data governance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the letter of credit amount.. Valid values are `^[A-Z]{3}$`',
    `document_requirements` STRING COMMENT 'Detailed description of all documents required to be presented for negotiation under the letter of credit (e.g., commercial invoice, packing list, bill of lading, certificate of origin, inspection certificate).',
    `expiry_date` DATE COMMENT 'The date when the letter of credit expires and is no longer valid for presentation of documents. Represents the effective-until date of the agreement.',
    `goods_description` STRING COMMENT 'Description of the goods or merchandise covered by the letter of credit, including product details, quantities, and specifications.',
    `incoterm_code` STRING COMMENT 'The International Commercial Terms (Incoterms) code defining the delivery terms, risk transfer point, and cost responsibilities between buyer and seller. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `issue_date` DATE COMMENT 'The date when the letter of credit was officially issued by the issuing bank. This is the principal business event timestamp marking when the LC becomes effective.',
    `last_modified_by_user` STRING COMMENT 'The user ID or name of the person who last modified this letter of credit record in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this letter of credit record was last updated in the system. Record audit trail for data governance.',
    `latest_shipment_date` DATE COMMENT 'The last permissible date for shipment of goods under the terms of the letter of credit.',
    `lc_amount` DECIMAL(18,2) COMMENT 'The maximum monetary value of the letter of credit. This is the principal quantitative fact representing the credit limit available to the beneficiary.',
    `lc_number` STRING COMMENT 'The externally-known documentary credit number issued by the bank. This is the business identifier used in trade finance communications and documentation.',
    `lc_status` STRING COMMENT 'Current lifecycle status of the letter of credit in the trade finance workflow. [ENUM-REF-CANDIDATE: draft|issued|advised|confirmed|amended|utilized|expired|closed — 8 candidates stripped; promote to reference product]',
    `lc_type` STRING COMMENT 'Classification of the letter of credit based on its terms and conditions. Determines the level of commitment and transferability.. Valid values are `irrevocable|revocable|confirmed|unconfirmed|transferable|standby`',
    `partial_shipment_allowed` BOOLEAN COMMENT 'Indicates whether partial shipments of goods are permitted under the letter of credit terms.',
    `payment_terms` STRING COMMENT 'The payment terms specified in the letter of credit indicating when payment will be made (at sight, deferred, or upon acceptance).. Valid values are `sight|deferred|usance|acceptance`',
    `port_of_discharge` STRING COMMENT 'The port or place where goods are unloaded at destination under the letter of credit terms.',
    `port_of_loading` STRING COMMENT 'The port or place where goods are loaded for shipment under the letter of credit terms.',
    `presentation_period_days` STRING COMMENT 'The maximum number of days after shipment date within which documents must be presented to the bank for negotiation.',
    `revolving_flag` BOOLEAN COMMENT 'Indicates whether the letter of credit automatically renews for additional shipments after each utilization.',
    `special_conditions` STRING COMMENT 'Any additional special terms, conditions, or instructions specific to this letter of credit that are not covered by standard fields.',
    `tenor_days` STRING COMMENT 'The number of days after sight or shipment date when payment is due under deferred payment or usance terms.',
    `tolerance_percentage` DECIMAL(18,2) COMMENT 'The permissible percentage variance (plus or minus) allowed in the LC amount and quantity as per UCP 600 Article 30.',
    `transferable_flag` BOOLEAN COMMENT 'Indicates whether the letter of credit can be transferred in whole or in part to one or more second beneficiaries.',
    `transshipment_allowed` BOOLEAN COMMENT 'Indicates whether transshipment (transfer of goods from one vessel to another during transit) is permitted under the letter of credit terms.',
    `utilized_amount` DECIMAL(18,2) COMMENT 'The cumulative amount that has been drawn or utilized against the letter of credit to date.',
    CONSTRAINT pk_letter_of_credit PRIMARY KEY(`letter_of_credit_id`)
) COMMENT 'Letter of Credit documentary credit record managing trade finance for international supplier payments including LC type, amount, beneficiary, and document requirements';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` (
    `cost_center_initiative_participation_id` BIGINT COMMENT 'Unique identifier for the cost center initiative participation record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to the cost center participating in the sustainability initiative. References the organizational cost object (store, warehouse, DC, office, production facility) involved in the program.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to the sustainability initiative in which the cost center is participating. References the discrete sustainability improvement program or project.',
    `sustainability_initiative_id` BIGINT COMMENT 'Foreign key to sustainability.sustainability_initiative. The sustainability program in which the cost center participates.',
    `actual_carbon_reduction_mt_co2e` DECIMAL(18,2) COMMENT 'Measured annual greenhouse gas emissions reduction in metric tons of CO2 equivalent achieved by this cost center through participation in the initiative. Enables rollup of initiative impact by cost center hierarchy and location.',
    `actual_energy_savings_mwh` DECIMAL(18,2) COMMENT 'Measured annual energy consumption reduction in megawatt hours achieved by this cost center through participation in the initiative. Supports energy efficiency reporting by facility type and geography.',
    `actual_water_savings_m3` DECIMAL(18,2) COMMENT 'Measured annual water consumption reduction in cubic meters achieved by this cost center through participation in the initiative. Supports water stewardship reporting by facility and region.',
    `allocated_investment_amount` DECIMAL(18,2) COMMENT 'The portion of the initiatives total investment amount allocated to this cost center, calculated as initiative investment_amount × cost_allocation_percentage. Used for cost center budget impact analysis and ESG investment tracking by organizational unit.',
    `cost_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the initiatives total investment amount allocated to or borne by this cost center, expressed as a decimal percentage (0.00 to 100.00). Used for distributing initiative costs across participating organizational units and for cost center budget tracking. This attribute was explicitly identified in the detection reasoning as relationship data (cost share).',
    `end_date` DATE COMMENT 'The date when this cost center completed or exited participation in the sustainability initiative. Null if participation is ongoing. This attribute was explicitly identified in the detection reasoning as relationship data (timeline).',
    `initiative_phase` STRING COMMENT 'The current phase of initiative implementation at this specific cost center. PLANNING: initiative approved but not yet started at this location. IMPLEMENTATION: active rollout in progress. MEASUREMENT: implementation complete, measuring impact. COMPLETED: initiative fully implemented and measured at this location. SUSPENDED: participation paused or cancelled. This attribute was explicitly identified in the detection reasoning as relationship data (phase).',
    `notes` STRING COMMENT 'Free-text notes capturing implementation details, challenges, lessons learned, or other context specific to this cost centers participation in the initiative.',
    `participation_role` STRING COMMENT 'The role of the cost center in the sustainability initiative. LEAD: primary responsible party driving implementation at this location. PARTICIPANT: active participant implementing the program. PILOT: test site for initiative before broader rollout. OBSERVER: monitoring or learning from the initiative without active implementation. This attribute was explicitly identified in the detection reasoning as relationship data.',
    `participation_status` STRING COMMENT 'Current lifecycle status of this cost centers participation in the initiative. ACTIVE: currently participating. COMPLETED: participation finished successfully. SUSPENDED: temporarily paused. CANCELLED: participation terminated before completion.',
    `start_date` DATE COMMENT 'The date when this cost center began participating in the sustainability initiative. May differ from the initiatives overall start date if cost centers join in phases. This attribute was explicitly identified in the detection reasoning as relationship data (timeline).',
    CONSTRAINT pk_cost_center_initiative_participation PRIMARY KEY(`cost_center_initiative_participation_id`)
) COMMENT 'This association product represents the participation relationship between cost centers and sustainability initiatives in Apparel Fashion operations. It captures the cross-functional involvement of organizational cost centers (stores, warehouses, DCs, offices) in discrete sustainability improvement programs (renewable energy, waterless dyeing, repair services, packaging elimination). Each record links one cost center to one sustainability initiative with attributes that track the participation role (lead vs. participant), cost allocation responsibility, timeline boundaries, and implementation phase. This enables portfolio management of sustainability programs across the organizational cost structure and supports ESG reporting by cost center hierarchy.. Existence Justification: In Apparel Fashion sustainability operations, cost centers (stores, warehouses, DCs, offices, production facilities) participate in multiple sustainability initiatives simultaneously (LED retrofit, renewable energy procurement, waterless dyeing, packaging elimination), and each initiative involves multiple cost centers across the organizational hierarchy. The business actively manages these participation relationships as part of ESG program portfolio management, tracking which locations are involved in which programs, their roles (lead vs. participant), cost allocation responsibility, implementation timelines, and measured impact by location.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`finance`.`allocation_cycle` (
    `allocation_cycle_id` BIGINT COMMENT 'Primary key for allocation_cycle',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Allocation cycles represent cost allocation and assessment runs in SAP S/4HANA CO. These must be scoped to a legal entity (company code) for proper cost accounting and financial reporting. Each alloca',
    `parent_cycle_id` BIGINT COMMENT 'Identifier of the parent allocation cycle if this cycle is a revision or sub-cycle of another. Nullable for top-level cycles.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the primary cost center from which costs are being allocated.',
    `prior_allocation_cycle_id` BIGINT COMMENT 'Self-referencing FK on allocation_cycle (prior_allocation_cycle_id)',
    `actual_end_date` DATE COMMENT 'The actual date when the allocation cycle execution was completed. Nullable if not yet completed.',
    `actual_start_date` DATE COMMENT 'The actual date when the allocation cycle execution began. Nullable if not yet started.',
    `allocation_basis` STRING COMMENT 'The basis or driver used for allocation calculations (e.g., headcount, square footage, revenue, units sold).',
    `allocation_frequency` STRING COMMENT 'The frequency at which this allocation cycle is executed (e.g., monthly, quarterly, annual).',
    `allocation_method` STRING COMMENT 'The methodology used to allocate costs or revenues during this cycle (e.g., direct allocation, step-down, activity-based costing).',
    `allocation_scope` STRING COMMENT 'The organizational scope to which this allocation cycle applies (e.g., global, regional, divisional).',
    `approval_date` DATE COMMENT 'The date on which this allocation cycle was formally approved by authorized personnel.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this allocation cycle.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this allocation cycle record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which allocation amounts are denominated.',
    `cycle_code` STRING COMMENT 'Business identifier code for the allocation cycle, used for external reference and reporting.',
    `cycle_name` STRING COMMENT 'Descriptive name of the allocation cycle, typically indicating the period or purpose (e.g., Q1 2024 Cost Allocation, Annual Budget Allocation).',
    `cycle_type` STRING COMMENT 'Classification of the allocation cycle indicating its purpose within the financial planning process.',
    `allocation_cycle_description` STRING COMMENT 'Detailed description of the allocation cycle, including its purpose, scope, and any special considerations.',
    `effective_end_date` DATE COMMENT 'The date on which this allocation cycle ceases to be effective. Nullable for open-ended cycles.',
    `effective_start_date` DATE COMMENT 'The date from which this allocation cycle becomes effective and applicable for financial transactions.',
    `fiscal_period` STRING COMMENT 'The fiscal period within the year (e.g., Q1, M01, H1, FY) to which this allocation cycle applies.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this allocation cycle applies.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this allocation cycle is currently active (True) or has been deactivated (False).',
    `is_automated` BOOLEAN COMMENT 'Indicates whether this allocation cycle is executed through automated processes (True) or requires manual intervention (False).',
    `modified_by` STRING COMMENT 'Name or identifier of the user who last modified this allocation cycle record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this allocation cycle record was last modified.',
    `notes` STRING COMMENT 'Additional notes or comments related to this allocation cycle, including any exceptions or special handling instructions.',
    `planned_end_date` DATE COMMENT 'The planned date for completing the allocation cycle execution activities.',
    `planned_start_date` DATE COMMENT 'The planned date for beginning the allocation cycle execution activities.',
    `requires_approval` BOOLEAN COMMENT 'Indicates whether this allocation cycle requires formal approval before execution (True) or can proceed without approval (False).',
    `allocation_cycle_status` STRING COMMENT 'Current lifecycle status of the allocation cycle, indicating its progression through the approval and execution workflow.',
    `total_allocation_amount` DECIMAL(18,2) COMMENT 'The total monetary amount being allocated in this cycle across all cost centers, products, or channels.',
    `version_number` STRING COMMENT 'Version number of this allocation cycle, incremented when the cycle is revised or rerun.',
    `created_by` STRING COMMENT 'Name or identifier of the user who created this allocation cycle record.',
    CONSTRAINT pk_allocation_cycle PRIMARY KEY(`allocation_cycle_id`)
) COMMENT 'Master reference table for allocation_cycle. Referenced by allocation_cycle_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ADD CONSTRAINT `fk_finance_finance_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ADD CONSTRAINT `fk_finance_finance_payment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ADD CONSTRAINT `fk_finance_finance_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ADD CONSTRAINT `fk_finance_finance_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ADD CONSTRAINT `fk_finance_finance_payment_letter_of_credit_id` FOREIGN KEY (`letter_of_credit_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`letter_of_credit`(`letter_of_credit_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_original_entry_cogs_entry_id` FOREIGN KEY (`original_entry_cogs_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cogs_entry`(`cogs_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ADD CONSTRAINT `fk_finance_tax_item_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ADD CONSTRAINT `fk_finance_tax_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ADD CONSTRAINT `fk_finance_tax_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ADD CONSTRAINT `fk_finance_tax_item_original_tax_item_id` FOREIGN KEY (`original_tax_item_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`tax_item`(`tax_item_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ADD CONSTRAINT `fk_finance_tax_item_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ADD CONSTRAINT `fk_finance_tax_item_asset_transaction_id` FOREIGN KEY (`asset_transaction_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`asset_transaction`(`asset_transaction_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_allocation_cycle_id` FOREIGN KEY (`allocation_cycle_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_original_allocation_cost_allocation_id` FOREIGN KEY (`original_allocation_cost_allocation_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_sender_cost_center_id` FOREIGN KEY (`sender_cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_cash_pool_header_bank_account_id` FOREIGN KEY (`cash_pool_header_bank_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ADD CONSTRAINT `fk_finance_consolidation_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ADD CONSTRAINT `fk_finance_consolidation_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ADD CONSTRAINT `fk_finance_consolidation_entry_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ADD CONSTRAINT `fk_finance_consolidation_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ADD CONSTRAINT `fk_finance_consolidation_entry_reversed_entry_consolidation_entry_id` FOREIGN KEY (`reversed_entry_consolidation_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`consolidation_entry`(`consolidation_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ADD CONSTRAINT `fk_finance_consolidation_entry_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ADD CONSTRAINT `fk_finance_consolidation_entry_reversal_consolidation_entry_id` FOREIGN KEY (`reversal_consolidation_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`consolidation_entry`(`consolidation_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ADD CONSTRAINT `fk_finance_letter_of_credit_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ADD CONSTRAINT `fk_finance_letter_of_credit_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ADD CONSTRAINT `fk_finance_letter_of_credit_amended_letter_of_credit_id` FOREIGN KEY (`amended_letter_of_credit_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`letter_of_credit`(`letter_of_credit_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ADD CONSTRAINT `fk_finance_cost_center_initiative_participation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_parent_cycle_id` FOREIGN KEY (`parent_cycle_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_prior_allocation_cycle_id` FOREIGN KEY (`prior_allocation_cycle_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`allocation_cycle`(`allocation_cycle_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `apparel_fashion_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `actual_cost_ytd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Year-to-Date (YTD)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `actual_cost_ytd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = 'dtc|wholesale|retail|ecommerce|outlet');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `committed_cost_ytd` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost Year-to-Date (YTD)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `committed_cost_ytd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|assessment|distribution|activity_based|percentage');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_number` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|planned');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Group');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_node` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Hierarchy Node');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `is_locked_for_posting` SET TAGS ('dbx_business_glossary_term' = 'Is Locked for Posting');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `is_overhead_receiver` SET TAGS ('dbx_business_glossary_term' = 'Is Overhead Receiver');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `is_overhead_sender` SET TAGS ('dbx_business_glossary_term' = 'Is Overhead Sender');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|step_down|reciprocal|activity_based');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `analysis_period` SET TAGS ('dbx_business_glossary_term' = 'Analysis Period (YYYYMM)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `analysis_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}(0[1-9]|1[0-2])$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Direct-to-Consumer (DTC) Channel Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'dtc|wholesale|retail|ecommerce|marketplace');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `consolidation_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Unit Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `consolidation_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO) Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_group_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'north_america|emea|apac|latam|greater_china');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `hierarchy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Notes');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `planning_level` SET TAGS ('dbx_business_glossary_term' = 'Planning Level');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `planning_level` SET TAGS ('dbx_value_regex' = 'strategic|tactical|operational');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'footwear|apparel|accessories|equipment|licensed_products');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'brand|channel|product_line|region|store|division');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Email Address');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Short Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'cost_plus|market_price|negotiated|arms_length');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Identifier');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `account_long_text` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Long Description');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Classification');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_value_regex' = 'current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `blocked_for_posting_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocked for Posting Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Statement Classification');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_value_regex' = 'operating|investing|financing|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `channel_classification` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Classification');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `cogs_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Relevant Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `consolidation_account` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_center_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `ebitda_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Relevant Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `field_status_group` SET TAGS ('dbx_business_glossary_term' = 'Field Status Group');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `field_status_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `financial_statement_category` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Category');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `gaap_classification` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Classification');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|pending_approval');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `gmroi_category` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Category');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `ifrs_classification` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Classification');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `interest_calculation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Interest Calculation Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `landed_cost_component` SET TAGS ('dbx_business_glossary_term' = 'Landed Duty Paid (LDP) Cost Component');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `line_item_display_flag` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `open_item_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `planning_level` SET TAGS ('dbx_business_glossary_term' = 'Planning Level');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Allowed Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `profit_center_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `profit_loss_classification` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Classification');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Sort Key');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `sort_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `tolerance_group` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Group');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `tolerance_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`gl_account` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_business_glossary_term' = 'Accounting Principle');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_value_regex' = 'ifrs|us_gaap|local_gaap|management|tax');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `accrual_posting_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Posting Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `accrual_posting_status` SET TAGS ('dbx_value_regex' = 'pending|complete|partial');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `close_blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Close Blocking Reason');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `close_calendar_template` SET TAGS ('dbx_business_glossary_term' = 'Close Calendar Template');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `close_checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Close Checklist Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `close_checklist_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|complete|blocked');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `close_responsible_owner` SET TAGS ('dbx_business_glossary_term' = 'Close Responsible Owner');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `consolidation_ledger_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Ledger Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `currency_type` SET TAGS ('dbx_business_glossary_term' = 'Currency Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `currency_type` SET TAGS ('dbx_value_regex' = 'company_code|group|hard|index|global');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `current_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Current Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `current_posting_period` SET TAGS ('dbx_business_glossary_term' = 'Current Posting Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `depreciation_run_status` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `depreciation_run_status` SET TAGS ('dbx_value_regex' = 'pending|running|complete|failed');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `intercompany_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Reconciliation Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `intercompany_reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|reconciled|variance_identified');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `last_close_date` SET TAGS ('dbx_business_glossary_term' = 'Last Close Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `last_closed_period` SET TAGS ('dbx_business_glossary_term' = 'Last Closed Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `leading_ledger_flag` SET TAGS ('dbx_business_glossary_term' = 'Leading Ledger Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `ledger_code` SET TAGS ('dbx_business_glossary_term' = 'Ledger Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `ledger_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `ledger_name` SET TAGS ('dbx_business_glossary_term' = 'Ledger Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `ledger_status` SET TAGS ('dbx_business_glossary_term' = 'Ledger Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `ledger_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `ledger_type` SET TAGS ('dbx_business_glossary_term' = 'Ledger Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `ledger_type` SET TAGS ('dbx_value_regex' = 'leading|extension|special_purpose');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `multi_gaap_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-GAAP Compliance Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `next_close_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Close Due Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Ledger Notes');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `parallel_accounting_scenario` SET TAGS ('dbx_business_glossary_term' = 'Parallel Accounting Scenario');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `period_lock_status` SET TAGS ('dbx_business_glossary_term' = 'Period Lock Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `period_lock_status` SET TAGS ('dbx_value_regex' = 'open|locked|partially_locked');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `posting_period_variant` SET TAGS ('dbx_business_glossary_term' = 'Posting Period Variant');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `posting_period_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `sign_off_approver` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Approver');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `statutory_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Statutory Reporting Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `statutory_reporting_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|submitted|approved');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'legal|group|profit_center|segment');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ledger` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'transaction_recording');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `carbon_offset_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_business_glossary_term' = 'Accounting Principle');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_value_regex' = 'IFRS|GAAP|LOCAL_GAAP|TAX');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_document_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Document Currency');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'S|H');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_header_text` SET TAGS ('dbx_business_glossary_term' = 'Document Header Text');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `trading_partner` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `trading_partner` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `translation_date` SET TAGS ('dbx_business_glossary_term' = 'Translation Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,24}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_by` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'transaction_recording');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_group_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Group Currency');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Transaction Currency');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `customer_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `customer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10,12}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,18}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_key_1` SET TAGS ('dbx_business_glossary_term' = 'Reference Key 1');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_key_2` SET TAGS ('dbx_business_glossary_term' = 'Reference Key 2');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_key_3` SET TAGS ('dbx_business_glossary_term' = 'Reference Key 3');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,24}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'transaction_recording');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `cogs_recognition_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Recognition Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_due_date` SET TAGS ('dbx_business_glossary_term' = 'Discount Due Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ifrs_accrual_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS Accrual Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_category` SET TAGS ('dbx_business_glossary_term' = 'Invoice Category');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_category` SET TAGS ('dbx_value_regex' = 'raw_materials|cmt_services|freight|operating_expense|capital_expenditure|other');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|recurring');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `landed_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Landed Duty Paid (LDP) Cost Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|ach|eft|letter_of_credit|cash');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partial_match|variance_within_tolerance|variance_exceeds_tolerance');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `vendor_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'transaction_recording');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Billing Block Reason');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Clearing Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `created_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight and Shipping Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|proforma|intercompany');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `outstanding_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|credit_card|check|letter_of_credit|cash');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,30}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|deferred|milestone');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'wholesale|dtc_online|dtc_store|retail|marketplace');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` SET TAGS ('dbx_subdomain' = 'transaction_recording');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `finance_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Payment ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `letter_of_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Credit Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `bank_charges` SET TAGS ('dbx_business_glossary_term' = 'Bank Charges');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `bank_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `beneficiary_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Bank Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `beneficiary_bank_swift_code` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Bank SWIFT Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `beneficiary_bank_swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `beneficiary_bank_swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `beneficiary_bank_swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `local_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `payment_run_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `payment_run_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|reconciled|failed|cancelled|in_transit');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'outgoing_vendor|incoming_customer|intercompany_netting|lc_settlement|bank_transfer|refund');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Payment Priority');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partially_matched|under_review');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `actual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'OPEX|CAPEX|COGS|OTB|REVENUE|EBITDA');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'RETAIL|ECOMMERCE|WHOLESALE|DTC|OUTLET|FRANCHISE');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget End Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Budget');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `is_baseline` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Budget');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'MONTHLY|QUARTERLY|ANNUAL');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Reason');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA_CO|ANAPLAN|ORACLE_EBS|MANUAL');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Start Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `available_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'cogs|operating_expense|capital_expenditure|marketing|payroll|overhead');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|frozen|closed');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'operational|capital|project|discretionary');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = 'retail|wholesale|ecommerce|dtc|outlet');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(Q[1-4]|M(0[1-9]|1[0-2])|H[1-2])$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Locked Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `is_otb_controlled` SET TAGS ('dbx_business_glossary_term' = 'Open-to-Buy (OTB) Controlled Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` SET TAGS ('dbx_subdomain' = 'transaction_recording');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `cogs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Entry ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `original_entry_cogs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Original COGS Entry ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `collection_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `colorway_code` SET TAGS ('dbx_business_glossary_term' = 'Colorway Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `cost_variance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `costing_method` SET TAGS ('dbx_business_glossary_term' = 'Costing Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `costing_method` SET TAGS ('dbx_value_regex' = 'standard|average|fifo|lifo|specific_identification');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `duty_cost` SET TAGS ('dbx_business_glossary_term' = 'Duty Cost');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `duty_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `fob_cost` SET TAGS ('dbx_business_glossary_term' = 'Free on Board (FOB) Cost');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `fob_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `ldp_cost` SET TAGS ('dbx_business_glossary_term' = 'Landed Duty Paid (LDP) Cost');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `ldp_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'GL Posting Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `quantity_sold` SET TAGS ('dbx_business_glossary_term' = 'Quantity Sold');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'COGS Recognition Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'retail|wholesale|ecommerce|dtc|marketplace');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Region Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `size_code` SET TAGS ('dbx_business_glossary_term' = 'Size Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `style_code` SET TAGS ('dbx_business_glossary_term' = 'Style Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `total_cogs_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Cost of Goods Sold (COGS) Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `total_cogs_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` SET TAGS ('dbx_subdomain' = 'transaction_recording');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `landed_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Landed Cost Identifier');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `asn_id` SET TAGS ('dbx_business_glossary_term' = 'Asn Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `air_freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Air Freight Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'weight|volume|value|unit_count');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `customs_brokerage_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Brokerage Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `customs_duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Duty Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `customs_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Value Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `fob_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Free on Board (FOB) Price Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `gsp_preference_applied` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Preference Applied');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `gsp_preference_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Preference Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `inland_freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Inland Freight Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `insurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `landed_cost_number` SET TAGS ('dbx_business_glossary_term' = 'Landed Cost Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `landed_cost_number` SET TAGS ('dbx_value_regex' = '^LC-[0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `landed_cost_status` SET TAGS ('dbx_business_glossary_term' = 'Landed Cost Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `landed_cost_status` SET TAGS ('dbx_value_regex' = 'draft|calculated|approved|posted|reversed');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `letter_of_credit_number` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `letter_of_credit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `ocean_freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Ocean Freight Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `other_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Charges Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `port_handling_amount` SET TAGS ('dbx_business_glossary_term' = 'Port Handling Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `port_of_discharge` SET TAGS ('dbx_business_glossary_term' = 'Port of Discharge');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `port_of_loading` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `tariff_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `total_landed_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Landed Duty Paid (LDP) Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `unit_landed_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Unit Landed Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_business_glossary_term' = 'Accounting Principle');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_value_regex' = 'IFRS|US_GAAP|LOCAL_GAAP|HYBRID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `business_segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `business_segment` SET TAGS ('dbx_value_regex' = 'ATHLETIC|LIFESTYLE|LUXURY|ACCESSORIES|FOOTWEAR');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Company Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `company_name_short` SET TAGS ('dbx_business_glossary_term' = 'Company Short Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `company_status` SET TAGS ('dbx_business_glossary_term' = 'Company Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `company_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|DORMANT|LIQUIDATION|MERGED');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `consolidation_entity_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entity Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `consolidation_group_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `cost_of_sales_accounting_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost of Sales (COS) Accounting Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_business_glossary_term' = 'Credit Control Area');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `field_status_variant` SET TAGS ('dbx_business_glossary_term' = 'Field Status Variant');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `field_status_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'NORTH_AMERICA|EUROPE|ASIA_PACIFIC|LATIN_AMERICA|MIDDLE_EAST_AFRICA');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `intercompany_clearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Clearing Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `posting_period_variant` SET TAGS ('dbx_business_glossary_term' = 'Posting Period Variant');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `posting_period_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `profit_center_standard_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Standard Hierarchy');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'transaction_recording');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'wholesale|retail|ecommerce|franchise|outlet');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `consolidation_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Unit Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_date` SET TAGS ('dbx_business_glossary_term' = 'Elimination Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Elimination Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_value_regex' = 'pending|eliminated|partially_eliminated|exception');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_position` SET TAGS ('dbx_business_glossary_term' = 'Netting Position');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_position` SET TAGS ('dbx_value_regex' = 'payable|receivable|settled|offset');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Profit Center Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|disputed|resolved');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'cash_payment|netting|offset|loan_conversion|waiver');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^IC[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_price_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Adjustment Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'comparable_uncontrolled_price|resale_price|cost_plus|transactional_net_margin|profit_split');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` SET TAGS ('dbx_subdomain' = 'transaction_recording');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `tax_item_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Item ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `original_tax_item_id` SET TAGS ('dbx_business_glossary_term' = 'Original Tax Item ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `asset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `customs_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'pending|filed|paid|reconciled|disputed');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `landed_cost_component` SET TAGS ('dbx_business_glossary_term' = 'Landed Duty Paid (LDP) Cost Component');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `landed_cost_component` SET TAGS ('dbx_value_regex' = 'duty|freight|insurance|handling');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Line Item Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Item Notes');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Payment Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Reversal Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `tax_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Determination Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `tax_direction` SET TAGS ('dbx_business_glossary_term' = 'Tax Direction');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `tax_direction` SET TAGS ('dbx_value_regex' = 'input_tax|output_tax');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `tax_exemption_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `tax_jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `tax_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `tax_return_reference` SET TAGS ('dbx_business_glossary_term' = 'Tax Return Reference');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'VAT|sales_tax|import_duty|excise_duty|withholding_tax|GST');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `taxable_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Base Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ALTER COLUMN `withholding_tax_indicator` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_group_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Group Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|retired|disposed|transferred');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_subnumber` SET TAGS ('dbx_business_glossary_term' = 'Asset Subnumber');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_subnumber` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_physical_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inventory Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lease Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `maintenance_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_value_regex' = 'sale|scrap|donation|obsolete|damaged|end_of_life');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Depreciation Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|macrs|accelerated');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Transaction ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'User ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_sub_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Sub-Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_value_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Value Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `customer_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `depreciation_area_code` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `document_line_item` SET TAGS ('dbx_business_glossary_term' = 'Document Line Item');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entry Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|cancelled|parked');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_text` SET TAGS ('dbx_business_glossary_term' = 'Transaction Text');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_type_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `original_allocation_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Original Allocation ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `sender_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'percentage|quantity|equivalence|direct|activity_based|driver_based');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocation Quantity');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_run_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Run Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending|error|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_unit` SET TAGS ('dbx_business_glossary_term' = 'Allocation Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO) Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_element_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Controlling Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `equivalence_number` SET TAGS ('dbx_business_glossary_term' = 'Equivalence Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `product_line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_allocation` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `margin_record_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Record ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `environmental_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `air_freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Air Freight Cost');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `asp_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Selling Price (ASP) Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `aur_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Retail (AUR) Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'wholesale|retail|ecommerce|dtc|outlet|marketplace');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `cogs_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `contribution_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Contribution Margin Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `cost_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `customs_duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Duty Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `fob_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Free On Board (FOB) Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `gmroi_ratio` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Ratio');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `gross_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percentage');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `gsp_preference_indicator` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Preference Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `imu_percentage` SET TAGS ('dbx_business_glossary_term' = 'Initial Markup (IMU) Percentage');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `inland_freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Inland Freight Cost');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `insurance_cost` SET TAGS ('dbx_business_glossary_term' = 'Insurance Cost');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `markdown_amount` SET TAGS ('dbx_business_glossary_term' = 'Markdown (MD) Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `mmu_percentage` SET TAGS ('dbx_business_glossary_term' = 'Maintained Markup (MMU) Percentage');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `ocean_freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Ocean Freight Cost');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `port_handling_cost` SET TAGS ('dbx_business_glossary_term' = 'Port Handling Cost');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `product_category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `quantity_sold` SET TAGS ('dbx_business_glossary_term' = 'Quantity Sold');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_value_regex' = '^SO[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `str_contribution` SET TAGS ('dbx_business_glossary_term' = 'Sell-Through Rate (STR) Contribution');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `tariff_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Percentage');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `total_ldp_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Landed Duty Paid (LDP) Cost');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Period Close ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Close Owner Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `accrual_posting_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Posting Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `accrual_posting_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `blocked_steps` SET TAGS ('dbx_business_glossary_term' = 'Blocked Steps');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `checklist_template_code` SET TAGS ('dbx_business_glossary_term' = 'Checklist Template Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `close_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Close Completion Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `close_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Close Start Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `close_status` SET TAGS ('dbx_business_glossary_term' = 'Close Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `close_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|complete|blocked|reopened');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `close_type` SET TAGS ('dbx_business_glossary_term' = 'Close Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `close_type` SET TAGS ('dbx_value_regex' = 'operational|statutory|management|consolidation');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `cogs_recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Recognition Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `cogs_recognition_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `completed_steps` SET TAGS ('dbx_business_glossary_term' = 'Completed Steps');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `depreciation_run_status` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `depreciation_run_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `intercompany_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Reconciliation Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `intercompany_reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `period_lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Period Lock Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|special');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `planned_close_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Close Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `reopen_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Reopen Approved By');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `reopen_reason` SET TAGS ('dbx_business_glossary_term' = 'Reopen Reason');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `reopen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reopen Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `revenue_recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `revenue_recognition_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `sign_off_approver_email` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Approver Email Address');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `sign_off_approver_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `sign_off_approver_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `sign_off_approver_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `sign_off_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Approver Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `statutory_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Statutory Reporting Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `statutory_reporting_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `total_checklist_steps` SET TAGS ('dbx_business_glossary_term' = 'Total Checklist Steps');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ALTER COLUMN `variance_explanation` SET TAGS ('dbx_business_glossary_term' = 'Variance Explanation');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `account_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `cash_pool_header_bank_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `account_closing_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closing Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `account_opening_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opening Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `account_purpose_description` SET TAGS ('dbx_business_glossary_term' = 'Account Purpose Description');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|blocked|dormant');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'operating|payroll|letter_of_credit|cash_pooling|escrow|transit');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `available_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Balance Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `available_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Bank Address Line 1');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Bank Address Line 2');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_city` SET TAGS ('dbx_business_glossary_term' = 'Bank City');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_key` SET TAGS ('dbx_business_glossary_term' = 'Bank Key');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_state_province` SET TAGS ('dbx_business_glossary_term' = 'Bank State or Province');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `cash_pooling_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cash Pooling Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `current_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Balance Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `current_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `house_bank_code` SET TAGS ('dbx_business_glossary_term' = 'House Bank Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `house_bank_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percentage');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Bank Statement Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `lc_facility_indicator` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Facility Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `lc_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Limit Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `lc_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `minimum_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `payment_method_supported` SET TAGS ('dbx_business_glossary_term' = 'Payment Methods Supported');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `relationship_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Bank Relationship Manager Email Address');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `relationship_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `relationship_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `relationship_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `relationship_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Relationship Manager Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `relationship_manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Bank Relationship Manager Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `relationship_manager_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `relationship_manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Bank Identifier Code (BIC)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `consolidation_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `reversed_entry_consolidation_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Consolidation Entry Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Source Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `reversal_consolidation_entry_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_business_glossary_term' = 'Accounting Principle');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_value_regex' = 'IFRS|GAAP|LOCAL_GAAP|STATUTORY');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|wholesale|ecommerce|dtc|outlet');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `consolidation_group_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `consolidation_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Unit Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit Credit Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `elimination_method` SET TAGS ('dbx_business_glossary_term' = 'Elimination Method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `elimination_method` SET TAGS ('dbx_value_regex' = 'full_elimination|proportional_elimination|equity_method|cost_method');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `entry_amount` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `entry_description` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Description');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|posted|reversed|rejected');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'intercompany_elimination|currency_translation|minority_interest|fair_value_adjustment|goodwill_impairment|consolidation_adjustment');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_value_regex' = 'spot|average|closing|historical');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `minority_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minority Interest Percentage');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Notes');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `target_company_code` SET TAGS ('dbx_business_glossary_term' = 'Target Company Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` SET TAGS ('dbx_subdomain' = 'transaction_recording');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `letter_of_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `amended_letter_of_credit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `advising_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Advising Bank Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `advising_bank_swift_code` SET TAGS ('dbx_business_glossary_term' = 'Advising Bank SWIFT Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `advising_bank_swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `advising_bank_swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `advising_bank_swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `applicant_address` SET TAGS ('dbx_business_glossary_term' = 'Applicant Address');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `applicant_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `applicant_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `applicant_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `applicant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `applicant_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `available_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `beneficiary_address` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Address');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `beneficiary_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `beneficiary_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `charges_account` SET TAGS ('dbx_business_glossary_term' = 'Charges Account');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `charges_account` SET TAGS ('dbx_value_regex' = 'applicant|beneficiary|shared');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `confirming_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Confirming Bank Name');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `document_requirements` SET TAGS ('dbx_business_glossary_term' = 'Document Requirements');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `goods_description` SET TAGS ('dbx_business_glossary_term' = 'Goods Description');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Code');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Issue Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `latest_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Latest Shipment Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `lc_amount` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `lc_number` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Number');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `lc_status` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `lc_type` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Type');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `lc_type` SET TAGS ('dbx_value_regex' = 'irrevocable|revocable|confirmed|unconfirmed|transferable|standby');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `partial_shipment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Partial Shipment Allowed');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'sight|deferred|usance|acceptance');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `port_of_discharge` SET TAGS ('dbx_business_glossary_term' = 'Port of Discharge');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `port_of_loading` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `presentation_period_days` SET TAGS ('dbx_business_glossary_term' = 'Presentation Period Days');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `revolving_flag` SET TAGS ('dbx_business_glossary_term' = 'Revolving Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `tenor_days` SET TAGS ('dbx_business_glossary_term' = 'Tenor Days');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Percentage');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `transferable_flag` SET TAGS ('dbx_business_glossary_term' = 'Transferable Flag');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `transshipment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Transshipment Allowed');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ALTER COLUMN `utilized_amount` SET TAGS ('dbx_business_glossary_term' = 'Utilized Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` SET TAGS ('dbx_association_edges' = 'finance.cost_center,sustainability.sustainability_initiative');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ALTER COLUMN `cost_center_initiative_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Initiative Participation ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Initiative Participation - Cost Center Id');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Initiative Participation - Sustainability Initiative Id');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ALTER COLUMN `sustainability_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative ID');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ALTER COLUMN `actual_carbon_reduction_mt_co2e` SET TAGS ('dbx_business_glossary_term' = 'Actual Carbon Reduction (mtCO2e)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ALTER COLUMN `actual_energy_savings_mwh` SET TAGS ('dbx_business_glossary_term' = 'Actual Energy Savings (MWh)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ALTER COLUMN `actual_water_savings_m3` SET TAGS ('dbx_business_glossary_term' = 'Actual Water Savings (m³)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ALTER COLUMN `allocated_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Investment Amount');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ALTER COLUMN `cost_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Participation End Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ALTER COLUMN `initiative_phase` SET TAGS ('dbx_business_glossary_term' = 'Initiative Phase');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Participation Notes');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ALTER COLUMN `participation_role` SET TAGS ('dbx_business_glossary_term' = 'Participation Role');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Start Date');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`allocation_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`allocation_cycle` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Identifier');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `prior_allocation_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `total_allocation_amount` SET TAGS ('dbx_confidential' = 'true');
