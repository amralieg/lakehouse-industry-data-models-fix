-- Schema for Domain: finance | Business: Restaurants | Version: v1_mvm
-- Generated on: 2026-05-06 04:01:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `restaurants_ecm`.`finance` COMMENT 'Authoritative domain for general ledger (GL), accounts payable (AP), accounts receivable (AR), fixed assets (FA), cost center management, budgeting, P&L reporting, EBITDA tracking, CapEx/OpEx classification, revenue management, royalty income accounting, and multi-entity consolidation via SAP S/4HANA. GAAP/IFRS compliant financial statements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the general ledger account record. Primary key.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (company code) to which this GL account belongs. Supports multi-entity consolidation across franchise and company-owned operations.',
    `parent_account_gl_account_id` BIGINT COMMENT 'Reference to the parent account in the account hierarchy for roll-up reporting. Null for top-level accounts. Enables multi-level account group hierarchies.',
    `account_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for accounts that manage balances in a specific currency (e.g., USD, EUR, GBP). Null for accounts managed only in company code currency.. Valid values are `^[A-Z]{3}$`',
    `account_description` STRING COMMENT 'Detailed business description of the account purpose, usage guidelines, and what types of transactions should be posted to this account.',
    `account_group` STRING COMMENT 'SAP account group code that defines the accounts characteristics, field status, and number range. Controls account behavior and validation rules in SAP S/4HANA.',
    `account_name` STRING COMMENT 'Human-readable short name or title of the GL account (e.g., Food Cost - Beef, Franchise Royalty Revenue, Depreciation - Equipment).',
    `account_number` STRING COMMENT 'The externally-known unique account code used across all legal entities in the chart of accounts. Typically 6-10 digit numeric code following SAP S/4HANA GL numbering convention.. Valid values are `^[0-9]{6,10}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the GL account: active for normal use, blocked for temporarily suspended, closed for permanently retired, pending_activation for newly created accounts awaiting approval.. Valid values are `active|blocked|closed|pending_activation`',
    `account_type` STRING COMMENT 'High-level classification of the account into one of the five fundamental financial statement categories: asset, liability, equity, revenue, or expense.. Valid values are `asset|liability|equity|revenue|expense`',
    `alternate_account_number` STRING COMMENT 'Alternative or legacy account code used for cross-reference, migration mapping, or external reporting (e.g., mapping to previous ERP system account numbers).',
    `balance_sheet_classification` STRING COMMENT 'Specific balance sheet line item classification for asset, liability, and equity accounts. Set to not_applicable for P&L (Profit and Loss) accounts (revenue/expense).. Valid values are `current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable`',
    `cash_flow_classification` STRING COMMENT 'Classification of this account for cash flow statement presentation: operating for operational cash flows, investing for CapEx (Capital Expenditure) and asset transactions, financing for debt and equity, not_applicable for non-cash accounts.. Valid values are `operating|investing|financing|not_applicable`',
    `consolidation_account_number` STRING COMMENT 'Mapped account number used in corporate consolidation reporting to standardize accounts across multiple legal entities and chart of accounts structures.',
    `cost_element_category` STRING COMMENT 'Classification of cost element: primary for costs posted from external transactions (FI to CO), secondary for internal allocations and assessments, not_applicable if not a cost element.. Valid values are `primary|secondary|not_applicable`',
    `cost_element_indicator` BOOLEAN COMMENT 'Flag indicating whether this GL account is also defined as a cost element in SAP Controlling (CO) module for cost center and internal order postings.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this GL account record. Supports accountability and audit requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this GL account record was first created in the system. Audit trail for account master data governance.',
    `field_status_group` STRING COMMENT 'SAP field status group code that controls which fields are required, optional, or suppressed when posting transactions to this account.',
    `financial_statement_category` STRING COMMENT 'Detailed sub-classification within the account type for financial statement presentation (e.g., Current Assets, Long-Term Liabilities, Operating Revenue, Cost of Goods Sold (COGS), Selling General and Administrative (SG&A)).',
    `functional_area` STRING COMMENT 'Business function or operational area this account supports (e.g., Restaurant Operations, Franchise, Supply Chain, Marketing, Corporate, Real Estate). Used for segment reporting and management accounting.',
    `gaap_account_indicator` BOOLEAN COMMENT 'Flag indicating whether this account is used in GAAP-compliant financial statements. Supports dual-ledger reporting for companies reporting under both GAAP and IFRS.',
    `ifrs_account_indicator` BOOLEAN COMMENT 'Flag indicating whether this account is used in IFRS-compliant financial statements. Supports dual-ledger reporting for companies reporting under both GAAP and IFRS.',
    `intercompany_indicator` BOOLEAN COMMENT 'Flag indicating whether this account is used for intercompany transactions between legal entities that require elimination during consolidation.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this GL account record. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this GL account record was last updated. Tracks changes to account master data for audit and compliance.',
    `line_item_display_indicator` BOOLEAN COMMENT 'Flag indicating whether individual line item details are stored and displayed for this account. True for most operational accounts; false for summary accounts.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or business context about this GL account (e.g., usage guidelines, approval requirements, historical context).',
    `open_item_management_indicator` BOOLEAN COMMENT 'Flag indicating whether this account uses open item management for tracking and clearing individual transactions (e.g., for clearing accounts, suspense accounts).',
    `planning_level` STRING COMMENT 'Granularity level at which budget planning and forecasting is performed for this account (e.g., corporate, region, restaurant, cost_center).',
    `posting_allowed_indicator` BOOLEAN COMMENT 'Flag indicating whether direct transaction postings are allowed to this account. False for summary/header accounts that only receive totals from sub-accounts.',
    `profit_loss_classification` STRING COMMENT 'Specific P&L statement line item classification for revenue and expense accounts (e.g., Sales Revenue, COGS (Cost of Goods Sold), Labor Cost, Occupancy Cost, EBITDA (Earnings Before Interest Taxes Depreciation and Amortization)). Null for balance sheet accounts.',
    `reconciliation_account_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a reconciliation account (subledger control account) that summarizes detailed transactions from AP (Accounts Payable), AR (Accounts Receivable), or FA (Fixed Assets) subledgers.',
    `segment_reporting_indicator` BOOLEAN COMMENT 'Flag indicating whether transactions posted to this account are included in segment reporting for business unit, geographic, or product line analysis.',
    `sort_key` STRING COMMENT 'SAP sort key that determines the default sorting and grouping of line items posted to this account (e.g., by posting date, document number, or business partner).',
    `statistical_account_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a statistical account used for tracking non-monetary quantities (e.g., headcount, transaction counts, cover counts) without affecting financial balances.',
    `tax_category` STRING COMMENT 'Tax treatment classification for this account (e.g., taxable_revenue, non_taxable_revenue, input_tax, output_tax, exempt). Used for sales tax, VAT, and GST reporting.',
    `valid_from_date` DATE COMMENT 'Date from which this GL account becomes active and available for transaction posting. Supports time-dependent account master data.',
    `valid_to_date` DATE COMMENT 'Date until which this GL account remains active. Null for accounts with no planned end date. Used for account retirement and historical reporting.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'Chart of accounts master record for the general ledger in SAP S/4HANA (CO/GL modules). Defines every account code used across all legal entities, including P&L accounts, balance sheet accounts, cost element accounts, and statistical accounts. Supports multi-entity consolidation, GAAP/IFRS dual-ledger reporting, and account group hierarchies. Each record carries account type (asset, liability, equity, revenue, expense), functional area, account group, and currency settings.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: cost_center has brand_code as a plain denormalized column. Cost centers are structured by brand for brand-level cost allocation and overhead reporting in multi-brand foodservice operations. brand_code',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Cost centers in SAP CO belong to a specific company code (legal entity). The company_code STRING column is denormalized and should be replaced by a FK to the legal_entity master, enabling proper multi',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Cost centers in SAP CO are assigned to profit centers for P&L reporting. The profit_center_code STRING column is denormalized and should be replaced by a FK to the profit_center master, enabling prope',
    `budget_amount` DECIMAL(18,2) COMMENT 'The approved annual budget amount for this cost center in local currency. Used for variance analysis, Labor% and COGS% target setting, and OpEx control. Updated during annual budgeting cycles and mid-year reforecasts.',
    `budget_year` STRING COMMENT 'The fiscal year for which the budget_amount is applicable. Enables multi-year budget tracking and year-over-year variance analysis.',
    `business_area_code` STRING COMMENT 'The SAP business area classification. Used to segment financial reporting by line of business (e.g., QSR, casual dining, catering, franchise operations) for multi-brand or multi-format portfolios.. Valid values are `^[A-Z0-9]{4}$`',
    `capex_eligible_flag` BOOLEAN COMMENT 'Indicates whether this cost center is eligible to receive capital expenditure allocations. True for restaurant units (equipment, R&M), distribution centers, and major corporate facilities. False for pure administrative departments. Used to distinguish CapEx from OpEx in financial reporting.',
    `cogs_percent_target` DECIMAL(18,2) COMMENT 'The target COGS% (cost of goods sold as a percentage of revenue) for this cost center. Critical KPI for food cost management. Typical QSR targets range from 25-35%. Used for menu engineering, pricing strategy, and supplier negotiations.',
    `controlling_area_code` STRING COMMENT 'The SAP Controlling Area to which this cost center belongs. Controlling areas represent the highest level of cost accounting organization, typically aligned with legal entities or major geographic regions for multi-entity consolidation.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_category` STRING COMMENT 'High-level categorization of the cost centers role. Revenue-generating centers (FOH, BOH) directly contribute to sales; support centers (maintenance, training) enable operations; administrative centers (HR, finance) provide governance; overhead centers (facilities, utilities) are indirect; capital project centers track CapEx initiatives.. Valid values are `revenue_generating|support|administrative|overhead|capital_project`',
    `cost_center_code` STRING COMMENT 'The externally-known alphanumeric code for the cost center as defined in SAP S/4HANA Controlling module. Used in financial reporting and P&L statements.. Valid values are `^[A-Z0-9]{4,12}$`',
    `cost_center_description` STRING COMMENT 'Free-text description providing additional context about this cost centers purpose, scope, or special characteristics. Used for documentation and reporting clarity.',
    `cost_center_name` STRING COMMENT 'The full business name of the cost center (e.g., Store #1234 - Downtown Chicago, Regional Office - Midwest, Corporate HR Department).',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active centers accept cost postings; inactive centers are temporarily disabled; pending centers are awaiting approval; closed centers are permanently retired; suspended centers are on hold; planned centers are scheduled for future activation (e.g., NRO pipeline).. Valid values are `active|inactive|pending|closed|suspended|planned`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by organizational function. Restaurant units are individual QSR locations; regional offices manage geographic territories; corporate departments are headquarters functions; shared service centers provide centralized support; distribution centers handle supply chain; franchise support manages franchisee relations.. Valid values are `restaurant_unit|regional_office|corporate_department|shared_service_center|distribution_center|franchise_support`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where this cost center operates. Used for multi-country consolidation, currency translation, and jurisdiction-specific compliance (FDA, USDA, local health departments).. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'The user ID of the person who created this cost center record. Used for audit trails and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost center record was first created in the system. Used for audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for this cost centers local currency. Used for budget planning, cost allocation, and multi-currency consolidation in GAAP/IFRS financial statements.. Valid values are `^[A-Z]{3}$`',
    `drive_thru_lanes` STRING COMMENT 'The number of drive-thru lanes at this location. Nullable for non-DT formats. Critical for SOS (Speed of Service) analysis, throughput capacity planning, and DT-specific cost allocation.',
    `format_code` STRING COMMENT 'The restaurant format classification. Examples: DT (Drive-Thru), DINE_IN, KIOSK, FOOD_COURT, AIRPORT, GHOST_KITCHEN. Used for format-specific cost benchmarking, throughput analysis, and real estate site selection.. Valid values are `^[A-Z0-9]{2,6}$`',
    `franchise_flag` BOOLEAN COMMENT 'Indicates whether this cost center represents a franchise-owned unit (true) or a company-owned unit (false). Critical for revenue recognition (royalty income vs direct sales), P&L consolidation, and franchise compliance tracking.',
    `functional_area_code` STRING COMMENT 'The functional area classification for cross-company-code reporting. Typical values include operations, marketing, R&D, administration, IT, finance. Used for functional P&L views and OpEx analysis.. Valid values are `^[A-Z0-9]{4}$`',
    `labor_percent_target` DECIMAL(18,2) COMMENT 'The target Labor% (labor cost as a percentage of revenue) for this cost center. Critical KPI for restaurant operations. Typical QSR targets range from 20-30%. Used for workforce scheduling optimization and P&L performance evaluation.',
    `last_modified_by_user` STRING COMMENT 'The user ID of the person who last modified this cost center record. Used for audit trails and change accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost center record was last updated. Used for change tracking and data freshness validation.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or historical context. Examples: Undergoing renovation Q2 2024, Pilot location for new POS system, Seasonal closure Nov-Mar.',
    `opex_allocation_method` STRING COMMENT 'The method used to allocate shared operating expenses to this cost center. Direct costs are posted directly; allocated methods distribute corporate overhead based on revenue, headcount, square footage, transaction volume, or fixed percentages. Used for full-absorption P&L reporting.. Valid values are `direct|allocated_revenue|allocated_headcount|allocated_sqft|allocated_transactions|fixed_percentage`',
    `parent_cost_center_code` STRING COMMENT 'The cost center code of the immediate parent in the organizational hierarchy. Nullable for top-level cost centers. Enables recursive hierarchy traversal for regional and corporate rollups.',
    `region_code` STRING COMMENT 'The geographic region code for this cost center. Used for regional P&L rollups, SSS (Same-Store Sales) analysis, and regional manager accountability. Examples: NEAST, SWEST, MIDWEST, INTL.. Valid values are `^[A-Z]{2,4}$`',
    `seating_capacity` STRING COMMENT 'The number of customer seats available at this cost center location. Nullable for non-dine-in formats (drive-thru only, ghost kitchens). Used for cover count analysis, table turn calculations, and throughput benchmarking.',
    `square_footage` STRING COMMENT 'The total interior square footage of this cost center facility. Used for OpEx allocation (utilities, CAM charges), productivity metrics (sales per square foot), and real estate valuation.',
    `valid_from_date` DATE COMMENT 'The date from which this cost center becomes effective and can accept cost postings. Aligns with NRO (New Restaurant Opening) dates for restaurant units or organizational change effective dates for corporate centers.',
    `valid_to_date` DATE COMMENT 'The date through which this cost center remains effective. Nullable for open-ended cost centers. Populated when a restaurant closes, a department is dissolved, or a regional office is consolidated.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Organizational cost center master data and cost allocation activity from SAP S/4HANA CO module. Represents the smallest unit of cost accountability — individual restaurant units, regional offices, corporate departments, and shared service centers. Master data tracks cost center type (restaurant, regional, corporate), responsible manager, controlling area, profit center assignment, valid-from/to dates, and hierarchy node. Allocation activity captures periodic distributions of shared costs (corporate overhead, IT, HR, marketing fund) using defined allocation keys (headcount, revenue, square footage), including sender/receiver relationships, allocation cycles, allocation rules, basis amounts, and reversal indicators. Enables fully-loaded restaurant P&L, Labor%/COGS%/OpEx allocation, accurate EBITDA by unit, and transparent overhead burden rates for franchise vs. company-owned comparisons.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique identifier for the profit center. Primary key for the profit center master record in SAP S/4HANA EC-PCA module.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: profit_center has brand_code as a plain denormalized column. Profit centers are organized by brand for brand-level segment P&L reporting — a regulatory and management reporting requirement in multi-br',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Profit centers in SAP EC-PCA belong to a specific company code (legal entity). The company_code STRING column is denormalized and should be replaced by a FK to the legal_entity master, enabling proper',
    `parent_profit_center_id` BIGINT COMMENT 'Reference to the parent profit center in the organizational hierarchy. Enables recursive roll-up for regional and brand-level P&L aggregation.',
    `aov_target_amount` DECIMAL(18,2) COMMENT 'Target annual revenue for this profit center expressed in the profit centers functional currency. Used for AUV benchmarking and performance variance analysis.',
    `business_area_code` STRING COMMENT 'SAP business area code for cross-company-code reporting. Enables consolidated P&L views across multiple legal entities within the same business segment.',
    `closure_date` DATE COMMENT 'Date the profit center ceased operations. Null for active profit centers. Used for historical P&L analysis and closed-unit portfolio reporting.',
    `closure_reason` STRING COMMENT 'Business reason for profit center closure (e.g., lease expiration, underperformance, market exit, franchise termination). Used for portfolio optimization analysis.',
    `consolidation_unit_code` STRING COMMENT 'Code identifying the consolidation unit for multi-entity financial consolidation. Used in GAAP/IFRS-compliant consolidated financial statement preparation.',
    `controlling_area_code` STRING COMMENT 'SAP controlling area to which this profit center is assigned. Controlling area represents the organizational unit for cost accounting and internal reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_group_code` STRING COMMENT 'Code of the cost center group associated with this profit center. Links profit center P&L to underlying cost center actuals for COGS and OpEx analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this profit center record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for P&L reporting (e.g., USD, EUR, GBP). Determines the functional currency for this profit centers financial transactions.. Valid values are `^[A-Z]{3}$`',
    `ebitda_target_amount` DECIMAL(18,2) COMMENT 'Target EBITDA for this profit center expressed in the profit centers functional currency. Used for profitability benchmarking and executive performance evaluation.',
    `geographic_region_code` STRING COMMENT 'Code representing the geographic region (e.g., Northeast, Southwest, EMEA, APAC). Used for regional P&L consolidation and market performance analysis.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this profit center record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this profit center record was last updated. Used for change tracking and data quality monitoring.',
    `lock_indicator` BOOLEAN COMMENT 'Flag indicating whether the profit center is locked for transaction posting. Locked centers cannot receive new P&L entries but remain visible for historical reporting.',
    `marketing_fund_rate_percent` DECIMAL(18,2) COMMENT 'Marketing fund contribution rate percentage for franchise profit centers. Represents the percentage of gross sales contributed to the brand marketing fund.',
    `notes` STRING COMMENT 'Free-text notes and comments about the profit center. Used to document special circumstances, organizational changes, or reporting exceptions.',
    `opening_date` DATE COMMENT 'Date the profit center commenced operations. Used to calculate operating tenure for SSS eligibility and maturity-based performance benchmarking.',
    `ownership_model` STRING COMMENT 'Ownership structure of the profit center. Determines revenue recognition treatment, royalty income accounting, and CapEx/OpEx allocation rules.. Valid values are `company_owned|franchise|joint_venture|licensed`',
    `profit_center_category` STRING COMMENT 'Functional category of the profit center. Operating centers generate direct revenue; non-operating centers represent overhead or shared services allocated to operating units.. Valid values are `operating|non_operating|corporate|shared_services`',
    `profit_center_code` STRING COMMENT 'Business identifier code for the profit center as defined in SAP controlling area. Used in financial reporting and P&L statements.. Valid values are `^[A-Z0-9]{4,10}$`',
    `profit_center_name` STRING COMMENT 'Full descriptive name of the profit center (e.g., Downtown Chicago QSR Unit 1234, Northeast Regional Franchise Group, Company-Owned Casual Dining Segment).',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center. Active centers participate in P&L reporting; inactive centers are excluded from current period consolidation.. Valid values are `active|inactive|pending|closed`',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Royalty rate percentage applied to franchise profit centers. Represents the percentage of gross sales remitted to the franchisor as ongoing royalty income.',
    `segment_reporting_flag` BOOLEAN COMMENT 'Indicates whether this profit center is a reportable segment under GAAP ASC 280 or IFRS 8. Reportable segments require separate disclosure in external financial statements.',
    `segment_type` STRING COMMENT 'Classification of the profit center by business segment type. Determines the level of P&L aggregation and reporting hierarchy.. Valid values are `restaurant_unit|brand_segment|geographic_region|franchise_group|company_owned_group|channel_segment`',
    `short_name` STRING COMMENT 'Abbreviated name or alias for the profit center used in reports and dashboards for space-constrained displays.',
    `sss_eligible_flag` BOOLEAN COMMENT 'Indicates whether this profit center is included in Same-Store Sales (SSS) / Comparable Store Sales (Comp Sales) calculations. Typically requires 12+ months of operating history.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the primary tax jurisdiction for this profit center. Determines applicable sales tax, VAT, and income tax treatment in P&L reporting.',
    `valid_from_date` DATE COMMENT 'Effective start date for this profit center record. Profit center becomes active for P&L posting and reporting from this date forward.',
    `valid_to_date` DATE COMMENT 'Effective end date for this profit center record. Profit center is excluded from P&L posting and reporting after this date. Null for open-ended validity.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Profit center master record from SAP S/4HANA EC-PCA module. Represents a business segment for internal P&L reporting — individual restaurant units, brand segments, geographic regions, or franchise vs. company-owned groupings. Supports SSS (Same-Store Sales) reporting, AUV (Average Unit Volume) tracking, and EBITDA decomposition by segment. Carries hierarchy assignment, controlling area, and responsible executive.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity record. Primary key.',
    `parent_entity_legal_entity_id` BIGINT COMMENT 'Foreign key reference to the parent legal entity in the corporate hierarchy. Null for the ultimate parent company.',
    `primary_ultimate_parent_entity_legal_entity_id` BIGINT COMMENT 'Foreign key reference to the top-level parent entity in the corporate structure. Used for ultimate consolidation and group reporting.',
    `accounting_standard` STRING COMMENT 'Primary accounting framework used for financial statement preparation. GAAP for US entities, IFRS for international, or local statutory standards.. Valid values are `GAAP|IFRS|local_statutory`',
    `address_line_1` STRING COMMENT 'First line of the legal entitys registered office address as filed with corporate registry.',
    `address_line_2` STRING COMMENT 'Second line of the legal entitys registered office address (suite, floor, building name).',
    `city` STRING COMMENT 'City or municipality of the legal entitys registered office.',
    `company_code` STRING COMMENT 'Four-character alphanumeric code uniquely identifying the legal entity in SAP S/4HANA FI. Used as the organizational unit for financial accounting and external reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_group_code` STRING COMMENT 'Identifier of the consolidation group or reporting segment this entity belongs to for multi-entity financial consolidation.',
    `consolidation_method` STRING COMMENT 'Method used to consolidate this entitys financial results into group reporting. Full for subsidiaries, equity for associates, none for non-consolidated entities.. Valid values are `full|proportionate|equity|none`',
    `controlling_area` STRING COMMENT 'SAP S/4HANA organizational unit for cost accounting, internal reporting, and profitability analysis. May span multiple company codes.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the legal entitys registered office address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was first created in the system.',
    `credit_control_area` STRING COMMENT 'SAP S/4HANA organizational unit for managing customer credit limits and credit exposure across one or more company codes.',
    `dissolution_date` DATE COMMENT 'Date the legal entity was officially dissolved or ceased operations. Null for active entities.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet for business credit and supplier management.. Valid values are `^[0-9]{9}$`',
    `effective_from_date` DATE COMMENT 'Date from which this legal entity record is effective for financial posting and reporting. Used for time-dependent organizational changes.',
    `effective_to_date` DATE COMMENT 'Date until which this legal entity record is effective. Null for currently active entities. Used for historical tracking of organizational changes.',
    `entity_status` STRING COMMENT 'Current operational and legal status of the entity. Active entities post transactions; inactive entities are retained for historical reporting.. Valid values are `active|inactive|dormant|liquidation|dissolved`',
    `entity_type` STRING COMMENT 'Classification of the legal entity structure. Determines ownership model, consolidation treatment, and reporting obligations.. Valid values are `company_owned|franchise_subsidiary|holding_company|joint_venture|partnership|branch`',
    `fiscal_year_end_month` STRING COMMENT 'Month number (1-12) representing the end of the entitys fiscal year. 12 = December for calendar year entities.',
    `fiscal_year_variant` STRING COMMENT 'Code defining the fiscal year calendar structure (e.g., calendar year, 4-4-5 retail calendar, 52/53 week year) used by this entity.',
    `incorporation_date` DATE COMMENT 'Date the legal entity was officially registered or incorporated with the governing jurisdiction.',
    `intercompany_clearing_flag` BOOLEAN COMMENT 'Indicates whether this entity participates in automated intercompany clearing and reconciliation processes for intra-group transactions.',
    `jurisdiction_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the jurisdiction where the entity is incorporated and legally domiciled.. Valid values are `^[A-Z]{3}$`',
    `jurisdiction_state_province` STRING COMMENT 'State, province, or sub-national jurisdiction where the entity is registered. Relevant for federal systems (USA, Canada, etc.).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was last updated.',
    `legal_name` STRING COMMENT 'Full registered legal name of the entity as filed with government authorities. Used on official financial statements, tax filings, and legal contracts.',
    `lei_code` STRING COMMENT '20-character alphanumeric Legal Entity Identifier issued by the Global LEI Foundation for financial transaction reporting and regulatory compliance.. Valid values are `^[A-Z0-9]{20}$`',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the entitys functional currency for financial reporting and local statutory books.. Valid values are `^[A-Z]{3}$`',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of equity ownership held by the parent entity. 100.00 for wholly-owned subsidiaries, less for joint ventures or minority interests.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the legal entitys registered office.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for the legal entity.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary business contact or registered agent for the legal entity.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary business contact for the legal entity.',
    `profit_center_required_flag` BOOLEAN COMMENT 'Indicates whether profit center assignment is mandatory for all financial postings in this legal entity. True enforces segment reporting compliance.',
    `registration_number` STRING COMMENT 'Official registration or incorporation number assigned by the jurisdictions corporate registry.',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code used for consolidated group reporting. Typically USD for US-based parent companies.. Valid values are `^[A-Z]{3}$`',
    `segment_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this entity is subject to segment reporting requirements under GAAP ASC 280 or IFRS 8.',
    `short_name` STRING COMMENT 'Abbreviated or trade name used for internal reporting and operational reference.',
    `state_province` STRING COMMENT 'State, province, or region of the legal entitys registered office.',
    `tax_identification_number` STRING COMMENT 'Government-issued tax identifier (EIN in USA, VAT number in EU, etc.) used for tax filing and reporting.',
    `vat_registration_number` STRING COMMENT 'VAT or GST registration number for entities operating in jurisdictions with value-added tax systems. Used for tax reporting and invoice compliance.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master record for each legal entity (company code) within the Restaurants corporate structure and intercompany transaction activity from SAP S/4HANA FI. Covers company-owned operating entities, holding companies, franchise subsidiaries, and joint ventures across all geographies. Entity master stores fiscal year variant, chart of accounts assignment, local currency, tax jurisdiction, GAAP/IFRS reporting standard, and consolidation group membership. Intercompany activity captures management fee charges, shared service allocations, intercompany loans, cross-entity food supply transfers, netting status, elimination flags, and reconciliation periods. Foundation for multi-entity financial consolidation, intercompany elimination in consolidated financial statements, and segment reporting.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record. Primary key for the journal entry header in SAP S/4HANA FI-GL.',
    `approver_user_employee_id` BIGINT COMMENT 'SAP user ID of the person who approved this journal entry for posting. Populated only for entries requiring approval workflow. Used for segregation of duties compliance.',
    `employee_id` BIGINT COMMENT 'SAP user ID of the person who approved this journal entry for posting. Populated only for entries requiring approval workflow. Used for segregation of duties compliance.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Journal entries are posted within a specific financial period. The fiscal_period (INT) and fiscal_year (INT) columns are denormalized period identifiers that should be replaced by a FK to the financia',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Every GL journal entry in SAP FI-GL belongs to a specific company code (legal entity). Adding legal_entity_id normalizes the company_code string into a proper FK reference to the legal_entity master. ',
    `primary_journal_employee_id` BIGINT COMMENT 'SAP user ID of the person or system account that posted this journal entry. Used for audit trail and segregation of duties monitoring.',
    `tertiary_journal_last_modified_user_employee_id` BIGINT COMMENT 'SAP user ID of the person who last modified this journal entry header (e.g., added notes, changed status). Blank if never modified after initial posting.',
    `adjustment_period_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry was posted in a special adjustment period (periods 13-16) for year-end close. True if adjustment period; False if regular period.',
    `approval_timestamp` TIMESTAMP COMMENT 'Exact date and time when the journal entry was approved. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Null if no approval required or not yet approved.',
    `audit_class` STRING COMMENT 'Classification of the journal entry for audit sampling and risk assessment. Values: standard (routine posting), high_risk (unusual or large amount), manual_adjustment (manual journal entry requiring scrutiny), system_generated (automated posting).. Valid values are `standard|high_risk|manual_adjustment|system_generated`',
    `baseline_payment_date` DATE COMMENT 'The baseline date from which payment terms are calculated (typically document date or posting date). Used to determine net due date and discount periods. Format: yyyy-MM-dd.',
    `batch_input_session` STRING COMMENT 'Name of the batch input session if this journal entry was posted via batch processing (e.g., mass upload, automated interface). Blank for manually posted entries.',
    `clearing_date` DATE COMMENT 'The date on which this journal entry was cleared. Populated only for cleared documents. Format: yyyy-MM-dd.',
    `clearing_document_number` STRING COMMENT 'The document number of the clearing document if this journal entry has been cleared (e.g., open item cleared by payment or offsetting entry). Blank if not cleared.. Valid values are `^[0-9]{10}$`',
    `consolidation_transaction_type` STRING COMMENT 'Three-character code classifying the journal entry for consolidation purposes (e.g., 100=standard posting, 200=intercompany elimination, 300=currency translation adjustment, 400=consolidation adjustment). Used in multi-entity financial consolidation.. Valid values are `^[A-Z0-9]{3}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the document currency (e.g., USD, EUR, GBP). All line item amounts in this journal entry are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date printed on the source document (invoice date, receipt date, contract date). May differ from posting date. Used for aging analysis and payment terms calculation. Format: yyyy-MM-dd.',
    `document_header_text` STRING COMMENT 'Free-text description or memo entered at the document header level. Provides business context for the journal entry (e.g., Monthly depreciation run, Accrual for Q4 marketing expenses).',
    `document_number` STRING COMMENT 'Ten-digit accounting document number assigned by SAP upon posting. The externally-known unique identifier for this journal entry within the company code and fiscal year. Used for audit trail and cross-reference.. Valid values are `^[0-9]{10}$`',
    `document_type` STRING COMMENT 'Two-character code classifying the nature of the accounting document (e.g., SA=GL account document, KR=vendor invoice, DR=customer invoice, AB=accounting document, AA=asset posting). Controls number ranges and posting keys.. Valid values are `^[A-Z]{2}$`',
    `entry_date` DATE COMMENT 'The calendar date on which the document was entered into the SAP system by the user. Used for audit trail and processing time analysis. Format: yyyy-MM-dd.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert document currency to local currency at the time of posting. Expressed as local currency per one unit of document currency.',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry involves intercompany transactions between multiple legal entities within the corporate group. True if intercompany; False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Exact date and time of the last modification to this journal entry header. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Null if never modified.',
    `ledger_group` STRING COMMENT 'Two-character code identifying the ledger in which this entry is posted (e.g., 0L=leading ledger for GAAP, 2L=IFRS ledger, 3L=management ledger). Supports parallel accounting for multiple reporting standards.. Valid values are `^[A-Z0-9]{2}$`',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the company code local currency. Used for statutory reporting and consolidation.. Valid values are `^[A-Z]{3}$`',
    `net_due_date` DATE COMMENT 'The calculated due date for payment based on payment terms and baseline date. Used for cash flow forecasting and AP/AR aging. Format: yyyy-MM-dd.',
    `parked_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is in parked status (saved but not yet posted). True if parked; False if posted. Parked documents do not update GL balances until posted.',
    `payment_terms_code` STRING COMMENT 'Four-character code defining payment terms for vendor invoices or customer invoices (e.g., net 30, 2/10 net 30). Used to calculate due dates and cash discount eligibility.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'The date on which the journal entry is posted to the general ledger. Determines the fiscal period assignment and is the primary date for financial reporting. Format: yyyy-MM-dd.',
    `posting_key` STRING COMMENT 'Two-digit numeric code that controls the type of posting (debit or credit) and the account type (e.g., 40=debit GL, 50=credit GL, 01=debit customer, 31=debit vendor). Determines field status and processing logic.. Valid values are `^[0-9]{2}$`',
    `posting_timestamp` TIMESTAMP COMMENT 'Exact date and time when the journal entry was posted to the general ledger. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and real-time reporting.',
    `reference_document_number` STRING COMMENT 'Free-text field for external reference numbers such as vendor invoice number, purchase order number, or intercompany document reference. Used for reconciliation and audit trail.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a reversal of a prior posting. True if this document reverses another document; False otherwise.',
    `reversal_reason_code` STRING COMMENT 'Two-character code explaining why the document was reversed (e.g., 01=reversal in current period, 02=reversal in next period, 03=error correction). Populated only for reversal documents.. Valid values are `^[A-Z0-9]{2}$`',
    `reversed_document_number` STRING COMMENT 'The document number of the original journal entry that this entry reverses. Populated only when reversal_indicator is True. Maintains audit trail for accrual reversals and error corrections.. Valid values are `^[0-9]{10}$`',
    `source_system_code` STRING COMMENT 'Code identifying the originating system for this journal entry (e.g., SAP_ECC, SAP_S4, LEGACY_GL, COUPA, WORKDAY). Used for data lineage and interface reconciliation.. Valid values are `^[A-Z0-9]{3,10}$`',
    `tax_reporting_date` DATE COMMENT 'The date used for tax reporting purposes (may differ from posting date based on jurisdiction rules). Used for VAT/GST returns and sales tax filings. Format: yyyy-MM-dd.',
    `trading_partner_company_code` STRING COMMENT 'Four-character company code of the intercompany trading partner. Populated only when intercompany_indicator is True. Used for intercompany reconciliation and elimination entries.. Valid values are `^[A-Z0-9]{4}$`',
    `transaction_code` STRING COMMENT 'SAP transaction code (T-code) used to create this journal entry (e.g., FB01, FB50, F-02). Indicates the posting method and user interface path.. Valid values are `^[A-Z0-9_]{4,10}$`',
    `workflow_status` STRING COMMENT 'Current state of the journal entry in the approval workflow. Values: draft (initial entry), pending_approval (submitted for review), approved (authorized but not posted), posted (final state in GL), rejected (not approved), cancelled (voided before posting).. Valid values are `draft|pending_approval|approved|posted|rejected|cancelled`',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'General ledger journal entry from SAP S/4HANA FI-GL, encompassing both header and line-level detail. Captures every financial posting across all legal entities — accruals, reversals, intercompany eliminations, period-end adjustments, and manual corrections. Header stores document type, posting date, fiscal period, reference document, ledger (leading/non-leading), currency, and posting user. Each line carries GL account, cost center, profit center, functional area, business area, debit/credit amount in document and local currency, tax code, assignment field, and line item text. The authoritative audit trail for all GL movements supporting GAAP/IFRS compliance, P&L drill-down, balance sheet construction, intercompany reconciliation, and external audit evidence.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for granular GL transaction tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Link line to cost_center master to normalize cost center details.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset master record if this line represents a fixed asset transaction (acquisition, depreciation, disposal). Null for non-FA entries.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Replace gl_account_code with authoritative FK to gl_account for detailed account attributes.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header. Links this line to the overall accounting document.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to realestate.lease. Business justification: Under IFRS 16/ASC 842, journal entry lines for ROU amortization, interest expense, and lease liability reduction must reference the specific lease. Lease accounting reconciliation and external audit r',
    `profile_id` BIGINT COMMENT 'Reference to the customer master record if this line represents an accounts receivable transaction. Null for non-AR entries.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Link line to profit_center master for consistent profit center data.',
    `amount_document_currency` DECIMAL(18,2) COMMENT 'Transaction amount in the original document currency. Used for multi-currency transactions before conversion to local currency.',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'Transaction amount converted to the local reporting currency of the legal entity. Used for consolidated financial statements.',
    `assignment_field` STRING COMMENT 'Free-text assignment field for additional reference information. Often used for invoice numbers, PO numbers, or internal tracking codes.',
    `baseline_date` DATE COMMENT 'Baseline date for payment terms calculation. Typically the invoice date or goods receipt date.',
    `business_area_code` STRING COMMENT 'Business area for segment reporting. May represent franchise vs. company-owned, or QSR vs. casual dining divisions.. Valid values are `^[A-Z0-9]{2,6}$`',
    `clearing_date` DATE COMMENT 'Date on which this open item was cleared (paid or settled). Null if still open.',
    `clearing_document_number` STRING COMMENT 'Document number of the clearing entry that settled this open item. Null if the line item is still open.',
    `company_code` STRING COMMENT 'Four-character company code representing the legal entity. Required for multi-entity consolidation and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this line is a debit (D) or credit (C) entry. Fundamental to double-entry bookkeeping.. Valid values are `D|C`',
    `document_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the document currency (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'Date of the source document (invoice date, receipt date). May differ from posting date for backdated or future-dated entries.',
    `due_date` DATE COMMENT 'Payment due date for AP/AR line items. Calculated based on posting date and payment terms. Null for non-payable/receivable entries.',
    `entry_date` DATE COMMENT 'Date on which the journal entry was created in the system. Audit trail for data entry timing.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate applied to convert document currency to local currency. Null if currencies are the same.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year. Typically 1-12 for monthly periods, or 1-13 for year-end adjustments.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this line item is posted. Derived from the posting date and fiscal calendar configuration.',
    `functional_area_code` STRING COMMENT 'Functional area classification for cost-of-sales accounting. Distinguishes COGS, labor, R&M, marketing, and administrative expenses.. Valid values are `^[A-Z0-9]{2,6}$`',
    `line_item_text` STRING COMMENT 'Descriptive text explaining the purpose or nature of this journal entry line. Provides business context for the transaction.',
    `line_number` STRING COMMENT 'Sequential line number within the journal entry. Determines the order of debit and credit entries.',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the local reporting currency.. Valid values are `^[A-Z]{3}$`',
    `payment_terms_code` STRING COMMENT 'Payment terms code for AP/AR line items. Defines due date calculation and discount terms.. Valid values are `^[A-Z0-9]{2,6}$`',
    `posting_date` DATE COMMENT 'Date on which this line item was posted to the general ledger. Determines the fiscal period assignment.',
    `posting_key` STRING COMMENT 'Two-digit posting key that controls the account type (GL, vendor, customer, asset) and debit/credit indicator. SAP-specific control field.. Valid values are `^[0-9]{2}$`',
    `reference_document_number` STRING COMMENT 'External reference document number (e.g., vendor invoice number, customer receipt number). Links GL entry to source transaction.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this line item is a reversal entry. True if this line reverses a prior posting.',
    `reversed_document_number` STRING COMMENT 'Document number of the original entry that this line reverses. Null if not a reversal.',
    `special_gl_indicator` STRING COMMENT 'Single-character code for special GL transactions (e.g., down payments, guarantees, bills of exchange). Blank for standard postings.. Valid values are `^[A-Z]$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount calculated for this line item in local currency. Null if the line is non-taxable.',
    `tax_code` STRING COMMENT 'Tax code applied to this line item. Determines sales tax, VAT, or GST treatment for revenue and expense transactions.. Valid values are `^[A-Z0-9]{2,6}$`',
    `trading_partner_code` STRING COMMENT 'Trading partner code for intercompany transactions. Identifies the counterparty legal entity for consolidation and elimination entries.. Valid values are `^[A-Z0-9]{4,10}$`',
    `transaction_code` STRING COMMENT 'SAP transaction code (T-code) used to create this entry (e.g., FB01, FB50, MIRO). Audit trail for process identification.. Valid values are `^[A-Z0-9]{4,8}$`',
    `user_name` STRING COMMENT 'SAP user ID of the person who created this journal entry line. Audit trail for accountability.',
    `value_date` DATE COMMENT 'Value date for cash management and bank reconciliation. Represents the effective date funds are available or debited.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit/credit line items within a GL journal entry from SAP S/4HANA FI-GL. Each line carries GL account, cost center, profit center, functional area, business area, amount in document and local currency, tax code, assignment field, and line item text. Enables granular P&L and balance sheet drill-down, cost center reporting, and intercompany reconciliation at the line level.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts payable invoice record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the invoice for payment. Used for audit trail and segregation of duties compliance.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Allows AP invoices for marketing media purchases to be tied to the originating campaign, supporting financial reconciliation and campaign ROI calculations.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: AP invoices are posted within a specific financial period. The fiscal_period and fiscal_year integer columns are denormalized period identifiers that should be replaced by a FK to the financial_period',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: AP invoices in SAP FI-AP are posted to a specific company code (legal entity). Adding legal_entity_id normalizes the company_code string into a proper FK to the legal_entity master, enabling multi-ent',
    `maintenance_contract_id` BIGINT COMMENT 'Foreign key linking to realestate.maintenance_contract. Business justification: AP invoices from maintenance vendors are matched against maintenance contracts for three-way matching and contract spend tracking. Foodservice operators validate vendor invoices against contract terms',
    `primary_ap_created_by_user_employee_id` BIGINT COMMENT 'The user ID of the person who created the invoice record in the system. Used for audit trail and accountability.',
    `unit_id` BIGINT COMMENT 'Identifier for the restaurant location or unit to which this invoice expense is allocated. Used for unit-level P&L and Average Unit Volume (AUV) analysis.',
    `tertiary_ap_modified_by_user_employee_id` BIGINT COMMENT 'The user ID of the person who last modified the invoice record. Used for audit trail and change accountability.',
    `approval_date` DATE COMMENT 'The date the invoice was approved for payment. Used for tracking approval cycle time and compliance with payment policies.',
    `approval_status` STRING COMMENT 'Status of the invoice approval workflow. Indicates whether the invoice has been reviewed and approved for payment by authorized personnel.. Valid values are `pending|approved|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the invoice record was first created in the system. Used for audit trail and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the invoice, including early payment discounts, volume discounts, or promotional allowances.',
    `due_date` DATE COMMENT 'The date by which payment is due to the vendor per the payment terms. Used for cash flow forecasting and aging analysis.',
    `dunning_level` STRING COMMENT 'The dunning level or escalation stage for overdue invoices. Zero indicates no dunning. Higher numbers indicate escalated collection efforts.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert foreign currency invoice amounts to the company code local currency. Null for invoices in local currency.',
    `expense_category` STRING COMMENT 'High-level categorization of the invoice expense type. Used for Cost of Goods Sold (COGS) percentage and Operating Expense (OpEx) tracking.. Valid values are `food_beverage|equipment|repairs_maintenance|utilities|services|other`',
    `goods_receipt_number` STRING COMMENT 'The goods receipt document number confirming physical receipt of goods or services. Used for three-way matching.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before any deductions, including line item charges and taxes. Represents the full amount billed by the vendor.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. This is the principal business event timestamp for the invoice transaction.',
    `invoice_description` STRING COMMENT 'Free-text description or memo field providing additional context about the invoice, such as the nature of goods or services purchased.',
    `invoice_number` STRING COMMENT 'The vendor-assigned invoice number as printed on the supplier invoice document. This is the externally-known business identifier for the invoice.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts payable workflow.. Valid values are `draft|posted|approved|paid|cancelled|on_hold`',
    `invoice_type` STRING COMMENT 'Classification of the invoice document type (standard invoice, credit memo for returns, debit memo for additional charges, prepayment, or recurring invoice).. Valid values are `standard|credit_memo|debit_memo|prepayment|recurring`',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Net invoice amount converted to the company code local currency using the exchange rate. Used for consolidated financial reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the invoice record was last modified. Used for audit trail and change tracking.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount payable to the vendor after applying discounts and adjustments. This is the amount that will be paid.',
    `payment_block_indicator` STRING COMMENT 'Code indicating whether payment is blocked and the reason for the block (e.g., pricing dispute, quantity variance, quality issue). Empty if no block is active.',
    `payment_date` DATE COMMENT 'The date the invoice was actually paid to the vendor. Null if the invoice is unpaid.',
    `payment_method` STRING COMMENT 'The payment instrument or method used to pay the invoice (check, ACH, wire transfer, credit card, cash).. Valid values are `check|ach|wire_transfer|credit_card|cash`',
    `payment_reference_number` STRING COMMENT 'The payment document number or transaction reference assigned when the invoice was paid. Used for payment reconciliation and audit trail.',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms agreed with the vendor (e.g., Net 30, 2/10 Net 30). Determines due date calculation and early payment discount eligibility.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the general ledger. Used for period assignment and financial reporting.',
    `purchase_order_number` STRING COMMENT 'The purchase order number against which this invoice is being verified. Used for three-way matching and spend tracking.',
    `reference_document_number` STRING COMMENT 'Reference to a related document such as the original invoice for a credit memo, or a contract number. Provides audit trail and document linkage.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the invoice, including sales tax, VAT, GST, or other applicable taxes.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match process comparing purchase order (PO), goods receipt (GR), and invoice. Indicates whether the invoice matches the PO and GR within tolerance or has variances.. Valid values are `matched|variance_quantity|variance_price|variance_gr|not_applicable|pending`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from the invoice payment as required by tax regulations. Reduces the net payment to the vendor.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts payable vendor invoice and payment lifecycle from SAP S/4HANA FI-AP, encompassing invoice header, line-level detail, and outbound payment settlement. Records all supplier invoices for food and beverage purchases, equipment, R&M, utilities, and services. Header stores vendor ID, invoice date, due date, payment terms, gross/net amount, tax, currency, payment block, three-way match status, and dunning level. Each line captures purchased item/service, quantity, unit price, GL account, cost center, PO reference, goods receipt reference, and tax code. Payment data stores payment method (ACH, wire, check), payment date, bank account, cleared invoice references, discount taken, and payment run ID. Enables COGS% analysis by ingredient category, food vs. non-food spend split, three-way match reconciliation, DPO (Days Payable Outstanding) tracking, cash discount optimization, and cash flow forecasting.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'Unique identifier for the accounts payable payment transaction. Primary key.',
    `bank_account_id` BIGINT COMMENT 'Identifier for the companys bank account from which payment was debited. Used for cash management and bank reconciliation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ap_payment has a cost_center STRING column that stores the cost center code for payment allocation. This should be normalized to a FK reference to the cost_center master. The string cost_center column',
    `employee_id` BIGINT COMMENT 'User ID or system identifier that initiated the payment run or created the payment document.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: AP payments are recorded within a specific financial period. The fiscal_period and fiscal_year integer columns are denormalized period identifiers replaced by a FK to the financial_period master for p',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: ap_payment has a gl_account STRING column that stores the GL account code for the payment clearing entry. This should be normalized to a FK reference to gl_account master. The string gl_account column',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: AP payment runs in SAP FI-AP are executed within a specific company code (legal entity). Adding legal_entity_id normalizes the company_code string into a proper FK to the legal_entity master for multi',
    `payment_run_id` BIGINT COMMENT 'Identifier for the batch payment run that generated this payment. Groups multiple payments processed together.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: ap_payment has a profit_center STRING column that stores the profit center code for payment allocation. This should be normalized to a FK reference to the profit_center master. The string profit_cente',
    `bank_name` STRING COMMENT 'Name of the financial institution holding the companys payment account.',
    `business_area` STRING COMMENT 'Business area or division code for cross-company reporting (e.g., QSR, casual dining, franchise operations).',
    `clearing_date` DATE COMMENT 'Date when the payment cleared the companys bank account and funds were debited. Null if not yet cleared.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system. Used for audit trail and compliance reporting.',
    `discount_taken_amount` DECIMAL(18,2) COMMENT 'Cash discount amount deducted from invoice total for early payment. Supports supplier relationship management and Cost of Goods Sold (COGS) optimization.',
    `document_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the payment amount (e.g., USD, CAD, EUR, GBP, MXN).. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate applied to convert document currency to local currency. Null if currencies are the same.',
    `invoice_count` STRING COMMENT 'Number of invoices cleared by this payment. A single payment may settle multiple invoices.',
    `local_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the company codes local reporting currency.. Valid values are `^[A-Z]{3}$`',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Payment amount converted to the company codes local currency for consolidation and Profit and Loss (P&L) reporting.',
    `modified_by` STRING COMMENT 'User ID of the last person who modified the payment record (e.g., status change, cancellation, reversal).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the payment record. Used for change tracking and audit compliance.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Total payment amount in document currency. Net amount remitted to vendor after discounts and adjustments.',
    `payment_block_reason` STRING COMMENT 'Reason code if payment was blocked or held for review (e.g., duplicate invoice, pricing dispute, quality issue). Null if not blocked.',
    `payment_date` DATE COMMENT 'Date the payment was issued or scheduled to be sent to the vendor. Principal business event timestamp for cash management and Days Payable Outstanding (DPO) tracking.',
    `payment_description` STRING COMMENT 'Free-text description or memo field providing additional context about the payment purpose or special handling instructions.',
    `payment_document_number` STRING COMMENT 'SAP payment document number assigned during payment run. Externally-known business identifier for this payment.. Valid values are `^[A-Z0-9]{10}$`',
    `payment_method` STRING COMMENT 'Payment instrument used to remit funds to vendor. ACH (Automated Clearing House) for domestic electronic transfers, wire for same-day transfers, check for paper-based payments, EFT for general electronic transfers, virtual card for card-based B2B payments.. Valid values are `ACH|wire_transfer|check|electronic_funds_transfer|virtual_card|international_wire`',
    `payment_priority` STRING COMMENT 'Priority level assigned to payment for processing sequence. Urgent for critical suppliers, high for preferred vendors, normal for standard terms, low for deferred payments.. Valid values are `urgent|high|normal|low`',
    `payment_processor` STRING COMMENT 'Name of third-party payment processor or banking partner used to execute the payment (e.g., JP Morgan, Bank of America, Citibank).',
    `payment_reference_number` STRING COMMENT 'Bank-assigned reference or confirmation number for the payment transaction. Used for reconciliation and dispute resolution.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment. Pending: scheduled but not yet sent. Processed: sent to bank. Cleared: funds debited from company account. Failed: rejected by bank. Cancelled: voided before processing. Reversed: reversed after clearing.. Valid values are `pending|processed|cleared|failed|cancelled|reversed`',
    `payment_terms` STRING COMMENT 'Payment terms code applied to this payment (e.g., Net 30, 2/10 Net 30). Determines discount eligibility and due date calculation.',
    `payment_type` STRING COMMENT 'Classification of payment purpose. Vendor invoice for goods/services, credit memo for returns, down payment for Capital Expenditure (CapEx) projects, advance payment for future delivery, expense reimbursement for employee-paid vendor costs.. Valid values are `vendor_invoice|credit_memo|down_payment|advance_payment|expense_reimbursement`',
    `reconciliation_status` STRING COMMENT 'Bank reconciliation status indicating whether payment has been matched to bank statement. Unreconciled: not yet matched. Reconciled: matched to bank statement. Exception: discrepancy found. Pending review: awaiting manual review.. Valid values are `unreconciled|reconciled|exception|pending_review`',
    `remittance_email` STRING COMMENT 'Vendor email address to which remittance advice is sent. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `value_date` DATE COMMENT 'Date when funds are expected to be available in the vendors account. Used for cash flow forecasting.',
    `vendor_account_number` STRING COMMENT 'Vendors bank account number or payment account identifier used for remittance.',
    `vendor_name` STRING COMMENT 'Legal name of the vendor receiving payment.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount withheld from payment per regulatory requirements. Remitted separately to tax authorities.',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Accounts payable payment run records from SAP S/4HANA FI-AP. Captures outbound payments to food suppliers, equipment vendors, landlords (CAM charges), and service providers. Stores payment method (ACH, wire, check), payment date, bank account, cleared invoice references, discount taken, payment amount in local and document currency, and payment run ID. Supports cash management, DPO (Days Payable Outstanding) tracking, and supplier relationship management.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts receivable invoice record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Link AR invoice to cost_center master to avoid duplicated code values.',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchisee when the invoice is for royalty or franchise fee billing. Null for non-franchise revenue streams.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Replace string GL account reference with FK to gl_account for consistency.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: AR invoices in SAP FI-AR are issued by a specific company code (legal entity). Adding legal_entity_id normalizes the company_code string into a proper FK to the legal_entity master, enabling multi-ent',
    `unit_id` BIGINT COMMENT 'Restaurant location associated with the invoice when billing is location-specific (e.g., royalty based on location sales). Null for corporate-level billings.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Link AR invoice to profit_center master for consistent reporting.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Manual adjustments applied to the invoice for credits, rebates, or billing corrections. Can be positive or negative.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address for invoice mailing. Includes street number and name.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address for suite, apartment, or building information. Optional field.',
    `billing_city` STRING COMMENT 'City name for the billing address. Used for invoice mailing and tax jurisdiction determination.',
    `billing_contact_name` STRING COMMENT 'Name of the primary billing contact at the customer or franchisee organization. Used for invoice delivery and payment inquiries.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166 country code for the billing address. Used for international invoicing and tax compliance.. Valid values are `^[A-Z]{3}$`',
    `billing_email` STRING COMMENT 'Email address for electronic invoice delivery and billing communications. Primary channel for invoice distribution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_period_end_date` DATE COMMENT 'End date of the period covered by this invoice. Used for royalty and franchise fee revenue recognition alignment.',
    `billing_period_start_date` DATE COMMENT 'Start date of the period covered by this invoice. Relevant for royalty invoices based on monthly or weekly sales performance.',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the billing address. Required for invoice delivery and tax jurisdiction determination.',
    `billing_state_province` STRING COMMENT 'State or province code for the billing address. Used for tax calculation and regulatory reporting.',
    `business_area` STRING COMMENT 'SAP business area for segment reporting. Enables P&L analysis by brand, region, or business unit.. Valid values are `^[A-Z0-9]{4}$`',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created the invoice record. Used for accountability and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts (e.g., USD, EUR, GBP). Supports multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the invoice. May include early payment discounts, volume discounts, or promotional adjustments.',
    `due_date` DATE COMMENT 'Date by which payment is expected based on payment terms. Used for aging analysis and dunning trigger calculations.',
    `dunning_level` STRING COMMENT 'Current dunning level for overdue invoices. Indicates escalation stage in the collection process (0=no dunning, 1=first reminder, 2=second reminder, 3=final notice, etc.).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied for foreign currency invoices to convert to company reporting currency. Null for domestic currency transactions.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before taxes, discounts, or adjustments. Represents the base billing amount for goods or services.',
    `invoice_date` DATE COMMENT 'Date the invoice was issued. Represents the business event date for revenue recognition and aging calculations.',
    `invoice_number` STRING COMMENT 'Externally-known unique invoice number assigned by SAP S/4HANA for customer billing. Used for customer communication and payment reconciliation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the collection workflow. Tracks progression from draft through payment to closure or write-off. [ENUM-REF-CANDIDATE: draft|open|partially_paid|paid|overdue|written_off|cancelled — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on revenue stream: royalty invoices to franchisees, franchise fee billings, catering and corporate account charges, gift card liability settlements, intercompany charges, or rebate billings.. Valid values are `royalty|franchise_fee|catering|gift_card_settlement|intercompany|rebate`',
    `last_dunning_date` DATE COMMENT 'Date the most recent dunning notice was sent to the customer. Used to track collection activity and determine next dunning action.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified the invoice record. Used for change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was last modified. Tracks changes for audit and data quality monitoring.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final invoice amount due after applying taxes, discounts, and adjustments. This is the amount the customer must pay.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the invoice. May include special billing instructions, dispute details, or collection notes.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining unpaid amount on the invoice. Updated as payments are received and applied. Zero when invoice is fully paid.',
    `payment_method` STRING COMMENT 'Expected or preferred payment method for this invoice. Guides payment processing and reconciliation.. Valid values are `ach|wire_transfer|check|credit_card|direct_debit|cash`',
    `payment_reference` STRING COMMENT 'Reference number or identifier provided to customer for payment remittance. Used for automated payment matching and reconciliation.',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms agreement (e.g., Net 30, Net 15, Due on Receipt). Determines due date calculation and discount eligibility.. Valid values are `^[A-Z0-9]{2,10}$`',
    `posting_date` DATE COMMENT 'Date the invoice was posted to the general ledger. May differ from invoice date due to period-end processing or batch posting.',
    `revenue_recognition_date` DATE COMMENT 'Date when revenue from this invoice is recognized for financial reporting purposes. May differ from invoice date per GAAP/IFRS revenue recognition rules.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charged on the invoice. Includes sales tax, VAT, or other applicable taxes based on jurisdiction.',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Accounts receivable invoice and payment lifecycle from SAP S/4HANA FI-AR. Covers all revenue-generating billings and their collection: royalty invoices to franchisees, catering and corporate account billings, gift card liability settlements, and intercompany charges. Invoice data stores customer/franchisee ID, invoice date, due date, payment terms, gross amount, tax, currency, dunning level, and collection status. Payment receipt data captures payment method, receipt date, bank clearing account, applied invoice references, unapplied cash amounts, and DSO (Days Sales Outstanding) impact. Supports royalty income accounting, franchise fee revenue recognition (ASC 606/IFRS 15), franchisee cash flow monitoring, and aging analysis.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`ar_payment` (
    `ar_payment_id` BIGINT COMMENT 'Unique identifier for the accounts receivable payment record. Primary key.',
    `bank_account_id` BIGINT COMMENT 'Reference to the company bank clearing account where the payment was deposited. Links to cash management and bank reconciliation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Normalize cost center reference on AR payment.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: AR payments are recorded within a specific financial period. The fiscal_period and fiscal_year integer columns are denormalized period identifiers replaced by a FK to the financial_period master for p',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Replace GL account code with FK to gl_account for authoritative data.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: AR payment receipts in SAP FI-AR are recorded within a specific company code (legal entity). Adding legal_entity_id normalizes the company_code string into a proper FK to the legal_entity master for m',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Normalize profit center reference on AR payment.',
    `ach_trace_number` STRING COMMENT 'The ACH network trace number for ACH payments. Enables tracking and reconciliation of electronic payments.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has been allocated to specific invoices. Used to track payment application progress.',
    `check_number` STRING COMMENT 'The check number for check payments. Null for electronic payment methods. Used for audit trails and bank reconciliation.',
    `clearing_date` DATE COMMENT 'The date when the payment cleared the bank and funds were confirmed available. May differ from receipt date for checks and ACH.',
    `created_by_user` STRING COMMENT 'The SAP user ID who created the payment record. Used for audit trails and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when the payment record was first created in SAP. Used for audit trails and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the payment amount (e.g., USD, EUR, GBP). Required for multi-currency operations and foreign exchange tracking.. Valid values are `^[A-Z]{3}$`',
    `discount_taken_amount` DECIMAL(18,2) COMMENT 'The early payment discount amount deducted by the customer when paying within discount terms. Reduces net cash received.',
    `dso_impact_days` STRING COMMENT 'The number of days between invoice due date and payment receipt date. Used to calculate DSO metrics and monitor collection efficiency.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert payment currency to company code functional currency. Null for domestic currency payments.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The payment amount converted to the company code functional currency using the exchange rate. Used for consolidated financial reporting.',
    `modified_by_user` STRING COMMENT 'The SAP user ID who last modified the payment record. Used for audit trails and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The system timestamp when the payment record was last modified. Used for audit trails and data synchronization.',
    `notes` STRING COMMENT 'Free-text notes or comments about the payment. Used to document special circumstances, customer communications, or application instructions.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The total gross amount of the payment received, before any deductions or allocations. Expressed in the payment currency.',
    `payment_document_number` STRING COMMENT 'The externally-known SAP payment document number assigned to this AR payment receipt. Used for reconciliation and audit trails.. Valid values are `^[A-Z0-9]{10}$`',
    `payment_method` STRING COMMENT 'The financial instrument used for payment: wire transfer, ACH (Automated Clearing House), check, credit card, debit card, or cash.. Valid values are `wire_transfer|ach|check|credit_card|debit_card|cash`',
    `payment_processor` STRING COMMENT 'The third-party payment processor or gateway used for credit card or digital payments (e.g., Stripe, PayPal, Square). Null for direct bank payments.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment: received (entered), cleared (bank confirmed), applied (allocated to invoices), partially applied, unapplied (cash on account), reversed, or voided. [ENUM-REF-CANDIDATE: received|cleared|applied|partially_applied|unapplied|reversed|voided — 7 candidates stripped; promote to reference product]',
    `payment_type` STRING COMMENT 'Classification of the payment purpose: royalty income, franchise fees, marketing fund contributions, catering invoice payments, or intercompany settlements.. Valid values are `royalty|franchise_fee|marketing_fund|catering_invoice|intercompany_settlement|other`',
    `posting_date` DATE COMMENT 'The accounting period date when the payment was posted to the general ledger. Determines which fiscal period recognizes the cash receipt.',
    `receipt_date` DATE COMMENT 'The business date when the payment was received and recorded in the AR system. Used for Days Sales Outstanding (DSO) calculation and revenue recognition.',
    `reference_number` STRING COMMENT 'Customer-provided reference number or remittance advice identifier. Used to match payments to invoices during application.',
    `reversal_date` DATE COMMENT 'The date when the payment was reversed. Null for non-reversed payments. Used for audit trails and financial period corrections.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this payment has been reversed. True if reversed, False if active. Reversed payments remain in history for audit trails.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for payment reversal (e.g., NSF - non-sufficient funds, duplicate entry, customer dispute, bank error). Null for non-reversed payments. [ENUM-REF-CANDIDATE: NSF|duplicate|dispute|bank_error|wrong_account|fraud|other — promote to reference product]',
    `transaction_reference` STRING COMMENT 'The payment processor transaction identifier for card or digital wallet payments. Used for chargeback management and reconciliation.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that remains unallocated to invoices. Represents cash on account or overpayments requiring future application.',
    `wire_confirmation_number` STRING COMMENT 'Bank-provided confirmation or trace number for wire transfer payments. Used for payment verification and dispute resolution.',
    CONSTRAINT pk_ar_payment PRIMARY KEY(`ar_payment_id`)
) COMMENT 'Accounts receivable payment receipt records from SAP S/4HANA FI-AR. Captures inbound payments from franchisees (royalties, franchise fees, marketing fund contributions), corporate catering clients, and intercompany settlements. Stores payment method, receipt date, bank clearing account, applied invoice references, unapplied cash amounts, and DSO (Days Sales Outstanding) impact. Critical for royalty income reconciliation and franchise cash flow monitoring.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key sourced from SAP S/4HANA FI-AA asset master.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fixed assets in SAP FI-AA are assigned to cost centers for depreciation allocation and cost reporting. The cost_center_code STRING column is denormalized and should be replaced by a FK to the cost_cen',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Fixed assets in SAP FI-AA are posted to specific GL accounts (asset balance sheet accounts, accumulated depreciation accounts). The gl_account_code STRING column is denormalized and should be replaced',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or manager responsible for the custody and maintenance of the asset. Supports accountability and asset stewardship.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since acquisition. Contra-asset account that reduces the gross book value to net book value.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total capitalized cost of the fixed asset at acquisition including purchase price, installation, freight, and other directly attributable costs. Recorded in USD.',
    `acquisition_date` DATE COMMENT 'Date when the fixed asset was acquired or placed into service. Used as the start date for depreciation calculations and useful life tracking.',
    `asset_class` STRING COMMENT 'Classification category of the fixed asset used for grouping and reporting. Determines depreciation rules and capitalization thresholds per GAAP/IFRS standards.. Valid values are `kitchen_equipment|pos_hardware|leasehold_improvements|furniture_fixtures|vehicles|it_infrastructure`',
    `asset_description` STRING COMMENT 'Detailed business description of the fixed asset including make, model, and specifications (e.g., Vulcan 6-Burner Gas Range Model XYZ123).',
    `asset_number` STRING COMMENT 'Externally-known unique asset tag or serial number assigned to the fixed asset for tracking and identification purposes. Used for physical asset verification and audit trails.. Valid values are `^[A-Z0-9]{8,12}$`',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset. Determines whether depreciation is active and whether the asset appears on the balance sheet. [ENUM-REF-CANDIDATE: active|in_service|under_construction|retired|disposed|impaired|held_for_sale — 7 candidates stripped; promote to reference product]',
    `asset_subclass` STRING COMMENT 'Detailed sub-classification within the asset class for granular tracking (e.g., Fryers, Grills, KDS Units under kitchen_equipment).',
    `capex_project_code` STRING COMMENT 'Reference code linking the asset to the originating capital expenditure project or budget line item. Supports CapEx tracking and ROI analysis.. Valid values are `^[A-Z]{3}-[0-9]{6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset record was first created in the SAP S/4HANA system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost and book value (e.g., USD, EUR, GBP). Supports multi-currency consolidation for international operations.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate periodic depreciation expense. Straight-line is most common for restaurant equipment; declining balance may be used for vehicles.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits`',
    `disposal_date` DATE COMMENT 'Date when the asset was retired, sold, or otherwise disposed of. Triggers final depreciation calculation and removal from active asset register.',
    `disposal_method` STRING COMMENT 'Method by which the asset was disposed of. Determines accounting treatment and tax implications for gain/loss recognition.. Valid values are `sold|scrapped|donated|traded_in|transferred`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Cash or fair value received from the sale or disposal of the asset. Used to calculate gain or loss on disposal for P&L reporting.',
    `impairment_indicator` BOOLEAN COMMENT 'Flag indicating whether the asset has been tested for impairment and found to have a carrying value exceeding its recoverable amount per GAAP/IFRS standards.',
    `impairment_loss` DECIMAL(18,2) COMMENT 'Amount of impairment loss recognized when the assets carrying value exceeds its fair value or value in use. Recorded as a non-cash charge to P&L.',
    `insurance_policy_number` STRING COMMENT 'Policy number for property and casualty insurance covering the asset. Used for claims processing and risk management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset record was last updated in the SAP S/4HANA system. Supports change tracking and audit compliance.',
    `last_physical_inventory_date` DATE COMMENT 'Date of the most recent physical verification or audit of the asset. Supports SOX compliance and internal control over fixed assets.',
    `lease_indicator` BOOLEAN COMMENT 'Flag indicating whether the asset is subject to a lease agreement (finance lease or operating lease under ASC 842 / IFRS 16). Determines right-of-use asset treatment.',
    `manufacturer_name` STRING COMMENT 'Name of the equipment manufacturer or brand (e.g., Vulcan, Hobart, NCR). Supports vendor performance analysis and standardization initiatives.',
    `model_number` STRING COMMENT 'Manufacturer model number or SKU for the asset. Used for parts ordering, service manuals, and replacement planning.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the asset calculated as acquisition cost minus accumulated depreciation. Represents the asset value on the balance sheet.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special handling instructions, or historical context about the asset (e.g., Replaced due to fire damage 2022-03-15).',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the asset acquisition. Provides audit trail to procurement documentation and invoice matching.. Valid values are `^PO-[0-9]{8,10}$`',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. Subtracted from acquisition cost to determine depreciable base.',
    `serial_number` STRING COMMENT 'Manufacturer serial number for the asset. Used for warranty claims, service tracking, and theft recovery.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Expected useful life of the asset in years as determined by GAAP/IFRS guidelines and company policy. Used to calculate annual depreciation expense.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or vendor warranty expires. Used to plan for extended service contracts and budget for repairs and maintenance (R&M).',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master record, depreciation lifecycle, and impairment tracking from SAP S/4HANA FI-AA. Tracks all capitalized assets across company-owned restaurants and corporate facilities: kitchen equipment (fryers, grills, KDS units), POS hardware, leasehold improvements, furniture and fixtures, vehicles, and IT infrastructure. Master data stores asset class, acquisition date, acquisition cost, useful life, depreciation method, salvage value, and CapEx project reference. Depreciation detail captures periodic planned/posted depreciation by fiscal period, depreciation area (book, tax, IFRS), depreciation amount, accumulated depreciation, net book value, and depreciation key. Supports CapEx vs. OpEx classification, EBITDA calculation (adding back D&A), tax depreciation schedules, impairment testing, and asset disposal/retirement processing for restaurant closures and remodels.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: budget has brand_code as a plain denormalized column. Brand-level budgeting is a core process in multi-brand foodservice — annual budgets are set by brand for marketing, capex, and operations. brand_c',
    `unit_id` BIGINT COMMENT 'Identifier of the specific restaurant location to which this budget line applies. Null for corporate or regional-level budgets.',
    `budget_unit_id` BIGINT COMMENT 'Identifier of the specific restaurant location to which this budget line applies. Null for corporate or regional-level budgets.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budgets in SAP CO are allocated to specific cost centers. The cost_center_code STRING column is denormalized and should be replaced by a FK to the cost_center master, enabling proper budget-vs-actual ',
    `employee_id` BIGINT COMMENT 'Name or identifier of the individual or department responsible for managing and monitoring this budget line.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Budgets are planned for specific financial periods. The fiscal_period and fiscal_year integer columns are denormalized period identifiers replaced by a FK to the financial_period master, enabling peri',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Budgets are planned against specific GL accounts (revenue, expense, CapEx accounts). The gl_account_code STRING column is denormalized and should be replaced by a FK to the gl_account master, enabling',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budgets are allocated to profit centers for P&L planning. The profit_center_code STRING column is denormalized and should be replaced by a FK to the profit_center master, enabling proper budget-vs-act',
    `amount` DECIMAL(18,2) COMMENT 'The budgeted monetary amount for the specified GL account, cost center, and fiscal period. Expressed in the reporting currency.',
    `approval_date` DATE COMMENT 'The date on which the budget record was formally approved by the approving authority.',
    `approving_authority` STRING COMMENT 'Name or identifier of the individual or committee that approved this budget line (e.g., CFO, Budget Committee, Regional Director).',
    `baseline_amount` DECIMAL(18,2) COMMENT 'The baseline or prior-year budget amount used as a reference point for variance analysis and year-over-year comparisons.',
    `budget_category` STRING COMMENT 'High-level categorization of the budget line for reporting and analysis purposes (e.g., Store Operations, Corporate Overhead, Franchise Support, New Restaurant Opening).',
    `budget_status` STRING COMMENT 'Current approval and lifecycle status of the budget record. Draft indicates work in progress, Submitted indicates pending approval, Approved indicates finalized, Rejected indicates not approved, Locked indicates no further changes allowed.. Valid values are `draft|submitted|approved|rejected|locked`',
    `budget_type` STRING COMMENT 'Classification of the budget line by expense or revenue category. OpEx (Operating Expenditure), CapEx (Capital Expenditure), Labor, Food Cost, Revenue, COGS (Cost of Goods Sold), Marketing, R&M (Repairs and Maintenance). [ENUM-REF-CANDIDATE: opex|capex|labor|food_cost|revenue|cogs|marketing|rm — 8 candidates stripped; promote to reference product]',
    `consolidation_entity` STRING COMMENT 'Legal entity or consolidation unit for multi-entity financial consolidation and GAAP/IFRS reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the budget amount is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this budget record ceases to be effective. Null for open-ended budgets.',
    `effective_start_date` DATE COMMENT 'The date from which this budget record becomes effective and applicable for financial planning and reporting.',
    `modified_by` STRING COMMENT 'User ID or name of the individual who last modified this budget record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional context, assumptions, or explanations related to this budget line item.',
    `nro_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this budget line is associated with a New Restaurant Opening (NRO) project. True if NRO-related, False otherwise.',
    `nro_project_code` STRING COMMENT 'Unique project code for the New Restaurant Opening initiative if this budget line is NRO-related. Null for non-NRO budgets.',
    `ownership_type` STRING COMMENT 'Indicates whether the budget applies to a company-owned location, a franchise location, or a joint venture.. Valid values are `company_owned|franchise|joint_venture`',
    `region_code` STRING COMMENT 'Geographic region code for regional budget aggregation and reporting (e.g., Northeast, Southwest, EMEA, APAC).',
    `subcategory` STRING COMMENT 'Detailed subcategory within the budget category for granular expense or revenue classification (e.g., Utilities, Rent, Advertising, Training).',
    `variance_threshold_pct` DECIMAL(18,2) COMMENT 'The acceptable variance threshold percentage for budget-to-actual reporting. Variances exceeding this threshold trigger alerts or reviews.',
    `version_code` STRING COMMENT 'Version of the budget record indicating whether it is the original budget, a revised budget, a forecast, a reforecast, or the final approved budget.. Valid values are `original|revised|forecast|reforecast|final`',
    `created_by` STRING COMMENT 'User ID or name of the individual who created this budget record.',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Annual and rolling financial budget and forecast records from SAP S/4HANA CO, encompassing plan header and granular line-level allocations with cash forecasting integration. Stores budget version (original, revised, rolling forecast), fiscal year, approval status, and approving authority. Line-level detail specifies GL account, cost center or profit center, fiscal period, budget category (food cost, labor, occupancy, marketing, R&M, CapEx), planned amount, and currency. Supports monthly phasing of annual budgets, variance analysis (actual vs. budget), NRO CapEx budgeting, daypart-level labor budgeting, food cost (COGS%) targets by restaurant unit, cash flow forecasting by period, and liquidity planning for treasury operations.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique identifier for the budget line item. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: budget_line has brand_code as a plain denormalized column. Budget line items are allocated by brand for brand-level P&L planning and variance analysis. brand_code is a denormalized representation of r',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Needed to trace individual budget line items to the specific campaign they support for detailed spend tracking and performance measurement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget lines specify granular cost center allocations. The cost_center STRING column is denormalized and should be replaced by a FK to the cost_center master, enabling proper budget line-level cost ce',
    `employee_id` BIGINT COMMENT 'Username or identifier of the person who approved this budget line. Null if not yet approved.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Budget lines are allocated to specific financial periods. The fiscal_period and fiscal_year integer columns are denormalized period identifiers replaced by a FK to the financial_period master, enablin',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Budget lines specify allocations against specific GL accounts. The gl_account_code STRING column is denormalized and should be replaced by a FK to the gl_account master, enabling proper budget line-le',
    `budget_id` BIGINT COMMENT 'Reference to the parent budget plan that contains this line item.',
    `unit_id` BIGINT COMMENT 'Reference to the specific restaurant location if this budget line is allocated at the unit level. Null for corporate or regional budget lines.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budget lines specify granular profit center allocations. The profit_center STRING column is denormalized and should be replaced by a FK to the profit_center master, enabling proper budget line-level P',
    `allocation_driver` STRING COMMENT 'Business metric or driver used as the basis for allocation (e.g., revenue, transaction count, square footage, headcount). Null if allocation_method is direct.',
    `allocation_method` STRING COMMENT 'Method used to allocate or calculate this budget line (e.g., direct assignment, proportional allocation based on revenue, driver-based using transaction volume, zero-based budgeting, incremental from prior year).. Valid values are `direct|proportional|driver_based|zero_based|incremental`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line was approved. Null if not yet approved.',
    `baseline_amount` DECIMAL(18,2) COMMENT 'Prior year or baseline amount used as the starting point for this budget line. Supports variance analysis and incremental budgeting.',
    `budget_category` STRING COMMENT 'High-level classification of the budget line by expense or revenue type. Aligns with P&L statement structure and industry-standard categories (COGS, labor, occupancy, etc.). [ENUM-REF-CANDIDATE: food_cost|beverage_cost|labor|occupancy|marketing|utilities|repairs_maintenance|supplies|franchise_fees|other_operating|capex|opex — 12 candidates stripped; promote to reference product]',
    `budget_percentage_target` DECIMAL(18,2) COMMENT 'Target percentage of revenue or total budget that this line represents (e.g., COGS% target of 30.00, Labor% target of 25.00). Used for ratio-based budgeting and variance analysis.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget line within the approval and execution workflow.. Valid values are `draft|submitted|approved|active|closed|cancelled`',
    `budget_subcategory` STRING COMMENT 'Detailed subcategory within the budget category for granular tracking (e.g., within labor: FOH labor, BOH labor, management labor; within food cost: protein, produce, dairy).',
    `budget_version` STRING COMMENT 'Version or type of budget this line represents (original annual budget, mid-year revision, rolling forecast, or actual results for comparison).. Valid values are `original|revised|forecast|actual`',
    `company_code` STRING COMMENT 'Four-character SAP company code representing the legal entity or operating unit to which this budget line applies.. Valid values are `^[A-Z0-9]{4}$`',
    `created_by_user` STRING COMMENT 'Username or identifier of the person who created this budget line record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the planned amount (e.g., USD, EUR, GBP). Supports multi-currency budgeting for international operations.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Service period or daypart for which this budget line applies. Supports daypart-level labor budgeting and revenue planning. Null if not daypart-specific.. Valid values are `breakfast|lunch|dinner|late_night|all_day`',
    `effective_end_date` DATE COMMENT 'Date when this budget line expires or is superseded. Null for open-ended budget lines.',
    `effective_start_date` DATE COMMENT 'Date when this budget line becomes effective and active for financial planning and control.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the person who last modified this budget line record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, assumptions, or justification for this budget line.',
    `planned_amount` DECIMAL(18,2) COMMENT 'Budgeted monetary amount for this line item in the specified currency. Represents the target spend or revenue for the fiscal period.',
    `quantity_target` DECIMAL(18,2) COMMENT 'Budgeted quantity or volume for non-monetary metrics (e.g., labor hours, transaction count, covers, units sold). Null for purely monetary budget lines.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity target (e.g., hours, transactions, covers, cases, pounds). Null if quantity_target is not applicable.',
    `variance_threshold_amount` DECIMAL(18,2) COMMENT 'Absolute monetary variance threshold that triggers alerts or requires management review. Null if no threshold is set.',
    `variance_threshold_percentage` DECIMAL(18,2) COMMENT 'Percentage variance threshold that triggers alerts or requires management review. Null if no threshold is set.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Granular line-level budget allocations within a budget plan. Each line specifies the GL account, cost center or profit center, fiscal period, budget category (food cost, labor, occupancy, marketing, R&M), planned amount, and currency. Supports monthly phasing of annual budgets, daypart-level labor budgeting, and food cost (COGS%) targets by restaurant unit.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the bank account record. Primary key. Role: MASTER_RESOURCE.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Bank accounts in SAP FI are reconciled against specific GL accounts (cash/bank GL accounts). The gl_account_code STRING column is denormalized and should be replaced by a FK to the gl_account master, ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Bank accounts are owned by a legal entity; replace company_code string with FK to legal_entity for proper hierarchy.',
    `account_holder_name` STRING COMMENT 'Legal name of the account holder as registered with the bank. Typically matches the legal entity name but may differ for special-purpose accounts.',
    `account_name` STRING COMMENT 'The legal name or title of the bank account as registered with the financial institution.',
    `account_number` STRING COMMENT 'The bank account number. Stored in masked or encrypted format for PCI DSS compliance. Restricted access required.',
    `account_status` STRING COMMENT 'Current lifecycle status of the bank account. Active accounts are available for transactions; inactive accounts are dormant but not closed; closed accounts are permanently terminated; frozen accounts are temporarily blocked; pending activation accounts are awaiting setup completion.. Valid values are `active|inactive|closed|frozen|pending_activation`',
    `account_type` STRING COMMENT 'Classification of the bank account by its primary business purpose: operating (daily transactions), payroll (employee payments), concentration (cash pooling), zero-balance (subsidiary sweep), escrow (restricted funds), reserve (regulatory or contractual hold).. Valid values are `operating|payroll|concentration|zero_balance|escrow|reserve`',
    `bank_key` STRING COMMENT 'Country-specific bank identifier. In the US this is the ABA routing number; in other countries it may be a sort code, bank code, or clearing number.',
    `bank_name` STRING COMMENT 'The legal name of the financial institution holding the account.',
    `bank_statement_delivery_method` STRING COMMENT 'How bank statements are delivered: electronic (email or portal), paper (postal mail), or both.. Valid values are `electronic|paper|both`',
    `branch_address` STRING COMMENT 'Full street address of the bank branch. Classified as confidential organizational contact data.',
    `branch_name` STRING COMMENT 'Name of the specific bank branch where the account is held, if applicable.',
    `cash_pool_group` STRING COMMENT 'Identifier for the cash pooling or notional pooling group this account belongs to. Used for multi-entity liquidity management and interest optimization.',
    `closing_date` DATE COMMENT 'The date the bank account was closed or terminated. Null for active accounts.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166 country code where the bank account is domiciled (e.g., USA, CAN, MEX, GBR).. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this bank account record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the account (e.g., USD, EUR, GBP, CAD, MXN). Defines the denomination of balances and transactions.. Valid values are `^[A-Z]{3}$`',
    `dual_signature_required_flag` BOOLEAN COMMENT 'Indicates whether two authorized signatories are required for transactions above a certain threshold. True if dual control is mandated; false otherwise.',
    `dual_signature_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which dual signature is required. Null if dual signature is not applicable or always required.',
    `electronic_banking_code` STRING COMMENT 'Identifier or login ID for online banking or electronic funds transfer systems. Confidential to prevent unauthorized access.',
    `iban` STRING COMMENT 'International Bank Account Number for accounts in IBAN-participating countries. Up to 34 alphanumeric characters. Restricted due to account identification sensitivity.',
    `interest_rate_percent` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the account balance, expressed as a percentage. May be positive for interest-bearing accounts or negative for fee-based accounts.',
    `last_reconciliation_date` DATE COMMENT 'The date of the most recent successful bank reconciliation for this account.',
    `minimum_balance_amount` DECIMAL(18,2) COMMENT 'Minimum balance required to avoid fees or maintain account status. Null if no minimum is required.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this bank account record in the system.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank account record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or comments about the bank account (e.g., usage restrictions, special terms, historical context).',
    `opening_date` DATE COMMENT 'The date the bank account was opened with the financial institution.',
    `overdraft_facility_flag` BOOLEAN COMMENT 'Indicates whether the account has an overdraft or line of credit facility. True if overdraft is available; false otherwise.',
    `overdraft_limit_amount` DECIMAL(18,2) COMMENT 'Maximum overdraft or credit line available on this account. Null if no overdraft facility exists.',
    `payment_method_supported` STRING COMMENT 'Comma-separated list of payment methods supported by this account (e.g., ACH, wire, check, EFT, SEPA). [ENUM-REF-CANDIDATE: ACH|wire|check|EFT|SEPA|BACS|CHAPS|RTP — promote to reference product]',
    `primary_contact_email` STRING COMMENT 'Email address of the primary bank contact. Classified as confidential organizational contact data.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary relationship manager or contact person at the bank for this account.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary bank contact. Classified as confidential organizational contact data.',
    `reconciliation_frequency` STRING COMMENT 'How often this bank account is reconciled against the general ledger: daily (high-volume operating accounts), weekly (moderate activity), monthly (low activity or reserve accounts).. Valid values are `daily|weekly|monthly`',
    `signatory_list` STRING COMMENT 'Comma-separated list of employee IDs or names authorized to sign checks or approve wire transfers on this account. Confidential for fraud prevention.',
    `swift_code` STRING COMMENT 'Bank Identifier Code (BIC) or SWIFT code for international wire transfers. 8 or 11 character alphanumeric code identifying the bank and branch.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Corporate bank account master record and daily transactional statement activity from SAP S/4HANA FI-TR (Treasury). Master data defines all operating, payroll, concentration, and zero-balance accounts across legal entities and geographies — storing bank name, account number (masked), IBAN/routing, account type, currency, cash pool group, signatory list, and reconciliation GL account. Statement lines capture daily electronic bank statement imports including value date, posting date, transaction type (credit/debit), amount, bank reference, counterparty name, clearing status, and matched GL posting. Supports daily automated bank reconciliation, real-time cash position reporting, fraud detection for restaurant cash deposits, POS settlement flow matching, and treasury cash pooling across entities.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`financial_period` (
    `financial_period_id` BIGINT COMMENT 'Unique identifier for the financial period record. Primary key.',
    `comparative_prior_period_id` BIGINT COMMENT 'Foreign key reference to the immediately preceding period (e.g., prior month). Used for sequential period-over-period analysis.',
    `comparative_prior_year_period_id` BIGINT COMMENT 'Foreign key reference to the equivalent period in the prior fiscal year. Used for year-over-year comparative analysis and SSS reporting.',
    `prior_financial_period_id` BIGINT COMMENT 'Self-referencing FK on financial_period (prior_financial_period_id)',
    `accounting_principle` STRING COMMENT 'Accounting standard applied in this ledger: US_GAAP (United States Generally Accepted Accounting Principles), IFRS (International Financial Reporting Standards), local_GAAP (country-specific standards), management (internal reporting).. Valid values are `US_GAAP|IFRS|local_GAAP|management`',
    `adjustment_posting_allowed_flag` BOOLEAN COMMENT 'Indicates whether adjustment postings (corrections, reclassifications) are allowed in this period after initial close. Used for controlled reopening during audit or correction cycles.',
    `adjustment_reason` STRING COMMENT 'Reason code or description for why the period is an adjustment period.',
    `audit_required_flag` BOOLEAN COMMENT 'Indicates whether this period is subject to external audit review. Typically true for year-end periods and quarterly periods for publicly traded entities.',
    `audit_trail_flag` BOOLEAN COMMENT 'True if changes to this period are tracked for audit purposes.',
    `calendar_days_count` STRING COMMENT 'Total number of calendar days in the period. Used for daily average calculations and period normalization in financial analysis.',
    `calendar_month` STRING COMMENT 'Month number (1‑12) in the calendar year.',
    `calendar_quarter` STRING COMMENT 'Quarter number (1‑4) in the calendar year.',
    `calendar_year` STRING COMMENT 'Gregorian calendar year of the period.',
    `close_actual_date` DATE COMMENT 'Actual date when the period-end close process was completed and the period status changed to closed. Null if period is still open.',
    `close_scheduled_date` DATE COMMENT 'Target date for completing the period-end close process. Used for close calendar planning and tracking adherence to financial reporting deadlines.',
    `close_variance_days` STRING COMMENT 'Number of days between scheduled and actual close date (positive if late, negative if early). Used to track period-end close efficiency and identify process improvement opportunities.',
    `company_code` STRING COMMENT 'Four-character alphanumeric code identifying the legal entity in SAP S/4HANA. Links this period to a specific company within the multi-entity structure.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_group_code` STRING COMMENT 'Code identifying the consolidation group for multi‑entity reporting.',
    `consolidation_required_flag` BOOLEAN COMMENT 'Indicates whether this period requires multi-entity consolidation processing. True for periods where intercompany eliminations and group reporting are performed.',
    `created_by_user` STRING COMMENT 'User ID or username of the person who created this financial period record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this financial period record was first created in the system. Used for audit trail and data lineage tracking.',
    `day_count` STRING COMMENT 'Total count of calendar days covered by the period.',
    `effective_end_date` DATE COMMENT 'Date when the period ceases to be effective (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the period becomes effective for reporting purposes.',
    `end_date` DATE COMMENT 'Last calendar day of the financial period.',
    `exchange_rate_to_reporting` DECIMAL(18,2) COMMENT 'Conversion rate from functional currency to reporting currency for the period.',
    `exchange_rate_type` STRING COMMENT 'Type of exchange rate applied for currency translation in this period: average (period average rate for P&L), closing (period-end rate for balance sheet), budget (planning rate), historical (acquisition date rate for fixed assets).. Valid values are `average|closing|budget|historical`',
    `financial_period_description` STRING COMMENT 'Optional free‑text description of the period.',
    `financial_statement_type` STRING COMMENT 'Type of financial statement the period primarily supports.. Valid values are `balance_sheet|income_statement|cash_flow|equity`',
    `fiscal_month` STRING COMMENT 'Month number (1‑12) within the fiscal year.',
    `fiscal_period_code` STRING COMMENT 'Standard code used by SAP for the fiscal period (e.g., "2023P01").',
    `fiscal_quarter` STRING COMMENT 'Quarter number (1‑4) within the fiscal year.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year to which this period belongs. May differ from calendar year depending on fiscal year variant configuration.',
    `fiscal_year_variant` STRING COMMENT 'Two-character code defining the fiscal calendar structure (number of periods, special periods, year-end rules) used by the company code. Determines how the fiscal year is divided into posting periods.. Valid values are `^[A-Z0-9]{2}$`',
    `holiday_indicator` STRING COMMENT 'Degree to which holidays affect the period.. Valid values are `none|partial|full`',
    `is_adjustment_period` BOOLEAN COMMENT 'True if the period is used for post‑close adjustments.',
    `is_current` BOOLEAN COMMENT 'True if this period is the active reporting period.',
    `is_estimated` BOOLEAN COMMENT 'True if the period values are based on estimates rather than actuals.',
    `is_holiday_period` BOOLEAN COMMENT 'True if the period includes a recognized holiday schedule.',
    `is_interim` BOOLEAN COMMENT 'True if the period is an interim (non‑full) reporting period.',
    `ledger_type` STRING COMMENT 'Classification of the ledger: leading (primary GAAP ledger for statutory reporting), non_leading (parallel IFRS or local GAAP ledger), special_purpose (management or segment reporting ledger).. Valid values are `leading|non_leading|special_purpose`',
    `lock_flag` BOOLEAN COMMENT 'True when the period is locked for posting to prevent changes.',
    `modified_by_user` STRING COMMENT 'User ID or username of the person who last modified this financial period record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this financial period record was last modified. Updated whenever period status, close dates, or other attributes change.',
    `notes` STRING COMMENT 'Free-text field for recording period-specific notes, exceptions, or special circumstances (e.g., Includes acquisition of XYZ brand, Impacted by COVID-19 closures, Leap year adjustment).',
    `period_category` STRING COMMENT 'Business classification of the period data.. Valid values are `actual|budget|forecast|plan`',
    `period_end_date` DATE COMMENT 'Last calendar date of the financial period. Defines the end of the posting window for transactions assigned to this period.',
    `period_key` STRING COMMENT 'Compact code representing the period (e.g., FY2023Q1, FY2023M04).',
    `period_name` STRING COMMENT 'Human-readable name or label for the period (e.g., January 2024, Q1 FY2024, Period 13 - Year-End Adjustments). Used for reporting and user interface display.',
    `period_number` STRING COMMENT 'Sequential period number within the fiscal year (typically 1-12 for monthly periods, or 1-13 for 4-4-5 retail calendars). Special periods (13, 14, 15, 16) used for year-end adjustments.',
    `period_sequence_number` STRING COMMENT 'Sequential order of the period within its fiscal year.',
    `period_start_date` DATE COMMENT 'First calendar date of the financial period. Defines the beginning of the posting window for transactions assigned to this period.',
    `period_status` STRING COMMENT 'Current posting status of the period: not_opened (future period, no posting allowed), open (active posting allowed), closed (period-end close completed, limited posting), locked (archived, no posting allowed).. Valid values are `not_opened|open|closed|locked`',
    `period_type` STRING COMMENT 'Classification of the period: regular (standard posting period), special (year-end adjustment period 13-16), or adjustment (mid-year correction period).. Valid values are `regular|special|adjustment`',
    `posting_allowed_flag` BOOLEAN COMMENT 'Indicates whether new transactions can be posted to this period. True if period is open for posting, false if closed or locked.',
    `quarter_number` STRING COMMENT 'Fiscal quarter number (1-4) to which this period belongs. Supports quarterly financial reporting and Same-Store Sales (SSS) analysis.',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for consolidated financial reporting in this period (e.g., USD for US Dollar, EUR for Euro). Used for multi-currency consolidation.. Valid values are `^[A-Z]{3}$`',
    `segment_reporting_flag` BOOLEAN COMMENT 'True if the period is used for segment‑level reporting.',
    `source_system` STRING COMMENT 'Originating system that defines the period (e.g., SAP S/4HANA).',
    `sss_eligible_flag` BOOLEAN COMMENT 'Indicates whether this period is eligible for Same-Store Sales (SSS) or Comparable Store Sales (Comp Sales) analysis. Typically true for periods where stores have been open for at least 12-13 months.',
    `start_date` DATE COMMENT 'First calendar day of the financial period.',
    `tax_reporting_flag` BOOLEAN COMMENT 'True if the period is used for tax reporting calculations.',
    `tax_reporting_period_flag` BOOLEAN COMMENT 'Indicates whether this period is a tax reporting period requiring submission of tax returns (e.g., quarterly estimated tax, annual tax filing). Used for tax compliance tracking.',
    `working_days_count` STRING COMMENT 'Number of business working days in the period, excluding weekends and holidays. Used for normalizing operational metrics and labor cost analysis.',
    `year_period_key` STRING COMMENT 'Concatenated key combining fiscal year and period number (format: YYYYPPP, e.g., 2024001 for FY2024 Period 1). Used for sorting and comparative period analysis.. Valid values are `^[0-9]{4}[0-9]{3}$`',
    CONSTRAINT pk_financial_period PRIMARY KEY(`financial_period_id`)
) COMMENT 'Master reference table for financial_period. ';

