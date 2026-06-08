-- Schema for Domain: finance | Business: Agriculture | Version: v1_ecm
-- Generated on: 2026-05-01 16:23:37

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `agriculture_ecm`.`finance` COMMENT 'SSOT for all enterprise financial data including general ledger (GL), cost center accounting, accounts payable (AP), crop enterprise budgeting, CAPEX/OPEX tracking, COGS allocation by commodity, EBITDA reporting, ROI analysis, and financial controls per SOX requirements. Integrates with SAP S/4HANA FI/CO and Oracle NetSuite. Ensures GAAP/IFRS compliance for consolidated financial statements and regulatory filings.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique surrogate identifier for the GL account record in the enterprise data lakehouse. Primary key for all financial posting references across AP, AR, fixed assets, and period-end close.',
    `account_currency` STRING COMMENT 'The ISO 4217 three-letter currency code in which this GL account is maintained (e.g., USD for US Dollar). Accounts may be maintained in local currency, group currency, or hard currency. Supports multi-currency consolidation for international agricultural operations.. Valid values are `^[A-Z]{3}$`',
    `account_group` STRING COMMENT 'Grouping classification that controls the number range and field selection for GL accounts within SAP S/4HANA (e.g., current assets, fixed assets, operating expenses, COGS). Supports chart of accounts structuring and financial reporting hierarchies for crop enterprise EBITDA analysis.',
    `account_long_description` STRING COMMENT 'Extended narrative description of the GL account purpose, usage guidelines, and applicable business transactions. Supports SOX documentation requirements and auditor review.',
    `account_name` STRING COMMENT 'The short descriptive name of the GL account as it appears in the chart of accounts and financial statements. Used for display in trial balance, P&L, and balance sheet reports.',
    `account_number` STRING COMMENT 'The externally-known alphanumeric GL account number as defined in the chart of accounts (CoA). Corresponds to the SAP S/4HANA G/L account number (SAKNR) and Oracle NetSuite account number. Used in all financial postings, journal entries, and regulatory filings.. Valid values are `^[0-9]{4,10}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the GL account: active (available for posting), inactive (temporarily disabled), blocked (posting prevented per SOX controls), or archived (retired from use but retained for historical reporting). Drives account availability in financial transaction processing.. Valid values are `active|inactive|blocked|archived`',
    `account_subtype` STRING COMMENT 'Further classification within the account type for agricultural enterprise reporting (e.g., current_asset, non_current_asset, current_liability, long_term_liability, operating_revenue, other_income, cogs, operating_expense, depreciation, interest_expense, tax_expense). Supports EBITDA line-item decomposition and CAPEX/OPEX segregation. [ENUM-REF-CANDIDATE: current_asset|non_current_asset|current_liability|long_term_liability|operating_revenue|other_income|cogs|operating_expense|depreciation|interest_expense|tax_expense — promote to reference product]',
    `account_type` STRING COMMENT 'Fundamental classification of the GL account per the accounting equation: asset, liability, equity, revenue, or expense. Drives debit/credit normal balance behavior and financial statement placement. Corresponds to SAP account type (KTOKS) and Oracle NetSuite account type.. Valid values are `asset|liability|equity|revenue|expense`',
    `chart_of_accounts_code` STRING COMMENT 'The identifier of the chart of accounts to which this GL account belongs. An enterprise may maintain multiple charts of accounts (e.g., operational CoA, group CoA for consolidation). Corresponds to SAP KTOPL field.. Valid values are `^[A-Z0-9]{4}$`',
    `commodity_allocation_flag` BOOLEAN COMMENT 'Indicates whether costs or revenues posted to this GL account can be allocated to specific agricultural commodities (e.g., corn, soybeans, wheat, livestock). Enables commodity-level COGS and profitability analysis per crop enterprise. Supports USDA farm program reporting and Granular Farm Management integration.',
    `consolidation_account_number` STRING COMMENT 'The group-level GL account number used for intercompany elimination and consolidated financial statement preparation. Maps local chart of accounts entries to the group chart of accounts for IFRS 10 consolidation reporting. Corresponds to SAP ALTKT field.',
    `cost_center_required` BOOLEAN COMMENT 'When True, a cost center assignment is mandatory for all postings to this GL account. Ensures cost accountability by organizational unit (e.g., field operations, irrigation, crop protection, livestock). Supports crop enterprise budgeting and OPEX tracking in SAP CO.',
    `cost_element_category` STRING COMMENT 'SAP Controlling (CO) cost element classification: primary cost elements map directly to P&L GL accounts (e.g., seed costs, fertilizer COGS, labor); secondary cost elements are used for internal allocations and activity-based costing. Supports crop enterprise EBITDA reporting and COGS allocation by commodity.. Valid values are `primary|secondary|not_applicable`',
    `cost_element_type` STRING COMMENT 'Numeric or coded type of the SAP CO cost element (e.g., 1=primary costs/cost-reducing revenues, 3=accrual/deferral per surcharge, 11=revenues, 12=sales deductions, 21=internal settlement, 41=overhead rates, 42=assessment, 43=internal activity allocation). Drives cost allocation behavior in crop enterprise budgeting. [ENUM-REF-CANDIDATE: 1|3|11|12|21|41|42|43 — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account record was first created in the system of record (SAP S/4HANA or Oracle NetSuite). Supports audit trail requirements under SOX Section 404 and GAAP/IFRS record-keeping standards.',
    `deactivation_date` DATE COMMENT 'The date on which this GL account was deactivated or retired from active use. Null for currently active accounts. Supports chart of accounts lifecycle management and historical financial statement reconstruction.',
    `effective_date` DATE COMMENT 'The date from which this GL account became active and available for financial postings. Used for chart of accounts versioning and historical financial reporting. Supports GAAP/IFRS comparative period reporting.',
    `field_status_group` STRING COMMENT 'Controls which fields are required, optional, or suppressed when posting to this GL account. Corresponds to SAP FSTAG field. Ensures data completeness for cost center, profit center, and commodity allocation fields on agricultural financial postings.',
    `financial_statement_section` STRING COMMENT 'Indicates which primary financial statement this account appears in: balance sheet (B/S) for assets, liabilities, and equity; profit and loss (P&L) for revenues and expenses; cash flow statement; or statement of changes in equity. Critical for GAAP/IFRS dual-ledger reporting and EBITDA computation.. Valid values are `balance_sheet|profit_and_loss|cash_flow|equity_statement`',
    `functional_area` STRING COMMENT 'SAP functional area classification used for cost-of-sales accounting and segment reporting (e.g., production, sales, administration, research and development, procurement). Enables P&L by function reporting per IFRS IAS 1 and supports crop enterprise EBITDA analysis by business function.',
    `is_balance_sheet_account` BOOLEAN COMMENT 'Flag indicating whether this GL account is a balance sheet account (True) or a profit and loss account (False). Balance sheet accounts carry forward balances at year-end; P&L accounts are closed to retained earnings. Corresponds to SAP XBILK field.',
    `is_capex_account` BOOLEAN COMMENT 'Flags whether this GL account is designated for capital expenditure (CAPEX) tracking, including farm equipment purchases, land improvements, irrigation infrastructure, and precision agriculture technology investments. Supports CAPEX vs OPEX segregation for financial planning and tax depreciation.',
    `is_cogs_account` BOOLEAN COMMENT 'Flags whether this GL account is used for Cost of Goods Sold (COGS) allocation. Supports commodity-level COGS tracking for crop enterprises (e.g., corn, soybeans, wheat) and livestock operations. Critical for gross margin analysis and EBITDA reporting by crop enterprise.',
    `is_ebitda_relevant` BOOLEAN COMMENT 'Indicates whether this GL account is included in EBITDA calculations for crop enterprise performance reporting. Accounts flagged as EBITDA-relevant are included in operating income before interest, taxes, depreciation, and amortization line items. Supports management reporting and investor relations.',
    `is_gaap_relevant` BOOLEAN COMMENT 'Indicates whether this GL account is active and relevant under US GAAP reporting requirements. Supports dual-ledger GAAP/IFRS accounting where certain accounts may apply to one framework but not the other. Used in GAAP-basis financial statement preparation and SOX compliance.',
    `is_ifrs_relevant` BOOLEAN COMMENT 'Indicates whether this GL account is active and relevant under IFRS reporting requirements. Supports dual-ledger GAAP/IFRS accounting for consolidated financial statements filed with international regulators. Used in IFRS-basis financial statement preparation.',
    `is_opex_account` BOOLEAN COMMENT 'Flags whether this GL account is designated for operational expenditure (OPEX) tracking, including seed costs, fertilizer, crop protection chemicals, labor, and irrigation operating costs. Supports CAPEX/OPEX segregation for EBITDA reporting and crop enterprise budgeting.',
    `is_reconciliation_account` BOOLEAN COMMENT 'Indicates whether this GL account is a reconciliation account for a subledger (AP, AR, fixed assets, inventory). Reconciliation accounts cannot be posted to directly; postings flow from the subledger. Corresponds to SAP MITKZ field. Critical for SOX financial controls.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account record was most recently updated. Tracks chart of accounts maintenance activity and supports SOX change management controls and audit trail documentation.',
    `line_item_display` BOOLEAN COMMENT 'When True, individual line items posted to this GL account are stored and displayable for detailed audit trail and drill-down analysis. Corresponds to SAP XKRES field. Required for SOX audit trail requirements and financial controls documentation.',
    `normal_balance` STRING COMMENT 'Indicates whether the account normally carries a debit or credit balance per double-entry bookkeeping rules. Assets and expenses are normally debit; liabilities, equity, and revenues are normally credit. Used for trial balance validation and period-end close controls.. Valid values are `debit|credit`',
    `open_item_management` BOOLEAN COMMENT 'When True, individual line items posted to this account are managed as open items that must be explicitly cleared (e.g., GR/IR clearing accounts, bank clearing accounts, advance payment accounts). Corresponds to SAP XOPVW field. Essential for AP/AR reconciliation and period-end close.',
    `posting_block` BOOLEAN COMMENT 'When True, prevents any new financial postings to this GL account. Used during period-end close, account restructuring, or SOX-mandated account freeze periods. Corresponds to SAP XSPEB field. Critical for financial controls and audit integrity.',
    `profit_center_required` BOOLEAN COMMENT 'When True, a profit center assignment is mandatory for all postings to this GL account. Ensures segment-level profitability reporting by crop enterprise, livestock operation, or business unit. Supports IFRS 8 operating segment disclosure and management reporting.',
    `reconciliation_account_type` STRING COMMENT 'When is_reconciliation_account is True, identifies which subledger this account reconciles: accounts payable (vendor), accounts receivable (customer), fixed assets, or inventory. Null or not_applicable for non-reconciliation accounts. Supports period-end close and SOX subledger-to-GL reconciliation controls.. Valid values are `accounts_payable|accounts_receivable|fixed_assets|inventory|not_applicable`',
    `sort_key` STRING COMMENT 'Three-digit code that determines the assignment field populated in line items posted to this GL account (e.g., 001=posting date, 003=document number, 009=external document number, 014=assignment field). Corresponds to SAP ZUAWA field. Controls how line items are sorted and displayed in account statements.. Valid values are `^[0-9]{3}$`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this GL account master data originates: SAP S/4HANA FI module or Oracle NetSuite GL. Supports data lineage tracking in the Databricks lakehouse silver layer and reconciliation between ERP systems.. Valid values are `SAP_S4HANA|ORACLE_NETSUITE`',
    `tax_category` STRING COMMENT 'Specifies the tax relevance of the GL account for input/output tax determination (e.g., input tax, output tax, not tax-relevant, tax-exempt). Corresponds to SAP MWSKZ field. Relevant for agricultural input tax recovery on seed, fertilizer, and equipment purchases per applicable tax regulations.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'General Ledger (GL) chart of accounts master — the authoritative SSOT for all GL account definitions across the agricultural enterprise. Captures account number, account type (asset, liability, equity, revenue, expense), account group, cost element classification, P&L vs balance sheet indicator, currency, consolidation account mapping, IFRS/GAAP dual-ledger flags, and active status. Supports EBITDA reporting by crop enterprise, commodity-level COGS tracking, and SOX financial controls. Referenced by all financial postings across AP, AR, fixed assets, and period-end close.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique surrogate identifier for the cost center record in the enterprise data platform (Silver Layer). Primary key for the cost_center data product.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: cost_center has company_code as a STRING. Cost centers belong to a specific legal entity (company code) in SAP CO. Normalizing to a proper FK ensures referential integrity between the controlling area',
    `employee_id` BIGINT COMMENT 'Employee ID of the manager accountable for this cost centers budget and expenditures, as maintained in SAP SuccessFactors HR. Used for budget approval workflows, variance reporting, and SOX financial controls accountability. Stored as employee identifier, not personal name.',
    `activity_type_code` STRING COMMENT 'SAP CO activity type code representing the primary activity performed by this cost center (e.g., MACH for machine hours, LABOR for labor hours, IRRIG for irrigation hours, SPRAY for spraying operations). Used for activity-based cost allocation and internal price calculation.. Valid values are `^[A-Z0-9_]{1,6}$`',
    `approval_status` STRING COMMENT 'Workflow approval status of the cost center master record per SOX internal controls. Draft: initial creation not yet submitted. Pending_approval: submitted for authorization. Approved: authorized by finance controller and available for use. Rejected: returned for correction. Ensures segregation of duties and financial control compliance.. Valid values are `draft|pending_approval|approved|rejected`',
    `business_area_code` STRING COMMENT 'SAP business area code representing a distinct area of operations for internal balance sheet and P&L reporting (e.g., CROP for crop operations, LVST for livestock, SUPL for supply chain). Enables cross-company-code segment reporting per GAAP ASC 280 and IFRS 8.. Valid values are `^[A-Z0-9]{1,4}$`',
    `capex_budget_annual` DECIMAL(18,2) COMMENT 'Approved annual CAPEX budget amount for this cost center in the controlling currency. Represents planned capital investments (equipment, infrastructure, land improvements) for the fiscal year. Supports CAPEX tracking and ROI analysis per GAAP ASC 360 / IFRS IAS 16.',
    `commodity_type` STRING COMMENT 'Primary agricultural commodity or livestock type associated with this cost center for COGS allocation and crop enterprise budgeting (e.g., corn, soybeans, wheat, cattle, hogs, poultry, cotton, rice). Enables commodity-level profitability analysis and WASDE-aligned reporting. [ENUM-REF-CANDIDATE: corn|soybeans|wheat|cattle|hogs|poultry|cotton|rice|other — promote to reference product]',
    `controlling_area_code` STRING COMMENT 'SAP Controlling Area code to which this cost center belongs. The controlling area defines the organizational unit within which cost accounting is performed. All cost centers within the same controlling area share the same chart of accounts and fiscal year variant.. Valid values are `^[A-Z0-9]{1,4}$`',
    `cost_center_category` STRING COMMENT 'Functional classification of the cost center indicating its primary business purpose. Drives overhead allocation rules, COGS allocation by commodity, and OPEX tracking. Values: production (direct crop/livestock production), administration (G&A overhead), research_and_development (R&D per GAAP ASC 730), field_operations (planting, harvesting, irrigation), supply_chain (logistics, warehousing), overhead (indirect shared services).. Valid values are `production|administration|research_and_development|field_operations|supply_chain|overhead`',
    `cost_center_code` STRING COMMENT 'The externally-known alphanumeric code that uniquely identifies the cost center within the SAP S/4HANA CO controlling area. This is the business-facing identifier used in journal entries, purchase orders, and management reports (e.g., CC-FIELD-001, CC-ADMIN-HQ).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `cost_center_description` STRING COMMENT 'Free-text description providing additional context about the cost centers purpose, scope, and operational activities (e.g., Manages all field operations costs for the 5,000-acre corn production unit in Iowa, including planting, fertilization, crop protection, and harvest activities). Supports management reporting and organizational documentation.',
    `cost_center_name` STRING COMMENT 'Full descriptive name of the cost center as maintained in SAP S/4HANA CO master data (e.g., North Field Operations – Corn Belt, Livestock Feed Management – Hog Unit 3). Used in financial reports and management dashboards.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center master record. Active: available for cost postings. Inactive: temporarily disabled. Locked: blocked for new postings (e.g., period-end close). Pending_approval: awaiting authorization per SOX controls. Archived: historical record no longer in use.. Valid values are `active|inactive|locked|pending_approval|archived`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country in which this cost center operates (e.g., USA, BRA, ARG, CAN). Supports multi-national agricultural operations, IFRS/GAAP consolidated reporting, GDPR compliance for international operations, and country-of-origin tracking per COOL regulations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost center master record was first created in the source system or data platform. Supports audit trail requirements, SOX financial controls, and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost centers controlling currency (e.g., USD for US Dollar). Defines the currency in which cost center budgets, actual costs, and variances are reported. Aligns with the controlling area currency in SAP CO.. Valid values are `^[A-Z]{3}$`',
    `fiscal_year_variant` STRING COMMENT 'SAP fiscal year variant code defining the fiscal year structure for this cost center (e.g., K4 for calendar year January–December, V3 for April–March agricultural fiscal year). Determines period-end close schedules and budget planning cycles.. Valid values are `^[A-Z0-9]{2}$`',
    `functional_area_code` STRING COMMENT 'SAP functional area code classifying the cost center by business function for cost-of-sales accounting (e.g., PROD for production/COGS, ADMIN for G&A, SALES for selling expenses, RD for R&D). Supports COGS allocation by commodity and functional income statement reporting per GAAP/IFRS.. Valid values are `^[A-Z0-9_]{1,16}$`',
    `geographic_region` STRING COMMENT 'Geographic region or territory associated with this cost center (e.g., Midwest Corn Belt, Southeast Poultry Region, Great Plains Wheat Belt, Pacific Northwest). Supports regional OPEX analysis, GIS-based land management integration with Esri ArcGIS, and USDA regional reporting.',
    `gl_account_assignment_group` STRING COMMENT 'GL account assignment group linking this cost center to the appropriate general ledger accounts in SAP FI for automatic account determination. Ensures correct GL posting for COGS, OPEX, and overhead entries per the chart of accounts and GAAP/IFRS financial reporting requirements.. Valid values are `^[A-Z0-9_]{1,10}$`',
    `hierarchy_level` STRING COMMENT 'Numeric level of this cost center within the standard hierarchy (cost center group tree) in SAP CO. Level 1 represents the top-level controlling area node; higher numbers represent more granular operational units. Used for roll-up reporting and overhead allocation across the agricultural enterprise.',
    `hierarchy_node_code` STRING COMMENT 'Code of the standard hierarchy node (cost center group) to which this cost center belongs in SAP CO. Enables hierarchical roll-up of costs for management reporting, budget consolidation, and EBITDA analysis by business segment.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `is_project_cost_collector` BOOLEAN COMMENT 'Indicates whether this cost center is designated as a project cost collector for capital projects, R&D programs, or special agricultural initiatives (e.g., precision agriculture rollout, irrigation infrastructure project). When True, costs posted here are tracked against a project budget in SAP PS/CO.',
    `is_statistical` BOOLEAN COMMENT 'Indicates whether this is a statistical cost center used only for reporting and allocation base calculations (e.g., tracking headcount, acreage, or machine hours as statistical key figures) without receiving actual cost postings. Statistical cost centers support overhead distribution in SAP CO.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this cost center master record in the source system or data platform. Critical for SOX change management controls, audit trails, and incremental data pipeline processing in the Databricks Silver Layer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lock_indicator` STRING COMMENT 'SAP CO lock indicator controlling which types of postings are permitted to this cost center. Unlocked: all postings allowed. Locked_actual: actual cost postings blocked. Locked_plan: planning postings blocked. Locked_all: all postings blocked (e.g., during period-end close or organizational restructuring).. Valid values are `unlocked|locked_actual|locked_plan|locked_all`',
    `opex_budget_annual` DECIMAL(18,2) COMMENT 'Approved annual OPEX budget amount for this cost center in the controlling currency. Represents planned operational expenditures for the fiscal year as entered in SAP CO planning. Used for budget vs. actual variance analysis, EBITDA forecasting, and crop enterprise budgeting per GAAP/IFRS.',
    `overhead_allocation_key` STRING COMMENT 'SAP overhead allocation key (costing sheet key) assigned to this cost center, determining how indirect overhead costs are allocated from overhead cost centers to production/field operations cost centers. Critical for accurate COGS allocation by commodity and crop enterprise profitability analysis.. Valid values are `^[A-Z0-9_]{1,10}$`',
    `plant_code` STRING COMMENT 'SAP plant code representing the physical agricultural facility or farm location associated with this cost center (e.g., grain elevator, livestock facility, processing plant, field operations hub). Links cost center to physical operations for OPEX tracking and asset management.. Valid values are `^[A-Z0-9]{1,4}$`',
    `profit_center_code` STRING COMMENT 'SAP profit center code to which this cost center is assigned for profitability analysis. Profit centers represent autonomous business segments (e.g., corn enterprise, soybean enterprise, hog operation, supply chain segment) enabling EBITDA reporting and GAAP/IFRS segment reporting.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `segment_type` STRING COMMENT 'Business segment classification of the cost center for GAAP ASC 280 / IFRS 8 segment reporting. Identifies whether the cost center belongs to a crop enterprise (e.g., corn, soybeans, wheat), livestock operation (e.g., cattle, hogs, poultry), supply chain segment, corporate overhead, or shared services. Drives EBITDA reporting by segment.. Valid values are `crop_enterprise|livestock_operation|supply_chain|corporate|shared_services`',
    `short_name` STRING COMMENT 'Abbreviated name of the cost center (up to 20 characters) used in condensed financial reports, budget variance summaries, and SAP CO transaction screens where space is limited.. Valid values are `^.{1,20}$`',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this cost center master data originates. SAP_S4HANA: primary ERP source (CO module). ORACLE_NETSUITE: secondary ERP for certain legal entities. GRANULAR: Granular Farm Management for farm-level cost centers. MANUAL: manually created in the data platform.. Valid values are `SAP_S4HANA|ORACLE_NETSUITE|GRANULAR|MANUAL`',
    `source_system_key` STRING COMMENT 'The natural key or primary identifier of this cost center record in the originating source system (e.g., SAP cost center number, Oracle NetSuite internal ID, Granular cost center reference). Enables data lineage tracing and reconciliation between the Silver Layer and operational systems.',
    `valid_from_date` DATE COMMENT 'Date from which this cost center is active and available for cost postings in SAP CO. Supports time-dependent master data management and ensures costs are only allocated to active cost centers within their valid period. Format: yyyy-MM-dd.',
    `valid_to_date` DATE COMMENT 'Date until which this cost center is active and available for cost postings. After this date, the cost center is locked for new postings. Null indicates an open-ended validity. Supports fiscal year planning and organizational restructuring in SAP CO. Format: yyyy-MM-dd.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Cost center and profit center master data representing organizational units and profitability segments used for cost allocation, internal management accounting, and segment reporting across the agricultural enterprise. Captures cost center code, name, hierarchy level (including profit center hierarchy nodes), responsible manager, controlling area, company code, valid-from/to dates, cost center category (production, administration, R&D, field operations), profit center assignment and attributes (commodity/crop segment, livestock operation, supply chain segment), and project cost collection flags. Supports OPEX tracking, crop enterprise budgeting, overhead allocation, COGS allocation by commodity, EBITDA reporting by crop enterprise or livestock operation per GAAP/IFRS segment reporting requirements.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`company_code` (
    `company_code_id` BIGINT COMMENT 'Unique surrogate key for the company code record in the enterprise data lakehouse. Primary key for this entity.',
    `address_city` STRING COMMENT 'City of the legal entitys registered office address. Used for tax jurisdiction determination, regulatory filings, and geographic segmentation in financial reporting.',
    `address_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the registered office address. Used for international regulatory compliance, COOL (Country of Origin Labeling) reporting, and IFRS geographic segment disclosures.. Valid values are `^[A-Z]{3}$`',
    `address_postal_code` STRING COMMENT 'Postal or ZIP code of the legal entitys registered office address. Used for tax jurisdiction mapping, regulatory filings, and geographic analytics in the enterprise GIS.',
    `address_state_province` STRING COMMENT 'State or province of the legal entitys registered office. Drives state-level tax jurisdiction, USDA state program eligibility, and EPA regional compliance requirements.',
    `address_street` STRING COMMENT 'Street address of the legal entitys registered office as recorded with government authorities. Used for regulatory correspondence, USDA/FDA/EPA filings, and legal notices.',
    `chart_of_accounts` STRING COMMENT 'The SAP chart of accounts key assigned to this company code, defining the GL account structure used for all financial postings, cost center accounting, and COGS allocation by commodity. Ensures consistency across consolidated financial statements.. Valid values are `^[A-Z0-9]{1,4}$`',
    `company_code_code` STRING COMMENT 'The 4-character alphanumeric company code as defined in SAP S/4HANA FI module. Serves as the primary external business identifier for the legal entity across all financial transactions, general ledger postings, and regulatory filings. Aligns with SAP company code (BUKRS) field.. Valid values are `^[A-Z0-9]{1,4}$`',
    `company_code_status` STRING COMMENT 'Current lifecycle status of the company code. Controls whether financial postings, procurement transactions, and payroll processing are permitted for this entity in SAP S/4HANA and Oracle NetSuite.. Valid values are `active|inactive|in_liquidation|dormant|pending`',
    `consolidation_chart_of_accounts` STRING COMMENT 'The group-level chart of accounts used for intercompany consolidation and segment reporting. Maps local GL accounts to the group reporting structure for GAAP/IFRS consolidated financial statements.. Valid values are `^[A-Z0-9]{1,4}$`',
    `consolidation_group` STRING COMMENT 'Identifier for the consolidation group to which this company code belongs within the enterprise group structure. Used for multi-entity financial consolidation, intercompany elimination, and GAAP ASC 810 / IFRS 10 consolidated statement preparation.',
    `controlling_area` STRING COMMENT 'SAP controlling area code to which this company code is assigned. The controlling area defines the scope of cost center accounting, internal orders, and profitability analysis (CO-PA) for CAPEX/OPEX tracking and crop enterprise budgeting.. Valid values are `^[A-Z0-9]{1,4}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country in which the legal entity is incorporated and registered. Drives tax jurisdiction determination, regulatory reporting obligations (USDA, FDA, EPA), and currency defaulting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this company code record was first created in the enterprise data lakehouse. Supports SOX audit trail requirements, data lineage tracking, and financial control documentation.',
    `credit_control_area` STRING COMMENT 'SAP credit control area assigned to this company code for accounts receivable credit limit management and customer credit risk monitoring across the agricultural supply chain and sales distribution operations.. Valid values are `^[A-Z0-9]{1,4}$`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the local (functional) currency of the company code. Used for all general ledger postings, COGS allocation, EBITDA reporting, and GAAP/IFRS financial statement preparation.. Valid values are `^[A-Z]{3}$`',
    `effective_from_date` DATE COMMENT 'The date from which this company code became active and financial postings were permitted in the ERP system. Marks the start of the entitys operational financial lifecycle for GAAP/IFRS reporting periods.',
    `effective_to_date` DATE COMMENT 'The date on which this company code was deactivated or closed. Null for currently active entities. Used for historical consolidation scope management and SOX audit trail requirements.',
    `entity_type` STRING COMMENT 'Classification of the legal entity structure within the agricultural enterprise group. Determines consolidation treatment under GAAP ASC 810 / IFRS 10 and applicable regulatory reporting obligations.. Valid values are `subsidiary|parent|joint_venture|branch|holding|cooperative`',
    `epa_facility_identifier` STRING COMMENT 'EPA-assigned facility identifier for environmental compliance reporting, pesticide registration, and agricultural chemical use tracking under EPA regulations. Supports IPM program documentation and BMP compliance.',
    `fda_establishment_number` STRING COMMENT 'FDA-assigned establishment registration number for food manufacturing or processing facilities operated by this legal entity. Required for FSMA compliance, HACCP program registration, and FDA food safety inspections.',
    `fiscal_year_variant` STRING COMMENT 'SAP fiscal year variant code (e.g., K4 for calendar year, V3 for April–March) that defines the fiscal year and posting period structure for this company code. Critical for period-end close, CAPEX/OPEX tracking, and GAAP/IFRS period reporting.. Valid values are `^[A-Z0-9]{2}$`',
    `gaap_reporting_standard` STRING COMMENT 'The accounting standard under which this company code prepares its statutory financial statements. US entities typically report under GAAP; international subsidiaries may report under IFRS. Drives chart of accounts mapping and consolidation adjustments.. Valid values are `GAAP|IFRS|GAAP_IFRS`',
    `globalg_ap_number` STRING COMMENT 'GLOBALG.A.P. certification number assigned to this legal entity for Good Agricultural Practices compliance. Supports customer audit requirements, export market access, and GFSI-recognized food safety certification tracking.',
    `incorporation_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the jurisdiction in which the legal entity was formally incorporated. May differ from the operating country for holding companies or international subsidiaries in the global agricultural supply chain.. Valid values are `^[A-Z]{3}$`',
    `incorporation_date` DATE COMMENT 'The date on which the legal entity was formally incorporated or registered with the relevant government authority. Used for entity lifecycle management, consolidation scope determination, and regulatory filing history.',
    `intercompany_clearing_account` STRING COMMENT 'GL account number used for intercompany transaction clearing and elimination during multi-entity consolidation. Ensures accurate elimination of intercompany balances in GAAP/IFRS consolidated financial statements.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code representing the primary language used for financial documents, correspondence, and regulatory filings for this company code in SAP S/4HANA.. Valid values are `^[A-Z]{2}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this company code record. Supports change management tracking, SOX internal control documentation, and data quality monitoring in the Databricks Silver Layer.',
    `legal_entity_name` STRING COMMENT 'Full registered legal name of the entity as it appears on government filings, SEC registrations, USDA certifications, and consolidated financial statements. Used for GAAP/IFRS segment reporting and SOX financial controls.',
    `organic_certification_number` STRING COMMENT 'USDA National Organic Program (NOP) certification number for legal entities engaged in certified organic crop production or processing. Required for organic premium pricing, COOL labeling, and USDA organic program compliance reporting.',
    `profit_center_standard_hierarchy` STRING COMMENT 'SAP controlling area profit center standard hierarchy node assigned to this company code. Supports EBITDA reporting, ROI analysis by business segment, and COGS allocation by commodity across the agricultural enterprise.',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the group reporting (presentation) currency used in consolidated financial statements. Typically USD for US-headquartered agricultural enterprises. Distinct from the local functional currency.. Valid values are `^[A-Z]{3}$`',
    `sec_registrant_number` STRING COMMENT 'SEC Central Index Key (CIK) or registrant number for publicly traded entities within the agricultural enterprise. Required for SEC filings, SOX compliance, and GAAP financial statement disclosures.',
    `short_name` STRING COMMENT 'Abbreviated or trading name of the legal entity used in internal reports, dashboards, and operational communications within the FMIS and ERP systems.',
    `sox_in_scope` BOOLEAN COMMENT 'Indicates whether this company code is within the scope of SOX Section 302 and Section 404 internal control over financial reporting (ICFR) requirements. Drives audit procedures, control testing, and financial reporting certifications.',
    `tax_identification_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or equivalent tax identification number assigned to the legal entity by the relevant tax authority. Required for IRS filings, USDA program participation, and SOX financial controls.',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction identifier used to determine applicable federal, state, and local tax rates for this legal entity. Drives sales tax, use tax, and VAT calculations in SAP S/4HANA and Oracle NetSuite. Relevant for USDA, FDA, and EPA regulatory tax obligations.',
    `usda_entity_identifier` STRING COMMENT 'USDA-assigned identifier for this legal entity used in farm program registrations, commodity reporting, FSMA compliance filings, and National Organic Program (NOP) certifications. Supports regulatory reporting to USDA APHIS and FSIS.',
    `vat_registration_number` STRING COMMENT 'VAT or GST registration number for the legal entity in applicable jurisdictions. Required for international agricultural trade, cross-border supply chain transactions, and IFRS tax reporting for non-US entities.',
    CONSTRAINT pk_company_code PRIMARY KEY(`company_code_id`)
) COMMENT 'Legal entity and company code master representing individual legal entities within the agricultural enterprise for consolidated financial statements. Captures company code, legal entity name, country, currency, fiscal year variant, chart of accounts assignment, consolidation group, tax jurisdiction, and regulatory filing identifiers (USDA, FDA, SEC). Supports SOX financial controls, multi-entity consolidation, and GAAP/IFRS segment reporting.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique surrogate identifier for each general ledger journal entry record in the agricultural enterprise. Primary key for the journal_entry data product in the Databricks Silver Layer.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: journal_entry has company_code as a STRING. Every journal entry belongs to a specific legal entity (company code). Normalizing to a proper FK ensures referential integrity and enables entity-level fin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: journal_entry has cost_center as a STRING. Normalizing to a FK to cost_center links the journal entry header to the organizational unit, enabling cost center-level journal entry reporting and controll',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: journal_entry has gl_account as a STRING. While journal_entry_line carries the detailed GL account references, the header-level gl_account string should be normalized to a FK for consistency and refer',
    `approval_status` STRING COMMENT 'Workflow approval state of the journal entry, particularly for manual entries and high-value postings subject to SOX internal controls. pending = awaiting approver action; approved = authorized for posting; rejected = returned for correction; not_required = system-generated entry exempt from manual approval.. Valid values are `pending|approved|rejected|not_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'The exact date and time when this journal entry was approved for posting. Provides a precise audit trail event timestamp for SOX compliance, internal control testing, and financial close timeline analysis.',
    `approved_by` STRING COMMENT 'The system user ID of the approver who authorized this journal entry for posting, particularly for manual entries and high-value postings subject to SOX dual-control requirements. Supports segregation of duties (SoD) compliance and internal audit reviews.',
    `assignment_field` STRING COMMENT 'Free-form alphanumeric field used to sort and group GL line items for clearing and reconciliation purposes. In agricultural operations, commonly populated with crop season identifiers, field IDs, commodity lot numbers, or customer/vendor account numbers to facilitate open item management.',
    `company_code_amount` DECIMAL(18,2) COMMENT 'The journal entry amount converted to the company code (local) currency. Used for entity-level financial reporting, statutory filings, and GAAP/IFRS consolidated financial statements. Derived from transaction_amount using the exchange rate at posting_date.',
    `company_code_currency` STRING COMMENT 'ISO 4217 three-letter currency code of the company code (local) currency in which company_code_amount is expressed. Typically USD for US-based agricultural entities but may differ for international subsidiaries.. Valid values are `^[A-Z]{3}$`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether the line item is a debit (D) or credit (C) posting per double-entry bookkeeping principles. Fundamental to GL balance verification, trial balance generation, and GAAP/IFRS financial statement preparation.. Valid values are `D|C`',
    `document_date` DATE COMMENT 'The date of the original source document (invoice, receipt, contract, etc.) that triggered this journal entry. May differ from posting_date for accruals, reversals, or late-arriving documents. Used for aging analysis and audit trail verification.',
    `document_number` STRING COMMENT 'The externally-known accounting document number assigned by SAP S/4HANA FI or Oracle NetSuite upon posting. Serves as the primary business identifier for the journal entry and is referenced in audit trails, reconciliation reports, and SOX compliance documentation.',
    `document_type` STRING COMMENT 'SAP document type code classifying the nature of the journal entry (e.g., SA=GL account document, KR=vendor invoice, DR=customer invoice, AB=accounting document, ZP=payment posting, AA=asset posting). Drives posting rules, number ranges, and reporting classification. [ENUM-REF-CANDIDATE: SA|KR|DR|AB|ZP|AA|RE|RV|WA|WE — promote to reference product]',
    `elimination_status` STRING COMMENT 'Status of the intercompany elimination process for this journal entry in the consolidated financial statements. pending = awaiting elimination; eliminated = successfully eliminated in consolidation; not_required = not an intercompany entry; exception = elimination discrepancy requiring investigation.. Valid values are `pending|eliminated|not_required|exception`',
    `entry_timestamp` TIMESTAMP COMMENT 'The exact date and time when this journal entry record was first created in the source system (SAP S/4HANA or Oracle NetSuite). Serves as the RECORD_AUDIT_CREATED timestamp for SOX-compliant audit trail and data lineage tracking.',
    `entry_type` STRING COMMENT 'Functional classification of the journal entry indicating its business purpose. standard = routine operational posting; accrual = period-end accrual; reversal = reversal of a prior entry; intercompany = cross-entity transaction; manual = manually entered by accountant; recurring = template-based periodic entry.. Valid values are `standard|accrual|reversal|intercompany|manual|recurring`',
    `fiscal_period` STRING COMMENT 'The accounting period (1–16, including special periods for year-end adjustments) within the fiscal year in which this journal entry is posted. Aligns with SAP S/4HANA period-end close cycles and supports monthly/quarterly EBITDA and COGS reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this journal entry is recorded, as defined by the agricultural enterprises accounting calendar. Used for annual financial reporting, USDA farm program year alignment, and GAAP/IFRS period-end close processes.',
    `functional_area` STRING COMMENT 'SAP functional area code classifying the journal entry by business function for cost-of-sales accounting and segment reporting (e.g., production, sales, administration, research). Supports IFRS 8 segment disclosures and GAAP ASC 280 reportable segment analysis.',
    `intercompany_indicator` BOOLEAN COMMENT 'Flag identifying this journal entry as an intercompany transaction between two legal entities within the agricultural enterprise group. True = intercompany posting requiring elimination in consolidated financial statements; False = intracompany or third-party posting.',
    `last_changed_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry record was last modified in the source system. Supports SOX-compliant change audit trails, data reconciliation between SAP S/4HANA and Oracle NetSuite, and Silver Layer incremental load processing.',
    `line_item_text` STRING COMMENT 'Descriptive text explaining the business purpose of this journal entry line item. Provides human-readable context for auditors, accountants, and financial analysts. Examples: Corn harvest COGS allocation Q3, Irrigation system CAPEX accrual, Intercompany feed cost recharge.',
    `posting_date` DATE COMMENT 'The date on which the journal entry is posted to the general ledger, determining the fiscal period and year assignment. Critical for period-end close, COGS allocation by commodity, and GAAP/IFRS accrual-basis accounting compliance.',
    `posting_key` STRING COMMENT 'SAP two-digit posting key controlling the account type, debit/credit indicator, and field selection for this journal entry line (e.g., 40=GL debit, 50=GL credit, 31=vendor credit, 01=customer debit). Determines how the line item is processed and displayed in the GL.',
    `posting_status` STRING COMMENT 'Current lifecycle state of the journal entry in the GL workflow. draft = entry created but not posted; posted = fully posted to GL; parked = saved for review before posting; held = temporarily suspended; reversed = reversed by a subsequent document; cleared = open items cleared against each other.. Valid values are `draft|posted|parked|held|reversed|cleared`',
    `posting_user` STRING COMMENT 'The system user ID of the person or automated process that posted this journal entry in SAP S/4HANA or Oracle NetSuite. Essential for SOX-compliant audit trails, segregation of duties (SoD) controls, and forensic accounting investigations.',
    `profit_center` STRING COMMENT 'SAP profit center code representing the autonomous business segment (e.g., crop division, livestock division, processing plant) responsible for this posting. Supports segment-level EBITDA reporting, ROI analysis by commodity, and IFRS 8 operating segment disclosures.',
    `reference_document_number` STRING COMMENT 'External reference number linking this journal entry to the originating source document such as a Purchase Order (PO), Sales Order (SO), Goods Receipt Note (GRN), Bill of Lading (BOL), or vendor invoice number. Supports end-to-end traceability across the agricultural supply chain.',
    `reversal_date` DATE COMMENT 'The posting date of the reversing journal entry. Used for period-end accrual management, ensuring reversals are posted in the correct fiscal period. Supports automated accrual reversal workflows in SAP S/4HANA for crop season cost accruals.',
    `reversal_document_number` STRING COMMENT 'The accounting document number of the reversing entry that cancels this journal entry. Populated only when reversal_indicator is True. Enables complete audit trail tracing from original posting through reversal for SOX compliance and GAAP/IFRS restatement analysis.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry has been reversed by a subsequent accounting document. True = entry has been reversed; False = entry is active and not reversed. Critical for period-end close accuracy, accrual management, and SOX audit trail completeness.',
    `source_system` STRING COMMENT 'Identifier of the operational system of record from which this journal entry originated. Supports data lineage tracking, reconciliation between SAP S/4HANA FI/CO and Oracle NetSuite GL, and Silver Layer data quality monitoring.. Valid values are `SAP_S4HANA|ORACLE_NETSUITE|GRANULAR|MANUAL`',
    `tax_code` STRING COMMENT 'Tax condition code assigned to this journal entry line item, determining applicable tax rates and tax account postings (e.g., input VAT on agricultural inputs, output VAT on commodity sales, exempt codes for USDA-regulated transactions). Supports tax reporting and compliance.',
    `trading_partner_company_code` STRING COMMENT 'The company code of the receiving/counterpart entity in an intercompany journal entry. Used for intercompany reconciliation, elimination of intercompany profits in consolidated financial statements, and netting agreement processing per GAAP ASC 810 and IFRS 10.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The gross monetary amount of the journal entry in the transaction currency. Represents the raw financial value before currency conversion. Used for COGS allocation, crop enterprise budgeting, CAPEX/OPEX tracking, and EBITDA reporting.',
    `transaction_currency` STRING COMMENT 'ISO 4217 three-letter currency code of the transaction amount (e.g., USD, EUR, BRL, AUD). Supports multi-currency agricultural operations including international commodity trading, export sales, and cross-border supply chain transactions.. Valid values are `^[A-Z]{3}$`',
    `wbs_element` STRING COMMENT 'SAP Work Breakdown Structure element code linking this journal entry to a specific capital project, crop season project, or infrastructure investment. Enables CAPEX tracking, project-level cost accumulation, and ROI analysis for agricultural investments such as irrigation systems or precision agriculture technology.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'General ledger journal entry representing all accounting documents including standard postings, intercompany transactions, accruals, reversals, and manual entries with embedded line-level detail. Header captures document number, document type, posting date, document date, fiscal year/period, company code, reference document, posting user, reversal indicator, and approval status. Line-level detail captures GL account, debit/credit indicator, amounts in transaction and company code currencies, cost center, profit center, WBS element, tax code, assignment field, and line item text. For intercompany postings: sending/receiving company code, elimination status, reconciliation status, and netting agreement reference. SSOT for all GL postings across the agricultural enterprise. Supports COGS allocation by commodity, crop enterprise cost tracking, intercompany elimination for consolidated financial statements, and SOX-compliant audit trails for GAAP/IFRS reporting.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual line item within a General Ledger (GL) journal entry. Serves as the primary key for this record in the Databricks Silver Layer lakehouse.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Line-level commodity tagging on journal entries supports commodity-level cost allocation, gross margin reporting by crop, and hedge gain/loss attribution. Ag financial analysts drill from GL line item',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this expenditure or revenue posting. Enables crop enterprise cost tracking, OPEX allocation by farm division, and management accounting reporting in SAP CO.',
    `gl_account_id` BIGINT COMMENT 'Reference to the General Ledger (GL) account to which this line item is posted. Identifies the chart of accounts node (e.g., revenue, COGS, asset, liability) for financial classification. Satisfies TRANSACTION_LINE role RESOURCE_REFERENCE category requirement.',
    `order_id` BIGINT COMMENT 'Reference to the SAP internal order used for short-term cost collection on specific agricultural activities (e.g., a planting campaign, a pest management program, or a harvest operation). Complements WBS for non-project cost tracking.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key reference to the parent journal entry header (TRANSACTION_HEADER). Links this line item to its controlling GL journal entry document. Satisfies TRANSACTION_LINE role HEADER_REFERENCE category requirement.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center for this posting, enabling profitability analysis by crop type, livestock operation, or business segment. Supports EBITDA and ROI reporting by agricultural business unit.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the Work Breakdown Structure (WBS) element for project-based cost tracking. Used for CAPEX projects such as irrigation infrastructure, equipment procurement, and farm facility construction.',
    `account_type` STRING COMMENT 'SAP account type code indicating the subledger category of this posting: A=Asset, D=Customer (Debtor), K=Vendor (Creditor), M=Material, S=General Ledger. Determines reconciliation account linkage and subledger integration.. Valid values are `A|D|K|M|S`',
    `assignment_field` STRING COMMENT 'Free-form alphanumeric assignment field (ZUONR in SAP) used to link this line item to a specific business reference such as a purchase order number, sales order, crop lot, or payment run identifier. Supports clearing and reconciliation workflows.',
    `baseline_date` DATE COMMENT 'Reference date used for payment term calculation and due date determination for vendor/customer line items. Typically the invoice date or goods receipt date for agricultural procurement transactions.',
    `business_area_code` STRING COMMENT 'SAP business area code representing an organizational unit for which balance sheets and P&L statements can be drawn. Used to segment financial reporting across crop, livestock, and supply chain divisions.',
    `clearing_date` DATE COMMENT 'Date on which this open item was cleared (matched and offset) by a corresponding payment or contra-posting. Null for uncleared items. Used for aging analysis and cash flow reporting.',
    `clearing_document_number` STRING COMMENT 'Document number of the clearing transaction that offset this open item (e.g., payment clearing a vendor invoice, goods receipt clearing a GRN). Null if the line item is still open. Critical for AP/AR reconciliation and SOX audit trails.',
    `company_code_amount` DECIMAL(18,2) COMMENT 'Monetary amount of this line item translated into the company code (functional) currency. Used for consolidated financial reporting, EBITDA computation, and GAAP/IFRS statutory reporting.',
    `company_code_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code of the company code (legal entity) in which this posting is recorded. Typically the functional currency of the agricultural operating entity (e.g., USD for US operations).. Valid values are `^[A-Z]{3}$`',
    `controlling_area_code` STRING COMMENT 'SAP Controlling (CO) area code that groups company codes for management accounting purposes. Defines the scope of cost center and profit center hierarchies for consolidated agricultural enterprise reporting.',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this line item represents a debit (D) or credit (C) posting to the GL account. Fundamental to double-entry bookkeeping and ensures journal entry balance. Aligns with SAP FI posting key logic.. Valid values are `D|C`',
    `functional_area_code` STRING COMMENT 'SAP functional area code classifying the business function of this posting (e.g., production, administration, sales, research). Supports cost-of-sales accounting and segment reporting per IFRS 8 and GAAP ASC 280.',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'Monetary amount translated into the group (consolidation) currency for enterprise-wide consolidated financial statements. Supports IFRS 10 and GAAP ASC 810 consolidation reporting across global agricultural entities.',
    `line_item_status` STRING COMMENT 'Current processing status of this journal entry line item: open=uncleared open item, cleared=matched and offset, parked=saved but not posted, reversed=reversed by a subsequent document, blocked=payment block applied. Supports AP aging and SOX audit workflows.. Valid values are `open|cleared|parked|reversed|blocked`',
    `line_item_text` STRING COMMENT 'Descriptive text for this journal entry line item providing business context for the posting (e.g., Seed purchase - Corn Hybrid 2024, Fertilizer COGS allocation Q3). Supports audit trail and SOX documentation requirements.',
    `line_number` STRING COMMENT 'Sequential line item number within the parent journal entry, used to order and uniquely identify each posting line within a document. Satisfies TRANSACTION_LINE role LINE_SEQUENCE category requirement.',
    `payment_block_code` STRING COMMENT 'Code indicating a payment block applied to this line item preventing automatic payment processing (e.g., quality hold, dispute, manual review required). Used in agricultural AP workflows for invoice verification and HACCP-related quality disputes.',
    `plant_code` STRING COMMENT 'SAP plant code identifying the agricultural facility (farm, processing plant, storage facility, feedlot) associated with this posting. Enables plant-level cost tracking and operational financial reporting.',
    `posting_key` STRING COMMENT 'SAP posting key (two-digit code) that determines the account type, debit/credit indicator, and field selection for this line item (e.g., 40=GL debit, 50=GL credit, 31=vendor credit, 01=customer debit). Controls the accounting logic of the posting.',
    `quantity` DECIMAL(18,2) COMMENT 'Physical quantity associated with this line item posting (e.g., bushels of grain, metric tons of fertilizer, hundredweight of livestock). Supports quantity-based COGS allocation and commodity volume reconciliation. Satisfies TRANSACTION_LINE role LINE_QUANTITY category requirement.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the quantity field (e.g., BU=Bushel, MT=Metric Ton, CWT=Hundredweight, KG=Kilogram). Aligns with USDA standard agricultural units and SAP base unit of measure configuration. [ENUM-REF-CANDIDATE: BU|MT|CWT|KG|LB|EA|L|GAL|TON — 9 candidates stripped; promote to reference product]',
    `reference_document_number` STRING COMMENT 'External reference document number associated with this line item (e.g., vendor invoice number, purchase order number, GRN number, sales order number). Enables cross-system traceability between SAP FI and source operational documents.',
    `reversal_document_number` STRING COMMENT 'Document number of the reversing journal entry that cancelled this line item. Populated only when reversal_indicator is True. Provides the audit chain link required for SOX Section 302/404 compliance.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this line item has been reversed by a subsequent correcting journal entry. True if reversed; False if original and active. Supports SOX audit trail integrity and financial restatement tracking.',
    `segment_code` STRING COMMENT 'Reporting segment identifier for this posting, enabling disaggregated financial disclosures by operating segment (e.g., Crop Production, Livestock, Agri-Supply Chain). Required for IFRS 8 and GAAP ASC 280 segment reporting.',
    `source_system_code` STRING COMMENT 'Identifier of the originating system that generated this journal entry line (e.g., SAP_FI=SAP S/4HANA FI, NETSUITE=Oracle NetSuite, GRANULAR=Granular Farm Management, MANUAL=manual entry, INTERFACE=automated interface). Supports data lineage and SOX IT general controls.. Valid values are `SAP_FI|NETSUITE|GRANULAR|MANUAL|INTERFACE`',
    `special_gl_indicator` STRING COMMENT 'SAP Special GL indicator for non-standard postings such as down payments, guarantees, or bill of exchange transactions. Used in agricultural advance payment scenarios (e.g., prepaid seed contracts, crop advance payments).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Calculated tax amount in company code currency for this line item based on the assigned tax code. Used for VAT/GST reporting and tax liability reconciliation.',
    `tax_code` STRING COMMENT 'Tax code assigned to this line item, determining the applicable tax rate and tax account for VAT, GST, or sales tax calculations. Critical for tax compliance in multi-jurisdiction agricultural operations.',
    `transaction_currency_amount` DECIMAL(18,2) COMMENT 'Monetary amount of this line item expressed in the originating transaction currency. Represents the raw posting value before currency translation. Satisfies TRANSACTION_LINE role LINE_VALUE_OR_RESULT category requirement.',
    `transaction_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code of the originating transaction (e.g., USD, EUR, BRL). Used for multi-currency agricultural commodity trading and international supply chain transactions.. Valid values are `^[A-Z]{3}$`',
    `value_date` DATE COMMENT 'The bank value date for this posting, representing when funds are available or debited at the bank. Used for cash management, bank reconciliation, and liquidity planning in agricultural treasury operations.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual line items within a GL journal entry capturing debit/credit postings to specific GL accounts. Captures line item number, GL account, debit/credit indicator, amount in transaction currency, amount in company code currency, cost center, profit center, WBS element, tax code, assignment field, and line item text. Supports COGS allocation by commodity, crop enterprise cost tracking, and SOX-compliant audit trails.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` (
    `finance_ap_invoice_id` BIGINT COMMENT 'Unique surrogate identifier for the accounts payable invoice record in the finance domain silver layer. Primary key for this entity. Entity role: TRANSACTION_HEADER.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: finance_ap_invoice has company_code as a STRING. AP invoices belong to a specific legal entity. Normalizing to a proper FK ensures referential integrity and enables entity-level AP reporting and inter',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which this invoice is allocated. Supports COGS allocation by commodity, crop enterprise budget variance analysis, and CAPEX/OPEX tracking per SAP CO module.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: finance_ap_invoice has gl_account_code as a STRING. AP invoices are posted to specific GL accounts (accounts payable, expense accounts). Normalizing to a FK to gl_account links the invoice to the auth',
    `purchase_order_id` BIGINT COMMENT 'Reference to the originating purchase order record. Used for three-way match validation (PO/GRN/invoice) to confirm invoice legitimacy before payment. Critical for agricultural input procurement controls.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor (supplier) master record who issued this invoice. Links to the vendor/supplier master party entity for agricultural input suppliers (seed, fertilizer NPK, crop protection chemicals, feed, equipment parts). Supports PARTY_REFERENCE requirement for TRANSACTION_HEADER role.',
    `approval_status` STRING COMMENT 'Current status of the invoice in the approval workflow. pending = awaiting approver action; approved = authorized for payment; rejected = returned to AP team; escalated = routed to higher authority due to amount threshold or exception. Supports SOX segregation of duties controls.. Valid values are `pending|approved|rejected|escalated`',
    `approved_by` STRING COMMENT 'Name or user identifier of the person who approved this invoice in the workflow. Required for SOX audit trail and segregation of duties documentation. Sourced from SAP workflow approval log.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice was approved in the workflow. Supports SOX audit trail, SLA monitoring for invoice processing cycle time, and period-end close reporting.',
    `capex_opex_indicator` STRING COMMENT 'Classifies the invoice as a capital expenditure (CAPEX) or operational expenditure (OPEX). CAPEX invoices relate to long-term asset acquisition (equipment, infrastructure); OPEX invoices relate to recurring operational costs (inputs, services, maintenance). Critical for EBITDA reporting, ROI analysis, and GAAP/IFRS asset capitalization rules.. Valid values are `CAPEX|OPEX`',
    `commodity_category` STRING COMMENT 'Agricultural commodity or input category for this invoice. Enables COGS allocation by commodity, seasonal input cost tracking, and crop enterprise budget variance analysis. Categories align with core agricultural input types: seeds, fertilizers (NPK), crop protection chemicals, animal feed, equipment parts, agronomic services, fuel, and other. [ENUM-REF-CANDIDATE: seeds|fertilizers|crop_protection|feed|equipment_parts|services|fuel|other — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this AP invoice record was first created in the system. RECORD_AUDIT_CREATED for TRANSACTION_HEADER role. Supports SOX audit trail requirements and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the invoice amounts (e.g., USD, EUR, CAD). Part of the MONETARY_TRIPLET. Required for multi-currency operations in global agricultural supply chains. Corresponds to SAP field WAERS.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Cash discount amount available if payment is made within the early payment discount period as defined by payment terms. Supports working capital optimization and vendor discount capture reporting for agricultural input procurement.',
    `discount_due_date` DATE COMMENT 'Last date by which payment must be made to qualify for the early payment discount. Enables treasury teams to prioritize payments and capture available discounts on high-volume agricultural input invoices.',
    `due_date` DATE COMMENT 'Calculated date by which payment must be made to the vendor based on payment terms (e.g., Net 30, 2/10 Net 30). Critical for cash flow management, early payment discount capture, and avoiding late payment penalties on agricultural input purchases.',
    `fiscal_period` STRING COMMENT 'Accounting period (1-12 or 1-16 for special periods) within the fiscal year for this invoice posting. Supports monthly period-end close, seasonal input cost tracking, and crop enterprise budget variance analysis. Corresponds to SAP field MONAT.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this invoice is recorded for financial reporting purposes. Used for period-end close, annual budget variance analysis, and GAAP/IFRS consolidated financial statement preparation. Corresponds to SAP field GJAHR.',
    `grn_number` STRING COMMENT 'Reference number of the goods receipt note (GRN) confirming physical receipt of agricultural inputs (seeds, fertilizers, chemicals, feed, parts) at the warehouse or farm location. Key document in three-way match. Corresponds to SAP MIGO goods receipt document number.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before tax deductions. Part of the MONETARY_TRIPLET for TRANSACTION_HEADER role. Represents the full billed value for agricultural inputs (seeds, fertilizers NPK, crop protection chemicals, feed, equipment parts). Used for COGS allocation and crop enterprise budget variance analysis.',
    `invoice_date` DATE COMMENT 'The date printed on the vendors invoice document. Represents the BUSINESS_EVENT_TIMESTAMP (date precision) for the invoice issuance event. Used for payment terms calculation, aging analysis, and seasonal input cost tracking. Corresponds to SAP field BLDAT.',
    `invoice_line_count` STRING COMMENT 'Total number of line items on this invoice. Supports invoice complexity analysis, processing time benchmarking, and validation that all line-level detail records are present in the silver layer. Derived from the source system header record.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the AP invoice. LIFECYCLE_STATUS for TRANSACTION_HEADER role. draft = entered but not posted; posted = recorded in GL; approved = workflow approved; paid = payment cleared; blocked = payment block active; cancelled = reversed/voided.. Valid values are `draft|posted|approved|paid|blocked|cancelled`',
    `invoice_type` STRING COMMENT 'Classification of the invoice document type. standard = regular vendor invoice; credit_memo = vendor credit for returns/adjustments; debit_memo = additional charge; recurring = periodic service invoice; intercompany = between related legal entities. Corresponds to SAP field BLART.. Valid values are `standard|credit_memo|debit_memo|recurring|intercompany`',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this invoice is part of a recurring payment schedule (e.g., land lease payments, equipment rental, subscription services). Supports automated invoice matching and cash flow forecasting for seasonal agricultural operations.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net payable amount after tax adjustments (gross_amount minus tax_amount or as applicable per tax treatment). Part of the MONETARY_TRIPLET. Represents the actual cash outflow for payment processing and AP aging reports.',
    `payment_block_status` STRING COMMENT 'Indicates whether the invoice is blocked from payment and the reason. unblocked = cleared for payment; manual_block = manually held; quality_block = QM hold pending COA review; price_variance = unit price exceeds PO tolerance; duplicate_check = potential duplicate invoice detected. Corresponds to SAP field ZLSPR.. Valid values are `unblocked|manual_block|quality_block|price_variance|duplicate_check`',
    `payment_date` DATE COMMENT 'Actual date on which payment was made to the vendor. Used for AP aging analysis, on-time payment KPI reporting, and cash flow reconciliation. Populated upon payment clearing. Corresponds to SAP field AUGDT.',
    `payment_method` STRING COMMENT 'Method by which payment will be or was made to the vendor. Supports treasury operations, bank reconciliation, and payment run configuration. Corresponds to SAP field ZLSCH. Common methods for agricultural suppliers include ACH, wire transfer, check, and EFT.. Valid values are `ACH|wire|check|card|EFT`',
    `payment_reference` STRING COMMENT 'Reference number of the payment document (check number, ACH transaction ID, wire reference) that cleared this invoice. Populated after payment is executed. Used for bank reconciliation and vendor payment confirmation. Corresponds to SAP field AUGBL (clearing document).',
    `payment_terms_code` STRING COMMENT 'Vendor payment terms code defining the payment schedule and early payment discount conditions (e.g., NT30 = Net 30 days, 2/10NT30 = 2% discount if paid within 10 days, net 30). Drives due_date calculation and cash discount management. Corresponds to SAP field ZTERM.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the general ledger (GL). Determines the accounting period for GAAP/IFRS period-end close. May differ from invoice_date due to processing lag. Corresponds to SAP field BUDAT.',
    `sap_document_number` STRING COMMENT 'Internal SAP S/4HANA FI accounting document number assigned upon invoice posting. Used for cross-referencing with the general ledger and audit trail. Corresponds to SAP field BELNR in table BKPF.',
    `source_system` STRING COMMENT 'Originating operational system from which this AP invoice record was ingested into the Databricks silver layer. Supports data lineage, reconciliation between SAP S/4HANA FI and Oracle NetSuite AP, and audit trail for the lakehouse pipeline.. Valid values are `SAP_S4HANA|ORACLE_NETSUITE|GRANULAR|MANUAL`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice (e.g., sales tax, VAT, use tax). Part of the MONETARY_TRIPLET. Supports tax reporting, recoverability analysis, and GAAP/IFRS tax accounting. Corresponds to SAP field WMWST.',
    `tax_code` STRING COMMENT 'Tax determination code applied to the invoice for calculating applicable taxes (sales tax, VAT, use tax, agricultural exemptions). Corresponds to SAP field MWSKZ. Supports tax compliance reporting for EPA, USDA, and state agricultural tax exemption programs.',
    `three_way_match_status` STRING COMMENT 'Result of the three-way match validation comparing the purchase order (PO), goods receipt note (GRN), and vendor invoice. matched = all three documents align within tolerance; quantity_variance = invoice quantity differs from GRN; price_variance = invoice price differs from PO; grn_missing = goods receipt not yet recorded. Critical SOX control for agricultural input procurement.. Valid values are `pending|matched|quantity_variance|price_variance|grn_missing`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this AP invoice record. RECORD_AUDIT_UPDATED for TRANSACTION_HEADER role. Tracks changes for SOX compliance, workflow audit trail, and delta processing in the Databricks silver layer.',
    `vendor_invoice_number` STRING COMMENT 'The externally-assigned invoice number as printed on the vendors invoice document. Serves as the primary BUSINESS_IDENTIFIER for three-way match (PO/GRN/invoice) and vendor dispute resolution. Must be unique per vendor. Sourced from SAP S/4HANA FI document header field BELNR.',
    CONSTRAINT pk_finance_ap_invoice PRIMARY KEY(`finance_ap_invoice_id`)
) COMMENT 'Accounts payable invoice representing vendor invoices for agricultural inputs (seeds, fertilizers NPK, crop protection chemicals, feed, equipment parts) with embedded line-level detail. Header captures vendor invoice number, vendor ID, invoice date, posting date, payment terms, gross amount, tax amount, net amount, currency, payment block status, three-way match status (PO/GRN/invoice), and approval workflow status. Line-level detail captures material/service description, quantity, unit of measure (MT, BU, CWT), unit price, line amount, GL account assignment, cost center, purchase order reference, goods receipt reference (GRN), tax code, and commodity classification. Supports COGS allocation by commodity, crop enterprise budget variance analysis, and seasonal input cost tracking.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` (
    `ap_invoice_line_id` BIGINT COMMENT 'Unique surrogate identifier for each accounts payable invoice line item record in the silver layer lakehouse. Primary key for this entity. Entity role: TRANSACTION_LINE.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: AP invoice lines for grain purchases and commodity input procurement require commodity linkage for cost-of-production reporting, commodity-level spend analysis, and FSMA traceability. Ag procurement c',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which this invoice line expenditure is allocated, supporting crop enterprise budgeting and OPEX/CAPEX tracking. Maps to SAP CO cost center (KOSTL).',
    `field_id` BIGINT COMMENT 'Reference to the specific agricultural field or land parcel to which this invoice line expenditure is allocated, enabling field-level cost tracking, precision agriculture cost analysis, and GIS-based financial reporting.',
    `finance_ap_invoice_id` BIGINT COMMENT 'Foreign key reference to the parent AP invoice header record. Establishes the header-to-line relationship for this invoice line item. Satisfies TRANSACTION_LINE HEADER_REFERENCE category.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: ap_invoice_line has gl_account_code as a STRING. Each invoice line is posted to a specific GL account (expense, inventory, asset). Normalizing to a FK to gl_account links the line item to the authorit',
    `material_master_id` BIGINT COMMENT 'Reference to the material master or service catalog record for the agricultural input, commodity, or service being invoiced on this line. Satisfies TRANSACTION_LINE RESOURCE_REFERENCE category. Maps to SAP MM material master (MATNR).',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt note (GRN) record confirming physical receipt of agricultural inputs against which this invoice line is matched. Supports three-way matching and COGS allocation. Maps to SAP MIGO goods receipt document.',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order header associated with this invoice line, enabling three-way matching between PO, goods receipt, and invoice. Maps to SAP MM EKKO/EKPO purchase order.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_contract. Business justification: Individual AP invoice lines in agriculture reference contract lines for price compliance checking (e.g., verifying fertilizer invoice price matches contracted price tier). Supports contract compliance',
    `capex_opex_indicator` STRING COMMENT 'Indicates whether this invoice line represents a capital expenditure (CAPEX) for long-term asset investment or an operational expenditure (OPEX) for day-to-day farming operations. Critical for financial reporting, budgeting, and EBITDA calculation.. Valid values are `CAPEX|OPEX`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this AP invoice line record was first created in the source system, used for audit trail, SOX financial controls, and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `crop_season` STRING COMMENT 'The agricultural crop season or growing year to which this invoice line expenditure is attributed (e.g., 2024-Spring, 2024-Fall). Enables crop enterprise budgeting, seasonal COGS allocation, and year-over-year financial analysis.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the monetary amounts on this invoice line (e.g., USD, EUR, CAD). Supports multi-currency AP processing for international agricultural supply chain transactions.. Valid values are `^[A-Z]{3}$`',
    `delivery_date` DATE COMMENT 'The actual or expected date on which the agricultural inputs or services on this invoice line were delivered or performed. Used for accrual accounting, crop season alignment, and PHI/REI compliance tracking for agrochemicals.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary discount applied to this invoice line as negotiated with the vendor (e.g., volume rebate, early payment discount, seasonal pricing). Reduces the net payable amount for this line.',
    `gmo_indicator` BOOLEAN COMMENT 'Indicates whether the agricultural input on this invoice line contains or is derived from genetically modified organisms (GMO). Required for COOL (Country of Origin Labeling), USDA NOP organic certification compliance, and customer transparency reporting.',
    `line_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of this invoice line before tax and discounts, calculated as quantity multiplied by unit price. Satisfies TRANSACTION_LINE LINE_VALUE_OR_RESULT category. Maps to SAP RSEG-WRBTR (line item amount in document currency).',
    `line_number` STRING COMMENT 'Sequential line item number within the parent AP invoice, used to order and uniquely identify each line within the invoice. Satisfies TRANSACTION_LINE LINE_SEQUENCE category. Corresponds to SAP RSEG-BUZEI (line item number).',
    `line_status` STRING COMMENT 'Current processing status of this AP invoice line within the accounts payable workflow. open = awaiting posting; posted = GL entry created; blocked = held for review (e.g., price variance); reversed = accounting reversal applied; cancelled = line voided; parked = saved but not yet posted. Maps to SAP FI document status.. Valid values are `open|posted|blocked|reversed|cancelled|parked`',
    `lot_number` STRING COMMENT 'The batch or lot number (LOT) of the agricultural input (seed, fertilizer, pesticide) on this invoice line, enabling traceability from purchase through application for FSMA compliance, MRL tracking, and food safety audit trails.',
    `matching_status` STRING COMMENT 'Status of the three-way matching process (PO, GRN, Invoice) for this line item. unmatched = no match yet; po_matched = matched to PO only; grn_matched = matched to GRN only; three_way_matched = fully matched; exception = variance requiring resolution. Critical for SOX controls.. Valid values are `unmatched|po_matched|grn_matched|three_way_matched|exception`',
    `net_amount` DECIMAL(18,2) COMMENT 'The net payable amount for this invoice line after applying discounts and before tax (line_amount minus discount_amount). Used for COGS allocation, crop enterprise budgeting, and EBITDA reporting.',
    `po_line_number` STRING COMMENT 'The specific line item number on the referenced purchase order that corresponds to this invoice line, enabling precise PO-to-invoice line matching. Maps to SAP EKPO-EBELP.',
    `price_variance_amount` DECIMAL(18,2) COMMENT 'The monetary difference between the invoiced unit price and the purchase order unit price for this line, used to identify and resolve invoice discrepancies. A non-zero value triggers the matching exception workflow. Maps to SAP MM invoice verification price variance.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the material or service invoiced on this line. Satisfies TRANSACTION_LINE LINE_QUANTITY category. Used in conjunction with unit_of_measure for volume-based COGS allocation and three-way matching against GRN quantity.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'The difference between the invoiced quantity and the goods receipt quantity for this line, used to identify over- or under-billing by vendors. Supports three-way matching exception management and vendor performance tracking.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this invoice line was ingested into the lakehouse silver layer (e.g., SAP_S4HANA for FI-AP module, ORACLE_NETSUITE for NetSuite AP, GRANULAR for Granular Farm Management). Supports data lineage and reconciliation.. Valid values are `SAP_S4HANA|ORACLE_NETSUITE|GRANULAR|MANUAL`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount applicable to this invoice line, including sales tax, VAT, or use tax as applicable by jurisdiction. Used for tax reporting and accounts payable accruals.',
    `tax_code` STRING COMMENT 'The tax determination code applied to this invoice line, identifying the applicable tax rate and jurisdiction rules (e.g., V1 for input VAT, U1 for use tax). Maps to SAP FI MWSKZ tax code.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the invoiced quantity, using standard agricultural units: MT (Metric Ton), BU (Bushel), CWT (Hundredweight), KG (Kilogram), LB (Pound), L (Liter), GAL (Gallon), EA (Each), HR (Hour), AC (Acre). Maps to SAP MEINS base unit of measure. [ENUM-REF-CANDIDATE: MT|BU|CWT|KG|LB|L|GAL|EA|HR|AC — 10 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'The agreed price per unit of measure for the material or service on this invoice line, as stated by the vendor. Used for price variance analysis against PO unit price and market benchmarks (DTN/WASDE). Maps to SAP RSEG-WRBTR / quantity.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this AP invoice line record in the source system, supporting change tracking, SOX audit controls, and incremental data loading in the lakehouse pipeline. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `wbs_element` STRING COMMENT 'The WBS element code for CAPEX project cost tracking, used when the invoice line relates to capital expenditure on agricultural infrastructure, equipment, or land improvements. Maps to SAP PS POSID.',
    CONSTRAINT pk_ap_invoice_line PRIMARY KEY(`ap_invoice_line_id`)
) COMMENT 'Line-level detail for accounts payable invoices capturing individual line items for agricultural input purchases. Captures line number, material/service description, quantity, unit of measure (MT, BU, CWT), unit price, line amount, GL account assignment, cost center, purchase order reference, goods receipt reference (GRN), tax code, and commodity classification. Supports COGS allocation by commodity and crop enterprise budgeting.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'Primary key for ap_payment',
    `bank_account_id` BIGINT COMMENT 'Internal identifier of the companys house bank account from which the payment was disbursed. References the SAP house bank/account ID configuration. Supports bank account-level cash position monitoring and liquidity management.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: ap_payment has company_code as a STRING. Payments are made by a specific legal entity. Normalizing to a proper FK ensures referential integrity and enables entity-level payment reporting and cash flow',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which this payment is allocated for management accounting and CAPEX/OPEX tracking. Supports COGS allocation by commodity and crop enterprise budgeting.',
    `finance_ap_invoice_id` BIGINT COMMENT 'Reference to the primary cleared accounts payable invoice that this payment settles. Supports invoice-to-payment matching and reconciliation for agricultural input purchases.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: ap_payment has gl_account_code as a STRING. Payment transactions are posted to specific GL accounts (bank clearing accounts, AP accounts). Normalizing to a FK to gl_account links the payment to the au',
    `payment_run_id` BIGINT COMMENT 'Reference to the automated payment run batch that generated this disbursement. SAP F110 payment run identifier used to group payments executed in the same batch cycle, supporting seasonal payment cycles aligned with planting and harvest.',
    `procurement_goods_receipt_id` BIGINT COMMENT 'FK to procurement.procurement_goods_receipt',
    `purchase_order_id` BIGINT COMMENT 'FK to procurement.purchase_order',
    `vendor_id` BIGINT COMMENT 'Reference to the agricultural input supplier or service vendor receiving this payment. Links to the vendor master record for supplier identity, banking details, and payment terms.',
    `approved_by` STRING COMMENT 'User ID or name of the financial controller or AP manager who approved this payment for disbursement. Required for SOX dual-control and segregation of duties compliance. Supports payment authorization audit trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was formally approved by the authorized approver. Provides SOX-compliant audit trail for payment authorization and segregation of duties controls.',
    `bank_clearing_date` DATE COMMENT 'Date on which the bank confirmed the payment as cleared in the bank statement. Used for bank reconciliation, outstanding check tracking, and cash flow actuals reporting.',
    `bank_clearing_status` STRING COMMENT 'Status of the payment as reported by the bank clearing system. Indicates whether the payment has been confirmed as cleared by the bank, returned (e.g., invalid account), or rejected. Drives bank reconciliation and outstanding payment follow-up.. Valid values are `uncleared|cleared|returned|rejected`',
    `check_number` STRING COMMENT 'Physical check number assigned when payment method is CHECK. Used for check register management, positive pay file submission to the bank, and outstanding check reconciliation. Null for electronic payment methods (ACH, WIRE, EFT).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment record was first created in the financial system. Provides audit trail for record origination and supports SOX financial reporting controls.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction currency of this payment (e.g., USD for domestic, EUR for European suppliers, BRL for Brazilian commodity purchases). Supports multi-currency AP management for global agricultural supply chain.. Valid values are `^[A-Z]{3}$`',
    `discount_taken_amount` DECIMAL(18,2) COMMENT 'Early payment discount amount deducted from the invoice total at time of payment. Reflects early-pay discount optimization for agricultural input purchases (e.g., seed, fertilizer, crop protection chemicals). Reduces COGS and improves ROI.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign currency exchange rate applied at the time of payment to convert the transaction currency to the company code local currency (USD). Used for foreign currency gain/loss calculation and IFRS IAS 21 compliance reporting.',
    `fiscal_period` STRING COMMENT 'Fiscal accounting period (1-12 or 1-16 for special periods) within the fiscal year in which this payment is posted. Used for period-level cash flow reporting, EBITDA analysis, and month-end close reconciliation.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this payment is recorded for financial reporting purposes. Agricultural businesses may use non-calendar fiscal years aligned with growing seasons. Required for period-end close, GAAP/IFRS consolidated statements, and SOX financial controls.',
    `invoice_count` STRING COMMENT 'Number of individual invoices cleared by this single payment transaction. Supports partial vs. full payment analysis and multi-invoice payment run reconciliation for bulk agricultural input purchases.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Payment amount converted to the company code local currency (USD) using the exchange_rate at time of payment. Used for consolidated financial statements, EBITDA reporting, and GAAP/IFRS compliance.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'Actual net amount remitted to the vendor after deducting any early payment discount taken. Equals payment_amount minus discount_taken_amount. Represents the true cash disbursement recorded in the bank statement.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Gross payment amount disbursed to the vendor in the transaction currency before any discount deduction. Represents the total cash outflow for this payment event. Used for cash flow management and EBITDA reporting.',
    `payment_block_reason` STRING COMMENT 'Reason code indicating why a payment is blocked from processing (e.g., invoice dispute, missing COA, quality hold, vendor master incomplete). Null when payment is not blocked. Supports AP workflow management and vendor dispute resolution.',
    `payment_date` DATE COMMENT 'The actual business date on which the payment was issued or disbursed to the vendor. Used for cash flow reporting, early-pay discount optimization, and seasonal payment cycle analysis aligned with planting and harvest periods.',
    `payment_document_number` STRING COMMENT 'Externally-known payment document number assigned by the financial system (SAP FI or Oracle NetSuite) at the time of payment posting. Used for audit trails, bank reconciliation, and vendor remittance communication.',
    `payment_method` STRING COMMENT 'The payment instrument used to disburse funds to the vendor. ACH (Automated Clearing House) is common for domestic agricultural input suppliers; WIRE for international commodity purchases; CHECK for smaller vendors. Supports payment method analysis and bank fee optimization.. Valid values are `ACH|WIRE|CHECK|EFT|CARD`',
    `payment_notes` STRING COMMENT 'Free-text notes or comments entered by AP staff regarding this payment transaction. May include vendor communication details, dispute context, seasonal payment cycle notes, or special handling instructions for agricultural input suppliers.',
    `payment_reference` STRING COMMENT 'External payment reference number transmitted to the bank and included in the remittance advice to the vendor. For ACH payments, this is the transaction reference in the NACHA file. Enables vendor-side payment matching and dispute resolution.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Tracks progression from initiation through bank clearing or return/void. Supports cash flow management and bank reconciliation workflows.. Valid values are `initiated|approved|sent|cleared|returned|voided`',
    `payment_type` STRING COMMENT 'Classification of the payment transaction type. Advance payments are common for seed and input purchases ahead of planting season. Partial payments occur for large equipment or land lease transactions. Supports cash flow forecasting and working capital analysis.. Valid values are `standard|advance|partial|final|void_replacement`',
    `posting_date` DATE COMMENT 'The accounting posting date on which the payment is recorded in the general ledger. Determines the fiscal period for financial reporting and GAAP/IFRS period-end close.',
    `remittance_advice_sent` BOOLEAN COMMENT 'Indicates whether a remittance advice notification has been sent to the vendor detailing the invoices cleared by this payment. Supports vendor communication workflows and dispute prevention for agricultural input suppliers.',
    `remittance_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the remittance advice was transmitted to the vendor. Provides audit trail for vendor communication and supports SLA tracking for payment notification.',
    `source_system` STRING COMMENT 'Identifier of the operational system of record from which this payment record originated. Supports data lineage tracking in the Databricks Silver Layer and multi-system reconciliation between SAP S/4HANA FI and Oracle NetSuite AP.. Valid values are `SAP_S4HANA|ORACLE_NETSUITE|GRANULAR`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payment record was last modified in the financial system. Tracks changes to payment status, clearing date, or bank confirmation. Supports data lineage and SOX audit trail requirements.',
    `value_date` DATE COMMENT 'The bank value date on which funds are credited to the vendors account. May differ from payment_date due to bank processing float. Critical for accurate cash position reporting and bank statement reconciliation.',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Accounts payable payment transaction recording actual disbursements to agricultural input suppliers and service vendors. Captures payment document number, vendor ID, payment date, payment method (ACH, wire, check), bank account, payment amount, currency, cleared invoice references, discount taken, payment run ID, and bank clearing status. Supports seasonal payment cycles aligned with planting and harvest, early-pay discount optimization for input purchases, and cash flow management.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` (
    `crop_enterprise_budget_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying a crop enterprise budget record. Primary key for this entity. Role: TRANSACTION_HEADER.',
    `carbon_footprint_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_footprint. Business justification: Carbon-adjusted crop budgeting is a standard practice in regenerative agriculture finance. Linking crop_enterprise_budget to carbon_footprint enables carbon cost/benefit analysis per crop season, requ',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Enterprise budgets in ag are built per commodity (corn, soybeans, wheat). Linking to commodity enables benchmark price lookups, standard yield comparisons, MRL/grade standard references, and commodity',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: crop_enterprise_budget is a financial planning record that must be associated with a legal entity (company code) for GAAP/IFRS compliance and consolidated financial reporting. No company_code string c',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: crop_enterprise_budget has cost_center_code as a STRING. Normalizing to a FK to cost_center links the crop budget to the organizational unit responsible for the farming operation, enabling cost center',
    `farm_unit_id` BIGINT COMMENT 'Reference to the farm or agricultural business unit for which this crop enterprise budget is prepared. Serves as the PARTY_REFERENCE (organizational unit) for the TRANSACTION_HEADER role. Links to the farm/cost center hierarchy in SAP S/4HANA CO and Granular Farm Management.',
    `field_id` BIGINT COMMENT 'Reference to the specific agricultural field or land parcel for which this crop enterprise budget is prepared. Enables field-level financial performance tracking, break-even analysis per acre, and integration with John Deere Operations Center field mapping and Esri ArcGIS land records.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: crop_enterprise_budget has gl_account_code as a STRING. Normalizing to a FK to gl_account links the budget to the authoritative GL account, enabling proper financial statement mapping of crop enterpri',
    `seed_variety_id` BIGINT COMMENT 'Foreign key linking to product.seed_variety. Business justification: Ag enterprise budgets are built for specific seed varieties (e.g., trait packages affect input costs, yield potential affects revenue). Linking seed_variety_id enables yield potential-based revenue mo',
    `sustainability_certification_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_certification. Business justification: Certified crop budgets (organic, GlobalG.A.P.) carry premium price assumptions in planned_price_per_unit and planned_revenue_per_ha. Agriculture financial planners must link budgets to the certificati',
    `approval_status` STRING COMMENT 'Current approval workflow status of the crop enterprise budget. Tracks the authorization state separate from the overall budget lifecycle status. Required for SOX financial controls — budgets must be approved before costs can be committed against them.. Valid values are `pending|approved|rejected|escalated`',
    `approved_by` STRING COMMENT 'Name or employee identifier of the individual who approved this crop enterprise budget. Required for SOX audit trail and financial controls documentation. Captured from SAP S/4HANA workflow or SAP SuccessFactors HR records.',
    `approved_date` DATE COMMENT 'Date on which this crop enterprise budget received formal approval. Establishes the authorization date for SOX financial controls and triggers the budget activation in SAP S/4HANA CO for cost commitment tracking.',
    `breakeven_price_per_unit` DECIMAL(18,2) COMMENT 'Minimum commodity price per unit required to cover all planned production costs (planned total cost ÷ planned total yield). Critical decision-support metric for marketing strategy, forward contract pricing, and crop insurance coverage level selection.',
    `budget_area_acres` DECIMAL(18,2) COMMENT 'Total planned planted area in acres for this crop enterprise budget. US-standard unit used alongside hectares for domestic reporting, USDA FSA program compliance, and land rent calculations expressed per acre.',
    `budget_area_ha` DECIMAL(18,2) COMMENT 'Total planned planted area in hectares (ha) for this crop enterprise budget. Used as the denominator for per-hectare cost and revenue calculations, break-even analysis, and ROI reporting. Aligns with field area records in Esri ArcGIS and John Deere Operations Center.',
    `budget_date` DATE COMMENT 'The principal business event date on which this crop enterprise budget was formally established or initiated. Represents the BUSINESS_EVENT_TIMESTAMP (date precision) for the budget creation event, distinct from system audit timestamps. Used for period alignment in financial reporting.',
    `budget_number` STRING COMMENT 'Externally-known alphanumeric identifier for the crop enterprise budget, used in financial planning documents, SAP CO cost object references, and Granular Farm Management records. Serves as the BUSINESS_IDENTIFIER for cross-system traceability.. Valid values are `^CEB-[0-9]{4}-[A-Z0-9]{6,12}$`',
    `budget_status` STRING COMMENT 'Current lifecycle state of the crop enterprise budget. Drives approval workflow and financial reporting inclusion. Draft = in preparation; Submitted = pending approval; Approved = authorized for use; Revised = updated post-approval; Final = locked for period close; Cancelled = voided. LIFECYCLE_STATUS for TRANSACTION_HEADER role.. Valid values are `draft|submitted|approved|revised|final|cancelled`',
    `budget_version` STRING COMMENT 'Version classification of the crop enterprise budget indicating whether it represents the original plan, a mid-season revision, or the final locked version. Supports variance analysis between original and revised plans per GAAP budgetary control requirements.. Valid values are `original|revised|final`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this crop enterprise budget record was first created in the data platform. Supports RECORD_AUDIT_CREATED requirement for TRANSACTION_HEADER role. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `crop_insurance_cost_per_ha` DECIMAL(18,2) COMMENT 'Planned crop insurance premium cost per hectare included in this enterprise budget. Reflects USDA Risk Management Agency (RMA) policy premiums for revenue protection or yield protection coverage. Confidential as it reflects risk management strategy.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this crop enterprise budget (e.g., USD, EUR, BRL). Required for GAAP/IFRS consolidated financial statement preparation and multi-currency reporting in SAP S/4HANA FI.. Valid values are `^[A-Z]{3}$`',
    `fiscal_period` STRING COMMENT 'Fiscal period (quarter or posting period) within the fiscal year to which this budget is aligned (e.g., Q1, Q2, P01–P12). Supports sub-annual budget phasing, cash flow planning, and SAP S/4HANA CO period-based cost allocation.. Valid values are `^(Q[1-4]|P(0[1-9]|1[0-2]))$`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this crop enterprise budget belongs. Used for period-based financial reporting, year-over-year variance analysis, and alignment with SAP S/4HANA FI fiscal year variants and Oracle NetSuite accounting periods.',
    `government_program_payment_per_ha` DECIMAL(18,2) COMMENT 'Planned government program payment per hectare expected to be received (e.g., USDA ARC/PLC payments, conservation program payments). Included as a revenue offset in the enterprise budget for accurate net income projection.',
    `harvest_end_date` DATE COMMENT 'Planned date by which harvest operations are expected to be completed for this crop enterprise. Drives revenue recognition timing, post-harvest handling cost planning, and storage/logistics scheduling in the supply chain.',
    `is_gmo` BOOLEAN COMMENT 'Indicates whether the budgeted crop variety is a Genetically Modified Organism (GMO). Affects seed cost tiers, technology trait fees, export market eligibility, and COOL labeling compliance requirements.',
    `land_rent_per_ha` DECIMAL(18,2) COMMENT 'Planned cash land rent cost per hectare included in this crop enterprise budget. One of the largest variable cost components in crop production. Confidential as it reflects negotiated lease terms. Used for land cost benchmarking and lease vs. own analysis.',
    `notes` STRING COMMENT 'Free-text field for agronomic, financial, or operational notes associated with this crop enterprise budget. Captures assumptions, risk factors, revision rationale, or special conditions (e.g., drought risk, market volatility, new variety trial). Supports audit documentation and management commentary.',
    `planned_cost_per_ha` DECIMAL(18,2) COMMENT 'Total planned cost of production per hectare. Key benchmark metric for comparing production efficiency across fields, farms, and seasons. Used in break-even price calculations and OPEX benchmarking against industry standards.',
    `planned_net_income` DECIMAL(18,2) COMMENT 'Planned net income for the crop enterprise calculated as planned total revenue minus planned total cost. Primary profitability metric for crop enterprise budgeting, ROI analysis, and lender/investor reporting. Confidential as it reflects forward financial projections.',
    `planned_price_per_unit` DECIMAL(18,2) COMMENT 'Budgeted commodity selling price per unit of measure used to calculate planned revenue. Typically derived from forward contract prices, DTN market data, or WASDE price projections. Confidential as it reflects pricing strategy and forward market positions.',
    `planned_revenue_per_ha` DECIMAL(18,2) COMMENT 'Total planned gross revenue per hectare calculated as planned yield per hectare multiplied by planned price per unit. Core metric for crop enterprise profitability analysis, break-even determination, and ROI reporting. Confidential as it reflects forward pricing strategy.',
    `planned_total_cost` DECIMAL(18,2) COMMENT 'Total planned cost of production for the entire budgeted area, aggregating all cost line items (seed, fertilizer NPK, crop protection, labor, equipment, irrigation, land rent, crop insurance, custom hire). Used for COGS allocation, break-even analysis, and EBITDA reporting.',
    `planned_total_revenue` DECIMAL(18,2) COMMENT 'Total planned gross revenue for the entire budgeted area (planned revenue per hectare × budget area). Represents the gross income line in the crop enterprise budget P&L. Used for EBITDA projection and SAP S/4HANA CO profitability analysis. Confidential as it reflects forward pricing.',
    `planned_yield_per_ha` DECIMAL(18,2) COMMENT 'Expected crop yield per hectare (ha) used as the basis for revenue projections in this enterprise budget. Expressed in the commoditys standard unit of measure (e.g., MT/ha for grains, BU/ha for corn). Derived from historical yield records, NDVI analysis, and agronomic models.',
    `planting_start_date` DATE COMMENT 'Planned date on which planting operations are scheduled to begin for this crop enterprise. Used for cash flow timing, input procurement scheduling, and integration with Climate FieldView and Trimble Ag Software planting plans.',
    `profit_center_code` STRING COMMENT 'SAP S/4HANA CO profit center code associated with this crop enterprise budget. Enables profitability analysis by crop enterprise, farm unit, or geographic segment for management reporting and EBITDA calculation.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this crop enterprise budget record was last modified. Supports RECORD_AUDIT_UPDATED requirement for TRANSACTION_HEADER role. Used for change tracking and SOX audit trail compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `yield_uom` STRING COMMENT 'Unit of measure for yield quantities in this budget (e.g., MT = Metric Ton, BU = Bushel, CWT = Hundredweight). Ensures consistent interpretation of planned and actual yield figures across commodity types and reporting systems.. Valid values are `MT|BU|CWT|KG|LB|TON`',
    CONSTRAINT pk_crop_enterprise_budget PRIMARY KEY(`crop_enterprise_budget_id`)
) COMMENT 'Crop enterprise budget master with embedded line-level detail representing planned financial performance for a specific crop, field, and growing season. Header captures budget ID, crop type, field/farm unit, growing season, budget version (original, revised, final), planned revenue per acre/hectare, planned yield, planned price per unit, and approval status. Line-level detail captures individual cost and revenue categories (seed, fertilizer NPK, crop protection, custom hire, labor, equipment, irrigation, land rent, crop insurance, revenue) with planned quantity, unit cost, planned total, actual amount, and variance. Core to agricultural financial planning, break-even analysis, and ROI analysis per crop enterprise.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`capital_project` (
    `capital_project_id` BIGINT COMMENT 'Primary key for capital_project',
    `employee_id` BIGINT COMMENT 'Employee identifier of the final approval authority who authorized the project. Supports SOX segregation of duties controls and audit trail documentation.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: capital_project has company_code as a STRING column. Normalizing to a proper FK to company_code ensures referential integrity and links capital projects to the correct legal entity. The string column ',
    `farm_unit_id` BIGINT COMMENT 'Foreign key linking to land.farm_unit. Business justification: Capital projects are budgeted and approved at the farm unit level for FSA reporting and farm-level financial planning. farm_unit_code is a denormalized text reference to the farm unit. A proper FK ena',
    `field_id` BIGINT COMMENT 'Foreign key linking to land.field. Business justification: Capital projects for irrigation installation, drainage tile, land leveling, and grain storage are executed on specific fields. Field-level capex tracking enables ROI analysis by field, supports crop e',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: capital_project has gl_account_code as a STRING. Normalizing to a FK to gl_account links the capital project to the authoritative GL chart of accounts, enabling proper financial reporting and CAPEX ac',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_initiative. Business justification: Capital projects for irrigation upgrades, renewable energy, or precision agriculture are directly linked to sustainability initiatives. Agriculture CFOs track capex ROI alongside emission reduction ta',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to the specific compliance obligation that this capital project must satisfy.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Agriculture capital projects (new facilities, irrigation expansion, CAFO construction) require permits before construction and operation. Linking capex requests to required permits enables permit-gate',
    `primary_capital_requestor_employee_id` BIGINT COMMENT 'Employee identifier of the person who submitted the capital/operational project request. Used for approval workflow routing, accountability tracking, and SOX audit trail.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: capital_project has requesting_cost_center_code as a STRING. Normalizing to a FK to cost_center establishes proper referential integrity linking the capital project to the organizational unit requesti',
    `actual_completion_date` DATE COMMENT 'Actual calendar date on which the project was completed and closed. Used for variance analysis against planned completion date and to trigger asset capitalization or cost settlement in SAP.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Total actual costs incurred and posted to the project (WBS element or internal order) to date, sourced from SAP CO actual cost postings. Used for budget vs. actual variance reporting and CAPEX/OPEX tracking.',
    `approval_date` DATE COMMENT 'Calendar date on which the final approval authority granted authorization for the project. Marks the point at which budget commitment is authorized and procurement activities may commence.',
    `approval_status` STRING COMMENT 'Current state of the multi-level approval workflow for this request, distinct from overall project status. Tracks whether the financial authorization has been granted, is pending, or has been rejected at any approval tier. Supports SOX financial controls documentation.. Valid values are `pending|approved|conditionally_approved|rejected|escalated`',
    `approved_amount` DECIMAL(18,2) COMMENT 'Total amount formally approved by the authorization hierarchy for this project. May differ from estimated cost if the approval was conditional or partially approved. Drives budget availability checks in SAP.',
    `asset_class_code` STRING COMMENT 'SAP Asset Accounting (AA) asset class code that determines the depreciation key, useful life, and balance sheet account for the resulting fixed asset (e.g., machinery, buildings, land improvements, IT equipment). Applicable for CAPEX projects only.',
    `assigned_date` DATE COMMENT 'The date on which this compliance obligation was formally assigned to or identified for this capital project. Supports audit trail and compliance program management.',
    `budget_fiscal_year` STRING COMMENT 'The fiscal year in which the project budget is allocated and tracked (e.g., 2024). Used for annual capital planning, CAPEX/OPEX budget cycle management, and year-end financial reporting.',
    `business_justification` STRING COMMENT 'Narrative business case explaining why the project is necessary, including operational need, regulatory compliance requirement, productivity improvement, or strategic alignment. Required for SOX approval documentation and audit trail.',
    `committed_cost_amount` DECIMAL(18,2) COMMENT 'Total value of purchase orders and contracts committed against this project but not yet invoiced or goods-receipted. Represents financial obligations that reduce available budget. Sourced from SAP MM commitment management.',
    `compliance_deadline` DATE COMMENT 'The deadline by which this compliance obligation must be satisfied in the context of this specific capital projects timeline. Distinct from the obligations general due_date on compliance_obligation, as project-specific deadlines are driven by project phase gates, permit submission windows, and regulatory review timelines. Sourced from detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital project request record was first created in the system. Supports audit trail, SOX documentation, and data lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this project record (e.g., USD, EUR, BRL). Ensures consistent multi-currency financial reporting and IFRS compliance.. Valid values are `^[A-Z]{3}$`',
    `depreciation_key` STRING COMMENT 'SAP FI-AA depreciation key code that defines the depreciation method (e.g., straight-line, declining balance) and calculation rules for the resulting fixed asset. Applicable for CAPEX projects only.',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Total estimated cost of the project at the time of request submission, in the company code currency. Serves as the baseline for budget vs. actual variance analysis and ROI calculation.',
    `estimated_cost_impact` DECIMAL(18,2) COMMENT 'The estimated monetary cost impact of satisfying this compliance obligation on this specific capital project. Belongs to the project-obligation pairing, not to either entity alone — the same obligation may have different cost impacts on different projects depending on project scope and scale. Sourced from detection phase relationship data.',
    `expenditure_category` STRING COMMENT 'Classifies the request as a Capital Expenditure (CAPEX) — assets that are capitalized on the balance sheet per GAAP/IFRS — or Operational Expenditure (OPEX) — costs expensed in the current period. Drives accounting treatment, depreciation scheduling, and financial reporting.. Valid values are `CAPEX|OPEX`',
    `fulfillment_status` STRING COMMENT 'The fulfillment status of this compliance obligation specifically for this capital project. Distinct from the obligations overall fulfillment_status on compliance_obligation, as the same obligation may be fulfilled for one project but still pending for another.',
    `funding_source` STRING COMMENT 'Identifies the source of funds for the project (e.g., operating_budget, capital_budget, external_loan, government_grant such as USDA FSA programs, equipment_financing). Drives treasury and debt management reporting. [ENUM-REF-CANDIDATE: operating_budget|capital_budget|external_loan|government_grant|equipment_financing|internal_transfer|other — promote to reference product]',
    `internal_order_number` STRING COMMENT 'SAP CO internal order number used for cost collection on smaller CAPEX/OPEX projects that do not warrant a full WBS structure. Enables cost monitoring and settlement to fixed assets or cost centers.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the capital project request record. Used for incremental data loading, change tracking, and SOX audit trail in the Databricks Silver Layer.',
    `obligation_type` STRING COMMENT 'The type of compliance obligation as it applies to this specific capital project context. Sourced from detection phase relationship data. Allows filtering and reporting of compliance obligations by type across the project portfolio.',
    `payback_period_months` STRING COMMENT 'Estimated number of months required to recover the initial capital investment through cost savings or incremental revenue. Used alongside ROI for capital project prioritization and approval scoring.',
    `planned_completion_date` DATE COMMENT 'Planned calendar date for project completion and asset capitalization or cost settlement. Used for depreciation start date planning and project milestone tracking.',
    `planned_start_date` DATE COMMENT 'Planned calendar date for commencement of project activities (e.g., equipment delivery, construction groundbreaking, field renovation start). Used for project scheduling and seasonal agricultural planning alignment.',
    `priority_level` STRING COMMENT 'Business-assigned priority ranking for the project request, used to sequence approvals and allocate budget during capital planning cycles. Critical typically indicates regulatory compliance or safety-driven requirements.. Valid values are `critical|high|medium|low`',
    `profit_center_code` STRING COMMENT 'SAP CO profit center associated with the project, enabling profitability analysis by commodity, farm unit, or business segment. Supports EBITDA and ROI reporting at the profit center level.',
    `project_description` STRING COMMENT 'Detailed narrative describing the scope, objectives, and deliverables of the capital or operational project. Supports business justification review and SOX documentation requirements.',
    `project_phase` STRING COMMENT 'The phase of the capital project during which this compliance obligation must be satisfied. A single project may have obligations in multiple phases (e.g., wetland determination in pre-construction, stormwater inspection during construction, final environmental sign-off at post-completion). Sourced from detection phase relationship data.',
    `project_status` STRING COMMENT 'Current lifecycle state of the capital/operational project request through the approval and execution workflow. Drives SOX approval controls and project cost collection gating. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|in_progress|on_hold|completed|cancelled — promote to reference product]',
    `project_title` STRING COMMENT 'Short, descriptive title of the capital or operational project (e.g., Center-Pivot Irrigation System Upgrade – Farm Unit 7, New Grain Storage Facility – Elevator 3). Used in approval workflows and executive reporting.',
    `project_type` STRING COMMENT 'Categorizes the nature of the investment (e.g., equipment_purchase for tractors/combines, land_improvement for drainage/terracing, facility_construction for grain elevators/storage, technology_infrastructure for FMIS/IoT/GPS systems, crop_trial for R&D field trials). [ENUM-REF-CANDIDATE: equipment_purchase|land_improvement|facility_construction|technology_infrastructure|field_renovation|crop_trial|irrigation_system|marketing_campaign|vehicle_fleet|other — promote to reference product]',
    `request_date` DATE COMMENT 'Calendar date on which the capital or operational project request was formally submitted by the requesting cost center. Serves as the business event date for the request lifecycle.',
    `request_number` STRING COMMENT 'Externally-visible, human-readable request number assigned at submission (e.g., CAPEX-2024-00123 or OPEX-2024-00456). Used for cross-system reference in SAP S/4HANA IM (Investment Management) and Oracle NetSuite project modules.. Valid values are `^CAPEX-[0-9]{4}-[0-9]{5}$|^OPEX-[0-9]{4}-[0-9]{5}$`',
    `roi_percentage` DECIMAL(18,2) COMMENT 'Projected Return on Investment (ROI) percentage calculated at the time of request submission, based on estimated cost savings, yield improvements, or revenue generation. Supports capital allocation decision-making and post-implementation review.',
    `settlement_rule` STRING COMMENT 'Defines how accumulated project costs are settled at project completion in SAP CO/PS — either capitalized to a fixed asset (asset_under_construction → final asset), settled to a cost center, or posted to a GL account. Critical for correct CAPEX capitalization and OPEX expensing.. Valid values are `asset_under_construction|cost_center|gl_account|profit_center|wbs_element`',
    `sox_control_relevant` BOOLEAN COMMENT 'Indicates whether this project is subject to SOX internal control over financial reporting (ICFR) requirements. True for projects above the materiality threshold or involving significant asset capitalization. Drives mandatory dual-approval and documentation requirements.',
    `useful_life_years` STRING COMMENT 'Estimated useful economic life of the asset or improvement in years, used to determine the depreciation schedule in SAP FI-AA. Applicable for CAPEX projects. Aligns with GAAP ASC 360 and IFRS IAS 16 depreciation requirements.',
    `wbs_element` STRING COMMENT 'SAP Project System (PS) Work Breakdown Structure element code assigned to this project for hierarchical cost collection, budget tracking, and settlement. Enables granular project cost management and CAPEX/OPEX reporting.',
    CONSTRAINT pk_capital_project PRIMARY KEY(`capital_project_id`)
) COMMENT 'Capital and project expenditure request, approval, and cost collection record for agricultural investments and operational projects. Covers CAPEX items (tractors, combines, planters, irrigation systems, land improvements, facility construction, technology infrastructure) and OPEX project tracking (field renovation, crop trials, marketing campaigns). Captures request number, asset/project description, category (CAPEX/OPEX), requesting cost center, estimated cost, funding source, business justification, ROI calculation, approval workflow status, approved amount, budget vs actual costs, commitment costs, settlement rule, and project status. Supports CAPEX/OPEX tracking, project cost management, and SOX financial controls.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying each fixed asset record in the enterprise asset register. Primary key for the fixed_asset data product.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to finance.capital_project. Business justification: Fixed assets are capitalized from approved capital projects (CAPEX requests). Linking fixed_asset to capital_project via capex_request_id enables full lifecycle traceability from CAPEX request through',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity (company code) that owns this fixed asset. Supports multi-entity agricultural operations and consolidated financial reporting under GAAP/IFRS. Links to the finance.company_code master.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: fixed_asset has cost_center_code as a STRING. Normalizing to a FK to cost_center links the asset to the organizational unit responsible for it, enabling cost center-level asset reporting and depreciat',
    `field_id` BIGINT COMMENT 'Foreign key linking to land.field. Business justification: Irrigation pivots, grain bins, tile drainage systems, and farm structures are fixed assets physically located on specific fields. Field-level asset tracking enables capital investment analysis by fiel',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: fixed_asset has gl_account_code as a STRING. Normalizing to a FK to gl_account links the asset to the authoritative GL account for asset accounting (asset acquisition, depreciation, disposal accounts)',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Fixed assets in agriculture (irrigation systems, grain storage, CAFO facilities, processing equipment) require operating permits. Linking assets to their required permits enables permit renewal tracki',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Agricultural fixed assets (tractors, irrigation equipment, storage facilities) are acquired via POs. The existing purchase_order_number is denormalized text. Proper FK enables asset-to-PO traceability',
    `vendor_id` BIGINT COMMENT 'FK to procurement.vendor',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense posted against this asset from capitalization date through the last completed fiscal period. Represents the cumulative reduction in asset carrying value. Sourced from SAP FI-AA depreciation run postings.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original historical cost of the asset at acquisition including purchase price, freight, installation, and any directly attributable costs to bring the asset to its intended use. Recorded in the reporting currency. Basis for GAAP/IFRS asset accounting and MACRS depreciation.',
    `acquisition_date` DATE COMMENT 'Date the asset was acquired or placed in service. Used as the start date for depreciation calculations, MACRS recovery period, and Section 179 expensing elections. Corresponds to the capitalization date in SAP FI-AA.',
    `asset_category` STRING COMMENT 'High-level business category grouping assets for management reporting and CAPEX/OPEX analysis. Aligns with agricultural asset types common in USDA farm balance sheet reporting and enterprise financial consolidation. [ENUM-REF-CANDIDATE: farm_equipment|irrigation_infrastructure|grain_storage|livestock_facility|land_improvement|technology|vehicle|building — 8 candidates stripped; promote to reference product]',
    `asset_class_code` STRING COMMENT 'SAP FI-AA asset class code that categorizes the asset for depreciation rules, GL account determination, and MACRS tax class assignment (e.g., TRACTOR, IRRIG_INFRA, GRAIN_STORAGE, LIVESTOCK_FAC, LAND_IMPROVE, TECH_ASSET). Drives depreciation method and useful life defaults. [ENUM-REF-CANDIDATE: TRACTOR|COMBINE|SPRAYER|PLANTER|IRRIG_INFRA|GRAIN_STORAGE|LIVESTOCK_FAC|LAND_IMPROVE|VEHICLE|TECH_ASSET|BUILDING|LAND — promote to reference product]',
    `asset_description` STRING COMMENT 'Human-readable description of the fixed asset (e.g., John Deere 8R 410 Tractor, Center Pivot Irrigation System - Field 12, Grain Bin 50,000 BU Capacity). Used in financial statements, insurance schedules, and CAPEX reporting.',
    `asset_number` STRING COMMENT 'Externally-known unique asset number assigned in SAP S/4HANA FI-AA (Asset Accounting module) or Oracle NetSuite fixed asset register. Serves as the primary business identifier for the asset across ERP, insurance, and audit systems.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset. active = in productive use; under_construction = asset under construction (AUC) not yet capitalized; idle = temporarily out of service; disposed = sold or retired; transferred = transferred to another entity; scrapped = written off with no proceeds.. Valid values are `active|under_construction|idle|disposed|transferred|scrapped`',
    `asset_subnumber` STRING COMMENT 'Sub-number within the asset number used in SAP FI-AA to track component-level assets or subsequent acquisitions (e.g., engine overhaul on a tractor recorded as a sub-asset). Enables component accounting per IFRS IAS 16.',
    `asset_tag_number` STRING COMMENT 'Physical asset tag or barcode/RFID label affixed to the asset for physical inventory verification. Used during annual physical asset counts required by SOX internal controls and GAAP ASC 360 asset existence assertions.',
    `bonus_depreciation_pct` DECIMAL(18,2) COMMENT 'Percentage of additional first-year bonus depreciation elected under IRS Section 168(k) for qualifying farm equipment and property. Common values: 100% (2017-2022), 80% (2023), 60% (2024), 40% (2025). Reduces taxable income in acquisition year.',
    `capitalization_date` DATE COMMENT 'Date the asset was formally capitalized on the balance sheet and depreciation commenced. May differ from acquisition_date for assets under construction (AUC) that are transferred to productive use upon completion.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset record was first created in the system. Supports audit trail requirements under SOX Section 404 and GAAP/IFRS asset accounting controls.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this asset record (e.g., USD). Supports multi-currency consolidation for international agricultural operations under IFRS.. Valid values are `^[A-Z]{3}$`',
    `depreciation_area` STRING COMMENT 'SAP FI-AA depreciation area indicating the accounting framework for which this depreciation record applies. book = GAAP book depreciation; tax = US federal tax (MACRS); ifrs = IFRS IAS 16 reporting; state_tax = state-level tax depreciation; group = consolidated group reporting.. Valid values are `book|tax|ifrs|state_tax|group`',
    `depreciation_method` STRING COMMENT 'Depreciation calculation method applied to this asset. straight_line = GAAP book depreciation; macrs = Modified Accelerated Cost Recovery System for US federal tax; declining_balance = accelerated book method; units_of_production = usage-based for farm equipment; section_179 = immediate expensing election for qualifying farm equipment under IRS Section 179.. Valid values are `straight_line|macrs|declining_balance|sum_of_years|units_of_production|section_179`',
    `disposal_date` DATE COMMENT 'Date the asset was disposed of through sale, trade-in, scrapping, or retirement. Triggers final depreciation calculation, gain/loss on disposal recognition, and removal from the active asset register. Null if asset has not been disposed.',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Cash or fair value proceeds received upon disposal of the asset (sale price, trade-in allowance, or insurance settlement). Used to calculate gain or loss on disposal: proceeds minus net book value at disposal date. Null if asset has not been disposed or was scrapped with no proceeds.',
    `disposal_reason` STRING COMMENT 'Reason code for asset disposal. Used for asset lifecycle analytics, replacement planning, and CAPEX justification. destroyed may trigger insurance claims; traded_in affects new asset acquisition cost calculation. [ENUM-REF-CANDIDATE: sold|traded_in|scrapped|donated|stolen|destroyed|transferred — 7 candidates stripped; promote to reference product]',
    `fiscal_period` STRING COMMENT 'Fiscal period (month 01-12) of the most recent depreciation posting. Supports monthly depreciation run tracking and period-end financial close validation per SOX controls.. Valid values are `^(0[1-9]|1[0-2])$`',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the most recent depreciation run or asset transaction was posted. Used for annual depreciation reporting, CAPEX budget reconciliation, and GAAP/IFRS financial statement preparation.. Valid values are `^[0-9]{4}$`',
    `impairment_loss` DECIMAL(18,2) COMMENT 'Cumulative impairment loss recognized on this asset where the carrying amount exceeds the recoverable amount. Triggered by events such as crop failure, flood damage to irrigation infrastructure, or obsolescence of precision agriculture technology. Recorded per GAAP ASC 360 / IFRS IAS 36.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number covering this asset against loss, damage, or liability. Agricultural equipment and facilities are typically covered under farm property and equipment insurance. Required for insurance schedule reporting and claims processing.',
    `insured_value` DECIMAL(18,2) COMMENT 'Current insured replacement value of the asset as declared on the insurance policy. May differ from net book value (NBV) as insurance is based on replacement cost rather than depreciated book value. Used for insurance adequacy reviews.',
    `last_depreciation_posted_amount` DECIMAL(18,2) COMMENT 'Depreciation expense amount posted in the most recent depreciation run for this asset. Used for period-over-period variance analysis and to validate depreciation run completeness in SOX-controlled financial close processes.',
    `last_depreciation_run_date` DATE COMMENT 'Date of the most recently completed periodic depreciation run for this asset. Used to confirm depreciation is current and to identify assets that may have missed a depreciation posting cycle. Sourced from SAP FI-AA depreciation run history.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fixed asset record. Used for change data capture (CDC) in the Databricks Silver Layer pipeline and SOX audit trail compliance.',
    `macrs_property_class` STRING COMMENT 'IRS MACRS recovery period class for US federal tax depreciation. Farm equipment (tractors, combines, sprayers) typically qualifies as 5-year or 7-year property; grain bins as 7-year; single-purpose agricultural structures as 10-year; land improvements as 15-year. Critical for USDA farm tax planning. [ENUM-REF-CANDIDATE: 3_year|5_year|7_year|10_year|15_year|20_year|27_5_year|39_year — 8 candidates stripped; promote to reference product]',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying amount of the asset on the balance sheet, calculated as acquisition_cost minus accumulated_depreciation minus any impairment losses. Reported on the enterprise balance sheet per GAAP ASC 360 and IFRS IAS 16. Key metric for CAPEX ROI analysis.',
    `profit_center_code` STRING COMMENT 'SAP CO profit center associated with this asset for internal profitability reporting. Enables EBITDA analysis by farm enterprise or commodity segment. Supports management accounting and ROI analysis at the profit center level.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. Used in straight-line depreciation calculation (depreciable base = acquisition_cost - salvage_value). Also referred to as residual value under IFRS IAS 16. Reviewed annually per GAAP ASC 360.',
    `section_179_elected` BOOLEAN COMMENT 'Indicates whether the IRS Section 179 immediate expensing election was made for this asset in the year of acquisition. Common for farm equipment purchases to maximize tax deductions in the acquisition year. True = Section 179 elected; False = standard depreciation applied.',
    `serial_number` STRING COMMENT 'Manufacturer serial number of the asset (e.g., tractor VIN, combine serial number, irrigation controller serial). Used for warranty claims, insurance identification, equipment telematics registration with John Deere Operations Center, and physical asset verification during audits.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Estimated useful economic life of the asset in years as determined at acquisition. Used for straight-line depreciation rate calculation and IFRS IAS 16 residual value assessment. Common values: tractors/combines 7-10 years, grain bins 20 years, irrigation systems 15-20 years.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master representing capitalized agricultural assets with embedded depreciation schedule, run history, and disposal records. Covers farm equipment (tractors, combines, sprayers, planters), irrigation infrastructure, grain storage facilities (bins, elevators), livestock facilities, land improvements, and technology assets. Captures asset number, description, asset class, acquisition date, acquisition cost, useful life, depreciation method (straight-line, MACRS, Section 179), depreciation area (book, tax, IFRS), accumulated depreciation, net book value, location (farm/field), cost center, insurance coverage, disposal status, periodic depreciation run records (fiscal period, depreciation posted, run status), and disposal proceeds. Supports GAAP/IFRS asset accounting, MACRS tax depreciation for farm equipment, and Section 179 expensing elections common in agricultural operations.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`period_close` (
    `period_close_id` BIGINT COMMENT 'Primary key for period_close',
    `employee_id` BIGINT COMMENT 'Reference to the employee or manager authorized to sign off and approve completion of this period close task. Critical for SOX segregation of duties and financial controls.',
    `close_calendar_id` BIGINT COMMENT 'Reference to the close calendar template that governs the schedule and sequencing of this period close task. Manages seasonal peaks around harvest settlement and crop year-end.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Ag period-close tasks include commodity inventory valuation (LIFO/FIFO/average cost), hedge mark-to-market postings, and grain settlement reconciliation — all commodity-specific. Linking commodity_id ',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity or company code within the agricultural enterprise for which this period close task applies. Aligns with SAP S/4HANA company code configuration.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this close task, enabling OPEX and CAPEX tracking by organizational unit within the agricultural enterprise.',
    `dependency_task_period_close_id` BIGINT COMMENT 'Reference to another period close task that must be completed before this task can begin. Enables sequencing and dependency management within the close calendar workflow.',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: Financial period close in agriculture includes ESG reporting close tasks (harvest_settlement_flag present on period_close). Linking to esg_report enables coordinated financial and ESG close calendar m',
    `primary_period_employee_id` BIGINT COMMENT 'Reference to the employee or user responsible for executing and completing this period close task. Supports SOX accountability and segregation of duties controls.',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual financial value posted or recorded as a result of completing this close task (e.g., actual accrual posted, actual depreciation run amount, actual inventory valuation). Compared against estimated amount for variance reporting.',
    `approver_name` STRING COMMENT 'Full name of the approver who signs off on this period close task. Retained for audit trail and SOX control documentation.',
    `close_period_type` STRING COMMENT 'Classification of the close period indicating whether this is a month-end, quarter-end, year-end, crop-year-end (agricultural fiscal cycle), or special period close. Crop-year-end is specific to agricultural enterprises following USDA crop year conventions.. Valid values are `month_end|quarter_end|year_end|crop_year_end|special`',
    `close_reference_number` STRING COMMENT 'Externally-known business identifier for this period close task record, used for cross-system tracking and audit trail. Typically sourced from SAP S/4HANA or Oracle NetSuite close management workflows.',
    `close_task_name` STRING COMMENT 'Human-readable name or short description of the specific period close task, providing additional context beyond the task type code (e.g., Q3 Grain Inventory Mark-to-Market, Harvest Settlement Accruals Posting).',
    `close_task_type` STRING COMMENT 'The specific type of period-end close activity being tracked. Examples include accruals posting, depreciation run, inventory valuation at harvest, intercompany reconciliation, grain inventory mark-to-market, COGS allocation by commodity, financial statement preparation, and tax provision. [ENUM-REF-CANDIDATE: accruals_posting|depreciation_run|inventory_valuation|intercompany_reconciliation|grain_mark_to_market|cogs_allocation|financial_statement_prep|tax_provision|bank_reconciliation|fixed_asset_close — promote to reference product]',
    `completion_date` DATE COMMENT 'The actual date on which this period close task was completed and marked as finished. Null if the task has not yet been completed. Used to calculate close cycle time and on-time performance KPIs.',
    `controlling_area` STRING COMMENT 'SAP S/4HANA controlling area code that defines the organizational unit for cost accounting and management reporting. Groups company codes for EBITDA and COGS reporting across the agricultural enterprise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this period close task record was first created in the system. Provides the audit trail creation timestamp for SOX compliance and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the financial amounts associated with this close task (e.g., USD for US Dollar). Supports multi-currency consolidation for international agricultural operations.. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'The scheduled deadline by which this period close task must be completed, as defined in the close calendar. Drives overdue detection and escalation workflows.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this period close task has been escalated due to being overdue, blocked, or requiring management intervention. True when escalated; False under normal processing.',
    `estimated_amount` DECIMAL(18,2) COMMENT 'The estimated financial value associated with this close task (e.g., estimated accrual amount, estimated depreciation charge, estimated inventory valuation adjustment). Used for pre-close planning and variance analysis.',
    `fiscal_period` STRING COMMENT 'The fiscal period number (1–12 for monthly, 13–16 for special periods) within the fiscal year to which this close task applies. Aligns with SAP S/4HANA period configuration.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this period close task belongs. In agriculture, the fiscal year may align with the crop year (e.g., October–September) rather than the calendar year.',
    `gaap_ifrs_standard` STRING COMMENT 'The accounting standard under which this period close task is executed and reported. Supports dual GAAP/IFRS reporting for consolidated financial statements and regulatory filings.. Valid values are `GAAP|IFRS|GAAP_IFRS_DUAL`',
    `gl_posting_date` DATE COMMENT 'The date on which financial entries associated with this close task are posted to the General Ledger (GL) in SAP S/4HANA. Critical for period-end cutoff compliance under GAAP and IFRS.',
    `harvest_settlement_flag` BOOLEAN COMMENT 'Indicates whether this close task is specifically associated with the agricultural harvest settlement process, which involves final grain pricing, deferred payment settlements, and crop year-end accruals. True for harvest settlement tasks; False otherwise.',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this close task involves intercompany reconciliation or elimination entries between legal entities within the agricultural enterprise group. True for intercompany tasks; False for single-entity tasks.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this period close task record was most recently modified. Supports change tracking, audit trails, and incremental data loading in the Databricks Silver Layer.',
    `period_end_date` DATE COMMENT 'The last calendar date of the financial period being closed. Defines the reporting window for this close cycle and aligns with GAAP/IFRS reporting timelines.',
    `period_start_date` DATE COMMENT 'The first calendar date of the financial period being closed. Defines the reporting window for this close cycle.',
    `posting_period_locked` BOOLEAN COMMENT 'Indicates whether the fiscal posting period has been locked in SAP S/4HANA to prevent further journal entries after close completion. True when the period is locked; False when still open for posting.',
    `sign_off_timestamp` TIMESTAMP COMMENT 'The precise date and time when the approver formally signed off on this period close task. Provides an immutable audit timestamp for SOX compliance and financial controls documentation.',
    `source_system` STRING COMMENT 'The operational system of record from which this period close task record originates. Supports data lineage tracking across SAP S/4HANA FI/CO, Oracle NetSuite, Granular Farm Management, or manual entry.. Valid values are `SAP_S4HANA|ORACLE_NETSUITE|GRANULAR|MANUAL`',
    `sox_control_reference` STRING COMMENT 'The SOX internal control identifier or reference number associated with this period close task. Links the task to the enterprises SOX control framework for financial reporting compliance and audit evidence.',
    `task_notes` STRING COMMENT 'Free-text notes or comments entered by the task owner or approver regarding the execution of this period close task, including explanations for variances, exceptions, or issues encountered during the close process.',
    `task_owner_name` STRING COMMENT 'Full name of the employee or user responsible for executing this period close task. Retained for audit trail and SOX control documentation purposes.',
    `task_sequence` STRING COMMENT 'Numeric ordering of this close task within the overall period close workflow, enabling sequenced execution and progress tracking across the close calendar.',
    `task_status` STRING COMMENT 'Current workflow status of the period close task indicating its progress through the close cycle. Drives close calendar dashboards and SOX control monitoring.. Valid values are `not_started|in_progress|completed|overdue|blocked|waived`',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between the estimated amount and the actual amount for this close task. Positive variance indicates actual exceeded estimate; negative indicates under-run. Used for close quality analysis and management reporting.',
    CONSTRAINT pk_period_close PRIMARY KEY(`period_close_id`)
) COMMENT 'Period-end financial close task and status record tracking the completion of month-end, quarter-end, and year-end close activities across the agricultural enterprise. Captures close period, company code, close task (accruals posting, depreciation run, inventory valuation at harvest, intercompany reconciliation, grain inventory mark-to-market, financial statement preparation), task owner, due date, completion date, status, dependencies, and sign-off approver. Manages the close calendar including seasonal peaks around harvest settlement and crop year-end. Supports SOX financial controls and GAAP/IFRS reporting timelines.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique surrogate identifier for each intercompany financial transaction record within the agricultural enterprise group. Primary key for this data product.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Intercompany grain transfers between ag legal entities (farm LLC to grain marketing subsidiary) require commodity identification for transfer pricing documentation, intercompany elimination, and commo',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Intercompany transactions generate GL journal entries for both the sending and receiving entities. Linking intercompany_transaction to journal_entry enables traceability from the intercompany transact',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity (company code) on the receiving end of the intercompany transaction. Corresponds to the counterpart subsidiary or entity within the agricultural enterprise group.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Intercompany commodity transfers between related agriculture entities originate from intercompany sales orders. Linking IC transactions to the originating sales order enables intercompany elimination,',
    `sending_company_code_id` BIGINT COMMENT 'Reference to the legal entity (company code) initiating and posting the intercompany transaction. Corresponds to the originating subsidiary or farming entity within the agricultural enterprise group.',
    `approval_status` STRING COMMENT 'Workflow approval status of the intercompany transaction per the enterprises SOX-compliant financial controls framework. Large intercompany transactions above defined thresholds require multi-level approval before posting. Supports segregation of duties and internal audit requirements.. Valid values are `pending|approved|rejected|escalated`',
    `approved_by` STRING COMMENT 'User ID or name of the financial controller or authorized approver who approved this intercompany transaction per the SOX-compliant approval workflow. Required for audit trail and segregation of duties compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the intercompany transaction was approved by the authorized approver. Supports SOX audit trail, segregation of duties documentation, and period-end close timelines.',
    `commodity_quantity` DECIMAL(18,2) COMMENT 'The quantity of agricultural commodity transferred in an intercompany commodity transfer transaction. Expressed in the unit of measure specified in commodity_quantity_uom. Populated only for transaction_type = commodity_transfer.',
    `commodity_quantity_uom` STRING COMMENT 'Unit of measure for the commodity quantity in an intercompany commodity transfer. BU = Bushel, MT = Metric Ton, CWT = Hundredweight, LB = Pound, KG = Kilogram, TON = Short Ton. Aligns with USDA and CBOT standard commodity measurement conventions.. Valid values are `BU|MT|CWT|LB|KG|TON`',
    `cost_center_sending` STRING COMMENT 'The SAP S/4HANA CO cost center of the sending entity associated with the intercompany transaction. Supports OPEX tracking, cost allocation, and management fee distribution across the agricultural enterprise.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the intercompany transaction record was first created in the source system (SAP S/4HANA). Supports audit trail, data lineage, and SOX financial controls.',
    `document_date` DATE COMMENT 'The date on the originating source document (invoice, transfer order, loan agreement) that triggered the intercompany transaction. May differ from posting_date when documents are processed with a lag.',
    `elimination_status` STRING COMMENT 'Current status of the intercompany transactions elimination in the consolidated financial statements. Transactions must be eliminated to avoid double-counting in GAAP/IFRS consolidated P&L and balance sheet. pending indicates awaiting elimination run; eliminated confirms full elimination; disputed flags mismatches requiring resolution.. Valid values are `pending|eliminated|partially_eliminated|not_required|disputed`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign currency exchange rate applied to translate the transaction currency amount to the group currency at the time of posting. Sourced from SAP S/4HANA exchange rate tables, aligned with IFRS IAS 21 closing or average rate methodology.',
    `fiscal_period` STRING COMMENT 'The fiscal period (1–16, including special periods) within the fiscal year to which this intercompany transaction is assigned in SAP S/4HANA. Used for monthly close, intercompany reconciliation, and consolidated financial statement preparation.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this intercompany transaction belongs, as determined by the company code fiscal year variant in SAP S/4HANA. Used for period-end consolidation and GAAP/IFRS annual reporting.',
    `gl_account_receiving` STRING COMMENT 'The General Ledger (GL) account number in the receiving company codes chart of accounts to which the offsetting intercompany entry is posted. Supports automated intercompany clearing and reconciliation in SAP S/4HANA.. Valid values are `^[0-9]{6,10}$`',
    `gl_account_sending` STRING COMMENT 'The General Ledger (GL) account number in the sending company codes chart of accounts to which the intercompany transaction is posted (debit or credit). Sourced from SAP S/4HANA FI module.. Valid values are `^[0-9]{6,10}$`',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount translated into the group reporting currency (typically USD) for consolidated financial statement preparation. Supports EBITDA reporting and consolidated P&L at the enterprise group level.',
    `group_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the enterprise groups reporting currency used in consolidated financial statements (e.g., USD). Defined at the consolidation group level in SAP S/4HANA.. Valid values are `^[A-Z]{3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the intercompany transaction record was last modified in the source system (SAP S/4HANA). Tracks changes to reconciliation status, elimination status, or approval workflow. Supports data lineage and SOX audit trail.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount translated into the local (functional) currency of the sending company code. Used for local statutory reporting and tax compliance in the jurisdiction of the originating entity.',
    `netting_agreement_reference` STRING COMMENT 'Reference identifier for the intercompany netting agreement under which multiple intercompany payables and receivables between entities are offset and settled as a single net payment. Reduces cash flow complexity across the agricultural enterprise group.',
    `netting_status` STRING COMMENT 'Indicates whether this intercompany transaction is included in a netting cycle, has been settled via netting, or is excluded from netting arrangements. Supports cash pooling and treasury management across the agricultural enterprise group.. Valid values are `included|excluded|settled|pending_netting`',
    `posting_date` DATE COMMENT 'The accounting date on which the intercompany transaction is posted to the general ledger (GL) in SAP S/4HANA. Determines the fiscal period and year to which the transaction belongs for GAAP/IFRS financial reporting.',
    `profit_center_receiving` STRING COMMENT 'The SAP S/4HANA CO profit center of the receiving entity for the intercompany transaction. Used for segment reporting, COGS allocation by commodity, and internal profitability analysis.',
    `profit_center_sending` STRING COMMENT 'The SAP S/4HANA CO profit center of the sending entity responsible for the intercompany transaction. Enables profitability analysis by crop enterprise, livestock operation, or business segment within the agricultural group.',
    `reconciliation_status` STRING COMMENT 'Status of the intercompany transaction reconciliation between the sending and receiving company codes. Mismatches between the two sides of an intercompany transaction must be resolved before period-end close. Supports SOX-compliant financial controls.. Valid values are `unreconciled|matched|mismatched|in_review|confirmed`',
    `reference_document_number` STRING COMMENT 'External reference document number associated with the intercompany transaction, such as a Purchase Order (PO) number, Sales Order (SO) number, intercompany invoice number, or loan agreement reference. Enables end-to-end traceability across the agricultural supply chain.',
    `reversal_date` DATE COMMENT 'The accounting date on which the reversal of this intercompany transaction was posted in SAP S/4HANA. Populated only when transaction_status = reversed. Used for period-end close and audit trail.',
    `reversal_document_number` STRING COMMENT 'SAP S/4HANA document number of the reversal entry created to cancel this intercompany transaction. Populated only when transaction_status = reversed. Supports audit trail and SOX financial controls.',
    `sap_document_number` STRING COMMENT 'The 10-digit SAP S/4HANA FI document number assigned to the intercompany transaction upon posting. Serves as the primary system-of-record reference for tracing the transaction back to the originating SAP document for audit and reconciliation purposes.. Valid values are `^[0-9]{10}$`',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The gross base amount of the intercompany transaction in the transaction currency. Represents the face value before any adjustments, netting, or eliminations. For commodity transfers, reflects the transfer price of agricultural goods (grain, livestock, inputs).',
    `transaction_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the intercompany transaction amount is denominated (e.g., USD, EUR, BRL). Drives foreign currency translation for consolidated financial statements.. Valid values are `^[A-Z]{3}$`',
    `transaction_description` STRING COMMENT 'Free-text description of the intercompany transaction providing business context, such as the nature of the commodity transfer, management fee basis, or loan purpose. Sourced from the SAP S/4HANA document header text field.',
    `transaction_number` STRING COMMENT 'Externally-known business identifier for the intercompany transaction, typically generated by SAP S/4HANA FI module. Follows the format ICT-{YYYY}-{SEQUENCE}. Used for cross-entity reconciliation and audit trail.. Valid values are `^ICT-[0-9]{4}-[0-9]{8}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the intercompany transaction in SAP S/4HANA. draft indicates a parked document; posted confirms GL posting; reversed indicates a reversal document has been created; cancelled indicates the transaction was voided; on_hold indicates pending approval.. Valid values are `draft|posted|reversed|cancelled|on_hold`',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction by its business nature. Commodity transfers represent cross-entity movement of agricultural goods (grain, livestock, inputs). Management fees cover shared services charges. Intercompany loans represent financing between entities. Service charges cover operational support. [ENUM-REF-CANDIDATE: commodity_transfer|management_fee|intercompany_loan|service_charge|dividend|royalty|cost_allocation|capital_contribution — promote to reference product]. Valid values are `commodity_transfer|management_fee|intercompany_loan|service_charge|dividend|royalty`',
    `transfer_price_method` STRING COMMENT 'The OECD-approved transfer pricing methodology applied to determine the arms-length price for the intercompany transaction. Critical for tax compliance and regulatory reporting. Commodity transfers between farming subsidiaries must comply with OECD Transfer Pricing Guidelines and local tax authority requirements.. Valid values are `cost_plus|market_price|resale_price|comparable_uncontrolled|transactional_net_margin`',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Intercompany financial transaction record capturing cross-entity transactions between legal entities within the agricultural enterprise group (e.g., commodity transfers between farming subsidiaries, management fee charges, intercompany loans). Captures transaction ID, sending company code, receiving company code, transaction type, posting date, amount, currency, elimination status, reconciliation status, and netting agreement reference. Supports GAAP/IFRS consolidated financial statement elimination.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`tax_record` (
    `tax_record_id` BIGINT COMMENT 'Unique surrogate identifier for each tax transaction and compliance record in the agricultural enterprise. Primary key for the tax_record data product.',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity (company code) under which this tax obligation is recorded. Aligns with SAP S/4HANA FI company code structure for consolidated tax reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: tax_record has cost_center_code as a STRING. Tax obligations are often allocated to specific cost centers (e.g., property tax to farm operations cost center). Normalizing to a FK enables cost center-l',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: tax_record has gl_account_code as a STRING. Tax postings are recorded to specific GL accounts. Normalizing to a FK to gl_account links tax records to the authoritative chart of accounts, enabling prop',
    `original_tax_record_id` BIGINT COMMENT 'Reference to the original tax_record_id that this record amends or supersedes. Populated only when amended_indicator is True, enabling lineage tracking of tax corrections and restatements.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to land.parcel. Business justification: Property tax records are assessed and filed against specific parcels. Farm accountants reconcile annual property tax payments (tracked on parcel.annual_property_tax) against tax_record entries. County',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Sales orders generate tax obligations (sales tax, VAT, excise on commodity sales). Tax records must reference the originating sales order for tax audit trails, regulatory compliance reporting, and tax',
    `amended_indicator` BOOLEAN COMMENT 'Flag indicating whether this tax record represents an amended filing (e.g., IRS Form 1040X equivalent) correcting a previously filed return. Supports audit trail and SOX financial controls.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for SOX financial controls and data lineage in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this tax record (taxable_base_amount, tax_amount, exemption_amount, net_tax_amount). Supports multi-currency consolidation for international agricultural operations.. Valid values are `^[A-Z]{3}$`',
    `deferred_tax_direction` STRING COMMENT 'Indicates whether the deferred tax position is an asset (future tax benefit) or liability (future tax obligation) per GAAP ASC 740 and IFRS IAS 12. Applicable only when deferred_tax_indicator is True.. Valid values are `asset|liability|none`',
    `deferred_tax_indicator` BOOLEAN COMMENT 'Flag indicating whether this tax record represents a deferred tax asset or liability per GAAP ASC 740 or IFRS IAS 12. Deferred taxes arise from temporary differences between book and tax accounting for agricultural assets such as crop inventory, biological assets, and depreciation.',
    `exemption_amount` DECIMAL(18,2) COMMENT 'Monetary value of agricultural-specific tax exemptions applied to this record, including farm fuel tax credits, ag sales tax exemptions on seeds/fertilizers/pesticides, and USDA-recognized exemptions. Reduces the net tax liability.',
    `exemption_certificate_number` STRING COMMENT 'Reference number of the agricultural tax exemption certificate (e.g., farm sales tax exemption certificate for seeds, fertilizers, pesticides, or farm fuel). Required for audit substantiation of exemption_amount claims with state revenue departments.',
    `exemption_type` STRING COMMENT 'Classification of the agricultural tax exemption applied to this record. Includes farm fuel tax credits, ag sales tax exemptions on qualifying inputs (seeds, fertilizers, pesticides), organic input exemptions, and equipment exemptions per USDA and state revenue rules.. Valid values are `farm_fuel_credit|ag_sales_tax|organic_input|equipment_exemption|none`',
    `filing_reference_number` STRING COMMENT 'Regulatory authority-assigned confirmation or acknowledgment number for the tax return or filing submission (e.g., IRS e-file acknowledgment number, state filing confirmation). Provides audit trail for regulatory compliance.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the tax record within the filing workflow. Tracks progression from draft preparation through regulatory acceptance or rejection, supporting SOX financial controls and audit readiness.. Valid values are `draft|filed|accepted|rejected|amended|void`',
    `fiscal_period` STRING COMMENT 'The fiscal period (1–16 in SAP S/4HANA, typically 1–12 for monthly) within the fiscal year to which this tax record is assigned. Supports period-close tax accruals and monthly EBITDA reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year (four-digit integer, e.g., 2024) to which this tax record belongs. Aligns with the company code fiscal year variant in SAP S/4HANA FI for annual tax provision and GAAP/IFRS reporting.',
    `interest_amount` DECIMAL(18,2) COMMENT 'Monetary amount of interest charged by the regulatory authority on overdue tax balances. Tracked separately for GAAP/IFRS accrual accounting and financial statement disclosure.',
    `jurisdiction_name` STRING COMMENT 'Human-readable name of the taxing jurisdiction (e.g., Iowa Department of Revenue, USDA Federal, Polk County Assessor). Supports reporting and correspondence with regulatory authorities.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this tax record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking, SOX audit controls, and incremental data loading in the Databricks Silver Layer.',
    `net_tax_amount` DECIMAL(18,2) COMMENT 'Final tax obligation after deducting exemption_amount and any credits from tax_amount. Represents the actual cash outflow or accrual posted to the GL for GAAP/IFRS financial statement reporting.',
    `notes` STRING COMMENT 'Free-text field for additional context, tax advisor commentary, audit findings, or regulatory correspondence notes associated with this tax record. Supports SOX documentation requirements.',
    `payment_date` DATE COMMENT 'Actual date on which the tax payment was remitted to the regulatory authority. Used to calculate late payment penalties and interest, and to confirm compliance with statutory deadlines.',
    `payment_due_date` DATE COMMENT 'Statutory deadline by which the tax payment must be remitted to the regulatory authority (IRS, state revenue department, county assessor for property tax). Critical for cash flow planning and penalty avoidance.',
    `payment_reference_number` STRING COMMENT 'Bank or treasury payment reference number (e.g., EFTPS confirmation number for IRS payments, state e-file confirmation) confirming remittance of the tax amount. Used for payment reconciliation and audit evidence.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary amount of penalties assessed by the regulatory authority for late filing, late payment, or underpayment of taxes. Tracked separately from net_tax_amount for GAAP/IFRS disclosure and OPEX reporting.',
    `posting_date` DATE COMMENT 'The date on which the tax transaction was posted to the general ledger in SAP S/4HANA FI or Oracle NetSuite. Determines the accounting period for GAAP/IFRS financial statement inclusion.',
    `profit_center_code` STRING COMMENT 'SAP S/4HANA CO profit center associated with this tax record, enabling EBITDA reporting and ROI analysis at the crop enterprise or business unit level.',
    `regulatory_authority` STRING COMMENT 'The governing regulatory body responsible for administering this tax obligation. Agricultural enterprises interact with IRS for federal income/excise tax, state revenue departments for sales/use tax, county assessors for property tax, and EPA for chemical excise taxes.. Valid values are `IRS|state_revenue|county_assessor|EPA|USDA|FDA`',
    `source_system` STRING COMMENT 'Operational system of record from which this tax record originated. Supports data lineage tracking in the Databricks Silver Layer and reconciliation between SAP S/4HANA FI, Oracle NetSuite, and Granular Farm Management financial modules.. Valid values are `SAP_S4HANA|Oracle_NetSuite|Granular|manual`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Calculated tax liability amount derived from taxable_base_amount multiplied by tax_rate, adjusted for any exemptions or credits. Represents the actual tax obligation posted to the GL. Denominated in the company reporting currency.',
    `tax_category` STRING COMMENT 'Broad accounting category of the tax record distinguishing direct taxes (income, property), indirect taxes (sales, excise, use), deferred tax assets/liabilities, and current tax provisions per GAAP ASC 740 and IFRS IAS 12.. Valid values are `direct|indirect|deferred|current`',
    `tax_document_number` STRING COMMENT 'Externally-known tax document or posting reference number assigned by the source system (SAP S/4HANA FI or Oracle NetSuite). Used for audit trail, cross-referencing with tax filings, and regulatory correspondence with IRS, state revenue departments, or EPA.',
    `tax_jurisdiction_code` STRING COMMENT 'Alphanumeric code identifying the taxing authority jurisdiction (federal, state, county, municipality) where the tax obligation arises. Aligns with SAP S/4HANA FI tax jurisdiction configuration and supports multi-state agricultural operations.',
    `tax_period_end_date` DATE COMMENT 'End date of the tax reporting period to which this tax record applies. Together with tax_period_start_date defines the taxable period for filing and accrual purposes.',
    `tax_period_start_date` DATE COMMENT 'Start date of the tax reporting period (month, quarter, or fiscal year) to which this tax record applies. Used for period-based tax accruals, EBITDA reporting, and regulatory filing schedules.',
    `tax_rate` DECIMAL(18,2) COMMENT 'The applicable statutory or effective tax rate expressed as a decimal (e.g., 0.0825 for 8.25%). Sourced from the tax jurisdiction configuration in SAP S/4HANA FI or Oracle NetSuite tax engine.',
    `tax_type` STRING COMMENT 'Classification of the tax obligation. Covers agricultural-specific tax types including sales tax on inputs, use tax on equipment, excise tax on agricultural chemicals (EPA-regulated), property tax on farmland, income tax provisions, and payroll tax. [ENUM-REF-CANDIDATE: sales_tax|use_tax|excise_tax|property_tax|income_tax|payroll_tax|fuel_tax|value_added_tax|withholding_tax — promote to reference product]. Valid values are `sales_tax|use_tax|excise_tax|property_tax|income_tax|payroll_tax`',
    `taxable_base_amount` DECIMAL(18,2) COMMENT 'The gross monetary value subject to taxation before applying the tax rate. For agricultural enterprises this may represent crop sale proceeds, chemical purchase value, farmland assessed value, or income before tax. Denominated in the company reporting currency.',
    CONSTRAINT pk_tax_record PRIMARY KEY(`tax_record_id`)
) COMMENT 'Tax transaction and compliance record capturing tax postings, filings, and obligations for the agricultural enterprise including sales tax, use tax, excise tax on agricultural chemicals, property tax on farmland, income tax provisions, and agricultural-specific exemptions (farm fuel tax credits, ag sales tax exemptions). Captures tax document number, tax type, tax jurisdiction, taxable base amount, tax rate, tax amount, tax period, filing status, payment due date, and regulatory authority (IRS, state revenue department). Supports GAAP/IFRS tax accounting, deferred tax calculations, and regulatory compliance.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`commodity_hedge` (
    `commodity_hedge_id` BIGINT COMMENT 'Unique system-generated identifier for each commodity hedging instrument record. Primary key for the commodity_hedge data product.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Hedge effectiveness testing, MTM valuation, and basis risk reporting all require linking each hedge position to the specific commodity being hedged. Treasury/risk management teams in ag operations alw',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity (company code) under which this hedge is recorded for financial reporting and SOX compliance. Links to the finance.company_code master.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `farm_unit_id` BIGINT COMMENT 'Foreign key linking to land.farm_unit. Business justification: Commodity hedges are placed to protect anticipated production from specific farm operations. ASC 815 hedge effectiveness testing requires matching hedges to the hedged item (anticipated crop productio',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `herd_id` BIGINT COMMENT 'Foreign key linking to livestock.herd. Business justification: Livestock producers place live cattle and feeder cattle futures hedges against specific herds for price risk management. Linking commodity_hedge to herd enables hedge effectiveness testing, P&L attrib',
    `production_group_id` BIGINT COMMENT 'Foreign key linking to livestock.production_group. Business justification: Feedlot operators hedge specific production lots (groups) against futures contracts for closeout price protection. Linking commodity_hedge to production_group supports lot-level hedge effectiveness te',
    `basis_risk_amount` DECIMAL(18,2) COMMENT 'The monetary value of the basis differential between the local cash price and the exchange-traded futures price for the hedged commodity. Represents residual price risk not eliminated by the hedge. Critical metric in agricultural commodity marketing and grain merchandising.',
    `broker_account_number` STRING COMMENT 'The account number assigned by the futures commission merchant (FCM) or broker for the trading account under which this hedge position is held. Used for margin account reconciliation and position reporting.',
    `contract_expiration_date` DATE COMMENT 'The calendar date on which the futures or options contract expires or the forward contract matures. Used for position management, roll scheduling, and hedge effectiveness testing timelines.',
    `contract_month` STRING COMMENT 'The delivery/expiration month of the futures or options contract expressed in standard exchange notation (e.g., Z24 = December 2024, H25 = March 2025). Critical for managing basis risk and roll strategy in agricultural commodity marketing.. Valid values are `^[A-Z]{1}[0-9]{2}$`',
    `counterparty_name` STRING COMMENT 'The name of the broker, dealer, or OTC counterparty for the hedging instrument. For exchange-traded instruments, this is typically the futures commission merchant (FCM) or clearing broker. For OTC forwards, this is the counterparty financial institution or grain merchandiser.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this commodity hedge record was first created in the system. Supports audit trail requirements under SOX and hedge accounting documentation per ASC 815/IFRS 9.',
    `effectiveness_test_date` DATE COMMENT 'The date on which the most recent hedge effectiveness test was performed. Required for hedge accounting documentation and SOX audit trail.',
    `effectiveness_test_method` STRING COMMENT 'The methodology used to assess hedge effectiveness as required by ASC 815/IFRS 9. dollar_offset compares changes in fair value; regression uses statistical analysis; hypothetical_derivative compares to a perfect hedge; critical_terms_match applies when key terms of hedging instrument and hedged item match.. Valid values are `dollar_offset|regression|hypothetical_derivative|critical_terms_match`',
    `effectiveness_test_result` STRING COMMENT 'The outcome of the most recent hedge effectiveness assessment. highly_effective qualifies for hedge accounting treatment (80-125% offset range per ASC 815); ineffective requires de-designation and P&L recognition of ineffective portion; not_tested for instruments not yet assessed.. Valid values are `highly_effective|ineffective|not_tested`',
    `exchange_code` STRING COMMENT 'Code identifying the exchange on which the futures or options contract is traded. CME (Chicago Mercantile Exchange) for livestock; CBOT (Chicago Board of Trade) for grains and oilseeds; ICE (Intercontinental Exchange) for cotton and sugar; NYMEX for energy-related agricultural inputs.. Valid values are `CME|CBOT|ICE|NYMEX|KCBT|MGE`',
    `forward_price` DECIMAL(18,2) COMMENT 'For forward contracts, the agreed-upon price at which the commodity will be bought or sold at the future settlement date. Expressed in currency per unit of measure. Null for exchange-traded futures and options.',
    `futures_price_at_entry` DECIMAL(18,2) COMMENT 'The exchange-quoted futures price at the time the hedge position was established. Used as the reference price for basis calculation (local cash price minus futures price) and hedge effectiveness testing.',
    `hedge_designation` STRING COMMENT 'Formal hedge accounting designation per ASC 815 (US GAAP) or IFRS 9. fair_value hedges offset changes in fair value of a recognized asset/liability; cash_flow hedges offset variability in future cash flows; net_investment hedges offset foreign currency exposure in net investments; not_designated instruments are economic hedges not qualifying for hedge accounting treatment.. Valid values are `fair_value|cash_flow|net_investment|not_designated`',
    `hedge_end_date` DATE COMMENT 'The date on which the hedge relationship is expected to end or was terminated. Used for hedge accounting de-designation and effectiveness testing period boundaries.',
    `hedge_number` STRING COMMENT 'Externally-known business identifier for the hedging instrument, typically assigned by the treasury management system or SAP S/4HANA FI-TRM module (e.g., HDG-2024-00123). Used for cross-system reconciliation and audit trail.',
    `hedge_ratio` DECIMAL(18,2) COMMENT 'The proportion of the hedged items exposure covered by the hedging instrument, expressed as a decimal (e.g., 0.8000 = 80% coverage). Required for hedge accounting documentation under ASC 815/IFRS 9 and used in hedge effectiveness testing.',
    `hedge_start_date` DATE COMMENT 'The date on which the hedge relationship formally begins for hedge accounting purposes per ASC 815/IFRS 9. May differ from trade_date if formal designation documentation is completed after execution.',
    `hedge_status` STRING COMMENT 'Current lifecycle state of the hedging instrument. open indicates an active position; closed indicates the position has been offset or settled; expired indicates the contract reached maturity; cancelled indicates early termination; pending_designation indicates awaiting formal hedge accounting designation per ASC 815/IFRS 9.. Valid values are `open|closed|expired|cancelled|pending_designation`',
    `hedged_item_description` STRING COMMENT 'Narrative description of the specific exposure or hedged item being protected by this instrument (e.g., Forecasted corn purchase Q3 2024 - 500,000 BU, Soybean inventory held at Decatur elevator). Required for hedge accounting documentation under ASC 815/IFRS 9.',
    `initial_margin_required` DECIMAL(18,2) COMMENT 'The initial margin deposit required by the exchange clearinghouse when the futures position is established. Expressed in the transaction currency. Monitored daily against margin calls for cash flow management.',
    `instrument_type` STRING COMMENT 'Classification of the hedging instrument. futures are standardized exchange-traded contracts; options grant the right but not obligation to buy/sell at a strike price; forward contracts are OTC bilateral agreements at a fixed forward price; swap contracts exchange cash flows based on commodity price differentials.. Valid values are `futures|options|forward|swap`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this commodity hedge record was most recently modified. Supports change tracking, audit trail, and incremental data loading in the Databricks Silver Layer.',
    `mark_to_market_value` DECIMAL(18,2) COMMENT 'The current fair value of the hedging instrument based on the latest available market price. Positive values indicate an unrealized gain; negative values indicate an unrealized loss. Updated daily for exchange-traded instruments per GAAP/IFRS fair value measurement requirements.',
    `mtm_valuation_date` DATE COMMENT 'The date as of which the mark-to-market value was last calculated. Ensures financial reporting accuracy and supports period-end close processes in SAP S/4HANA FI.',
    `notional_quantity` DECIMAL(18,2) COMMENT 'The total quantity of the underlying commodity covered by the hedging instrument. Expressed in the unit of measure applicable to the commodity (e.g., bushels for grain, hundredweight for livestock, metric tons for oilseeds). Drives exposure calculation and hedge ratio determination.',
    `number_of_contracts` STRING COMMENT 'The count of standardized exchange contracts comprising the hedge position. Each exchange contract represents a fixed notional quantity (e.g., 5,000 BU per CBOT corn contract). Used for margin calculation and position limit monitoring.',
    `option_premium_paid` DECIMAL(18,2) COMMENT 'The total premium paid to acquire an options contract, expressed in the transaction currency. Represents the maximum loss exposure for long option positions. Recorded as an asset under ASC 815/IFRS 9 hedge accounting. Null for futures and forward contracts.',
    `option_type` STRING COMMENT 'For options instruments, specifies whether the contract is a call option (right to buy) or put option (right to sell) the underlying commodity. not_applicable for futures and forward contracts. Agricultural producers typically purchase put options to establish price floors.. Valid values are `call|put|not_applicable`',
    `quantity_unit_of_measure` STRING COMMENT 'The unit of measure for the notional quantity. BU (Bushel) for grains; MT (Metric Ton) for oilseeds and international contracts; CWT (Hundredweight) for livestock; LB (Pound) for cotton and sugar; TON for domestic bulk commodities.. Valid values are `BU|MT|CWT|LB|TON|BBL`',
    `realized_gain_loss` DECIMAL(18,2) COMMENT 'The actual gain or loss recognized upon closing, expiration, or settlement of the hedging instrument. Positive values indicate a gain; negative values indicate a loss. Recorded to the appropriate P&L or OCI account per ASC 815/IFRS 9 hedge accounting treatment.',
    `settlement_date` DATE COMMENT 'The date on which the hedging instrument was or is expected to be settled. For closed/expired positions, the actual settlement date. For open positions, the expected settlement date based on contract terms.',
    `settlement_type` STRING COMMENT 'The method by which the contract is settled at expiration. cash settlement uses the final settlement price without physical delivery; physical_delivery requires delivery of the actual commodity; offset indicates the position was closed by an opposing trade before expiration.. Valid values are `cash|physical_delivery|offset`',
    `strike_price` DECIMAL(18,2) COMMENT 'For options contracts, the price at which the holder has the right to buy (call) or sell (put) the underlying commodity. Expressed in the currency per unit of measure (e.g., USD per bushel). Null for futures and forward contracts.',
    `trade_date` DATE COMMENT 'The date on which the hedging instrument was executed or entered into. Represents the principal business event date for the hedge transaction, used for mark-to-market valuation and hedge accounting documentation.',
    `transaction_currency` STRING COMMENT 'The ISO 4217 three-letter currency code in which the hedge instrument is denominated (e.g., USD for CME/CBOT contracts, GBP for ICE London contracts). Used for multi-currency consolidation and IFRS/GAAP foreign currency translation.. Valid values are `^[A-Z]{3}$`',
    `variation_margin_balance` DECIMAL(18,2) COMMENT 'The cumulative daily settlement amount reflecting gains and losses on the futures position since inception. Positive indicates net gains credited to the margin account; negative indicates net losses debited. Critical for daily cash flow management and liquidity planning.',
    CONSTRAINT pk_commodity_hedge PRIMARY KEY(`commodity_hedge_id`)
) COMMENT 'Commodity price hedging instrument record capturing futures contracts, options, and forward contracts used to manage price risk for agricultural commodities including grain (corn, wheat, soybeans), oilseeds, cotton, sugar, and livestock (feeder cattle, lean hogs). Captures hedge ID, commodity type, instrument type (futures, options, forward), exchange (CME, CBOT, ICE), contract month, notional quantity (BU/MT/CWT), strike/forward price, premium paid, hedge designation (fair value, cash flow per ASC 815/IFRS 9), effectiveness test result, mark-to-market value, margin requirements, and settlement status. Essential for managing basis risk between local cash prices and exchange-traded futures in agricultural marketing.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`government_program` (
    `government_program_id` BIGINT COMMENT 'Unique surrogate identifier for each government agricultural program enrollment record in the enterprise data platform (Silver Layer primary key).',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: USDA programs (ARC-CO, PLC, CRP, WHIP+) are enrolled and paid per commodity. FSA payment calculations, base acre assignments, and compliance reporting all require linking the program enrollment to the',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity (company code) that enrolled in or receives payments under this government program. Aligns with SAP S/4HANA FI company code.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: government_program has cost_center as a STRING. USDA program payments are allocated to specific farming operation cost centers. Normalizing to a FK enables cost center-level government payment reporti',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: government_program has gl_account as a STRING. USDA program payments are posted to specific GL accounts. Normalizing to a FK to gl_account links government program payments to the authoritative chart ',
    `herd_id` BIGINT COMMENT 'Foreign key linking to livestock.herd. Business justification: USDA livestock programs (LIP, ELAP, LFP) are enrolled against specific herds. Linking government_program to herd supports program payment reconciliation, conservation compliance verification, and FSA ',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to land.parcel. Business justification: CRP, ACEP, and conservation compliance enrollment is recorded at the parcel/tract level by FSA. Regulatory compliance reporting and payment reconciliation require linking government program records to',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: USDA government program enrollment (ARC, CRP, EQIP) requires specific conservation and environmental permits. Agriculture operations must link program enrollment to required permits for conservation_c',
    `production_group_id` BIGINT COMMENT 'Foreign key linking to livestock.production_group. Business justification: USDA livestock indemnity programs (LIP, ELAP) can be claimed at the production group/lot level for specific animal losses. Linking government_program to production_group supports FSA payment calculati',
    `actual_payment_amount` DECIMAL(18,2) COMMENT 'Actual total payment amount received from the government program for the program year, in USD. Recorded upon receipt and reconciled against estimated amounts. Feeds into GL revenue recognition and USDA regulatory reporting.',
    `administering_agency` STRING COMMENT 'Federal or state agency responsible for administering the program. USDA FSA (Farm Service Agency) administers commodity and disaster programs; USDA NRCS (Natural Resources Conservation Service) administers conservation programs; USDA RMA (Risk Management Agency) administers crop insurance programs.. Valid values are `USDA_FSA|USDA_NRCS|USDA_RMA|USDA_AMS|STATE_AGENCY|OTHER`',
    `base_acres` DECIMAL(18,2) COMMENT 'USDA FSA-established base acres for the covered commodity on the farm, representing the historical planted acreage used to calculate ARC-CO and PLC program payments. Distinct from enrolled or planted acres.',
    `conservation_compliance_status` STRING COMMENT 'Status of the farm operations compliance with USDA conservation compliance requirements (Highly Erodible Land Conservation (HELC) and Wetland Conservation (WC) provisions). Non-compliance results in loss of eligibility for most USDA program benefits.. Valid values are `compliant|non_compliant|under_review|exempt|not_applicable`',
    `county_code` STRING COMMENT 'FIPS county code for the county in which the enrolled farm is located and the FSA county office that administers the program. Required for ARC-CO county-level benchmark calculations and USDA reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this government program enrollment record was first created in the enterprise data platform. Supports audit trail requirements under SOX financial controls.',
    `crop_insurance_policy_number` STRING COMMENT 'USDA Risk Management Agency (RMA) / Federal Crop Insurance Corporation (FCIC) policy number for crop insurance programs. Unique identifier linking to the RMA actuarial data and indemnity payment records.',
    `effective_end_date` DATE COMMENT 'Date on which the program enrollment period expires or the contract term concludes. Null for open-ended or multi-year rolling programs.',
    `effective_start_date` DATE COMMENT 'Date on which the program enrollment period begins and the farm operation becomes eligible for program benefits, payments, or coverage.',
    `enrolled_acres` DECIMAL(18,2) COMMENT 'Total number of acres enrolled in the program for the program year. For conservation programs (CRP, EQIP), this is the contracted acreage. For commodity programs, this represents the planted or covered acres.',
    `enrollment_date` DATE COMMENT 'Date on which the farm operation formally enrolled or signed up for the government program with the administering agency.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the farms enrollment in the government program. Drives payment eligibility, compliance monitoring, and revenue planning workflows.. Valid values are `enrolled|pending|approved|suspended|terminated|expired`',
    `estimated_payment_amount` DECIMAL(18,2) COMMENT 'Projected total payment amount expected to be received from the government program for the program year, in USD. Used for farm revenue planning, ROI analysis, and EBITDA forecasting. Calculated based on enrolled acres, base acres, payment yield, and payment rate.',
    `farm_serial_number` STRING COMMENT 'USDA FSA-assigned Farm Serial Number uniquely identifying the farm unit registered with the local FSA county office. Required for commodity program enrollment and payment processing.',
    `helc_determination` STRING COMMENT 'USDA NRCS determination of whether the enrolled land contains Highly Erodible Land (HEL) and whether the farm is in compliance with required conservation practices. Affects program payment eligibility.. Valid values are `no_helc|helc_present_compliant|helc_present_non_compliant|determination_pending`',
    `insurance_coverage_level` DECIMAL(18,2) COMMENT 'Percentage of expected yield or revenue covered by the crop insurance policy (e.g., 70%, 75%, 80%, 85%). Expressed as a decimal percentage. Determines indemnity payment trigger thresholds.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this government program enrollment record was most recently modified in the enterprise data platform. Supports change tracking, data lineage, and SOX audit trail requirements.',
    `livestock_units` DECIMAL(18,2) COMMENT 'Number of livestock units enrolled or covered under livestock-related programs (e.g., ELAP - Emergency Livestock Assistance Program, LFP - Livestock Forage Disaster Program). Expressed in animal units as defined by USDA.',
    `notes` STRING COMMENT 'Free-text field for additional program-specific information, compliance notes, agency correspondence references, or special conditions attached to the enrollment that do not fit structured fields.',
    `payment_currency` STRING COMMENT 'ISO 4217 three-letter currency code for all payment amounts associated with this program record (typically USD for USDA programs). Required for IFRS consolidated financial reporting.. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'Date on which the actual program payment was received from the administering agency. Used for cash flow planning, GL posting date determination, and revenue recognition under GAAP/IFRS.',
    `payment_limitation_amount` DECIMAL(18,2) COMMENT 'Maximum allowable payment amount in USD that the farm operation may receive under USDA payment limitation rules for the program year. Varies by program type and entity structure.',
    `payment_limitation_status` STRING COMMENT 'Indicates whether the farm operations total program payments are within, at, or exceeding USDA-established annual payment limitation caps (e.g., $125,000 per person per year for ARC/PLC). Critical for compliance and payment eligibility monitoring.. Valid values are `within_limit|at_limit|exceeded_limit|not_applicable`',
    `payment_rate` DECIMAL(18,2) COMMENT 'Per-unit payment rate established by the administering agency for the program year (e.g., dollars per base acre for ARC-CO/PLC, dollars per acre per year for CRP, dollars per practice unit for EQIP). Used to calculate estimated and actual payment amounts.',
    `payment_rate_unit` STRING COMMENT 'Unit of measure associated with the payment rate (e.g., per acre, per base acre, per bushel (BU), per hundredweight (CWT), per head of livestock, per conservation practice, per insurance policy). [ENUM-REF-CANDIDATE: per_acre|per_base_acre|per_bushel|per_cwt|per_head|per_practice|per_policy — 7 candidates stripped; promote to reference product]',
    `payment_yield` DECIMAL(18,2) COMMENT 'USDA FSA-established program payment yield (bushels per acre or equivalent unit) for the covered commodity, used in PLC payment calculations. Represents the farms historical average yield.',
    `profit_center` STRING COMMENT 'SAP S/4HANA CO profit center associated with the government program, enabling profitability analysis by farm unit, commodity, or business segment for EBITDA and ROI reporting.',
    `program_code` STRING COMMENT 'Official agency-assigned short code or acronym for the program (e.g., ARC-CO, ARC-IC, PLC, CRP, EQIP, CSP, WHIP+, ERP, ELAP). Used for regulatory reporting and cross-referencing with USDA systems.',
    `program_name` STRING COMMENT 'Full official name of the government agricultural program (e.g., Agriculture Risk Coverage-County Option (ARC-CO), Price Loss Coverage (PLC), Conservation Reserve Program (CRP), Environmental Quality Incentives Program (EQIP), Conservation Stewardship Program (CSP), Whole-Farm Revenue Protection (WFRP)).',
    `program_number` STRING COMMENT 'Externally assigned program or contract number issued by the administering agency (e.g., USDA FSA farm serial number, NRCS contract number, RMA policy number). Used for cross-referencing with agency records.',
    `program_type` STRING COMMENT 'High-level classification of the government program category. Commodity programs include ARC-CO, ARC-IC, PLC. Conservation programs include CRP, EQIP, CSP. Crop insurance covers FCIC/RMA policies. Disaster assistance includes WHIP+, ERP, ELAP. State incentive covers state-level agricultural programs.. Valid values are `commodity|conservation|crop_insurance|disaster_assistance|state_incentive`',
    `program_year` STRING COMMENT 'The federal fiscal or crop year for which the program enrollment and associated payments apply (e.g., 2024). Used for annual revenue planning and USDA reporting cycles.',
    `state_code` STRING COMMENT 'Two-letter US state code (USPS abbreviation) for the state in which the enrolled farm or land is located. Used for state-level program eligibility, FSA county office routing, and geographic reporting.. Valid values are `^[A-Z]{2}$`',
    `tract_number` STRING COMMENT 'USDA FSA-assigned tract number identifying a contiguous block of land within the farm unit. Used for base acre and enrolled acre tracking at the sub-farm level.',
    `wetland_conservation_status` STRING COMMENT 'USDA NRCS determination of wetland conservation compliance on the enrolled land. Farms converting wetlands to crop production may lose eligibility for USDA program benefits under Swampbuster provisions.. Valid values are `no_wetland|wetland_compliant|wetland_non_compliant|determination_pending`',
    CONSTRAINT pk_government_program PRIMARY KEY(`government_program_id`)
) COMMENT 'USDA and government agricultural program enrollment and payment record capturing participation in federal and state farm programs. Covers commodity programs (ARC-CO, ARC-IC, PLC), conservation programs (CRP, EQIP, CSP), crop insurance (FCIC/RMA policies), disaster assistance (WHIP+, ERP, ELAP), and state-level agricultural incentives. Captures program name, administering agency (USDA FSA, NRCS, RMA), enrollment period, enrolled acres/base acres/livestock units, payment rate, estimated and actual payments received, compliance requirements (conservation compliance, HELC/WC), and payment limitation status. Supports farm revenue planning, ROI analysis, and regulatory reporting to USDA.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique surrogate identifier for the bank account record in the enterprise data platform. Primary key for the bank_account data product.',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity (company code) that owns this bank account, aligning with SAP S/4HANA FI company code structure for financial consolidation and GAAP/IFRS reporting.',
    `gl_account_id` BIGINT COMMENT 'Reference to the GL reconciliation account used to post bank transactions and reconcile the bank account balance in the general ledger. Critical for period-close and SOX controls.',
    `parent_bank_account_id` BIGINT COMMENT 'Self-referencing FK on bank_account (parent_bank_account_id)',
    `account_name` STRING COMMENT 'The official account name as registered with the financial institution, typically the legal entity name or operating division name (e.g., AgriCorp Operating Account — Corn Division).',
    `account_number` STRING COMMENT 'The official bank account number assigned by the financial institution. Used for payment disbursements (input purchases, payroll), crop revenue deposits, and operating line of credit draws. Classified as restricted PCI-sensitive financial data.',
    `account_status` STRING COMMENT 'Current lifecycle status of the bank account. Frozen accounts may indicate regulatory holds or fraud investigations. Closed accounts are retained for historical audit trails per SOX requirements.. Valid values are `active|inactive|frozen|closed|pending_activation`',
    `account_type` STRING COMMENT 'Classification of the bank account by its functional purpose within agricultural cash management. Operating accounts handle day-to-day input payments and crop revenue; escrow accounts hold seasonal advance payments; money market accounts manage short-term liquidity between planting and harvest cycles.. Valid values are `operating|savings|escrow|money_market|payroll|credit_line`',
    `available_balance` DECIMAL(18,2) COMMENT 'Funds immediately available for disbursement after deducting outstanding checks, pending ACH debits, and holds. Distinct from ledger balance; used for real-time cash availability decisions during peak input purchasing seasons.',
    `balance_date` DATE COMMENT 'The date as of which the daily_balance was last recorded or confirmed. Ensures temporal accuracy of cash position reporting for period-close reconciliation and treasury management.',
    `bank_branch_address` STRING COMMENT 'Physical street address of the bank branch. Used for correspondence, check mailing, and regulatory documentation for USDA program payment accounts and Farm Credit lending relationships.',
    `bank_branch_name` STRING COMMENT 'Name of the specific bank branch where the account is held. Relevant for agricultural enterprises with regional banking relationships tied to specific farm credit districts or local agricultural lending offices.',
    `bank_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the bank branch is domiciled (e.g., USA, CAN, BRA). Determines applicable banking regulations, currency controls, and SWIFT routing conventions for international agricultural trade settlements.. Valid values are `^[A-Z]{3}$`',
    `bank_name` STRING COMMENT 'Full legal name of the financial institution holding the account (e.g., Farm Credit Services of America, AgriBank FCB, Wells Fargo Bank N.A.). Used for counterparty identification in payment processing and banking relationship management.',
    `bank_statement_frequency` STRING COMMENT 'Frequency at which bank statements are received and processed for reconciliation. Daily statements are typical for high-volume operating accounts during planting and harvest seasons; monthly for savings and escrow accounts.. Valid values are `daily|weekly|monthly|quarterly`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank account record was first created in the enterprise data platform. Supports audit trail requirements for SOX financial controls and data lineage tracking.',
    `credit_facility_drawn` DECIMAL(18,2) COMMENT 'Current outstanding drawn balance on the operating line of credit associated with this account. Tracks seasonal borrowing against the credit facility limit for input financing and working capital management.',
    `credit_facility_limit` DECIMAL(18,2) COMMENT 'Maximum approved credit limit on the operating line of credit linked to this account. Agricultural enterprises rely on seasonal operating lines to finance seed, fertilizer (NPK), and crop protection inputs ahead of harvest revenue. Null for non-credit accounts.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the accounts operating currency (e.g., USD, EUR, BRL, CAD). Determines the base currency for all transactions posted to this account and drives foreign exchange revaluation in multi-currency agricultural operations.. Valid values are `^[A-Z]{3}$`',
    `daily_balance` DECIMAL(18,2) COMMENT 'Most recent end-of-day ledger balance for the account as reported by the bank or treasury management system. Critical for seasonal cash flow monitoring during planting and harvest cycles, operating line of credit management, and daily liquidity reporting.',
    `dual_signatory_required` BOOLEAN COMMENT 'Indicates whether this account requires dual authorization (two signatories) for payment transactions above the single-signatory threshold. Enforces segregation of duties as a SOX internal control for high-value agricultural disbursements.',
    `effective_from_date` DATE COMMENT 'Date from which this bank account became active and available for use in enterprise payment processing. Used for temporal validity tracking in SAP S/4HANA and for audit trail purposes.',
    `effective_to_date` DATE COMMENT 'Date on which this bank account ceases to be valid for payment processing. Null for open-ended active accounts. Closed accounts retain this date for historical audit trail and SOX compliance documentation.',
    `house_bank_account_id_code` STRING COMMENT 'SAP S/4HANA house bank account ID (sub-account identifier within the house bank) used in payment program configuration. Distinguishes between multiple accounts at the same bank (e.g., operating vs. payroll vs. escrow accounts at the same institution).',
    `house_bank_code` STRING COMMENT 'SAP S/4HANA house bank identifier that groups bank accounts under a single banking institution within the enterprise. Used in automatic payment program (APP) configuration to route payments through the correct bank for input supplier disbursements and crop revenue collections.',
    `iban` STRING COMMENT 'International Bank Account Number used for cross-border payment processing in SEPA and other international banking zones. Required for European agricultural trade partners and international commodity export settlements.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$`',
    `last_reconciliation_date` DATE COMMENT 'Date of the most recent completed bank reconciliation for this account. Tracks reconciliation currency for period-close management and SOX control compliance. Unreconciled accounts past due date trigger escalation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this bank account record. Used for change data capture (CDC), audit trail maintenance, and SOX control evidence of master data governance.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'Approved overdraft protection limit for the account. Provides short-term liquidity buffer during peak agricultural disbursement periods (e.g., planting season input payments) before crop revenue is received.',
    `payment_method_code` STRING COMMENT 'Primary payment method configured for outgoing disbursements from this account in the automatic payment program (APP). Determines how AP payments for seeds, fertilizers, crop protection chemicals, and equipment are processed.. Valid values are `ACH|WIRE|CHECK|EFT|SEPA|SWIFT`',
    `primary_signatory_name` STRING COMMENT 'Full name of the primary authorized signatory for the bank account. Required for check signing authority, wire transfer approvals, and banking mandate documentation. Part of SOX internal control documentation for financial authorization.',
    `purpose_description` STRING COMMENT 'Free-text description of the specific business purpose of this bank account (e.g., Corn and Soybean Crop Revenue Collection — Midwest Region, Seasonal Input Supplier Payments — Spring Planting, USDA CRP Program Payment Receipt Account).',
    `reconciliation_status` STRING COMMENT 'Current reconciliation status of the bank account for the most recent statement period. Unreconciled status triggers period-close blocking actions per SOX financial controls.. Valid values are `reconciled|in_progress|unreconciled|pending_review`',
    `routing_number` STRING COMMENT 'American Bankers Association (ABA) routing transit number identifying the financial institution for domestic ACH and wire transfers. Used for input supplier payments, USDA program payment receipts, and payroll disbursements within the US banking system.. Valid values are `^[0-9]{9}$`',
    `secondary_signatory_name` STRING COMMENT 'Full name of the secondary authorized signatory for dual-control payment authorization. Dual-signatory requirements are common for large agricultural enterprises to satisfy SOX internal control requirements for high-value transactions.',
    `single_signatory_limit` DECIMAL(18,2) COMMENT 'Maximum transaction amount that a single authorized signatory can approve without requiring dual authorization. Transactions above this threshold require dual-signatory approval per SOX internal control policies.',
    `source_system` STRING COMMENT 'Operational system of record from which this bank account master record originates. SAP S/4HANA FI is the primary source for enterprise accounts; Oracle NetSuite for subsidiary entities; Granular Farm Management for farm-level accounts.. Valid values are `SAP_S4HANA|ORACLE_NETSUITE|GRANULAR|MANUAL`',
    `swift_bic_code` STRING COMMENT 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Business Identifier Code for international wire transfers. Required for cross-border agricultural commodity payments, CIF/FOB trade settlements, and foreign currency transactions with international suppliers and buyers.. Valid values are `^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `usda_program_account` BOOLEAN COMMENT 'Indicates whether this account is designated to receive USDA government program payments (e.g., ARC, PLC, CRP, EQIP, CSP). USDA program accounts require specific tracking for government payment compliance and farm program reporting.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Bank account master representing enterprise banking relationships and cash management accounts used for agricultural operations. Captures bank account number, bank name, bank routing/SWIFT/BIC, account type (operating, savings, escrow, money market), currency, company code, GL reconciliation account, signatory authorities, daily balance, credit facility linkage, and active status. Critical for seasonal cash flow management, crop revenue deposits, input payment disbursements, and operating line of credit draws in agricultural enterprises.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`loan` (
    `loan_id` BIGINT COMMENT 'Unique system-generated identifier for each loan or credit facility record in the agricultural enterprise debt portfolio.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Loans are disbursed to and repaid from specific bank accounts. Linking loan to bank_account enables cash management integration, showing which bank account receives loan proceeds and from which accoun',
    `herd_id` BIGINT COMMENT 'Foreign key linking to livestock.herd. Business justification: Livestock herds are pledged as collateral for FSA operating loans and commercial lines of credit. Linking loan to herd (as collateral) supports lender reporting, collateral valuation updates, and cove',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: CCC commodity loans, FSA marketing assistance loans, and operating lines secured by grain inventory are tied to specific commodities. Linking commodity_id supports commodity loan balance reporting, co',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity (company code) under which this loan is held, supporting consolidated financial reporting per GAAP/IFRS.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for servicing this loan (e.g., farm operations, equipment division). Enables interest expense allocation by business unit in SAP S/4HANA CO for EBITDA reporting.',
    `farm_unit_id` BIGINT COMMENT 'Foreign key linking to land.farm_unit. Business justification: FSA operating loans and farm lines of credit are issued to specific farm operations. Farm financial managers track debt-to-asset ratios and loan covenants by farm unit. FSA loan number on loan table m',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: loan has gl_account_code as a STRING. Loan balances and interest are posted to specific GL accounts (long-term debt, interest expense). Normalizing to a FK to gl_account links the loan to the authorit',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to land.parcel. Business justification: Agricultural real estate loans and FSA guaranteed loans are collateralized against specific parcels. Lenders and farm financial managers track which parcels secure which loans for lien management, tit',
    `parent_loan_id` BIGINT COMMENT 'Self-referencing FK on loan (parent_loan_id)',
    `accrued_interest_amount` DECIMAL(18,2) COMMENT 'Interest expense accrued since the last payment date but not yet paid. Required for period-end accrual journal entries in SAP S/4HANA FI and accurate EBITDA reporting.',
    `available_credit_amount` DECIMAL(18,2) COMMENT 'Undrawn portion of the credit facility available for future draws (credit_limit_amount minus outstanding_balance). Critical for seasonal liquidity planning and crop input purchasing decisions.',
    `capex_opex_indicator` STRING COMMENT 'Classifies the loan proceeds as Capital Expenditure (CAPEX — land, equipment, infrastructure), Operational Expenditure (OPEX — seasonal inputs, operating costs), or mixed. Drives GL account assignment and financial statement classification.. Valid values are `CAPEX|OPEX|mixed`',
    `collateral_description` STRING COMMENT 'Narrative description of the specific assets pledged as collateral (e.g., Section 14 T2N R5E 320 acres farmland, John Deere 8R 410 tractor SN XXXXXXX). Supports lien filing and asset encumbrance management.',
    `collateral_type` STRING COMMENT 'Primary category of assets pledged as security for the loan. Agricultural loans are commonly secured by farmland, equipment, standing crops, or livestock. Drives lender risk assessment and asset encumbrance tracking. [ENUM-REF-CANDIDATE: land|equipment|crop|livestock|accounts_receivable|blanket_lien — promote to reference product]. Valid values are `land|equipment|crop|livestock|accounts_receivable|blanket_lien`',
    `collateral_valuation_date` DATE COMMENT 'Date on which the collateral was most recently appraised or valued. Lenders typically require periodic revaluation; this date triggers renewal workflows.',
    `collateral_value_amount` DECIMAL(18,2) COMMENT 'Appraised or estimated market value of the pledged collateral at the most recent valuation date. Used to calculate loan-to-value (LTV) ratios and assess collateral coverage adequacy.',
    `covenant_compliance_status` STRING COMMENT 'Current compliance state with respect to all financial covenants on this loan. A breach status triggers escalation to CFO and legal counsel and may require SOX disclosure. Monitored at each period close.. Valid values are `compliant|waiver_obtained|breach|under_review`',
    `covenant_description` STRING COMMENT 'Summary of key financial covenants attached to the loan agreement (e.g., minimum current ratio of 1.25:1, maximum debt-to-asset ratio of 0.50, minimum working capital of $500,000). Covenant breaches can trigger acceleration clauses.',
    `covenant_review_date` DATE COMMENT 'Date of the most recent covenant compliance review or test. Lenders typically require quarterly or annual covenant testing; this date drives the next review scheduling.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this loan record was first created in the data platform. Supports audit trail requirements under SOX and data lineage tracking in the Databricks Silver Layer.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum authorized borrowing capacity under a revolving line of credit or operating line. Applicable to operating lines and seasonal crop production facilities. Null for fully-drawn term loans.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this loan record (e.g., USD for US Dollar). Supports multi-currency consolidation in IFRS reporting.. Valid values are `^[A-Z]{3}$`',
    `draw_period_end_date` DATE COMMENT 'Last date on which the borrower may draw funds under a revolving credit facility or operating line of credit. After this date, the facility enters repayment-only mode. Specific to revolving and seasonal crop production lines.',
    `fsa_guarantee_percentage` DECIMAL(18,2) COMMENT 'Percentage of the loan principal guaranteed by the USDA Farm Service Agency under the Business and Industry (B&I) or Farm Loan Programs (e.g., 90.00 = 90%). Null for non-guaranteed loans. Reduces lender risk and may affect interest rate terms.',
    `fsa_loan_number` STRING COMMENT 'USDA Farm Service Agency assigned loan identifier for FSA direct or guaranteed loans. Required for federal program reporting, subsidy tracking, and USDA compliance filings. Null for non-FSA loans.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate expressed as a decimal (e.g., 0.06500 = 6.5%). For variable-rate loans, this reflects the current effective rate including the benchmark plus spread. Used for interest expense accrual in SAP S/4HANA CO and EBITDA reporting.',
    `interest_rate_type` STRING COMMENT 'Indicates whether the interest rate is fixed for the loan term, variable (tied to a benchmark such as SOFR or Prime Rate), or hybrid (fixed for an initial period then variable). Drives interest expense forecasting and hedge accounting decisions.. Valid values are `fixed|variable|hybrid`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this loan record. Supports change data capture (CDC) processing in the Databricks Silver Layer and SOX audit trail requirements.',
    `lender_name` STRING COMMENT 'Name of the lending institution providing the debt facility (e.g., Farm Credit Services of America, Rabobank, Wells Fargo Agribusiness, USDA Farm Service Agency). Essential for counterparty risk management and lender relationship tracking.',
    `lender_type` STRING COMMENT 'Category of the lending institution. Farm Credit institutions are government-sponsored enterprises; FSA loans carry federal guarantees; commercial banks and cooperatives operate under standard banking regulations. Informs interest rate benchmarking and covenant expectations.. Valid values are `farm_credit|commercial_bank|fsa|cooperative|insurance_company|private`',
    `loan_number` STRING COMMENT 'Externally-known loan reference number assigned by the lender (e.g., Farm Credit loan number, commercial bank reference, FSA loan number). Used for lender correspondence and payment remittances.',
    `loan_status` STRING COMMENT 'Current lifecycle state of the loan. Drives financial reporting classifications (current vs. non-current debt), covenant monitoring, and SOX control checkpoints.. Valid values are `active|paid_off|defaulted|restructured|pending_approval|cancelled`',
    `loan_type` STRING COMMENT 'Classification of the debt instrument. Operating lines of credit fund seasonal inputs; term loans finance equipment or land; FSA guaranteed loans are backed by the USDA Farm Service Agency; crop production loans are secured against future harvest revenue. [ENUM-REF-CANDIDATE: operating_line_of_credit|term_loan|fsa_guaranteed|crop_production|equipment_loan|real_estate_mortgage — promote to reference product]. Valid values are `operating_line_of_credit|term_loan|fsa_guaranteed|crop_production|equipment_loan|real_estate_mortgage`',
    `maturity_date` DATE COMMENT 'Contractual date on which the full outstanding principal and any accrued interest are due. Drives current vs. non-current debt classification on the balance sheet and triggers covenant review processes.',
    `next_payment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the next scheduled payment including both principal and interest components. Supports cash flow planning and AP payment run preparation in SAP S/4HANA.',
    `next_payment_date` DATE COMMENT 'Date on which the next scheduled principal or interest payment is due to the lender. Used for cash flow forecasting, AP payment scheduling in SAP S/4HANA, and covenant compliance monitoring.',
    `origination_date` DATE COMMENT 'Date the loan agreement was executed and funds were first made available. Establishes the start of the amortization schedule and the effective date for interest accrual. Aligns with GAAP ASC 470 initial recognition.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current unpaid principal balance as of the last payment or draw event. Critical for balance sheet reporting, debt covenant compliance monitoring, and EBITDA-to-debt ratio calculations.',
    `payment_frequency` STRING COMMENT 'Scheduled frequency of principal and/or interest payments. Agricultural loans often use seasonal or annual schedules aligned with harvest revenue cycles rather than standard monthly amortization.. Valid values are `monthly|quarterly|semi_annual|annual|at_maturity|seasonal`',
    `principal_amount` DECIMAL(18,2) COMMENT 'Original face value of the loan at origination. Used as the baseline for amortization schedules, interest calculations, and CAPEX/OPEX debt tracking in SAP S/4HANA FI.',
    `purpose_description` STRING COMMENT 'Business purpose for which the loan proceeds are used (e.g., Purchase of 640-acre irrigated corn ground, Seasonal operating inputs for 2024 corn/soybean crop, John Deere combine acquisition). Required for CAPEX/OPEX classification and USDA program eligibility.',
    `rate_benchmark` STRING COMMENT 'Reference rate index used as the base for variable-rate loans (e.g., SOFR — Secured Overnight Financing Rate, Prime Rate, Farm Credit index). Null for fixed-rate instruments. Required for interest rate risk management and hedge effectiveness testing.. Valid values are `SOFR|prime_rate|libor|fixed|farm_credit_index|other`',
    `rate_spread_bps` DECIMAL(18,2) COMMENT 'Margin added to the benchmark rate expressed in basis points (e.g., 150 = 1.50%). Combined with the benchmark to derive the effective interest rate for variable-rate loans. Used in interest expense modeling and commodity hedge accounting.',
    `source_system` STRING COMMENT 'Operational system of record from which this loan record was sourced (e.g., SAP S/4HANA FI, Oracle NetSuite, Granular Farm Management). Supports data lineage tracking and reconciliation in the Databricks Silver Layer.. Valid values are `SAP_S4HANA|Oracle_NetSuite|Granular|manual`',
    `sox_control_relevant` BOOLEAN COMMENT 'Indicates whether this loan is subject to SOX internal control requirements (True = in-scope for SOX 302/404 controls). Material debt instruments require documented controls over completeness, accuracy, and valuation of the liability.',
    CONSTRAINT pk_loan PRIMARY KEY(`loan_id`)
) COMMENT 'Loan and credit facility master tracking all debt instruments held by the agricultural enterprise including operating lines of credit, term loans for equipment/land, FSA guaranteed loans, and seasonal crop production loans. Captures loan ID, lender (Farm Credit, commercial bank, FSA), loan type, principal amount, outstanding balance, interest rate (fixed/variable), maturity date, collateral (land, equipment, crop), covenant requirements, payment schedule, and draw/repayment history. Essential for ag financial planning where seasonal borrowing against future crop revenue is standard practice.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key for payment_run',
    `approved_by_user_employee_id` BIGINT COMMENT 'Reference to the user who approved this payment run. Ensures segregation of duties per SOX requirements.',
    `bank_account_id` BIGINT COMMENT 'Reference to the corporate bank account from which payments in this run will be disbursed.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Payment runs are executed within a legal entity context. Currently denormalized as company_code (STRING). Normalizing to company_code_id FK enables referential integrity and proper consolidation. Remo',
    `cost_center_id` BIGINT COMMENT 'Reference to the primary cost center responsible for the payments in this run. Used for cost allocation and management reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this payment run. Required for audit trails and Sarbanes-Oxley (SOX) compliance.',
    `parent_payment_run_id` BIGINT COMMENT 'Self-referencing FK on payment_run (parent_payment_run_id)',
    `approval_workflow_code` BIGINT COMMENT 'Reference to the approval workflow instance that governed the authorization process for this payment run. Supports multi-level approval requirements.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the payment run was approved by an authorized approver. Required for Sarbanes-Oxley (SOX) compliance and audit trails.',
    `batch_reference` STRING COMMENT 'External batch or file reference number assigned by the banking system or payment processor when the payment file was transmitted.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all payments in this run (e.g., USD, EUR, CAD). All payment amounts within a single run must be in the same currency.',
    `payment_run_description` STRING COMMENT 'Free-text description providing additional context about the purpose or scope of this payment run (e.g., Weekly vendor payments for harvest supplies, Monthly grower settlements for corn crop).',
    `error_message` STRING COMMENT 'System-generated error or exception message if the payment run encountered processing failures. Used for troubleshooting and operational support.',
    `execution_timestamp` TIMESTAMP COMMENT 'The precise date and time when the payment run was executed and payments were transmitted to the banking system or payment processor.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year to which this payment run is assigned.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this payment run is assigned for financial reporting and budgeting purposes.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this payment run is part of a recurring schedule (e.g., weekly payroll, monthly rent). True if recurring, False if ad-hoc.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payment run record was last modified.',
    `notes` STRING COMMENT 'Internal notes or comments added by treasury or accounts payable staff regarding special handling, exceptions, or other operational details.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used for disbursements in this run (e.g., Automated Clearing House (ACH), wire transfer, physical check, Electronic Funds Transfer (EFT)).',
    `payment_priority` STRING COMMENT 'Priority level assigned to this payment run for processing and cash management purposes. Urgent payments may require expedited approval and same-day execution.',
    `payment_terms` STRING COMMENT 'Standard payment terms applied to this run (e.g., Net 30, Net 60, Immediate). Inherited from vendor master data but captured here for reporting consistency.',
    `posting_date` DATE COMMENT 'The accounting date on which the payment run transactions are posted to the General Ledger (GL). Used for period-end close and financial reporting.',
    `reconciliation_date` DATE COMMENT 'The date on which the payment run was reconciled with bank statements.',
    `reconciliation_status` STRING COMMENT 'Indicates whether the payment run has been reconciled against bank statements and whether any discrepancies were identified.',
    `recurrence_pattern` STRING COMMENT 'Describes the recurrence schedule if is_recurring is True (e.g., Weekly on Friday, Monthly on 15th, Bi-weekly). Null for ad-hoc runs.',
    `run_number` STRING COMMENT 'Business identifier for the payment run, formatted as PR-YYYYMMDD-NNNN for external reference and audit trails.',
    `run_type` STRING COMMENT 'Classification of the payment run based on payee category. Determines routing, approval workflows, and compliance requirements.',
    `scheduled_date` DATE COMMENT 'The date on which payments in this run are scheduled to be executed. Used for cash flow planning and vendor communication.',
    `source_system` STRING COMMENT 'The originating system or module that generated this payment run (e.g., SAP S/4HANA FI, Oracle NetSuite AP, custom grower settlement system).',
    `payment_run_status` STRING COMMENT 'Current lifecycle status of the payment run. Tracks progression from draft through approval, processing, and completion or cancellation.',
    `total_deduction_amount` DECIMAL(18,2) COMMENT 'The sum of all deductions applied across payments in this run, including tax withholdings, advances, and other adjustments.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'The sum of all gross payment amounts before any deductions, adjustments, or fees. Represents the total obligation to payees.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'The sum of all net payment amounts after deductions. This is the actual cash outflow from the corporate bank account.',
    `total_payment_count` STRING COMMENT 'The total number of individual payment transactions included in this payment run.',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Master reference table for payment_run. Referenced by payment_run_id.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Primary key for profit_center',
    `business_unit_id` BIGINT COMMENT 'Reference to the business unit or division that owns and manages this profit center for strategic planning and performance evaluation.',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity company code under which this profit center operates for financial accounting purposes.',
    `controlling_area_id` BIGINT COMMENT 'Reference to the controlling area (CO) organizational unit that manages cost accounting and profitability analysis for this profit center.',
    `cost_center_id` BIGINT COMMENT 'Reference to the default cost center associated with this profit center for overhead allocation and cost tracking.',
    `created_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who created this profit center record, used for audit trail and accountability.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or manager who is accountable for the financial performance and operational results of this profit center.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified this profit center record, used for audit trail and accountability.',
    `parent_profit_center_id` BIGINT COMMENT 'Reference to the parent profit center in the organizational hierarchy for roll-up reporting and consolidated financial analysis. Null for top-level profit centers.',
    `budget_allocation_method` STRING COMMENT 'Method used to allocate corporate overhead and shared service costs to this profit center for budgeting and variance analysis.',
    `closure_date` DATE COMMENT 'Actual date when this profit center was closed or deactivated, preventing further financial postings. Null if still active.',
    `closure_reason` STRING COMMENT 'Business justification or reason for closing this profit center, used for audit trail and organizational change tracking.',
    `cogs_allocation_basis` STRING COMMENT 'Basis used to allocate cost of goods sold to this profit center for gross margin calculation and profitability analysis.',
    `commodity_type` STRING COMMENT 'Primary agricultural commodity or product category that this profit center focuses on for revenue generation and cost of goods sold (COGS) allocation.',
    `consolidation_flag` BOOLEAN COMMENT 'Indicates whether this profit center is included in consolidated financial statements and regulatory filings.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the primary country of operation for this profit center, used for tax jurisdiction and regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this profit center record was first created in the system, used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the local operating currency for this profit center used in financial transactions and reporting.',
    `geographic_region` STRING COMMENT 'Geographic region or territory where this profit center operates, used for regional profitability analysis and market segmentation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this profit center record, used for change tracking and audit compliance.',
    `notes` STRING COMMENT 'Free-form text field for additional business context, special instructions, or operational notes related to this profit center.',
    `profit_center_code` STRING COMMENT 'External business identifier code for the profit center used in financial reporting and consolidation. Typically alphanumeric format aligned with chart of accounts structure.',
    `profit_center_hierarchy_level` STRING COMMENT 'Numeric level in the profit center organizational hierarchy, with 1 being the top consolidated level and higher numbers representing more granular operational units.',
    `profit_center_name` STRING COMMENT 'Full business name of the profit center used for identification in financial statements and management reports.',
    `profit_center_type` STRING COMMENT 'Classification of the profit center by operational function within the agriculture business (e.g., crop production, livestock operations, processing facilities, distribution centers).',
    `revenue_recognition_method` STRING COMMENT 'Accounting method used to recognize revenue for this profit center in accordance with GAAP/IFRS standards and agriculture industry practices.',
    `segment_reporting_flag` BOOLEAN COMMENT 'Indicates whether this profit center represents a reportable segment under ASC 280 or IFRS 8 segment reporting requirements.',
    `short_name` STRING COMMENT 'Abbreviated name or acronym for the profit center used in condensed reports and dashboards.',
    `sox_control_scope` BOOLEAN COMMENT 'Indicates whether this profit center is within the scope of Sarbanes-Oxley Act financial controls and audit requirements.',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center indicating whether it is operational and available for financial postings.',
    `transfer_pricing_method` STRING COMMENT 'Method used to price inter-company or inter-profit-center transactions for internal management reporting and tax compliance.',
    `valid_from_date` DATE COMMENT 'Date from which this profit center became active and available for financial postings and reporting.',
    `valid_to_date` DATE COMMENT 'Date until which this profit center remains active. Null indicates no planned end date. Used for historical analysis and period-based reporting.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Master reference table for profit_center. Referenced by profit_center_id.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'Primary key for wbs_element',
    `commodity_id` BIGINT COMMENT 'Reference to the agricultural commodity (crop type, livestock category) for which this WBS element tracks costs. Used for COGS allocation by commodity.',
    `company_code_id` BIGINT COMMENT 'Reference to the legal entity company code for financial consolidation and statutory reporting per GAAP/IFRS requirements.',
    `controlling_area_id` BIGINT COMMENT 'Reference to the controlling area for management accounting, cost allocation, and internal reporting purposes.',
    `created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this WBS element record. Required for audit trail and SOX compliance.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or manager accountable for delivering the WBS element scope and managing its budget.',
    `functional_area_id` BIGINT COMMENT 'Reference to the functional area for cost-of-sales accounting and functional expense classification per GAAP/IFRS requirements.',
    `program_id` BIGINT COMMENT 'Reference to the multi-year investment program or capital plan to which this WBS element contributes. Used for long-term CAPEX tracking.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this WBS element record. Required for change tracking and SOX compliance.',
    `parent_wbs_element_id` BIGINT COMMENT 'Reference to the parent WBS element in the hierarchical project structure. Null for top-level WBS elements.',
    `plant_id` BIGINT COMMENT 'Reference to the agricultural production facility, processing plant, or operational site associated with this WBS element for location-based cost tracking.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center for internal profitability analysis and segment reporting. Used for EBITDA and ROI tracking by business unit.',
    `capital_project_id` BIGINT COMMENT 'Reference to the parent project to which this WBS element belongs. Links WBS element to the overarching project structure.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for managing and executing activities under this WBS element. Used for cost center accounting and budget control.',
    `account_assignment_element_indicator` BOOLEAN COMMENT 'Flag indicating whether this WBS element can be used as an account assignment object for purchase orders, invoices, and other financial documents. True if account-assignment-relevant, False otherwise.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Total actual costs posted to this WBS element from invoices, payroll, and other financial transactions. Used for budget variance reporting.',
    `applicant_name` STRING COMMENT 'Name of the person or department who requested the creation of this WBS element. Used for audit trail and approval workflows.',
    `approval_date` DATE COMMENT 'Date when the WBS element and its budget were formally approved by authorized management. Required for SOX compliance and financial controls.',
    `billing_element_indicator` BOOLEAN COMMENT 'Flag indicating whether this WBS element is used as a billing element for customer invoicing. True if billing-relevant, False otherwise.',
    `budget_type` STRING COMMENT 'Classification of the WBS element budget as capital expenditure (CAPEX), operational expenditure (OPEX), or mixed for financial statement categorization.',
    `committed_cost_amount` DECIMAL(18,2) COMMENT 'Total amount of purchase orders and commitments issued against this WBS element but not yet invoiced. Used for funds availability checking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this WBS element record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts associated with this WBS element. Used for multi-currency consolidation.',
    `end_date` DATE COMMENT 'Planned or actual completion date for activities under this WBS element. Used for project milestone tracking and schedule variance analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this WBS element record was last updated. Used for change tracking and audit compliance per SOX requirements.',
    `planned_budget_amount` DECIMAL(18,2) COMMENT 'The original approved budget amount allocated to this WBS element for planning and variance analysis purposes.',
    `planning_element_indicator` BOOLEAN COMMENT 'Flag indicating whether this WBS element is used for project planning and scheduling activities. True if planning-relevant, False otherwise.',
    `results_analysis_key` STRING COMMENT 'Configuration key controlling revenue recognition method and work-in-progress calculation for this WBS element per GAAP/IFRS revenue recognition standards.',
    `revised_budget_amount` DECIMAL(18,2) COMMENT 'The current revised budget amount after approved budget changes, supplements, or reallocations. Used for current-period budget control.',
    `settlement_profile` STRING COMMENT 'Configuration key defining how costs accumulated on this WBS element are settled to receiving cost objects (assets, GL accounts, cost centers) at period-end.',
    `start_date` DATE COMMENT 'Planned or actual start date for activities under this WBS element. Used for project scheduling and timeline tracking.',
    `statistical_indicator` BOOLEAN COMMENT 'Flag indicating whether this WBS element is used only for statistical reporting purposes without actual cost postings. True if statistical, False if operational.',
    `wbs_element_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying the WBS element in project management and financial systems. Used for cost allocation and project tracking.',
    `wbs_element_description` STRING COMMENT 'Detailed description of the WBS elements scope, purpose, and deliverables within the project hierarchy.',
    `wbs_element_name` STRING COMMENT 'Human-readable name or title of the WBS element describing the project phase, deliverable, or cost object.',
    `wbs_element_status` STRING COMMENT 'Current lifecycle status of the WBS element indicating its operational state within the project execution workflow.',
    `wbs_element_type` STRING COMMENT 'Classification of the WBS element by its functional purpose: planning (for project planning), billing (for customer invoicing), account_assignment (for cost allocation), or statistical (for reporting only).',
    `wbs_level` STRING COMMENT 'Hierarchical level of the WBS element within the project structure. Level 1 represents top-level elements, with increasing numbers for deeper nesting.',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Master reference table for wbs_element. Referenced by wbs_element_id.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`close_calendar` (
    `close_calendar_id` BIGINT COMMENT 'Primary key for close_calendar',
    `parent_close_calendar_id` BIGINT COMMENT 'Self-referencing FK on close_calendar (parent_close_calendar_id)',
    `actual_close_date` DATE COMMENT 'The actual date on which the close process was completed and the period was closed. Null if the period is still open or in progress.',
    `adjustment_posting_allowed` BOOLEAN COMMENT 'Indicates whether adjustment entries (journal entries, accruals, reclassifications) are allowed during soft close or after reopening. Supports controlled close process.',
    `audit_completion_date` DATE COMMENT 'The date on which external audit procedures for this period were completed and the audit opinion was issued. Null if audit is not required or not yet complete.',
    `audit_required` BOOLEAN COMMENT 'Indicates whether this close period requires external audit review (typically true for annual and quarterly reporting periods).',
    `calendar_month` STRING COMMENT 'The calendar month (1-12) in which this close period ends. Used for calendar-year reporting alignment.',
    `calendar_quarter` STRING COMMENT 'The calendar quarter (1-4) in which this close period ends. Used for calendar-year reporting alignment.',
    `calendar_year` STRING COMMENT 'The calendar year in which this close period ends. May differ from fiscal year for organizations with non-calendar fiscal years.',
    `close_due_date` DATE COMMENT 'Target date by which the close process for this period must be completed. Used for close calendar planning and compliance tracking.',
    `close_status` STRING COMMENT 'Current lifecycle status of the close period: open (accepting transactions), soft_close (preliminary close, limited posting allowed), hard_close (final close, restricted posting), closed (finalized, no posting), reopened (closed period reopened for adjustments), locked (permanently closed per SOX controls).',
    `consolidation_completion_date` DATE COMMENT 'The date on which consolidation of all entities for this period was completed. Null if consolidation is not required or not yet complete.',
    `consolidation_required` BOOLEAN COMMENT 'Indicates whether this period requires consolidation of subsidiary and business unit financial results into consolidated financial statements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this close calendar record was first created in the system.',
    `close_calendar_description` STRING COMMENT 'Detailed description of the close period, including any special circumstances, adjustments, or notes relevant to this period (e.g., Includes acquisition of XYZ Corp, Restated for accounting policy change).',
    `fiscal_period` STRING COMMENT 'The fiscal period number within the fiscal year (1-12 for monthly, 1-13 for 4-4-5 calendar). Represents the sequential period within the year.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter within the fiscal year (1, 2, 3, or 4). Null for annual or monthly periods that do not align to quarters.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this close period belongs (e.g., 2024).',
    `hard_close_date` DATE COMMENT 'The date on which the period entered hard close status, restricting most posting activities and finalizing preliminary results.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this close calendar record is currently active and in use. False for deprecated or historical periods no longer referenced.',
    `lock_date` DATE COMMENT 'The date on which the period was permanently locked, preventing any further posting or adjustments per SOX compliance requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this close calendar record was last modified or updated.',
    `notes` STRING COMMENT 'Additional operational notes or comments related to the close process for this period, such as delays, issues encountered, or special approvals required.',
    `period_code` STRING COMMENT 'Standardized code identifying the close period, typically used in financial systems (e.g., 2024-01, Q1-2024, FY2024).',
    `period_end_date` DATE COMMENT 'The last calendar date included in this close period. Transactions on or before this date belong to this period.',
    `period_name` STRING COMMENT 'Business-friendly name for the accounting close period (e.g., January 2024 Close, Q1 FY2024 Close, Year-End 2023).',
    `period_start_date` DATE COMMENT 'The first calendar date included in this close period. Transactions on or after this date belong to this period.',
    `period_type` STRING COMMENT 'Classification of the close period by duration: monthly for standard monthly close, quarterly for quarter-end close, annual for year-end close, special for ad-hoc or adjustment periods.',
    `posting_allowed` BOOLEAN COMMENT 'Indicates whether transaction posting is currently allowed for this period. True if open or soft close, false if hard close, closed, or locked.',
    `reopen_date` DATE COMMENT 'The date on which a previously closed period was reopened for adjustments. Null if the period has never been reopened.',
    `reporting_period` BOOLEAN COMMENT 'Indicates whether this period is a formal reporting period requiring consolidated financial statements and regulatory filings (e.g., quarterly, annual). False for internal-only or special periods.',
    `soft_close_date` DATE COMMENT 'The date on which the period entered soft close status, allowing preliminary reporting while final adjustments are processed.',
    `sox_compliant` BOOLEAN COMMENT 'Indicates whether this close period has met all Sarbanes-Oxley Act internal control and audit requirements. True when all SOX controls have been executed and documented.',
    `working_days` STRING COMMENT 'The number of business working days within this close period, excluding weekends and holidays. Used for operational planning and productivity analysis.',
    CONSTRAINT pk_close_calendar PRIMARY KEY(`close_calendar_id`)
) COMMENT 'Master reference table for close_calendar. Referenced by close_calendar_id.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`patronage_distribution` (
    `patronage_distribution_id` BIGINT COMMENT 'Primary key for patronage_distribution',
    `account_id` BIGINT COMMENT 'Identifier of the cooperative member receiving the patronage distribution.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Patronage distributions are cooperative-specific financial transactions that must be tracked by legal entity for regulatory reporting and tax compliance. Each distribution is issued by one company cod',
    `employee_id` BIGINT COMMENT 'Identifier of the user or board member who approved the patronage distribution.',
    `parent_patronage_distribution_id` BIGINT COMMENT 'Self-referencing FK on patronage_distribution (parent_patronage_distribution_id)',
    `approval_date` DATE COMMENT 'Date when the board of directors approved the patronage distribution allocation.',
    `business_unit_code` STRING COMMENT 'Code identifying the cooperative business unit or division that generated the patronage activity.',
    `calculation_date` DATE COMMENT 'Date when the patronage distribution amount was calculated based on member patronage activity.',
    `cash_percentage` DECIMAL(18,2) COMMENT 'Percentage of total distribution paid in cash, typically minimum 20% per IRS qualified written notice requirements.',
    `cash_portion_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the patronage distribution paid to the member in cash.',
    `check_number` STRING COMMENT 'Check number if payment method is check for the cash portion of patronage distribution.',
    `commodity_type` STRING COMMENT 'Primary commodity or service category on which the member patronage was based for this distribution.',
    `cost_center_code` STRING COMMENT 'Cost center code for financial accounting allocation of the patronage distribution expense.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the patronage distribution record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the patronage distribution amounts.',
    `distribution_number` STRING COMMENT 'Externally-known unique business identifier for the patronage distribution transaction.',
    `distribution_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to patronage base amount to calculate the total distribution allocation.',
    `distribution_status` STRING COMMENT 'Current lifecycle status of the patronage distribution in the approval and payment workflow.',
    `distribution_type` STRING COMMENT 'Classification of the patronage distribution method per cooperative bylaws and IRS regulations.',
    `equity_certificate_number` STRING COMMENT 'Certificate number issued for the equity portion of the patronage distribution allocated to member capital account.',
    `equity_percentage` DECIMAL(18,2) COMMENT 'Percentage of total distribution retained as member equity or allocated to capital account.',
    `equity_portion_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the patronage distribution retained as member equity or allocated to capital account.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which the patronage distribution is calculated and allocated.',
    `form_1099_patr_issue_date` DATE COMMENT 'Date when IRS Form 1099-PATR was issued to the member for tax reporting.',
    `form_1099_patr_issued` BOOLEAN COMMENT 'Indicates whether IRS Form 1099-PATR has been issued to the member for this distribution.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the patronage distribution is posted.',
    `issue_date` DATE COMMENT 'Date when the patronage distribution was officially issued to the member.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the patronage distribution record was last modified.',
    `net_cash_paid` DECIMAL(18,2) COMMENT 'Net cash amount paid to member after withholding and any other deductions.',
    `non_qualified_amount` DECIMAL(18,2) COMMENT 'Portion of distribution that does not qualify for cooperative tax deduction and is taxed at corporate level.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding special circumstances, adjustments, or member communications related to this patronage distribution.',
    `patronage_base_amount` DECIMAL(18,2) COMMENT 'Total dollar value of member patronage activity (purchases, sales, or services) used as the basis for distribution calculation.',
    `payment_date` DATE COMMENT 'Date when the cash portion of the patronage distribution was paid or equity was allocated to member account.',
    `payment_method` STRING COMMENT 'Method used to disburse the cash portion of the patronage distribution to the member.',
    `qualified_amount` DECIMAL(18,2) COMMENT 'Portion of distribution that qualifies for tax deduction by the cooperative under IRS Subchapter T qualified written notice rules.',
    `redemption_eligible_date` DATE COMMENT 'Date when the equity portion becomes eligible for redemption to the member per revolving fund schedule.',
    `revolving_period_years` STRING COMMENT 'Number of years the equity portion will be retained before redemption per cooperative revolving fund policy.',
    `tax_year` STRING COMMENT 'Tax year for which the patronage distribution is reported on IRS Form 1099-PATR.',
    `total_distribution_amount` DECIMAL(18,2) COMMENT 'Total patronage distribution amount allocated to the member before cash/equity split.',
    `withholding_amount` DECIMAL(18,2) COMMENT 'Federal and state tax withholding amount deducted from cash portion per member W-9 status and backup withholding rules.',
    CONSTRAINT pk_patronage_distribution PRIMARY KEY(`patronage_distribution_id`)
) COMMENT 'Master reference table for patronage_distribution. Referenced by patronage_distribution_id.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`financing_arrangement` (
    `financing_arrangement_id` BIGINT COMMENT 'Primary key for financing_arrangement',
    `company_code_id` BIGINT COMMENT 'Identifier of the internal business entity or legal entity receiving the financing.',
    `cost_center_id` BIGINT COMMENT 'Cost center to which financing costs and interest expenses are allocated.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or executive who approved the financing arrangement.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Financing arrangements post to specific GL accounts for liability tracking and interest expense. Currently denormalized as gl_account_code (STRING). Normalizing to gl_account_id FK enables referential',
    `vendor_id` BIGINT COMMENT 'Identifier of the financial institution or party providing the financing.',
    `parent_financing_arrangement_id` BIGINT COMMENT 'Self-referencing FK on financing_arrangement (parent_financing_arrangement_id)',
    `accounting_treatment_code` STRING COMMENT 'Code indicating the accounting classification and treatment under GAAP or IFRS standards.',
    `approval_date` DATE COMMENT 'Date when the financing arrangement was formally approved by authorized management or board.',
    `arrangement_name` STRING COMMENT 'Human-readable descriptive name of the financing arrangement for business reference.',
    `arrangement_number` STRING COMMENT 'Externally-known unique business identifier for the financing arrangement, used in contracts and communications.',
    `arrangement_status` STRING COMMENT 'Current lifecycle status of the financing arrangement indicating its operational state.',
    `arrangement_type` STRING COMMENT 'Classification of the financing arrangement based on structure and purpose.',
    `collateral_description` STRING COMMENT 'Description of assets pledged as security for the financing arrangement, such as equipment, land, or inventory.',
    `collateral_value` DECIMAL(18,2) COMMENT 'Appraised or book value of collateral securing the financing arrangement.',
    `commodity_type` STRING COMMENT 'Agricultural commodity or crop type associated with the financing arrangement, if applicable (e.g., corn, soybeans, wheat).',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the legal contract document for this financing arrangement.',
    `covenant_description` STRING COMMENT 'Description of financial covenants and restrictions imposed by the lender, such as debt-to-equity ratios or minimum working capital requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this financing arrangement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this arrangement.',
    `data_source_system` STRING COMMENT 'Name of the source system from which this financing arrangement record originated (e.g., SAP S/4HANA, Oracle NetSuite).',
    `effective_date` DATE COMMENT 'Date when the financing arrangement becomes legally binding and active.',
    `interest_calculation_method` STRING COMMENT 'Method used to calculate interest charges on the outstanding balance.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the financing arrangement, expressed as a decimal (e.g., 0.0525 for 5.25%).',
    `interest_rate_type` STRING COMMENT 'Classification indicating whether the interest rate is fixed, variable, or hybrid over the arrangement term.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this financing arrangement record was last updated in the system.',
    `loan_to_value_ratio` DECIMAL(18,2) COMMENT 'Ratio of the principal amount to the collateral value, expressed as a decimal (e.g., 0.8000 for 80%).',
    `maturity_date` DATE COMMENT 'Date when the financing arrangement reaches full term and final payment is due.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or contextual information about the financing arrangement.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current outstanding principal balance remaining on the financing arrangement.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Scheduled payment amount per payment period, including principal and interest components.',
    `payment_frequency` STRING COMMENT 'Frequency at which principal and interest payments are due under the arrangement.',
    `prepayment_allowed_flag` BOOLEAN COMMENT 'Indicates whether early repayment of principal is permitted under the arrangement terms.',
    `prepayment_penalty_rate` DECIMAL(18,2) COMMENT 'Penalty rate applied to prepayments if early repayment is subject to fees, expressed as a decimal percentage.',
    `principal_amount` DECIMAL(18,2) COMMENT 'Original principal amount of the financing arrangement at inception.',
    `purpose_code` STRING COMMENT 'Classification code indicating the business purpose for which the financing was obtained.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this arrangement must be included in regulatory financial filings and disclosures.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this financing arrangement is subject to SOX internal control requirements and audit procedures.',
    `term_months` STRING COMMENT 'Total duration of the financing arrangement expressed in months from effective date to maturity.',
    CONSTRAINT pk_financing_arrangement PRIMARY KEY(`financing_arrangement_id`)
) COMMENT 'Master reference table for financing_arrangement. Referenced by arrangement_id.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`controlling_area` (
    `controlling_area_id` BIGINT COMMENT 'Primary key for controlling_area',
    `parent_controlling_area_id` BIGINT COMMENT 'Self-referencing FK on controlling_area (parent_controlling_area_id)',
    `activity_type_enabled_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether activity-based costing is enabled within this controlling area for tracking and allocating resource consumption by activity type.',
    `allocation_cycle_enabled_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether automated cost allocation cycles are enabled for this controlling area to distribute overhead and shared service costs across cost centers and profit centers.',
    `budget_control_enabled_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether budget control and availability checking is enforced within this controlling area to prevent overspending against approved budgets.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the chart of accounts used by this controlling area for general ledger account mapping and financial statement preparation.',
    `commitment_management_enabled_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether commitment tracking is enabled for purchase requisitions and purchase orders within this controlling area for funds reservation and budget consumption analysis.',
    `company_code_id` BIGINT COMMENT 'Reference to the primary company code associated with this controlling area. A controlling area may span multiple company codes but typically has one primary assignment for organizational hierarchy purposes.',
    `consolidation_group_code` STRING COMMENT 'Four-character code identifying the financial consolidation group to which this controlling area belongs for consolidated financial statement preparation and group reporting.',
    `controlling_area_code` STRING COMMENT 'Four-character alphanumeric code uniquely identifying the controlling area in the enterprise resource planning system. Used as the business identifier for external system integration and reporting.',
    `cost_center_standard_hierarchy_id` BIGINT COMMENT 'Reference to the default cost center hierarchy used for organizational reporting and cost rollup within this controlling area.',
    `cost_of_goods_sold_variant` STRING COMMENT 'Two-character code defining the cost of goods sold calculation method and allocation rules used within this controlling area for inventory valuation and product costing.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who originally created this controlling area record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this controlling area record was first created in the system.',
    `cross_company_cost_allocation_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this controlling area supports cross-company code cost allocations for shared services and intercompany charge-backs.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the controlling area currency used for internal cost accounting, budgeting, and management reporting. All cost centers and internal orders within this controlling area report in this currency.',
    `controlling_area_description` STRING COMMENT 'Detailed business description explaining the purpose, scope, and organizational boundaries of the controlling area.',
    `effective_end_date` DATE COMMENT 'Date on which this controlling area was deactivated or closed, after which no new transactions may be posted. Null for currently active controlling areas.',
    `effective_start_date` DATE COMMENT 'Date on which this controlling area became active and available for posting financial transactions and cost accounting entries.',
    `fiscal_year_variant_code` STRING COMMENT 'Two-character code defining the fiscal year calendar structure for this controlling area, including the number of periods, special periods, and year-end closing rules.',
    `gaap_compliance_standard` STRING COMMENT 'Accounting standard framework applied within this controlling area for financial statement preparation and regulatory reporting compliance.',
    `internal_order_enabled_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether internal order functionality is enabled within this controlling area for project-based cost tracking and capital expenditure management.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user who most recently modified this controlling area record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this controlling area record was most recently updated or modified.',
    `controlling_area_name` STRING COMMENT 'Full descriptive name of the controlling area as recognized across the enterprise for financial reporting and cost management purposes.',
    `operating_concern_code` STRING COMMENT 'Four-character code identifying the operating concern (profitability analysis segment) associated with this controlling area for margin analysis and contribution reporting.',
    `profit_center_standard_hierarchy_id` BIGINT COMMENT 'Reference to the default profit center hierarchy used for profitability analysis and segment reporting within this controlling area.',
    `sox_compliance_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this controlling area is subject to Sarbanes-Oxley Act internal control requirements for financial reporting accuracy and audit trail integrity.',
    `statistical_key_figure_enabled_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether statistical key figures are enabled for this controlling area to support non-monetary allocation bases such as headcount, square footage, or production volume.',
    `controlling_area_status` STRING COMMENT 'Current lifecycle status of the controlling area indicating whether it is operational and available for cost accounting and management reporting transactions.',
    `variance_calculation_method` STRING COMMENT 'Method used to calculate cost variances between planned and actual costs within this controlling area for management reporting and performance analysis.',
    CONSTRAINT pk_controlling_area PRIMARY KEY(`controlling_area_id`)
) COMMENT 'Master reference table for controlling_area. Referenced by controlling_area_id.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`business_unit` (
    `business_unit_id` BIGINT COMMENT 'Primary key for business_unit',
    `address_line_1` STRING COMMENT 'Primary street address line for the business unit headquarters or primary office location.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or additional location details.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total approved annual operating budget for the business unit in functional currency for crop enterprise budgeting and variance analysis.',
    `annual_revenue_target` DECIMAL(18,2) COMMENT 'Annual revenue target or goal for the business unit in functional currency for performance tracking and ROI analysis.',
    `business_unit_code` STRING COMMENT 'Externally-known unique alphanumeric code for the business unit used in financial reporting and consolidation.',
    `capex_budget_amount` DECIMAL(18,2) COMMENT 'Approved capital expenditure budget for the fiscal year for asset acquisition and infrastructure investment tracking.',
    `city` STRING COMMENT 'City or municipality where the business unit is located.',
    `commodity_focus` STRING COMMENT 'Primary agricultural commodity or crop type that this business unit specializes in for COGS allocation and enterprise budgeting.',
    `consolidation_flag` BOOLEAN COMMENT 'Indicates whether this business unit is included in consolidated financial statements and group-level reporting.',
    `cost_center_code` STRING COMMENT 'Cost center identifier used for expense allocation and management accounting in SAP S/4HANA FI/CO.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the business unit is primarily located or registered.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this business unit record was first created in the system.',
    `business_unit_description` STRING COMMENT 'Detailed description of the business unit purpose, scope, and operational focus.',
    `effective_end_date` DATE COMMENT 'Date when the business unit ceased operations, was closed, merged, or divested. Null for active business units.',
    `effective_start_date` DATE COMMENT 'Date when the business unit became operational or was established in the organizational structure.',
    `email_address` STRING COMMENT 'Primary contact email address for the business unit.',
    `financial_controller_employee_id` BIGINT COMMENT 'Reference to the employee serving as the financial controller responsible for financial controls and SOX compliance for this business unit.',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the primary operating currency of the business unit.',
    `gl_company_code` STRING COMMENT 'Company code in the general ledger system for financial accounting and statutory reporting.',
    `intercompany_elimination_flag` BOOLEAN COMMENT 'Indicates whether intercompany transactions involving this business unit require elimination entries during consolidation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this business unit record was last updated or modified.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity under which this business unit operates for statutory reporting and compliance.',
    `manager_employee_id` BIGINT COMMENT 'Reference to the employee who serves as the business unit manager or director responsible for operational and financial performance.',
    `business_unit_name` STRING COMMENT 'Full legal or operational name of the business unit.',
    `opex_budget_amount` DECIMAL(18,2) COMMENT 'Approved operating expenditure budget for the fiscal year for recurring operational costs and expense management.',
    `parent_business_unit_id` BIGINT COMMENT 'Reference to the parent business unit in the organizational hierarchy for consolidation and roll-up reporting.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the business unit office.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the business unit address.',
    `profit_center_code` STRING COMMENT 'Profit center identifier used for revenue and profitability analysis in management accounting.',
    `region` STRING COMMENT 'Geographic region or territory designation for regional reporting and analysis.',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used for consolidated financial reporting and group-level analysis.',
    `short_name` STRING COMMENT 'Abbreviated name or acronym used for display and reporting purposes.',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this business unit is in scope for Sarbanes-Oxley Act compliance and internal control testing.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the business unit is located.',
    `business_unit_status` STRING COMMENT 'Current operational lifecycle status of the business unit.',
    `tax_identification_number` STRING COMMENT 'Tax identification number or employer identification number (EIN) assigned by the tax authority for this business unit.',
    `tax_jurisdiction` STRING COMMENT 'Primary tax jurisdiction or authority under which the business unit files tax returns and reports taxable income.',
    `business_unit_type` STRING COMMENT 'Classification of the business unit organizational structure type.',
    CONSTRAINT pk_business_unit PRIMARY KEY(`business_unit_id`)
) COMMENT 'Master reference table for business_unit. Referenced by business_unit_id.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`finance`.`functional_area` (
    `functional_area_id` BIGINT COMMENT 'Primary key for functional_area',
    `budget_allocation_amount` DECIMAL(18,2) COMMENT 'Annual budget amount allocated to this functional area for operational expenses (OPEX) and capital expenses (CAPEX).',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget allocation amount (e.g., USD, EUR, CAD).',
    `commodity_focus` STRING COMMENT 'Primary agricultural commodity or crop type associated with this functional area (e.g., corn, soybeans, wheat, dairy, beef cattle). Applicable for production-focused functional areas.',
    `cost_allocation_method` STRING COMMENT 'Method used to allocate shared costs and overhead expenses to this functional area for accurate cost of goods sold (COGS) and profitability analysis.',
    `cost_center_id` BIGINT COMMENT 'Reference to the primary cost center associated with this functional area for cost allocation and tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this functional area record was first created in the system.',
    `ebitda_contribution_target` DECIMAL(18,2) COMMENT 'Target EBITDA contribution amount for this functional area, used for performance measurement and management reporting.',
    `effective_end_date` DATE COMMENT 'Date when this functional area ceased operations or was closed. Null for currently active functional areas.',
    `effective_start_date` DATE COMMENT 'Date when this functional area became active and operational within the enterprise.',
    `enterprise_system_code` STRING COMMENT 'Code or identifier used to represent this functional area in enterprise resource planning (ERP) systems such as SAP S/4HANA or Oracle NetSuite.',
    `external_reporting_code` STRING COMMENT 'Code used for external regulatory reporting and financial statement disclosures to governing bodies and stakeholders.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the functional area budget and performance metrics are defined.',
    `functional_area_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the functional area for external reference and reporting. Used in financial statements and management reports.',
    `functional_area_description` STRING COMMENT 'Detailed description of the functional areas purpose, scope, and responsibilities within the agricultural enterprise.',
    `functional_area_name` STRING COMMENT 'Full descriptive name of the functional area (e.g., Crop Production, Livestock Operations, Equipment Maintenance, Sales & Marketing).',
    `functional_area_type` STRING COMMENT 'Classification of the functional area by its primary business function within the agricultural enterprise.',
    `gaap_reporting_segment` STRING COMMENT 'GAAP reporting segment classification for consolidated financial statement reporting and segment disclosure requirements.',
    `general_ledger_account_id` BIGINT COMMENT 'Reference to the default general ledger account used for posting transactions related to this functional area.',
    `geographic_region` STRING COMMENT 'Geographic region or location where this functional area operates (e.g., Midwest Region, California Central Valley, Southeast Operations).',
    `ifrs_reporting_segment` STRING COMMENT 'IFRS reporting segment classification for international consolidated financial statement reporting per IFRS 8 Operating Segments.',
    `is_capex_eligible` BOOLEAN COMMENT 'Indicates whether this functional area is eligible to incur and track capital expenditures (CAPEX) for asset acquisition and improvement projects.',
    `is_revenue_generating` BOOLEAN COMMENT 'Indicates whether this functional area directly generates revenue for the enterprise (true) or is a cost center only (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this functional area record was last updated or modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this functional areas operations, budget, or reporting requirements.',
    `parent_functional_area_id` BIGINT COMMENT 'Reference to the parent functional area in a hierarchical organizational structure. Null for top-level functional areas.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center associated with this functional area for profitability analysis and internal management reporting.',
    `responsible_manager_id` BIGINT COMMENT 'Reference to the employee who is the designated manager or owner responsible for this functional areas performance and budget.',
    `roi_target_percentage` DECIMAL(18,2) COMMENT 'Target return on investment percentage for this functional area, expressed as a percentage of invested capital.',
    `sox_control_required` BOOLEAN COMMENT 'Indicates whether this functional area is subject to Sarbanes-Oxley Act (SOX) financial controls and audit requirements.',
    `functional_area_status` STRING COMMENT 'Current operational status of the functional area within the enterprise organizational structure.',
    CONSTRAINT pk_functional_area PRIMARY KEY(`functional_area_id`)
) COMMENT 'Master reference table for functional_area. Referenced by functional_area_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `agriculture_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ADD CONSTRAINT `fk_finance_finance_ap_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ADD CONSTRAINT `fk_finance_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ADD CONSTRAINT `fk_finance_finance_ap_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_finance_ap_invoice_id` FOREIGN KEY (`finance_ap_invoice_id`) REFERENCES `agriculture_ecm`.`finance`.`finance_ap_invoice`(`finance_ap_invoice_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `agriculture_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_finance_ap_invoice_id` FOREIGN KEY (`finance_ap_invoice_id`) REFERENCES `agriculture_ecm`.`finance`.`finance_ap_invoice`(`finance_ap_invoice_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `agriculture_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `agriculture_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_close_calendar_id` FOREIGN KEY (`close_calendar_id`) REFERENCES `agriculture_ecm`.`finance`.`close_calendar`(`close_calendar_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_dependency_task_period_close_id` FOREIGN KEY (`dependency_task_period_close_id`) REFERENCES `agriculture_ecm`.`finance`.`period_close`(`period_close_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_sending_company_code_id` FOREIGN KEY (`sending_company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_original_tax_record_id` FOREIGN KEY (`original_tax_record_id`) REFERENCES `agriculture_ecm`.`finance`.`tax_record`(`tax_record_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ADD CONSTRAINT `fk_finance_commodity_hedge_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ADD CONSTRAINT `fk_finance_commodity_hedge_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ADD CONSTRAINT `fk_finance_commodity_hedge_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ADD CONSTRAINT `fk_finance_government_program_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ADD CONSTRAINT `fk_finance_government_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ADD CONSTRAINT `fk_finance_government_program_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_parent_bank_account_id` FOREIGN KEY (`parent_bank_account_id`) REFERENCES `agriculture_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ADD CONSTRAINT `fk_finance_loan_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `agriculture_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ADD CONSTRAINT `fk_finance_loan_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ADD CONSTRAINT `fk_finance_loan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ADD CONSTRAINT `fk_finance_loan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ADD CONSTRAINT `fk_finance_loan_parent_loan_id` FOREIGN KEY (`parent_loan_id`) REFERENCES `agriculture_ecm`.`finance`.`loan`(`loan_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `agriculture_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_parent_payment_run_id` FOREIGN KEY (`parent_payment_run_id`) REFERENCES `agriculture_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `agriculture_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `agriculture_ecm`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_controlling_area_id` FOREIGN KEY (`controlling_area_id`) REFERENCES `agriculture_ecm`.`finance`.`controlling_area`(`controlling_area_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_functional_area_id` FOREIGN KEY (`functional_area_id`) REFERENCES `agriculture_ecm`.`finance`.`functional_area`(`functional_area_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_parent_wbs_element_id` FOREIGN KEY (`parent_wbs_element_id`) REFERENCES `agriculture_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `agriculture_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`close_calendar` ADD CONSTRAINT `fk_finance_close_calendar_parent_close_calendar_id` FOREIGN KEY (`parent_close_calendar_id`) REFERENCES `agriculture_ecm`.`finance`.`close_calendar`(`close_calendar_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`patronage_distribution` ADD CONSTRAINT `fk_finance_patronage_distribution_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`patronage_distribution` ADD CONSTRAINT `fk_finance_patronage_distribution_parent_patronage_distribution_id` FOREIGN KEY (`parent_patronage_distribution_id`) REFERENCES `agriculture_ecm`.`finance`.`patronage_distribution`(`patronage_distribution_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`financing_arrangement` ADD CONSTRAINT `fk_finance_financing_arrangement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`financing_arrangement` ADD CONSTRAINT `fk_finance_financing_arrangement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`financing_arrangement` ADD CONSTRAINT `fk_finance_financing_arrangement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`financing_arrangement` ADD CONSTRAINT `fk_finance_financing_arrangement_parent_financing_arrangement_id` FOREIGN KEY (`parent_financing_arrangement_id`) REFERENCES `agriculture_ecm`.`finance`.`financing_arrangement`(`financing_arrangement_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`controlling_area` ADD CONSTRAINT `fk_finance_controlling_area_parent_controlling_area_id` FOREIGN KEY (`parent_controlling_area_id`) REFERENCES `agriculture_ecm`.`finance`.`controlling_area`(`controlling_area_id`);

-- ========= TAGS =========
ALTER SCHEMA `agriculture_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `agriculture_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `account_currency` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Currency (ISO 4217)');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `account_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `account_long_description` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Long Description');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|archived');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `account_subtype` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Subtype');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (CoA) Code');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `commodity_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Commodity Allocation Flag');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Number');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_center_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Required Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element (CO) Category');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|not_applicable');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Element (CO) Type Code');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Deactivation Date');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Effective Date');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `field_status_group` SET TAGS ('dbx_business_glossary_term' = 'Field Status Group Code');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `financial_statement_section` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Section');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `financial_statement_section` SET TAGS ('dbx_value_regex' = 'balance_sheet|profit_and_loss|cash_flow|equity_statement');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `is_balance_sheet_account` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Account Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `is_capex_account` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Account Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `is_cogs_account` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Account Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `is_ebitda_relevant` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Relevance Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `is_gaap_relevant` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Relevance Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `is_ifrs_relevant` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Relevance Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `is_opex_account` SET TAGS ('dbx_business_glossary_term' = 'Operational Expenditure (OPEX) Account Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `is_reconciliation_account` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `line_item_display` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `normal_balance` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance Side');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `normal_balance` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `open_item_management` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `posting_block` SET TAGS ('dbx_business_glossary_term' = 'Posting Block Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `profit_center_required` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Required Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Subledger Type');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account_type` SET TAGS ('dbx_value_regex' = 'accounts_payable|accounts_receivable|fixed_assets|inventory|not_applicable');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Sort Key Code');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `sort_key` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|ORACLE_NETSUITE');
ALTER TABLE `agriculture_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee ID');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Type Code');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,6}$');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `capex_budget_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Capital Expenditure (CAPEX) Budget');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `capex_budget_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO) Code');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'production|administration|research_and_development|field_operations|supply_chain|overhead');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|locked|pending_approval|archived');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Currency Code');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,16}$');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `gl_account_assignment_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Assignment Group');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `gl_account_assignment_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,10}$');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Hierarchy Level');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_node_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Hierarchy Node Code');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `is_project_cost_collector` SET TAGS ('dbx_business_glossary_term' = 'Project Cost Collector Flag');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `is_statistical` SET TAGS ('dbx_business_glossary_term' = 'Statistical Cost Center Flag');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Lock Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_value_regex' = 'unlocked|locked_actual|locked_plan|locked_all');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `opex_budget_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Operational Expenditure (OPEX) Budget');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `opex_budget_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `overhead_allocation_key` SET TAGS ('dbx_business_glossary_term' = 'Overhead Allocation Key');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `overhead_allocation_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,10}$');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'crop_enterprise|livestock_operation|supply_chain|corporate|shared_services');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Short Name');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `short_name` SET TAGS ('dbx_value_regex' = '^.{1,20}$');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|ORACLE_NETSUITE|GRANULAR|MANUAL');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `source_system_key` SET TAGS ('dbx_business_glossary_term' = 'Source System Key');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_city` SET TAGS ('dbx_business_glossary_term' = 'Registered Office City');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_country_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Office Country Code');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Office Postal Code');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_state_province` SET TAGS ('dbx_business_glossary_term' = 'Registered Office State or Province');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_street` SET TAGS ('dbx_business_glossary_term' = 'Registered Office Street Address');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_street` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `address_street` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) Assignment');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_business_glossary_term' = 'Company Code Status');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|in_liquidation|dormant|pending');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `consolidation_chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Chart of Accounts');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `consolidation_chart_of_accounts` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO Area)');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Incorporation Code');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_business_glossary_term' = 'Credit Control Area');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'subsidiary|parent|joint_venture|branch|holding|cooperative');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `epa_facility_identifier` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Facility Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `fda_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Establishment Number');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `gaap_reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Standard');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `gaap_reporting_standard` SET TAGS ('dbx_value_regex' = 'GAAP|IFRS|GAAP_IFRS');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `globalg_ap_number` SET TAGS ('dbx_business_glossary_term' = 'GLOBALG.A.P. (Global Good Agricultural Practices) Number');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `incorporation_country_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Incorporation Code');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `incorporation_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Incorporation');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `intercompany_clearing_account` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Clearing Account');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code Language Code');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `organic_certification_number` SET TAGS ('dbx_business_glossary_term' = 'National Organic Program (NOP) Certification Number');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `profit_center_standard_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Standard Hierarchy');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Reporting Currency Code');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `sec_registrant_number` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Registrant Number');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `sec_registrant_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Company Short Name');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `sox_in_scope` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) In-Scope Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `usda_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'United States Department of Agriculture (USDA) Entity Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `agriculture_ecm`.`finance`.`company_code` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code_amount` SET TAGS ('dbx_business_glossary_term' = 'Company Code Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code_currency` SET TAGS ('dbx_business_glossary_term' = 'Company Code Currency');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Type');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Status');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `elimination_status` SET TAGS ('dbx_value_regex' = 'pending|eliminated|not_required|exception');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entry Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Type');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'standard|accrual|reversal|intercompany|manual|recurring');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Changed Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|posted|parked|held|reversed|cleared');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_user` SET TAGS ('dbx_business_glossary_term' = 'Posting User ID');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|ORACLE_NETSUITE|GRANULAR|MANUAL');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_company_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Company Code');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order ID');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'A|D|K|M|S');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `company_code_amount` SET TAGS ('dbx_business_glossary_term' = 'Company Code Currency Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `company_code_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `company_code_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code Currency Code');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `company_code_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_status` SET TAGS ('dbx_business_glossary_term' = 'Line Item Status');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_status` SET TAGS ('dbx_value_regex' = 'open|cleared|parked|reversed|blocked');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_block_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_FI|NETSUITE|GRANULAR|MANUAL|INTERFACE');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `special_gl_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special General Ledger (GL) Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` SET TAGS ('dbx_subdomain' = 'payables_management');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `finance_ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) / Operational Expenditure (OPEX) Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `discount_due_date` SET TAGS ('dbx_business_glossary_term' = 'Discount Due Date');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `grn_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Note (GRN) Number');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `invoice_line_count` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Count');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|posted|approved|paid|blocked|cancelled');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|recurring|intercompany');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Invoice Flag');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `payment_block_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Status');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `payment_block_status` SET TAGS ('dbx_value_regex' = 'unblocked|manual_block|quality_block|price_variance|duplicate_check');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire|check|card|EFT');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Document Number');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|ORACLE_NETSUITE|GRANULAR|MANUAL');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status (PO/GRN/Invoice)');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'pending|matched|quantity_variance|price_variance|grn_missing');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `vendor_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ALTER COLUMN `vendor_invoice_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` SET TAGS ('dbx_subdomain' = 'payables_management');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `ap_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice Line ID');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field / Land Parcel ID');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `finance_ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material / Service ID');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Note (GRN) ID');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure / Operational Expenditure (CAPEX/OPEX) Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `crop_season` SET TAGS ('dbx_business_glossary_term' = 'Crop Season');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Discount Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `gmo_indicator` SET TAGS ('dbx_business_glossary_term' = 'Genetically Modified Organism (GMO) Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Number');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Status');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|posted|blocked|reversed|cancelled|parked');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT)');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `matching_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Matching Status');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `matching_status` SET TAGS ('dbx_value_regex' = 'unmatched|po_matched|grn_matched|three_way_matched|exception');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Line Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `po_line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `price_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `price_variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Quantity');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|ORACLE_NETSUITE|GRANULAR|MANUAL');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` SET TAGS ('dbx_subdomain' = 'payables_management');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Payment Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `finance_ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Clearing Date');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Clearing Status');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_clearing_status` SET TAGS ('dbx_value_regex' = 'uncleared|cleared|returned|rejected');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `discount_taken_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `invoice_count` SET TAGS ('dbx_business_glossary_term' = 'Invoice Count');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|WIRE|CHECK|EFT|CARD');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'initiated|approved|sent|cleared|returned|voided');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'standard|advance|partial|final|void_replacement');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `remittance_advice_sent` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Flag');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `remittance_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remittance Sent Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|ORACLE_NETSUITE|GRANULAR');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` SET TAGS ('dbx_subdomain' = 'enterprise_planning');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `crop_enterprise_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Crop Enterprise Budget ID');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `farm_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Farm Unit ID');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field ID');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `seed_variety_id` SET TAGS ('dbx_business_glossary_term' = 'Seed Variety Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `sustainability_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `breakeven_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Break-Even Price Per Unit');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `breakeven_price_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `budget_area_acres` SET TAGS ('dbx_business_glossary_term' = 'Budget Area Acres');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `budget_area_ha` SET TAGS ('dbx_business_glossary_term' = 'Budget Area Hectares (ha)');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `budget_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Date');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Crop Enterprise Budget Number');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_value_regex' = '^CEB-[0-9]{4}-[A-Z0-9]{6,12}$');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|revised|final|cancelled');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `budget_version` SET TAGS ('dbx_value_regex' = 'original|revised|final');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `crop_insurance_cost_per_ha` SET TAGS ('dbx_business_glossary_term' = 'Crop Insurance Cost Per Hectare');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `crop_insurance_cost_per_ha` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(Q[1-4]|P(0[1-9]|1[0-2]))$');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `government_program_payment_per_ha` SET TAGS ('dbx_business_glossary_term' = 'Government Program Payment Per Hectare');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `government_program_payment_per_ha` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `harvest_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Harvest End Date');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `is_gmo` SET TAGS ('dbx_business_glossary_term' = 'Genetically Modified Organism (GMO) Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `land_rent_per_ha` SET TAGS ('dbx_business_glossary_term' = 'Land Rent Per Hectare');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `land_rent_per_ha` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `planned_cost_per_ha` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost Per Hectare');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `planned_cost_per_ha` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `planned_net_income` SET TAGS ('dbx_business_glossary_term' = 'Planned Net Income');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `planned_net_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `planned_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Planned Price Per Unit');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `planned_price_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `planned_revenue_per_ha` SET TAGS ('dbx_business_glossary_term' = 'Planned Revenue Per Hectare');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `planned_revenue_per_ha` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `planned_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Total Cost');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `planned_total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `planned_total_revenue` SET TAGS ('dbx_business_glossary_term' = 'Planned Total Revenue');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `planned_total_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `planned_yield_per_ha` SET TAGS ('dbx_business_glossary_term' = 'Planned Yield Per Hectare');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `planting_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Planting Start Date');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `yield_uom` SET TAGS ('dbx_business_glossary_term' = 'Yield Unit of Measure (UOM)');
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ALTER COLUMN `yield_uom` SET TAGS ('dbx_value_regex' = 'MT|BU|CWT|KG|LB|TON');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` SET TAGS ('dbx_subdomain' = 'enterprise_planning');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `farm_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Farm Unit Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Project Compliance Requirement - Compliance Obligation Id');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `primary_capital_requestor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee ID');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `primary_capital_requestor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `primary_capital_requestor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Cost Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Project Completion Date');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Project Cost Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Project Approval Date');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|conditionally_approved|rejected|escalated');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Project Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `approved_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Class Code');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Assignment Date');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `budget_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Fiscal Year');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `committed_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `committed_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Project Compliance Deadline');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `depreciation_key` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Key');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Project Cost Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Compliance Cost Impact');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `expenditure_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) / Operational Expenditure (OPEX) Category');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `expenditure_category` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Project-Level Fulfillment Status');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Project Funding Source');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Internal Order Number');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Project Obligation Type');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `payback_period_months` SET TAGS ('dbx_business_glossary_term' = 'Payback Period (Months)');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Project Completion Date');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Project Start Date');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Project Priority Level');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Applicable Project Phase');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `project_title` SET TAGS ('dbx_business_glossary_term' = 'Project Title');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Project Request Date');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Capital/Operational Project Request Number');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^CAPEX-[0-9]{4}-[0-9]{5}$|^OPEX-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percentage');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_business_glossary_term' = 'Cost Settlement Rule');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_value_regex' = 'asset_under_construction|cost_center|gl_account|profit_center|wbs_element');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `sox_control_relevant` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Relevant Flag');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Asset Useful Life (Years)');
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'enterprise_planning');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Request Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|under_construction|idle|disposed|transferred|scrapped');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_subnumber` SET TAGS ('dbx_business_glossary_term' = 'Asset Sub-Number');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `bonus_depreciation_pct` SET TAGS ('dbx_business_glossary_term' = 'Bonus Depreciation Percentage');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_value_regex' = 'book|tax|ifrs|state_tax|group');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|macrs|declining_balance|sum_of_years|units_of_production|section_179');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposal Reason');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(0[1-9]|1[0-2])$');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insured_value` SET TAGS ('dbx_business_glossary_term' = 'Insured Value');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insured_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_depreciation_posted_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Depreciation Posted Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_depreciation_posted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_depreciation_run_date` SET TAGS ('dbx_business_glossary_term' = 'Last Depreciation Run Date');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `macrs_property_class` SET TAGS ('dbx_business_glossary_term' = 'Modified Accelerated Cost Recovery System (MACRS) Property Class');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `section_179_elected` SET TAGS ('dbx_business_glossary_term' = 'Section 179 Expensing Election');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Period Close Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Approver ID');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `close_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Close Calendar ID');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `dependency_task_period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Dependency Task ID');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `primary_period_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Task Owner ID');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `primary_period_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `primary_period_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `actual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Approver Name');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `close_period_type` SET TAGS ('dbx_business_glossary_term' = 'Close Period Type');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `close_period_type` SET TAGS ('dbx_value_regex' = 'month_end|quarter_end|year_end|crop_year_end|special');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `close_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Close Reference Number');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `close_task_name` SET TAGS ('dbx_business_glossary_term' = 'Close Task Name');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `close_task_type` SET TAGS ('dbx_business_glossary_term' = 'Close Task Type');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Task Completion Date');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Task Due Date');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `estimated_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `estimated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `gaap_ifrs_standard` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) / International Financial Reporting Standards (IFRS) Reporting Standard');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `gaap_ifrs_standard` SET TAGS ('dbx_value_regex' = 'GAAP|IFRS|GAAP_IFRS_DUAL');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `harvest_settlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Harvest Settlement Flag');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `posting_period_locked` SET TAGS ('dbx_business_glossary_term' = 'Posting Period Locked Flag');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|ORACLE_NETSUITE|GRANULAR|MANUAL');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `sox_control_reference` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Reference');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `task_notes` SET TAGS ('dbx_business_glossary_term' = 'Close Task Notes');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `task_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Task Owner Name');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `task_owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `task_sequence` SET TAGS ('dbx_business_glossary_term' = 'Task Sequence Number');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Close Task Status');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue|blocked|waived');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Code ID');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Company Code ID');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `commodity_quantity` SET TAGS ('dbx_business_glossary_term' = 'Commodity Quantity');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `commodity_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Commodity Quantity Unit of Measure (UOM)');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `commodity_quantity_uom` SET TAGS ('dbx_value_regex' = 'BU|MT|CWT|LB|KG|TON');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_sending` SET TAGS ('dbx_business_glossary_term' = 'Sending Cost Center');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Status');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_value_regex' = 'pending|eliminated|partially_eliminated|not_required|disputed');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_receiving` SET TAGS ('dbx_business_glossary_term' = 'Receiving General Ledger (GL) Account');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_receiving` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_sending` SET TAGS ('dbx_business_glossary_term' = 'Sending General Ledger (GL) Account');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_sending` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Netting Agreement Reference');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_status` SET TAGS ('dbx_business_glossary_term' = 'Netting Status');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_status` SET TAGS ('dbx_value_regex' = 'included|excluded|settled|pending_netting');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_receiving` SET TAGS ('dbx_business_glossary_term' = 'Receiving Profit Center');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_sending` SET TAGS ('dbx_business_glossary_term' = 'Sending Profit Center');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Reconciliation Status');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|matched|mismatched|in_review|confirmed');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Document Number');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Number');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^ICT-[0-9]{4}-[0-9]{8}$');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|cancelled|on_hold');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'commodity_transfer|management_fee|intercompany_loan|service_charge|dividend|royalty');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_price_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Method');
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_price_method` SET TAGS ('dbx_value_regex' = 'cost_plus|market_price|resale_price|comparable_uncontrolled|transactional_net_margin');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Record ID');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `original_tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Original Tax Record ID');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `amended_indicator` SET TAGS ('dbx_business_glossary_term' = 'Amended Tax Return Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `deferred_tax_direction` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Direction');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `deferred_tax_direction` SET TAGS ('dbx_value_regex' = 'asset|liability|none');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `deferred_tax_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `exemption_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `exemption_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `exemption_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `exemption_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Type');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `exemption_type` SET TAGS ('dbx_value_regex' = 'farm_fuel_credit|ag_sales_tax|organic_input|equipment_exemption|none');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Reference Number');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Status');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|filed|accepted|rejected|amended|void');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Interest Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `interest_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Name');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `net_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Tax Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `net_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Notes');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Payment Date');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Payment Due Date');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Payment Reference Number');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Penalty Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Date');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'IRS|state_revenue|county_assessor|EPA|USDA|FDA');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|Oracle_NetSuite|Granular|manual');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_category` SET TAGS ('dbx_value_regex' = 'direct|indirect|deferred|current');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_document_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Document Number');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Period End Date');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Period Start Date');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'sales_tax|use_tax|excise_tax|property_tax|income_tax|payroll_tax');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `taxable_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Base Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ALTER COLUMN `taxable_base_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `commodity_hedge_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Hedge ID');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `farm_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Farm Unit Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `herd_id` SET TAGS ('dbx_business_glossary_term' = 'Herd Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `production_group_id` SET TAGS ('dbx_business_glossary_term' = 'Production Group Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `basis_risk_amount` SET TAGS ('dbx_business_glossary_term' = 'Basis Risk Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `basis_risk_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `broker_account_number` SET TAGS ('dbx_business_glossary_term' = 'Broker Account Number');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `broker_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `contract_month` SET TAGS ('dbx_business_glossary_term' = 'Contract Month');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `contract_month` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}[0-9]{2}$');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `effectiveness_test_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Test Date');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `effectiveness_test_method` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Test Method');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `effectiveness_test_method` SET TAGS ('dbx_value_regex' = 'dollar_offset|regression|hypothetical_derivative|critical_terms_match');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `effectiveness_test_result` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Test Result');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `effectiveness_test_result` SET TAGS ('dbx_value_regex' = 'highly_effective|ineffective|not_tested');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Exchange Code');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `exchange_code` SET TAGS ('dbx_value_regex' = 'CME|CBOT|ICE|NYMEX|KCBT|MGE');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `forward_price` SET TAGS ('dbx_business_glossary_term' = 'Forward Price');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `futures_price_at_entry` SET TAGS ('dbx_business_glossary_term' = 'Futures Price at Entry');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Designation');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_value_regex' = 'fair_value|cash_flow|net_investment|not_designated');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `hedge_end_date` SET TAGS ('dbx_business_glossary_term' = 'Hedge End Date');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `hedge_number` SET TAGS ('dbx_business_glossary_term' = 'Hedge Number');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `hedge_ratio` SET TAGS ('dbx_business_glossary_term' = 'Hedge Ratio');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `hedge_start_date` SET TAGS ('dbx_business_glossary_term' = 'Hedge Start Date');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `hedge_status` SET TAGS ('dbx_business_glossary_term' = 'Hedge Status');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `hedge_status` SET TAGS ('dbx_value_regex' = 'open|closed|expired|cancelled|pending_designation');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `hedged_item_description` SET TAGS ('dbx_business_glossary_term' = 'Hedged Item Description');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `initial_margin_required` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin Required');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `initial_margin_required` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'futures|options|forward|swap');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `mark_to_market_value` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Value');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `mark_to_market_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `mtm_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Valuation Date');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `notional_quantity` SET TAGS ('dbx_business_glossary_term' = 'Notional Quantity');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `number_of_contracts` SET TAGS ('dbx_business_glossary_term' = 'Number of Contracts');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `option_premium_paid` SET TAGS ('dbx_business_glossary_term' = 'Option Premium Paid');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `option_premium_paid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `option_type` SET TAGS ('dbx_business_glossary_term' = 'Option Type');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `option_type` SET TAGS ('dbx_value_regex' = 'call|put|not_applicable');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'BU|MT|CWT|LB|TON|BBL');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `realized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Realized Gain/Loss');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `realized_gain_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'cash|physical_delivery|offset');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `strike_price` SET TAGS ('dbx_business_glossary_term' = 'Strike Price');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `variation_margin_balance` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin Balance');
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ALTER COLUMN `variation_margin_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `government_program_id` SET TAGS ('dbx_business_glossary_term' = 'Government Program ID');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `herd_id` SET TAGS ('dbx_business_glossary_term' = 'Herd Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `production_group_id` SET TAGS ('dbx_business_glossary_term' = 'Production Group Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `actual_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `actual_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `administering_agency` SET TAGS ('dbx_business_glossary_term' = 'Administering Agency');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `administering_agency` SET TAGS ('dbx_value_regex' = 'USDA_FSA|USDA_NRCS|USDA_RMA|USDA_AMS|STATE_AGENCY|OTHER');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `base_acres` SET TAGS ('dbx_business_glossary_term' = 'Base Acres');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `conservation_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Conservation Compliance Status');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `conservation_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|exempt|not_applicable');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `county_code` SET TAGS ('dbx_business_glossary_term' = 'County Code (FIPS)');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `crop_insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Crop Insurance Policy Number (RMA)');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `enrolled_acres` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Acres');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|pending|approved|suspended|terminated|expired');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `estimated_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Payment Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `estimated_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `farm_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Farm Serial Number (FSN)');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `helc_determination` SET TAGS ('dbx_business_glossary_term' = 'Highly Erodible Land Conservation (HELC) Determination');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `helc_determination` SET TAGS ('dbx_value_regex' = 'no_helc|helc_present_compliant|helc_present_non_compliant|determination_pending');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `insurance_coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Level');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `livestock_units` SET TAGS ('dbx_business_glossary_term' = 'Livestock Units');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `payment_currency` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `payment_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `payment_limitation_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Limitation Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `payment_limitation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `payment_limitation_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Limitation Status');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `payment_limitation_status` SET TAGS ('dbx_value_regex' = 'within_limit|at_limit|exceeded_limit|not_applicable');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `payment_rate` SET TAGS ('dbx_business_glossary_term' = 'Payment Rate');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `payment_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Payment Rate Unit');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `payment_yield` SET TAGS ('dbx_business_glossary_term' = 'Payment Yield');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `program_number` SET TAGS ('dbx_business_glossary_term' = 'Program Number');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'commodity|conservation|crop_insurance|disaster_assistance|state_incentive');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `program_year` SET TAGS ('dbx_business_glossary_term' = 'Program Year');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `tract_number` SET TAGS ('dbx_business_glossary_term' = 'Tract Number');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `wetland_conservation_status` SET TAGS ('dbx_business_glossary_term' = 'Wetland Conservation (WC) Status');
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ALTER COLUMN `wetland_conservation_status` SET TAGS ('dbx_value_regex' = 'no_wetland|wetland_compliant|wetland_non_compliant|determination_pending');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|frozen|closed|pending_activation');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'operating|savings|escrow|money_market|payroll|credit_line');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `balance_date` SET TAGS ('dbx_business_glossary_term' = 'Balance Date');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Address');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Country Code');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_statement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Frequency');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_statement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `credit_facility_drawn` SET TAGS ('dbx_business_glossary_term' = 'Credit Facility Drawn Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `credit_facility_drawn` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `credit_facility_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Facility Limit');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `credit_facility_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Account Currency Code');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `daily_balance` SET TAGS ('dbx_business_glossary_term' = 'Daily Bank Account Balance');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `daily_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `dual_signatory_required` SET TAGS ('dbx_business_glossary_term' = 'Dual Signatory Required Flag');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Account Effective From Date');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Account Effective To Date');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `house_bank_account_id_code` SET TAGS ('dbx_business_glossary_term' = 'House Bank Account ID Code');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `house_bank_account_id_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `house_bank_account_id_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `house_bank_code` SET TAGS ('dbx_business_glossary_term' = 'House Bank Code');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Bank Reconciliation Date');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_value_regex' = 'ACH|WIRE|CHECK|EFT|SEPA|SWIFT');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Signatory Name');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `purpose_description` SET TAGS ('dbx_business_glossary_term' = 'Account Purpose Description');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Reconciliation Status');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|in_progress|unreconciled|pending_review');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number (ABA)');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `secondary_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Secondary Signatory Name');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `secondary_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `single_signatory_limit` SET TAGS ('dbx_business_glossary_term' = 'Single Signatory Transaction Limit');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `single_signatory_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|ORACLE_NETSUITE|GRANULAR|MANUAL');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Bank Identifier Code (BIC)');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`bank_account` ALTER COLUMN `usda_program_account` SET TAGS ('dbx_business_glossary_term' = 'USDA Program Account Flag');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `loan_id` SET TAGS ('dbx_business_glossary_term' = 'Loan ID');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `herd_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Herd Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `farm_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Farm Unit Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `parent_loan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `accrued_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `accrued_interest_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `available_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Credit Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `available_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure / Operational Expenditure (CAPEX/OPEX) Indicator');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX|mixed');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `collateral_description` SET TAGS ('dbx_business_glossary_term' = 'Collateral Description');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `collateral_type` SET TAGS ('dbx_value_regex' = 'land|equipment|crop|livestock|accounts_receivable|blanket_lien');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `collateral_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation Date');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `collateral_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Value Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `collateral_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `covenant_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Covenant Compliance Status');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `covenant_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|waiver_obtained|breach|under_review');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `covenant_description` SET TAGS ('dbx_business_glossary_term' = 'Covenant Description');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `covenant_review_date` SET TAGS ('dbx_business_glossary_term' = 'Covenant Review Date');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `draw_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Draw Period End Date');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `fsa_guarantee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Farm Service Agency (FSA) Guarantee Percentage');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `fsa_loan_number` SET TAGS ('dbx_business_glossary_term' = 'Farm Service Agency (FSA) Loan Number');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `interest_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Type');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_value_regex' = 'fixed|variable|hybrid');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `lender_name` SET TAGS ('dbx_business_glossary_term' = 'Lender Name');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `lender_type` SET TAGS ('dbx_business_glossary_term' = 'Lender Type');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `lender_type` SET TAGS ('dbx_value_regex' = 'farm_credit|commercial_bank|fsa|cooperative|insurance_company|private');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `loan_number` SET TAGS ('dbx_business_glossary_term' = 'Loan Number');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `loan_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `loan_status` SET TAGS ('dbx_business_glossary_term' = 'Loan Status');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `loan_status` SET TAGS ('dbx_value_regex' = 'active|paid_off|defaulted|restructured|pending_approval|cancelled');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `loan_type` SET TAGS ('dbx_business_glossary_term' = 'Loan Type');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `loan_type` SET TAGS ('dbx_value_regex' = 'operating_line_of_credit|term_loan|fsa_guaranteed|crop_production|equipment_loan|real_estate_mortgage');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Maturity Date');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `next_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Next Payment Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `next_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `next_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Payment Due Date');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `origination_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Origination Date');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|at_maturity|seasonal');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Principal Amount');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `principal_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `purpose_description` SET TAGS ('dbx_business_glossary_term' = 'Loan Purpose Description');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `rate_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `rate_benchmark` SET TAGS ('dbx_value_regex' = 'SOFR|prime_rate|libor|fixed|farm_credit_index|other');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `rate_spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Rate Spread Basis Points (BPS)');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|Oracle_NetSuite|Granular|manual');
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ALTER COLUMN `sox_control_relevant` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Relevant Flag');
ALTER TABLE `agriculture_ecm`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'payables_management');
ALTER TABLE `agriculture_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`payment_run` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`payment_run` ALTER COLUMN `parent_payment_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `agriculture_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_subdomain' = 'enterprise_planning');
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ALTER COLUMN `committed_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ALTER COLUMN `planned_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ALTER COLUMN `revised_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`close_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`close_calendar` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `agriculture_ecm`.`finance`.`close_calendar` ALTER COLUMN `close_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Close Calendar Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`close_calendar` ALTER COLUMN `parent_close_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`patronage_distribution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`patronage_distribution` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `agriculture_ecm`.`finance`.`patronage_distribution` ALTER COLUMN `patronage_distribution_id` SET TAGS ('dbx_business_glossary_term' = 'Patronage Distribution Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`patronage_distribution` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`patronage_distribution` ALTER COLUMN `parent_patronage_distribution_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`financing_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`financing_arrangement` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `agriculture_ecm`.`finance`.`financing_arrangement` ALTER COLUMN `financing_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Financing Arrangement Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`financing_arrangement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`finance`.`financing_arrangement` ALTER COLUMN `parent_financing_arrangement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`controlling_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`controlling_area` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `agriculture_ecm`.`finance`.`controlling_area` ALTER COLUMN `controlling_area_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`controlling_area` ALTER COLUMN `parent_controlling_area_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`business_unit` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`functional_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`finance`.`functional_area` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `agriculture_ecm`.`finance`.`functional_area` ALTER COLUMN `functional_area_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Identifier');
ALTER TABLE `agriculture_ecm`.`finance`.`functional_area` ALTER COLUMN `budget_allocation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`functional_area` ALTER COLUMN `ebitda_contribution_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`finance`.`functional_area` ALTER COLUMN `roi_target_percentage` SET TAGS ('dbx_confidential' = 'true');
