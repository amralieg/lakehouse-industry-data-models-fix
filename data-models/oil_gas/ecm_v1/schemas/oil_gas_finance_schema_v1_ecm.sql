-- Schema for Domain: finance | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`finance` COMMENT 'Serves as the SSOT for enterprise financial management including general ledger, cost center accounting, CAPEX/OPEX budgeting, LOE tracking, DD&A calculations, AFE management, NPV/IRR project economics, EBITDA reporting, and financial statements. Owns chart of accounts, journal entries, cost centers, and financial planning. Supports IFRS/GAAP oil and gas accounting (successful efforts and full cost methods), SEC financial disclosure, and SOX compliance. Integrates with SAP S/4HANA FI/CO modules.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Cost centers belong to legal entities. The existing company_code STRING attribute should be replaced with a proper FK to company_code.company_code_id to enable legal entity-level cost center hierarchi',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee who is the designated manager responsible for this cost center, accountable for budget performance and cost control.',
    `field_id` BIGINT COMMENT 'Foreign key reference to the oil or gas field to which this cost center is assigned, enabling field-level lease operating expense (LOE) tracking and reserves-based cost analysis.',
    `hierarchy_id` BIGINT COMMENT 'Foreign key reference to the primary physical asset (facility, well, plant, or equipment) associated with this cost center. Used to link operating expenses to specific assets for asset lifecycle costing and depreciation, depletion, and amortization (DD&A) calculations.',
    `joint_venture_id` BIGINT COMMENT 'Foreign key reference to the joint venture or joint operating agreement (JOA) to which this cost center belongs, enabling partner cost allocation and joint interest billing (JIB) processing.',
    `parent_cost_center_id` BIGINT COMMENT 'Foreign key reference to the parent cost center in the cost center hierarchy, enabling roll-up reporting and hierarchical cost allocation. Null for top-level cost centers.',
    `profit_center_id` BIGINT COMMENT 'Foreign key reference to the profit center to which this cost center is assigned for segment reporting and profitability analysis. Enables roll-up of costs to revenue-generating business units.',
    `activity_type` STRING COMMENT 'The primary operational activity type associated with this cost center, used for activity-based costing and operational performance analysis in oil and gas operations. [ENUM-REF-CANDIDATE: drilling|completion|workover|production|maintenance|inspection|abandonment|other — 8 candidates stripped; promote to reference product]',
    `afe_number` STRING COMMENT 'The authorization for expenditure (AFE) number associated with this cost center, used to track approved capital or operating expenditures for drilling, completion, or facility projects. Common in upstream operations.. Valid values are `^AFE-[A-Z0-9]{6,12}$`',
    `allocation_method` STRING COMMENT 'The method used to allocate costs from this cost center to other cost objects or profit centers. Direct charge assigns costs directly. Activity-based uses cost drivers. Percentage uses fixed ratios. Headcount allocates by employee count. Area allocates by square footage. Volume allocates by production volume.. Valid values are `direct_charge|activity_based|percentage|headcount|area|volume`',
    `budget_amount` DECIMAL(18,2) COMMENT 'The approved annual operating budget (OPEX) or authorization for expenditure (AFE) amount allocated to this cost center for the current fiscal year, in the cost centers currency. Used for budget vs. actual variance analysis.',
    `budget_year` STRING COMMENT 'The fiscal year for which the budget amount is applicable, enabling multi-year budget tracking and historical budget analysis.',
    `business_area` STRING COMMENT 'High-level business segment classification for this cost center. Upstream includes exploration and production (E&P). Midstream includes transportation and storage. Downstream includes refining, petrochemicals, and marketing. Corporate includes G&A and shared services.. Valid values are `upstream|midstream|downstream|corporate`',
    `controlling_area` STRING COMMENT 'The SAP controlling area (CO) organizational unit that manages this cost center for internal management accounting, cost allocation, and profitability analysis. Multiple company codes may share a single controlling area.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_category` STRING COMMENT 'Classification of the cost center by its cost behavior and allocation method. Direct cost centers accumulate costs directly attributable to production or projects. Indirect cost centers accumulate support costs that are allocated to direct cost centers. Overhead cost centers track general administrative expenses. Capital cost centers accumulate costs for capital projects (CAPEX).. Valid values are `direct|indirect|overhead|capital`',
    `cost_center_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying the cost center in the enterprise chart of accounts and controlling area. Used as the business identifier in SAP CO module and all financial reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `cost_center_description` STRING COMMENT 'Extended free-text description providing additional context about the cost centers purpose, scope, and operational details beyond the standard name field.',
    `cost_center_name` STRING COMMENT 'The full descriptive name of the cost center, providing human-readable identification for financial reporting and management review.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active cost centers accept expense postings. Inactive cost centers are closed to new postings but retain historical data. Blocked cost centers are temporarily suspended. Pending closure cost centers are in the process of being decommissioned.. Valid values are `active|inactive|blocked|pending_closure`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by its primary business function. Production cost centers track lease operating expenses (LOE) and field operations. Drilling cost centers accumulate well construction costs. Exploration cost centers capture prospect evaluation and seismic costs. Refining and petrochemical cost centers track processing plant operations. General administrative (G&A) cost centers accumulate corporate overhead. [ENUM-REF-CANDIDATE: production|drilling|exploration|refining|petrochemical|transportation|general_administrative|sales_marketing — 8 candidates stripped; promote to reference product]',
    `cost_element_group` STRING COMMENT 'The primary cost element group or general ledger (GL) account category that this cost center typically posts to, enabling standardized cost classification and reporting across the enterprise.',
    `country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code where this cost center is located, used for country-level regulatory reporting and tax compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was first created in the system, used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this cost centers expenses are recorded and reported. Typically matches the company codes local currency.. Valid values are `^[A-Z]{3}$`',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this cost center is subject to enhanced environmental compliance tracking and reporting requirements under EPA, BSEE, or other environmental regulations. True means enhanced tracking is required.',
    `functional_area` STRING COMMENT 'The functional discipline or department that this cost center supports, enabling cross-functional cost analysis and benchmarking across the enterprise. [ENUM-REF-CANDIDATE: operations|maintenance|engineering|hse|finance|human_resources|information_technology|procurement|legal — 9 candidates stripped; promote to reference product]',
    `geographic_region` STRING COMMENT 'The geographic region or basin where this cost center operates, enabling regional cost benchmarking and geographic segment reporting for SEC and IFRS compliance.',
    `hierarchy_level` STRING COMMENT 'The depth level of this cost center in the organizational hierarchy, with 1 representing top-level cost centers and higher numbers representing deeper nesting. Used for hierarchical reporting and aggregation.',
    `lock_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this cost center is locked for posting. True means the cost center is locked and cannot accept new expense transactions. False means it is open for postings.',
    `modified_by` STRING COMMENT 'The user ID or system identifier of the person or process that last modified this cost center record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was last modified in the system, used for audit trail and change tracking.',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this cost center is subject to Sarbanes-Oxley (SOX) internal control testing and audit requirements. True means SOX controls apply.',
    `tax_jurisdiction` STRING COMMENT 'The tax jurisdiction or authority under which this cost center operates, used for tax allocation, transfer pricing, and compliance with local tax regulations.',
    `valid_from_date` DATE COMMENT 'The date from which this cost center record becomes effective and can accept expense postings. Used for time-dependent cost center master data management.',
    `valid_to_date` DATE COMMENT 'The date until which this cost center record is effective. After this date, the cost center is closed to new postings. Null for cost centers with no planned closure date.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The percentage of working interest (WI) that this cost center represents in a joint venture or lease, used to calculate the companys share of joint costs. Expressed as a percentage (e.g., 35.50 for 35.50%).',
    `created_by` STRING COMMENT 'The user ID or system identifier of the person or process that created this cost center record in the system.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Master record for all cost centers in the oil and gas enterprise, representing organizational units used to accumulate and track OPEX, LOE, and overhead costs. Captures cost center code, description, cost center type (production, drilling, G&A, exploration), responsible manager, company code, controlling area, profit center assignment, currency, valid-from/to dates, and hierarchical parent cost center. Integrates with SAP S/4HANA CO module as the primary cost object for expense allocation and internal reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique system identifier for the profit center record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Profit centers belong to legal entities. The existing company_code STRING attribute should be replaced with a proper FK to company_code.company_code_id to enable legal entity-level profit center hiera',
    `parent_profit_center_id` BIGINT COMMENT 'Identifier of the parent profit center in the organizational hierarchy, enabling multi-level profitability analysis and consolidation.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the manager or executive accountable for the profit centers financial performance and operational results.',
    `accounting_method` STRING COMMENT 'Oil and gas accounting method applied to this profit center: successful efforts (capitalizes only successful exploration costs) or full cost (capitalizes all exploration costs within a cost center).. Valid values are `successful_efforts|full_cost`',
    `asset_class` STRING COMMENT 'Classification of the profit centers primary asset base: producing (generating revenue from proved developed producing reserves), non-producing (proved developed non-producing), development (under development), or exploration (exploratory activities).. Valid values are `producing|non_producing|development|exploration`',
    `business_area` STRING COMMENT 'Four-character code identifying the business area for cross-company code reporting. Represents a separate area of operations or responsibilities within the organization.. Valid values are `^[A-Z0-9]{4}$`',
    `capex_budget_annual` DECIMAL(18,2) COMMENT 'Annual capital expenditure budget allocated to this profit center for asset development, facility construction, and major equipment purchases. Expressed in the profit centers local currency.',
    `controlling_area` STRING COMMENT 'Four-character code identifying the controlling area (organizational unit in management accounting) under which this profit center operates. Controlling area represents the highest organizational unit for cost accounting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_group` STRING COMMENT 'Grouping classification for associated cost centers that roll up into this profit center for internal cost allocation and profitability analysis.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code identifying the primary country of operations for this profit center.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'User identifier of the person who created this profit center record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this profit center record was first created in the enterprise system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the local currency in which the profit centers financial transactions are recorded and reported.. Valid values are `^[A-Z]{3}$`',
    `dd_and_a_method` STRING COMMENT 'Method used to calculate depreciation, depletion, and amortization for assets within this profit center: unit-of-production (based on reserves), straight-line, or declining-balance.. Valid values are `unit_of_production|straight_line|declining_balance`',
    `environmental_classification` STRING COMMENT 'Environmental and operational classification of the profit centers assets: onshore, offshore shallow water, offshore deepwater, arctic, or unconventional (shale, oil sands, etc.).. Valid values are `onshore|offshore_shallow|offshore_deepwater|arctic|unconventional`',
    `geographic_region` STRING COMMENT 'Primary geographic region where the profit center operates, used for regional profitability analysis and segment reporting.. Valid values are `north_america|south_america|europe|middle_east|africa|asia_pacific`',
    `hierarchy_node` STRING COMMENT 'Position of this profit center within the organizational profit center hierarchy, enabling roll-up reporting and consolidation. Typically represented as a path or node identifier.',
    `hse_tier` STRING COMMENT 'Health, Safety, and Environment (HSE) risk tier classification for this profit center based on operational complexity, environmental sensitivity, and regulatory requirements.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `joa_operator_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this profit center acts as the operator under Joint Operating Agreements (JOA) for joint venture operations.',
    `last_modified_by_user` STRING COMMENT 'User identifier of the person who last modified this profit center record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this profit center record was last modified or updated.',
    `net_revenue_interest_percentage` DECIMAL(18,2) COMMENT 'Percentage of net revenue interest retained by the company after deducting royalties and overriding royalty interests. Represents the actual revenue share from production.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the profit center configuration and operations.',
    `opex_budget_annual` DECIMAL(18,2) COMMENT 'Annual operating expenditure budget allocated to this profit center for day-to-day operations, maintenance, and lease operating expenses (LOE). Expressed in the profit centers local currency.',
    `production_phase` STRING COMMENT 'Current production phase of the profit centers assets: primary recovery (natural reservoir pressure), secondary recovery (water or gas injection), tertiary enhanced oil recovery (EOR/IOR techniques), or depleted.. Valid values are `primary|secondary|tertiary_eor|depleted`',
    `profit_center_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the profit center within the controlling area. Used in financial reporting and internal management accounting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `profit_center_name` STRING COMMENT 'Full descriptive name of the profit center representing the business segment or operational unit.',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center: active (operational and posting transactions), inactive (temporarily suspended), planned (future activation), or closed (permanently deactivated).. Valid values are `active|inactive|planned|closed`',
    `profit_center_type` STRING COMMENT 'Classification of the profit center by primary business function: upstream exploration and production (E&P), midstream transportation and storage, downstream refining, downstream petrochemical manufacturing, marketing and sales, or corporate support.. Valid values are `upstream_ep|midstream|downstream_refining|downstream_petrochemical|marketing_sales|corporate`',
    `psa_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this profit center operates under a Production Sharing Agreement (PSA) with a host government or national oil company (NOC).',
    `reserve_category` STRING COMMENT 'Primary reserves classification for assets managed by this profit center: 1P (proved), 2P (proved plus probable), 3P (proved plus probable plus possible), contingent resources, or prospective resources.. Valid values are `1P|2P|3P|contingent|prospective`',
    `segment` STRING COMMENT 'Segment classification code for external financial reporting under IFRS 8 Operating Segments. Represents a component of the business that engages in activities from which it may earn revenues and incur expenses.. Valid values are `^[A-Z0-9]{4,10}$`',
    `tax_jurisdiction` STRING COMMENT 'Primary tax jurisdiction or fiscal regime under which this profit center operates, determining applicable tax rates, royalty structures, and fiscal terms.',
    `valid_from_date` DATE COMMENT 'Effective start date from which this profit center configuration is valid and active for transaction posting and financial reporting.',
    `valid_to_date` DATE COMMENT 'Effective end date until which this profit center configuration remains valid. Null value indicates open-ended validity.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'Percentage of working interest held by the company in the assets managed by this profit center. Working interest represents the operating interest that bears the cost of development and operation.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Master record for profit centers representing autonomous business segments used for internal profitability reporting in oil and gas operations. Captures profit center code, description, profit center type (upstream E&P, refining, petrochemical, marketing), responsible manager, company code, controlling area, segment classification, currency, and hierarchy node. Supports segment reporting under IFRS 8 and internal management reporting by business unit. Integrates with SAP S/4HANA CO-PCA module.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique system identifier for the general ledger account record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: GL accounts can be company-code-specific or shared across a chart of accounts. The existing company_code STRING attribute should be replaced with a proper FK to company_code.company_code_id to enable ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: GL account setup accountability is essential for chart of accounts governance. Links account creation to specific employee for financial reporting structure and SOX control in Oil & Gas accounting.',
    `account_group` STRING COMMENT 'The account group classification used to organize accounts into logical categories for reporting and analysis (e.g., current assets, fixed assets, operating expenses, capital expenditures).',
    `account_long_description` STRING COMMENT 'Extended description providing detailed explanation of the account purpose, usage guidelines, and business context.',
    `account_name` STRING COMMENT 'The short descriptive name of the GL account used for display and reporting purposes.',
    `account_number` STRING COMMENT 'The unique account number used to identify this GL account in the chart of accounts. Typically a 4-10 digit numeric code structured according to the enterprise account numbering scheme.. Valid values are `^[0-9]{4,10}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the GL account indicating whether it is available for posting transactions.. Valid values are `active|inactive|blocked|pending`',
    `account_type` STRING COMMENT 'The fundamental accounting classification of the account indicating whether it represents assets, liabilities, equity, revenue, or expenses in the financial statements.. Valid values are `asset|liability|equity|revenue|expense`',
    `accounting_method_indicator` STRING COMMENT 'Indicates which oil and gas accounting method applies to this account: successful efforts method or full cost method, as defined by SEC Rule 4-10 and FASB ASC 932.. Valid values are `successful_efforts|full_cost`',
    `afe_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether expenditures posted to this account require an approved Authorization for Expenditure (AFE) for capital project control.',
    `balance_sheet_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this account appears on the balance sheet (true) or profit and loss statement (false).',
    `capitalization_flag` BOOLEAN COMMENT 'Boolean flag indicating whether expenditures posted to this account are capitalized as assets (true) or expensed immediately (false). Critical for CAPEX vs OPEX classification.',
    `chart_of_accounts` STRING COMMENT 'The chart of accounts code identifying which chart of accounts this GL account belongs to. Supports multiple charts for different reporting requirements.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_account` STRING COMMENT 'The consolidation account number used for corporate financial consolidation and elimination entries across multiple legal entities and business units.',
    `cost_element` STRING COMMENT 'The cost element code used in SAP Controlling (CO) module for cost center accounting, internal orders, and profitability analysis. Links GL accounts to cost accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account master record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the account local currency. For multi-currency accounts, this represents the primary account currency.. Valid values are `^[A-Z]{3}$`',
    `depreciation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this account is subject to depreciation, depletion, or amortization calculations for oil and gas assets.',
    `financial_statement_item` STRING COMMENT 'The financial statement line item code that this account maps to for balance sheet and profit and loss statement reporting. Used for financial statement consolidation and SEC reporting.',
    `functional_area` STRING COMMENT 'The functional area classification used for segment reporting and management accounting (e.g., exploration, drilling, production, refining, marketing, administration).',
    `gaap_mapping_code` STRING COMMENT 'The US GAAP account classification code used for mapping this account to GAAP financial statement line items for SEC reporting.',
    `hse_category` STRING COMMENT 'The HSE category classification for accounts related to health, safety, and environmental compliance costs (e.g., environmental remediation, safety equipment, compliance monitoring).',
    `ifrs_mapping_code` STRING COMMENT 'The IFRS account classification code used for mapping this account to IFRS financial statement line items for international reporting.',
    `joint_venture_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this account is used for joint venture accounting and joint interest billing (JIB) transactions under joint operating agreements (JOA).',
    `line_item_display_flag` BOOLEAN COMMENT 'Boolean flag indicating whether individual line items are stored and can be displayed for this account, enabling detailed transaction drill-down.',
    `loe_category` STRING COMMENT 'The lease operating expense category classification for production operating costs (e.g., well operations, facilities maintenance, utilities, labor). Used for LOE tracking and analysis.',
    `modified_by` STRING COMMENT 'The user ID of the person who last modified this GL account master record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account master record was last modified.',
    `open_item_management_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this account is managed on an open item basis, requiring line items to be explicitly cleared rather than simply netting to a balance.',
    `posting_block_flag` BOOLEAN COMMENT 'Boolean flag indicating whether direct posting to this account is blocked, requiring transactions to be posted through subledgers or specific transaction types only.',
    `profit_loss_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this account appears on the profit and loss statement (income statement).',
    `reconciliation_account_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this is a reconciliation account that is automatically posted to from subledgers (accounts receivable, accounts payable, asset accounting).',
    `reserves_category` STRING COMMENT 'The reserves category classification for accounts related to proved reserves, probable reserves, or possible reserves under SPE PRMS and SEC reporting standards.',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this account is subject to SOX internal controls and requires additional review and approval workflows for financial reporting compliance.',
    `tax_category` STRING COMMENT 'The tax category classification code indicating how transactions posted to this account are treated for tax purposes (e.g., taxable revenue, non-taxable, tax-exempt, input tax, output tax).',
    `valid_from_date` DATE COMMENT 'The date from which this GL account becomes valid and available for transaction posting.',
    `valid_to_date` DATE COMMENT 'The date until which this GL account remains valid. After this date, the account is no longer available for new postings. Null indicates no expiration.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'Chart of accounts master record defining every general ledger account used in the oil and gas enterprise financial statements. Captures account number, account description, account type (asset, liability, equity, revenue, expense), financial statement item, account group, balance sheet/P&L indicator, tax category, reconciliation account flag, open item management flag, currency, and IFRS/GAAP mapping. Supports successful efforts and full cost accounting methods per SEC Rule 4-10 and COPAS standards. Integrates with SAP S/4HANA FI-GL module.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`company_code` (
    `company_code_id` BIGINT COMMENT 'Unique identifier for the company code record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Company code setup accountability is essential for legal entity governance. Links entity creation to specific employee for corporate structure changes and audit trail in Oil & Gas multi-entity financi',
    `accounting_method` STRING COMMENT 'Accounting method used for oil and gas exploration and production activities. Successful efforts method capitalizes only costs of successful wells; full cost method capitalizes all exploration costs within a cost center. Determines DD&A (Depreciation, Depletion, and Amortization) calculation and reserves disclosure.. Valid values are `successful_efforts|full_cost`',
    `business_area_required_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether business area assignment is mandatory for financial postings in this company code. Business areas enable cross-company code segment reporting and profitability analysis by line of business (E&P, Refining, Petrochemicals, Marketing).',
    `chart_of_accounts` STRING COMMENT 'Four-character code identifying the chart of accounts assigned to this company code. The COA defines the structure of general ledger (GL) accounts used for recording financial transactions, supporting both statutory and management reporting requirements.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code` STRING COMMENT 'Four-character alphanumeric code uniquely identifying the legal entity or company code within the enterprise organizational structure. Used as the primary business identifier for all financial postings and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `company_name` STRING COMMENT 'Full legal name of the company or legal entity as registered with regulatory authorities. Used for statutory reporting, financial statements, and external communications.',
    `company_status` STRING COMMENT 'Current operational status of the company code. Active indicates normal operations; inactive indicates no current transactions; dormant indicates temporary suspension; liquidation indicates wind-down in progress; merged indicates entity has been consolidated into another company code.. Valid values are `active|inactive|dormant|liquidation|merged`',
    `consolidation_group` STRING COMMENT 'Identifier for the consolidation group or reporting unit to which this company code belongs. Used for multi-level consolidation, segment reporting, and management reporting hierarchies under IFRS 8 and SEC Regulation S-K.',
    `controlling_area` STRING COMMENT 'Four-character code identifying the controlling area to which this company code is assigned. The controlling area is the organizational unit for cost accounting, internal orders, profit center accounting, and profitability analysis. Multiple company codes can share a single controlling area.. Valid values are `^[A-Z0-9]{4}$`',
    `country_of_incorporation` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the jurisdiction where the legal entity is incorporated and registered. Determines applicable tax laws, statutory reporting requirements, and regulatory oversight.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this company code record was first created in the system. Supports audit trail, data lineage, and SOX compliance requirements.',
    `credit_control_area` STRING COMMENT 'Four-character code identifying the credit control area assigned to this company code. Used for managing customer credit limits, credit exposure monitoring, and accounts receivable risk management across one or more company codes.. Valid values are `^[A-Z0-9]{4}$`',
    `effective_from_date` DATE COMMENT 'Date from which this company code became active and available for financial postings. Represents the legal incorporation date or the date the entity was added to the ERP system.',
    `effective_to_date` DATE COMMENT 'Date on which this company code ceased operations or was deactivated for financial postings. Null if the company code is still active. Used for historical reporting and audit trail purposes.',
    `elimination_company_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this company code is used exclusively for intercompany elimination entries during consolidation. True if this is an elimination company; false if it is an operating entity.',
    `field_status_variant` STRING COMMENT 'Four-character code defining the field status control rules for financial document entry in this company code. Determines which fields are required, optional, or suppressed during transaction posting, supporting data quality and SOX compliance.. Valid values are `^[A-Z0-9]{4}$`',
    `fiscal_year_variant` STRING COMMENT 'Two-character code defining the fiscal year calendar structure for this company code, including the number of periods, period start/end dates, and year-end closing rules. Aligns with statutory reporting requirements and internal management reporting cycles.. Valid values are `^[A-Z0-9]{2}$`',
    `gaap_framework` STRING COMMENT 'Primary accounting framework used for statutory financial reporting. IFRS (International Financial Reporting Standards), US GAAP (United States Generally Accepted Accounting Principles), or local GAAP as required by the country of incorporation.. Valid values are `IFRS|US_GAAP|local_GAAP`',
    `intercompany_partner_assignment` STRING COMMENT 'Comma-separated list or structured identifier of intercompany trading partner company codes with which this entity has regular intercompany transactions. Used for intercompany reconciliation, netting, and elimination processes.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this company code record. Supports audit trail and change management requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this company code record was last modified in the system. Supports audit trail, change tracking, and SOX compliance requirements.',
    `legal_entity_type` STRING COMMENT 'Classification of the legal entity structure. IOC (International Oil Company) subsidiary, NOC (National Oil Company) subsidiary, joint venture entity, holding company, special purpose vehicle (SPV), or branch office.. Valid values are `IOC_subsidiary|NOC_subsidiary|joint_venture|holding_company|special_purpose_vehicle|branch`',
    `local_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the functional currency of the company code. All financial transactions are recorded in this currency for statutory reporting and local GAAP compliance.. Valid values are `^[A-Z]{3}$`',
    `posting_period_variant` STRING COMMENT 'Four-character code defining the number of posting periods and special periods (e.g., year-end adjustment periods) for this company code. Controls the opening and closing of accounting periods for transaction posting and period-end close processes.. Valid values are `^[A-Z0-9]{4}$`',
    `profit_center_required_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether profit center assignment is mandatory for financial postings in this company code. Profit centers enable internal management reporting, profitability analysis, and segment performance evaluation.',
    `registered_address_line1` STRING COMMENT 'First line of the legal registered address of the company code as filed with regulatory authorities. Used for statutory correspondence, legal notices, and regulatory filings.',
    `registered_address_line2` STRING COMMENT 'Second line of the legal registered address, typically containing building name, suite number, or additional location details.',
    `registered_city` STRING COMMENT 'City or municipality of the legal registered address.',
    `registered_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the legal registered address.. Valid values are `^[A-Z]{3}$`',
    `registered_postal_code` STRING COMMENT 'Postal or ZIP code of the legal registered address.',
    `registered_state_province` STRING COMMENT 'State, province, or administrative region of the legal registered address. Relevant for jurisdictions with state-level tax or regulatory requirements.',
    `reporting_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the group reporting currency used for consolidated financial statements and management reporting. Transactions are translated from local currency to reporting currency for consolidation purposes.. Valid values are `^[A-Z]{3}$`',
    `sec_cik_number` STRING COMMENT 'Ten-digit Central Index Key (CIK) number assigned by the SEC to identify the registrant for EDGAR filings and public disclosures. Null if not an SEC registrant.. Valid values are `^[0-9]{10}$`',
    `sec_registrant_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this company code is a registrant with the U.S. Securities and Exchange Commission (SEC) and subject to SEC financial disclosure and reserves reporting requirements under Regulation S-X and S-K.',
    `sox_scope_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this company code is within the scope of Sarbanes-Oxley Act (SOX) compliance testing and internal control certification. True if SOX controls apply; false otherwise.',
    `tax_jurisdiction` STRING COMMENT 'Tax authority jurisdiction code or identifier where the company code is registered for tax purposes. Determines applicable tax rates, filing requirements, and compliance obligations for income tax, VAT, sales tax, and other statutory taxes.',
    `valuation_area` STRING COMMENT 'Four-character code defining the organizational level at which material and inventory valuation is performed. Typically aligned with the company code for legal valuation purposes, supporting IFRS IAS 2 Inventories and LIFO/FIFO/weighted average costing methods.. Valid values are `^[A-Z0-9]{4}$`',
    CONSTRAINT pk_company_code PRIMARY KEY(`company_code_id`)
) COMMENT 'Master record for legal entities and company codes within the oil and gas enterprise organizational structure. Captures company code, company name, legal entity type (IOC subsidiary, JV entity, holding company, SPV), country of incorporation, fiscal year variant, chart of accounts assignment, local currency, reporting currency, tax jurisdiction, registered address, consolidation group, elimination company indicator, and intercompany partner assignments. Serves as the foundational organizational unit for all financial postings, statutory reporting, and multi-entity consolidation. Supports intercompany eliminations under IFRS 10, statutory reporting across jurisdictions, and SEC registrant identification. Integrates with SAP S/4HANA FI organizational structure.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique system identifier for the journal entry header record. Primary key for the journal entry transaction.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Journal entries reference term contracts for revenue recognition (ASC 606), contract liability adjustments, accruals, and deferrals. Required for contract accounting, audit trail, and financial statem',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Every journal entry is posted to a legal entity (company code). The existing company_code STRING attribute should be replaced with a proper FK to company_code.company_code_id for referential integrity',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entries can have a default cost center at header level (inherited by lines if not overridden). The existing cost_center STRING attribute should be replaced with a proper FK to cost_center.cost',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SOX compliance and financial audit requirements mandate tracking who created each journal entry. Essential for segregation of duties analysis, fraud detection, and audit trail in Oil & Gas financial r',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Journal entries can be charged against AFEs for capital project accounting. The existing afe_number STRING attribute should be replaced with a proper FK to finance_afe.finance_afe_id to enable AFE-lev',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Journal entries can have a default profit center at header level (inherited by lines if not overridden). The existing profit_center STRING attribute should be replaced with a proper FK to profit_cente',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Spot trade settlements generate journal entries for revenue/cost recognition and mark-to-market adjustments. Required for trade accounting, P&L reconciliation, audit trail, and financial statement pre',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Journal entries can be linked to WBS elements for project-level financial postings. The existing wbs_element STRING attribute should be replaced with a proper FK to wbs_element.wbs_element_id to enabl',
    `allocation_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is the result of an automated cost allocation, distribution, or assessment cycle. True for allocation postings; False for direct manual or transactional postings.',
    `asset_number` STRING COMMENT 'Unique identifier for the fixed asset (well, facility, equipment, pipeline) to which this journal entry relates. Used for asset capitalization, depreciation (DD&A), and asset retirement obligation (ARO) tracking.',
    `batch_input_session` STRING COMMENT 'Name of the batch input session if this journal entry was created through batch processing or mass upload. Used to trace entries back to their batch source for error resolution and audit.',
    `business_area` STRING COMMENT 'Code identifying the business area or segment (Upstream E&P, Midstream, Downstream Refining, Petrochemicals) for segment reporting and internal management reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording the exact date and time when this journal entry record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the document currency in which the journal entry amounts are denominated. All line items within the entry share this currency.. Valid values are `^[A-Z]{3}$`',
    `dd_and_a_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry represents a DD&A posting for oil and gas assets. True for DD&A entries calculated using unit-of-production or straight-line methods; False for other entries.',
    `document_date` DATE COMMENT 'The date printed on the original source document or invoice that gave rise to this journal entry. May differ from posting date. Used for document tracking, audit trail, and reconciliation with external parties.',
    `document_header_text` STRING COMMENT 'Free-form text field providing a brief description or explanation of the business purpose of the journal entry. Visible at header level and inherited by all line items unless overridden.',
    `document_number` STRING COMMENT 'Ten-digit accounting document number assigned by the system or entered manually. Serves as the business identifier for the journal entry within the company code and fiscal year. Unique within company code and fiscal year combination.. Valid values are `^[0-9]{10}$`',
    `document_type` STRING COMMENT 'Two-character code classifying the business transaction type of the journal entry. Controls document number ranges, account types allowed, and posting behavior. Common types: SA (General Ledger), AB (Accounting Document), AF (Depreciation Posting), DR (Customer Invoice), KR (Vendor Invoice), RE (Invoice Receipt), RV (Reversal), ZP (Payment). [ENUM-REF-CANDIDATE: SA|AB|AF|DR|DZ|KA|KG|KN|KR|KZ|RE|RV|WA|WE|ZP — 15 candidates stripped; promote to reference product]',
    `entry_date` DATE COMMENT 'The calendar date on which the journal entry was physically entered into the system by the user. Used for audit trail and internal control monitoring.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert document currency amounts to local company code currency and group reporting currency. Expressed as units of local currency per one unit of document currency. Null if document currency equals local currency.',
    `fiscal_period` STRING COMMENT 'Numeric fiscal period (1-16) within the fiscal year to which this journal entry is posted. Periods 1-12 represent regular monthly periods; periods 13-16 are special periods for year-end adjustments and closing entries.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year to which this journal entry is assigned based on the posting date and the company code fiscal year variant. Used for period-based reporting and year-end closing processes.',
    `functional_area` STRING COMMENT 'Code representing the functional area or business function (Exploration, Drilling, Production, Refining, Marketing, HSE, G&A) for cost of sales and functional expense classification in financial statements.',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry represents an intercompany transaction between two or more company codes within the enterprise. True for intercompany postings requiring elimination in consolidated financial statements.',
    `internal_order` STRING COMMENT 'Alphanumeric identifier for the internal order used to collect costs for a specific purpose (maintenance campaign, turnaround, workover). Used for short-term cost tracking and budget monitoring.',
    `joint_venture_code` STRING COMMENT 'Unique identifier for the joint venture, production sharing agreement (PSA), or joint operating agreement (JOA) to which this journal entry relates. Used for partner billing, cost recovery, and revenue distribution.',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified this journal entry. Null if the entry has never been modified after initial creation. Used for change tracking and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp recording the exact date and time when this journal entry was last modified. Null if never modified. Used for audit trail and version control.',
    `ledger_group` STRING COMMENT 'Identifier for the ledger or ledger group to which this journal entry is posted. Supports parallel accounting for different accounting principles (IFRS, GAAP, tax ledger). Default is leading ledger (0L).',
    `parking_status` STRING COMMENT 'Status indicating whether the journal entry is parked (saved but not yet posted), posted (committed to the general ledger), or held (temporarily suspended pending approval). Parked documents do not update account balances until posted.. Valid values are `parked|posted|held`',
    `partner_share_percentage` DECIMAL(18,2) COMMENT 'Percentage share of costs or revenues allocated to a specific joint venture partner in this journal entry. Used for joint interest billing (JIB) and partner netting calculations. Null for non-JV transactions.',
    `posting_date` DATE COMMENT 'The date on which the journal entry is posted to the general ledger and becomes effective for financial reporting. Determines the fiscal period and fiscal year for the transaction. Used for period-end closing and financial statement preparation.',
    `posting_key_indicator` STRING COMMENT 'Two-digit code that controls the type of posting (debit or credit) and the account type (General Ledger, Accounts Payable, Accounts Receivable, Asset). Inherited by line items but captured at header for summary control.',
    `reference_document` STRING COMMENT 'Free-text field containing the reference number of an external document, invoice, purchase order, Authorization for Expenditure (AFE) number, or other source document that originated this journal entry. Used for cross-referencing and audit trail.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a reversal of a previously posted document. True if this entry reverses another entry; False for original postings.',
    `reversal_reason_code` STRING COMMENT 'Two-digit code indicating the business reason for reversing the original document. Common codes: 01 (Reversal in current period), 02 (Reversal in prior period), 03 (Correction), 04 (Accrual reversal), 05 (Other). Null for non-reversal entries.. Valid values are `01|02|03|04|05`',
    `reversed_document_number` STRING COMMENT 'Document number of the original journal entry that is being reversed by this entry. Populated only when reversal_indicator is True. Establishes audit trail linkage between original and reversing entries.',
    `sox_control_reference` STRING COMMENT 'Reference identifier linking this journal entry to a specific SOX internal control or control activity. Used for SOX compliance testing, audit sampling, and control effectiveness monitoring.',
    `successful_efforts_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is related to successful efforts accounting treatment (capitalization of successful wells, expensing of dry holes). True for successful efforts postings; False otherwise.',
    `trading_partner_company_code` STRING COMMENT 'Company code of the intercompany trading partner for intercompany transactions. Used for intercompany reconciliation and consolidation elimination entries. Null for non-intercompany transactions.',
    `transaction_code` STRING COMMENT 'SAP transaction code (T-code) used to create or post this journal entry. Examples: FB01 (Post Document), FB50 (G/L Account Posting), F-02 (General Posting). Used for audit trail and user activity analysis.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Transactional header record of every general ledger posting in the oil and gas enterprise, representing the atomic document unit of financial accounting. Captures journal entry number, posting date, document date, document type (original entry, accrual, reversal, intercompany, allocation, reclassification), company code, fiscal year, fiscal period, reference document, currency, exchange rate, reversal indicator, parking/hold status, and SOX control reference. Each journal entry contains one or more journal_entry_line items carrying the debit/credit detail. Supports IFRS/GAAP oil and gas accounting including DD&A postings, successful efforts write-offs, production revenue accruals, cost allocations, and intercompany eliminations. Integrates with SAP S/4HANA FI-GL (BKPF header).';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for the journal entry line product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entry lines can be allocated to cost centers for detailed cost tracking. The existing cost_center_code STRING attribute should be replaced with a proper FK to cost_center.cost_center_id to ena',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Every journal entry line posts to a GL account. The existing gl_account_code STRING attribute should be replaced with a proper FK to gl_account.gl_account_id to enable chart of accounts validation, fi',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header document. Links this line item to the overall journal entry batch and document number.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Journal entry lines can be allocated to profit centers for detailed profitability analysis. The existing profit_center_code STRING attribute should be replaced with a proper FK to profit_center.profit',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: JE lines for PO accruals, adjustments, and reclassifications must reference PO for audit trail and accrual reconciliation. Standard accrual accounting for oil & gas procurement.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: JE lines for vendor accruals, adjustments, and manual postings need direct vendor reference for reconciliation and vendor account management. Real month-end close requirement in oil & gas.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Journal entry lines can be linked to WBS elements for project-level cost tracking. The existing wbs_element_code STRING attribute should be replaced with a proper FK to wbs_element.wbs_element_id to e',
    `asset_number` STRING COMMENT 'The fixed asset number for asset-related postings including CAPEX capitalization, depreciation, and asset retirement. Links to wells, facilities, pipelines, and equipment in the asset register.. Valid values are `^[A-Z0-9]{6,12}$`',
    `asset_subnumber` STRING COMMENT 'The subnumber or component identifier within a main asset. Used for tracking individual components or sub-assets within a larger asset structure.. Valid values are `^[A-Z0-9]{1,4}$`',
    `assignment_field` STRING COMMENT 'Free-form assignment field for additional reference information such as well name, lease number, AFE number, or vendor invoice number. Used for reconciliation and drill-down analysis.',
    `baseline_payment_date` DATE COMMENT 'The baseline date from which payment terms are calculated for AP/AR line items. Typically the invoice date or goods receipt date.',
    `business_area_code` STRING COMMENT 'The business area classification for cross-company code segment reporting. Represents upstream (E&P), midstream (transportation), downstream (refining), or petrochemical business segments.. Valid values are `^[A-Z0-9]{4}$`',
    `business_transaction_type` STRING COMMENT 'The business transaction type code that classifies the nature of the posting. Examples include CAPEX, OPEX, LOE, DD&A, revenue, inventory movement, and intercompany transfer.. Valid values are `^[A-Z0-9]{4}$`',
    `clearing_date` DATE COMMENT 'The date on which this open item was cleared through payment, offset, or other settlement. Null for uncleared items.',
    `clearing_document_number` STRING COMMENT 'The document number of the clearing transaction that settled this open item. Links to the payment or offset document.. Valid values are `^[0-9]{10}$`',
    `company_code_currency_amount` DECIMAL(18,2) COMMENT 'The monetary amount of this line item converted to the company code local currency. Used for financial statement preparation and statutory reporting.',
    `company_code_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the local currency of the company code. Used for statutory reporting and consolidation.. Valid values are `^[A-Z]{3}$`',
    `cost_element_code` STRING COMMENT 'The controlling cost element that mirrors the GL account for cost accounting purposes. Used for primary and secondary cost allocation in CO module.. Valid values are `^[0-9]{6,10}$`',
    `debit_credit_indicator` STRING COMMENT 'Explicit indicator of whether this line item represents a debit (D) or credit (C) posting. Derived from posting key but stored for query performance.. Valid values are `D|C`',
    `document_date` DATE COMMENT 'The date of the source document (invoice date, receipt date, contract date). May differ from posting date for backdated or future-dated transactions.',
    `functional_area_code` STRING COMMENT 'The functional area classification for cost-of-sales accounting and functional expense reporting. Distinguishes between production, exploration, development, G&A, and marketing expenses.. Valid values are `^[A-Z0-9]{4,8}$`',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'The monetary amount of this line item converted to the group reporting currency. Supports consolidated financial statements and enterprise-wide analytics.',
    `group_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the reporting currency of the corporate group. Used for consolidated financial reporting.. Valid values are `^[A-Z]{3}$`',
    `internal_order_number` STRING COMMENT 'The internal order number for overhead cost collection and allocation. Used for tracking indirect costs, maintenance orders, and short-term cost objects that are not full projects.. Valid values are `^[A-Z0-9]{6,12}$`',
    `line_item_number` STRING COMMENT 'Sequential line item number within the journal entry document. Determines the ordering and position of this line within the parent entry.',
    `line_item_text` STRING COMMENT 'Descriptive text providing additional context for this journal entry line item. May include vendor name, invoice description, or transaction narrative.',
    `partner_profit_center_code` STRING COMMENT 'The profit center of the trading partner for intercompany profit elimination and transfer pricing analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `payment_terms_code` STRING COMMENT 'The payment terms code for accounts payable and receivable line items. Determines due date calculation and cash discount eligibility.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'The date on which this line item is posted to the general ledger. Determines the fiscal period and year for financial reporting.',
    `posting_key` STRING COMMENT 'Two-digit code that determines whether the line item is a debit or credit posting and controls the account type and field status. Standard values include 40 (debit GL), 50 (credit GL), 01 (debit customer), 11 (credit customer), 21 (debit vendor), 31 (credit vendor).. Valid values are `^[0-9]{2}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity associated with this line item for quantity-based postings. Used for inventory movements, production volumes, and unit cost calculations.',
    `reference_key_1` STRING COMMENT 'First reference key field for customer-defined reference information. Often used for well identifier, lease code, or joint venture partner reference.',
    `reference_key_2` STRING COMMENT 'Second reference key field for customer-defined reference information. May contain AFE number, production month, or cost category code.',
    `reference_key_3` STRING COMMENT 'Third reference key field for customer-defined reference information. Supports additional dimensional analysis such as reservoir zone or product stream.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversal transaction that negated this line item. Null if not reversed.. Valid values are `^[0-9]{10}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this line item has been reversed. True if the posting has been negated by a subsequent reversal document.',
    `tax_code` STRING COMMENT 'The tax code that determines the tax calculation procedure and tax accounts for this line item. Handles sales tax, use tax, VAT, and excise taxes.. Valid values are `^[A-Z0-9]{2,4}$`',
    `tax_jurisdiction_code` STRING COMMENT 'The tax jurisdiction identifier for multi-jurisdictional tax reporting. Captures state, county, and local tax authorities for severance tax and production tax compliance.. Valid values are `^[A-Z0-9]{4,10}$`',
    `trading_partner_code` STRING COMMENT 'The trading partner identifier for intercompany and joint venture transactions. Used for elimination entries in consolidation and partner netting in JIB processing.. Valid values are `^[A-Z0-9]{4,10}$`',
    `transaction_currency_amount` DECIMAL(18,2) COMMENT 'The monetary amount of this line item in the original transaction currency. Positive for debits, negative for credits in some system configurations.',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the original transaction was denominated. May differ from company code currency for foreign currency transactions.. Valid values are `^[A-Z]{3}$`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity field. Common values include BBL (barrels), MCF (thousand cubic feet), MT (metric tons), GAL (gallons), and EA (each).. Valid values are `^[A-Z]{2,3}$`',
    `value_date` DATE COMMENT 'The value date for cash management and bank reconciliation. Represents the date funds are available or debited from bank accounts.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual line item within a general ledger journal entry, capturing the debit or credit posting to a specific GL account with full cost object assignment. Captures line item number, GL account, posting key (debit/credit), amount in transaction currency, amount in company code currency, cost center, profit center, WBS element, internal order, asset number, tax code, assignment field, text, business area, cost element, quantity, unit of measure, and business transaction type. Serves as the unified actual cost record for all financial and controlling postings — including LOE, CAPEX actuals, overhead allocations, and depreciation charges. Supports granular cost allocation across upstream, midstream, and downstream operations and LOE per BOE analysis when joined with production data. Integrates with SAP S/4HANA FI-GL (BSEG) and CO actual line items (COEP).';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`finance_afe` (
    `finance_afe_id` BIGINT COMMENT 'Unique identifier for the Authorization for Expenditure record. Primary key for the finance AFE product.',
    `approved_by_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: AFE approval authority tracking is critical for capital expenditure governance in Oil & Gas. Regulatory and JOA requirements mandate documented approval chains. Links financial authorization to specif',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AFEs can be charged to cost centers for expense tracking and organizational cost allocation. The existing cost_center_code STRING attribute should be replaced with a proper FK to cost_center.cost_cent',
    `employee_id` BIGINT COMMENT 'Reference to the operating company responsible for executing the AFE project and managing day-to-day operations under the Joint Operating Agreement (JOA).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AFEs post to GL accounts for financial statement capitalization. The existing gl_account_code STRING attribute should be replaced with a proper FK to gl_account.gl_account_id to enable AFE capitalizat',
    `superseded_afe_finance_afe_id` BIGINT COMMENT 'Reference to the previous AFE record that this AFE supersedes or revises, enabling tracking of AFE revision history and budget change audit trail.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: AFEs can be linked to WBS elements for project-level cost tracking and integration with project management systems. The existing wbs_element STRING attribute should be replaced with a proper FK to wbs',
    `actual_completion_date` DATE COMMENT 'The actual date on which the AFE project was completed and closed out, enabling variance analysis between planned and actual timelines.',
    `actual_cost_to_date` DECIMAL(18,2) COMMENT 'The cumulative actual costs incurred against this AFE as of the current reporting date, enabling budget-versus-actual variance tracking and over-run detection.',
    `afe_number` STRING COMMENT 'The externally-known unique business identifier for the AFE, used for tracking and reference across joint venture partners and in Joint Interest Billing (JIB) statements.',
    `afe_status` STRING COMMENT 'Current lifecycle status of the AFE, tracking its progression from proposal through approval, execution, and closure. Over-run status indicates actual costs have exceeded the authorized budget. [ENUM-REF-CANDIDATE: proposed|approved|active|in_progress|closed|cancelled|over_run|suspended — 8 candidates stripped; promote to reference product]',
    `afe_type` STRING COMMENT 'Classification of the AFE by project category, indicating the nature of the capital or operating expenditure (e.g., drilling, workover, facility construction, pipeline, Enhanced Oil Recovery (EOR) project, Plug and Abandonment (P&A)). [ENUM-REF-CANDIDATE: drilling|workover|completion|facility_construction|pipeline|eor_project|abandonment|seismic|exploration|development — 10 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'The date on which the AFE was formally approved by the appropriate authority (e.g., joint venture partners, management committee, board of directors), authorizing the expenditure to proceed.',
    `basin_name` STRING COMMENT 'Name of the geological basin or play in which the AFE project is located (e.g., Permian Basin, Gulf of Mexico, North Sea), supporting regional portfolio analysis.',
    `capex_opex_classification` STRING COMMENT 'Classification of the AFE expenditure as Capital Expenditure (CAPEX) for asset acquisition or improvement, Operating Expenditure (OPEX) for routine operations and maintenance, or mixed for projects with both components.. Valid values are `capex|opex|mixed`',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'The contingency reserve included in the AFE budget as a percentage of the base estimate, expressed as a decimal (e.g., 0.1000 for 10%), to cover unforeseen costs and project uncertainties.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the geographic location of the AFE project, supporting regulatory reporting and geographic analysis.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this AFE record was first created in the system, supporting audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the AFE amounts (e.g., USD for United States Dollar, CAD for Canadian Dollar, GBP for British Pound).. Valid values are `^[A-Z]{3}$`',
    `discount_rate` DECIMAL(18,2) COMMENT 'The discount rate used in Net Present Value (NPV) calculations for this AFE, expressed as a decimal (e.g., 0.1000 for 10%), reflecting the companys cost of capital and project risk profile.',
    `estimated_irr` DECIMAL(18,2) COMMENT 'The estimated Internal Rate of Return (IRR) for the project at the time of AFE approval, expressed as a decimal (e.g., 0.1500 for 15%), used to evaluate project economics and prioritize capital investments.',
    `estimated_npv` DECIMAL(18,2) COMMENT 'The estimated Net Present Value (NPV) of the project at the time of AFE approval, representing the discounted cash flow value of expected future revenues minus costs, used for capital allocation decisions.',
    `expected_completion_date` DATE COMMENT 'The planned date for completion of all AFE project activities and final cost reconciliation, used for project scheduling and financial forecasting.',
    `expected_start_date` DATE COMMENT 'The planned date for commencement of the AFE project activities, used for scheduling and resource planning.',
    `field_name` STRING COMMENT 'Name of the oil or gas field to which this AFE relates, enabling aggregation and analysis of capital and operating expenditures by field.',
    `gross_afe_amount` DECIMAL(18,2) COMMENT 'The total authorized budget amount for the entire project before applying working interest, representing 100% of the estimated costs. Used for Joint Interest Billing (JIB) and partner cost allocation.',
    `joa_reference` STRING COMMENT 'Reference to the Joint Operating Agreement (JOA) that governs the joint venture relationship and cost-sharing arrangements for this AFE.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this AFE record was last modified, supporting audit trail and change tracking requirements.',
    `net_afe_amount` DECIMAL(18,2) COMMENT 'The companys net authorized budget amount after applying the working interest percentage (net = gross × WI%). This is the amount the company is authorized to spend on its share of the project.',
    `project_justification` STRING COMMENT 'Business justification and rationale for the AFE project, documenting the strategic objectives, expected benefits, and economic drivers supporting the investment decision.',
    `remaining_budget` DECIMAL(18,2) COMMENT 'The remaining authorized budget available for expenditure, calculated as net AFE amount minus actual cost to date. Negative values indicate budget over-run.',
    `revision_number` STRING COMMENT 'Sequential revision number for the AFE, incremented each time the AFE is revised or supplemented due to scope changes or budget adjustments. Original AFE is revision 0.',
    `risk_category` STRING COMMENT 'Overall risk classification for the AFE project, considering technical, operational, financial, and regulatory risks, used for portfolio risk management and capital allocation decisions.. Valid values are `low|medium|high|critical`',
    `spud_date` DATE COMMENT 'The planned or actual date when drilling operations commence (spud date), marking the start of physical work on a drilling AFE. Null for non-drilling AFEs.',
    `state_province` STRING COMMENT 'State or province where the AFE project is located, supporting sub-national regulatory reporting and tax compliance.',
    `title` STRING COMMENT 'Descriptive title or name of the AFE project, providing a human-readable summary of the work scope (e.g., Smith #1 Drilling and Completion, West Field Waterflood Expansion).',
    `variance_amount` DECIMAL(18,2) COMMENT 'The budget variance amount (net AFE amount minus actual cost to date), with negative values indicating over-run and positive values indicating under-run. Used for financial performance monitoring.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The budget variance expressed as a percentage of the net AFE amount, enabling normalized comparison of over-runs and under-runs across AFEs of different sizes.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The companys Working Interest (WI) ownership percentage in the project, representing the share of costs to be borne and the share of production revenue before royalties. Expressed as a decimal (e.g., 0.375000 for 37.5%).',
    CONSTRAINT pk_finance_afe PRIMARY KEY(`finance_afe_id`)
) COMMENT 'Authorization for Expenditure (AFE) master record representing the formal capital or expense budget authorization for a specific oil and gas project or well. Captures AFE number, AFE title, AFE type (drilling, workover, facility construction, pipeline, EOR project), well or facility reference, operator, working interest (WI) percentage, gross AFE amount, net AFE amount, CAPEX/OPEX classification, AFE status (proposed, approved, active, closed, over-run), approval date, spud date, expected completion date, and cost code breakdown. Integrates with SAP Joint Venture Accounting for partner cost sharing and JIB billing.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` (
    `afe_cost_line_id` BIGINT COMMENT 'Unique identifier for the AFE cost line item. Primary key for the AFE cost line entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: AFE cost line approval authority is required for capital expenditure governance. Links line-item authorization to specific employee for drilling/completion cost control in Oil & Gas AFE management.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: AFE cost lines must link to contracts for commitment tracking, variance analysis, and contract cost control. Critical for drilling rig contracts and service agreements in oil & gas.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `drilling_afe_id` BIGINT COMMENT 'Foreign key reference to the parent AFE document. Links this cost line to its controlling AFE.',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: AFE cost lines for tubulars, casing, completion equipment must reference material master for detailed cost tracking and material planning. Real drilling and completion cost management requirement.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or service provider expected to perform the work or supply the equipment for this cost line.',
    `wbs_element_id` BIGINT COMMENT 'FK to finance.wbs_element',
    `actual_cost_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual costs incurred against this cost line as of the reporting date. Used for budget variance analysis and cost overrun tracking.',
    `approval_status` STRING COMMENT 'Current approval status of this cost line within the AFE approval workflow. Tracks progression through authorization process.. Valid values are `draft|pending_approval|approved|rejected|revised`',
    `approved_date` DATE COMMENT 'Date on which this cost line was approved. Used for audit trail and authorization tracking.',
    `asset_number` STRING COMMENT 'Fixed asset number to which this cost will be capitalized. Used for asset lifecycle tracking and depreciation calculation.',
    `budgeted_gross_amount` DECIMAL(18,2) COMMENT 'Total budgeted cost for this line item before working interest adjustment. Represents 100% of the estimated cost.',
    `budgeted_net_amount` DECIMAL(18,2) COMMENT 'Budgeted cost adjusted for working interest percentage. Represents the companys share of the estimated cost based on WI ownership.',
    `capex_opex_classification` STRING COMMENT 'Classification of the cost line as capital expenditure or operating expenditure. Determines accounting treatment and financial statement presentation per IFRS/GAAP.. Valid values are `capex|opex`',
    `committed_cost` DECIMAL(18,2) COMMENT 'Amount committed via purchase orders or contracts but not yet invoiced. Represents encumbered funds for this cost line.',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'Percentage of base cost allocated as contingency. Used for risk-adjusted budgeting and probabilistic cost estimation.',
    `cost_category` STRING COMMENT 'High-level classification of the cost line item. Determines capitalization treatment and depreciation methodology per IFRS/GAAP oil and gas accounting standards.. Valid values are `tangible|intangible|surface_equipment|subsurface_equipment|overhead|indirect`',
    `cost_code` STRING COMMENT 'Detailed cost code from the chart of accounts. Provides granular classification for financial reporting and cost tracking per COPAS standards.',
    `cost_description` STRING COMMENT 'Detailed narrative description of the cost line item. Explains the specific work, equipment, or service being budgeted.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost line record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this cost line. Supports multi-currency AFE management.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Depreciation method to be applied to capitalized costs. Determines DD&A calculation methodology per IFRS/GAAP oil and gas accounting.. Valid values are `straight_line|units_of_production|declining_balance|none`',
    `forecast_final_cost` DECIMAL(18,2) COMMENT 'Current forecast of the final total cost for this line item. Updated periodically based on actual performance and remaining work estimates.',
    `is_contingency` BOOLEAN COMMENT 'Flag indicating whether this cost line represents contingency budget. Used to separate base estimates from risk reserves.',
    `line_number` STRING COMMENT 'Sequential line number within the AFE document. Used for ordering and referencing specific cost line items.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified this cost line record. Supports change tracking and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost line record was last modified. Supports change tracking and audit trail requirements.',
    `notes` STRING COMMENT 'Free-form notes or comments regarding this cost line. Captures additional context, assumptions, or special instructions.',
    `phase` STRING COMMENT 'Project phase or stage to which this cost line applies. Used for phase-based cost tracking and milestone reporting.. Valid values are `drilling|completion|facilities|workover|abandonment|other`',
    `quantity` DECIMAL(18,2) COMMENT 'Budgeted quantity for this cost line when applicable. Used in conjunction with unit rate to calculate total cost.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantity-based cost lines (e.g., feet, barrels, hours, each). Used when cost is calculated as quantity × unit rate.',
    `unit_rate` DECIMAL(18,2) COMMENT 'Cost per unit of measure. Used to calculate total cost as quantity × unit rate.',
    `useful_life_years` STRING COMMENT 'Estimated useful life in years for depreciation calculation. Used for straight-line and declining balance depreciation methods.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Dollar variance between budgeted and actual costs. Positive values indicate over-budget, negative values indicate under-budget.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between budgeted and actual costs. Calculated as (actual - budget) / budget * 100.',
    `created_by` STRING COMMENT 'User identifier of the person who created this cost line record. Supports audit trail and accountability.',
    CONSTRAINT pk_afe_cost_line PRIMARY KEY(`afe_cost_line_id`)
) COMMENT 'Detailed cost line item within an Authorization for Expenditure (AFE), capturing the budgeted cost breakdown by cost category, cost code, and phase. Captures AFE cost line number, cost category (tangible, intangible, surface equipment, subsurface, overhead), cost code, description, budgeted gross amount, budgeted net amount (WI-adjusted), actual cost to date, committed cost, variance amount, variance percentage, and phase (drilling, completion, facilities). Supports AFE cost tracking, over-run analysis, and CAPEX/OPEX classification per COPAS standards.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key for the budget master data.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Budget approval workflow requires linking approval authority to specific employee for financial control and accountability. Essential for annual planning cycle governance and management reporting in O',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Budgets include revenue forecasts from specific term contracts. Required for revenue budget vs actual analysis, contract performance tracking, forecast accuracy measurement, and management reporting i',
    `company_code_id` BIGINT COMMENT 'FK to finance.company_code',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `finance_afe_id` BIGINT COMMENT 'FK to finance.finance_afe',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `joint_venture_id` BIGINT COMMENT 'The joint venture or JOA (Joint Operating Agreement) identifier if this budget is for a joint venture operation. Links budget to partner cost-sharing and JIB (Joint Interest Billing) processes.',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `wbs_element_id` BIGINT COMMENT 'FK to finance.wbs_element',
    `amount` DECIMAL(18,2) COMMENT 'The approved budget amount in the specified currency. Represents the planned spending or allocation for the fiscal period and organizational unit.',
    `approval_date` DATE COMMENT 'The date on which the budget was formally approved by the authorized approver or budget committee. Used for audit trail and SOX (Sarbanes-Oxley Act) compliance.',
    `asset_class` STRING COMMENT 'The asset class for CAPEX budgets. Represents the type of fixed asset being capitalized (e.g., drilling equipment, production facilities, pipelines, refinery units, IT infrastructure). Used for DD&A (Depreciation Depletion and Amortization) calculations.',
    `budget_category` STRING COMMENT 'Secondary classification or sub-category of the budget. Examples include drilling (exploration, development, workover), production (artificial lift, well services, facilities maintenance), refining (turnaround, catalyst, utilities), or G&A (IT, HR, legal, finance).',
    `budget_number` STRING COMMENT 'Externally-known business identifier for the budget. Human-readable reference number used in budget documentation and approvals.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget. Draft indicates initial preparation, submitted indicates pending approval, approved indicates executive sign-off, active indicates in-force for the fiscal period, closed indicates period end, and superseded indicates replaced by a revised version. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|active|closed|superseded — 7 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the budget by spending category. CAPEX (Capital Expenditure) for long-term asset investments, OPEX (Operating Expenditure) for day-to-day operations, LOE (Lease Operating Expense) for well and field operations, G&A (General and Administrative) for corporate overhead, exploration for prospect evaluation, drilling for well construction, production for field operations, refining for downstream processing, and joint_venture for JOA-governed activities. [ENUM-REF-CANDIDATE: capex|opex|loe|exploration|drilling|production|refining|g&a|joint_venture — 9 candidates stripped; promote to reference product]',
    `business_unit` STRING COMMENT 'The business unit or division responsible for this budget. Examples include Upstream E&P, Midstream, Downstream Refining, Petrochemicals, or regional operating divisions.',
    `commodity_assumption` STRING COMMENT 'The commodity price assumption used in budget planning. Captures assumed prices for WTI (West Texas Intermediate), Brent crude, natural gas (Henry Hub), NGL (Natural Gas Liquids), or refined products. Critical for revenue and NPV (Net Present Value) / IRR (Internal Rate of Return) calculations.',
    `contingency_percent` DECIMAL(18,2) COMMENT 'The contingency percentage included in the budget to account for uncertainty and risk. Common in CAPEX and drilling budgets. Expressed as a percentage of the base budget amount.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount (e.g., USD, EUR, GBP). Supports multi-currency budgeting and consolidation.. Valid values are `^[A-Z]{3}$`',
    `effective_from_date` DATE COMMENT 'The date from which this budget becomes effective and active for spending control and variance tracking.',
    `effective_to_date` DATE COMMENT 'The date on which this budget expires or is superseded. Nullable for open-ended budgets that remain active until explicitly closed.',
    `escalation_rate` DECIMAL(18,2) COMMENT 'The annual cost escalation or inflation rate assumed in multi-year budgets. Expressed as a percentage. Used to adjust future-year budget amounts for expected cost inflation.',
    `facility_name` STRING COMMENT 'The facility or plant name for facility-specific budgets (e.g., refinery, petrochemical plant, FPSO (Floating Production Storage and Offloading), gas processing plant, terminal). Links budget to downstream and midstream assets.',
    `field_name` STRING COMMENT 'The oil or gas field name for production and LOE (Lease Operating Expense) budgets. Links budget to specific upstream assets and reserves.',
    `fiscal_period` STRING COMMENT 'The fiscal period within the fiscal year (e.g., Q1, Q2, January, February). Supports quarterly and monthly budget allocation and tracking.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget applies. Four-digit year (e.g., 2024) representing the annual or multi-year planning period.',
    `last_modified_by` STRING COMMENT 'The user or system identifier of the person who last modified this budget record. Supports change management and audit requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was last modified. Used for change tracking and audit trail.',
    `narrative` STRING COMMENT 'Free-text description or justification for the budget. Captures business rationale, strategic objectives, assumptions, and key drivers (e.g., drilling program scope, production targets, commodity price assumptions, cost inflation factors).',
    `owner` STRING COMMENT 'The name or identifier of the budget owner or responsible manager. The individual accountable for budget execution and variance management.',
    `production_volume_assumption` STRING COMMENT 'The production volume assumption used in budget planning. Captures assumed production rates in BOPD (Barrels of Oil Per Day), MCFD (Thousand Cubic Feet per Day), or BOE (Barrel of Oil Equivalent). Used for LOE per BOE calculations and revenue forecasting.',
    `version` STRING COMMENT 'Version of the budget indicating whether it is the original approved budget, a revised budget, a forecast update, or a supplemental allocation. Supports budget change management and variance analysis.. Valid values are `original|revised|forecast|supplemental|reforecast|final`',
    `well_name` STRING COMMENT 'The well name or API well number for well-specific budgets (e.g., drilling, completion, workover, P&A (Plug and Abandonment) budgets). Links budget to individual wellbore assets.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'The working interest percentage for joint venture budgets. Represents the companys share of costs and operations under the JOA (Joint Operating Agreement). Expressed as a percentage (e.g., 35.50 for 35.5%).',
    `created_by` STRING COMMENT 'The user or system identifier of the person who created this budget record. Supports accountability and audit requirements.',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Annual or multi-year financial budget master record for the oil and gas enterprise, capturing approved spending plans by business unit, cost center, and GL account. Captures budget ID, budget version (original, revised, forecast), budget type (CAPEX, OPEX, LOE, G&A, exploration), fiscal year, company code, cost center, profit center, WBS element, budget amount, currency, approval status, approval date, approved by, and budget narrative. Supports CAPEX/OPEX planning cycles, LOE budgeting per BOE, and NPV/IRR project economics. Integrates with SAP S/4HANA CO-OM-CEL budget management.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique identifier for the budget line item record. Primary key for the budget line entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Budget line approval authority is required for detailed budget governance. Links line-item authorization to specific employee for OPEX/CAPEX budget control in Oil & Gas annual planning.',
    `asset_facility_id` BIGINT COMMENT 'Reference to a production facility, refinery, or processing plant for facility-level budget tracking. Supports OPEX budgeting for midstream and downstream assets.',
    `budget_id` BIGINT COMMENT 'Reference to the parent budget header that this line item belongs to. Links to the master budget record containing overall budget metadata.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget lines are allocated to cost centers for departmental budget planning. The existing cost_center STRING attribute should be replaced with a proper FK to cost_center.cost_center_id to enable cost ',
    `field_id` BIGINT COMMENT 'Reference to the oil or gas field for production-related budget lines. Links budget to specific upstream assets for LOE per BOE tracking and field-level economics.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Budget lines can be planned against AFEs for capital project budget planning. The existing afe_number STRING attribute should be replaced with a proper FK to finance_afe.finance_afe_id to enable AFE b',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Budget lines are planned against GL accounts. The existing gl_account STRING attribute should be replaced with a proper FK to gl_account.gl_account_id to enable budget vs. actual reporting by account ',
    `joint_venture_id` BIGINT COMMENT 'Reference to the joint venture or partnership for joint interest billing and partner cost allocation. Critical for Production Sharing Agreement (PSA) and Joint Operating Agreement (JOA) budget management.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budget lines are allocated to profit centers for segment-level budget planning. The existing profit_center STRING attribute should be replaced with a proper FK to profit_center.profit_center_id to ena',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Budget lines can be allocated to WBS elements for project-level budget planning. The existing wbs_element STRING attribute should be replaced with a proper FK to wbs_element.wbs_element_id to enable p',
    `well_asset_id` BIGINT COMMENT 'Reference to a specific well for well-level budget tracking. Used for drilling and completion AFE budgets and per-well operating expense allocation.',
    `allocation_basis` STRING COMMENT 'The method used to allocate or phase the budget amount. Common bases include per Barrel of Oil Equivalent (BOE), per well, per unit throughput, per employee, fixed amount, or percentage allocation.. Valid values are `per_BOE|per_well|per_unit_throughput|per_employee|fixed|percentage`',
    `allocation_quantity` DECIMAL(18,2) COMMENT 'The quantity or volume used in conjunction with the allocation basis to calculate the budget amount. For example, forecasted BOE production or number of wells.',
    `allocation_unit` STRING COMMENT 'The unit of measure for the allocation quantity. Examples include Barrel of Oil Equivalent (BOE), Barrels of Oil Per Day (BOPD), Thousand Cubic Feet per Day (MCFD), wells, employees, units, or percent. [ENUM-REF-CANDIDATE: BOE|BOPD|MCFD|wells|employees|units|percent — 7 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'The date on which this budget line was formally approved by the authorized budget owner or management committee.',
    `asset_class` STRING COMMENT 'The fixed asset class for CAPEX budget lines. Used for depreciation calculation and asset lifecycle management. Relevant for drilling rigs, production facilities, pipelines, and refining equipment.. Valid values are `^[A-Z0-9]{4,8}$`',
    `comments` STRING COMMENT 'Free-text comments or notes providing additional context, justification, or assumptions for this budget line. Supports budget review and variance analysis.',
    `cost_element` STRING COMMENT 'The cost element code representing the nature of the expense or revenue. Used for cost center accounting and profitability analysis.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget line record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the budget amounts (e.g., USD, EUR, GBP). Supports multi-currency budget planning.. Valid values are `^[A-Z]{3}$`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for this budget line. Typically 1-12 representing monthly budget phasing.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget line applies. Represents the annual financial planning period.',
    `functional_area` STRING COMMENT 'The business functional area or operational domain to which this budget line applies. Aligns with core oil and gas business processes. [ENUM-REF-CANDIDATE: Exploration|Drilling|Production|Refining|Petrochemicals|Marketing|HSE|G&A — 8 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'The user ID or name of the individual who last modified this budget line record. Supports audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget line record was last modified. Tracks the most recent update for change management and audit purposes.',
    `planned_amount` DECIMAL(18,2) COMMENT 'The original planned budget amount for this line item and fiscal period. Represents the initial spending authorization before any revisions.',
    `revised_amount` DECIMAL(18,2) COMMENT 'The revised budget amount after adjustments, reallocations, or supplemental authorizations. Reflects the current approved spending limit.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'The working interest percentage for this budget line in joint venture operations. Represents the ownership share and cost-bearing obligation.',
    `created_by` STRING COMMENT 'The user ID or name of the individual who created this budget line record. Supports audit trail and accountability.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Granular budget line item record within a financial budget, capturing the period-level spending plan by GL account, cost element, and organizational unit. Captures budget line ID, budget ID reference, fiscal period, GL account, cost element, cost center, profit center, WBS element, planned amount, revised amount, currency, and allocation basis (per BOE, per well, per unit throughput). Supports monthly budget phasing, variance analysis against actuals, and LOE per BOE tracking for production cost benchmarking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'Unique identifier for the WBS element. Primary key for the WBS element master record.',
    `asset_class_id` BIGINT COMMENT 'Foreign key reference to the fixed asset class to which this WBS element will be capitalized upon settlement. Determines depreciation methods and useful life for Asset Under Construction (AUC) settlement.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: WBS elements belong to legal entities. The existing company_code STRING attribute should be replaced with a proper FK to company_code.company_code_id to enable legal entity-level project hierarchies a',
    `investment_program_id` BIGINT COMMENT 'Foreign key reference to the investment program or capital portfolio under which this WBS element is classified. Used for strategic capital allocation and portfolio management reporting.',
    `parent_wbs_element_id` BIGINT COMMENT 'Foreign key reference to the parent WBS element in the hierarchical project structure. Null for top-level WBS elements directly under the project definition.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee who is the designated project manager responsible for this WBS element. Used for accountability and communication routing.',
    `profit_center_id` BIGINT COMMENT 'Foreign key reference to the profit center responsible for this WBS element. Used for internal profitability analysis and segment reporting.',
    `project_definition_id` BIGINT COMMENT 'Foreign key reference to the parent project definition under which this WBS element is organized. Links the WBS element to the overall project structure.',
    `cost_center_id` BIGINT COMMENT 'Foreign key reference to the cost center responsible for managing and executing this WBS element. Used for organizational accountability and cost allocation.',
    `settlement_receiver_id` BIGINT COMMENT 'Foreign key reference to the target object (fixed asset, cost center, or profitability segment) that will receive the settled costs from this WBS element. Used for asset capitalization and cost allocation.',
    `tertiary_wbs_last_modified_by_user_employee_id` BIGINT COMMENT 'The system user ID of the person who most recently modified this WBS element record. Used for audit trails and change management.',
    `actual_cost` DECIMAL(18,2) COMMENT 'The cumulative actual costs posted to this WBS element from purchase orders, invoices, time sheets, and other cost documents. Used for cost variance analysis and earned value management.',
    `actual_finish_date` DATE COMMENT 'The actual date when work on this WBS element was completed. Null if work is still in progress. Used for project closeout and performance analysis.',
    `actual_start_date` DATE COMMENT 'The actual date when work on this WBS element commenced. Null if work has not yet started. Used for schedule variance analysis.',
    `afe_approval_date` DATE COMMENT 'The date when the Authorization for Expenditure (AFE) was formally approved by the appropriate authority. Used for audit trails and compliance verification.',
    `afe_number` STRING COMMENT 'The Authorization for Expenditure (AFE) document number that authorizes spending on this WBS element. Critical for joint venture billing and partner cost allocation in oil and gas operations.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `available_budget` DECIMAL(18,2) COMMENT 'The remaining budget available for this WBS element, calculated as budget_amount minus actual_cost minus committed_cost. Used for budget control and spending authorization.',
    `billing_element_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this WBS element is used as a billing element for customer projects or joint venture partner billing. Enables revenue recognition and Joint Interest Billing (JIB) processes.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The total approved budget allocated to this WBS element for Capital Expenditure (CAPEX) tracking. Represents the authorized spending limit per the Authorization for Expenditure (AFE).',
    `budget_profile_code` STRING COMMENT 'Code identifying the budget control profile that governs budget availability checking and tolerance rules for this WBS element. Determines whether hard or soft budget controls are enforced.. Valid values are `^[A-Z0-9]{1,10}$`',
    `capitalization_date` DATE COMMENT 'The date when the Asset Under Construction (AUC) accumulated on this WBS element was capitalized to a fixed asset and depreciation commenced. Used for Depreciation Depletion and Amortization (DD&A) calculations.',
    `closure_date` DATE COMMENT 'The date when the WBS element was formally closed in the system after final settlement and administrative closeout. No further transactions are permitted after closure.',
    `committed_cost` DECIMAL(18,2) COMMENT 'The total value of purchase orders, contracts, and other commitments that have been issued against this WBS element but not yet invoiced. Used for funds availability checking and cash flow forecasting.',
    `controlling_area_code` STRING COMMENT 'The controlling area code under which this WBS element is managed for cost accounting purposes. Links the project to the organizational unit for internal cost management.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this WBS element record was first created in the system. Used for audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which budget and cost amounts for this WBS element are denominated. Used for multi-currency project accounting and consolidation.. Valid values are `^[A-Z]{3}$`',
    `functional_area` STRING COMMENT 'High-level business segment classification for this WBS element. Used for segment reporting and strategic capital allocation analysis.. Valid values are `upstream|midstream|downstream|corporate`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this WBS element record was most recently modified. Used for change tracking and audit compliance.',
    `planned_finish_date` DATE COMMENT 'The scheduled date when work on this WBS element is planned to be completed. Used for project milestone tracking and critical path analysis.',
    `planned_start_date` DATE COMMENT 'The scheduled date when work on this WBS element is planned to begin. Used for project scheduling and resource planning.',
    `planning_profile_code` STRING COMMENT 'Code identifying the planning profile that controls which planning methods and cost element groups are permitted for this WBS element. Used for project cost planning and forecasting.. Valid values are `^[A-Z0-9]{1,10}$`',
    `plant_code` STRING COMMENT 'The plant or facility code where the project work for this WBS element is being performed. Used for location-based cost tracking and asset assignment.. Valid values are `^[A-Z0-9]{4}$`',
    `project_type` STRING COMMENT 'Classification of the project type for this WBS element. Indicates the nature of capital expenditure activity being tracked. [ENUM-REF-CANDIDATE: exploration_and_production|engineering_procurement_construction|front_end_engineering_design|facility_upgrade|turnaround|drilling_and_completion|pipeline_construction|fpso_deployment|refinery_expansion|well_workover — 10 candidates stripped; promote to reference product]',
    `settlement_rule_type` STRING COMMENT 'Defines the target object type to which costs accumulated on this WBS element will be settled upon project completion. Fixed asset settlement creates Asset Under Construction (AUC) entries that capitalize to the balance sheet.. Valid values are `fixed_asset|cost_center|profitability_segment|none`',
    `statistical_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this WBS element is statistical (used for planning and reporting only) or real (used for actual cost posting). Statistical WBS elements do not accept actual postings.',
    `technical_completion_date` DATE COMMENT 'The date when the WBS element was marked as technically complete, indicating that all planned work has been finished and no further costs should be posted. Precedes final settlement and closure.',
    `wbs_element_code` STRING COMMENT 'The externally-known alphanumeric code that uniquely identifies the WBS element within the project hierarchy. Used as the business identifier for project cost tracking and Authorization for Expenditure (AFE) management.. Valid values are `^[A-Z0-9]{1,24}$`',
    `wbs_element_description` STRING COMMENT 'Detailed textual description of the WBS element, explaining the scope of work, deliverables, or cost object purpose within the project structure.',
    `wbs_element_status` STRING COMMENT 'Current lifecycle status of the WBS element. Controls whether costs can be posted and whether the element is available for planning and execution activities.. Valid values are `created|released|technically_complete|closed`',
    `wbs_level` STRING COMMENT 'Numeric indicator of the hierarchical level of this WBS element within the project structure. Level 1 represents top-level elements, with increasing numbers for deeper nesting.',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Work Breakdown Structure (WBS) element master record representing a hierarchical project cost object used to plan, track, and control CAPEX expenditures on oil and gas projects including wells, pipelines, FPSOs, and processing facilities. Captures WBS element code, description, project definition, WBS level, parent WBS element, project type (E&P, EPC, FEED, facility upgrade, turnaround), responsible cost center, planned start/finish dates, actual start/finish dates, budget amount, actual cost, committed cost, available budget, project status (created, released, technically complete, closed), settlement rule (to fixed asset or cost center), and investment program assignment. Integrates with SAP S/4HANA PS (Project System) module and supports AUC (Asset Under Construction) settlement to fixed assets upon project completion.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`actual_cost` (
    `actual_cost_id` BIGINT COMMENT 'Unique identifier for the actual cost transaction record. Primary key for the actual cost entity.',
    `asset_facility_id` BIGINT COMMENT 'The unique identifier of the facility (production platform, processing plant, refinery, terminal) to which this actual cost is attributed, if applicable.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Actual costs frequently relate to term contracts (transportation, processing, storage services). Required for contract profitability analysis, variance analysis, accrual validation, and contract perfo',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Actual costs belong to a legal entity. The existing company_code STRING attribute should be replaced with a proper FK to company_code.company_code_id for legal entity consolidation and financial state',
    `cost_object_id` BIGINT COMMENT 'The unique identifier of the specific cost object (cost center code, WBS element number, AFE number, internal order number) to which this actual cost is assigned.',
    `drilling_well_id` BIGINT COMMENT 'The unique identifier of the well to which this actual cost is attributed, if applicable. Used for well-level cost tracking and LOE per BOE calculations.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Actual costs are tracked against AFEs for capital project cost control. The existing afe_number STRING attribute should be replaced with a proper FK to finance_afe.finance_afe_id to enable variance an',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Actual costs post to GL accounts. The existing gl_account STRING attribute should be replaced with a proper FK to gl_account.gl_account_id to enable joining to chart of accounts master data and enforc',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Actual costs from GR postings must link for inventory valuation, cost of goods tracking, and material cost accounting. Standard inventory accounting requirement for oil & gas materials.',
    `partner_id` BIGINT COMMENT 'The unique identifier of the joint venture partner to whom a portion of this actual cost should be allocated, if applicable. Used for joint interest billing and partner netting.',
    `employee_id` BIGINT COMMENT 'The unique identifier of the employee whose labor or expenses generated this actual cost, if applicable (e.g., payroll postings, timesheets, expense reports).',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Actual costs can be allocated to profit centers for profitability analysis. The existing profit_center STRING attribute should be replaced with a proper FK to profit_center.profit_center_id to enable ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Actual costs must trace to originating PO for three-way match, audit trail, variance analysis, and procurement cost reconciliation. Core AP/procurement integration for oil & gas operations.',
    `rig_id` BIGINT COMMENT 'Foreign key linking to drilling.rig. Business justification: Actual costs post to rigs for rig-specific cost tracking and day rate reconciliation. New attribute needed; no existing candidate. Real business process for rig cost management.',
    `service_entry_sheet_id` BIGINT COMMENT 'Foreign key linking to procurement.service_entry_sheet. Business justification: Actual costs from services must link to SES for service cost tracking, accrual management, and drilling/completion service cost accounting. Real service procurement requirement in oil & gas.',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Spot trades incur direct costs (brokerage, inspection, demurrage) requiring capture for accurate P&L calculation, trade profitability analysis, mark-to-market validation, and trader performance measur',
    `vendor_id` BIGINT COMMENT 'The unique identifier of the vendor or supplier from whom goods or services were procured, if this actual cost originated from a vendor invoice or purchase order.',
    `accrual_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this actual cost is an accrual posting (estimated cost posted before invoice receipt). True if accrual, False if actual invoice or payment.',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value of the actual cost in the transaction currency. Represents the total cost posted for this line item.',
    `business_area` STRING COMMENT 'The business area or segment to which this actual cost is assigned for segment reporting (e.g., Upstream, Midstream, Downstream, Petrochemicals).',
    `business_transaction_type` STRING COMMENT 'The type of business transaction that generated this actual cost posting. Indicates the originating business process or module. [ENUM-REF-CANDIDATE: goods_receipt|invoice_receipt|payroll_posting|depreciation|overhead_allocation|internal_transfer|accrual|reversal|manual_adjustment — 9 candidates stripped; promote to reference product]',
    `capitalization_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this actual cost is capitalized to a fixed asset (True) or expensed in the current period (False). Critical for CAPEX vs OPEX classification.',
    `cost_allocation_method` STRING COMMENT 'The method used to allocate or assign this actual cost to the cost object (direct assignment, overhead allocation, activity-based costing, etc.).. Valid values are `direct|allocation|apportionment|activity_based`',
    `cost_category` STRING COMMENT 'The high-level cost category classification for oil and gas financial management. CAPEX (Capital Expenditure) for capital projects, OPEX (Operating Expenditure) for operational costs, LOE (Lease Operating Expense) for well-level operating costs, DD&A (Depreciation Depletion and Amortization) for non-cash charges. [ENUM-REF-CANDIDATE: capex|opex|loe|dd_and_a|overhead|indirect|direct — 7 candidates stripped; promote to reference product]',
    `cost_document_number` STRING COMMENT 'The externally-known unique document number assigned to this actual cost posting in the controlling module. Used for audit trail and reconciliation.',
    `cost_element` STRING COMMENT 'The cost element code that classifies the nature of the cost (labor, materials, services, depreciation, etc.). Maps to the chart of accounts in financial accounting.',
    `cost_object_type` STRING COMMENT 'The type of cost object against which the actual cost is posted. Determines the cost allocation structure in the oil and gas enterprise. [ENUM-REF-CANDIDATE: cost_center|wbs_element|afe|internal_order|production_order|sales_order|project|asset — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this actual cost record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the actual cost amount is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `depreciation_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this actual cost represents a depreciation, depletion, or amortization charge. True for DD&A postings, False otherwise.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when the actual cost was posted. Typically ranges from 1 to 12 for regular periods, with special periods for year-end adjustments.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the actual cost was posted, used for period-based financial reporting and analysis.',
    `functional_area` STRING COMMENT 'The functional area classification for this actual cost (e.g., Exploration, Production, Refining, Marketing, Administration) used for cost-of-sales accounting and functional reporting.',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this actual cost involves an intercompany transaction between legal entities within the enterprise. True if intercompany, False otherwise.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this actual cost record was last modified. Used for change tracking and audit compliance.',
    `net_cost_amount` DECIMAL(18,2) COMMENT 'The net cost amount after applying working interest percentage or other allocation factors. Represents the companys share of the total cost.',
    `originating_module` STRING COMMENT 'The SAP module or functional area that originated this actual cost posting (FI=Financial Accounting, CO=Controlling, MM=Materials Management, PM=Plant Maintenance, PS=Project System, PP=Production Planning, SD=Sales and Distribution, HR=Human Resources). [ENUM-REF-CANDIDATE: FI|CO|MM|PM|PS|PP|SD|HR — 8 candidates stripped; promote to reference product]',
    `posting_date` DATE COMMENT 'The date when the actual cost was posted to the controlling ledger. Represents the business event date for the cost transaction.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity associated with the actual cost transaction, such as hours worked, barrels produced, or units consumed. Used for unit cost analysis.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this actual cost posting is a reversal of a previous posting. True if this is a reversal transaction, False otherwise.',
    `reversed_document_number` STRING COMMENT 'The cost document number of the original posting that this transaction reverses, if this is a reversal. Null if not a reversal.',
    `source_document_line_item` STRING COMMENT 'The line item number within the source document that generated this actual cost. Provides granular traceability to the specific line in the originating transaction.',
    `source_document_number` STRING COMMENT 'The unique document number of the originating source document (e.g., invoice number, purchase order number, timesheet ID). Enables traceability to source transactions.',
    `source_document_type` STRING COMMENT 'The type of source document that originated this actual cost (e.g., purchase order, invoice, timesheet, material document). Used for drill-back and audit trail.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity field (e.g., HR for hours, BBL for barrels, EA for each, TON for tons). Standardized per industry conventions.',
    `variance_category` STRING COMMENT 'The category of variance analysis for which this actual cost is compared (budget variance, AFE variance, forecast variance, standard cost variance, prior year comparison).. Valid values are `budget|forecast|afe|standard_cost|prior_year`',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The working interest percentage applicable to this actual cost for joint venture cost allocation. Represents the ownership share of the cost object.',
    CONSTRAINT pk_actual_cost PRIMARY KEY(`actual_cost_id`)
) COMMENT 'Transactional record of actual costs posted against cost objects (cost centers, WBS elements, AFEs, internal orders) in the oil and gas enterprise. Captures actual cost document number, posting date, fiscal period, cost object type, cost object reference, cost element, GL account, amount, currency, quantity, unit of measure, business transaction type (goods receipt, invoice, payroll, depreciation), source document reference, and originating module. Supports LOE tracking per BOE, CAPEX vs OPEX actuals monitoring, and variance analysis against AFE budgets. Integrates with SAP S/4HANA CO actual cost line items (COEP).';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key for the fixed asset master data.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Fixed assets belong to legal entities. The existing company_code STRING attribute should be replaced with a proper FK to company_code.company_code_id to enable legal entity-level asset registers and f',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fixed assets can be assigned to cost centers for depreciation expense allocation. The existing cost_center STRING attribute should be replaced with a proper FK to cost_center.cost_center_id to enable ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Fixed asset creation accountability is essential for asset master data governance. Links asset capitalization to specific employee for property accounting and audit trail in Oil & Gas fixed asset mana',
    `lease_id` BIGINT COMMENT 'FK to land.lease',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Fixed assets can be capitalized from WBS elements (project-to-asset settlement). The existing wbs_element STRING attribute should be replaced with a proper FK to wbs_element.wbs_element_id to enable t',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation, depletion, and amortization accumulated since capitalization. Calculated per successful efforts or full cost method for oil and gas properties.',
    `acquisition_value` DECIMAL(18,2) COMMENT 'Original acquisition or construction cost of the fixed asset. Represents the total capitalized cost including direct costs, allocated overhead, and capitalized interest.',
    `api_well_number` STRING COMMENT 'Unique 14-digit API well identifier assigned by regulatory authorities. Standard identifier for well assets used across industry for regulatory reporting and data exchange.. Valid values are `^[0-9]{2}-[0-9]{3}-[0-9]{5}-[0-9]{2}-[0-9]{2}$`',
    `asset_class` STRING COMMENT 'Classification of the fixed asset type. Determines depreciation method, useful life, and financial reporting treatment per IFRS/GAAP oil and gas accounting standards.. Valid values are `oil_and_gas_properties|machinery_and_equipment|buildings_and_structures|vehicles|office_equipment|land`',
    `asset_description` STRING COMMENT 'Detailed business description of the fixed asset including make, model, location, and operational purpose.',
    `asset_number` STRING COMMENT 'External business identifier for the fixed asset. Unique asset tag or registration number used across the enterprise for asset tracking and reporting.. Valid values are `^[A-Z0-9]{8,12}$`',
    `asset_retirement_obligation_amount` DECIMAL(18,2) COMMENT 'Estimated present value of future plug and abandonment costs for oil and gas wells and facilities. Capitalized as part of asset cost and accreted over asset life per GAAP ASC 410.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset. Determines whether depreciation is active, asset is capitalized, or asset is subject to impairment testing. [ENUM-REF-CANDIDATE: active|under_construction|retired|abandoned|disposed|impaired|held_for_sale — 7 candidates stripped; promote to reference product]',
    `asset_sub_class` STRING COMMENT 'Detailed sub-classification within the asset class. Examples include producing wells, non-producing wells, gathering systems, processing plants, FPSO units, compressor stations, refineries, pipelines, drilling rigs, and support facilities.',
    `capitalization_date` DATE COMMENT 'Date when the asset was placed in service and capitalized on the balance sheet. Marks the start of depreciation and depletion calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset record was first created in the system. Used for audit trail and data lineage tracking.',
    `cumulative_production` DECIMAL(18,2) COMMENT 'Total production to date in depletion units. Used as numerator in unit of production depreciation calculation to determine depletion rate.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts. Used for multi-currency consolidation and foreign exchange translation.. Valid values are `^[A-Z]{3}$`',
    `depletion_unit` STRING COMMENT 'Unit of measure for unit of production depreciation calculation. Typically BOE (Barrel of Oil Equivalent) for oil and gas properties, used to calculate depletion rate based on production volumes.. Valid values are `BOE|MMBOE|MCF|MMCF|BBL|TONNES`',
    `depreciation_area_book` DECIMAL(18,2) COMMENT 'Net book value in the book depreciation area for financial statement reporting per IFRS or GAAP.',
    `depreciation_area_ifrs` DECIMAL(18,2) COMMENT 'Net book value in the IFRS depreciation area for international financial reporting and consolidation.',
    `depreciation_area_tax` DECIMAL(18,2) COMMENT 'Net book value in the tax depreciation area for tax return preparation and deferred tax calculation.',
    `depreciation_key` STRING COMMENT 'Depreciation method applied to the asset. Unit of production is standard for oil and gas producing properties; straight-line for facilities and equipment.. Valid values are `unit_of_production|straight_line|declining_balance|sum_of_years_digits|no_depreciation`',
    `estimated_ultimate_recovery` DECIMAL(18,2) COMMENT 'Total estimated recoverable reserves in depletion units for oil and gas producing properties. Used as denominator in unit of production depreciation calculation. Aligned with SEC proved reserves classification.',
    `facility_type` STRING COMMENT 'Type of facility asset such as FPSO, platform, compressor station, processing plant, refinery unit, pipeline, or storage terminal. Used for asset classification and maintenance planning.',
    `field_name` STRING COMMENT 'Name of the oil or gas field where the asset is located. Used for reserves allocation, production reporting, and joint venture accounting.',
    `geographic_location` STRING COMMENT 'Geographic location of the asset including country, state/province, and basin. Used for regulatory reporting, tax jurisdiction determination, and portfolio segmentation.',
    `impairment_indicator_flag` BOOLEAN COMMENT 'Indicates whether the asset has been identified for impairment testing due to triggering events such as commodity price decline, reserves downgrade, or operational issues.',
    `impairment_loss_amount` DECIMAL(18,2) COMMENT 'Cumulative impairment loss recognized when the carrying amount exceeds the recoverable amount. Required for SEC ceiling test compliance for oil and gas properties under full cost method.',
    `last_depreciation_run_date` DATE COMMENT 'Date of the most recent depreciation calculation run. Used to track periodic depreciation posting and ensure timely financial close.',
    `last_impairment_test_date` DATE COMMENT 'Date of the most recent impairment test performed on the asset. Required quarterly for full cost pool ceiling test and annually for successful efforts method.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset record was last updated. Used for change tracking and SOX compliance audit trails.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current net book value of the fixed asset calculated as acquisition value minus accumulated depreciation. Represents the carrying amount on the balance sheet.',
    `net_revenue_interest_percentage` DECIMAL(18,2) COMMENT 'Ownership percentage representing the companys share of production revenue after royalties and overriding royalty interests. Used for revenue allocation and reserves valuation.',
    `operator_flag` BOOLEAN COMMENT 'Indicates whether the company is the operator of the asset. Operator is responsible for day-to-day operations, AFE preparation, and joint interest billing.',
    `operator_name` STRING COMMENT 'Name of the operating company responsible for the asset if the company is non-operated. Used for joint venture partner tracking and JIB reconciliation.',
    `retirement_date` DATE COMMENT 'Date when the asset was retired, disposed, or abandoned. Marks the end of depreciation and triggers gain/loss calculation.',
    `retirement_proceeds` DECIMAL(18,2) COMMENT 'Cash or fair value received from asset sale or disposal. Used to calculate gain or loss on retirement.',
    `retirement_type` STRING COMMENT 'Type of asset retirement transaction. Determines accounting treatment for gain/loss recognition and plug and abandonment (P&A) cost capitalization.. Valid values are `sale|scrap|abandonment|transfer|partial_retirement`',
    `sec_proved_property_classification` STRING COMMENT 'SEC reserves classification for oil and gas properties: PDP (Proved Developed Producing), PDNP (Proved Developed Non-Producing), PUD (Proved Undeveloped). Required for SEC financial disclosure and ceiling test compliance.. Valid values are `PDP|PDNP|PUD|non_proved|not_applicable`',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Estimated useful life of the asset in years for straight-line or declining balance depreciation methods. Not applicable for unit of production method.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'Ownership percentage representing the companys share of capital costs and operating expenses for the asset. Used for joint venture accounting and AFE cost allocation.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master record for all capitalized assets in the oil and gas enterprise including wells, pipelines, processing facilities, FPSOs, compressors, and refinery units. Captures asset number, asset description, asset class (oil and gas properties, machinery, buildings, vehicles), company code, cost center, WBS element, capitalization date, acquisition value, accumulated depreciation, net book value, depreciation key (unit of production, straight-line, declining balance), useful life, depletion unit (BOE), asset status (active, under construction, retired, abandoned), SEC proved property classification, last depreciation run date, depreciation area values (book, tax, IFRS), and retirement/abandonment details. Supports DD&A calculations per successful efforts and full cost methods, periodic depreciation run tracking, and SEC ceiling test compliance. Integrates with SAP S/4HANA FI-AA module (ANLA/ANLC).';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`project_economics` (
    `project_economics_id` BIGINT COMMENT 'Unique identifier for the project economics evaluation record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Investment decision governance requires linking economics approval to specific employee. Essential for capital allocation decisions, FID (Final Investment Decision) documentation, and management accou',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Project economics are calculated for AFEs (capital projects). The existing afe_number STRING attribute should be replaced with a proper FK to finance_afe.finance_afe_id to enable linking economic anal',
    `project_id` BIGINT COMMENT 'Reference to the capital project being evaluated. Links to the master project record in the project management system.',
    `approval_date` DATE COMMENT 'The date on which the project economics evaluation was formally approved for capital allocation.',
    `approval_status` STRING COMMENT 'The current approval status of the project economics evaluation in the AFE and capital allocation workflow.. Valid values are `draft|submitted|under_review|approved|rejected|on_hold`',
    `boe_reserves_1p` DECIMAL(18,2) COMMENT 'The proved reserves in barrels of oil equivalent. Reserves with reasonable certainty of being recoverable under existing economic and operating conditions.',
    `boe_reserves_2p` DECIMAL(18,2) COMMENT 'The proved plus probable reserves in barrels of oil equivalent. Includes proved reserves plus reserves with greater than 50% probability of recovery.',
    `boe_reserves_3p` DECIMAL(18,2) COMMENT 'The proved plus probable plus possible reserves in barrels of oil equivalent. Includes all reserve categories with at least 10% probability of recovery.',
    `comments` STRING COMMENT 'Free-text comments and notes regarding the economic evaluation, assumptions, or special considerations.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this project economics record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary values in this evaluation (e.g., USD, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `discount_rate` DECIMAL(18,2) COMMENT 'The base discount rate applied to future cash flows for NPV calculation, expressed as a percentage (e.g., 10.00 for 10%).',
    `economic_limit_date` DATE COMMENT 'The projected date when the project reaches its economic limit and production is no longer profitable. Used for abandonment planning.',
    `evaluation_date` DATE COMMENT 'The date on which this economic evaluation was performed. Critical for time-series analysis of project economics.',
    `evaluation_type` STRING COMMENT 'The type of economic evaluation being performed: initial assessment, revised forecast, final economics, annual review, or reforecast.. Valid values are `initial|revised|final|annual_review|reforecast`',
    `finding_and_development_cost_per_boe` DECIMAL(18,2) COMMENT 'The finding and development cost per BOE. Total exploration and development costs divided by reserves added. Key metric for portfolio efficiency.',
    `first_production_date` DATE COMMENT 'The projected or actual date of first commercial production from the project.',
    `gas_price_assumption` DECIMAL(18,2) COMMENT 'The natural gas price assumption used in the economic evaluation, typically in USD per thousand cubic feet (MCF) or million British thermal units (MMBTU).',
    `gross_npv` DECIMAL(18,2) COMMENT 'The gross net present value of the project before working interest adjustments. Represents the total economic value at the discount rate.',
    `gross_revenue` DECIMAL(18,2) COMMENT 'The total gross revenue from hydrocarbon sales over the project lifecycle before royalties and working interest adjustments.',
    `irr` DECIMAL(18,2) COMMENT 'The internal rate of return for the project, expressed as a percentage. The discount rate at which NPV equals zero.',
    `modified_by` STRING COMMENT 'The user or system identifier that last modified this project economics record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this project economics record was last modified.',
    `net_npv` DECIMAL(18,2) COMMENT 'The net present value adjusted for working interest ownership. Represents the companys share of project economics.',
    `net_revenue` DECIMAL(18,2) COMMENT 'The net revenue after net revenue interest adjustments. Represents the companys share of revenue after royalties and burdens.',
    `net_revenue_interest` DECIMAL(18,2) COMMENT 'The companys net revenue interest percentage after royalties and overriding royalty interests, expressed as a percentage. Determines revenue share.',
    `oil_price_assumption` DECIMAL(18,2) COMMENT 'The oil price assumption used in the economic evaluation, typically in USD per barrel. May reference WTI or Brent benchmark.',
    `payback_period_years` DECIMAL(18,2) COMMENT 'The number of years required to recover the initial capital investment from net cash flows.',
    `peak_capex` DECIMAL(18,2) COMMENT 'The maximum annual capital expenditure required during the project lifecycle. Critical for cash flow planning.',
    `price_deck_scenario` STRING COMMENT 'The price deck scenario used for the evaluation: base case corporate assumptions, high case, low case, SEC pricing rules, or current spot pricing.. Valid values are `base_case|high_case|low_case|sec_pricing|spot_pricing`',
    `project_life_years` STRING COMMENT 'The total economic life of the project in years from first production to economic limit.',
    `reserve_replacement_ratio` DECIMAL(18,2) COMMENT 'The ratio of reserves added to reserves produced during the period. A ratio above 1.0 indicates reserves are being replaced faster than production.',
    `risk_adjusted_discount_rate` DECIMAL(18,2) COMMENT 'The risk-adjusted discount rate incorporating project-specific risk factors, expressed as a percentage. Used for risk-weighted NPV calculations.',
    `risk_assessment_category` STRING COMMENT 'The overall risk category assigned to the project based on technical, commercial, and operational risk factors.. Valid values are `low_risk|medium_risk|high_risk|very_high_risk`',
    `sensitivity_analysis_performed` BOOLEAN COMMENT 'Indicates whether sensitivity analysis on key variables (price, reserves, costs) was performed as part of this evaluation.',
    `total_capex` DECIMAL(18,2) COMMENT 'The total capital expenditure over the project lifecycle including drilling, completion, facilities, and infrastructure costs.',
    `total_loe` DECIMAL(18,2) COMMENT 'The total lease operating expense over the project lifecycle. Direct costs of operating producing properties.',
    `total_opex` DECIMAL(18,2) COMMENT 'The total operating expenditure over the project lifecycle including production operations, maintenance, and overhead.',
    `working_interest` DECIMAL(18,2) COMMENT 'The companys working interest percentage in the project, expressed as a percentage (e.g., 65.00 for 65%). Determines cost-bearing obligation.',
    `created_by` STRING COMMENT 'The user or system identifier that created this project economics record.',
    CONSTRAINT pk_project_economics PRIMARY KEY(`project_economics_id`)
) COMMENT 'Financial economics master record for oil and gas capital projects capturing NPV, IRR, DCF, and payback period calculations used for investment decision-making and portfolio management. Captures project economics ID, project reference, evaluation date, discount rate, risk-adjusted discount rate, gross NPV, net NPV (WI-adjusted), IRR, payback period (years), peak CAPEX, total CAPEX, total OPEX, total LOE, gross revenue, net revenue (NRI-adjusted), BOE reserves (1P/2P/3P), finding and development cost (F&D cost per BOE), reserve replacement ratio, and economic limit date. Supports AFE justification, portfolio ranking, and SEC reserves economics.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique identifier for the intercompany transaction record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Intercompany transactions can be allocated to cost centers for cross-entity cost allocation. The existing cost_center STRING attribute should be replaced with a proper FK to cost_center.cost_center_id',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Intercompany transactions can be charged against AFEs for cross-entity capital project cost tracking. The existing afe_number STRING attribute should be replaced with a proper FK to finance_afe.financ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Intercompany transactions post to GL accounts. The existing gl_account STRING attribute should be replaced with a proper FK to gl_account.gl_account_id to enable intercompany GL account analysis and e',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Intercompany transactions can be allocated to profit centers for cross-entity profitability analysis. The existing profit_center STRING attribute should be replaced with a proper FK to profit_center.p',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Intercompany transactions have a sending legal entity. The existing sending_company_code STRING attribute should be replaced with a proper FK to company_code.company_code_id to enable intercompany rec',
    `business_unit` STRING COMMENT 'The business unit or operating segment associated with the intercompany transaction for segment reporting and performance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the intercompany transaction record was first created in the financial system.',
    `elimination_date` DATE COMMENT 'The date on which the intercompany transaction was eliminated in the consolidated financial statements.',
    `elimination_status` STRING COMMENT 'The current status of the intercompany transaction in the consolidation elimination process (pending elimination, eliminated in consolidation, excluded from elimination, or flagged for manual review).. Valid values are `pending|eliminated|excluded|manual_review`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the transaction amount from the transaction currency to the group reporting currency at the time of the transaction.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the transaction is recorded.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the intercompany transaction is recorded for financial reporting purposes.',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the group reporting currency (typically USD) using the exchange rate for consolidated financial reporting.',
    `intercompany_transaction_description` STRING COMMENT 'A free-text description providing additional details about the nature, purpose, or context of the intercompany transaction.',
    `jib_reference` STRING COMMENT 'The JIB reference number if the intercompany transaction is related to joint venture operations and joint interest billing processes.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the intercompany transaction record was last modified or updated in the financial system.',
    `netting_group` STRING COMMENT 'The netting group identifier used to aggregate intercompany transactions for multilateral netting settlement processes.',
    `netting_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this transaction is subject to intercompany netting processes to reduce the number of cross-border payments (True if subject to netting, False otherwise).',
    `payment_date` DATE COMMENT 'The actual date on which the intercompany transaction was settled or paid.',
    `payment_due_date` DATE COMMENT 'The date by which the intercompany transaction amount is due for payment from the receiving entity to the sending entity.',
    `payment_reference` STRING COMMENT 'A reference identifier linking this transaction to the payment record or bank transfer used to settle the intercompany obligation.',
    `payment_status` STRING COMMENT 'The current payment status of the intercompany transaction (unpaid, partially paid, paid in full, overdue, or waived).. Valid values are `unpaid|partially_paid|paid|overdue|waived`',
    `payment_terms` STRING COMMENT 'The payment terms agreed upon for settling the intercompany transaction (e.g., Net 30, Net 60, Due on Receipt).',
    `posting_date` DATE COMMENT 'The date on which the transaction was posted to the general ledger for accounting period assignment.',
    `product_category` STRING COMMENT 'The category of product or service involved in the intercompany transaction (e.g., crude oil, natural gas, NGL, refined products, petrochemicals, technical services, administrative services) for product-level analysis.',
    `quantity` DECIMAL(18,2) COMMENT 'The physical quantity of product transferred in the intercompany transaction, if applicable (e.g., barrels of crude oil, MCF of natural gas).',
    `receiving_company_code` STRING COMMENT 'The company code of the legal entity that is the receiver or beneficiary of the intercompany transaction (e.g., the entity receiving crude oil, services, or loan proceeds).',
    `reconciliation_reference` STRING COMMENT 'A reference identifier linking this transaction to the corresponding intercompany reconciliation record or matching transaction in the counterparty entitys books.',
    `reconciliation_status` STRING COMMENT 'The status of the intercompany transaction reconciliation between the sending and receiving entities (matched, unmatched, disputed, resolved, or pending review).. Valid values are `matched|unmatched|disputed|resolved|pending_review`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The amount of tax (e.g., VAT, GST, withholding tax) associated with the intercompany transaction, if applicable.',
    `tax_code` STRING COMMENT 'The tax code that determines the tax treatment and rate applicable to the intercompany transaction.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary value of the intercompany transaction in the transaction currency before any adjustments or eliminations.',
    `transaction_currency` STRING COMMENT 'The three-letter ISO 4217 currency code in which the intercompany transaction was originally denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `transaction_date` DATE COMMENT 'The date on which the intercompany transaction was executed or recorded in the financial system.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number assigned to the intercompany transaction for external reference and reconciliation tracking.',
    `transaction_subtype` STRING COMMENT 'A more granular classification within the transaction type to further specify the nature of the intercompany activity (e.g., crude oil transfer, natural gas transfer, technical services, administrative services, short-term loan, long-term loan).',
    `transaction_type` STRING COMMENT 'The category of intercompany transaction indicating the nature of the business activity (e.g., crude oil or NGL product transfer, service charge, management fee, intercompany loan, dividend distribution, royalty payment, overhead allocation, interest charge, lease payment, or cost recharge). [ENUM-REF-CANDIDATE: product_transfer|service_charge|management_fee|loan|dividend|royalty|overhead_allocation|interest_charge|lease_payment|recharge — 10 candidates stripped; promote to reference product]',
    `transfer_price_documentation` STRING COMMENT 'A reference to the transfer pricing documentation or study that supports the pricing methodology and arms length nature of the intercompany transaction.',
    `transfer_price_method` STRING COMMENT 'The transfer pricing methodology applied to determine the intercompany transaction price (e.g., cost plus markup, market price, negotiated price, resale minus, comparable uncontrolled price) for tax compliance and arms length pricing.. Valid values are `cost_plus|market_price|negotiated|resale_minus|comparable_uncontrolled_price`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity transferred (e.g., BBL for barrels, BOE for barrel of oil equivalent, MCF for thousand cubic feet, MMCF for million cubic feet, MT for metric tons, GAL for gallons, LB for pounds, KG for kilograms). [ENUM-REF-CANDIDATE: BBL|BOE|MCF|MMCF|MT|GAL|LB|KG — 8 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit of product or service in the intercompany transaction, used to calculate the total transaction amount.',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Transactional record of intercompany financial transactions between legal entities within the oil and gas enterprise, including crude oil transfers, gas sales, service charges, management fees, and loan interest. Captures intercompany transaction ID, transaction date, sending company code, receiving company code, transaction type (product transfer, service charge, loan, dividend, royalty), GL account, amount, currency, exchange rate, netting indicator, elimination status, and reconciliation reference. Supports intercompany elimination for consolidated financial statements under IFRS 10 and SOX intercompany reconciliation controls.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`tax_provision` (
    `tax_provision_id` BIGINT COMMENT 'Unique identifier for the tax provision record. Primary key for the tax provision entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Tax provisions are calculated for legal entities. The existing company_code STRING attribute should be replaced with a proper FK to company_code.company_code_id to enable legal entity-level tax report',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tax provision preparer accountability is critical for tax compliance governance. Links tax calculation to specific employee for deferred tax analysis and audit support in Oil & Gas tax reporting.',
    `accounting_standard` STRING COMMENT 'The accounting standard under which the tax provision is prepared. IFRS follows IAS 12, US GAAP follows ASC 740, and local GAAP follows jurisdiction-specific standards.. Valid values are `IFRS|US_GAAP|local_GAAP`',
    `audit_status` STRING COMMENT 'Status of tax authority audit for this jurisdiction and period. Tracks whether the tax position is under examination by tax authorities (IRS, state revenue departments, international tax authorities).. Valid values are `not_audited|under_audit|audit_completed|settled`',
    `book_basis_amount` DECIMAL(18,2) COMMENT 'The financial statement carrying amount (book basis) of the underlying asset or liability. The difference between book basis and tax basis creates the temporary difference.',
    `carryforward_expiration_date` DATE COMMENT 'The date on which the tax loss carryforward or tax credit carryforward expires if not utilized. Some jurisdictions allow indefinite carryforwards; others have time limits (e.g., 20 years).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tax provision record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this tax provision record (e.g., USD, CAD, GBP, EUR). All amounts are recorded in this currency.. Valid values are `^[A-Z]{3}$`',
    `current_tax_expense` DECIMAL(18,2) COMMENT 'The amount of income tax expense for the current period based on taxable income. Represents taxes payable or refundable for the current year.',
    `deferred_tax_asset` DECIMAL(18,2) COMMENT 'The amount of income taxes recoverable in future periods related to deductible temporary differences, tax loss carryforwards, and tax credit carryforwards. Common in oil and gas for Depreciation Depletion and Amortization (DD&A) timing differences and Abandoned and Dry Hole (ADH) costs.',
    `deferred_tax_expense` DECIMAL(18,2) COMMENT 'The amount of income tax expense or benefit related to changes in deferred tax assets and liabilities. Represents the tax effect of temporary differences between book and tax basis.',
    `deferred_tax_liability` DECIMAL(18,2) COMMENT 'The amount of income taxes payable in future periods related to taxable temporary differences. Common in oil and gas for accelerated tax depreciation versus book depreciation and successful efforts versus full cost accounting differences.',
    `effective_tax_rate` DECIMAL(18,2) COMMENT 'The actual tax rate calculated as total tax expense divided by pretax book income. Expressed as a decimal. Differs from statutory rate due to permanent differences, rate changes, and jurisdictional mix. Key metric for SEC financial disclosure and investor analysis.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert foreign currency tax provisions to the reporting currency. Represents the rate from the local jurisdiction currency to the company reporting currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for which the tax provision applies. Typically 1-12 for monthly periods or 1-4 for quarterly periods.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which the tax provision applies. Four-digit year representation.',
    `interest_on_tax_position` DECIMAL(18,2) COMMENT 'Interest accrued on underpayment or overpayment of taxes, or on uncertain tax positions. Calculated based on applicable jurisdiction interest rates.',
    `jurisdiction_code` STRING COMMENT 'Code identifying the tax jurisdiction (federal, state, country, or local). Format: ISO country code for federal (e.g., USA, CAN, GBR), or country-state for state/provincial (e.g., USA-TX, CAN-AB).. Valid values are `^[A-Z]{2,3}(-[A-Z0-9]{2,5})?$`',
    `jurisdiction_name` STRING COMMENT 'Full name of the tax jurisdiction (e.g., United States Federal, Texas, Alberta, United Kingdom).',
    `jurisdiction_type` STRING COMMENT 'Classification of the tax jurisdiction level: federal (national), state (US state), provincial (Canadian province), country (international), local (county/city), or municipal.. Valid values are `federal|state|provincial|country|local|municipal`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the tax provision record was last modified. Used for audit trail and change tracking to support SOX compliance.',
    `net_deferred_tax_position` DECIMAL(18,2) COMMENT 'Net deferred tax asset or liability position, calculated as deferred tax asset minus deferred tax liability. Positive values indicate a net asset position; negative values indicate a net liability position.',
    `penalty_on_tax_position` DECIMAL(18,2) COMMENT 'Penalties assessed or accrued related to tax positions, underpayments, or late filings. Common in oil and gas for royalty and severance tax disputes.',
    `permanent_difference` DECIMAL(18,2) COMMENT 'Differences between book income and taxable income that will never reverse. Examples in oil and gas include percentage depletion in excess of cost depletion, non-deductible fines and penalties, and tax-exempt income.',
    `pretax_book_income` DECIMAL(18,2) COMMENT 'Income before income taxes per the financial statements (book income). Used as the starting point for the tax provision calculation and effective tax rate reconciliation.',
    `provision_method` STRING COMMENT 'Method used to calculate the tax provision. Actual method uses actual year-to-date results, estimated method uses projections, and annualized method estimates full-year effective tax rate applied to interim periods per IAS 34 and ASC 740-270.. Valid values are `actual|estimated|annualized`',
    `provision_notes` STRING COMMENT 'Free-text notes documenting assumptions, judgments, and significant items in the tax provision calculation. Used to document complex positions such as transfer pricing, Production Sharing Agreement (PSA) interpretations, and uncertain tax positions.',
    `provision_status` STRING COMMENT 'Current status of the tax provision record in the financial close process. Draft provisions are prepared during the close cycle, preliminary provisions are subject to review, final provisions are approved for financial reporting, amended provisions reflect corrections, and audited provisions have been reviewed by external auditors.. Valid values are `draft|preliminary|final|amended|audited`',
    `reviewer_name` STRING COMMENT 'Name of the individual who reviewed and approved the tax provision calculation. Required for SOX internal controls over financial reporting.',
    `statute_expiration_date` DATE COMMENT 'The date on which the statute of limitations expires for this tax period, after which the tax authority can no longer assess additional tax. Typically 3 years from filing date in the US, but varies by jurisdiction.',
    `statutory_tax_rate` DECIMAL(18,2) COMMENT 'The enacted tax rate for the jurisdiction. Expressed as a decimal (e.g., 0.2100 for 21%). Used to calculate the expected tax expense and for effective tax rate reconciliation.',
    `tax_basis_amount` DECIMAL(18,2) COMMENT 'The tax basis of the underlying asset or liability that gives rise to the temporary difference. For oil and gas properties, represents the remaining tax basis for depletion and depreciation purposes under either successful efforts or full cost method.',
    `tax_credit_amount` DECIMAL(18,2) COMMENT 'Tax credits available to reduce current tax liability. Oil and gas specific credits include Enhanced Oil Recovery (EOR) credits, marginal well credits, Carbon Capture and Storage (CCS) credits (Section 45Q), and renewable energy credits.',
    `tax_loss_carryforward` DECIMAL(18,2) COMMENT 'Net Operating Loss (NOL) available to offset future taxable income. Common in oil and gas during commodity price downturns or for companies with significant exploration and development expenditures.',
    `tax_return_filed_date` DATE COMMENT 'The date on which the tax return for this jurisdiction and period was filed with the tax authority. Used to track filing compliance and statute of limitations.',
    `tax_type` STRING COMMENT 'Type of tax for which the provision is recorded. Oil and gas specific types include production tax (tax on volume produced), severance tax (state tax on extraction), windfall profit tax (tax on excess profits), and resource rent tax (tax on economic rent from resources).. Valid values are `corporate_income_tax|production_tax|severance_tax|windfall_profit_tax|resource_rent_tax|value_added_tax`',
    `taxable_income` DECIMAL(18,2) COMMENT 'Income subject to tax as determined under the applicable tax law. Differs from book income due to permanent and temporary differences. For oil and gas, includes adjustments for Intangible Drilling Costs (IDC), depletion methods, and production-based deductions.',
    `temporary_difference` DECIMAL(18,2) COMMENT 'Differences between the tax basis and book basis of assets and liabilities that will reverse over time. Common oil and gas temporary differences include DD&A timing, successful efforts versus tax accounting for exploration costs, and Asset Retirement Obligation (ARO) timing.',
    `total_tax_expense` DECIMAL(18,2) COMMENT 'Total income tax expense for the period, calculated as current tax expense plus deferred tax expense. This is the amount reported on the income statement.',
    `unrecognized_tax_benefit` DECIMAL(18,2) COMMENT 'The amount of tax benefit from an uncertain tax position that does not meet the more-likely-than-not recognition threshold. Common in oil and gas for transfer pricing positions, Production Sharing Agreement (PSA) interpretations, and cross-border transactions.',
    `valuation_allowance` DECIMAL(18,2) COMMENT 'Reduction in deferred tax assets when it is more likely than not that some portion or all of the deferred tax asset will not be realized. Common in oil and gas during commodity price downturns or for marginal properties.',
    CONSTRAINT pk_tax_provision PRIMARY KEY(`tax_provision_id`)
) COMMENT 'Transactional record of income tax provisions, deferred tax assets/liabilities, and tax accruals for oil and gas operations across jurisdictions. Captures tax provision ID, fiscal period, company code, jurisdiction (federal, state, country), tax type (corporate income tax, production tax, severance tax, windfall profit tax, resource rent tax), current tax expense, deferred tax expense, deferred tax asset, deferred tax liability, effective tax rate, statutory tax rate, temporary difference, and tax basis. Supports IFRS/GAAP tax accounting (IAS 12 / ASC 740) and SEC financial disclosure requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`financial_statement` (
    `financial_statement_id` BIGINT COMMENT 'Unique identifier for the financial statement record. Primary key for the financial statement entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Financial reporting governance requires linking statement approval to specific employee. Critical for SEC filing accountability, SOX certification, and CFO/Controller sign-off documentation in Oil & G',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Financial statements are prepared for legal entities. The existing company_code STRING attribute should be replaced with a proper FK to company_code.company_code_id to enable legal entity-level financ',
    `accounting_standard` STRING COMMENT 'The accounting standard framework under which the financial statement has been prepared (IFRS, US GAAP, IFRS for SMEs, or local GAAP).. Valid values are `IFRS|US_GAAP|IFRS_for_SMEs|local_GAAP`',
    `approval_date` DATE COMMENT 'The date on which the financial statement was formally approved by management or the board of directors for publication.',
    `approval_status` STRING COMMENT 'Current approval and publication status of the financial statement in its lifecycle (draft, pending review, approved, published, or restated).. Valid values are `draft|pending_review|approved|published|restated`',
    `audit_completion_date` DATE COMMENT 'The date on which the external audit was completed and the audit report was signed by the auditor.',
    `auditor_name` STRING COMMENT 'The name of the external audit firm that performed the independent audit of the financial statement.',
    `auditor_opinion` STRING COMMENT 'The type of audit opinion issued by the external auditor (unqualified/clean, qualified, adverse, or disclaimer of opinion).. Valid values are `unqualified|qualified|adverse|disclaimer`',
    `capex_amount` DECIMAL(18,2) COMMENT 'Total capital expenditures incurred during the reporting period for exploration, drilling, facilities, and other long-term assets. Expressed in the reporting currency.',
    `comparative_period_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this statement includes comparative prior period financial information as required by accounting standards.',
    `consolidation_group` STRING COMMENT 'The consolidation group or reporting unit identifier when the statement represents consolidated financial results across multiple legal entities or business segments.',
    `created_by_user` STRING COMMENT 'The user identifier or name of the person who created this financial statement record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this financial statement record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `dd_and_a_method` STRING COMMENT 'The depreciation, depletion, and amortization method applied to oil and gas assets in this financial statement (units of production, straight line, or declining balance).. Valid values are `units_of_production|straight_line|declining_balance`',
    `ebitda_amount` DECIMAL(18,2) COMMENT 'The calculated EBITDA amount for the reporting period, representing operating performance before financing and non-cash charges. Expressed in the reporting currency.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter designation for quarterly financial statements (Q1, Q2, Q3, Q4) or FY for full-year annual statements.. Valid values are `Q1|Q2|Q3|Q4|FY`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this financial statement belongs, represented as a four-digit year (e.g., 2024).',
    `internal_control_assessment` STRING COMMENT 'Management assessment of the effectiveness of internal controls over financial reporting as of the statement date, as required by SOX Section 404.. Valid values are `effective|ineffective|not_assessed`',
    `last_modified_by_user` STRING COMMENT 'The user identifier or name of the person who last modified this financial statement record in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this financial statement record was last modified or updated in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Additional notes, comments, or explanatory information related to the financial statement preparation, significant accounting policies, or material events.',
    `oil_gas_accounting_method` STRING COMMENT 'The oil and gas specific accounting method applied for exploration and production costs (successful efforts method or full cost method).. Valid values are `successful_efforts|full_cost`',
    `opex_amount` DECIMAL(18,2) COMMENT 'Total operating expenditures incurred during the reporting period including lease operating expenses, production costs, and general administrative expenses. Expressed in the reporting currency.',
    `preparation_date` DATE COMMENT 'The date on which the financial statement was prepared or finalized by the accounting team.',
    `publication_date` DATE COMMENT 'The date on which the financial statement was publicly released or made available to stakeholders and investors.',
    `reporting_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the financial statement amounts are presented (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `reporting_period_end_date` DATE COMMENT 'The ending date of the financial reporting period covered by this statement. Represents the as-of date for balance sheet or the period-end for income and cash flow statements.',
    `reporting_period_start_date` DATE COMMENT 'The beginning date of the financial reporting period covered by this statement.',
    `reserves_disclosure_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this statement includes oil and gas reserves disclosure as required by SEC and SPE PRMS standards.',
    `restatement_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this financial statement is a restatement of previously published financial results due to error correction or accounting policy changes.',
    `restatement_reason` STRING COMMENT 'Textual explanation of the reason for restatement if the restatement flag is True, including nature of error or accounting policy change.',
    `sec_accession_number` STRING COMMENT 'The unique SEC EDGAR accession number assigned to the filing for tracking and retrieval purposes.',
    `sec_filing_date` DATE COMMENT 'The date on which the financial statement was filed with the SEC via EDGAR system, if applicable.',
    `sec_filing_type` STRING COMMENT 'The type of SEC filing associated with this financial statement (10-K annual report, 10-Q quarterly report, 20-F for foreign issuers, 8-K current report, 6-K for foreign issuers, or not applicable for internal statements).. Valid values are `10-K|10-Q|20-F|8-K|6-K|not_applicable`',
    `segment_reporting_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this statement includes segment reporting disclosures for operating segments (Exploration and Production, Refining, Petrochemicals, etc.).',
    `sox_certification_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this financial statement has been certified by the CEO and CFO under SOX Section 302 requirements.',
    `statement_number` STRING COMMENT 'Business identifier or document number assigned to the financial statement for external reference and tracking purposes.',
    `statement_type` STRING COMMENT 'Classification of the financial statement indicating the type of financial report being prepared (balance sheet, income statement, cash flow statement, statement of changes in equity, segment report, or notes to financial statements).. Valid values are `balance_sheet|income_statement|cash_flow_statement|statement_of_changes_in_equity|segment_report|notes_to_financial_statements`',
    CONSTRAINT pk_financial_statement PRIMARY KEY(`financial_statement_id`)
) COMMENT 'Periodic financial statement master record representing the formal financial reports prepared for the oil and gas enterprise including balance sheet, income statement, cash flow statement, and statement of changes in equity. Captures financial statement ID, statement type (balance sheet, income statement, cash flow, equity statement, segment report), reporting period, fiscal year, company code or consolidation group, accounting standard (IFRS, US GAAP), reporting currency, preparation date, approval status, auditor sign-off indicator, restatement flag, and SEC filing reference (10-K, 10-Q, 20-F). Supports SEC financial disclosure, EBITDA reporting, and SOX-compliant financial close.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`hedge_position` (
    `hedge_position_id` BIGINT COMMENT 'Unique identifier for the hedge position record. Primary key for the hedge position entity.',
    `commercial_counterparty_id` BIGINT COMMENT 'Identifier for the financial institution or counterparty with whom the hedge contract is executed. Links to commercial counterparty master data.',
    `cost_center_id` BIGINT COMMENT 'Identifier for the cost center responsible for managing this hedge position. Used for internal cost allocation and budgeting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Risk management accountability requires linking hedge transaction initiator to specific employee. Essential for commodity hedging governance, trading authority verification, and ISDA documentation in ',
    `profit_center_id` BIGINT COMMENT 'Identifier for the profit center or business unit to which this hedge position is allocated. Links to finance profit center master data for cost allocation and performance reporting.',
    `business_segment` STRING COMMENT 'The business segment to which this hedge position is allocated. Segments include upstream (E&P), midstream (transportation), downstream (refining), petrochemicals, and corporate.. Valid values are `upstream|midstream|downstream|petrochemicals|corporate`',
    `ceiling_price` DECIMAL(18,2) COMMENT 'The ceiling price for collar structures. Represents the maximum price participation. Null for non-collar instruments.',
    `collateral_posted` DECIMAL(18,2) COMMENT 'The amount of collateral posted to the counterparty under the Credit Support Annex. Expressed in USD.',
    `confirmation_number` STRING COMMENT 'Unique confirmation number issued by the counterparty for the hedge transaction. Used for reconciliation and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hedge position record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credit_exposure` DECIMAL(18,2) COMMENT 'The current credit exposure to the counterparty, representing the potential loss if the counterparty defaults. Calculated as the positive mark-to-market value net of collateral. Expressed in USD.',
    `credit_support_annex_flag` BOOLEAN COMMENT 'Indicates whether a Credit Support Annex is in place for this hedge position, requiring collateral posting based on mark-to-market exposure.',
    `currency_pair` STRING COMMENT 'Currency pair for foreign exchange hedges. Format: BASE/QUOTE (e.g., USD/EUR, USD/GBP). Null for commodity hedges.. Valid values are `^[A-Z]{3}/[A-Z]{3}$`',
    `current_fair_value` DECIMAL(18,2) COMMENT 'The current fair value of the hedge position based on mark-to-market valuation. Represents the net present value of expected future cash flows. Expressed in USD.',
    `current_market_price` DECIMAL(18,2) COMMENT 'The current market price of the underlying commodity or currency. Updated regularly for mark-to-market valuation. Expressed in USD per unit.',
    `floor_price` DECIMAL(18,2) COMMENT 'The floor price for collar structures. Represents the minimum price protection. Null for non-collar instruments.',
    `geographic_region` STRING COMMENT 'Geographic region associated with the hedged exposure. Examples include North America, Europe, Asia Pacific, Middle East, Latin America.',
    `hedge_accounting_designation` STRING COMMENT 'The hedge accounting treatment designation under IFRS 9 or ASC 815. Options include cash flow hedge, fair value hedge, net investment hedge, or not designated for hedge accounting.. Valid values are `cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated`',
    `hedge_effectiveness_status` STRING COMMENT 'The current effectiveness status of the hedge based on prospective and retrospective testing. Highly effective hedges qualify for hedge accounting treatment.. Valid values are `highly_effective|effective|ineffective|not_tested`',
    `hedge_end_date` DATE COMMENT 'The maturity or expiration date of the hedge position. Represents when the hedge coverage terminates.',
    `hedge_position_number` STRING COMMENT 'Business identifier for the hedge position, externally visible and used in reporting and confirmations. Format: HP-YYYYNNNN where YYYY is year and NNNN is sequence.. Valid values are `^HP-[0-9]{8}$`',
    `hedge_start_date` DATE COMMENT 'The effective start date of the hedge position. Represents when the hedge coverage begins.',
    `hedge_status` STRING COMMENT 'Current lifecycle status of the hedge position. Active positions are in force, matured positions have reached expiration, terminated positions were closed early, cancelled positions were voided, and suspended positions are temporarily inactive.. Valid values are `active|matured|terminated|cancelled|suspended`',
    `hedge_type` STRING COMMENT 'Type of derivative instrument used for hedging. Includes crude oil swaps, natural gas collars, put/call options, costless collars, foreign exchange forwards, and interest rate swaps.. Valid values are `crude_oil_swap|gas_collar|put_option|call_option|costless_collar|fx_forward`',
    `hedged_commodity` STRING COMMENT 'The underlying commodity being hedged. Includes WTI crude, Brent crude, Henry Hub natural gas, TTF natural gas, NGL, LPG, and refined petroleum products. [ENUM-REF-CANDIDATE: crude_oil_wti|crude_oil_brent|natural_gas_henry_hub|natural_gas_ttf|ngl|lpg|refined_products — 7 candidates stripped; promote to reference product]',
    `hedged_forecast_transaction` STRING COMMENT 'Description of the forecasted transaction being hedged. For cash flow hedges, identifies the specific future production, sales, or purchase transaction that the hedge is designed to protect.',
    `ineffectiveness_amount` DECIMAL(18,2) COMMENT 'The portion of the hedge that is deemed ineffective and must be recognized immediately in profit or loss. Represents the excess gain or loss beyond the effective portion. Expressed in USD.',
    `isda_master_agreement_reference` STRING COMMENT 'Reference number of the ISDA (International Swaps and Derivatives Association) Master Agreement governing the hedge transaction. Establishes legal framework and netting arrangements.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified the hedge position record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the hedge position record was last updated. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `market_price_at_inception` DECIMAL(18,2) COMMENT 'The prevailing market price of the underlying commodity or currency at the time the hedge was initiated. Used for effectiveness testing and valuation. Expressed in USD per unit.',
    `next_settlement_date` DATE COMMENT 'The next scheduled settlement date for the hedge position. Updated after each settlement event.',
    `notional_volume` DECIMAL(18,2) COMMENT 'The notional quantity of the hedged commodity or financial instrument. For commodity hedges, expressed in barrels (BOE), cubic feet (MCF), or gallons. For FX hedges, expressed in base currency amount.',
    `premium_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the premium paid. Typically USD for oil and gas hedges.. Valid values are `^[A-Z]{3}$`',
    `premium_paid` DECIMAL(18,2) COMMENT 'The upfront premium paid to enter the hedge position. Applicable for purchased options. Zero for costless collars and swaps. Expressed in USD.',
    `prospective_effectiveness_result` DECIMAL(18,2) COMMENT 'The result of the prospective effectiveness test, expressed as a ratio or percentage. Tests whether the hedge is expected to be highly effective in offsetting future cash flow or fair value changes.',
    `realized_gain_loss` DECIMAL(18,2) COMMENT 'The cumulative realized gain or loss from settled hedge transactions. Positive values represent gains, negative values represent losses. Expressed in USD.',
    `retrospective_effectiveness_result` DECIMAL(18,2) COMMENT 'The result of the retrospective effectiveness test, expressed as a ratio or percentage. Tests whether the hedge has been highly effective in offsetting past cash flow or fair value changes. Must be within 80-125% range for hedge accounting qualification.',
    `settlement_frequency` STRING COMMENT 'Frequency at which the hedge position is cash-settled. Common frequencies include monthly, quarterly, semi-annual, annual, or at maturity.. Valid values are `monthly|quarterly|semi_annual|annual|at_maturity`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this hedge position is subject to SOX internal controls and testing requirements due to materiality or risk profile.',
    `strike_price` DECIMAL(18,2) COMMENT 'The fixed price or strike price at which the hedge is executed. For swaps, this is the fixed price. For options, this is the strike price. Expressed in USD per unit (e.g., USD/BBL, USD/MMBTU).',
    `trade_date` DATE COMMENT 'The date on which the hedge transaction was executed and confirmed with the counterparty.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'The current unrealized gain or loss on the hedge position based on mark-to-market valuation. Represents the difference between current fair value and carrying value. Expressed in USD.',
    `volume_unit` STRING COMMENT 'Unit of measure for the notional volume. BOE (Barrel of Oil Equivalent), BBL (Barrels), MMBTU (Million British Thermal Units), MCF (Thousand Cubic Feet), MMCF (Million Cubic Feet), GAL (Gallons), or currency code for FX hedges. [ENUM-REF-CANDIDATE: BOE|BBL|MMBTU|MCF|MMCF|GAL|USD|EUR|GBP — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_hedge_position PRIMARY KEY(`hedge_position_id`)
) COMMENT 'Master record of commodity price and foreign exchange hedge positions held by the oil and gas enterprise to manage exposure to crude oil price volatility (WTI, Brent), natural gas prices (Henry Hub, TTF), NGL prices, and currency risk. Captures hedge position ID, hedge type (crude oil swap, gas collar, put option, costless collar, FX forward, interest rate swap), hedged commodity or currency pair, notional volume or amount, hedge start date, hedge end date, settlement dates, strike price or fixed price, premium paid, market price at inception, current fair value (mark-to-market), realized gain/loss, hedge accounting designation (cash flow hedge, fair value hedge, net investment hedge), effectiveness test result (prospective and retrospective), ineffectiveness amount, counterparty, ISDA master agreement reference, and credit exposure. Supports IFRS 9 / ASC 815 hedge accounting, SEC commodity risk disclosure (Item 7A), and board-level risk reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` (
    `impairment_assessment_id` BIGINT COMMENT 'Unique identifier for the impairment assessment record. Primary key for the impairment assessment entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Impairment assessor accountability is critical for ceiling test and asset impairment governance. Links technical evaluation to specific employee for reserves engineer/financial analyst accountability ',
    `cgu_id` BIGINT COMMENT 'Reference to the cash-generating unit to which the asset belongs for impairment testing purposes under IAS 36.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Impairment assessments are performed for legal entities. The existing company_code STRING attribute should be replaced with a proper FK to company_code.company_code_id to enable legal entity-level imp',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center associated with the asset or CGU being assessed for impairment.',
    `gl_account_id` BIGINT COMMENT 'Reference to the general ledger account to which the impairment loss or reversal is posted.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center responsible for the asset or CGU being assessed for impairment.',
    `accounting_method` STRING COMMENT 'The oil and gas accounting method used: successful efforts method or full cost method, which determines how exploration and development costs are capitalized and amortized.. Valid values are `successful_efforts|full_cost`',
    `accounting_standard` STRING COMMENT 'The accounting standard framework applied for the impairment assessment: IAS 36 (International Accounting Standard), ASC 360 (Accounting Standards Codification), IFRS (International Financial Reporting Standards), or GAAP (Generally Accepted Accounting Principles).. Valid values are `IAS_36|ASC_360|IFRS|GAAP`',
    `approval_date` DATE COMMENT 'The date on which the impairment assessment was formally approved by the reviewer or management.',
    `assessment_date` DATE COMMENT 'The date on which the impairment assessment was performed or completed.',
    `assessment_number` STRING COMMENT 'Business-facing unique reference number assigned to the impairment assessment for tracking and reporting purposes.',
    `assessment_status` STRING COMMENT 'The current lifecycle status of the impairment assessment: draft, in review, approved, posted to the general ledger, or cancelled.. Valid values are `draft|in_review|approved|posted|cancelled`',
    `assessment_type` STRING COMMENT 'Classification of the impairment assessment based on the reason or timing of the evaluation.. Valid values are `annual|interim|triggering_event|acquisition|disposal|regulatory`',
    `brent_price_assumption` DECIMAL(18,2) COMMENT 'The assumed Brent crude oil price per barrel used in the impairment assessment cash flow projections.',
    `carrying_amount` DECIMAL(18,2) COMMENT 'The book value or carrying value of the asset or CGU on the balance sheet at the assessment date, before any impairment loss is recognized.',
    `ceiling_test_limit` DECIMAL(18,2) COMMENT 'The calculated ceiling test limit under the full cost method, representing the maximum allowable capitalized costs based on the present value of estimated future net revenues from proved reserves.',
    `ceiling_test_performed` BOOLEAN COMMENT 'Indicates whether a ceiling test was performed as part of the impairment assessment under the full cost method, which limits capitalized costs to the present value of estimated future net revenues.',
    `created_by_user` STRING COMMENT 'The username or identifier of the user who created this impairment assessment record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this impairment assessment record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which all monetary amounts in this impairment assessment are denominated (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `discount_rate` DECIMAL(18,2) COMMENT 'The pre-tax discount rate applied in the discounted cash flow (DCF) calculation to determine value in use, reflecting the time value of money and asset-specific risks.',
    `estimated_ultimate_recovery` DECIMAL(18,2) COMMENT 'The Estimated Ultimate Recovery (EUR) of hydrocarbons from the asset over its entire productive life, used in the impairment assessment.',
    `fair_value_less_costs_to_sell` DECIMAL(18,2) COMMENT 'The estimated amount obtainable from the sale of the asset in an arms length transaction between knowledgeable, willing parties, less the costs of disposal.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year in which the impairment assessment was performed and recorded.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the impairment assessment was performed and recorded.',
    `gas_price_assumption` DECIMAL(18,2) COMMENT 'The assumed natural gas price per unit (e.g., per MMBTU or MCF) used in the impairment assessment cash flow projections.',
    `impairment_loss_recognized` DECIMAL(18,2) COMMENT 'The amount by which the carrying amount exceeds the recoverable amount, recognized as an impairment loss in the financial statements.',
    `impairment_reversal_amount` DECIMAL(18,2) COMMENT 'The amount of previously recognized impairment loss that is reversed in the current period due to an increase in the recoverable amount (not applicable to goodwill under IFRS).',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified or updated this impairment assessment record in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this impairment assessment record was last modified or updated in the system.',
    `notes` STRING COMMENT 'Additional notes, comments, or explanations related to the impairment assessment, including assumptions, methodologies, or special considerations.',
    `posting_date` DATE COMMENT 'The date on which the impairment loss or reversal was posted to the general ledger and reflected in the financial statements.',
    `price_deck_applied` STRING COMMENT 'The commodity price forecast or price deck used in the impairment assessment, including references to benchmark prices such as West Texas Intermediate (WTI), Brent, or Henry Hub.',
    `property_type` STRING COMMENT 'Classification of the oil and gas property being assessed: Proved Developed Producing (PDP), Proved Developed Non-Producing (PDNP), Proved Undeveloped (PUD), unproved properties, goodwill, or other assets.. Valid values are `proved_developed_producing|proved_developed_non_producing|proved_undeveloped|unproved|goodwill|other`',
    `recoverable_amount` DECIMAL(18,2) COMMENT 'The higher of the assets fair value less costs to sell and its value in use, representing the maximum amount recoverable from the asset.',
    `reserve_estimate_used` STRING COMMENT 'The reserve classification used in the impairment assessment: 1P (Proved), 2P (Proved plus Probable), 3P (Proved plus Probable plus Possible), PDP (Proved Developed Producing), PDNP (Proved Developed Non-Producing), PUD (Proved Undeveloped), or unproved reserves. [ENUM-REF-CANDIDATE: 1P|2P|3P|PDP|PDNP|PUD|unproved — 7 candidates stripped; promote to reference product]',
    `reserve_volume_boe` DECIMAL(18,2) COMMENT 'The estimated reserve volume in Barrels of Oil Equivalent (BOE) used in the impairment assessment calculations.',
    `reviewer_name` STRING COMMENT 'The name of the individual or team responsible for reviewing and approving the impairment assessment.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this impairment assessment is subject to Sarbanes-Oxley (SOX) internal control testing and compliance requirements.',
    `triggering_event` STRING COMMENT 'Description of the event or indicator that triggered the impairment assessment, such as commodity price decline, reserve revision, regulatory change, abandonment decision, or adverse market conditions.',
    `triggering_event_date` DATE COMMENT 'The date on which the triggering event occurred that necessitated the impairment assessment.',
    `value_in_use` DECIMAL(18,2) COMMENT 'The present value of the future cash flows expected to be derived from the asset or CGU, calculated using discounted cash flow (DCF) analysis.',
    `wti_price_assumption` DECIMAL(18,2) COMMENT 'The assumed West Texas Intermediate (WTI) crude oil price per barrel used in the impairment assessment cash flow projections.',
    CONSTRAINT pk_impairment_assessment PRIMARY KEY(`impairment_assessment_id`)
) COMMENT 'Transactional record of oil and gas asset impairment assessments conducted to evaluate whether the carrying value of proved and unproved properties, goodwill, or other assets exceeds their recoverable amount. Captures impairment assessment ID, assessment date, asset or cash-generating unit (CGU) reference, triggering event (price decline, reserve revision, regulatory change, abandonment decision), carrying amount, recoverable amount (higher of fair value less costs to sell and value in use), impairment loss recognized, reversal amount, discount rate used, price deck applied (WTI, Brent), reserve estimate used (1P/2P), and accounting standard (IAS 36 / ASC 360). Supports SEC ceiling test calculations under full cost method.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`cash_management` (
    `cash_management_id` BIGINT COMMENT 'Unique identifier for the cash management record. Primary key for the cash management data product.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Cash positions belong to legal entities. The existing company_code STRING attribute should be replaced with a proper FK to company_code.company_code_id to enable legal entity-level cash consolidation ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Treasury accountability requires linking cash position preparer to specific employee. Essential for daily cash management, JIB settlement tracking, and treasury operations governance in Oil & Gas cash',
    `account_id` BIGINT COMMENT 'Reference to the master bank account that serves as the header account for the cash pooling structure. Null if this account is not part of a cash pool.',
    `previous_cash_management_id` BIGINT COMMENT 'Self-referencing FK on cash_management (previous_cash_management_id)',
    `afe_related_amount` DECIMAL(18,2) COMMENT 'Cash outflow amount related to approved Authorization for Expenditure (AFE) projects. Tracks CAPEX spending for drilling, completion, and facility construction projects.',
    `bank_statement_reference` STRING COMMENT 'Reference number or identifier from the bank statement used for reconciliation and audit trail. Links cash management records to external bank documentation.',
    `business_date` DATE COMMENT 'The business date for which the cash position or transaction is recorded. Represents the effective date for treasury operations and cash flow analysis.',
    `cash_pool_participant_flag` BOOLEAN COMMENT 'Indicates whether this bank account participates in a cash pooling arrangement for centralized treasury management and interest optimization.',
    `cash_position_type` STRING COMMENT 'Classification of the cash position record indicating whether it represents an opening balance, closing balance, intraday position, forecast, or actual position.. Valid values are `opening_balance|closing_balance|intraday_position|forecast|actual`',
    `closing_balance_amount` DECIMAL(18,2) COMMENT 'Cash balance at the end of the business day in the bank account. Used for daily cash reconciliation and liquidity reporting.',
    `commodity_sales_receipt_amount` DECIMAL(18,2) COMMENT 'Cash inflow from crude oil, natural gas, Natural Gas Liquids (NGL), and refined product sales. Primary operating cash inflow for upstream and midstream operations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the cash management record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_facility_available_amount` DECIMAL(18,2) COMMENT 'Total available credit facility amount that can be drawn for liquidity management. Represents undrawn portion of committed credit lines and revolving facilities.',
    `credit_facility_drawn_amount` DECIMAL(18,2) COMMENT 'Amount currently drawn from credit facilities. Represents outstanding borrowings under revolving credit agreements and short-term credit lines.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cash position and transaction amounts. Critical for multi-currency treasury operations and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate used to convert transaction currency to local or group currency. Critical for multi-currency cash management and FX exposure tracking.',
    `forecast_confidence_level` STRING COMMENT 'Confidence level assigned to the cash forecast based on data quality, historical accuracy, and business volatility. Used for risk-adjusted liquidity planning.. Valid values are `high|medium|low`',
    `forecast_horizon_days` STRING COMMENT 'Number of days into the future that this cash forecast record represents. Used for short-term liquidity planning and working capital management.',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'Cash position or transaction amount expressed in the group reporting currency for consolidated financial statements and enterprise-wide cash visibility.',
    `inflow_financing_amount` DECIMAL(18,2) COMMENT 'Total cash inflows from financing activities including debt drawdowns, credit facility utilization, equity issuance, and partner contributions. Aligns with cash flow statement financing section.',
    `inflow_investing_amount` DECIMAL(18,2) COMMENT 'Total cash inflows from investing activities including asset sales, divestiture proceeds, and investment redemptions. Aligns with cash flow statement investing section.',
    `inflow_operating_amount` DECIMAL(18,2) COMMENT 'Total cash inflows from operating activities including customer payments, production revenue, and operating receipts. Aligns with cash flow statement operating section.',
    `jib_settlement_amount` DECIMAL(18,2) COMMENT 'Cash flow amount related to Joint Interest Billing (JIB) settlements with joint venture partners. Includes partner billings, receipts, and netting transactions.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified the cash management record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the cash management record was last updated. Used for audit trail and change tracking.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Cash position or transaction amount expressed in the local currency of the operating entity. Used for local statutory reporting and compliance.',
    `loe_payment_amount` DECIMAL(18,2) COMMENT 'Cash outflow for Lease Operating Expense (LOE) including well operations, maintenance, utilities, and field-level operating costs. Key Operating Expenditure (OPEX) component.',
    `net_change_amount` DECIMAL(18,2) COMMENT 'Net change in cash position for the business day calculated as total inflows minus total outflows across all activity categories. Reconciles opening to closing balance.',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or context regarding the cash position, forecast assumptions, or reconciliation issues.',
    `opening_balance_amount` DECIMAL(18,2) COMMENT 'Cash balance at the beginning of the business day in the bank account. Starting point for daily cash position reconciliation.',
    `outflow_financing_amount` DECIMAL(18,2) COMMENT 'Total cash outflows for financing activities including debt repayments, interest payments, dividend distributions, and partner distributions. Aligns with cash flow statement financing section.',
    `outflow_investing_amount` DECIMAL(18,2) COMMENT 'Total cash outflows for investing activities including Capital Expenditure (CAPEX) for drilling, facilities, and equipment purchases. Aligns with cash flow statement investing section.',
    `outflow_operating_amount` DECIMAL(18,2) COMMENT 'Total cash outflows for operating activities including vendor payments, Lease Operating Expense (LOE), payroll, and operating disbursements. Aligns with cash flow statement operating section.',
    `reconciliation_status` STRING COMMENT 'Status of the cash position reconciliation process indicating whether the bank statement has been reconciled with the general ledger and treasury system.. Valid values are `reconciled|pending|variance_identified|under_investigation`',
    `reconciliation_variance_amount` DECIMAL(18,2) COMMENT 'Difference between bank statement balance and general ledger cash balance. Represents timing differences, unrecorded transactions, or errors requiring investigation.',
    `royalty_payment_amount` DECIMAL(18,2) COMMENT 'Cash outflow for royalty payments to mineral rights owners and government entities. Calculated based on Net Revenue Interest (NRI) and production volumes.',
    `short_term_investment_amount` DECIMAL(18,2) COMMENT 'Value of short-term investments and money market instruments held as part of cash management strategy. Includes commercial paper, treasury bills, and overnight deposits.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this cash management record is subject to Sarbanes-Oxley (SOX) internal control testing and audit requirements for financial reporting accuracy.',
    `value_date` DATE COMMENT 'Date on which funds are actually available for use or when interest calculation begins. May differ from business date due to banking processing cycles.',
    `working_interest_cash_call_amount` DECIMAL(18,2) COMMENT 'Cash outflow for Working Interest (WI) cash calls issued by joint venture operators. Represents partner share of joint operating costs and capital expenditures.',
    CONSTRAINT pk_cash_management PRIMARY KEY(`cash_management_id`)
) COMMENT 'Master and transactional record for enterprise cash management including bank accounts, cash positions, cash forecasts, and liquidity planning across the oil and gas enterprise. Captures bank account details, daily cash balances, cash inflows/outflows by category (operating, investing, financing), short-term investment positions, credit facility drawdowns, and cash pooling arrangements. Supports treasury operations, working capital management, and cash flow forecasting for CAPEX-intensive upstream and midstream projects. Integrates with SAP S/4HANA FI-BL (Bank Ledger) and treasury modules.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`accounts_payable` (
    `accounts_payable_id` BIGINT COMMENT 'Unique identifier for the accounts payable record. Primary key for the accounts payable transaction.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: AP invoices frequently relate to term contracts (transportation, processing, storage services). Required for contract accrual validation, three-way match, vendor performance tracking, and contract cos',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Every AP invoice belongs to a legal entity. The existing company_code STRING attribute should be replaced with a proper FK to company_code.company_code_id for referential integrity and to enable joini',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AP invoices can be charged to cost centers for expense tracking. The existing cost_center_code STRING attribute should be replaced with a proper FK to cost_center.cost_center_id to enable joining to c',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: AP entry preparer accountability is essential for financial control and segregation of duties. Links invoice processing to specific employee for three-way match verification and SOX compliance in Oil ',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: AP invoices can be charged against AFEs (Authorization for Expenditure) for capital project tracking. The existing afe_number STRING attribute should be replaced with a proper FK to finance_afe.financ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AP invoices post to GL accounts. The existing gl_account_code STRING attribute should be replaced with a proper FK to gl_account.gl_account_id to enable joining to chart of accounts master data and en',
    `payment_run_id` BIGINT COMMENT 'Identifier for the automated payment run that processed or will process this invoice. Used for batch payment tracking.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: AP invoices can be allocated to profit centers for profitability analysis. The existing profit_center_code STRING attribute should be replaced with a proper FK to profit_center.profit_center_id to ena',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: AP invoices must reference PO for three-way match, payment authorization, and invoice verification. Core accounts payable process for oil & gas procurement operations.',
    `service_entry_sheet_id` BIGINT COMMENT 'Foreign key linking to procurement.service_entry_sheet. Business justification: AP for services must link to SES for service acceptance verification and payment authorization. Real service invoice processing for drilling and completion services in oil & gas.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor or supplier to whom payment is owed. Links to the vendor master data.',
    `reversal_accounts_payable_id` BIGINT COMMENT 'Self-referencing FK on accounts_payable (reversal_accounts_payable_id)',
    `aging_bucket` STRING COMMENT 'The aging category based on days outstanding from due date. Used for cash flow management and vendor relationship monitoring.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `baseline_date` DATE COMMENT 'The reference date from which payment terms are calculated. Typically the invoice date or goods receipt date.',
    `clearing_date` DATE COMMENT 'The date the invoice was cleared from open items. Indicates when the payable obligation was satisfied.',
    `clearing_document` STRING COMMENT 'The document number that cleared this open item in the accounts payable subledger.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this accounts payable record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the invoice amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `days_payable_outstanding` STRING COMMENT 'Number of days this invoice has been outstanding from the invoice date. Key metric for working capital management.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The cash discount amount available if payment is made within the discount period per payment terms.',
    `due_date` DATE COMMENT 'The date by which payment must be made to the vendor according to payment terms. Used for cash flow planning and aging analysis.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate used to convert the invoice amount from transaction currency to local currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when this invoice was posted. Used for monthly financial close.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this invoice was posted. Used for period-based financial reporting and analysis.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before any deductions, discounts, or withholding taxes. Represents the full vendor claim.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. Used for aging calculations and payment term determination.',
    `invoice_description` STRING COMMENT 'Detailed description of the goods or services covered by this invoice. Provides business context for the payable.',
    `invoice_number` STRING COMMENT 'The vendor-provided invoice number or document reference for this payable. Business identifier for the invoice.',
    `jib_category` STRING COMMENT 'The JIB cost category code for this invoice per COPAS standards (e.g., drilling, completion, production, overhead).',
    `joa_reference` STRING COMMENT 'Reference to the Joint Operating Agreement governing cost sharing for this invoice. Used for joint interest billing.',
    `last_modified_by_user` STRING COMMENT 'The user ID of the person who last modified this accounts payable record. Part of SOX change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this accounts payable record was last modified. Tracks changes for audit and compliance.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The invoice amount converted to the company code local currency for financial reporting and consolidation.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net amount payable to the vendor after all deductions, discounts, and withholding taxes. This is the actual payment amount.',
    `payment_block_code` STRING COMMENT 'Code indicating if and why the invoice is blocked from payment (e.g., price variance, quantity dispute, quality hold).',
    `payment_date` DATE COMMENT 'The date payment was actually made to the vendor. Null if invoice is still unpaid.',
    `payment_method` STRING COMMENT 'The method by which payment will be or was made to the vendor (check, wire transfer, ACH, EFT, etc.).. Valid values are `check|wire_transfer|ach|eft|credit_card|letter_of_credit`',
    `payment_reference` STRING COMMENT 'The payment document number or check number issued for this invoice. Used for payment reconciliation.',
    `payment_status` STRING COMMENT 'Current payment status of the invoice. Tracks the lifecycle from open obligation through payment and clearing.. Valid values are `open|partially_paid|paid|blocked|cleared|cancelled`',
    `payment_terms` STRING COMMENT 'The payment terms code defining the due date calculation and discount conditions (e.g., Net 30, 2/10 Net 30).',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the general ledger. Determines the fiscal period for financial reporting.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this invoice is subject to SOX internal control testing and audit requirements.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount included in the invoice (sales tax, VAT, GST, or other applicable taxes).',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match validation between Purchase Order, Goods Receipt, and Invoice Receipt. Critical SOX control.. Valid values are `matched|price_variance|quantity_variance|not_matched|bypassed`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of tax withheld at source as required by tax regulations. Reduces the net payment to the vendor.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The working interest percentage owned by this company in the joint venture. Determines cost allocation share.',
    CONSTRAINT pk_accounts_payable PRIMARY KEY(`accounts_payable_id`)
) COMMENT 'Transactional record of vendor invoices, payment obligations, and disbursements owed by the oil and gas enterprise to suppliers, contractors, service companies, and royalty/JIB partners. Captures invoice number, vendor reference, invoice date, due date, payment terms, gross amount, tax withholding, net amount, payment status (open, partially paid, paid, blocked), three-way match status (PO/GR/IR), aging bucket, and payment run reference. Supports vendor payment processing, COPAS billing reconciliation, and SOX-compliant accounts payable controls. Integrates with SAP S/4HANA FI-AP module.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key for payment_run',
    `employee_id` BIGINT COMMENT 'System identifier of the user who approved the payment run.',
    `party_id` BIGINT COMMENT 'Identifier of the external party (vendor, contractor, or employee) receiving the payments.',
    `previous_payment_run_id` BIGINT COMMENT 'Self-referencing FK on payment_run (previous_payment_run_id)',
    `actual_payment_date` DATE COMMENT 'Date on which the payments were actually disbursed.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of taxes, fees, discounts, or other adjustments applied to the gross amount.',
    `approval_status` STRING COMMENT 'Current approval state of the payment run.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the payment run received approval.',
    `batch_number` STRING COMMENT 'Identifier of the processing batch within the source system (e.g., SAP batch).',
    `comments` STRING COMMENT 'Free‑form notes entered by the finance team regarding the payment run.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the payment run.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before deductions, expressed in the transaction currency.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the payment run was generated automatically by a scheduled job.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount to be paid after all adjustments, in the transaction currency.',
    `payment_channel` STRING COMMENT 'System or interface through which the payment run was processed.',
    `payment_method` STRING COMMENT 'Instrument used to execute the payments (e.g., wire transfer, ACH, check).',
    `payment_type` STRING COMMENT 'Category of payments processed in the run.',
    `run_code` STRING COMMENT 'Human‑readable code assigned to the payment run for tracking and reporting.',
    `run_timestamp` TIMESTAMP COMMENT 'The date and time when the payment run was initiated in the business process.',
    `scheduled_date` DATE COMMENT 'Planned calendar date for the payment run to be executed.',
    `source_system` STRING COMMENT 'Originating ERP or financial system (e.g., SAP S/4HANA).',
    `payment_run_status` STRING COMMENT 'Current processing state of the payment run.',
    `total_transaction_amount` DECIMAL(18,2) COMMENT 'Aggregate sum of all individual transaction amounts before adjustments.',
    `transaction_count` STRING COMMENT 'Count of individual payment transactions included in the run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment run record.',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Master reference table for payment_run. Referenced by payment_run_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`cost_object` (
    `cost_object_id` BIGINT COMMENT 'Primary key for cost_object',
    `asset_id` BIGINT COMMENT 'Identifier of the physical asset linked to the cost object.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `employee_id` BIGINT COMMENT 'Identifier of the party (e.g., department or manager) that owns the cost object.',
    `project_id` BIGINT COMMENT 'Identifier of the project associated with the cost object.',
    `parent_cost_object_id` BIGINT COMMENT 'Self-referencing FK on cost_object (parent_cost_object_id)',
    `accounting_method` STRING COMMENT 'Accounting treatment applied to the cost object (full cost or successful effort).',
    `actual_amount` DECIMAL(18,2) COMMENT 'Actual incurred amount recorded against the cost object.',
    `allocation_rate` DECIMAL(18,2) COMMENT 'Rate used to allocate costs from this object to downstream entities.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned budget amount allocated to the cost object.',
    `cost_category` STRING COMMENT 'Category of cost (direct, indirect, overhead, administrative).',
    `cost_object_code` STRING COMMENT 'Unique alphanumeric code used to identify the cost object in financial systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost object record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `depreciation_end_date` DATE COMMENT 'Date when depreciation is expected to be fully recognized.',
    `depreciation_life_years` STRING COMMENT 'Useful life of the asset in years for depreciation purposes.',
    `depreciation_method` STRING COMMENT 'Method used to calculate depreciation for capitalized costs.',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation calculations begin.',
    `cost_object_description` STRING COMMENT 'Detailed description of the cost object purpose and scope.',
    `effective_end_date` DATE COMMENT 'Date when the cost object ceases to be effective (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the cost object becomes effective for accounting.',
    `external_reference_number` STRING COMMENT 'Reference identifier from external systems linked to the cost object.',
    `financial_reporting_level` STRING COMMENT 'Level at which the cost object is reported in financial statements.',
    `is_capitalized` BOOLEAN COMMENT 'Indicates whether costs recorded under this object are capitalized (True) or expensed (False).',
    `cost_object_name` STRING COMMENT 'Human‑readable name of the cost object.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the cost object.',
    `cost_object_status` STRING COMMENT 'Current lifecycle status of the cost object.',
    `tax_code` STRING COMMENT 'Tax classification code applicable to the cost object.',
    `cost_object_type` STRING COMMENT 'Classification of the cost object (e.g., project, asset, cost center).',
    `unit_of_measure` STRING COMMENT 'Unit used for monetary or physical measurement of the cost object.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cost object record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between budgeted and actual amounts (budget - actual).',
    `variance_percent` DECIMAL(18,2) COMMENT 'Percentage variance between budget and actual amounts.',
    CONSTRAINT pk_cost_object PRIMARY KEY(`cost_object_id`)
) COMMENT 'Master reference table for cost_object. Referenced by cost_object_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`cgu` (
    `cgu_id` BIGINT COMMENT 'Primary key for cgu',
    `parent_cgu_id` BIGINT COMMENT 'Identifier of the parent CGU in a hierarchical grouping, if applicable.',
    `project_id` BIGINT COMMENT 'Identifier of the capital project to which the CGU belongs.',
    `annual_cash_flow` DECIMAL(18,2) COMMENT 'Projected annual cash flow generated by the CGU, used for impairment testing.',
    `asset_group` STRING COMMENT 'Logical grouping of assets within the CGU (e.g., wells, processing units).',
    `carrying_amount` DECIMAL(18,2) COMMENT 'Current book value of the CGU assets on the balance sheet.',
    `cgu_code` STRING COMMENT 'External code or number assigned to the CGU by the finance organization.',
    `cgu_name` STRING COMMENT 'Human‑readable name of the CGU used in reports and analysis.',
    `cgu_type` STRING COMMENT 'Category of the CGU indicating its primary business function.',
    `consolidation_level` STRING COMMENT 'Level at which the CGU is consolidated for reporting.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier associated with the CGU for budgeting and reporting.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the CGU is located.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the CGU record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the currency used for monetary values.',
    `depreciation_method` STRING COMMENT 'Method used to allocate the CGUs cost over its useful life.',
    `cgu_description` STRING COMMENT 'Free‑form description providing additional context about the CGU.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Discount rate applied when calculating net present value for the CGU.',
    `effective_from` DATE COMMENT 'Date when the CGU became effective for financial reporting.',
    `effective_until` DATE COMMENT 'Date when the CGU ceases to be effective; null if open‑ended.',
    `impairment_amount` DECIMAL(18,2) COMMENT 'Amount of impairment recognized for the CGU during the latest test.',
    `impairment_review_status` STRING COMMENT 'Current status of the CGUs impairment review process.',
    `impairment_test_date` DATE COMMENT 'Date on which the most recent impairment test was performed.',
    `irr` DECIMAL(18,2) COMMENT 'Rate of return at which the net present value of the CGU equals zero.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the CGU is included in group‑level consolidation.',
    `last_impairment_review_date` DATE COMMENT 'Date of the most recent review of the CGUs impairment status.',
    `last_update_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the CGU record.',
    `location_code` BIGINT COMMENT 'Reference to the physical location or site where the CGU operates.',
    `npv` DECIMAL(18,2) COMMENT 'Present value of expected future cash flows for the CGU.',
    `project_name` STRING COMMENT 'Name of the capital project associated with the CGU.',
    `region` STRING COMMENT 'Broad geographic region (e.g., North America, Middle East) of the CGU.',
    `reporting_currency_code` STRING COMMENT 'Currency used for consolidated financial reporting of the CGU.',
    `cgu_status` STRING COMMENT 'Current operational status of the CGU.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate used in financial calculations for the CGU.',
    `useful_life_years` STRING COMMENT 'Estimated economic life of the CGU expressed in years.',
    CONSTRAINT pk_cgu PRIMARY KEY(`cgu_id`)
) COMMENT 'Master reference table for cgu. Referenced by cgu_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`project` (
    `project_id` BIGINT COMMENT 'Primary key for project',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee responsible for overall project execution.',
    `sponsor_id` BIGINT COMMENT 'Unique identifier of the business unit or external party sponsoring the project.',
    `parent_project_id` BIGINT COMMENT 'Self-referencing FK on project (parent_project_id)',
    `actual_completion_date` DATE COMMENT 'Date the project was officially closed or handed over.',
    `approval_date` DATE COMMENT 'Date the project received formal approval.',
    `approved_by` STRING COMMENT 'Name of the executive who approved the project budget.',
    `capital_expenditure_budget` DECIMAL(18,2) COMMENT 'Planned capital spending allocated to the project.',
    `cost_center_code` STRING COMMENT 'Code of the cost center that funds the project.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the project site.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the project record was first inserted into the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter currency code for all monetary amounts.',
    `project_description` STRING COMMENT 'Detailed narrative describing scope, objectives, and key deliverables.',
    `end_date` DATE COMMENT 'Planned or actual date the project is expected to finish; null if open‑ended.',
    `expected_completion_date` DATE COMMENT 'Target date for project delivery as defined in the project plan.',
    `is_capex` BOOLEAN COMMENT 'True if the project is primarily a capital expenditure initiative.',
    `is_opex` BOOLEAN COMMENT 'True if the project is primarily an operating expenditure initiative.',
    `last_modified_by` STRING COMMENT 'User or system account that performed the latest update.',
    `location` STRING COMMENT 'Specific site or field name where the project activities occur.',
    `operating_expenditure_budget` DECIMAL(18,2) COMMENT 'Planned operating costs for the project lifecycle.',
    `phase_end_date` DATE COMMENT 'Planned or actual end date of the current phase.',
    `phase_start_date` DATE COMMENT 'Date the current phase began.',
    `project_category` STRING COMMENT 'High‑level business segment the project belongs to.',
    `project_manager_name` STRING COMMENT 'Full name of the project manager.',
    `project_name` STRING COMMENT 'Human‑readable name of the project.',
    `project_number` STRING COMMENT 'External project code used in contracts, reporting, and external systems.',
    `project_phase` STRING COMMENT 'Current phase of the project lifecycle.',
    `project_subcategory` STRING COMMENT 'More granular classification within the main category (e.g., drilling, pipeline, refinery upgrade).',
    `project_type` STRING COMMENT 'Category of the project reflecting its primary business purpose.',
    `region` STRING COMMENT 'Broad geographic region where the project is located.',
    `risk_category` STRING COMMENT 'Primary domain of risk affecting the project.',
    `risk_rating` STRING COMMENT 'Overall risk level assigned to the project.',
    `sponsor_name` STRING COMMENT 'Readable name of the sponsor organization.',
    `start_date` DATE COMMENT 'Date the project officially commenced.',
    `project_status` STRING COMMENT 'Current lifecycle state of the project.',
    `total_budget` DECIMAL(18,2) COMMENT 'Aggregate of CAPEX and OPEX budgets; used for financial reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the project record.',
    CONSTRAINT pk_project PRIMARY KEY(`project_id`)
) COMMENT 'Master reference table for project. Referenced by project_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`project_definition` (
    `project_definition_id` BIGINT COMMENT 'Primary key for project_definition',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who is the primary manager of the project.',
    `parent_project_definition_id` BIGINT COMMENT 'Self-referencing FK on project_definition (parent_project_definition_id)',
    `actual_end_date` DATE COMMENT 'Date the project was actually completed or shut down.',
    `actual_start_date` DATE COMMENT 'Date the project actually commenced work.',
    `approval_date` DATE COMMENT 'Date on which the project definition was approved.',
    `approved_by` STRING COMMENT 'Name of the individual or authority that approved the project definition.',
    `asset_owner` STRING COMMENT 'Organizational unit or legal entity that owns the project assets.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Overall approved monetary budget for the project (CAPEX + OPEX).',
    `capex_budget` DECIMAL(18,2) COMMENT 'Capital expenditure portion of the total budget.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the project definition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary values on the record.',
    `project_definition_description` STRING COMMENT 'Detailed textual description of the projects scope and objectives.',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the projects environmental impact assessment.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the projects budget is allocated.',
    `irr` DECIMAL(18,2) COMMENT 'Projected internal rate of return for the project, expressed as a percentage.',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating whether the project is classified as confidential for internal handling.',
    `is_public` BOOLEAN COMMENT 'Flag indicating whether project information is publicly disclosed.',
    `last_reported_cost` DECIMAL(18,2) COMMENT 'Most recent cost figure reported for the project.',
    `last_reported_date` DATE COMMENT 'Date on which the last cost figure was reported.',
    `location_country` STRING COMMENT 'Three‑letter ISO country code where the project is located.',
    `location_region` STRING COMMENT 'Geographic region or basin within the country where the project resides.',
    `npv` DECIMAL(18,2) COMMENT 'Projected net present value of the project cash flows, expressed in the budget currency.',
    `opex_budget` DECIMAL(18,2) COMMENT 'Operating expenditure portion of the total budget.',
    `planned_end_date` DATE COMMENT 'Scheduled completion date for the project as originally planned.',
    `planned_start_date` DATE COMMENT 'Scheduled start date for the project as originally planned.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary project contact.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary project contact.',
    `project_category` STRING COMMENT 'Broad categorization of the project based on location and ownership model.',
    `project_code` STRING COMMENT 'External business identifier or code used to reference the project across systems.',
    `project_name` STRING COMMENT 'Human‑readable name of the oil and gas project.',
    `project_phase` STRING COMMENT 'High‑level phase of the project lifecycle.',
    `project_stage` STRING COMMENT 'More granular stage within the current phase.',
    `project_status` STRING COMMENT 'Current lifecycle status of the project.',
    `project_status_reason` STRING COMMENT 'Free‑text explanation for the current project status.',
    `project_type` STRING COMMENT 'Classification of the project based on its primary activity.',
    `project_url` STRING COMMENT 'Web address linking to the projects internal portal or external page.',
    `regulatory_approval_date` DATE COMMENT 'Date when the final regulatory approval was granted.',
    `regulatory_approval_status` STRING COMMENT 'Current status of required regulatory approvals.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned by the risk management function.',
    `sponsor_name` STRING COMMENT 'Name of the senior executive or stakeholder sponsoring the project.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the project definition record.',
    CONSTRAINT pk_project_definition PRIMARY KEY(`project_definition_id`)
) COMMENT 'Master reference table for project_definition. Referenced by project_definition_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` (
    `settlement_receiver_id` BIGINT COMMENT 'Primary key for settlement_receiver',
    `tax_entity_id` BIGINT COMMENT 'Government‑issued tax identifier for the settlement receiver (e.g., EIN, VAT).',
    `parent_settlement_receiver_id` BIGINT COMMENT 'Self-referencing FK on settlement_receiver (parent_settlement_receiver_id)',
    `address_line1` STRING COMMENT 'First line of the settlement receivers mailing address.',
    `address_line2` STRING COMMENT 'Second line of the settlement receivers mailing address (optional).',
    `bank_account_number` STRING COMMENT 'Settlement receivers bank account number for receiving payments.',
    `bank_account_type` STRING COMMENT 'Type of bank account (e.g., checking, savings).',
    `bank_name` STRING COMMENT 'Name of the bank where the settlement receiver holds an account.',
    `city` STRING COMMENT 'City component of the settlement receivers mailing address.',
    `contact_person_email` STRING COMMENT 'Email address of the primary contact person.',
    `contact_person_name` STRING COMMENT 'Name of the primary contact person for settlement matters.',
    `contact_person_phone` STRING COMMENT 'Phone number of the primary contact person.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the settlement receivers location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the settlement receiver record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for settlements.',
    `default_settlement_day` STRING COMMENT 'Numeric day of month when routine settlements are scheduled.',
    `effective_end_date` DATE COMMENT 'Date when the settlement receiver was deactivated or terminated (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the settlement receiver became active in the system.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether payments to this receiver are subject to tax.',
    `legal_entity_identifier` STRING COMMENT 'Global legal entity identifier used for regulatory reporting.',
    `settlement_receiver_name` STRING COMMENT 'Legal name of the settlement receiver organization or party.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the settlement receiver.',
    `payment_method` STRING COMMENT 'Method used to settle payments to the receiver.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the settlement receivers mailing address.',
    `primary_email` STRING COMMENT 'Primary email address used for settlement communications.',
    `primary_phone` STRING COMMENT 'Primary telephone number for settlement communications.',
    `receiver_type` STRING COMMENT 'Category of the settlement receiver indicating its business relationship to Oil Gas.',
    `settlement_frequency` STRING COMMENT 'How often settlements are processed for this receiver.',
    `settlement_terms` STRING COMMENT 'Negotiated terms governing settlement timing (e.g., Net 30).',
    `state_province` STRING COMMENT 'State or province component of the settlement receivers mailing address.',
    `settlement_receiver_status` STRING COMMENT 'Current operational status of the settlement receiver.',
    `swift_code` STRING COMMENT 'International bank identifier code for wire transfers.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the settlement receiver is exempt from tax withholding.',
    `tax_exempt_reason` STRING COMMENT 'Reason or code explaining tax exemption status.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the settlement receiver record.',
    CONSTRAINT pk_settlement_receiver PRIMARY KEY(`settlement_receiver_id`)
) COMMENT 'Master reference table for settlement_receiver. Referenced by settlement_receiver_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`investment_program` (
    `investment_program_id` BIGINT COMMENT 'Primary key for investment_program',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `project_id` BIGINT COMMENT 'Identifier of the upstream project linked to this investment program.',
    `parent_investment_program_id` BIGINT COMMENT 'Self-referencing FK on investment_program (parent_investment_program_id)',
    `actual_end_date` DATE COMMENT 'Date when the program was completed or closed.',
    `actual_start_date` DATE COMMENT 'Date when work on the program actually commenced.',
    `approved_by` STRING COMMENT 'Name of the executive who approved the investment program.',
    `approved_date` DATE COMMENT 'Date when the investment program received formal approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investment program record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary amounts.',
    `investment_program_description` STRING COMMENT 'Free‑form narrative describing the purpose, scope, and key objectives of the investment program.',
    `effective_from` DATE COMMENT 'Date when the investment program becomes effective.',
    `effective_until` DATE COMMENT 'Date when the investment program ends or expires; null for open‑ended programs.',
    `expected_irr` DECIMAL(18,2) COMMENT 'Projected internal rate of return for the program.',
    `expected_npv` DECIMAL(18,2) COMMENT 'Projected net present value of the programs cash flows, in reporting currency.',
    `funding_source` STRING COMMENT 'Origin of the programs financing.',
    `funding_status` STRING COMMENT 'Current status of the allocated funding.',
    `investment_type` STRING COMMENT 'Specifies whether the program is capital expenditure, operating expenditure, or both.',
    `priority` STRING COMMENT 'Business priority level assigned to the program.',
    `program_code` STRING COMMENT 'External reference code used in finance systems to identify the investment program.',
    `program_manager` STRING COMMENT 'Name of the individual responsible for overall program execution.',
    `program_name` STRING COMMENT 'Descriptive name of the investment program.',
    `program_type` STRING COMMENT 'Category of the program indicating its strategic focus.',
    `risk_rating` STRING COMMENT 'Qualitative risk assessment of the program.',
    `investment_program_status` STRING COMMENT 'Current lifecycle state of the investment program.',
    `total_capex_amount` DECIMAL(18,2) COMMENT 'Approved capital expenditure budget for the program, in the reporting currency.',
    `total_opex_amount` DECIMAL(18,2) COMMENT 'Approved operating expenditure budget for the program, in the reporting currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the investment program record.',
    CONSTRAINT pk_investment_program PRIMARY KEY(`investment_program_id`)
) COMMENT 'Master reference table for investment_program. Referenced by investment_program_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`finance`.`sponsor` (
    `sponsor_id` BIGINT COMMENT 'Primary key for sponsor',
    `address_line1` STRING COMMENT 'Primary street address of the sponsor.',
    `address_line2` STRING COMMENT 'Secondary address information for the sponsor.',
    `business_unit` STRING COMMENT 'Internal business unit responsible for the sponsor relationship.',
    `city` STRING COMMENT 'City component of the sponsors address.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the sponsors primary location. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|CHN|RUS|BRA|IND — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the sponsor record was first created.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount approved for the sponsor.',
    `currency_code` STRING COMMENT 'Currency used for financial transactions with the sponsor.',
    `sponsor_description` STRING COMMENT 'Free‑form description of the sponsors business and relationship.',
    `effective_end_date` DATE COMMENT 'Date when the sponsor relationship ends, if applicable.',
    `effective_start_date` DATE COMMENT 'Date when the sponsor relationship becomes effective.',
    `industry_sector` STRING COMMENT 'Broad industry sector classification for the sponsor.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the sponsor record.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the sponsor record.',
    `sponsor_name` STRING COMMENT 'Legal name of the sponsor entity.',
    `parent_sponsor_id` BIGINT COMMENT 'Identifier of the parent sponsor in hierarchical sponsor structures, if applicable.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the sponsor.',
    `postal_code` STRING COMMENT 'Postal code for the sponsors address.',
    `primary_contact_email` STRING COMMENT 'Primary email address for sponsor communications.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for sponsor communications.',
    `sponsor_type` STRING COMMENT 'Classification of sponsor based on relationship to the company.',
    `state` STRING COMMENT 'State or province component of the sponsors address.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the sponsor is exempt from tax reporting.',
    `tax_exempt_reason` STRING COMMENT 'Reason for tax exemption, if applicable.',
    `tax_id` STRING COMMENT 'Government‑issued tax identifier for the sponsor.',
    `website_url` STRING COMMENT 'Public website address of the sponsor.',
    CONSTRAINT pk_sponsor PRIMARY KEY(`sponsor_id`)
) COMMENT 'Master reference table for sponsor. Referenced by sponsor_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `oil_gas_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ADD CONSTRAINT `fk_finance_finance_afe_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ADD CONSTRAINT `fk_finance_finance_afe_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ADD CONSTRAINT `fk_finance_finance_afe_superseded_afe_finance_afe_id` FOREIGN KEY (`superseded_afe_finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ADD CONSTRAINT `fk_finance_finance_afe_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ADD CONSTRAINT `fk_finance_afe_cost_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ADD CONSTRAINT `fk_finance_afe_cost_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ADD CONSTRAINT `fk_finance_afe_cost_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `oil_gas_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_investment_program_id` FOREIGN KEY (`investment_program_id`) REFERENCES `oil_gas_ecm`.`finance`.`investment_program`(`investment_program_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_parent_wbs_element_id` FOREIGN KEY (`parent_wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_project_definition_id` FOREIGN KEY (`project_definition_id`) REFERENCES `oil_gas_ecm`.`finance`.`project_definition`(`project_definition_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_settlement_receiver_id` FOREIGN KEY (`settlement_receiver_id`) REFERENCES `oil_gas_ecm`.`finance`.`settlement_receiver`(`settlement_receiver_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_cost_object_id` FOREIGN KEY (`cost_object_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_object`(`cost_object_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ADD CONSTRAINT `fk_finance_project_economics_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ADD CONSTRAINT `fk_finance_project_economics_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ADD CONSTRAINT `fk_finance_financial_statement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ADD CONSTRAINT `fk_finance_hedge_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ADD CONSTRAINT `fk_finance_hedge_position_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ADD CONSTRAINT `fk_finance_impairment_assessment_cgu_id` FOREIGN KEY (`cgu_id`) REFERENCES `oil_gas_ecm`.`finance`.`cgu`(`cgu_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ADD CONSTRAINT `fk_finance_impairment_assessment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ADD CONSTRAINT `fk_finance_impairment_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ADD CONSTRAINT `fk_finance_impairment_assessment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ADD CONSTRAINT `fk_finance_impairment_assessment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ADD CONSTRAINT `fk_finance_cash_management_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ADD CONSTRAINT `fk_finance_cash_management_previous_cash_management_id` FOREIGN KEY (`previous_cash_management_id`) REFERENCES `oil_gas_ecm`.`finance`.`cash_management`(`cash_management_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `oil_gas_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_reversal_accounts_payable_id` FOREIGN KEY (`reversal_accounts_payable_id`) REFERENCES `oil_gas_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_previous_payment_run_id` FOREIGN KEY (`previous_payment_run_id`) REFERENCES `oil_gas_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_object` ADD CONSTRAINT `fk_finance_cost_object_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_object` ADD CONSTRAINT `fk_finance_cost_object_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_object` ADD CONSTRAINT `fk_finance_cost_object_parent_cost_object_id` FOREIGN KEY (`parent_cost_object_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_object`(`cost_object_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`cgu` ADD CONSTRAINT `fk_finance_cgu_parent_cgu_id` FOREIGN KEY (`parent_cgu_id`) REFERENCES `oil_gas_ecm`.`finance`.`cgu`(`cgu_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`cgu` ADD CONSTRAINT `fk_finance_cgu_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`project` ADD CONSTRAINT `fk_finance_project_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `oil_gas_ecm`.`finance`.`sponsor`(`sponsor_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`project` ADD CONSTRAINT `fk_finance_project_parent_project_id` FOREIGN KEY (`parent_project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`project_definition` ADD CONSTRAINT `fk_finance_project_definition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`project_definition` ADD CONSTRAINT `fk_finance_project_definition_parent_project_definition_id` FOREIGN KEY (`parent_project_definition_id`) REFERENCES `oil_gas_ecm`.`finance`.`project_definition`(`project_definition_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ADD CONSTRAINT `fk_finance_settlement_receiver_parent_settlement_receiver_id` FOREIGN KEY (`parent_settlement_receiver_id`) REFERENCES `oil_gas_ecm`.`finance`.`settlement_receiver`(`settlement_receiver_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`investment_program` ADD CONSTRAINT `fk_finance_investment_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`investment_program` ADD CONSTRAINT `fk_finance_investment_program_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`investment_program` ADD CONSTRAINT `fk_finance_investment_program_parent_investment_program_id` FOREIGN KEY (`parent_investment_program_id`) REFERENCES `oil_gas_ecm`.`finance`.`investment_program`(`investment_program_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `oil_gas_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `afe_number` SET TAGS ('dbx_value_regex' = '^AFE-[A-Z0-9]{6,12}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct_charge|activity_based|percentage|headcount|area|volume');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = 'upstream|midstream|downstream|corporate');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'direct|indirect|overhead|capital');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending_closure');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Group');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `accounting_method` SET TAGS ('dbx_business_glossary_term' = 'Accounting Method');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `accounting_method` SET TAGS ('dbx_value_regex' = 'successful_efforts|full_cost');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'producing|non_producing|development|exploration');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `capex_budget_annual` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Budget Annual');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `capex_budget_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `dd_and_a_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Depletion and Amortization (DD&A) Method');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `dd_and_a_method` SET TAGS ('dbx_value_regex' = 'unit_of_production|straight_line|declining_balance');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Classification');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_value_regex' = 'onshore|offshore_shallow|offshore_deepwater|arctic|unconventional');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'north_america|south_america|europe|middle_east|africa|asia_pacific');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `hierarchy_node` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `hse_tier` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Tier');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `hse_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `joa_operator_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Operator Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `net_revenue_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `opex_budget_annual` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Budget Annual');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `opex_budget_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary_eor|depleted');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'upstream_ep|midstream|downstream_refining|downstream_petrochemical|marketing_sales|corporate');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `psa_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `reserve_category` SET TAGS ('dbx_business_glossary_term' = 'Reserve Category');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `reserve_category` SET TAGS ('dbx_value_regex' = '1P|2P|3P|contingent|prospective');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Identifier');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `account_long_description` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Long Description');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `accounting_method_indicator` SET TAGS ('dbx_business_glossary_term' = 'Oil and Gas Accounting Method Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `accounting_method_indicator` SET TAGS ('dbx_value_regex' = 'successful_efforts|full_cost');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `afe_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Eligible Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_indicator` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Indicator Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `capitalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Capitalization Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `consolidation_account` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element` SET TAGS ('dbx_business_glossary_term' = 'Controlling (CO) Cost Element');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Account Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `depreciation_flag` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Depletion and Amortization (DD&A) Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `financial_statement_item` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Item Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `gaap_mapping_code` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Mapping Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `hse_category` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Category');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `ifrs_mapping_code` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Mapping Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `joint_venture_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Account Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `line_item_display_flag` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `loe_category` SET TAGS ('dbx_business_glossary_term' = 'Lease Operating Expense (LOE) Category');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `open_item_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `posting_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Block Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `profit_loss_indicator` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Indicator Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Reserves Management System (PRMS) Reserves Category');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `accounting_method` SET TAGS ('dbx_business_glossary_term' = 'Oil and Gas Accounting Method');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `accounting_method` SET TAGS ('dbx_value_regex' = 'successful_efforts|full_cost');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `business_area_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Business Area Required Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA)');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Company Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `company_status` SET TAGS ('dbx_business_glossary_term' = 'Company Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `company_status` SET TAGS ('dbx_value_regex' = 'active|inactive|dormant|liquidation|merged');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Country of Incorporation');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_business_glossary_term' = 'Credit Control Area');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `elimination_company_indicator` SET TAGS ('dbx_business_glossary_term' = 'Elimination Company Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `field_status_variant` SET TAGS ('dbx_business_glossary_term' = 'Field Status Variant');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `field_status_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `gaap_framework` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Framework');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `gaap_framework` SET TAGS ('dbx_value_regex' = 'IFRS|US_GAAP|local_GAAP');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `intercompany_partner_assignment` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Partner Assignment');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `legal_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `legal_entity_type` SET TAGS ('dbx_value_regex' = 'IOC_subsidiary|NOC_subsidiary|joint_venture|holding_company|special_purpose_vehicle|branch');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `local_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `posting_period_variant` SET TAGS ('dbx_business_glossary_term' = 'Posting Period Variant');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `posting_period_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `profit_center_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Required Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_country` SET TAGS ('dbx_business_glossary_term' = 'Registered Country');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_business_glossary_term' = 'Registered State or Province');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `sec_cik_number` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Central Index Key (CIK) Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `sec_cik_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `sec_registrant_indicator` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Registrant Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `sox_scope_indicator` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Scope Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `valuation_area` SET TAGS ('dbx_business_glossary_term' = 'Valuation Area');
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ALTER COLUMN `valuation_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `allocation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Allocation Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `batch_input_session` SET TAGS ('dbx_business_glossary_term' = 'Batch Input Session Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `dd_and_a_indicator` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Depletion and Amortization (DD&A) Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_header_text` SET TAGS ('dbx_business_glossary_term' = 'Document Header Text');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `internal_order` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `joint_venture_code` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `parking_status` SET TAGS ('dbx_business_glossary_term' = 'Parking Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `parking_status` SET TAGS ('dbx_value_regex' = 'parked|posted|held');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `partner_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Partner Share Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key_indicator` SET TAGS ('dbx_business_glossary_term' = 'Posting Key Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = '01|02|03|04|05');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `sox_control_reference` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Reference');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `successful_efforts_indicator` SET TAGS ('dbx_business_glossary_term' = 'Successful Efforts Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_company_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Company Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Header ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `asset_subnumber` SET TAGS ('dbx_business_glossary_term' = 'Asset Subnumber');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `asset_subnumber` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `baseline_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Payment Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Business Transaction Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_transaction_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `company_code_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Company Code Currency Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `company_code_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `company_code_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `partner_profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Profit Center Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `partner_profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_key_1` SET TAGS ('dbx_business_glossary_term' = 'Reference Key 1');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_key_2` SET TAGS ('dbx_business_glossary_term' = 'Reference Key 2');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_key_3` SET TAGS ('dbx_business_glossary_term' = 'Reference Key 3');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `superseded_afe_finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Authorization for Expenditure (AFE) ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `actual_cost_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost To Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `afe_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `afe_type` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `basin_name` SET TAGS ('dbx_business_glossary_term' = 'Basin Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) / Operating Expenditure (OPEX) Classification');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_value_regex' = 'capex|opex|mixed');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `estimated_irr` SET TAGS ('dbx_business_glossary_term' = 'Estimated Internal Rate of Return (IRR)');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `estimated_npv` SET TAGS ('dbx_business_glossary_term' = 'Estimated Net Present Value (NPV)');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `expected_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Completion Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `expected_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Start Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `field_name` SET TAGS ('dbx_business_glossary_term' = 'Field Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `gross_afe_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Authorization for Expenditure (AFE) Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `joa_reference` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Reference');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `net_afe_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Authorization for Expenditure (AFE) Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `project_justification` SET TAGS ('dbx_business_glossary_term' = 'Project Justification');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `remaining_budget` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `spud_date` SET TAGS ('dbx_business_glossary_term' = 'Spud Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Title');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `afe_cost_line_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Cost Line ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `actual_cost_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost to Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|revised');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `budgeted_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Gross Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `budgeted_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Net Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) / Operating Expenditure (OPEX) Classification');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_value_regex' = 'capex|opex');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `committed_cost` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'tangible|intangible|surface_equipment|subsurface_equipment|overhead|indirect');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `cost_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `cost_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Line Description');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|units_of_production|declining_balance|none');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `forecast_final_cost` SET TAGS ('dbx_business_glossary_term' = 'Forecast Final Cost');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `is_contingency` SET TAGS ('dbx_business_glossary_term' = 'Is Contingency Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Cost Line Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Line Notes');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'drilling|completion|facilities|workover|abandonment|other');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `company_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `commodity_assumption` SET TAGS ('dbx_business_glossary_term' = 'Commodity Price Assumption');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `contingency_percent` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `escalation_rate` SET TAGS ('dbx_business_glossary_term' = 'Escalation Rate');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `field_name` SET TAGS ('dbx_business_glossary_term' = 'Field Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `narrative` SET TAGS ('dbx_business_glossary_term' = 'Budget Narrative');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `production_volume_assumption` SET TAGS ('dbx_business_glossary_term' = 'Production Volume Assumption');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|supplemental|reforecast|final');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `well_name` SET TAGS ('dbx_business_glossary_term' = 'Well Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'per_BOE|per_well|per_unit_throughput|per_employee|fixed|percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocation Quantity');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_unit` SET TAGS ('dbx_business_glossary_term' = 'Allocation Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Comments');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_element` SET TAGS ('dbx_business_glossary_term' = 'Cost Element');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Budget Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `investment_program_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Program ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `parent_wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `project_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Project Definition ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Cost Center ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `settlement_receiver_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Receiver ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `tertiary_wbs_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `tertiary_wbs_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `tertiary_wbs_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `afe_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Approval Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `afe_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `available_budget` SET TAGS ('dbx_business_glossary_term' = 'Available Budget');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `billing_element_indicator` SET TAGS ('dbx_business_glossary_term' = 'Billing Element Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `budget_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Profile Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `budget_profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `committed_cost` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `functional_area` SET TAGS ('dbx_value_regex' = 'upstream|midstream|downstream|corporate');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `planning_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Planning Profile Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `planning_profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `settlement_rule_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `settlement_rule_type` SET TAGS ('dbx_value_regex' = 'fixed_asset|cost_center|profitability_segment|none');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `statistical_indicator` SET TAGS ('dbx_business_glossary_term' = 'Statistical Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `technical_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Technical Completion Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,24}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_description` SET TAGS ('dbx_business_glossary_term' = 'WBS Element Description');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_status` SET TAGS ('dbx_business_glossary_term' = 'WBS Element Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_status` SET TAGS ('dbx_value_regex' = 'created|released|technically_complete|closed');
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_level` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Level');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `actual_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `cost_object_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Object ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Partner ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `accrual_indicator` SET TAGS ('dbx_business_glossary_term' = 'Accrual Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `business_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Business Transaction Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `capitalization_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|allocation|apportionment|activity_based');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `cost_document_number` SET TAGS ('dbx_business_glossary_term' = 'Cost Document Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `cost_element` SET TAGS ('dbx_business_glossary_term' = 'Cost Element');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `cost_object_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Object Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `depreciation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `net_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Cost Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `originating_module` SET TAGS ('dbx_business_glossary_term' = 'Originating Module');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Cost Quantity');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `source_document_line_item` SET TAGS ('dbx_business_glossary_term' = 'Source Document Line Item');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `source_document_number` SET TAGS ('dbx_business_glossary_term' = 'Source Document Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `source_document_type` SET TAGS ('dbx_business_glossary_term' = 'Source Document Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `variance_category` SET TAGS ('dbx_business_glossary_term' = 'Variance Category');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `variance_category` SET TAGS ('dbx_value_regex' = 'budget|forecast|afe|standard_cost|prior_year');
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_accounting');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Identifier');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation Depletion and Amortization (DD&A)');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_value` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Value');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `api_well_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Well Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `api_well_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{3}-[0-9]{5}-[0-9]{2}-[0-9]{2}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'oil_and_gas_properties|machinery_and_equipment|buildings_and_structures|vehicles|office_equipment|land');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_retirement_obligation_amount` SET TAGS ('dbx_business_glossary_term' = 'Asset Retirement Obligation (ARO) Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_sub_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Sub-Class');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cumulative_production` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Production');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depletion_unit` SET TAGS ('dbx_business_glossary_term' = 'Depletion Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depletion_unit` SET TAGS ('dbx_value_regex' = 'BOE|MMBOE|MCF|MMCF|BBL|TONNES');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area_book` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area Book Value');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area_ifrs` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area International Financial Reporting Standards (IFRS) Value');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area_tax` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area Tax Value');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_key` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Key');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_key` SET TAGS ('dbx_value_regex' = 'unit_of_production|straight_line|declining_balance|sum_of_years_digits|no_depreciation');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `estimated_ultimate_recovery` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR)');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `field_name` SET TAGS ('dbx_business_glossary_term' = 'Field Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `geographic_location` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_depreciation_run_date` SET TAGS ('dbx_business_glossary_term' = 'Last Depreciation Run Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_impairment_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Impairment Test Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_revenue_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `operator_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `retirement_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Retirement Proceeds');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `retirement_type` SET TAGS ('dbx_business_glossary_term' = 'Retirement Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `retirement_type` SET TAGS ('dbx_value_regex' = 'sale|scrap|abandonment|transfer|partial_retirement');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `sec_proved_property_classification` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Proved Property Classification');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `sec_proved_property_classification` SET TAGS ('dbx_value_regex' = 'PDP|PDNP|PUD|non_proved|not_applicable');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life in Years');
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` SET TAGS ('dbx_subdomain' = 'asset_accounting');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `project_economics_id` SET TAGS ('dbx_business_glossary_term' = 'Project Economics ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|on_hold');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `boe_reserves_1p` SET TAGS ('dbx_business_glossary_term' = 'Barrel of Oil Equivalent (BOE) Reserves - Proved (1P)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `boe_reserves_1p` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `boe_reserves_2p` SET TAGS ('dbx_business_glossary_term' = 'Barrel of Oil Equivalent (BOE) Reserves - Proved Plus Probable (2P)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `boe_reserves_2p` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `boe_reserves_3p` SET TAGS ('dbx_business_glossary_term' = 'Barrel of Oil Equivalent (BOE) Reserves - Proved Plus Probable Plus Possible (3P)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `boe_reserves_3p` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `economic_limit_date` SET TAGS ('dbx_business_glossary_term' = 'Economic Limit Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_value_regex' = 'initial|revised|final|annual_review|reforecast');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `finding_and_development_cost_per_boe` SET TAGS ('dbx_business_glossary_term' = 'Finding and Development (F&D) Cost per Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `finding_and_development_cost_per_boe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `first_production_date` SET TAGS ('dbx_business_glossary_term' = 'First Production Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `gas_price_assumption` SET TAGS ('dbx_business_glossary_term' = 'Gas Price Assumption');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `gross_npv` SET TAGS ('dbx_business_glossary_term' = 'Gross Net Present Value (NPV)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `gross_npv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `gross_revenue` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `gross_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `irr` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `irr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `net_npv` SET TAGS ('dbx_business_glossary_term' = 'Net Net Present Value (NPV)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `net_npv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `net_revenue` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `net_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `net_revenue_interest` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `net_revenue_interest` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `oil_price_assumption` SET TAGS ('dbx_business_glossary_term' = 'Oil Price Assumption');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `payback_period_years` SET TAGS ('dbx_business_glossary_term' = 'Payback Period (Years)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `peak_capex` SET TAGS ('dbx_business_glossary_term' = 'Peak Capital Expenditure (CAPEX)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `peak_capex` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `price_deck_scenario` SET TAGS ('dbx_business_glossary_term' = 'Price Deck Scenario');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `price_deck_scenario` SET TAGS ('dbx_value_regex' = 'base_case|high_case|low_case|sec_pricing|spot_pricing');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `project_life_years` SET TAGS ('dbx_business_glossary_term' = 'Project Life (Years)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `reserve_replacement_ratio` SET TAGS ('dbx_business_glossary_term' = 'Reserve Replacement Ratio');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `reserve_replacement_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `risk_adjusted_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Risk-Adjusted Discount Rate');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `risk_assessment_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Category');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `risk_assessment_category` SET TAGS ('dbx_value_regex' = 'low_risk|medium_risk|high_risk|very_high_risk');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `sensitivity_analysis_performed` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity Analysis Performed');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `total_capex` SET TAGS ('dbx_business_glossary_term' = 'Total Capital Expenditure (CAPEX)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `total_capex` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `total_loe` SET TAGS ('dbx_business_glossary_term' = 'Total Lease Operating Expense (LOE)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `total_loe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `total_opex` SET TAGS ('dbx_business_glossary_term' = 'Total Operating Expenditure (OPEX)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `total_opex` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `working_interest` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI)');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `working_interest` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_date` SET TAGS ('dbx_business_glossary_term' = 'Elimination Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Elimination Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_value_regex' = 'pending|eliminated|excluded|manual_review');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `jib_reference` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Reference');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_group` SET TAGS ('dbx_business_glossary_term' = 'Netting Group');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_indicator` SET TAGS ('dbx_business_glossary_term' = 'Netting Indicator');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partially_paid|paid|overdue|waived');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_reference` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Reference');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|disputed|resolved|pending_review');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_subtype` SET TAGS ('dbx_business_glossary_term' = 'Transaction Subtype');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_price_documentation` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Documentation Reference');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_price_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Method');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_price_method` SET TAGS ('dbx_value_regex' = 'cost_plus|market_price|negotiated|resale_minus|comparable_uncontrolled_price');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'IFRS|US_GAAP|local_GAAP');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Audit Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'not_audited|under_audit|audit_completed|settled');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `book_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Book Basis Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `carryforward_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Carryforward Expiration Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `current_tax_expense` SET TAGS ('dbx_business_glossary_term' = 'Current Tax Expense');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `deferred_tax_asset` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Asset (DTA)');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `deferred_tax_expense` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Expense');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `deferred_tax_liability` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Liability (DTL)');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `effective_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Effective Tax Rate (ETR)');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `interest_on_tax_position` SET TAGS ('dbx_business_glossary_term' = 'Interest on Tax Position');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}(-[A-Z0-9]{2,5})?$');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_value_regex' = 'federal|state|provincial|country|local|municipal');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `net_deferred_tax_position` SET TAGS ('dbx_business_glossary_term' = 'Net Deferred Tax Position');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `penalty_on_tax_position` SET TAGS ('dbx_business_glossary_term' = 'Penalty on Tax Position');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `permanent_difference` SET TAGS ('dbx_business_glossary_term' = 'Permanent Difference');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `pretax_book_income` SET TAGS ('dbx_business_glossary_term' = 'Pretax Book Income');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `provision_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Method');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `provision_method` SET TAGS ('dbx_value_regex' = 'actual|estimated|annualized');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `provision_notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Notes');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `provision_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `provision_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|amended|audited');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Reviewer Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `statute_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Statute of Limitations Expiration Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `statutory_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Statutory Tax Rate');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Basis Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_loss_carryforward` SET TAGS ('dbx_business_glossary_term' = 'Tax Loss Carryforward');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_return_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Return Filed Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'corporate_income_tax|production_tax|severance_tax|windfall_profit_tax|resource_rent_tax|value_added_tax');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `taxable_income` SET TAGS ('dbx_business_glossary_term' = 'Taxable Income');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `temporary_difference` SET TAGS ('dbx_business_glossary_term' = 'Temporary Difference');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `total_tax_expense` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Expense');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `unrecognized_tax_benefit` SET TAGS ('dbx_business_glossary_term' = 'Unrecognized Tax Benefit (UTB)');
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ALTER COLUMN `valuation_allowance` SET TAGS ('dbx_business_glossary_term' = 'Valuation Allowance');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `financial_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'IFRS|US_GAAP|IFRS_for_SMEs|local_GAAP');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Approval Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Approval Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|published|restated');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `audit_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Completion Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `auditor_opinion` SET TAGS ('dbx_business_glossary_term' = 'Auditor Opinion Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `auditor_opinion` SET TAGS ('dbx_value_regex' = 'unqualified|qualified|adverse|disclaimer');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `capex_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `comparative_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Comparative Period Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `dd_and_a_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Depletion and Amortization (DD&A) Method');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `dd_and_a_method` SET TAGS ('dbx_value_regex' = 'units_of_production|straight_line|declining_balance');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `ebitda_amount` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4|FY');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `internal_control_assessment` SET TAGS ('dbx_business_glossary_term' = 'Internal Control Assessment');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `internal_control_assessment` SET TAGS ('dbx_value_regex' = 'effective|ineffective|not_assessed');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Notes');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `oil_gas_accounting_method` SET TAGS ('dbx_business_glossary_term' = 'Oil and Gas Accounting Method');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `oil_gas_accounting_method` SET TAGS ('dbx_value_regex' = 'successful_efforts|full_cost');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `opex_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `preparation_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Preparation Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Publication Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `reserves_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Reserves Disclosure Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `restatement_flag` SET TAGS ('dbx_business_glossary_term' = 'Restatement Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `restatement_reason` SET TAGS ('dbx_business_glossary_term' = 'Restatement Reason');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `sec_accession_number` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Accession Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `sec_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Filing Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `sec_filing_type` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Filing Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `sec_filing_type` SET TAGS ('dbx_value_regex' = '10-K|10-Q|20-F|8-K|6-K|not_applicable');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `segment_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Segment Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `sox_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Certification Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_value_regex' = 'balance_sheet|income_statement|cash_flow_statement|statement_of_changes_in_equity|segment_report|notes_to_financial_statements');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` SET TAGS ('dbx_subdomain' = 'asset_accounting');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `hedge_position_id` SET TAGS ('dbx_business_glossary_term' = 'Hedge Position Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `business_segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `business_segment` SET TAGS ('dbx_value_regex' = 'upstream|midstream|downstream|petrochemicals|corporate');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `ceiling_price` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Price');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `collateral_posted` SET TAGS ('dbx_business_glossary_term' = 'Collateral Posted Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Trade Confirmation Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `credit_exposure` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `credit_support_annex_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `currency_pair` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `currency_pair` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}/[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `current_fair_value` SET TAGS ('dbx_business_glossary_term' = 'Current Fair Value (Mark-to-Market)');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `current_market_price` SET TAGS ('dbx_business_glossary_term' = 'Current Market Price');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `floor_price` SET TAGS ('dbx_business_glossary_term' = 'Floor Price');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `hedge_accounting_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Accounting Designation');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `hedge_accounting_designation` SET TAGS ('dbx_value_regex' = 'cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `hedge_effectiveness_status` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `hedge_effectiveness_status` SET TAGS ('dbx_value_regex' = 'highly_effective|effective|ineffective|not_tested');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `hedge_end_date` SET TAGS ('dbx_business_glossary_term' = 'Hedge End Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `hedge_position_number` SET TAGS ('dbx_business_glossary_term' = 'Hedge Position Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `hedge_position_number` SET TAGS ('dbx_value_regex' = '^HP-[0-9]{8}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `hedge_start_date` SET TAGS ('dbx_business_glossary_term' = 'Hedge Start Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `hedge_status` SET TAGS ('dbx_business_glossary_term' = 'Hedge Position Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `hedge_status` SET TAGS ('dbx_value_regex' = 'active|matured|terminated|cancelled|suspended');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `hedge_type` SET TAGS ('dbx_business_glossary_term' = 'Hedge Instrument Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `hedge_type` SET TAGS ('dbx_value_regex' = 'crude_oil_swap|gas_collar|put_option|call_option|costless_collar|fx_forward');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `hedged_commodity` SET TAGS ('dbx_business_glossary_term' = 'Hedged Commodity');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `hedged_forecast_transaction` SET TAGS ('dbx_business_glossary_term' = 'Hedged Forecast Transaction Description');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `ineffectiveness_amount` SET TAGS ('dbx_business_glossary_term' = 'Hedge Ineffectiveness Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `isda_master_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'ISDA Master Agreement Reference Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `market_price_at_inception` SET TAGS ('dbx_business_glossary_term' = 'Market Price at Inception');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `next_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Next Settlement Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `notional_volume` SET TAGS ('dbx_business_glossary_term' = 'Notional Volume');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `premium_currency` SET TAGS ('dbx_business_glossary_term' = 'Premium Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `premium_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `premium_paid` SET TAGS ('dbx_business_glossary_term' = 'Premium Paid');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `prospective_effectiveness_result` SET TAGS ('dbx_business_glossary_term' = 'Prospective Effectiveness Test Result');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `realized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Realized Gain or Loss');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `retrospective_effectiveness_result` SET TAGS ('dbx_business_glossary_term' = 'Retrospective Effectiveness Test Result');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|at_maturity');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `strike_price` SET TAGS ('dbx_business_glossary_term' = 'Strike Price or Fixed Price');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss');
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` SET TAGS ('dbx_subdomain' = 'asset_accounting');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `impairment_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Impairment Assessment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `cgu_id` SET TAGS ('dbx_business_glossary_term' = 'Cash-Generating Unit (CGU) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `accounting_method` SET TAGS ('dbx_business_glossary_term' = 'Accounting Method');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `accounting_method` SET TAGS ('dbx_value_regex' = 'successful_efforts|full_cost');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'IAS_36|ASC_360|IFRS|GAAP');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|posted|cancelled');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'annual|interim|triggering_event|acquisition|disposal|regulatory');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `brent_price_assumption` SET TAGS ('dbx_business_glossary_term' = 'Brent Crude Price Assumption');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `carrying_amount` SET TAGS ('dbx_business_glossary_term' = 'Carrying Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `ceiling_test_limit` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Test Limit');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `ceiling_test_performed` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Test Performed Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `estimated_ultimate_recovery` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR)');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `fair_value_less_costs_to_sell` SET TAGS ('dbx_business_glossary_term' = 'Fair Value Less Costs to Sell');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `gas_price_assumption` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Price Assumption');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `impairment_loss_recognized` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss Recognized');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `impairment_reversal_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Reversal Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `price_deck_applied` SET TAGS ('dbx_business_glossary_term' = 'Price Deck Applied');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `property_type` SET TAGS ('dbx_business_glossary_term' = 'Property Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `property_type` SET TAGS ('dbx_value_regex' = 'proved_developed_producing|proved_developed_non_producing|proved_undeveloped|unproved|goodwill|other');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Recoverable Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `reserve_estimate_used` SET TAGS ('dbx_business_glossary_term' = 'Reserve Estimate Used');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `reserve_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Reserve Volume in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `triggering_event` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `triggering_event_date` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `value_in_use` SET TAGS ('dbx_business_glossary_term' = 'Value in Use');
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ALTER COLUMN `wti_price_assumption` SET TAGS ('dbx_business_glossary_term' = 'West Texas Intermediate (WTI) Price Assumption');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `cash_management_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Management ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Pool Header Account ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `previous_cash_management_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `afe_related_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Related Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `bank_statement_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Reference');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `cash_pool_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash Pool Participant Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `cash_position_type` SET TAGS ('dbx_business_glossary_term' = 'Cash Position Type');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `cash_position_type` SET TAGS ('dbx_value_regex' = 'opening_balance|closing_balance|intraday_position|forecast|actual');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `closing_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `commodity_sales_receipt_amount` SET TAGS ('dbx_business_glossary_term' = 'Commodity Sales Receipt Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `credit_facility_available_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Facility Available Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `credit_facility_drawn_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Facility Drawn Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `forecast_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Level');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `forecast_confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `forecast_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon Days');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `inflow_financing_amount` SET TAGS ('dbx_business_glossary_term' = 'Financing Cash Inflow Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `inflow_investing_amount` SET TAGS ('dbx_business_glossary_term' = 'Investing Cash Inflow Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `inflow_operating_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Cash Inflow Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `jib_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Settlement Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `loe_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Lease Operating Expense (LOE) Payment Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `net_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Cash Change Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `opening_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `outflow_financing_amount` SET TAGS ('dbx_business_glossary_term' = 'Financing Cash Outflow Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `outflow_investing_amount` SET TAGS ('dbx_business_glossary_term' = 'Investing Cash Outflow Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `outflow_operating_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Cash Outflow Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|pending|variance_identified|under_investigation');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `reconciliation_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Variance Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `royalty_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `short_term_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Short-Term Investment Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ALTER COLUMN `working_interest_cash_call_amount` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Cash Call Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `reversal_accounts_payable_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `clearing_document` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `days_payable_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Payable Outstanding (DPO)');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `jib_category` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Category');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `joa_reference` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Reference');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_block_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|wire_transfer|ach|eft|credit_card|letter_of_credit');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'open|partially_paid|paid|blocked|cleared|cancelled');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|price_variance|quantity_variance|not_matched|bypassed');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `oil_gas_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Identifier');
ALTER TABLE `oil_gas_ecm`.`finance`.`payment_run` ALTER COLUMN `previous_payment_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_object` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_object` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_object` ALTER COLUMN `cost_object_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Object Identifier');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_object` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_object` ALTER COLUMN `parent_cost_object_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`cgu` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`cgu` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `oil_gas_ecm`.`finance`.`cgu` ALTER COLUMN `cgu_id` SET TAGS ('dbx_business_glossary_term' = 'Cgu Identifier');
ALTER TABLE `oil_gas_ecm`.`finance`.`project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`project` SET TAGS ('dbx_subdomain' = 'asset_accounting');
ALTER TABLE `oil_gas_ecm`.`finance`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `oil_gas_ecm`.`finance`.`project` ALTER COLUMN `parent_project_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_definition` SET TAGS ('dbx_subdomain' = 'asset_accounting');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_definition` ALTER COLUMN `project_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Project Definition Identifier');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_definition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_definition` ALTER COLUMN `parent_project_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_definition` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_definition` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_definition` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`project_definition` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `settlement_receiver_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Receiver Identifier');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `tax_entity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `tax_entity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `parent_settlement_receiver_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `legal_entity_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `legal_entity_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`investment_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`investment_program` SET TAGS ('dbx_subdomain' = 'asset_accounting');
ALTER TABLE `oil_gas_ecm`.`finance`.`investment_program` ALTER COLUMN `investment_program_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Program Identifier');
ALTER TABLE `oil_gas_ecm`.`finance`.`investment_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`investment_program` ALTER COLUMN `parent_investment_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` SET TAGS ('dbx_subdomain' = 'asset_accounting');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Identifier');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` ALTER COLUMN `tax_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`finance`.`sponsor` ALTER COLUMN `tax_id` SET TAGS ('dbx_pii_identifier' = 'true');
