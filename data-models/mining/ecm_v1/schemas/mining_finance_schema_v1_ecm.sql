-- Schema for Domain: finance | Business: Mining | Version: v1_ecm
-- Generated on: 2026-05-05 10:54:39

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`finance` COMMENT 'Owns all financial management data including general ledger, cost centre accounting, CAPEX/OPEX budgeting, AISC and C1 cash cost reporting, NPV/IRR project valuations, DCF models, and IFRS 6 exploration accounting. Supports external regulatory financial disclosures via SAP FI/CO.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`cost_centre` (
    `cost_centre_id` BIGINT COMMENT 'Unique surrogate key identifying each cost centre record in the Silver Layer lakehouse. Primary key for the cost_centre master data product.',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Cost centres roll up to profit centres in the organizational hierarchy. The profit_centre_code should be replaced with FK to profit_centre.profit_centre_id to enable joining to profit centre master da',
    `activity_type` STRING COMMENT 'The primary activity type associated with this cost centre for activity-based costing (e.g., DRILL_HOURS, HAUL_TONNES, PROCESS_TONNES, MAINT_HOURS). Drives per-tonne and per-hour cost rate calculations feeding C1 cash cost build-up. Corresponds to SAP CO activity type (LSTAR). [ENUM-REF-CANDIDATE: DRILL_HOURS|HAUL_TONNES|PROCESS_TONNES|MAINT_HOURS|BLAST_METRES|LAB_SAMPLES|ADMIN_HOURS — promote to reference product]',
    `aisc_component` STRING COMMENT 'Classification of this cost centres costs within the World Gold Council All-In Sustaining Cost (AISC) framework components. Enables automated AISC cost build-up from cost centre actuals. gna = General and Administrative costs. [ENUM-REF-CANDIDATE: mining|processing|gna|royalties|sustaining_capex|reclamation|other — 7 candidates stripped; promote to reference product]',
    `allocation_method` STRING COMMENT 'Method used to allocate or distribute costs from this cost centre to receiving cost objects. direct — costs charged directly; assessment — allocated via SAP CO assessment cycle; distribution — allocated via SAP CO distribution cycle; activity_allocation — allocated based on activity quantities; none — no secondary allocation performed.. Valid values are `direct|assessment|distribution|activity_allocation|none`',
    `budget_annual` DECIMAL(18,2) COMMENT 'Total approved annual budget allocated to this cost centre for the current fiscal year, expressed in the cost centres reporting currency. Used as the baseline for monthly budget vs. actual variance reporting and OPEX/CAPEX governance.',
    `budget_fiscal_year` STRING COMMENT 'The fiscal year (e.g., 2024) to which the annual budget amount applies. Enables year-on-year budget comparison and multi-year LOM cost planning.',
    `business_area_code` STRING COMMENT 'SAP FI business area associated with this cost centre, used for cross-company-code reporting and segment-level balance sheet preparation.. Valid values are `^[A-Z0-9]{1,4}$`',
    `c1_cost_component` STRING COMMENT 'Classification of this cost centre within the Brook Hunt / CRU C1 cash cost methodology components. Enables automated C1 per-pound or per-tonne cost build-up from cost centre actuals for commodity benchmarking. [ENUM-REF-CANDIDATE: mining|processing|site_admin|transport|royalties|treatment_refining|excluded — 7 candidates stripped; promote to reference product]',
    `commodity` STRING COMMENT 'The primary mineral commodity produced or supported by this cost centre (e.g., iron_ore, copper, lithium). Enables commodity-level cost disaggregation for C1 cash cost and AISC reporting by product. [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|silver|other — 8 candidates stripped; promote to reference product]',
    `company_code` STRING COMMENT 'SAP FI company code representing the legal entity to which this cost centre is assigned for statutory financial reporting and IFRS consolidation purposes.. Valid values are `^[A-Z0-9]{1,4}$`',
    `controlling_area_code` STRING COMMENT 'SAP CO controlling area to which this cost centre belongs, defining the organisational scope for internal cost accounting and management reporting. Typically aligned to a legal entity or mining group.. Valid values are `^[A-Z0-9]{1,4}$`',
    `cost_centre_category` STRING COMMENT 'Classification of the cost centre by its primary function in the mining cost structure. production covers direct mining and processing activities contributing to AISC and C1 cash cost; service covers internal service providers (e.g., maintenance workshops); overhead covers indirect mine-site costs; administration covers corporate functions; investment covers CAPEX project cost centres.. Valid values are `production|service|overhead|administration|investment`',
    `cost_centre_code` STRING COMMENT 'The externally-known alphanumeric code assigned to the cost centre in SAP CO, used across all financial postings, purchase orders, and work orders to identify the responsible organisational unit. Aligns with SAP CO cost centre number (KOSTL).. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `cost_centre_name` STRING COMMENT 'Human-readable descriptive name of the cost centre (e.g., Pit 3 Drilling Operations, SAG Mill Processing, Corporate Finance). Corresponds to SAP CO KTEXT (short description) field.',
    `cost_centre_status` STRING COMMENT 'Current lifecycle status of the cost centre. active — open for postings; inactive — temporarily suspended; locked — blocked for new postings pending review; pending_approval — awaiting authorisation; closed — permanently decommissioned following mine closure or restructure.. Valid values are `active|inactive|locked|pending_approval|closed`',
    `cost_centre_type` STRING COMMENT 'Indicates whether the cost centre primarily captures Operating Expenditure (OPEX) or Capital Expenditure (CAPEX), or functions as a shared service or IFRS 6 exploration cost centre. Drives treatment in AISC and C1 cash cost calculations and IFRS 6 exploration accounting.. Valid values are `opex|capex|shared_service|exploration`',
    `cost_element_group` STRING COMMENT 'SAP CO cost element group assigned to this cost centre, defining which primary cost elements (e.g., labour, materials, energy, depreciation) are permissible for posting. Supports structured cost build-up for AISC and C1 reporting.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost centre master record was first created in the source SAP CO system. Provides audit trail for master data governance and change management.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost centres primary reporting currency (e.g., AUD, USD, ZAR). Determines the currency in which budgets, actuals, and cost rates are maintained in SAP CO.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Organisational department code to which this cost centre belongs (e.g., DRILL, BLAST, HAUL, PROCESS, MAINT, HSE, FINANCE). Supports departmental cost reporting and headcount allocation.. Valid values are `^[A-Z0-9_-]{1,10}$`',
    `functional_area` STRING COMMENT 'Broad functional classification of the cost centre within the mining value chain. Used for cross-site functional cost benchmarking and AISC component attribution (e.g., mining, processing, G&A). [ENUM-REF-CANDIDATE: mining|processing|exploration|maintenance|logistics|hse|administration|finance|sales|rehabilitation — promote to reference product]',
    `gl_account_group` STRING COMMENT 'SAP FI General Ledger (GL) account group associated with this cost centre, defining the chart of accounts range permissible for postings. Ensures correct financial statement classification under IFRS.. Valid values are `^[A-Z0-9_-]{1,10}$`',
    `hierarchy_area` STRING COMMENT 'The standard hierarchy node or cost centre group to which this cost centre belongs in SAP CO, defining its position in the organisational cost reporting tree (e.g., mine site > department > function). Feeds AISC and C1 per-tonne cost roll-up.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `is_statistical` BOOLEAN COMMENT 'Indicates whether this is a statistical cost centre used for reporting and allocation base purposes only, with no actual cost postings permitted. Statistical cost centres track quantities (e.g., tonnes mined) used as allocation bases for activity-based costing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this cost centre master record in SAP CO. Supports incremental data loading, change detection, and master data audit compliance.',
    `lock_indicator` BOOLEAN COMMENT 'Flag indicating whether this cost centre is locked against actual postings in SAP CO. When True, no new financial transactions can be posted. Corresponds to SAP CO SPERRZ field.',
    `long_description` STRING COMMENT 'Extended narrative description of the cost centres business purpose, scope of activities, and cost allocation rationale. Supports AISC and C1 cash cost build-up documentation.',
    `plant_code` STRING COMMENT 'SAP MM/PM plant code associated with this cost centre, linking cost accounting to physical plant operations for maintenance work orders, material consumption, and asset depreciation postings.. Valid values are `^[A-Z0-9]{1,4}$`',
    `responsible_manager` STRING COMMENT 'Full name of the manager accountable for costs posted to this cost centre. Used for budget accountability, variance reporting, and management sign-off on monthly cost reviews. Corresponds to SAP CO VERAK field.',
    `responsible_manager_personnel_no` STRING COMMENT 'SAP HR personnel number of the manager responsible for this cost centre, enabling system-driven workflow approvals, budget notifications, and organisational reporting linkage.. Valid values are `^[0-9]{1,8}$`',
    `site_code` STRING COMMENT 'Code identifying the mine site or operational facility to which this cost centre is physically or organisationally assigned (e.g., PILBARA01, OLYMPIC_DAM, CORP_PERTH). Enables site-level cost aggregation for AISC reporting.. Valid values are `^[A-Z0-9_-]{1,10}$`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this cost centre master record was sourced. Supports data lineage tracking in the Databricks Silver Layer lakehouse.. Valid values are `SAP_S4HANA|MANUAL|MIGRATION`',
    `user_responsible` STRING COMMENT 'SAP user ID of the person responsible for maintaining and updating this cost centre master record. Corresponds to SAP CO VERAK (user responsible) field for data stewardship.',
    `wbs_element` STRING COMMENT 'SAP PS Work Breakdown Structure (WBS) element linked to this cost centre for CAPEX project cost tracking. Applicable to investment cost centres supporting mine development, plant construction, or major sustaining capital projects.. Valid values are `^[A-Z0-9._-]{1,24}$`',
    `valid_from` DATE COMMENT 'The date from which this cost centre is active and available for financial postings in SAP CO. Corresponds to SAP CO DATAB (valid from) field. Supports Life of Mine (LOM) planning and project phase cost tracking.',
    `valid_to` DATE COMMENT 'The date after which this cost centre is no longer active for financial postings. Corresponds to SAP CO DATBI (valid to) field. Null indicates an open-ended cost centre with no planned closure date.',
    CONSTRAINT pk_cost_centre PRIMARY KEY(`cost_centre_id`)
) COMMENT 'Master register of SAP CO cost centres used to track and allocate operational and capital expenditure across mine sites, processing plants, and corporate functions. Each cost centre captures responsible manager, organisational hierarchy position, activity type, valid-from/to dates, and cost centre category (production, service, overhead). Provides the cost allocation hierarchy feeding AISC and C1 cash cost calculations and supports activity-based costing for per-tonne cost build-up.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`general_ledger_account` (
    `general_ledger_account_id` BIGINT COMMENT 'Unique surrogate identifier for the GL account record in the Databricks Silver Layer. Primary key for this data product.',
    `account_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the GL account (SAP WAERS). Mining enterprises operating across multiple jurisdictions (Australia, USA, Canada, South Africa) may maintain accounts in local currencies (AUD, USD, CAD, ZAR) with group currency translation.. Valid values are `^[A-Z]{3}$`',
    `account_group` STRING COMMENT 'SAP account group (KTOKS) that controls the number range and field selection for the GL account. Groups accounts by functional category (e.g., revenue, OPEX, CAPEX, exploration, balance sheet). [ENUM-REF-CANDIDATE: revenue|opex|capex|exploration|balance_sheet|intercompany|tax|depreciation|provisions — promote to reference product]',
    `account_long_description` STRING COMMENT 'Extended description of the GL account providing full business context, including the nature of costs or revenues captured (e.g., OPEX — Drill and Blast Consumables — Open Pit). Supports financial reporting and audit.',
    `account_name` STRING COMMENT 'Short descriptive name of the GL account as defined in the chart of accounts (SAP field TXT20/TXT50). Used in financial reports, trial balances, and cost postings across mining operations.',
    `account_number` STRING COMMENT 'The externally-known SAP GL account number (SAKNR) from the chart of accounts, uniquely identifying the account within the company code. Used in all journal entries and cost postings across the mining enterprise.. Valid values are `^[0-9]{1,10}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the GL account. Active accounts accept postings; inactive accounts are retained for historical reporting; blocked accounts are temporarily suspended; accounts marked for deletion are pending removal from the chart of accounts after period-end.. Valid values are `active|inactive|blocked|marked_for_deletion`',
    `account_type` STRING COMMENT 'SAP account type (GVTYP) classifying the GL account as balance sheet or profit and loss. Determines how the account is treated during fiscal year-end closing and financial statement preparation.. Valid values are `balance_sheet|profit_and_loss|nonoperating_expense|nonoperating_income`',
    `aisc_cost_category` STRING COMMENT 'Mapping of the GL account to the World Gold Council AISC cost category framework, enabling AISC and C1 cash cost reporting. Categories include mining, processing, site G&A, sustaining CAPEX, royalties, and by-product credits. Used for commodity cost benchmarking across iron ore, copper, coal, lithium, and nickel operations. [ENUM-REF-CANDIDATE: c1_mining|c1_processing|c1_site_ga|royalties|by_product_credits|sustaining_capex|corporate_ga|reclamation — promote to reference product]',
    `alternative_account_number` STRING COMMENT 'SAP alternative account number (ALTKT) from a country-specific or group chart of accounts. Used in mining companies operating across multiple jurisdictions to map local statutory accounts to the group chart of accounts for consolidated IFRS reporting.',
    `balance_sheet_category` STRING COMMENT 'For balance sheet GL accounts, the IFRS balance sheet category (e.g., property plant and equipment, mineral rights, exploration assets, inventory, provisions for rehabilitation). Supports IFRS financial statement presentation and mine closure liability accounting. [ENUM-REF-CANDIDATE: ppe|mineral_rights|exploration_assets|inventory|trade_receivables|trade_payables|rehabilitation_provision|deferred_tax — promote to reference product]',
    `changed_by_user` STRING COMMENT 'SAP user ID (USNAM) of the person who last modified this GL account master record. Required for SOX internal controls, financial audit trails, and segregation of duties compliance in the mining finance function.',
    `chart_of_accounts_code` STRING COMMENT 'SAP chart of accounts key (KTOPL) to which this GL account belongs. A mining enterprise may operate multiple charts of accounts across jurisdictions (e.g., Australian GAAP, IFRS, US GAAP for SEC reporting).. Valid values are `^[A-Z0-9]{1,4}$`',
    `commitment_management_flag` BOOLEAN COMMENT 'Indicates whether purchase order commitments and funds reservations are tracked against this GL account in SAP CO. When true, uncommitted CAPEX and OPEX budget balances are visible, supporting mine budget control and CAPEX approval workflows.',
    `company_code` STRING COMMENT 'SAP company code (BUKRS) to which this GL account is assigned. Represents the legal entity within the mining group (e.g., a specific mine site entity, holding company, or joint venture entity).. Valid values are `^[A-Z0-9]{1,4}$`',
    `cost_centre_relevance` BOOLEAN COMMENT 'Indicates whether postings to this GL account require a cost centre assignment in SAP CO. When true, all OPEX postings must be assigned to a cost centre (e.g., drill and blast, haulage, processing plant, maintenance) for mine cost centre accounting and AISC reporting.',
    `cost_element_category` STRING COMMENT 'SAP Controlling (CO) cost element category (KATYP) indicating whether this is a primary cost element (linked to a P&L GL account, e.g., OPEX, CAPEX) or a secondary cost element (internal allocations, activity types). Critical for mine cost centre accounting and AISC/C1 cash cost reporting.. Valid values are `primary|secondary`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this GL account record was first created in the source SAP FI system. Provides audit trail for chart of accounts governance and financial control compliance.',
    `deletion_flag` BOOLEAN COMMENT 'SAP deletion flag (XLOEV) indicating the GL account has been marked for deletion from the chart of accounts. Accounts with this flag set will be removed during the next chart of accounts reorganisation run. Retained for audit trail purposes.',
    `effective_from_date` DATE COMMENT 'The date from which this GL account became active and available for postings. Used to track the introduction of new accounts during chart of accounts restructuring, mine commissioning, or new project setup.',
    `effective_to_date` DATE COMMENT 'The date on which this GL account was deactivated or closed. Null for currently active accounts. Used to manage account lifecycle during mine closure, asset disposal, or chart of accounts rationalisation.',
    `expenditure_classification` STRING COMMENT 'Mining-specific classification of the GL account as Operating Expenditure (OPEX), Capital Expenditure (CAPEX), exploration expenditure (IFRS 6), rehabilitation provision, sustaining CAPEX, or growth CAPEX. Drives AISC and C1 cash cost reporting and LOM financial modelling.. Valid values are `opex|capex|exploration|rehabilitation|sustaining_capex|growth_capex`',
    `field_status_group` STRING COMMENT 'SAP field status group (FSTAG) controlling which fields are required, optional, or suppressed when posting to this GL account. Determines mandatory entry of cost centre, WBS element, profit centre, or other account assignment objects for mining cost control.. Valid values are `^G[0-9]{3}$`',
    `financial_statement_item` STRING COMMENT 'Classification of the GL account within the financial statement structure (e.g., Income Statement, Balance Sheet, Cash Flow Statement). Supports IFRS-compliant financial reporting and SEC S-K 1300 mining disclosure requirements. [ENUM-REF-CANDIDATE: income_statement|balance_sheet|cash_flow_operating|cash_flow_investing|cash_flow_financing|equity_statement — promote to reference product]',
    `functional_area` STRING COMMENT 'SAP functional area (FKBER) classifying the GL account by business function for segment reporting (e.g., mining operations, mineral processing, exploration, administration, sales). Supports IFRS 8 Operating Segments disclosure for mining companies. [ENUM-REF-CANDIDATE: mining_operations|mineral_processing|exploration|administration|sales_marketing|logistics|hse|rehabilitation — promote to reference product]',
    `ifrs6_exploration_flag` BOOLEAN COMMENT 'Indicates whether this GL account is designated for exploration and evaluation expenditure under IFRS 6. When true, costs posted to this account are subject to IFRS 6 impairment testing and disclosure requirements. Relevant for junior and major mining companies with active exploration programs.',
    `interest_calculation_flag` BOOLEAN COMMENT 'SAP interest calculation indicator (XZPMO) specifying whether interest is calculated on balances in this GL account. Relevant for intercompany loan accounts, rehabilitation provision accounts, and deferred tax accounts in mining group structures.',
    `last_changed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this GL account master record in SAP FI. Supports change management tracking, SOX compliance, and chart of accounts version control for the mining enterprise.',
    `line_item_display_flag` BOOLEAN COMMENT 'SAP line item display flag (XKRES) indicating whether individual journal entry line items are stored and displayable for this account. When true, full drill-down to individual postings is available, supporting audit and cost analysis for mining operations.',
    `open_item_management_flag` BOOLEAN COMMENT 'SAP open item management flag (XOPVW) indicating whether individual line items posted to this account must be cleared against each other (e.g., GR/IR clearing accounts, bank clearing accounts). Critical for accounts payable and procurement reconciliation in mining supply chain.',
    `planning_block_flag` BOOLEAN COMMENT 'Indicates whether cost planning is blocked for this GL account in SAP CO (XSPEP). When true, budget planning entries cannot be made against this account, used to control CAPEX and OPEX budget planning integrity.',
    `posting_block_flag` BOOLEAN COMMENT 'Indicates whether direct postings to this GL account are blocked (SAP XSPEB). When true, no journal entries can be posted to this account, typically used for accounts under review, year-end closing accounts, or accounts pending reclassification.',
    `profit_centre_relevance` BOOLEAN COMMENT 'Indicates whether postings to this GL account are relevant for SAP Profit Centre Accounting (PCA). When true, all postings are distributed to profit centres representing individual mine sites or commodity business units, enabling site-level profitability reporting.',
    `reconciliation_account_flag` BOOLEAN COMMENT 'Indicates whether this GL account is a reconciliation account (SAP XINTB) that is automatically updated from a subledger (accounts payable, accounts receivable, asset accounting). Reconciliation accounts cannot be posted to directly and are critical for financial integrity in mining ERP environments.',
    `rehabilitation_provision_flag` BOOLEAN COMMENT 'Indicates whether this GL account is used to record mine rehabilitation and closure provisions under IFRS IAS 37. Rehabilitation provision accounts are subject to annual actuarial review and are disclosed in the notes to financial statements and environmental impact statements.',
    `royalty_account_flag` BOOLEAN COMMENT 'Indicates whether this GL account is designated for recording mineral royalty payments to government or private landowners. Royalty accounts are separately tracked for AISC reporting, tax deductibility assessment, and regulatory disclosure under mining tenement agreements.',
    `sort_key` STRING COMMENT 'SAP sort key (ZUAWA) defining the default assignment field populated when posting to this GL account (e.g., document date, posting date, purchase order number, cost centre). Controls how line items are sorted in account statements and financial reports.. Valid values are `^[0-9]{3}$`',
    `tax_category` STRING COMMENT 'SAP tax category (MWSKZ) controlling whether the GL account is relevant for input tax (GST/VAT on purchases), output tax (GST/VAT on sales), or not tax-relevant. Critical for mining royalty and resource rent tax compliance across jurisdictions.. Valid values are `input_tax|output_tax|not_relevant|exempt`',
    `tolerance_group` STRING COMMENT 'SAP tolerance group (TOLGR) assigned to the GL account, defining acceptable variance limits for payment differences and clearing transactions. Used in accounts payable and receivable processing for mining procurement and commodity sales.',
    `wbs_element_relevance` BOOLEAN COMMENT 'Indicates whether postings to this GL account require a WBS element assignment in SAP PS (Project System). When true, costs must be assigned to a project WBS element, typically for CAPEX projects, mine development, or exploration programs tracked under IFRS 6.',
    CONSTRAINT pk_general_ledger_account PRIMARY KEY(`general_ledger_account_id`)
) COMMENT 'Chart of accounts master data sourced from SAP FI, defining every GL account used across the mining enterprise including revenue accounts, OPEX accounts, CAPEX accounts, exploration expenditure accounts (IFRS 6), and balance sheet accounts. Provides the financial classification backbone for all journal entries and cost postings.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`profit_centre` (
    `profit_centre_id` BIGINT COMMENT 'Unique identifier for the profit centre. Primary key.',
    `aisc_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this profit centre is included in All-In Sustaining Cost (AISC) reporting for external disclosures.',
    `business_area_code` STRING COMMENT 'The SAP business area code used for cross-company code reporting and segment analysis.. Valid values are `^[A-Z0-9]{4}$`',
    `c1_cost_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this profit centre reports C1 cash cost metrics for commodity margin analysis.',
    `closure_date` DATE COMMENT 'The date on which the profit centre was formally closed or decommissioned.',
    `commodity_type` STRING COMMENT 'The primary mineral commodity associated with this profit centre (e.g., iron ore, copper, coal, lithium, nickel). [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|silver|zinc|bauxite|other — 10 candidates stripped; promote to reference product]',
    `company_code` STRING COMMENT 'The SAP FI company code representing the legal entity to which this profit centre is assigned for financial reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area_code` STRING COMMENT 'The SAP Controlling Area to which this profit centre belongs. Controlling areas represent organizational units for cost and profit management.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_centre_group` STRING COMMENT 'The cost centre group or hierarchy to which this profit centres cost centres roll up for cost allocation and reporting.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the profit centre is domiciled (e.g., AUS, CAN, CHL).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this profit centre record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the profit centres local reporting currency (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `exploration_accounting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this profit centre applies IFRS 6 exploration and evaluation asset accounting.',
    `functional_currency_code` STRING COMMENT 'The functional currency as defined by IAS 21 for this profit centres primary economic environment.. Valid values are `^[A-Z]{3}$`',
    `geographic_region` STRING COMMENT 'The geographic region or jurisdiction where the profit centre operates (e.g., Western Australia, Queensland, South America).',
    `hierarchy_node` STRING COMMENT 'The hierarchical node or path representing this profit centres position in the organizational profit centre hierarchy.',
    `ifrs_segment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this profit centre is a reportable operating segment under IFRS 8.',
    `jorc_resource_category` STRING COMMENT 'The highest JORC resource classification category applicable to this profit centres mineral resources (measured, indicated, inferred), if the profit centre is a mine site.. Valid values are `measured|indicated|inferred|not_applicable`',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this profit centre record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this profit centre record was last updated or modified.',
    `lom_plan_reference` STRING COMMENT 'Reference identifier to the Life of Mine plan document or system record associated with this profit centre, if applicable.',
    `profit_centre_code` STRING COMMENT 'The externally-known alphanumeric code identifying the profit centre in SAP CO. Used for reporting and integration with external systems.. Valid values are `^[A-Z0-9]{4,10}$`',
    `profit_centre_description` STRING COMMENT 'Detailed description of the profit centres business scope, operations, and responsibilities.',
    `profit_centre_name` STRING COMMENT 'The full business name of the profit centre (e.g., Iron Ore Mine Site A, Copper Processing Plant B, Lithium Business Unit).',
    `profit_centre_status` STRING COMMENT 'Current lifecycle status of the profit centre indicating whether it is operational, suspended, or closed.. Valid values are `active|inactive|suspended|closed|planned`',
    `profit_centre_type` STRING COMMENT 'Classification of the profit centre by operational function (e.g., mine site, processing plant, commodity business unit, corporate function, exploration division, logistics hub).. Valid values are `mine_site|processing_plant|commodity_business_unit|corporate_function|exploration_division|logistics_hub`',
    `reserve_category` STRING COMMENT 'The ore reserve classification (proved or probable) for this profit centres economically mineable reserves, per JORC or equivalent standards.. Valid values are `proved|probable|not_applicable`',
    `segment_code` STRING COMMENT 'The operating segment code aligned to IFRS 8 segment reporting requirements. Used for external financial disclosures.. Valid values are `^[A-Z0-9]{4,10}$`',
    `short_name` STRING COMMENT 'Abbreviated name or acronym for the profit centre used in reports and dashboards.',
    `valid_from_date` DATE COMMENT 'The date from which this profit centre became active and operational for financial reporting.',
    `valid_to_date` DATE COMMENT 'The date until which this profit centre is valid. Null for open-ended profit centres.',
    CONSTRAINT pk_profit_centre PRIMARY KEY(`profit_centre_id`)
) COMMENT 'SAP CO profit centre master representing autonomous business units within the mining group (e.g., individual mine sites, commodity business units, processing operations) used for internal profitability reporting. Enables segment-level P&L reporting aligned to IFRS 8 operating segments and commodity-level margin analysis.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'Unique identifier for the WBS element. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Foreign key reference to the parent project definition under which this WBS element is organized.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key reference to the default cost centre for posting costs when this WBS element is used for account assignment.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee or contractor who is the accountable project manager or work package owner for this WBS element.',
    `parent_wbs_element_id` BIGINT COMMENT 'Foreign key reference to the parent WBS element in the hierarchical structure. Null for top-level WBS elements.',
    `profit_centre_id` BIGINT COMMENT 'Foreign key reference to the profit centre for internal profitability analysis and segment reporting.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'The cumulative actual costs posted to this WBS element from invoices, payroll, material issues, and other financial transactions. Used for spend tracking and CAPEX reporting.',
    `actual_end_date` DATE COMMENT 'The actual date when work on this WBS element was completed. Null if work is still in progress. Used for project closure and lessons learned analysis.',
    `actual_start_date` DATE COMMENT 'The actual date when work commenced on this WBS element. Used for schedule variance analysis and project performance reporting.',
    `applicant_name` STRING COMMENT 'The name of the person or department who requested or initiated the project or work package represented by this WBS element.',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'The total approved budget allocated to this WBS element, representing the authorized spending limit for CAPEX or OPEX. Critical for financial control and variance analysis.',
    `asset_under_construction_flag` BOOLEAN COMMENT 'Boolean flag indicating whether costs posted to this WBS element are capitalized as an Asset Under Construction per IFRS 16 and IAS 16. True for CAPEX projects that will be settled to fixed assets, false for OPEX or expensed projects.',
    `committed_cost_amount` DECIMAL(18,2) COMMENT 'The total value of purchase orders, contracts, and other commitments issued against this WBS element but not yet invoiced. Used for funds reservation and cash flow forecasting.',
    `commodity_type` STRING COMMENT 'The primary mineral commodity associated with this WBS element project: iron_ore, copper, coal, lithium, nickel, gold, or other. Used for commodity-specific CAPEX tracking and All-In Sustaining Cost (AISC) allocation. [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|other — 7 candidates stripped; promote to reference product]',
    `company_code` STRING COMMENT 'The SAP company code (legal entity) to which this WBS element belongs. Used for financial consolidation and IFRS reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area` STRING COMMENT 'The SAP controlling area for management accounting and cost control purposes.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this WBS element record was first created in SAP PS.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all financial values associated with this WBS element (budget, actuals, commitments).. Valid values are `^[A-Z]{3}$`',
    `functional_area` STRING COMMENT 'The operational functional area this WBS element supports: mining operations, mineral processing, exploration programs, infrastructure development, mine rehabilitation, or logistics and supply chain.. Valid values are `mining|processing|exploration|infrastructure|rehabilitation|logistics`',
    `ifrs6_exploration_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this WBS element represents exploration and evaluation expenditure subject to IFRS 6 accounting treatment. True for pre-feasibility exploration programs, false for development or production projects.',
    `investment_program` STRING COMMENT 'The strategic investment program or portfolio to which this WBS element belongs (e.g., Mine Expansion 2024, Sustaining Capital FY25, Exploration Campaign Q3). Used for portfolio-level CAPEX tracking and NPV/IRR analysis.',
    `jorc_reserve_category` STRING COMMENT 'The JORC Code reserve classification associated with the ore body or resource being developed by this project: proved (highest confidence), probable (lower confidence), or not_applicable for non-mining projects. Used for reserve reporting and SEC S-K 1300 compliance.. Valid values are `proved|probable|not_applicable`',
    `last_modified_by` STRING COMMENT 'The SAP user ID of the person who last updated this WBS element record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this WBS element record was last modified in SAP PS.',
    `mine_site_code` STRING COMMENT 'The unique code identifying the mine site or operational location where this WBS element work is being performed (e.g., IRONORE01, COPPERMINE02). Used for site-level CAPEX and OPEX aggregation.. Valid values are `^[A-Z0-9]{3,10}$`',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'The initial budget amount approved at project inception, before any subsequent budget revisions or supplements. Used for baseline variance reporting.',
    `planned_end_date` DATE COMMENT 'The scheduled completion date for this WBS element. Used for milestone tracking and LOM financial planning.',
    `planned_start_date` DATE COMMENT 'The scheduled start date for work on this WBS element, as defined in the project plan. Used for Life of Mine (LOM) scheduling and resource planning.',
    `planning_plant` STRING COMMENT 'The SAP plant code representing the physical mine site, processing facility, or operational location where the work will be performed.. Valid values are `^[A-Z0-9]{4}$`',
    `project_category` STRING COMMENT 'High-level classification of the project type: CAPEX (Capital Expenditure) for mine development and plant construction, OPEX (Operating Expenditure) for sustaining activities, exploration for resource discovery programs, rehabilitation for mine closure works, sustaining for ongoing maintenance capital, or expansion for growth projects.. Valid values are `capex|opex|exploration|rehabilitation|sustaining|expansion`',
    `settlement_rule_exists` BOOLEAN COMMENT 'Boolean flag indicating whether a settlement rule has been configured to allocate costs from this WBS element to assets, cost centres, or other receivers. True if settlement is configured, false otherwise.',
    `system_status` STRING COMMENT 'The SAP system-controlled status of the WBS element lifecycle: created (initial), released (active for posting), technically_completed (work finished but financially open), closed (final settlement complete), or locked (posting blocked).. Valid values are `created|released|technically_completed|closed|locked`',
    `user_status` STRING COMMENT 'User-defined status field for business-specific workflow states (e.g., awaiting_approval, in_execution, on_hold, under_review). Configurable per company requirements.',
    `wbs_element_code` STRING COMMENT 'The externally-known alphanumeric code identifying the WBS element in SAP PS. Typically hierarchical (e.g., P-12345.01.02). Used in all project reporting and cost allocation.. Valid values are `^[A-Z0-9-.]{1,24}$`',
    `wbs_element_description` STRING COMMENT 'Full business description of the WBS element, detailing the scope of work, deliverable, or project phase it represents.',
    `wbs_element_type` STRING COMMENT 'Classification of the WBS element by its functional purpose: planning (for scheduling), account_assignment (for cost posting), billing (for revenue recognition), or statistical (for reporting only).. Valid values are `planning|account_assignment|billing|statistical`',
    `wbs_level` STRING COMMENT 'The hierarchical level of this WBS element within the project structure. Level 1 is the top-level project, subsequent levels represent sub-phases or work packages.',
    `created_by` STRING COMMENT 'The SAP user ID of the person who created this WBS element record in the system.',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Work Breakdown Structure element master from SAP PS representing the hierarchical project cost structure for CAPEX projects including mine development, plant construction, exploration programs, and rehabilitation works. Each WBS element captures approved budget, committed costs, actual spend, and project phase classification. Critical for CAPEX tracking and LOM financial planning.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry header record in the general ledger system. Primary key for all financial postings.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Journal entries can be cost centre specific for management accounting. The cost_center code should be replaced with FK to cost_centre.cost_centre_id to enable joining to cost centre master data.',
    `employee_id` BIGINT COMMENT 'The SAP user ID of the person who created this journal entry. Used for audit trail, segregation of duties monitoring, and user activity analysis.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.processing_plant. Business justification: Plant-specific journal entries (accruals, inventory adjustments, depreciation) reference the plant for cost centre derivation and financial reporting. Enables plant-level P&L and balance sheet reporti',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Journal entries can be profit centre specific for segment reporting. The profit_center code should be replaced with FK to profit_centre.profit_centre_id to enable joining to profit centre master data.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Journal entries can be project-related and posted to WBS elements. The wbs_element code should be replaced with FK to wbs_element.wbs_element_id to enable joining to project master data.',
    `asset_number` STRING COMMENT 'The fixed asset number when this journal entry relates to asset accounting transactions (acquisitions, depreciation, retirements). Links to the asset register for CAPEX capitalization and depreciation tracking.',
    `asset_subnumber` STRING COMMENT 'The subnumber of the fixed asset for tracking components or sub-assets within a main asset. Used for detailed asset lifecycle management.',
    `business_area` STRING COMMENT 'The business area for cross-company code reporting. Represents business segments that span multiple legal entities, such as global copper operations or integrated iron ore value chain.',
    `clearing_date` DATE COMMENT 'The date on which this journal entry was cleared. Populated when open items are settled. Used for aging analysis and cash flow reporting.',
    `clearing_document_number` STRING COMMENT 'The document number of the clearing entry if this journal entry has been cleared (e.g., invoice cleared by payment). Used for open item management and reconciliation.',
    `company_code` STRING COMMENT 'The legal entity or company code within the mining group to which this journal entry belongs. Represents the smallest organizational unit for which a complete self-contained set of accounts can be drawn up for external reporting purposes.. Valid values are `^[A-Z0-9]{4}$`',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this journal entry was originally posted (e.g., USD, AUD, CAD, CLP for Chilean Peso, ZAR for South African Rand). All line items in this entry share this currency.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date printed on the original source document (invoice, receipt, contract). May differ from posting date. Used for document tracking and audit purposes.',
    `document_header_text` STRING COMMENT 'Free-form text description at the header level providing context for this journal entry. Used for explanatory notes, period-end adjustments, and manual posting descriptions.',
    `document_number` STRING COMMENT 'The externally-known unique document number assigned by SAP FI to this journal entry. Used for audit trails and cross-system reconciliation.. Valid values are `^[A-Z0-9]{10}$`',
    `document_type` STRING COMMENT 'Classifies the journal entry by its business purpose: SA (General Ledger Document), AB (Accounting Document), KR (Vendor Invoice), DR (Customer Invoice), DZ (Payment Document), KA (Customer Document), KG (Vendor Credit Memo), KN (Net Customer Document), KZ (Payment Request), RE (Invoice Receipt), RV (Transfer Posting), WA (Goods Issue), WE (Goods Receipt), ZP (Payment Posting). Controls number ranges and posting rules. [ENUM-REF-CANDIDATE: SA|AB|KR|DR|DZ|KA|KG|KN|KZ|RE|RV|WA|WE|ZP — 14 candidates stripped; promote to reference product]',
    `entry_date` DATE COMMENT 'The calendar date when this journal entry was physically entered into the SAP system. Used for audit trail and user activity tracking.',
    `entry_time` TIMESTAMP COMMENT 'The time of day when this journal entry was entered into the system. Stored in HH:MM:SS format. Used for detailed audit trails.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate used to convert the document currency to the company code local currency at the time of posting. Used for multi-currency consolidation and reporting.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when this journal entry was posted. Typically 1-12 for regular periods, 13-16 for special closing periods.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this journal entry is posted. Used for period-based financial reporting and IFRS compliance.',
    `functional_area` STRING COMMENT 'The functional area for cost-of-sales accounting. Classifies costs by function: mining operations, processing, logistics, sales and marketing, administration. Used for functional P&L presentation under IFRS.',
    `intercompany_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry represents an intercompany transaction between different company codes within the mining group. True for intercompany postings requiring elimination entries during consolidation.',
    `internal_order` STRING COMMENT 'The internal order number for tracking specific cost collection objects such as maintenance campaigns, exploration programs, or overhead cost pools. Used for detailed OPEX analysis.',
    `ledger_group` STRING COMMENT 'Identifies the ledger to which this entry is posted: 0L (Leading Ledger - IFRS), 1L (Local GAAP), 2L (Management Reporting), 3L (Tax Ledger), 9L (Consolidation Ledger). Supports parallel accounting under IFRS and local standards.. Valid values are `0L|1L|2L|3L|9L`',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The total amount of this journal entry converted to the company code local currency using the exchange rate. Used for statutory financial statements and IFRS reporting.',
    `local_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code of the company codes local currency. All amounts are converted to this currency for statutory reporting.. Valid values are `^[A-Z]{3}$`',
    `material_number` STRING COMMENT 'The material master number when this journal entry relates to inventory movements, ROM stockpile valuations, or concentrate sales. Links to material master for commodity tracking.',
    `parked_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry is parked (saved but not yet posted). True for parked documents awaiting approval, False for posted documents. Used for workflow and approval processes.',
    `posting_date` DATE COMMENT 'The date on which this journal entry was posted to the general ledger. This is the accounting date that determines which fiscal period the entry affects. Critical for period-end close and financial statement preparation.',
    `posting_key` STRING COMMENT 'Two-digit code that controls the type of posting at the line item level: 01-49 (Debit postings), 50-99 (Credit postings). Determines account type, debit/credit indicator, and field status.. Valid values are `^[0-9]{2}$`',
    `reference_document_number` STRING COMMENT 'External reference number from the source document (purchase order, invoice, contract). Used to link journal entries back to originating business transactions.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry is a reversal of a previous posting. True if this entry reverses another entry, False otherwise. Used for accrual reversals and error corrections.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for reversing the original entry: 01 (Reversal in Current Period), 02 (Reversal in Next Period), 03 (Incorrect Posting), 04 (Accrual Reversal), 05 (Other). Used for financial control and audit purposes.. Valid values are `01|02|03|04|05`',
    `reversed_document_number` STRING COMMENT 'The document number of the original journal entry that this entry reverses. Populated only when reversal_indicator is True. Maintains audit trail for reversed transactions.',
    `trading_partner_company_code` STRING COMMENT 'The company code of the intercompany trading partner when intercompany_indicator is True. Used for intercompany reconciliation and consolidation elimination entries.',
    `transaction_currency_amount` DECIMAL(18,2) COMMENT 'The total amount of this journal entry in the original transaction currency. Sum of all debit or credit line items in document currency.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'SAP FI journal entry header representing every financial posting in the general ledger including accruals, reversals, intercompany eliminations, IFRS 6 exploration capitalisation entries, and period-end adjustments. Captures document type, posting date, fiscal period, company code, and reference document. The primary transactional record for all financial movements.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for the journal entry line product.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Journal entry lines can be cost centre specific for management accounting. The cost_centre_code should be replaced with FK to cost_centre.cost_centre_id to enable joining to cost centre master data.',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Every journal entry line posts to a GL account. The gl_account_code should be replaced with FK to general_ledger_account.general_ledger_account_id to enable joining to account master data including ac',
    `journal_entry_id` BIGINT COMMENT 'Foreign key reference to the parent journal entry header. Links this line item to its containing journal entry document.',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Journal entry lines can be profit centre specific for segment reporting. The profit_centre_code should be replaced with FK to profit_centre.profit_centre_id to enable joining to profit centre master d',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Journal entry lines can be project-related and posted to WBS elements. The wbs_element_code should be replaced with FK to wbs_element.wbs_element_id to enable joining to project master data.',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'The monetary amount of the line item converted to the local reporting currency of the operating entity. Used for consolidated financial reporting.',
    `amount_transaction_currency` DECIMAL(18,2) COMMENT 'The monetary amount of the line item in the original transaction currency. Represents the value before any currency conversion.',
    `asset_number` STRING COMMENT 'The fixed asset number for asset-related postings (CAPEX, depreciation, disposals). Links the line item to a specific asset in the asset register.. Valid values are `^[A-Z0-9]{6,12}$`',
    `asset_subnumber` STRING COMMENT 'The subnumber identifying a specific component or sub-asset within a main asset. Used for detailed asset tracking and partial disposals.. Valid values are `^[0-9]{1,4}$`',
    `assignment_text` STRING COMMENT 'Free-form text field for additional assignment or reference information. Often used to capture invoice numbers, purchase order references, or other cross-reference identifiers.',
    `baseline_date` DATE COMMENT 'The baseline date from which payment terms are calculated. Determines the due date for payment or receipt of funds.',
    `business_area_code` STRING COMMENT 'The business area code representing a distinct line of business or commodity type (e.g., iron ore, copper, coal). Enables financial reporting by business segment.. Valid values are `^[A-Z0-9]{2,4}$`',
    `clearing_date` DATE COMMENT 'The date when this line item was cleared or settled against another document. Null if the item remains open.',
    `clearing_document_number` STRING COMMENT 'The document number of the clearing document that settled this line item. Provides traceability to payment or receipt transactions.. Valid values are `^[0-9]{10}$`',
    `customer_code` STRING COMMENT 'The customer master code for accounts receivable postings. Identifies the buyer or customer associated with this line item.. Valid values are `^[A-Z0-9]{6,10}$`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this line item is a debit (D) or credit (C) posting. Fundamental accounting classification for double-entry bookkeeping.. Valid values are `D|C`',
    `functional_area_code` STRING COMMENT 'The functional area code representing the business function (e.g., mining, processing, logistics, administration). Used for cost of sales and functional expense reporting.. Valid values are `^[A-Z0-9]{2,4}$`',
    `internal_order_number` STRING COMMENT 'The internal order number for cost collection and allocation. Used for tracking specific cost objects such as maintenance campaigns or exploration programs.. Valid values are `^[A-Z0-9]{6,12}$`',
    `line_item_text` STRING COMMENT 'Descriptive text providing additional detail about the nature or purpose of this line item posting. Enhances auditability and understanding of the transaction.',
    `line_number` STRING COMMENT 'Sequential line item number within the journal entry document. Determines the ordering of line items within a single journal entry.',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the local reporting currency (e.g., USD, AUD). Identifies the currency used for statutory and management reporting.. Valid values are `^[A-Z]{3}$`',
    `material_number` STRING COMMENT 'The material master number for inventory-related postings. Links the line item to a specific material or commodity (e.g., iron ore concentrate, diesel fuel, reagents).. Valid values are `^[A-Z0-9]{6,18}$`',
    `payment_terms_code` STRING COMMENT 'The payment terms code defining the due date calculation and discount conditions. Critical for cash flow forecasting and working capital management.. Valid values are `^[A-Z0-9]{2,4}$`',
    `posted_timestamp` TIMESTAMP COMMENT 'The date and time when this line item was posted to the general ledger. Critical for audit trail and financial period cutoff verification.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of material or units associated with this line item. Used for inventory valuation and unit cost calculations.',
    `reference_key_1` STRING COMMENT 'First reference key field for linking to source documents or external systems. Commonly used for invoice numbers, contract references, or shipment identifiers.',
    `reference_key_2` STRING COMMENT 'Second reference key field for additional cross-referencing. Provides flexibility for multi-dimensional traceability to source transactions.',
    `reference_key_3` STRING COMMENT 'Third reference key field for extended cross-referencing requirements. Supports complex traceability scenarios across multiple systems.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversal document that reversed this line item. Null if the item has not been reversed.. Valid values are `^[0-9]{10}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this line item has been reversed. True if the posting has been reversed by a subsequent reversal document.',
    `tax_amount_local_currency` DECIMAL(18,2) COMMENT 'The calculated tax amount for this line item in local currency. Derived from the tax code and base amount.',
    `tax_code` STRING COMMENT 'The tax code applied to this line item. Determines the tax treatment, rate, and GL accounts for tax posting (e.g., GST, VAT, sales tax).. Valid values are `^[A-Z0-9]{2,4}$`',
    `trading_partner_code` STRING COMMENT 'The trading partner code for intercompany transactions. Identifies the counterparty legal entity within the corporate group for consolidation and elimination purposes.. Valid values are `^[A-Z0-9]{4,10}$`',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction currency (e.g., USD, AUD, EUR). Identifies the currency in which the original transaction was denominated.. Valid values are `^[A-Z]{3}$`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity field (e.g., MT for metric tonnes, L for litres, KG for kilograms). Standardizes quantity reporting across materials.. Valid values are `^[A-Z]{2,3}$`',
    `value_date` DATE COMMENT 'The value date for cash management and liquidity planning. Represents the effective date when funds are available or debited.',
    `vendor_code` STRING COMMENT 'The vendor master code for accounts payable postings. Identifies the supplier or contractor associated with this line item.. Valid values are `^[A-Z0-9]{6,10}$`',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit and credit line items within a SAP FI journal entry, capturing GL account, cost centre, profit centre, WBS element, amount in transaction and local currency, tax code, and assignment text. Provides the granular financial posting detail required for cost allocation, AISC calculation, and regulatory financial reporting.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`capex_budget` (
    `capex_budget_id` BIGINT COMMENT 'Unique surrogate identifier for each CAPEX budget record in the silver layer lakehouse. Primary key for the capex_budget data product.',
    `asset_class_id` BIGINT COMMENT 'FK to equipment.asset_class',
    `capital_project_id` BIGINT COMMENT 'FK to project.capital_project',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: CAPEX budgets are tracked and reported by cost centre. The cost_centre_code should be replaced with FK to cost_centre.cost_centre_id to enable joining to cost centre master data including hierarchy, r',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: CAPEX budgets post to specific GL accounts in the chart of accounts. The gl_account_code should be replaced with FK to general_ledger_account.general_ledger_account_id to enable joining to account mas',
    `mine_site_id` BIGINT COMMENT 'FK to mine.mine_site',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.processing_plant. Business justification: Capital budgets are allocated to specific processing plants for expansion, sustaining capex, and asset replacement projects. Enables plant-level capex tracking, project portfolio management, and capit',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: CAPEX budgets should be allocated to profit centres for investment planning and approval by business segment. Opex_budget already has profit_centre_id; capex_budget should have the same dimension for ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: CAPEX budgets are allocated to WBS elements in SAP PS. The wbs_element_code should be replaced with a proper FK to wbs_element.wbs_element_id for referential integrity and to enable joining to WBS hie',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure posted to this WBS element in SAP FI/CO as at the reporting date. Represents invoiced and goods-receipted costs capitalised to the asset under construction.',
    `aisc_contribution_usd` DECIMAL(18,2) COMMENT 'The sustaining CAPEX component of this budget expressed in USD per unit of production, contributing to the AISC metric reported to investors. Applies only to sustaining capital categories per World Gold Council AISC guidance.',
    `approval_authority` STRING COMMENT 'The delegated authority level that approved this CAPEX budget, reflecting the companys capital delegation of authority (DOA) framework. Determines the governance tier for audit and compliance purposes.. Valid values are `Board|Executive Committee|CFO|General Manager|Site Manager`',
    `approval_date` DATE COMMENT 'Date on which the CAPEX budget was formally approved by the board or delegated capital authority. Required for capital governance audit trails and regulatory financial disclosures.',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Original board-approved CAPEX budget amount for this WBS element in the reporting currency. Represents the baseline capital allocation against which variances are measured.',
    `budget_revision_number` STRING COMMENT 'Sequential revision number indicating how many times the original approved budget has been formally revised (0 = original approval, 1 = first revision, etc.). Supports audit trail of capital budget changes.',
    `budget_status` STRING COMMENT 'Current workflow status of the CAPEX budget record. Tracks the approval lifecycle from initial draft through board approval, revision cycles, and project closure.. Valid values are `Draft|Submitted|Approved|Revised|Closed|Cancelled`',
    `capex_category` STRING COMMENT 'Classification of the CAPEX type: Sustaining (maintaining existing assets), Growth (expanding capacity), Exploration (IFRS 6 qualifying expenditure), Rehabilitation (mine closure obligations), or IT (technology infrastructure). Drives AISC reporting and NPV/IRR modelling.. Valid values are `Sustaining|Growth|Exploration|Rehabilitation|IT`',
    `capitalisation_date` DATE COMMENT 'Date on which the asset under construction is expected to be or was transferred to a fixed asset and capitalised in SAP AM. Triggers commencement of depreciation under IAS 16.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total value of purchase orders and contracts committed against this CAPEX budget line in SAP MM/PS. Represents legally obligated spend not yet invoiced. Critical for available budget calculation.',
    `contingency_amount` DECIMAL(18,2) COMMENT 'Contingency allowance included within the approved budget to cover unforeseen scope, geotechnical, or market risks. Reported separately to the board to distinguish base estimate from risk provision.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CAPEX budget record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this budget record (e.g., AUD, USD, ZAR). Supports multi-currency capital reporting for international mining operations.. Valid values are `^[A-Z]{3}$`',
    `discount_rate_pct` DECIMAL(18,2) COMMENT 'Weighted average cost of capital (WACC) or hurdle rate applied in the DCF model for NPV calculation, expressed as a percentage. Approved by the board for capital project evaluation.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert budget amounts from the transaction currency to the group reporting currency (e.g., USD to AUD). Sourced from SAP FI exchange rate tables at the time of budget approval.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month 1–12) within the fiscal year for which this budget line applies. Supports monthly capital phasing and cash flow forecasting in SAP CO.',
    `fiscal_year` STRING COMMENT 'The fiscal year (e.g., 2024) for which this CAPEX budget is approved and tracked. Aligns with the companys financial reporting calendar in SAP FI.',
    `forecast_at_completion_amount` DECIMAL(18,2) COMMENT 'Total projected cost at project completion, calculated as actual spend plus forecast to complete. Key metric for capital overrun/underrun reporting to the board and NPV/IRR sensitivity analysis.',
    `forecast_to_complete_amount` DECIMAL(18,2) COMMENT 'Estimated remaining expenditure required to complete the project scope from the current reporting date. Used in earned value management and LOM capital cash flow forecasting.',
    `irr_pct` DECIMAL(18,2) COMMENT 'Internal Rate of Return of the capital project expressed as a percentage, derived from the approved DCF model. Used alongside NPV for capital project ranking and board investment approval.',
    `is_lom_capital` BOOLEAN COMMENT 'Indicates whether this CAPEX budget line is included in the approved Life of Mine capital plan. True = included in LOM plan; False = ad hoc or supplementary capital not in the LOM baseline.',
    `is_sustaining_capex` BOOLEAN COMMENT 'Indicates whether this budget is classified as sustaining CAPEX for AISC reporting purposes per World Gold Council guidance. True = sustaining capital included in AISC; False = growth or non-sustaining capital.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this CAPEX budget record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for incremental data loading and change tracking in the silver layer.',
    `lom_plan_year` STRING COMMENT 'The Life of Mine plan year in which this CAPEX budget is scheduled, enabling alignment of capital expenditure with the long-term mine production schedule and NPV/IRR modelling horizon.',
    `npv_amount` DECIMAL(18,2) COMMENT 'Net Present Value of the capital project calculated using the approved discount rate in the DCF model. Key investment decision metric used in board capital allocation governance and project ranking.',
    `opex_capex_split_pct` DECIMAL(18,2) COMMENT 'Percentage of the total project cost classified as CAPEX (versus OPEX) for accounting and tax purposes. Relevant for mixed-nature projects where capitalisation criteria under IAS 16 or IFRS 6 apply to only a portion of spend.',
    `project_code` STRING COMMENT 'Unique alphanumeric code identifying the capital project to which this budget line belongs, as defined in SAP PS. Used to group WBS elements under a single capital initiative (e.g., pit expansion, processing plant upgrade).',
    `project_end_date` DATE COMMENT 'Planned or actual completion date of the capital project or WBS phase. Drives capital phasing in LOM plans and determines the depreciation commencement date under IAS 16.',
    `project_phase` STRING COMMENT 'The lifecycle phase of the capital project to which this budget applies. Supports IFRS 6 exploration accounting and LOM capital phasing. [ENUM-REF-CANDIDATE: Exploration|Feasibility|Construction|Commissioning|Operations|Closure — promote to reference product if additional phases are required]. Valid values are `Exploration|Feasibility|Construction|Commissioning|Operations|Closure`',
    `project_start_date` DATE COMMENT 'Planned or actual start date of the capital project or WBS phase. Used in LOM capital scheduling and NPV/IRR discounted cash flow modelling.',
    `revised_budget_amount` DECIMAL(18,2) COMMENT 'Most recent board-approved revised budget amount after formal budget revision cycles (e.g., mid-year reforecast). Null if no revision has been approved. Supports variance analysis against original budget.',
    `revision_reason` STRING COMMENT 'Narrative description of the reason for the most recent budget revision (e.g., scope change, geotechnical risk materialisation, commodity price impact on equipment costs). Required for capital governance audit.',
    `source_system_code` STRING COMMENT 'Identifier of the operational source system from which this CAPEX budget record was extracted (e.g., SAP-S4HANA-PROD). Supports data lineage and multi-system reconciliation in the lakehouse.',
    CONSTRAINT pk_capex_budget PRIMARY KEY(`capex_budget_id`)
) COMMENT 'Capital expenditure budget master capturing approved CAPEX allocations by WBS element, project phase, mine site, and fiscal year. Tracks original approved budget, budget revisions, committed costs, actual spend, and forecast-to-complete. Supports LOM capital planning, NPV/IRR project valuations, and board-approved capital allocation governance.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`opex_budget` (
    `opex_budget_id` BIGINT COMMENT 'Unique surrogate identifier for each OPEX budget record in the silver layer lakehouse. Primary key for the opex_budget data product.',
    `employee_id` BIGINT COMMENT 'SAP HR employee identifier of the individual who formally approved this OPEX budget record. Supports segregation of duties and audit trail requirements under IFRS and SOX-equivalent controls.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: OPEX budgets are allocated by cost centre. The cost_centre_code should be replaced with FK to cost_centre.cost_centre_id to enable joining to cost centre master data including hierarchy, responsible m',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: OPEX budgets are allocated by GL account. The gl_account_code should be replaced with FK to general_ledger_account.general_ledger_account_id to enable joining to account master data including account ',
    `owner_employee_id` BIGINT COMMENT 'SAP HR employee identifier of the person accountable for managing and approving this OPEX budget line. Supports budget ownership governance and approval workflow tracking.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.processing_plant. Business justification: Operating budgets are set at plant level for cost control, variance reporting, and AISC forecasting. Links financial planning to operational assets for budget vs actual analysis and cost centre perfor',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: OPEX budgets roll up to profit centres for segment reporting. The profit_centre_code should be replaced with FK to profit_centre.profit_centre_id to enable joining to profit centre master data.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: OPEX budgets can be project-related and allocated to WBS elements. The wbs_element_code should be replaced with FK to wbs_element.wbs_element_id to enable joining to project master data.',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'The actual operating expenditure incurred against this budget line for the fiscal period, sourced from SAP FI/CO actuals postings. Used to calculate budget variance and support C1 and AISC reporting.',
    `approval_date` DATE COMMENT 'The date on which this OPEX budget record was formally approved by the designated approver. Marks the transition from draft to approved status in the budget lifecycle.',
    `budget_cycle_code` STRING COMMENT 'Identifier for the budget planning cycle (e.g., AOP-2024, MYR-2024-Q2) during which this OPEX budget was prepared and submitted. Supports multi-cycle budget management including Annual Operating Plan (AOP) and mid-year reviews.',
    `budget_description` STRING COMMENT 'Free-text description of the OPEX budget line providing business context, justification, or notes entered by the budget owner. Supports budget review and audit processes.',
    `budget_end_date` DATE COMMENT 'The end date of the period covered by this OPEX budget record. Defines the temporal boundary for expenditure allocation and variance measurement.',
    `budget_quantity` DECIMAL(18,2) COMMENT 'The budgeted quantity of the resource or activity associated with this OPEX line (e.g., tonnes of ore processed, litres of fuel, hours of labour). Used in unit cost calculations for C1 and AISC reporting.',
    `budget_reference_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned to the OPEX budget record in SAP S/4HANA CO, used for cross-system traceability and audit referencing. Corresponds to the SAP internal order or cost centre budget document number.',
    `budget_start_date` DATE COMMENT 'The start date of the period covered by this OPEX budget record. May align with the fiscal period start or represent a sub-period budget window for project-based expenditure.',
    `budget_status` STRING COMMENT 'Current workflow status of the OPEX budget record within the budget approval lifecycle. Controls editability and reporting inclusion (e.g., only approved budgets are used in C1 and AISC baseline calculations).. Valid values are `draft|submitted|approved|rejected|locked|closed`',
    `budget_version` STRING COMMENT 'Identifies the version of the budget record, distinguishing the original approved budget from subsequent revisions and forecasts. Supports budget lifecycle tracking and variance analysis against baseline. [ENUM-REF-CANDIDATE: original|revised_1|revised_2|revised_3|forecast|reforecast|final — promote to reference product if more versions are required]. Valid values are `original|revised_1|revised_2|revised_3|forecast|reforecast`',
    `committed_amount` DECIMAL(18,2) COMMENT 'The value of purchase orders and contracts committed against this OPEX budget line but not yet invoiced or posted as actuals. Supports available budget calculation and cash flow forecasting.',
    `commodity_type` STRING COMMENT 'The primary mineral commodity associated with this OPEX budget line. Enables commodity-level cost reporting and supports C1 cash cost per tonne calculations by commodity. [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|silver|other — promote to reference product]',
    `cost_category` STRING COMMENT 'High-level classification of the operating expenditure type. Used to segment OPEX into functional areas for C1 cash cost and AISC reporting. [ENUM-REF-CANDIDATE: mining|processing|maintenance|administration|hse|logistics|exploration|rehabilitation — promote to reference product]. Valid values are `mining|processing|maintenance|administration|hse|logistics`',
    `cost_element_code` STRING COMMENT 'SAP CO cost element code providing a secondary classification of the expenditure nature (e.g., wages, fuel, reagents, explosives). Bridges the GL account to cost object controlling for granular OPEX analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this OPEX budget record was first created in the system. Provides the audit trail entry point for the budget record lifecycle.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this budget record (e.g., AUD, USD, ZAR). Supports multi-currency mining operations and foreign exchange reporting.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert budget amounts from the transaction currency to the group reporting currency. Sourced from SAP FI exchange rate tables for the applicable fiscal period.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month number 1–12) within the fiscal year to which this OPEX budget record applies. Supports monthly budget phasing and period-level variance reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year (e.g., 2024) to which this OPEX budget record belongs. Used for annual budget cycle management and year-over-year variance analysis.',
    `forecast_amount` DECIMAL(18,2) COMMENT 'The latest forecast of total OPEX spend for the fiscal period, incorporating actuals to date plus projected remaining spend. Used in rolling forecast cycles and AISC guidance updates.',
    `is_capitalised` BOOLEAN COMMENT 'Indicates whether any portion of this OPEX budget line has been reclassified as capital expenditure (CAPEX) under IFRS 6 or IAS 16. True if capitalised; False if fully expensed as OPEX. Critical for IFRS 6 exploration accounting compliance.',
    `is_lom_included` BOOLEAN COMMENT 'Indicates whether this OPEX budget line is included in the Life of Mine (LOM) plan financial model. True if included in LOM; False if excluded (e.g., one-off or non-recurring items). Supports NPV and DCF modelling.',
    `last_revised_date` DATE COMMENT 'The date on which the most recent budget revision was applied to this record. Tracks the recency of budget amendments for governance and audit purposes.',
    `mine_site_code` STRING COMMENT 'Identifier for the mine site or operational location to which this OPEX budget applies. Enables site-level cost reporting and benchmarking across the mining portfolio.',
    `opex_classification` STRING COMMENT 'Classifies the OPEX budget line according to industry cost reporting frameworks. C1 cash cost covers direct mining and processing costs; AISC (All-In Sustaining Cost) includes sustaining capital and corporate overhead. Critical for external cost disclosure to investors and regulators.. Valid values are `c1_cash_cost|aisc|sustaining_capital|non_sustaining|corporate`',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'The initially approved OPEX budget amount in the reporting currency for the specified cost centre, GL account, mine site, and fiscal period. Represents the baseline against which actual spend and revisions are measured.',
    `quantity_unit_of_measure` STRING COMMENT 'The unit of measure for the budget_quantity field (e.g., t = tonnes, kt = kilotonnes, L = litres, h = hours, kWh = kilowatt-hours). Ensures dimensional consistency in unit cost calculations. [ENUM-REF-CANDIDATE: t|kt|Mt|L|kL|h|kWh|MWh|m3|kg — 10 candidates stripped; promote to reference product]',
    `revised_budget_amount` DECIMAL(18,2) COMMENT 'The most recently approved revised OPEX budget amount after formal budget amendments. Null if no revision has been made. Used in variance analysis to compare against actual spend.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this OPEX budget record was sourced. Supports data lineage tracking in the Databricks silver layer and reconciliation between planning and financial systems.. Valid values are `SAP_S4HANA|HEXAGON_MINEPLAN|DESWIK|MANUAL`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to this OPEX budget record. Used for change data capture in the Databricks silver layer and incremental load processing.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between the revised (or original if no revision) budget amount and the actual spend amount for the fiscal period. Positive value indicates underspend; negative value indicates overspend. Stored as a pre-computed field to support period-end reporting without recalculation overhead.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The budget variance expressed as a percentage of the budget amount ((budget - actual) / budget * 100). Enables proportional variance analysis and exception reporting across cost centres and mine sites.',
    CONSTRAINT pk_opex_budget PRIMARY KEY(`opex_budget_id`)
) COMMENT 'Operating expenditure budget master capturing approved OPEX allocations by cost centre, GL account, mine site, and fiscal period. Tracks original budget, revised budget, actual spend, and variance. Supports C1 cash cost and AISC reporting by providing the budgeted cost baseline against which actual mining, processing, and sustaining capital costs are measured.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for each cost allocation transaction record in the SAP CO allocation cycle. Primary key for the cost_allocation data product in the finance domain Silver layer.',
    `allocation_cycle_id` BIGINT COMMENT 'Reference to the SAP CO allocation cycle definition (assessment or distribution cycle) under which this allocation was executed. Links to the cycle configuration that defines sender/receiver rules and allocation basis.',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Cost allocations can be received by profit centres. The receiver_profit_centre code should be replaced with FK receiver_profit_centre_id → profit_centre.profit_centre_id to enable joining to profit ce',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Cost allocations can be received by WBS elements (project cost objects). The receiver_wbs_element code should be replaced with FK receiver_wbs_element_id → wbs_element.wbs_element_id to enable joining',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Cost allocations originate from a sender cost centre. The sender_cost_centre code and name should be replaced with FK sender_cost_centre_id → cost_centre.cost_centre_id to enable joining to sender cos',
    `activity_rate` DECIMAL(18,2) COMMENT 'The planned or actual cost rate per unit of activity (e.g., cost per equipment hour, cost per tonne processed) used to calculate the allocated amount. Supports equipment hourly rate charging and processing plant throughput-based apportionment in AISC and C1 cost build-up.',
    `activity_type_code` STRING COMMENT 'SAP CO activity type code when the allocation basis is an activity rate (e.g., EQUIP_HR for equipment hours, PROC_T for processing tonnes, DRILL_M for drilling metres). Drives the activity price calculation and links to the planned activity rate for variance analysis.',
    `aisc_component` STRING COMMENT 'Classification of the allocated cost into the World Gold Council / ICMM All-In Sustaining Cost (AISC) reporting component. Enables automated AISC build-up from cost allocation transactions: mining costs, processing costs, G&A, royalties, sustaining capital, and by-product credits. [ENUM-REF-CANDIDATE: mining|processing|general_and_admin|royalties|sustaining_capital|by_product_credit — promote to reference product]. Valid values are `mining|processing|general_and_admin|royalties|sustaining_capital|by_product_credit`',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The monetary value of costs allocated from the sender to the receiver cost object in the controlling area currency. This is the primary financial outcome of the allocation transaction and feeds directly into AISC and C1 cash cost per-tonne calculations and OPEX/CAPEX reporting.',
    `allocated_amount_usd` DECIMAL(18,2) COMMENT 'The allocated cost amount translated to US Dollars (USD) using the exchange rate applicable at the cycle run date. Required for AISC and C1 cash cost reporting in USD per ounce or USD per tonne as per ICMM and investor disclosure standards.',
    `allocation_basis_type` STRING COMMENT 'Method used to determine the allocation quantity or proportion. Activity rate charges based on confirmed activity quantities (e.g., equipment hours); statistical key figure uses operational metrics (e.g., tonnes processed, headcount); percentage applies a fixed split; fixed amount allocates a predetermined sum; equivalence number uses weighted ratios.. Valid values are `activity_rate|statistical_key_figure|percentage|fixed_amount|equivalence_number`',
    `allocation_basis_unit` STRING COMMENT 'Unit of measure for the allocation basis value (e.g., HR for hours, T for tonnes, PCT for percentage, KWH for kilowatt-hours). Aligns with SAP unit of measure codes and supports per-tonne cost build-up for AISC and C1 cash cost calculations.',
    `allocation_basis_value` DECIMAL(18,2) COMMENT 'The quantity or rate value of the allocation basis used to compute the allocated amount. For activity rate allocations this is the confirmed activity quantity (e.g., machine hours); for statistical key figure allocations this is the operational metric value (e.g., tonnes of ore processed); for percentage allocations this is the percentage applied.',
    `allocation_document_number` STRING COMMENT 'SAP CO allocation document number uniquely identifying the posting document generated during the allocation cycle run. Corresponds to the CO document number in SAP S/4HANA CO module and serves as the business-facing reference for audit and reconciliation.',
    `allocation_notes` STRING COMMENT 'Free-text notes or comments entered by the cost accountant describing the purpose, basis, or special circumstances of the allocation (e.g., Q3 processing plant overhead absorption based on ROM tonnes, Equipment fleet hourly rate recharge to open pit operations). Supports audit review and period-end close documentation.',
    `allocation_run_type` STRING COMMENT 'Indicates whether the allocation was executed against actual costs (actual run), planned costs (plan run for budget allocation modelling), or as a simulation (test run without posting). Supports both actual AISC reporting and budget/forecast cost allocation modelling.. Valid values are `actual|plan|simulated`',
    `allocation_status` STRING COMMENT 'Current processing status of the allocation document. Posted indicates confirmed CO posting; reversed indicates a reversal document has been generated; simulated indicates a test run without actual posting; error indicates a failed cycle run requiring correction; cancelled indicates a voided allocation.. Valid values are `posted|reversed|simulated|error|cancelled`',
    `allocation_type` STRING COMMENT 'Classification of the SAP CO allocation method used. Assessment transfers primary and secondary costs using assessment cost elements; distribution reallocates primary costs; activity allocation charges based on activity rates; template allocation uses formula-based rules; periodic reposting corrects prior postings. [ENUM-REF-CANDIDATE: assessment|distribution|activity_allocation|template_allocation|periodic_reposting — promote to reference product if additional types emerge]. Valid values are `assessment|distribution|activity_allocation|template_allocation|periodic_reposting`',
    `c1_cost_component` STRING COMMENT 'Classification of the allocated cost into the Brook Hunt / CRU C1 Cash Cost reporting component. C1 cash cost is the industry-standard direct cash cost measure used for copper, nickel, and other base metals. Components include mining, processing, site G&A, transport, royalties, and treatment/refining charges. [ENUM-REF-CANDIDATE: mining|processing|site_general_admin|transport|royalties|treatment_refining — promote to reference product]. Valid values are `mining|processing|site_general_admin|transport|royalties|treatment_refining`',
    `commodity_code` STRING COMMENT 'Code identifying the mineral commodity to which the allocated cost is attributed (e.g., FE for iron ore, CU for copper, COAL for coal, LI for lithium, NI for nickel). Enables commodity-level cost reporting and per-tonne cost build-up for AISC and C1 calculations by commodity.',
    `company_code` STRING COMMENT 'SAP FI company code of the legal entity under which the allocation is posted. Supports legal entity-level financial reporting, intercompany cost allocation identification, and IFRS consolidated financial statement preparation.',
    `controlling_area` STRING COMMENT 'SAP CO controlling area code within which the allocation cycle was executed. The controlling area defines the organisational scope for management accounting and cost centre hierarchies. Required for multi-entity mining groups operating across multiple SAP controlling areas.',
    `cost_category` STRING COMMENT 'Classification of the allocated cost as Operating Expenditure (OPEX), Capital Expenditure (CAPEX), sustaining capital, or exploration cost. Drives AISC component classification (OPEX feeds C1 cash cost; sustaining capital feeds AISC; exploration feeds IFRS 6 capitalisation decisions).. Valid values are `opex|capex|sustaining_capital|exploration`',
    `cost_element_code` STRING COMMENT 'SAP CO cost element (secondary cost element for assessments, primary cost element for distributions) under which the allocation is posted. Determines the cost category in the chart of accounts and drives AISC cost component classification (mining, processing, G&A, sustaining capital).',
    `cost_element_name` STRING COMMENT 'Descriptive name of the SAP CO cost element (e.g., Equipment Hourly Rate Charge, Processing Plant Overhead Absorption, Shared Services Assessment). Provides human-readable cost category context for reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost allocation record was first created in the Silver layer data product, sourced from the SAP CO document creation timestamp. Used for data lineage, audit trail, and incremental load processing.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code of the controlling area currency in which the allocated amount is denominated (e.g., AUD for Australian Dollar, USD for US Dollar, ZAR for South African Rand). Supports multi-currency mining operations across jurisdictions.. Valid values are `^[A-Z]{3}$`',
    `cycle_run_date` DATE COMMENT 'Calendar date on which the SAP CO allocation cycle was executed and postings were generated. Used to sequence allocation runs within a fiscal period and reconcile with period-end close activities.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert the allocated amount from the controlling area currency to USD at the cycle run date. Sourced from SAP FI exchange rate tables and aligned with the rate type used for management reporting.',
    `fiscal_period` STRING COMMENT 'The fiscal period (1–12 or 1–16 for special periods) within the fiscal year in which this allocation was posted. Aligns with SAP posting period and supports monthly OPEX and CAPEX cost build-up for AISC and C1 reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year (e.g., 2024) in which this cost allocation was posted. Used for annual financial reporting, AISC and C1 cash cost period aggregation, and IFRS 6 exploration cost capitalisation tracking.',
    `is_intercompany` BOOLEAN COMMENT 'Indicates whether this allocation crosses legal entity boundaries (True) or is within the same legal entity (False). Intercompany allocations require elimination in consolidated IFRS financial statements and may have transfer pricing implications under OECD guidelines.',
    `is_reversal` BOOLEAN COMMENT 'Indicates whether this allocation document is a reversal of a prior allocation posting (True) or an original allocation (False). Reversal records carry negative amounts and are linked to the original document number for audit trail purposes.',
    `mine_site_code` STRING COMMENT 'Code identifying the mine site or operation to which the allocated cost belongs. Supports site-level cost reporting, multi-site AISC benchmarking, and regulatory financial disclosures by operation as required under SEC S-K 1300 and JORC reporting.',
    `original_document_number` STRING COMMENT 'For reversal allocation records, the SAP CO document number of the original allocation being reversed. Enables audit trail linkage between original and reversal postings for period-end reconciliation and financial control.',
    `posting_date` DATE COMMENT 'The accounting posting date of the allocation document in SAP FI/CO. Determines the fiscal period in which the cost is recognised and may differ from the cycle run date when allocations are posted retroactively during period-end close.',
    `receiver_cost_centre` STRING COMMENT 'SAP CO cost centre code of the receiving cost object that absorbs the allocated costs. Represents the mine pit, processing circuit, exploration project, or operational department receiving the cost charge.',
    `receiver_cost_centre_name` STRING COMMENT 'Descriptive name of the receiving cost centre (e.g., Open Pit Mining Operations, Copper Flotation Circuit, Lithium Exploration). Provides human-readable context for the allocation destination.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost allocation record was last modified in the Silver layer data product (e.g., following a reversal, status update, or data correction). Supports change data capture and incremental processing in the Databricks Lakehouse pipeline.',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Transactional record of internal cost allocations, assessments, and distributions between cost centres, profit centres, and WBS elements executed via SAP CO allocation cycles. Captures sender/receiver cost objects, allocation basis (activity rates, statistical key figures, percentages), cycle run date, and allocated amounts. Covers shared services distribution, equipment hourly rate charges, processing plant throughput-based apportionment, and overhead absorption. Essential for accurate per-tonne cost build-up feeding AISC and C1 cash cost calculations.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`cost_performance_report` (
    `cost_performance_report_id` BIGINT COMMENT 'Primary key for cost_performance_report',
    `cost_centre_id` BIGINT COMMENT 'Reference to the SAP CO cost centre responsible for the cost accumulation reported. Aligns cost performance data to the organisational cost structure for management accounting.',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Cost performance reports aggregate costs from specific GL accounts. This link allows drilling down from AISC/C1 summary metrics to the underlying GL account detail. Consistent with pattern where all c',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: AISC/C1 cost performance reports are typically prepared by profit centre, as each mine site is a profit centre. This link allows aggregating cost performance across the profit centre hierarchy and com',
    `site_id` BIGINT COMMENT 'Reference to the mine site for which this cost performance report is generated. Enables site-level AISC benchmarking and multi-site portfolio cost analysis.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Cost performance reports may track project-specific costs via WBS elements, particularly for sustaining capital projects that contribute to AISC. This link allows reporting AISC by project phase or WB',
    `aisc_guidance_high` DECIMAL(18,2) COMMENT 'Upper bound of the published AISC cost guidance range for the reporting period or full year, as disclosed in investor guidance documents. Together with aisc_guidance_low defines the guidance band for performance assessment.',
    `aisc_guidance_low` DECIMAL(18,2) COMMENT 'Lower bound of the published AISC cost guidance range for the reporting period or full year, as disclosed in investor guidance documents. Used to assess whether actual AISC performance is within the guided range.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the finance manager or CFO who approved this cost performance report for publication or investor disclosure. Required for SOX and internal audit trail compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this cost performance report was formally approved by the authorised finance approver. Provides the audit trail required for SOX compliance and regulatory financial disclosure.',
    `budget_unit_cost` DECIMAL(18,2) COMMENT 'Budgeted per-unit AISC or C1 cost for the reporting period as approved in the annual operating plan. Used as the benchmark for variance analysis against actual unit cost results. Sourced from SAP CO planning versions.',
    `byproduct_credit` DECIMAL(18,2) COMMENT 'Revenue credit from by-product commodity sales (e.g., silver credits in a gold operation, molybdenum credits in a copper operation) deducted from gross costs to arrive at net AISC and C1 cost. A negative value reduces the reported unit cost.',
    `commodity` STRING COMMENT 'Primary commodity for which the unit cost metrics are reported. AISC and C1 cost benchmarks are commodity-specific; gold uses World Gold Council standards while copper uses Brook Hunt C1 framework. [ENUM-REF-CANDIDATE: gold|copper|iron_ore|coal|lithium|nickel|silver|zinc|cobalt|manganese — promote to reference product]',
    `cost_variance_driver` STRING COMMENT 'Narrative description of the primary driver(s) explaining the variance between actual and budget unit cost. Examples include grade underperformance, unplanned maintenance downtime, reagent price escalation, or FX movement. Used in management commentary and investor disclosures.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this cost performance report record was first created in the system. Provides the data lineage audit trail for the silver layer lakehouse.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which cost components are reported prior to USD conversion (e.g., AUD for Australian operations, ZAR for South African operations). Enables multi-currency cost consolidation.. Valid values are `^[A-Z]{3}$`',
    `fiscal_period` STRING COMMENT 'The fiscal period number (1–12 for monthly, 1–4 for quarterly) within the fiscal year as maintained in SAP S/4HANA CO. Enables period-over-period cost variance analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this cost performance report belongs, as defined in SAP S/4HANA FI fiscal year variant. Used for annual AISC trend analysis and year-on-year variance reporting.',
    `fx_rate_to_usd` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert local currency cost components to USD for the reporting period. Sourced from SAP FI currency translation tables. Critical for cross-jurisdiction AISC benchmarking.',
    `ga_cost` DECIMAL(18,2) COMMENT 'Site-level general and administrative overhead costs allocated to the reporting period, including site management, administration, and corporate services. Included in AISC but excluded from C1 cash cost per World Gold Council methodology.',
    `head_grade` DECIMAL(18,2) COMMENT 'Average grade of ore fed to the processing plant during the reporting period, expressed in the commodity-appropriate unit (e.g., g/t for gold, % for copper). Head grade is a key cost driver — lower grades increase unit AISC by reducing production volume from the same processing throughput.',
    `is_guidance_met` BOOLEAN COMMENT 'Indicates whether the actual unit cost result falls within the published AISC or C1 guidance range for the period. True when unit_cost_result is between aisc_guidance_low and aisc_guidance_high. Used in investor reporting and board performance dashboards.',
    `mining_opex` DECIMAL(18,2) COMMENT 'Direct mining operating costs for the period including drilling, blasting, loading, hauling, and ROM pad management. A core component of both AISC and C1 cost calculations. Sourced from SAP CO cost centre actuals for mining cost centres.',
    `prior_period_unit_cost` DECIMAL(18,2) COMMENT 'Per-unit AISC or C1 cost from the immediately preceding reporting period of the same type (e.g., prior quarter for quarterly reports). Enables period-on-period trend analysis and investor disclosure of cost trajectory.',
    `processing_opex` DECIMAL(18,2) COMMENT 'Direct mineral processing and beneficiation costs for the period including comminution, flotation, leaching, SX-EW, and reagent consumption. Sourced from SAP CO processing plant cost centres.',
    `production_unit_of_measure` STRING COMMENT 'Unit of measure for the production volume field. Commodity-specific: troy ounces (oz) for gold and silver, dry metric tonnes (dmt) for iron ore and coal, pounds (lb) for copper and nickel. [ENUM-REF-CANDIDATE: oz|troy_oz|dmt|wmt|lb|t|kg — 7 candidates stripped; promote to reference product]',
    `production_volume` DECIMAL(18,2) COMMENT 'Total quantity of payable commodity produced during the reporting period, expressed in the unit of measure applicable to the commodity (e.g., troy ounces for gold, dry metric tonnes for iron ore, pounds for copper). Used as the denominator in per-unit AISC and C1 cost calculations.',
    `recovery_rate_pct` DECIMAL(18,2) COMMENT 'Metallurgical recovery rate achieved during the reporting period, expressed as a percentage of valuable mineral extracted from the ore feed. Recovery rate directly impacts production volume and therefore unit AISC. Sourced from metallurgical balance reconciliation.',
    `refining_and_transport_cost` DECIMAL(18,2) COMMENT 'Costs incurred for off-site refining, smelting, and transportation of concentrate or doré to the point of sale. Included in C1 cash cost for base metals and in AISC for precious metals. Covers both CIF and FOB delivery terms.',
    `report_number` STRING COMMENT 'Externally-known business identifier for the cost performance report, used in investor disclosures, management reporting packs, and peer benchmarking submissions. Follows the format CPR-YYYY-MM-SiteCode.. Valid values are `^CPR-[0-9]{4}-[0-9]{2}-[A-Z0-9]{4,10}$`',
    `report_status` STRING COMMENT 'Current lifecycle state of the cost performance report, controlling whether it is eligible for external disclosure or investor reporting. Draft reports are work-in-progress; published reports are locked for regulatory submission.. Valid values are `draft|under_review|approved|published|superseded`',
    `report_type` STRING COMMENT 'Classification of the cost reporting methodology applied. AISC follows World Gold Council standards including sustaining CAPEX and G&A. C1 captures direct cash costs only. C2 and C3 represent broader cost boundary definitions used in copper and base metals benchmarking.. Valid values are `aisc|c1_cash_cost|c2_total_cost|c3_full_cost`',
    `reporting_period_end` DATE COMMENT 'Last calendar date of the reporting period covered by this cost performance record. Together with reporting_period_start defines the cost accumulation window for AISC and C1 calculations.',
    `reporting_period_start` DATE COMMENT 'First calendar date of the reporting period covered by this cost performance record. Used to align cost metrics with production volumes and financial period boundaries in SAP FI/CO.',
    `reporting_period_type` STRING COMMENT 'Granularity of the reporting period — monthly for operational management, quarterly for ASX/SEC investor disclosures, and annual for full-year AISC benchmarking against peers.. Valid values are `monthly|quarterly|half_yearly|annual`',
    `royalty_cost` DECIMAL(18,2) COMMENT 'Government and private royalties payable on mineral production during the reporting period. Included in both AISC and C1 cost calculations. Sourced from SAP FI accounts payable royalty accruals.',
    `strip_ratio` DECIMAL(18,2) COMMENT 'Ratio of waste material (overburden) moved to ore mined during the reporting period. A key open-pit cost driver — higher strip ratios increase mining OPEX per unit of ore processed and directly inflate AISC. Sourced from mine production reconciliation.',
    `sustaining_capex` DECIMAL(18,2) COMMENT 'Capital expenditure required to sustain current production levels, including equipment replacement, tailings storage facility (TSF) raises, and mine infrastructure maintenance. Included in AISC but excluded from C1 cash cost. Sourced from SAP PS project actuals.',
    `total_cost_usd` DECIMAL(18,2) COMMENT 'Aggregate of all cost components (mining OPEX, processing OPEX, G&A, sustaining CAPEX, royalties, refining and transport) less by-product credits for the reporting period, expressed in USD. This is the numerator used to compute the per-unit AISC or C1 cost.',
    `unit_cost_result` DECIMAL(18,2) COMMENT 'Calculated per-unit AISC or C1 cash cost expressed in USD per production unit of measure (e.g., USD/oz for gold, USD/lb for copper, USD/dmt for iron ore). This is the primary cost disclosure metric for investor reporting and peer benchmarking. Computed as total_cost_usd divided by production_volume.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this cost performance report record was last modified. Tracks restatements, corrections, or updates to cost components following period-end close adjustments in SAP CO.',
    `variance_to_budget_pct` DECIMAL(18,2) COMMENT 'Percentage variance of actual unit cost result against the budget unit cost for the period. Positive values indicate cost overrun; negative values indicate cost underperformance. Calculated as ((unit_cost_result - budget_unit_cost) / budget_unit_cost) * 100.',
    `variance_to_prior_period_pct` DECIMAL(18,2) COMMENT 'Percentage variance of actual unit cost result against the prior period unit cost. Used in quarterly investor reports and management commentary to explain cost movement drivers.',
    CONSTRAINT pk_cost_performance_report PRIMARY KEY(`cost_performance_report_id`)
) COMMENT 'Unit cost performance reporting record capturing both AISC (All-In Sustaining Cost) and C1 cash cost metrics per mine site, commodity, and reporting period. AISC includes mining OPEX, processing, G&A, sustaining CAPEX, royalties, and by-product credits per World Gold Council standards. C1 captures direct cash costs excluding sustaining CAPEX and overheads. Stores report type, production volume, cost components breakdown, per-unit cost result, and variance to budget/prior period. The primary cost disclosure metrics for investor reporting and peer benchmarking.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`project_valuation` (
    `project_valuation_id` BIGINT COMMENT 'Unique surrogate identifier for the project valuation record in the Databricks Silver Layer. Primary key for this entity.',
    `capital_project_id` BIGINT COMMENT 'Reference to the mining project (greenfield, brownfield, acquisition, or divestment) being valued. Links to the project master record.',
    `cost_centre_id` BIGINT COMMENT 'Reference to the SAP CO cost centre responsible for funding and tracking this valuation study.',
    `aisc_usd` DECIMAL(18,2) COMMENT 'All-In Sustaining Cost (AISC) per unit of payable metal/mineral produced, expressed in USD per applicable unit. Extends C1 to include royalties, sustaining CAPEX, corporate G&A, and reclamation costs. Used for investor reporting and project economics benchmarking.',
    `approval_date` DATE COMMENT 'Date on which the valuation was formally approved by the investment committee or board, triggering capital allocation and project sanction decisions.',
    `breakeven_price_usd` DECIMAL(18,2) COMMENT 'The commodity price at which the project NPV equals zero at the applied discount rate, expressed in USD per applicable unit. Represents the minimum long-term commodity price required for the project to be economically viable.',
    `c1_cash_cost_usd` DECIMAL(18,2) COMMENT 'C1 cash cost per unit of payable metal/mineral produced, expressed in USD per applicable unit. Represents direct cash costs of mining, processing, and site administration, excluding royalties, depreciation, and sustaining capital. Industry-standard cost metric for benchmarking.',
    `capex_total_musd` DECIMAL(18,2) COMMENT 'Total capital expenditure (CAPEX) estimate for the project over its full life, expressed in million USD. Includes initial development CAPEX, sustaining CAPEX, and closure CAPEX as modelled in the DCF. Sourced from SAP PS capital budgeting.',
    `commodity_price_usd` DECIMAL(18,2) COMMENT 'Long-term real commodity price assumption used as the base case in the DCF model, expressed in USD per applicable unit (e.g., USD/tonne for iron ore, USD/lb for copper). This is a proprietary price deck assumption and is commercially sensitive.',
    `commodity_type` STRING COMMENT 'Primary commodity being evaluated in this valuation model. Determines the applicable price deck, benchmark index, and market demand assumptions used in the DCF. [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|silver|zinc|other — promote to reference product]',
    `country_risk_premium_pct` DECIMAL(18,2) COMMENT 'Additional risk premium added to the base discount rate to reflect sovereign, political, and regulatory risk in the jurisdiction where the project is located, expressed as a percentage. Used in cross-border acquisition and greenfield valuations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this valuation record was first created in the system, providing the audit trail start point for data lineage and regulatory disclosure purposes.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the DCF model financial outputs (NPV, CAPEX, OPEX) are expressed (e.g., USD, AUD, CAD). Enables multi-currency consolidation and reporting.. Valid values are `^[A-Z]{3}$`',
    `discount_rate_pct` DECIMAL(18,2) COMMENT 'Nominal or real discount rate (Weighted Average Cost of Capital — WACC) applied to future cash flows in the DCF model, expressed as a percentage (e.g., 8.00 for 8%). The primary driver of NPV sensitivity.',
    `effective_date` DATE COMMENT 'The reference date as of which all DCF model inputs (commodity prices, exchange rates, cost estimates) are expressed. Used to align valuations across different study dates for comparability.',
    `head_grade_pct` DECIMAL(18,2) COMMENT 'Average feed grade of the ore reserve used in the DCF production profile, expressed as a percentage (e.g., % Fe for iron ore, % Cu for copper). Directly drives revenue calculations in the DCF model.',
    `inflation_rate_pct` DECIMAL(18,2) COMMENT 'Annual general inflation rate assumption applied in nominal DCF models to escalate costs and revenues over the mine life, expressed as a percentage. Only applicable when price_basis is nominal.',
    `irr_pct` DECIMAL(18,2) COMMENT 'Internal Rate of Return (IRR) of the project under the base case assumptions, expressed as a percentage. The discount rate at which the project NPV equals zero. Used alongside NPV for investment ranking and hurdle rate comparison.',
    `mine_life_years` STRING COMMENT 'Estimated total operating life of the mine in years as modelled in the DCF, derived from the LOM (Life of Mine) plan. Directly determines the number of cash flow periods in the NPV calculation.',
    `notes` STRING COMMENT 'Free-text field for recording key assumptions, caveats, material changes from the prior version, or qualifications relevant to the interpretation of this valuation. Supports audit trail and regulatory disclosure documentation.',
    `npv_base_musd` DECIMAL(18,2) COMMENT 'Net Present Value (NPV) of the project under the base case commodity price, production, and cost assumptions, expressed in million USD. The primary investment decision metric for capital allocation and stage-gate approval.',
    `npv_high_musd` DECIMAL(18,2) COMMENT 'NPV under the upside/high commodity price and cost scenario, expressed in million USD. Used in sensitivity analysis to quantify project value upside under favourable market conditions.',
    `npv_low_musd` DECIMAL(18,2) COMMENT 'NPV under the downside/low commodity price and cost scenario, expressed in million USD. Used in sensitivity analysis to quantify project value at risk under adverse market conditions.',
    `opex_unit_usd` DECIMAL(18,2) COMMENT 'Steady-state operating expenditure (OPEX) per tonne of ore processed, expressed in USD/t. Represents the all-in operating cost assumption in the DCF model, excluding royalties and sustaining capital.',
    `ore_reserve_category` STRING COMMENT 'JORC/NI 43-101 resource and reserve classification underpinning the production profile used in the DCF model. Proved and Probable are Ore Reserves; Measured, Indicated, and Inferred are Mineral Resources. Determines the confidence level and regulatory disclosure requirements of the valuation.. Valid values are `proved|probable|indicated|measured|inferred`',
    `payback_period_years` DECIMAL(18,2) COMMENT 'Number of years from first production (or initial CAPEX commitment) required to recover the total initial capital investment from undiscounted project cash flows. Used as a liquidity and risk metric alongside NPV and IRR.',
    `prepared_by` STRING COMMENT 'Name or employee identifier of the qualified person (QP) or financial analyst responsible for preparing this valuation study. For JORC/NI 43-101 disclosures, the QP must be a competent person as defined by the applicable standard.',
    `price_basis` STRING COMMENT 'Indicates whether the commodity price deck and cost estimates in the DCF model are expressed in real (constant purchasing power) or nominal (inflated) terms. Critical for correct interpretation of NPV and IRR outputs.. Valid values are `real|nominal`',
    `production_rate_mtpa` DECIMAL(18,2) COMMENT 'Steady-state annual ore production throughput assumption used in the DCF model, expressed in million tonnes per annum (Mtpa). Derived from the mine production schedule and processing plant design capacity.',
    `recovery_rate_pct` DECIMAL(18,2) COMMENT 'Metallurgical recovery rate assumed in the DCF model, expressed as a percentage of valuable mineral extracted from the ore feed. Determines payable metal/mineral production volume and directly impacts revenue projections.',
    `royalty_rate_pct` DECIMAL(18,2) COMMENT 'Government or private royalty rate applied to revenue or profit in the DCF model, expressed as a percentage. Jurisdiction-specific and commodity-specific; a material cost item in project economics.',
    `strip_ratio` DECIMAL(18,2) COMMENT 'Ratio of waste (overburden) tonnes to ore tonnes mined, as modelled in the LOM plan. A key driver of mining OPEX in open-cut operations. Higher strip ratios increase unit mining costs and reduce project economics.',
    `study_stage` STRING COMMENT 'Stage-gate study phase at which this valuation was produced. Scoping = order-of-magnitude; PFS = Pre-Feasibility Study; DFS = Definitive Feasibility Study; BFS = Bankable Feasibility Study; Update = periodic refresh. Drives accuracy expectations and capital governance approval thresholds. [ENUM-REF-CANDIDATE: scoping|pfs|dfs|bfs|update — promote to reference product if additional stages are required]. Valid values are `scoping|pfs|dfs|bfs|update`',
    `tax_rate_pct` DECIMAL(18,2) COMMENT 'Corporate income tax rate applied in the DCF model for the project jurisdiction, expressed as a percentage. Drives post-tax NPV and IRR calculations. May differ from statutory rate due to mining-specific tax concessions.',
    `total_ore_reserve_mt` DECIMAL(18,2) COMMENT 'Total ore reserve tonnage (Proved + Probable) underpinning the LOM production schedule in the DCF model, expressed in million tonnes. Sourced from the JORC/NI 43-101 compliant resource estimate.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this valuation record, supporting audit trail requirements and change management governance.',
    `valuation_code` STRING COMMENT 'Externally-known alphanumeric business identifier for this valuation study, used in stage-gate governance documentation and board submissions (e.g., VAL-PILBARA-2024).. Valid values are `^VAL-[A-Z0-9]{4,12}-[0-9]{4}$`',
    `valuation_name` STRING COMMENT 'Human-readable descriptive name of the valuation study (e.g., Pilbara Iron Ore Expansion DFS 2024), used in reports and presentations.',
    `valuation_status` STRING COMMENT 'Current lifecycle state of the valuation record within the stage-gate capital governance workflow. Draft = work in progress; Under Review = submitted for technical/financial review; Approved = board or investment committee approved; Superseded = replaced by a newer version; Archived = retained for audit trail.. Valid values are `draft|under_review|approved|superseded|archived`',
    `valuation_type` STRING COMMENT 'Classification of the investment decision context: greenfield (new mine development), brownfield (expansion of existing operation), acquisition (target company or asset purchase), divestment (asset sale assessment), or exploration (early-stage resource discovery). Drives applicable discount rate and risk premium selection.. Valid values are `greenfield|brownfield|acquisition|divestment|exploration`',
    `version_number` STRING COMMENT 'Sequential integer version of this valuation within the same study stage, enabling tracking of iterative model updates (e.g., commodity price deck revisions, CAPEX re-estimates) without creating a new study stage record.',
    CONSTRAINT pk_project_valuation PRIMARY KEY(`project_valuation_id`)
) COMMENT 'NPV/IRR project valuation record capturing discounted cash flow (DCF) model outputs for mining investment decisions including greenfield mine development, brownfield expansions, acquisition targets, and divestment assessments. Stores key assumptions (commodity price deck, production profile, mine life, CAPEX/OPEX estimates, discount rate, country risk premium), calculated outputs (NPV, IRR, payback period, breakeven commodity price), and sensitivity/scenario analysis parameters. Versioned per study stage (scoping, PFS, DFS, BFS) to support stage-gate capital governance and JORC/NI 43-101 economic assessments.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`royalty_obligation` (
    `royalty_obligation_id` BIGINT COMMENT 'Unique surrogate identifier for each royalty obligation record in the mining finance system. Primary key for the royalty_obligation data product.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Royalty obligations are tracked by cost centre for AISC and C1 cost reporting. The cost_centre_code should be replaced with FK to cost_centre.cost_centre_id to enable joining to cost centre master dat',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Royalty obligations post to specific GL accounts. The gl_account_code should be replaced with FK to general_ledger_account.general_ledger_account_id to enable joining to account master data including ',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Royalty obligations should be allocated to profit centres for segment reporting. Royalties are typically mine-site-specific (profit centre = mine site), and this link allows reporting royalty expense ',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Financial royalty obligations originate from specific tenements. Direct link enables reconciliation between contractual royalty agreements and financial liability records, supporting audit trail and e',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Royalty obligations can be project-related and charged to WBS elements. The wbs_element code should be replaced with FK to wbs_element.wbs_element_id to enable joining to project master data.',
    `accrued_liability_amount` DECIMAL(18,2) COMMENT 'The cumulative royalty liability accrued in the current accounting period but not yet paid, as recorded in SAP FI accounts payable. Used for IFRS balance sheet reporting and period-end accrual journals.',
    `aisc_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this royalty obligation is included in the AISC (All-In Sustaining Cost) calculation for the mine site. AISC is a key industry cost metric used in external financial reporting and investor disclosures per ICMM and World Gold Council guidance.',
    `c1_cost_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this royalty obligation is included in the C1 cash cost calculation. C1 is the direct cash cost of production per unit and is a standard industry cost reporting metric used in investor and analyst reporting.',
    `calculation_basis` STRING COMMENT 'The financial basis on which the royalty is calculated. Gross revenue uses total sales value; net revenue deducts allowable costs; FOB (Free on Board) uses the value at the mine gate; CIF (Cost Insurance and Freight) includes shipping costs; net smelter return deducts processing costs; net profit is used for profit-based royalties.. Valid values are `gross_revenue|net_revenue|free_on_board|cost_insurance_freight|net_smelter_return|net_profit`',
    `commodity` STRING COMMENT 'The mineral commodity to which this royalty obligation applies, such as iron ore, copper, coal, lithium, or nickel. Determines the applicable royalty rate schedule and regulatory reporting category. [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|silver|zinc|other — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this royalty obligation record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the royalty obligation is denominated and payable (e.g., AUD, USD, ZAR). Used for SAP FI foreign currency revaluation and IFRS financial reporting.. Valid values are `^[A-Z]{3}$`',
    `dispute_description` STRING COMMENT 'Narrative description of the nature of any active dispute, audit finding, or legal challenge relating to this royalty obligation. Populated only when dispute_flag is true. Confidential due to legal sensitivity.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this royalty obligation is currently subject to a formal dispute, audit, or legal challenge with the payee or regulatory authority. When true, accruals may require additional provisioning under IFRS.',
    `effective_from_date` DATE COMMENT 'The date from which this royalty obligation becomes legally binding and royalty accruals commence. Aligns with the commencement of mining operations or the execution of the royalty agreement.',
    `effective_to_date` DATE COMMENT 'The date on which this royalty obligation expires or is terminated. Null for open-ended obligations tied to the life of the mine (LOM). Used for LOM financial planning and IFRS decommissioning provisions.',
    `exemption_basis` STRING COMMENT 'The legal or regulatory basis for any royalty exemption, such as a state agreement provision, development phase concession, or rehabilitation credit. Populated only when exemption_flag is true.',
    `exemption_flag` BOOLEAN COMMENT 'Indicates whether this royalty obligation has been granted a full or partial exemption by the relevant government authority (e.g., during mine development, rehabilitation, or under a state agreement). Affects accrual calculations.',
    `governing_legislation` STRING COMMENT 'The specific mining act, regulation, or agreement that establishes the legal basis for this royalty obligation (e.g., Mining Act 1978 WA, Mineral Resources Act 1989 QLD). Critical for regulatory compliance and legal review.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction (state, territory, or country) whose mining royalty legislation governs this obligation. Determines the applicable royalty rate schedule, calculation basis, and regulatory reporting requirements. Uses ISO 3166-1 alpha-3 country code or state code.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'The monetary amount of the most recent royalty payment remitted to the payee, in the obligation currency. Used for payment trend analysis and SAP FI accounts payable reconciliation.',
    `last_payment_date` DATE COMMENT 'The date on which the most recent royalty payment was made to the payee. Used to verify payment compliance, calculate overdue amounts, and support SAP FI accounts payable reconciliation.',
    `mine_site_code` STRING COMMENT 'Identifier for the mine site or tenement area to which this royalty obligation is attached. Links to the operational mine site for production volume tracking and royalty calculation. Used in SAP CO cost centre allocation.',
    `minimum_royalty_amount` DECIMAL(18,2) COMMENT 'The minimum royalty payable per payment period regardless of production volume or commodity price, as stipulated in the royalty agreement or legislation. Ensures a floor payment to the royalty authority. Expressed in the obligation currency.',
    `notes` STRING COMMENT 'Free-text field for additional commentary, special conditions, or contextual information relating to this royalty obligation that is not captured in structured fields. Used by finance and legal teams for audit trail purposes.',
    `obligation_number` STRING COMMENT 'Externally-known business identifier for the royalty obligation, used in SAP FI accounts payable and regulatory correspondence. Follows the format ROY-YYYY-NNNNNN.. Valid values are `^ROY-[0-9]{4}-[0-9]{6}$`',
    `obligation_status` STRING COMMENT 'Current lifecycle state of the royalty obligation. Active indicates payments are currently due; suspended indicates a temporary halt; terminated indicates the obligation has ended; pending indicates awaiting regulatory approval; under_review indicates a dispute or audit is in progress.. Valid values are `active|suspended|terminated|pending|under_review`',
    `payee_name` STRING COMMENT 'Legal name of the entity to whom royalties are payable, including government authorities, state mining departments, landowners, or native title holders. Used for SAP FI vendor master alignment and regulatory disclosure.',
    `payee_type` STRING COMMENT 'Classification of the royalty payee entity. Government includes federal and state mining authorities; landowner refers to private surface or mineral rights holders; native title refers to indigenous land rights holders; joint_venture refers to JV partner royalty arrangements.. Valid values are `government|landowner|native_title|joint_venture|other`',
    `payment_due_day` STRING COMMENT 'The day of the month (1–31) by which royalty payments must be received by the payee following the end of the reporting period. Used to calculate payment due dates in SAP FI and manage cash flow planning.',
    `payment_frequency` STRING COMMENT 'The scheduled frequency at which royalty payments must be remitted to the payee. Drives the SAP FI payment run schedule and cash flow forecasting in the finance domain.. Valid values are `monthly|quarterly|semi_annual|annual|on_demand`',
    `price_reference` STRING COMMENT 'The commodity price reference used in ad valorem royalty calculations. LME spot uses the London Metal Exchange spot price; Platts index uses the relevant Platts commodity index; contract price uses the actual sales contract price; realized price uses the actual achieved price; benchmark price uses a government-set reference price.. Valid values are `lme_spot|platts_index|contract_price|realized_price|benchmark_price`',
    `production_volume_basis` STRING COMMENT 'The production measurement basis used to calculate royalties. ROM (Run of Mine) tonnes is the raw ore extracted; dry metric tonnes (DMT) and wet metric tonnes (WMT) are standard shipping measures; contained metal is used for metal-in-concentrate royalties; concentrate tonnes applies to processed product royalties.. Valid values are `rom_tonnes|dry_metric_tonnes|wet_metric_tonnes|contained_metal|concentrate_tonnes`',
    `rate_review_date` DATE COMMENT 'The scheduled date on which the royalty rate is subject to review or renegotiation by the relevant authority or as stipulated in the royalty agreement. Critical for financial planning and OPEX forecasting.',
    `rate_unit` STRING COMMENT 'The unit of measure for the royalty rate. Percent_revenue applies to ad valorem royalties; per_tonne or per_dmt (dry metric tonne) or per_wmt (wet metric tonne) applies to specific/production-based royalties; percent_profit applies to profit-based royalties.. Valid values are `percent_revenue|per_tonne|per_dmt|per_wmt|per_unit|percent_profit`',
    `reporting_period_type` STRING COMMENT 'The type of reporting period used for royalty calculation and submission to the relevant authority. Determines the period-end accrual schedule in SAP FI and aligns with regulatory reporting requirements.. Valid values are `calendar_month|calendar_quarter|financial_year|calendar_year`',
    `royalty_rate` DECIMAL(18,2) COMMENT 'The applicable royalty rate expressed as a decimal fraction (e.g., 0.075 for 7.5%). For ad valorem royalties this is a percentage of revenue; for specific royalties this is a rate per unit of production. Confidential as it reflects negotiated commercial terms.',
    `royalty_type` STRING COMMENT 'Classification of the royalty obligation by calculation methodology. Ad valorem is based on the value of production, specific is a fixed rate per unit of production, profit-based is derived from net profit, production-based is a flat rate per tonne, and hybrid combines multiple methods.. Valid values are `ad_valorem|specific|profit_based|production_based|hybrid`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this royalty obligation record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking, audit compliance, and SAP FI change log alignment.',
    `vendor_code` STRING COMMENT 'The SAP FI vendor master code for the royalty payee, used to process royalty payments through the accounts payable module. Links the obligation to the payees payment details in SAP.',
    CONSTRAINT pk_royalty_obligation PRIMARY KEY(`royalty_obligation_id`)
) COMMENT 'Master record of all royalty obligations payable to government authorities, landowners, and native title holders on mineral production. Captures royalty type (ad valorem, specific, profit-based), applicable commodity, royalty rate, calculation basis, payment schedule, and accrued liability. Supports regulatory financial disclosure and SAP FI accounts payable accruals.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`exploration_expenditure` (
    `exploration_expenditure_id` BIGINT COMMENT 'Primary key for exploration_expenditure',
    `employee_id` BIGINT COMMENT 'The SAP HR employee identifier of the authorised approver who approved this exploration expenditure for capitalisation or expensing. Supports delegated authority compliance and audit trail requirements.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: IFRS 6 exploration expenditures are tracked by cost centre. The cost_centre_code should be replaced with FK to cost_centre.cost_centre_id to enable joining to cost centre master data and organizationa',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Exploration expenditures post to specific GL accounts with IFRS 6 classification. The gl_account_code should be replaced with FK to general_ledger_account.general_ledger_account_id to enable joining t',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: IFRS 6 exploration expenditure should be allocated to profit centres for segment reporting. Exploration activities are typically organized by geographic region or commodity type, which map to profit c',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Exploration expenditure must be tracked by tenement for IFRS 6 area-of-interest accounting, capitalization decisions, and impairment testing. Essential for quarterly capitalization review and ensuring',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Exploration projects are tracked via SAP PS WBS elements. The sap_wbs_element code should be replaced with FK to wbs_element.wbs_element_id to enable joining to WBS master data including project hiera',
    `accumulated_expenditure_amount` DECIMAL(18,2) COMMENT 'The cumulative total of capitalised exploration and evaluation expenditure for this area of interest as at the posting date. Represents the carrying value of the E&E asset on the balance sheet prior to impairment assessment. Critical for IFRS 6 impairment trigger evaluation and JORC resource reporting.',
    `amount_functional_currency` DECIMAL(18,2) COMMENT 'The exploration expenditure amount translated into the entitys functional currency (typically AUD) using the exchange rate applicable at the transaction date. Used for consolidated IFRS financial reporting and IFRS 6 asset carrying value calculations.',
    `approval_date` DATE COMMENT 'The date on which this exploration expenditure was formally approved by the authorised delegate. Required for delegated authority audit trails and period-end capitalisation cut-off.',
    `area_of_interest_code` STRING COMMENT 'Unique code identifying the geographic area of interest (AOI) to which this expenditure is attributed. The area of interest is the fundamental unit of account under IFRS 6 for capitalisation and impairment assessment. Aligns with tenement or exploration licence boundaries.',
    `area_of_interest_name` STRING COMMENT 'Descriptive name of the exploration area of interest (e.g., Pilbara North Block, Kalgoorlie East Tenement). Provides human-readable context for financial reporting and ASX continuous disclosure.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The approved budget amount allocated for this exploration expenditure line or project phase in the functional currency. Used for CAPEX/OPEX budget variance analysis and board-approved exploration programme tracking.',
    `capitalisation_status` STRING COMMENT 'Indicates whether this expenditure has been capitalised as an exploration and evaluation (E&E) asset, expensed in the period, is pending accounting review, reclassified to mine development assets upon technical feasibility determination, or written off following impairment. Core IFRS 6 accounting policy field.. Valid values are `capitalised|expensed|pending_review|reclassified|written_off`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the jurisdiction in which the exploration activity was conducted (e.g., AUS, CAN, ZAF). Required for multi-jurisdiction regulatory reporting and IFRS 6 segment disclosure.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this exploration expenditure record was first created in the data platform, in ISO 8601 format with timezone offset. Supports data lineage, audit trail, and IFRS 6 period-end reporting cut-off validation.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction currency in which the expenditure amount is denominated (e.g., AUD, USD, CAD). Required for multi-currency consolidation and foreign exchange translation under IAS 21.. Valid values are `^[A-Z]{3}$`',
    `expenditure_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the exploration expenditure incurred in the transaction currency. This is the primary financial measure for IFRS 6 capitalisation tracking, budget variance analysis, and ASX continuous disclosure of exploration spend.',
    `expenditure_category` STRING COMMENT 'Indicates whether this exploration expenditure is classified as Capital Expenditure (CAPEX) — to be capitalised as an E&E asset — or Operating Expenditure (OPEX) — to be expensed in the current period. Fundamental to IFRS 6 accounting policy and management reporting.. Valid values are `capex|opex`',
    `expenditure_date` DATE COMMENT 'The date on which the exploration expenditure was incurred or the cost was recognised in the accounting period. Used for period-end accrual cut-off and IFRS 6 capitalisation timing.',
    `expenditure_description` STRING COMMENT 'Free-text description of the exploration expenditure, capturing the specific activity, scope, or deliverable (e.g., RC drilling programme — 20 holes, 2,400m total, Pilbara North Block). Supports audit review and ASX continuous disclosure narrative.',
    `expenditure_type` STRING COMMENT 'Classification of the nature of exploration expenditure incurred. Determines the appropriate accounting treatment under IFRS 6 and supports granular cost analysis by activity. [ENUM-REF-CANDIDATE: drilling|geophysical_survey|assaying|geological_mapping|feasibility_study|environmental_study|land_access|administration — promote to reference product]',
    `exploration_stage` STRING COMMENT 'The stage of the exploration programme at which this expenditure was incurred, from initial grassroots reconnaissance through to feasibility completion. Determines the likelihood of capitalisation and informs JORC resource classification progression. [ENUM-REF-CANDIDATE: grassroots|target_generation|resource_definition|prefeasibility|feasibility|development_ready — promote to reference product]. Valid values are `grassroots|target_generation|resource_definition|prefeasibility|feasibility|development_ready`',
    `fiscal_period` STRING COMMENT 'The accounting period (month number 1–12) within the fiscal year in which this expenditure is recognised. Used for monthly management reporting and period-end close processes in SAP CO.',
    `fiscal_year` STRING COMMENT 'The financial year in which this exploration expenditure is recognised, expressed as a four-digit integer (e.g., 2024). Aligns with the companys fiscal year calendar as configured in SAP FI.',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the entitys functional currency into which the transaction currency amount has been translated (e.g., AUD). Supports multi-entity group consolidation under IFRS.. Valid values are `^[A-Z]{3}$`',
    `impairment_amount` DECIMAL(18,2) COMMENT 'The monetary value of any impairment loss recognised against the capitalised exploration and evaluation asset for this area of interest in the functional currency. Recognised in profit or loss per IFRS 6 paragraph 21 when recoverable amount falls below carrying value.',
    `impairment_indicator_present` BOOLEAN COMMENT 'Indicates whether one or more IFRS 6 impairment indicators are present for this area of interest at the reporting date (e.g., exploration licence expiry, no further exploration planned, resource not commercially viable). Triggers mandatory impairment test under IFRS 6 paragraph 20.',
    `metres_drilled` DECIMAL(18,2) COMMENT 'The total metres drilled associated with this exploration expenditure record, where the expenditure relates to a drilling programme. Enables cost-per-metre analysis and links financial spend to physical drilling progress reported under JORC.',
    `mineral_commodity` STRING COMMENT 'The primary mineral commodity being targeted by the exploration programme associated with this expenditure (e.g., iron_ore, copper, lithium). Used for commodity-level cost analysis, portfolio management, and segment reporting under IFRS 8. [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|zinc|silver|manganese|other — promote to reference product]',
    `posting_date` DATE COMMENT 'The date on which this expenditure was posted to the SAP FI general ledger. May differ from expenditure_date due to accrual adjustments or period-end processing. Used for financial period reconciliation.',
    `project_code` STRING COMMENT 'Internal project code assigned to the exploration programme under which this expenditure was incurred. Links to the SAP PS project structure and Hexagon MinePlan project hierarchy for integrated cost and schedule tracking.',
    `purchase_order_number` STRING COMMENT 'The SAP MM or Pronto Xi purchase order number associated with this exploration expenditure. Provides the procurement-to-pay audit trail linking the expenditure to the approved purchase order and goods/services receipt.',
    `reclassification_date` DATE COMMENT 'The date on which capitalised exploration and evaluation expenditure was reclassified from E&E assets to mine development assets (or written off) following technical feasibility determination or impairment. Null if reclassification has not occurred.',
    `reporting_standard` STRING COMMENT 'The mineral resource reporting standard applicable to this exploration expenditure based on the jurisdiction of the area of interest. Determines the disclosure requirements for resource estimates associated with this spend. Values: JORC (Australia), NI_43-101 (Canada), SAMREC (South Africa), SEC_SK1300 (USA).. Valid values are `JORC|NI_43-101|SAMREC|SEC_SK1300`',
    `sap_document_number` STRING COMMENT 'The SAP S/4HANA FI document number assigned to this exploration expenditure posting. Serves as the primary cross-reference to the source system of record for audit and reconciliation purposes.',
    `technical_feasibility_date` DATE COMMENT 'The date on which technical feasibility and commercial viability was formally determined for the area of interest, triggering reclassification of E&E assets to mine development assets. Null if technical feasibility has not yet been determined.',
    `technical_feasibility_determined` BOOLEAN COMMENT 'Indicates whether technical feasibility and commercial viability of extracting the mineral resource has been determined for this area of interest. When True, triggers mandatory reclassification of capitalised E&E assets to mine development assets under IFRS 6 paragraph 17.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this exploration expenditure record was last modified in the data platform, in ISO 8601 format with timezone offset. Used for incremental data processing, change tracking, and audit compliance.',
    `vendor_code` STRING COMMENT 'SAP MM vendor master code for the external supplier or contractor who provided the exploration services (e.g., drilling contractor, geophysical survey company, assay laboratory). Links to the SAP vendor master for accounts payable processing.',
    CONSTRAINT pk_exploration_expenditure PRIMARY KEY(`exploration_expenditure_id`)
) COMMENT 'IFRS 6 exploration and evaluation expenditure record capturing costs incurred during mineral exploration including drilling, geophysical surveys, assaying, and feasibility studies. Tracks capitalisation vs expensing decisions per area of interest, impairment trigger assessments, accumulated expenditure by project area, and reclassification to mine development assets upon technical feasibility and commercial viability determination. Supports area-of-interest accounting policy, IFRS 6 compliance reporting, and ASX continuous disclosure requirements for exploration spend.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`rehabilitation_provision` (
    `rehabilitation_provision_id` BIGINT COMMENT 'Unique surrogate identifier for each mine rehabilitation and closure provision record in the lakehouse silver layer.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Closure provisions link to mine development projects for life-of-mine accounting and asset retirement obligation (ARO) tracking. Mining companies establish provisions at project sanction and revise th',
    `cost_centre_id` BIGINT COMMENT 'Reference to the SAP CO cost centre responsible for carrying and managing this rehabilitation provision balance.',
    `general_ledger_account_id` BIGINT COMMENT 'Reference to the SAP FI general ledger account under which the rehabilitation provision liability is recorded on the balance sheet.',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site for which this rehabilitation and closure provision is established. Each provision is site-specific.',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Rehabilitation provisions should be allocated to profit centres for segment reporting and balance sheet allocation. Consistent with pattern where all major financial products (journal_entry, cost_allo',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Rehabilitation provisions are often tracked against WBS elements for project-based closure cost accounting. The existing wbs_element_code (STRING) should be replaced with proper FK to wbs_element.wbs_',
    `actual_expenditure_amount` DECIMAL(18,2) COMMENT 'Actual rehabilitation expenditure incurred and drawn down against the provision during the reporting period. Reduces the provision balance and is settled through the SAP FI accounts payable process.',
    `aisc_inclusion_flag` BOOLEAN COMMENT 'Indicates whether the rehabilitation provision charge (unwinding of discount and revisions) is included in the All-In Sustaining Cost (AISC) metric for external commodity cost reporting purposes.',
    `bond_expiry_date` DATE COMMENT 'The expiry date of the regulatory rehabilitation bond instrument. Requires renewal before expiry to maintain regulatory compliance and avoid breach of mining licence conditions.',
    `bond_instrument_type` STRING COMMENT 'The type of financial instrument used to secure the regulatory rehabilitation bond lodged with the government regulator.. Valid values are `bank_guarantee|cash_deposit|insurance_bond|letter_of_credit|surety_bond`',
    `closing_balance_amount` DECIMAL(18,2) COMMENT 'The rehabilitation provision balance at the end of the reporting period after all movements (unwinding of discount, revisions, drawdowns, new provisions) have been applied. Reported on the balance sheet as a non-current liability.',
    `cost_estimate_basis` STRING COMMENT 'The methodological basis used to derive the undiscounted rehabilitation cost estimate. Internal_estimate indicates costs prepared by the mine closure team; independent_review indicates a third-party specialist review; regulatory_assessment indicates costs assessed by the environmental regulator; lom_plan_derived indicates costs derived from the Life of Mine (LOM) plan.. Valid values are `internal_estimate|independent_review|regulatory_assessment|lom_plan_derived`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this rehabilitation provision record was first created in the system, providing an audit trail for data governance and IFRS financial reporting integrity.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary provision amounts are denominated (e.g., AUD, USD, ZAR). Supports multi-currency operations across international mine sites.. Valid values are `^[A-Z]{3}$`',
    `discount_rate_pct` DECIMAL(18,2) COMMENT 'The pre-tax risk-free discount rate (expressed as a decimal, e.g., 0.0450 for 4.50%) applied to discount the undiscounted rehabilitation cost estimate to its present value. Typically based on government bond rates matching the expected closure timeline.',
    `disturbance_area_ha` DECIMAL(18,2) COMMENT 'The total area of land disturbed by mining operations (in hectares) that is subject to rehabilitation obligations. Used as a key driver in estimating per-hectare rehabilitation costs and validating provision adequacy.',
    `expected_closure_date` DATE COMMENT 'The estimated date on which mine operations will cease and full rehabilitation activities are expected to be completed, based on the current Life of Mine (LOM) plan. Drives the discounting period for the provision calculation.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this rehabilitation provision record belongs, used for annual financial reporting and IFRS disclosure alignment.',
    `inflation_rate_pct` DECIMAL(18,2) COMMENT 'The long-term inflation rate assumption (expressed as a decimal, e.g., 0.0250 for 2.50%) applied to escalate the rehabilitation cost estimate from current-day costs to nominal future costs at the expected closure date.',
    `last_estimate_review_date` DATE COMMENT 'The date on which the rehabilitation cost estimate was most recently reviewed and updated. IAS 37 requires provisions to be reviewed at each balance sheet date.',
    `new_provision_amount` DECIMAL(18,2) COMMENT 'Additional provision recognised during the reporting period for new disturbance areas or newly identified rehabilitation obligations at the mine site.',
    `next_estimate_review_date` DATE COMMENT 'The scheduled date for the next formal review of the rehabilitation cost estimate, ensuring compliance with IAS 37 annual review requirements and regulatory bond reassessment cycles.',
    `opening_balance_amount` DECIMAL(18,2) COMMENT 'The rehabilitation provision balance at the start of the reporting period, as carried forward from the prior period closing balance. Used to reconcile provision movements per IAS 37 disclosure requirements.',
    `opex_capex_classification` STRING COMMENT 'Indicates whether the rehabilitation expenditure is classified as Operating Expenditure (OPEX) or Capital Expenditure (CAPEX) for internal cost reporting and All-In Sustaining Cost (AISC) calculation purposes.. Valid values are `opex|capex`',
    `provision_notes` STRING COMMENT 'Free-text notes capturing material assumptions, significant judgements, regulatory conditions, or other contextual information relevant to the rehabilitation provision estimate and its movements during the period.',
    `provision_reference` STRING COMMENT 'Externally-known business reference code for the provision record, used in SAP FI/CO and regulatory financial disclosures. Follows the format REHAB-<SITE_CODE>-<YEAR>.. Valid values are `^REHAB-[A-Z0-9]{3,10}-[0-9]{4}$`',
    `provision_status` STRING COMMENT 'Current lifecycle status of the rehabilitation provision record. Active indicates the provision is live on the balance sheet; revised indicates a formal estimate revision has been processed; settled indicates actual expenditure has fully drawn down the provision; closed indicates the mine site rehabilitation obligation has been discharged; under_review indicates the provision is being reassessed.. Valid values are `active|revised|settled|closed|under_review`',
    `provision_type` STRING COMMENT 'Classification of the nature of the rehabilitation obligation. Decommissioning covers plant and equipment removal; rehabilitation covers land and soil restoration; environmental_restoration covers broader ecosystem recovery; tailings_remediation covers Tailings Storage Facility (TSF) closure; water_treatment covers ongoing water management post-closure; infrastructure_removal covers roads, buildings, and utilities. [ENUM-REF-CANDIDATE: decommissioning|rehabilitation|environmental_restoration|tailings_remediation|water_treatment|infrastructure_removal — promote to reference product]. Valid values are `decommissioning|rehabilitation|environmental_restoration|tailings_remediation|water_treatment|infrastructure_removal`',
    `recognition_date` DATE COMMENT 'The date on which the rehabilitation provision was first recognised on the balance sheet, corresponding to the date the constructive or legal obligation arose (typically commencement of mining disturbance).',
    `regulatory_bond_amount` DECIMAL(18,2) COMMENT 'The financial assurance bond amount lodged with the relevant government regulator as security for the rehabilitation obligation. May differ from the IAS 37 provision balance due to different regulatory vs. accounting methodologies.',
    `rehabilitation_completed_area_ha` DECIMAL(18,2) COMMENT 'The cumulative area of land (in hectares) that has been successfully rehabilitated and formally signed off by the relevant environmental regulator, reducing the outstanding rehabilitation obligation.',
    `reporting_period_end_date` DATE COMMENT 'The financial reporting period end date (balance sheet date) to which this provision balance snapshot relates. Enables period-over-period tracking of provision movements.',
    `revision_amount` DECIMAL(18,2) COMMENT 'Net increase or decrease to the provision balance arising from revisions to the estimated future rehabilitation cost during the period. Positive values indicate upward revisions; negative values indicate downward revisions. Corresponds to changes in the underlying asset under IFRIC 1.',
    `sap_provision_document_number` STRING COMMENT 'The SAP FI accounting document number under which the rehabilitation provision journal entry is posted in the general ledger. Enables traceability between the data product and the source system of record.',
    `tsf_related_flag` BOOLEAN COMMENT 'Indicates whether this rehabilitation provision relates specifically to a Tailings Storage Facility (TSF) closure obligation, which carries heightened regulatory scrutiny and disclosure requirements under ICMM and MAC standards.',
    `undiscounted_cost_estimate` DECIMAL(18,2) COMMENT 'The total estimated future cost of mine rehabilitation and closure in nominal (undiscounted) terms, as determined by the most recent mine closure cost estimate study. This is the gross cost before applying the time-value-of-money discount.',
    `unwinding_of_discount_amount` DECIMAL(18,2) COMMENT 'The finance charge recognised in the income statement during the period representing the unwinding of the time-value-of-money discount applied to the provision. Calculated as the opening provision balance multiplied by the pre-tax risk-free discount rate.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this rehabilitation provision record was most recently modified, supporting audit trail requirements and change tracking for IAS 37 provision movement disclosures.',
    `years_to_closure` STRING COMMENT 'The number of years from the reporting period end date to the expected mine closure date, used as the discounting period in the present value calculation of the rehabilitation provision.',
    CONSTRAINT pk_rehabilitation_provision PRIMARY KEY(`rehabilitation_provision_id`)
) COMMENT 'Mine rehabilitation and closure provision master capturing the estimated future cost of mine site rehabilitation, decommissioning, and environmental restoration obligations per mine site. Tracks provision balance, unwinding of discount, revisions to estimates, and actual expenditure drawdowns. Reported under IAS 37 provisions and IFRS financial statements.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique surrogate identifier for the fixed asset record in the data lakehouse. Primary key for the fixed_asset data product.',
    `asset_class_id` BIGINT COMMENT 'FK to equipment.asset_class',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Fixed assets originate from capital projects for asset register traceability and depreciation basis. Mining assets (plant, equipment, infrastructure) link to originating projects for lifecycle cost tr',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Fixed assets are assigned to cost centres for depreciation allocation and responsibility tracking. Both cost_centre_code and responsible_cost_centre should be consolidated into a single FK to cost_cen',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Fixed assets are posted to specific GL accounts (asset accounts by asset class). This link allows reconciling fixed asset register to GL account balances and supports asset class reporting.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.processing_plant. Business justification: Processing equipment assets (mills, flotation cells, pumps) are located at specific plants for asset register, depreciation calculation, and impairment testing. Links financial asset accounting to phy',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Fixed assets should be allocated to profit centres for segment balance sheet and depreciation reporting. Essential for mining operations where assets are allocated to specific mine sites (profit centr',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Fixed assets are capitalized from WBS elements (assets under construction). The wbs_element code should be replaced with FK to wbs_element.wbs_element_id to enable tracing asset capitalization back to',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation charged against the asset from the acquisition date to the current reporting period. Corresponds to SAP ANLC-KNAFA. Used to calculate net book value for balance sheet reporting.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original historical cost of the asset at the time of acquisition or capitalisation, including purchase price, installation, and directly attributable costs. Corresponds to SAP ANLC-KANSW. Reported in the assets book currency.',
    `acquisition_date` DATE COMMENT 'Date on which the fixed asset was acquired, capitalised, or placed in service. Used as the start date for depreciation calculations and CAPEX reporting. Corresponds to SAP ANLA-AKTIV.',
    `asset_category` STRING COMMENT 'High-level business category of the fixed asset used for CAPEX reporting and balance sheet disclosures. Aligns with IAS 16 and IFRS 6 asset groupings. [ENUM-REF-CANDIDATE: plant_and_equipment|mine_development|mineral_rights|infrastructure|mobile_equipment|land|construction_in_progress — promote to reference product]',
    `asset_class_code` STRING COMMENT 'SAP FI-AA asset class code (ANLA-ANLKL) that classifies the asset into categories such as plant and equipment, mine development costs, mineral rights, infrastructure, or vehicles. Drives depreciation rules and balance sheet grouping.',
    `asset_description` STRING COMMENT 'Short descriptive name of the fixed asset as recorded in SAP FI-AA (ANLA-TXT50). Examples: SAG Mill No. 3, Haul Road – Pit 2 to ROM Pad, Mineral Rights – Tenement ML1234.',
    `asset_number` STRING COMMENT 'The externally-known SAP FI-AA asset number uniquely identifying the capitalised asset within the asset accounting module. Corresponds to the SAP ANLA-ANLN1 field.',
    `asset_responsible_person` STRING COMMENT 'Name or personnel number of the individual accountable for the assets physical custody, condition, and compliance with asset management policies. Corresponds to SAP ANLA-VERTN.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset. active indicates the asset is in service and depreciating; under_construction indicates a capital work in progress (CWIP); retired indicates end of useful life; disposed indicates sale or write-off; impaired indicates a recognised impairment loss; transferred indicates inter-company or inter-site transfer.. Valid values are `active|under_construction|retired|disposed|impaired|transferred`',
    `asset_sub_number` STRING COMMENT 'SAP FI-AA sub-number (ANLN2) used to track components or partial retirements of a main asset number. Enables component-level tracking within a single asset master.',
    `asset_tag_number` STRING COMMENT 'Physical asset tag or barcode number affixed to the asset for field identification and inventory verification. Used during physical asset counts and reconciliation with the SAP asset register.',
    `business_area_code` STRING COMMENT 'SAP FI business area code associated with the asset, used for segment reporting and internal financial statements across mining operations.',
    `capex_budget_code` STRING COMMENT 'Reference code linking the asset to the approved CAPEX budget line item or capital project authorisation. Supports CAPEX tracking and variance reporting against approved capital expenditure budgets.',
    `capitalisation_date` DATE COMMENT 'Date on which the asset was formally capitalised and transferred from capital work in progress (CWIP) to a fixed asset class. May differ from acquisition_date for assets under construction.',
    `company_code` STRING COMMENT 'SAP FI company code (BUKRS) to which the fixed asset belongs. Identifies the legal entity responsible for the asset for financial reporting and balance sheet purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset master record was first created in the source system (SAP FI-AA). Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the assets financial values (acquisition cost, depreciation, NBV) are recorded. Typically the company code currency (e.g., AUD, USD, ZAR).. Valid values are `^[A-Z]{3}$`',
    `deactivation_date` DATE COMMENT 'Date on which the asset was retired, disposed of, or decommissioned. Marks the end of the assets depreciable life in the accounting records.',
    `depreciation_key` STRING COMMENT 'SAP FI-AA depreciation key code (e.g., LINR, DG10, UOP1) that defines the specific depreciation calculation rules applied to the asset, including method, period control, and base value.',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate periodic depreciation for the asset. Mining assets commonly use units_of_production (UOP) aligned to ore reserve depletion or straight_line over useful life. Corresponds to SAP depreciation key configuration.. Valid values are `straight_line|units_of_production|declining_balance|sum_of_years_digits|no_depreciation`',
    `ifrs6_exploration_flag` BOOLEAN COMMENT 'Indicates whether the asset is classified as an exploration and evaluation asset under IFRS 6 (Exploration for and Evaluation of Mineral Resources). When true, specific IFRS 6 recognition and impairment rules apply rather than standard IAS 16 treatment.',
    `impairment_loss` DECIMAL(18,2) COMMENT 'Cumulative impairment loss recognised against the asset where the recoverable amount has fallen below the carrying amount. Recorded in accordance with IAS 36 and disclosed in financial statements.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the insurance policy covering the fixed asset. Used for insurance management, claims processing, and ensuring adequate coverage of high-value mining assets.',
    `insured_value` DECIMAL(18,2) COMMENT 'Current insured replacement value of the asset as declared to the insurer. May differ from net book value; used for insurance adequacy reviews and risk management reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the fixed asset master record in the source system. Used for change tracking, audit compliance, and incremental data loading.',
    `location_code` STRING COMMENT 'Specific physical location code within the plant or mine site where the asset is installed or stationed (e.g., processing circuit, pit bench, ROM pad). Corresponds to SAP ANLA-STORT.',
    `lom_plan_reference` STRING COMMENT 'Reference identifier linking the asset to the Life of Mine (LOM) plan under which it was approved and capitalised. Supports alignment of asset useful life with mine reserve depletion schedules for units-of-production depreciation.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current net book value (NBV) of the asset, calculated as acquisition cost less accumulated depreciation and any impairment losses. Key balance sheet figure for CAPEX and financial disclosures.',
    `purchase_order_number` STRING COMMENT 'SAP MM purchase order number associated with the acquisition of the asset. Provides the procurement audit trail linking the asset to the original purchase transaction.',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'Remaining estimated useful life of the asset in years as at the current reporting date. Derived from useful life and elapsed depreciation periods; used for impairment assessments and LOM closure planning.',
    `residual_value` DECIMAL(18,2) COMMENT 'Estimated residual or scrap value of the asset at the end of its useful life. Deducted from acquisition cost to determine the depreciable amount under IAS 16. Corresponds to SAP ANLC-SCHRW.',
    `revaluation_amount` DECIMAL(18,2) COMMENT 'Cumulative revaluation surplus or deficit recognised for assets carried under the revaluation model per IAS 16. Applicable to mineral rights and land assets subject to periodic fair value assessment.',
    `serial_number` STRING COMMENT 'Manufacturers serial number of the asset, used for warranty tracking, insurance purposes, and cross-referencing with the equipment maintenance register in Infor EAM.',
    `source_system` STRING COMMENT 'Identifier of the operational system of record from which this fixed asset record was sourced. Supports data lineage and reconciliation between the lakehouse silver layer and upstream systems.. Valid values are `SAP_S4HANA|INFOR_EAM|MANUAL`',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Estimated useful economic life of the asset in years as determined at the time of capitalisation or last review. Used for straight-line depreciation calculations and Life of Mine (LOM) planning alignment.',
    `vendor_code` STRING COMMENT 'SAP MM vendor code of the supplier from whom the asset was purchased. Used for warranty claims, procurement history, and vendor performance analysis.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master from SAP FI Asset Accounting capturing all capitalised mining assets including plant and equipment, mine development costs, mineral rights, and infrastructure. Tracks acquisition cost, accumulated depreciation, net book value, useful life, depreciation method (units of production or straight-line), and asset class. Supports CAPEX reporting and balance sheet disclosures.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique identifier for the intercompany transaction record.',
    `cost_centre_id` BIGINT COMMENT 'FK to finance.cost_centre',
    `general_ledger_account_id` BIGINT COMMENT 'FK to finance.general_ledger_account',
    `profit_centre_id` BIGINT COMMENT 'FK to finance.profit_centre',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Intercompany transactions can be project-related and charged to WBS elements. The wbs_element code should be replaced with FK to wbs_element.wbs_element_id to enable joining to project master data.',
    `business_area_code` STRING COMMENT 'Business area code for cross-company code segment reporting and consolidation.. Valid values are `^[A-Z0-9]{4}$`',
    `commodity` STRING COMMENT 'Primary commodity associated with the intercompany transaction if related to mineral sales or transfers. [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|other — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the intercompany transaction record was first created in the system.',
    `document_date` DATE COMMENT 'Date of the original business document that triggered the intercompany transaction.',
    `due_date` DATE COMMENT 'Date by which the intercompany transaction amount is due for settlement between entities.',
    `elimination_date` DATE COMMENT 'Date on which the intercompany transaction was eliminated during the consolidation process.',
    `elimination_status` STRING COMMENT 'Status indicating whether the intercompany transaction has been eliminated in group consolidation.. Valid values are `pending|eliminated|not_required|manual_adjustment`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert transaction currency to group currency.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the intercompany transaction was posted.',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'Transaction amount converted to the group reporting currency for consolidation purposes.',
    `group_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used for group-level consolidation and reporting.. Valid values are `^[A-Z]{3}$`',
    `intercompany_transaction_description` STRING COMMENT 'Detailed textual description of the intercompany transaction explaining the business purpose and context.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the intercompany transaction record was last updated or modified.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Transaction amount converted to the local currency of the sending company code.',
    `payment_terms` STRING COMMENT 'Payment terms agreed between the sending and receiving entities for settlement of the intercompany transaction.',
    `posting_date` DATE COMMENT 'Date on which the intercompany transaction was posted to the general ledger.',
    `receiving_company_code` STRING COMMENT 'SAP company code of the legal entity receiving or being charged in the intercompany transaction.. Valid values are `^[A-Z0-9]{4}$`',
    `reference_document_number` STRING COMMENT 'External reference document number such as invoice number, purchase order, or contract reference supporting the intercompany transaction.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this intercompany transaction is a reversal of a previously posted transaction.',
    `reversed_document_number` STRING COMMENT 'Document number of the original transaction that this reversal posting is correcting.',
    `sending_company_code` STRING COMMENT 'SAP company code of the legal entity initiating or charging the intercompany transaction.. Valid values are `^[A-Z0-9]{4}$`',
    `settlement_date` DATE COMMENT 'Actual date on which the intercompany transaction was fully settled between entities.',
    `settlement_status` STRING COMMENT 'Current status of the intercompany transaction settlement indicating payment progress.. Valid values are `open|partially_settled|fully_settled|overdue|disputed`',
    `site_code` STRING COMMENT 'Mining site or operation code associated with the intercompany transaction for operational tracking.. Valid values are `^[A-Z0-9]{4,8}$`',
    `source_system` STRING COMMENT 'Identifier of the source system from which the intercompany transaction data originated.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code applicable to the intercompany transaction for withholding tax and compliance purposes.. Valid values are `^[A-Z]{2,3}$`',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Gross monetary value of the intercompany transaction in the transaction currency before any adjustments.',
    `transaction_category` STRING COMMENT 'High-level category grouping the intercompany transaction for reporting and analysis purposes.. Valid values are `goods|services|financing|equity|allocation`',
    `transaction_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the intercompany transaction was originally denominated.. Valid values are `^[A-Z]{3}$`',
    `transaction_document_number` STRING COMMENT 'SAP FI document number uniquely identifying the intercompany posting in the general ledger.. Valid values are `^[A-Z0-9]{10}$`',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction indicating the nature of the cross-entity charge or transfer. [ENUM-REF-CANDIDATE: intercompany_sale|intercompany_purchase|management_fee|royalty|loan|dividend|interest_charge|cost_allocation — 8 candidates stripped; promote to reference product]',
    `transfer_pricing_documentation_reference` STRING COMMENT 'Reference identifier to the transfer pricing documentation supporting the transaction pricing.',
    `transfer_pricing_method` STRING COMMENT 'Transfer pricing methodology applied to determine the intercompany transaction price for tax compliance.. Valid values are `cost_plus|market_price|negotiated|arms_length|comparable_uncontrolled_price`',
    `value_date` DATE COMMENT 'Effective date for cash flow and interest calculation purposes.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax applied to the intercompany transaction as per local tax regulations.',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Intercompany financial transaction record capturing cross-entity charges, loans, dividends, and management fee postings between legal entities within the mining group. Tracks sending and receiving company codes, transaction type, amount, currency, elimination status, and SAP FI document references. Supports group consolidation and transfer pricing compliance.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`hedge_instrument` (
    `hedge_instrument_id` BIGINT COMMENT 'Unique identifier for the financial hedging instrument record.',
    `cost_centre_id` BIGINT COMMENT 'FK to finance.cost_centre',
    `counterparty_id` BIGINT COMMENT 'FK to customer.counterparty',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Hedge instruments are posted to specific GL accounts for mark-to-market valuation (e.g., derivative asset/liability accounts, hedge reserve accounts). This link allows reconciling hedge instrument reg',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Hedging instruments should be allocated to profit centres for segment risk reporting. Commodity hedges are typically allocated to specific mine sites (profit centres) to match production exposure. Ess',
    `wbs_element_id` BIGINT COMMENT 'FK to finance.wbs_element',
    `aisc_inclusion_flag` BOOLEAN COMMENT 'Boolean flag indicating whether gains/losses from this hedging instrument are included in the calculation of All-In Sustaining Cost (AISC) for the mine site. True if included, False if excluded.',
    `c1_cost_inclusion_flag` BOOLEAN COMMENT 'Boolean flag indicating whether gains/losses from this hedging instrument are included in the calculation of C1 Cash Cost for the mine site. True if included, False if excluded.',
    `counterparty_credit_rating` STRING COMMENT 'The credit rating of the counterparty as assessed by a recognized rating agency (e.g., Moodys, S&P, Fitch), used for counterparty risk assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this hedge instrument record was first created in the data system.',
    `cumulative_gain_loss` DECIMAL(18,2) COMMENT 'The cumulative realized and unrealized gain or loss on the hedging instrument since inception, used for financial reporting and performance tracking.',
    `effective_date` DATE COMMENT 'The date from which the hedging instrument becomes active and hedge accounting treatment begins, if designated.',
    `hedge_accounting_designation` STRING COMMENT 'The IFRS 9 hedge accounting classification: fair value hedge (hedging changes in fair value of recognized asset/liability), cash flow hedge (hedging variability in future cash flows), net investment hedge (hedging FX risk in foreign operations), or not designated (held at fair value through profit or loss).. Valid values are `fair_value_hedge|cash_flow_hedge|net_investment_hedge|not_designated`',
    `hedge_effectiveness_ratio_pct` DECIMAL(18,2) COMMENT 'The calculated hedge effectiveness ratio as a percentage, measuring the degree to which changes in the hedging instrument offset changes in the hedged item. IFRS 9 requires a ratio between 80% and 125% for hedge accounting qualification.',
    `hedge_effectiveness_test_method` STRING COMMENT 'The method used to assess hedge effectiveness under IFRS 9 (e.g., dollar offset method, regression analysis, scenario analysis).',
    `hedge_ratio` DECIMAL(18,2) COMMENT 'The ratio of the quantity of the hedging instrument to the quantity of the hedged item, used in hedge effectiveness calculations under IFRS 9.',
    `hedged_item_description` STRING COMMENT 'Description of the underlying exposure or asset/liability being hedged (e.g., forecast copper sales Q1 2024, USD-denominated CAPEX for mine expansion, floating rate debt).',
    `instrument_category` STRING COMMENT 'High-level categorization of the hedge by underlying risk exposure: commodity price hedge (gold, copper, iron ore), foreign currency hedge (FX protection for CAPEX or revenue), or interest rate hedge (debt cost management).. Valid values are `commodity_price_hedge|foreign_currency_hedge|interest_rate_hedge`',
    `instrument_reference_number` STRING COMMENT 'External business identifier or contract number assigned to the hedging instrument by the treasury system or counterparty.',
    `instrument_status` STRING COMMENT 'Current lifecycle status of the hedging instrument: active (open and in force), matured (reached maturity date), settled (closed out and settled), terminated (early termination by agreement), or cancelled (voided before execution).. Valid values are `active|matured|settled|terminated|cancelled`',
    `instrument_type` STRING COMMENT 'Classification of the hedging instrument by derivative type: commodity forward, commodity option, foreign exchange (FX) forward, FX option, interest rate swap, or commodity swap.. Valid values are `commodity_forward|commodity_option|fx_forward|fx_option|interest_rate_swap|commodity_swap`',
    `last_effectiveness_test_date` DATE COMMENT 'The date on which the most recent hedge effectiveness test was performed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this hedge instrument record was last updated or modified.',
    `mark_to_market_value` DECIMAL(18,2) COMMENT 'The current fair value or mark-to-market valuation of the hedging instrument, representing unrealized gain or loss at the reporting date.',
    `maturity_date` DATE COMMENT 'The expiration or settlement date of the hedging instrument when the contract matures and is settled or exercised.',
    `mtm_valuation_currency` STRING COMMENT 'The currency in which the mark-to-market value is reported (ISO 4217 three-letter code).. Valid values are `^[A-Z]{3}$`',
    `mtm_valuation_date` DATE COMMENT 'The date as of which the mark-to-market value was calculated or obtained.',
    `notional_amount` DECIMAL(18,2) COMMENT 'The notional principal or contract size of the hedging instrument, representing the quantity or value being hedged (e.g., tonnes of copper, USD amount for FX forward).',
    `notional_unit_of_measure` STRING COMMENT 'The unit of measure for the notional amount (e.g., tonnes, ounces, USD, AUD, barrels).',
    `option_style` STRING COMMENT 'For option instruments, specifies the exercise style: European (exercisable only at maturity), American (exercisable any time before maturity), Asian (average price option), or not_applicable for non-option instruments.. Valid values are `european|american|asian|not_applicable`',
    `option_type` STRING COMMENT 'For option instruments, specifies whether it is a call option (right to buy) or put option (right to sell). Set to not_applicable for forwards, swaps, and other non-option instruments.. Valid values are `call|put|not_applicable`',
    `premium_currency` STRING COMMENT 'The currency in which the option premium was paid (ISO 4217 three-letter code).. Valid values are `^[A-Z]{3}$`',
    `premium_paid` DECIMAL(18,2) COMMENT 'The upfront premium paid for option contracts. Null or zero for forward contracts and swaps that typically have no upfront premium.',
    `sap_document_number` STRING COMMENT 'The SAP FI document number or treasury transaction reference linking this hedge instrument to the SAP S/4HANA financial system for audit trail and reconciliation.',
    `settlement_date` DATE COMMENT 'The actual date on which the hedging instrument was settled or closed out. Null if the instrument is still open.',
    `strike_price` DECIMAL(18,2) COMMENT 'The agreed strike or exercise price for option contracts, or the forward price for forward contracts. Represents the price at which the hedge is executed.',
    `strike_price_currency` STRING COMMENT 'The currency in which the strike or forward price is denominated (ISO 4217 three-letter code, e.g., USD, AUD, EUR).. Valid values are `^[A-Z]{3}$`',
    `trade_date` DATE COMMENT 'The date on which the hedging instrument was executed or contracted with the counterparty.',
    `underlying_commodity` STRING COMMENT 'The specific commodity being hedged (gold, copper, iron ore, nickel, lithium, coal) for commodity price hedges. Set to not_applicable for FX and interest rate hedges. [ENUM-REF-CANDIDATE: gold|copper|iron_ore|nickel|lithium|coal|not_applicable — 7 candidates stripped; promote to reference product]',
    `underlying_currency_pair` STRING COMMENT 'The currency pair being hedged for foreign exchange instruments (e.g., USD/AUD, EUR/USD). Null for commodity and interest rate hedges.',
    CONSTRAINT pk_hedge_instrument PRIMARY KEY(`hedge_instrument_id`)
) COMMENT 'Financial hedging instrument master capturing commodity price hedges (gold, copper, iron ore forwards and options), foreign currency contracts, and interest rate swaps used to manage mining revenue and cost exposure. Tracks instrument type, notional amount, strike/forward price, maturity date, counterparty, mark-to-market valuation, hedge effectiveness results, and IFRS 9 hedge accounting designation. Supports commodity revenue certainty, CAPEX FX protection, and treasury risk reporting.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`tax_obligation` (
    `tax_obligation_id` BIGINT COMMENT 'Unique identifier for the tax obligation record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Tax obligations are tracked by cost centre for management accounting. The cost_centre_code should be replaced with FK to cost_centre.cost_centre_id to enable joining to cost centre master data.',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Tax obligations post to specific GL accounts. The gl_account_code should be replaced with FK to general_ledger_account.general_ledger_account_id to enable joining to account master data including tax_',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that holds this tax obligation. Links to the legal entity master.',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Tax obligations should be allocated to profit centres for segment tax reporting. Mining operations have mine-site-specific taxes (PRRT, MRRT, state royalties) that need to be allocated to the profit c',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Project-specific tax obligations (e.g., PRRT on specific development projects) should link to WBS elements. This allows tracking tax obligations by project phase and capitalizing pre-production taxes ',
    `aisc_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this tax obligation is included in the calculation of All-In Sustaining Cost (AISC) for the mine site.',
    `assessment_date` DATE COMMENT 'Date on which the tax obligation was formally assessed or confirmed by the tax authority or internal tax team.',
    `commodity` STRING COMMENT 'Primary commodity associated with the revenue or operations that generated this tax obligation. [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|silver|zinc|other — 9 candidates stripped; promote to reference product]',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity for financial reporting purposes.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax obligation record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this record.. Valid values are `^[A-Z]{3}$`',
    `current_tax_liability_amount` DECIMAL(18,2) COMMENT 'Current tax liability amount for the reporting period, representing tax payable within 12 months.',
    `deferred_tax_asset_amount` DECIMAL(18,2) COMMENT 'Deferred tax asset balance arising from temporary differences, tax loss carryforwards, or unused tax credits.',
    `deferred_tax_liability_amount` DECIMAL(18,2) COMMENT 'Deferred tax liability balance arising from temporary differences between accounting and tax bases of assets and liabilities.',
    `due_date` DATE COMMENT 'Date by which the tax obligation must be paid to avoid penalties or interest.',
    `effective_tax_rate_pct` DECIMAL(18,2) COMMENT 'Effective tax rate percentage calculated as total tax expense divided by pre-tax income for the reporting period.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert local currency tax amounts to reporting currency, if applicable.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year for this tax obligation.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this tax obligation applies.',
    `interest_amount` DECIMAL(18,2) COMMENT 'Interest charged on overdue tax obligations or interest earned on overpaid tax amounts.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax obligation record was last modified.',
    `mine_site_code` STRING COMMENT 'Mine site code identifying the mining operation to which this tax obligation is attributed.. Valid values are `^[A-Z0-9]{3,10}$`',
    `notes` STRING COMMENT 'Free-text notes providing additional context, explanations, or audit trail information for this tax obligation.',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the tax obligation: draft (estimated), assessed (confirmed by authority), due (payment pending), paid (settled), overdue (past due date), disputed (under review), or waived (forgiven). [ENUM-REF-CANDIDATE: draft|assessed|due|paid|overdue|disputed|waived — 7 candidates stripped; promote to reference product]',
    `payment_date` DATE COMMENT 'Actual date on which the tax obligation was paid. Null if not yet paid.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Penalty amount levied by the tax authority for late payment, underpayment, or non-compliance.',
    `reference` STRING COMMENT 'External reference number or document number for this tax obligation as recorded in SAP FI or tax authority systems.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period covered by this tax obligation.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period covered by this tax obligation.',
    `sap_document_number` STRING COMMENT 'SAP FI document number for the accounting entry that recorded this tax obligation.. Valid values are `^[0-9]{10}$`',
    `statutory_tax_rate_pct` DECIMAL(18,2) COMMENT 'Statutory tax rate percentage applicable in the jurisdiction for this tax type.',
    `tax_adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustment amount applied to the tax obligation due to prior period corrections, audit findings, or regulatory changes.',
    `tax_authority_name` STRING COMMENT 'Name of the tax authority or regulatory body to which this obligation is owed (e.g., Australian Taxation Office, Canada Revenue Agency).',
    `tax_instalment_amount` DECIMAL(18,2) COMMENT 'Amount of tax paid as an instalment or advance payment during the reporting period.',
    `tax_jurisdiction_code` STRING COMMENT 'ISO country code or jurisdiction code where the tax obligation applies (e.g., AUS, CAN-ON, USA-WY). Supports multi-jurisdictional mining operations.. Valid values are `^[A-Z]{2,3}(-[A-Z0-9]{2,6})?$`',
    `tax_loss_carryforward_amount` DECIMAL(18,2) COMMENT 'Accumulated tax loss carryforward amount available to offset future taxable income in this jurisdiction.',
    `tax_return_reference` STRING COMMENT 'Reference number of the tax return filing to which this obligation relates.',
    `tax_type` STRING COMMENT 'Type of tax obligation: income tax, resource rent tax (PRRT/MRRT), withholding tax, GST/VAT, royalty, excise, or payroll tax. [ENUM-REF-CANDIDATE: income_tax|resource_rent_tax|withholding_tax|gst|vat|royalty|excise|payroll_tax — 8 candidates stripped; promote to reference product]',
    `taxable_income_amount` DECIMAL(18,2) COMMENT 'Taxable income or tax base amount used to calculate the tax obligation for the reporting period.',
    `total_obligation_amount` DECIMAL(18,2) COMMENT 'Total tax obligation amount including base tax, adjustments, penalties, and interest.',
    CONSTRAINT pk_tax_obligation PRIMARY KEY(`tax_obligation_id`)
) COMMENT 'Corporate tax obligation master capturing income tax, resource rent tax (PRRT/MRRT), withholding tax, and GST/VAT obligations per legal entity and jurisdiction. Tracks current tax liability, deferred tax balances, tax instalments, and effective tax rate. Supports SAP FI tax reporting and regulatory tax filings across multiple mining jurisdictions.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`vendor_invoice` (
    `vendor_invoice_id` BIGINT COMMENT 'Unique identifier for the vendor invoice record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Vendor invoices for project goods/services link to capital projects for capitalization vs expense classification. Mining companies route project invoices via project code for WBS posting and asset cap',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Vendor invoices are charged to cost centres. The cost_centre_code should be replaced with FK to cost_centre.cost_centre_id to enable joining to cost centre master data and support AISC/C1 cost reporti',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Vendor invoices post to specific GL accounts. The gl_account_code should be replaced with FK to general_ledger_account.general_ledger_account_id to enable joining to account master data including expe',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.processing_plant. Business justification: Invoices for plant-specific goods/services (reagents, grinding media, contractor services) are tagged to plants for cost allocation and three-way matching with plant-issued purchase orders. Standard A',
    `procurement_vendor_id` BIGINT COMMENT 'Reference to the vendor who issued this invoice.',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Vendor invoices should be allocated to profit centres for segment cost reporting. Invoices are typically allocated to the mine site (profit centre) receiving the goods/services. Essential for segment ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Vendor invoices can be project-related and charged to WBS elements. The wbs_element_code should be replaced with FK to wbs_element.wbs_element_id to enable joining to project master data and support C',
    `aisc_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this invoice expenditure is included in the AISC calculation for the mine site.',
    `c1_cost_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this invoice expenditure is included in the C1 cash cost calculation.',
    `commodity_type` STRING COMMENT 'The primary commodity associated with the expenditure covered by this invoice. [ENUM-REF-CANDIDATE: iron ore|copper|coal|lithium|nickel|gold|other — 7 candidates stripped; promote to reference product]',
    `company_code` STRING COMMENT 'The company code representing the legal entity receiving the invoice.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the invoice amount.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any early payment discount or negotiated discount applied to the invoice.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this invoice is currently under dispute.',
    `dispute_raised_date` DATE COMMENT 'The date the dispute was formally raised against this invoice.',
    `dispute_resolution_action` STRING COMMENT 'Description of the action taken to resolve the dispute (e.g., credit note issued, price adjustment, goods returned).',
    `dispute_resolved_date` DATE COMMENT 'The date the dispute was resolved and closed.',
    `dispute_status` STRING COMMENT 'Current status of the dispute resolution process.. Valid values are `open|under review|resolved|escalated|withdrawn`',
    `dispute_type` STRING COMMENT 'The category of dispute raised against this invoice, if applicable.. Valid values are `price variance|quantity discrepancy|quality rejection|duplicate invoice|service not rendered|other`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The portion of the invoice amount that is under dispute.',
    `due_date` DATE COMMENT 'The date by which payment is due to the vendor according to the payment terms.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the invoice currency to the functional currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the invoice was posted.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the invoice was posted.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The net invoice amount converted to the companys functional currency (typically USD or local currency).',
    `goods_receipt_number` STRING COMMENT 'The goods receipt document number used for three-way matching, confirming physical receipt of goods or services.',
    `gross_invoice_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before tax and adjustments.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice, as printed on the invoice document.',
    `invoice_description` STRING COMMENT 'A textual description of the goods or services covered by this invoice.',
    `invoice_number` STRING COMMENT 'The unique invoice number assigned by the vendor for this invoice document.',
    `invoice_status` STRING COMMENT 'Current payment status of the invoice in the procure-to-pay cycle. [ENUM-REF-CANDIDATE: pending|approved|disputed|paid|partially paid|cancelled|on hold — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor invoice record was last updated.',
    `mine_site_code` STRING COMMENT 'The mine site or operational location to which this invoice relates.',
    `net_invoice_amount` DECIMAL(18,2) COMMENT 'The final payable amount after tax, discounts, and adjustments.',
    `opex_capex_classification` STRING COMMENT 'Classification of the invoice expenditure as operating expenditure, capital expenditure, or mixed.. Valid values are `OPEX|CAPEX|mixed`',
    `payment_date` DATE COMMENT 'The actual date payment was made to the vendor. Null if not yet paid.',
    `payment_method` STRING COMMENT 'The method by which payment will be or was made to the vendor.. Valid values are `electronic funds transfer|cheque|wire transfer|credit card|letter of credit|other`',
    `payment_reference_number` STRING COMMENT 'The payment document or transaction reference number for the payment made against this invoice.',
    `payment_terms_code` STRING COMMENT 'The payment terms code defining the payment schedule and discount conditions (e.g., Net 30, 2/10 Net 30).',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the general ledger in the financial system.',
    `purchase_order_number` STRING COMMENT 'The purchase order number that this invoice references, used for three-way matching (PO-GR-Invoice).',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount (GST, VAT, sales tax) applied to the invoice.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match validation between purchase order, goods receipt, and invoice.. Valid values are `matched|variance|unmatched|bypassed`',
    CONSTRAINT pk_vendor_invoice PRIMARY KEY(`vendor_invoice_id`)
) COMMENT 'Vendor invoice received for goods or services supplied to the mining operation, including dispute management for exceptions. Captures invoice number, vendor, PO reference, invoice date, due date, line items, invoiced quantities, unit prices, tax amounts, total invoice value, currency, payment terms, three-way match status (PO-GR-Invoice), payment status (pending, approved, disputed, paid, partially paid), and where applicable: dispute type (price variance, quantity discrepancy, quality rejection, duplicate invoice), disputed amount, dispute raised date, resolution action, resolved date, and dispute status (open, under review, resolved, escalated). The primary accounts payable document in the procure-to-pay cycle. Sourced from SAP S/4HANA FI accounts payable and Pronto Xi.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`cash_flow_forecast` (
    `cash_flow_forecast_id` BIGINT COMMENT 'Unique identifier for the cash flow forecast record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Project capex spend profiles drive 13-week and annual cash flow forecasts for liquidity planning. Mining companies forecast project cash outflows by project for debt covenant compliance and funding de',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Cash flow forecasts are prepared and reported by cost centre. The cost_centre_code should be replaced with FK to cost_centre.cost_centre_id to enable joining to cost centre master data and organizatio',
    `legal_entity_id` BIGINT COMMENT 'FK to finance.legal_entity',
    `mine_site_id` BIGINT COMMENT 'FK to mine.mine_site',
    `employee_id` BIGINT COMMENT 'Employee identifier of the treasury or finance analyst who prepared this cash flow forecast.',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Cash flow forecasts roll up to profit centres for segment reporting. The profit_centre_code should be replaced with FK to profit_centre.profit_centre_id to enable joining to profit centre master data ',
    `superseded_cash_flow_forecast_id` BIGINT COMMENT 'Self-referencing FK on cash_flow_forecast (superseded_cash_flow_forecast_id)',
    `approval_date` DATE COMMENT 'Date on which this cash flow forecast version was formally approved for use in treasury planning and board reporting.',
    `asset_disposal_amount` DECIMAL(18,2) COMMENT 'Forecasted cash proceeds from sale or disposal of fixed assets, equipment, or mining infrastructure.',
    `capex_amount` DECIMAL(18,2) COMMENT 'Forecasted capital expenditure cash outflows for sustaining and expansion capital projects, mine development, and equipment purchases.',
    `closing_cash_balance_amount` DECIMAL(18,2) COMMENT 'Forecasted cash and cash equivalents balance at the end of the forecast period, critical for liquidity planning and covenant monitoring.',
    `commodity_sales_amount` DECIMAL(18,2) COMMENT 'Forecasted cash receipts from primary commodity sales, representing the main operating cash inflow for mining operations.',
    `commodity_type` STRING COMMENT 'Primary commodity or mineral type associated with this forecast, enabling commodity-specific cash flow analysis and price sensitivity modeling. [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|mixed — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this cash flow forecast record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all forecast amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `debt_covenant_compliance_flag` BOOLEAN COMMENT 'Indicator whether the forecasted cash position and financial ratios meet all debt covenant requirements. True indicates compliance.',
    `debt_service_amount` DECIMAL(18,2) COMMENT 'Forecasted cash outflows for debt principal and interest payments, critical for debt covenant compliance monitoring.',
    `dividend_payment_amount` DECIMAL(18,2) COMMENT 'Forecasted cash outflows for dividend distributions to shareholders, supporting dividend capacity assessment and board reporting.',
    `exchange_rate_to_usd` DECIMAL(18,2) COMMENT 'Exchange rate used to convert local currency amounts to USD for consolidated group reporting and AISC calculations.',
    `expansion_capex_amount` DECIMAL(18,2) COMMENT 'Forecasted expansion capital expenditure for growth projects, new mine development, and capacity expansion initiatives.',
    `financing_cash_inflow_amount` DECIMAL(18,2) COMMENT 'Forecasted cash inflows from financing activities including debt drawdowns, equity issuance, and capital contributions.',
    `financing_cash_outflow_amount` DECIMAL(18,2) COMMENT 'Forecasted cash outflows for financing activities including debt service, dividend payments, and share buybacks.',
    `fiscal_period` STRING COMMENT 'Fiscal period number within the fiscal year (1-12 for monthly, 1-4 for quarterly) for financial reporting alignment.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this forecast period belongs, used for annual financial planning and reporting alignment.',
    `forecast_assumptions` STRING COMMENT 'Key assumptions underlying this forecast including commodity price assumptions, production volumes, exchange rates, and cost escalation factors.',
    `forecast_horizon` STRING COMMENT 'Time granularity and planning horizon of the forecast. LOM (Life of Mine) represents full mine life projection.. Valid values are `weekly|monthly|quarterly|annual|lom`',
    `forecast_period_end_date` DATE COMMENT 'End date of the period covered by this cash flow forecast.',
    `forecast_period_start_date` DATE COMMENT 'Start date of the period covered by this cash flow forecast.',
    `forecast_reference_number` STRING COMMENT 'Externally-known unique reference number for this cash flow forecast version, used for tracking and audit purposes.. Valid values are `^CF-[0-9]{4}-[0-9]{6}$`',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the cash flow forecast indicating its approval state and usability for decision-making.. Valid values are `draft|submitted|approved|rejected|superseded|active`',
    `forecast_type` STRING COMMENT 'Classification of the forecast by cash flow category aligned with cash flow statement structure.. Valid values are `operating|investing|financing|consolidated`',
    `forecast_version` STRING COMMENT 'Version number of the forecast, incremented with each revision to track forecast evolution over time.',
    `hedging_settlement_amount` DECIMAL(18,2) COMMENT 'Forecasted net cash flows from commodity price hedging instruments and derivative settlements, can be positive or negative.',
    `investing_cash_inflow_amount` DECIMAL(18,2) COMMENT 'Forecasted cash inflows from investing activities including asset disposals, divestments, and investment redemptions.',
    `investing_cash_outflow_amount` DECIMAL(18,2) COMMENT 'Forecasted cash outflows for investing activities including CAPEX (Capital Expenditure), exploration expenditure, and acquisitions.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this cash flow forecast record was last modified, supporting audit trail and version control.',
    `lom_plan_reference` STRING COMMENT 'Reference to the Life of Mine plan document or version from which long-term cash flow forecasts are derived.. Valid values are `^LOM-[0-9]{4}-[A-Z0-9]{4,8}$`',
    `net_cash_flow_amount` DECIMAL(18,2) COMMENT 'Forecasted net cash flow for the period, calculated as total inflows minus total outflows across all activity categories.',
    `opening_cash_balance_amount` DECIMAL(18,2) COMMENT 'Forecasted cash and cash equivalents balance at the beginning of the forecast period.',
    `operating_cash_inflow_amount` DECIMAL(18,2) COMMENT 'Forecasted cash inflows from operating activities including commodity sales revenue, by-product credits, and other operating receipts.',
    `operating_cash_outflow_amount` DECIMAL(18,2) COMMENT 'Forecasted cash outflows for operating activities including OPEX (Operating Expenditure), royalties, and operating taxes.',
    `opex_amount` DECIMAL(18,2) COMMENT 'Forecasted operating expenditure cash outflows including mining, processing, general and administrative costs.',
    `royalty_payment_amount` DECIMAL(18,2) COMMENT 'Forecasted cash outflows for mineral royalty payments to governments, landowners, and other royalty holders.',
    `sustaining_capex_amount` DECIMAL(18,2) COMMENT 'Forecasted sustaining capital expenditure required to maintain current production levels, included in AISC (All-In Sustaining Cost) calculations.',
    `tax_payment_amount` DECIMAL(18,2) COMMENT 'Forecasted cash outflows for corporate income tax, mining tax, and other tax obligations.',
    `variance_to_prior_forecast_amount` DECIMAL(18,2) COMMENT 'Variance between current forecast net cash flow and the prior forecast version, enabling forecast accuracy tracking and variance analysis.',
    `variance_to_prior_forecast_pct` DECIMAL(18,2) COMMENT 'Percentage variance between current forecast and prior forecast, calculated as (current - prior) / prior * 100.',
    CONSTRAINT pk_cash_flow_forecast PRIMARY KEY(`cash_flow_forecast_id`)
) COMMENT 'Periodic cash flow forecast record capturing projected operating, investing, and financing cash flows by mine site, commodity, legal entity, and forecast horizon (weekly, monthly, quarterly, LOM). Tracks forecast inflows from commodity sales, hedging settlements, and asset disposals against outflows for CAPEX, OPEX, royalties, tax, debt service, and dividends. Includes forecast version, approval status, and variance to prior forecast. Supports treasury planning, debt covenant compliance monitoring, dividend capacity assessment, and board liquidity reporting for capital-intensive mining operations.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`project_cost_allocation` (
    `project_cost_allocation_id` BIGINT COMMENT 'Unique surrogate key identifying each cost centre to capital project allocation record',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to the capital project receiving cost allocations from the cost centre',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to the cost centre that is allocating costs to the capital project',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Cost allocations should specify which GL account the allocation is for (e.g., labor, materials, equipment). This allows tracking allocation by cost element. Consistent with pattern where all allocatio',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Project_cost_allocation is an association product linking cost_centre to capital_project. It should also link to the specific WBS element within that project, as WBS elements are the granular project ',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the cost centres budget and actual costs allocated to this capital project during the effective period. Used for proportional cost distribution when a cost centre supports multiple concurrent projects.',
    `allocation_status` STRING COMMENT 'Current status of this cost allocation relationship: active (costs are being posted), suspended (temporarily paused), closed (allocation ended), pending_approval (awaiting finance approval). Supports allocation lifecycle management.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Specific budget amount allocated from this cost centre to this capital project for the effective period. Represents the portion of the cost centres annual budget earmarked for this projects activities.',
    `cost_category` STRING COMMENT 'Classification of the type of costs this cost centre contributes to the capital project (e.g., direct_labour, materials, equipment_hire, contractor_services, engineering, site_services, overhead, contingency). Enables cost build-up analysis and CAPEX category reporting.',
    `created_by_user` STRING COMMENT 'SAP user ID or employee identifier of the person who created this cost allocation record, supporting accountability and audit requirements.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this cost allocation record was created in the system, used for audit trail and allocation history tracking.',
    `effective_from_date` DATE COMMENT 'Start date from which this cost centre allocation to the capital project is active. Enables time-based cost allocation tracking as project phases change or cost centre responsibilities shift.',
    `effective_to_date` DATE COMMENT 'End date after which this cost centre allocation to the capital project is no longer active. NULL indicates an ongoing allocation. Supports historical tracking of cost centre assignments across project lifecycle.',
    `last_modified_by_user` STRING COMMENT 'SAP user ID or employee identifier of the person who last modified this allocation record, supporting change tracking and accountability.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this allocation record, tracking when allocation percentages or budget amounts were adjusted.',
    `notes` STRING COMMENT 'Free-text field for finance users to document the business rationale for this allocation, special circumstances, or allocation methodology notes.',
    CONSTRAINT pk_project_cost_allocation PRIMARY KEY(`project_cost_allocation_id`)
) COMMENT 'This association product represents the cost allocation relationship between cost centres and capital projects in the mining portfolio. It captures the financial assignment of cost centre budgets and expenditure tracking to capital projects over specific time periods. Each record links one cost centre to one capital project with allocation percentages, budget amounts, cost categories, and effective date ranges that exist only in the context of this project-cost relationship. This enables accurate CAPEX tracking, project cost build-up, and multi-cost-centre project accounting.. Existence Justification: In mining operations, capital projects routinely span multiple cost centres (e.g., a shaft sinking project uses site services, engineering, construction, and equipment hire cost centres), and cost centres concurrently support multiple capital projects (e.g., the site engineering cost centre allocates effort across brownfield expansion, tailings raise, and sustaining capital projects). Finance teams actively manage these allocations with specific percentages, budget amounts, time periods, and cost categories to enable accurate CAPEX tracking and project cost build-up.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`allocation_cycle` (
    `allocation_cycle_id` BIGINT COMMENT 'Primary key for allocation_cycle',
    `reversed_cycle_id` BIGINT COMMENT 'Reference to the allocation cycle that this cycle reverses, if this is a reversal cycle.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Allocation cycles typically originate from a source cost centre (e.g., shared services cost centre allocating to operational cost centres). The existing source_cost_pool (STRING) should be replaced wi',
    `prior_allocation_cycle_id` BIGINT COMMENT 'Self-referencing FK on allocation_cycle (prior_allocation_cycle_id)',
    `active_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this allocation cycle is currently active and available for use in financial reporting and analysis.',
    `allocation_basis` STRING COMMENT 'The basis or driver used for cost allocation in this cycle (e.g., headcount, production volume, machine hours, square footage).',
    `allocation_method` STRING COMMENT 'The cost allocation methodology applied in this cycle (direct, step-down, reciprocal, activity-based, proportional, or driver-based allocation).',
    `approval_date` DATE COMMENT 'The date on which this allocation cycle was formally approved.',
    `approval_required_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this allocation cycle requires formal approval before completion.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this allocation cycle, if approval was required and granted.',
    `cost_category` STRING COMMENT 'The primary cost category being allocated in this cycle, distinguishing between operational expenditure (OPEX), capital expenditure (CAPEX), exploration, development, sustaining, corporate, or shared services costs.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this allocation cycle record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which allocations are calculated and reported for this cycle.',
    `cycle_code` STRING COMMENT 'Business identifier code for the allocation cycle, used for external reference and reporting.',
    `cycle_name` STRING COMMENT 'Descriptive name of the allocation cycle for business user identification and reporting purposes.',
    `cycle_type` STRING COMMENT 'Classification of the allocation cycle based on frequency and purpose (monthly, quarterly, annual, ad-hoc, project-based, or interim).',
    `end_date` DATE COMMENT 'The date when the allocation cycle period ends, marking the conclusion of the financial period covered by this cycle.',
    `fiscal_period` STRING COMMENT 'The fiscal period number within the fiscal year (1-12 for monthly, 1-4 for quarterly) to which this allocation cycle applies.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this allocation cycle belongs, represented as a four-digit year.',
    `last_modified_by` STRING COMMENT 'Identifier or name of the user who last modified this allocation cycle record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this allocation cycle record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, explanations, or special instructions related to this allocation cycle.',
    `processing_end_timestamp` TIMESTAMP COMMENT 'The timestamp when allocation processing completed for this cycle.',
    `processing_start_timestamp` TIMESTAMP COMMENT 'The timestamp when allocation processing began for this cycle.',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this allocation cycle represents a reversal of a previous allocation.',
    `run_sequence_number` STRING COMMENT 'Sequential number indicating the iteration or run number of this allocation cycle, used when cycles are re-run or adjusted.',
    `start_date` DATE COMMENT 'The date when the allocation cycle period begins, marking the start of the financial period covered by this cycle.',
    `allocation_cycle_status` STRING COMMENT 'Current lifecycle status of the allocation cycle indicating its processing state.',
    `target_entity_type` STRING COMMENT 'The type of entity to which costs are being allocated (cost center, project, asset, mine site, business unit, or product).',
    `total_allocated_amount` DECIMAL(18,2) COMMENT 'The total monetary amount allocated across all cost centers and entities during this allocation cycle.',
    `created_by` STRING COMMENT 'Identifier or name of the user who created this allocation cycle record.',
    CONSTRAINT pk_allocation_cycle PRIMARY KEY(`allocation_cycle_id`)
) COMMENT 'Master reference table for allocation_cycle. Referenced by allocation_cycle_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
    `parent_entity_id` BIGINT COMMENT 'Reference to the immediate parent legal entity in the corporate ownership hierarchy. Null for ultimate parent entities.',
    `ultimate_parent_entity_id` BIGINT COMMENT 'Reference to the top-level parent legal entity in the corporate ownership hierarchy. Self-referencing for ultimate parent entities.',
    `parent_legal_entity_id` BIGINT COMMENT 'Self-referencing FK on legal_entity (parent_legal_entity_id)',
    `accounting_standard` STRING COMMENT 'The primary accounting standard framework used by the legal entity for financial reporting (e.g., IFRS, US GAAP, local GAAP).',
    `consolidation_method` STRING COMMENT 'The accounting method used to consolidate this entitys financial results into group reporting (full consolidation, proportionate consolidation, equity method, or no consolidation).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this legal entity record was first created in the system.',
    `data_source_system` STRING COMMENT 'The name of the source system from which this legal entity record originated (e.g., SAP FI/CO, Oracle Financials, corporate registry).',
    `dissolution_date` DATE COMMENT 'The date on which the legal entity was officially dissolved or deregistered. Null for active entities.',
    `effective_from_date` DATE COMMENT 'The date from which this legal entity record becomes effective for financial reporting and operational purposes.',
    `effective_to_date` DATE COMMENT 'The date until which this legal entity record is effective. Null for currently active records.',
    `entity_status` STRING COMMENT 'Current operational and legal status of the entity (e.g., active, dormant, in liquidation, dissolved, suspended).',
    `entity_type` STRING COMMENT 'Classification of the legal entity structure within the corporate hierarchy (e.g., subsidiary, parent company, joint venture, branch, division, partnership).',
    `external_auditor` STRING COMMENT 'The name of the external audit firm responsible for auditing the legal entitys financial statements.',
    `fiscal_year_end_day` STRING COMMENT 'The day of the month on which the legal entitys fiscal year ends, represented as an integer (1-31).',
    `fiscal_year_end_month` STRING COMMENT 'The month in which the legal entitys fiscal year ends, represented as an integer (1=January, 12=December).',
    `functional_currency` STRING COMMENT 'The primary currency of the economic environment in which the entity operates, using ISO 4217 three-letter currency codes.',
    `ifrs6_exploration_entity` BOOLEAN COMMENT 'Indicates whether the legal entity is engaged in exploration and evaluation of mineral resources and applies IFRS 6 accounting standards.',
    `incorporation_date` DATE COMMENT 'The date on which the legal entity was officially incorporated or registered with the relevant regulatory authority.',
    `incorporation_jurisdiction` STRING COMMENT 'The country or jurisdiction where the legal entity is incorporated or registered, using ISO 3166-1 alpha-3 country codes.',
    `industry_classification_code` STRING COMMENT 'The standardized industry classification code (e.g., ISIC, NAICS, SIC) identifying the entitys primary business sector.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this legal entity record is currently active and valid for use in financial transactions and reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this legal entity record was last updated or modified in the system.',
    `legal_name` STRING COMMENT 'The full registered legal name of the entity as recorded in official incorporation documents and regulatory filings.',
    `lei_code` STRING COMMENT 'The 20-character alphanumeric ISO 17442 Legal Entity Identifier code uniquely identifying the legal entity in global financial markets.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'The percentage of ownership held by the parent entity in this legal entity, expressed as a decimal (e.g., 100.00 for wholly-owned, 50.00 for 50% ownership).',
    `primary_business_activity` STRING COMMENT 'Description of the primary business activity or industry sector in which the legal entity operates (e.g., iron ore mining, copper extraction, coal production).',
    `registered_address_line1` STRING COMMENT 'The first line of the official registered address of the legal entity as recorded with the incorporation authority.',
    `registered_address_line2` STRING COMMENT 'The second line of the official registered address of the legal entity (optional, for additional address details).',
    `registered_city` STRING COMMENT 'The city or municipality of the legal entitys registered address.',
    `registered_country` STRING COMMENT 'The country of the legal entitys registered address, using ISO 3166-1 alpha-3 country codes.',
    `registered_postal_code` STRING COMMENT 'The postal or ZIP code of the legal entitys registered address.',
    `registered_state_province` STRING COMMENT 'The state, province, or region of the legal entitys registered address.',
    `registration_number` STRING COMMENT 'The official registration or company number assigned by the incorporation jurisdictions regulatory authority.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether the legal entity is subject to mandatory regulatory financial reporting requirements (e.g., SEC filings, ASX continuous disclosure).',
    `reporting_currency` STRING COMMENT 'The currency in which the entity presents its financial statements, using ISO 4217 three-letter currency codes.',
    `stock_exchange_listing` STRING COMMENT 'The stock exchange(s) on which the legal entitys securities are listed, if publicly traded (e.g., ASX, NYSE, LSE). Null for private entities.',
    `stock_ticker_symbol` STRING COMMENT 'The ticker symbol or trading code used to identify the legal entitys securities on stock exchanges. Null for private entities.',
    `tax_identification_number` STRING COMMENT 'The unique tax identification number assigned by the tax authority in the entitys primary tax jurisdiction.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master reference table for legal_entity. Referenced by legal_entity_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`finance`.`business_unit` (
    `business_unit_id` BIGINT COMMENT 'Primary key for business_unit',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Business units are typically mapped to cost centres for cost accounting. The existing cost_centre_code (STRING) should be replaced with proper FK to cost_centre.cost_centre_id. This allows joining to ',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the primary finance or accounting contact for this business unit.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that owns or operates this business unit for statutory reporting and compliance purposes.',
    `manager_employee_id` BIGINT COMMENT 'Reference to the employee who is the general manager or head of this business unit.',
    `parent_business_unit_id` BIGINT COMMENT 'Reference to the parent business unit in the organizational hierarchy. Null for top-level business units.',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Business units are typically mapped to profit centres for P&L reporting. The existing profit_centre_code (STRING) should be replaced with proper FK to profit_centre.profit_centre_id. This allows joini',
    `address_line_1` STRING COMMENT 'Primary street address of the business unit facility or office.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building name, floor, or suite number.',
    `aisc_reporting_flag` BOOLEAN COMMENT 'Indicates whether this business unit is included in consolidated AISC reporting for investor disclosures.',
    `annual_production_capacity_tonnes` DECIMAL(18,2) COMMENT 'Maximum annual production capacity of the business unit measured in metric tonnes. Applicable to mine sites and processing plants.',
    `c1_cash_cost_reporting_flag` BOOLEAN COMMENT 'Indicates whether this business unit reports C1 cash costs, a key performance metric in copper and base metals mining.',
    `city` STRING COMMENT 'City or town where the business unit is located.',
    `closure_date` DATE COMMENT 'Date when the business unit ceased operations or was decommissioned. Null for active business units.',
    `business_unit_code` STRING COMMENT 'Short alphanumeric code used to identify the business unit in financial systems and reports. Typically used in SAP FI/CO postings and management reporting.',
    `commodity_focus` STRING COMMENT 'Primary mineral or commodity that this business unit extracts, processes, or manages.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the business unit is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this business unit record was first created in the system.',
    `effective_from_date` DATE COMMENT 'Date from which this business unit record is effective for financial reporting and organizational purposes.',
    `effective_to_date` DATE COMMENT 'Date until which this business unit record is effective. Null for current records.',
    `environmental_permit_number` STRING COMMENT 'Primary environmental operating permit or license number issued by regulatory authorities.',
    `establishment_date` DATE COMMENT 'Date when the business unit was formally established or commenced operations.',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO currency code representing the primary currency used for financial reporting and budgeting at this business unit.',
    `ifrs_6_exploration_flag` BOOLEAN COMMENT 'Indicates whether this business unit is subject to IFRS 6 exploration and evaluation asset accounting treatment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this business unit record was last updated.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the business unit location in decimal degrees, used for spatial analysis and logistics planning.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the business unit location in decimal degrees, used for spatial analysis and logistics planning.',
    `mining_lease_number` STRING COMMENT 'Government-issued mining lease or concession number authorizing mineral extraction at this location.',
    `business_unit_name` STRING COMMENT 'Full legal or operational name of the business unit.',
    `operating_model` STRING COMMENT 'Business model under which the business unit operates, affecting cost structure and financial reporting.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the business unit location.',
    `region_code` STRING COMMENT 'Three-letter code representing the geographic region where the business unit operates (e.g., AUS for Australia, CHL for Chile, CAN for Canada).',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO currency code used for consolidated group reporting. May differ from functional currency.',
    `royalty_regime` STRING COMMENT 'Description of the mining royalty regime applicable to this business unit, including rate structure and calculation basis.',
    `short_name` STRING COMMENT 'Abbreviated name of the business unit used in reports and dashboards where space is limited.',
    `state_province` STRING COMMENT 'State or province where the business unit is located, relevant for regional taxation and regulatory compliance.',
    `business_unit_status` STRING COMMENT 'Current operational status of the business unit. Care and maintenance indicates temporary suspension with minimal staffing.',
    `tax_jurisdiction_code` STRING COMMENT 'Code representing the primary tax jurisdiction applicable to this business unit for income tax and royalty calculations.',
    `business_unit_type` STRING COMMENT 'Classification of the business unit based on its primary operational function within the mining value chain.',
    CONSTRAINT pk_business_unit PRIMARY KEY(`business_unit_id`)
) COMMENT 'Master reference table for business_unit. Referenced by business_unit_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ADD CONSTRAINT `fk_finance_cost_centre_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_parent_wbs_element_id` FOREIGN KEY (`parent_wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `mining_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ADD CONSTRAINT `fk_finance_capex_budget_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ADD CONSTRAINT `fk_finance_capex_budget_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ADD CONSTRAINT `fk_finance_capex_budget_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ADD CONSTRAINT `fk_finance_capex_budget_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ADD CONSTRAINT `fk_finance_opex_budget_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ADD CONSTRAINT `fk_finance_opex_budget_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ADD CONSTRAINT `fk_finance_opex_budget_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ADD CONSTRAINT `fk_finance_opex_budget_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_allocation_cycle_id` FOREIGN KEY (`allocation_cycle_id`) REFERENCES `mining_ecm`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ADD CONSTRAINT `fk_finance_cost_performance_report_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ADD CONSTRAINT `fk_finance_cost_performance_report_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ADD CONSTRAINT `fk_finance_cost_performance_report_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ADD CONSTRAINT `fk_finance_cost_performance_report_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ADD CONSTRAINT `fk_finance_project_valuation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ADD CONSTRAINT `fk_finance_royalty_obligation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ADD CONSTRAINT `fk_finance_royalty_obligation_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ADD CONSTRAINT `fk_finance_royalty_obligation_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ADD CONSTRAINT `fk_finance_royalty_obligation_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ADD CONSTRAINT `fk_finance_exploration_expenditure_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ADD CONSTRAINT `fk_finance_exploration_expenditure_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ADD CONSTRAINT `fk_finance_exploration_expenditure_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ADD CONSTRAINT `fk_finance_exploration_expenditure_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ADD CONSTRAINT `fk_finance_rehabilitation_provision_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ADD CONSTRAINT `fk_finance_rehabilitation_provision_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ADD CONSTRAINT `fk_finance_rehabilitation_provision_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ADD CONSTRAINT `fk_finance_rehabilitation_provision_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ADD CONSTRAINT `fk_finance_hedge_instrument_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ADD CONSTRAINT `fk_finance_hedge_instrument_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ADD CONSTRAINT `fk_finance_hedge_instrument_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ADD CONSTRAINT `fk_finance_hedge_instrument_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ADD CONSTRAINT `fk_finance_tax_obligation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ADD CONSTRAINT `fk_finance_tax_obligation_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ADD CONSTRAINT `fk_finance_tax_obligation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ADD CONSTRAINT `fk_finance_tax_obligation_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ADD CONSTRAINT `fk_finance_tax_obligation_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_superseded_cash_flow_forecast_id` FOREIGN KEY (`superseded_cash_flow_forecast_id`) REFERENCES `mining_ecm`.`finance`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ADD CONSTRAINT `fk_finance_project_cost_allocation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ADD CONSTRAINT `fk_finance_project_cost_allocation_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ADD CONSTRAINT `fk_finance_project_cost_allocation_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_reversed_cycle_id` FOREIGN KEY (`reversed_cycle_id`) REFERENCES `mining_ecm`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `mining_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_prior_allocation_cycle_id` FOREIGN KEY (`prior_allocation_cycle_id`) REFERENCES `mining_ecm`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_entity_id` FOREIGN KEY (`parent_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_ultimate_parent_entity_id` FOREIGN KEY (`ultimate_parent_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_parent_business_unit_id` FOREIGN KEY (`parent_business_unit_id`) REFERENCES `mining_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `mining_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `mining_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Identifier');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `aisc_component` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) Component');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|assessment|distribution|activity_allocation|none');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `budget_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `budget_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `budget_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Fiscal Year');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `c1_cost_component` SET TAGS ('dbx_business_glossary_term' = 'C1 Cash Cost Component');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Primary Commodity');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Category');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_category` SET TAGS ('dbx_value_regex' = 'production|service|overhead|administration|investment');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Code');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Name');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Status');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_status` SET TAGS ('dbx_value_regex' = 'active|inactive|locked|pending_approval|closed');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Type (Operating Expenditure / Capital Expenditure)');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_type` SET TAGS ('dbx_value_regex' = 'opex|capex|shared_service|exploration');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Group');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,10}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `gl_account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `gl_account_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,10}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `hierarchy_area` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Hierarchy Area');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `hierarchy_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `is_statistical` SET TAGS ('dbx_business_glossary_term' = 'Statistical Cost Centre Indicator');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Long Description');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `responsible_manager` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `responsible_manager_personnel_no` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Personnel Number');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `responsible_manager_personnel_no` SET TAGS ('dbx_value_regex' = '^[0-9]{1,8}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Code');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,10}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|MANUAL|MIGRATION');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `user_responsible` SET TAGS ('dbx_business_glossary_term' = 'User Responsible');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,24}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `mining_ecm`.`finance`.`cost_centre` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `account_currency` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Currency');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `account_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `account_long_description` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Long Description');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,10}$');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|marked_for_deletion');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'balance_sheet|profit_and_loss|nonoperating_expense|nonoperating_income');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `aisc_cost_category` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) Category');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_business_glossary_term' = 'Alternative Account Number (Country Chart of Accounts)');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `alternative_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `balance_sheet_category` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Category');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `changed_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Changed By User');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) Code');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `commitment_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Commitment Management Flag');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `cost_centre_relevance` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Relevance Flag');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category (SAP CO)');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `deletion_flag` SET TAGS ('dbx_business_glossary_term' = 'Deletion Flag');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `expenditure_classification` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Classification (OPEX/CAPEX)');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `expenditure_classification` SET TAGS ('dbx_value_regex' = 'opex|capex|exploration|rehabilitation|sustaining_capex|growth_capex');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `field_status_group` SET TAGS ('dbx_business_glossary_term' = 'Field Status Group');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `field_status_group` SET TAGS ('dbx_value_regex' = '^G[0-9]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `financial_statement_item` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Item Classification');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `ifrs6_exploration_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS 6 Exploration Expenditure Flag');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `interest_calculation_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Calculation Flag');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `last_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Changed Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `line_item_display_flag` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Flag');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `open_item_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Flag');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `planning_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Planning Block Flag');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `posting_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Block Flag');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `profit_centre_relevance` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Relevance Flag');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `reconciliation_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Flag');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `rehabilitation_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Mine Rehabilitation Provision Flag');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `royalty_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Royalty Account Flag');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Sort Key');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `sort_key` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_value_regex' = 'input_tax|output_tax|not_relevant|exempt');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `tolerance_group` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Group');
ALTER TABLE `mining_ecm`.`finance`.`general_ledger_account` ALTER COLUMN `wbs_element_relevance` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Relevance Flag');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre ID');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `aisc_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) Reporting Flag');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `c1_cost_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'C1 Cash Cost Reporting Flag');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO) Code');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `cost_centre_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Group');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `exploration_accounting_flag` SET TAGS ('dbx_business_glossary_term' = 'Exploration Accounting Flag');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `hierarchy_node` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Hierarchy Node');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `ifrs_segment_flag` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Segment Flag');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `jorc_resource_category` SET TAGS ('dbx_business_glossary_term' = 'Joint Ore Reserves Committee (JORC) Resource Category');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `jorc_resource_category` SET TAGS ('dbx_value_regex' = 'measured|indicated|inferred|not_applicable');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `lom_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan Reference');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `profit_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Code');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `profit_centre_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `profit_centre_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Description');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `profit_centre_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Name');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `profit_centre_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Status');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `profit_centre_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|planned');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `profit_centre_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Type');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `profit_centre_type` SET TAGS ('dbx_value_regex' = 'mine_site|processing_plant|commodity_business_unit|corporate_function|exploration_division|logistics_hub');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `reserve_category` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Category');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `reserve_category` SET TAGS ('dbx_value_regex' = 'proved|probable|not_applicable');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Segment Code');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Short Name');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `mining_ecm`.`finance`.`profit_centre` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Definition ID');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre ID');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person ID');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `parent_wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre ID');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `applicant_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Name');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `applicant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `applicant_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `asset_under_construction_flag` SET TAGS ('dbx_business_glossary_term' = 'Asset Under Construction (AUC) Flag');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `committed_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost Amount');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `functional_area` SET TAGS ('dbx_value_regex' = 'mining|processing|exploration|infrastructure|rehabilitation|logistics');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `ifrs6_exploration_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS 6 Exploration and Evaluation Flag');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `investment_program` SET TAGS ('dbx_business_glossary_term' = 'Investment Program');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `jorc_reserve_category` SET TAGS ('dbx_business_glossary_term' = 'Joint Ore Reserves Committee (JORC) Reserve Category');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `jorc_reserve_category` SET TAGS ('dbx_value_regex' = 'proved|probable|not_applicable');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `mine_site_code` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Code');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `mine_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `planning_plant` SET TAGS ('dbx_business_glossary_term' = 'Planning Plant');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `planning_plant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `project_category` SET TAGS ('dbx_business_glossary_term' = 'Project Category');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `project_category` SET TAGS ('dbx_value_regex' = 'capex|opex|exploration|rehabilitation|sustaining|expansion');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `settlement_rule_exists` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule Exists Flag');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `system_status` SET TAGS ('dbx_business_glossary_term' = 'System Status');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `system_status` SET TAGS ('dbx_value_regex' = 'created|released|technically_completed|closed|locked');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `user_status` SET TAGS ('dbx_business_glossary_term' = 'User Status');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-.]{1,24}$');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_description` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Description');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_type` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Type');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_type` SET TAGS ('dbx_value_regex' = 'planning|account_assignment|billing|statistical');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_level` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Hierarchy Level');
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posting User Identifier (ID)');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Number');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `asset_subnumber` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Subnumber');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Document Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_header_text` SET TAGS ('dbx_business_glossary_term' = 'Document Header Text');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Document Number');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Document Type');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_time` SET TAGS ('dbx_business_glossary_term' = 'Entry Time');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Indicator');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `internal_order` SET TAGS ('dbx_business_glossary_term' = 'Internal Order (CO)');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_value_regex' = '0L|1L|2L|3L|9L');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `parked_indicator` SET TAGS ('dbx_business_glossary_term' = 'Parked Document Indicator');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = '01|02|03|04|05');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `trading_partner_company_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Company Code');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Amount');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line Identifier (ID)');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Transaction Currency');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `asset_subnumber` SET TAGS ('dbx_business_glossary_term' = 'Asset Subnumber');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `asset_subnumber` SET TAGS ('dbx_value_regex' = '^[0-9]{1,4}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_text` SET TAGS ('dbx_business_glossary_term' = 'Assignment Text');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `customer_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Code');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `customer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,18}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_key_1` SET TAGS ('dbx_business_glossary_term' = 'Reference Key 1');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_key_2` SET TAGS ('dbx_business_glossary_term' = 'Reference Key 2');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_key_3` SET TAGS ('dbx_business_glossary_term' = 'Reference Key 3');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount in Local Currency');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Code');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `trading_partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `mining_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` SET TAGS ('dbx_subdomain' = 'investment_planning');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `capex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Budget ID');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Capital Expenditure (CAPEX) Spend Amount');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `aisc_contribution_usd` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) Contribution (USD)');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `aisc_contribution_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Capital Approval Authority');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `approval_authority` SET TAGS ('dbx_value_regex' = 'Board|Executive Committee|CFO|General Manager|Site Manager');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Date');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Capital Expenditure (CAPEX) Budget Amount');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `budget_revision_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Number');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Capital Budget Status');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'Draft|Submitted|Approved|Revised|Closed|Cancelled');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `capex_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Category');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `capex_category` SET TAGS ('dbx_value_regex' = 'Sustaining|Growth|Exploration|Rehabilitation|IT');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `capitalisation_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Capitalisation Date');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Capital Amount');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Contingency Amount');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `discount_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percentage');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Rate');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `forecast_at_completion_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast at Completion (FAC) Amount');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `forecast_at_completion_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `forecast_to_complete_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast to Complete (FTC) Amount');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `forecast_to_complete_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `irr_pct` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR) Percentage');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `irr_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `is_lom_capital` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Capital Flag');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `is_sustaining_capex` SET TAGS ('dbx_business_glossary_term' = 'Sustaining Capital Expenditure (CAPEX) Flag');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `lom_plan_year` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan Year');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `npv_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) Amount');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `npv_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `opex_capex_split_pct` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure / Capital Expenditure (OPEX/CAPEX) Split Percentage');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Code');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Capital Project End Date');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Phase');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'Exploration|Feasibility|Construction|Commissioning|Operations|Closure');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Start Date');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `revised_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Capital Expenditure (CAPEX) Budget Amount');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `revised_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Reason');
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` SET TAGS ('dbx_subdomain' = 'investment_planning');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `opex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Budget ID');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Employee ID');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `budget_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Cycle Code');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `budget_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Description');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `budget_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget End Date');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `budget_quantity` SET TAGS ('dbx_business_glossary_term' = 'Budget Quantity');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `budget_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Reference Number');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `budget_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Start Date');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|locked|closed');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `budget_version` SET TAGS ('dbx_value_regex' = 'original|revised_1|revised_2|revised_3|forecast|reforecast');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Cost Category');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'mining|processing|maintenance|administration|hse|logistics');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast Amount');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `is_capitalised` SET TAGS ('dbx_business_glossary_term' = 'Is Capitalised Flag');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `is_lom_included` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan Included Flag');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `last_revised_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revised Date');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `mine_site_code` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Code');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `opex_classification` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Classification');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `opex_classification` SET TAGS ('dbx_value_regex' = 'c1_cash_cost|aisc|sustaining_capital|non_sustaining|corporate');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `revised_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `revised_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|HEXAGON_MINEPLAN|DESWIK|MANUAL');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation ID');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle ID');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `activity_rate` SET TAGS ('dbx_business_glossary_term' = 'Activity Rate');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Type Code');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `aisc_component` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) Component');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `aisc_component` SET TAGS ('dbx_value_regex' = 'mining|processing|general_and_admin|royalties|sustaining_capital|by_product_credit');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount (USD)');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Type');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_type` SET TAGS ('dbx_value_regex' = 'activity_rate|statistical_key_figure|percentage|fixed_amount|equivalence_number');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_unit` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Unit of Measure');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_value` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Value');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_document_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Document Number');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_run_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Run Type');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_run_type` SET TAGS ('dbx_value_regex' = 'actual|plan|simulated');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|simulated|error|cancelled');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'assessment|distribution|activity_allocation|template_allocation|periodic_reposting');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `c1_cost_component` SET TAGS ('dbx_business_glossary_term' = 'C1 Cash Cost Component');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `c1_cost_component` SET TAGS ('dbx_value_regex' = 'mining|processing|site_general_admin|transport|royalties|treatment_refining');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category (OPEX/CAPEX)');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'opex|capex|sustaining_capital|exploration');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_element_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Name');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cycle_run_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Run Date');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Is Intercompany Allocation Flag');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal Flag');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `mine_site_code` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Code');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `original_document_number` SET TAGS ('dbx_business_glossary_term' = 'Original Allocation Document Number');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `receiver_cost_centre` SET TAGS ('dbx_business_glossary_term' = 'Receiver Cost Centre');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `receiver_cost_centre_name` SET TAGS ('dbx_business_glossary_term' = 'Receiver Cost Centre Name');
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` SET TAGS ('dbx_subdomain' = 'investment_planning');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `cost_performance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Performance Report Identifier');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre ID');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `aisc_guidance_high` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) Guidance High (USD per Unit)');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `aisc_guidance_high` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `aisc_guidance_low` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) Guidance Low (USD per Unit)');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `aisc_guidance_low` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `budget_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Budget Unit Cost (USD per Unit)');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `budget_unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `byproduct_credit` SET TAGS ('dbx_business_glossary_term' = 'By-Product Credit');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `byproduct_credit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Commodity');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `cost_variance_driver` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Driver');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `fx_rate_to_usd` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate to USD');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `ga_cost` SET TAGS ('dbx_business_glossary_term' = 'General and Administrative (G&A) Cost');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `ga_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `head_grade` SET TAGS ('dbx_business_glossary_term' = 'Head Grade');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `is_guidance_met` SET TAGS ('dbx_business_glossary_term' = 'Is Guidance Met Flag');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `mining_opex` SET TAGS ('dbx_business_glossary_term' = 'Mining Operating Expenditure (OPEX)');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `mining_opex` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `prior_period_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Unit Cost (USD per Unit)');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `prior_period_unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `processing_opex` SET TAGS ('dbx_business_glossary_term' = 'Processing Operating Expenditure (OPEX)');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `processing_opex` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `production_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `production_volume` SET TAGS ('dbx_business_glossary_term' = 'Production Volume');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `recovery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Recovery Rate Percentage');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `refining_and_transport_cost` SET TAGS ('dbx_business_glossary_term' = 'Refining and Transport Cost');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `refining_and_transport_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Cost Performance Report Number');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `report_number` SET TAGS ('dbx_value_regex' = '^CPR-[0-9]{4}-[0-9]{2}-[A-Z0-9]{4,10}$');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|published|superseded');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Report Type');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'aisc|c1_cash_cost|c2_total_cost|c3_full_cost');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Type');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|half_yearly|annual');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `royalty_cost` SET TAGS ('dbx_business_glossary_term' = 'Royalty Cost');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `royalty_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `strip_ratio` SET TAGS ('dbx_business_glossary_term' = 'Strip Ratio (Overburden to Ore Ratio)');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `sustaining_capex` SET TAGS ('dbx_business_glossary_term' = 'Sustaining Capital Expenditure (CAPEX)');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `sustaining_capex` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `total_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Cost (USD)');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `total_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `unit_cost_result` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost Result (USD per Unit)');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `unit_cost_result` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `variance_to_budget_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance to Budget Percentage');
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ALTER COLUMN `variance_to_prior_period_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance to Prior Period Percentage');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` SET TAGS ('dbx_subdomain' = 'investment_planning');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `project_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Project Valuation ID');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre ID');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `aisc_usd` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) (USD per Unit)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `aisc_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `breakeven_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Breakeven Commodity Price (USD per Unit)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `breakeven_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `c1_cash_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'C1 Cash Cost (USD per Unit)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `c1_cash_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `capex_total_musd` SET TAGS ('dbx_business_glossary_term' = 'Total Capital Expenditure (CAPEX) (Million USD)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `capex_total_musd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `commodity_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Commodity Price Deck (USD per Unit)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `commodity_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `country_risk_premium_pct` SET TAGS ('dbx_business_glossary_term' = 'Country Risk Premium (Percentage)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `country_risk_premium_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `discount_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate (Percentage)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `discount_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `head_grade_pct` SET TAGS ('dbx_business_glossary_term' = 'Head Grade (Percentage)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `inflation_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Inflation Rate (Percentage)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `irr_pct` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR) (Percentage)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `irr_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `mine_life_years` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Years');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Valuation Notes');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `npv_base_musd` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) Base Case (Million USD)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `npv_base_musd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `npv_high_musd` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) High Case (Million USD)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `npv_high_musd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `npv_low_musd` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) Low Case (Million USD)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `npv_low_musd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `opex_unit_usd` SET TAGS ('dbx_business_glossary_term' = 'Unit Operating Expenditure (OPEX) (USD per Tonne)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `opex_unit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `ore_reserve_category` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Category');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `ore_reserve_category` SET TAGS ('dbx_value_regex' = 'proved|probable|indicated|measured|inferred');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `payback_period_years` SET TAGS ('dbx_business_glossary_term' = 'Payback Period (Years)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Prepared By');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `price_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Basis');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `price_basis` SET TAGS ('dbx_value_regex' = 'real|nominal');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `production_rate_mtpa` SET TAGS ('dbx_business_glossary_term' = 'Production Rate (Million Tonnes Per Annum)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `recovery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Recovery Rate (Percentage)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `royalty_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate (Percentage)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `royalty_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `strip_ratio` SET TAGS ('dbx_business_glossary_term' = 'Strip Ratio (Overburden to Ore Ratio)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `study_stage` SET TAGS ('dbx_business_glossary_term' = 'Study Stage');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `study_stage` SET TAGS ('dbx_value_regex' = 'scoping|pfs|dfs|bfs|update');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `tax_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Corporate Tax Rate (Percentage)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `tax_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `total_ore_reserve_mt` SET TAGS ('dbx_business_glossary_term' = 'Total Ore Reserve (Million Tonnes)');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `valuation_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Code');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `valuation_code` SET TAGS ('dbx_value_regex' = '^VAL-[A-Z0-9]{4,12}-[0-9]{4}$');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `valuation_name` SET TAGS ('dbx_business_glossary_term' = 'Valuation Name');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|superseded|archived');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'greenfield|brownfield|acquisition|divestment|exploration');
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `royalty_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation ID');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `accrued_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Royalty Liability Amount');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `accrued_liability_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `aisc_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) Inclusion Flag');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `c1_cost_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'C1 Cash Cost Inclusion Flag');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation Basis');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_value_regex' = 'gross_revenue|net_revenue|free_on_board|cost_insurance_freight|net_smelter_return|net_profit');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Commodity');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Royalty Dispute Description');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `dispute_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Royalty Dispute Flag');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation Effective From Date');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation Effective To Date');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `exemption_basis` SET TAGS ('dbx_business_glossary_term' = 'Royalty Exemption Basis');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Royalty Exemption Flag');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `governing_legislation` SET TAGS ('dbx_business_glossary_term' = 'Governing Legislation');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Royalty Jurisdiction');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Royalty Payment Amount');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Royalty Payment Date');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `mine_site_code` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Code');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `minimum_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Royalty Amount');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `minimum_royalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation Notes');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation Number');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_value_regex' = '^ROY-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation Status');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending|under_review');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payee Name');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `payee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `payee_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payee Type');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `payee_type` SET TAGS ('dbx_value_regex' = 'government|landowner|native_title|joint_venture|other');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `payment_due_day` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment Due Day');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment Frequency');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|on_demand');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `price_reference` SET TAGS ('dbx_business_glossary_term' = 'Royalty Price Reference');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `price_reference` SET TAGS ('dbx_value_regex' = 'lme_spot|platts_index|contract_price|realized_price|benchmark_price');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `production_volume_basis` SET TAGS ('dbx_business_glossary_term' = 'Production Volume Basis');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `production_volume_basis` SET TAGS ('dbx_value_regex' = 'rom_tonnes|dry_metric_tonnes|wet_metric_tonnes|contained_metal|concentrate_tonnes');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `rate_review_date` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Review Date');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Unit');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'percent_revenue|per_tonne|per_dmt|per_wmt|per_unit|percent_profit');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Reporting Period Type');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_value_regex' = 'calendar_month|calendar_quarter|financial_year|calendar_year');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `royalty_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Type');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `royalty_type` SET TAGS ('dbx_value_regex' = 'ad_valorem|specific|profit_based|production_based|hybrid');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Vendor Code');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` SET TAGS ('dbx_subdomain' = 'investment_planning');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `exploration_expenditure_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Expenditure Identifier');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `accumulated_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Exploration Expenditure Amount');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `accumulated_expenditure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `amount_functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Amount in Functional Currency');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `amount_functional_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Approval Date');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `area_of_interest_code` SET TAGS ('dbx_business_glossary_term' = 'Area of Interest Code');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `area_of_interest_name` SET TAGS ('dbx_business_glossary_term' = 'Area of Interest Name');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Exploration Budget Amount');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `capitalisation_status` SET TAGS ('dbx_business_glossary_term' = 'Capitalisation Status');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `capitalisation_status` SET TAGS ('dbx_value_regex' = 'capitalised|expensed|pending_review|reclassified|written_off');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Exploration Expenditure Amount');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `expenditure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `expenditure_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) / Operating Expenditure (OPEX) Category');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `expenditure_category` SET TAGS ('dbx_value_regex' = 'capex|opex');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `expenditure_date` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Date');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `expenditure_description` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Description');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `expenditure_type` SET TAGS ('dbx_business_glossary_term' = 'Exploration Expenditure Type');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `exploration_stage` SET TAGS ('dbx_business_glossary_term' = 'Exploration Stage');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `exploration_stage` SET TAGS ('dbx_value_regex' = 'grassroots|target_generation|resource_definition|prefeasibility|feasibility|development_ready');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss Amount');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `impairment_indicator_present` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator Present Flag');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `metres_drilled` SET TAGS ('dbx_business_glossary_term' = 'Metres Drilled');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `mineral_commodity` SET TAGS ('dbx_business_glossary_term' = 'Target Mineral Commodity');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'SAP Posting Date');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Exploration Project Code');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `reclassification_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Reclassification Date');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Mineral Resource Reporting Standard');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_value_regex' = 'JORC|NI_43-101|SAMREC|SEC_SK1300');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Document Number');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `technical_feasibility_date` SET TAGS ('dbx_business_glossary_term' = 'Technical Feasibility Determination Date');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `technical_feasibility_determined` SET TAGS ('dbx_business_glossary_term' = 'Technical Feasibility Determined Flag');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `rehabilitation_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Provision ID');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre ID');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `actual_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Expenditure Drawdown Amount');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `actual_expenditure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `aisc_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) Inclusion Flag');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `bond_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Bond Expiry Date');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `bond_instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Bond Instrument Type');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `bond_instrument_type` SET TAGS ('dbx_value_regex' = 'bank_guarantee|cash_deposit|insurance_bond|letter_of_credit|surety_bond');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `closing_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance Amount');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `closing_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `cost_estimate_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Basis');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `cost_estimate_basis` SET TAGS ('dbx_value_regex' = 'internal_estimate|independent_review|regulatory_assessment|lom_plan_derived');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `discount_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percentage');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `disturbance_area_ha` SET TAGS ('dbx_business_glossary_term' = 'Disturbance Area (Hectares)');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `expected_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Mine Closure Date');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `inflation_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Inflation Rate Percentage');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `last_estimate_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cost Estimate Review Date');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `new_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'New Provision Amount');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `new_provision_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `next_estimate_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Cost Estimate Review Date');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `opening_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance Amount');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `opening_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `opex_capex_classification` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) / Capital Expenditure (CAPEX) Classification');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `opex_capex_classification` SET TAGS ('dbx_value_regex' = 'opex|capex');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `provision_notes` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Provision Notes');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `provision_reference` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Provision Reference Number');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `provision_reference` SET TAGS ('dbx_value_regex' = '^REHAB-[A-Z0-9]{3,10}-[0-9]{4}$');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `provision_status` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Provision Status');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `provision_status` SET TAGS ('dbx_value_regex' = 'active|revised|settled|closed|under_review');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `provision_type` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Provision Type');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `provision_type` SET TAGS ('dbx_value_regex' = 'decommissioning|rehabilitation|environmental_restoration|tailings_remediation|water_treatment|infrastructure_removal');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Provision Recognition Date');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `regulatory_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rehabilitation Bond Amount');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `regulatory_bond_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `rehabilitation_completed_area_ha` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Completed Area (Hectares)');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `revision_amount` SET TAGS ('dbx_business_glossary_term' = 'Provision Revision Amount');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `revision_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `sap_provision_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Provision Document Number');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `tsf_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) Related Flag');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `undiscounted_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Undiscounted Rehabilitation Cost Estimate');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `undiscounted_cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `unwinding_of_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Unwinding of Discount Amount');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `unwinding_of_discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ALTER COLUMN `years_to_closure` SET TAGS ('dbx_business_glossary_term' = 'Years to Mine Closure');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'investment_planning');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_responsible_person` SET TAGS ('dbx_business_glossary_term' = 'Asset Responsible Person');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|under_construction|retired|disposed|impaired|transferred');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_sub_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Sub-Number');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capex_budget_code` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Budget Code');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalisation_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalisation Date');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_key` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Key');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|units_of_production|declining_balance|sum_of_years_digits|no_depreciation');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `ifrs6_exploration_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS 6 Exploration Asset Flag');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insured_value` SET TAGS ('dbx_business_glossary_term' = 'Insured Value');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insured_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Code');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lom_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan Reference');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `residual_value` SET TAGS ('dbx_business_glossary_term' = 'Residual Value (Scrap Value)');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `residual_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `revaluation_amount` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Amount');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `revaluation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|INFOR_EAM|MANUAL');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Commodity');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_date` SET TAGS ('dbx_business_glossary_term' = 'Elimination Date');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Elimination Status');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_value_regex' = 'pending|eliminated|not_required|manual_adjustment');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Code');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Company Code');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'open|partially_settled|fully_settled|overdue|disputed');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_category` SET TAGS ('dbx_business_glossary_term' = 'Transaction Category');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_category` SET TAGS ('dbx_value_regex' = 'goods|services|financing|equity|allocation');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_document_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Document Number');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Documentation Reference');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'cost_plus|market_price|negotiated|arms_length|comparable_uncontrolled_price');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `mining_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `hedge_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Hedge Instrument ID');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `aisc_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) Inclusion Flag');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `c1_cost_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'C1 Cash Cost Inclusion Flag');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `counterparty_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Credit Rating');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `cumulative_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Gain or Loss');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `cumulative_gain_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `hedge_accounting_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Accounting Designation');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `hedge_accounting_designation` SET TAGS ('dbx_value_regex' = 'fair_value_hedge|cash_flow_hedge|net_investment_hedge|not_designated');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `hedge_effectiveness_ratio_pct` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Ratio Percentage');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `hedge_effectiveness_test_method` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Test Method');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `hedge_ratio` SET TAGS ('dbx_business_glossary_term' = 'Hedge Ratio');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `hedged_item_description` SET TAGS ('dbx_business_glossary_term' = 'Hedged Item Description');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `instrument_category` SET TAGS ('dbx_business_glossary_term' = 'Instrument Category');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `instrument_category` SET TAGS ('dbx_value_regex' = 'commodity_price_hedge|foreign_currency_hedge|interest_rate_hedge');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `instrument_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Reference Number');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `instrument_status` SET TAGS ('dbx_business_glossary_term' = 'Instrument Status');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `instrument_status` SET TAGS ('dbx_value_regex' = 'active|matured|settled|terminated|cancelled');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'commodity_forward|commodity_option|fx_forward|fx_option|interest_rate_swap|commodity_swap');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `last_effectiveness_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Effectiveness Test Date');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `mark_to_market_value` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Value');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `mark_to_market_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `mtm_valuation_currency` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Valuation Currency');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `mtm_valuation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `mtm_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Valuation Date');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Amount');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `notional_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Notional Unit of Measure');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `option_style` SET TAGS ('dbx_business_glossary_term' = 'Option Style');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `option_style` SET TAGS ('dbx_value_regex' = 'european|american|asian|not_applicable');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `option_type` SET TAGS ('dbx_business_glossary_term' = 'Option Type');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `option_type` SET TAGS ('dbx_value_regex' = 'call|put|not_applicable');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `premium_currency` SET TAGS ('dbx_business_glossary_term' = 'Premium Currency');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `premium_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `premium_paid` SET TAGS ('dbx_business_glossary_term' = 'Premium Paid');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `premium_paid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Document Number');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `strike_price` SET TAGS ('dbx_business_glossary_term' = 'Strike Price');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `strike_price_currency` SET TAGS ('dbx_business_glossary_term' = 'Strike Price Currency');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `strike_price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `underlying_commodity` SET TAGS ('dbx_business_glossary_term' = 'Underlying Commodity');
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `underlying_currency_pair` SET TAGS ('dbx_business_glossary_term' = 'Underlying Currency Pair');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `tax_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Obligation ID');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `aisc_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) Inclusion Flag');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Commodity');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `current_tax_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Tax Liability Amount');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `deferred_tax_asset_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Asset (DTA) Amount');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `deferred_tax_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Liability (DTL) Amount');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `effective_tax_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Effective Tax Rate (ETR) Percentage');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `mine_site_code` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Code');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `mine_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Tax Obligation Reference Number');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Document Number');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `statutory_tax_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Statutory Tax Rate Percentage');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `tax_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Adjustment Amount');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `tax_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Name');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `tax_instalment_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Instalment Amount');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}(-[A-Z0-9]{2,6})?$');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `tax_loss_carryforward_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Loss Carryforward Amount');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `tax_loss_carryforward_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `tax_return_reference` SET TAGS ('dbx_business_glossary_term' = 'Tax Return Reference');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `taxable_income_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Income Amount');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `taxable_income_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`tax_obligation` ALTER COLUMN `total_obligation_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Obligation Amount');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `procurement_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `aisc_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) Inclusion Flag');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `c1_cost_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'C1 Cash Cost Inclusion Flag');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `dispute_raised_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Date');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `dispute_resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Action');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `dispute_resolved_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolved Date');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|under review|resolved|escalated|withdrawn');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `dispute_type` SET TAGS ('dbx_value_regex' = 'price variance|quantity discrepancy|quality rejection|duplicate invoice|service not rendered|other');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `gross_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Payment Status');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `mine_site_code` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Code');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `net_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `opex_capex_classification` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) / Capital Expenditure (CAPEX) Classification');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `opex_capex_classification` SET TAGS ('dbx_value_regex' = 'OPEX|CAPEX|mixed');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'electronic funds transfer|cheque|wire transfer|credit card|letter of credit|other');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|variance|unmatched|bypassed');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `cash_flow_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Forecast ID');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Prepared By Employee ID');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `superseded_cash_flow_forecast_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `asset_disposal_amount` SET TAGS ('dbx_business_glossary_term' = 'Asset Disposal Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `capex_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `closing_cash_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Closing Cash Balance Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `commodity_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Commodity Sales Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `debt_covenant_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Debt Covenant Compliance Flag');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `debt_service_amount` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `dividend_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Dividend Payment Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `exchange_rate_to_usd` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to United States Dollar (USD)');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `expansion_capex_amount` SET TAGS ('dbx_business_glossary_term' = 'Expansion Capital Expenditure (CAPEX) Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `financing_cash_inflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Financing Cash Inflow Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `financing_cash_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Financing Cash Outflow Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_assumptions` SET TAGS ('dbx_business_glossary_term' = 'Forecast Assumptions');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_horizon` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_horizon` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annual|lom');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Reference Number');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_reference_number` SET TAGS ('dbx_value_regex' = '^CF-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|superseded|active');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'operating|investing|financing|consolidated');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `forecast_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `hedging_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Hedging Settlement Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `investing_cash_inflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Investing Cash Inflow Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `investing_cash_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Investing Cash Outflow Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `lom_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan Reference');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `lom_plan_reference` SET TAGS ('dbx_value_regex' = '^LOM-[0-9]{4}-[A-Z0-9]{4,8}$');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `net_cash_flow_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Cash Flow Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `opening_cash_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Opening Cash Balance Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `operating_cash_inflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Cash Inflow Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `operating_cash_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Cash Outflow Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `opex_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `royalty_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `sustaining_capex_amount` SET TAGS ('dbx_business_glossary_term' = 'Sustaining Capital Expenditure (CAPEX) Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `tax_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Payment Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `variance_to_prior_forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance to Prior Forecast Amount');
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ALTER COLUMN `variance_to_prior_forecast_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance to Prior Forecast Percentage');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` SET TAGS ('dbx_subdomain' = 'investment_planning');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` SET TAGS ('dbx_association_edges' = 'finance.cost_centre,project.capital_project');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `project_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Project Cost Allocation ID');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Cost Allocation - Capital Project Id');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Project Cost Allocation - Cost Centre Id');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget Amount');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Created Date');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `mining_ecm`.`finance`.`allocation_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`allocation_cycle` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `mining_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Identifier');
ALTER TABLE `mining_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Source Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `prior_allocation_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `created_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ALTER COLUMN `parent_legal_entity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`business_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`finance`.`business_unit` SET TAGS ('dbx_subdomain' = 'organizational_accounting');
ALTER TABLE `mining_ecm`.`finance`.`business_unit` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier');
ALTER TABLE `mining_ecm`.`finance`.`business_unit` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`business_unit` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`business_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`finance`.`business_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
