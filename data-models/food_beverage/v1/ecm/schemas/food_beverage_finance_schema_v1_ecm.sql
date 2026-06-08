-- Schema for Domain: finance | Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:22

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`finance` COMMENT 'Authoritative domain for all financial data — general ledger, cost centers, accounts payable/receivable, COGS calculation, standard costing, variance analysis, budgeting, forecasting, EBITDA reporting, revenue management, RSP/pricing strategy, trade spend accruals, intercompany transactions, fixed assets, and financial close processes.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique surrogate identifier for the GL account record in the enterprise data lakehouse. Primary key for the gl_account master data product. Role: MASTER_RESOURCE.',
    `esg_disclosure_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_disclosure. Business justification: Specific GL accounts capture environmental expenses; ESG disclosure references these accounts for transparent reporting.',
    `bank_account_id` BIGINT COMMENT 'Reference to the house bank account associated with this GL account, applicable for bank GL accounts. Links the GL account to the physical bank account for cash management and bank reconciliation. Corresponds to SAP SKB1.HBKID + HKTID. Used in treasury and cash management for F&B global banking relationships.',
    `account_category` STRING COMMENT 'High-level categorization indicating whether the account is a balance sheet account (carries forward balances) or a profit and loss account (cleared at year-end). Statistical and memo accounts are used for internal tracking without impacting financial statements. Drives year-end closing procedures and EBITDA reporting.. Valid values are `balance_sheet|profit_and_loss|statistical|memo`',
    `account_created_by` STRING COMMENT 'User ID or name of the person who created the GL account master record. Supports audit trail requirements and Sarbanes-Oxley (SOX) internal controls over financial reporting. Corresponds to SAP SKA1.ERNAM.',
    `account_creation_date` DATE COMMENT 'The date on which the GL account master record was originally created in the chart of accounts. Used for audit trail, account lifecycle management, and compliance reporting. Corresponds to SAP SKA1.ERDAT.',
    `account_group_code` STRING COMMENT 'Account group that controls the number range and field selection for the GL account. In SAP, this is the KTOKS field on SKA1 (e.g., GKON for reconciliation accounts, SAKO for general accounts). Governs which fields are required, optional, or suppressed during account master maintenance.',
    `account_hierarchy_node` STRING COMMENT 'The node identifier within the GL account hierarchy (e.g., SAP Financial Statement Version node, Oracle account hierarchy node) to which this account is assigned. Enables roll-up reporting from individual accounts to subtotals and totals in financial statements. Supports EBITDA reporting, segment reporting, and management reporting structures.',
    `account_long_name` STRING COMMENT 'Extended descriptive name of the GL account providing full business context beyond the short name. Used in detailed financial reporting, account reconciliation documentation, and audit trails. Corresponds to SAP SKA1.TXT50.',
    `account_name` STRING COMMENT 'Human-readable short description / name of the GL account as it appears in financial reports, journal entry screens, and the chart of accounts. Corresponds to SAP SKA1.TXT20 (short text) or Oracle account description.',
    `account_number` STRING COMMENT 'The externally-known GL account code as defined in the chart of accounts (e.g., SAP G/L account number, Oracle natural account segment). This is the business identifier used in all journal entries, cost allocations, and financial postings across ERP systems. Aligns to SAP SKA1.SAKNR / Oracle COA segment.. Valid values are `^[0-9]{1,10}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the GL account master record. Active accounts accept postings; blocked accounts are temporarily restricted; accounts marked for deletion are pending archival. Drives posting validation in ERP systems and financial close processes.. Valid values are `active|blocked|marked_for_deletion|inactive`',
    `account_subtype` STRING COMMENT 'Further classification of the GL account within its primary account type, providing granular categorization for financial reporting and analytics. Examples: for assets — current_asset, fixed_asset, intangible_asset; for expenses — cogs, selling_expense, admin_expense, rd_expense, trade_spend. Supports COGS calculation, EBITDA reporting, and trade promotion management (TPM) accrual tracking in F&B. [ENUM-REF-CANDIDATE: current_asset|fixed_asset|intangible_asset|current_liability|long_term_liability|cogs|gross_revenue|net_revenue|trade_spend|selling_expense|admin_expense|rd_expense — promote to reference product]',
    `account_type` STRING COMMENT 'Fundamental classification of the GL account indicating its role in financial statements. Determines whether the account appears on the balance sheet (asset, liability, equity) or income statement (revenue, expense). Corresponds to SAP SKA1.KTOKS account group classification and Oracle account type. Critical for P&L vs. balance sheet segregation and EBITDA reporting.. Valid values are `asset|liability|equity|revenue|expense`',
    `alternative_account_number` STRING COMMENT 'Country-specific or group-level alternative account number used for local statutory reporting or group consolidation mapping. Enables mapping between the operating chart of accounts and a group/country chart of accounts. Corresponds to SAP SKB1.ALTKT. Supports multi-GAAP and consolidation reporting for global F&B operations.',
    `balance_sheet_account` BOOLEAN COMMENT 'Indicates whether this account is a balance sheet account whose balance carries forward to the next fiscal year without being closed. Balance sheet accounts represent assets, liabilities, and equity. Used in financial close processes, intercompany reconciliation, and fixed asset reporting.',
    `chart_of_accounts_code` STRING COMMENT 'Identifier of the chart of accounts to which this GL account belongs. In SAP, this is the KTOPL field (e.g., INT, CAUS). Enterprises may maintain multiple charts of accounts for different legal entities or reporting frameworks (GAAP, IFRS). Drives account assignment and financial statement version mapping.. Valid values are `^[A-Z0-9]{1,4}$`',
    `commitment_management` BOOLEAN COMMENT 'Indicates whether commitment management (funds commitment tracking) is active for this GL account. When true, purchase orders and other commitments are tracked against budget for this account. Relevant for capital expenditure accounts and trade promotion spend management in F&B. Corresponds to SAP SKB1 commitment management indicator.',
    `company_code` STRING COMMENT 'The SAP company code (or Oracle legal entity code) for which this GL account is extended. A single chart of accounts account may be extended to multiple company codes with different settings. Represents the smallest organizational unit for which a complete self-contained set of accounts can be drawn up. Corresponds to SAP SKB1.BUKRS.. Valid values are `^[A-Z0-9]{1,4}$`',
    `company_code_posting_block` BOOLEAN COMMENT 'Indicates whether postings to this GL account are blocked at the company code level (as opposed to the chart of accounts level). Allows selective blocking for specific legal entities while keeping the account active in others. Corresponds to SAP SKB1.XSPEB.',
    `cost_element_category` STRING COMMENT 'Classifies the GL account as a primary cost element (originating from FI postings, e.g., material costs, labor), secondary cost element (internal allocations only, e.g., overhead rates, activity allocations), or not applicable (balance sheet accounts). In SAP S/4HANA, primary cost elements are unified with GL accounts. Drives COGS calculation, variance analysis, and cost center accounting.. Valid values are `primary|secondary|not_applicable`',
    `cost_element_type` STRING COMMENT 'Numeric type code classifying the cost element behavior in controlling (CO). Examples: 1=primary costs/cost-reducing revenues, 3=accrual/deferral per surcharge, 4=accrual/deferral per debit=actual, 11=revenues, 12=sales deductions, 22=external settlement. Corresponds to SAP CSKA.KATYP. Drives cost allocation, variance analysis, and profitability reporting. [ENUM-REF-CANDIDATE: 1|3|4|11|12|22|41|42|43|50|51|61 — promote to reference product]',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code specifying the account currency for this GL account. If set, all postings to this account must be in this currency. Blank indicates the account accepts postings in any company code currency. Critical for multi-currency F&B operations across global markets. Corresponds to SAP SKB1.WAERS.. Valid values are `^[A-Z]{3}$`',
    `deletion_flag` BOOLEAN COMMENT 'Indicates whether this GL account has been flagged for deletion and is pending archival. Accounts flagged for deletion cannot receive new postings and will be removed during the next archiving run. Corresponds to SAP SKA1.XLOEV. Supports master data lifecycle management and chart of accounts housekeeping.',
    `field_status_group` STRING COMMENT 'Controls which fields are required, optional, or suppressed when posting to this GL account. Determines the entry screen layout for journal entries. Corresponds to SAP SKB1.FSTAG. Critical for enforcing data quality on financial postings (e.g., requiring cost center on expense accounts).',
    `financial_statement_version` STRING COMMENT 'The financial statement version (FSV) to which this account is assigned for statutory and management reporting. Controls how the account is grouped and displayed in balance sheets and income statements. In SAP, corresponds to the VERSN field in T011T. Supports parallel reporting under GAAP and IFRS.',
    `functional_area` STRING COMMENT 'Classifies the GL account by business function for cost-of-sales accounting and segment reporting (e.g., manufacturing/COGS, sales and distribution, general and administrative, research and development, marketing). Enables income statement reporting by function of expense per IFRS IAS 1. Critical for F&B P&L reporting by function. Corresponds to SAP FKBER.',
    `inflation_index` STRING COMMENT 'Reference to the inflation index used for inflation accounting adjustments on this GL account. Applicable in high-inflation economies where F&B operations require IAS 29 (Financial Reporting in Hyperinflationary Economies) compliance. Corresponds to SAP SKB1 inflation index assignment.',
    `interest_calculation_indicator` STRING COMMENT 'Indicator controlling whether and how interest is calculated on balances in this GL account. Used for intercompany loan accounts, overdue receivables, and cash pool accounts. Corresponds to SAP SKB1.ZINRT. Supports intercompany transaction management and treasury operations in F&B.',
    `is_reconciliation_account` BOOLEAN COMMENT 'Boolean flag indicating whether this GL account is designated as a reconciliation account for a subledger (AP, AR, or fixed assets). When true, direct manual postings are blocked and all entries must originate from the corresponding subledger. Supports subledger-to-GL reconciliation controls.',
    `last_modified_date` DATE COMMENT 'The date on which the GL account master record was last changed. Supports change management tracking, audit trail, and SOX compliance for master data governance. Corresponds to SAP SKA1.LAEDA.',
    `line_item_display` BOOLEAN COMMENT 'Indicates whether individual line items are stored and displayed for this GL account. When true, users can drill down to individual postings. Required for accounts subject to audit or detailed reconciliation. Corresponds to SAP SKB1.XKRES. Impacts storage requirements and reporting granularity.',
    `only_balances_in_local_currency` BOOLEAN COMMENT 'When true, the system only manages balances in local (company code) currency for this account, suppressing foreign currency balance management. Typically set for cash and bank accounts. Corresponds to SAP SKB1.XSALH. Impacts foreign currency revaluation processes.',
    `open_item_management` BOOLEAN COMMENT 'Indicates whether open item management is activated for this GL account. When true, individual line items remain open until cleared against an offsetting entry (e.g., GR/IR clearing accounts, bank clearing accounts). Essential for reconciliation of goods receipt/invoice receipt accounts in F&B procurement. Corresponds to SAP SKB1.XOPVW.',
    `planning_level` STRING COMMENT 'Indicates the level at which financial planning and budgeting is performed for this account (e.g., cost center level, profit center level, company code level). Drives integration with SAP IBP and budgeting tools for demand planning, COGS forecasting, and trade spend budgeting in F&B operations.',
    `posting_block` BOOLEAN COMMENT 'Indicates whether postings to this GL account are currently blocked at the chart of accounts level. When true, no journal entries can be posted to this account across all company codes. Used during account restructuring, period-end controls, or when an account is being retired. Corresponds to SAP SKA1.XSPEB.',
    `profit_center_default` STRING COMMENT 'Default profit center assigned to this GL account for automatic profit center derivation during posting. Ensures that balance sheet items and certain P&L items are assigned to the correct profit center for segment reporting. Corresponds to SAP SKB1.PRCTR. Supports F&B brand/category P&L reporting and IFRS 8 segment disclosure.',
    `profit_loss_statement_account` BOOLEAN COMMENT 'Indicates whether this account is a profit and loss (income statement) account. P&L accounts are closed to retained earnings at fiscal year-end. Complements account_category for explicit P&L identification used in EBITDA reporting, trade spend accruals, and revenue management analytics.',
    `reconciliation_account_type` STRING COMMENT 'Indicates whether this GL account serves as a reconciliation account for a subledger (accounts payable, accounts receivable, fixed assets) or is a standard posting account. Reconciliation accounts cannot be posted to directly; postings flow through the subledger. Corresponds to SAP SKB1.MITKZ. Critical for AP/AR and fixed asset subledger integrity.. Valid values are `accounts_payable|accounts_receivable|fixed_assets|none`',
    `revaluation_indicator` BOOLEAN COMMENT 'Indicates whether this GL account is subject to foreign currency revaluation at period-end. When true, open items or balances in foreign currency are revalued to the current exchange rate. Critical for F&B companies with multi-currency operations. Corresponds to SAP SKB1 revaluation settings. Supports IFRS IAS 21 and GAAP ASC 830 compliance.',
    `sort_key` STRING COMMENT 'Defines the field used to populate the allocation field in line items posted to this account, enabling sorting and grouping of line items in account statements. Common values: 001 (posting date), 012 (document number), 031 (material number). Corresponds to SAP SKB1.ZUAWA. Supports efficient account analysis and reconciliation.. Valid values are `^[0-9]{3}$`',
    `tax_category` STRING COMMENT 'Specifies the tax category applicable to this GL account, controlling which tax codes can be used when posting to this account. Blank indicates no tax is applicable. Values such as + (all tax codes allowed), - (only input tax), or specific tax category codes. Critical for VAT/GST compliance in F&B operations across jurisdictions. Corresponds to SAP SKB1.MWSKZ. [ENUM-REF-CANDIDATE: input_tax|output_tax|all|none|input_only|output_only — promote to reference product]',
    `tolerance_group` STRING COMMENT 'Assigns the GL account to a tolerance group that defines acceptable payment difference limits for clearing open items. Controls automatic write-off of small differences during payment processing and account clearing. Corresponds to SAP SKB1.TOGRU. Relevant for AR/AP clearing in F&B trade management.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'General ledger chart of accounts master — the authoritative SSOT for all GL account codes used across the F&B enterprise. Captures account number, account type (P&L vs balance sheet), financial statement version assignment, account group, currency, tax category, reconciliation account flag, posting block status, and account hierarchy classification. Every financial posting, budget line, and cost allocation references this master. Drives journal entry classification and all financial reporting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique surrogate identifier for the cost center record in the Silver Layer lakehouse. Primary key. Entity role: MASTER_RESOURCE — represents an organizational unit the business owns and manages for cost allocation purposes.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: cost_center is defined under a legal entity; replace string code with FK to company_code',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Cost centers are assigned to specific production facilities; linking to establishment registration enables facility‑level cost tracking for regulatory compliance.',
    `packaging_profile_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_profile. Business justification: Cost centers manage packaging initiatives; the FK ties financial cost allocation to specific packaging profiles.',
    `employee_id` BIGINT COMMENT 'Employee ID of the manager accountable for costs incurred by this cost center. Used for budget ownership, variance reporting, and approval workflows. Maps to SAP field VERAK (Person Responsible). Sourced from Workday HCM.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Cost centers are assigned responsibility for specific sustainability targets in budgeting and performance tracking.',
    `activity_type_code` STRING COMMENT 'Primary activity type code associated with this cost center, representing the unit of output used for direct activity allocation (e.g., machine hours, labor hours, production runs). Used in standard costing and variance analysis. Maps to SAP CO activity type (LSTAR).. Valid values are `^[A-Z0-9_-]{1,6}$`',
    `allocation_method` STRING COMMENT 'Method used to allocate or distribute costs from this cost center to other cost objects (orders, products, other cost centers). Drives COGS calculation accuracy and variance analysis. direct_activity uses activity types; assessment and distribution use cycle-based allocation.. Valid values are `direct_activity|assessment|distribution|statistical`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved annual budget for this cost center in the cost center currency for the current fiscal year. Used as the baseline for budget vs. actual variance reporting and EBITDA forecasting. Sourced from SAP CO budget planning (KPF6).',
    `budget_fiscal_year` STRING COMMENT 'The fiscal year (four-digit integer, e.g., 2025) to which the budget_amount applies. Enables multi-year budget tracking and year-over-year variance analysis.',
    `business_area_code` STRING COMMENT 'SAP business area code representing a distinct area of operations or responsibility within the company for internal balance sheet and P&L reporting. Supports segment-level financial reporting across legal entities. Maps to SAP field GSBER.. Valid values are `^[A-Z0-9]{1,4}$`',
    `changed_by_user` STRING COMMENT 'SAP user ID of the person who last modified this cost center master record in SAP CO. Supports change audit trail and Sarbanes-Oxley internal control documentation. Maps to SAP field AENAM.. Valid values are `^[A-Z0-9_.-]{1,12}$`',
    `cogs_relevant` BOOLEAN COMMENT 'Indicates whether costs incurred by this cost center are included in COGS calculation (True) or classified as operating expenses (False). Production and quality cost centers are typically COGS-relevant; administrative and marketing cost centers are not.',
    `controlling_area_code` STRING COMMENT 'SAP Controlling (CO) area code that governs this cost center. The controlling area defines the organizational unit within which cost accounting is performed. All cost centers within a controlling area share the same chart of accounts and fiscal year variant. Maps to SAP field KOKRS.. Valid values are `^[A-Z0-9]{1,4}$`',
    `cost_center_category` STRING COMMENT 'Functional classification of the cost center indicating its primary business activity. Drives COGS allocation methodology and EBITDA reporting segmentation. Maps to SAP field KOSAR (Cost Center Category). CLASSIFICATION_OR_TYPE category.. Valid values are `production|administration|marketing|research_development|distribution|quality`',
    `cost_center_code` STRING COMMENT 'The externally-known alphanumeric code uniquely identifying the cost center within the controlling area, as assigned in SAP CO. Used in journal entries, purchase orders, and COGS allocation. Maps to SAP field KOSTL (Cost Center). BUSINESS_IDENTIFIER category.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `cost_center_description` STRING COMMENT 'Long-form description of the cost centers business purpose, scope of operations, and organizational context. Provides additional detail beyond the short name for reporting and governance.',
    `cost_center_name` STRING COMMENT 'Human-readable short name of the cost center (e.g., Chicago Snack Plant, R&D Lab - Beverages, North America Sales Region). Maps to SAP field KTEXT. IDENTITY_LABEL category.',
    `cost_center_status` STRING COMMENT 'Current lifecycle state of the cost center record. locked prevents new postings; pending_deletion marks records flagged for archival after period close. Maps to SAP deletion flag and lock indicators. LIFECYCLE_STATUS category.. Valid values are `active|inactive|locked|pending_deletion`',
    `cost_center_type` STRING COMMENT 'Operational classification distinguishing how costs flow: direct cost centers incur costs directly attributable to production (e.g., production lines); indirect and overhead centers accumulate shared costs for allocation; service centers provide internal services charged to other cost centers.. Valid values are `direct|indirect|overhead|service`',
    `cost_element_group` STRING COMMENT 'SAP cost element group associated with this cost center, defining the set of cost elements (G/L accounts) that can be posted to it. Supports cost reporting by cost element category (material, labor, overhead, depreciation).. Valid values are `^[A-Z0-9_-]{1,10}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where this cost center operates (e.g., USA, GBR, DEU). Used for statutory reporting, transfer pricing compliance, and regulatory cost allocation.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'SAP user ID of the person who created this cost center master record in SAP CO. Supports audit trail and change management governance. Maps to SAP field ERNAM.. Valid values are `^[A-Z0-9_.-]{1,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost center master record was first created in the source system (SAP CO). Supports audit trail requirements and data lineage. Maps to SAP field ERDAT/ERZET. RECORD_AUDIT_CREATED category.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which costs for this cost center are planned and reported (e.g., USD, EUR, GBP). Determines the currency for budget, actual, and variance postings. Maps to SAP field WAERS.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Organizational department code to which this cost center belongs (e.g., MFG-OPS, FIN-CTRL, MKT-BRAND). Supports departmental cost rollup reporting and aligns with HR organizational structure from Workday HCM.. Valid values are `^[A-Z0-9_-]{1,10}$`',
    `fiscal_year_variant` STRING COMMENT 'SAP fiscal year variant code defining the fiscal calendar applicable to this cost center (e.g., K4 for calendar year, V3 for April–March). Governs period-end close and budget cycle alignment. Maps to SAP field GJAHR variant.. Valid values are `^[A-Z0-9]{2}$`',
    `functional_area_code` STRING COMMENT 'SAP functional area code classifying the cost center by business function (e.g., manufacturing, sales, administration, R&D) for cost-of-sales accounting and functional income statement reporting. Maps to SAP field FKBER.. Valid values are `^[A-Z0-9]{1,16}$`',
    `geographic_region` STRING COMMENT 'Geographic region associated with this cost center (e.g., North America, Europe, Asia Pacific). Supports regional P&L reporting, trade spend analysis, and sales region cost allocation. [ENUM-REF-CANDIDATE: north_america|europe|asia_pacific|latin_america|middle_east_africa|global — promote to reference product]',
    `hierarchy_area` STRING COMMENT 'Node identifier within the standard cost center hierarchy (SAP standard hierarchy) to which this cost center belongs. Enables hierarchical cost rollup reporting from individual cost centers to plant, region, and enterprise levels. Maps to SAP field KHINR.',
    `is_intercompany` BOOLEAN COMMENT 'Indicates whether this cost center participates in intercompany cost allocations (True), meaning costs may be charged across legal entities. Triggers intercompany elimination processes during financial consolidation.',
    `is_locked_for_posting` BOOLEAN COMMENT 'Indicates whether this cost center is locked (True) to prevent new actual cost postings, typically applied during period-end close or when a cost center is being restructured. Maps to SAP CO lock indicator (SPERRK).',
    `is_statistical` BOOLEAN COMMENT 'Indicates whether this cost center is a statistical cost center (True) used only for informational reporting without actual cost postings, or a real cost center (False) that receives actual cost allocations. Maps to SAP CO statistical indicator.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this cost center master record in the source system. Supports change detection for incremental data loads and audit compliance. Maps to SAP field AEDAT/AEZET.',
    `overhead_key` STRING COMMENT 'SAP overhead key assigned to this cost center, determining the overhead surcharge rates applied during product costing. Links to overhead costing sheets used in standard cost estimates for manufactured goods. Maps to SAP field ZUORD.. Valid values are `^[A-Z0-9_-]{1,6}$`',
    `plant_code` STRING COMMENT 'SAP plant code associated with this cost center, linking manufacturing or distribution facility operations to cost accounting. Critical for COGS allocation to production plants and OEE-based variance analysis. Maps to SAP field WERKS.. Valid values are `^[A-Z0-9]{1,4}$`',
    `profit_center_code` STRING COMMENT 'Code of the profit center to which this cost center is assigned for internal profitability reporting. Enables P&L reporting at the profit center level and supports EBITDA analysis by business segment. Maps to SAP field PRCTR.. Valid values are `^[A-Z0-9_-]{1,10}$`',
    `segment_code` STRING COMMENT 'Reporting segment code (e.g., SNACKS-NA, BEVERAGES-EU, DAIRY-APAC) to which this cost center contributes. Enables EBITDA reporting by business segment per IFRS 8 operating segment disclosure requirements.. Valid values are `^[A-Z0-9_-]{1,10}$`',
    `source_record_key` STRING COMMENT 'The natural key of this cost center record in the originating source system (e.g., the concatenation of controlling area and cost center code in SAP CO: A000/CC1001). Enables traceability from the Silver Layer back to the operational system of record.',
    `source_system_code` STRING COMMENT 'Identifier of the source system from which this cost center record was extracted (e.g., SAP_CO_PRD, ORACLE_ERP_PROD). Supports data lineage tracking and multi-system reconciliation in the Silver Layer.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `standard_rate` DECIMAL(18,2) COMMENT 'Planned cost rate per unit of activity for this cost center, used in standard costing to value production orders and calculate COGS. Expressed in the cost center currency per activity unit. Variances between standard and actual rates are reported in period-end variance analysis. MEASUREMENT_OR_VALUE category.',
    `valid_from_date` DATE COMMENT 'The date from which this cost center is active and available for cost postings. Supports time-dependent master data management and ensures costs are only allocated to active cost centers. Maps to SAP field DATAB. EFFECTIVE_FROM category.',
    `valid_to_date` DATE COMMENT 'The date after which this cost center is no longer active for cost postings. A null or far-future date (e.g., 9999-12-31) indicates an open-ended cost center. Maps to SAP field DATBI. EFFECTIVE_UNTIL category.',
    `wbs_element_code` STRING COMMENT 'Work Breakdown Structure element code linking this cost center to a specific capital project or R&D initiative in SAP PS (Project System). Relevant for NPD project cost tracking and capital expenditure allocation.. Valid values are `^[A-Z0-9._-]{1,24}$`',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Cost center master data representing organizational units responsible for incurring costs — plants, production lines, sales regions, R&D labs, and corporate functions. Sourced from SAP CO. Captures cost center code, description, responsible manager, controlling area, company code, profit center assignment, cost center category (production, administration, marketing), valid-from/to dates, and currency. Foundational for COGS allocation, variance analysis, and EBITDA reporting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique surrogate identifier for the profit center record in the Silver Layer lakehouse. Primary key. Entity role: MASTER_RESOURCE — represents an internal organizational resource (autonomous business segment) used for P&L reporting in SAP CO-PCA.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: profit_center is defined under a legal entity; replace string code with FK to company_code',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Profit center performance reports need the managers employee ID for responsibility tracking and compensation alignment.',
    `allocation_method` STRING COMMENT 'Method used to allocate shared costs (e.g., manufacturing overhead, corporate G&A) to this profit center. direct — costs posted directly; assessment — periodic cycle-based allocation; distribution — proportional distribution; settlement — order/project settlement; none — no allocation applied. Impacts COGS calculation and variance analysis.. Valid values are `direct|assessment|distribution|settlement|none`',
    `brand_code` STRING COMMENT 'Code of the brand associated with this profit center when the profit center represents a brand-level P&L segment. Enables brand-level EBITDA decomposition, brand equity tracking, and trade promotion management (TPM) analysis. Null for non-brand profit centers.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `budget_period_end` DATE COMMENT 'End date of the current active budget period for this profit center. Defines the boundary for budget vs. actual comparisons, financial close processes, and period-end accruals for trade spend and COGS.',
    `budget_period_start` DATE COMMENT 'Start date of the current active budget period for this profit center. Used in budgeting, forecasting, and EBITDA variance analysis to align actuals against planned financial targets within the correct fiscal window.',
    `channel_type` STRING COMMENT 'Sales channel classification for channel-level profit centers, enabling channel-level EBITDA decomposition. Values: retail (traditional brick-and-mortar), foodservice (restaurants, cafeterias), DTC (direct-to-consumer), ecommerce (online retail), export (international distribution), institutional (B2B bulk). Null for non-channel profit centers.. Valid values are `retail|foodservice|dtc|ecommerce|export|institutional`',
    `controlling_area_code` STRING COMMENT 'SAP Controlling (CO) area code to which this profit center belongs. The controlling area defines the organizational unit within which cost and profit accounting is performed. All profit centers within a controlling area share the same chart of accounts and fiscal year variant.. Valid values are `^[A-Z0-9]{1,4}$`',
    `cost_center_code` STRING COMMENT 'SAP cost center code associated with the overhead or functional costs allocated to this profit center. Enables COGS calculation and variance analysis by linking profit center P&L to cost center cost pools (e.g., manufacturing overhead, marketing spend).. Valid values are `^[A-Z0-9_-]{1,10}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country of operation associated with this profit center. Used for country-level P&L reporting, regulatory compliance (FDA, EFSA, USDA), and transfer pricing documentation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this profit center master record was first created in the source system (SAP CO-PCA). Serves as the RECORD_AUDIT_CREATED category for this MASTER_RESOURCE entity. Used for data lineage, audit trails, and Silver Layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the profit center currency used for internal P&L reporting (e.g., USD, EUR, GBP). Profit center currency may differ from company code currency for multinational operations. Critical for EBITDA decomposition and revenue management reporting.. Valid values are `^[A-Z]{3}$`',
    `dummy_profit_center_flag` BOOLEAN COMMENT 'Indicates whether this is the SAP dummy profit center used to capture postings that cannot be assigned to a real profit center (e.g., balance sheet items, unassigned transactions). The dummy profit center is a standard SAP CO-PCA construct and must be identifiable for exclusion from P&L reporting.',
    `elimination_flag` BOOLEAN COMMENT 'Indicates whether transactions posted to this profit center are subject to intercompany elimination during group consolidation. When true, revenues and costs are eliminated in consolidated financial statements to avoid double-counting. Critical for IFRS 10 group reporting.',
    `fiscal_year_variant` STRING COMMENT 'SAP fiscal year variant code that defines the fiscal year structure for this profit center (e.g., K4 for calendar year, V3 for April–March). Determines period mapping for financial close, budgeting, and EBITDA reporting cycles.. Valid values are `^[A-Z0-9]{2}$`',
    `functional_area_code` STRING COMMENT 'SAP functional area code assigned to the profit center, classifying costs by business function (e.g., manufacturing, sales, marketing, R&D, administration). Enables cost-of-sales accounting and functional P&L reporting per IFRS requirements.. Valid values are `^[A-Z0-9_]{1,16}$`',
    `geographic_region_code` STRING COMMENT 'Code representing the geographic region (e.g., NA, EMEA, APAC, LATAM) associated with this profit center when the profit center represents a regional P&L segment. Enables regional EBITDA decomposition, cross-border intercompany reconciliation, and regulatory compliance reporting by jurisdiction.. Valid values are `^[A-Z]{2,10}$`',
    `gl_account_group` STRING COMMENT 'SAP GL account group associated with the profit center, defining the range of general ledger accounts that can post to this profit center. Ensures correct account assignment for revenue, COGS, trade spend accruals, and intercompany transactions.',
    `hierarchy_node_code` STRING COMMENT 'Code of the standard hierarchy node in SAP CO-PCA to which this profit center is assigned. Defines the position of the profit center within the enterprise profit center hierarchy, enabling roll-up reporting from individual profit centers to business units, divisions, and corporate level.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this profit center master record in the source system. Used for incremental data loading, change data capture (CDC), and audit trail maintenance in the Silver Layer lakehouse.',
    `lock_indicator` BOOLEAN COMMENT 'Indicates whether the profit center is locked for financial postings in SAP CO-PCA. When true, no new journal entries, cost allocations, or revenue postings can be made to this profit center. Used during period-end close, organizational restructuring, or audit holds.',
    `parent_profit_center_code` STRING COMMENT 'Code of the immediate parent profit center in the internal hierarchy, enabling self-referential tree traversal for roll-up P&L reporting. Null for top-level profit centers. Supports brand-level and channel-level EBITDA decomposition across hierarchical levels.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `product_line_code` STRING COMMENT 'Code of the product line (e.g., RTD beverages, RTE snacks, dairy) associated with this profit center when the profit center represents a product-line-level P&L segment. Supports product-line-level revenue management, pricing strategy (RSP/EDLP), and COGS variance analysis.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `profit_center_code` STRING COMMENT 'Externally-known alphanumeric code that uniquely identifies the profit center within the SAP CO-PCA controlling area. This is the business-facing identifier used in financial reporting, journal entries, and intercompany allocations (e.g., PC_SNACKS_NA, PC_BEV_EMEA). Serves as the BUSINESS_IDENTIFIER category for this MASTER_RESOURCE entity.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `profit_center_description` STRING COMMENT 'Free-text long description of the profit centers business purpose, scope, and organizational context. Provides additional context beyond the short name for financial analysts, auditors, and data stewards. Sourced from SAP CO-PCA long text field.',
    `profit_center_group` STRING COMMENT 'SAP profit center group to which this profit center belongs, enabling grouped reporting and planning across related profit centers (e.g., all beverage profit centers grouped under GRP_BEVERAGES). Used in planning layouts, report painter reports, and EBITDA roll-up structures.',
    `profit_center_level` STRING COMMENT 'Numeric level of the profit center within the enterprise profit center hierarchy (e.g., 1 = corporate, 2 = division, 3 = brand/channel, 4 = sub-brand). Enables hierarchical roll-up queries and drill-down analysis in EBITDA reporting and financial dashboards.',
    `profit_center_name` STRING COMMENT 'Human-readable name of the profit center as defined in SAP CO-PCA (e.g., North America Snacks, EMEA Beverages, DTC Channel). Used as the IDENTITY_LABEL in financial dashboards, EBITDA reports, and brand-level P&L decomposition.',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center in SAP CO-PCA. active — operational and accepting postings; inactive — temporarily suspended; locked — blocked for new postings (e.g., during restructuring); in_planning — set up for future fiscal year; archived — decommissioned and closed. Serves as the LIFECYCLE_STATUS category for this MASTER_RESOURCE entity.. Valid values are `active|inactive|locked|in_planning|archived`',
    `profit_center_type` STRING COMMENT 'Classification of the profit center by the dimension it represents for internal P&L reporting. Supports brand-level (e.g., a specific snack brand), product-line-level (e.g., RTD beverages), geographic-region-level (e.g., LATAM), or channel-level (e.g., retail, foodservice, DTC) EBITDA decomposition. Serves as the CLASSIFICATION_OR_TYPE category for this MASTER_RESOURCE entity.. Valid values are `brand|product_line|geographic_region|channel|business_unit|functional`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this profit center is subject to external regulatory financial reporting requirements (e.g., FDA facility-level reporting, USDA program reporting, SEC segment disclosures). When true, additional data governance controls and audit trails are applied.',
    `sap_profit_center_key` STRING COMMENT 'The natural composite key from SAP CO-PCA combining controlling area and profit center code (e.g., 1000/PC_SNACKS_NA). Preserved in the Silver Layer for traceability back to the source system and for cross-system reconciliation with Oracle Cloud ERP or other financial systems.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `segment_code` STRING COMMENT 'SAP segment classification code assigned to the profit center, enabling segment reporting per IFRS 8 / ASC 280. Segments typically align to major business divisions such as Snacks, Beverages, Dairy, or Packaged Foods. Used for external financial disclosures and investor reporting.. Valid values are `^[A-Z0-9_]{1,10}$`',
    `short_name` STRING COMMENT 'Abbreviated display name for the profit center used in space-constrained reporting interfaces, planogram layouts, and financial dashboards (e.g., NA Snacks, EMEA Bev). Sourced from SAP CO-PCA short text field.. Valid values are `^.{1,20}$`',
    `source_system_code` STRING COMMENT 'Identifier of the operational source system from which this profit center record was ingested (e.g., SAP_S4HANA_PROD, SAP_S4HANA_EU). Enables multi-system reconciliation in the Silver Layer when profit centers are managed across multiple SAP instances or ERP systems.. Valid values are `^[A-Z0-9_-]{1,30}$`',
    `standard_costing_enabled` BOOLEAN COMMENT 'Indicates whether standard costing is activated for this profit center. When true, product costs are valued at standard cost and variances (price, quantity, efficiency) are tracked against actuals. Critical for COGS calculation, margin analysis, and manufacturing variance reporting in F&B operations.',
    `sustainability_segment` STRING COMMENT 'Classification of the profit centers product portfolio or operations by sustainability commitment level. Supports ESG reporting, sustainability-linked financial targets, and green revenue tracking. sustainable — meets defined sustainability criteria; transitioning — in progress toward sustainability targets; conventional — standard operations.. Valid values are `sustainable|conventional|transitioning|not_applicable`',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code associated with the profit centers primary operating location. Used for indirect tax (VAT/GST) determination, transfer pricing compliance, and regulatory reporting to tax authorities (IRS, HMRC, etc.). Aligns with SAP tax configuration.. Valid values are `^[A-Z0-9_-]{1,15}$`',
    `transfer_price_method` STRING COMMENT 'Method used for intercompany transfer pricing when goods or services are exchanged between profit centers. cost_plus — cost plus a markup; market_price — prevailing market rate; negotiated — bilaterally agreed price; none — no intercompany transfers. Required for intercompany reconciliation and tax compliance.. Valid values are `cost_plus|market_price|negotiated|none`',
    `valid_from` DATE COMMENT 'Date from which this profit center is valid and active for financial postings in SAP CO-PCA. Supports time-dependent master data management and ensures correct period assignment during financial close and historical reporting.',
    `valid_to` DATE COMMENT 'Date until which this profit center is valid for financial postings. After this date, the profit center is locked for new postings. Null indicates an open-ended validity. Used for decommissioning profit centers during organizational restructuring or brand divestitures.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Profit center master representing autonomous business segments for internal P&L reporting — brands, product lines, geographic regions, or channels (retail, foodservice, DTC). Sourced from SAP CO-PCA. Captures profit center code, name, hierarchy node, responsible manager, company code, controlling area, segment classification, and currency. Enables brand-level and channel-level EBITDA decomposition critical to F&B revenue management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`company_code` (
    `company_code_id` BIGINT COMMENT 'Unique surrogate identifier for the company code record in the Food Beverage lakehouse Silver layer. Primary key for this entity. Role classification: MASTER_RESOURCE — represents a legal entity (incorporated company, subsidiary, joint venture, or holding entity) that the business owns and manages within the Food Beverage group.',
    `accounting_standard` STRING COMMENT 'The primary accounting standard under which this company code prepares its statutory financial statements. Determines recognition, measurement, and disclosure rules for revenue, inventory (COGS/FIFO), fixed assets, and trade spend accruals. Drives parallel ledger configuration in SAP.. Valid values are `IFRS|US_GAAP|LOCAL_GAAP|IFRS_and_LOCAL`',
    `address_city` STRING COMMENT 'City of the registered office of the legal entity. Used in statutory filings, regulatory submissions, and legal correspondence. Classified as confidential organizational contact data.',
    `address_postal_code` STRING COMMENT 'Postal or ZIP code of the registered office of the legal entity. Used for tax jurisdiction determination, regulatory filings, and statutory correspondence.',
    `address_region` STRING COMMENT 'State, province, or region of the registered office. Used for sub-national tax jurisdiction determination, state-level regulatory compliance (e.g., California Prop 65 for food labeling), and regional statutory reporting.',
    `address_street` STRING COMMENT 'Street address of the registered office of the legal entity as recorded in the official company registry. Used for statutory correspondence, regulatory filings with FDA/USDA/EFSA, and legal notices. Classified as confidential organizational contact data.',
    `business_area` STRING COMMENT 'SAP business area code representing the operational division or segment within the Food Beverage group (e.g., North America Snacks, EMEA Beverages, APAC Dairy). Used for segment-level financial reporting, cross-company-code balance sheet preparation, and divisional P&L analysis.',
    `chart_of_accounts` STRING COMMENT 'The SAP chart of accounts key assigned to this company code, defining the general ledger account structure used for financial postings. Governs the GL account hierarchy, COGS account assignments, revenue accounts, and trade spend accrual accounts. Maps to SAP KTOPL field.. Valid values are `^[A-Z0-9]{1,4}$`',
    `company_code_code` STRING COMMENT 'The four-character alphanumeric SAP FI company code that uniquely identifies the legal entity within the ERP system. This is the externally-known business identifier used across all SAP modules (FI, CO, MM, SD, PP) and in intercompany transactions, statutory reporting, and financial consolidation. Maps directly to the BUKRS field in SAP.. Valid values are `^[A-Z0-9]{1,4}$`',
    `company_code_status` STRING COMMENT 'Current lifecycle status of the company code within the Food Beverage group. Controls whether the entity is available for posting, planning, and reporting. Inactive or dormant entities are excluded from operational processes but retained for historical audit and statutory purposes.. Valid values are `active|inactive|in_liquidation|dormant|pending_registration`',
    `company_registration_number` STRING COMMENT 'Official company registration number issued by the national company registry (e.g., Companies House in the UK, SEC in the US, Handelsregister in Germany). Used for statutory filings, regulatory submissions, and legal entity verification in trade agreements.',
    `consolidation_group` STRING COMMENT 'The consolidation group or reporting unit to which this company code belongs within the Food Beverage group financial consolidation structure. Used in SAP Group Reporting or BPC to aggregate financial results for segment reporting, EBITDA roll-ups, and statutory consolidated accounts.',
    `consolidation_indicator` BOOLEAN COMMENT 'Flag indicating whether this company code is included in the Food Beverage group consolidated financial statements. Entities with this flag set to false (e.g., dormant shells, entities below materiality threshold) are excluded from group EBITDA reporting and multi-entity consolidation runs.',
    `controlling_area` STRING COMMENT 'SAP Controlling (CO) area to which this company code is assigned. The controlling area defines the organizational unit for management accounting, cost center accounting, profit center accounting, COGS variance analysis, and standard costing. A single controlling area may span multiple company codes for cross-entity cost allocation. Maps to SAP KOKRS field.. Valid values are `^[A-Z0-9]{1,4}$`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 Alpha-3 country code representing the country in which the legal entity is incorporated and registered. Determines applicable tax jurisdiction, regulatory reporting requirements (FDA, EFSA, USDA), and statutory accounting standards.. Valid values are `^[A-Z]{3}$`',
    `credit_control_area` STRING COMMENT 'SAP credit control area assigned to this company code, governing customer credit limit management, accounts receivable exposure monitoring, and credit risk controls for trade customers. Relevant for revenue management and trade spend credit exposure. Maps to SAP KKBER field.. Valid values are `^[A-Z0-9]{1,4}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the local (functional) currency of the company code. All financial postings, COGS calculations, standard costing, and statutory financial statements for this entity are denominated in this currency. Maps to SAP WAERS field.. Valid values are `^[A-Z]{3}$`',
    `deactivation_date` DATE COMMENT 'The date on which the company code was deactivated or blocked for new postings in SAP FI. Null for currently active entities. Used to manage the lifecycle of dormant, liquidated, or divested entities within the Food Beverage group and to control consolidation scope.',
    `entity_type` STRING COMMENT 'Classification of the legal entity within the Food Beverage corporate group structure. Drives consolidation treatment, intercompany elimination rules, and statutory reporting obligations. [ENUM-REF-CANDIDATE: subsidiary|joint_venture|holding|branch|associate|operating_entity — promote to reference product if additional types are needed]. Valid values are `subsidiary|joint_venture|holding|branch|associate|operating_entity`',
    `erp_system_instance` STRING COMMENT 'Identifier of the SAP S/4HANA or Oracle Cloud ERP system instance from which this company code record is sourced. Relevant for Food Beverage entities that operate across multiple ERP landscapes (e.g., post-acquisition entities not yet migrated to the central SAP instance). Supports data lineage and source system traceability.',
    `fiscal_year_variant` STRING COMMENT 'SAP fiscal year variant code defining the fiscal calendar structure for this company code — including whether the fiscal year is calendar-year aligned or offset (e.g., April–March, October–September), and the number of posting periods. Critical for period-end close, budgeting cycles, and demand planning alignment. Maps to SAP PERIV field.. Valid values are `^[A-Z0-9]{2}$`',
    `food_safety_license_number` STRING COMMENT 'Regulatory license or registration number issued by the applicable food safety authority (e.g., FDA Food Facility Registration Number, USDA Establishment Number, EFSA authorization number) for this legal entity. Required for manufacturing, importing, or distributing food and beverage products. Critical for FSMA compliance and GFSI certification tracking.',
    `functional_currency_indicator` BOOLEAN COMMENT 'Flag indicating whether the local currency of this company code is also its functional currency as defined under IFRS IAS 21. When false, a separate functional currency determination is required, impacting foreign currency translation adjustments in the consolidated financial statements.',
    `gfsi_certification_scheme` STRING COMMENT 'The GFSI-benchmarked food safety certification scheme held by this legal entity. Indicates the food safety management standard under which the entity operates (e.g., SQF, BRC, FSSC 22000). Used for supplier qualification, customer compliance requirements, and regulatory audit readiness. [ENUM-REF-CANDIDATE: SQF|BRC|FSSC_22000|IFS|GlobalGAP|not_certified — promote to reference product]. Valid values are `SQF|BRC|FSSC_22000|IFS|GlobalGAP|not_certified`',
    `group_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the Food Beverage group reporting currency used in consolidated financial statements, EBITDA reporting, and multi-entity consolidation. Typically USD or EUR for global food and beverage groups. Enables currency translation for intercompany eliminations.. Valid values are `^[A-Z]{3}$`',
    `gst_applicable` BOOLEAN COMMENT 'Flag indicating whether Goods and Services Tax (GST) or equivalent consumption tax applies to transactions of this company code. Relevant for entities operating in GST jurisdictions (e.g., Australia, Canada, India, Singapore). Drives tax code determination in SAP SD and MM for food and beverage product sales.',
    `incorporation_date` DATE COMMENT 'The date on which the legal entity was formally incorporated and registered with the relevant national company registry. Used for entity age calculations, statutory anniversary filings, and historical financial consolidation scope determination.',
    `intercompany_indicator` BOOLEAN COMMENT 'Flag indicating whether this company code participates in intercompany transactions within the Food Beverage group. When true, the entity is subject to intercompany elimination rules during group consolidation, transfer pricing policies, and intercompany billing processes. Maps to SAP intercompany configuration.',
    `language_key` STRING COMMENT 'Two-letter ISO 639-1 language code representing the primary language used for correspondence, statutory documents, and regulatory filings for this company code. Drives language-specific output for invoices, financial statements, and FDA/EFSA regulatory submissions.. Valid values are `^[A-Z]{2}$`',
    `ledger_group` STRING COMMENT 'SAP ledger group assigned to this company code, enabling parallel accounting under multiple accounting standards (e.g., IFRS and local GAAP simultaneously). Supports multi-GAAP reporting requirements for Food Beverage entities operating across jurisdictions with different statutory requirements.',
    `legal_name` STRING COMMENT 'The full registered legal name of the incorporated entity as it appears in the official company registry of the country of incorporation. Used for statutory reporting, regulatory filings, intercompany agreements, and financial consolidation disclosures.',
    `parent_company_code` STRING COMMENT 'The SAP company code of the immediate parent entity within the Food Beverage group legal entity hierarchy. Enables traversal of the corporate ownership structure for intercompany elimination, transfer pricing, and group consolidation. Self-referencing for the ultimate holding entity.. Valid values are `^[A-Z0-9]{1,4}$`',
    `posting_period_variant` STRING COMMENT 'SAP posting period variant that controls which fiscal periods are open or closed for financial postings in this company code. Governs the financial close process, period-end accruals, and trade spend accrual postings. Maps to SAP XVPER field.. Valid values are `^[A-Z0-9]{1,4}$`',
    `profit_center_standard` STRING COMMENT 'Default SAP profit center assigned to this company code for management accounting purposes. Profit centers align to business units (e.g., Snacks, Beverages, Dairy) and are used for internal P&L reporting, EBITDA analysis by segment, and revenue management reporting.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the company code master record was first created in the source ERP system (SAP FI or Oracle Cloud ERP). Represents the business creation event, not the lakehouse ingestion time. Used for audit trail, data lineage, and entity lifecycle tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the company code master record in the source ERP system. Used for change data capture (CDC), incremental lakehouse loads, and audit trail compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `short_name` STRING COMMENT 'Abbreviated or trading name of the legal entity used in internal reporting, dashboards, and operational communications where the full legal name is impractical. Corresponds to the SAP company code short description field.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this company code master record was ingested into the lakehouse. Supports data lineage, reconciliation, and audit trail requirements for the Silver layer. Values: SAP_S4 (SAP S/4HANA FI), ORACLE_CLOUD (Oracle Cloud ERP Financials), LEGACY (pre-migration legacy ERP).. Valid values are `SAP_S4|ORACLE_CLOUD|LEGACY`',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code identifying the specific federal, state/province, and local tax authority applicable to this company code. Used for automated tax calculation on sales orders, purchase orders, and intercompany transactions. Drives compliance with FDA, USDA, and local food safety levy requirements. Maps to SAP TXJCD field.',
    `tax_number` STRING COMMENT 'Employer Identification Number (EIN) or equivalent national tax identification number assigned to the legal entity by the relevant tax authority. Used for statutory tax filings, payroll tax reporting, and regulatory submissions to FDA and USDA.',
    `transfer_pricing_method` STRING COMMENT 'The OECD-approved transfer pricing method applied to intercompany transactions involving this company code. Governs how intercompany prices are set for goods (e.g., finished snacks, beverages transferred between manufacturing and distribution entities) and services. Critical for tax compliance and EBITDA integrity across the group. [ENUM-REF-CANDIDATE: CUP|resale_price|cost_plus|TNMM|profit_split|not_applicable — promote to reference product]. Valid values are `CUP|resale_price|cost_plus|TNMM|profit_split|not_applicable`',
    `vat_registration_number` STRING COMMENT 'Value Added Tax (VAT) registration number issued by the tax authority of the country of incorporation. Required for EU VAT compliance, cross-border trade invoicing, and regulatory reporting to EFSA and national tax authorities. Used in intercompany billing and trade documentation.',
    CONSTRAINT pk_company_code PRIMARY KEY(`company_code_id`)
) COMMENT 'Legal entity master representing each incorporated company within the Food Beverage group — subsidiaries, joint ventures, and holding entities across geographies. Sourced from SAP FI. Captures company code, legal name, country, currency, fiscal year variant, chart of accounts assignment, tax jurisdiction, VAT registration number, and intercompany indicator. Governs statutory reporting, intercompany eliminations, and multi-entity consolidation.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique surrogate identifier for each journal entry record in the Silver Layer lakehouse. Primary key for the journal_entry data product. Entity role: TRANSACTION_HEADER — represents a discrete financial posting event in the general ledger.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Journal entry belongs to a company; replace string code with FK to company_code',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entry belongs to a cost center; add FK to cost_center',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SOX audit requires tracking which employee created each journal entry; linking created_by_employee_id to employee provides mandatory accountability.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Journal entry references a GL account; add FK to gl_account',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Journal entry belongs to a profit center; add FK to profit_center',
    `assignment` STRING COMMENT 'Free-text or structured assignment field used for sorting and matching open items (e.g., invoice number, payment reference, purchase order number). Critical for automated payment clearing, dunning, and accounts payable/receivable reconciliation.',
    `business_area` STRING COMMENT 'SAP business area code representing an organizational unit (e.g., Snacks, Beverages, Dairy, Packaged Foods) for which internal financial statements can be drawn. Enables segment reporting and divisional P&L analysis without requiring separate company codes.',
    `controlling_area` STRING COMMENT 'SAP controlling area code that groups company codes for management accounting purposes. Defines the organizational scope for cost center accounting, internal orders, and profitability analysis (CO-PA). Enables cross-company-code cost allocation and EBITDA reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center` STRING COMMENT 'SAP cost center code identifying the organizational unit responsible for cost incurrence (e.g., a manufacturing plant, distribution center, or functional department). Drives COGS allocation, overhead absorption, and variance analysis in the CO module.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the journal entry record was first created in the source system (SAP S/4HANA). Captures the precise date and time of system entry for audit trail, SOX compliance, and data lineage tracking in the Silver Layer lakehouse.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code of the transaction currency in which the journal entry amounts are originally denominated (e.g., USD, EUR, GBP, CAD). Distinct from local/company-code currency. Required for multi-currency consolidation and FX reporting.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date of the original source document (invoice, receipt, contract, etc.) that triggered the journal entry. May differ from posting_date; used for aging analysis, payment terms calculation, and audit substantiation.',
    `document_header_text` STRING COMMENT 'Free-text description at the journal entry header level providing business context for the posting (e.g., Monthly COGS accrual — Plant 1001, Trade spend settlement Q3, Intercompany recharge — Snacks Division). Supports audit review and financial close commentary.',
    `document_number` STRING COMMENT 'Externally visible ten-digit accounting document number assigned by SAP S/4HANA FI at the time of posting. Uniquely identifies the journal entry within a company code and fiscal year. Used for audit trail, drill-down, and cross-reference with source documents.. Valid values are `^[0-9]{10}$`',
    `document_status` STRING COMMENT 'Current workflow state of the journal entry in the financial close process. draft = not yet posted; posted = active in GL; parked = saved but not posted pending approval; reversed = offset by a reversal document; cleared = open items matched; blocked = held for review.. Valid values are `draft|posted|parked|reversed|cleared|blocked`',
    `document_type` STRING COMMENT 'Two-character SAP document type code classifying the nature of the journal entry (e.g., SA=General Ledger, KR=Vendor Invoice, DR=Customer Invoice, AB=Asset Posting, WA=Goods Issue, ML=Material Ledger). Controls number range assignment and field selection. [ENUM-REF-CANDIDATE: SA|KR|DR|AB|WA|ML|KZ|DZ|RE|RV — promote to reference product]. Valid values are `^[A-Z0-9]{2}$`',
    `entry_date` DATE COMMENT 'The calendar date on which the journal entry record was created in the system. Distinct from posting_date (accounting effect) and document_date (source document). Used for audit trail and data lineage.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign currency exchange rate applied to translate document-currency amounts to local currency at the time of posting. Expressed as units of local currency per one unit of document currency. Critical for FX gain/loss calculation and multi-currency consolidation.',
    `fiscal_period` STRING COMMENT 'Numeric fiscal posting period (1–16) within the fiscal year. Periods 1–12 represent standard months; periods 13–16 are special closing periods used for year-end adjustments. Drives period-end close, trial balance, and P&L reporting.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year in which the journal entry is recorded. Used for period-end close, financial statement preparation, and year-over-year variance analysis. May differ from calendar year depending on the companys fiscal year variant.',
    `gl_account` STRING COMMENT 'General Ledger account number from the chart of accounts to which the journal entry is posted. Determines the financial statement line (P&L or balance sheet) affected. Drives trial balance, COGS calculation, trade spend accruals, and regulatory reporting.. Valid values are `^[0-9]{6,10}$`',
    `intercompany_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry involves a transaction between two legal entities within the Food Beverage group (True) or is a standalone entity posting (False). Intercompany entries require elimination during group consolidation and are subject to transfer pricing policies.',
    `internal_order` STRING COMMENT 'SAP internal order number used to collect costs for a specific project, campaign, or temporary cost object (e.g., a new product launch, capital project, or trade promotion). Enables granular cost tracking beyond cost center level for NPD and trade spend management.',
    `journal_entry_type` STRING COMMENT 'Business classification of the journal entry by its accounting purpose. standard = regular transaction posting; accrual = period-end accrual; reversal = offset of prior posting; recurring = periodic template-based entry; statistical = non-financial reporting entry; intercompany = cross-entity transaction. Drives financial close workflow and EBITDA reporting.. Valid values are `standard|accrual|reversal|recurring|statistical|intercompany`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the journal entry record in the source system. Used for incremental data loading, change data capture (CDC), and audit trail maintenance in the Silver Layer. Supports financial close monitoring and SOX controls.',
    `ledger_group` STRING COMMENT 'Identifier for the accounting ledger group to which the journal entry is posted (e.g., 0L for leading ledger, L1 for IFRS parallel ledger, L2 for local GAAP ledger). Supports parallel accounting under multiple accounting standards (IFRS and US GAAP simultaneously).',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code of the company codes local (functional) currency. Used for statutory financial reporting in the country of the legal entity. Enables translation of document-currency amounts to local currency for balance sheet and P&L.. Valid values are `^[A-Z]{3}$`',
    `posting_date` DATE COMMENT 'The date on which the journal entry is posted to the general ledger and affects account balances. Determines the fiscal period assignment. Critical for period-end cut-off, accrual accuracy, and regulatory reporting.',
    `posting_key` STRING COMMENT 'Two-digit SAP posting key controlling the debit/credit indicator, account type, and field selection for the journal entry. Standard values include 40 (GL debit), 50 (GL credit), 31 (vendor credit), 21 (vendor debit), 01 (customer debit), 11 (customer credit). Drives account determination and field status.. Valid values are `^[0-9]{2}$`',
    `posting_period_status` STRING COMMENT 'Status of the fiscal period to which this journal entry belongs at the time of analysis. open = period accepting postings; closed = period locked after financial close; blocked = temporarily restricted; future = not yet open. Supports period-end close monitoring and financial reporting integrity.. Valid values are `open|closed|blocked|future`',
    `profit_center` STRING COMMENT 'SAP profit center code identifying the organizational unit responsible for revenue and cost accountability (e.g., a brand, product line, or geographic market). Enables profitability analysis, brand-level P&L, and EBITDA reporting by business unit.',
    `reference_document_number` STRING COMMENT 'External reference number from the originating source document (e.g., vendor invoice number, purchase order number, sales order number, or EDI transaction reference). Enables cross-referencing between the journal entry and upstream operational documents for audit and reconciliation.',
    `reversal_document_number` STRING COMMENT 'Accounting document number of the corresponding reversal or reversed document. Populated when reversal_indicator is True (this is the reversal) or when this document has been reversed by another. Enables bidirectional audit trail linkage between original and reversal postings.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry is a reversal document (True) or an original posting (False). Reversal entries offset prior postings for corrections, accrual reversals, or period-end adjustments. Critical for audit trail integrity and financial close accuracy.',
    `reversal_reason_code` STRING COMMENT 'Code identifying the business reason for reversing the journal entry (e.g., 01=Reversal in current period, 02=Reversal in next period, 03=Accrual reversal, 04=Error correction). Supports financial close governance and SOX control documentation.',
    `source_system` STRING COMMENT 'Identifier of the operational system of record from which the journal entry originated (e.g., SAP_S4HANA for primary ERP, ORACLE_ERP for subsidiary systems, MANUAL for spreadsheet uploads, INTERFACE for EDI/API feeds). Supports data lineage, reconciliation, and Silver Layer provenance tracking.. Valid values are `SAP_S4HANA|ORACLE_ERP|MANUAL|INTERFACE|LEGACY`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount (VAT, GST, sales tax) associated with the journal entry in document currency. Populated for tax-relevant postings. Used for tax return preparation, VAT reconciliation, and regulatory reporting to FDA, USDA, and tax authorities.',
    `tax_code` STRING COMMENT 'Two-character SAP tax code identifying the applicable tax condition (e.g., V1=Input VAT 10%, A1=Output VAT 10%, I0=Zero-rated, X0=Tax-exempt). Drives automatic tax calculation, tax account determination, and VAT/GST reporting to tax authorities.. Valid values are `^[A-Z0-9]{2}$`',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'Sum of all credit line item amounts in the document currency for this journal entry. Must equal total_debit_amount for a balanced entry. Used for trial balance validation, financial statement generation, and double-entry integrity checks.',
    `total_credit_amount_lc` DECIMAL(18,2) COMMENT 'Sum of all credit line item amounts translated to the company codes local (functional) currency. Paired with total_debit_amount_lc for local-currency trial balance and statutory reporting.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'Sum of all debit line item amounts in the document currency for this journal entry. Must equal total_credit_amount for a balanced entry (double-entry bookkeeping). Used for trial balance validation, financial statement generation, and EBITDA reporting.',
    `total_debit_amount_lc` DECIMAL(18,2) COMMENT 'Sum of all debit line item amounts translated to the company codes local (functional) currency. Used for statutory financial reporting, local GAAP compliance, and country-level P&L and balance sheet preparation.',
    `trading_partner_code` STRING COMMENT 'Company code of the intercompany trading partner when intercompany_indicator is True. Used for intercompany elimination during group consolidation, transfer pricing documentation, and intercompany reconciliation processes.. Valid values are `^[A-Z0-9]{4}$`',
    `wbs_element` STRING COMMENT 'SAP Work Breakdown Structure element code for project-based cost assignment (e.g., capital expenditure projects, plant expansion, new production line installation). Enables project cost tracking, capitalization decisions, and fixed asset accounting.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Core financial posting document capturing every debit/credit transaction in the general ledger — the atomic unit of financial truth for the F&B enterprise. Encompasses document header (document number, company code, fiscal year, posting date, document type, currency, exchange rate, reversal indicator) and all constituent line items (line number, GL account, debit/credit indicator, amounts in document and local currency, cost center, profit center, tax code, assignment text, business area). Drives all financial statements, trial balance generation, regulatory reporting, COGS allocation, and variance drill-down for F&B manufacturing and trade spend.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Unique surrogate identifier for the accounts payable invoice record in the Silver Layer lakehouse. Primary key for this entity. Entity role: TRANSACTION_HEADER.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: ap_invoice belongs to a legal entity; replace string code with FK to company_code',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which this invoice expense is allocated for internal cost accounting and COGS/EBITDA reporting.',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document confirming physical receipt of goods or services, used in three-way match (PO, GR, invoice) verification. Enables FIFO/FEFO inventory costing alignment.',
    `payment_run_id` BIGINT COMMENT 'The identifier of the SAP automatic payment program run (F110) that processed this invoice payment. Used for batch payment reconciliation, bank file tracing, and payment run audit.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice is matched as part of the three-way match process (PO, goods receipt, invoice). Critical for COGS accruals and procurement compliance.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor (supplier) master record who issued this invoice. Covers raw material and ingredient suppliers, co-packers, 3PL providers, packaging vendors, and indirect service providers. Satisfies PARTY_REFERENCE category for TRANSACTION_HEADER role.',
    `blocking_reason` STRING COMMENT 'The reason code explaining why an invoice has been placed on payment hold (e.g., price variance, quantity variance, quality hold, missing GR, duplicate invoice). Used for dispute management and supplier performance tracking. [ENUM-REF-CANDIDATE: price_variance|quantity_variance|quality_hold|missing_gr|duplicate|missing_po|terms_dispute — promote to reference product]',
    `clearing_date` DATE COMMENT 'The date on which the invoice was cleared in the AP subledger, confirming full settlement. Used for DPO calculation, working capital reporting, and financial close reconciliation.',
    `clearing_status` STRING COMMENT 'Indicates whether the invoice has been fully cleared (paid and matched), partially cleared, or remains open in the AP subledger. reversed indicates a posting reversal. Used for AP aging analysis and period-end close.. Valid values are `open|partially_cleared|cleared|reversed`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this AP invoice record was first created in the source system (SAP FI-AP). Satisfies RECORD_AUDIT_CREATED category for TRANSACTION_HEADER role. Used for data lineage, audit trail, and SLA measurement.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code of the invoice (e.g., USD, EUR, GBP). Part of the MONETARY_TRIPLET. Required for multi-currency operations across global Food Beverage markets and foreign exchange revaluation.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The cash discount amount available if payment is made by the discount_due_date. Represents the financial benefit of early payment programs. Tracked for ROI analysis of working capital optimization initiatives.',
    `discount_captured` BOOLEAN COMMENT 'Indicates whether the early payment discount was successfully captured at time of payment. Used to measure discount capture rate KPI and evaluate treasury performance against working capital targets.',
    `discount_due_date` DATE COMMENT 'The deadline by which payment must be made to capture the early payment discount offered by the vendor (e.g., 2% if paid within 10 days). Used for dynamic discounting and working capital optimization programs.',
    `due_date` DATE COMMENT 'The date by which payment must be made to the vendor to comply with agreed payment terms and avoid late payment penalties. Calculated from invoice_date and payment_terms_code. Critical for cash flow forecasting and working capital management.',
    `edi_transaction_reference` STRING COMMENT 'The EDI transaction identifier for invoices received electronically via EDI 810 (Invoice) transaction set. Used for automated invoice matching, EDI reconciliation, and supplier EDI compliance tracking in F&B procurement.',
    `entry_date` DATE COMMENT 'The date the invoice was entered into the SAP system (BKPF.CPUDT). Used for invoice processing cycle time analysis and SLA compliance tracking.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the invoice currency to the local company code currency at the time of posting. Used for FX variance analysis and treasury reporting.',
    `fiscal_period` STRING COMMENT 'The fiscal posting period (01–12 for regular periods, 13–16 for special periods) within the fiscal year. Used for monthly financial close, accrual management, and period-over-period variance analysis.. Valid values are `^(0[1-9]|1[0-6])$`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this invoice posting belongs (SAP BKPF.GJAHR). Used for period-end financial close, EBITDA reporting, and budget variance analysis.. Valid values are `^[0-9]{4}$`',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this invoice is posted for financial reporting (e.g., COGS raw materials, packaging expense, logistics cost). Enables P&L line item analysis and EBITDA reporting.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total gross amount of the invoice before tax deductions and discounts, as stated on the vendor invoice. Part of the MONETARY_TRIPLET required for TRANSACTION_HEADER role. Used for COGS accruals, cash flow forecasting, and working capital analysis.',
    `invoice_date` DATE COMMENT 'The date printed on the vendors invoice document, representing the principal business event date of the invoice. Used for payment terms calculation, aging analysis, and cash flow forecasting. Satisfies BUSINESS_EVENT_TIMESTAMP category for TRANSACTION_HEADER role.',
    `invoice_reference_text` STRING COMMENT 'Free-text reference or description field from the vendor invoice or AP clerk entry (SAP BKPF.BKTXT). May contain delivery note numbers, contract references, or service period descriptions. Used for invoice search and dispute resolution.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the AP invoice through the payables workflow. Satisfies LIFECYCLE_STATUS category for TRANSACTION_HEADER role. blocked indicates a hold pending resolution (price, quantity, or quality discrepancy).. Valid values are `open|in_review|approved|blocked|paid|cancelled`',
    `invoice_type` STRING COMMENT 'Classification of the invoice document type. credit_memo represents vendor credits for returns or adjustments. intercompany covers transactions between legal entities within the Food Beverage group. Drives accounting treatment and workflow routing.. Valid values are `standard|credit_memo|debit_memo|recurring|intercompany`',
    `is_intercompany` BOOLEAN COMMENT 'Indicates whether this invoice represents a transaction between two legal entities within the Food Beverage corporate group. Intercompany invoices require elimination in consolidated financial statements per IFRS IAS 27.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this invoice is part of a recurring payment schedule (e.g., monthly 3PL service fees, lease payments, SaaS subscriptions). Used for automated accrual management and cash flow forecasting.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The net invoice amount translated to the company code local currency (e.g., USD for US entities) using the exchange rate at posting date. Used for consolidated financial reporting and EBITDA calculation.',
    `match_status` STRING COMMENT 'Indicates the result of the three-way match process comparing the purchase order, goods receipt, and vendor invoice. three_way_matched confirms all three documents align within tolerance. Critical for invoice approval and COGS accuracy.. Valid values are `not_matched|two_way_matched|three_way_matched|exception`',
    `net_amount` DECIMAL(18,2) COMMENT 'The net payable amount after tax and discount adjustments (gross_amount minus discounts plus tax_amount). Part of the MONETARY_TRIPLET. Represents the actual cash obligation to the vendor for payment execution.',
    `payment_date` DATE COMMENT 'The actual date on which payment was executed and funds were disbursed to the vendor. Used for Days Payable Outstanding (DPO) calculation, cash flow actuals, and supplier payment compliance reporting.',
    `payment_document_number` STRING COMMENT 'The SAP FI accounting document number generated when the payment was executed (clearing document). Links the invoice to its payment for reconciliation and audit trail purposes.',
    `payment_method` STRING COMMENT 'The payment instrument used to settle this invoice (ACH electronic transfer, wire transfer, check, virtual card, or direct debit). Drives payment run configuration and bank reconciliation processes.. Valid values are `ACH|wire|check|virtual_card|direct_debit`',
    `payment_terms_code` STRING COMMENT 'The SAP payment terms key (e.g., NT30, 2/10NET30) defining the due date calculation and early payment discount conditions. Drives cash flow forecasting, working capital optimization, and early-payment discount capture strategy.',
    `plant_code` STRING COMMENT 'The SAP plant code identifying the manufacturing facility, distribution center, or warehouse that received the goods or services invoiced. Used for plant-level COGS analysis and supply chain cost allocation.',
    `posting_date` DATE COMMENT 'The date on which the invoice was posted to the general ledger in SAP FI (BKPF.BUDAT). Determines the accounting period for financial close and COGS accrual recognition.',
    `procurement_category` STRING COMMENT 'Business spend category classifying the nature of the goods or services invoiced. Enables COGS vs. SG&A allocation, category spend analytics, and supplier segmentation. [ENUM-REF-CANDIDATE: raw_material|packaging|co_packing|3pl_logistics|indirect_services|capex|toll_manufacturing|marketing|utilities|maintenance — promote to reference product]',
    `sap_document_number` STRING COMMENT 'The internal SAP FI accounting document number assigned upon invoice posting (BKPF.BELNR). Used for cross-referencing with general ledger entries and financial close processes.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount (VAT, GST, sales tax) applied to this invoice. Part of the MONETARY_TRIPLET. Used for tax reporting, input tax recovery, and compliance with FDA/USDA indirect cost regulations.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this AP invoice record in the source system. Satisfies RECORD_AUDIT_UPDATED category for TRANSACTION_HEADER role. Used for incremental data loading and change data capture in the lakehouse.',
    `vendor_bank_account` STRING COMMENT 'The vendors bank account identifier used for payment execution (masked/tokenized for security). Required for ACH and wire payment processing. Classified as confidential financial data per PCI DSS and internal treasury controls.',
    `vendor_invoice_number` STRING COMMENT 'The externally-assigned invoice number as printed on the vendors invoice document. Used for vendor reconciliation, dispute resolution, and audit trail. Satisfies BUSINESS_IDENTIFIER category for TRANSACTION_HEADER role.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts payable full lifecycle record encompassing invoice receipt through payment execution and settlement for all vendor obligations — raw material and ingredient suppliers, co-packers, 3PL providers, packaging vendors, and indirect service providers. Covers three-way match (PO, GR, invoice), invoice verification (vendor invoice number, vendor account, invoice date, payment terms, gross/tax/net amounts, match status, blocking reasons), payment execution (payment document, payment method including ACH/wire/check, bank account, payment date, discount captured, payment run ID), and clearing/settlement status. Sourced from SAP FI-AP. Critical for COGS accruals, cash flow forecasting, working capital optimization, supplier payment compliance, and early-payment discount capture in F&B procurement.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'Unique surrogate identifier for the accounts receivable invoice record in the Silver layer lakehouse. Primary key. Entity role: TRANSACTION_HEADER.',
    `account_id` BIGINT COMMENT 'Reference to the customer (retail chain, foodservice distributor, convenience operator, or DTC consumer) to whom this invoice is issued. Satisfies TRANSACTION_HEADER PARTY_REFERENCE category.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: ar_invoice belongs to a legal entity; replace string code with FK to company_code',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AR invoice belongs to a cost center; replace code with FK',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AR invoice references a GL account; add FK to gl_account',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: AR invoice belongs to a profit center; replace code with FK',
    `order_id` BIGINT COMMENT 'Reference to the originating sales order from which this invoice was generated, enabling order-to-cash traceability.',
    `billing_company_code` STRING COMMENT 'SAP company code of the legal entity issuing the invoice. Required for intercompany reconciliation, statutory reporting, and multi-entity financial consolidation.',
    `billing_document_number` STRING COMMENT 'Externally-known SAP SD billing document number (VBELN) that uniquely identifies this invoice in the source system and on customer-facing documents. Satisfies TRANSACTION_HEADER BUSINESS_IDENTIFIER category.',
    `channel_type` STRING COMMENT 'Commercial channel through which the sale was made. Enables channel-level revenue reporting, trade spend analysis, and margin management across retail, foodservice, DTC, and e-commerce.. Valid values are `retail|foodservice|convenience|dtc|ecommerce|club`',
    `clearing_date` DATE COMMENT 'Date on which the invoice was cleared (fully settled) in SAP FI-AR. Used for DSO calculation, aging analysis, and period-end close reconciliation.',
    `clearing_document_number` STRING COMMENT 'SAP FI clearing document number (AUGBL) assigned when the invoice is fully or partially cleared against a payment or credit memo. Null for open items.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the source system (SAP FI-AR). Used for audit trail and data lineage. Satisfies TRANSACTION_HEADER RECORD_AUDIT_CREATED category.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this invoice (e.g., USD, EUR, GBP, CAD). Required for multi-currency revenue reporting and FX translation. Part of TRANSACTION_HEADER MONETARY_TRIPLET.. Valid values are `^[A-Z]{3}$`',
    `deduction_amount` DECIMAL(18,2) COMMENT 'Dollar value of customer-taken deductions against this invoice (e.g., promotional allowances, freight claims, shortage claims). Central to F&B deduction management and trade spend reconciliation.',
    `deduction_code` STRING COMMENT 'Standardized code classifying the reason for a customer deduction (e.g., promotional allowance, freight claim, shortage, pricing dispute). Enables deduction analytics and recovery tracking. [ENUM-REF-CANDIDATE: promo_allowance|freight_claim|shortage|pricing_dispute|quality_claim|early_pay_discount|other — promote to reference product]',
    `dispute_reason` STRING COMMENT 'Free-text or coded description of the reason the customer has disputed this invoice (e.g., pricing discrepancy, quantity shortage, quality issue). Supports root cause analysis and deduction recovery.',
    `dispute_status` STRING COMMENT 'Current status of any customer dispute raised against this invoice. Enables dispute management workflow tracking and deduction resolution reporting.. Valid values are `none|open|under_review|resolved|escalated`',
    `distribution_channel_code` STRING COMMENT 'SAP distribution channel code (VTWEG) indicating the route-to-market for this invoice (e.g., wholesale, DSD, e-commerce). Supports channel profitability and trade spend analysis.',
    `due_date` DATE COMMENT 'Date by which full payment must be received per the agreed payment terms. Used for aging analysis, dunning scheduling, and DSO management.',
    `dunning_date` DATE COMMENT 'Date of the most recent dunning notice sent to the customer for this invoice. Used to schedule next dunning action and track collections activity.',
    `dunning_level` STRING COMMENT 'Current dunning (collections escalation) level assigned to this invoice in SAP FI-AR, ranging from 0 (no dunning) to the maximum configured level. Drives collections workflow and customer communication.',
    `early_payment_discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the cash discount available to the customer if payment is received by the early payment discount date. Used for discount accrual and deduction validation.',
    `early_payment_discount_date` DATE COMMENT 'Last date by which the customer may pay to qualify for the early payment (cash) discount defined in the payment terms (e.g., the 10 in 2/10NET30). Supports cash discount accrual and working capital optimization.',
    `edi_status` STRING COMMENT 'Transmission status of the invoice via EDI (Electronic Data Interchange) or customer portal. Tracks whether the invoice was successfully delivered electronically to the customer, supporting straight-through processing and dispute prevention.. Valid values are `not_applicable|sent|acknowledged|rejected|portal_submitted`',
    `fiscal_period` STRING COMMENT 'Fiscal year and period (YYYY-MM) to which this invoice is posted in the general ledger. Used for period-end close, revenue reporting, and financial consolidation.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before trade discounts, allowances, and deductions. Represents the list-price billing value used as the starting point for net revenue calculation. Part of TRANSACTION_HEADER MONETARY_TRIPLET.',
    `invoice_date` DATE COMMENT 'The date the invoice was issued to the customer, representing the principal business event date for revenue recognition and payment term calculation. Satisfies TRANSACTION_HEADER BUSINESS_EVENT_TIMESTAMP category.',
    `invoice_status` STRING COMMENT 'Current lifecycle state of the invoice within the accounts receivable workflow. Drives DSO reporting, dunning triggers, and cash application automation. Satisfies TRANSACTION_HEADER LIFECYCLE_STATUS category.. Valid values are `open|partially_paid|paid|disputed|cancelled|written_off`',
    `invoice_type` STRING COMMENT 'Classification of the invoice by its commercial purpose. Drives revenue recognition treatment, GL posting logic, and reporting segmentation. [ENUM-REF-CANDIDATE: standard|credit_memo|debit_memo|intercompany|pro_forma|consignment — promote to reference product if additional types are needed]. Valid values are `standard|credit_memo|debit_memo|intercompany|pro_forma|consignment`',
    `lockbox_batch_number` STRING COMMENT 'Identifier of the bank lockbox processing batch in which this invoices payment was received. Enables reconciliation between bank lockbox files and SAP FI-AR cash application.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount due after applying trade discounts and allowances to the gross amount. Represents the contractual obligation for payment and the basis for revenue recognition. Part of TRANSACTION_HEADER MONETARY_TRIPLET net total.',
    `open_amount` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the invoice after applying all payments, credits, and deductions. Drives DSO calculation, aging bucket reporting, and dunning level determination.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Total amount of cash received and applied to this invoice. May differ from net_amount due to short payments, deductions, or partial payments.',
    `payment_date` DATE COMMENT 'Date on which payment was received and applied against this invoice. Null if unpaid. Used for DSO calculation and cash flow reporting.',
    `payment_method` STRING COMMENT 'Instrument or mechanism used by the customer to remit payment (e.g., ACH, wire transfer, check, EDI payment). Drives cash application routing and remittance matching.. Valid values are `ach|wire|check|credit_card|edi_payment|lockbox`',
    `payment_terms_code` STRING COMMENT 'SAP payment terms key (e.g., NT30, 2/10NET30) defining the due date calculation, early payment discount percentage, and discount period for this invoice. Governs cash application and DSO targets.',
    `remittance_document_number` STRING COMMENT 'Customer-provided remittance advice document number accompanying the payment, used to match incoming cash to open invoices during cash application.',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue from this invoice is recognized in the general ledger per FASB ASC 606 / IFRS 15 five-step model. May differ from invoice_date for consignment, bill-and-hold, or multi-element arrangements.',
    `sales_org_code` STRING COMMENT 'SAP sales organization (VKORG) responsible for the sale, defining the selling entity, pricing procedures, and revenue assignment for this invoice.',
    `short_payment_amount` DECIMAL(18,2) COMMENT 'Amount by which the customers remittance falls short of the invoiced net amount, excluding valid deductions. Triggers deduction investigation and collections follow-up.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Sales tax, VAT, or GST amount calculated on the net invoice amount per applicable jurisdiction tax rules. Required for tax compliance reporting to FDA-regulated markets and international jurisdictions.',
    `trade_discount_amount` DECIMAL(18,2) COMMENT 'Contractual trade discount applied to the gross invoice amount, reflecting negotiated off-invoice allowances, promotional pricing, or volume rebates. Part of TRANSACTION_HEADER MONETARY_TRIPLET adjustment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was last modified in the source system, capturing payment applications, dispute updates, or status changes. Satisfies TRANSACTION_HEADER RECORD_AUDIT_UPDATED category.',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Accounts receivable full lifecycle record encompassing billing through cash application and settlement for all customer obligations — retail chains, foodservice distributors, convenience operators, and DTC consumers. Covers invoice issuance (customer account, billing document, invoice date, payment terms, gross/net amounts, EDI/portal status), dunning and collections management, payment receipt (remittance document, payment method, lockbox batch, remittance amount, short-payment amount, deduction code), cash application, and clearing status. Sourced from SAP FI-AR and SD billing integration. Drives revenue recognition, DSO management, cash application automation, and deduction identification for F&B commercial finance.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` (
    `finance_standard_cost_id` BIGINT COMMENT 'Unique identifier for the standard cost record. Primary key for the standard cost master and variance analysis entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: standard_cost is defined per legal entity; replace string code with FK to company_code',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: standard_cost is allocated to a cost center; replace code with FK to cost_center',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: standard_cost references a GL account; replace code with FK to gl_account',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: standard_cost is allocated to a profit center; replace code with FK to profit_center',
    `base_unit_of_measure` STRING COMMENT 'Base unit of measure for the standard cost (e.g., EA for each, KG for kilogram, LB for pound, CS for case). Must match the material master base UOM for consistency.. Valid values are `^[A-Z]{2,3}$`',
    `co_packing_cost` DECIMAL(18,2) COMMENT 'Standard cost component for third-party co-packing or toll manufacturing services per unit. Applicable when production is outsourced to contract manufacturers or co-packers.',
    `controlling_area` STRING COMMENT 'Management accounting controlling area for cost center and profit center reporting. May span multiple company codes for consolidated management reporting and cross-company cost allocation.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_change_amount` DECIMAL(18,2) COMMENT 'Absolute change in standard cost per unit from previous to current period. Positive indicates cost increase; negative indicates cost reduction. Drives inventory revaluation and margin impact analysis.',
    `cost_change_percentage` DECIMAL(18,2) COMMENT 'Percentage change in standard cost from previous to current period. Key metric for cost inflation tracking, procurement performance, and pricing strategy decisions.',
    `cost_component_structure` STRING COMMENT 'Configuration key defining the cost component split schema (e.g., which cost elements roll into raw material, labor, overhead categories). Ensures consistent cost classification across products and plants.. Valid values are `^[A-Z0-9]{1,6}$`',
    `cost_estimate_number` STRING COMMENT 'Unique identifier for the detailed cost estimate calculation that produced this standard cost. Links to the itemized cost roll-up with BOM explosion, routing operations, and overhead allocation details.. Valid values are `^[0-9]{12}$`',
    `cost_estimate_status` STRING COMMENT 'Lifecycle status of the cost estimate. Only released estimates are activated as standard costs for inventory valuation. Created and calculated are preliminary; marked for deletion are superseded.. Valid values are `created|calculated|released|marked_for_deletion|error`',
    `costing_lot_size` DECIMAL(18,2) COMMENT 'Production lot size used as the basis for standard cost calculation. Fixed costs are spread across this quantity. Larger lot sizes reduce per-unit fixed overhead; smaller lots increase it, creating lot-size variance.',
    `costing_variant` STRING COMMENT 'Costing methodology variant used for standard cost calculation (e.g., PPC1 for product costing, PC01 for material ledger). Determines valuation approach, cost component structure, and overhead allocation rules.. Valid values are `^[A-Z0-9]{1,4}$`',
    `costing_version` STRING COMMENT 'Version number for the standard cost estimate. Allows multiple cost scenarios (current, planned, simulated) to coexist for comparison and what-if analysis before release.. Valid values are `^[0-9]{1,2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the standard cost record was first created in the data platform. Supports data lineage, audit trail, and change tracking for compliance and troubleshooting.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the standard cost (e.g., USD, EUR, GBP). Standard costs are maintained in local plant currency and converted to group reporting currency for consolidation.. Valid values are `^[A-Z]{3}$`',
    `direct_labor_cost` DECIMAL(18,2) COMMENT 'Standard cost component for direct production labor per unit. Calculated from routing operation times multiplied by labor rates. Includes line operators, batch mixers, and packaging crew.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year for variance tracking. Period 1-12 for calendar fiscal year; may differ for non-calendar fiscal years. Enables monthly variance trending and seasonality analysis.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the standard cost or variance is applicable. Standard costs are typically set annually; variances are tracked by fiscal period for trend analysis and budget comparison.',
    `fixed_overhead_cost` DECIMAL(18,2) COMMENT 'Standard cost component for fixed manufacturing overhead per unit. Includes depreciation, plant supervision, property taxes, insurance, and fixed maintenance allocated based on normal capacity utilization.',
    `freight_in_cost` DECIMAL(18,2) COMMENT 'Standard cost component for inbound freight and logistics per unit. Includes transportation of raw materials and packaging to the manufacturing plant, allocated to finished goods.',
    `material_number` STRING COMMENT 'Unique identifier for the material or SKU (Stock Keeping Unit) in the ERP system. Links to the product master for finished goods, semi-finished goods, raw materials, and packaging components.. Valid values are `^[A-Z0-9]{8,18}$`',
    `other_cost` DECIMAL(18,2) COMMENT 'Standard cost component for miscellaneous manufacturing costs not classified in other categories. May include quality testing, rework allowance, or special handling charges.',
    `packaging_material_cost` DECIMAL(18,2) COMMENT 'Standard cost component for primary, secondary, and tertiary packaging materials per unit. Includes bottles, cans, cartons, labels, shrink wrap, pallets, and shipping materials.',
    `plant_code` STRING COMMENT 'Manufacturing plant or production facility where the standard cost is applicable. Standard costs are plant-specific to reflect local labor rates, overhead allocation, and manufacturing efficiency.. Valid values are `^[A-Z0-9]{4}$`',
    `previous_standard_price` DECIMAL(18,2) COMMENT 'Prior period standard cost per unit before the current cost roll. Used to calculate cost change impact, revaluation amounts, and year-over-year cost trend analysis.',
    `price_control_indicator` STRING COMMENT 'Valuation method indicator: S for standard price (predetermined cost), V for moving average price (actual cost). Food and beverage finished goods typically use standard price; raw materials may use moving average.. Valid values are `S|V`',
    `price_unit` STRING COMMENT 'Quantity unit for which the standard price is defined (e.g., 1, 10, 100, 1000). Standard price per unit is divided by price unit to get per-base-unit cost. Commonly 1 for finished goods, may be higher for low-value materials.',
    `raw_material_cost` DECIMAL(18,2) COMMENT 'Standard cost component for raw materials and ingredients per unit. Derived from BOM (Bill of Materials) quantities multiplied by component standard prices. Largest cost driver in food and beverage manufacturing.',
    `release_date` DATE COMMENT 'Date when the cost estimate was released and activated as the official standard cost. Marks the transition from preliminary to production-ready cost. Critical for audit trail and variance analysis cutover.',
    `released_by_user` STRING COMMENT 'User ID of the cost accountant or controller who released the standard cost estimate. Provides accountability for cost master changes and supports SOX (Sarbanes-Oxley) compliance audit requirements.. Valid values are `^[A-Z0-9_]{1,12}$`',
    `standard_price_per_unit` DECIMAL(18,2) COMMENT 'Total standard cost per base unit of measure. Used for inventory valuation, COGS (Cost of Goods Sold) calculation, and gross margin reporting. Sum of all cost component splits.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the standard cost record was last modified. Tracks cost master maintenance activity, variance postings, and data refresh cycles for data quality monitoring.',
    `valid_from_date` DATE COMMENT 'Effective start date for this standard cost. Standard costs are typically updated annually or semi-annually during the standard cost roll process, with mid-year adjustments for significant material or overhead changes.',
    `valid_to_date` DATE COMMENT 'Effective end date for this standard cost. Null or far-future date indicates the current active standard cost. Historical records retain prior period costs for variance trending and year-over-year analysis.',
    `valuation_class` STRING COMMENT 'Material valuation class determining GL (General Ledger) account assignment for inventory and COGS postings. Links material type to chart of accounts for financial reporting.. Valid values are `^[0-9]{4}$`',
    `variable_overhead_cost` DECIMAL(18,2) COMMENT 'Standard cost component for variable manufacturing overhead per unit. Includes utilities, indirect materials, consumables, and variable maintenance that scale with production volume.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary value of the variance (actual cost minus standard cost). Positive variance indicates unfavorable (actual higher than standard); negative indicates favorable (actual lower than standard). Aggregated for EBITDA (Earnings Before Interest Taxes Depreciation and Amortization) reporting.',
    `variance_category` STRING COMMENT 'Classification of manufacturing variance type. Price variance: material cost differences. Quantity variance: usage differences. Scrap variance: waste. Mix variance: recipe substitution. Yield variance: output differences. Lot-size variance: volume impact on fixed costs. Overhead variance: absorption differences. [ENUM-REF-CANDIDATE: price_variance|quantity_variance|scrap_variance|mix_variance|yield_variance|lot_size_variance|overhead_variance|resource_usage_variance — 8 candidates stripped; promote to reference product]',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Variance amount expressed as a percentage of standard cost. Used for materiality assessment, exception reporting, and operational performance scorecards. Thresholds trigger management review.',
    CONSTRAINT pk_finance_standard_cost PRIMARY KEY(`finance_standard_cost_id`)
) COMMENT 'Standard cost master and variance analysis record for each SKU/material — combining the pre-determined cost used for inventory valuation and COGS calculation with actual manufacturing and purchase price variances. Captures material number, plant, costing variant, standard price per unit, cost component split (raw materials, direct labor, manufacturing overhead, packaging, freight-in), costing lot size, valid-from date, and release status. Also captures all variance records: production order or purchase order reference, variance category (price variance, quantity variance, scrap variance, mix variance, lot-size variance, overhead variance), variance amount and percentage, period, cost center, and settlement status. The financial backbone for F&B gross margin management, standard cost roll-up decisions, make-vs-buy analysis, and operational efficiency reporting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`finance_budget` (
    `finance_budget_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key for the budget data product.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Finance budget is scoped to a company; replace string with FK',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Finance budget is scoped to a cost center; replace code with FK',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `employee_id` BIGINT COMMENT 'User ID or employee ID of the budget owner responsible for managing and monitoring this budget line. Typically the cost center manager or department head.',
    `primary_finance_employee_id` BIGINT COMMENT 'User ID or employee ID of the person who approved the budget. Null if not yet approved.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Finance budget is scoped to a profit center; replace code with FK',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Annual budgeting allocates funds to each sustainability target; the FK enables traceability of spend.',
    `amount` DECIMAL(18,2) COMMENT 'The planned budget amount for the specified fiscal period, cost center, and GL account. Represents the financial target or allocation in the budget currency.',
    `approval_date` DATE COMMENT 'Date on which the budget was approved by the authorized approver. Null if not yet approved.',
    `approval_status` STRING COMMENT 'Current approval status of the budget record. DRAFT = In preparation, SUBMITTED = Awaiting approval, APPROVED = Approved for use, REJECTED = Not approved, LOCKED = Finalized and locked for the period.. Valid values are `DRAFT|SUBMITTED|APPROVED|REJECTED|LOCKED`',
    `budget_category` STRING COMMENT 'Categorization of the budget planning approach. ANNUAL = Annual fixed budget, ROLLING = Rolling forecast budget, SUPPLEMENTAL = Additional budget allocation, CONTINGENCY = Reserve or contingency budget.. Valid values are `ANNUAL|ROLLING|SUPPLEMENTAL|CONTINGENCY`',
    `budget_type` STRING COMMENT 'Classification of the budget by financial category. OPEX = Operating Expenses, CAPEX = Capital Expenditures, REVENUE = Revenue Budget, HEADCOUNT = Workforce Budget, COGS = Cost of Goods Sold, TRADE_SPEND = Trade Promotion and Marketing Spend.. Valid values are `OPEX|CAPEX|REVENUE|HEADCOUNT|COGS|TRADE_SPEND`',
    `business_area_code` STRING COMMENT 'Business area code for cross-company code reporting. Represents a business segment that may span multiple legal entities.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area_code` STRING COMMENT 'Four-character code representing the controlling area for cost accounting and management reporting. Aligns with SAP CO controlling area structure.. Valid values are `^[A-Z0-9]{4}$`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for country-specific budget allocation (e.g., USA, GBR, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the lakehouse. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount (e.g., USD, EUR, GBP). Indicates the currency in which the budget is denominated.. Valid values are `^[A-Z]{3}$`',
    `distribution_channel_code` STRING COMMENT 'Distribution channel code for channel-specific budget planning (e.g., Retail, Foodservice, E-commerce, Direct Store Delivery).. Valid values are `^[A-Z0-9]{2}$`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for which this budget applies. Typically ranges from 1 to 12 for monthly budgets, or 1 to 4 for quarterly budgets.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this budget is defined. Represents the annual planning period (e.g., 2024, 2025).',
    `functional_area_code` STRING COMMENT 'Functional area code for classifying budget by business function (e.g., Manufacturing, Sales, R&D, Marketing, Supply Chain).. Valid values are `^[A-Z0-9]{4,6}$`',
    `geographic_region_code` STRING COMMENT 'Geographic region code for regional budget planning (e.g., NORAM, EMEA, APAC, LATAM). Enables regional financial target setting and variance analysis.. Valid values are `^[A-Z0-9]{2,6}$`',
    `is_carry_forward` BOOLEAN COMMENT 'Boolean flag indicating whether this budget line represents a carry-forward from a previous fiscal period. True = Carry-forward budget, False = New budget allocation.',
    `is_locked` BOOLEAN COMMENT 'Boolean flag indicating whether the budget record is locked for editing. True = Locked (no further changes allowed), False = Unlocked (editable). Used to freeze budgets after approval or period close.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was last updated in the lakehouse. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, assumptions, or justification for the budget allocation. Used for documenting budget rationale and planning assumptions.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility code to which this budget applies. Used for plant-specific budget allocation in manufacturing and operations.. Valid values are `^[A-Z0-9]{4}$`',
    `product_category_code` STRING COMMENT 'Product category or product line code for product-specific budget allocation (e.g., Snacks, Beverages, Dairy). Used for category-level financial planning.',
    `quantity` DECIMAL(18,2) COMMENT 'Planned quantity associated with the budget (e.g., headcount, production volume, units sold). Used for non-monetary budget planning such as workforce or production capacity.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the budget quantity (e.g., FTE for headcount, MT for metric tons, EA for each). Provides context for the budget_quantity field.',
    `sales_org_code` STRING COMMENT 'Sales organization code for revenue and sales-related budgets. Represents the sales division or region responsible for revenue targets.. Valid values are `^[A-Z0-9]{4}$`',
    `source_record_key` STRING COMMENT 'Primary key or unique identifier of the budget record in the source system. Used for traceability and reconciliation back to the source system.',
    `source_system_code` STRING COMMENT 'Identifier of the source system from which this budget record originated (e.g., SAP_CO, ORACLE_EPM, ANAPLAN). Used for data lineage and reconciliation.',
    `version_code` STRING COMMENT 'Code identifying the version of the budget (e.g., ORIGINAL, REVISED, LE1, LE2, FORECAST). Enables tracking of budget iterations and revisions throughout the fiscal year.. Valid values are `^[A-Z0-9]{1,10}$`',
    `version_name` STRING COMMENT 'Descriptive name for the budget version (e.g., Original Budget, Q2 Revised Budget, Latest Estimate). Provides human-readable context for the version code.',
    CONSTRAINT pk_finance_budget PRIMARY KEY(`finance_budget_id`)
) COMMENT 'Annual and rolling financial budget master capturing planned financial targets by cost center, profit center, GL account, and fiscal period. Sourced from SAP CO budgeting or Oracle Cloud EPM. Captures budget version (original, revised, latest estimate), fiscal year, period, company code, cost center, profit center, GL account, budget amount, currency, budget type (opex, capex, headcount), approval status, and budget owner. Foundational for variance-to-budget reporting and EBITDA target management in F&B.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`forecast` (
    `forecast_id` BIGINT COMMENT 'Primary key for forecast',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Forecast is prepared for a company; replace string with FK',
    `employee_id` BIGINT COMMENT 'Employee identifier of the manager or executive who approved this forecast version. Supports governance and audit trail.',
    `forecast_employee_id` BIGINT COMMENT 'Employee or user identifier of the person responsible for submitting and maintaining this forecast line. Typically a finance business partner or profit center controller.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Forecast references a GL account; add FK to gl_account',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Forecast is prepared for a profit center; replace code with FK',
    `sop_cycle_id` BIGINT COMMENT 'Identifier linking this financial forecast to the corresponding S&OP cycle. Ensures alignment between demand planning, supply planning, and financial forecasting.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the forecast was formally approved. Marks the transition from draft to official forecast.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The original annual budget amount for this period and account. Used for variance-to-budget analysis and performance tracking.',
    `business_unit_code` STRING COMMENT 'High-level business unit or division code (e.g., Snacks, Beverages, Dairy). Used for executive-level reporting and strategic planning.. Valid values are `^[A-Z0-9]{2,6}$`',
    `commentary` STRING COMMENT 'Free-text narrative explaining key assumptions, risks, opportunities, or changes from prior forecast. Provides qualitative context for quantitative projections.',
    `confidence_level` STRING COMMENT 'Subjective confidence rating assigned by the forecast owner. Indicates reliability and risk associated with the forecast estimate.. Valid values are `high|medium|low`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for country-specific forecasts. Supports statutory reporting and local market analysis.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this forecast record was first created in the source system. Audit field for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the forecasted amounts (e.g., USD, EUR, GBP). Supports multi-currency forecasting and consolidation.. Valid values are `^[A-Z]{3}$`',
    `distribution_channel_code` STRING COMMENT 'Distribution channel for revenue forecasts (e.g., retail, foodservice, DSD, e-commerce). Enables channel-specific forecast analysis.. Valid values are `^[A-Z0-9]{2}$`',
    `driver_type` STRING COMMENT 'Primary business driver or assumption category underlying the forecast (e.g., volume growth, pricing action, product mix shift, foreign exchange impact). Enables driver-based planning and variance explanation. [ENUM-REF-CANDIDATE: volume|price|mix|fx|inflation|productivity|investment — 7 candidates stripped; promote to reference product]',
    `fiscal_period` STRING COMMENT 'The fiscal period within the year (e.g., P01-P12 for months, Q1-Q4 for quarters, H1-H2 for half-years, FY for full year). Defines the granularity of the forecast.. Valid values are `^(P(0[1-9]|1[0-2])|Q[1-4]|H[1-2]|FY)$`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this forecast applies (e.g., 2024, 2025). Aligns with the companys fiscal calendar.',
    `forecast_date` DATE COMMENT 'The date when this forecast version was created or submitted. Represents the as-of date for the forecast snapshot.',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the forecast record. Tracks progression from draft through approval to publication.. Valid values are `draft|submitted|under_review|approved|published|superseded`',
    `forecast_type` STRING COMMENT 'Classification of the forecast by planning horizon and frequency. Rolling forecasts are continuously updated; annual/quarterly/monthly are fixed-period; reforecast is a mid-cycle update; flash is a rapid preliminary estimate.. Valid values are `rolling|annual|quarterly|monthly|reforecast|flash`',
    `forecasted_amount` DECIMAL(18,2) COMMENT 'The projected financial value for this forecast line in the specified currency. Represents the current best estimate of revenue, cost, or profit for the period.',
    `geographic_region_code` STRING COMMENT 'Geographic region or market for the forecast (e.g., NORAM, EMEA, LATAM, APAC). Enables regional performance tracking and investor reporting.. Valid values are `^[A-Z]{2,6}$`',
    `gl_account_category` STRING COMMENT 'High-level financial statement line item category for the forecasted amount. Enables aggregation and variance analysis by P&L component. [ENUM-REF-CANDIDATE: revenue|cogs|gross_profit|operating_expense|ebitda|depreciation|ebit|interest|tax|net_income — 10 candidates stripped; promote to reference product]',
    `gl_account_code` STRING COMMENT 'Detailed GL account number for the forecasted line item. Provides granular mapping to the chart of accounts for financial close integration.. Valid values are `^[0-9]{6,10}$`',
    `owner_name` STRING COMMENT 'Full name of the forecast owner for display and reporting purposes.',
    `prior_forecast_amount` DECIMAL(18,2) COMMENT 'The forecasted amount from the previous forecast version for the same period and account. Enables trend analysis and revision tracking.',
    `product_category_code` STRING COMMENT 'Product category or portfolio segment for revenue and COGS forecasts (e.g., Salty Snacks, Carbonated Soft Drinks, Dairy). Supports category-level planning.. Valid values are `^[A-Z0-9]{4,8}$`',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when the forecast was published to executive dashboards and investor relations. Indicates availability for external guidance.',
    `sales_org_code` STRING COMMENT 'Sales organization responsible for revenue forecasts. Aligns with SAP SD sales organization structure for channel and customer segmentation.. Valid values are `^[A-Z0-9]{4}$`',
    `scenario_code` STRING COMMENT 'Planning scenario for the forecast (e.g., base case, upside, downside). Supports scenario planning and risk assessment for investor guidance.. Valid values are `base|optimistic|pessimistic|worst_case|best_case`',
    `source_system_code` STRING COMMENT 'Identifier of the source system from which the forecast was extracted (e.g., SAP_IBP, ORACLE_PBCS, ANAPLAN). Supports data lineage and reconciliation.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this forecast record was last modified in the source system. Tracks revision history.',
    `variance_to_budget_amount` DECIMAL(18,2) COMMENT 'The difference between the forecasted amount and the budget amount (forecasted_amount - budget_amount). Positive values indicate favorable variance for revenue, unfavorable for costs.',
    `variance_to_prior_forecast_amount` DECIMAL(18,2) COMMENT 'The difference between the current forecast and the prior forecast (forecasted_amount - prior_forecast_amount). Tracks forecast revision magnitude.',
    `version_code` STRING COMMENT 'Version identifier for the forecast cycle (e.g., V1, V2, Q1R1, Q2R2). Distinguishes between initial forecast and subsequent revisions within the same fiscal period.. Valid values are `^[A-Z0-9]{2,10}$`',
    CONSTRAINT pk_forecast PRIMARY KEY(`forecast_id`)
) COMMENT 'Rolling financial forecast record capturing updated revenue, cost, and EBITDA projections by period, profit center, and business unit. Distinct from budget (which is annual/fixed) — forecasts are updated monthly or quarterly. Captures forecast version, forecast date, fiscal year, period, company code, profit center, GL account category, forecasted amount, prior forecast amount, variance to budget, currency, and forecast owner. Supports S&OP financial integration and investor guidance for F&B.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key for the fixed asset entity. Inferred role: MASTER_RESOURCE.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Fixed asset is owned by a company; replace string with FK',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fixed asset is assigned to a cost center; replace code with FK',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Fixed asset references a GL account for accounting; add FK to gl_account',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Fixed asset is assigned to a profit center; replace code with FK',
    `employee_id` BIGINT COMMENT 'Employee ID of the person responsible for the asset (e.g., plant manager, maintenance supervisor). Used for accountability and asset custody tracking.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since the asset was placed in service. Calculated as the sum of all periodic depreciation postings.',
    `acquisition_date` DATE COMMENT 'Date the asset was acquired or placed in service. Used as the starting point for depreciation calculation and useful life tracking.',
    `asset_class_code` STRING COMMENT 'Classification code that categorizes the asset type (e.g., manufacturing equipment, building, vehicle, IT hardware). Determines depreciation rules, useful life, and GL account assignment in SAP FI-AA.',
    `asset_description` STRING COMMENT 'Detailed business description of the fixed asset, including make, model, capacity, and distinguishing characteristics (e.g., High-Speed Bottling Line - Line 3 - 600 BPM).',
    `asset_location` STRING COMMENT 'Detailed physical location of the asset within the plant or facility (e.g., Production Floor - Line 3 - Bay 12). Used for asset tracking, maintenance scheduling, and physical inventory.',
    `asset_number` STRING COMMENT 'Externally-known unique business identifier for the fixed asset, typically assigned by the ERP system (SAP FI-AA asset master number). Used for asset tracking, reporting, and cross-system reference.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset. Active assets are in service and depreciating; under construction assets are capitalized but not yet depreciating; retired/disposed assets are no longer in use.. Valid values are `active|inactive|under_construction|retired|disposed|impaired`',
    `asset_tag_number` STRING COMMENT 'Physical barcode or RFID tag number affixed to the asset for inventory tracking and physical verification during asset audits.',
    `capitalization_date` DATE COMMENT 'Date the asset was capitalized on the balance sheet. May differ from acquisition date for assets under construction (AUC) that are capitalized upon completion.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset record was first created in the source system (SAP FI-AA). Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts (original cost, accumulated depreciation, net book value). Typically the local currency of the company code.. Valid values are `^[A-Z]{3}$`',
    `depreciation_gl_account_code` STRING COMMENT 'General ledger account number for accumulated depreciation (contra-asset account, e.g., 1509 - Accumulated Depreciation - Machinery). Used for balance sheet presentation.',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate periodic depreciation expense. Straight-line is most common for F&B manufacturing assets; units of production may be used for high-utilization equipment.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits|none`',
    `disposal_date` DATE COMMENT 'Date the asset was physically disposed, sold, or scrapped. May differ from retirement date if there is a lag between decommissioning and disposal.',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Cash or fair value received from the sale or disposal of the asset. Used to calculate gain or loss on disposal (proceeds minus net book value).',
    `expense_gl_account_code` STRING COMMENT 'General ledger account number for depreciation expense postings (e.g., 6800 - Depreciation Expense). Used for income statement reporting and COGS allocation.',
    `gl_account_code` STRING COMMENT 'General ledger account number for the asset balance sheet account (e.g., 1500 - Machinery and Equipment). Determined by asset class and used for financial statement reporting.',
    `impairment_amount` DECIMAL(18,2) COMMENT 'Total impairment loss recognized on the asset when its recoverable amount falls below net book value. Recorded as a write-down and reduces the carrying value.',
    `impairment_date` DATE COMMENT 'Date the impairment loss was recognized. Triggers adjustment to net book value and may affect future depreciation calculations.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number covering the asset against loss, damage, or theft. Used for risk management and claims processing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset record was last updated in the source system. Used for change tracking and data synchronization.',
    `last_physical_inventory_date` DATE COMMENT 'Date the asset was last physically verified during a fixed asset inventory audit. Used to ensure asset register accuracy and compliance with SOX controls.',
    `manufacturer_name` STRING COMMENT 'Name of the equipment manufacturer or vendor (e.g., Tetra Pak, Krones, Siemens). Used for vendor management, spare parts sourcing, and warranty claims.',
    `model_number` STRING COMMENT 'Manufacturer model or part number for the asset. Used for technical specifications, spare parts identification, and maintenance planning.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the asset on the balance sheet, calculated as original cost minus accumulated depreciation. Represents the remaining capitalized value.',
    `original_cost` DECIMAL(18,2) COMMENT 'Initial acquisition or construction cost of the asset at capitalization, including purchase price, freight, installation, and directly attributable costs. Represents the gross book value before depreciation.',
    `plant_code` STRING COMMENT 'Manufacturing plant, distribution center, or facility location where the asset is physically located. Used for site-level asset tracking and capex reporting.',
    `purchase_order_number` STRING COMMENT 'Original purchase order number used to acquire the asset. Links the asset to procurement records and vendor invoices for audit trail and warranty tracking.',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'Number of years remaining in the assets useful life as of the current reporting period. Calculated as useful life minus elapsed time since capitalization.',
    `retirement_date` DATE COMMENT 'Date the asset was retired from service or disposed. Triggers final depreciation calculation and removal from active asset register.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. Depreciation is calculated on (original cost - salvage value). Often zero for F&B manufacturing equipment.',
    `sap_asset_key` STRING COMMENT 'Composite key from SAP FI-AA (company code + asset number + sub-number) used for exact source system reconciliation and traceability.',
    `serial_number` STRING COMMENT 'Manufacturer serial number or unique equipment identifier for the asset. Used for warranty tracking, maintenance history, and asset verification.',
    `source_system_code` STRING COMMENT 'Identifier of the source ERP system from which the asset record originated (e.g., SAP_S4_PROD, ORACLE_ERP_US). Used for data lineage and multi-system integration.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Expected economic useful life of the asset in years, as determined by asset class and business policy. Used to calculate straight-line depreciation rate (1 / useful life).',
    `vendor_name` STRING COMMENT 'Name of the vendor or supplier from whom the asset was purchased. Used for vendor performance tracking and warranty claims.',
    `warranty_expiration_date` DATE COMMENT 'Date the manufacturer or vendor warranty expires. Used to determine whether repairs are covered under warranty or must be expensed.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master and complete lifecycle record for all capitalized property, plant, and equipment — manufacturing lines, filling equipment, refrigeration systems, DCs, vehicles, and IT infrastructure. Encompasses asset master data (asset number, class, description, acquisition date, useful life, depreciation method, net book value, plant/location, cost center) and all movement transactions (acquisitions, transfers, retirements, write-downs, depreciation postings with transaction type, amount, period, GL account, and document reference). Sourced from SAP FI-AA. Supports capex tracking, depreciation scheduling, asset impairment assessment, and asset ROI analysis for F&B manufacturing investments.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique identifier for the intercompany transaction record. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: intercompany_transaction may be charged to a cost center; replace code with FK to cost_center',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Intercompany transaction creation audit demands employee identification for compliance and internal control reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: intercompany_transaction posts to a GL account; replace code with FK to gl_account',
    `netting_run_id` BIGINT COMMENT 'Unique identifier of the intercompany netting run in which this transaction was included. Format NET followed by 8-digit date stamp. Null if transaction has not been netted.. Valid values are `^NET[0-9]{8}$`',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: intercompany_transaction may be charged to a profit center; replace code with FK to profit_center',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: intercompany_transaction sender entity; replace string with FK to company_code',
    `business_area_code` STRING COMMENT 'The business area code representing the line of business or product category associated with this intercompany transaction. Used for segment reporting and cross-company business area consolidation.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this intercompany transaction record was first created in the source ERP system. Captures date and time with timezone for complete audit trail.',
    `document_date` DATE COMMENT 'The business date when the intercompany transaction was created or initiated. May differ from posting date due to period-end processing or backdated entries.',
    `document_number` STRING COMMENT 'Unique business document number assigned to this intercompany transaction in the ERP system. Ten-character alphanumeric identifier used for audit trail and reconciliation purposes.. Valid values are `^[A-Z0-9]{10}$`',
    `due_date` DATE COMMENT 'The date by which the receiving entity must settle the intercompany payable to the sending entity. Calculated based on posting date and payment terms. Used for cash flow forecasting and working capital management.',
    `elimination_document_number` STRING COMMENT 'The consolidation system document number that records the elimination entry for this intercompany transaction. Populated only after consolidation processing. Used for audit trail and reconciliation between legal entity and group reporting.. Valid values are `^[A-Z0-9]{10}$`',
    `elimination_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this intercompany transaction must be eliminated during the consolidation process for statutory reporting. True indicates the transaction will be reversed in consolidated financial statements to avoid double-counting revenue and expenses within the group.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the transaction currency to local or group currency. Typically the spot rate on the posting date or a monthly average rate depending on company policy.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when the transaction was posted. Typically 1-12 for standard calendar periods, or 13-16 for special closing periods used during year-end adjustments.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the intercompany transaction was posted, based on the posting date and the fiscal year variant of the sending company code. Four-digit year value used for period-based financial reporting.',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the group reporting currency (typically USD or EUR) for consolidated financial statements. Essential for EBITDA reporting and corporate performance analysis.',
    `last_modified_by_user` STRING COMMENT 'The user ID of the person who last modified this intercompany transaction record. Used for audit trail and change tracking in financial controls.. Valid values are `^[A-Z0-9]{8,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The system timestamp when this intercompany transaction record was last updated in the source ERP system. Captures date and time with timezone for complete audit trail and change tracking.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the local currency of the sending company code using the exchange rate at the time of posting. Used for statutory reporting in the sending entitys functional currency.',
    `net_amount` DECIMAL(18,2) COMMENT 'The final payable or receivable amount after applying taxes, discounts, and adjustments. This is the amount that will be settled between the two entities through intercompany netting or payment.',
    `netting_status` STRING COMMENT 'Indicates whether this intercompany transaction is included in the periodic intercompany netting process to reduce cash movements between entities. Not netted indicates standalone settlement; included in netting means eligible for next netting run; netted indicates already processed; excluded indicates manual settlement required.. Valid values are `not_netted|included_in_netting|netted|excluded`',
    `payment_date` DATE COMMENT 'The actual date when the intercompany transaction was settled through payment or netting. Null if transaction remains open. Used to calculate days sales outstanding (DSO) and payment performance metrics.',
    `payment_method` STRING COMMENT 'The method used to settle the intercompany transaction. Wire transfer indicates bank payment; netting indicates multilateral netting process; offset indicates manual clearing against another transaction; manual journal indicates accounting adjustment without cash movement.. Valid values are `wire_transfer|netting|offset|manual_journal`',
    `payment_terms_code` STRING COMMENT 'The payment terms code defining the due date calculation and early payment discount conditions for this intercompany transaction. Four-character code referencing the payment terms master data (e.g., N030 for net 30 days).. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'The accounting date when the intercompany transaction was posted to the general ledger in both sending and receiving entities. This date determines the fiscal period for financial reporting and must align with the open accounting period in both company codes.',
    `receiving_company_code` STRING COMMENT 'SAP company code of the legal entity receiving the intercompany charge or transfer. Four-character alphanumeric code identifying the receiving entity in the corporate structure.. Valid values are `^[A-Z0-9]{4}$`',
    `reconciliation_status` STRING COMMENT 'Status of the intercompany reconciliation process indicating whether the sending and receiving entity records match. Matched indicates both sides agree; unmatched indicates discrepancy; disputed indicates formal disagreement; under review indicates investigation in progress.. Valid values are `matched|unmatched|disputed|under_review`',
    `reference_document_number` STRING COMMENT 'External reference number linking this intercompany transaction to the originating business document such as a sales order, purchase order, invoice, or goods receipt. Provides traceability to the underlying operational transaction.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag (True/False) indicating whether this intercompany transaction is a reversal of a previously posted transaction. True indicates this is a correcting entry; False indicates an original transaction.',
    `reversed_document_number` STRING COMMENT 'The document number of the original intercompany transaction that this entry reverses. Populated only when reversal indicator is True. Provides audit trail for corrections and cancellations.. Valid values are `^[A-Z0-9]{10}$`',
    `source_system_code` STRING COMMENT 'Identifier of the source ERP system from which this intercompany transaction was extracted. Supports multi-system landscapes where different legal entities operate on different ERP instances (e.g., SAP S/4HANA, Oracle Cloud ERP).. Valid values are `^[A-Z0-9]{3,10}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The value-added tax (VAT), goods and services tax (GST), or other indirect tax amount applied to the intercompany transaction. May be zero for certain cross-border transactions or exempt services.',
    `tax_jurisdiction_code` STRING COMMENT 'Two-letter ISO country code representing the tax jurisdiction governing this intercompany transaction. Critical for determining VAT/GST treatment, withholding tax obligations, and transfer pricing documentation requirements.. Valid values are `^[A-Z]{2}$`',
    `trading_partner_code` STRING COMMENT 'The trading partner code identifying the counterparty entity in intercompany reporting. Used in consolidation systems to match and eliminate reciprocal transactions between group entities.. Valid values are `^[A-Z0-9]{6}$`',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the intercompany transaction in the transaction currency before any adjustments, taxes, or discounts. Represents the base charge or transfer value between entities.',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the intercompany transaction was originally denominated. This is the currency agreed upon between the sending and receiving entities for the transaction.. Valid values are `^[A-Z]{3}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the intercompany transaction. Draft indicates pending approval; posted indicates recorded in both entities; cleared indicates payment settled; reversed indicates cancellation; eliminated indicates consolidated for statutory reporting.. Valid values are `draft|posted|cleared|reversed|eliminated`',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction indicating the nature of the cross-entity charge. Goods transfer represents inventory movements between manufacturing and distribution entities; service charge captures shared service center allocations; royalty represents intellectual property licensing fees; loan interest covers intercompany financing; management fee represents corporate overhead allocations; cost allocation represents other cross-entity cost distributions.. Valid values are `goods_transfer|service_charge|royalty|loan_interest|management_fee|cost_allocation`',
    `transfer_pricing_method` STRING COMMENT 'The transfer pricing methodology applied to determine the intercompany transaction price. Cost plus adds a markup to cost; market price uses external benchmarks; negotiated represents arms length agreements; comparable uncontrolled uses third-party comparables; resale minus deducts margin from resale price. Critical for tax compliance and OECD transfer pricing documentation.. Valid values are `cost_plus|market_price|negotiated|comparable_uncontrolled|resale_minus`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax deducted from the intercompany transaction amount for cross-border payments subject to tax treaty provisions. Typically applies to royalties, interest, and service fees. Zero for domestic transactions or exempt categories.',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Intercompany financial transaction record capturing cross-entity charges, transfers, and settlements between Food Beverage legal entities — manufacturing entities billing distribution entities, shared service centers charging operating companies, and royalty flows between IP-holding and operating entities. Captures sending company code, receiving company code, transaction type (goods transfer, service charge, royalty, loan interest), amount, currency, exchange rate, netting status, and elimination flag for consolidation. Essential for statutory reporting and transfer pricing compliance.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`fiscal_period` (
    `fiscal_period_id` BIGINT COMMENT 'Primary key for fiscal_period',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: fiscal_period is scoped to a legal entity; replace string code with FK to company_code',
    `asset_posting_status` STRING COMMENT 'Posting authorization status for asset account types (fixed assets, depreciation). Controls whether asset transactions can be posted in this period.. Valid values are `open|closed`',
    `audit_trail_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether detailed audit logging is enabled for all transactions posted in this fiscal period for compliance and forensic purposes.',
    `balance_sheet_reconciliation_status` STRING COMMENT 'Status of balance sheet account reconciliation process for this period, ensuring all balance sheet accounts are substantiated and reconciled to sub-ledgers.. Valid values are `not_started|in_progress|reconciled|variance`',
    `blocked_close_tasks` STRING COMMENT 'Count of close tasks that are currently blocked due to unmet dependencies or issues requiring resolution.',
    `close_actual_date` DATE COMMENT 'The actual calendar date when the financial close process was completed and certified.',
    `close_cycle_name` STRING COMMENT 'Descriptive name of the financial close cycle for this period (e.g., January 2024 Close, Q1 2024 Close, FY2024 Year-End Close).',
    `close_delay_days` STRING COMMENT 'Number of calendar days by which the close process exceeded the target date. Zero or negative if close was on time or early.',
    `close_sla_met` BOOLEAN COMMENT 'Boolean indicator of whether the close process met the target SLA (True if actual close date is on or before target date, False otherwise).',
    `close_start_date` DATE COMMENT 'The calendar date when the financial close process for this period was initiated.',
    `close_status` STRING COMMENT 'Overall status of the period-end close process: not_started (close not initiated), in_progress (tasks underway), complete (all tasks finished), certified (final sign-off and SOX attestation complete).. Valid values are `not_started|in_progress|complete|certified`',
    `close_target_date` DATE COMMENT 'The planned target date by which the financial close process should be completed, per the close calendar and SLA (Service Level Agreement).',
    `completed_close_tasks` STRING COMMENT 'Count of close tasks that have been marked as complete for this fiscal period.',
    `controlling_area_code` STRING COMMENT 'Four-character code identifying the controlling area (CO module organizational unit) to which this fiscal period applies for cost accounting and profitability analysis.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_allocation_status` STRING COMMENT 'Status of cost center and internal order allocation cycles (assessment, distribution, overhead allocation) for this fiscal period.. Valid values are `not_started|in_progress|complete|error`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiscal period record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the local currency for this company code and fiscal period (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `depreciation_run_status` STRING COMMENT 'Status of the periodic depreciation calculation and posting run for fixed assets in this fiscal period.. Valid values are `not_started|in_progress|complete|error`',
    `expense_posting_status` STRING COMMENT 'Posting authorization status for expense account types (COGS, operating expenses). Controls whether expense transactions can be posted in this period.. Valid values are `open|closed`',
    `financial_statement_status` STRING COMMENT 'Status of financial statement preparation and approval workflow for this period: not_started, draft (in preparation), review (under management review), approved (signed off), published (externally released).. Valid values are `not_started|draft|review|approved|published`',
    `fiscal_period_number` STRING COMMENT 'Sequential period number within the fiscal year. Regular periods are 1-12; special adjustment periods are 13-16 for year-end close activities.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this period belongs, represented as a four-digit integer (e.g., 2024).',
    `fiscal_year_variant` STRING COMMENT 'Two-character code defining the fiscal year calendar structure (e.g., K4 for calendar year, V3 for April-March fiscal year). Determines period start/end dates and number of periods.. Valid values are `^[A-Z0-9]{2}$`',
    `intercompany_reconciliation_status` STRING COMMENT 'Status of intercompany transaction reconciliation for this period: not_started, in_progress, reconciled (balanced), or variance (unresolved differences requiring investigation).. Valid values are `not_started|in_progress|reconciled|variance`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiscal period record was last updated, reflecting the most recent change to period status or close task progress.',
    `ledger_group` STRING COMMENT 'Identifier for the ledger group or accounting principle (e.g., 0L for leading ledger, 2L for IFRS parallel ledger) to which this period applies.',
    `liability_posting_status` STRING COMMENT 'Posting authorization status for liability account types (accounts payable, accrued expenses). Controls whether liability transactions can be posted in this period.. Valid values are `open|closed`',
    `notes` STRING COMMENT 'Free-text field for capturing important notes, issues, or commentary related to this fiscal period close (e.g., significant variances, process improvements, system issues).',
    `period_end_date` DATE COMMENT 'The last calendar date of the fiscal period when transactions can be posted.',
    `period_start_date` DATE COMMENT 'The first calendar date of the fiscal period when transactions can be posted.',
    `period_status` STRING COMMENT 'Overall status of the fiscal period controlling whether any posting activity is allowed: not_opened (future period), open (active posting), closed (period-end complete), locked (archived, no changes).. Valid values are `not_opened|open|closed|locked`',
    `period_type` STRING COMMENT 'Classification of the fiscal period: regular (monthly operating periods 1-12), special (adjustment periods 13-16), year_end (final close period), or opening (initial balance period).. Valid values are `regular|special|year_end|opening`',
    `posting_authority_override_allowed` BOOLEAN COMMENT 'Boolean flag indicating whether authorized users can override posting restrictions for this period (typically False for closed periods to maintain data integrity).',
    `responsible_controller` STRING COMMENT 'Name or identifier of the financial controller or accounting manager responsible for overseeing the close process for this period.',
    `revenue_posting_status` STRING COMMENT 'Posting authorization status for revenue account types (sales revenue, other income). Controls whether revenue transactions can be posted in this period.. Valid values are `open|closed`',
    `sign_off_date` DATE COMMENT 'The calendar date when the sign-off owner provided final certification for this fiscal period close.',
    `sign_off_owner` STRING COMMENT 'Name or identifier of the executive (CFO, Controller, VP Finance) who provides final certification and sign-off for this fiscal period close.',
    `source_system_code` STRING COMMENT 'Identifier of the source ERP or financial system from which this fiscal period record originated (e.g., SAP S/4HANA FI, Oracle Cloud Financials).',
    `sox_certification_status` STRING COMMENT 'Status of SOX internal control certification for this period: not_required (non-SOX entity), pending (awaiting sign-off), certified (controls attested), exception (control deficiency identified).. Valid values are `not_required|pending|certified|exception`',
    `total_close_tasks` STRING COMMENT 'Total count of close tasks defined for this fiscal period across all task types and responsible teams.',
    CONSTRAINT pk_fiscal_period PRIMARY KEY(`fiscal_period_id`)
) COMMENT 'Fiscal period management and financial close orchestration record defining accounting periods and all period-end close activities for each company code. Captures fiscal year, period number (1-12 plus special periods 13-16), start/end dates, period type (regular, special, year-end), open/close status per account type (assets, liabilities, revenue, expense), and posting authority controls. Also encompasses complete close task management: task name, task type (accrual posting, depreciation run, cost allocation, IC reconciliation, balance sheet reconciliation, financial statement preparation), responsible team, planned/actual completion dates, status (open, in-progress, complete, blocked), predecessor dependencies, sign-off owner, and SLA tracking. Controls posting windows and enables close cycle management, audit trail, SOX compliance evidence, and period-end SLA reporting for F&B financial operations.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`tax_record` (
    `tax_record_id` BIGINT COMMENT 'Unique identifier for the tax transaction record. Primary key for the tax_record product.',
    `account_id` BIGINT COMMENT 'Reference to the customer associated with this tax transaction for output tax scenarios (sales tax, VAT on customer invoices).',
    `ap_invoice_id` BIGINT COMMENT 'Reference to the vendor invoice document that generated this tax posting for input tax scenarios.',
    `ar_invoice_id` BIGINT COMMENT 'Reference to the customer invoice document that generated this tax posting for output tax scenarios.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: tax_record is filed by a legal entity; replace string code with FK to company_code',
    `journal_entry_id` BIGINT COMMENT 'Reference to the general ledger journal entry that contains this tax posting for manual or intercompany tax adjustments.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Tax records need to be associated with the product registration to report taxes per regulated product and satisfy agency filing requirements.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor associated with this tax transaction for input tax scenarios (VAT on vendor invoices, excise duty on raw material procurement).',
    `clearing_date` DATE COMMENT 'The date on which the tax liability was paid to the tax authority or input tax was recovered. Populated when tax_status is cleared.',
    `clearing_document_number` STRING COMMENT 'The document number of the payment or settlement document that cleared this tax liability or input tax receivable. Populated when tax_status is cleared.',
    `cost_center_code` STRING COMMENT 'The cost center code for tax expense allocation in cost accounting. Used for non-recoverable input tax and excise duty cost assignment.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this tax record was first created in the lakehouse silver layer. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the tax transaction. Examples: USD, EUR, GBP, JPY. Supports multi-currency tax reporting.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert transaction currency to local currency for tax reporting. Null if transaction currency equals local currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year in which the tax transaction is recorded. Examples: 1-12 for monthly periods, 1-4 for quarterly periods.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the tax transaction is recorded, based on the company code fiscal year variant. Examples: 2023, 2024.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which the tax amount is posted. Examples: 154000 (Input VAT Receivable), 175000 (Output VAT Payable), 520100 (Excise Duty Expense).',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this tax transaction is associated with an intercompany transaction between two company codes within the same corporate group. True if intercompany, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this tax record was last updated in the lakehouse silver layer. Supports change tracking and audit trail.',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the company code local currency. Used for statutory reporting and consolidation.. Valid values are `^[A-Z]{3}$`',
    `plant_code` STRING COMMENT 'The manufacturing plant or distribution center code where the taxable transaction originated. Relevant for excise duty and sugar levy calculations tied to production volume.',
    `profit_center_code` STRING COMMENT 'The profit center code for internal management reporting and tax cost allocation. Links tax expense to business segments.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversal transaction that negated this tax posting. Populated when tax_status is reversed.',
    `reversal_reason_code` STRING COMMENT 'The code indicating the reason for reversing this tax transaction. Examples: CN (credit note issued), ERR (posting error), ADJ (tax rate adjustment). Populated when tax_status is reversed.',
    `reverse_charge_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this transaction is subject to reverse charge VAT mechanism, where the buyer (not the seller) accounts for VAT. True if reverse charge applies, False otherwise.',
    `source_system_code` STRING COMMENT 'The identifier of the source ERP system from which this tax record was extracted. Examples: SAP_FI_PROD, SAP_FI_EU, ORACLE_ERP_CLOUD. Supports multi-system data integration and lineage.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount posted to the tax GL account. This is the product of taxable_base_amount and tax_rate_percentage.',
    `tax_amount_local_currency` DECIMAL(18,2) COMMENT 'The tax amount converted to the company code local currency using the exchange rate. Used for statutory tax reporting and consolidation.',
    `tax_authority_name` STRING COMMENT 'The name of the tax authority or regulatory body to which this tax is remitted. Examples: IRS (US), HMRC (UK), Bundeszentralamt für Steuern (Germany), Direction Générale des Finances Publiques (France).',
    `tax_code` STRING COMMENT 'The tax code configured in the ERP system that determines tax rate, tax type, and GL account assignment. Examples: V0 (zero-rated VAT), V1 (standard VAT), I1 (input VAT), E1 (excise duty code).',
    `tax_document_date` DATE COMMENT 'The date of the source document (invoice date, receipt date) that triggered the tax transaction. Used for tax point determination and VAT reporting.',
    `tax_document_number` STRING COMMENT 'The unique document number assigned to this tax transaction in the source ERP system (SAP FI tax module). This is the externally-known identifier for audit and reconciliation purposes.',
    `tax_exemption_certificate_number` STRING COMMENT 'The certificate or authorization number issued by the tax authority granting exemption for this transaction. Required for audit trail when tax_exemption_indicator is True.',
    `tax_exemption_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this transaction qualifies for tax exemption under applicable regulations. True if exempt, False otherwise. Examples: export sales (zero-rated VAT), essential food items (sales tax exempt).',
    `tax_exemption_reason_code` STRING COMMENT 'The code representing the legal basis for tax exemption. Examples: EXP (export), ESS (essential goods), RES (resale), GOV (government entity). Populated only when tax_exemption_indicator is True.',
    `tax_jurisdiction_code` STRING COMMENT 'The tax authority jurisdiction code where this tax is assessed and reported. Examples: US-CA (California), GB-HMRC (UK), DE-BZSt (Germany), FR-DGFiP (France). Supports multi-jurisdictional tax compliance.',
    `tax_line_item_number` STRING COMMENT 'Line item sequence number within the parent financial document, distinguishing multiple tax postings on a single invoice or journal entry.',
    `tax_posting_date` DATE COMMENT 'The date on which the tax transaction was posted to the general ledger. This is the accounting date for tax liability or receivable recognition.',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'The tax rate applied to the taxable base amount, expressed as a percentage. Examples: 20.00 (UK VAT standard rate), 19.00 (German VAT), 5.50 (reduced rate), 0.00 (zero-rated).',
    `tax_registration_number` STRING COMMENT 'The company code tax registration number or VAT identification number registered with the tax authority. Examples: VAT number (EU), EIN (US), GST number (India). Business-confidential identifier.',
    `tax_reporting_period` STRING COMMENT 'The tax authority reporting period to which this transaction belongs. Format varies by jurisdiction: YYYY-MM (monthly VAT), YYYY-QQ (quarterly sales tax), YYYY (annual excise duty). Examples: 2024-03, 2024-Q1, 2024.',
    `tax_status` STRING COMMENT 'Current lifecycle status of the tax transaction. Posted: initial posting complete. Cleared: tax liability settled or input tax recovered. Reversed: transaction reversed due to credit note or correction. Adjusted: manual adjustment applied. Under_audit: flagged for tax authority audit. Disputed: under dispute with tax authority.. Valid values are `posted|cleared|reversed|adjusted|under_audit|disputed`',
    `tax_type` STRING COMMENT 'Classification of the tax transaction by tax category: input VAT (recoverable tax on purchases), output VAT (tax collected on sales), sales tax, excise duty (alcohol, tobacco, fuel), sugar levy (sugar content tax on beverages), customs duty, withholding tax, use tax, or reverse charge VAT. [ENUM-REF-CANDIDATE: input_vat|output_vat|sales_tax|excise_duty|sugar_levy|customs_duty|withholding_tax|use_tax|reverse_charge — 9 candidates stripped; promote to reference product]',
    `taxable_base_amount` DECIMAL(18,2) COMMENT 'The net amount on which the tax is calculated, before tax is applied. This is the invoice line total or cost base subject to taxation.',
    `trading_partner_company_code` STRING COMMENT 'The company code of the intercompany trading partner for intercompany tax transactions. Populated only when intercompany_indicator is True.',
    CONSTRAINT pk_tax_record PRIMARY KEY(`tax_record_id`)
) COMMENT 'Tax transaction record capturing VAT, GST, sales tax, excise duty, and sugar tax postings associated with customer invoices, vendor invoices, and intercompany transactions. Sourced from SAP FI tax module. Captures tax document reference, tax type (input, output, excise, sugar levy), tax code, tax jurisdiction, taxable base amount, tax amount, currency, tax rate, reporting period, and tax authority. Supports indirect tax compliance and regulatory reporting obligations across F&B global markets including FDA/USDA and EFSA jurisdictions.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'System-generated unique identifier for the bank account record.',
    `cash_pool_id` BIGINT COMMENT 'Identifier of the cash pool to which the account belongs, if applicable.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: bank_account is owned by a legal entity; replace string code with FK to company_code',
    `cost_center_id` BIGINT COMMENT 'Cost center responsible for the accounts expenses.',
    `legal_entity_company_code_id` BIGINT COMMENT 'Reference to the legal entity (company code) that owns the account.',
    `profit_center_id` BIGINT COMMENT 'Profit center linked to the account for revenue attribution.',
    `cash_pool_header_bank_account_id` BIGINT COMMENT 'Self-referencing FK on bank_account (cash_pool_header_bank_account_id)',
    `account_number` STRING COMMENT 'The domestic bank account number used for payments and cash management.',
    `account_type` STRING COMMENT 'Classification of the account for treasury purposes.. Valid values are `operating|payroll|concentration|investment|custodial`',
    `balance_timestamp` TIMESTAMP COMMENT 'Timestamp when the daily balance was recorded.',
    `bank_account_status` STRING COMMENT 'Current lifecycle state of the bank account.. Valid values are `active|inactive|closed|suspended|pending`',
    `bank_address` STRING COMMENT 'Physical address of the bank branch.',
    `bank_branch` STRING COMMENT 'Name or code of the specific branch where the account is held.',
    `bank_city` STRING COMMENT 'City where the bank branch is located.',
    `bank_country` STRING COMMENT 'Three‑letter ISO country code where the bank is located.. Valid values are `^[A-Z]{3}$`',
    `bank_name` STRING COMMENT 'Legal name of the financial institution holding the account.',
    `bank_postal_code` STRING COMMENT 'Postal code of the bank branch address.',
    `bank_state` STRING COMMENT 'State or province of the bank branch.',
    `closing_date` DATE COMMENT 'Date the bank account was closed or scheduled for closure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code of the account (e.g., USD, EUR).. Valid values are `^[A-Z]{3}$`',
    `daily_balance` DECIMAL(18,2) COMMENT 'End‑of‑day cash balance for the account, used for cash positioning.',
    `iban` STRING COMMENT 'Standardized international account identifier for cross‑border transactions.',
    `is_consolidated` BOOLEAN COMMENT 'True if the account is part of a consolidated cash pool.',
    `is_intercompany` BOOLEAN COMMENT 'True if the account is used for intercompany transactions.',
    `last_reconciled_date` DATE COMMENT 'Date of the most recent successful bank reconciliation.',
    `opening_date` DATE COMMENT 'Date the bank account was opened.',
    `reconciliation_gl_account` STRING COMMENT 'General Ledger account used for bank reconciliation postings.',
    `swift_bic` STRING COMMENT 'Bank Identifier Code used for international wire transfers.',
    `treasury_center` STRING COMMENT 'Organizational unit responsible for the account within treasury.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the bank account record.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Bank account master record for all Food Beverage corporate bank accounts used in payment processing, cash pooling, and treasury management. Captures bank key, account number, IBAN, SWIFT/BIC, bank name, country, currency, account type (operating, payroll, concentration, investment), GL reconciliation account, daily balance, and status. Governs cash position reporting, payment file generation, and bank reconciliation across F&B global operations.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key for payment_run',
    `approved_by_user_employee_id` BIGINT COMMENT 'User identifier who approved the payment run.',
    `employee_id` BIGINT COMMENT 'User identifier who created the payment run record.',
    `party_id` BIGINT COMMENT 'Identifier of the vendor, supplier, or internal entity associated with the payment run.',
    `reversal_payment_run_id` BIGINT COMMENT 'Self-referencing FK on payment_run (reversal_payment_run_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run was approved.',
    `batch_number` STRING COMMENT 'External batch identifier from the payment processor.',
    `cost_center_code` STRING COMMENT 'Cost center associated with the payment run for internal accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run record was created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the payment run amounts.',
    `payment_run_description` STRING COMMENT 'Narrative description or notes for the payment run.',
    `effective_from` DATE COMMENT 'Start date of the payment runs applicability.',
    `effective_until` DATE COMMENT 'End date of the payment runs applicability, if applicable.',
    `error_message` STRING COMMENT 'Error message captured if the payment run failed.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used if the payment run involves currency conversion.',
    `exchange_rate_date` DATE COMMENT 'Date of the exchange rate applied to the payment run.',
    `fee_code` STRING COMMENT 'Fee classification code for the payment run.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the payment run was processed automatically.',
    `is_reconciled` BOOLEAN COMMENT 'Indicates whether the payment run has been reconciled.',
    `number_of_transactions` STRING COMMENT 'Count of individual payment transactions included in this run.',
    `payment_channel` STRING COMMENT 'Channel through which the payment run was processed.',
    `payment_method` STRING COMMENT 'Primary payment method used for the run.',
    `payment_run_version` STRING COMMENT 'Version number of the payment run record for change tracking.',
    `priority` STRING COMMENT 'Priority level assigned to the payment run.',
    `processing_time_seconds` STRING COMMENT 'Total processing time in seconds for the payment run.',
    `reconciliation_date` DATE COMMENT 'Date when the payment run was reconciled.',
    `region_code` STRING COMMENT 'Geographic region code for the payment run.',
    `retry_count` STRING COMMENT 'Number of retry attempts for the payment run.',
    `run_number` STRING COMMENT 'Business identifier assigned to the payment run.',
    `run_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run was initiated.',
    `run_type` STRING COMMENT 'Classification of the payment run purpose.',
    `scheduled_date` DATE COMMENT 'Planned date for the payment run to start.',
    `settlement_date` DATE COMMENT 'Date when the payment run is settled with the bank.',
    `source_system` STRING COMMENT 'Source system that originated the payment run.',
    `payment_run_status` STRING COMMENT 'Current lifecycle status of the payment run.',
    `tax_code` STRING COMMENT 'Tax code applied to the payment run.',
    `total_fee_amount` DECIMAL(18,2) COMMENT 'Total processing fees for the payment run.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount of all payments before deductions.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Net amount after taxes and fees.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the payment run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment run record.',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Master reference table for payment_run. Referenced by payment_run_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`cash_pool` (
    `cash_pool_id` BIGINT COMMENT 'Primary key for cash_pool',
    `parent_cash_pool_id` BIGINT COMMENT 'Self-referencing FK on cash_pool (parent_cash_pool_id)',
    `accounting_rule` STRING COMMENT 'Accounting rule or policy applied to the cash pool (e.g., FIFO, LIFO).',
    `audit_created_by` STRING COMMENT 'User identifier who performed the initial audit entry.',
    `audit_updated_by` STRING COMMENT 'User identifier who performed the most recent audit update.',
    `balance_amount` DECIMAL(18,2) COMMENT 'Current monetary balance held in the cash pool.',
    `cash_pool_category` STRING COMMENT 'High‑level category describing the strategic purpose of the cash pool.',
    `cash_pool_limit_amount` DECIMAL(18,2) COMMENT 'Maximum authorized balance for the cash pool.',
    `cash_pool_purpose` STRING COMMENT 'Specific business purpose for which the cash pool is maintained.',
    `cash_pool_utilization_pct` DECIMAL(18,2) COMMENT 'Percentage of the cash pool limit that is currently utilized.',
    `cash_pool_code` STRING COMMENT 'Business code used to reference the cash pool in external systems.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the cash pool.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cash pool record was first created in the system.',
    `currency` STRING COMMENT 'ISO 4217 currency code of the cash pool balances.',
    `cash_pool_description` STRING COMMENT 'Free‑form description providing context or notes about the cash pool.',
    `effective_from` DATE COMMENT 'Date when the cash pool becomes effective for accounting purposes.',
    `effective_until` DATE COMMENT 'Date when the cash pool ceases to be effective (null if open‑ended).',
    `interest_rate` DECIMAL(18,2) COMMENT 'Applicable interest rate for the cash pool expressed as a decimal (e.g., 0.0250 = 2.50%).',
    `is_cross_border` BOOLEAN COMMENT 'Indicates whether the cash pool includes cross‑border funds.',
    `last_reconciled_date` DATE COMMENT 'Date when the cash pool balances were last reconciled.',
    `legal_entity` STRING COMMENT 'Legal entity (company) that owns the cash pool.',
    `manager_email` STRING COMMENT 'Email address of the cash pool manager.',
    `manager_name` STRING COMMENT 'Full name of the individual responsible for managing the cash pool.',
    `manager_phone` STRING COMMENT 'Contact phone number of the cash pool manager.',
    `maturity_date` DATE COMMENT 'Date on which the cash pool matures or is scheduled for review.',
    `cash_pool_name` STRING COMMENT 'Human‑readable name of the cash pool.',
    `notes` STRING COMMENT 'Additional free‑form notes about the cash pool.',
    `owner_department` STRING COMMENT 'Organizational department responsible for the cash pool.',
    `reconciliation_status` STRING COMMENT 'Current status of the cash pool reconciliation process.',
    `region` STRING COMMENT 'Geographic region where the cash pool is primarily managed.',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the cash pool based on financial exposure.',
    `rollover_flag` BOOLEAN COMMENT 'Indicates whether the cash pool rolls over unused balances to the next period.',
    `source_system` STRING COMMENT 'Name of the source system of record for the cash pool data.',
    `cash_pool_status` STRING COMMENT 'Current lifecycle status of the cash pool.',
    `tax_jurisdiction` STRING COMMENT 'Tax jurisdiction applicable to the cash pool.',
    `cash_pool_type` STRING COMMENT 'Classification of the cash pool based on its primary function.',
    `updated_by` STRING COMMENT 'User identifier who last updated the cash pool record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cash pool record.',
    `version_number` STRING COMMENT 'Version number for optimistic concurrency control.',
    `created_by` STRING COMMENT 'User identifier who created the cash pool record.',
    CONSTRAINT pk_cash_pool PRIMARY KEY(`cash_pool_id`)
) COMMENT 'Master reference table for cash_pool. Referenced by cash_pool_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`netting_run` (
    `netting_run_id` BIGINT COMMENT 'Primary key for netting_run',
    `party_id` BIGINT COMMENT 'Identifier of the primary counterparty (e.g., business unit or external entity) involved in the netting run.',
    `reversal_netting_run_id` BIGINT COMMENT 'Self-referencing FK on netting_run (reversal_netting_run_id)',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of all adjustments (fees, taxes, discounts) applied during netting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the netting run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts in the netting run.',
    `netting_run_description` STRING COMMENT 'Free‑form text describing the purpose or notes for the netting run.',
    `effective_date` DATE COMMENT 'Date on which the netting run becomes effective for reporting purposes.',
    `expiry_date` DATE COMMENT 'Optional date when the netting run ceases to be valid; null if open‑ended.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross monetary value of all transactions before netting adjustments.',
    `net_amount` DECIMAL(18,2) COMMENT 'Resulting net monetary value after applying adjustments.',
    `netting_run_number` STRING COMMENT 'Business-visible identifier or code assigned to the netting run.',
    `netting_type` STRING COMMENT 'Category of netting performed (e.g., intercompany, cash, securities).',
    `processing_time_seconds` STRING COMMENT 'Total elapsed time in seconds for the netting run to complete.',
    `run_reason` STRING COMMENT 'Business reason or trigger for executing the netting run.',
    `run_timestamp` TIMESTAMP COMMENT 'Date and time when the netting run was executed.',
    `run_user` STRING COMMENT 'Identifier of the employee or system user who initiated the netting run.',
    `source_system` STRING COMMENT 'Name of the upstream system that supplied the transaction data for netting.',
    `netting_run_status` STRING COMMENT 'Current lifecycle status of the netting run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the netting run record.',
    CONSTRAINT pk_netting_run PRIMARY KEY(`netting_run_id`)
) COMMENT 'Master reference table for netting_run. Referenced by netting_run_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`finance`.`party` (
    `party_id` BIGINT COMMENT 'Primary key for party',
    `parent_party_id` BIGINT COMMENT 'Self-referencing FK on party (parent_party_id)',
    `address_line1` STRING COMMENT 'First line of the partys street address.',
    `address_line2` STRING COMMENT 'Second line of the partys street address (optional).',
    `city` STRING COMMENT 'City component of the partys address.',
    `classification` STRING COMMENT 'Business classification indicating internal vs external relationship.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the partys primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the party record was first created.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for the party.',
    `currency_code` STRING COMMENT 'Default currency for financial transactions with the party.',
    `date_of_birth` DATE COMMENT 'Birth date of an individual party.',
    `effective_end_date` DATE COMMENT 'Date when the party was deactivated or terminated (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the party became active in the system.',
    `email_address` STRING COMMENT 'Primary email address for electronic communications.',
    `industry_code` STRING COMMENT 'Standard industry classification code for the party.',
    `is_tax_exempt` BOOLEAN COMMENT 'Indicates whether the party is exempt from tax.',
    `legal_name` STRING COMMENT 'The legally registered name of the party used for contracts and regulatory filings.',
    `party_name` STRING COMMENT 'The primary display name of the party (person or organization).',
    `national_id_number` STRING COMMENT 'National identification number for individuals (e.g., SSN, passport).',
    `party_type` STRING COMMENT 'Classification of the party by its role in the ecosystem.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the party.',
    `phone_number` STRING COMMENT 'Primary telephone number for voice contact.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the partys address.',
    `preferred_language` STRING COMMENT 'Language preferred for communications.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for primary communications with the party.',
    `risk_rating` STRING COMMENT 'Overall risk assessment of the party.',
    `state_province` STRING COMMENT 'State or province component of the partys address.',
    `party_status` STRING COMMENT 'Current lifecycle status of the party record.',
    `tax_exempt_reason` STRING COMMENT 'Reason or code for tax exemption, if applicable.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax registration number (e.g., EIN, VAT).',
    `trade_name` STRING COMMENT 'The commonly used or brand name of the party, if different from the legal name.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the party record.',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Master reference table for party. Referenced by party_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `food_beverage_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ADD CONSTRAINT `fk_finance_finance_standard_cost_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ADD CONSTRAINT `fk_finance_finance_standard_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ADD CONSTRAINT `fk_finance_finance_standard_cost_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ADD CONSTRAINT `fk_finance_finance_standard_cost_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ADD CONSTRAINT `fk_finance_forecast_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ADD CONSTRAINT `fk_finance_forecast_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ADD CONSTRAINT `fk_finance_forecast_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_netting_run_id` FOREIGN KEY (`netting_run_id`) REFERENCES `food_beverage_ecm`.`finance`.`netting_run`(`netting_run_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `food_beverage_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `food_beverage_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `food_beverage_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_cash_pool_id` FOREIGN KEY (`cash_pool_id`) REFERENCES `food_beverage_ecm`.`finance`.`cash_pool`(`cash_pool_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_legal_entity_company_code_id` FOREIGN KEY (`legal_entity_company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_cash_pool_header_bank_account_id` FOREIGN KEY (`cash_pool_header_bank_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_party_id` FOREIGN KEY (`party_id`) REFERENCES `food_beverage_ecm`.`finance`.`party`(`party_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_reversal_payment_run_id` FOREIGN KEY (`reversal_payment_run_id`) REFERENCES `food_beverage_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`cash_pool` ADD CONSTRAINT `fk_finance_cash_pool_parent_cash_pool_id` FOREIGN KEY (`parent_cash_pool_id`) REFERENCES `food_beverage_ecm`.`finance`.`cash_pool`(`cash_pool_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`netting_run` ADD CONSTRAINT `fk_finance_netting_run_party_id` FOREIGN KEY (`party_id`) REFERENCES `food_beverage_ecm`.`finance`.`party`(`party_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`netting_run` ADD CONSTRAINT `fk_finance_netting_run_reversal_netting_run_id` FOREIGN KEY (`reversal_netting_run_id`) REFERENCES `food_beverage_ecm`.`finance`.`netting_run`(`netting_run_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ADD CONSTRAINT `fk_finance_party_parent_party_id` FOREIGN KEY (`parent_party_id`) REFERENCES `food_beverage_ecm`.`finance`.`party`(`party_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `food_beverage_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `esg_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Disclosure Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'House Bank Account Identifier');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_category` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Category');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_category` SET TAGS ('dbx_value_regex' = 'balance_sheet|profit_and_loss|statistical|memo');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_created_by` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Created By User');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_creation_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Creation Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_group_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_hierarchy_node` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Node');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_long_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Long Description');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|blocked|marked_for_deletion|inactive');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_subtype` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Subtype');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_business_glossary_term' = 'Alternative Account Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `balance_sheet_account` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Account Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `commitment_management` SET TAGS ('dbx_business_glossary_term' = 'Commitment Management Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `company_code_posting_block` SET TAGS ('dbx_business_glossary_term' = 'Company Code Posting Block Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|not_applicable');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Type Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Account Currency Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `deletion_flag` SET TAGS ('dbx_business_glossary_term' = 'Deletion Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `field_status_group` SET TAGS ('dbx_business_glossary_term' = 'Field Status Group Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `financial_statement_version` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Version (FSV)');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `inflation_index` SET TAGS ('dbx_business_glossary_term' = 'Inflation Index Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `interest_calculation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Interest Calculation Indicator');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `is_reconciliation_account` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Last Modified Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `line_item_display` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `only_balances_in_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Only Balances in Local Currency Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `open_item_management` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `planning_level` SET TAGS ('dbx_business_glossary_term' = 'Planning Level Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `posting_block` SET TAGS ('dbx_business_glossary_term' = 'Posting Block Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `profit_center_default` SET TAGS ('dbx_business_glossary_term' = 'Default Profit Center Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `profit_loss_statement_account` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Statement Account Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account_type` SET TAGS ('dbx_value_regex' = 'accounts_payable|accounts_receivable|fixed_assets|none');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `revaluation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Foreign Currency Revaluation Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Sort Key Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `sort_key` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ALTER COLUMN `tolerance_group` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Group Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `packaging_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Type Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,6}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct_activity|assessment|distribution|statistical');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `changed_by_user` SET TAGS ('dbx_business_glossary_term' = 'Changed By User ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `changed_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_.-]{1,12}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `cogs_relevant` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Relevant Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'production|administration|marketing|research_development|distribution|quality');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|locked|pending_deletion');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|overhead|service');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Group');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_.-]{1,12}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Currency Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,16}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_area` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Hierarchy Area');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Cost Center Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `is_locked_for_posting` SET TAGS ('dbx_business_glossary_term' = 'Locked for Posting Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `is_statistical` SET TAGS ('dbx_business_glossary_term' = 'Statistical Cost Center Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `overhead_key` SET TAGS ('dbx_business_glossary_term' = 'Overhead Key');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `overhead_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,6}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `source_record_key` SET TAGS ('dbx_business_glossary_term' = 'Source Record Key');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `standard_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Activity Rate');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `standard_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,24}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|assessment|distribution|settlement|none');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `budget_period_end` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `budget_period_start` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|foodservice|dtc|ecommerce|export|institutional');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Currency Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `dummy_profit_center_flag` SET TAGS ('dbx_business_glossary_term' = 'Dummy Profit Center Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,16}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `gl_account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `hierarchy_node_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Node Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Lock Indicator');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `product_line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_group` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Group');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_level` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Level');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|locked|in_planning|archived');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'brand|product_line|geographic_region|channel|business_unit|functional');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `sap_profit_center_key` SET TAGS ('dbx_business_glossary_term' = 'SAP Profit Center Natural Key');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `sap_profit_center_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Short Name');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_value_regex' = '^.{1,20}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,30}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `standard_costing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Standard Costing Enabled Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `sustainability_segment` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Segment Classification');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `sustainability_segment` SET TAGS ('dbx_value_regex' = 'sustainable|conventional|transitioning|not_applicable');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,15}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `transfer_price_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Method');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `transfer_price_method` SET TAGS ('dbx_value_regex' = 'cost_plus|market_price|negotiated|none');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'IFRS|US_GAAP|LOCAL_GAAP|IFRS_and_LOCAL');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `address_city` SET TAGS ('dbx_business_glossary_term' = 'Registered Office City');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `address_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `address_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Office Postal Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `address_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `address_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `address_region` SET TAGS ('dbx_business_glossary_term' = 'Registered Office State or Region');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `address_region` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `address_region` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `address_street` SET TAGS ('dbx_business_glossary_term' = 'Registered Office Street Address');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `address_street` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `address_street` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) Assignment');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_business_glossary_term' = 'Company Code Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|in_liquidation|dormant|pending_registration');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `company_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Company Registration Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `company_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `consolidation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Indicator');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO Area)');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Incorporation (ISO 3166-1 Alpha-3)');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_business_glossary_term' = 'Credit Control Area');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Company Code Deactivation Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'subsidiary|joint_venture|holding|branch|associate|operating_entity');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `erp_system_instance` SET TAGS ('dbx_business_glossary_term' = 'ERP System Instance');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `food_safety_license_number` SET TAGS ('dbx_business_glossary_term' = 'Food Safety License Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `food_safety_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `functional_currency_indicator` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Indicator');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `gfsi_certification_scheme` SET TAGS ('dbx_business_glossary_term' = 'Global Food Safety Initiative (GFSI) Certification Scheme');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `gfsi_certification_scheme` SET TAGS ('dbx_value_regex' = 'SQF|BRC|FSSC_22000|IFS|GlobalGAP|not_certified');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `gst_applicable` SET TAGS ('dbx_business_glossary_term' = 'Goods and Services Tax (GST) Applicable Indicator');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Incorporation');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `language_key` SET TAGS ('dbx_business_glossary_term' = 'Language Key (ISO 639-1)');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `language_key` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `parent_company_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `parent_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `posting_period_variant` SET TAGS ('dbx_business_glossary_term' = 'Posting Period Variant');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `posting_period_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `profit_center_standard` SET TAGS ('dbx_business_glossary_term' = 'Standard Profit Center');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Company Short Name');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_S4|ORACLE_CLOUD|LEGACY');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'CUP|resale_price|cost_plus|TNMM|profit_split|not_applicable');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'VAT Registration Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`company_code` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `assignment` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Document Currency Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_header_text` SET TAGS ('dbx_business_glossary_term' = 'Document Header Text');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'draft|posted|parked|reversed|cleared|blocked');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `gl_account` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `internal_order` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_type` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_type` SET TAGS ('dbx_value_regex' = 'standard|accrual|reversal|recurring|statistical|intercompany');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_period_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Period Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_period_status` SET TAGS ('dbx_value_regex' = 'open|closed|blocked|future');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|ORACLE_ERP|MANUAL|INTERFACE|LEGACY');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (Document Currency)');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount (Document Currency)');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_credit_amount_lc` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount Local Currency');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_credit_amount_lc` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Amount (Document Currency)');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_debit_amount_lc` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Amount Local Currency');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_debit_amount_lc` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Company Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'payables_management');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Invoice Blocking Reason');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'open|partially_cleared|cleared|reversed');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_captured` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Captured Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_due_date` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Due Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `edi_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(0[1-9]|1[0-6])$');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_reference_text` SET TAGS ('dbx_business_glossary_term' = 'Invoice Reference Text');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'open|in_review|approved|blocked|paid|cancelled');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|recurring|intercompany');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Invoice Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Recurring Invoice Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'not_matched|two_way_matched|three_way_matched|exception');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire|check|virtual_card|direct_debit');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Accounting Document Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `vendor_bank_account` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Account Reference');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `vendor_bank_account` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `vendor_bank_account` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ALTER COLUMN `vendor_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_company_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Company Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Document Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|foodservice|convenience|dtc|ecommerce|club');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `deduction_code` SET TAGS ('dbx_business_glossary_term' = 'Deduction Reason Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Description');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'none|open|under_review|resolved|escalated');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `early_payment_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `early_payment_discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `early_payment_discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `early_payment_discount_date` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `edi_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `edi_status` SET TAGS ('dbx_value_regex' = 'not_applicable|sent|acknowledged|rejected|portal_submitted');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'open|partially_paid|paid|disputed|cancelled|written_off');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|intercompany|pro_forma|consignment');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `lockbox_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Lockbox Batch ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `open_amount` SET TAGS ('dbx_business_glossary_term' = 'Open (Outstanding) Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `open_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `open_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount Received');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Receipt Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire|check|credit_card|edi_payment|lockbox');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `remittance_document_number` SET TAGS ('dbx_business_glossary_term' = 'Remittance Document Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `sales_org_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `short_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Short Payment Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `short_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `short_payment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `trade_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Discount Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `trade_discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `trade_discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `finance_standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `co_packing_cost` SET TAGS ('dbx_business_glossary_term' = 'Co-Packing Cost');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `cost_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Change Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `cost_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Change Percentage');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `cost_component_structure` SET TAGS ('dbx_business_glossary_term' = 'Cost Component Structure');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `cost_component_structure` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `cost_estimate_number` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `cost_estimate_number` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `cost_estimate_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `cost_estimate_status` SET TAGS ('dbx_value_regex' = 'created|calculated|released|marked_for_deletion|error');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `costing_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Costing Lot Size');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `costing_variant` SET TAGS ('dbx_business_glossary_term' = 'Costing Variant');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `costing_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `costing_version` SET TAGS ('dbx_business_glossary_term' = 'Costing Version');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `costing_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `direct_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Direct Labor Cost');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `fixed_overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Fixed Manufacturing Overhead Cost');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `freight_in_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight-In Cost');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `other_cost` SET TAGS ('dbx_business_glossary_term' = 'Other Manufacturing Cost');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `packaging_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material Cost');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `previous_standard_price` SET TAGS ('dbx_business_glossary_term' = 'Previous Standard Price Per Unit');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `price_control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Price Control Indicator');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `price_control_indicator` SET TAGS ('dbx_value_regex' = 'S|V');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `raw_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Cost');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `released_by_user` SET TAGS ('dbx_business_glossary_term' = 'Released By User');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `released_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,12}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `standard_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Standard Price Per Unit');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `variable_overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Variable Manufacturing Overhead Cost');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `variance_category` SET TAGS ('dbx_business_glossary_term' = 'Variance Category');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `primary_finance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `primary_finance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `primary_finance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'DRAFT|SUBMITTED|APPROVED|REJECTED|LOCKED');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'ANNUAL|ROLLING|SUPPLEMENTAL|CONTINGENCY');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'OPEX|CAPEX|REVENUE|HEADCOUNT|COGS|TRADE_SPEND');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `is_carry_forward` SET TAGS ('dbx_business_glossary_term' = 'Is Carry Forward Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Is Budget Locked Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Budget Quantity');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `sales_org_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `sales_org_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `source_record_key` SET TAGS ('dbx_business_glossary_term' = 'Source Record Key');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `version_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `version_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ALTER COLUMN `version_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Name');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Identifier');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `forecast_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Owner ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `forecast_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `forecast_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Sales and Operations Planning (S&OP) Cycle ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `commentary` SET TAGS ('dbx_business_glossary_term' = 'Forecast Commentary');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Level');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `driver_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Driver Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(P(0[1-9]|1[0-2])|Q[1-4]|H[1-2]|FY)$');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|published|superseded');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'rolling|annual|quarterly|monthly|reforecast|flash');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `forecasted_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `gl_account_category` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Category');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Owner Name');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `prior_forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Forecast Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `product_category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `sales_org_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `sales_org_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `scenario_code` SET TAGS ('dbx_business_glossary_term' = 'Scenario Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `scenario_code` SET TAGS ('dbx_value_regex' = 'base|optimistic|pessimistic|worst_case|best_case');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `variance_to_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance to Budget Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `variance_to_prior_forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance to Prior Forecast Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `version_code` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ALTER COLUMN `version_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_location` SET TAGS ('dbx_business_glossary_term' = 'Asset Location');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|retired|disposed|impaired');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Depreciation General Ledger (GL) Account Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits|none');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `expense_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Expense General Ledger (GL) Account Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_date` SET TAGS ('dbx_business_glossary_term' = 'Impairment Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_physical_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inventory Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `original_cost` SET TAGS ('dbx_business_glossary_term' = 'Original Cost');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `sap_asset_key` SET TAGS ('dbx_business_glossary_term' = 'SAP Asset Key');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_run_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Run ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_run_id` SET TAGS ('dbx_value_regex' = '^NET[0-9]{8}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Document Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_document_number` SET TAGS ('dbx_business_glossary_term' = 'Elimination Document Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Elimination Flag');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_status` SET TAGS ('dbx_business_glossary_term' = 'Netting Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `netting_status` SET TAGS ('dbx_value_regex' = 'not_netted|included_in_netting|netted|excluded');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|netting|offset|manual_journal');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|disputed|under_review');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'draft|posted|cleared|reversed|eliminated');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'goods_transfer|service_charge|royalty|loan_interest|management_fee|cost_allocation');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'cost_plus|market_price|negotiated|comparable_uncontrolled|resale_minus');
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Identifier');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `asset_posting_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Posting Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `asset_posting_status` SET TAGS ('dbx_value_regex' = 'open|closed');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `audit_trail_enabled` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `balance_sheet_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Reconciliation Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `balance_sheet_reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|reconciled|variance');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `blocked_close_tasks` SET TAGS ('dbx_business_glossary_term' = 'Blocked Close Tasks');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `close_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Close Actual Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `close_cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Close Cycle Name');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `close_delay_days` SET TAGS ('dbx_business_glossary_term' = 'Close Delay Days');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `close_sla_met` SET TAGS ('dbx_business_glossary_term' = 'Close Service Level Agreement (SLA) Met');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `close_start_date` SET TAGS ('dbx_business_glossary_term' = 'Close Start Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `close_status` SET TAGS ('dbx_business_glossary_term' = 'Close Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `close_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|complete|certified');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `close_target_date` SET TAGS ('dbx_business_glossary_term' = 'Close Target Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `completed_close_tasks` SET TAGS ('dbx_business_glossary_term' = 'Completed Close Tasks');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `cost_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `cost_allocation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|complete|error');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `depreciation_run_status` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Run Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `depreciation_run_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|complete|error');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `expense_posting_status` SET TAGS ('dbx_business_glossary_term' = 'Expense Posting Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `expense_posting_status` SET TAGS ('dbx_value_regex' = 'open|closed');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `financial_statement_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `financial_statement_status` SET TAGS ('dbx_value_regex' = 'not_started|draft|review|approved|published');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_number` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `intercompany_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany (IC) Reconciliation Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `intercompany_reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|reconciled|variance');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `liability_posting_status` SET TAGS ('dbx_business_glossary_term' = 'Liability Posting Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `liability_posting_status` SET TAGS ('dbx_value_regex' = 'open|closed');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Period Close Notes');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'not_opened|open|closed|locked');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'regular|special|year_end|opening');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `posting_authority_override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Posting Authority Override Allowed');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `responsible_controller` SET TAGS ('dbx_business_glossary_term' = 'Responsible Controller');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `revenue_posting_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Posting Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `revenue_posting_status` SET TAGS ('dbx_value_regex' = 'open|closed');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `sign_off_owner` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Owner');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `sox_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Certification Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `sox_certification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|certified|exception');
ALTER TABLE `food_beverage_ecm`.`finance`.`fiscal_period` ALTER COLUMN `total_close_tasks` SET TAGS ('dbx_business_glossary_term' = 'Total Close Tasks');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Indicator');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `reverse_charge_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reverse Charge Indicator');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount in Local Currency');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Name');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_document_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Document Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_document_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Document Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_exemption_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Indicator');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_exemption_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Reason Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Line Item Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Date');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Period');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Transaction Status');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_status` SET TAGS ('dbx_value_regex' = 'posted|cleared|reversed|adjusted|under_audit|disputed');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `taxable_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Base Amount');
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ALTER COLUMN `trading_partner_company_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Company Code');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'payables_management');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Identifier');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `cash_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Pool Identifier (CASH_POOL_ID)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (COST_CENTER_ID)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `legal_entity_company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEGAL_ENTITY_ID)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (PROFIT_CENTER_ID)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `cash_pool_header_bank_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number (ACCOUNT_NUMBER)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type (ACCOUNT_TYPE)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'operating|payroll|concentration|investment|custodial');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `balance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Balance Capture Timestamp (BALANCE_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status (STATUS)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended|pending');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address` SET TAGS ('dbx_business_glossary_term' = 'Bank Address (BANK_ADDRESS)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch (BANK_BRANCH)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_city` SET TAGS ('dbx_business_glossary_term' = 'Bank City (BANK_CITY)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_country` SET TAGS ('dbx_business_glossary_term' = 'Bank Country Code (BANK_COUNTRY)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name (BANK_NAME)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Postal Code (BANK_POSTAL_CODE)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_state` SET TAGS ('dbx_business_glossary_term' = 'Bank State/Province (BANK_STATE)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closing Date (CLOSING_DATE)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY_CODE)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `daily_balance` SET TAGS ('dbx_business_glossary_term' = 'Daily Account Balance (DAILY_BALANCE)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `daily_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `daily_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Account Indicator (IS_CONSOLIDATED)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Account Indicator (IS_INTERCOMPANY)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `last_reconciled_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date (LAST_RECONCILED_DATE)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opening Date (OPENING_DATE)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_gl_account` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation GL Account (RECONCILIATION_GL_ACCOUNT)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic` SET TAGS ('dbx_business_glossary_term' = 'SWIFT/BIC Code (SWIFT_BIC)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `treasury_center` SET TAGS ('dbx_business_glossary_term' = 'Treasury Center (TREASURY_CENTER)');
ALTER TABLE `food_beverage_ecm`.`finance`.`bank_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'payables_management');
ALTER TABLE `food_beverage_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Identifier');
ALTER TABLE `food_beverage_ecm`.`finance`.`payment_run` ALTER COLUMN `reversal_payment_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`cash_pool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`cash_pool` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `food_beverage_ecm`.`finance`.`cash_pool` ALTER COLUMN `cash_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Pool Identifier');
ALTER TABLE `food_beverage_ecm`.`finance`.`cash_pool` ALTER COLUMN `parent_cash_pool_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`cash_pool` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`cash_pool` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`cash_pool` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`cash_pool` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`cash_pool` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`cash_pool` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`netting_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`netting_run` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `food_beverage_ecm`.`finance`.`netting_run` ALTER COLUMN `netting_run_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Run Identifier');
ALTER TABLE `food_beverage_ecm`.`finance`.`netting_run` ALTER COLUMN `reversal_netting_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `parent_party_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`finance`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