CREATE OR REPLACE TABLE `restaurants_ecm`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key for payment_run',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who triggered the payment run.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Payment runs in SAP FI-AP are executed within a specific financial period. The fiscal_period (STRING) and fiscal_year (INT) columns are denormalized period identifiers replaced by a FK to the financia',
    `reversed_payment_run_id` BIGINT COMMENT 'Self-referencing FK on payment_run (reversed_payment_run_id)',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run finished processing.',
    `approval_status` STRING COMMENT 'Current approval state of the payment run.',
    `approved_by` BIGINT COMMENT 'Identifier of the employee who approved the payment run.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run was approved.',
    `batch_reference` STRING COMMENT 'External reference or identifier for the batch used by downstream systems.',
    `cost_center_code` STRING COMMENT 'Internal cost center associated with the payment run for accounting allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the payment run amounts.',
    `error_count` BIGINT COMMENT 'Number of errors encountered during processing of the run.',
    `external_reference_code` STRING COMMENT 'Identifier used by external systems (e.g., banking partner) to reference the run.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the payment run was generated automatically by the system.',
    `notes` STRING COMMENT 'Additional free‑form notes captured for the payment run.',
    `payment_channel` STRING COMMENT 'Technical channel through which the payment run was processed.',
    `payment_method` STRING COMMENT 'Instrument used to execute the payments.',
    `payment_run_description` STRING COMMENT 'Free‑form text describing the purpose or context of the payment run.',
    `payment_run_status` STRING COMMENT 'Current lifecycle status of the payment run.',
    `payment_run_type` STRING COMMENT 'Classification of the run based on its business purpose.',
    `processing_time_seconds` STRING COMMENT 'Total elapsed time in seconds for the run to complete.',
    `region_code` STRING COMMENT 'Geographic region identifier for the payment run (e.g., NA, EU, APAC).',
    `retry_flag` BOOLEAN COMMENT 'True if the run is a retry of a previously failed run.',
    `run_number` STRING COMMENT 'Business-visible sequential number assigned to the payment run.',
    `run_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run was initiated in the business process.',
    `scheduled_date` DATE COMMENT 'Planned calendar date for the payment run execution.',
    `settlement_date` DATE COMMENT 'Date on which the payments are settled with banks or vendors.',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Total discounts deducted from the gross amount.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Sum of all payment amounts before taxes, discounts, and fees.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Net amount payable after taxes and discounts.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Aggregate tax amount applied to the payment run.',
    `transaction_count` BIGINT COMMENT 'Count of individual payment transactions included in the run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment run record.',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Master reference table for payment_run. Referenced by payment_run_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_parent_account_gl_account_id` FOREIGN KEY (`parent_account_gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_entity_legal_entity_id` FOREIGN KEY (`parent_entity_legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_primary_ultimate_parent_entity_legal_entity_id` FOREIGN KEY (`primary_ultimate_parent_entity_legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `restaurants_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `restaurants_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `restaurants_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `restaurants_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `restaurants_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `restaurants_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ADD CONSTRAINT `fk_finance_financial_period_comparative_prior_period_id` FOREIGN KEY (`comparative_prior_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ADD CONSTRAINT `fk_finance_financial_period_comparative_prior_year_period_id` FOREIGN KEY (`comparative_prior_year_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ADD CONSTRAINT `fk_finance_financial_period_prior_financial_period_id` FOREIGN KEY (`prior_financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_reversed_payment_run_id` FOREIGN KEY (`reversed_payment_run_id`) REFERENCES `restaurants_ecm`.`finance`.`payment_run`(`payment_run_id`);

-- ========= TAGS =========
ALTER SCHEMA `restaurants_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `restaurants_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `parent_account_gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent General Ledger (GL) Account ID');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `account_currency` SET TAGS ('dbx_business_glossary_term' = 'Account Currency');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `account_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `account_description` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Description');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|blocked|closed|pending_activation');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `alternate_account_number` SET TAGS ('dbx_business_glossary_term' = 'Alternate Account Number');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `alternate_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `alternate_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Classification');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_value_regex' = 'current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Statement Classification');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_value_regex' = 'operating|investing|financing|not_applicable');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Number');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|not_applicable');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `field_status_group` SET TAGS ('dbx_business_glossary_term' = 'Field Status Group');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `financial_statement_category` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Category');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `gaap_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Account Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `ifrs_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Account Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `line_item_display_indicator` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `open_item_management_indicator` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `planning_level` SET TAGS ('dbx_business_glossary_term' = 'Planning Level');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `posting_allowed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Posting Allowed Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `profit_loss_classification` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Classification');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `segment_reporting_indicator` SET TAGS ('dbx_business_glossary_term' = 'Segment Reporting Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Sort Key');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `statistical_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Statistical Account Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `restaurants_ecm`.`finance`.`gl_account` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `capex_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Eligible Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `cogs_percent_target` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold Percent (COGS%) Target');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `cogs_percent_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'revenue_generating|support|administrative|overhead|capital_project');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|suspended|planned');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'restaurant_unit|regional_office|corporate_department|shared_service_center|distribution_center|franchise_support');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `drive_thru_lanes` SET TAGS ('dbx_business_glossary_term' = 'Drive-Thru (DT) Lanes');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `format_code` SET TAGS ('dbx_business_glossary_term' = 'Format Code');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `format_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `franchise_flag` SET TAGS ('dbx_business_glossary_term' = 'Franchise Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `labor_percent_target` SET TAGS ('dbx_business_glossary_term' = 'Labor Percent (Labor%) Target');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `labor_percent_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Notes');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `opex_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OpEx) Allocation Method');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `opex_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|allocated_revenue|allocated_headcount|allocated_sqft|allocated_transactions|fixed_percentage');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center Code');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (ID)');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center Identifier (ID)');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `aov_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV) Target Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `consolidation_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Unit Code');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO) Code');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_group_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group Code');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `ebitda_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Target Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `marketing_fund_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund Rate Percentage');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Notes');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `ownership_model` SET TAGS ('dbx_business_glossary_term' = 'Ownership Model');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `ownership_model` SET TAGS ('dbx_value_regex' = 'company_owned|franchise|joint_venture|licensed');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_category` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Category');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_category` SET TAGS ('dbx_value_regex' = 'operating|non_operating|corporate|shared_services');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Segment Reporting Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Segment Type');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'restaurant_unit|brand_segment|geographic_region|franchise_group|company_owned_group|channel_segment');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Short Name');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `sss_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Same-Store Sales (SSS) Eligible Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Legal Entity ID');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_ultimate_parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Legal Entity ID');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'GAAP|IFRS|local_statutory');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_group_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Code');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_value_regex' = 'full|proportionate|equity|none');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Country Code');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_business_glossary_term' = 'Credit Control Area');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Status');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|dormant|liquidation|dissolved');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'company_owned|franchise_subsidiary|holding_company|joint_venture|partnership|branch');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_end_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Month');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `intercompany_clearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Clearing Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `jurisdiction_country` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `jurisdiction_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `jurisdiction_state_province` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State or Province');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Code');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `profit_center_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Required Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `segment_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Segment Reporting Required Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Short Name');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Registered State or Province');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `restaurants_ecm`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `approver_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User ID');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `approver_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User ID');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posting User ID');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `tertiary_journal_last_modified_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified User ID');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `tertiary_journal_last_modified_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `adjustment_period_indicator` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Period Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `audit_class` SET TAGS ('dbx_business_glossary_term' = 'Audit Class');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `audit_class` SET TAGS ('dbx_value_regex' = 'standard|high_risk|manual_adjustment|system_generated');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `baseline_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Payment Date');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `batch_input_session` SET TAGS ('dbx_business_glossary_term' = 'Batch Input Session');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `consolidation_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Transaction Type');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `consolidation_transaction_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_header_text` SET TAGS ('dbx_business_glossary_term' = 'Document Header Text');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `net_due_date` SET TAGS ('dbx_business_glossary_term' = 'Net Due Date');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `parked_indicator` SET TAGS ('dbx_business_glossary_term' = 'Parked Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Date');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_company_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Company Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,10}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ALTER COLUMN `workflow_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|rejected|cancelled');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_document_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Document Currency');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Document Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `special_gl_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special General Ledger (GL) Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `special_gl_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Code');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `user_name` SET TAGS ('dbx_business_glossary_term' = 'User Name');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'payables_settlement');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `maintenance_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `primary_ap_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `primary_ap_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `primary_ap_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location ID');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tertiary_ap_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tertiary_ap_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tertiary_ap_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Expense Category');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `expense_category` SET TAGS ('dbx_value_regex' = 'food_beverage|equipment|repairs_maintenance|utilities|services|other');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|posted|approved|paid|cancelled|on_hold');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|recurring');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|wire_transfer|credit_card|cash');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|variance_quantity|variance_price|variance_gr|not_applicable|pending');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` SET TAGS ('dbx_subdomain' = 'payables_settlement');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Payment ID');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `discount_taken_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `document_currency` SET TAGS ('dbx_business_glossary_term' = 'Document Currency');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `document_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `invoice_count` SET TAGS ('dbx_business_glossary_term' = 'Invoice Count');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `local_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire_transfer|check|electronic_funds_transfer|virtual_card|international_wire');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_priority` SET TAGS ('dbx_business_glossary_term' = 'Payment Priority');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|cleared|failed|cancelled|reversed');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'vendor_invoice|credit_memo|down_payment|advance_payment|expense_reimbursement');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|exception|pending_review');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `remittance_email` SET TAGS ('dbx_business_glossary_term' = 'Remittance Email');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `remittance_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `remittance_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `remittance_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Account Number');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'receivables_collection');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice ID');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Email Address');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'royalty|franchise_fee|catering|gift_card_settlement|intercompany|rebate');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `last_dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|direct_debit|cash');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` SET TAGS ('dbx_subdomain' = 'receivables_collection');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Payment ID');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Trace Number');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `discount_taken_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `dso_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO) Impact Days');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|debit_card|cash');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'royalty|franchise_fee|marketing_fund|catering_invoice|intercompany_settlement|other');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`ar_payment` ALTER COLUMN `wire_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Wire Confirmation Number');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee ID');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'kitchen_equipment|pos_hardware|leasehold_improvements|furniture_fixtures|vehicles|it_infrastructure');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_subclass` SET TAGS ('dbx_business_glossary_term' = 'Asset Subclass');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capex_project_code` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Project Code');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capex_project_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{6}$');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sold|scrapped|donated|traded_in|transferred');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_physical_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inventory Date');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lease Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{8,10}$');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `budget_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `baseline_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|locked');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `consolidation_entity` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entity');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `nro_flag` SET TAGS ('dbx_business_glossary_term' = 'New Restaurant Opening (NRO) Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `nro_project_code` SET TAGS ('dbx_business_glossary_term' = 'New Restaurant Opening (NRO) Project Code');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'company_owned|franchise|joint_venture');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Budget Subcategory');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `variance_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `version_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Code');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `version_code` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|reforecast|final');
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan ID');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_driver` SET TAGS ('dbx_business_glossary_term' = 'Allocation Driver');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|proportional|driver_based|zero_based|incremental');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `baseline_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_percentage_target` SET TAGS ('dbx_business_glossary_term' = 'Budget Percentage Target');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|closed|cancelled');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Budget Subcategory');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_version` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|actual');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|all_day');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `quantity_target` SET TAGS ('dbx_business_glossary_term' = 'Quantity Target');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Name');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|frozen|pending_activation');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'operating|payroll|concentration|zero_balance|escrow|reserve');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_key` SET TAGS ('dbx_business_glossary_term' = 'Bank Key');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_statement_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Delivery Method');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_statement_delivery_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|both');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_address` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Address');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `cash_pool_group` SET TAGS ('dbx_business_glossary_term' = 'Cash Pool Group');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closing Date');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `dual_signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Dual Signature Required Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `dual_signature_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Dual Signature Threshold Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `electronic_banking_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Banking ID');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `electronic_banking_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percent');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `minimum_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opening Date');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_facility_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Facility Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit Amount');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `payment_method_supported` SET TAGS ('dbx_business_glossary_term' = 'Payment Methods Supported');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_list` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory List');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Code (BIC)');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Identifier (ID)');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `comparative_prior_period_id` SET TAGS ('dbx_business_glossary_term' = 'Comparative Prior Period Identifier (ID)');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `comparative_prior_year_period_id` SET TAGS ('dbx_business_glossary_term' = 'Comparative Prior Year Period Identifier (ID)');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `prior_financial_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_business_glossary_term' = 'Accounting Principle');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_value_regex' = 'US_GAAP|IFRS|local_GAAP|management');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `adjustment_posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Posting Allowed Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `audit_trail_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `calendar_days_count` SET TAGS ('dbx_business_glossary_term' = 'Calendar Days Count');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `calendar_month` SET TAGS ('dbx_business_glossary_term' = 'Calendar Month');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `calendar_quarter` SET TAGS ('dbx_business_glossary_term' = 'Calendar Quarter');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `calendar_year` SET TAGS ('dbx_business_glossary_term' = 'Calendar Year');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `close_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Close Actual Date');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `close_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Close Scheduled Date');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `close_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Close Variance Days');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `consolidation_group_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Code');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `consolidation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Required Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `day_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Days in Period');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `exchange_rate_to_reporting` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to Reporting Currency');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_value_regex' = 'average|closing|budget|historical');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `financial_period_description` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Description');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `financial_statement_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Type');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `financial_statement_type` SET TAGS ('dbx_value_regex' = 'balance_sheet|income_statement|cash_flow|equity');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `fiscal_period_code` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Code');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `holiday_indicator` SET TAGS ('dbx_business_glossary_term' = 'Holiday Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `holiday_indicator` SET TAGS ('dbx_value_regex' = 'none|partial|full');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `is_adjustment_period` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Period Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Current Period Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Estimated Period Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `is_holiday_period` SET TAGS ('dbx_business_glossary_term' = 'Holiday Period Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `is_interim` SET TAGS ('dbx_business_glossary_term' = 'Interim Period Indicator');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `ledger_type` SET TAGS ('dbx_business_glossary_term' = 'Ledger Type');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `ledger_type` SET TAGS ('dbx_value_regex' = 'leading|non_leading|special_purpose');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `lock_flag` SET TAGS ('dbx_business_glossary_term' = 'Period Lock Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Period Notes');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `period_category` SET TAGS ('dbx_business_glossary_term' = 'Period Category');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `period_category` SET TAGS ('dbx_value_regex' = 'actual|budget|forecast|plan');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `period_key` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Key');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Period Number');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `period_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Period Sequence Number');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'not_opened|open|closed|locked');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'regular|special|adjustment');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `posting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Allowed Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `quarter_number` SET TAGS ('dbx_business_glossary_term' = 'Quarter Number');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `segment_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Segment Reporting Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `sss_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Same-Store Sales (SSS) Eligible Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `tax_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `tax_reporting_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Period Flag');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `working_days_count` SET TAGS ('dbx_business_glossary_term' = 'Working Days Count');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `year_period_key` SET TAGS ('dbx_business_glossary_term' = 'Year Period Key');
ALTER TABLE `restaurants_ecm`.`finance`.`financial_period` ALTER COLUMN `year_period_key` SET TAGS ('dbx_value_regex' = '^[0-9]{4}[0-9]{3}$');
ALTER TABLE `restaurants_ecm`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'receivables_collection');
ALTER TABLE `restaurants_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Identifier');
ALTER TABLE `restaurants_ecm`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`finance`.`payment_run` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`finance`.`payment_run` ALTER COLUMN `reversed_payment_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
