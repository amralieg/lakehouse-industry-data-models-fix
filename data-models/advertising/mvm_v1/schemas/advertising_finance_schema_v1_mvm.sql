-- Schema for Domain: finance | Business: Advertising | Version: v1_mvm
-- Generated on: 2026-05-08 03:52:18

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
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Master agreements (retainers, MSAs) in advertising have budgets allocated at the agreement level, not just SOW level. Finance teams need to link budgets directly to agreements for annual budget planni',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this budget is allocated to, if applicable.',
    `client_brief_id` BIGINT COMMENT 'Foreign key linking to client.client_brief. Business justification: Client briefs define campaign objectives, budgets, and deliverables that directly drive budget creation and allocation in advertising operations. Budget planning starts with approved client briefs spe',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center this budget is allocated to for internal financial tracking.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Budget references GL account via natural key (gl_account_code). Adding surrogate key FK gl_account_id enables proper referential integrity. Remove redundant gl_account_code as it can be retrieved via ',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Finance budgets in advertising agencies are created to fund specific project initiatives. Finance teams need to link budget records to the initiative for project cost tracking, billing, and budget uti',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Budget lines in media planning are allocated to specific client brands for brand portfolio budget management and spend tracking. budget_line has campaign_id and cost_center_id but no brand reference; ',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this budget line supports. Enables campaign-level budget tracking and reconciliation.',
    `contract_deliverable_id` BIGINT COMMENT 'Foreign key linking to contract.contract_deliverable. Business justification: Budget lines fund specific contract deliverables in advertising project accounting. Linking budget_line to contract_deliverable enables deliverable-level cost tracking and actual-vs-estimated cost rep',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.contract_insertion_order. Business justification: Contract IOs authorize spend that is tracked at the budget line level. Linking budget_line to contract_insertion_order enables spend-vs-commitment reporting — a core financial control in advertising a',
    `contract_rate_card_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_card. Business justification: Budget lines in advertising are priced against negotiated rate cards. Linking budget_line to contract_rate_card enables rate compliance reporting — finance can verify that committed spend aligns with ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget lines are allocated to cost centers for granular expense tracking. Currently references via natural key (cost_center_code). Adding cost_center_id FK enables proper joins and removes redundant c',
    `finance_budget_id` BIGINT COMMENT 'Reference to the parent budget that this line item belongs to. Links to the master budget allocation.',
    `flight_id` BIGINT COMMENT 'Foreign key linking to campaign.flight. Business justification: Budget lines in advertising are structured around campaign flights. budget_line currently stores flight_start_date and flight_end_date as denormalized plain columns — a flight_id FK normalizes this, e',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Budget line items reference GL accounts for detailed cost tracking. Adding gl_account_id FK provides referential integrity. Remove redundant gl_account_code.',
    `io_line_id` BIGINT COMMENT 'Foreign key linking to vendor.io_line. Business justification: A finance budget line maps directly to a vendor IO line — the financial authorization corresponds to the contractual commitment. Advertising finance teams use this link to reconcile committed budget a',
    `plan_line_id` BIGINT COMMENT 'Foreign key linking to media.media_plan_line. Business justification: Budget lines allocated to plan lines for detailed budget management and plan-to-actual variance tracking in media planning.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier associated with this budget line spend. Links to vendor master data for payment processing and reconciliation.',
    `work_package_id` BIGINT COMMENT 'Foreign key linking to project.work_package. Business justification: Budget lines are allocated to specific WBS work packages for granular project cost tracking and WBS-level budget control — standard agency project accounting. Finance teams need to see which work pack',
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
    `agency_relationship_id` BIGINT COMMENT 'Foreign key linking to client.agency_relationship. Business justification: Invoices are issued under specific AOR or project-based agency-client agreements. Linking invoices to agency_relationship supports commission rate application, relationship-level billing reconciliatio',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Client invoices in advertising are issued at the brand level (brand-specific campaigns and services). Brand-level accounts receivable aging and invoice reporting are standard agency finance operations',
    `buy_id` BIGINT COMMENT 'Foreign key linking to media.buy. Business justification: Client invoices for media services reference specific buys for billing substantiation. Buy-level invoice tracking enables agencies to provide clients with detailed billing support and supports billing',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to campaign.campaign. Business justification: Client invoices in advertising are issued per campaign. A campaign_id FK on client_invoice enables campaign-level billing reconciliation, revenue attribution reporting, and dispute resolution — a name',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.insertion_order. Business justification: IOs are invoiced to clients; finance links invoices back to the authorizing IO for reconciliation and payment tracking. Replaces denormalized io_reference_number.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Client invoices are attributed to cost centers for revenue tracking and P&L allocation. Adding cost_center_id FK replaces natural key reference (cost_center_code).',
    `delivery_pacing_id` BIGINT COMMENT 'Foreign key linking to performance.delivery_pacing. Business justification: Client invoices are validated against delivery pacing records to confirm billed amounts reflect actual delivery. Finance teams use pacing data to support invoice accuracy, dispute resolution, and clie',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Agency client invoices are frequently triggered by project milestone completion (campaign launch, creative delivery gates). project_milestone has is_billing_trigger flag confirming this pattern. Billi',
    `performance_kpi_target_id` BIGINT COMMENT 'Foreign key linking to performance.performance_kpi_target. Business justification: Performance-based invoicing validates delivery against contractual KPI targets; billing adjustments require linking to target definitions.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.plan. Business justification: Client invoices for media services reference the media plan for billing reconciliation and client reporting. Agencies invoice clients against approved media plans; this link enables plan-level billing',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: SOWs are the contractual basis for client invoicing; invoice lines reference SOW terms and deliverables. Replaces denormalized sow_reference_number with proper FK.',
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
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Each invoice line item should be traceable to the specific budget line it is billing against. invoice_line already has revenue_recognition_category and revenue_recognition_date, indicating it is a fin',
    `buy_id` BIGINT COMMENT 'Foreign key linking to media.media_buy. Business justification: Invoice lines bill specific media buys for detailed cost recovery and margin calculation - essential billing granularity.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign associated with this billable line item. Links revenue to campaign performance.',
    `click_event_id` BIGINT COMMENT 'Foreign key linking to performance.click_event. Business justification: Invoice lines for CPC campaigns bill specific click volumes; delivery confirmation requires linking to click events.',
    `client_invoice_id` BIGINT COMMENT 'Reference to the parent invoice header. Links this line item to the overall client invoice.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Invoice line items are allocated to cost centers for detailed revenue attribution. Currently has cost_center (STRING) natural key. Adding cost_center_id FK provides referential integrity.',
    `creative_deliverable_id` BIGINT COMMENT 'Foreign key linking to creative.creative_deliverable. Business justification: Invoice lines bill clients for specific creative deliverables. Links billing to deliverables for revenue attribution, deliverable-level profitability analysis, and reconciliation of billed vs. deliver',
    `deliverable_tracker_id` BIGINT COMMENT 'Foreign key linking to project.deliverable_tracker. Business justification: Invoice lines in advertising are billed for specific project deliverables (TV spots, banner sets, reports). Linking invoice_line to deliverable_tracker enables billing reconciliation against project d',
    `delivery_pacing_id` BIGINT COMMENT 'Foreign key linking to performance.delivery_pacing. Business justification: Invoice lines are reconciled against delivery pacing at placement/line-item level to validate billed quantities. This line-level delivery validation is essential for accurate CPM/CPC billing and suppo',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Invoice line items post to GL revenue accounts. Adding gl_account_id FK replaces natural key reference (gl_account_code).',
    `io_line_id` BIGINT COMMENT 'Foreign key linking to vendor.io_line. Business justification: Client invoice lines in advertising are derived from vendor IO line delivery data. This link supports billing reconciliation and agency margin analysis by tracing each billed line back to the specific',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Invoice lines reference insertion orders for billing detail, reconciliation, and revenue allocation - core billing granularity in advertising finance.',
    `media_placement_id` BIGINT COMMENT 'Reference to the specific media placement being billed. Links invoice line to media execution details.',
    `performance_kpi_target_id` BIGINT COMMENT 'Foreign key linking to performance.performance_kpi_target. Business justification: Invoice lines for performance-based billing reference specific KPI targets (guaranteed viewability, CPA rates). Linking invoice_line to performance_kpi_target supports performance-based billing valida',
    `plan_line_id` BIGINT COMMENT 'Foreign key linking to media.media_plan_line. Business justification: Invoice lines reference plan lines for billing against planned spend and budget variance tracking in client billing processes.',
    `programmatic_deal_id` BIGINT COMMENT 'Foreign key linking to media.programmatic_deal. Business justification: Programmatic deal invoice lines must reference the originating deal for billing reconciliation and DSP platform cost verification. Deal-level invoice line tracking is required for programmatic spend a',
    `reconciliation_id` BIGINT COMMENT 'Foreign key linking to vendor.reconciliation. Business justification: Client invoice lines are generated after vendor reconciliation confirms delivery. Linking invoice_line to the reconciliation record that validated delivery is standard advertising billing practice, en',
    `revenue_recognition_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition. Business justification: invoice_line already carries revenue_recognition_category and revenue_recognition_date attributes, indicating that revenue recognition is determined at the line level (different service lines may use ',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to media.schedule. Business justification: Broadcast invoice lines reference specific schedule entries for billing verification against aired spots. Affidavit reconciliation in broadcast billing requires matching invoice lines to schedule reco',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Vendor payables for media buys and production are attributed to specific client brands for brand-level cost of goods reporting and profitability analysis. vendor_payable has advertiser_id but brand-le',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: A vendor payable represents the actual AP liability incurred against a planned budget line. Linking vendor_payable.budget_line_id -> budget_line.budget_line_id enables direct committed-vs-actual spend',
    `buy_id` BIGINT COMMENT 'Reference to the media buy that generated this vendor payable. Links the financial liability to the underlying media purchase for campaign cost tracking and Return on Ad Spend (ROAS) analysis.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign for which this vendor cost was incurred. Enables campaign-level margin analysis and Return on Investment (ROI) calculation.',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.insertion_order. Business justification: Media IOs create vendor payables when media is delivered; finance reconciles payables against IO terms for three-way match and payment authorization.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vendor payables are attributed to cost centers for expense tracking. Adding cost_center_id FK replaces natural key reference.',
    `delivery_pacing_id` BIGINT COMMENT 'Foreign key linking to performance.delivery_pacing. Business justification: Finance teams validate vendor payables against actual delivery pacing data before approving payment. This delivery-to-payable validation is a standard media finance reconciliation step ensuring vendor',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Vendor payables post to GL accounts (typically accounts payable liability accounts). Adding gl_account_id FK replaces natural key reference.',
    `io_line_id` BIGINT COMMENT 'Foreign key linking to vendor.io_line. Business justification: In advertising AP workflows, a vendor payable is generated against the specific IO line that authorized the spend. This enables 3-way match (IO line → delivery → payable) and is standard practice for ',
    `media_placement_id` BIGINT COMMENT 'Foreign key linking to media.media_placement. Business justification: Payables reference specific placements for detailed cost tracking and delivery-based payment verification in vendor reconciliation.',
    `performance_kpi_target_id` BIGINT COMMENT 'Foreign key linking to performance.performance_kpi_target. Business justification: Performance-based vendor contracts include KPI-contingent payment terms. Linking vendor_payable to performance_kpi_target supports pay-for-performance payment processing and audit trails for KPI-gated',
    `plan_line_id` BIGINT COMMENT 'Foreign key linking to media.plan_line. Business justification: Vendor payables should reference plan lines for planned-vs-actual cost reconciliation at the line level. Agency finance teams require this link to produce budget variance reports by media channel and ',
    `production_job_id` BIGINT COMMENT 'Foreign key linking to creative.production_job. Business justification: Vendor payables (freelancers, studios, post-production) are tied to specific production jobs. Links payables to jobs for job costing, vendor cost reconciliation, and production budget variance analysi',
    `reconciliation_id` BIGINT COMMENT 'Foreign key linking to vendor.reconciliation. Business justification: Advertising AP teams release vendor payments only after reconciliation confirms delivery. Linking vendor_payable to the reconciliation record that validated delivery is the core AP release workflow an',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to media.schedule. Business justification: Broadcast vendor payables are generated from schedule entries representing aired spots. Linking vendor payables to schedules enables affidavit-based billing verification — a standard broadcast media a',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor, publisher, production supplier, freelancer, or technology partner to whom payment is owed.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to vendor.invoice. Business justification: Vendor payables track liabilities for specific vendor invoices. Finance teams reconcile payables against vendor.invoice records for payment matching, dispute resolution, and three-way match (PO-invoic',
    `vendor_rate_card_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_rate_card. Business justification: Vendor payable amounts are validated against the contracted rate card during AP processing. Advertising finance teams perform rate card verification as part of invoice approval — linking payable to ra',
    `video_completion_event_id` BIGINT COMMENT 'Foreign key linking to performance.video_completion_event. Business justification: Video vendor payables reconcile against delivered completions; CPCV payment validation requires completion event evidence.',
    `viewability_measurement_id` BIGINT COMMENT 'Foreign key linking to performance.viewability_measurement. Business justification: Viewability-guaranteed vendor contracts pay only for viewable impressions; payable validation requires viewability measurement evidence.',
    `work_package_id` BIGINT COMMENT 'Foreign key linking to project.work_package. Business justification: Vendor payables for production work (video production, photography, studio time) are incurred against specific WBS work packages. Finance needs to match vendor costs to the work package for project co',
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
    `buy_id` BIGINT COMMENT 'Foreign key linking to media.buy. Business justification: Vendor payments are made against specific media buys in agency operations. Direct buy-to-payment linkage enables buy-level payment status tracking and cash flow reporting. Agency finance teams require',
    `client_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.client_invoice. Business justification: Payments can be AR receipts from clients applied to client invoices. The existing invoice_id FK points to vendor.invoice for AP disbursements; this new FK handles client payment receipts. Enables trac',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice being settled by this payment. Links payment to the originating billing document for reconciliation.',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Payments allocated to insertion orders for cash flow tracking and payment reconciliation in media finance operations.',
    `original_payment_id` BIGINT COMMENT 'Reference to the original payment record that this payment reverses. Populated only when is_reversal is True.',
    `reconciliation_id` BIGINT COMMENT 'Foreign key linking to vendor.reconciliation. Business justification: Advertising agency payments to vendors are authorized by an approved reconciliation record. Linking payment to the reconciliation that triggered it supports the payment release audit trail and is requ',
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

CREATE OR REPLACE TABLE `advertising_ecm`.`finance`.`revenue_recognition` (
    `revenue_recognition_id` BIGINT COMMENT 'Unique identifier for the revenue recognition record. Primary key for this entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client (advertiser) for whom revenue is being recognized.',
    `agency_relationship_id` BIGINT COMMENT 'Foreign key linking to client.agency_relationship. Business justification: Revenue recognition in advertising agencies is governed by the fee structure of the agency relationship (retainer, commission, project). Linking revenue_recognition to agency_relationship supports rel',
    `agreement_id` BIGINT COMMENT 'Reference to the client contract or Statement of Work (SOW) that governs this revenue recognition event.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: ASC 606 / IFRS 15 revenue recognition in advertising agencies is performed at the brand level as the performance obligation unit. Brand-level revenue recognition reporting is a standard finance requir',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign associated with this revenue recognition, if applicable.',
    `client_invoice_id` BIGINT COMMENT 'Reference to the client invoice associated with this revenue recognition event, if revenue has been billed.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue recognition is attributed to cost centers for P&L reporting. Adding cost_center_id FK replaces natural key reference.',
    `delivery_pacing_id` BIGINT COMMENT 'Foreign key linking to performance.delivery_pacing. Business justification: ASC 606 percentage-of-completion revenue recognition requires delivery milestone data. Linking revenue_recognition to delivery_pacing supports delivery-based revenue recognition calculations and audit',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue recognition records post to specific GL revenue accounts. Adding gl_account_id FK replaces natural key reference.',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Revenue recognized against insertion orders for agency commission and service fees - fundamental revenue accounting in advertising.',
    `media_placement_id` BIGINT COMMENT 'Foreign key linking to media.media_placement. Business justification: Granular ASC 606 revenue recognition at placement level is required when each placement represents a distinct performance obligation. Agency finance teams recognize revenue as placements deliver; this',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: ASC 606/IFRS 15 revenue recognition in advertising agencies is tied to project milestone completion (performance obligations). revenue_recognition has denormalized milestone_name and milestone_date pl',
    `performance_kpi_target_id` BIGINT COMMENT 'Foreign key linking to performance.performance_kpi_target. Business justification: Revenue recognition for performance contracts depends on meeting KPI targets; ASC 606 performance obligations require target linkage.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.plan. Business justification: Revenue recognition for media agency services is tied to media plan delivery milestones under ASC 606 percentage-of-completion method. Linking revenue recognition to the media plan enables plan-level ',
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
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Media cost reconciliation matches planned media costs against actual vendor costs. The budget_line is the planning instrument that defines the planned_cost_amount, channel_type, and flight dates for a',
    `buy_id` BIGINT COMMENT 'Reference to the media buy that this reconciliation record pertains to. Links to the media buy master record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to campaign.campaign. Business justification: Media cost reconciliation is executed at the campaign level — comparing planned vs. billed media costs per campaign is a core advertising finance process. Enables campaign-level reconciliation reports',
    `click_event_id` BIGINT COMMENT 'Foreign key linking to performance.click_event. Business justification: Click discrepancy reconciliation between ad server and publisher systems; financial adjustments require linking to click events.',
    `conversion_event_id` BIGINT COMMENT 'Foreign key linking to performance.conversion_event. Business justification: CPA/CPC media buys require reconciliation of billed costs against conversion events. Finance teams validate vendor invoices by matching billed conversion counts to actual conversion event records duri',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `delivery_pacing_id` BIGINT COMMENT 'Foreign key linking to performance.delivery_pacing. Business justification: Pacing data informs reconciliation of planned vs actual delivery and spend; variance analysis requires pacing metrics.',
    `flight_id` BIGINT COMMENT 'Foreign key linking to campaign.flight. Business justification: Billing periods in advertising align with campaign flights. Reconciling media costs at the flight level (planned impressions/spend per flight vs. vendor invoice) is standard practice. Enables flight-l',
    `io_line_id` BIGINT COMMENT 'Foreign key linking to vendor.io_line. Business justification: Media cost reconciliation in advertising is performed at the IO line level — each contracted line has its own planned units and spend. Linking reconciliation to the specific IO line enables line-level',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to campaign.line_item. Business justification: Line-item-level media cost reconciliation is standard in programmatic and direct advertising — each line item has booked impressions/cost that must be reconciled against vendor delivery. Enables granu',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Reconciliation is performed at the IO level in agency billing operations. The existing io_number plain attribute is a denormalized reference; a proper FK replaces it. IO-level reconciliation is requir',
    `media_placement_id` BIGINT COMMENT 'Foreign key linking to media.media_placement. Business justification: Media cost reconciliation matches billed costs against contracted placement values. Linking reconciliation records to specific placements enables placement-level billing dispute resolution and varianc',
    `performance_kpi_target_id` BIGINT COMMENT 'Foreign key linking to performance.performance_kpi_target. Business justification: Media cost reconciliation validates actual delivery against contracted KPI targets (guaranteed CPM, viewability thresholds). Linking to performance_kpi_target supports contractual delivery validation ',
    `plan_line_id` BIGINT COMMENT 'Foreign key linking to media.plan_line. Business justification: Reconciliation against plan lines enables planned-vs-actual spend variance reporting at the line level — a standard agency financial control process. Finance teams require this link to produce budget ',
    `reconciliation_id` BIGINT COMMENT 'Foreign key linking to vendor.reconciliation. Business justification: Finance-side media cost reconciliation must be matched to the vendor-side reconciliation record to close the billing cycle. Advertising operations teams use this cross-domain match to confirm both par',
    `supplier_id` BIGINT COMMENT 'Identifier for the media vendor or publisher who provided the media inventory and submitted the invoice.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to vendor.invoice. Business justification: Media cost reconciliation is always performed against a specific vendor invoice — comparing billed amounts to planned costs. This is the foundational link for advertising media billing reconciliation ',
    `vendor_payable_id` BIGINT COMMENT 'Foreign key linking to finance.vendor_payable. Business justification: Media cost reconciliations match planned media costs against actual vendor invoices and result in vendor payables being created or adjusted. This FK links the reconciliation to the resulting vendor pa',
    `video_completion_event_id` BIGINT COMMENT 'Foreign key linking to performance.video_completion_event. Business justification: CPCV video buys are reconciled by matching billed completion counts to actual video completion events. This reconciliation step is mandatory for validating vendor invoices on completion-based video ca',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `advertising_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_client_invoice_id` FOREIGN KEY (`client_invoice_id`) REFERENCES `advertising_ecm`.`finance`.`client_invoice`(`client_invoice_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_revenue_recognition_id` FOREIGN KEY (`revenue_recognition_id`) REFERENCES `advertising_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `advertising_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_client_invoice_id` FOREIGN KEY (`client_invoice_id`) REFERENCES `advertising_ecm`.`finance`.`client_invoice`(`client_invoice_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_original_payment_id` FOREIGN KEY (`original_payment_id`) REFERENCES `advertising_ecm`.`finance`.`payment`(`payment_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_vendor_payable_id` FOREIGN KEY (`vendor_payable_id`) REFERENCES `advertising_ecm`.`finance`.`vendor_payable`(`vendor_payable_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_client_invoice_id` FOREIGN KEY (`client_invoice_id`) REFERENCES `advertising_ecm`.`finance`.`client_invoice`(`client_invoice_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `advertising_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_vendor_payable_id` FOREIGN KEY (`vendor_payable_id`) REFERENCES `advertising_ecm`.`finance`.`vendor_payable`(`vendor_payable_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `advertising_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'budget_control');
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
ALTER TABLE `advertising_ecm`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'budget_control');
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
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` SET TAGS ('dbx_subdomain' = 'budget_control');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `client_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'budget_control');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `contract_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Deliverable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `contract_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Budget Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `io_line_id` SET TAGS ('dbx_business_glossary_term' = 'Io Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `agency_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Buy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `delivery_pacing_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Pacing Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `performance_kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Kpi Target Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `click_event_id` SET TAGS ('dbx_business_glossary_term' = 'Click Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `client_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `creative_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Deliverable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `deliverable_tracker_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Tracker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `delivery_pacing_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Pacing Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `io_line_id` SET TAGS ('dbx_business_glossary_term' = 'Io Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `performance_kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Kpi Target Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `vendor_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Payable Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `delivery_pacing_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Pacing Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `io_line_id` SET TAGS ('dbx_business_glossary_term' = 'Io Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `performance_kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Kpi Target Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `production_job_id` SET TAGS ('dbx_business_glossary_term' = 'Production Job Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `vendor_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `video_completion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `viewability_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Viewability Measurement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`finance`.`payment` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Buy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `client_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Client Invoice Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `original_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`finance`.`payment` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition ID');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `agency_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `client_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `delivery_pacing_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Pacing Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `performance_kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Kpi Target Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` SET TAGS ('dbx_subdomain' = 'revenue_billing');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `media_cost_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Media Cost Reconciliation ID');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Media Buy ID');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `click_event_id` SET TAGS ('dbx_business_glossary_term' = 'Click Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `conversion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `delivery_pacing_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Pacing Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `io_line_id` SET TAGS ('dbx_business_glossary_term' = 'Io Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `performance_kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Kpi Target Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `vendor_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Payable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ALTER COLUMN `video_completion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Event Id (Foreign Key)');
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
