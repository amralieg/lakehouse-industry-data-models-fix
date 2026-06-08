-- Schema for Domain: finance | Business: Real Estate | Version: v1_mvm
-- Generated on: 2026-05-02 05:06:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `real_estate_ecm`.`finance` COMMENT 'Enterprise financial backbone covering GL, AP, AR, budgeting, forecasting, and financial reporting as sourced from Yardi Voyager and SAP S/4HANA. Owns cost centers, chart of accounts, NOI statements, EGI/PGI/GOI calculations, EBITDA roll-ups, DSCR calculations, cash management, financial consolidation, and SOX-compliant financial controls. Authoritative source for all property-level and portfolio-level P&L data.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique surrogate identifier for the cost center record in the enterprise data platform. Primary key for the cost_center master registry.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Multi-currency RE portfolios require cost centers to reference a validated functional currency for currency translation, consolidation reporting, and IFRS/GAAP compliance. Replaces denormalized functi',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: RE cost centers are organized by market/submarket for NOI-by-market reporting, budget variance analysis by geography, and portfolio performance benchmarking. Domain experts expect cost centers to refe',
    `parent_cost_center_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent cost center in the cost center hierarchy. Enables hierarchical roll-up of financial data for portfolio-level P&L, EBITDA consolidation, and management reporting. Null for top-level cost centers.',
    `allocation_method` STRING COMMENT 'Method used to allocate costs from this cost center to other cost centers or properties. direct = direct charge; percentage = fixed percentage split; square_footage = allocated by GLA/NLA; headcount = allocated by employee count; none = no allocation (standalone center).. Valid values are `direct|percentage|square_footage|headcount|none`',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Fixed percentage used when allocation_method is percentage. Represents the share of this cost centers costs to be allocated to downstream cost centers or properties. Value between 0.00 and 100.00.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total approved annual budget for this cost center in the functional currency. Represents the planned OPEX and/or CAPEX for the fiscal year as approved in Yardi Voyager or SAP S/4HANA budgeting module. Used for variance analysis and NOI forecasting.',
    `asset_class` STRING COMMENT 'Real estate asset class associated with this cost center when center_type is property. Enables asset-class-level financial benchmarking, CAP rate analysis, and portfolio segmentation. [ENUM-REF-CANDIDATE: office|retail|industrial|multifamily|mixed_use|land|hotel|other — promote to reference product]',
    `business_unit` STRING COMMENT 'The business unit or division to which this cost center is assigned (e.g., Commercial Real Estate, Residential, Development, Investment Advisory). Supports segment-level P&L reporting and portfolio analytics.',
    `cam_pool_indicator` BOOLEAN COMMENT 'Indicates whether this cost center is designated as a Common Area Maintenance (CAM) expense pool. When True, costs accumulated here are subject to CAM reconciliation and tenant recovery billing per lease agreements.',
    `capex_eligible` BOOLEAN COMMENT 'Indicates whether Capital Expenditure (CAPEX) postings are permitted against this cost center. Controls GL posting rules to ensure proper OPEX vs. CAPEX segregation for fixed asset accounting and financial reporting.',
    `center_type` STRING COMMENT 'Classification of the cost center by its organizational scope. property = property-level cost center tied to a specific asset; corporate = enterprise-wide overhead; departmental = functional department (e.g., Finance, HR); development = active construction or development project; investment = investment vehicle or fund-level tracking.. Valid values are `property|corporate|departmental|development|investment`',
    `company_code` STRING COMMENT 'SAP S/4HANA or Yardi Voyager company code representing the legal entity or organizational unit to which this cost center belongs. Used for financial consolidation, statutory reporting, and SOX-compliant entity-level controls.. Valid values are `^[A-Z0-9]{2,10}$`',
    `controlling_area` STRING COMMENT 'SAP S/4HANA controlling area code that governs the management accounting rules, currency, and fiscal year variant applicable to this cost center. Defines the scope of internal cost accounting and allocation cycles.',
    `cost_center_category` STRING COMMENT 'Financial category indicating the primary nature of expenditures tracked by this cost center. opex = Operating Expenditure (OPEX) only; capex = Capital Expenditure (CAPEX) only; mixed = both OPEX and CAPEX; overhead = corporate overhead allocation; revenue = revenue-generating center for NOI tracking.. Valid values are `opex|capex|mixed|overhead|revenue`',
    `cost_center_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the cost center within the chart of accounts and GL posting structure. Used in Yardi Voyager and SAP S/4HANA for financial allocation, NOI statements, and OPEX/CAPEX tracking. Serves as the business-facing identifier across all financial systems.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `cost_center_description` STRING COMMENT 'Detailed narrative description of the cost centers business purpose, scope of financial activities, and any special accounting treatment or allocation rules. Used for financial reporting documentation and audit support.',
    `cost_center_name` STRING COMMENT 'Full descriptive name of the cost center as displayed in financial reports, NOI statements, and budget documents. Examples: Downtown Office Tower — Property Operations, Corporate Finance Department, Residential Portfolio — Leasing.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. active = open for GL postings; inactive = temporarily suspended; pending = awaiting activation; closed = permanently decommissioned; locked = frozen for period-end close or audit.. Valid values are `active|inactive|pending|closed|locked`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction where this cost center operates. Governs applicable tax regulations, statutory reporting requirements, and currency rules.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost center record was first created in the enterprise data platform. Supports SOX-compliant audit trails and data lineage tracking.',
    `department_code` STRING COMMENT 'Code identifying the functional department associated with this cost center (e.g., Finance, Property Management, Leasing, Development). Used for departmental OPEX allocation and headcount cost tracking.',
    `effective_from` DATE COMMENT 'Date from which the cost center becomes active and eligible for GL postings and financial allocations. Supports period-accurate financial reporting and SOX-compliant audit trails.',
    `effective_to` DATE COMMENT 'Date on which the cost center ceases to be active. Null indicates an open-ended cost center with no planned closure. Used for period-accurate financial reporting and historical GL analysis.',
    `esg_tracking_enabled` BOOLEAN COMMENT 'Indicates whether Environmental, Social, and Governance (ESG) cost tracking is enabled for this cost center. When True, OPEX related to LEED certification, BREEAM compliance, energy efficiency, and sustainability initiatives are tracked separately.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which the cost centers budget and financial plan are defined. Enables year-over-year budget comparison and period-accurate financial reporting.',
    `fiscal_year_variant` STRING COMMENT 'Code identifying the fiscal year variant (calendar year, April–March, October–September, etc.) applicable to this cost center. Sourced from SAP S/4HANA controlling area configuration. Ensures correct period mapping for financial consolidation.',
    `gl_account_group` STRING COMMENT 'The GL account group or chart of accounts segment to which this cost center belongs. Governs which GL accounts are permissible for posting against this cost center. Sourced from SAP S/4HANA chart of accounts configuration and Yardi Voyager GL setup.',
    `hierarchy_level` STRING COMMENT 'Numeric level of this cost center within the organizational hierarchy (1 = top/enterprise, 2 = business unit, 3 = property/department, etc.). Used for hierarchical financial roll-up and reporting drill-down.',
    `hierarchy_path` STRING COMMENT 'Full materialized path of the cost center within the hierarchy, expressed as a delimited string of cost center codes from root to current node (e.g., CORP/CRE/NYC/TOWER1). Facilitates efficient hierarchical queries and reporting without recursive joins.',
    `intercompany_indicator` BOOLEAN COMMENT 'Indicates whether this cost center is used for intercompany transactions between legal entities within the real estate portfolio. When True, intercompany elimination rules apply during financial consolidation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this cost center record. Used for change tracking, SOX audit compliance, and incremental data pipeline processing in the Databricks Lakehouse Silver Layer.',
    `noi_tracking_enabled` BOOLEAN COMMENT 'Indicates whether this cost center is configured for Net Operating Income (NOI) statement generation. When True, the cost center participates in property-level P&L reporting including EGI, PGI, GOI, and NOI calculations.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or contextual information about the cost center that does not fit structured fields. May include budget approval references, restructuring notes, or temporary allocation overrides.',
    `profit_center_code` STRING COMMENT 'Code of the profit center to which this cost center is assigned for management accounting and P&L reporting. Enables NOI statement roll-up and EBITDA calculation at the profit center level in SAP S/4HANA.',
    `responsible_manager` STRING COMMENT 'Full name of the manager or cost center owner accountable for financial performance, budget adherence, and OPEX/CAPEX approvals for this cost center. Used in SOX-compliant approval workflows and financial reporting sign-offs.',
    `short_name` STRING COMMENT 'Abbreviated display name for the cost center used in condensed financial reports, dashboards, and system interfaces where space is limited.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this cost center record originates. Supports data lineage tracking and reconciliation between Yardi Voyager, SAP S/4HANA, and MRI Software.. Valid values are `yardi|sap|mri|argus|manual|other`',
    `source_system_code` STRING COMMENT 'The native cost center identifier as it exists in the originating source system (Yardi Voyager, SAP S/4HANA, or MRI Software). Enables reconciliation between the enterprise data platform and operational systems of record.',
    `sox_control_relevant` BOOLEAN COMMENT 'Indicates whether this cost center is subject to Sarbanes-Oxley (SOX) internal control requirements. When True, all financial postings require documented approval workflows and are subject to SOX audit procedures.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Master registry of cost centers used for financial allocation and reporting across the real estate portfolio. Each cost center maps to a property, department, or business unit and serves as the foundational dimension for GL posting, NOI statements, and OPEX/CAPEX tracking. Attributes include cost center code, name, type (property-level, corporate, departmental), responsible manager, active status, effective dates, hierarchy parent, and functional currency.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Unique surrogate identifier for each General Ledger (GL) account record in the enterprise chart of accounts. Primary key for the silver-layer data product.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: In multi-currency RE portfolios, GL accounts are denominated in a specific currency for financial statement preparation and consolidation. Replaces denormalized currency_code text with a validated ref',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: In RE, certain GL accounts are restricted to specific property types (e.g., CAM recovery accounts for commercial only, HOA accounts for residential). This restriction drives automated GL coding valida',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: GL accounts are mapped to regulatory obligations for compliance reporting — ASC 842 lease liability accounts to FASB obligations, environmental liability accounts to EPA obligations, REIT distribution',
    `account_code` STRING COMMENT 'The externally-known alphanumeric code that uniquely identifies the GL account within the enterprise chart of accounts. Used across Yardi Voyager and SAP S/4HANA for journal entry posting, financial reporting, and cross-system reconciliation. Serves as the business-facing natural key.. Valid values are `^[A-Z0-9]{2,20}$`',
    `account_description` STRING COMMENT 'Extended narrative description of the GL accounts purpose, the types of transactions it captures, and any applicable posting rules or restrictions. Provides guidance to accountants and property managers on correct account usage. Sourced from the account master in Yardi Voyager and SAP S/4HANA.',
    `account_group` STRING COMMENT 'Organizational grouping of GL accounts used to control field selection, number range assignment, and reporting segmentation in SAP S/4HANA (e.g., Revenue Accounts, Expense Accounts, Balance Sheet Accounts, Intercompany Accounts). Aligns with SAP account group configuration and Yardi Voyager account category groupings.',
    `account_name` STRING COMMENT 'Human-readable descriptive name of the GL account as displayed in financial statements, NOI reports, and budget templates (e.g., Rental Revenue – Office, Common Area Maintenance Expense, Tenant Improvement Allowance). Sourced from Yardi Voyager and SAP S/4HANA account master.',
    `account_short_name` STRING COMMENT 'Abbreviated account name (maximum 20 characters) used in space-constrained financial reports, trial balance printouts, and system interfaces where the full account name cannot be displayed. Sourced from SAP S/4HANA short text field and Yardi Voyager account abbreviation.. Valid values are `^.{1,20}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the GL account. active accounts accept journal postings; inactive accounts are retired and blocked from new postings; blocked accounts are temporarily suspended pending review; pending_review accounts are newly created and awaiting controller approval. Supports SOX-compliant financial controls over the chart of accounts.. Valid values are `active|inactive|blocked|pending_review`',
    `account_subtype` STRING COMMENT 'Secondary classification providing granular categorization within the account type (e.g., current asset, fixed asset, operating revenue, CAM expense, capital expenditure, right-of-use asset, lease liability). Supports NOI statement line-item mapping, CAPEX vs. OPEX segregation, and FASB ASC 842 / IFRS 16 lease accounting classification. [ENUM-REF-CANDIDATE: current_asset|fixed_asset|right_of_use_asset|intangible_asset|current_liability|long_term_liability|lease_liability|operating_revenue|other_income|operating_expense|cam_expense|capex|depreciation|equity_contributed|retained_earnings — promote to reference product]',
    `account_type` STRING COMMENT 'High-level classification of the GL account per the fundamental accounting equation: asset, liability, equity, revenue, or expense. Drives balance sheet vs. income statement placement and normal balance determination. Aligns with FASB and IFRS financial statement presentation requirements.. Valid values are `asset|liability|equity|revenue|expense`',
    `approval_date` DATE COMMENT 'The date on which the GL account creation or most recent modification was formally approved by the authorized financial officer. Part of the SOX-compliant audit trail for chart of accounts changes. Paired with approved_by to document the authorization event.',
    `approved_by` STRING COMMENT 'Name or identifier of the controller, CFO, or authorized financial officer who approved the creation or modification of this GL account. Supports SOX-compliant segregation of duties and audit trail requirements for chart of accounts governance. Changes to the chart of accounts must be authorized by a designated financial authority.',
    `argus_line_item` STRING COMMENT 'The corresponding line item label in Argus Enterprise cash flow models. Maps GL accounts to Argus revenue and expense line items to enable reconciliation between actual financial results (Yardi/SAP) and Argus valuation model projections. Supports CAP rate validation, DCF analysis, and investment performance reporting.',
    `budget_relevant` BOOLEAN COMMENT 'Indicates whether this GL account participates in the annual budgeting and forecasting process in Yardi Voyager and SAP S/4HANA. When True, budget amounts are planned against this account and actuals-vs-budget variance reporting is generated. When False, the account is excluded from budget templates (e.g., statistical or memo accounts).',
    `cam_recoverable_flag` BOOLEAN COMMENT 'Indicates whether expenses posted to this GL account are recoverable from tenants as Common Area Maintenance (CAM) charges under NNN or modified gross lease structures. Drives CAM reconciliation calculations in Yardi Voyager and MRI Software, determining which operating expenses are billable to tenants versus landlord-absorbed.',
    `capex_opex_flag` STRING COMMENT 'Classifies the GL account as a Capital Expenditure (CAPEX) account, Operating Expenditure (OPEX) account, or not applicable (for balance sheet, equity, or revenue accounts). Drives capitalization policy enforcement, fixed asset creation workflows in Yardi Voyager Fixed Assets module, and budget segregation between capital and operating budgets.. Valid values are `capex|opex|not_applicable`',
    `cash_flow_category` STRING COMMENT 'Maps the GL account to its classification in the cash flow statement per FASB ASC 230: operating activities (rental receipts, CAM collections, operating disbursements), investing activities (property acquisitions, capital improvements, dispositions), financing activities (mortgage proceeds, loan repayments, equity distributions), or not applicable for non-cash accounts.. Valid values are `operating|investing|financing|not_applicable`',
    `consolidation_account_code` STRING COMMENT 'The standardized account code used in the group-level financial consolidation chart of accounts in SAP S/4HANA. Local entity accounts map to this consolidation account to enable automated elimination of intercompany transactions and production of consolidated financial statements across all legal entities in the real estate portfolio.. Valid values are `^[A-Z0-9]{2,20}$`',
    `cost_element_category` STRING COMMENT 'Classifies the GL account as a primary cost element (originating costs from external postings), secondary cost element (internal cost allocations and settlements), or not applicable (for balance sheet and revenue accounts). Used in SAP S/4HANA Controlling (CO) module for property-level cost center accounting and overhead allocation to real estate assets.. Valid values are `primary|secondary|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account record was first created in the enterprise data platform. Provides the audit trail creation timestamp for SOX compliance and data lineage tracking in the Databricks silver layer. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `deactivation_date` DATE COMMENT 'The date on which this GL account was or will be deactivated and blocked from further journal entry postings. Null for currently active accounts. Supports account lifecycle management, chart of accounts rationalization, and SOX-compliant retirement of obsolete accounts.',
    `ebitda_category` STRING COMMENT 'Maps the GL account to its role in the EBITDA roll-up calculation used for investment analysis, DSCR calculations, and portfolio performance reporting. Distinguishes revenue, operating expense, EBITDA add-back items, interest, tax, depreciation, and amortization lines. Supports Argus Enterprise and SAP S/4HANA financial consolidation. [ENUM-REF-CANDIDATE: revenue|operating_expense|ebitda_addback|interest|tax|depreciation|amortization|below_ebitda — 8 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'The date from which this GL account became active and available for journal entry postings. Supports time-based account validity controls in SAP S/4HANA and Yardi Voyager, ensuring accounts are only used within their authorized validity period. Required for SOX-compliant change management of the chart of accounts.',
    `fasb_asc842_flag` BOOLEAN COMMENT 'Indicates whether this GL account is specifically designated for FASB ASC 842 lease accounting entries, including right-of-use (ROU) asset recognition, lease liability amortization, operating lease expense, and finance lease interest. Enables automated identification of ASC 842-impacted accounts for lessee accounting compliance and audit trail.',
    `ffo_classification` STRING COMMENT 'Indicates whether the GL account is included in NAREIT-defined Funds From Operations (FFO), excluded from FFO, or treated as an Adjusted Funds From Operations (AFFO) adjustment item. Critical for REIT financial reporting to the SEC and investor relations disclosures. Null for non-REIT entities.. Valid values are `included|excluded|affo_adjustment`',
    `financial_statement_line` STRING COMMENT 'The specific line item label on the published financial statement (income statement, balance sheet, or cash flow statement) to which this account maps. Supports automated financial statement generation, SEC reporting for publicly traded REITs, and FASB/IFRS presentation requirements (e.g., Rental Revenue, Operating Expenses, Right-of-Use Assets, Lease Liabilities).',
    `hierarchy_level` STRING COMMENT 'Numeric depth of the account within the GL account hierarchy tree, starting at 1 for root/summary accounts and incrementing for each subordinate level. Used to control financial statement roll-up logic, suppress detail lines in executive reporting, and enforce posting rules (only leaf-level accounts may accept journal entries).',
    `ifrs16_flag` BOOLEAN COMMENT 'Indicates whether this GL account is mapped to IFRS 16 lease accounting requirements, covering right-of-use asset recognition, lease liability measurement, depreciation of ROU assets, and interest on lease liabilities. Supports entities reporting under IFRS in international jurisdictions alongside FASB ASC 842 for dual-reporting entities.',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this GL account is designated for intercompany transactions between legal entities within the real estate portfolio (e.g., management fee income/expense, intercompany loans, intercompany distributions). Intercompany accounts are eliminated during financial consolidation in SAP S/4HANA to produce consolidated financial statements.',
    `is_posting_account` BOOLEAN COMMENT 'Indicates whether this account is a leaf-level posting account that accepts direct journal entry postings (True) or a summary/header account used only for roll-up and reporting purposes (False). Enforces the accounting control that transactions are posted only to detail accounts, not to summary nodes.',
    `legal_entity_code` STRING COMMENT 'Code identifying the legal entity (company code in SAP S/4HANA) to which this GL account belongs. In a multi-entity real estate portfolio, different legal entities (property-owning SPEs, management companies, REITs) may maintain separate charts of accounts or share a common chart with entity-specific account assignments.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `mri_account_code` STRING COMMENT 'The corresponding account code as configured in MRI Software for investment management and residential property accounting. Supports cross-system reconciliation for portfolios managed in MRI alongside Yardi Voyager, ensuring consistent GL mapping across both property management platforms.. Valid values are `^[A-Z0-9_-]{1,30}$`',
    `noi_category` STRING COMMENT 'Maps the GL account to its position in the real estate NOI waterfall: Potential Gross Income (PGI), vacancy/credit loss, Effective Gross Income (EGI), operating expense, Net Operating Income (NOI), or below-NOI items (debt service, depreciation, capital expenditures). Enables automated NOI statement generation and CAP rate calculations at property and portfolio level.. Valid values are `potential_gross_income|vacancy_loss|effective_gross_income|operating_expense|net_operating_income|below_noi`',
    `normal_balance` STRING COMMENT 'Indicates whether the accounts natural (expected) balance is a debit or credit per double-entry bookkeeping rules. Assets and expenses carry a debit normal balance; liabilities, equity, and revenue carry a credit normal balance. Used by Yardi Voyager and SAP S/4HANA to validate journal entry postings and detect sign reversals.. Valid values are `debit|credit`',
    `parent_account_code` STRING COMMENT 'The account code of the immediate parent account in the GL account hierarchy. Enables roll-up of financial data from detail accounts to summary accounts for NOI statements, EBITDA roll-ups, and portfolio-level P&L reporting. Null for top-level (root) accounts in the hierarchy.. Valid values are `^[A-Z0-9]{2,20}$`',
    `profit_center_relevant` BOOLEAN COMMENT 'Indicates whether postings to this GL account require a profit center assignment in SAP S/4HANA, enabling property-level and portfolio-level profitability analysis. When True, all journal entries to this account must carry a profit center (typically mapped to a property or legal entity) to support segment reporting and NOI attribution.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this GL account master record was sourced: Yardi Voyager (property-level GL), SAP S/4HANA (financial consolidation), MRI Software (investment/residential accounting), or manual (directly entered in the data platform). Supports data lineage, reconciliation, and master data management governance.. Valid values are `yardi_voyager|sap_s4hana|mri_software|manual`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this GL account is subject to SOX Section 302/404 internal control over financial reporting (ICFR) requirements. Accounts flagged as SOX-relevant require documented controls, segregation of duties enforcement, and periodic management testing. Applicable to publicly traded REITs and their subsidiaries.',
    `tax_code` STRING COMMENT 'Tax determination code assigned to the GL account for automated sales tax, VAT, or property tax calculation during transaction posting. Maps to the tax configuration in SAP S/4HANA and Yardi Voyager to ensure correct tax treatment on revenue and expense postings. Null for accounts not subject to tax determination.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account record was most recently modified in the enterprise data platform. Tracks the latest change for SOX-compliant audit trail, data lineage, and incremental ETL processing in the Databricks silver layer. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `yardi_account_code` STRING COMMENT 'The corresponding account code as configured in Yardi Voyager Property Management system. Enables cross-system reconciliation between Yardi Voyager (operational source of record for property-level accounting) and SAP S/4HANA (financial consolidation system). Used for ETL mapping and data lineage tracking in the silver layer.. Valid values are `^[A-Z0-9_-]{1,30}$`',
    CONSTRAINT pk_chart_of_accounts PRIMARY KEY(`chart_of_accounts_id`)
) COMMENT 'Enterprise chart of accounts defining the full GL account hierarchy used across all properties and legal entities. Establishes the authoritative account structure for income, expense, asset, liability, and equity classifications. Supports FASB ASC 842 lease accounting and SOX-compliant financial controls. Attributes include account code, account name, account type (asset, liability, equity, revenue, expense), sub-type, normal balance, parent account, IFRS 16 mapping flag, and active status.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Unique surrogate identifier for each legal entity record in the master registry. Serves as the primary key for all downstream joins across financial consolidation, SOX reporting, and portfolio management.',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: RE legal entities are domiciled in specific jurisdictions (state, MSA, country) for tax nexus determination, regulatory compliance, and geographic portfolio reporting. Domain experts expect entities t',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Real estate legal entities (REITs, LLCs, partnerships) are formed and operate in specific jurisdictions governing their tax treatment, reporting requirements, and regulatory obligations. formation_jur',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Real estate fund legal entities are structured around investment strategies (core, value-add, opportunistic). Fund investor reporting, INREV/NCREIF benchmarking, and regulatory disclosure require each',
    `parent_entity_legal_entity_id` BIGINT COMMENT 'Reference to the immediate parent legal entity in the ownership hierarchy, enabling consolidation roll-ups for REIT structures, holding companies, and joint-venture entities. Null for top-level entities.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: RE legal entities (REITs, LPs, JVs) have a designated functional currency for GAAP/IFRS consolidation, investor reporting, and currency translation adjustments. Role-prefixed functional_ distinguish',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: REIT compliance reporting and investor disclosure require each legal entity to be classified by property type (office, industrial, multifamily). Supports REIT qualifying income tests and SEC reporting',
    `argus_entity_code` STRING COMMENT 'Entity identifier used in Argus Enterprise for valuation, cash flow modeling, and portfolio reporting. Links this legal entity to Argus DCF models and NAV calculations.',
    `audit_period_end_date` DATE COMMENT 'End date of the most recently completed external audit period for this entity. Tracks audit cycle completion for SOX compliance monitoring and financial statement issuance scheduling.',
    `auditor_name` STRING COMMENT 'Name of the independent registered public accounting firm (PCAOB-registered) responsible for auditing the entitys financial statements. Required for SOX Section 404 attestation and SEC annual report disclosures.',
    `aum_usd` DECIMAL(18,2) COMMENT 'Total gross asset value (GAV) of real estate assets owned or managed by this legal entity, expressed in USD. Key metric for fund reporting, investor disclosures, and management fee calculations. Sourced from Argus Enterprise or MRI portfolio reports.',
    `consolidation_method` STRING COMMENT 'Accounting method applied when consolidating this entity into parent financial statements. Full for wholly-owned subsidiaries, proportional for JVs, equity for minority interests, cost for passive investments per FASB ASC 810.. Valid values are `full|proportional|equity|cost|not_consolidated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the legal entity record was first created in the system. Supports audit trail requirements, SOX ICFR documentation, and data lineage tracking in the Databricks Silver layer.',
    `dissolution_date` DATE COMMENT 'Date on which the legal entity was formally dissolved, wound down, or deregistered. Null for active entities. Triggers cessation of financial postings and initiates final tax return filing obligations.',
    `ein` STRING COMMENT 'IRS-assigned Employer Identification Number (EIN) / Federal Tax Identification Number for the entity. Required for tax filings (Form 1065, 1120-REIT, K-1), lender due diligence, and title company transactions.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `entity_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the legal entity across operational systems (Yardi company code, SAP company code). Used as the cross-system integration key for GL, AP, AR, and financial consolidation.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `entity_status` STRING COMMENT 'Current lifecycle status of the legal entity. Controls whether the entity is eligible for new transactions, financial postings, and regulatory filings. Dissolved entities are retained for historical reporting.. Valid values are `active|inactive|dissolved|pending_formation|suspended`',
    `entity_subtype` STRING COMMENT 'Functional subclassification of the entity within the enterprise structure. Distinguishes Special Purpose Entities (SPEs) used for property ownership from operating companies, fund vehicles, and management entities. [ENUM-REF-CANDIDATE: HOLDING_CO|OPERATING_CO|SPE|FUND|MANAGEMENT_CO|DEVELOPMENT_CO|FINANCE_CO|ADVISORY_CO — promote to reference product]',
    `entity_type` STRING COMMENT 'Classification of the legal entitys organizational structure. Drives consolidation method, tax treatment, and SEC reporting obligations. [ENUM-REF-CANDIDATE: REIT|LLC|LP|GP|C_CORP|S_CORP|JV|TRUST|LLP|PARTNERSHIP — promote to reference product]',
    `fiscal_year_end_month` STRING COMMENT 'Calendar month (1–12) in which the entitys fiscal year ends. Determines the period-end close schedule, annual report filing deadlines, and tax return due dates. Most US REITs use December (12) fiscal year end.',
    `formation_date` DATE COMMENT 'Date on which the legal entity was officially formed and registered with the applicable jurisdiction. Used for entity age calculations, compliance tracking, and historical financial reporting.',
    `gl_company_code` STRING COMMENT 'Company code assigned to this legal entity in the General Ledger system (SAP S/4HANA BUKRS or Yardi company code). The primary integration key linking this master record to all financial transactions, journal entries, and trial balances.. Valid values are `^[A-Z0-9]{1,10}$`',
    `is_reit_elected` BOOLEAN COMMENT 'Indicates whether the entity has made a valid REIT election under IRC Section 856. REIT-elected entities must distribute at least 90% of taxable income, qualify asset and income tests, and file Form 1120-REIT annually.',
    `is_sec_reporting` BOOLEAN COMMENT 'Indicates whether the entity is a reporting company subject to SEC disclosure requirements (10-K, 10-Q, 8-K filings). Triggers SOX compliance obligations, XBRL tagging, and enhanced internal control requirements.',
    `is_sox_in_scope` BOOLEAN COMMENT 'Indicates whether the entity is within scope for SOX Section 404 internal control over financial reporting (ICFR) assessments. Determines which entities require management assessment and external auditor attestation.',
    `is_variable_interest_entity` BOOLEAN COMMENT 'Indicates whether the entity qualifies as a Variable Interest Entity (VIE) under FASB ASC 810, requiring consolidation by the primary beneficiary regardless of voting interest. Common for SPEs and certain JV structures in real estate.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the legal entity record. Required for change data capture (CDC) processing in the Databricks lakehouse pipeline and SOX audit trail documentation.',
    `legal_name` STRING COMMENT 'Full registered legal name of the entity as it appears on formation documents, tax filings, and regulatory submissions (e.g., Acme Properties LLC, Acme REIT I, L.P.). Must match state/jurisdiction registration records.',
    `mri_entity_code` STRING COMMENT 'Entity identifier assigned in MRI Software for investment management and property accounting. Enables cross-system reconciliation between MRI and SAP/Yardi financial records.',
    `nav_usd` DECIMAL(18,2) COMMENT 'Net Asset Value of the entity calculated as total assets minus total liabilities, expressed in USD. Primary valuation metric for REIT and fund entities used in investor reporting, unit pricing, and performance benchmarking per INREV/NCREIF guidelines.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of the legal entity owned by the immediate parent entity, expressed as a decimal (e.g., 100.00 for wholly-owned, 50.00 for 50/50 JV). Drives consolidation thresholds and minority interest calculations under FASB ASC 810.',
    `primary_contact_email` STRING COMMENT 'Business email address of the primary contact for the entity. Used for regulatory notifications, audit correspondence, and financial reporting communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact or authorized representative for the entity, typically the CFO, Controller, or Asset Manager responsible for financial reporting and regulatory correspondence.',
    `registered_address_city` STRING COMMENT 'City of the entitys official registered address. Required for state tax filings, regulatory submissions, and legal service of process.',
    `registered_address_country` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the entitys official registered address. Distinguishes domestic US entities from foreign subsidiaries requiring FBAR and FATCA reporting.. Valid values are `^[A-Z]{3}$`',
    `registered_address_line1` STRING COMMENT 'First line of the entitys official registered address as filed with the state Secretary of State and IRS. Used for legal notices, regulatory correspondence, and title company communications.',
    `registered_address_postal_code` STRING COMMENT 'ZIP or ZIP+4 postal code of the entitys official registered address. Used for tax jurisdiction determination and regulatory correspondence routing.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `registered_address_state` STRING COMMENT 'Two-letter US state code of the entitys official registered address. May differ from the formation jurisdiction for entities with a registered agent in a different state.. Valid values are `^[A-Z]{2}$`',
    `registered_agent_name` STRING COMMENT 'Name of the entitys designated registered agent responsible for receiving legal service of process, state notices, and annual report reminders on behalf of the entity.',
    `state_registration_number` STRING COMMENT 'State-issued entity registration or charter number assigned by the Secretary of State in the jurisdiction of formation. Used for state tax filings, good-standing certificates, and title searches.',
    `state_tax_nexus` STRING COMMENT 'Comma-separated list of two-letter US state codes where the entity has established tax nexus through property ownership, operations, or employee presence. Drives multi-state apportionment and state tax filing obligations.',
    `tax_classification` STRING COMMENT 'IRS federal tax classification of the entity for income tax purposes. Determines the applicable tax return form (1120-REIT, 1065, Schedule C) and pass-through treatment for investors.. Valid values are `corporation|partnership|disregarded_entity|s_corporation|trust`',
    `tax_year_end_month` STRING COMMENT 'Calendar month (1–12) in which the entitys tax year ends, which may differ from the fiscal year end for certain partnership structures. Drives K-1 issuance timing and estimated tax payment schedules.',
    `trade_name` STRING COMMENT 'Operating or doing business as (DBA) name used in commercial transactions, marketing, and tenant-facing communications when different from the registered legal name.',
    `yardi_entity_code` STRING COMMENT 'Entity identifier assigned in Yardi Voyager property management and accounting system. Used to link this legal entity master record to Yardi GL, AR, AP, and lease administration data.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master registry of all legal entities within the real estate enterprise — including property-owning SPEs, REITs, joint-venture entities, holding companies, and operating subsidiaries. Serves as the consolidation anchor for financial reporting and SOX compliance. Attributes include entity name, entity type (REIT, LLC, LP, JV), EIN/tax ID, jurisdiction, functional currency, consolidation method, parent entity, REIT election status, and SEC reporting flag.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique surrogate identifier for each journal entry record in the Silver Layer lakehouse. Primary key for the finance.journal_entry data product.',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: Appraisals trigger fair value adjustment journal entries for investment property revaluation (IAS 40) and impairment charges (ASC 360). Linking the journal entry to the triggering appraisal provides t',
    `budget_id` BIGINT COMMENT 'Reference to the budget period against which this journal entrys actuals are tracked. Enables budget-vs-actual variance analysis at the property, cost center, and portfolio level. Supports forecasting and financial planning workflows in Yardi Voyager and SAP S/4HANA.',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Journal entries record penalty payments, remediation cost accruals, and settlement amounts for compliance violations. Real estate controllers need a direct GL-to-violation link for violation cost trac',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this journal entry. Cost centers represent organizational units (e.g., property management, leasing, development) used for internal cost allocation, budgeting, and management reporting.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Multi-currency RE transactions require journal entries to reference a validated transaction currency for exchange rate application, currency translation, and multi-currency financial reporting. Replac',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund or Real Estate Investment Trust (REIT) vehicle to which this journal entry is attributed. Supports fund-level financial reporting, Net Asset Value (NAV) calculations, and investor distribution tracking.',
    `ledger_id` BIGINT COMMENT 'Reference to the specific General Ledger (GL) ledger (e.g., leading ledger, parallel ledger for IFRS vs. GAAP) to which this entry is posted. Supports parallel accounting under FASB ASC 842 and IFRS 16 for lease accounting.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: journal_entry has company_code as a denormalized STRING that maps to a legal entity (SAP S/4HANA company codes correspond 1:1 to legal entities). Every GL posting belongs to a specific legal entity fo',
    `nav_calculation_id` BIGINT COMMENT 'Foreign key linking to valuation.nav_calculation. Business justification: NAV calculations trigger journal entries for fair value adjustments (unrealized gains/losses) in fund accounting. Linking journal_entry to nav_calculation supports the audit trail from GL posting to t',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to transaction.property_sale. Business justification: Gain/loss on sale journal entries reference the triggering property sale for financial reporting (ASC 360 disposal accounting). Real estate accountants post gain/loss, proceeds, and cost basis removal',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Journal entries are created to record accruals and payments triggered by regulatory filings — filing fees, penalty accruals, remediation cost recognition. Real estate controllers need to link GL entri',
    `rent_schedule_id` BIGINT COMMENT 'Foreign key linking to lease.rent_schedule. Business justification: Journal entries for straight-line rent, lease liability amortization, and deferred rent are generated from rent schedules. Direct FK from journal_entry to rent_schedule provides the audit trail requir',
    `reversed_entry_journal_entry_id` BIGINT COMMENT 'Reference to the original journal entry that this entry reverses. Populated only when is_reversal is True. Enables bidirectional audit trail linking reversal entries to their originating postings for SOX compliance.',
    `tax_assessment_id` BIGINT COMMENT 'Foreign key linking to valuation.tax_assessment. Business justification: Property tax accruals and payments are posted as journal entries. Linking journal_entry to tax_assessment enables GL drill-down to the underlying assessment for audit support and tax appeal documentat',
    `tenant_id` BIGINT COMMENT 'Foreign key linking to tenant.tenant. Business justification: ASC 842 / IFRS 16 compliance: straight-line rent, lease incentive amortization, and deferred rent journal entries must be attributed to the specific tenant for audit trail, tenant-level P&L reporting,',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: In RE accounting, journal entry document types (acquisition, disposition, lease commencement, CAM reconciliation) map to transaction types that drive GL coding rules, FASB ASC 842 classification, and ',
    `approval_status` STRING COMMENT 'Current workflow lifecycle state of the journal entry. Tracks the SOX-compliant approval chain from draft creation through posting. posted indicates the entry has been committed to the GL; reversed indicates a reversal has been executed.. Valid values are `draft|pending_approval|approved|rejected|posted|reversed`',
    `approved_by` STRING COMMENT 'The user ID or name of the individual who approved this journal entry in the SOX-compliant approval workflow. Required for audit trail and segregation of duties compliance. Populated when approval_status is approved or posted.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry was approved by the authorized approver. Supports SOX audit trail, segregation of duties verification, and period-end close timeline monitoring.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry record was first created in the source system. Supports audit trail, data lineage, and SOX compliance. Represents the RECORD_AUDIT_CREATED canonical category.',
    `document_date` DATE COMMENT 'The date of the original source document or business transaction that triggered the journal entry (e.g., invoice date, lease commencement date). May differ from posting date. Maps to SAP BKPF-BLDAT.',
    `entry_number` STRING COMMENT 'Externally-known, human-readable document number assigned by the source system (e.g., Yardi Voyager journal number or SAP document number). Used for cross-system reconciliation and audit trail. Maps to SAP BKPF-BELNR or Yardi JE reference number.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign currency exchange rate applied to translate the transaction currency amount to the functional currency amount at the time of posting. Stored with six decimal precision to support accurate multi-currency financial consolidation.',
    `fiscal_period` STRING COMMENT 'The accounting period (month) within the fiscal year to which this journal entry belongs, expressed as a two-digit period number (01–12 for regular periods; 13–16 for special closing periods). Used for period-end close, NOI statements, and financial reporting.. Valid values are `^(0[1-9]|1[0-2]|13|14|15|16)$`',
    `fiscal_year` STRING COMMENT 'The four-digit fiscal year to which this journal entry belongs. Combined with fiscal_period, uniquely identifies the accounting period for financial reporting, budgeting, and year-end close processes.',
    `functional_credit_amount` DECIMAL(18,2) COMMENT 'The sum of all credit line item amounts translated to the functional currency using the exchange_rate. Used for financial statement preparation, NOI reporting, and EBITDA roll-ups in the entitys reporting currency.',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the functional currency of the legal entity (company code) in which financial statements are prepared. Used for foreign currency translation and consolidation under FASB ASC 830 and IFRS 21.. Valid values are `^[A-Z]{3}$`',
    `functional_debit_amount` DECIMAL(18,2) COMMENT 'The sum of all debit line item amounts translated to the functional currency using the exchange_rate. Used for financial statement preparation, NOI reporting, and EBITDA roll-ups in the entitys reporting currency.',
    `header_text` STRING COMMENT 'Free-text description at the journal entry header level explaining the business purpose or context of the posting (e.g., Q3 CAM Reconciliation Accrual, Lease Commencement ROU Asset Recognition). Supports audit trail and business user understanding.',
    `intercompany_partner_code` STRING COMMENT 'The company code of the intercompany trading partner entity. Populated when is_intercompany is True. Used for intercompany reconciliation and elimination entries during financial consolidation. Maps to SAP BKPF-VBUND.',
    `is_balanced` BOOLEAN COMMENT 'Indicates whether the journal entry is balanced (total debits equal total credits). A value of True confirms the entry satisfies double-entry bookkeeping requirements. Unbalanced entries (False) are flagged for correction before posting.',
    `is_intercompany` BOOLEAN COMMENT 'Indicates whether this journal entry involves a transaction between two legal entities within the same corporate group (intercompany posting). True entries require elimination during financial consolidation for REIT and group-level reporting.',
    `is_reversal` BOOLEAN COMMENT 'Indicates whether this journal entry is a reversal of a previously posted entry. True means this entry was created to negate a prior posting (e.g., accrual reversal at period start). Used for period-end close management and audit trail.',
    `noi_category` STRING COMMENT 'Classification of this journal entrys contribution to the Net Operating Income (NOI) statement. Categorizes postings as revenue (rental income, CAM recoveries), operating expense (property OPEX), capital expenditure (CAPEX), below-NOI items, or non-operating. Drives property-level NOI reporting and CAP Rate analysis.. Valid values are `revenue|operating_expense|capex|below_noi|non_operating`',
    `posting_date` DATE COMMENT 'The date on which the journal entry is posted to the General Ledger (GL). Determines the accounting period in which the transaction is recognized. Distinct from the document date and value date. Maps to SAP BKPF-BUDAT.',
    `posting_key` STRING COMMENT 'Two-digit code controlling the debit/credit indicator, account type, and field selection for the journal entry posting. Maps to SAP posting key (BSEG-BSCHL). Common values include 40 (GL debit), 50 (GL credit), 01 (customer invoice), 31 (vendor invoice).',
    `reference_document_number` STRING COMMENT 'External reference number linking this journal entry to a related business document such as a lease agreement, invoice, purchase order, or contract. Supports cross-document traceability and audit trail. Maps to SAP BKPF-XBLNR.',
    `reversal_date` DATE COMMENT 'The scheduled or actual date on which this journal entry is to be reversed. Populated for accrual entries that are set up for automatic reversal at the start of the next accounting period. Supports automated period-end close workflows.',
    `source_system` STRING COMMENT 'Identifies the operational system of record that originated this journal entry. Supports data lineage, reconciliation, and audit trail requirements. Critical for SOX compliance and cross-system financial consolidation.. Valid values are `yardi_voyager|sap_s4hana|mri_software|argus_enterprise|manual`',
    `source_system_ref` STRING COMMENT 'The native document or transaction identifier from the originating source system (e.g., Yardi batch number, SAP BKPF compound key). Enables direct traceability back to the system of record for audit and reconciliation purposes.',
    `tax_code` STRING COMMENT 'The tax determination code applied to this journal entry, identifying the applicable tax rate and jurisdiction (e.g., sales tax, VAT, property transfer tax). Maps to SAP BKPF-MWSKZ. Used for tax reporting and compliance with local tax authorities.',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'The sum of all credit line item amounts in the transaction currency for this journal entry. Must equal total_debit_amount for the entry to be balanced per double-entry bookkeeping principles. Used for entry-level validation and reconciliation.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'The sum of all debit line item amounts in the transaction currency for this journal entry. Must equal total_credit_amount for the entry to be balanced per double-entry bookkeeping principles. Used for entry-level validation and reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry record was last modified in the source system or Silver Layer. Supports change tracking, data lineage, and SOX audit trail. Represents the RECORD_AUDIT_UPDATED canonical category.',
    `created_by` STRING COMMENT 'The user ID or name of the individual who created or prepared this journal entry. Supports segregation of duties (preparer vs. approver vs. poster) required under SOX Section 404 internal controls.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Core GL transactional record capturing all financial postings across the real estate portfolio with embedded debit/credit line items. Each entry is a balanced posting event with line-level detail mapped to GL accounts, cost centers, and properties. Supports property-level P&L, NOI statements, CAM allocations, EBITDA roll-ups, and SOX audit trails. Sourced from Yardi Voyager and SAP S/4HANA. Attributes include journal entry number, posting date, period, document type, source system, approval status, reversal flag, and per-line: debit/credit indicator, amount, functional currency amount, GL account, cost center, property reference, profit center, segment, tax code, and line description.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual debit or credit line item within a journal entry. Primary key for this table in the Databricks Silver Layer.',
    `asset_id` BIGINT COMMENT 'Reference to the property against which this line item is posted. Enables property-level P&L, NOI statements, CAM reconciliations, and per-property financial reporting.',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: GL line-item postings for building-specific operating expenses, CAM pool allocations, and depreciation schedules require building-level coding. Building-level trial balance and variance reports depend',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the General Ledger (GL) account in the chart of accounts to which this line item is posted. Drives property-level NOI statements, OPEX/CAPEX classification, and financial consolidation.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this line item. Enables departmental and property-level cost allocation, OPEX tracking, and budget variance analysis.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Multi-currency RE portfolio accounting requires JE lines to reference a validated transaction currency for exchange rate lookups, functional currency translation, and multi-currency consolidation repo',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header to which this line item belongs. Establishes the header-detail relationship per double-entry bookkeeping standards.',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the lease agreement associated with this line item. Enables lease-level financial tracking, ASC 842/IFRS 16 right-of-use asset and liability postings, and CAM reconciliation by lease.',
    `original_line_journal_entry_line_id` BIGINT COMMENT 'Reference to the original journal entry line that this line reverses or corrects. Populated only when reversal_flag is true. Enables audit trail linkage between original and reversal postings.',
    `approved_by` STRING COMMENT 'The user ID or name of the individual who approved this journal entry line posting. Required for SOX Section 302/404 internal controls documentation and segregation of duties compliance.',
    `assignment_number` STRING COMMENT 'Alphanumeric assignment field used for open item management, payment clearing, and AR/AP matching. In Yardi Voyager and SAP S/4HANA, this field links line items to specific invoices, payments, or clearing documents.',
    `cam_flag` BOOLEAN COMMENT 'Indicates whether this line item is a Common Area Maintenance (CAM) expense eligible for tenant pass-through billing and CAM reconciliation under NNN or modified gross lease structures.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this journal entry line record was first created in the source system. Used for audit trail, SOX compliance, and data lineage tracking in the Silver Layer.',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this line item is a debit (D) or credit (C) posting per double-entry bookkeeping. Fundamental to GL balance verification and trial balance preparation.. Valid values are `D|C`',
    `document_date` DATE COMMENT 'The date of the originating business document (invoice, receipt, lease amendment, etc.) that triggered this journal entry line. May differ from posting_date due to accrual accounting and period-end adjustments.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the posting amount from transaction currency to functional currency at the time of posting. Required for multi-currency reconciliation and audit trail under FASB ASC 830.',
    `fiscal_period` STRING COMMENT 'The fiscal period (accounting month, 1–12 or 1–16 for special periods) within the fiscal year to which this line item is assigned. Drives period-end close, monthly NOI statements, and budget-to-actual variance reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this journal entry line belongs. Used for annual financial consolidation, REIT FFO/AFFO reporting, and year-over-year NOI comparisons.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The posting amount translated into the entitys functional currency (typically USD for US-based REITs). Required for financial consolidation, EBITDA roll-ups, and SEC/FASB reporting when transaction currency differs from functional currency.',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the entitys functional currency used in financial consolidation and statutory reporting (e.g., USD). Distinct from transaction_currency_code for multi-currency portfolios.. Valid values are `^[A-Z]{3}$`',
    `gl_account_code` STRING COMMENT 'The alphanumeric GL account code from the chart of accounts as it appears in the source system (Yardi Voyager or SAP S/4HANA). Retained as a denormalized reference for direct financial reporting and reconciliation without requiring a join.',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this line item represents an intercompany transaction between related legal entities within the same ownership structure. Required for intercompany elimination during financial consolidation and SOX compliance.',
    `intercompany_partner_code` STRING COMMENT 'The trading partner entity code for intercompany transactions. Populated only when intercompany_flag is true. Used to match and eliminate intercompany balances during financial consolidation.',
    `internal_order_code` STRING COMMENT 'SAP internal order code used for collecting costs related to specific maintenance activities, tenant improvement projects, or short-term CAPEX initiatives. Complements WBS elements for granular cost object tracking.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this journal entry line record in the source system. Supports incremental data loading, change data capture, and SOX audit trail requirements.',
    `line_description` STRING COMMENT 'Free-text description of the individual journal entry line item explaining the nature of the posting (e.g., Q3 CAM reconciliation adjustment, TI amortization — Suite 400, CAPEX — HVAC replacement). Supports audit trail and financial review.',
    `line_number` STRING COMMENT 'Sequential line item number within the parent journal entry. Establishes ordering of debit and credit postings and is used for audit trail reconstruction and reconciliation.',
    `line_type` STRING COMMENT 'Classification of the journal entry line by its accounting nature. Distinguishes standard postings from accruals, reversals, period-end adjustments, intercompany eliminations, and consolidation entries. Critical for SOX-compliant financial controls and audit.. Valid values are `standard|accrual|reversal|adjustment|intercompany|elimination`',
    `noi_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this line item is included in the property-level Net Operating Income (NOI) calculation. Excludes debt service, depreciation, and capital items from NOI per industry standard definitions.',
    `opex_capex_indicator` STRING COMMENT 'Classifies the line item as an operating expenditure (OPEX) or capital expenditure (CAPEX). Fundamental for property-level NOI statements, CAPEX budgeting, fixed asset capitalization, and REIT FFO/AFFO adjustments.. Valid values are `OPEX|CAPEX`',
    `posted_by` STRING COMMENT 'The user ID or name of the individual who posted this journal entry line to the General Ledger. Supports SOX segregation of duties controls, audit trail, and financial close governance.',
    `posting_amount` DECIMAL(18,2) COMMENT 'The monetary amount of this line item in the transaction currency. Always a positive value; the debit_credit_indicator determines the direction of the posting. Used in NOI calculations, CAM reconciliations, and OPEX/CAPEX allocations.',
    `posting_date` DATE COMMENT 'The accounting date on which this line item is posted to the General Ledger. Determines the fiscal period to which the posting belongs and drives period-end close, NOI statements, and financial reporting.',
    `posting_status` STRING COMMENT 'Current lifecycle status of the journal entry line within the GL workflow. Indicates whether the line has been fully posted, reversed, parked for review, held pending approval, or cleared against an open item.. Valid values are `posted|reversed|parked|held|cleared`',
    `profit_center_code` STRING COMMENT 'The alphanumeric profit center code as sourced from SAP S/4HANA. Retained as a denormalized field for portfolio-level P&L segmentation and REIT segment reporting without requiring a join.',
    `reference_document_number` STRING COMMENT 'External reference number linking this line item to the originating business document (e.g., invoice number, lease payment reference, purchase order number, work order ID). Supports AP/AR reconciliation and audit trail.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this line item is a reversal of a previously posted entry (e.g., accrual reversal at period start). Used to identify and exclude reversal pairs from period-end balance calculations.',
    `segment_code` STRING COMMENT 'Business segment identifier (e.g., commercial, residential, industrial, retail) used for segment-level financial reporting per FASB ASC 280 and SEC REIT disclosure requirements. Enables EBITDA and NOI roll-ups by portfolio segment.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this journal entry line was sourced (e.g., Yardi Voyager, SAP S/4HANA, MRI Software, or Manual entry). Required for data lineage, reconciliation, and Silver Layer audit trail.. Valid values are `Yardi Voyager|SAP S/4HANA|MRI Software|Manual`',
    `tax_code` STRING COMMENT 'Tax classification code applied to this line item for VAT, sales tax, or property tax determination. Used in tax reporting, CAM reconciliations, and NNN lease tax pass-through calculations.',
    `value_date` DATE COMMENT 'The effective date for cash flow and bank value purposes, particularly relevant for treasury postings, rent receipts, and loan disbursements. Used in DSCR calculations and cash management reporting.',
    `wbs_element_code` STRING COMMENT 'Work Breakdown Structure (WBS) element code from SAP S/4HANA Project Systems or Procore, used to allocate CAPEX line items to specific development or renovation projects. Enables project-level cost tracking and CAPEX budget control.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit or credit line items within a journal entry, each mapped to a GL account, cost center, and property. Provides the granular posting detail required for property-level NOI statements, CAM reconciliations, and OPEX/CAPEX allocations. Attributes include line number, debit/credit indicator, amount, functional currency amount, account code, cost center, property reference, profit center, segment, tax code, and line description.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Unique surrogate identifier for each accounts payable invoice record in the Silver layer lakehouse. Primary key for the ap_invoice data product.',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: Appraisal engagement fees generate AP invoices. Linking ap_invoice to appraisal enables matching of appraisal costs to the specific engagement for budget tracking and vendor payment management, a stan',
    `asset_id` BIGINT COMMENT 'Reference to the property to which this invoice is allocated. Enables property-level expense tracking, NOI calculations, and CAM reconciliation.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: ap_invoice currently stores bank_account_number as a denormalized STRING. Adding a proper FK bank_account_id → finance.bank_account.bank_account_id normalizes the payment destination, enabling joins t',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: AP invoices for building-specific operating expenses (utilities, janitorial, insurance, elevator maintenance) require building-level coding for CAM pool allocation, building P&L, and CAM reconciliatio',
    `campaign_flight_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_flight. Business justification: Media vendor invoices in real estate are billed at the campaign flight level (specific placement periods). AP must reference the campaign flight to validate invoice amounts against flight budgets and ',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Marketing-related AP invoices (agency retainers, event costs, creative production) must be attributed to specific campaigns for campaign ROI analysis and budget reconciliation. Real estate marketing c',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the GL account in the chart of accounts to which this invoice is posted. Drives financial reporting, NOI statements, and EBITDA roll-ups.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.assessment. Business justification: AP invoices from third-party assessors, environmental consultants, and compliance auditors are directly tied to assessment engagements. Property managers and controllers need to track assessment costs',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Real estate AP invoices for construction, renovation, and capital work must reference the permit authorizing the work. Permit-linked invoices are required for certificate of occupancy closeout, lien w',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Real estate AP invoices are generated to pay regulatory fines, penalties, and violation settlements. A real estate compliance manager expects penalty payment invoices to reference the violation being ',
    `construction_contract_id` BIGINT COMMENT 'Foreign key linking to development.construction_contract. Business justification: AP invoices for construction payments reference the authorizing construction contract. Finance teams require contract-to-invoice linkage for payment tracking, retainage management, lien waiver complia',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this invoice. Used for departmental expense allocation, OPEX tracking, and financial consolidation in SAP S/4HANA.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: RE property management involves vendor invoices in multiple currencies (international properties, foreign vendors). Linking to reference.currency_code enables validated currency lookups for AP aging r',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Fund-level operating expenses (audit fees, fund administration, legal fees) are captured as AP invoices coded to the fund. Real estate fund controllers require fund-level AP coding for management fee ',
    `lease_agreement_id` BIGINT COMMENT 'Foreign key linking to lease.agreement. Business justification: AP invoices for leasing commissions, TI construction work, and lease-related vendor services are tied to specific lease agreements for cost allocation, TI budget tracking, and leasing commission expen',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: AP invoices are processed and recorded under a specific legal entity for SOX compliance, tax reporting, and intercompany accounting. In a real estate enterprise with multiple property-owning entities,',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to property.inspection. Business justification: AP invoices for inspection-triggered remediation work reference the specific inspection that identified the deficiency. This supports work order to invoice matching, regulatory compliance documentatio',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order associated with this invoice, enabling three-way match (PO, receipt, invoice) for procure-to-pay controls. Nullable for non-PO invoices.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: AP invoices for compliance expenditures (environmental remediation, mandatory inspections, regulatory filing fees) must be coded to the governing regulatory obligation for obligation-level spend track',
    `tax_assessment_id` BIGINT COMMENT 'Foreign key linking to valuation.tax_assessment. Business justification: Property tax bills generate AP invoices. Linking ap_invoice to tax_assessment enables matching of tax payments to the specific assessment, supporting tax appeal tracking and NNN tenant recovery billin',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: In RE AP, invoice types (capital expenditure, operating expense, CAM, tenant improvement) map to transaction types that determine GL account coding, CAPEX vs OPEX classification, and CAM recovery elig',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: ap_invoice.work_order_number is a denormalized reference to work_order. In RE, vendor AP invoices for maintenance services are matched to work orders for 3-way matching, cost verification, and CAM rec',
    `ap_invoice_description` STRING COMMENT 'Free-text description of the goods or services invoiced as provided by the vendor or entered by AP staff. Used for audit review, expense coding, and work order matching.',
    `approval_status` STRING COMMENT 'The current approval workflow status of the invoice. Tracks whether the invoice has been reviewed and authorized by the appropriate approver(s) per the delegation of authority matrix. Required for SOX compliance.. Valid values are `pending|approved|rejected|escalated`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time at which the invoice was approved for payment. Provides a precise audit trail for SOX compliance and approval cycle time analytics.',
    `cleared_date` DATE COMMENT 'The date on which the payment cleared the bank (check cashed, ACH settled, wire confirmed). Used for bank reconciliation and cash management reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this invoice record was first created in the source system. Provides the audit creation trail required for SOX compliance and data lineage.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The discount amount available if payment is made within the early payment discount window as specified in the payment terms (e.g., 2/10 Net 30). Supports cash discount optimization.',
    `due_date` DATE COMMENT 'The date by which payment must be made to the vendor to comply with agreed payment terms and avoid late payment penalties. Derived from invoice date plus payment terms.',
    `expense_category` STRING COMMENT 'The business expense classification for this invoice (e.g., OPEX - Repairs and Maintenance, CAPEX - Building Improvement, CAM, Utilities, Insurance, Property Tax, Management Fees). Used for NOI statement line items and budget variance analysis. [ENUM-REF-CANDIDATE: opex_repairs|opex_utilities|opex_insurance|opex_property_tax|opex_management_fees|capex_improvement|cam|professional_services — promote to reference product]',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before any tax deductions or discounts, as stated on the vendor invoice. Represents the full obligation prior to adjustments.',
    `invoice_date` DATE COMMENT 'The date printed on the vendor invoice document. Represents the principal business event date for the invoice and is used to determine payment due dates based on payment terms.',
    `invoice_number` STRING COMMENT 'The externally-assigned invoice number as provided by the vendor on the invoice document. Used for vendor reconciliation, dispute resolution, and audit trail. Must be unique per vendor.',
    `invoice_status` STRING COMMENT 'Current workflow lifecycle state of the invoice within the procure-to-pay cycle. Drives approval routing, payment scheduling, and financial reporting. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|posted|paid|void|on_hold — promote to reference product]',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this invoice is part of a recurring payment schedule (e.g., monthly service contracts, insurance premiums, property management fees). Supports automated recurring invoice processing.',
    `is_void` BOOLEAN COMMENT 'Indicates whether this invoice has been voided. Voided invoices are retained for audit trail purposes but excluded from financial reporting and payment processing.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net payable amount after deducting applicable discounts and adjustments from the gross amount. Represents the actual cash obligation to the vendor.',
    `paid_amount` DECIMAL(18,2) COMMENT 'The actual amount disbursed to the vendor for this invoice. May differ from net_amount in cases of partial payments, disputed amounts, or applied credits.',
    `payment_date` DATE COMMENT 'The date on which payment was issued to the vendor. Used for cash flow reporting, vendor aging analysis, and DSCR calculations at the property level.',
    `payment_method` STRING COMMENT 'The disbursement method used or designated for paying this invoice. Determines the payment run processing path in Yardi Voyager or SAP S/4HANA (check run, ACH batch, wire transfer, virtual card).. Valid values are `check|ach|wire|virtual_card|eft`',
    `payment_number` STRING COMMENT 'The check number, ACH transaction reference, or wire transfer confirmation number associated with the disbursement for this invoice. Populated upon payment execution.',
    `payment_terms` STRING COMMENT 'The agreed payment terms between the company and the vendor as stated on the invoice or vendor master (e.g., Net 30, Net 60, 2/10 Net 30, Due on Receipt). Drives due date calculation and cash flow forecasting.',
    `po_number` STRING COMMENT 'The human-readable purchase order number referenced on the vendor invoice. Enables three-way match validation and procurement compliance. Nullable for non-PO invoices.',
    `posting_date` DATE COMMENT 'The accounting date on which the invoice is posted to the general ledger. Determines the fiscal period for expense recognition and financial reporting under GAAP/IFRS.',
    `received_date` DATE COMMENT 'The date the invoice was physically or electronically received by the accounts payable department. Used to calculate processing cycle time and aging from receipt.',
    `service_period_end` DATE COMMENT 'The end date of the service period covered by this invoice. Used alongside service_period_start for accrual-basis expense recognition and period-over-period reporting.',
    `service_period_start` DATE COMMENT 'The start date of the service period covered by this invoice. Critical for accrual accounting, period matching, and CAM reconciliation under GAAP.',
    `source_system` STRING COMMENT 'The operational system of record from which this invoice record was sourced. Distinguishes Yardi Voyager AP invoices (property-level) from SAP S/4HANA invoices (corporate/enterprise-level) for lineage and reconciliation.. Valid values are `yardi_voyager|sap_s4hana`',
    `source_system_invoice_code` STRING COMMENT 'The native primary key or unique identifier of this invoice record in the originating source system (Yardi Voyager or SAP S/4HANA). Enables traceability from the Silver layer back to the system of record.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax component of the invoice including sales tax, use tax, or VAT as applicable. Separated for tax reporting, input tax recovery, and compliance with tax authorities.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this invoice record was last modified in the source system or Silver layer. Supports change data capture, incremental loads, and audit trail requirements.',
    `vendor_invoice_ref` STRING COMMENT 'Additional vendor-side reference number or remittance advice code provided on the invoice, distinct from the primary invoice number. Used for vendor reconciliation and dispute management.',
    `void_date` DATE COMMENT 'The date on which the invoice was voided. Populated only when is_void is True. Required for audit trail and period-end reconciliation.',
    `void_reason` STRING COMMENT 'The reason code explaining why the invoice was voided. Required for SOX audit trail and AP quality control reporting.. Valid values are `duplicate|incorrect_amount|incorrect_vendor|cancelled_service|data_entry_error|other`',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts payable records covering the full procure-to-pay cycle for vendor payments related to property operations, construction, maintenance, and corporate services. Captures vendor invoices and associated disbursements (check runs, ACH, wire transfers) from Yardi Voyager AP and SAP S/4HANA. Invoice attributes include invoice number, vendor ID, invoice date, due date, payment terms, gross amount, tax amount, net amount, currency, property/cost center allocation, approval status, PO reference, and source system. Payment attributes include payment number, payment date, payment method, bank account, payment amount, cleared date, void flag, and void date.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'Unique surrogate identifier for each AP payment disbursement record in the Silver Layer lakehouse. Primary key for this entity.',
    `ap_invoice_id` BIGINT COMMENT 'Reference to the primary AP invoice record being settled by this payment. Establishes the payment-to-invoice linkage for invoice aging, open payables, and three-way match validation. For partial payments or multi-invoice check runs, this captures the primary invoice.',
    `asset_id` BIGINT COMMENT 'Reference to the property against which this payment is charged. Enables property-level OPEX tracking, NOI statement preparation, and CAM reconciliation. Null for corporate-level payables not attributable to a specific property.',
    `bank_account_id` BIGINT COMMENT 'Reference to the company bank account from which the payment was disbursed. Links to the bank account master for account number, bank name, routing number, and GL cash account mapping. Required for bank reconciliation.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the General Ledger account to which this payment is posted. Drives financial statement classification (OPEX vs CAPEX), NOI calculations, and EBITDA roll-ups. Sourced from Yardi Voyager or SAP S/4HANA chart of accounts.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this expenditure. Used for departmental expense allocation, property-level cost tracking, and management reporting. Aligns with SAP S/4HANA controlling (CO) module cost center hierarchy.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: RE AP payments to international vendors or for cross-border property expenses require validated currency references for exchange rate application, bank reconciliation, and multi-currency cash flow rep',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: AP payments are disbursed by a specific legal entity — the entity that owns the bank account and bears the liability. In a multi-entity real estate portfolio, payment runs must be attributed to the co',
    `payment_run_id` BIGINT COMMENT 'Reference to the batch payment run or check run that generated this payment. Groups individual payments processed together in a single disbursement cycle. Used for batch reconciliation, audit trails, and payment run reporting.',
    `ach_trace_number` STRING COMMENT 'NACHA-assigned trace number for ACH electronic payments. Uniquely identifies the ACH transaction within the Federal Reserve or EPN clearing network. Used for ACH return resolution and bank reconciliation. Null for non-ACH payments.',
    `approval_status` STRING COMMENT 'Workflow approval status of the payment prior to disbursement. pending = awaiting approver action; approved = authorized for payment; rejected = denied by approver; auto_approved = system-approved within pre-authorized limits. Supports SOX-compliant segregation of duties controls.. Valid values are `pending|approved|rejected|auto_approved`',
    `approved_by` STRING COMMENT 'Name or user identifier of the individual who authorized this payment for disbursement. Required for SOX-compliant audit trails and segregation of duties documentation. Captures the approver at time of authorization.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was approved for disbursement. Used for SOX audit trails, approval turnaround time analysis, and segregation of duties compliance reporting.',
    `bank_routing_number` STRING COMMENT 'ABA routing transit number of the vendors receiving bank account. Required for ACH and wire payment processing. Stored for remittance and payment audit purposes. Classified confidential as it is a banking identifier.. Valid values are `^[0-9]{9}$`',
    `check_number` STRING COMMENT 'Physical or laser-printed check number for check-based payments. Null for ACH, wire, or virtual card payments. Used for positive pay file submission to the bank and check register reconciliation.',
    `cleared_date` DATE COMMENT 'Date on which the payment was confirmed as settled/cleared by the bank (i.e., funds debited from the company bank account and confirmed received). Used for bank reconciliation, outstanding check aging, and cash position reporting. Null until cleared.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this AP payment record was first created in the Silver Layer lakehouse. Used for data lineage, audit trails, and record-level change tracking. Populated by the ingestion pipeline at load time.',
    `discount_taken_amount` DECIMAL(18,2) COMMENT 'Early-payment discount amount deducted from the invoice balance at time of payment (e.g., 2/10 net 30 terms). Reduces the net cash disbursed and is tracked separately for GL posting to discount income accounts.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign currency exchange rate applied at the time of payment to convert the transaction currency amount to the functional (base) currency. Applicable for cross-border vendor payments. Stored for audit and financial consolidation purposes per FASB ASC 830.',
    `expense_category` STRING COMMENT 'High-level expense classification for financial reporting and NOI analysis. opex = Operating Expenditure (OPEX) for property operations; capex = Capital Expenditure (CAPEX) for improvements; ti = Tenant Improvement (TI) allowance; cam = Common Area Maintenance (CAM) expense; debt_service = mortgage or loan payment; tax = property tax; insurance = property insurance premium. [ENUM-REF-CANDIDATE: opex|capex|ti|cam|debt_service|tax|insurance — 7 candidates stripped; promote to reference product]',
    `fiscal_period` STRING COMMENT 'Accounting fiscal period (YYYY-MM format) to which this payment is attributed for financial reporting. Derived from gl_posting_date but stored explicitly to support period-based filtering, NOI period reporting, and budget-vs-actual variance analysis.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Payment amount expressed in the entitys functional (base) currency after applying the exchange rate. Used for consolidated financial reporting, NOI statements, and EBITDA roll-ups across multi-currency portfolios.',
    `gl_posting_date` DATE COMMENT 'The accounting date on which this payment is posted to the General Ledger. May differ from payment_date due to period-close cutoffs or accrual adjustments. Determines the accounting period for financial reporting and SOX-compliant period-end close.',
    `is_1099_reportable` BOOLEAN COMMENT 'Indicates whether this payment is subject to IRS Form 1099 reporting requirements. True = payment must be included in annual 1099 filing for the vendor. Determined by vendor tax classification and payment type.',
    `is_partial_payment` BOOLEAN COMMENT 'Indicates whether this payment represents a partial settlement of the associated invoice(s) rather than full payment. True = partial payment; False = full payment. Used for open invoice aging and vendor statement reconciliation.',
    `is_voided` BOOLEAN COMMENT 'Indicates whether this payment has been voided (cancelled after issuance but before or after clearing). True = payment is voided and should be excluded from cash disbursement totals. Used for audit trails and reissuance tracking.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'Actual net cash disbursed to the vendor after deducting any early-payment discounts or adjustments from the gross payment amount. Equals payment_amount minus discount_taken_amount. Used for bank reconciliation and cash management reporting.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Gross amount disbursed to the vendor in the transaction currency. Represents the total funds transferred, before any discount adjustments. Core monetary field for AP cash disbursement reporting and DSCR calculations.',
    `payment_date` DATE COMMENT 'The principal business event date on which the payment was issued or disbursed to the vendor. For checks, this is the check date; for ACH/wire, this is the value date. Used for cash flow reporting and period-close cutoff.',
    `payment_memo` STRING COMMENT 'Free-text memo or description associated with the payment, as entered by the AP processor. Appears on check stubs, ACH addenda records, or wire instructions. Used for vendor communication and internal reference.',
    `payment_method` STRING COMMENT 'The instrument or mechanism used to disburse funds to the vendor. check = physical or laser-printed check; ach = Automated Clearing House electronic transfer; wire = same-day wire transfer; virtual_card = single-use virtual credit card; eft = generic electronic funds transfer.. Valid values are `check|ach|wire|virtual_card|eft`',
    `payment_number` STRING COMMENT 'Externally-known, human-readable payment reference number assigned by the source system (e.g., Yardi check number or SAP payment document number). Used for reconciliation, audit trails, and vendor remittance advice.',
    `payment_status` STRING COMMENT 'Current lifecycle state of the AP payment. pending = approved but not yet disbursed; issued = check printed or ACH/wire initiated; cleared = confirmed settled by bank; voided = cancelled before clearing; stopped = stop-payment placed; returned = ACH/wire returned by receiving bank.. Valid values are `pending|issued|cleared|voided|stopped|returned`',
    `payment_type` STRING COMMENT 'Business classification of the payment purpose. vendor_payment = standard operating expense vendor; ti_allowance = Tenant Improvement (TI) allowance disbursement to tenant or contractor; construction_draw = CAPEX draw for development/renovation; security_deposit_refund = return of tenant security deposit; owner_distribution = distribution to property owner; corporate_payable = non-property corporate expense. [ENUM-REF-CANDIDATE: vendor_payment|ti_allowance|construction_draw|security_deposit_refund|owner_distribution|corporate_payable — promote to reference product]. Valid values are `vendor_payment|ti_allowance|construction_draw|security_deposit_refund|owner_distribution|corporate_payable`',
    `positive_pay_submitted` BOOLEAN COMMENT 'Indicates whether this check payment has been submitted to the banks positive pay fraud prevention service. True = submitted; False = not submitted. Applicable only to check payments. Used for fraud control compliance and bank reconciliation.',
    `remittance_advice_number` STRING COMMENT 'Reference number of the remittance advice document sent to the vendor detailing which invoices are being paid and any discounts applied. Used for vendor reconciliation and dispute resolution.',
    `source_system` STRING COMMENT 'Operational system of record from which this payment record originated. Used for data lineage, reconciliation between systems, and Silver Layer provenance tracking. Supports multi-system consolidation across Yardi Voyager and SAP S/4HANA.. Valid values are `yardi_voyager|sap_s4hana|mri_software`',
    `source_system_payment_code` STRING COMMENT 'Native payment identifier from the originating source system (e.g., Yardi Voyager internal payment key or SAP FI document number). Preserved for cross-system reconciliation, data lineage, and drill-back to the operational system of record.',
    `tax_year` STRING COMMENT 'Calendar or fiscal tax year to which this payment is attributed for 1099 reporting purposes. Required for IRS Form 1099-MISC/NEC annual reporting for vendor payments exceeding IRS thresholds. Null for non-1099-reportable payments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this AP payment record was last modified in the Silver Layer lakehouse. Tracks updates such as void processing, cleared date population, or approval status changes. Used for incremental load detection and audit compliance.',
    `value_date` DATE COMMENT 'The bank value date on which funds are available to the recipient. For ACH payments, this is the settlement date (typically T+1 or T+2). For wires, this is the same-day settlement date. Distinct from payment_date (initiation) and cleared_date (confirmation).',
    `vendor_name` STRING COMMENT 'Legal or trade name of the vendor/payee at the time of payment. Captured as a denormalized field for remittance advice, audit trails, and reporting without requiring a join to the vendor master.',
    `void_date` DATE COMMENT 'Date on which the payment was voided in the source system. Null if the payment has not been voided. Used for audit trails, outstanding check resolution, and period-close adjustments.',
    `void_reason` STRING COMMENT 'Reason code explaining why the payment was voided. Used for audit compliance, fraud detection, and AP process improvement. Null if payment is not voided. [ENUM-REF-CANDIDATE: lost_check|stale_dated|incorrect_amount|duplicate_payment|vendor_request|bank_return|stop_payment — promote to reference product]',
    `wire_reference_number` STRING COMMENT 'Bank-assigned reference number for wire transfer payments (SWIFT/Fedwire). Used to trace and confirm wire settlement with the receiving bank. Null for non-wire payments.',
    `withholding_amount` DECIMAL(18,2) COMMENT 'Amount withheld from the vendor payment for backup withholding, retention, or tax withholding purposes. Common in construction contracts (retention holdback) and for 1099-reportable vendors subject to IRS backup withholding. Reduces net disbursement.',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Records of actual disbursements made to vendors against AP invoices, including check runs, ACH transfers, and wire payments. Tracks payment execution for property operating expenses, TI allowances, construction draws, and corporate payables. Attributes include payment number, payment date, payment method (check, ACH, wire), bank account, payment amount, currency, cleared date, void flag, void date, and associated invoice references.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'Unique surrogate identifier for each accounts receivable invoice record in the Silver Layer lakehouse. Primary key for the ar_invoice data product.',
    `amenity_id` BIGINT COMMENT 'Foreign key linking to property.amenity. Business justification: AR invoices for amenity usage fees (conference room rental, fitness center memberships, rooftop event space) reference the specific amenity for amenity revenue tracking, NOI attribution, and tenant am',
    `application_id` BIGINT COMMENT 'Foreign key linking to tenant.application. Business justification: Application fee invoices and initial rent invoices originate from the approved application. AR teams reconcile invoice creation back to the application for audit trails, application fee refund process',
    `asset_id` BIGINT COMMENT 'Reference to the property against which this invoice is raised. Supports property-level NOI statements, EGI/PGI roll-ups, and portfolio-level P&L reporting.',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: AR invoices for rent, CAM, and utilities are issued against specific buildings in multi-building portfolios. Building-level AR aging reports, CAM reconciliation, and tenant billing statements require ',
    `cam_schedule_id` BIGINT COMMENT 'Foreign key linking to lease.cam_schedule. Business justification: CAM reconciliation invoices are generated from cam_schedule records; direct FK supports CAM billing audit trail and tenant dispute resolution. RE property accountants generate annual CAM true-up invoi',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: ar_invoice has gl_account_code as a denormalized STRING but lacks a proper FK to finance.chart_of_accounts. Every AR invoice posts to a GL account (rent income, CAM recovery, etc.) and must be linked ',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to tenant.corporate_entity. Business justification: Commercial RE billing consolidation: enterprise tenants are invoiced at the corporate entity level (parent company) for consolidated AR aging, credit exposure reporting, and enterprise lease portfolio',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ar_invoice has cost_center_code as a denormalized STRING but lacks a proper FK to finance.cost_center. AR invoices in real estate are always associated with a cost center for NOI tracking and property',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: RE tenant billing in multi-currency portfolios (international tenants, cross-border leases) requires validated currency references for AR aging, revenue recognition, and investor reporting. Replaces d',
    `guarantor_id` BIGINT COMMENT 'Foreign key linking to tenant.guarantor. Business justification: When guarantors are called upon during collections, AR invoices are issued directly to the guarantor. Collections teams must track which guarantor is liable for a specific invoice to enforce guarantee',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the lease agreement under which this invoice is generated. Enables lease-level receivable tracking, CAM reconciliation, and WALT/WALE analytics.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: AR invoices are issued by a specific legal entity (the property-owning entity) to tenants. In a real estate enterprise with multiple property-owning LLCs or REITs, each AR invoice must be attributed t',
    `notice_id` BIGINT COMMENT 'Foreign key linking to tenant.notice. Business justification: Rent increase and default cure process: notices (rent increase, default, CAM true-up) directly trigger AR invoice creation or adjustment. Linking invoice to the originating notice provides the audit t',
    `occupancy_id` BIGINT COMMENT 'Foreign key linking to tenant.occupancy. Business justification: Rent invoices are generated per occupancy period. Property accountants tie each AR invoice to the occupancy record to validate billing period alignment, prorate move-in/move-out charges, and support C',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Ground lease rent invoices are billed against specific parcels, not buildings or units. Ground lease AR billing, parcel-level rent roll reporting, and ground lease escalation tracking require direct p',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: AR invoices for commercial space rent, CAM charges, and percentage rent reference the specific space for CAM reconciliation, percentage rent breakpoint calculations, and space-level revenue reporting.',
    `rent_schedule_id` BIGINT COMMENT 'Foreign key linking to lease.rent_schedule. Business justification: AR invoices for rent are generated from rent schedules; direct FK supports billing accuracy verification and rent roll reporting. RE property managers generate monthly rent invoices from rent schedule',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant party responsible for this invoice. Links to the tenant master record for receivable aging, tenant ledger, and CRM reporting.',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: In RE AR, charge types (base rent, CAM recovery, percentage rent, late fee, TI reimbursement) map to transaction types that drive revenue recognition (ASC 842), NOI categorization, and investor report',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: AR invoices for unit rent, utilities, and ancillary charges reference the specific unit for rent roll reconciliation, delinquency tracking, and lease administration. ar_invoice has agreement_id but un',
    `aging_bucket` STRING COMMENT 'Receivable aging classification based on days elapsed since the invoice due date. Used in tenant receivable aging reports, credit risk assessment, and property-level delinquency dashboards.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `applied_amount` DECIMAL(18,2) COMMENT 'Total cash receipts applied against this invoice to date. The difference between net_amount and applied_amount yields the outstanding balance. Critical for aging and delinquency reporting.',
    `bank_deposit_reference` STRING COMMENT 'Bank deposit slip or batch reference number linking this receipt to the physical or electronic bank deposit. Supports bank reconciliation and treasury cash management.',
    `billing_period_end` DATE COMMENT 'Last day of the billing period covered by this invoice. Together with billing_period_start defines the service period for revenue recognition and CAM reconciliation.',
    `billing_period_start` DATE COMMENT 'First day of the billing period covered by this invoice. Used for proration calculations, CAM reconciliation periods, and EGI/PGI period alignment.',
    `breakpoint_amount` DECIMAL(18,2) COMMENT 'Natural or artificial breakpoint threshold above which percentage rent is owed per the lease agreement. Used to calculate overage rent on percentage_rent charge type invoices.',
    `cam_reconciliation_year` STRING COMMENT 'Calendar or fiscal year for which CAM charges on this invoice are being reconciled. Applicable only to CAM charge type invoices. Supports annual CAM true-up calculations per lease terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was first created in the source system. Provides the audit trail creation point required for SOX-compliant financial controls.',
    `credit_memo_reference` STRING COMMENT 'Reference number of any credit memo issued against this invoice for adjustments, concessions, or billing corrections. Null if no credit memo applies.',
    `days_past_due` STRING COMMENT 'Number of calendar days elapsed since the invoice due date as of the last refresh. Zero or negative indicates current. Drives aging bucket assignment and late fee eligibility.',
    `dispute_date` DATE COMMENT 'Date on which the invoice dispute was formally raised. Used to track dispute resolution SLAs and tenant relationship metrics.',
    `dispute_reason` STRING COMMENT 'Free-text or coded reason provided by the tenant or property manager when an invoice is placed in disputed status. Supports dispute resolution workflow and tenant relationship management.',
    `due_date` DATE COMMENT 'Date by which payment is contractually required per the lease terms. Drives aging bucket classification, late fee triggering, and tenant delinquency reporting.',
    `fiscal_period` STRING COMMENT 'Accounting fiscal period (YYYY-MM) to which this invoice is attributed for financial reporting. Aligns with the property management entitys fiscal calendar in Yardi Voyager and SAP S/4HANA.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total pre-tax invoice amount before any adjustments, credits, or concessions. Represents the full contractual charge for the billing period. Used as the basis for PGI calculations.',
    `invoice_date` DATE COMMENT 'The principal business event date on which the invoice was issued to the tenant. Used as the basis for aging calculations, revenue recognition, and EGI/PGI reporting periods.',
    `invoice_number` STRING COMMENT 'Externally-visible, human-readable invoice reference number as assigned by Yardi Voyager AR. Used for tenant correspondence, remittance matching, and audit trails. Unique within a property management entity.',
    `invoice_status` STRING COMMENT 'Current lifecycle state of the AR invoice. Controls downstream processing: draft invoices are not yet posted; open invoices are outstanding; partially_paid indicates partial cash application; paid indicates full settlement; void indicates cancellation; disputed indicates tenant-raised dispute under review.. Valid values are `draft|open|partially_paid|paid|void|disputed`',
    `late_fee_rate` DECIMAL(18,2) COMMENT 'Contractual late fee rate (as a decimal percentage) applied to overdue balances per the lease agreement. Used to calculate late fee invoice amounts when days_past_due exceeds the grace period.',
    `net_amount` DECIMAL(18,2) COMMENT 'Total amount due from the tenant after tax inclusion (gross_amount + tax_amount). Represents the actual receivable balance posted to the tenant ledger and used in EGI calculations.',
    `nsf_flag` BOOLEAN COMMENT 'Indicates whether the payment associated with this invoice was returned due to non-sufficient funds (NSF). True triggers reversal of the applied receipt and potential late fee assessment per lease terms.',
    `payment_method` STRING COMMENT 'Instrument used by the tenant to remit payment. Informs treasury operations, bank deposit routing, and NSF risk profiling. ACH and wire are most common for commercial tenants.. Valid values are `ach|check|wire|credit_card|cash|other`',
    `percentage_rent_sales_amount` DECIMAL(18,2) COMMENT 'Tenant-reported gross sales amount used as the basis for percentage rent calculation. Applicable only to percentage_rent charge type invoices. Sourced from tenant sales reports per lease breakpoint provisions.',
    `post_date` DATE COMMENT 'Date on which the invoice was posted to the General Ledger accounting period. May differ from invoice_date for accrual adjustments. Controls which fiscal period the revenue is recognized in.',
    `posted_flag` BOOLEAN COMMENT 'Indicates whether this invoice has been posted to the General Ledger. Unposted invoices are excluded from financial reporting. SOX control point for period-end close.',
    `receipt_date` DATE COMMENT 'Date on which cash payment was received and recorded in Yardi Voyager AR. Used for cash flow reporting, bank deposit reconciliation, and DSO (Days Sales Outstanding) calculations.',
    `receipt_number` STRING COMMENT 'Reference number of the cash receipt applied to this invoice, as assigned by Yardi Voyager AR. Enables order-to-cash traceability and bank reconciliation. Null if no payment has been received.',
    `source_system` STRING COMMENT 'Operational system of record from which this invoice record was sourced. Supports data lineage, reconciliation, and Silver Layer ingestion audit.. Valid values are `yardi_voyager|mri_software|manual`',
    `source_system_invoice_code` STRING COMMENT 'Native primary key or invoice identifier from the originating source system (e.g., Yardi Voyager internal invoice ID). Enables reconciliation between the Silver Layer and the operational system of record.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Sales tax, GST, VAT, or other applicable tax assessed on the invoice. Jurisdiction-specific; may be zero for NNN leases where tenant pays taxes directly.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'Portion of received cash not yet applied to a specific invoice line. Represents tenant prepayments or unallocated receipts held in suspense pending application.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this invoice record in the source system or Silver Layer. Required for incremental data loading, change data capture, and SOX audit trail.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount of the invoice balance written off as uncollectible per the bad debt policy. Impacts NOI and requires GL journal entry. Subject to SOX controls and credit committee approval.',
    `write_off_date` DATE COMMENT 'Date on which the bad debt write-off was approved and posted. Required for SOX-compliant audit trail and GL period close.',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Accounts receivable records covering the full order-to-cash cycle for tenant charges and cash receipts — rent billings, CAM reconciliations, percentage rent, TI reimbursements, and miscellaneous property income. Sourced from Yardi Voyager AR. Invoice attributes include invoice number, tenant reference, lease reference, property reference, invoice date, due date, billing period, charge type (base rent, CAM, percentage rent, parking, utility, late fee), gross amount, tax amount, net amount, currency, and aging bucket. Receipt attributes include receipt number, receipt date, payment method, bank deposit reference, amount received, applied amount, unapplied amount, and NSF flag. Supports EGI/PGI calculations and tenant receivable aging reports.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`ar_receipt` (
    `ar_receipt_id` BIGINT COMMENT 'Unique system-generated identifier for each AR cash receipt record in the finance domain. Primary key for the ar_receipt data product.',
    `ar_invoice_id` BIGINT COMMENT 'Reference to the primary AR invoice against which this receipt is applied. Supports invoice-level application tracking and open-item management in the AR sub-ledger.',
    `asset_id` BIGINT COMMENT 'Reference to the property at which the tenancy exists. Enables property-level EGI realization, NOI calculation, and portfolio-level financial reporting.',
    `bank_account_id` BIGINT COMMENT 'Reference to the company bank account into which the payment was deposited. Supports bank reconciliation, cash position reporting, and treasury management.',
    `cam_schedule_id` BIGINT COMMENT 'Foreign key linking to lease.cam_schedule. Business justification: CAM reconciliation payments received are tracked via ar_receipt; direct FK to cam_schedule supports CAM audit trail and dispute resolution. RE property managers need to match CAM receipts to specific ',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the GL account in the chart of accounts to which this receipt is posted. Drives financial consolidation, NOI statements, and EGI/PGI/GOI roll-ups.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center associated with this receipt for property-level and portfolio-level P&L attribution. Supports EBITDA roll-ups and management reporting.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: RE tenant receipts in multi-currency portfolios require validated currency references for bank deposit reconciliation, exchange rate application, and multi-currency cash flow reporting. Replaces denor',
    `guarantor_id` BIGINT COMMENT 'Foreign key linking to tenant.guarantor. Business justification: Payments received from guarantors must be tracked separately from tenant payments for collections reporting, guarantee release decisions, and 1099 reporting. AR teams identify guarantor-sourced receip',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the lease agreement against which this receipt is applied. Enables EGI realization tracking at the lease level and supports FASB ASC 842 / IFRS 16 lease accounting compliance.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Cash receipts are deposited into bank accounts owned by specific legal entities. Attributing ar_receipt to a legal_entity enables entity-level cash flow reporting, intercompany reconciliation, and acc',
    `occupancy_id` BIGINT COMMENT 'Foreign key linking to tenant.tenant_occupancy. Business justification: Cash application process: receipts must be applied to specific occupancy periods for period-accurate revenue recognition, CAM reconciliation, and move-out final account settlement. Property accountant',
    `original_receipt_ar_receipt_id` BIGINT COMMENT 'Reference to the original ar_receipt_id that this record reverses or corrects. Populated only when reversal_flag = True. Enables audit trail linkage between original and reversal entries for SOX compliance.',
    `rent_schedule_id` BIGINT COMMENT 'Foreign key linking to lease.rent_schedule. Business justification: AR receipts for rent payments must be traceable to the specific rent schedule period they satisfy for rent roll reconciliation and delinquency reporting. RE property accountants expect receipts to be ',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant entity who made the payment. Links the receipt to the tenant master record for AR aging, EGI tracking, and tenant relationship management.',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Real estate cash receipts must be classified by transaction type (rent payment, security deposit, CAM true-up, percentage rent) for income recognition, bank reconciliation, and REIT qualifying income ',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the received amount that has been applied against one or more AR invoices. Used to track open-item clearance and AR aging. Applied amount + unapplied amount = received amount.',
    `approved_by` STRING COMMENT 'The username or employee identifier of the supervisor or manager who approved the receipt posting, particularly for large or unusual receipts. Supports SOX segregation of duties and internal control requirements.',
    `bank_deposit_date` DATE COMMENT 'The date on which the payment was physically or electronically deposited into the bank account. Used for bank reconciliation and cash management reporting.',
    `bank_deposit_reference` STRING COMMENT 'The bank-assigned deposit slip or batch reference number confirming the deposit of funds. Used to reconcile AR receipts against bank statements and support SOX-compliant cash controls.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this AR receipt record was first created in the data platform (Silver Layer). Used for data lineage, audit trail, and SOX-compliant record-keeping. Distinct from receipt_date (business event date).',
    `discount_amount` DECIMAL(18,2) COMMENT 'The discount amount granted to the tenant for early payment, if applicable under the lease terms. Reduces the net receivable and is recorded as a contra-revenue item in the GL.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the transaction currency amount to the functional/reporting currency at the time of receipt. Relevant for international portfolios and REIT financial consolidation.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The received amount converted to the entitys functional (reporting) currency using the exchange_rate. Used for consolidated financial statements, REIT reporting, and SEC filings.',
    `income_category` STRING COMMENT 'The income classification of the receipt for EGI (Effective Gross Income) and NOI (Net Operating Income) reporting. Aligns with Argus Enterprise income line categories and property-level P&L structure. [ENUM-REF-CANDIDATE: base_rent|percentage_rent|cam|tax_recovery|insurance_recovery|parking|storage|other — promote to reference product]',
    `is_nsf` BOOLEAN COMMENT 'Indicates whether the payment was returned by the bank due to non-sufficient funds (NSF) or a dishonoured check/ACH. When True, triggers NSF fee assessment, AR reversal, and tenant credit risk review.',
    `is_prepayment` BOOLEAN COMMENT 'Indicates whether this receipt represents a prepayment for a future billing period. When True, the amount is held as a deferred liability until the applicable period, per FASB ASC 842 revenue recognition rules.',
    `is_security_deposit` BOOLEAN COMMENT 'Indicates whether this receipt is a security deposit payment. Security deposits are held in trust and are not recognized as income until forfeited or applied. Drives separate GL coding and regulatory compliance with state/local landlord-tenant laws.',
    `nsf_date` DATE COMMENT 'The date on which the bank notified the company of the NSF return. Populated only when is_nsf = True. Used to calculate NSF fee due dates and initiate AR reversal processing.',
    `payment_method` STRING COMMENT 'The instrument or mechanism used by the tenant to make the payment (e.g., ACH electronic transfer, wire, check, credit card, cash). Drives bank reconciliation, NSF risk assessment, and treasury management.. Valid values are `check|ach|wire|credit_card|cash|eft`',
    `payment_reference` STRING COMMENT 'The payer-provided reference number accompanying the payment (e.g., check number, ACH trace number, wire reference, remittance advice number). Used for remittance matching and dispute resolution.',
    `period_end_date` DATE COMMENT 'The end date of the billing period to which this receipt relates. Together with period_start_date, defines the revenue recognition window for the payment under FASB ASC 842 and IFRS 16.',
    `period_start_date` DATE COMMENT 'The start date of the billing period to which this receipt relates. Used to match receipts to the correct accounting period for EGI realization and accrual-basis reporting under FASB ASC 842.',
    `posted_by` STRING COMMENT 'The username or employee identifier of the AR staff member who posted this receipt in the system of record (Yardi Voyager or SAP S/4HANA). Required for SOX audit trail and segregation of duties compliance.',
    `posting_date` DATE COMMENT 'The date on which the receipt was posted to the General Ledger (GL). May differ from receipt_date due to processing delays or period-end adjustments. Critical for period-close accuracy and SOX-compliant financial controls.',
    `receipt_date` DATE COMMENT 'The real-world business date on which the payment was received from the tenant or payer. This is the principal business event date used for EGI realization, period-end close, and cash flow reporting. Distinct from the posting date and bank value date.',
    `receipt_notes` STRING COMMENT 'Free-text notes entered by the AR processor regarding the receipt, such as tenant instructions, dispute context, partial payment explanations, or special handling instructions.',
    `receipt_number` STRING COMMENT 'Externally visible, human-readable receipt reference number assigned by the AR system (e.g., Yardi Voyager or SAP S/4HANA) at the time of payment posting. Used for tenant remittance matching and audit trails.. Valid values are `^RCP-[0-9]{4}-[0-9]{6}$`',
    `receipt_status` STRING COMMENT 'Current lifecycle state of the cash receipt. posted indicates fully applied to AR; unposted is pending review; reversed indicates a reversal entry was created; nsf indicates a returned/bounced payment; on_account indicates unapplied credit; voided indicates the receipt was cancelled. [ENUM-REF-CANDIDATE: posted|unposted|reversed|nsf|on_account|voided — promote to reference product]. Valid values are `posted|unposted|reversed|nsf|on_account|voided`',
    `receipt_type` STRING COMMENT 'Classification of the nature of the payment received. Distinguishes rent payments, security deposit receipts, CAM (Common Area Maintenance) reconciliation payments, late fees, prepayments, and miscellaneous income. Drives EGI component analysis and GL coding. [ENUM-REF-CANDIDATE: rent|security_deposit|cam_reconciliation|late_fee|miscellaneous|prepayment — promote to reference product]. Valid values are `rent|security_deposit|cam_reconciliation|late_fee|miscellaneous|prepayment`',
    `received_amount` DECIMAL(18,2) COMMENT 'The gross amount of cash received from the tenant or payer in the transaction currency. This is the total funds received before any application or allocation. Core component of EGI realization and cash flow reporting.',
    `remittance_advice_number` STRING COMMENT 'The remittance advice document number provided by the tenant with their payment, detailing which invoices the payment is intended to cover. Supports automated cash application and dispute resolution.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this receipt record is a reversal entry created to offset a previously posted receipt (e.g., due to NSF, data entry error, or duplicate posting). When True, the original_receipt_id should be populated.',
    `source_system` STRING COMMENT 'The operational system of record from which this receipt record originated. Supports data lineage, reconciliation between systems, and Silver Layer provenance tracking in the Databricks Lakehouse.. Valid values are `yardi_voyager|sap_s4hana|mri_software|manual`',
    `source_system_receipt_code` STRING COMMENT 'The native receipt identifier from the originating system of record (e.g., Yardi Voyager receipt key or SAP document number). Enables traceability from the Silver Layer back to the source system for reconciliation and audit.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the received amount that has not yet been applied to any AR invoice and remains as an on-account credit. Triggers follow-up by the AR team for proper allocation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this AR receipt record was last modified in the data platform. Tracks corrections, reversals, and status changes for audit trail and SOX compliance purposes.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'The amount written off against this receipt as uncollectable, if a partial write-off was applied at the time of receipt posting. Impacts bad debt expense and AR aging reports.',
    CONSTRAINT pk_ar_receipt PRIMARY KEY(`ar_receipt_id`)
) COMMENT 'Records of cash receipts and tenant payments applied against AR invoices, including rent payments, security deposit receipts, and miscellaneous income. Tracks EGI realization at the property level. Attributes include receipt number, receipt date, payment method, bank deposit reference, amount received, currency, applied amount, unapplied amount, tenant reference, property reference, and NSF flag.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique surrogate identifier for the budget record in the Silver Layer lakehouse. Primary key for the finance.budget data product.',
    `asset_id` BIGINT COMMENT 'Reference to the property entity for which this budget is prepared. Enables property-level NOI variance analysis, PSF benchmarking, and investor reporting. Null for portfolio-level or cost-center-only budgets.',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Annual operating and CapEx budgets are prepared at the building level in multi-building portfolios for lender reporting, asset management decisions, and CAM pool budgeting. budget already has asset_id',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the GL account in the chart of accounts for this budget line. Enables mapping of budget amounts to the GL for NOI statements, EBITDA roll-ups, and SOX-compliant financial controls in SAP S/4HANA and Yardi Voyager.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.assessment. Business justification: Remediation budgets and capital improvement budgets are directly triggered by compliance assessment findings. Real estate CFOs and asset managers need to link budget line items to the assessment that ',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center entity against which this budget is allocated. Aligns with the GL cost center hierarchy in SAP S/4HANA and Yardi Voyager for OPEX/CAPEX planning and financial consolidation.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: RE budgets for international properties or multi-currency portfolios require validated currency references for budget consolidation, variance reporting, and investor presentations. Replaces denormaliz',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Budgets are maintained within a specific accounting ledger (e.g., GAAP ledger, tax ledger, management ledger). In SAP S/4HANA and Yardi Voyager, budget tracking is ledger-specific — a property may hav',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Budgets in a real estate enterprise are prepared and approved at the legal entity level — each property-owning LLC, REIT subsidiary, or operating entity has its own budget. The budget product currentl',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio entity for portfolio-level budget roll-ups. Supports AUM-level EBITDA, NOI, and DSCR reporting as required by REIT investor disclosures and Argus Enterprise portfolio reporting.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Real estate operating budgets include line items mandated by regulatory obligations — property tax escrows, environmental remediation reserves, ADA compliance capex. Budget approval requires demonstra',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to finance.reporting_period. Business justification: Finance budgets are prepared for specific reporting periods (annual, quarterly, monthly). Linking finance_budget to reporting_period enables period-over-period budget vs. actual variance analysis, bud',
    `account_category` STRING COMMENT 'High-level classification of the GL account for this budget line: revenue (PGI, EGI, GRI), opex (Operating Expenditure), capex (Capital Expenditure), debt_service (mortgage/loan payments), or reserve (replacement/capital reserve). Drives NOI, EBITDA, and DSCR roll-up logic.. Valid values are `revenue|opex|capex|debt_service|reserve`',
    `approval_status` STRING COMMENT 'Current state of the budget approval workflow: pending (awaiting review), approved (authorized by required approvers), rejected (returned for revision), or escalated (elevated to senior approver). Supports SOX-compliant multi-level approval chain tracking.. Valid values are `pending|approved|rejected|escalated`',
    `approved_date` DATE COMMENT 'The calendar date on which the budget received its final approval. Used in SOX audit trails, investor reporting timelines, and budget lock-down processes.',
    `budget_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the budget within Yardi Voyager or SAP S/4HANA. Used for cross-system reconciliation and investor reporting references.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `budget_name` STRING COMMENT 'Human-readable descriptive name of the budget (e.g., 2025 Annual Operating Budget – Portfolio A, 2025 Capital Budget – 123 Main St). Used in reports and approval workflows.',
    `budget_type` STRING COMMENT 'Classification of the budget by purpose: operating (OPEX-focused NOI budget), capital (CAPEX project budget), reforecast (revised in-year estimate), cash_flow (treasury cash planning), or leasing (TI and leasing cost budget). [ENUM-REF-CANDIDATE: operating|capital|reforecast|cash_flow|leasing|master — promote to reference product if additional types emerge]. Valid values are `operating|capital|reforecast|cash_flow|leasing`',
    `budgeted_amount` DECIMAL(18,2) COMMENT 'The planned monetary amount for this budget line in the reporting currency. Represents the baseline for NOI variance analysis, OPEX/CAPEX planning, and investor reporting. Expressed in the currency defined by currency_code.',
    `cam_flag` BOOLEAN COMMENT 'Indicates whether this budget line is a recoverable Common Area Maintenance (CAM) expense that can be passed through to tenants under NNN or modified gross lease structures. True = CAM-recoverable; False = non-recoverable. Critical for CAM reconciliation and tenant billing.',
    `capex_category` STRING COMMENT 'Sub-classification for capital budget lines: tenant_improvement (TI allowances), building_improvement (structural/envelope), equipment (HVAC, elevators), land, or other. Applicable only when account_category = capex. Supports CAPEX planning and fixed asset capitalization per FASB ASC 360.. Valid values are `tenant_improvement|building_improvement|equipment|land|other`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was first created in the Silver Layer lakehouse. Serves as the RECORD_AUDIT_CREATED marker for data lineage, SOX audit trails, and incremental load processing.',
    `effective_from_date` DATE COMMENT 'The date from which this budget version becomes the active baseline for variance analysis and financial reporting. For annual budgets, typically the first day of the fiscal year.',
    `effective_to_date` DATE COMMENT 'The date on which this budget version ceases to be the active baseline, typically superseded by a reforecast or new version. Null for the currently active version. Supports multi-year and reforecast budget management.',
    `finance_budget_status` STRING COMMENT 'Current lifecycle state of the budget record: draft (being prepared), in_review (submitted for approval), approved (authorized for use), locked (frozen for reporting), archived (superseded), or rejected (returned for revision). Drives SOX-compliant approval workflow controls.. Valid values are `draft|in_review|approved|locked|archived|rejected`',
    `fiscal_period` STRING COMMENT 'Numeric fiscal period (1–12 for monthly, 1–4 for quarterly) within the fiscal year to which this budget line applies. Aligns with the SAP S/4HANA and Yardi Voyager fiscal calendar configuration.',
    `fiscal_year` STRING COMMENT 'The four-digit fiscal year to which this budget applies (e.g., 2025). Aligns with the entitys fiscal calendar as configured in Yardi Voyager and SAP S/4HANA for NOI and EBITDA roll-up reporting.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether this budget record represents a consolidated roll-up across multiple properties or cost centers (True) versus a single property/cost center budget (False). Supports portfolio-level EBITDA and NOI consolidation in SAP S/4HANA.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether this budget version has been locked and is no longer editable (True = locked; False = editable). Locked budgets serve as the immutable baseline for variance reporting and SOX audit evidence.',
    `line_description` STRING COMMENT 'Free-text description of the budget line item explaining the nature of the planned expenditure or revenue (e.g., HVAC preventive maintenance contract, Base rent revenue – Suite 200). Sourced from Yardi Voyager budget entry notes.',
    `noi_category` STRING COMMENT 'Categorizes the budget line within the NOI waterfall: pgi (Potential Gross Income), egi (Effective Gross Income), goi (Gross Operating Income), noi_above (above-NOI line item), noi_below (below-NOI line item), or non_operating. Enables automated NOI statement construction and CAP Rate analysis.. Valid values are `pgi|egi|goi|noi_above|noi_below|non_operating`',
    `notes` STRING COMMENT 'Free-text field for budget preparer or approver annotations, assumptions, or justifications (e.g., Assumes 3% rent escalation per lease terms, CAPEX deferred from 2024). Supports audit trail and investor reporting commentary.',
    `period_end_date` DATE COMMENT 'The last calendar date of the budget period to which this budget record applies. Together with period_start_date, defines the temporal scope for budget-to-actual variance reporting.',
    `period_start_date` DATE COMMENT 'The first calendar date of the budget period (month, quarter, or year) to which this budget record applies. Used for period-level NOI variance analysis and cash flow forecasting.',
    `period_type` STRING COMMENT 'Granularity of the budget period: monthly (12 periods), quarterly (4 periods), or annual (1 period). Determines how budget amounts are distributed and compared against actuals in NOI and EBITDA reporting.. Valid values are `monthly|quarterly|annual`',
    `prepared_by` STRING COMMENT 'Name or employee identifier of the individual who prepared and submitted this budget. Part of the SOX-compliant approval chain and audit trail. Sourced from Yardi Voyager or SAP S/4HANA workflow.',
    `prior_year_actual_amount` DECIMAL(18,2) COMMENT 'The actual amount recorded in the equivalent GL account and period in the prior fiscal year. Used as the baseline for year-over-year variance analysis and budget justification in investor and board reporting.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this budget record was sourced: yardi_voyager (property-level budgets), sap_s4hana (corporate/portfolio budgets), argus_enterprise (investment/valuation budgets), or manual (spreadsheet-originated). Required for data lineage and reconciliation.. Valid values are `yardi_voyager|sap_s4hana|argus_enterprise|manual`',
    `source_system_ref` STRING COMMENT 'The native identifier of this budget record in the originating source system (e.g., Yardi Voyager budget ID, SAP S/4HANA budget document number). Enables cross-system reconciliation and audit traceability.',
    `submitted_date` DATE COMMENT 'The calendar date on which the budget was formally submitted for review and approval. Supports approval cycle time tracking and SOX control evidence.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was last modified in the Silver Layer lakehouse. Supports change data capture, SOX audit trails, and incremental processing for downstream Gold Layer aggregations.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The absolute monetary difference between the budgeted amount and the prior year actual amount (budgeted_amount minus prior_year_actual_amount). Stored as a raw field to support NOI variance reporting without requiring runtime calculation.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The percentage change between the budgeted amount and the prior year actual amount, expressed as a decimal (e.g., 0.0500 = 5.00%). Stored as a sourced field from Yardi Voyager to support investor reporting and NOI variance dashboards.',
    `version_label` STRING COMMENT 'Descriptive label for the budget version stage (e.g., draft, preliminary, submitted, approved, reforecast_q1, final). Complements version_number with a human-readable stage indicator. [ENUM-REF-CANDIDATE: draft|preliminary|submitted|approved|reforecast_q1|reforecast_q2|reforecast_q3|final — promote to reference product]',
    `version_number` STRING COMMENT 'Sequential integer version of the budget (e.g., 1 = initial submission, 2 = first revision, 3 = board-approved). Supports multi-version budget management and reforecast tracking in Yardi Voyager.',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Annual and multi-year operating and capital budgets at the property, cost center, and portfolio level with embedded line-item detail by GL account and period. Serves as the baseline for NOI variance analysis, OPEX/CAPEX planning, and investor reporting. Sourced from Yardi Voyager Budgeting and SAP S/4HANA. Attributes include budget name, type (operating, capital, reforecast), fiscal year, version, status, approval chain, and per-line: GL account, cost center, property reference, period, budgeted amount, prior year actual, variance amount, variance percentage, and line description.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique surrogate identifier for each budget line item record within the enterprise data lakehouse. Primary key for the budget_line product.',
    `budget_id` BIGINT COMMENT 'Reference to the parent approved budget document that this line item belongs to. Links the line to its budget header for period, property, and approval context.',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Budget lines are allocated to specific buildings for building-level variance analysis, CAM pool budgeting, and capital expenditure planning. Multi-building asset budgets require building-level line it',
    `cam_schedule_id` BIGINT COMMENT 'Foreign key linking to lease.cam_schedule. Business justification: Budget lines for CAM recovery income are derived from cam_schedule estimates; direct FK supports CAM budget vs actual analysis. RE property managers budget CAM recoveries from estimated cam_schedules ',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this budget line. Supports departmental and property-level financial accountability and GL roll-up.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: RE budget lines for multi-currency portfolios require validated currency references for line-level currency translation, budget consolidation, and NOI variance reporting by currency. Replaces denormal',
    `lease_agreement_id` BIGINT COMMENT 'Foreign key linking to lease.agreement. Business justification: Budget lines for lease revenue (base rent, CAM recovery, percentage rent) are tied to specific lease agreements for lease-level budget vs. actual variance reporting. Real estate asset managers require',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio or fund to which the property belongs. Enables portfolio-level NOI, EGI, and EBITDA roll-up across multiple properties for REIT and AUM reporting.',
    `asset_id` BIGINT COMMENT 'Reference to the property against which this budget line is allocated. Enables property-level NOI, EGI, and OPEX variance analysis.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the GL account in the chart of accounts to which this budget line is posted. Drives financial consolidation and P&L reporting.',
    `rent_schedule_id` BIGINT COMMENT 'Foreign key linking to lease.rent_schedule. Business justification: Budget lines for rental income are derived from rent schedules; direct FK supports budget vs actual rent variance reporting. RE asset managers build annual budgets from rent schedules and need this li',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual posted GL amount for this account, cost center, and period as sourced from Yardi Voyager AR/AP/GL or SAP S/4HANA. Populated after period close; null for future periods.',
    `allocation_method` STRING COMMENT 'Method used to allocate this budget line to the property or cost center. PSF = Per Square Foot allocation; pro_rata = proportional share; SQM = per square meter; headcount = per employee; direct = directly assigned; manual = override. [ENUM-REF-CANDIDATE: direct|psf|pro_rata|sqm|headcount|manual — promote to reference product]. Valid values are `direct|psf|pro_rata|sqm|headcount|manual`',
    `approval_date` DATE COMMENT 'The date on which this budget line was formally approved by the authorized budget approver. Required for SOX-compliant audit trail of budget authorization.',
    `approved_by` STRING COMMENT 'Name or user identifier of the individual who approved this budget line. Supports SOX-compliant financial controls and audit trail for budget authorization.',
    `budget_category` STRING COMMENT 'High-level financial category classifying the budget line. Revenue lines contribute to PGI/EGI/GOI; OPEX lines feed NOI calculations; CAPEX lines track capital expenditure; debt_service covers DSCR inputs; reserve lines track replacement reserves. [ENUM-REF-CANDIDATE: revenue|opex|capex|noi|debt_service|reserve — promote to reference product if additional categories are needed]. Valid values are `revenue|opex|capex|noi|debt_service|reserve`',
    `budget_scenario` STRING COMMENT 'The planning scenario under which this budget line was prepared. Base = most likely; optimistic = upside case; conservative = downside case; stress = adverse scenario for DSCR and LTV stress testing. Supports Argus Enterprise scenario analysis.. Valid values are `base|optimistic|conservative|stress`',
    `budget_version` STRING COMMENT 'Version identifier for the budget iteration this line belongs to (e.g., ORIGINAL, REV1, REFORECAST_Q2). Supports multi-version budget comparison and rolling forecast workflows in Yardi Voyager and Argus Enterprise.. Valid values are `^[A-Z0-9._-]{1,20}$`',
    `budgeted_amount` DECIMAL(18,2) COMMENT 'The approved budgeted monetary amount for this GL account, cost center, and period combination. Core field for variance analysis against actuals. Expressed in the entitys functional currency.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget line record was first created in the data lakehouse Silver layer. Supports audit trail and data lineage requirements under SOX financial controls.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month number 1–12 or 1–13 for 4-4-5 calendars) within the fiscal year to which this budget line applies. Enables monthly variance analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year (e.g., 2024) to which this budget line applies. Aligns with the enterprise fiscal calendar as defined in SAP S/4HANA and Yardi Voyager.',
    `is_cam_recoverable` BOOLEAN COMMENT 'Indicates whether this expense budget line is recoverable from tenants as part of Common Area Maintenance (CAM) charges under NNN or modified gross lease structures. True = recoverable; False = landlord-absorbed.',
    `is_capex` BOOLEAN COMMENT 'Indicates whether this budget line represents a capital expenditure (CAPEX) rather than an operating expenditure (OPEX). True = CAPEX (capitalized asset investment); False = OPEX (period expense). Drives fixed asset capitalization and depreciation scheduling.',
    `line_code` STRING COMMENT 'Alphanumeric code uniquely identifying this budget line within the source system (Yardi Voyager or SAP S/4HANA). Used for cross-system reconciliation and audit trail.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `line_description` STRING COMMENT 'Human-readable description of the budget line item, such as Base Rent Income, CAM Expense, HVAC Maintenance, or Property Tax. Sourced from Yardi Voyager budget entry.',
    `line_number` STRING COMMENT 'Sequential line number ordering this item within its parent budget. Used for display ordering, referencing, and reconciliation against source budget documents in Yardi Voyager and SAP S/4HANA.',
    `line_status` STRING COMMENT 'Current workflow status of the budget line. Draft = under preparation; submitted = pending approval; approved = authorized for use; rejected = returned for revision; locked = period-closed and immutable; superseded = replaced by a revised line. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|locked|superseded — promote to reference product]. Valid values are `draft|submitted|approved|rejected|locked|superseded`',
    `line_type` STRING COMMENT 'Classifies the budget line as income (e.g., base rent, CAM recovery), expense (e.g., maintenance, insurance), transfer, reserve contribution, or adjustment. Drives sign convention in NOI and EGI roll-ups.. Valid values are `income|expense|transfer|reserve|adjustment`',
    `noi_component` STRING COMMENT 'Indicates which NOI/EGI/PGI/GOI/EBITDA roll-up component this budget line contributes to. PGI = Potential Gross Income; EGI = Effective Gross Income; GOI = Gross Operating Income; NOI = Net Operating Income; EBITDA = Earnings Before Interest Taxes Depreciation and Amortization; excluded = not included in any standard roll-up.. Valid values are `pgi|egi|goi|noi|ebitda|excluded`',
    `notes` STRING COMMENT 'Free-text notes or commentary entered by the budget preparer or approver explaining assumptions, drivers, or exceptions for this budget line (e.g., Includes TI allowance for Suite 200 renewal, CAM estimate based on prior year actuals +3%).',
    `period_end_date` DATE COMMENT 'The calendar end date of the budget period covered by this line item. Paired with period_start_date to define the exact budget window.',
    `period_start_date` DATE COMMENT 'The calendar start date of the budget period covered by this line item. Used for time-series alignment in NOI and variance reporting.',
    `prior_year_actual_amount` DECIMAL(18,2) COMMENT 'The actual posted amount for the equivalent GL account, cost center, and period in the prior fiscal year. Used as a benchmark for year-over-year budget analysis and trend reporting.',
    `revised_budget_amount` DECIMAL(18,2) COMMENT 'The most recently approved revised or reforecast budget amount for this line, reflecting mid-year budget amendments. Null if no revision has been approved. Supports rolling forecast analysis.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this budget line was sourced. Yardi Voyager = property-level budgets; SAP S/4HANA = corporate/consolidated budgets; Argus = investment/valuation budgets; MRI = residential/investment budgets; manual = spreadsheet or manual entry.. Valid values are `yardi|sap|argus|mri|manual`',
    `source_system_line_code` STRING COMMENT 'The native primary key or line identifier of this budget line in the originating source system (Yardi Voyager, SAP S/4HANA, or Argus Enterprise). Enables bi-directional traceability for reconciliation and audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget line record was last modified in the data lakehouse Silver layer. Tracks revisions, reforecasts, and period-close updates for SOX-compliant change management.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The monetary difference between actual_amount and budgeted_amount (actual minus budget). Positive variance on income lines indicates favorable performance; negative variance on expense lines indicates favorable performance. Core metric for NOI variance reporting.',
    `variance_pct` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the budgeted amount ((actual - budget) / budget * 100). Enables proportional comparison across budget lines of different magnitudes for portfolio-level reporting.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Granular budget line items by GL account, cost center, and period within an approved budget. Enables property-level and portfolio-level variance analysis between actual and budgeted NOI, EGI, PGI, and OPEX. Attributes include budget line number, GL account, cost center, property reference, period, budgeted amount, prior year actual, variance amount, variance percentage, and line description.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`noi_statement` (
    `noi_statement_id` BIGINT COMMENT 'Unique surrogate identifier for the NOI statement record in the Silver Layer lakehouse. Primary key for this entity.',
    `asset_id` BIGINT COMMENT 'Reference to the property for which this NOI statement is produced. Links to the property master record.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: NOI statements are the primary vehicle for budget vs. actual variance analysis in real estate asset management. Linking noi_statement to finance_budget enables direct comparison of actual NOI componen',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: NOI statements are produced at the building level for multi-building assets, required for lender DSCR compliance, asset management decisions, and investor reporting. A real estate CFO expects building',
    `cost_center_id` BIGINT COMMENT 'Reference to the GL cost center associated with this property for financial consolidation and reporting purposes.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: RE NOI statements for international properties require validated currency references for cap rate analysis, property valuation, and investor reporting in functional and reporting currencies. Replaces ',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Fund-level consolidated NOI statements are prepared for LP reporting, REIT compliance, and fund performance calculation. Real estate fund accountants require fund-level NOI statements distinct from po',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: NOI statements are derived from GL data within a specific ledger (GAAP, cash-basis, tax, or management reporting ledger). A property may have different NOI figures depending on the accounting basis of',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: NOI statements are produced for specific legal entities in the real estate enterprise — each property-owning entity has its own P&L waterfall. The noi_statement product currently has no FK to legal_en',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: NOI statements are benchmarked against market segment targets (cap rates, NOI PSF, target IRR) for fund manager reporting and asset performance evaluation. NCREIF/INREV reporting requires NOI segmente',
    `market_survey_id` BIGINT COMMENT 'Foreign key linking to marketing.market_survey. Business justification: NOI statements benchmark actual performance against market survey data (vacancy rates, market rents, cap rates). Real estate analysts and asset managers reference the specific market survey used for N',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio this property belongs to, enabling portfolio-level NOI roll-up and investor reporting.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: RE NOI statements are benchmarked and reported by property type (office, retail, industrial, multifamily) for lender covenant compliance, NCREIF benchmarking, and investor sector allocation reporting.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to finance.reporting_period. Business justification: NOI statements are produced for specific reporting periods (monthly, quarterly, annual). Linking noi_statement to reporting_period provides the authoritative period definition — including start/end da',
    `administrative_expense` DECIMAL(18,2) COMMENT 'Property-level administrative and general overhead costs including leasing commissions amortization, legal fees, accounting fees, and office expenses allocated to the property for the reporting period.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the NOI statement was formally approved by the authorized finance officer. Provides the SOX-compliant audit trail for financial statement sign-off.',
    `cam_recovery` DECIMAL(18,2) COMMENT 'Common Area Maintenance recovery income collected from tenants under NNN or modified gross leases for their pro-rata share of operating expenses. Included in EGI and offsets operating expenses.',
    `cap_rate_applied` DECIMAL(18,2) COMMENT 'The capitalization rate used to derive implied property value from NOI (Value = NOI / CAP Rate). Expressed as a decimal (e.g., 0.0550 = 5.50%). Sourced from Argus Enterprise valuation models and CoStar market comparables.',
    `capex_reserve` DECIMAL(18,2) COMMENT 'Capital expenditure reserve amount set aside for the reporting period for major building improvements, replacements, and non-recurring capital items. Deducted from NOI to arrive at AFFO in REIT reporting.',
    `concessions` DECIMAL(18,2) COMMENT 'Monetary value of rent-free periods, move-in incentives, and other lease concessions granted to tenants during the reporting period. Expressed as a positive deduction from PGI in the income waterfall.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this NOI statement record was first created in the Silver Layer lakehouse. Provides the audit trail for record provenance and SOX compliance.',
    `credit_loss` DECIMAL(18,2) COMMENT 'Revenue lost due to tenant non-payment, bad debt write-offs, and collection shortfalls during the reporting period. Expressed as a positive deduction from PGI. Sourced from Yardi Voyager AR aging.',
    `debt_service` DECIMAL(18,2) COMMENT 'Total principal and interest payments on property-level debt obligations for the reporting period. Used as the denominator in DSCR calculations. Sourced from SAP S/4HANA loan schedules.',
    `dscr` DECIMAL(18,2) COMMENT 'Debt Service Coverage Ratio — NOI divided by total debt service for the reporting period (NOI / Debt Service). A DSCR below 1.0 indicates the property does not generate sufficient income to cover debt obligations. Critical for lender covenant compliance and CMBS reporting.',
    `egi` DECIMAL(18,2) COMMENT 'Effective Gross Income — PGI minus vacancy loss, credit loss, and concessions, plus other income. Represents the actual income collected or collectible from the property. Core input for NOI and CAP rate calculations.',
    `fiscal_period` STRING COMMENT 'The fiscal period number within the fiscal year (1–12 for monthly, 1–4 for quarterly). Enables period-over-period variance analysis and WALE/WALT calculations.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this NOI statement belongs (e.g., 2024). Used for annual roll-up, budget comparison, and SEC/REIT regulatory reporting.',
    `gla_sqft` DECIMAL(18,2) COMMENT 'Total Gross Leasable Area of the property in square feet as of the reporting period. Used to calculate PSF metrics (NOI PSF, rent PSF) for benchmarking and CAP rate analysis.',
    `implied_property_value` DECIMAL(18,2) COMMENT 'Estimated property value derived by dividing NOI by the applied CAP rate (NOI / CAP Rate). Used for investor reporting, portfolio NAV calculations, and REIT asset valuations. Not a formal appraisal value.',
    `insurance_expense` DECIMAL(18,2) COMMENT 'Property and casualty insurance premiums allocated to the reporting period. Includes building, liability, and any specialized coverage (flood, earthquake). Component of total operating expenses.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether this NOI statement represents a consolidated multi-property or portfolio-level roll-up (True) versus a single-property statement (False). Drives aggregation logic in SAP S/4HANA financial consolidation.',
    `leasing_commission_expense` DECIMAL(18,2) COMMENT 'Brokerage leasing commissions paid or accrued during the reporting period for new leases and renewals. Tracked separately for AFFO adjustments and amortized per FASB ASC 842 straight-line requirements.',
    `management_fee_expense` DECIMAL(18,2) COMMENT 'Fee paid to the property manager (PM) for operational management services, typically calculated as a percentage of EGI or collected rents. Key line item for NOI sensitivity and management contract evaluation.',
    `management_fee_rate` DECIMAL(18,2) COMMENT 'Management fee expressed as a decimal percentage of EGI or collected rents (e.g., 0.0400 = 4.00%). Used to validate the management_fee_expense calculation and benchmark against market rates.',
    `noi` DECIMAL(18,2) COMMENT 'Net Operating Income — EGI minus total operating expenses. The primary measure of a propertys income-generating performance before debt service, capital expenditures, depreciation, and income taxes. Authoritative input for CAP rate valuation and DSCR calculations.',
    `noi_psf` DECIMAL(18,2) COMMENT 'NOI divided by GLA in square feet, expressed as a per-square-foot metric. Industry-standard benchmark for comparing property performance across the portfolio and against market comparables.',
    `notes` STRING COMMENT 'Free-text narrative notes from the asset manager or finance team providing context for unusual variances, one-time items, or material events affecting the NOI statement for the reporting period.',
    `occupancy_rate` DECIMAL(18,2) COMMENT 'Percentage of total leasable area that is occupied and generating rent during the reporting period, expressed as a decimal (e.g., 0.9200 = 92.00%). Complement of vacancy rate; used in investor dashboards and REIT disclosures.',
    `period_frequency` STRING COMMENT 'Frequency granularity of this NOI statement — monthly for operational monitoring, quarterly for investor reporting, annual for REIT filings, year-to-date for cumulative tracking, or trailing 12 months for CAP rate valuation.. Valid values are `monthly|quarterly|annual|year_to_date|trailing_12_months`',
    `pgi` DECIMAL(18,2) COMMENT 'Potential Gross Income — the maximum theoretical rental revenue achievable if the property were 100% occupied at market rents for the full reporting period. Top line of the NOI income waterfall. Sourced from Yardi Voyager lease schedules.',
    `property_tax_expense` DECIMAL(18,2) COMMENT 'Real estate tax and special assessment charges levied on the property for the reporting period. A primary component of operating expenses and a key driver of NOI sensitivity analysis.',
    `repairs_maintenance_expense` DECIMAL(18,2) COMMENT 'Costs for routine repairs, preventive maintenance, and non-capital building upkeep during the reporting period. Sourced from Building Engines work orders and Yardi Voyager AP. Component of total operating expenses.',
    `reporting_period_end` DATE COMMENT 'Last calendar date of the financial reporting period covered by this NOI statement (e.g., 2024-01-31 for a January monthly statement).',
    `reporting_period_start` DATE COMMENT 'First calendar date of the financial reporting period covered by this NOI statement (e.g., 2024-01-01 for a January monthly statement).',
    `restatement_reason` STRING COMMENT 'Free-text explanation for why a previously published NOI statement was restated. Required when statement_status is restated. Supports SOX audit trail and SEC disclosure requirements for material restatements.',
    `source_system` STRING COMMENT 'Operational system of record from which this NOI statement data was sourced (e.g., Yardi Voyager for property-level actuals, Argus Enterprise for budget/forecast, SAP S/4HANA for consolidated financials, or manual for off-system entries).. Valid values are `yardi_voyager|mri_software|argus_enterprise|sap_s4hana|manual`',
    `statement_number` STRING COMMENT 'Externally-known unique business identifier for this NOI statement, formatted as NOI-YYYY-MM-PropertyCode. Used in investor reports, audit trails, and regulatory submissions.. Valid values are `^NOI-[0-9]{4}-[0-9]{2}-[A-Z0-9]{4,20}$`',
    `statement_status` STRING COMMENT 'Current lifecycle state of the NOI statement. Draft indicates work-in-progress; under_review is pending approval; approved is finalized; published is distributed to investors; restated indicates a prior-period correction; voided is cancelled. [ENUM-REF-CANDIDATE: draft|under_review|approved|published|restated|voided — promote to reference product]. Valid values are `draft|under_review|approved|published|restated|voided`',
    `statement_type` STRING COMMENT 'Classification of the statement as actual reported results, approved budget, current forecast, reforecast, or prior-year actual for variance analysis. Drives how the statement is consumed in Argus Enterprise and investor reporting.. Valid values are `actual|budget|forecast|reforecast|prior_year_actual`',
    `ti_allowance` DECIMAL(18,2) COMMENT 'Tenant Improvement allowance costs incurred or accrued during the reporting period for build-out and fit-out of leased spaces. Impacts AFFO calculations and is tracked separately from operating expenses per FASB ASC 842.',
    `total_operating_expenses` DECIMAL(18,2) COMMENT 'Sum of all property-level operating expenditures for the reporting period, including management fees, repairs and maintenance, insurance, property taxes, utilities, and administrative costs. Deducted from EGI to arrive at NOI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this NOI statement record was last modified in the Silver Layer lakehouse. Tracks restatements, corrections, and re-approvals for audit and SOX compliance.',
    `utilities_expense` DECIMAL(18,2) COMMENT 'Landlord-paid utility costs for the reporting period including electricity, gas, water, sewer, and trash removal for common areas and vacant spaces. Component of total operating expenses.',
    `vacancy_loss` DECIMAL(18,2) COMMENT 'Revenue lost due to unoccupied units or spaces during the reporting period. Expressed as a positive deduction from PGI. Includes both physical vacancy and economic vacancy from lease-up periods.',
    `vacancy_rate` DECIMAL(18,2) COMMENT 'Physical vacancy rate for the property during the reporting period, expressed as a decimal percentage of total leasable area that is unoccupied (e.g., 0.0800 = 8.00%). Key driver of PGI-to-EGI waterfall.',
    CONSTRAINT pk_noi_statement PRIMARY KEY(`noi_statement_id`)
) COMMENT 'Property-level Net Operating Income statement capturing the full income waterfall — PGI, vacancy and credit loss, concessions, EGI, itemized operating expenses, and NOI — for a given reporting period. Serves as the authoritative financial performance record for each property and the primary input for CAP rate valuation, DSCR calculations, and investor reporting. Attributes include statement period, property reference, PGI, vacancy loss, concessions, EGI, operating expense categories, NOI, management fee, CAP rate applied, and reporting currency.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique surrogate identifier for each fixed asset record in the enterprise fixed asset register. Primary key for the fixed_asset data product.',
    `amenity_type_id` BIGINT COMMENT 'Foreign key linking to reference.amenity_type. Business justification: Real estate fixed assets include amenities (fitness centers, parking structures, rooftop terraces) classified by amenity type for CAM recovery allocation, capital expenditure planning, and LEED/ESG ce',
    `asset_id` BIGINT COMMENT 'Reference to the real estate property to which this fixed asset is physically associated or assigned. Enables property-level CAPEX tracking and NOI impact analysis.',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Structural improvements, HVAC systems, elevators, and roofing are capitalized as building-level fixed assets for component depreciation under ASC 360. Real estate accountants performing cost segregati',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the GL account in the chart of accounts to which this assets acquisition cost and depreciation charges are posted.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.assessment. Business justification: Fixed assets undergo compliance assessments — environmental Phase I/II studies, ADA accessibility audits, fire safety inspections, energy audits. Asset managers need to link each fixed asset to its go',
    `green_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.green_certification. Business justification: Real estate fixed assets (buildings, major systems) carry green certifications (LEED, ENERGY STAR) affecting depreciation treatment, tax incentive eligibility, and ESG reporting. A real estate sustain',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Real estate fixed assets (building improvements, TI, equipment installations) are created under specific building permits. The permit governs scope of work and must be closed before the asset is place',
    `construction_type_id` BIGINT COMMENT 'Foreign key linking to reference.construction_type. Business justification: In RE, fixed assets are classified by construction type (steel frame, masonry, wood frame) to determine depreciation method, useful life, insurance replacement cost, and IBC fire resistance classifica',
    `cost_center_id` BIGINT COMMENT 'Reference to the financial cost center responsible for this fixed asset, used for GL allocation, depreciation posting, and CAPEX budget tracking.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: RE fixed assets (buildings, improvements) in international portfolios require validated currency references for acquisition cost recording, depreciation calculation, and fixed asset register reporting',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Fixed assets (buildings, improvements) are capitalized from development projects. The fixed asset record references the development project for capitalization basis, depreciation calculation, and audi',
    `floor_id` BIGINT COMMENT 'Foreign key linking to property.floor. Business justification: Fixed assets such as HVAC systems, elevators, and tenant improvements are physically located on specific floors. Floor-level fixed asset registers support capital replacement planning, depreciation sc',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Fixed assets (buildings, land improvements, TI allowances) are owned by specific legal entities in the real estate enterprise. The fixed_asset register must be linked to the owning legal entity for de',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Land is capitalized as a non-depreciable fixed asset at the parcel level for tax basis tracking, disposition gain/loss calculation, and 1031 exchange identification. Real estate accountants require pa',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial space TI and leasehold improvements are capitalized at the space level for depreciation tracking and lease accounting. Real estate accountants and auditors expect fixed assets to reference ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Fixed assets (elevators, HVAC, fire suppression, accessibility ramps) are subject to specific regulatory obligations (ADA, fire code, energy efficiency mandates). Capital planners need to link assets ',
    `tax_assessment_id` BIGINT COMMENT 'Foreign key linking to valuation.tax_assessment. Business justification: Fixed assets are subject to property tax assessments. Linking fixed_asset to tax_assessment enables reconciliation of assessed value to book value, supporting impairment analysis and tax basis trackin',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Tenant improvement allowances and unit-specific capital improvements are capitalized as fixed assets at the unit level under ASC 842/IFRS 16. Real estate accountants tracking TI depreciation and lease',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense charged against this asset from the in-service date through the current reporting period. Contra-asset balance used to compute net book value.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total capitalized cost of the fixed asset at the time of acquisition, including purchase price, transaction costs, and any costs necessary to bring the asset to its intended use. Represents the gross book value before depreciation.',
    `acquisition_date` DATE COMMENT 'Date on which the fixed asset was acquired, purchased, or placed in service. This is the capitalization date used as the start point for depreciation calculations.',
    `asset_class` STRING COMMENT 'Classification of the fixed asset into a standardized category that governs depreciation method and useful life defaults. [ENUM-REF-CANDIDATE: building|land|land_improvement|tenant_improvement|hvac_system|capital_equipment|furniture_fixtures|leasehold_improvement|infrastructure|intangible — promote to reference product]',
    `asset_description` STRING COMMENT 'Human-readable description of the fixed asset, such as HVAC Rooftop Unit — Building A or Lobby Renovation — Tenant Improvement Suite 400. Used for identification in financial reports and audits.',
    `asset_location` STRING COMMENT 'Physical location of the asset within the property, such as building name, floor, suite, or room number (e.g., Building A — Floor 3 — Mechanical Room). Supports physical inventory verification.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset indicating its operational and accounting state. under_construction applies to assets in the Assets Under Construction (AUC) stage prior to capitalization.. Valid values are `in_service|under_construction|disposed|impaired|transferred|retired`',
    `asset_sub_class` STRING COMMENT 'Secondary classification providing finer granularity within an asset class, such as Mechanical or Electrical within the HVAC class, or Structural within Building. Supports detailed CAPEX reporting.',
    `asset_tag` STRING COMMENT 'Physical barcode or RFID tag number affixed to the asset for inventory tracking and physical verification during annual fixed asset audits.',
    `book_tax_difference` DECIMAL(18,2) COMMENT 'Cumulative difference between book depreciation and tax depreciation for this asset, representing the temporary timing difference used in deferred tax calculations under FASB ASC 740.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixed asset record was first created in the data platform. Used for audit trail and data lineage tracking in compliance with SOX financial controls.',
    `depreciation_convention` STRING COMMENT 'Timing convention applied to the first and last year of depreciation, determining how much depreciation is taken in the year of acquisition and disposal. Relevant for MACRS and book depreciation.. Valid values are `half_year|mid_month|mid_quarter|full_month`',
    `depreciation_method` STRING COMMENT 'Accounting method used to allocate the cost of the asset over its useful life. macrs refers to the Modified Accelerated Cost Recovery System used for US tax depreciation. Land assets use no_depreciation.. Valid values are `straight_line|declining_balance|sum_of_years_digits|units_of_production|macrs|no_depreciation`',
    `disposal_date` DATE COMMENT 'Date on which the fixed asset was disposed of, sold, scrapped, or retired from service. Triggers the recognition of any gain or loss on disposal in the GL.',
    `disposal_method` STRING COMMENT 'Method by which the fixed asset was removed from the asset register. Determines the accounting treatment for the disposal transaction.. Valid values are `sale|scrap|donation|transfer|write_off|trade_in`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Net cash proceeds received upon disposal or sale of the fixed asset. Used to calculate the gain or loss on disposal (disposal_proceeds minus net_book_value at disposal date).',
    `impairment_loss` DECIMAL(18,2) COMMENT 'Cumulative impairment charge recognized against this asset when its carrying amount exceeds its recoverable amount per FASB ASC 360 impairment testing. Reduces net book value below the normal depreciation schedule.',
    `impairment_test_date` DATE COMMENT 'Date on which the most recent FASB ASC 360 impairment test was performed for this asset. Required for SOX compliance documentation and audit trail.',
    `in_service_date` DATE COMMENT 'Date the asset was placed into active service and depreciation commenced. May differ from acquisition_date for assets under construction that are capitalized upon completion.',
    `insurance_policy_number` STRING COMMENT 'Reference to the property or equipment insurance policy covering this fixed asset. Required for insurance claims processing and risk management reporting.',
    `insured_value` DECIMAL(18,2) COMMENT 'Replacement cost or insured value of the fixed asset as declared on the insurance policy. May differ from net book value and is used for insurance adequacy reviews.',
    `leed_certified` BOOLEAN COMMENT 'Indicates whether this asset or the improvement it represents has achieved LEED certification from the U.S. Green Building Council. Supports ESG reporting and green building compliance tracking.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the fixed asset on the balance sheet, calculated as acquisition_cost minus accumulated_depreciation minus any impairment charges. Represents the assets accounting value at the reporting date.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the acquisition of this fixed asset. Links the asset to the originating procurement transaction for three-way match and audit purposes.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. Used in straight-line depreciation calculations as the floor below which book value is not depreciated.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number for equipment and mechanical assets such as HVAC units, elevators, and generators. Used for warranty tracking and maintenance records.',
    `source_system` STRING COMMENT 'Operational system of record from which this fixed asset record was sourced. Supports data lineage tracking and reconciliation between Yardi Voyager Fixed Assets and SAP S/4HANA FI-AA.. Valid values are `yardi_voyager|sap_s4hana|procore|manual`',
    `source_system_asset_code` STRING COMMENT 'Native asset identifier from the originating source system (e.g., Yardi asset number or SAP asset master number). Used for cross-system reconciliation and audit trail back to the system of record.',
    `tax_depreciation_method` STRING COMMENT 'Depreciation method applied for US federal income tax purposes, which may differ from the book depreciation method. MACRS and bonus depreciation are common for real estate capital assets.. Valid values are `macrs|ads|straight_line|bonus_depreciation|section_179|no_depreciation`',
    `tax_useful_life_years` DECIMAL(18,2) COMMENT 'Useful life assigned to the asset for tax depreciation purposes under IRS MACRS or ADS rules. May differ from the book useful_life_years used for GAAP reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixed asset record was last modified in the data platform. Supports change data capture, incremental loads, and SOX audit trail requirements.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Estimated useful economic life of the asset in years, used to calculate straight-line and other depreciation schedules. Determined per asset class per FASB ASC 360 and IRS guidelines.',
    `vendor_name` STRING COMMENT 'Name of the vendor, contractor, or supplier from whom the asset was acquired or who performed the capital improvement. Supports AP reconciliation and vendor spend analysis.',
    `warranty_expiry_date` DATE COMMENT 'Date on which the manufacturer or contractor warranty for this asset expires. Used to trigger preventive maintenance scheduling and warranty claim management before expiry.',
    `ytd_depreciation` DECIMAL(18,2) COMMENT 'Depreciation expense charged against this asset in the current fiscal year to date. Used for period-end financial reporting and budget-to-actual CAPEX variance analysis.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset register for all capitalized real estate assets including buildings, land improvements, tenant improvements (TI), HVAC systems, and capital equipment. Supports CAPEX tracking, depreciation schedules, and FASB ASC 360 asset impairment testing. Sourced from Yardi Voyager Fixed Assets and SAP S/4HANA FA. Attributes include asset number, asset description, asset class, property reference, acquisition date, acquisition cost, useful life, depreciation method, accumulated depreciation, net book value, disposal date, and disposal proceeds.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique surrogate identifier for each bank account record in the master registry. Primary key for the bank_account data product.',
    `asset_id` BIGINT COMMENT 'Reference to the property associated with this bank account. Applicable for property-level operating, escrow, or reserve accounts. Null for corporate-level accounts.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the General Ledger (GL) cash account in the chart of accounts to which this bank account maps. Enables automated GL posting and bank reconciliation in Yardi Voyager and SAP S/4HANA.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center associated with this bank account for financial reporting and expense allocation. Supports property-level and portfolio-level P&L reporting.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: RE bank accounts for international properties are domiciled in specific countries for AML compliance, FATF reporting, foreign ownership regulations, and withholding tax determination. Replaces denorma',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: RE property management bank accounts (operating, security deposit, reserve) are denominated in specific currencies for bank reconciliation, cash flow reporting, and multi-currency treasury management.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Bank accounts are subject to jurisdiction-specific regulations — escheatment laws, tax withholding requirements, anti-money-laundering rules, and state banking regulations. Treasury and compliance tea',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (corporate entity, SPE, or ownership structure) that holds this bank account. Supports multi-entity financial consolidation in SAP S/4HANA.',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio this bank account is associated with. Supports portfolio-level cash management and Assets Under Management (AUM) reporting.',
    `account_name` STRING COMMENT 'Official name of the bank account as registered with the financial institution. Typically reflects the legal entity or property name (e.g., Acme Realty LLC — Operating Account).',
    `account_number_masked` STRING COMMENT 'Masked bank account number retaining only the last four digits for display and reconciliation purposes. Full account number must not be stored in the lakehouse per PCI-DSS controls. Format: XXXX1234.. Valid values are `^[X*]{4,12}[0-9]{4}$`',
    `account_purpose` STRING COMMENT 'Specific operational purpose of the bank account within the real estate business. Provides finer-grained classification beyond account_type for cash management and reconciliation. [ENUM-REF-CANDIDATE: rent_collection|vendor_disbursement|payroll|tax_escrow|insurance_escrow|capital_reserve|tenant_security_deposit|loan_proceeds|construction_draw|intercompany — promote to reference product]',
    `account_status` STRING COMMENT 'Current lifecycle status of the bank account. Active accounts are available for transactions; frozen accounts are temporarily restricted by the bank or internal controls; closed accounts are permanently decommissioned; pending_approval accounts are awaiting authorization before activation.. Valid values are `active|inactive|frozen|closed|pending_approval`',
    `account_type` STRING COMMENT 'Classification of the bank account by its designated business purpose. Operating accounts handle day-to-day receipts and disbursements; escrow accounts hold funds pending transaction close; security deposit accounts hold tenant security deposits per statutory requirements; reserve accounts hold capital reserve funds; payroll accounts fund employee compensation; construction accounts fund development draws.. Valid values are `operating|escrow|security_deposit|reserve|payroll|construction`',
    `ach_enabled` BOOLEAN COMMENT 'Indicates whether Automated Clearing House (ACH) electronic payments are enabled for this bank account. Supports automated rent collection and vendor disbursement workflows.',
    `balance_as_of_date` DATE COMMENT 'The effective date of the current_balance figure. Indicates the point in time to which the reported balance applies, enabling accurate cash position reporting.',
    `bank_branch_address` STRING COMMENT 'Street address of the bank branch where the account is held. Used for official correspondence and audit documentation.',
    `bank_branch_name` STRING COMMENT 'Name of the specific bank branch where the account is domiciled. Used for correspondence and relationship management with the banking institution.',
    `bank_name` STRING COMMENT 'Full legal name of the financial institution where the account is held (e.g., JPMorgan Chase Bank, N.A.). Used for bank reconciliation reporting and counterparty risk management.',
    `bank_routing_number` STRING COMMENT 'Nine-digit American Bankers Association (ABA) routing transit number identifying the financial institution for ACH and wire transfer transactions. Classified confidential as it enables payment initiation.. Valid values are `^[0-9]{9}$`',
    `bank_statement_delivery` STRING COMMENT 'Method by which bank statements are delivered for this account. Electronic statements are imported directly into Yardi Voyager or SAP S/4HANA for automated reconciliation; paper statements require manual processing.. Valid values are `electronic|paper|both`',
    `close_date` DATE COMMENT 'Date on which the bank account was closed or decommissioned. Null for active accounts. Required for account lifecycle management and regulatory reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank account record was first created in the system. Supports audit trail and data lineage requirements.',
    `current_balance` DECIMAL(18,2) COMMENT 'Most recently confirmed ledger balance of the bank account as of the last reconciliation or bank statement date. Used for cash position monitoring and liquidity management. Not a calculated aggregate — represents the point-in-time balance from the source system.',
    `dual_signature_required` BOOLEAN COMMENT 'Indicates whether transactions on this account require dual authorization (two signatories). True for accounts with high transaction thresholds or escrow accounts per SOX internal controls.',
    `house_bank_code` STRING COMMENT 'SAP S/4HANA House Bank identifier representing the bank-level grouping under which this account is configured. Used for payment program configuration and bank statement processing.',
    `iban` STRING COMMENT 'International Bank Account Number (IBAN) for accounts held at international financial institutions. Required for cross-border wire transfers and EU/UK regulatory compliance.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$`',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applicable to the bank account balance, expressed as a decimal (e.g., 0.045000 for 4.5%). Applicable for interest-bearing accounts such as money market or reserve accounts.',
    `is_intercompany` BOOLEAN COMMENT 'Indicates whether this bank account is used for intercompany transactions between related legal entities within the portfolio. Supports intercompany elimination in financial consolidation.',
    `last_reconciled_date` DATE COMMENT 'Date of the most recent completed bank reconciliation for this account. Critical for SOX-compliant financial controls and cash position accuracy monitoring.',
    `lockbox_number` STRING COMMENT 'Bank-assigned lockbox number for accounts configured to receive tenant rent payments via lockbox processing. Enables automated AR cash application in Yardi Voyager.',
    `minimum_balance` DECIMAL(18,2) COMMENT 'Minimum balance required to be maintained in the account per bank agreement or internal policy (e.g., compensating balance requirements for credit facilities). Triggers alerts when balance falls below threshold.',
    `open_date` DATE COMMENT 'Date on which the bank account was officially opened with the financial institution. Used for account lifecycle tracking and audit trail.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'Maximum overdraft facility approved by the bank for this account. Zero or null if no overdraft facility exists. Used in cash management and liquidity risk monitoring.',
    `positive_pay_enrolled` BOOLEAN COMMENT 'Indicates whether this account is enrolled in the banks Positive Pay fraud prevention service, which validates issued checks against a transmitted file before clearing. Critical for AP disbursement fraud controls.',
    `reconciliation_frequency` STRING COMMENT 'Required frequency at which this bank account must be reconciled per internal controls policy. Drives automated reconciliation scheduling in Yardi Voyager.. Valid values are `daily|weekly|monthly|quarterly`',
    `ref` STRING COMMENT 'Internal reference code or short identifier assigned to this bank account within Yardi Voyager or SAP S/4HANA for use in GL postings, bank reconciliation, and reporting. Distinct from the masked account number.',
    `swift_code` STRING COMMENT 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Business Identifier Code (BIC) for the bank. Required for international wire transfers. Applicable for accounts at institutions with international operations.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this bank account record. Used for change data capture, audit trail, and SOX-compliant record management.',
    `wire_transfer_enabled` BOOLEAN COMMENT 'Indicates whether outgoing wire transfers are enabled for this bank account. Controls payment method availability in AP disbursement workflows.',
    `yardi_bank_code` STRING COMMENT 'Source system identifier for this bank account record in Yardi Voyager. Used for data lineage, reconciliation between the lakehouse silver layer and the operational system, and audit traceability.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Master registry of all corporate and property-level bank accounts used for cash management, rent collection, operating disbursements, and escrow. Supports cash position monitoring and bank reconciliation. Attributes include account number (masked), bank name, bank routing number, account type (operating, escrow, security deposit, reserve), currency, property or entity reference, account status, and signatory details.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`debt_instrument` (
    `debt_instrument_id` BIGINT COMMENT 'Unique surrogate identifier for each debt instrument record in the master registry. Primary key for the debt_instrument data product.',
    `asset_id` BIGINT COMMENT 'Reference to the collateral property securing this debt instrument. Supports LTV monitoring, property-level DSCR calculations, and collateral reporting to lenders.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Debt instruments (mortgages, construction loans, credit facilities) are typically associated with a specific bank account for loan proceeds disbursement and debt service payment collection. In real es',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the General Ledger (GL) account used to record the debt liability on the balance sheet. Ensures proper financial consolidation in SAP S/4HANA and SOX-compliant financial controls.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this debt instrument for financial reporting and budget allocation purposes within SAP S/4HANA and Yardi Voyager.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: RE debt instruments (mortgages, mezzanine loans, construction loans) for international properties are denominated in specific currencies for debt service calculation, LTV covenant monitoring, and lend',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Debt instruments are governed by jurisdiction-specific lending laws, usury caps, foreclosure procedures, and recording requirements. Real estate lenders and asset managers must know which jurisdiction',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Debt instruments (mortgages, construction loans, credit facilities) are obligations of a specific legal entity in the real estate enterprise. The debt_instrument product currently has no FK to legal_e',
    `lender_id` BIGINT COMMENT 'FK to finance.lender',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Mortgages and deeds of trust are secured by specific parcels (APN-level collateral). Lenders, servicers, and title officers require structured parcel-level collateral tracking for lien position manage',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio to which this debt instrument belongs. Enables portfolio-level debt aggregation, LTV roll-up, and DSCR covenant tracking across multi-property portfolios.',
    `title_record_id` BIGINT COMMENT 'Foreign key linking to property.title_record. Business justification: Debt instruments (mortgages, deeds of trust) are recorded as encumbrances on title records with specific recording numbers and priority positions. Title officers and real estate attorneys require this',
    `amortization_period_months` STRING COMMENT 'Total number of months over which the loan principal is amortized for payment calculation purposes. May differ from the loan term for balloon loans (e.g., 30-year amortization with 10-year balloon).',
    `amortization_type` STRING COMMENT 'Describes the principal repayment structure of the debt instrument. Fully amortizing loans retire principal over the term; interest-only loans defer principal to maturity; balloon loans have a large final payment.. Valid values are `fully_amortizing|interest_only|partial_amortization|balloon`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this debt instrument record was first created in the data platform. Supports audit trail requirements under SOX Section 302/404 and data governance lineage tracking.',
    `cross_collateralized` BOOLEAN COMMENT 'Indicates whether this debt instrument is cross-collateralized with other properties or loans, meaning multiple properties secure the same debt obligation. Impacts disposition and refinancing strategies.',
    `debt_issuance_costs` DECIMAL(18,2) COMMENT 'Total capitalized costs incurred to obtain the debt financing including legal fees, title insurance, appraisal fees, and origination fees. Presented as a direct deduction from the carrying amount of the debt per FASB ASC 835-30.',
    `dscr_covenant_threshold` DECIMAL(18,2) COMMENT 'Minimum Debt Service Coverage Ratio (DSCR) required under the loan agreement. DSCR is Net Operating Income (NOI) divided by total debt service. Breach triggers lender notification and potential cash trap provisions.',
    `escrow_required` BOOLEAN COMMENT 'Indicates whether the lender requires the borrower to maintain escrow accounts for taxes, insurance, and/or capital reserves as a condition of the loan.',
    `extended_maturity_date` DATE COMMENT 'Revised maturity date if the borrower has exercised an extension option under the loan agreement. Null if no extension has been exercised.',
    `guarantor_name` STRING COMMENT 'Legal name of the entity or individual providing a personal or corporate guarantee on the debt instrument. Applicable for recourse and partial-recourse loans. Required for credit risk and exposure reporting.',
    `instrument_status` STRING COMMENT 'Current lifecycle status of the debt instrument. Drives covenant monitoring workflows, lender reporting, and portfolio risk dashboards. [ENUM-REF-CANDIDATE: active|paid_off|in_default|in_foreclosure|refinanced|cancelled — promote to reference product]. Valid values are `active|paid_off|in_default|in_foreclosure|refinanced|cancelled`',
    `instrument_type` STRING COMMENT 'Classification of the debt instrument by its structural form. Determines applicable accounting treatment, covenant structures, and reporting requirements. [ENUM-REF-CANDIDATE: mortgage|construction_loan|mezzanine_debt|cmbs|credit_facility|bridge_loan — promote to reference product]. Valid values are `mortgage|construction_loan|mezzanine_debt|cmbs|credit_facility|bridge_loan`',
    `interest_only_end_date` DATE COMMENT 'Date on which the interest-only period expires and principal amortization payments commence. Applicable for hybrid and partial-amortization instruments. Null for fully amortizing loans.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applicable to the debt instrument expressed as a decimal (e.g., 0.065000 for 6.5%). For variable-rate instruments, reflects the current all-in rate including spread over the index.',
    `loan_number` STRING COMMENT 'Externally-known unique identifier assigned by the lender to this debt instrument. Used for lender correspondence, covenant reporting, and CMBS/RMBS pool identification. Maps to the loan reference number in Yardi Voyager Debt Management and SAP S/4HANA Finance.',
    `loan_term_months` STRING COMMENT 'Contractual duration of the debt instrument in months from origination to scheduled maturity. Used for debt maturity ladder analysis and refinancing pipeline planning.',
    `ltv_covenant_threshold` DECIMAL(18,2) COMMENT 'Maximum Loan-to-Value (LTV) ratio permitted under the loan agreement before a covenant breach is triggered. Drives automated covenant monitoring alerts and lender notification workflows.',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'Loan-to-Value (LTV) ratio calculated as outstanding principal balance divided by the appraised or market value of the collateral property. Key covenant metric monitored against lender thresholds for compliance.',
    `maturity_date` DATE COMMENT 'Contractual date on which the outstanding principal balance is due in full. Critical for refinancing planning, balloon payment scheduling, and WALT/WALE analysis in portfolio reporting.',
    `next_payment_date` DATE COMMENT 'Date on which the next scheduled debt service payment is due. Used for cash management, AP payment scheduling in Yardi Voyager, and covenant compliance monitoring.',
    `original_principal` DECIMAL(18,2) COMMENT 'Total principal amount of the debt instrument at origination. Serves as the baseline for LTV calculations, amortization schedules, and historical debt capacity analysis.',
    `origination_date` DATE COMMENT 'Date on which the debt instrument was originated and funds were first disbursed. Marks the effective start of the debt obligation and is used for amortization schedule calculations.',
    `origination_fee` DECIMAL(18,2) COMMENT 'Upfront fee paid to the lender at loan origination, typically expressed as points (percentage of loan amount). Capitalized as debt issuance cost and amortized over the loan term per FASB ASC 835.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current unpaid principal balance of the debt instrument as of the most recent payment date. Used for LTV ratio monitoring, balance sheet reporting, and DSCR covenant compliance.',
    `payment_frequency` STRING COMMENT 'Frequency at which scheduled debt service payments (principal and interest) are due under the loan agreement. Drives payment schedule generation and cash flow forecasting.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `prepayment_lockout_end_date` DATE COMMENT 'Date after which the borrower is permitted to prepay the loan without triggering a lockout penalty. Null if no lockout period applies. Critical for disposition and refinancing timing decisions.',
    `prepayment_penalty_type` STRING COMMENT 'Type of prepayment restriction or penalty applicable to early loan payoff. Yield maintenance and defeasance are common in CMBS structures. Drives refinancing cost analysis and disposition planning.. Valid values are `none|step_down|yield_maintenance|defeasance|lockout`',
    `rate_index` STRING COMMENT 'Benchmark interest rate index to which a variable-rate instrument is tied (e.g., SOFR, Prime Rate, Treasury). Null for fixed-rate instruments. Required for interest rate risk management and hedging analysis.. Valid values are `SOFR|LIBOR|Prime|EURIBOR|Treasury|SONIA`',
    `rate_spread` DECIMAL(18,2) COMMENT 'Contractual spread in basis points expressed as a decimal added to the benchmark index to determine the all-in interest rate for variable-rate instruments (e.g., 0.020000 for 200 bps over SOFR). Null for fixed-rate instruments.',
    `rate_type` STRING COMMENT 'Classification of the interest rate structure. Fixed Rate Mortgage (FRM) maintains a constant rate; variable/Adjustable Rate Mortgage (ARM) floats against a benchmark index; hybrid combines both periods.. Valid values are `fixed|variable|hybrid`',
    `recourse_type` STRING COMMENT 'Indicates whether the lender has recourse to the borrowers other assets beyond the collateral property in the event of default. Non-recourse is standard for CMBS; full recourse is common for construction loans.. Valid values are `full_recourse|non_recourse|partial_recourse`',
    `scheduled_payment_amount` DECIMAL(18,2) COMMENT 'Total scheduled periodic debt service payment amount including both principal and interest components. Used for cash flow forecasting, NOI impact analysis, and DSCR calculations.',
    `servicer_name` STRING COMMENT 'Name of the loan servicer responsible for collecting payments and managing escrow accounts, particularly relevant for CMBS instruments where the servicer differs from the originating lender.',
    `source_system` STRING COMMENT 'Operational system of record from which this debt instrument record was sourced (e.g., Yardi Voyager, SAP S/4HANA). Supports data lineage tracking and reconciliation across systems.. Valid values are `Yardi Voyager|SAP S/4HANA|MRI Software|Argus Enterprise`',
    `source_system_loan_code` STRING COMMENT 'Native identifier of this debt instrument in the originating source system (Yardi Voyager or SAP S/4HANA). Enables bi-directional reconciliation between the lakehouse silver layer and operational systems.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this debt instrument record was most recently modified in the data platform. Required for incremental data pipeline processing and SOX audit trail compliance.',
    CONSTRAINT pk_debt_instrument PRIMARY KEY(`debt_instrument_id`)
) COMMENT 'Master registry of all property-level and portfolio-level debt instruments — mortgages, construction loans, mezzanine debt, CMBS, and credit facilities — with embedded debt service payment history. Supports LTV monitoring, DSCR covenant tracking, amortization schedules, and lender reporting. Attributes include loan number, lender, loan type, original principal, outstanding balance, interest rate, rate type (fixed/variable), maturity date, LTV ratio, DSCR covenant threshold, collateral property reference, and per-payment: scheduled/actual principal and interest amounts, payment date, payment status, outstanding balance after payment, escrow amount, and late fees.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`debt_service_payment` (
    `debt_service_payment_id` BIGINT COMMENT 'Unique system-generated identifier for each debt service payment record. Primary key for the debt_service_payment data product.',
    `asset_id` BIGINT COMMENT 'Reference to the property or asset securing or associated with the debt instrument. Enables property-level DSCR calculations and NOI-to-debt-service analysis.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: debt_service_payment has bank_account_reference as a denormalized STRING but lacks a proper FK to finance.bank_account. Debt service payments are disbursed from specific property-level or corporate ba',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the GL account to which this debt service payment is posted. Ensures accurate financial consolidation and SOX-compliant audit trails.',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Debt covenant breaches (DSCR, LTV) recorded in debt_service_payment (is_covenant_breach, covenant_breach_type fields) generate formal compliance violation records. Asset managers and lenders need to l',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this debt service obligation. Supports GL allocation and financial consolidation under SAP S/4HANA.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: RE debt service payments for international properties require validated currency references for payment processing, exchange rate application, and DSCR covenant monitoring in functional currency. Repl',
    `debt_facility_id` BIGINT COMMENT 'Foreign key linking to investment.debt_facility. Business justification: Debt service payments are made against specific investment-domain debt facilities. This link enables covenant compliance monitoring, DSCR calculation, and debt service coverage reporting by connecting',
    `debt_instrument_id` BIGINT COMMENT 'Reference to the parent debt instrument (loan, mortgage, bond, or credit facility) against which this payment is applied. Used to link payments to the originating debt obligation for DSCR and covenant reporting.',
    `lender_id` BIGINT COMMENT 'Reference to the lending institution or counterparty to whom the debt service payment is remitted. Used for lender covenant reporting and cash management.',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio to which the debt-encumbered property belongs. Supports portfolio-level debt service aggregation and DSCR roll-up reporting.',
    `actual_escrow_paid` DECIMAL(18,2) COMMENT 'The actual escrow amount remitted to the lender for this payment period. Compared against scheduled_escrow_amount to identify escrow shortfalls or surpluses.',
    `actual_interest_paid` DECIMAL(18,2) COMMENT 'The actual interest amount remitted to the lender for this payment. Compared against scheduled_interest_amount to identify variances. Feeds into interest expense reporting on the P&L.',
    `actual_payment_date` DATE COMMENT 'The date on which the debt service payment was actually remitted to the lender. Compared against scheduled_payment_date to determine timeliness and trigger late fee calculations.',
    `actual_principal_paid` DECIMAL(18,2) COMMENT 'The actual principal amount remitted to the lender for this payment. Compared against scheduled_principal_amount to identify shortfalls or prepayments. Used to update the outstanding loan balance.',
    `approval_status` STRING COMMENT 'The internal approval workflow status for this debt service payment. Ensures SOX-compliant dual-control authorization before payment disbursement.. Valid values are `pending|approved|rejected|voided`',
    `approved_by` STRING COMMENT 'The name or user identifier of the individual who authorized this debt service payment in the internal approval workflow. Required for SOX-compliant audit trail documentation.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time at which the debt service payment was approved by the authorized approver. Part of the SOX-compliant audit trail for financial disbursements.',
    `covenant_breach_type` STRING COMMENT 'Categorizes the type of lender covenant breach triggered by this payment event. Null or none when no breach occurred. Used for lender reporting and risk management escalation.. Valid values are `missed_payment|dscr_violation|ltv_violation|late_payment|none`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this debt service payment record was first created in the data platform. Supports audit trail, data lineage, and SOX-compliant record-keeping.',
    `days_past_due` STRING COMMENT 'The number of calendar days by which the actual payment date exceeded the scheduled payment date. Zero for on-time payments. Used for lender covenant monitoring, late fee calculation, and credit risk reporting.',
    `fiscal_period` STRING COMMENT 'The accounting fiscal period (YYYY-MM) to which this debt service payment is attributed. Used for period-level P&L reporting, DSCR calculations, and financial consolidation.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `grace_period_days` STRING COMMENT 'The number of calendar days after the scheduled payment date within which payment may be made without triggering a late fee or covenant breach, as defined in the loan agreement.',
    `interest_rate_applied` DECIMAL(18,2) COMMENT 'The effective annual interest rate (as a decimal, e.g., 0.065 for 6.5%) applied to calculate the interest component of this payment. Captures the rate in effect for the period, which may vary for adjustable-rate mortgages (ARM).',
    `is_covenant_breach` BOOLEAN COMMENT 'Flag indicating whether this payment event triggered a lender covenant breach (e.g., missed payment, DSCR threshold violation, LTV breach). Drives escalation workflows and lender notification requirements.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'The penalty fee charged by the lender for a payment received after the scheduled due date or grace period. Tracked separately for covenant compliance reporting and expense analysis.',
    `notes` STRING COMMENT 'Free-text field for additional context or commentary on this debt service payment, such as reasons for partial payment, lender waiver details, or manual adjustment explanations.',
    `outstanding_balance_after` DECIMAL(18,2) COMMENT 'The remaining outstanding principal balance of the debt instrument immediately after this payment is applied. Critical for Loan-to-Value (LTV) ratio monitoring, DSCR calculations, and lender covenant compliance.',
    `outstanding_balance_before` DECIMAL(18,2) COMMENT 'The outstanding principal balance of the debt instrument immediately before this payment is applied. Used to verify interest calculations and track amortization progress.',
    `payment_method` STRING COMMENT 'The mechanism used to remit the debt service payment to the lender (e.g., wire transfer, ACH, check). Used for cash management, bank reconciliation, and audit trail purposes.. Valid values are `wire_transfer|ach|check|direct_debit|internal_transfer`',
    `payment_period_number` STRING COMMENT 'The sequential payment period number within the loan amortization schedule (e.g., payment 1 of 360 for a 30-year mortgage). Used to track amortization progress and validate payment schedules.',
    `payment_reference_number` STRING COMMENT 'Externally-known unique identifier for this debt service payment, as assigned by the source system (Yardi Voyager or SAP S/4HANA) or the lenders payment portal. Used for reconciliation and lender confirmation matching.',
    `payment_status` STRING COMMENT 'Current lifecycle state of the debt service payment. Drives DSCR monitoring, lender covenant alerts, and cash flow forecasting. [ENUM-REF-CANDIDATE: scheduled|pending|paid|partial|late|missed|reversed — promote to reference product]',
    `posting_date` DATE COMMENT 'The date on which the debt service payment was posted to the General Ledger. May differ from actual_payment_date due to period-end cut-off rules. Critical for SOX-compliant financial period reporting.',
    `prepayment_penalty_amount` DECIMAL(18,2) COMMENT 'The penalty amount charged by the lender for early repayment of principal beyond the scheduled amortization. Relevant for disposition planning and refinancing analysis.',
    `rate_type` STRING COMMENT 'Indicates whether the interest rate for this payment period is fixed (FRM), variable/adjustable (ARM), or hybrid. Relevant for interest rate risk analysis and cash flow forecasting.. Valid values are `fixed|variable|hybrid`',
    `scheduled_escrow_amount` DECIMAL(18,2) COMMENT 'The contractually scheduled escrow deposit amount due for this payment period, covering property taxes, insurance, and reserves as required by the lender. Included in total debt service obligation.',
    `scheduled_interest_amount` DECIMAL(18,2) COMMENT 'The contractually scheduled interest payment amount due for this payment period, calculated based on the outstanding loan balance and the applicable interest rate. Core component of total debt service for DSCR calculations.',
    `scheduled_payment_date` DATE COMMENT 'The contractually agreed date on which the debt service payment is due to the lender, as defined in the loan agreement or amortization schedule. Used for cash flow modeling and covenant compliance tracking.',
    `scheduled_principal_amount` DECIMAL(18,2) COMMENT 'The contractually scheduled principal repayment amount due for this payment period, as defined in the loan amortization schedule. Used as the baseline for DSCR numerator calculations and variance analysis.',
    `source_system` STRING COMMENT 'The operational system of record from which this debt service payment record originated. Supports data lineage, reconciliation, and Silver layer provenance tracking.. Valid values are `yardi_voyager|sap_s4hana|mri_software|argus_enterprise|manual`',
    `source_system_payment_code` STRING COMMENT 'The native identifier of this payment record in the originating source system (Yardi Voyager or SAP S/4HANA). Used for cross-system reconciliation and data lineage tracing in the Silver layer.',
    `total_payment_amount` DECIMAL(18,2) COMMENT 'The total amount actually remitted to the lender for this payment, representing the sum of actual principal, interest, escrow, and any late fees paid. Used for cash management reconciliation and lender statement matching.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this debt service payment record was last modified in the data platform. Tracks changes for audit trail and SOX-compliant financial controls.',
    `wire_confirmation_number` STRING COMMENT 'The bank-issued confirmation or transaction reference number for wire transfer or ACH payments. Used for payment reconciliation against lender statements and bank records.',
    CONSTRAINT pk_debt_service_payment PRIMARY KEY(`debt_service_payment_id`)
) COMMENT 'Records of scheduled and actual debt service payments (principal and interest) made against debt instruments. Supports DSCR calculations, cash flow modeling, and lender covenant reporting. Attributes include payment date, scheduled date, payment type (principal, interest, escrow), scheduled principal amount, scheduled interest amount, actual principal paid, actual interest paid, outstanding balance after payment, payment status, and late fee amount.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Primary key for purchase_order',
    `amended_purchase_order_id` BIGINT COMMENT 'Self-referencing FK on purchase_order (amended_purchase_order_id)',
    `asset_id` BIGINT COMMENT 'Identifier of the property for which this purchase order is issued. Links procurement to specific real estate assets.',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Purchase orders for building-specific services (janitorial, HVAC maintenance, elevator service contracts) require building-level coding for CAM recovery calculations and building-level operating expen',
    `chart_of_accounts_id` BIGINT COMMENT 'Identifier of the general ledger account to which this purchase order will be posted for financial accounting.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center to which this purchase order expense will be allocated for financial reporting and budgeting.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Purchase orders are issued by a specific legal entity in a real estate enterprise. The legal entity determines the contracting party, tax obligations, and financial reporting attribution. In multi-ent',
    `service_contract_id` BIGINT COMMENT 'Identifier of the master contract or blanket agreement under which this purchase order is issued, if applicable.',
    `approval_date` DATE COMMENT 'The date on which the purchase order was formally approved by authorized personnel.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address to which invoices should be sent.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address, typically suite or department number.',
    `billing_city` STRING COMMENT 'City name for the billing address.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address.',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the billing address.',
    `billing_state_province` STRING COMMENT 'State or province code for the billing address.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the purchase order was cancelled, if applicable. Supports audit trail and vendor relationship management.',
    `cancelled_date` DATE COMMENT 'The date on which the purchase order was cancelled, if applicable.',
    `closed_date` DATE COMMENT 'The date on which the purchase order was closed after all goods were received and invoices processed.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which this purchase order is denominated.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total discount amount applied to this purchase order based on vendor agreements or promotional terms.',
    `is_capital_expenditure` BOOLEAN COMMENT 'Boolean flag indicating whether this purchase order represents a capital expenditure that will be capitalized on the balance sheet rather than expensed.',
    `is_urgent` BOOLEAN COMMENT 'Boolean flag indicating whether this purchase order requires expedited processing and delivery.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order record was last modified. Audit trail field.',
    `notes` STRING COMMENT 'Free-form text field for additional instructions, special handling requirements, or internal comments related to this purchase order.',
    `payment_terms` STRING COMMENT 'The agreed payment terms between buyer and vendor specifying when payment is due after invoice receipt.',
    `po_date` DATE COMMENT 'The date on which the purchase order was created and issued to the vendor. Principal business event timestamp.',
    `po_number` STRING COMMENT 'Externally-known business identifier for the purchase order, typically formatted as PO-XXXXXX. Used for vendor communication and invoice matching.',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order in the procurement workflow.',
    `po_type` STRING COMMENT 'Classification of the purchase order based on procurement strategy and usage pattern.',
    `promised_delivery_date` DATE COMMENT 'The date by which the vendor has committed to deliver goods or complete services.',
    `requested_delivery_date` DATE COMMENT 'The date by which the buyer requests delivery of goods or completion of services.',
    `shipping_address_line1` STRING COMMENT 'First line of the physical address where goods should be delivered.',
    `shipping_address_line2` STRING COMMENT 'Second line of the physical address where goods should be delivered, typically suite or unit number.',
    `shipping_amount` DECIMAL(18,2) COMMENT 'The freight or shipping charges associated with delivery of goods for this purchase order.',
    `shipping_city` STRING COMMENT 'City name for the shipping address.',
    `shipping_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the shipping address.',
    `shipping_method` STRING COMMENT 'The method by which goods will be shipped or delivered to the buyer location.',
    `shipping_postal_code` STRING COMMENT 'Postal or ZIP code for the shipping address.',
    `shipping_state_province` STRING COMMENT 'State or province code for the shipping address.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'The sum of all line item amounts before taxes, fees, and discounts are applied.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applied to this purchase order, including sales tax, VAT, or other applicable taxes.',
    `total_amount` DECIMAL(18,2) COMMENT 'The final total amount of the purchase order including subtotal, taxes, shipping, and discounts. Net payable amount.',
    `vendor_contact_email` STRING COMMENT 'Email address of the primary vendor contact for communication regarding this purchase order.',
    `vendor_contact_name` STRING COMMENT 'Name of the primary contact person at the vendor organization for this purchase order.',
    `vendor_contact_phone` STRING COMMENT 'Phone number of the primary vendor contact for communication regarding this purchase order.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Master reference table for purchase_order. Referenced by purchase_order_id.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key for payment_run',
    `asset_id` BIGINT COMMENT 'Reference to the property associated with this payment run, if applicable (e.g., property-specific vendor payments).',
    `bank_account_id` BIGINT COMMENT 'Reference to the company bank account from which payments in this run are disbursed.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for or associated with this payment run.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Payment runs generate GL postings to a specific ledger. The ledger determines the accounting basis (GAAP, cash, tax) under which the payment is recorded. Linking payment_run to ledger ensures that the',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Payment runs are executed on behalf of a specific legal entity — the entity whose bank accounts are debited and whose AP liabilities are settled. In a multi-entity real estate portfolio, payment runs ',
    `portfolio_id` BIGINT COMMENT 'Reference to the portfolio associated with this payment run for portfolio-level payment processing.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Payment runs are executed specifically to satisfy regulatory obligations — penalty payments, annual filing fees, environmental remediation disbursements. Treasury teams need to reconcile payment runs ',
    `reprocessed_payment_run_id` BIGINT COMMENT 'Self-referencing FK on payment_run (reprocessed_payment_run_id)',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this payment run requires formal approval before execution (True) or can be executed without approval (False).',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this payment run was approved for execution.',
    `batch_reference_number` STRING COMMENT 'External batch reference number assigned by the payment processor or banking system for tracking purposes.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why this payment run was cancelled.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The date and time when this payment run was cancelled.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all payments in this run (e.g., USD, CAD, EUR).',
    `executed_timestamp` TIMESTAMP COMMENT 'The date and time when this payment run was executed and payment processing was initiated.',
    `execution_date` DATE COMMENT 'The actual date on which the payment run was executed and payments were initiated.',
    `failed_amount` DECIMAL(18,2) COMMENT 'The total monetary value of payments that failed to process in this run.',
    `failed_payment_count` STRING COMMENT 'The number of payments that failed to process or were rejected during this run.',
    `fiscal_period` STRING COMMENT 'The fiscal period (YYYY-MM format) to which this payment run is assigned for financial reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this payment run belongs for financial reporting purposes.',
    `gl_posting_date` DATE COMMENT 'The date on which the payment run transactions are posted to the general ledger for accounting purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payment run record was last modified.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used for disbursements in this run (e.g., ACH, wire transfer, check).',
    `payment_run_status` STRING COMMENT 'Current lifecycle status of the payment run indicating its stage in the approval and execution workflow.',
    `processing_notes` STRING COMMENT 'Free-text notes or comments related to the processing of this payment run, including any issues or special handling instructions.',
    `reconciliation_date` DATE COMMENT 'The date on which this payment run was reconciled with bank statements.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether this payment run has been reconciled with bank statements and payment confirmations.',
    `run_name` STRING COMMENT 'Descriptive name assigned to the payment run for identification purposes (e.g., Q1 2024 Vendor Payments, Monthly Lease Payments - March).',
    `run_number` STRING COMMENT 'Business-facing unique identifier for the payment run, typically formatted as PR-YYYYMMDD-NNNN.',
    `run_type` STRING COMMENT 'Classification of the payment run based on the nature of payments being processed.',
    `scheduled_date` DATE COMMENT 'The date on which payments in this run are scheduled to be disbursed or initiated.',
    `source_system` STRING COMMENT 'The system of record from which this payment run originated (e.g., Yardi Voyager, SAP S/4HANA).',
    `source_system_code` STRING COMMENT 'The unique identifier for this payment run in the source system of record.',
    `successful_amount` DECIMAL(18,2) COMMENT 'The total monetary value of payments that were successfully processed in this run.',
    `successful_payment_count` STRING COMMENT 'The number of payments that were successfully processed and disbursed in this run.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total monetary value of all payments included in this payment run.',
    `total_payment_count` STRING COMMENT 'The total number of individual payment transactions included in this payment run.',
    `value_date` DATE COMMENT 'The effective date for accounting and financial reporting purposes when payments are considered settled.',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Master reference table for payment_run. Referenced by payment_run_id.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`lender` (
    `lender_id` BIGINT COMMENT 'Primary key for lender',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Real estate lender relationship management and loan sourcing require lenders classified by geographic market (MSA, submarket, region). Supports lender selection for acquisitions and refinancings by ma',
    `parent_lender_id` BIGINT COMMENT 'Self-referencing FK on lender (parent_lender_id)',
    `address_line_1` STRING COMMENT 'First line of the lenders primary business address, typically street address.',
    `address_line_2` STRING COMMENT 'Second line of the lenders primary business address, typically suite or floor number.',
    `city` STRING COMMENT 'City where the lenders primary business office is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the lenders primary business location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lender record was first created in the system.',
    `credit_rating` STRING COMMENT 'Current credit rating of the lending institution as assigned by major rating agencies.',
    `credit_rating_agency` STRING COMMENT 'Name of the credit rating agency that assigned the credit rating.',
    `credit_rating_date` DATE COMMENT 'Date when the current credit rating was assigned or last updated.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the lenders primary lending currency.',
    `debt_service_coverage_ratio_min` DECIMAL(18,2) COMMENT 'Minimum debt service coverage ratio required by this lender for loan approval, expressed as a decimal (e.g., 1.25 for 1.25x coverage).',
    `federal_reserve_routing_number` STRING COMMENT 'Nine-digit ABA routing number for the lender, used for wire transfers and ACH transactions.',
    `lender_code` STRING COMMENT 'The externally-known unique code or identifier for the lender, used in loan documentation and financial systems.',
    `lender_name` STRING COMMENT 'The full legal name of the lending institution or financial entity.',
    `lender_status` STRING COMMENT 'Current operational status of the lender relationship in the system lifecycle.',
    `lender_type` STRING COMMENT 'Classification of the lender by institution type.',
    `lending_capacity_amount` DECIMAL(18,2) COMMENT 'Maximum lending capacity or credit line available from this lender for real estate financing.',
    `loan_to_value_ratio_max` DECIMAL(18,2) COMMENT 'Maximum loan-to-value ratio that this lender will accept for real estate financing, expressed as a decimal (e.g., 0.75 for 75%).',
    `maximum_loan_amount` DECIMAL(18,2) COMMENT 'Maximum loan amount that this lender will underwrite for a single real estate transaction.',
    `minimum_loan_amount` DECIMAL(18,2) COMMENT 'Minimum loan amount that this lender will underwrite for real estate transactions.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lender record was last modified in the system.',
    `notes` STRING COMMENT 'Free-form notes or comments about the lender, including special terms, relationship history, or underwriting preferences.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the lenders primary business address.',
    `preferred_lender_flag` BOOLEAN COMMENT 'Indicates whether this lender has preferred status for financing transactions.',
    `primary_contact_email` STRING COMMENT 'Primary email address for the main contact at the lending institution.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the lending institution.',
    `primary_contact_phone` STRING COMMENT 'Primary phone number for the main contact at the lending institution.',
    `property_types_financed` STRING COMMENT 'Comma-separated list of property types that this lender will finance (e.g., multifamily, office, retail, industrial, mixed-use).',
    `relationship_end_date` DATE COMMENT 'Date when the business relationship with this lender was terminated or ended, if applicable.',
    `relationship_start_date` DATE COMMENT 'Date when the business relationship with this lender was established.',
    `state_province` STRING COMMENT 'State or province where the lenders primary business office is located.',
    `swift_code` STRING COMMENT 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) code for international wire transfers.',
    `tax_identification_number` STRING COMMENT 'Tax identification number or employer identification number for the lending institution.',
    `typical_interest_rate` DECIMAL(18,2) COMMENT 'Typical or baseline interest rate offered by this lender, expressed as a decimal (e.g., 0.0525 for 5.25%).',
    `website_url` STRING COMMENT 'Primary website URL for the lending institution.',
    CONSTRAINT pk_lender PRIMARY KEY(`lender_id`)
) COMMENT 'Master reference table for lender. Referenced by lender_id.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`ledger` (
    `ledger_id` BIGINT COMMENT 'Primary key for ledger',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the chart of accounts structure used by this ledger.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `currency_code_id` BIGINT COMMENT 'FK to reference.currency_code',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Ledgers in multi-jurisdictional real estate entities are jurisdiction-specific — separate ledgers for different state tax regimes, IFRS vs GAAP by jurisdiction, or local statutory reporting. Controlle',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that owns or operates this ledger.',
    `parent_ledger_id` BIGINT COMMENT 'Reference to the parent ledger in a hierarchical ledger structure, if applicable.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Real estate companies maintain separate ledgers by property type (residential, commercial, industrial) for REIT compliance, financial statement segmentation, and property-type-specific accounting stan',
    `accounting_basis` STRING COMMENT 'The accounting method applied to this ledger (accrual, cash, or modified accrual basis).',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Indicates whether detailed audit trail logging is enabled for all transactions posted to this ledger.',
    `auto_reversal_enabled_flag` BOOLEAN COMMENT 'Indicates whether automatic reversal of accrual entries is enabled for this ledger.',
    `budget_tracking_enabled_flag` BOOLEAN COMMENT 'Indicates whether budget versus actual tracking and variance analysis is enabled for this ledger.',
    `consolidation_flag` BOOLEAN COMMENT 'Indicates whether this ledger is included in consolidated financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this ledger record was first created in the system.',
    `effective_end_date` DATE COMMENT 'The date on which this ledger ceases to be active for transaction posting. Null for open-ended ledgers.',
    `effective_start_date` DATE COMMENT 'The date from which this ledger becomes active and available for transaction posting.',
    `encumbrance_accounting_flag` BOOLEAN COMMENT 'Indicates whether encumbrance accounting (commitment tracking) is enabled for this ledger.',
    `external_ledger_reference` STRING COMMENT 'External reference identifier or code used by upstream source systems to identify this ledger.',
    `fiscal_year_start_month` STRING COMMENT 'Month number (1-12) indicating the start of the fiscal year for this ledger.',
    `intercompany_elimination_flag` BOOLEAN COMMENT 'Indicates whether intercompany transactions in this ledger are subject to elimination during consolidation.',
    `journal_approval_required_flag` BOOLEAN COMMENT 'Indicates whether journal entries posted to this ledger require managerial approval before posting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this ledger record was last updated or modified.',
    `ledger_code` STRING COMMENT 'Unique business identifier code for the ledger, used for external reference and reporting.',
    `ledger_description` STRING COMMENT 'Detailed textual description of the ledgers purpose, scope, and usage within the financial system.',
    `ledger_name` STRING COMMENT 'Human-readable name of the ledger (e.g., General Ledger, Property Ledger, Subsidiary Ledger).',
    `ledger_status` STRING COMMENT 'Current operational status of the ledger in the financial system lifecycle.',
    `ledger_type` STRING COMMENT 'Classification of the ledger by its functional purpose within the financial system.',
    `multi_currency_enabled_flag` BOOLEAN COMMENT 'Indicates whether this ledger supports transactions in multiple currencies with automatic conversion.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to this ledger.',
    `period_close_day` STRING COMMENT 'The day of the month (1-31) on which accounting periods are typically closed for this ledger.',
    `reporting_segment` STRING COMMENT 'Business segment or division classification for financial reporting and analysis purposes.',
    `retained_earnings_account_code` STRING COMMENT 'The general ledger account code used for retained earnings in this ledgers chart of accounts.',
    `source_system_code` STRING COMMENT 'Code identifying the source system of record for this ledger (e.g., YARDI, SAP_S4HANA).',
    `sox_compliant_flag` BOOLEAN COMMENT 'Indicates whether this ledger is subject to Sarbanes-Oxley Act compliance controls and audit requirements.',
    `suspense_account_code` STRING COMMENT 'The general ledger account code used for suspense or unallocated transactions in this ledger.',
    `version_number` STRING COMMENT 'Version number of this ledger record, incremented with each modification for change tracking.',
    CONSTRAINT pk_ledger PRIMARY KEY(`ledger_id`)
) COMMENT 'Master reference table for ledger. Referenced by ledger_id.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`finance`.`reporting_period` (
    `reporting_period_id` BIGINT COMMENT 'Primary key for reporting_period',
    `parent_period_reporting_period_id` BIGINT COMMENT 'Reference to the parent reporting period for hierarchical period structures (e.g., monthly period rolling up to quarterly period). Null for top-level periods.',
    `primary_prior_reporting_period_id` BIGINT COMMENT 'Self-referencing FK on reporting_period (prior_reporting_period_id)',
    `budget_version` STRING COMMENT 'Version identifier for the budget associated with this reporting period (e.g., Original, Revised Q2, Final). Used to track budget revisions and forecasts.',
    `calendar_month` STRING COMMENT 'The calendar month within the calendar year (1-12). Null for non-monthly periods.',
    `calendar_quarter` STRING COMMENT 'The calendar quarter within the calendar year (1, 2, 3, or 4). Null for non-quarterly periods.',
    `calendar_year` STRING COMMENT 'The calendar year to which this reporting period belongs (e.g., 2024).',
    `closed_date` DATE COMMENT 'The date when the reporting period was officially closed for new transactions. Null if period is still open. Format: yyyy-MM-dd.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reporting period record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `end_date` DATE COMMENT 'The last date of the reporting period (inclusive). Format: yyyy-MM-dd.',
    `fiscal_month` STRING COMMENT 'The fiscal month within the fiscal year (1-12). Null for non-monthly periods.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter within the fiscal year (1, 2, 3, or 4). Null for non-quarterly periods.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this reporting period belongs (e.g., 2024).',
    `is_adjustment_period` BOOLEAN COMMENT 'Indicates whether this period is designated for year-end or period-end adjustments (e.g., 13th period in some accounting systems).',
    `is_current_period` BOOLEAN COMMENT 'Indicates whether this is the current active reporting period for financial transactions and reporting.',
    `is_leap_year` BOOLEAN COMMENT 'Indicates whether the reporting period falls within a leap year (366 days). Relevant for daily and annual period calculations.',
    `locked_date` DATE COMMENT 'The date when the reporting period was locked and finalized. Null if period is not locked. Format: yyyy-MM-dd.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the reporting period record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `number_of_business_days` STRING COMMENT 'Total number of business days (excluding weekends and holidays) in the reporting period.',
    `number_of_days` STRING COMMENT 'Total number of calendar days in the reporting period.',
    `period_code` STRING COMMENT 'Standardized code representing the reporting period, used for system integration and reporting (e.g., 2024Q1, 202401, FY2024).',
    `period_name` STRING COMMENT 'Human-readable name or label for the reporting period (e.g., Q1 2024, January 2024, FY2024).',
    `period_type` STRING COMMENT 'Classification of the reporting period granularity (daily, weekly, monthly, quarterly, semi-annual, annual).',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the primary reporting currency used in this period (e.g., USD, EUR, GBP).',
    `reporting_period_description` STRING COMMENT 'Detailed description or notes about the reporting period, including any special circumstances or adjustments.',
    `reporting_period_status` STRING COMMENT 'Current lifecycle status of the reporting period. Open: transactions can be posted; Closed: period is closed for new transactions; Locked: period is finalized and cannot be reopened; Archived: historical period retained for compliance.',
    `sequence_number` STRING COMMENT 'Sequential ordering number for the reporting period within its fiscal year or parent period hierarchy.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this reporting period was created or synchronized (e.g., YARDI, SAP, MANUAL).',
    `start_date` DATE COMMENT 'The first date of the reporting period (inclusive). Format: yyyy-MM-dd.',
    CONSTRAINT pk_reporting_period PRIMARY KEY(`reporting_period_id`)
) COMMENT 'Master reference table for reporting_period. Referenced by reporting_period_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_entity_legal_entity_id` FOREIGN KEY (`parent_entity_legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_reversed_entry_journal_entry_id` FOREIGN KEY (`reversed_entry_journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_original_line_journal_entry_line_id` FOREIGN KEY (`original_line_journal_entry_line_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `real_estate_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `real_estate_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_original_receipt_ar_receipt_id` FOREIGN KEY (`original_receipt_ar_receipt_id`) REFERENCES `real_estate_ecm`.`finance`.`ar_receipt`(`ar_receipt_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_lender_id` FOREIGN KEY (`lender_id`) REFERENCES `real_estate_ecm`.`finance`.`lender`(`lender_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_lender_id` FOREIGN KEY (`lender_id`) REFERENCES `real_estate_ecm`.`finance`.`lender`(`lender_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_amended_purchase_order_id` FOREIGN KEY (`amended_purchase_order_id`) REFERENCES `real_estate_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_reprocessed_payment_run_id` FOREIGN KEY (`reprocessed_payment_run_id`) REFERENCES `real_estate_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ADD CONSTRAINT `fk_finance_lender_parent_lender_id` FOREIGN KEY (`parent_lender_id`) REFERENCES `real_estate_ecm`.`finance`.`lender`(`lender_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_parent_ledger_id` FOREIGN KEY (`parent_ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`reporting_period` ADD CONSTRAINT `fk_finance_reporting_period_parent_period_reporting_period_id` FOREIGN KEY (`parent_period_reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`reporting_period` ADD CONSTRAINT `fk_finance_reporting_period_primary_prior_reporting_period_id` FOREIGN KEY (`primary_prior_reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);

-- ========= TAGS =========
ALTER SCHEMA `real_estate_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `real_estate_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'ledger_control');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|percentage|square_footage|headcount|none');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Real Estate Asset Class');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `cam_pool_indicator` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Pool Indicator');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `capex_eligible` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Eligible');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `center_type` SET TAGS ('dbx_value_regex' = 'property|corporate|departmental|development|investment');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'opex|capex|mixed|overhead|revenue');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|locked');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `esg_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Tracking Enabled');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `gl_account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `noi_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Net Operating Income (NOI) Tracking Enabled');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Notes');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `responsible_manager` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Name');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `responsible_manager` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Short Name');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi|sap|mri|argus|manual|other');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Cost Center Code');
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ALTER COLUMN `sox_control_relevant` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Relevant');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` SET TAGS ('dbx_subdomain' = 'ledger_control');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts Identifier');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_description` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Description');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_short_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Short Name');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_short_name` SET TAGS ('dbx_value_regex' = '^.{1,20}$');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending_review');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_subtype` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Sub-Type');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Account Approval Date');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Account Approval Authority');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `argus_line_item` SET TAGS ('dbx_business_glossary_term' = 'Argus Enterprise Line Item Mapping');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `budget_relevant` SET TAGS ('dbx_business_glossary_term' = 'Budget Relevant Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cam_recoverable_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Recoverable Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `capex_opex_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) vs Operating Expenditure (OPEX) Classification');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `capex_opex_flag` SET TAGS ('dbx_value_regex' = 'capex|opex|not_applicable');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cash_flow_category` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Statement Category');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cash_flow_category` SET TAGS ('dbx_value_regex' = 'operating|investing|financing|not_applicable');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `consolidation_account_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Consolidation Account Code');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `consolidation_account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|not_applicable');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Account Deactivation Date');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `ebitda_category` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Category');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Account Effective Date');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `fasb_asc842_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Accounting Standards Board (FASB) ASC 842 Lease Accounting Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `ffo_classification` SET TAGS ('dbx_business_glossary_term' = 'Funds From Operations (FFO) Classification');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `ffo_classification` SET TAGS ('dbx_value_regex' = 'included|excluded|affo_adjustment');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_line` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Line Item');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Level');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `ifrs16_flag` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) 16 Leases Mapping Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Account Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `is_posting_account` SET TAGS ('dbx_business_glossary_term' = 'Posting Account Indicator');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `mri_account_code` SET TAGS ('dbx_business_glossary_term' = 'MRI Software Account Code');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `mri_account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,30}$');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `noi_category` SET TAGS ('dbx_business_glossary_term' = 'Net Operating Income (NOI) Category');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `noi_category` SET TAGS ('dbx_value_regex' = 'potential_gross_income|vacancy_loss|effective_gross_income|operating_expense|net_operating_income|below_noi');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `normal_balance` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance Side');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `normal_balance` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_account_code` SET TAGS ('dbx_business_glossary_term' = 'Parent General Ledger (GL) Account Code');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `parent_account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `profit_center_relevant` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Relevant Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|sap_s4hana|mri_software|manual');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Internal Control Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `yardi_account_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Account Code');
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `yardi_account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,30}$');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'ledger_control');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity ID');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `argus_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Argus Enterprise Entity Code');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `aum_usd` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) in USD');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `aum_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_value_regex' = 'full|proportional|equity|cost|not_consolidated');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Entity Dissolution Date');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `ein` SET TAGS ('dbx_business_glossary_term' = 'Employer Identification Number (EIN)');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `ein` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `ein` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `ein` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Status');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|dissolved|pending_formation|suspended');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_subtype` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Subtype');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_end_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Month');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `formation_date` SET TAGS ('dbx_business_glossary_term' = 'Entity Formation Date');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `gl_company_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Company Code');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `gl_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `is_reit_elected` SET TAGS ('dbx_business_glossary_term' = 'Real Estate Investment Trust (REIT) Election Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `is_sec_reporting` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Reporting Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `is_sox_in_scope` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) In-Scope Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `is_variable_interest_entity` SET TAGS ('dbx_business_glossary_term' = 'Variable Interest Entity (VIE) Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `mri_entity_code` SET TAGS ('dbx_business_glossary_term' = 'MRI Software Entity Code');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `nav_usd` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) in USD');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `nav_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_city` SET TAGS ('dbx_business_glossary_term' = 'Registered Address City');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Country');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Postal Code');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_state` SET TAGS ('dbx_business_glossary_term' = 'Registered Address State');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Registered Agent Name');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_agent_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `state_registration_number` SET TAGS ('dbx_business_glossary_term' = 'State Registration Number');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `state_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `state_tax_nexus` SET TAGS ('dbx_business_glossary_term' = 'State Tax Nexus Jurisdictions');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_classification` SET TAGS ('dbx_value_regex' = 'corporation|partnership|disregarded_entity|s_corporation|trust');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_year_end_month` SET TAGS ('dbx_business_glossary_term' = 'Tax Year End Month');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Name (DBA)');
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ALTER COLUMN `yardi_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Entity Code');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'ledger_control');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Period ID');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger ID');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `nav_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Nav Calculation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Property Sale Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `rent_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rent Schedule Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_entry_journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Journal Entry ID');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|posted|reversed');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Number');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(0[1-9]|1[0-2]|13|14|15|16)$');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Total Credit Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Total Debit Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_debit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `header_text` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Header Text');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Partner Code');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `is_balanced` SET TAGS ('dbx_business_glossary_term' = 'Is Balanced Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Is Intercompany Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `noi_category` SET TAGS ('dbx_business_glossary_term' = 'Net Operating Income (NOI) Category');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `noi_category` SET TAGS ('dbx_value_regex' = 'revenue|operating_expense|capex|below_noi|non_operating');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|sap_s4hana|mri_software|argus_enterprise|manual');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'ledger_control');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `original_line_journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Original Line ID');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cam_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `intercompany_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Partner Code');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `internal_order_code` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Code');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Line Type');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'standard|accrual|reversal|adjustment|intercompany|elimination');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `noi_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Operating Income (NOI) Inclusion Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `opex_capex_indicator` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) / Capital Expenditure (CAPEX) Indicator');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `opex_capex_indicator` SET TAGS ('dbx_value_regex' = 'OPEX|CAPEX');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posted_by` SET TAGS ('dbx_business_glossary_term' = 'Posted By');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_amount` SET TAGS ('dbx_business_glossary_term' = 'Posting Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|parked|held|cleared');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center (PC) Code');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Yardi Voyager|SAP S/4HANA|MRI Software|Manual');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Property Inspection Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Cleared Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Expense Category');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Invoice Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `is_void` SET TAGS ('dbx_business_glossary_term' = 'Is Void Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|wire|virtual_card|eft');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `service_period_end` SET TAGS ('dbx_business_glossary_term' = 'Service Period End Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `service_period_start` SET TAGS ('dbx_business_glossary_term' = 'Service Period Start Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|sap_s4hana');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `source_system_invoice_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Invoice ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `vendor_invoice_ref` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Reference');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Void Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ALTER COLUMN `void_reason` SET TAGS ('dbx_value_regex' = 'duplicate|incorrect_amount|incorrect_vendor|cancelled_service|data_entry_error|other');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Payment ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Trace Number');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|auto_approved');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Cleared Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `discount_taken_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Expense Category');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `is_1099_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is 1099 Reportable Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `is_partial_payment` SET TAGS ('dbx_business_glossary_term' = 'Is Partial Payment Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Is Voided Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_memo` SET TAGS ('dbx_business_glossary_term' = 'Payment Memo');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|wire|virtual_card|eft');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|issued|cleared|voided|stopped|returned');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'vendor_payment|ti_allowance|construction_draw|security_deposit_refund|owner_distribution|corporate_payable');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `positive_pay_submitted` SET TAGS ('dbx_business_glossary_term' = 'Positive Pay Submitted Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `remittance_advice_number` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Number');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|sap_s4hana|mri_software');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `source_system_payment_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Payment ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Void Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Reference Number');
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `amenity_id` SET TAGS ('dbx_business_glossary_term' = 'Amenity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `cam_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Cam Schedule Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `notice_id` SET TAGS ('dbx_business_glossary_term' = 'Notice Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `occupancy_id` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `rent_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rent Schedule Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `applied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `applied_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `bank_deposit_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Deposit Reference');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `breakpoint_amount` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Breakpoint Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `breakpoint_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `breakpoint_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `cam_reconciliation_year` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Reconciliation Year');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `credit_memo_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Reference Number');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute Reason');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|open|partially_paid|paid|void|disputed');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `late_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Rate');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `nsf_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Sufficient Funds (NSF) Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|check|wire|credit_card|cash|other');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `percentage_rent_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Tenant Sales Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `percentage_rent_sales_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `percentage_rent_sales_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `post_date` SET TAGS ('dbx_business_glossary_term' = 'GL Post Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Posted Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|mri_software|manual');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `source_system_invoice_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Invoice ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `ar_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Receipt ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'AR Invoice ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `cam_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Cam Schedule Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `occupancy_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Occupancy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `original_receipt_ar_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Original Receipt ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `rent_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rent Schedule Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `applied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `applied_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `bank_deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Deposit Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `bank_deposit_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Deposit Reference');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `income_category` SET TAGS ('dbx_business_glossary_term' = 'Income Category');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `is_nsf` SET TAGS ('dbx_business_glossary_term' = 'Non-Sufficient Funds (NSF) Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `is_prepayment` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `is_security_deposit` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `nsf_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Sufficient Funds (NSF) Return Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|wire|credit_card|cash|eft');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `posted_by` SET TAGS ('dbx_business_glossary_term' = 'Posted By User');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'GL Posting Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `receipt_notes` SET TAGS ('dbx_business_glossary_term' = 'Receipt Notes');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^RCP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'posted|unposted|reversed|nsf|on_account|voided');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_business_glossary_term' = 'Receipt Type');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_value_regex' = 'rent|security_deposit|cam_reconciliation|late_fee|miscellaneous|prepayment');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `received_amount` SET TAGS ('dbx_business_glossary_term' = 'Received Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `received_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `received_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `remittance_advice_number` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Number');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|sap_s4hana|mri_software|manual');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `source_system_receipt_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Receipt ID');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `account_category` SET TAGS ('dbx_business_glossary_term' = 'GL Account Category');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `account_category` SET TAGS ('dbx_value_regex' = 'revenue|opex|capex|debt_service|reserve');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'operating|capital|reforecast|cash_flow|leasing');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `cam_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `capex_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Category');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `capex_category` SET TAGS ('dbx_value_regex' = 'tenant_improvement|building_improvement|equipment|land|other');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective From Date');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective To Date');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `finance_budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `finance_budget_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|locked|archived|rejected');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Budget Consolidated Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Budget Locked Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `noi_category` SET TAGS ('dbx_business_glossary_term' = 'Net Operating Income (NOI) Category');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `noi_category` SET TAGS ('dbx_value_regex' = 'pgi|egi|goi|noi_above|noi_below|non_operating');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Type');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Budget Prepared By');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `prior_year_actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Actual Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `prior_year_actual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|sap_s4hana|argus_enterprise|manual');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Submission Date');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `version_label` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Label');
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `cam_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Cam Schedule Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `rent_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rent Schedule Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|psf|pro_rata|sqm|headcount|manual');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Approval Date');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'revenue|opex|capex|noi|debt_service|reserve');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_scenario` SET TAGS ('dbx_business_glossary_term' = 'Budget Scenario');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_scenario` SET TAGS ('dbx_value_regex' = 'base|optimistic|conservative|stress');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,20}$');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `is_cam_recoverable` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Recoverable Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `is_capex` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Code');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Number');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|locked|superseded');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Type');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'income|expense|transfer|reserve|adjustment');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `noi_component` SET TAGS ('dbx_business_glossary_term' = 'Net Operating Income (NOI) Component');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `noi_component` SET TAGS ('dbx_value_regex' = 'pgi|egi|goi|noi|ebitda|excluded');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `prior_year_actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Actual Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `prior_year_actual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `revised_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `revised_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi|sap|argus|mri|manual');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `source_system_line_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Line ID');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `noi_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Net Operating Income (NOI) Statement ID');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `market_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Market Survey Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `administrative_expense` SET TAGS ('dbx_business_glossary_term' = 'Administrative Expense');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `administrative_expense` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `cam_recovery` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Recovery');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `cam_recovery` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `cap_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Rate (CAP Rate) Applied');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `capex_reserve` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Reserve');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `capex_reserve` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `concessions` SET TAGS ('dbx_business_glossary_term' = 'Concessions');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `concessions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `credit_loss` SET TAGS ('dbx_business_glossary_term' = 'Credit Loss');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `credit_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `debt_service` SET TAGS ('dbx_business_glossary_term' = 'Debt Service');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `debt_service` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `dscr` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Coverage Ratio (DSCR)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `dscr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `egi` SET TAGS ('dbx_business_glossary_term' = 'Effective Gross Income (EGI)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `egi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `gla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Gross Leasable Area (GLA) in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `implied_property_value` SET TAGS ('dbx_business_glossary_term' = 'Implied Property Value');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `implied_property_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `insurance_expense` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expense');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `insurance_expense` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated Statement');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `leasing_commission_expense` SET TAGS ('dbx_business_glossary_term' = 'Leasing Commission Expense');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `leasing_commission_expense` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `management_fee_expense` SET TAGS ('dbx_business_glossary_term' = 'Property Management Fee Expense');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `management_fee_expense` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `management_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Property Management Fee Rate');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `noi` SET TAGS ('dbx_business_glossary_term' = 'Net Operating Income (NOI)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `noi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `noi_psf` SET TAGS ('dbx_business_glossary_term' = 'Net Operating Income Per Square Foot (NOI PSF)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `noi_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Statement Notes');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `occupancy_rate` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Rate');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `period_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Frequency');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `period_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|year_to_date|trailing_12_months');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `pgi` SET TAGS ('dbx_business_glossary_term' = 'Potential Gross Income (PGI)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `pgi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `property_tax_expense` SET TAGS ('dbx_business_glossary_term' = 'Property Tax Expense');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `property_tax_expense` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `repairs_maintenance_expense` SET TAGS ('dbx_business_glossary_term' = 'Repairs and Maintenance (R&M) Expense');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `repairs_maintenance_expense` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `restatement_reason` SET TAGS ('dbx_business_glossary_term' = 'Restatement Reason');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|mri_software|argus_enterprise|sap_s4hana|manual');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'NOI Statement Number');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_value_regex' = '^NOI-[0-9]{4}-[0-9]{2}-[A-Z0-9]{4,20}$');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'NOI Statement Status');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|published|restated|voided');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'NOI Statement Type');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_value_regex' = 'actual|budget|forecast|reforecast|prior_year_actual');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `ti_allowance` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `ti_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `total_operating_expenses` SET TAGS ('dbx_business_glossary_term' = 'Total Operating Expenses (OPEX)');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `total_operating_expenses` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `utilities_expense` SET TAGS ('dbx_business_glossary_term' = 'Utilities Expense');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `utilities_expense` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `vacancy_loss` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Loss');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `vacancy_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ALTER COLUMN `vacancy_rate` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Rate');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_financing');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `amenity_type_id` SET TAGS ('dbx_business_glossary_term' = 'Amenity Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `green_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Green Certification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `construction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `floor_id` SET TAGS ('dbx_business_glossary_term' = 'Floor Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_location` SET TAGS ('dbx_business_glossary_term' = 'Asset Location');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'in_service|under_construction|disposed|impaired|transferred|retired');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_sub_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Sub-Class');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `book_tax_difference` SET TAGS ('dbx_business_glossary_term' = 'Book-Tax Depreciation Difference');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `book_tax_difference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_convention` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Convention');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_convention` SET TAGS ('dbx_value_regex' = 'half_year|mid_month|mid_quarter|full_month');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|sum_of_years_digits|units_of_production|macrs|no_depreciation');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sale|scrap|donation|transfer|write_off|trade_in');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_test_date` SET TAGS ('dbx_business_glossary_term' = 'Impairment Test Date');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insured_value` SET TAGS ('dbx_business_glossary_term' = 'Insured Value');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insured_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `leed_certified` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certified');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|sap_s4hana|procore|manual');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `source_system_asset_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Asset ID');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Depreciation Method');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_value_regex' = 'macrs|ads|straight_line|bonus_depreciation|section_179|no_depreciation');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Tax Useful Life (Years)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `ytd_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Depreciation');
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ALTER COLUMN `ytd_depreciation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'asset_financing');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number (Masked)');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_value_regex' = '^[X*]{4,12}[0-9]{4}$');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `account_purpose` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Purpose');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|frozen|closed|pending_approval');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'operating|escrow|security_deposit|reserve|payroll|construction');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `ach_enabled` SET TAGS ('dbx_business_glossary_term' = 'ACH (Automated Clearing House) Enabled Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `balance_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Balance As-Of Date');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Address');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number (ABA)');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_statement_delivery` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Delivery Method');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_statement_delivery` SET TAGS ('dbx_value_regex' = 'electronic|paper|both');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Account Balance');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `dual_signature_required` SET TAGS ('dbx_business_glossary_term' = 'Dual Signature Required Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `house_bank_code` SET TAGS ('dbx_business_glossary_term' = 'House Bank Code');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Account Interest Rate');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Account Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `last_reconciled_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciled Date');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `lockbox_number` SET TAGS ('dbx_business_glossary_term' = 'Lockbox Number');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `minimum_balance` SET TAGS ('dbx_business_glossary_term' = 'Minimum Required Balance');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `minimum_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `positive_pay_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Positive Pay Enrolled Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `ref` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Reference Code');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'SWIFT / BIC Code');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `wire_transfer_enabled` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Enabled Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ALTER COLUMN `yardi_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Bank Account ID');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` SET TAGS ('dbx_subdomain' = 'asset_financing');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `debt_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument ID');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `lender_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `title_record_id` SET TAGS ('dbx_business_glossary_term' = 'Title Record Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `amortization_period_months` SET TAGS ('dbx_business_glossary_term' = 'Amortization Period (Months)');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `amortization_type` SET TAGS ('dbx_business_glossary_term' = 'Amortization Type');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `amortization_type` SET TAGS ('dbx_value_regex' = 'fully_amortizing|interest_only|partial_amortization|balloon');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `cross_collateralized` SET TAGS ('dbx_business_glossary_term' = 'Cross-Collateralized Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `debt_issuance_costs` SET TAGS ('dbx_business_glossary_term' = 'Debt Issuance Costs');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `debt_issuance_costs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `dscr_covenant_threshold` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Coverage Ratio (DSCR) Covenant Threshold');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `dscr_covenant_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `escrow_required` SET TAGS ('dbx_business_glossary_term' = 'Escrow Required Flag');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `extended_maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Maturity Date');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `guarantor_name` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Name');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `guarantor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `instrument_status` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument Status');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `instrument_status` SET TAGS ('dbx_value_regex' = 'active|paid_off|in_default|in_foreclosure|refinanced|cancelled');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument Type');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'mortgage|construction_loan|mezzanine_debt|cmbs|credit_facility|bridge_loan');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `interest_only_end_date` SET TAGS ('dbx_business_glossary_term' = 'Interest-Only Period End Date');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `interest_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `loan_number` SET TAGS ('dbx_business_glossary_term' = 'Loan Number');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `loan_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `loan_term_months` SET TAGS ('dbx_business_glossary_term' = 'Loan Term (Months)');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `ltv_covenant_threshold` SET TAGS ('dbx_business_glossary_term' = 'LTV Covenant Threshold');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `ltv_covenant_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value Ratio (LTV)');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Maturity Date');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `next_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Payment Due Date');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `original_principal` SET TAGS ('dbx_business_glossary_term' = 'Original Principal Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `original_principal` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `origination_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Origination Date');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `origination_fee` SET TAGS ('dbx_business_glossary_term' = 'Loan Origination Fee');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `origination_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Principal Balance');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `prepayment_lockout_end_date` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Lockout End Date');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `prepayment_penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Penalty Type');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `prepayment_penalty_type` SET TAGS ('dbx_value_regex' = 'none|step_down|yield_maintenance|defeasance|lockout');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `rate_index` SET TAGS ('dbx_business_glossary_term' = 'Rate Index');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `rate_index` SET TAGS ('dbx_value_regex' = 'SOFR|LIBOR|Prime|EURIBOR|Treasury|SONIA');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `rate_spread` SET TAGS ('dbx_business_glossary_term' = 'Rate Spread Over Index');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Type');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'fixed|variable|hybrid');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `recourse_type` SET TAGS ('dbx_business_glossary_term' = 'Recourse Type');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `recourse_type` SET TAGS ('dbx_value_regex' = 'full_recourse|non_recourse|partial_recourse');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `scheduled_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Payment Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `scheduled_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `servicer_name` SET TAGS ('dbx_business_glossary_term' = 'Loan Servicer Name');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `servicer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Yardi Voyager|SAP S/4HANA|MRI Software|Argus Enterprise');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `source_system_loan_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Loan ID');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` SET TAGS ('dbx_subdomain' = 'asset_financing');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `debt_service_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Payment ID');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `debt_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Facility Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `debt_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument ID');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `lender_id` SET TAGS ('dbx_business_glossary_term' = 'Lender ID');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `actual_escrow_paid` SET TAGS ('dbx_business_glossary_term' = 'Actual Escrow Paid');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `actual_interest_paid` SET TAGS ('dbx_business_glossary_term' = 'Actual Interest Paid');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `actual_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `actual_principal_paid` SET TAGS ('dbx_business_glossary_term' = 'Actual Principal Paid');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|voided');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `covenant_breach_type` SET TAGS ('dbx_business_glossary_term' = 'Covenant Breach Type');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `covenant_breach_type` SET TAGS ('dbx_value_regex' = 'missed_payment|dscr_violation|ltv_violation|late_payment|none');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `interest_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Applied');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `is_covenant_breach` SET TAGS ('dbx_business_glossary_term' = 'Covenant Breach Indicator');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `outstanding_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Loan Balance After Payment');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `outstanding_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Loan Balance Before Payment');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|direct_debit|internal_transfer');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `payment_period_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Period Number');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'GL Posting Date');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `prepayment_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Penalty Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Type');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'fixed|variable|hybrid');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `scheduled_escrow_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Escrow Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `scheduled_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Interest Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `scheduled_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Payment Date');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `scheduled_principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Principal Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|sap_s4hana|mri_software|argus_enterprise|manual');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `source_system_payment_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Payment ID');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `total_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Amount');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ALTER COLUMN `wire_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Wire Confirmation Number');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `amended_purchase_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Identifier');
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ALTER COLUMN `reprocessed_payment_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` SET TAGS ('dbx_subdomain' = 'asset_financing');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `lender_id` SET TAGS ('dbx_business_glossary_term' = 'Lender Identifier');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `parent_lender_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `federal_reserve_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `lending_capacity_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `swift_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ALTER COLUMN `typical_interest_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` SET TAGS ('dbx_subdomain' = 'ledger_control');
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Identifier');
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`finance`.`reporting_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`finance`.`reporting_period` SET TAGS ('dbx_subdomain' = 'ledger_control');
ALTER TABLE `real_estate_ecm`.`finance`.`reporting_period` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Identifier');
ALTER TABLE `real_estate_ecm`.`finance`.`reporting_period` ALTER COLUMN `primary_prior_reporting_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
