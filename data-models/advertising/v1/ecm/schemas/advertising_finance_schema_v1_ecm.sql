-- Schema for Domain: finance | Business: Advertising | Version: v1_ecm
-- Generated on: 2026-05-08 02:28:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`finance` COMMENT 'Corporate financial domain managing agency billing, revenue recognition, client invoicing, media cost reconciliation, and P&L reporting. Owns budget allocations, cost centers, general ledger entries, EBITDA tracking, vendor payables, payment terms, margin analysis, and financial reporting for campaigns and accounts. Integrates with SAP S/4HANA FI/CO and Mediaocean Prisma billing.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center record. Primary key.',
    `parent_cost_center_id` BIGINT COMMENT 'Reference to the parent cost center in a hierarchical cost center structure. Enables roll-up reporting and multi-level budget consolidation. Null for top-level cost centers.',
    `allocation_method` STRING COMMENT 'The method used to allocate costs from this cost center to other cost objects or client accounts. Direct allocation assigns costs explicitly, activity-based uses cost drivers, headcount allocates by employee count, revenue allocates by revenue contribution, square footage by physical space, and Full-Time Equivalent (FTE) by staffing levels.. Valid values are `direct|activity_based|headcount|revenue|square_footage|fte`',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'The total approved budget amount allocated to this cost center for the fiscal year. Used for budget-versus-actual variance analysis and financial planning.',
    `approval_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether expenditures charged to this cost center require explicit approval before posting. True indicates approval workflow is enforced; false indicates automatic posting.',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which expenditures charged to this cost center require additional approval. Amounts below this threshold may be auto-approved based on delegation rules.',
    `billable_flag` BOOLEAN COMMENT 'Boolean indicator of whether costs incurred in this cost center are directly billable to clients. True indicates billable work; false indicates non-billable overhead or internal support.',
    `budget_owner_email` STRING COMMENT 'The email address of the budget owner for communication regarding budget approvals, variance reporting, and financial planning.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `budget_owner_name` STRING COMMENT 'The name of the individual responsible for managing and approving the budget for this cost center. Typically a department head, practice leader, or senior manager.',
    `company_code` STRING COMMENT 'The company code or legal entity identifier to which this cost center belongs. Used for multi-entity financial consolidation and reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area` STRING COMMENT 'The controlling area in SAP S/4HANA CO that groups cost centers for management accounting and internal reporting purposes. A controlling area may span multiple company codes.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_category` STRING COMMENT 'High-level functional category of the cost center. Production centers create deliverables, service centers provide internal services, support centers enable operations, sales centers drive revenue, marketing centers manage campaigns, and administration centers handle corporate governance.. Valid values are `production|service|support|sales|marketing|administration`',
    `cost_center_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying the cost center in financial systems and reports. Used as the business identifier in SAP S/4HANA CO module and Mediaocean Prisma billing.. Valid values are `^[A-Z0-9]{4,12}$`',
    `cost_center_name` STRING COMMENT 'The human-readable name or title of the cost center, used for display and reporting purposes.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active centers are operational and accepting charges, inactive centers are temporarily disabled, suspended centers are under review, closed centers are permanently retired, and pending approval centers are awaiting activation.. Valid values are `active|inactive|suspended|closed|pending_approval`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center based on its function and cost allocation model. Overhead centers support general operations, billable centers track client-facing work, shared services centers provide cross-functional support, direct centers relate to revenue-generating activities, indirect centers support operations, and administrative centers manage corporate functions.. Valid values are `overhead|billable|shared_services|direct|indirect|administrative`',
    `cost_pool_flag` BOOLEAN COMMENT 'Boolean indicator of whether this cost center functions as a cost pool that aggregates costs for subsequent allocation to other cost centers or client accounts. True indicates a cost pool; false indicates a standard cost center.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was first created in the system. Used for audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this cost centers budget and expenses are denominated. Examples include USD, EUR, GBP, CAD.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this cost center configuration ceases to be effective. Null for currently active configurations. Used for historical analysis and audit trails.',
    `effective_start_date` DATE COMMENT 'The date on which this cost center configuration becomes effective and begins accepting cost allocations. Supports temporal validity and historical tracking.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this cost center configuration is applicable. Cost centers may have different configurations across fiscal years for budget planning and reporting purposes.. Valid values are `^[0-9]{4}$`',
    `last_modified_by` STRING COMMENT 'The username or identifier of the user who last modified this cost center record. Supports audit requirements and change management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was most recently updated. Used for change tracking and audit trails.',
    `location_code` STRING COMMENT 'Three-letter code identifying the primary geographic location or office where this cost center operates. Examples include NYC, LON, SFO, TOR. Used for location-based cost analysis and reporting.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the cost center. Used for documentation and knowledge transfer.',
    `overhead_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of overhead costs allocated to this cost center from shared services or administrative cost pools. Used in fully-loaded cost calculations and margin analysis.',
    `owning_department` STRING COMMENT 'The department or organizational unit that owns and manages this cost center. Examples include Creative Services, Media Planning, Account Management, Finance, Human Resources, IT, Operations.',
    `practice_group` STRING COMMENT 'The specialized practice area or service line associated with this cost center, such as Digital Marketing, Brand Strategy, Public Relations, Data Analytics, Creative Production, Media Buying.',
    `profit_and_loss_responsibility_flag` BOOLEAN COMMENT 'Boolean indicator of whether this cost center has direct profit and loss accountability. True indicates the center is a profit center with revenue and expense responsibility; false indicates a pure cost center.',
    `quarterly_budget_amount` DECIMAL(18,2) COMMENT 'The budget amount allocated to this cost center for the current quarter. Supports quarterly business review (QBR) processes and short-term financial management.',
    `sap_co_cost_center_reference` STRING COMMENT 'The corresponding cost center identifier in the SAP S/4HANA Controlling (CO) module. Used for integration and reconciliation between the lakehouse and the source ERP system.. Valid values are `^[A-Z0-9]{10}$`',
    `created_by` STRING COMMENT 'The username or identifier of the user who created this cost center record. Supports audit requirements and accountability.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Master record for agency cost centers used to allocate and track expenditures across departments, practice groups, and client accounts. Captures cost center code, name, type (overhead, billable, shared services), owning department, P&L responsibility flag, budget owner, SAP CO cost center reference, active status, and fiscal year applicability. Serves as the foundational organizational unit for management accounting, budget-vs-actual reporting, and overhead allocation in SAP S/4HANA CO module.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the general ledger account. Primary key for the GL account master data.',
    `account_code` STRING COMMENT 'The externally-known unique account number used in financial transactions and reporting. Typically a 4-10 digit numeric code aligned to the chart of accounts structure.. Valid values are `^[0-9]{4,10}$`',
    `account_description_long` STRING COMMENT 'Extended description or explanatory text for the general ledger account, providing additional context, usage guidelines, or business rules for posting.',
    `account_group` STRING COMMENT 'The hierarchical grouping or category within the chart of accounts (e.g., Current Assets, Operating Expenses, Client Revenue). Used for rollup and reporting.',
    `account_name` STRING COMMENT 'The human-readable name or title of the general ledger account (e.g., Media Costs - Digital, Client Revenue - Retainer, Salaries and Wages).',
    `account_type` STRING COMMENT 'The fundamental accounting classification of the account: asset, liability, equity, revenue, or expense. Determines the accounts role in the balance sheet or profit and loss statement.. Valid values are `asset|liability|equity|revenue|expense`',
    `balance_sheet_classification` STRING COMMENT 'The detailed balance sheet classification for asset, liability, and equity accounts: current asset, non-current asset, current liability, non-current liability, equity, or not applicable (for P&L accounts).. Valid values are `current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable`',
    `chart_of_accounts` STRING COMMENT 'The chart of accounts identifier to which this account belongs. Defines the account structure and numbering scheme for the organization or group.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code` STRING COMMENT 'The SAP company code (legal entity identifier) to which this account belongs. Supports multi-entity chart of accounts with company-specific configurations.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_group` STRING COMMENT 'The consolidation grouping code used for corporate group financial consolidation and elimination entries. Aligns accounts across legal entities for consolidated reporting.',
    `cost_center_applicable` BOOLEAN COMMENT 'Indicates whether this account requires cost center assignment for expense tracking and allocation. True if cost center is mandatory for postings to this account.',
    `cost_element` STRING COMMENT 'The cost element code linking this GL account to the controlling (CO) module for cost center and internal order tracking. Used for management accounting and margin analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this general ledger account record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the accounts local currency (e.g., USD, EUR, GBP). Determines the currency in which balances are maintained.. Valid values are `^[A-Z]{3}$`',
    `field_status_group` STRING COMMENT 'The field status group code that controls which fields are required, optional, or hidden when posting to this account. Enforces data entry rules at the account level.',
    `financial_statement_category` STRING COMMENT 'The primary financial statement to which this account belongs: balance sheet, income statement (P&L), cash flow statement, or statement of equity.. Valid values are `balance_sheet|income_statement|cash_flow|equity`',
    `gaap_mapping` STRING COMMENT 'The US GAAP account classification or line item code to which this account maps for GAAP-compliant financial reporting.',
    `gl_account_status` STRING COMMENT 'The current lifecycle status of the general ledger account: active (in use), inactive (not in use but retained), pending (awaiting approval), or archived (historical only).. Valid values are `active|inactive|pending|archived`',
    `ifrs_mapping` STRING COMMENT 'The IFRS account classification or line item code to which this account maps for IFRS-compliant financial reporting.',
    `line_item_display` BOOLEAN COMMENT 'Indicates whether individual line items (journal entry details) are stored and displayed for this account. True if line-item reporting is enabled; false if only totals are maintained.',
    `modified_by` STRING COMMENT 'The username or identifier of the user who last modified this general ledger account record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this general ledger account record was last modified in the system.',
    `open_item_management` BOOLEAN COMMENT 'Indicates whether this account uses open item management for tracking and clearing individual postings (e.g., invoices, payments). True if open item clearing is required.',
    `pl_classification` STRING COMMENT 'The detailed profit and loss classification for revenue and expense accounts: operating revenue, non-operating revenue, cost of sales, operating expense, non-operating expense, or not applicable (for balance sheet accounts).. Valid values are `operating_revenue|non_operating_revenue|cost_of_sales|operating_expense|non_operating_expense|not_applicable`',
    `posting_blocked` BOOLEAN COMMENT 'Indicates whether direct postings to this account are currently blocked. True if the account is locked for new transactions (e.g., during period close or account deactivation).',
    `profit_center_applicable` BOOLEAN COMMENT 'Indicates whether this account requires profit center assignment for P&L segmentation and profitability analysis. True if profit center is mandatory for postings to this account.',
    `reconciliation_account` BOOLEAN COMMENT 'Indicates whether this is a reconciliation account (control account) that summarizes subledger balances (e.g., accounts receivable, accounts payable, vendor accounts). True if this account is managed by a subledger.',
    `sort_key` STRING COMMENT 'The sort key or allocation field used for automatic assignment of posting keys, document numbers, or payment terms during transaction entry.',
    `tax_category` STRING COMMENT 'The tax category or tax code applicable to this account for automatic tax calculation and reporting (e.g., VAT Standard, Sales Tax Exempt, Input Tax).',
    `valid_from_date` DATE COMMENT 'The date from which this general ledger account is valid and available for use in financial transactions. Supports time-dependent account structures.',
    `valid_to_date` DATE COMMENT 'The date until which this general ledger account is valid. Null if the account is open-ended. Used for account retirement and historical tracking.',
    `created_by` STRING COMMENT 'The username or identifier of the user who created this general ledger account record in the system.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'General ledger chart of accounts master for the agency, aligned to SAP S/4HANA FI module. Captures account code, account name, account type (asset, liability, equity, revenue, expense), financial statement category, P&L vs balance sheet classification, cost element linkage, currency, consolidation group, IFRS/GAAP mapping, and active status. Serves as the SSOT for all ledger account definitions used in journal entries, billing, and financial reporting.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`finance_budget` (
    `finance_budget_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Advertising budgets are allocated by brand for brand-level P&L tracking and investment analysis. Brand managers require brand_profile attribution to measure ROI and spending against brand-specific tar',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this budget is allocated to, if applicable.',
    `client_brief_id` BIGINT COMMENT 'Foreign key linking to client.client_brief. Business justification: Client briefs define campaign objectives, budgets, and deliverables that directly drive budget creation and allocation in advertising operations. Budget planning starts with approved client briefs spe',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center this budget is allocated to for internal financial tracking.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Budget references GL account via natural key (gl_account_code). Adding surrogate key FK gl_account_id enables proper referential integrity. Remove redundant gl_account_code as it can be retrieved via ',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: SOWs define the scope and budget for client engagements; finance creates budgets based on SOW commitments for spend control and forecasting.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Amount of the budget that has been allocated or committed to specific activities or sub-budgets, but not yet spent.',
    `approval_date` DATE COMMENT 'Date when the budget was officially approved by the authorized approver.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the budget: draft (being prepared), pending (awaiting approval), approved (authorized for use), rejected (not approved), cancelled (voided).. Valid values are `draft|pending|approved|rejected|cancelled`',
    `approved_amount` DECIMAL(18,2) COMMENT 'The total approved budget amount in the specified currency. This is the baseline for spend authorization and variance analysis.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the budget.',
    `budget_category` STRING COMMENT 'High-level financial category of the budget: operating (day-to-day operational expenses), capital (long-term asset investments), project (specific project-based allocation), discretionary (flexible spend allocation).. Valid values are `operating|capital|project|discretionary`',
    `budget_description` STRING COMMENT 'Detailed description of the budget purpose, scope, and any special conditions or notes.',
    `budget_name` STRING COMMENT 'Descriptive name of the budget for easy identification and reporting purposes.',
    `budget_number` STRING COMMENT 'Externally-known unique business identifier for the budget record, used for reference in financial documents and approvals.. Valid values are `^[A-Z0-9]{6,20}$`',
    `budget_type` STRING COMMENT 'Classification of the budget by its purpose: campaign (client campaign spend), overhead (agency operational costs), media (media buying allocation), production (creative production costs), talent (talent and usage rights fees), creative (creative development costs).. Valid values are `campaign|overhead|media|production|talent|creative`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the approved budget amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this budget expires and spend authorization ends. Nullable for open-ended budgets.',
    `effective_start_date` DATE COMMENT 'Date when this budget becomes effective and spend authorization begins.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year this budget applies to, typically 1-12 for monthly periods or 1-4 for quarterly periods.',
    `fiscal_year` STRING COMMENT 'The fiscal year this budget applies to, represented as a four-digit year (e.g., 2024).',
    `lock_status` BOOLEAN COMMENT 'Indicates whether the budget is locked (true) and cannot be modified, or unlocked (false) and can still be edited. Locked budgets are typically final versions used for variance reporting.',
    `mediaocean_prisma_budget_reference` STRING COMMENT 'Reference identifier to the corresponding budget record in Mediaocean Prisma for media planning and billing reconciliation.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this budget record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was last modified.',
    `owner` STRING COMMENT 'Name or identifier of the individual or role responsible for managing and authorizing spend against this budget.',
    `profit_center_code` STRING COMMENT 'Profit center code in SAP S/4HANA CO for Profit and Loss (P&L) reporting and margin analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `remaining_amount` DECIMAL(18,2) COMMENT 'Remaining unspent budget amount, calculated as approved amount minus spent amount and allocated amount.',
    `revision_number` STRING COMMENT 'Sequential revision number tracking how many times this budget has been revised. Original budget is revision 0.',
    `revision_reason` STRING COMMENT 'Business justification or reason for the most recent budget revision.',
    `sap_co_internal_order` STRING COMMENT 'Reference to the SAP S/4HANA CO internal order number used for cost collection and budget control in the ERP system.. Valid values are `^[A-Z0-9]{6,12}$`',
    `spent_amount` DECIMAL(18,2) COMMENT 'Actual amount spent against this budget to date, used for budget-vs-actual variance analysis.',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'Acceptable variance threshold as a percentage of the approved budget. Exceeding this threshold triggers alerts or requires additional approval.',
    `version` STRING COMMENT 'Version status of the budget: original (initial approved budget), revised (updated after changes), final (locked final version), forecast (projected budget for planning).. Valid values are `original|revised|final|forecast`',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this budget record.',
    CONSTRAINT pk_finance_budget PRIMARY KEY(`finance_budget_id`)
) COMMENT 'Approved financial budget records for campaigns, accounts, cost centers, and agency operations, serving as the control baseline for spend authorization and variance analysis. Captures budget version (original, revised, final), budget type (campaign, overhead, media, production, talent), fiscal year, fiscal period, approved amount, currency, budget owner, approval status, approval date, lock status, SAP CO internal order reference, and Mediaocean Prisma budget reference. Supports budget-vs-actual reporting, EBITDA tracking, and financial governance processes.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique identifier for the budget line item. Primary key for the budget line entity.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Budget line items specify which brand they support for granular brand-level cost tracking. Essential for brand profitability analysis, brand investment reporting, and allocating shared campaign costs ',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this budget line supports. Enables campaign-level budget tracking and reconciliation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget lines are allocated to cost centers for granular expense tracking. Currently references via natural key (cost_center_code). Adding cost_center_id FK enables proper joins and removes redundant c',
    `finance_budget_id` BIGINT COMMENT 'Reference to the parent budget that this line item belongs to. Links to the master budget allocation.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Budget line items reference GL accounts for detailed cost tracking. Adding gl_account_id FK provides referential integrity. Remove redundant gl_account_code.',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Budget lines track against insertion orders for spend monitoring and budget consumption analysis in financial planning.',
    `plan_line_id` BIGINT COMMENT 'Foreign key linking to media.media_plan_line. Business justification: Budget lines allocated to plan lines for detailed budget management and plan-to-actual variance tracking in media planning.',
    `scope_item_id` BIGINT COMMENT 'Foreign key linking to contract.scope_item. Business justification: Scope items map to budget line items for detailed cost tracking, variance analysis, and scope change management.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier associated with this budget line spend. Links to vendor master data for payment processing and reconciliation.',
    `actual_spend` DECIMAL(18,2) COMMENT 'The actual amount spent to date against this budget line, including invoiced and paid expenses. Used for budget variance analysis and burn rate tracking.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The original approved budget amount allocated to this line item at the time of budget creation. Represents the baseline budget before any revisions.',
    `approval_status` STRING COMMENT 'Current approval workflow status of this budget line. Controls whether the line can be committed or spent against.. Valid values are `draft|pending_approval|approved|rejected|revised`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this budget line. Provides audit trail for budget authorization and accountability.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line was approved. Critical for audit trail and compliance with financial controls.',
    `billing_category` STRING COMMENT 'Classification of how this budget line will appear on client invoices. Aligns with industry-standard billing practices and client contract terms.. Valid values are `working_media|non_working_media|production|fee|pass_through`',
    `channel_type` STRING COMMENT 'The media channel or platform type this budget line is allocated to. Supports channel-level budget analysis and Return on Ad Spend (ROAS) optimization. [ENUM-REF-CANDIDATE: digital|tv|radio|print|ooh|social|search|programmatic|ctv|ott — 10 candidates stripped; promote to reference product]',
    `committed_amount` DECIMAL(18,2) COMMENT 'The amount of budget that has been committed through Insertion Orders (IO), contracts, or purchase orders but not yet invoiced or paid. Represents encumbered funds.',
    `cost_category` STRING COMMENT 'Classification of the budget line by cost type. Determines how the expense is categorized in financial reporting and Profit and Loss (P&L) statements. [ENUM-REF-CANDIDATE: media|creative_production|talent|technology|research|overhead|contingency — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was first created in the system. Provides audit trail for budget lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget line. Supports multi-currency budget management and consolidation.. Valid values are `^[A-Z]{3}$`',
    `flight_end_date` DATE COMMENT 'The end date of the campaign flight or phase that this budget line covers. Defines the conclusion of the budget period for spend reconciliation.',
    `flight_start_date` DATE COMMENT 'The start date of the campaign flight or phase that this budget line covers. Defines the beginning of the budget period for spend tracking.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this budget line is currently active and available for spending. Inactive lines are retained for historical reporting but cannot be spent against.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this budget line represents costs that will be billed to the client or absorbed as agency overhead. Critical for margin analysis and client invoicing.',
    `line_description` STRING COMMENT 'Detailed textual description of what this budget line covers, including scope, deliverables, and any special conditions or assumptions.',
    `line_number` STRING COMMENT 'Sequential line number within the parent budget. Used for ordering and referencing specific line items in budget documentation.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied to cost for client billing. Used to calculate gross margin and agency revenue on pass-through costs.',
    `modified_by` STRING COMMENT 'Identifier of the user who last modified this budget line record. Provides audit trail for all budget changes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was last updated. Critical for change tracking and data freshness validation.',
    `notes` STRING COMMENT 'Free-form notes and comments about this budget line. Captures assumptions, constraints, dependencies, or special instructions for budget execution.',
    `revised_amount` DECIMAL(18,2) COMMENT 'The current approved budget amount after any revisions, amendments, or reforecasts. Reflects the most up-to-date budget allocation for this line.',
    `revision_number` STRING COMMENT 'Sequential version number tracking how many times this budget line has been revised. Supports change management and audit requirements.',
    `revision_reason` STRING COMMENT 'Textual explanation for why this budget line was revised. Required for financial governance and Quarterly Business Review (QBR) reporting.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The absolute difference between revised budget amount and actual spend. Positive values indicate under-spend, negative values indicate over-spend.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance amount expressed as a percentage of the revised budget. Key Performance Indicator (KPI) for budget management and financial control.',
    `created_by` STRING COMMENT 'Identifier of the user who created this budget line record. Supports accountability and audit requirements.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Granular line-item breakdown of approved budgets, enabling detailed tracking of spend by campaign flight, media channel, creative production phase, or cost category. Captures parent budget reference, line description, cost category, channel type, flight start/end dates, allocated amount, revised amount, committed amount, actual spend to date, variance amount, variance percentage, and approval status. Feeds margin analysis and P&L reporting at the campaign and account level.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`client_invoice` (
    `client_invoice_id` BIGINT COMMENT 'Unique identifier for the client invoice record. Primary key for the client invoice entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client advertiser account being invoiced. Links invoice to the client master record.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Agency invoices to multi-brand clients are structured by brand for brand-level billing and revenue tracking. Required for brand P&L reporting, brand profitability analysis, and client billing reconcil',
    `click_event_id` BIGINT COMMENT 'Foreign key linking to performance.click_event. Business justification: CPC invoicing bills for delivered clicks; invoice validation requires linking billed amounts to actual click event data.',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.insertion_order. Business justification: IOs are invoiced to clients; finance links invoices back to the authorizing IO for reconciliation and payment tracking. Replaces denormalized io_reference_number.',
    `conversion_event_id` BIGINT COMMENT 'Foreign key linking to performance.conversion_event. Business justification: Performance-based invoicing bills for delivered conversions (CPL/CPA contracts); invoice validation requires conversion event evidence.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Client invoices are attributed to cost centers for revenue tracking and P&L allocation. Adding cost_center_id FK replaces natural key reference (cost_center_code).',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Client invoices bill against insertion orders - fundamental billing relationship linking revenue recognition to media commitments in agency billing.',
    `performance_kpi_target_id` BIGINT COMMENT 'Foreign key linking to performance.performance_kpi_target. Business justification: Performance-based invoicing validates delivery against contractual KPI targets; billing adjustments require linking to target definitions.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: SOWs are the contractual basis for client invoicing; invoice lines reference SOW terms and deliverables. Replaces denormalized sow_reference_number with proper FK.',
    `video_completion_event_id` BIGINT COMMENT 'Foreign key linking to performance.video_completion_event. Business justification: CPCV invoicing bills for video completions; invoice validation requires linking billed amounts to completion event data.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Additional adjustments applied to the invoice (credits, surcharges, reconciliation adjustments). Can be positive or negative.',
    `amount_outstanding` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the invoice. Calculated as total_amount minus amount_paid. Zero when invoice is fully paid.',
    `amount_paid` DECIMAL(18,2) COMMENT 'Total amount received from the client against this invoice. Used to track partial payments and calculate outstanding balance.',
    `approved_by` STRING COMMENT 'Name or identifier of the agency employee who approved the invoice for issuance. Used for internal approval audit trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice was approved for issuance. Marks transition from draft to issued status.',
    `billing_contact_email` STRING COMMENT 'Email address of the billing contact for invoice delivery and payment correspondence. Primary communication channel for accounts receivable.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'Name of the client contact responsible for invoice receipt and payment processing. Used for invoice delivery and payment follow-up.',
    `billing_period_end_date` DATE COMMENT 'End date of the period covered by this invoice. Defines the scope of services or media placements included in the billing cycle.',
    `billing_period_start_date` DATE COMMENT 'Start date of the period covered by this invoice. Relevant for retainer billing, subscription services, and time-based billing.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice record was first created in the system. Audit field for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice (e.g., USD, EUR, GBP). Defines the monetary unit for all amounts.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the invoice. May include volume discounts, early payment discounts, or negotiated rate reductions.',
    `dispute_date` DATE COMMENT 'Date when the client raised a dispute on this invoice. Used for dispute aging and resolution tracking.',
    `dispute_reason` STRING COMMENT 'Reason provided by client for disputing the invoice. Populated when invoice_status is disputed. Used for dispute resolution tracking.',
    `due_date` DATE COMMENT 'Date by which payment is expected from the client based on agreed payment terms. Used for accounts receivable aging and collections management.',
    `invoice_date` DATE COMMENT 'Date the invoice was issued to the client. Used for revenue recognition timing and aging analysis.',
    `invoice_notes` STRING COMMENT 'Free-text notes or special instructions related to the invoice. May include payment instructions, billing clarifications, or client-specific requirements.',
    `invoice_number` STRING COMMENT 'Externally-visible unique invoice number issued to the client. Used for client communication, payment reference, and accounts receivable tracking.. Valid values are `^INV-[0-9]{8,12}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice: draft (not yet finalized), issued (approved for sending), sent (delivered to client), partially_paid (payment in progress), paid (fully settled), overdue (past due date), disputed (under client review), cancelled (voided). [ENUM-REF-CANDIDATE: draft|issued|sent|partially_paid|paid|overdue|disputed|cancelled — 8 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on billing model: retainer (recurring fee), project (fixed scope), media (placement costs), production (creative development), pass_through (third-party costs), or adjustment (credit/debit memo).. Valid values are `retainer|project|media|production|pass_through|adjustment`',
    `mediaocean_billing_reference` STRING COMMENT 'Reference identifier from Mediaocean Prisma billing system for media cost reconciliation and invoice generation. Links to media buy billing records.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice record was last modified. Audit field for change tracking and data lineage.',
    `payment_method` STRING COMMENT 'Expected or preferred payment method for this invoice: wire transfer, ACH (Automated Clearing House), check, credit card, or direct debit.. Valid values are `wire_transfer|ach|check|credit_card|direct_debit`',
    `payment_received_date` DATE COMMENT 'Date when full or final payment was received from the client. Null if invoice is unpaid or partially paid.',
    `payment_terms` STRING COMMENT 'Agreed payment terms defining when payment is due: net_15 (15 days), net_30 (30 days), net_45 (45 days), net_60 (60 days), net_90 (90 days), due_on_receipt (immediate), custom (non-standard terms). [ENUM-REF-CANDIDATE: net_15|net_30|net_45|net_60|net_90|due_on_receipt|custom — 7 candidates stripped; promote to reference product]',
    `purchase_order_number` STRING COMMENT 'Client purchase order number required for invoice processing. Many clients require PO reference for accounts payable approval.',
    `revenue_recognition_date` DATE COMMENT 'Date when revenue from this invoice is recognized in financial statements. May differ from invoice date based on revenue recognition rules.',
    `sap_fi_document_number` STRING COMMENT 'SAP S/4HANA FI document number for the accounting entry created from this invoice. Links invoice to general ledger posting.',
    `sent_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice was sent to the client. Used for tracking invoice delivery and aging calculations.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before taxes, discounts, or adjustments. Sum of all line item charges.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice (sales tax, VAT, GST). Calculated based on jurisdiction and tax rules.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total amount due from the client. Calculated as subtotal + tax - discount + adjustment. This is the amount the client must pay.',
    CONSTRAINT pk_client_invoice PRIMARY KEY(`client_invoice_id`)
) COMMENT 'Authoritative record of invoices issued by the agency to advertising clients for services rendered, media placements, and production work. Captures invoice number, invoice date, due date, billing period, client account reference, SOW/IO reference, invoice type (retainer, project, media, production), line item summary, subtotal, tax amount, total amount, currency, payment terms (net 30/60/90), payment status, SAP FI document number, and Mediaocean Prisma billing reference. Core to revenue recognition and accounts receivable management.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key for the invoice_line product.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Invoice line items detail services/media delivered for specific brands, enabling brand-level revenue recognition and margin analysis. Critical for brand profitability reporting and allocating shared s',
    `buy_id` BIGINT COMMENT 'Foreign key linking to media.media_buy. Business justification: Invoice lines bill specific media buys for detailed cost recovery and margin calculation - essential billing granularity.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign associated with this billable line item. Links revenue to campaign performance.',
    `click_event_id` BIGINT COMMENT 'Foreign key linking to performance.click_event. Business justification: Invoice lines for CPC campaigns bill specific click volumes; delivery confirmation requires linking to click events.',
    `client_invoice_id` BIGINT COMMENT 'Reference to the parent invoice header. Links this line item to the overall client invoice.',
    `conversion_event_id` BIGINT COMMENT 'Foreign key linking to performance.conversion_event. Business justification: Invoice lines for performance campaigns bill specific conversion volumes; delivery confirmation requires linking to conversion events.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Invoice line items are allocated to cost centers for detailed revenue attribution. Currently has cost_center (STRING) natural key. Adding cost_center_id FK provides referential integrity.',
    `creative_deliverable_id` BIGINT COMMENT 'Foreign key linking to creative.creative_deliverable. Business justification: Invoice lines bill clients for specific creative deliverables. Links billing to deliverables for revenue attribution, deliverable-level profitability analysis, and reconciliation of billed vs. deliver',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Invoice line items post to GL revenue accounts. Adding gl_account_id FK replaces natural key reference (gl_account_code).',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Invoice lines reference insertion orders for billing detail, reconciliation, and revenue allocation - core billing granularity in advertising finance.',
    `media_placement_id` BIGINT COMMENT 'Reference to the specific media placement being billed. Links invoice line to media execution details.',
    `plan_line_id` BIGINT COMMENT 'Foreign key linking to media.media_plan_line. Business justification: Invoice lines reference plan lines for billing against planned spend and budget variance tracking in client billing processes.',
    `video_completion_event_id` BIGINT COMMENT 'Foreign key linking to performance.video_completion_event. Business justification: Invoice lines for video campaigns bill specific completion volumes; delivery confirmation requires linking to completion events.',
    `viewability_measurement_id` BIGINT COMMENT 'Foreign key linking to performance.viewability_measurement. Business justification: Invoice lines for viewability-guaranteed placements bill based on viewable impressions; requires linking to viewability measurement data.',
    `billing_code` STRING COMMENT 'Internal billing classification code used to categorize the type of service or cost being invoiced. Maps to agency billing taxonomy.',
    `billing_status` STRING COMMENT 'Current lifecycle status of this invoice line item. Tracks progression through billing workflow from draft to final billing. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|billed|disputed|adjusted|cancelled — 7 candidates stripped; promote to reference product]',
    `commission_amount` DECIMAL(18,2) COMMENT 'Total agency commission earned on this line item. Represents agency revenue on media pass-through costs.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'Agency commission rate applied to media costs. Standard agency markup percentage per client contract terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was first created in the system. Audit trail for record origination.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the line amount. Supports multi-currency billing for global clients.. Valid values are `^[A-Z]{3}$`',
    `delivery_confirmation_date` DATE COMMENT 'Date on which service delivery was confirmed by client or operations. Triggers revenue recognition eligibility.',
    `delivery_confirmed_flag` BOOLEAN COMMENT 'Indicates whether service delivery has been confirmed and validated. True when performance obligation is fulfilled and documented.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Absolute monetary discount applied to this line item. Reduces the line amount before tax calculation.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to this line item. Reflects negotiated client discounts, volume rebates, or promotional adjustments.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this line item is under client dispute. True when client has challenged the charge and resolution is pending.',
    `dispute_reason` STRING COMMENT 'Client-provided reason for disputing this invoice line item. Documents the nature of the billing disagreement for resolution tracking.',
    `line_amount` DECIMAL(18,2) COMMENT 'Total monetary value for this invoice line before tax. Calculated as quantity multiplied by unit rate, adjusted for discounts or markups.',
    `line_number` STRING COMMENT 'Sequential line number within the invoice. Determines the ordering and presentation sequence of line items on the invoice document.',
    `line_total` DECIMAL(18,2) COMMENT 'Total amount for this invoice line including tax. Sum of line amount and tax amount, representing the final billable value.',
    `modified_by` STRING COMMENT 'User identifier of the person or system that last modified this invoice line record. Tracks responsibility for billing changes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was last modified. Audit trail for tracking changes to billing details.',
    `notes` STRING COMMENT 'Free-form notes and comments related to this invoice line item. Captures billing instructions, special terms, or clarifications.',
    `purchase_order_number` STRING COMMENT 'Client purchase order number authorizing this expenditure. Required for client accounts payable processing and payment matching.',
    `quantity` DECIMAL(18,2) COMMENT 'Numeric quantity of units being billed. Represents impressions, hours, days, or other unit of measure depending on service type.',
    `revenue_recognition_category` STRING COMMENT 'Classification of revenue recognition status for this line item. Determines timing of revenue realization per accounting standards.. Valid values are `recognized|deferred|accrued|unbilled`',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue for this line item is recognized in the general ledger. Drives financial period allocation.',
    `service_category` STRING COMMENT 'High-level categorization of the billable service. Enables revenue analysis by service type and supports P&L reporting by business line. [ENUM-REF-CANDIDATE: media_cost|creative_production|agency_fee|strategic_planning|research_insights|technology_platform|third_party_cost — 7 candidates stripped; promote to reference product]',
    `service_description` STRING COMMENT 'Detailed narrative description of the billable service, media cost, production fee, or agency commission. Appears on the client-facing invoice document.',
    `service_end_date` DATE COMMENT 'End date of the service period being billed. Defines the completion of the performance obligation delivery window.',
    `service_start_date` DATE COMMENT 'Start date of the service period being billed. Defines the beginning of the performance obligation delivery window.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to this invoice line. Calculated based on tax code and applicable jurisdiction rates.',
    `tax_code` STRING COMMENT 'Tax classification code determining the applicable tax treatment for this line item. Maps to tax jurisdiction and rate tables.',
    `unit_of_measure` STRING COMMENT 'The unit by which quantity is measured. Defines how the billable service is quantified for pricing purposes. [ENUM-REF-CANDIDATE: impressions|clicks|hours|days|units|flat_fee|cpm|cpc|cpa — 9 candidates stripped; promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'Price per unit of measure. The rate applied to quantity to calculate the line amount before adjustments.',
    `created_by` STRING COMMENT 'User identifier of the person or system that created this invoice line record. Supports audit and accountability requirements.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual line items on a client invoice, capturing the detailed breakdown of billable services, media costs, production fees, and agency commissions. Captures invoice reference, line number, service description, billing code, quantity, unit rate, line amount, tax code, revenue recognition category, campaign reference, cost center, GL account code, and delivery confirmation flag. Enables granular revenue recognition and client billing transparency per IAB billing standards.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`vendor_payable` (
    `vendor_payable_id` BIGINT COMMENT 'Unique identifier for the vendor payable record. Primary key for the vendor payable entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client account for which this vendor expense was incurred. Supports client-level profitability analysis and budget tracking.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Media buys and vendor costs are tracked by brand to measure true brand-level profitability and cost allocation. Essential for brand P&L accuracy, brand ROI calculation, and cost reconciliation in mult',
    `buy_id` BIGINT COMMENT 'Reference to the media buy that generated this vendor payable. Links the financial liability to the underlying media purchase for campaign cost tracking and Return on Ad Spend (ROAS) analysis.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign for which this vendor cost was incurred. Enables campaign-level margin analysis and Return on Investment (ROI) calculation.',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.insertion_order. Business justification: Media IOs create vendor payables when media is delivered; finance reconciles payables against IO terms for three-way match and payment authorization.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vendor payables are attributed to cost centers for expense tracking. Adding cost_center_id FK replaces natural key reference.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Vendor payables post to GL accounts (typically accounts payable liability accounts). Adding gl_account_id FK replaces natural key reference.',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Vendor payables track against insertion orders for payment reconciliation and sequential liability management in media finance.',
    `media_placement_id` BIGINT COMMENT 'Foreign key linking to media.media_placement. Business justification: Payables reference specific placements for detailed cost tracking and delivery-based payment verification in vendor reconciliation.',
    `production_job_id` BIGINT COMMENT 'Foreign key linking to creative.production_job. Business justification: Vendor payables (freelancers, studios, post-production) are tied to specific production jobs. Links payables to jobs for job costing, vendor cost reconciliation, and production budget variance analysi',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor, publisher, production supplier, freelancer, or technology partner to whom payment is owed.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: Vendor contracts govern payment terms and amounts; payables reference the underlying contract for approval, audit, and compliance verification.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to vendor.invoice. Business justification: Vendor payables track liabilities for specific vendor invoices. Finance teams reconcile payables against vendor.invoice records for payment matching, dispute resolution, and three-way match (PO-invoic',
    `video_completion_event_id` BIGINT COMMENT 'Foreign key linking to performance.video_completion_event. Business justification: Video vendor payables reconcile against delivered completions; CPCV payment validation requires completion event evidence.',
    `viewability_measurement_id` BIGINT COMMENT 'Foreign key linking to performance.viewability_measurement. Business justification: Viewability-guaranteed vendor contracts pay only for viewable impressions; payable validation requires viewability measurement evidence.',
    `approval_date` DATE COMMENT 'The date the vendor payable was approved for payment. Marks the transition from pending review to authorized for payment processing.',
    `approved_by` STRING COMMENT 'The user identifier of the person who approved the vendor payable for payment. Required for financial controls and audit trail compliance.. Valid values are `^[A-Za-z0-9.-_]{3,50}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor payable record was first created in the system. Required for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payable amount (e.g., USD, EUR, GBP). Required for multi-currency financial reporting and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The discount amount available if payment is made by the early payment discount deadline. Supports cash management optimization through early payment incentives.',
    `discount_deadline` DATE COMMENT 'The last date by which payment must be made to qualify for the early payment discount. Used for cash flow optimization decisions.',
    `dispute_date` DATE COMMENT 'The date the payable was flagged as disputed. Used for aging analysis of unresolved disputes and vendor relationship management.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for disputing the vendor payable. Populated when payment_status is disputed. Used for vendor negotiation and dispute tracking.',
    `due_date` DATE COMMENT 'The date by which payment must be made to the vendor according to the agreed payment terms. Used for cash flow planning and aging analysis.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year in which this vendor payable is recorded. Used for period-based financial reporting and variance analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this vendor payable is recorded for financial reporting purposes. Derived from posting date and fiscal calendar configuration.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total amount owed to the vendor before any discounts or adjustments are applied. Represents the full invoice value.',
    `invoice_date` DATE COMMENT 'The date the vendor invoice was issued. This is the principal business event timestamp for the payable transaction and serves as the baseline for payment term calculations.',
    `mediaocean_payable_reference` STRING COMMENT 'The unique payable reference identifier from Mediaocean Prisma billing system. Enables reconciliation between media buying platform and financial system for media cost tracking.. Valid values are `^[A-Z0-9-]{10,30}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor payable record was last modified. Used for change tracking and audit compliance.',
    `net_amount` DECIMAL(18,2) COMMENT 'The final amount payable to the vendor after applying early payment discounts and any other adjustments. This is the actual payment amount.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the vendor payable. Used for documenting special payment instructions, reconciliation notes, or other relevant information.',
    `payable_document_number` STRING COMMENT 'The unique business document number assigned to this accounts payable record, used for tracking and reconciliation purposes.. Valid values are `^[A-Z0-9]{8,20}$`',
    `payment_date` DATE COMMENT 'The date the payment was actually made to the vendor. Null for unpaid payables. Used for cash flow reporting and payment performance analysis.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used to settle the vendor payable. ACH (Automated Clearing House) for electronic bank transfers, wire transfer for same-day payments, check for paper-based payments, credit card for card-based payments, EFT (Electronic Funds Transfer) for direct bank transfers, virtual card for single-use card payments.. Valid values are `ach|wire_transfer|check|credit_card|eft|virtual_card`',
    `payment_reference_number` STRING COMMENT 'The unique reference number assigned to the payment transaction (e.g., check number, wire confirmation number, ACH trace number). Used for payment tracking and bank reconciliation.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `payment_status` STRING COMMENT 'Current status of the vendor payment in the accounts payable lifecycle. Open indicates unpaid liability, scheduled indicates payment is queued, paid indicates payment completed, disputed indicates vendor dispute in progress, cancelled indicates payable voided, on_hold indicates payment temporarily suspended.. Valid values are `open|scheduled|paid|disputed|cancelled|on_hold`',
    `payment_terms` STRING COMMENT 'The contractual payment terms agreed with the vendor, typically expressed as net days (net_30, net_60, net_90, net_120). Determines the due date calculation from invoice date.. Valid values are `^(net_[0-9]{1,3}|due_on_receipt|prepaid|custom)$`',
    `posting_date` DATE COMMENT 'The date the vendor payable was posted to the general ledger. Determines the accounting period for financial reporting and may differ from invoice date for period-end accruals.',
    `reconciliation_status` STRING COMMENT 'Status of the three-way reconciliation process between vendor invoice, media buy order, and actual delivery. Pending indicates awaiting reconciliation, matched indicates full agreement, discrepancy indicates variance requiring investigation, resolved indicates discrepancy closed, escalated indicates dispute requiring management intervention.. Valid values are `pending|matched|discrepancy|resolved|escalated`',
    `sap_fi_document_number` STRING COMMENT 'The SAP S/4HANA FI document number for the vendor invoice posting. Links the payable to the general ledger entry and enables full financial audit trail.. Valid values are `^[0-9]{10}$`',
    `sequential_liability_flag` BOOLEAN COMMENT 'Indicates whether this payable is subject to sequential liability rules, where the agency is liable for vendor payment only after receiving payment from the client. Critical for cash flow management and risk mitigation in media buying.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount included in the vendor payable (e.g., sales tax, VAT, GST). Required for tax reporting and compliance with jurisdictional tax regulations.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of tax withheld from the vendor payment as required by tax regulations. Reduces the net payment amount and must be remitted to tax authorities.',
    CONSTRAINT pk_vendor_payable PRIMARY KEY(`vendor_payable_id`)
) COMMENT 'Accounts payable records for amounts owed by the agency to media vendors, publishers, production suppliers, freelancers, and technology partners. Captures vendor reference, payable document number, invoice date, due date, payment terms (net 30/60/90/120), gross amount, net amount, early payment discount amount, discount deadline, currency, payment status (open, scheduled, paid, disputed), SAP FI vendor invoice document number, Mediaocean Prisma payable reference, media buy reference, sequential liability flag, and reconciliation status. Supports media cost reconciliation, vendor payment processing, cash flow planning, and sequential liability management.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction record. Primary key for the payment entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client or advertiser associated with this payment. Populated for inbound AR receipts and client-related outbound payments.',
    `bank_account_id` BIGINT COMMENT 'Reference to the bank account from which the payment was debited (outbound) or to which it was credited (inbound). Links to the agencys cash management system.',
    `client_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.client_invoice. Business justification: Payments can be AR receipts from clients applied to client invoices. The existing invoice_id FK points to vendor.invoice for AP disbursements; this new FK handles client payment receipts. Enables trac',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice being settled by this payment. Links payment to the originating billing document for reconciliation.',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Payments allocated to insertion orders for cash flow tracking and payment reconciliation in media finance operations.',
    `original_payment_id` BIGINT COMMENT 'Reference to the original payment record that this payment reverses. Populated only when is_reversal is True.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor, publisher, or supplier associated with this payment. Populated for outbound AP disbursements.',
    `vendor_payable_id` BIGINT COMMENT 'Foreign key linking to finance.vendor_payable. Business justification: Payments to vendors settle vendor payables (AP liabilities). This FK links the payment to the vendor payable record it is settling, enabling AP aging and payment application tracking. The existing inv',
    `amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the payment transaction in the specified currency. Represents the total cash movement before any adjustments.',
    `approval_date` DATE COMMENT 'The date on which the payment was approved. Null if not yet approved or if approval is not required.',
    `approval_status` STRING COMMENT 'Indicates whether the payment has been approved for processing: pending approval (awaiting authorization), approved (authorized for execution), or rejected (denied by approver).. Valid values are `pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved the payment for processing. Used for audit trail and segregation of duties compliance.',
    `bank_transaction_reference` STRING COMMENT 'The unique transaction identifier assigned by the bank or payment processor. Used for bank reconciliation and dispute resolution.',
    `channel` STRING COMMENT 'The interface or channel through which the payment was initiated or received: online portal, mobile app, direct bank transfer, lockbox service, manual entry by AP/AR clerk, or API integration.. Valid values are `online_portal|mobile_app|bank_transfer|lockbox|manual_entry|api`',
    `clearing_document_number` STRING COMMENT 'The document number assigned during the clearing process in the financial system. Links payment to the clearing entry that offsets the receivable or payable.. Valid values are `^[A-Z0-9]{8,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the payment was made (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `direction` STRING COMMENT 'Indicates whether this is a payment received from a client (inbound/AR receipt) or a payment made to a vendor (outbound/AP disbursement).. Valid values are `inbound|outbound`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary value of any early payment discount or settlement discount applied to this payment. Null if no discount was taken.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the payment amount to the agencys functional currency. Null for payments in functional currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year in which this payment was recorded. Used for period-based financial reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this payment was recorded, based on the payment date. Used for financial period reporting and year-end closing.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The payment amount converted to the agencys functional currency using the exchange rate. Used for consolidated financial reporting and P&L (Profit and Loss) analysis.',
    `is_reversal` BOOLEAN COMMENT 'Boolean flag indicating whether this payment is a reversal of a previous payment transaction. True if this is a reversal entry, False otherwise.',
    `memo` STRING COMMENT 'Free-text memo or notes field providing additional context about the payment. May include invoice references, campaign details, or special instructions.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payment record was last modified. Used for change tracking and audit purposes.',
    `payee_name` STRING COMMENT 'The name of the party receiving the payment. For inbound payments, this is the agency entity. For outbound payments, this is the vendor, publisher, or supplier.',
    `payer_name` STRING COMMENT 'The name of the party making the payment. For inbound payments, this is the client or advertiser. For outbound payments, this is the agency entity.',
    `payment_date` DATE COMMENT 'The date on which the payment transaction was executed or received. This is the business event date for cash flow recognition.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to execute the payment: ACH (Automated Clearing House), wire transfer, check, credit card, debit card, or electronic transfer.. Valid values are `ach|wire|check|credit_card|debit_card|electronic_transfer`',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment: pending (initiated but not cleared), cleared (funds transferred), failed (transaction rejected), cancelled (voided before clearing), reversed (funds returned after clearing), or reconciled (matched to invoice/payable).. Valid values are `pending|cleared|failed|cancelled|reversed|reconciled`',
    `payment_type` STRING COMMENT 'Classification of the payment purpose: invoice payment (standard settlement), advance payment (prepayment), refund (return of funds), rebate (volume discount payment), commission (agency fee), or retainer (upfront fee).. Valid values are `invoice_payment|advance_payment|refund|rebate|commission|retainer`',
    `reconciliation_date` DATE COMMENT 'The date on which the payment was successfully reconciled to its corresponding invoice or bank statement. Null if not yet reconciled.',
    `reconciliation_status` STRING COMMENT 'Indicates whether the payment has been matched to its corresponding invoice, payable, or bank statement entry: unreconciled (no match), partially reconciled (partial match), fully reconciled (complete match), or disputed (discrepancy identified).. Valid values are `unreconciled|partially_reconciled|fully_reconciled|disputed`',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this payment transaction for tracking and reconciliation purposes. Used in bank statements and remittance advice.. Valid values are `^[A-Z0-9]{8,20}$`',
    `remittance_advice_reference` STRING COMMENT 'Reference number or identifier from the remittance advice document accompanying the payment. Used to match payment to specific invoices or line items.',
    `sap_payment_document_number` STRING COMMENT 'The payment document number generated in SAP S/4HANA FI module. Primary reference for integration with the ERP (Enterprise Resource Planning) system.. Valid values are `^[0-9]{10}$`',
    `terms` STRING COMMENT 'The contractual payment terms applicable to this payment (e.g., Net 30, Net 60, 2/10 Net 30). Indicates the agreed-upon payment schedule and any early payment discounts.',
    `value_date` DATE COMMENT 'The date on which the funds become available in the receiving account or are debited from the paying account. Used for cash position and liquidity management.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of tax withheld from the payment as required by tax regulations. Common for cross-border payments and vendor payments subject to withholding.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Records of actual cash payments made to vendors (AP disbursements) and received from clients (AR receipts), serving as the SSOT for all cash movement events. Captures payment reference number, payment date, payment direction (inbound/outbound), payment method (ACH, wire, check, credit card), payer/payee reference, linked invoice or payable reference, payment amount, currency, exchange rate applied, bank account reference, clearing document number, SAP FI payment document number, reconciliation status, and value date. Supports cash flow forecasting, bank reconciliation, DSO/DPO calculation, and working capital management.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record. Primary key for the journal entry entity.',
    `accrual_id` BIGINT COMMENT 'Foreign key linking to finance.accrual. Business justification: Journal entries are created to post accruals at period-end and to reverse them in subsequent periods. This FK links the JE to the accrual record it is posting or reversing, enabling audit trail and ac',
    `advertiser_id` BIGINT COMMENT 'Foreign key reference to the client (advertiser) associated with this journal entry. Used for client-level revenue recognition and billing reconciliation. Null for internal or non-client entries.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to contract.amendment. Business justification: Significant contract amendments trigger accounting adjustments via journal entries for deferred revenue, accruals, or revenue recognition changes.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Financial postings for brand-specific accruals, allocations, or adjustments require brand attribution for accurate brand P&L. Supports brand-level financial reporting, brand profitability consolidatio',
    `buy_id` BIGINT COMMENT 'Foreign key linking to media.media_buy. Business justification: Journal entries post media buy expenses for financial reporting and cost recognition in general ledger accounting.',
    `campaign_id` BIGINT COMMENT 'Foreign key reference to the advertising campaign associated with this journal entry. Used to link financial postings to campaign performance and margin analysis. Null for non-campaign-related entries.',
    `click_event_id` BIGINT COMMENT 'Foreign key linking to performance.click_event. Business justification: Click-based revenue/cost journal entries require click volume evidence for accurate financial reporting and accrual accounting.',
    `client_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.client_invoice. Business justification: Journal entries are created to record client invoices (AR receivables) in the general ledger when invoices are issued. This FK links the JE to the client invoice record it is posting, enabling AR subl',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.milestone. Business justification: Milestone completion triggers accrual reversals or revenue recognition journal entries; finance links JEs to milestones for audit trail and ASC 606 compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entries at header level may have default cost center attribution. Adding cost_center_id FK replaces natural key reference.',
    `credit_memo_id` BIGINT COMMENT 'Foreign key linking to finance.credit_memo. Business justification: Journal entries are created to post credit memos to the general ledger (both AR credits to clients and AP credits from vendors). This FK links the JE to the credit memo it is posting, enabling audit t',
    `financial_close_id` BIGINT COMMENT 'Foreign key linking to finance.financial_close. Business justification: Journal entries are posted as part of financial close processes and period-end activities. This FK links the JE to the financial close period it belongs to, enabling close workflow tracking and ensuri',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Journal entry header may have primary GL account reference. Adding gl_account_id FK replaces natural key reference (gl_account_code).',
    `intercompany_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.intercompany_transaction. Business justification: Journal entries are created to record intercompany transactions between legal entities within the agency holding group. This FK links the JE to the intercompany transaction record it is posting, enabl',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Journal entries reference insertion orders for expense posting, accruals, and financial statement preparation in media accounting.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to finance.payment. Business justification: Journal entries are created to record payment transactions (both AP disbursements and AR receipts) in the general ledger. This FK links the JE to the payment record it is posting, enabling cash reconc',
    `revenue_recognition_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition. Business justification: Journal entries are created to recognize revenue per revenue recognition schedules and performance obligations. This FK links the JE to the revenue recognition record it is posting, enabling complianc',
    `vendor_payable_id` BIGINT COMMENT 'Foreign key linking to finance.vendor_payable. Business justification: Journal entries are created to record vendor payables (AP liabilities) in the general ledger when invoices are received. This FK links the JE to the vendor payable record it is posting, enabling AP su',
    `accrual_reversal_date` DATE COMMENT 'For accrual-type entries, the date on which the accrual will be automatically reversed. Typically the first day of the following fiscal period. Null for non-accrual entries.',
    `accrual_reversal_status` STRING COMMENT 'Status of the automatic reversal for accrual entries: not_applicable (non-accrual entry), pending (scheduled for reversal), reversed (reversal completed), or failed (reversal encountered an error).. Valid values are `not_applicable|pending|reversed|failed`',
    `accrual_type` STRING COMMENT 'For accrual entries, the category of accrual: expense (general operating expenses), revenue (deferred or unbilled revenue), media_cost (media buy accruals), production_cost (creative production accruals), or not_applicable (non-accrual entry).. Valid values are `expense|revenue|media_cost|production_cost|not_applicable`',
    `approved_by_user` STRING COMMENT 'User ID or name of the individual who approved this journal entry for posting. Null if no approval workflow is required or if entry is still pending approval.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry was approved for posting. Null if no approval is required or if entry is still pending approval.',
    `batch_reference` STRING COMMENT 'The batch identifier for grouped journal entries posted together in a single batch run. Used for batch-level reconciliation and error tracking.',
    `company_code` STRING COMMENT 'The legal entity or company code within the corporate structure to which this journal entry belongs. Used for multi-entity consolidation and reporting.',
    `created_by_user` STRING COMMENT 'User ID or name of the individual who created this journal entry in the accounting system. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code (e.g., USD, EUR, GBP) indicating the transaction currency for this journal entry.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date of the source document or transaction that triggered this journal entry. May differ from posting date for backdated or forward-dated entries.',
    `entry_type` STRING COMMENT 'Classification of the journal entry indicating the nature of the posting: standard (regular operational postings), accrual (period-end accruals with auto-reversal), reversal (reverses a prior entry), intercompany (cross-entity transactions), reclassification (reallocation between accounts), or adjustment (corrective postings).. Valid values are `standard|accrual|reversal|intercompany|reclassification|adjustment`',
    `estimated_amount_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the amounts in this journal entry are estimates (True) or actuals (False). Common for accruals where final invoice amounts are not yet known.',
    `fiscal_period` STRING COMMENT 'The fiscal period (e.g., 01, 02, ..., 12, or 13 for year-end adjustments) to which this journal entry is assigned. Used for period-end close and financial statement preparation.',
    `fiscal_year` STRING COMMENT 'The fiscal year (e.g., 2023, 2024) to which this journal entry belongs. Combined with fiscal_period, this determines the reporting period for financial statements.',
    `intercompany_partner_entity` STRING COMMENT 'For intercompany entries, the legal entity code or name of the counterparty entity within the corporate group. Null for non-intercompany entries.',
    `journal_entry_description` STRING COMMENT 'Free-text description providing business context for the journal entry, such as the nature of the transaction, campaign reference, or accounting rationale.',
    `journal_entry_number` STRING COMMENT 'Business-facing unique journal entry document number assigned by the accounting system. Used for external reference and audit trails.',
    `notes` STRING COMMENT 'Additional free-text notes or comments providing supplementary context, audit explanations, or special instructions related to this journal entry.',
    `original_journal_entry_number` STRING COMMENT 'For reversal-type entries, the journal entry number of the original entry being reversed. Null for non-reversal entries.',
    `posted_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry was posted to the general ledger. Null if entry is still in draft or pending approval status.',
    `posting_date` DATE COMMENT 'The date on which the journal entry was posted to the general ledger. This is the effective date for financial reporting and determines the fiscal period assignment.',
    `posting_status` STRING COMMENT 'Current lifecycle status of the journal entry: draft (not yet posted), posted (committed to the general ledger), reversed (entry has been reversed), cancelled (entry voided before posting), or pending_approval (awaiting authorization).. Valid values are `draft|posted|reversed|cancelled|pending_approval`',
    `profit_center_code` STRING COMMENT 'The profit center code for internal profitability analysis and segment reporting. Used for EBITDA tracking and P&L reporting by business unit.',
    `reclassification_reason` STRING COMMENT 'For reclassification entries, a textual explanation of why the reallocation between accounts was necessary. Null for non-reclassification entries.',
    `reference_document_number` STRING COMMENT 'External reference number linking this journal entry to a source document such as an invoice, purchase order, media insertion order (IO), or contract. Used for audit trail and reconciliation.',
    `reversal_journal_entry_number` STRING COMMENT 'The journal entry number of the reversing entry that offsets this original entry. Null if this entry has not been reversed.',
    `reversed_by_user` STRING COMMENT 'User ID or name of the individual who reversed this journal entry. Null if entry has not been reversed.',
    `reversed_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry was reversed. Null if entry has not been reversed.',
    `sap_fi_document_number` STRING COMMENT 'The native SAP S/4HANA FI document number for this journal entry, used for system-to-system reconciliation and traceability back to the source ERP system.',
    `source_system` STRING COMMENT 'The name or code of the upstream system that originated this journal entry (e.g., SAP S/4HANA, Mediaocean Prisma, Workday HCM). Used for data lineage and reconciliation.',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'The sum of all credit amounts across all line items in this journal entry. Must equal total_debit_amount per double-entry accounting principles.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'The sum of all debit amounts across all line items in this journal entry. Must equal total_credit_amount per double-entry accounting principles.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'General ledger journal entries recording all financial transactions in the agencys books per SAP S/4HANA FI, including standard postings, accruals with auto-reversal, reversals, reclassifications, and intercompany entries. Captures journal entry number, posting date, document date, fiscal period, fiscal year, entry type (standard, accrual, reversal, intercompany, reclassification), posting status, total debit amount, total credit amount, currency, reference document, accrual-specific fields (reversal date, reversal status, estimated amount flag, accrual type: expense/revenue/media cost/production cost), created by, approved by, and SAP FI document number. Serves as the SSOT for all ledger postings including period-end accruals, supporting EBITDA tracking, period-end close processes, and financial statement preparation.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for the journal entry line product.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client account associated with this line item. Supports client-level revenue recognition and margin analysis.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Individual GL line items need brand attribution for detailed brand-level financial reporting and consolidation. Required for brand P&L drill-down, brand cost allocation transparency, and supporting br',
    `buy_id` BIGINT COMMENT 'Foreign key linking to media.media_buy. Business justification: Journal entry lines post buy-level expenses for detailed GL accounting and financial statement line-item support.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign associated with this line item. Enables campaign-level cost allocation and ROI analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entry lines are allocated to cost centers for management accounting. Adding cost_center_id FK replaces natural key reference.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Every journal entry line posts to a GL account - this is the core double-entry bookkeeping relationship. Adding gl_account_id FK replaces natural key reference and removes redundant gl_account_name (r',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header. Links this line item to its containing journal entry document.',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Journal entry lines detail insertion order-level postings for granular accounting and audit trail in financial systems.',
    `reversed_line_journal_entry_line_id` BIGINT COMMENT 'Reference to the original journal entry line that this entry reverses. Null if this is not a reversal entry.',
    `assignment_reference` STRING COMMENT 'Free-text assignment field used for grouping related line items, linking to external references, or supporting reconciliation processes.',
    `baseline_date` DATE COMMENT 'Baseline date for payment terms calculation. Used to determine due dates and cash discount periods for payables and receivables.',
    `business_area_code` STRING COMMENT 'Business area for cross-company code reporting and segment analysis. Enables consolidated P&L by business line or service offering.. Valid values are `^[A-Z0-9]{4}$`',
    `clearing_date` DATE COMMENT 'Date on which this line item was cleared (matched with offsetting entry). Null for open items. Supports accounts payable and receivable reconciliation.',
    `clearing_document_number` STRING COMMENT 'Document number of the clearing entry that closed this line item. Null for open items. Links payments to invoices and supports reconciliation.. Valid values are `^[0-9]{10}$`',
    `created_by_user` STRING COMMENT 'User ID of the person who created this journal entry line. Supports audit trails, segregation of duties, and SOX compliance.. Valid values are `^[A-Z0-9_]{1,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this journal entry line record was first created in the system. Supports audit trails and data lineage tracking.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Credit amount for this line item in the transaction currency. Null or zero if the line is a debit entry.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amounts. Supports multi-currency accounting and foreign exchange reconciliation.. Valid values are `^[A-Z]{3}$`',
    `debit_amount` DECIMAL(18,2) COMMENT 'Debit amount for this line item in the transaction currency. Null or zero if the line is a credit entry.',
    `document_date` DATE COMMENT 'Date of the source document (invoice, receipt, etc.) that originated this line item. May differ from posting date for backdated or forward-dated entries.',
    `document_type` STRING COMMENT 'Two-character document type code that classifies the journal entry (e.g., SA for G/L account document, DR for customer invoice, KR for vendor invoice). Controls number ranges and posting rules.. Valid values are `^[A-Z]{2}$`',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year for this line item. Enables monthly P&L reporting and budget variance analysis.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this line item is posted. Supports period-based financial reporting and year-end closing processes.',
    `line_item_text` STRING COMMENT 'Descriptive text providing additional context for the line item. Used for audit trails, reconciliation notes, and financial statement drill-down.',
    `line_number` STRING COMMENT 'Sequential line number within the journal entry. Determines the ordering of line items within a single journal entry document.',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the company code local currency used in financial statements.. Valid values are `^[A-Z]{3}$`',
    `local_currency_credit_amount` DECIMAL(18,2) COMMENT 'Credit amount converted to the company code local currency for consolidated financial reporting and P&L analysis.',
    `local_currency_debit_amount` DECIMAL(18,2) COMMENT 'Debit amount converted to the company code local currency for consolidated financial reporting and P&L analysis.',
    `modified_by_user` STRING COMMENT 'User ID of the person who last modified this journal entry line. Supports audit trails and change management.. Valid values are `^[A-Z0-9_]{1,12}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this journal entry line record was last modified. Supports change tracking and audit compliance.',
    `payment_terms` STRING COMMENT 'Payment terms code defining due date calculation and cash discount conditions for vendor and customer line items.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'Date on which the line item is posted to the general ledger. Determines the fiscal period and affects financial statement balances.',
    `posting_key` STRING COMMENT 'Two-digit posting key that determines whether the line is a debit or credit and controls field status and account type. Standard SAP posting keys include 40 (debit GL), 50 (credit GL), 01 (debit customer), 11 (credit customer), 31 (debit vendor), 21 (credit vendor).. Valid values are `^[0-9]{2}$`',
    `profit_center_code` STRING COMMENT 'Profit center responsible for this line item. Supports P&L reporting and EBITDA tracking by business unit or client account.. Valid values are `^[A-Z0-9]{4,12}$`',
    `reference_key` STRING COMMENT 'Reference key for external system integration and cross-system reconciliation. May contain invoice numbers, purchase order numbers, or other source document identifiers.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this line item is a reversal of a previous entry. Supports audit trails and error correction processes.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount calculated for this line item in the transaction currency. Supports tax reconciliation and compliance reporting.',
    `tax_code` STRING COMMENT 'Tax code that determines the tax rate and tax account for this line item. Supports VAT, sales tax, and other jurisdiction-specific tax calculations.. Valid values are `^[A-Z0-9]{1,4}$`',
    `trading_partner_code` STRING COMMENT 'Trading partner company code for intercompany transactions. Supports elimination entries and consolidated financial statements.. Valid values are `^[A-Z0-9]{4,10}$`',
    `value_date` DATE COMMENT 'Value date for cash management and liquidity planning. Represents the effective date for interest calculation and cash flow forecasting.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit and credit line items within a general ledger journal entry. Captures journal entry reference, line number, GL account code, cost center, profit center, debit amount, credit amount, currency, posting key, assignment reference, campaign reference, tax code, and line item text. Enables drill-down from financial statements to source transactions and supports cost allocation across campaigns and accounts.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`revenue_recognition` (
    `revenue_recognition_id` BIGINT COMMENT 'Unique identifier for the revenue recognition record. Primary key for this entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client (advertiser) for whom revenue is being recognized.',
    `agreement_id` BIGINT COMMENT 'Reference to the client contract or Statement of Work (SOW) that governs this revenue recognition event.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Revenue recognition schedules are maintained by brand for multi-brand clients to support brand-level financial performance tracking. Essential for brand revenue reporting, brand profitability measurem',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign associated with this revenue recognition, if applicable.',
    `click_event_id` BIGINT COMMENT 'Foreign key linking to performance.click_event. Business justification: Performance-based contracts with click KPIs require click delivery evidence for revenue recognition under ASC 606.',
    `client_invoice_id` BIGINT COMMENT 'Reference to the client invoice associated with this revenue recognition event, if revenue has been billed.',
    `conversion_event_id` BIGINT COMMENT 'Foreign key linking to performance.conversion_event. Business justification: Performance obligations for CPA/CPL contracts depend on conversion delivery as evidence of performance obligation satisfaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue recognition is attributed to cost centers for P&L reporting. Adding cost_center_id FK replaces natural key reference.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue recognition records post to specific GL revenue accounts. Adding gl_account_id FK replaces natural key reference.',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Revenue recognized against insertion orders for agency commission and service fees - fundamental revenue accounting in advertising.',
    `performance_kpi_target_id` BIGINT COMMENT 'Foreign key linking to performance.performance_kpi_target. Business justification: Revenue recognition for performance contracts depends on meeting KPI targets; ASC 606 performance obligations require target linkage.',
    `adjustment_reason` STRING COMMENT 'Explanation for any adjustment, reversal, or correction made to the revenue recognition record. Required when recognition status is adjusted or reversed.',
    `approved_by` STRING COMMENT 'User ID or name of the finance manager or controller who approved this revenue recognition entry, ensuring compliance with ASC 606 and internal controls.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition entry was approved by the finance manager or controller.',
    `contract_reference_number` STRING COMMENT 'External business identifier for the contract or Statement of Work (SOW) document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition record was first created in the system. Part of audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this revenue recognition record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deferred_revenue_amount` DECIMAL(18,2) COMMENT 'Amount of revenue that has been billed or received but not yet recognized, representing the contract liability. Calculated as total contract value minus recognized amount to date.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year when revenue is recognized, typically 1-12 for monthly periods or 1-4 for quarterly periods.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter (1-4) within the fiscal year for quarterly business review (QBR) and financial reporting purposes.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this revenue recognition event occurs, used for financial reporting and Profit and Loss (P&L) aggregation.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this revenue recognition record is currently active (True) or has been superseded or voided (False). Used for soft deletes and historical tracking.',
    `milestone_date` DATE COMMENT 'Date when the milestone was achieved or is expected to be achieved, triggering revenue recognition for milestone-based contracts.',
    `milestone_name` STRING COMMENT 'Name or description of the milestone achieved that triggers revenue recognition, applicable when recognition method is milestone-based.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this revenue recognition record. Part of audit trail for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition record was last modified. Updated whenever any field changes. Part of audit trail for data lineage.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this revenue recognition event, including any special considerations or exceptions.',
    `percentage_complete` DECIMAL(18,2) COMMENT 'Percentage of completion for this performance obligation, used when recognition method is percentage-of-completion. Value between 0.00 and 100.00.',
    `performance_obligation_description` STRING COMMENT 'Detailed description of the specific performance obligation being fulfilled (e.g., media planning services, creative production, campaign execution, retainer services).',
    `profit_center_code` STRING COMMENT 'Profit center code in SAP S/4HANA CO for segment reporting and Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) tracking.',
    `recognition_end_date` DATE COMMENT 'Date when revenue recognition is expected to complete for this performance obligation, typically aligned with contract end date or service completion.',
    `recognition_method` STRING COMMENT 'Method used to recognize revenue for this performance obligation per accounting standards. Straight-line for retainers, milestone for project-based, percentage-of-completion for long-term campaigns, point-in-time for discrete deliverables.. Valid values are `straight_line|milestone|percentage_of_completion|point_in_time|output_method|input_method`',
    `recognition_start_date` DATE COMMENT 'Date when revenue recognition begins for this performance obligation, typically aligned with contract effective date or service commencement.',
    `recognition_status` STRING COMMENT 'Current lifecycle status of the revenue recognition record. Pending indicates not yet started, in-progress for ongoing recognition, completed when fully recognized, deferred for postponed recognition, reversed for corrections, adjusted for amendments.. Valid values are `pending|in_progress|completed|deferred|reversed|adjusted`',
    `recognized_amount_to_date` DECIMAL(18,2) COMMENT 'Cumulative revenue amount recognized to date for this performance obligation. Updated as revenue is recognized over time or at point in time.',
    `revenue_type` STRING COMMENT 'Classification of revenue stream type. Retainer for ongoing monthly fees, project for fixed-price engagements, commission for percentage-based fees, media markup for agency margin on media buys, production for creative services, consulting for advisory services, performance fee for outcome-based compensation. [ENUM-REF-CANDIDATE: retainer|project|commission|media_markup|production|consulting|performance_fee — 7 candidates stripped; promote to reference product]',
    `sap_fi_document_number` STRING COMMENT 'SAP S/4HANA FI document number for the revenue recognition posting, providing traceability to the general ledger entry.',
    `sap_fi_posting_date` DATE COMMENT 'Date when the revenue recognition entry was posted in SAP S/4HANA FI general ledger.',
    `service_line` STRING COMMENT 'Agency service line or business unit delivering the performance obligation (e.g., Media Planning, Creative Services, Digital Marketing, Account Management, Data Analytics).',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Total monetary value allocated to this specific performance obligation from the contract. Represents the transaction price allocated per ASC 606 Step 4.',
    `unbilled_revenue_amount` DECIMAL(18,2) COMMENT 'Amount of revenue recognized but not yet billed to the client, representing a contract asset or accrued revenue.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this revenue recognition record. Part of audit trail for accountability.',
    CONSTRAINT pk_revenue_recognition PRIMARY KEY(`revenue_recognition_id`)
) COMMENT 'Records governing when and how agency revenue is recognized from client contracts, retainers, and project-based engagements per ASC 606 / IFRS 15 standards. Captures contract reference, performance obligation description, recognition method (straight-line, milestone, percentage-of-completion), recognition start/end date, total contract value, recognized amount to date, deferred revenue amount, recognition status, fiscal period, and SAP FI revenue recognition document reference. Critical for accurate P&L reporting.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` (
    `media_cost_reconciliation_id` BIGINT COMMENT 'Unique identifier for the media cost reconciliation record. Primary key for this entity.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Media cost reconciliations compare planned vs actual spend by brand to ensure accurate brand-level cost accounting. Critical for brand budget variance analysis, brand profitability accuracy, and resol',
    `buy_id` BIGINT COMMENT 'Reference to the media buy that this reconciliation record pertains to. Links to the media buy master record.',
    `click_event_id` BIGINT COMMENT 'Foreign key linking to performance.click_event. Business justification: Click discrepancy reconciliation between ad server and publisher systems; financial adjustments require linking to click events.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `delivery_pacing_id` BIGINT COMMENT 'Foreign key linking to performance.delivery_pacing. Business justification: Pacing data informs reconciliation of planned vs actual delivery and spend; variance analysis requires pacing metrics.',
    `impression_event_id` BIGINT COMMENT 'Foreign key linking to performance.impression_event. Business justification: Media cost reconciliation compares planned vs actual impressions; core use case requires linking reconciliation records to actual delivery events.',
    `supplier_id` BIGINT COMMENT 'Identifier for the media vendor or publisher who provided the media inventory and submitted the invoice.',
    `vendor_payable_id` BIGINT COMMENT 'Foreign key linking to finance.vendor_payable. Business justification: Media cost reconciliations match planned media costs against actual vendor invoices and result in vendor payables being created or adjusted. This FK links the reconciliation to the resulting vendor pa',
    `viewability_measurement_id` BIGINT COMMENT 'Foreign key linking to performance.viewability_measurement. Business justification: Viewability discrepancies drive make-goods and financial adjustments; reconciliation requires linking to viewability measurement data.',
    `actual_cpm` DECIMAL(18,2) COMMENT 'The actual cost per thousand impressions calculated from billed cost and delivered impressions. Calculated as (billed_cost_amount / delivered_impressions) * 1000.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the final reconciled amount. Used for accountability and audit trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the reconciliation was formally approved for payment processing and client billing. Represents the completion of the reconciliation workflow.',
    `billed_cost_amount` DECIMAL(18,2) COMMENT 'The actual cost amount invoiced by the vendor for the media delivery. Represents the vendors claim for payment based on delivered impressions or placements.',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period covered by this reconciliation record. Defines the conclusion of the media delivery window being reconciled.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period covered by this reconciliation record. Defines the beginning of the media delivery window being reconciled.',
    `cpm_variance` DECIMAL(18,2) COMMENT 'The difference between planned CPM and actual CPM. Used to identify rate discrepancies and pricing issues.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this reconciliation record was first created in the system. Represents the start of the reconciliation lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this reconciliation record. Ensures consistent currency handling across multi-currency campaigns.. Valid values are `^[A-Z]{3}$`',
    `delivered_impressions` BIGINT COMMENT 'The actual number of impressions delivered by the vendor as confirmed by third-party ad serving platforms (Google Campaign Manager 360, DSP platforms). Used for delivery variance calculation.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether this reconciliation record is currently under dispute. True indicates active dispute; False indicates no dispute or resolved dispute.',
    `dispute_opened_date` DATE COMMENT 'Date when a dispute was formally opened for this reconciliation record. Null if no dispute has been raised.',
    `dispute_resolution_notes` STRING COMMENT 'Free-text notes documenting the dispute resolution process, including vendor communications, adjustments made, and final agreement terms.',
    `dispute_resolved_date` DATE COMMENT 'Date when the dispute was formally resolved and the reconciliation was cleared. Null if dispute is still open or no dispute was raised.',
    `gl_posting_date` DATE COMMENT 'Date when the reconciled amount was posted to the general ledger in SAP S/4HANA FI. Used for financial period closing and P&L reporting.',
    `impression_variance` BIGINT COMMENT 'The difference between planned impressions and delivered impressions. Positive values indicate over-delivery; negative values indicate under-delivery.',
    `impression_variance_percentage` DECIMAL(18,2) COMMENT 'The impression variance expressed as a percentage of planned impressions. Calculated as (impression_variance / planned_impressions) * 100. Used for delivery performance tracking.',
    `io_number` STRING COMMENT 'The insertion order number associated with this media buy. Unique identifier for the IO document authorizing the media placement.. Valid values are `^IO-[A-Z0-9]{6,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this reconciliation record was last updated. Used for change tracking and audit trail.',
    `make_good_flag` BOOLEAN COMMENT 'Boolean indicator of whether this reconciliation includes make-good impressions provided by the vendor to compensate for under-delivery or quality issues.',
    `make_good_impressions` BIGINT COMMENT 'Number of additional impressions provided by the vendor as make-good compensation. Null or zero if no make-good was provided.',
    `payment_due_date` DATE COMMENT 'Date by which payment to the vendor is due based on contract payment terms. Used for accounts payable scheduling and cash flow management.',
    `planned_cost_amount` DECIMAL(18,2) COMMENT 'The originally planned media cost as specified in the insertion order and media plan. Represents the budgeted amount for this media buy.',
    `planned_cpm` DECIMAL(18,2) COMMENT 'The planned cost per thousand impressions as negotiated in the media buy. Used as the baseline rate for cost reconciliation.',
    `planned_impressions` BIGINT COMMENT 'The number of impressions originally planned and contracted in the insertion order. Used as the baseline for delivery reconciliation.',
    `reconciled_amount` DECIMAL(18,2) COMMENT 'The final agreed-upon cost amount after reconciliation adjustments, dispute resolution, and variance analysis. This is the amount approved for payment and client billing.',
    `reconciliation_document_number` STRING COMMENT 'Unique document number generated by Mediaocean Prisma for this reconciliation transaction. Used for audit trail and cross-system reference.. Valid values are `^REC-[A-Z0-9]{8,15}$`',
    `reconciliation_status` STRING COMMENT 'Current workflow status of the reconciliation record. Tracks the lifecycle from initial variance detection through dispute resolution to final clearance and payment approval.. Valid values are `open|in_review|in_dispute|cleared|approved|rejected`',
    `third_party_verification_date` DATE COMMENT 'Date when the third-party verification data was received or confirmed. Used for audit trail and data freshness tracking.',
    `third_party_verification_source` STRING COMMENT 'Name of the third-party ad serving or verification platform that provided the delivered impressions data (e.g., Google Campaign Manager 360, The Trade Desk, Nielsen, Comscore).',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between planned cost and reconciled amount. Positive values indicate over-billing or over-delivery; negative values indicate under-delivery or cost savings.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance amount expressed as a percentage of the planned cost. Calculated as (variance_amount / planned_cost_amount) * 100. Used for threshold-based alerting and variance reporting.',
    `variance_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for the cost variance. Used for root cause analysis and vendor performance tracking.. Valid values are `under_delivery|over_delivery|rate_discrepancy|make_good|bonus_impressions|technical_issue`',
    `variance_reason_description` STRING COMMENT 'Detailed free-text explanation of the variance reason, including context, supporting evidence, and resolution notes. Provides audit trail for financial reconciliation.',
    `vendor_reference` STRING COMMENT 'External reference identifier provided by the media vendor or publisher for this billing cycle. May include invoice number or billing statement reference.',
    CONSTRAINT pk_media_cost_reconciliation PRIMARY KEY(`media_cost_reconciliation_id`)
) COMMENT 'Reconciliation records matching planned media costs (from IOs and media plans) against actual vendor invoices and third-party delivery confirmations from Mediaocean Prisma, Google Campaign Manager 360, and DSP platforms. Captures media buy reference, IO number, planned cost, billed cost, delivered impressions, reconciled amount, variance amount, variance reason (under-delivery, rate discrepancy, make-good), reconciliation status (open, in-dispute, cleared), billing period, vendor reference, and Mediaocean Prisma reconciliation document number. Core to sequential liability management and client billing integrity.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`credit_memo` (
    `credit_memo_id` BIGINT COMMENT 'Unique identifier for the credit memo record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client receiving or issuing the credit memo.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Credit memos for billing adjustments or make-goods are issued at the brand level in multi-brand client relationships. Required for accurate brand revenue tracking, brand P&L adjustments, and brand-lev',
    `buy_id` BIGINT COMMENT 'Foreign key linking to media.media_buy. Business justification: Credit memos adjust buy-level billing for underdelivery and performance issues - essential for accurate cost reconciliation.',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign associated with the credit memo adjustment.',
    `client_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.client_invoice. Business justification: Credit memos can be issued to clients (AR credits) to adjust previously billed amounts on client invoices. The existing invoice_id FK points to vendor.invoice for AP credits; this new FK handles clien',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Credit memos are attributed to cost centers for expense/revenue adjustments. Adding cost_center_id FK replaces natural key reference (cost_center_code).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Credit memos post to GL accounts for financial statement impact. Adding gl_account_id FK replaces natural key reference.',
    `invoice_id` BIGINT COMMENT 'Reference to the original invoice being adjusted by this credit memo.',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Credit memos reference insertion orders for billing adjustments, makegoods, and underdelivery credits in client billing.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor when the credit memo is received from a media supplier or publisher.',
    `vendor_payable_id` BIGINT COMMENT 'Foreign key linking to finance.vendor_payable. Business justification: Credit memos received from vendors reduce vendor payables (AP liabilities). This FK links the credit memo to the vendor payable record it is adjusting, enabling AP reconciliation and tracking of payab',
    `application_status` STRING COMMENT 'Indicates whether the credit memo has been applied to outstanding balances: open (not yet applied), partially applied, fully applied, or void.. Valid values are `open|partially_applied|fully_applied|void`',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the credit memo that has been applied to invoices or outstanding balances.',
    `approval_date` DATE COMMENT 'The date the credit memo was approved by the authorized approver.',
    `approval_status` STRING COMMENT 'Current approval state of the credit memo in the workflow: draft, pending approval, approved, rejected, or cancelled.. Valid values are `draft|pending_approval|approved|rejected|cancelled`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the credit memo.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the credit memo record was first created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the credit being issued or received, before tax adjustments.',
    `credit_memo_number` STRING COMMENT 'Externally visible business identifier for the credit memo, used in client and vendor communications.',
    `credit_memo_type` STRING COMMENT 'Classification of the credit memo indicating the nature of the adjustment: client-issued (agency credits client), vendor-received (vendor credits agency), internal adjustment, make-good, under-delivery, or billing error correction.. Valid values are `client_issued|vendor_received|internal_adjustment|make_good|under_delivery|billing_error`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit memo transaction (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'The date by which the credit memo should be applied or processed according to payment terms.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year when the credit memo was posted.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the credit memo was issued or posted, used for financial period reporting.',
    `issue_date` DATE COMMENT 'The date the credit memo was officially issued or received.',
    `mediaocean_prisma_reference` STRING COMMENT 'Reference identifier linking this credit memo to the corresponding record in Mediaocean Prisma billing and reconciliation system.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the credit memo record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the credit memo record was last updated.',
    `net_credit_amount` DECIMAL(18,2) COMMENT 'The total credit amount including tax adjustments, representing the final credit value.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the credit memo for internal reference and audit trail.',
    `payment_terms` STRING COMMENT 'The payment terms applicable to the credit memo, indicating when the credit should be applied or refunded (e.g., Net 30, Immediate).',
    `posting_date` DATE COMMENT 'The date the credit memo was posted to the general ledger for accounting purposes.',
    `profit_center_code` STRING COMMENT 'The profit center code for segment reporting and EBITDA (Earnings Before Interest Taxes Depreciation and Amortization) analysis.',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for issuing the credit memo: billing error, under-delivery, make-good, rate adjustment, volume discount, or quality issue.. Valid values are `billing_error|under_delivery|make_good|rate_adjustment|volume_discount|quality_issue`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of why the credit memo was issued, providing context beyond the reason code.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'The unapplied portion of the credit memo still available for future application.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this credit memo reverses a previous credit memo or invoice (True if reversal, False otherwise).',
    `reversed_document_number` STRING COMMENT 'The document number of the original credit memo or invoice being reversed, if this is a reversal transaction.',
    `sap_fi_document_number` STRING COMMENT 'The SAP S/4HANA Financial Accounting document number assigned to this credit memo for general ledger integration.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax adjustment associated with the credit memo, which may reduce previously charged taxes.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the credit memo record.',
    CONSTRAINT pk_credit_memo PRIMARY KEY(`credit_memo_id`)
) COMMENT 'Credit notes issued to clients or received from vendors to adjust previously billed amounts due to billing errors, make-goods, under-delivery, or negotiated adjustments. Captures credit memo number, issue date, credit type (client-issued, vendor-received), original invoice reference, reason code, credit amount, currency, tax adjustment, approval status, SAP FI credit memo document number, and application status (open, partially applied, fully applied). Supports billing accuracy and client relationship management.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique identifier for the intercompany transaction record. Primary key for this entity.',
    `advertiser_id` BIGINT COMMENT 'Identifier of the client account for which this intercompany transaction was incurred, enabling client-level cost tracking and billing.',
    `campaign_id` BIGINT COMMENT 'Identifier of the advertising campaign associated with this intercompany transaction, if the transaction relates to campaign cost allocation or shared media buying.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center associated with this intercompany transaction for management accounting and cost allocation purposes.',
    `original_transaction_intercompany_transaction_id` BIGINT COMMENT 'Reference to the original intercompany transaction ID if this record is a reversal or adjustment, enabling audit trail and correction tracking.',
    `receiving_entity_cost_center_id` BIGINT COMMENT 'Identifier of the legal entity within the holding group that is the recipient of this intercompany transaction.',
    `sending_entity_cost_center_id` BIGINT COMMENT 'Identifier of the legal entity within the holding group that is the originator or sender of this intercompany transaction.',
    `approval_date` DATE COMMENT 'The date on which this intercompany transaction was formally approved by the authorized financial controller.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the intercompany transaction, indicating whether it has been reviewed and authorized by the appropriate financial controllers.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the financial controller or authorized person who approved this intercompany transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this intercompany transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the transaction amount is denominated.. Valid values are `^[A-Z]{3}$`',
    `elimination_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this intercompany transaction should be eliminated during consolidated financial statement preparation (True) or retained (False).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the transaction amount to the functional currency, if applicable.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this intercompany transaction belongs for financial reporting purposes.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the functional currency of the sending entity for consolidated reporting purposes.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this intercompany transaction is posted in the sending entitys books.. Valid values are `^[0-9]{4,10}$`',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this intercompany transaction record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this intercompany transaction record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or special instructions related to this intercompany transaction.',
    `payment_terms` STRING COMMENT 'The payment terms agreed upon between the sending and receiving entities for settlement of this intercompany transaction.. Valid values are `net_30|net_60|net_90|due_on_receipt|custom`',
    `posting_period` STRING COMMENT 'The fiscal period (YYYY-MM format) in which this intercompany transaction was posted to the general ledger.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `profit_center_code` STRING COMMENT 'The profit center code associated with this intercompany transaction for segment reporting and profitability analysis.. Valid values are `^PC[0-9]{4,8}$`',
    `reconciliation_date` DATE COMMENT 'The date on which this intercompany transaction was successfully reconciled and matched between the sending and receiving entities.',
    `reconciliation_status` STRING COMMENT 'Current status of the intercompany transaction reconciliation process between sending and receiving entities.. Valid values are `pending|matched|unmatched|disputed|resolved|approved`',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this intercompany transaction is a reversal or correction of a previously posted transaction (True) or an original transaction (False).',
    `sap_fi_document_number` STRING COMMENT 'The SAP S/4HANA FI document number generated when this intercompany transaction was posted in the financial accounting module.. Valid values are `^[0-9]{10}$`',
    `service_description` STRING COMMENT 'Textual description of the service, cost allocation, or transaction purpose that this intercompany record represents.',
    `settlement_date` DATE COMMENT 'The date on which the intercompany transaction was fully settled or paid between the sending and receiving entities.',
    `settlement_status` STRING COMMENT 'Current status indicating whether the intercompany transaction has been financially settled between the entities.. Valid values are `unsettled|partially_settled|fully_settled|waived`',
    `tax_jurisdiction_code` STRING COMMENT 'Code representing the tax jurisdiction or country under whose regulations this intercompany transaction is governed for tax reporting purposes.. Valid values are `^[A-Z]{2,3}$`',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary value of the intercompany transaction in the transaction currency.',
    `transaction_date` DATE COMMENT 'The business date on which the intercompany transaction occurred or was recognized for accounting purposes.',
    `transaction_reference_number` STRING COMMENT 'Externally visible unique reference number assigned to this intercompany transaction for tracking and reconciliation purposes across entities.. Valid values are `^IC-[A-Z0-9]{8,20}$`',
    `transaction_type` STRING COMMENT 'Classification of the nature of the intercompany transaction, such as cost allocation, shared service charge, intercompany loan, management fee, royalty, transfer pricing adjustment, or recharge. [ENUM-REF-CANDIDATE: cost_allocation|shared_service_charge|intercompany_loan|management_fee|royalty|transfer_pricing|recharge — 7 candidates stripped; promote to reference product]',
    `transfer_pricing_method` STRING COMMENT 'The transfer pricing methodology applied to determine the transaction amount for tax compliance and arms length pricing requirements.. Valid values are `cost_plus|market_based|profit_split|comparable_uncontrolled_price|resale_price|not_applicable`',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this intercompany transaction record in the system.',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Records of financial transactions between legal entities within the agency holding group (e.g., WPP, Omnicom, Publicis network entities), including cost allocations, shared service charges, intercompany loans, and management fees. Captures transaction reference, transaction date, sending entity, receiving entity, transaction type, amount, currency, GL account, cost center, elimination flag, SAP FI intercompany document number, and reconciliation status. Supports consolidated financial reporting, intercompany elimination during period-end close, and transfer pricing compliance.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`accrual` (
    `accrual_id` BIGINT COMMENT 'Unique identifier for the accrual record. Primary key for the accrual entity.',
    `gl_account_id` BIGINT COMMENT 'Reference to the client account associated with this accrual, enabling client-level revenue and cost tracking for Profit and Loss (P&L) reporting.',
    `accrual_gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Accruals must post to specific GL accounts. Currently references via natural key (gl_account_code). Adding gl_account_id FK enables proper chart of accounts integration.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Month-end accruals for unbilled media or services are estimated and tracked by brand for accurate brand P&L closure. Essential for brand financial reporting accuracy, brand profitability measurement, ',
    `buy_id` BIGINT COMMENT 'Foreign key linking to media.media_buy. Business justification: Accruals for media buys awaiting vendor invoices - critical for period-end expense recognition and financial statement accuracy.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign associated with this accrual, if applicable. Used to allocate media costs, production costs, and revenues to specific campaigns for margin analysis and Return on Ad Spend (ROAS) calculation.',
    `click_event_id` BIGINT COMMENT 'Foreign key linking to performance.click_event. Business justification: CPC cost accruals based on delivered clicks not yet invoiced; requires click volume for accurate accrual estimation.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this accrual, enabling departmental and functional cost tracking.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Accruals are often tracked against approved budgets to monitor estimated spend and ensure accrued costs are within budget allocations. This FK enables budget-to-actual variance analysis including accr',
    `financial_close_id` BIGINT COMMENT 'Foreign key linking to finance.financial_close. Business justification: Accruals are posted during financial close periods as part of period-end adjustments. This FK links the accrual to the financial close period it belongs to, enabling close workflow tracking and ensuri',
    `impression_event_id` BIGINT COMMENT 'Foreign key linking to performance.impression_event. Business justification: Media cost accruals estimate costs for delivered-but-not-yet-billed impressions; requires impression volume data for accurate accrual calculation.',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Accruals posted for insertion order commitments not yet invoiced - essential for accurate financial close and expense matching.',
    `production_job_id` BIGINT COMMENT 'Foreign key linking to creative.production_job. Business justification: Accruals are estimated for in-flight production jobs (unbilled vendor work, labor costs). Links accruals to jobs for work-in-progress accounting, period-end close accuracy, and job cost forecasting.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier for whom this accrual represents an estimated payable, used for vendor reconciliation and accounts payable management.',
    `accrual_date` DATE COMMENT 'The date on which the accrual entry is recorded in the financial system, typically the last day of the accounting period.',
    `accrual_description` STRING COMMENT 'Detailed narrative description of the accrual, explaining the nature of the cost or revenue, the business rationale, and any supporting context for period-end close and audit purposes.',
    `accrual_type` STRING COMMENT 'Classification of the accrual by nature of the transaction: expense accrual for general operating costs, revenue accrual for earned but unbilled revenue, media cost accrual for media buys incurred but not invoiced, production cost accrual for creative production work completed but not billed, talent cost accrual for freelance or contractor work performed but not invoiced, or overhead accrual for allocated indirect costs.. Valid values are `expense|revenue|media_cost|production_cost|talent_cost|overhead`',
    `actual_invoice_amount` DECIMAL(18,2) COMMENT 'The actual invoiced amount received after the accrual was posted, used to calculate accrual variance and improve future estimation accuracy. Populated when the actual invoice is received and matched to the accrual.',
    `approval_status` STRING COMMENT 'Current approval status of the accrual entry. Draft indicates the accrual is being prepared; pending_approval indicates the accrual is awaiting finance manager approval; approved indicates the accrual has been approved and posted; rejected indicates the accrual was rejected and requires revision.. Valid values are `draft|pending_approval|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the accrual entry was approved for posting, supporting audit trail and period-end close timeline tracking.',
    `approved_by` STRING COMMENT 'User ID or name of the finance manager or controller who approved this accrual entry for posting to the general ledger.',
    `basis` STRING COMMENT 'The methodology used to calculate the accrual amount. Contract indicates the accrual is based on contractual terms; estimate indicates management estimate based on available information; historical indicates the accrual is based on historical spending patterns; percentage_of_completion indicates the accrual is calculated based on project completion percentage.. Valid values are `contract|estimate|historical|percentage_of_completion`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this accrual record was first created in the system, supporting audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the accrual amount is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `estimated_amount` DECIMAL(18,2) COMMENT 'The estimated monetary value of the accrued cost or revenue in the specified currency. This is the best estimate at period-end based on available information, contracts, and historical patterns.',
    `fiscal_period` STRING COMMENT 'The fiscal period within the fiscal year to which this accrual applies. Format: Q1-Q4 for quarters, M01-M12 for months, or P01-P13 for SAP posting periods.. Valid values are `^(Q[1-4]|M(0[1-9]|1[0-2])|P(0[1-9]|1[0-3]))$`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this accrual applies, represented as a four-digit year (e.g., 2024).',
    `internal_order_number` STRING COMMENT 'SAP CO internal order number for project-based or campaign-based cost tracking, used when accruals need to be allocated to specific internal orders for detailed cost control.. Valid values are `^IO[0-9]{6,10}$`',
    `is_material` BOOLEAN COMMENT 'Boolean flag indicating whether this accrual is considered material for financial reporting purposes based on corporate materiality thresholds. Material accruals require additional review and documentation.',
    `mediaocean_prisma_reference` STRING COMMENT 'Reference identifier from Mediaocean Prisma system for media cost accruals, enabling reconciliation between media planning/buying platform and financial system.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this accrual record was last modified, supporting change tracking and audit trail requirements.',
    `notes` STRING COMMENT 'Additional free-text notes or comments providing supplementary context, assumptions, or supporting documentation references for the accrual. Used during period-end close review and audit.',
    `posting_date` DATE COMMENT 'The date on which the accrual entry was posted to the general ledger in the financial system, which may differ from the accrual date if the entry was prepared in advance and posted later.',
    `preparer_name` STRING COMMENT 'Name or user ID of the finance analyst or accountant who prepared this accrual entry, supporting accountability and audit trail requirements.',
    `profit_center_code` STRING COMMENT 'The profit center code to which this accrual is allocated, enabling profitability analysis by business unit, service line, or geographic region.. Valid values are `^PC[0-9]{4,6}$`',
    `reference_number` STRING COMMENT 'Business-facing unique reference number for the accrual entry, used for tracking and reconciliation purposes.. Valid values are `^ACR-[0-9]{8}$`',
    `reversal_date` DATE COMMENT 'The date on which this accrual is scheduled to be reversed, typically the first day of the subsequent accounting period. Accruals are reversed when the actual invoice or payment is received and recorded.',
    `reversal_status` STRING COMMENT 'Current status of the accrual reversal process. Pending indicates the accrual is active and awaiting reversal; reversed indicates the accrual has been reversed upon receipt of actual invoice; cancelled indicates the accrual was cancelled without reversal; adjusted indicates the accrual amount was modified before reversal.. Valid values are `pending|reversed|cancelled|adjusted`',
    `sap_fi_accrual_document_number` STRING COMMENT 'The SAP FI document number assigned to this accrual entry in the SAP S/4HANA system, used for traceability and reconciliation between the lakehouse and the source ERP system.. Valid values are `^[0-9]{10}$`',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between the estimated accrual amount and the actual invoice amount (actual_invoice_amount minus estimated_amount). Positive variance indicates over-accrual; negative variance indicates under-accrual. Used for accrual accuracy analysis and process improvement.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance amount expressed as a percentage of the estimated amount, calculated as (variance_amount / estimated_amount) * 100. Used to assess accrual estimation quality and identify systematic over- or under-accrual patterns.',
    CONSTRAINT pk_accrual PRIMARY KEY(`accrual_id`)
) COMMENT 'Period-end accrual records capturing estimated costs and revenues that have been incurred but not yet invoiced or received, ensuring accurate period financial statements. Captures accrual reference, accrual date, fiscal period, accrual type (expense, revenue, media cost, production cost), description, estimated amount, currency, GL account, cost center, campaign reference, reversal date, reversal status, and SAP FI accrual document number. Supports accurate EBITDA reporting and period-end close processes.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`financial_close` (
    `financial_close_id` BIGINT COMMENT 'Unique identifier for the financial close record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Financial close processes are typically organized and tracked by cost center for reconciliation, variance analysis, and departmental sign-off. This FK enables tracking which cost center owns or is res',
    `reopened_financial_close_id` BIGINT COMMENT 'Self-referencing FK on financial_close (reopened_financial_close_id)',
    `accruals_posted_flag` BOOLEAN COMMENT 'Indicates whether all required accruals have been posted for the period.',
    `actual_close_date` DATE COMMENT 'The actual date when the financial close was completed and the period was locked.',
    `ap_subledger_reconciled_flag` BOOLEAN COMMENT 'Indicates whether the accounts payable subledger has been reconciled to the general ledger control account.',
    `ar_subledger_reconciled_flag` BOOLEAN COMMENT 'Indicates whether the accounts receivable subledger has been reconciled to the general ledger control account.',
    `audit_ready_flag` BOOLEAN COMMENT 'Indicates whether all documentation and supporting evidence is prepared and ready for external audit review by Big 4 auditors.',
    `audit_trail_reference` STRING COMMENT 'Reference number or identifier linking this close to audit documentation and supporting evidence for Big 4 audit readiness.',
    `bank_reconciliations_complete_flag` BOOLEAN COMMENT 'Indicates whether all bank account reconciliations have been completed and cleared for the period.',
    `cfo_sign_off_by` STRING COMMENT 'Name of the CFO who signed off on the close.',
    `cfo_sign_off_flag` BOOLEAN COMMENT 'Indicates whether the CFO has reviewed and approved the close for the period.',
    `cfo_sign_off_timestamp` TIMESTAMP COMMENT 'Date and time when the CFO signed off on the close.',
    `close_commentary` STRING COMMENT 'Free-text commentary and notes about the close process, including issues encountered, resolutions, and key decisions made during the period.',
    `close_owner` STRING COMMENT 'Name of the individual responsible for coordinating and overseeing the financial close process for this period.',
    `close_owner_email` STRING COMMENT 'Email address of the close owner for communication and escalation purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `close_period_reference` STRING COMMENT 'Business reference number for the close period, used for external communication and audit trail.',
    `close_status` STRING COMMENT 'Current status of the financial close workflow: open (not started), in-progress (tasks being executed), pending-review (awaiting approval), closed (completed and locked), or reopened (unlocked for adjustments).. Valid values are `open|in-progress|pending-review|closed|reopened`',
    `close_type` STRING COMMENT 'Type of financial close being performed: monthly, quarterly, annual, or special (ad-hoc).. Valid values are `monthly|quarterly|annual|special`',
    `company_code` STRING COMMENT 'SAP company code for which this close is being performed, representing the legal entity.',
    `controller_sign_off_by` STRING COMMENT 'Name of the controller who signed off on the close.',
    `controller_sign_off_flag` BOOLEAN COMMENT 'Indicates whether the controller has reviewed and approved the close for the period.',
    `controller_sign_off_timestamp` TIMESTAMP COMMENT 'Date and time when the controller signed off on the close.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the financial close record was created in the system.',
    `days_to_close` STRING COMMENT 'Number of calendar days taken to complete the close from period end to actual close date. Key performance indicator for close efficiency.',
    `fiscal_period` STRING COMMENT 'The fiscal period number within the fiscal year (1-12 for monthly, 1-4 for quarterly).',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter number (1-4) within the fiscal year.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this close period applies.',
    `holding_company_deadline` DATE COMMENT 'Deadline imposed by the holding company for completion of the financial close and submission of consolidated reporting packages.',
    `intercompany_eliminations_done_flag` BOOLEAN COMMENT 'Indicates whether all intercompany transactions have been identified and elimination entries posted for consolidated reporting.',
    `media_cost_reconciliations_cleared_flag` BOOLEAN COMMENT 'Indicates whether all media cost reconciliations between planned and billed amounts have been cleared and approved.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the financial close record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the financial close record was last modified.',
    `revenue_recognized_flag` BOOLEAN COMMENT 'Indicates whether all revenue recognition entries have been posted according to performance obligations and contract terms.',
    `sap_fi_period_lock_date` DATE COMMENT 'Date when the period was locked in SAP S/4HANA FI.',
    `sap_fi_period_lock_status` STRING COMMENT 'Status of the period lock in SAP S/4HANA FI: open (postings allowed), locked (no postings allowed), or partially-locked (restricted postings only).. Valid values are `open|locked|partially-locked`',
    `sox_compliance_flag` BOOLEAN COMMENT 'Indicates whether all SOX 404 internal control requirements have been met for this close period.',
    `target_close_date` DATE COMMENT 'The planned date by which the financial close should be completed, typically set by holding company or regulatory deadlines.',
    `variance_explanation` STRING COMMENT 'Explanation of significant variances identified during the close process, including budget-to-actual and period-over-period variances.',
    `created_by` STRING COMMENT 'User ID or name of the person who created the financial close record.',
    CONSTRAINT pk_financial_close PRIMARY KEY(`financial_close_id`)
) COMMENT 'Period-end close workflow record tracking the status, tasks, and sign-offs required to close each fiscal period for the agency. Captures close period reference, fiscal year, fiscal period, close type (monthly, quarterly, annual), close status (open, in-progress, pending-review, closed), close checklist items (accruals posted, bank reconciliations complete, media cost reconciliations cleared, intercompany eliminations done, revenue recognized, AR/AP subledger reconciled), task owner assignments, target close date, actual close date, days to close KPI, sign-off by controller, sign-off by CFO, SAP FI period lock status, audit trail reference, and close commentary. Essential for SOX 404 compliance, Big 4 audit readiness, and ensuring timely financial reporting per holding company deadlines.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`budget_approval` (
    `budget_approval_id` BIGINT COMMENT 'Unique identifier for this budget approval authority record. Primary key.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to the budget record requiring approval',
    `worker_id` BIGINT COMMENT 'Foreign key linking to the worker authorized to approve this budget',
    `approval_authority_level` STRING COMMENT 'The hierarchical approval authority level assigned to this worker for this budget (e.g., department_head, finance_controller, CFO). Determines approval workflow routing and escalation paths. Explicitly identified in detection phase relationship data.',
    `approval_limit_amount` DECIMAL(18,2) COMMENT 'The maximum budget amount this worker is authorized to approve in the budgets currency. Amounts exceeding this limit require escalation to higher authority levels. Explicitly identified in detection phase relationship data.',
    `assigned_by` STRING COMMENT 'Name or identifier of the individual who assigned this approval authority. Used for audit trail and accountability.',
    `assigned_date` DATE COMMENT 'The date when this approval authority was originally assigned to the worker for this budget. Used for audit trail and governance reporting.',
    `delegation_end_date` DATE COMMENT 'The date when this workers approval authority for this budget expires. Nullable for permanent authority assignments. Supports temporary delegation scenarios. Explicitly identified in detection phase relationship data.',
    `delegation_start_date` DATE COMMENT 'The date when this workers approval authority for this budget becomes effective. Supports temporary delegation scenarios (e.g., during manager absence). Explicitly identified in detection phase relationship data.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this approval authority assignment is currently active (true) or has been revoked/expired (false). Used to manage approval workflow routing.',
    `notification_preference` STRING COMMENT 'The workers preferred notification channel for budget approval requests related to this specific budget (email, SMS, Slack, Teams). Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_budget_approval PRIMARY KEY(`budget_approval_id`)
) COMMENT 'This association product represents the approval authority relationship between budget and worker. It captures the multi-level approval workflow where budgets require sign-off from multiple authorized approvers (department heads, finance controllers, CFO) and workers can approve multiple budgets within their authority limits. Each record links one budget to one worker with approval authority level, delegation periods, approval limits, and notification preferences that exist only in the context of this approval relationship.. Existence Justification: Budget approval workflows in advertising agencies operate as a multi-level authorization process where a single budget requires sign-off from multiple approvers at different authority levels (department head, finance controller, CFO), and each worker can approve multiple budgets within their delegated authority limits. The approval relationship itself carries operational data including approval authority level, delegation periods (start/end dates), approval limit amounts, and notification preferences that belong to neither the budget nor the worker alone but to the specific approval authority assignment.';

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Primary key for bank_account',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for transactions and reconciliation of this bank account.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: bank_account currently has general_ledger_account_code (STRING) storing the GL account code as a denormalized string. This should be normalized to a FK relationship to gl_account for data integrity an',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that owns or controls this bank account.',
    `sweep_to_bank_account_id` BIGINT COMMENT 'Self-referencing FK on bank_account (sweep_to_bank_account_id)',
    `account_closed_date` DATE COMMENT 'The date on which the bank account was closed or deactivated, if applicable.',
    `account_name` STRING COMMENT 'The registered name or title of the bank account as it appears on bank statements.',
    `account_number` STRING COMMENT 'The unique account number assigned by the financial institution. May be domestic format or IBAN.',
    `account_opened_date` DATE COMMENT 'The date on which the bank account was originally opened with the financial institution.',
    `account_purpose` STRING COMMENT 'The primary business purpose or function for which this bank account is designated within the agencys financial operations.',
    `account_status` STRING COMMENT 'Current operational status of the bank account in the agencys financial system.',
    `account_type` STRING COMMENT 'Classification of the bank account based on its purpose and functionality.',
    `ach_enabled` BOOLEAN COMMENT 'Indicates whether ACH transactions are enabled for this account.',
    `balance_amount` DECIMAL(18,2) COMMENT 'The current balance of the bank account as of the last reconciliation or statement date.',
    `balance_as_of_date` DATE COMMENT 'The date on which the current balance amount was last updated or verified.',
    `bank_identifier_code` STRING COMMENT 'The BIC or SWIFT code uniquely identifying the financial institution for international transactions.',
    `bank_name` STRING COMMENT 'The legal name of the financial institution holding the account.',
    `bank_statement_frequency` STRING COMMENT 'The frequency at which the bank provides account statements.',
    `branch_code` STRING COMMENT 'The unique code identifying the bank branch within the financial institutions network.',
    `branch_name` STRING COMMENT 'The name of the specific bank branch where the account is held.',
    `check_writing_enabled` BOOLEAN COMMENT 'Indicates whether check writing privileges are enabled for this account.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code representing the primary currency of the bank account.',
    `interest_rate_percent` DECIMAL(18,2) COMMENT 'The annual interest rate percentage applied to the account balance, if applicable.',
    `is_primary_account` BOOLEAN COMMENT 'Indicates whether this is the primary or default bank account for the associated legal entity or cost center.',
    `last_reconciliation_date` DATE COMMENT 'The date of the most recent bank reconciliation performed for this account.',
    `minimum_balance_required` DECIMAL(18,2) COMMENT 'The minimum balance that must be maintained in the account as per bank or internal policy requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was last modified or updated.',
    `multi_currency_enabled` BOOLEAN COMMENT 'Indicates whether the account supports transactions in multiple currencies.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to the bank account.',
    `online_banking_enabled` BOOLEAN COMMENT 'Indicates whether online banking access is enabled for this account.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'The maximum overdraft or credit facility limit approved for this bank account.',
    `primary_contact_email` STRING COMMENT 'The email address of the primary bank contact for account management and support.',
    `primary_contact_name` STRING COMMENT 'The name of the primary contact person at the bank for account-related inquiries and issues.',
    `primary_contact_phone` STRING COMMENT 'The phone number of the primary bank contact for this account.',
    `reconciliation_frequency` STRING COMMENT 'The scheduled frequency at which bank reconciliation is performed for this account.',
    `routing_number` STRING COMMENT 'The domestic routing number (ABA routing number in US, sort code in UK) used for electronic funds transfers.',
    `statement_delivery_method` STRING COMMENT 'The method by which bank statements are delivered to the account holder.',
    `wire_transfer_enabled` BOOLEAN COMMENT 'Indicates whether wire transfer functionality is enabled for this account.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Master reference table for bank_account. Referenced by bank_account_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_client_invoice_id` FOREIGN KEY (`client_invoice_id`) REFERENCES `advertising_ecm`.`finance`.`client_invoice`(`client_invoice_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `advertising_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_client_invoice_id` FOREIGN KEY (`client_invoice_id`) REFERENCES `advertising_ecm`.`finance`.`client_invoice`(`client_invoice_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_original_payment_id` FOREIGN KEY (`original_payment_id`) REFERENCES `advertising_ecm`.`finance`.`payment`(`payment_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_vendor_payable_id` FOREIGN KEY (`vendor_payable_id`) REFERENCES `advertising_ecm`.`finance`.`vendor_payable`(`vendor_payable_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_accrual_id` FOREIGN KEY (`accrual_id`) REFERENCES `advertising_ecm`.`finance`.`accrual`(`accrual_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_client_invoice_id` FOREIGN KEY (`client_invoice_id`) REFERENCES `advertising_ecm`.`finance`.`client_invoice`(`client_invoice_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_credit_memo_id` FOREIGN KEY (`credit_memo_id`) REFERENCES `advertising_ecm`.`finance`.`credit_memo`(`credit_memo_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_financial_close_id` FOREIGN KEY (`financial_close_id`) REFERENCES `advertising_ecm`.`finance`.`financial_close`(`financial_close_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_intercompany_transaction_id` FOREIGN KEY (`intercompany_transaction_id`) REFERENCES `advertising_ecm`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `advertising_ecm`.`finance`.`payment`(`payment_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_revenue_recognition_id` FOREIGN KEY (`revenue_recognition_id`) REFERENCES `advertising_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_vendor_payable_id` FOREIGN KEY (`vendor_payable_id`) REFERENCES `advertising_ecm`.`finance`.`vendor_payable`(`vendor_payable_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `advertising_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_reversed_line_journal_entry_line_id` FOREIGN KEY (`reversed_line_journal_entry_line_id`) REFERENCES `advertising_ecm`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_client_invoice_id` FOREIGN KEY (`client_invoice_id`) REFERENCES `advertising_ecm`.`finance`.`client_invoice`(`client_invoice_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_vendor_payable_id` FOREIGN KEY (`vendor_payable_id`) REFERENCES `advertising_ecm`.`finance`.`vendor_payable`(`vendor_payable_id`);
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ADD CONSTRAINT `fk_finance_credit_memo_client_invoice_id` FOREIGN KEY (`client_invoice_id`) REFERENCES `advertising_ecm`.`finance`.`client_invoice`(`client_invoice_id`);
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ADD CONSTRAINT `fk_finance_credit_memo_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ADD CONSTRAINT `fk_finance_credit_memo_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ADD CONSTRAINT `fk_finance_credit_memo_vendor_payable_id` FOREIGN KEY (`vendor_payable_id`) REFERENCES `advertising_ecm`.`finance`.`vendor_payable`(`vendor_payable_id`);
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_original_transaction_intercompany_transaction_id` FOREIGN KEY (`original_transaction_intercompany_transaction_id`) REFERENCES `advertising_ecm`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_receiving_entity_cost_center_id` FOREIGN KEY (`receiving_entity_cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_sending_entity_cost_center_id` FOREIGN KEY (`sending_entity_cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_accrual_gl_account_id` FOREIGN KEY (`accrual_gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_financial_close_id` FOREIGN KEY (`financial_close_id`) REFERENCES `advertising_ecm`.`finance`.`financial_close`(`financial_close_id`);
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ADD CONSTRAINT `fk_finance_financial_close_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ADD CONSTRAINT `fk_finance_financial_close_reopened_financial_close_id` FOREIGN KEY (`reopened_financial_close_id`) REFERENCES `advertising_ecm`.`finance`.`financial_close`(`financial_close_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` ADD CONSTRAINT `fk_finance_budget_approval_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_sweep_to_bank_account_id` FOREIGN KEY (`sweep_to_bank_account_id`) REFERENCES `advertising_ecm`.`finance`.`bank_account`(`bank_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `advertising_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|activity_based|headcount|revenue|square_footage|fte');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Email Address');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Name');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'production|service|support|sales|marketing|administration');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending_approval');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'overhead|billable|shared_services|direct|indirect|administrative');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_pool_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Pool Flag');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Notes');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `overhead_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overhead Allocation Percentage');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `owning_department` SET TAGS ('dbx_business_glossary_term' = 'Owning Department');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `practice_group` SET TAGS ('dbx_business_glossary_term' = 'Practice Group');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_and_loss_responsibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Responsibility Flag');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `quarterly_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Quarterly Budget Amount');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `quarterly_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `sap_co_cost_center_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Controlling (CO) Cost Center Reference');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `sap_co_cost_center_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `account_description_long` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Long Description');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Classification');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_value_regex' = 'current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA)');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_center_applicable` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Applicable Flag');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element` SET TAGS ('dbx_business_glossary_term' = 'Cost Element');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `field_status_group` SET TAGS ('dbx_business_glossary_term' = 'Field Status Group');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `financial_statement_category` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Category');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `financial_statement_category` SET TAGS ('dbx_value_regex' = 'balance_sheet|income_statement|cash_flow|equity');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `gaap_mapping` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Mapping');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `ifrs_mapping` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Mapping');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `line_item_display` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Flag');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `open_item_management` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Flag');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `pl_classification` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Classification');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `pl_classification` SET TAGS ('dbx_value_regex' = 'operating_revenue|non_operating_revenue|cost_of_sales|operating_expense|non_operating_expense|not_applicable');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `posting_blocked` SET TAGS ('dbx_business_glossary_term' = 'Posting Blocked Flag');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `profit_center_applicable` SET TAGS ('dbx_business_glossary_term' = 'Profit Center (P&L) Applicable Flag');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Flag');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Sort Key');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `client_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|cancelled');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'operating|capital|project|discretionary');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Description');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'campaign|overhead|media|production|talent|creative');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `lock_status` SET TAGS ('dbx_business_glossary_term' = 'Lock Status');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `mediaocean_prisma_budget_reference` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma Budget Reference');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Amount');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `sap_co_internal_order` SET TAGS ('dbx_business_glossary_term' = 'SAP Controlling (CO) Internal Order');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `sap_co_internal_order` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `spent_amount` SET TAGS ('dbx_business_glossary_term' = 'Spent Amount');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `variance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'original|revised|final|forecast');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Budget Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `scope_item_id` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget Amount');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Approval Status');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|revised');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `billing_category` SET TAGS ('dbx_business_glossary_term' = 'Client Billing Category');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `billing_category` SET TAGS ('dbx_value_regex' = 'working_media|non_working_media|production|fee|pass_through');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Media Channel Type');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Budget Amount');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight End Date');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Start Date');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Billable to Client Flag');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Number');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Agency Markup Percentage');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Number');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Reason');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `client_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Client Invoice Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `click_event_id` SET TAGS ('dbx_business_glossary_term' = 'Click Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `conversion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `performance_kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Kpi Target Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `video_completion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `amount_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Amount Outstanding');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `invoice_notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{8,12}$');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'retainer|project|media|production|pass_through|adjustment');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `mediaocean_billing_reference` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma Billing Reference');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|direct_debit');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `sap_fi_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Document Number');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sent Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `click_event_id` SET TAGS ('dbx_business_glossary_term' = 'Click Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `client_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `conversion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `creative_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Deliverable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `video_completion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `viewability_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Viewability Measurement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `billing_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Code');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `delivery_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Date');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `delivery_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmed Flag');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `line_total` SET TAGS ('dbx_business_glossary_term' = 'Line Total');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Category');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_value_regex' = 'recognized|deferred|accrued|unbilled');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` SET TAGS ('dbx_subdomain' = 'payable_management');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `vendor_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Payable Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `production_job_id` SET TAGS ('dbx_business_glossary_term' = 'Production Job Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `video_completion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `viewability_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Viewability Measurement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `approved_by` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9.-_]{3,50}$');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Amount');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `discount_deadline` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Deadline');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Payable Amount');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `mediaocean_payable_reference` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma Payable Reference');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `mediaocean_payable_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,30}$');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payable Notes');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `payable_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payable Document Number');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `payable_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|eft|virtual_card');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'open|scheduled|paid|disputed|cancelled|on_hold');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^(net_[0-9]{1,3}|due_on_receipt|prepaid|custom)$');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|matched|discrepancy|resolved|escalated');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `sap_fi_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Vendor Invoice Document Number');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `sap_fi_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `sequential_liability_flag` SET TAGS ('dbx_business_glossary_term' = 'Sequential Liability Flag');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `advertising_ecm`.`finance`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`finance`.`payment` SET TAGS ('dbx_subdomain' = 'payable_management');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `client_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Client Invoice Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `original_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `vendor_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Payable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `bank_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Transaction Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `bank_transaction_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online_portal|mobile_app|bank_transfer|lockbox|manual_entry|api');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Payment Direction');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal Flag');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `memo` SET TAGS ('dbx_business_glossary_term' = 'Payment Memo');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `payer_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Name');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire|check|credit_card|debit_card|electronic_transfer');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|failed|cancelled|reversed|reconciled');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'invoice_payment|advance_payment|refund|rebate|commission|retainer');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|partially_reconciled|fully_reconciled|disputed');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `remittance_advice_reference` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Reference');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `sap_payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Payment Document Number');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `sap_payment_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `click_event_id` SET TAGS ('dbx_business_glossary_term' = 'Click Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `client_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Client Invoice Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `credit_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `financial_close_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Close Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `vendor_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Payable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `accrual_reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Reversal Date');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `accrual_reversal_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Reversal Status');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `accrual_reversal_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|reversed|failed');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `accrual_type` SET TAGS ('dbx_business_glossary_term' = 'Accrual Type');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `accrual_type` SET TAGS ('dbx_value_regex' = 'expense|revenue|media_cost|production_cost|not_applicable');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Type');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'standard|accrual|reversal|intercompany|reclassification|adjustment');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `estimated_amount_flag` SET TAGS ('dbx_business_glossary_term' = 'Estimated Amount Flag');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_partner_entity` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Partner Entity');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Description');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Number');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `original_journal_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Original Journal Entry Number');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|cancelled|pending_approval');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `reclassification_reason` SET TAGS ('dbx_business_glossary_term' = 'Reclassification Reason');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_journal_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Journal Entry Number');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_by_user` SET TAGS ('dbx_business_glossary_term' = 'Reversed By User');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversed Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `sap_fi_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Document Number');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Amount');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_line_journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Line Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_reference` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reference');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,12}$');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Credit Amount');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Debit Amount');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,12}$');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_key` SET TAGS ('dbx_business_glossary_term' = 'Reference Key');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition ID');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `click_event_id` SET TAGS ('dbx_business_glossary_term' = 'Click Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `client_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `conversion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `performance_kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Kpi Target Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Approved By User');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Approved Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `deferred_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Amount');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Record Flag');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Date');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Notes');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `percentage_complete` SET TAGS ('dbx_business_glossary_term' = 'Percentage Complete');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `performance_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Description');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition End Date');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'straight_line|milestone|percentage_of_completion|point_in_time|output_method|input_method');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Start Date');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Status');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|deferred|reversed|adjusted');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognized_amount_to_date` SET TAGS ('dbx_business_glossary_term' = 'Recognized Amount to Date');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Type');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `sap_fi_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Document Number');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `sap_fi_posting_date` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Posting Date');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `unbilled_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Unbilled Revenue Amount');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` SET TAGS ('dbx_subdomain' = 'payable_management');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `media_cost_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Media Cost Reconciliation ID');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Media Buy ID');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `click_event_id` SET TAGS ('dbx_business_glossary_term' = 'Click Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `delivery_pacing_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Pacing Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `impression_event_id` SET TAGS ('dbx_business_glossary_term' = 'Impression Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `vendor_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Payable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `viewability_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Viewability Measurement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `actual_cpm` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `billed_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Cost Amount');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `cpm_variance` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Variance');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `delivered_impressions` SET TAGS ('dbx_business_glossary_term' = 'Delivered Impressions');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `dispute_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Opened Date');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `dispute_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Notes');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `dispute_resolved_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolved Date');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `impression_variance` SET TAGS ('dbx_business_glossary_term' = 'Impression Variance');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `impression_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Impression Variance Percentage');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `io_number` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Number');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `io_number` SET TAGS ('dbx_value_regex' = '^IO-[A-Z0-9]{6,12}$');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `make_good_flag` SET TAGS ('dbx_business_glossary_term' = 'Make-Good Flag');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `make_good_impressions` SET TAGS ('dbx_business_glossary_term' = 'Make-Good Impressions');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `planned_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost Amount');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `planned_cpm` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `planned_impressions` SET TAGS ('dbx_business_glossary_term' = 'Planned Impressions');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `reconciled_amount` SET TAGS ('dbx_business_glossary_term' = 'Reconciled Amount');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `reconciliation_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Document Number');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `reconciliation_document_number` SET TAGS ('dbx_value_regex' = '^REC-[A-Z0-9]{8,15}$');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'open|in_review|in_dispute|cleared|approved|rejected');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `third_party_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Verification Date');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `third_party_verification_source` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Verification Source');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_value_regex' = 'under_delivery|over_delivery|rate_discrepancy|make_good|bonus_impressions|technical_issue');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `variance_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Description');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `vendor_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Reference');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `credit_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo ID');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `client_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Client Invoice Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `vendor_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Payable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'open|partially_applied|fully_applied|void');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|cancelled');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `credit_memo_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Type');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `credit_memo_type` SET TAGS ('dbx_value_regex' = 'client_issued|vendor_received|internal_adjustment|make_good|under_delivery|billing_error');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `mediaocean_prisma_reference` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma Reference');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `net_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Credit Amount');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'billing_error|under_delivery|make_good|rate_adjustment|volume_discount|quality_issue');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `sap_fi_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP FI (Financial Accounting) Document Number');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `original_transaction_intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_entity_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Legal Entity ID');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_entity_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Legal Entity ID');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Elimination Flag');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_60|net_90|due_on_receipt|custom');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^PC[0-9]{4,8}$');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|matched|unmatched|disputed|resolved|approved');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sap_fi_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Document Number');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sap_fi_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'unsettled|partially_settled|fully_settled|waived');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Reference Number');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_value_regex' = '^IC-[A-Z0-9]{8,20}$');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'cost_plus|market_based|profit_split|comparable_uncontrolled_price|resale_price|not_applicable');
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `click_event_id` SET TAGS ('dbx_business_glossary_term' = 'Click Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `financial_close_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Close Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `impression_event_id` SET TAGS ('dbx_business_glossary_term' = 'Impression Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `production_job_id` SET TAGS ('dbx_business_glossary_term' = 'Production Job Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Date');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_description` SET TAGS ('dbx_business_glossary_term' = 'Accrual Description');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_business_glossary_term' = 'Accrual Type');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_value_regex' = 'expense|revenue|media_cost|production_cost|talent_cost|overhead');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `actual_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Invoice Amount');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Accrual Basis');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `basis` SET TAGS ('dbx_value_regex' = 'contract|estimate|historical|percentage_of_completion');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `estimated_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Amount');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(Q[1-4]|M(0[1-9]|1[0-2])|P(0[1-9]|1[0-3]))$');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_value_regex' = '^IO[0-9]{6,10}$');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `is_material` SET TAGS ('dbx_business_glossary_term' = 'Is Material');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `mediaocean_prisma_reference` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma Reference');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Accrual Notes');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^PC[0-9]{4,6}$');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Accrual Reference Number');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^ACR-[0-9]{8}$');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `reversal_status` SET TAGS ('dbx_business_glossary_term' = 'Reversal Status');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `reversal_status` SET TAGS ('dbx_value_regex' = 'pending|reversed|cancelled|adjusted');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `sap_fi_accrual_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Accrual Document Number');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `sap_fi_accrual_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `financial_close_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Close ID');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `reopened_financial_close_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `accruals_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Accruals Posted Flag');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `ap_subledger_reconciled_flag` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Subledger Reconciled Flag');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `ar_subledger_reconciled_flag` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Subledger Reconciled Flag');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `audit_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Ready Flag');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `bank_reconciliations_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Bank Reconciliations Complete Flag');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `cfo_sign_off_by` SET TAGS ('dbx_business_glossary_term' = 'Chief Financial Officer (CFO) Sign-Off By');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `cfo_sign_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Chief Financial Officer (CFO) Sign-Off Flag');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `cfo_sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Chief Financial Officer (CFO) Sign-Off Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `close_commentary` SET TAGS ('dbx_business_glossary_term' = 'Close Commentary');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `close_owner` SET TAGS ('dbx_business_glossary_term' = 'Close Owner');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `close_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Close Owner Email Address');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `close_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `close_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `close_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `close_period_reference` SET TAGS ('dbx_business_glossary_term' = 'Close Period Reference Number');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `close_status` SET TAGS ('dbx_business_glossary_term' = 'Close Status');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `close_status` SET TAGS ('dbx_value_regex' = 'open|in-progress|pending-review|closed|reopened');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `close_type` SET TAGS ('dbx_business_glossary_term' = 'Close Type');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `close_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|special');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `controller_sign_off_by` SET TAGS ('dbx_business_glossary_term' = 'Controller Sign-Off By');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `controller_sign_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Controller Sign-Off Flag');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `controller_sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Controller Sign-Off Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `days_to_close` SET TAGS ('dbx_business_glossary_term' = 'Days to Close Key Performance Indicator (KPI)');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `holding_company_deadline` SET TAGS ('dbx_business_glossary_term' = 'Holding Company Deadline');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `intercompany_eliminations_done_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Eliminations Done Flag');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `media_cost_reconciliations_cleared_flag` SET TAGS ('dbx_business_glossary_term' = 'Media Cost Reconciliations Cleared Flag');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `revenue_recognized_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognized Flag');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `sap_fi_period_lock_date` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Period Lock Date');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `sap_fi_period_lock_status` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Period Lock Status');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `sap_fi_period_lock_status` SET TAGS ('dbx_value_regex' = 'open|locked|partially-locked');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `sox_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Compliance Flag');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `target_close_date` SET TAGS ('dbx_business_glossary_term' = 'Target Close Date');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `variance_explanation` SET TAGS ('dbx_business_glossary_term' = 'Variance Explanation');
ALTER TABLE `advertising_ecm`.`finance`.`financial_close` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` SET TAGS ('dbx_association_edges' = 'finance.budget,talent.worker');
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` ALTER COLUMN `budget_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Identifier');
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval - Budget Id');
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval - Worker Id');
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` ALTER COLUMN `approval_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Limit Amount');
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` ALTER COLUMN `assigned_by` SET TAGS ('dbx_business_glossary_term' = 'Assigned By');
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` ALTER COLUMN `delegation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delegation End Date');
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` ALTER COLUMN `delegation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delegation Start Date');
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'payable_management');
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Identifier');
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` ALTER COLUMN `sweep_to_bank_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` ALTER COLUMN `balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
