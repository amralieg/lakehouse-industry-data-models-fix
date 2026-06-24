-- Schema for Domain: finance | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 03:51:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`finance` COMMENT 'Core financial management including general ledger, accounts payable, accounts receivable, cost center accounting, and financial reporting. Manages CapEx (Capital Expenditure) tracking, budget planning, FY (Fiscal Year) close, EBITDA reporting, profitability analysis by vehicle line/plant/region, and intercompany settlements. Tracks manufacturing cost (material, labor, overhead), warranty reserves, and inventory valuation. Supports SOX compliance, IFRS/GAAP reporting. Integrates with SAP FI/CO.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'System-generated unique identifier for the GL account record.',
    `account_code` STRING COMMENT 'External business code used to identify the GL account in the chart of accounts.',
    `account_group` STRING COMMENT 'Higher‑level grouping used for reporting and posting rules.',
    `account_name` STRING COMMENT 'Human‑readable name or title of the GL account.',
    `account_type` STRING COMMENT 'Classification of the account as asset, liability, equity, revenue, or expense.. Valid values are `asset|liability|equity|revenue|expense`',
    `balance_type` STRING COMMENT 'Indicates whether the account is reported on the balance sheet or the profit & loss statement.. Valid values are `profit_and_loss|balance_sheet`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget amount allocated to the account for the fiscal year, expressed in the account currency.',
    `chart_of_accounts_version` STRING COMMENT 'Version identifier of the chart of accounts in which this account is defined.',
    `closing_balance` DECIMAL(18,2) COMMENT 'Balance of the account at the end of the fiscal year.',
    `cost_center_code` STRING COMMENT 'Code of the cost center to which the account is assigned for internal cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the GL account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code in which the account balances are expressed.',
    `gl_account_description` STRING COMMENT 'Free‑form description providing additional context about the account.',
    `effective_from` DATE COMMENT 'Date on which the GL account becomes active for posting.',
    `effective_to` DATE COMMENT 'Date on which the GL account is retired or becomes inactive; null if open‑ended.',
    `fiscal_year` STRING COMMENT 'Fiscal year (FY) to which the account is primarily associated for budgeting.',
    `gl_account_status` STRING COMMENT 'Current lifecycle status of the account.. Valid values are `active|inactive|blocked|pending`',
    `is_budgeted` BOOLEAN COMMENT 'True if the account has an associated budget for the fiscal year.',
    `is_consolidation_account` BOOLEAN COMMENT 'Indicates whether the account participates in legal entity consolidation reporting.',
    `is_deprecated` BOOLEAN COMMENT 'True if the account is scheduled for phase‑out and should no longer be used for new postings.',
    `is_reconciliation_account` BOOLEAN COMMENT 'True if the account is used as a reconciliation (clearing) account for sub‑ledger postings.',
    `is_tax_relevant` BOOLEAN COMMENT 'Indicates whether the account participates in tax calculations.',
    `last_posting_date` DATE COMMENT 'Date of the most recent posting to this GL account.',
    `last_reconciliation_date` DATE COMMENT 'Date when the account was last reconciled with sub‑ledger balances.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Balance of the account at the start of the fiscal year.',
    `profit_center_code` STRING COMMENT 'Code of the profit center linked to the account for profitability reporting.',
    `reporting_level` STRING COMMENT 'Level in the reporting hierarchy at which the account is aggregated.. Valid values are `company|division|plant|region|country`',
    `segment` STRING COMMENT 'Business segment to which the account belongs (e.g., OEM, Aftermarket, Service, R&D).. Valid values are `OEM|Aftermarket|Service|R&D`',
    `tax_category` STRING COMMENT 'Category defining the tax treatment applied to postings in this account.. Valid values are `taxable|exempt|zero|reverse`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the GL account record.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'General Ledger (GL) account master record aligned with SAP FI chart of accounts. Defines each account in the corporate chart of accounts including account type (asset, liability, equity, revenue, expense), account group, P&L vs balance sheet classification, currency, tax category, and reconciliation account flags. SSOT for all GL account definitions used across FI/CO postings, IFRS/GAAP reporting, and SOX compliance controls.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique surrogate key for the cost center master record.',
    `parent_cost_center_id` BIGINT COMMENT 'Identifier of the immediate parent cost center in the hierarchy (null for top‑level).',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant to which the cost center is assigned.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Cumulative actual expenses posted to the cost center.',
    `allocation_method` STRING COMMENT 'Method used to allocate indirect costs to the cost center.. Valid values are `fixed|percentage|activity_based|none`',
    `approval_status` STRING COMMENT 'Current approval state of the cost centers budget.. Valid values are `pending|approved|rejected`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned budget amount allocated to the cost center for the fiscal year.',
    `cost_center_category` STRING COMMENT 'Higher‑level classification of the cost center for reporting purposes.. Valid values are `cost_center|profit_center|investment_center`',
    `cost_center_code` STRING COMMENT 'External business code assigned to the cost center (e.g., SAP CO cost center code).',
    `cost_center_status` STRING COMMENT 'Current operational status of the cost center.. Valid values are `active|inactive|planned|closed`',
    `cost_center_type` STRING COMMENT 'Category of the cost center indicating its primary function within the organization.. Valid values are `production|administration|research|sales|service`',
    `country` STRING COMMENT 'Three‑letter ISO country code of the cost centers primary location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost center record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code used for budgeting and reporting.. Valid values are `^[A-Z]{3}$`',
    `cost_center_description` STRING COMMENT 'Free‑form description of the cost center purpose and scope.',
    `effective_from` DATE COMMENT 'Date when the cost center becomes valid for posting costs.',
    `effective_to` DATE COMMENT 'Date when the cost center is retired or no longer valid (nullable).',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the budget is defined (e.g., FY2025).',
    `hierarchy_level` STRING COMMENT 'Depth of the cost center within the organizational hierarchy (1 = top level).',
    `last_review_date` DATE COMMENT 'Date when the cost centers budget and performance were last reviewed.',
    `cost_center_name` STRING COMMENT 'Human‑readable name of the cost center used in reports and UI.',
    `region` STRING COMMENT 'Business region (e.g., North America, Europe) where the cost center operates.',
    `reporting_level` STRING COMMENT 'Level at which the cost center is aggregated for financial reporting.. Valid values are `plant|division|global`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cost center record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between budgeted and actual spend (budget – actual).',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Cost center master record representing an organizational unit to which manufacturing costs, labor, overhead, and indirect expenses are assigned. Aligned with SAP CO cost center accounting (CCA). Captures cost center hierarchy, responsible manager, plant assignment, profit center linkage, valid-from/to dates, currency, and cost center category (production, administration, R&D, sales). Supports EBITDA reporting and profitability analysis by plant, vehicle line, and region.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique surrogate key for the profit center record.',
    `employee_id` BIGINT COMMENT 'Surrogate key of the employee who owns the profit center.',
    `owner_id` BIGINT COMMENT 'Surrogate key of the employee who owns the profit center.',
    `parent_profit_center_id` BIGINT COMMENT 'Identifier of the immediate parent profit center in the hierarchy.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant associated with the profit center.',
    `primary_profit_manager_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `profit_employee_id` BIGINT COMMENT 'Surrogate key of the employee responsible for the profit center.',
    `actual_amount` DECIMAL(18,2) COMMENT 'Actual realized amount for the profit center in the current period.',
    `audit_trail` STRING COMMENT 'JSON‑encoded log of significant changes to the profit center record.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget for the profit center for the fiscal year.',
    `profit_center_category` STRING COMMENT 'High‑level category such as Vehicle Line, Service, Parts, or Finance.',
    `closure_date` DATE COMMENT 'Date on which the profit center was officially closed.',
    `profit_center_code` STRING COMMENT 'Business identifier code used in SAP and external reports.',
    `company_code` STRING COMMENT 'SAP company code to which the profit center belongs.',
    `compliance_status` STRING COMMENT 'Current compliance status with internal and external regulatory requirements.. Valid values are `Compliant|NonCompliant|Pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the profit center record was first created.',
    `currency_code` STRING COMMENT 'Currency in which the profit center records its transactions.. Valid values are `^[A-Z]{3}$`',
    `profit_center_description` STRING COMMENT 'Free‑form description of the profit centers purpose and scope.',
    `ebitda_amount` DECIMAL(18,2) COMMENT 'Earnings before interest, taxes, depreciation, and amortization for the profit center.',
    `effective_from` DATE COMMENT 'Date when the profit center became operational.',
    `effective_to` DATE COMMENT 'Date when the profit center is scheduled to be retired (nullable for open‑ended).',
    `external_reference` STRING COMMENT 'Identifier used in external ERP or reporting systems to reference this profit center.',
    `hierarchy_path` STRING COMMENT 'Slash‑delimited path showing the profit centers position in the hierarchy (e.g., /1000/2000/3000).',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the profit center is included in corporate consolidation.',
    `is_intercompany` BOOLEAN COMMENT 'True if the profit center participates in intercompany transactions.',
    `last_review_date` DATE COMMENT 'Date of the most recent financial or operational review.',
    `profit_center_level` STRING COMMENT 'Numeric depth of the profit center within the organizational hierarchy.',
    `margin_percent` DECIMAL(18,2) COMMENT 'Profit margin expressed as a percentage of revenue.',
    `profit_center_name` STRING COMMENT 'Human‑readable name of the profit center.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the profit center.',
    `owner` STRING COMMENT 'Name of the business owner or sponsor of the profit center.',
    `plan_amount` DECIMAL(18,2) COMMENT 'Planned financial amount for the upcoming period.',
    `profit_center_group` STRING COMMENT 'Logical grouping used for internal reporting (e.g., Group A, Group B).',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center.. Valid values are `Active|Inactive|Planned|Closed`',
    `profit_center_type` STRING COMMENT 'Category of profit center indicating its accounting purpose.. Valid values are `Legal|Operating|Reporting`',
    `region_code` STRING COMMENT 'Three‑letter code representing the geographic region of the profit center.. Valid values are `NA|EU|APAC|LATAM|MEA`',
    `reporting_currency` STRING COMMENT 'Currency used for consolidated financial reporting of the profit center.. Valid values are `^[A-Z]{3}$`',
    `review_cycle` STRING COMMENT 'Frequency of scheduled reviews for the profit center.. Valid values are `Annual|Quarterly`',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the profit center based on financial and operational exposure.. Valid values are `Low|Medium|High`',
    `segment` STRING COMMENT 'Segment classification of the profit center (e.g., electric vehicle, internal combustion, hybrid, commercial).. Valid values are `EV|ICE|HEV|PHEV|Commercial|Luxury`',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status of the profit center.',
    `updated_by` STRING COMMENT 'User identifier of the person who performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the profit center record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Profit center master record representing a management accounting unit used to analyze profitability by vehicle line, plant, region, or business segment. Aligned with SAP CO-PCA (Profit Center Accounting). Captures profit center hierarchy, responsible manager, company code assignment, segment classification (EV, ICE, HEV, commercial), and reporting currency. Enables contribution margin and EBITDA analysis at granular business unit level.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`company_code` (
    `company_code_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying the company code record.',
    `intercompany_group_id` BIGINT COMMENT 'Identifier of the intercompany settlement group to which the entity belongs.',
    `address_line1` STRING COMMENT 'Primary street address of the legal entity.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `business_line` STRING COMMENT 'Primary business line or functional area of the entity. [ENUM-REF-CANDIDATE: design_engineering|manufacturing|sales|after_sales|r&d|finance|procurement — 7 candidates stripped; promote to reference product]',
    `chart_of_accounts` STRING COMMENT 'Identifier of the chart of accounts used for financial posting.',
    `city` STRING COMMENT 'City where the legal entity is located.',
    `company_code` STRING COMMENT 'Alphanumeric identifier used in SAP FI to represent the legal entity (e.g., US01, DE02).',
    `company_code_status` STRING COMMENT 'Current operational status of the legal entity.. Valid values are `active|inactive|closed|pending`',
    `consolidation_group` STRING COMMENT 'Group identifier used for legal consolidation of financial statements.',
    `cost_center_code` STRING COMMENT 'Cost center identifier for internal cost allocation.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the legal entity is incorporated.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the company code record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the company code ceases to be effective (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date on which the company code becomes effective for accounting.',
    `email_address` STRING COMMENT 'Primary email address for corporate communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `entity_type` STRING COMMENT 'Classification of the legal entity within the corporate structure.. Valid values are `legal_entity|joint_venture|subsidiary|branch|holding`',
    `fiscal_year_variant` STRING COMMENT 'SAP fiscal year variant code defining the fiscal calendar for the entity.. Valid values are `FY01|FY02|FY03|FY04|FY05|FY06`',
    `functional_currency` STRING COMMENT 'Currency in which the entitys internal transactions are recorded.. Valid values are `^[A-Z]{3}$`',
    `industry_sector` STRING COMMENT 'Broad industry segment in which the entity operates.. Valid values are `passenger_vehicles|commercial_vehicles|components|services|software`',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the entity is included in group consolidation.',
    `legal_name` STRING COMMENT 'Full legal name of the company as registered with the jurisdiction.',
    `lifecycle_status` STRING COMMENT 'Lifecycle stage of the entity (e.g., active, suspended, terminated, draft).',
    `local_currency` STRING COMMENT 'ISO 4217 currency code of the entitys functional currency for local reporting.. Valid values are `^[A-Z]{3}$`',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the legal entity.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the entitys address.. Valid values are `^[A-Z0-9]{3,10}$`',
    `profit_center_code` STRING COMMENT 'Code of the profit center to which the entity reports.',
    `registration_number` STRING COMMENT 'Official registration number assigned by the corporate registry.',
    `reporting_standard` STRING COMMENT 'Accounting framework used for statutory reporting (e.g., IFRS, US GAAP).. Valid values are `IFRS|GAAP|IFRS_FOR_SME|US_GAAP|EU_GAAP`',
    `segment` STRING COMMENT 'Segment (global, regional, local) used in management reporting.',
    `short_name` STRING COMMENT 'Abbreviated or commonly used name for the legal entity.',
    `state_province` STRING COMMENT 'State or province of the entitys address.',
    `tax_id_number` STRING COMMENT 'Government‑issued tax identifier for the legal entity.',
    `tax_jurisdiction_code` STRING COMMENT 'Code representing the tax jurisdiction applicable to the entity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the company code record.',
    `website_url` STRING COMMENT 'Public website URL of the legal entity.',
    CONSTRAINT pk_company_code PRIMARY KEY(`company_code_id`)
) COMMENT 'Legal entity and company code master record representing an independent accounting unit within the Automotive enterprise. Aligned with SAP FI company code configuration. Captures legal entity name, country of incorporation, fiscal year variant, chart of accounts assignment, local currency, functional currency, IFRS/GAAP reporting standard, tax jurisdiction, and intercompany settlement group. Supports multi-entity consolidation and intercompany eliminations.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` (
    `fiscal_period_id` BIGINT COMMENT 'System-generated unique identifier for the fiscal period record.',
    `accrual_cutoff_date` DATE COMMENT 'Date after which accruals are no longer allowed for this period.',
    `company_code` STRING COMMENT 'Organizational code of the legal entity to which the period applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the fiscal period record was initially created in the system.',
    `fiscal_period_description` STRING COMMENT 'Optional free‑text notes describing special characteristics of the period.',
    `fiscal_period_status` STRING COMMENT 'Current lifecycle status of the period used for posting: open, closed, or locked.. Valid values are `open|closed|locked`',
    `fiscal_year` STRING COMMENT 'Four‑digit calendar year to which the period belongs, e.g., 2024.',
    `fiscal_year_variant` STRING COMMENT 'Identifier for the fiscal year variant configuration (e.g., 12‑month, 4‑quarter, 13‑period).',
    `is_current_period` BOOLEAN COMMENT 'True if this period is the active period for ongoing postings.',
    `is_interim` BOOLEAN COMMENT 'Indicates whether the period is an interim reporting period (true) or a full fiscal period (false).',
    `lock_date` DATE COMMENT 'Date on which the period was locked for posting; null if not locked.',
    `period_end_date` DATE COMMENT 'Last calendar date of the fiscal period.',
    `period_name` STRING COMMENT 'Human‑readable label for the period, e.g., "January", "Q1", "Special Adjustment".',
    `period_number` STRING COMMENT 'Sequential number of the period within the fiscal year (1‑12 for monthly, 1‑4 for quarterly).',
    `period_start_date` DATE COMMENT 'First calendar date of the fiscal period.',
    `period_type` STRING COMMENT 'Classification of the period: regular reporting, adjustment, or special period.. Valid values are `regular|adjustment|special`',
    `posting_deadline_date` DATE COMMENT 'Final date by which all transactions must be posted to this period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the fiscal period record.',
    CONSTRAINT pk_fiscal_period PRIMARY KEY(`fiscal_period_id`)
) COMMENT 'Fiscal period and fiscal year (FY) calendar reference master defining the financial reporting periods used across the enterprise. Captures fiscal year, period number, period name, start date, end date, period status (open, closed, locked), period type (regular, special/adjustment), and company code applicability. Governs FY close processes, period-end accruals, and IFRS/GAAP reporting windows. Aligned with SAP FI fiscal year variant configuration.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Replace string company_code with FK to company_code for proper relational integrity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Reference cost_center master instead of free‑text code.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Link journal entry to fiscal period master for consistent period handling.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that performed the posting.',
    `journal_posting_user_employee_id` BIGINT COMMENT 'Identifier of the user or system that performed the posting.',
    `party_id` BIGINT COMMENT 'Identifier of the business partner (vendor, customer, or other) associated with the entry.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Reference profit_center master for reporting consistency.',
    `amount` DECIMAL(18,2) COMMENT 'Total amount of the journal entry in the document currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the journal entry record was created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the amounts.',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether the line is a debit or credit.. Valid values are `debit|credit`',
    `document_date` DATE COMMENT 'Date recorded on the accounting document (may differ from posting date).',
    `document_language` STRING COMMENT 'Language key of the document (e.g., EN, DE).',
    `document_number` STRING COMMENT 'External document number assigned by SAP FI for the journal entry.',
    `document_type` STRING COMMENT 'Type of accounting document (e.g., SA – General Ledger, KR – Vendor Invoice, AB – Customer Invoice).. Valid values are `SA|KR|AB|DR|CR`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert foreign currency to local currency.',
    `exchange_rate_type` STRING COMMENT 'Type of exchange rate (e.g., M – average, G – spot).',
    `intercompany_indicator` BOOLEAN COMMENT 'True if the entry is part of an intercompany transaction.',
    `is_adjustment` BOOLEAN COMMENT 'Indicates whether the entry is an adjusting entry (e.g., accrual).',
    `is_consolidated` BOOLEAN COMMENT 'True if the entry is part of a consolidated financial statement.',
    `is_manual_entry` BOOLEAN COMMENT 'True if the entry was entered manually rather than by automated process.',
    `is_test_entry` BOOLEAN COMMENT 'True if the entry is a test or simulation record.',
    `journal_entry_status` STRING COMMENT 'Current processing status of the journal entry.. Valid values are `posted|reversed|pending|error`',
    `ledger_group` STRING COMMENT 'Ledger group indicating IFRS or local GAAP ledger.',
    `line_item_count` STRING COMMENT 'Number of line items associated with this journal entry.',
    `plant` STRING COMMENT 'Plant code where the transaction originated.',
    `posting_category` STRING COMMENT 'High‑level category of the posting (e.g., GL, AP, AR).',
    `posting_key` STRING COMMENT 'SAP posting key defining the transaction type (e.g., 40 for debit).',
    `posting_period` STRING COMMENT 'Posting period identifier (e.g., 202401).',
    `posting_reference` STRING COMMENT 'External reference identifier (e.g., external system ID).',
    `posting_text` STRING COMMENT 'User‑defined text describing the posting.',
    `posting_timestamp` TIMESTAMP COMMENT 'Date and time when the entry was posted to the ledger.',
    `posting_user_role` STRING COMMENT 'Role of the user who posted the entry (e.g., accountant, system).',
    `reference_document_number` STRING COMMENT 'Reference number linking to related documents (e.g., invoice).',
    `reversal_document_number` STRING COMMENT 'Document number of the original entry being reversed.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating if the entry is a reversal of a previous entry.',
    `segment` STRING COMMENT 'Segment identifier for internal reporting (e.g., automotive, powertrain).',
    `source_module` STRING COMMENT 'Specific module within the source system (e.g., FI‑GL).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount calculated for the entry.',
    `tax_code` STRING COMMENT 'Tax code applied to the entry for tax determination.',
    `tax_jurisdiction` STRING COMMENT 'Tax jurisdiction code applicable to the entry.',
    `transaction_code` STRING COMMENT 'Code representing the business transaction (e.g., AP, AR).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the journal entry record.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'General ledger journal entry header record capturing all financial postings in the SAP FI ledger. Represents the primary transactional record for every accounting document including goods issue postings, vendor invoice postings, customer payments, accruals, depreciation runs, intercompany settlements, and manual adjustments. Captures document type, posting date, fiscal year/period, company code, reference document, posting user, reversal indicator, and ledger group (IFRS vs local GAAP). SSOT for all GL postings.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'System-generated unique identifier for the journal entry line record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Link line to cost_center master for cost allocation.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Replace string GL account code with FK to gl_account master.',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the parent journal entry (header) to which this line belongs.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Link line to profit_center master for profitability reporting.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Reference WBS element master for project cost tracking.',
    `account_type` STRING COMMENT 'Classification of the GL account (e.g., balance sheet, profit & loss).',
    `amount_cc` DECIMAL(18,2) COMMENT 'Monetary amount posted on the line in the company code (local) currency.',
    `amount_tc` DECIMAL(18,2) COMMENT 'Monetary amount posted on the line in the transaction currency.',
    `assignment` STRING COMMENT 'User‑defined assignment field for additional categorisation (e.g., cost object).',
    `business_area` STRING COMMENT 'Business area classification for reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the journal entry line record was created in the system.',
    `currency_cc` STRING COMMENT 'Three‑letter ISO 4217 code of the company code (local) currency.. Valid values are `[A-Z]{3}`',
    `currency_tc` STRING COMMENT 'Three‑letter ISO 4217 code of the transaction currency.. Valid values are `[A-Z]{3}`',
    `debit_credit_indicator` STRING COMMENT 'Flag indicating whether the line is a debit (D) or credit (C).. Valid values are `D|C`',
    `document_date` DATE COMMENT 'Date printed on the accounting document.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert amount_tc to amount_cc.',
    `exchange_rate_type` STRING COMMENT 'Identifier of the exchange rate type (e.g., M for market, A for average).',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or period code) of the posting.',
    `fiscal_year` STRING COMMENT 'Fiscal year of the posting (e.g., 2024).',
    `line_sequence` STRING COMMENT 'Sequential number of the line within the journal entry, used for ordering.',
    `line_text` STRING COMMENT 'Free‑form description of the line item.',
    `plant` STRING COMMENT 'Manufacturing plant or location code associated with the posting.',
    `posting_date` DATE COMMENT 'Date on which the line is posted to the ledger.',
    `posting_key` STRING COMMENT 'SAP posting key that determines the type of posting (e.g., debit/credit).',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity associated with the line (e.g., number of units, hours).',
    `reference_document_item` STRING COMMENT 'Item number of the referenced external document.',
    `reference_document_number` STRING COMMENT 'External document number referenced by this line (e.g., invoice).',
    `reversal_indicator` BOOLEAN COMMENT 'True if this line reverses a previous posting.',
    `segment` STRING COMMENT 'Segment code for profitability analysis.',
    `tax_code` STRING COMMENT 'Tax code used for tax calculation on the line.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the journal entry line record.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual line item within a GL journal entry, representing a single debit or credit posting to a GL account. Captures GL account, debit/credit indicator, posting amount in transaction currency and company code currency, cost center, profit center, WBS element, plant, tax code, assignment field, and line item text. Supports detailed cost allocation, profitability analysis, and SOX audit trail requirements. Aligned with SAP FI line item table (BSEG).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'System-generated unique identifier for the AP invoice record.',
    `trade_compliance_record_id` BIGINT COMMENT 'Foreign key linking to compliance.trade_compliance_record. Business justification: AP invoices for imported parts must reference the trade compliance record to ensure customs duties and export‑control compliance.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the supplier that issued the invoice.',
    `cost_center_code` STRING COMMENT 'Cost center associated with the invoice for internal accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code of the invoice amount.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early payment or contractual discount applied to the invoice.',
    `due_date` DATE COMMENT 'Date by which payment must be made according to payment terms.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert invoice currency to the reporting currency.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the invoice belongs.. Valid values are `^[0-9]{4}$`',
    `goods_receipt_number` STRING COMMENT 'Reference to the goods receipt that triggered the invoice.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before taxes and discounts.',
    `invoice_date` DATE COMMENT 'Date the supplier issued the invoice.',
    `invoice_number` STRING COMMENT 'Vendor-assigned invoice number used for reference and matching.',
    `invoice_status` STRING COMMENT 'Current processing status of the invoice.. Valid values are `draft|open|approved|paid|rejected|cancelled`',
    `is_credit_memo` BOOLEAN COMMENT 'True if the record represents a credit memo rather than a standard invoice.',
    `material_group` STRING COMMENT 'Group classification of materials purchased.',
    `net_amount` DECIMAL(18,2) COMMENT 'Invoice amount after tax and discounts.',
    `notes` STRING COMMENT 'Free-text notes entered on the invoice for additional context.',
    `payment_block_flag` BOOLEAN COMMENT 'Indicates whether payment of the invoice is blocked (true) or allowed (false).',
    `payment_date` DATE COMMENT 'Date the invoice was paid.',
    `payment_method` STRING COMMENT 'Method used for payment (e.g., ACH, Wire, Check).. Valid values are `ACH|Wire|Check|CreditCard|Cash`',
    `payment_reference` STRING COMMENT 'Reference number of the payment transaction.',
    `payment_terms` STRING COMMENT 'Standard payment terms code governing the invoice.. Valid values are `Net30|Net45|Net60|EOM|2%_10`',
    `plant_code` STRING COMMENT 'Manufacturing plant code related to the invoice.',
    `posting_date` DATE COMMENT 'Date the invoice was posted to the general ledger.',
    `ppap_status` STRING COMMENT 'Status of the Production Part Approval Process for the supplier.. Valid values are `NotStarted|InProgress|Approved|Rejected`',
    `purchase_order_number` STRING COMMENT 'Reference to the purchase order associated with the invoice.',
    `reporting_currency_code` STRING COMMENT 'Currency code used for financial reporting of the invoice.. Valid values are `^[A-Z]{3}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount included in the invoice.',
    `tax_code` STRING COMMENT 'Tax code used for tax calculation on the invoice.. Valid values are `VAT|GST|SALES|NONE`',
    `three_way_match_flag` BOOLEAN COMMENT 'True when purchase order, goods receipt, and invoice are matched.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the last update to the invoice record.',
    `warranty_reserve_amount` DECIMAL(18,2) COMMENT 'Amount reserved for warranty liability related to the invoice.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts Payable (AP) vendor invoice record capturing supplier invoices received for direct materials (production parts, CKD/SKD kits), indirect materials (MRO, tooling), and services. Aligned with SAP FI-AP (Accounts Payable) module. Captures vendor ID, invoice date, posting date, payment terms, gross amount, tax amount, net amount, currency, payment block status, three-way match status (PO/GR/IR), due date, and payment method. Supports PPAP-related supplier payment tracking and cash flow management.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction.',
    `payment_run_id` BIGINT COMMENT 'Identifier of the batch run that processed this payment.',
    `payment_settlement_id` BIGINT COMMENT 'Identifier linking to settlement batch.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the supplier/vendor receiving the payment.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total payment amount before taxes and discounts.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount after tax and discount.',
    `bank_account_number` STRING COMMENT 'Bank account number used for the payment (PCI-sensitive).',
    `clearance_date` DATE COMMENT 'Date when the payment cleared the bank.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code of the payment.. Valid values are `USD|EUR|JPY|GBP|CNY|CAD`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount applied to the payment.',
    `early_payment_discount_flag` BOOLEAN COMMENT 'Indicates if an early payment discount was applied.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied if payment currency differs from functional currency.',
    `house_bank_code` STRING COMMENT 'Code of the house bank handling the payment.',
    `is_automated` BOOLEAN COMMENT 'Flag indicating if the payment was processed automatically.',
    `payment_channel` STRING COMMENT 'Channel through which the payment was initiated.. Valid values are `online|batch|manual`',
    `payment_comments` STRING COMMENT 'Additional comments or notes regarding the payment.',
    `payment_cost_center` STRING COMMENT 'Cost center associated with the payment.',
    `payment_date` DATE COMMENT 'Calendar date of the payment (date part).',
    `payment_description` STRING COMMENT 'Free-text description or memo for the payment.',
    `payment_document_number` STRING COMMENT 'Document number assigned to the payment in the ERP system.',
    `payment_due_date` DATE COMMENT 'Original due date of the invoice(s) being paid.',
    `payment_error_flag` BOOLEAN COMMENT 'Indicates if the payment encountered an error.',
    `payment_exchange_rate_date` DATE COMMENT 'Date on which the exchange rate was determined.',
    `payment_fiscal_period` STRING COMMENT 'Fiscal period (month/quarter) of the payment.',
    `payment_fiscal_year` STRING COMMENT 'Fiscal year of the payment.',
    `payment_gl_account` STRING COMMENT 'General Ledger account code charged for the payment.',
    `payment_method` STRING COMMENT 'Method used to make the payment (e.g., ACH, wire, check, EFT).. Valid values are `ach|wire|check|eft`',
    `payment_original_amount` DECIMAL(18,2) COMMENT 'Payment amount in original invoice currency.',
    `payment_original_currency` STRING COMMENT 'Currency of the original invoice amount.. Valid values are `USD|EUR|JPY|GBP|CNY|CAD`',
    `payment_priority` STRING COMMENT 'Priority level assigned to the payment.. Valid values are `high|normal|low`',
    `payment_reference` STRING COMMENT 'External reference number provided by the vendor or bank.',
    `payment_settlement_date` DATE COMMENT 'Date of the settlement batch.',
    `payment_status` STRING COMMENT 'Current processing status of the payment.. Valid values are `pending|processed|cleared|failed|reversed`',
    `payment_tax_code` STRING COMMENT 'Tax code applied to the payment.',
    `payment_terms` STRING COMMENT 'Contractual payment terms (e.g., Net30).',
    `payment_timestamp` TIMESTAMP COMMENT 'Exact date and time when the payment was executed.',
    `payment_type` STRING COMMENT 'Indicates if the payment is outbound (to vendor) or inbound (refund).. Valid values are `outbound|inbound`',
    `payment_vat_amount` DECIMAL(18,2) COMMENT 'Value-added tax amount included in the payment.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the payment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment record.',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Accounts Payable payment transaction record capturing outgoing payments made to suppliers and vendors. Captures payment run ID, payment date, vendor ID, bank account, payment method (ACH, wire, check), payment amount, currency, cleared invoice references, payment document number, house bank, and payment status. Supports supplier payment performance tracking, cash management, and working capital optimization aligned with JIT/JIS supply chain payment terms.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'Primary key',
    `company_code_id` BIGINT COMMENT 'Company code FK',
    `ar_intercompany_entity_company_code_id` BIGINT COMMENT 'Intercompany entity FK',
    `party_id` BIGINT COMMENT 'Customer party FK',
    `vin_registry_id` BIGINT COMMENT 'VIN registry FK',
    `accounting_date` DATE COMMENT 'Date for accounting period assignment',
    `aging_bucket` STRING COMMENT 'AR aging classification bucket',
    `ar_invoice_status` STRING COMMENT 'Current status of the AR invoice',
    `billing_document_number` STRING COMMENT 'Reference billing document number',
    `collection_status` STRING COMMENT 'Status of collection efforts',
    `cost_center_code` STRING COMMENT 'Cost center assignment',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Transaction currency ISO code',
    `delivery_note_number` STRING COMMENT 'Associated delivery note',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount applied to invoice',
    `discount_reason` STRING COMMENT 'Reason for discount',
    `distribution_channel` STRING COMMENT 'Sales distribution channel',
    `due_date` DATE COMMENT 'Payment due date',
    `fiscal_period` STRING COMMENT 'Fiscal period of posting',
    `fiscal_year` STRING COMMENT 'Fiscal year of posting',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross invoice amount',
    `intercompany_flag` BOOLEAN COMMENT 'Whether invoice is intercompany',
    `invoice_category` STRING COMMENT 'Category of invoice',
    `invoice_date` DATE COMMENT 'Date invoice was issued',
    `invoice_number` STRING COMMENT 'Unique invoice number',
    `invoice_type` STRING COMMENT 'Type of AR invoice',
    `net_amount` DECIMAL(18,2) COMMENT 'Net invoice amount after discounts',
    `payment_amount` DECIMAL(18,2) COMMENT 'Amount paid against invoice',
    `payment_method` STRING COMMENT 'Method of payment',
    `payment_received_date` DATE COMMENT 'Date payment was received',
    `payment_status` STRING COMMENT 'Current payment status',
    `payment_terms` STRING COMMENT 'Payment terms code',
    `plant_code` STRING COMMENT 'Originating plant code',
    `posting_date` DATE COMMENT 'GL posting date',
    `profit_center_code` STRING COMMENT 'Profit center assignment',
    `purchase_order_number` STRING COMMENT 'Customer PO reference',
    `region_code` STRING COMMENT 'Sales region code',
    `revenue_recognition_date` DATE COMMENT 'Date revenue is recognized',
    `sales_order_number` STRING COMMENT 'Related sales order',
    `sales_org_code` STRING COMMENT 'Sales organization code',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount on invoice',
    `tax_code` STRING COMMENT 'Tax code applied',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `warranty_reserve_amount` DECIMAL(18,2) COMMENT 'Warranty reserve allocation',
    `warranty_reserve_flag` BOOLEAN COMMENT 'Whether warranty reserve applies',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Accounts receivable invoice issued to customers for vehicle sales, parts, and services';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`ar_payment` (
    `ar_payment_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Employee FK',
    `ar_posted_by_user_employee_id` BIGINT COMMENT 'Posted by employee FK',
    `party_id` BIGINT COMMENT 'Party FK',
    `ar_payment_status` STRING COMMENT 'Payment status',
    `bank_account_number` STRING COMMENT 'Bank account number',
    `bank_name` STRING COMMENT 'Bank name',
    `cash_application_status` STRING COMMENT 'Cash application status',
    `clearance_date` DATE COMMENT 'Date payment cleared',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Payment currency',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount taken',
    `due_date` DATE COMMENT 'Original due date',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate at payment',
    `exchange_rate_date` DATE COMMENT 'Date of exchange rate',
    `gross_amount` DECIMAL(18,2) COMMENT 'Gross payment amount',
    `invoice_number` STRING COMMENT 'Related invoice number',
    `is_partial_payment` BOOLEAN COMMENT 'Whether partial payment',
    `net_amount` DECIMAL(18,2) COMMENT 'Net payment amount',
    `notes` STRING COMMENT 'Payment notes',
    `original_amount` DECIMAL(18,2) COMMENT 'Original invoice amount',
    `payment_channel` STRING COMMENT 'Channel of payment',
    `payment_date` DATE COMMENT 'Date of payment',
    `payment_method` STRING COMMENT 'Method of payment',
    `payment_number` STRING COMMENT 'Unique payment number',
    `payment_source` STRING COMMENT 'Source of payment',
    `payment_terms_code` STRING COMMENT 'Payment terms',
    `posting_timestamp` TIMESTAMP COMMENT 'GL posting timestamp',
    `remittance_reference` STRING COMMENT 'Remittance advice reference',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    CONSTRAINT pk_ar_payment PRIMARY KEY(`ar_payment_id`)
) COMMENT 'Accounts receivable payment received from customers';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`capex_request` (
    `capex_request_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Approver FK',
    `capex_employee_id` BIGINT COMMENT 'Employee FK',
    `capex_requested_by_employee_id` BIGINT COMMENT 'Requestor FK',
    `capex_updated_by_user_employee_id` BIGINT COMMENT 'Updated by FK',
    `org_unit_id` BIGINT COMMENT 'Org unit FK',
    `plant_id` BIGINT COMMENT 'Plant FK',
    `primary_capex_employee_id` BIGINT COMMENT 'Primary CAPEX owner FK',
    `regulatory_requirement_id` BIGINT COMMENT 'Regulatory requirement FK',
    `vendor_id` BIGINT COMMENT 'Vendor FK',
    `actual_end_date` DATE COMMENT 'Actual project end date',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Actual spend to date',
    `approval_date` TIMESTAMP COMMENT 'Date of approval',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Approved budget',
    `budget_amount` DECIMAL(18,2) COMMENT 'Requested budget',
    `capex_request_status` STRING COMMENT 'Current status',
    `cost_center_code` STRING COMMENT 'Cost center',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation',
    `currency_code` STRING COMMENT 'Currency',
    `depreciation_method` STRING COMMENT 'Depreciation method',
    `depreciation_years` STRING COMMENT 'Useful life years',
    `capex_request_description` STRING COMMENT 'Description of request',
    `external_funding_amount` DECIMAL(18,2) COMMENT 'External funding',
    `fiscal_year` STRING COMMENT 'Fiscal year',
    `funding_source` STRING COMMENT 'Source of funding',
    `has_external_funding` BOOLEAN COMMENT 'External funding flag',
    `investment_category` STRING COMMENT 'Investment category',
    `irr` DECIMAL(18,2) COMMENT 'Internal rate of return',
    `is_capitalized` BOOLEAN COMMENT 'Capitalization flag',
    `is_compliant` BOOLEAN COMMENT 'Compliance flag',
    `justification` STRING COMMENT 'Business justification',
    `npv` DECIMAL(18,2) COMMENT 'Net present value',
    `payback_period_years` DECIMAL(18,2) COMMENT 'Payback period',
    `priority` STRING COMMENT 'Priority level',
    `procurement_method` STRING COMMENT 'Procurement method',
    `project_end_date` DATE COMMENT 'Planned end date',
    `project_start_date` DATE COMMENT 'Planned start date',
    `regulatory_approval_status` STRING COMMENT 'Regulatory approval status',
    `request_date` TIMESTAMP COMMENT 'Date of request',
    `request_number` STRING COMMENT 'Unique request number',
    `risk_rating` STRING COMMENT 'Risk assessment',
    `supporting_document_url` STRING COMMENT 'Document URL',
    `tax_implication` STRING COMMENT 'Tax implications',
    `title` STRING COMMENT 'Request title',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update',
    `wbs_element` STRING COMMENT 'WBS element code',
    CONSTRAINT pk_capex_request PRIMARY KEY(`capex_request_id`)
) COMMENT 'Capital expenditure request for plant equipment, tooling, and facility investments';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`budget_plan` (
    `budget_plan_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Approver FK',
    `finance_project_id` BIGINT COMMENT 'Project FK',
    `allocation_method` STRING COMMENT 'Budget allocation method',
    `approval_date` DATE COMMENT 'Date approved',
    `budget_category` STRING COMMENT 'Budget category',
    `budget_plan_status` STRING COMMENT 'Plan status',
    `cost_center_code` STRING COMMENT 'Cost center',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'Currency',
    `effective_end_date` DATE COMMENT 'Plan end date',
    `effective_start_date` DATE COMMENT 'Plan start date',
    `fiscal_year` STRING COMMENT 'Fiscal year',
    `gl_account` STRING COMMENT 'GL account',
    `is_forecast` BOOLEAN COMMENT 'Forecast flag',
    `is_locked` BOOLEAN COMMENT 'Lock flag',
    `notes` STRING COMMENT 'Notes',
    `plan_code` STRING COMMENT 'Plan code',
    `plan_name` STRING COMMENT 'Plan name',
    `plan_type` STRING COMMENT 'Plan type',
    `planned_amount` DECIMAL(18,2) COMMENT 'Planned budget amount',
    `planning_period` STRING COMMENT 'Planning period',
    `profit_center_code` STRING COMMENT 'Profit center',
    `revised_amount` DECIMAL(18,2) COMMENT 'Revised budget amount',
    `scenario` STRING COMMENT 'Budget scenario',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update',
    `version_number` STRING COMMENT 'Version number',
    CONSTRAINT pk_budget_plan PRIMARY KEY(`budget_plan_id`)
) COMMENT 'Annual and multi-year budget plans for cost centers, profit centers, and projects';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'Cost center FK',
    `gl_account_id` BIGINT COMMENT 'GL account FK',
    `budget_plan_id` BIGINT COMMENT 'Budget header FK',
    `profit_center_id` BIGINT COMMENT 'Profit center FK',
    `allocation_method` STRING COMMENT 'Allocation method',
    `amount_type` STRING COMMENT 'Amount type',
    `approved_timestamp` TIMESTAMP COMMENT 'Approval timestamp',
    `budget_line_status` STRING COMMENT 'Line status',
    `business_unit` STRING COMMENT 'Business unit',
    `comments` STRING COMMENT 'Comments',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'Currency',
    `budget_line_description` STRING COMMENT 'Line description',
    `effective_end_date` DATE COMMENT 'End date',
    `effective_start_date` DATE COMMENT 'Start date',
    `fiscal_period` STRING COMMENT 'Fiscal period',
    `fiscal_year` STRING COMMENT 'Fiscal year',
    `is_manual` BOOLEAN COMMENT 'Manual entry flag',
    `justification` STRING COMMENT 'Justification',
    `line_quantity` DECIMAL(18,2) COMMENT 'Quantity',
    `line_sequence` STRING COMMENT 'Line sequence',
    `planned_amount` DECIMAL(18,2) COMMENT 'Planned amount',
    `plant_code` STRING COMMENT 'Plant code',
    `product_line` STRING COMMENT 'Product line',
    `revised_amount` DECIMAL(18,2) COMMENT 'Revised amount',
    `unit_of_measure` STRING COMMENT 'UOM',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update',
    `version_number` STRING COMMENT 'Version',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Individual line items within a budget plan';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` (
    `manufacturing_cost_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'Cost center FK',
    `plant_id` BIGINT COMMENT 'Plant FK',
    `production_order_id` BIGINT COMMENT 'Production order FK',
    `actual_energy_cost` DECIMAL(18,2) COMMENT 'Actual energy cost',
    `actual_fixed_overhead_cost` DECIMAL(18,2) COMMENT 'Actual fixed overhead',
    `actual_labor_cost` DECIMAL(18,2) COMMENT 'Actual labor cost',
    `actual_material_cost` DECIMAL(18,2) COMMENT 'Actual material cost',
    `actual_scrap_cost` DECIMAL(18,2) COMMENT 'Actual scrap cost',
    `actual_tooling_amortization_cost` DECIMAL(18,2) COMMENT 'Actual tooling amortization',
    `actual_variable_overhead_cost` DECIMAL(18,2) COMMENT 'Actual variable overhead',
    `cost_calculation_timestamp` TIMESTAMP COMMENT 'Calculation timestamp',
    `cost_record_number` STRING COMMENT 'Record number',
    `cost_variance_amount` DECIMAL(18,2) COMMENT 'Variance amount',
    `cost_variance_percent` DECIMAL(18,2) COMMENT 'Variance percent',
    `costing_date` DATE COMMENT 'Costing date',
    `costing_version` STRING COMMENT 'Costing version',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'Currency',
    `is_variance_exceed_threshold` BOOLEAN COMMENT 'Variance threshold flag',
    `manufacturing_cost_status` STRING COMMENT 'Status',
    `standard_energy_cost` DECIMAL(18,2) COMMENT 'Standard energy cost',
    `standard_fixed_overhead_cost` DECIMAL(18,2) COMMENT 'Standard fixed overhead',
    `standard_labor_cost` DECIMAL(18,2) COMMENT 'Standard labor cost',
    `standard_material_cost` DECIMAL(18,2) COMMENT 'Standard material cost',
    `standard_scrap_cost` DECIMAL(18,2) COMMENT 'Standard scrap cost',
    `standard_tooling_amortization_cost` DECIMAL(18,2) COMMENT 'Standard tooling amortization',
    `standard_variable_overhead_cost` DECIMAL(18,2) COMMENT 'Standard variable overhead',
    `total_actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost',
    `total_standard_cost` DECIMAL(18,2) COMMENT 'Total standard cost',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update',
    `variance_threshold_amount` DECIMAL(18,2) COMMENT 'Threshold amount',
    `vehicle_line` STRING COMMENT 'Vehicle line',
    `vehicle_model_code` STRING COMMENT 'Model code',
    `vehicle_model_year` STRING COMMENT 'Model year',
    CONSTRAINT pk_manufacturing_cost PRIMARY KEY(`manufacturing_cost_id`)
) COMMENT 'Standard and actual manufacturing cost records per production order and vehicle line';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` (
    `warranty_reserve_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'Cost center FK',
    `profit_center_id` BIGINT COMMENT 'Profit center FK',
    `vin_registry_id` BIGINT COMMENT 'VIN registry FK',
    `accounting_period` STRING COMMENT 'Accounting period',
    `accrual_basis` STRING COMMENT 'Accrual basis',
    `actuarial_review_date` DATE COMMENT 'Last actuarial review',
    `audit_trail_notes` STRING COMMENT 'Audit notes',
    `claims_charged` DECIMAL(18,2) COMMENT 'Claims charged against reserve',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'Currency',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `estimated_cost_per_unit` DECIMAL(18,2) COMMENT 'Estimated cost per unit',
    `fiscal_year` STRING COMMENT 'Fiscal year',
    `is_ifrs_compliant` BOOLEAN COMMENT 'IFRS compliance flag',
    `is_sox_controlled` BOOLEAN COMMENT 'SOX control flag',
    `last_actuarial_update_timestamp` TIMESTAMP COMMENT 'Last actuarial update',
    `market_region` STRING COMMENT 'Market region',
    `model_year` STRING COMMENT 'Model year',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Regulatory reporting flag',
    `reserve_adequacy_ratio` DECIMAL(18,2) COMMENT 'Adequacy ratio',
    `reserve_amount` DECIMAL(18,2) COMMENT 'Reserve amount',
    `reserve_balance` DECIMAL(18,2) COMMENT 'Current balance',
    `reserve_description` STRING COMMENT 'Description',
    `reserve_number` STRING COMMENT 'Reserve number',
    `reserve_source` STRING COMMENT 'Source',
    `units_sold` BIGINT COMMENT 'Units sold',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update',
    `vehicle_line` STRING COMMENT 'Vehicle line',
    `warranty_claims_amount` DECIMAL(18,2) COMMENT 'Total claims amount',
    `warranty_claims_count` BIGINT COMMENT 'Number of claims',
    `warranty_reserve_status` STRING COMMENT 'Status',
    `warranty_type` STRING COMMENT 'Warranty type',
    CONSTRAINT pk_warranty_reserve PRIMARY KEY(`warranty_reserve_id`)
) COMMENT 'Warranty reserve accruals and balances for vehicle warranty obligations';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` (
    `finance_inventory_valuation_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'Cost center FK',
    `gl_account_id` BIGINT COMMENT 'GL account FK',
    `profit_center_id` BIGINT COMMENT 'Profit center FK',
    `actual_unit_cost` DECIMAL(18,2) COMMENT 'Actual unit cost',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'Currency',
    `fiscal_period` STRING COMMENT 'Fiscal period',
    `fiscal_year` STRING COMMENT 'Fiscal year',
    `is_consignment` BOOLEAN COMMENT 'Consignment flag',
    `material_type` STRING COMMENT 'Type of material (raw, WIP, finished goods)',
    `obsolescence_provision_amount` DECIMAL(18,2) COMMENT 'Obsolescence provision',
    `plant_code` STRING COMMENT 'Plant code',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Quantity on hand',
    `standard_unit_cost` DECIMAL(18,2) COMMENT 'Standard unit cost',
    `storage_location_code` STRING COMMENT 'Storage location',
    `total_valuation_amount` DECIMAL(18,2) COMMENT 'Total inventory value',
    `total_value` DECIMAL(18,2) COMMENT '',
    `unit_cost` DECIMAL(18,2) COMMENT '',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update',
    `valuation_date` DATE COMMENT 'Date of valuation',
    `valuation_method` STRING COMMENT 'Valuation method (standard cost, FIFO, weighted average)',
    `variance_amount` DECIMAL(18,2) COMMENT 'Cost variance',
    `write_down_amount` DECIMAL(18,2) COMMENT 'Write-down amount',
    CONSTRAINT pk_finance_inventory_valuation PRIMARY KEY(`finance_inventory_valuation_id`)
) COMMENT 'Financial inventory valuation for GAAP/IFRS reporting including standard cost, FIFO, and weighted average methods';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Fixed Asset Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `org_unit_id` BIGINT COMMENT 'Org Unit Id',
    `plant_id` BIGINT COMMENT 'Plant Id',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Accumulated Depreciation',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Acquisition Cost',
    `acquisition_date` DATE COMMENT 'Acquisition Date',
    `asset_class` STRING COMMENT 'Asset Class',
    `asset_condition` STRING COMMENT 'Asset Condition',
    `asset_description` STRING COMMENT 'Asset Description',
    `asset_name` STRING COMMENT 'Asset Name',
    `asset_status` STRING COMMENT 'Asset Status',
    `asset_tag` STRING COMMENT 'Asset Tag',
    `asset_type` STRING COMMENT 'Asset Type',
    `capitalized_flag` BOOLEAN COMMENT 'Capitalized Flag',
    `condition_rating` STRING COMMENT 'Condition Rating',
    `cost_center_code` STRING COMMENT 'Cost Center Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `depreciation_method` STRING COMMENT 'Depreciation Method',
    `depreciation_rate_percent` DECIMAL(18,2) COMMENT 'Depreciation Rate Percent',
    `depreciation_start_date` DATE COMMENT 'Depreciation Start Date',
    `disposal_method` STRING COMMENT 'Disposal Method',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Insurance Coverage Amount',
    `insurance_expiry_date` DATE COMMENT 'Insurance Expiry Date',
    `insurance_policy_number` STRING COMMENT 'Insurance Policy Number',
    `last_inspection_date` DATE COMMENT 'Last Inspection Date',
    `location_code` STRING COMMENT 'Location Code',
    `maintenance_schedule` STRING COMMENT 'Maintenance Schedule',
    `manufacturer` STRING COMMENT 'Manufacturer',
    `model` STRING COMMENT 'Model',
    `net_book_value` DECIMAL(18,2) COMMENT 'Net Book Value',
    `next_inspection_date` DATE COMMENT 'Next Inspection Date',
    `responsible_department` STRING COMMENT 'Responsible Department',
    `retirement_date` DATE COMMENT 'Retirement Date',
    `serial_number` STRING COMMENT 'Serial Number',
    `tax_depreciation_amount` DECIMAL(18,2) COMMENT 'Tax Depreciation Amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    `useful_life_years` STRING COMMENT 'Useful Life Years',
    `vin` STRING COMMENT 'Vin',
    `warranty_end_date` DATE COMMENT 'Warranty End Date',
    `warranty_provider` STRING COMMENT 'Warranty Provider',
    `warranty_start_date` DATE COMMENT 'Warranty Start Date',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master record for all capitalized assets including manufacturing machinery, production tooling, dies, stamping presses, paint shop equipment, EV battery assembly lines, plant buildings, and IT infrastructure. Aligned with SAP FI-AA (Asset Accounting). Captures asset class, asset description, acquisition date, acquisition cost, useful life, depreciation method (straight-line, declining balance), accumulated depreciation, net book value, plant assignment, cost center, and retirement date. Supports CapEx tracking and IFRS/GAAP asset disclosure.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`depreciation_run` (
    `depreciation_run_id` BIGINT COMMENT 'Depreciation Run Id',
    `employee_id` BIGINT COMMENT 'Created By Employee Id',
    `gl_account_id` BIGINT COMMENT 'Gl Account Id',
    `company_code` STRING COMMENT 'Company Code',
    `cost_center_code` STRING COMMENT 'Cost Center Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `depreciation_area` STRING COMMENT 'Depreciation Area',
    `depreciation_end_date` DATE COMMENT 'Depreciation End Date',
    `depreciation_method` STRING COMMENT 'Depreciation Method',
    `depreciation_start_date` DATE COMMENT 'Depreciation Start Date',
    `fiscal_period` STRING COMMENT 'Fiscal Period',
    `fiscal_year` STRING COMMENT 'Fiscal Year',
    `is_test_run` BOOLEAN COMMENT 'Is Test Run',
    `number_of_assets_processed` STRING COMMENT 'Number Of Assets Processed',
    `posting_document_number` STRING COMMENT 'Posting Document Number',
    `profit_center_code` STRING COMMENT 'Profit Center Code',
    `remarks` STRING COMMENT 'Remarks',
    `run_number` STRING COMMENT 'Run Number',
    `run_status` STRING COMMENT 'Run Status',
    `run_timestamp` TIMESTAMP COMMENT 'Run Timestamp',
    `run_type` STRING COMMENT 'Run Type',
    `status_detail` STRING COMMENT 'Status Detail',
    `total_depreciation_amount` DECIMAL(18,2) COMMENT 'Total Depreciation Amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_depreciation_run PRIMARY KEY(`depreciation_run_id`)
) COMMENT 'Periodic depreciation run transaction record capturing the execution of planned depreciation for fixed assets within a fiscal period. Aligned with SAP FI-AA depreciation posting run (AFAB). Captures run date, fiscal year, fiscal period, company code, depreciation area (book, tax, IFRS), total depreciation posted, number of assets processed, run status, and GL posting document reference. Supports period-end close, asset accounting reconciliation, and EBITDA calculation (depreciation add-back).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`intercompany_settlement` (
    `intercompany_settlement_id` BIGINT COMMENT 'Intercompany Settlement Id',
    `employee_id` BIGINT COMMENT 'Approved By Employee Id',
    `cost_center_id` BIGINT COMMENT 'Cost Center Id',
    `gl_account_id` BIGINT COMMENT 'Gl Account Id',
    `intercompany_group_id` BIGINT COMMENT 'Intercompany Group Id',
    `intercompany_loan_id` BIGINT COMMENT 'Related Loan Id',
    `profit_center_id` BIGINT COMMENT 'Profit Center Id',
    `amount_gross` DECIMAL(18,2) COMMENT 'Amount Gross',
    `amount_net` DECIMAL(18,2) COMMENT 'Amount Net',
    `amount_tax` DECIMAL(18,2) COMMENT 'Amount Tax',
    `approval_timestamp` TIMESTAMP COMMENT 'Approval Timestamp',
    `clearing_document_number` STRING COMMENT 'Clearing Document Number',
    `comments` STRING COMMENT 'Comments',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `intercompany_settlement_description` STRING COMMENT 'Intercompany Settlement Description',
    `effective_from` DATE COMMENT 'Effective From',
    `effective_until` DATE COMMENT 'Effective Until',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange Rate',
    `fiscal_period` STRING COMMENT 'Fiscal Period',
    `fiscal_year` STRING COMMENT 'Fiscal Year',
    `intercompany_settlement_status` STRING COMMENT 'Intercompany Settlement Status',
    `is_approved` BOOLEAN COMMENT 'Is Approved',
    `netting_indicator` BOOLEAN COMMENT 'Netting Indicator',
    `posting_date` DATE COMMENT 'Posting Date',
    `receiving_company_code` STRING COMMENT 'Receiving Company Code',
    `reconciliation_status` STRING COMMENT 'Reconciliation Status',
    `sending_company_code` STRING COMMENT 'Sending Company Code',
    `settlement_number` STRING COMMENT 'Settlement Number',
    `settlement_type` STRING COMMENT 'Settlement Type',
    `source_document_number` STRING COMMENT 'Source Document Number',
    `target_document_number` STRING COMMENT 'Target Document Number',
    `tax_code` STRING COMMENT 'Tax Code',
    `transaction_date` DATE COMMENT 'Transaction Date',
    `transfer_price_basis` STRING COMMENT 'Transfer Price Basis',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_intercompany_settlement PRIMARY KEY(`intercompany_settlement_id`)
) COMMENT 'Intercompany settlement transaction record capturing financial transactions between legal entities within the Automotive group, including transfer pricing for CKD/SKD kits, shared service charges, royalty payments, management fee allocations, and intercompany loans. Captures sending company code, receiving company code, settlement type, settlement amount, currency, transfer price basis, netting indicator, clearing document reference, and reconciliation status. Supports intercompany elimination in group consolidation and IFRS/GAAP compliance.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Cost Allocation Id',
    `allocation_cycle_id` BIGINT COMMENT 'Allocation Cycle Id',
    `employee_id` BIGINT COMMENT 'Created By Employee Id',
    `activity_quantity` DECIMAL(18,2) COMMENT 'Activity Quantity',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Allocated Amount',
    `allocation_date` DATE COMMENT 'Allocation Date',
    `allocation_method` STRING COMMENT 'Allocation Method',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Allocation Percentage',
    `cost_allocation_status` STRING COMMENT 'Cost Allocation Status',
    `cost_element_code` STRING COMMENT 'Cost Element Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `cost_allocation_description` STRING COMMENT 'Cost Allocation Description',
    `effective_from` DATE COMMENT 'Effective From',
    `effective_until` DATE COMMENT 'Effective Until',
    `fiscal_period` STRING COMMENT 'Fiscal Period',
    `fiscal_year` STRING COMMENT 'Fiscal Year',
    `is_intercompany` BOOLEAN COMMENT 'Is Intercompany',
    `posting_date` DATE COMMENT 'Posting Date',
    `profit_center_code` STRING COMMENT 'Profit Center Code',
    `receiver_cost_center_code` STRING COMMENT 'Receiver Cost Center Code',
    `sender_cost_center_code` STRING COMMENT 'Sender Cost Center Code',
    `statistical_key_value` DECIMAL(18,2) COMMENT 'Statistical Key Value',
    `updated_by` STRING COMMENT 'Updated By',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Cost allocation and assessment cycle transaction record capturing the periodic redistribution of overhead costs from service cost centers (maintenance, utilities, HR, IT) to production cost centers and profit centers. Aligned with SAP CO assessment and distribution cycles (KSV5/KSU5). Captures allocation cycle ID, fiscal period, sender cost center, receiver cost center/profit center, allocation method (fixed percentage, activity-based, statistical key figure), allocated amount, and currency. Supports accurate vehicle manufacturing cost calculation.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`tax_posting` (
    `tax_posting_id` BIGINT COMMENT 'Tax Posting Id',
    `gl_account_id` BIGINT COMMENT 'Gl Account Id',
    `journal_entry_id` BIGINT COMMENT 'Journal Entry Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `tax_posting_description` STRING COMMENT 'Tax Posting Description',
    `fiscal_period` STRING COMMENT 'Fiscal Period',
    `fiscal_year` STRING COMMENT 'Fiscal Year',
    `line_sequence` STRING COMMENT 'Line Sequence',
    `posting_date` DATE COMMENT 'Posting Date',
    `source_document_number` STRING COMMENT 'Source Document Number',
    `source_document_type` STRING COMMENT 'Source Document Type',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax Amount',
    `tax_base_amount` DECIMAL(18,2) COMMENT 'Tax Base Amount',
    `tax_code` STRING COMMENT 'Tax Code',
    `tax_exempt_flag` BOOLEAN COMMENT 'Tax Exempt Flag',
    `tax_jurisdiction` STRING COMMENT 'Tax Jurisdiction',
    `tax_posting_status` STRING COMMENT 'Tax Posting Status',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax Rate',
    `tax_rate_type` STRING COMMENT 'Tax Rate Type',
    `tax_reporting_period` STRING COMMENT 'Tax Reporting Period',
    `tax_return_reference` STRING COMMENT 'Tax Return Reference',
    `tax_type` STRING COMMENT 'Tax Type',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_tax_posting PRIMARY KEY(`tax_posting_id`)
) COMMENT 'Tax posting record capturing VAT, sales tax, withholding tax, and excise duty transactions associated with vendor invoices, customer invoices, and intercompany transactions. Captures tax code, tax type (input/output VAT, withholding, excise), tax base amount, tax amount, currency, tax jurisdiction, reporting period, tax return reference, and GL account. Supports indirect tax compliance, tax return preparation, and regulatory reporting to EPA/DOT/CARB for excise-related levies.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`accrual` (
    `accrual_id` BIGINT COMMENT 'Accrual Id',
    `dealership_id` BIGINT COMMENT 'Related Dealer Dealership Id',
    `accrual_related_dealership_id` BIGINT COMMENT 'Related Dealership Id',
    `cost_center_id` BIGINT COMMENT 'Cost Center Id',
    `employee_id` BIGINT COMMENT 'Created By Employee Id',
    `gl_account_id` BIGINT COMMENT 'Gl Account Id',
    `profit_center_id` BIGINT COMMENT 'Profit Center Id',
    `finance_project_id` BIGINT COMMENT 'Related Project Id',
    `vin_registry_id` BIGINT COMMENT 'Related Vehicle Vin Registry Id',
    `accrual_date` DATE COMMENT 'Accrual Date',
    `accrual_number` STRING COMMENT 'Accrual Number',
    `accrual_status` STRING COMMENT 'Accrual Status',
    `accrual_type` STRING COMMENT 'Accrual Type',
    `amount` DECIMAL(18,2) COMMENT 'Amount',
    `audit_user` STRING COMMENT 'Audit User',
    `basis` STRING COMMENT 'Basis',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `accrual_description` STRING COMMENT 'Accrual Description',
    `fiscal_period` STRING COMMENT 'Fiscal Period',
    `fiscal_year` STRING COMMENT 'Fiscal Year',
    `is_manual` BOOLEAN COMMENT 'Is Manual',
    `is_tax_relevant` BOOLEAN COMMENT 'Is Tax Relevant',
    `notes` STRING COMMENT 'Notes',
    `period_end_date` DATE COMMENT 'Period End Date',
    `posting_date` DATE COMMENT 'Posting Date',
    `reversal_date` DATE COMMENT 'Reversal Date',
    `supporting_document_ref` STRING COMMENT 'Supporting Document Ref',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax Amount',
    `tax_code` STRING COMMENT 'Tax Code',
    `updated_by` STRING COMMENT 'Updated By',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_accrual PRIMARY KEY(`accrual_id`)
) COMMENT 'Period-end accrual and prepayment record capturing estimated financial obligations and deferred costs that must be recognized in the correct fiscal period per IFRS/GAAP matching principle. Includes warranty accruals, rebate accruals, bonus provisions, tooling amortization accruals, and dealer incentive accruals. Captures accrual type, accrual amount, currency, accrual basis, GL account, cost center, fiscal period, reversal date, and supporting documentation reference. Critical for accurate FY close and SOX compliance.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`currency_rate` (
    `currency_rate_id` BIGINT COMMENT 'Currency Rate Id',
    `company_code_id` BIGINT COMMENT 'Company Code Id',
    `company_code` STRING COMMENT 'Company Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_from` STRING COMMENT 'Currency From',
    `currency_to` STRING COMMENT 'Currency To',
    `currency_rate_description` STRING COMMENT 'Currency Rate Description',
    `fiscal_year` STRING COMMENT 'Fiscal Year',
    `is_historical` BOOLEAN COMMENT 'Is Historical',
    `period` STRING COMMENT 'Period',
    `rate_date` DATE COMMENT 'Rate Date',
    `rate_type` STRING COMMENT 'Rate Type',
    `rate_value` DECIMAL(18,2) COMMENT 'Rate Value',
    `source` STRING COMMENT 'Source',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    `valid_from` DATE COMMENT 'Valid From',
    `valid_to` DATE COMMENT 'Valid To',
    CONSTRAINT pk_currency_rate PRIMARY KEY(`currency_rate_id`)
) COMMENT 'Foreign exchange (FX) currency rate reference record capturing daily, monthly average, and period-end exchange rates used for multi-currency financial reporting and transaction conversion. Captures currency pair (from/to), rate type (spot, average, period-end, planning), valid date, exchange rate, rate source (ECB, Bloomberg, internal treasury), and company code applicability. Supports IFRS translation of foreign subsidiary financials, transaction currency conversion, and FX exposure reporting.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'Wbs Element Id',
    `cost_center_id` BIGINT COMMENT 'Cost Center Id',
    `parent_wbs_wbs_element_id` BIGINT COMMENT 'Parent Wbs Wbs Element Id',
    `plant_id` BIGINT COMMENT 'Plant Id',
    `profit_center_id` BIGINT COMMENT 'Profit Center Id',
    `finance_project_id` BIGINT COMMENT 'Project Id',
    `regulatory_requirement_id` BIGINT COMMENT 'Regulatory Requirement Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `wbs_responsible_person_employee_id` BIGINT COMMENT 'Responsible Person Employee Id',
    `accounting_status` STRING COMMENT 'Accounting Status',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual Cost',
    `approval_date` DATE COMMENT 'Approval Date',
    `approval_status` STRING COMMENT 'Approval Status',
    `budget_amount` DECIMAL(18,2) COMMENT 'Budget Amount',
    `committed_cost` DECIMAL(18,2) COMMENT 'Committed Cost',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `end_date` DATE COMMENT 'End Date',
    `external_reference` STRING COMMENT 'External Reference',
    `fiscal_period` STRING COMMENT 'Fiscal Period',
    `fiscal_year` STRING COMMENT 'Fiscal Year',
    `investment_program_code` STRING COMMENT 'Investment Program Code',
    `is_capex` BOOLEAN COMMENT 'Is Capex',
    `is_r_and_d` BOOLEAN COMMENT 'Is R And D',
    `milestone_flag` BOOLEAN COMMENT 'Milestone Flag',
    `notes` STRING COMMENT 'Notes',
    `planned_cost` DECIMAL(18,2) COMMENT 'Planned Cost',
    `plant_location` STRING COMMENT 'Plant Location',
    `project_phase` STRING COMMENT 'Project Phase',
    `revision_number` STRING COMMENT 'Revision Number',
    `start_date` DATE COMMENT 'Start Date',
    `updated_by` STRING COMMENT 'Updated By',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    `wbs_code` STRING COMMENT 'Wbs Code',
    `wbs_element_status` STRING COMMENT 'Wbs Element Status',
    `wbs_hierarchy_path` STRING COMMENT 'Wbs Hierarchy Path',
    `wbs_level` STRING COMMENT 'Wbs Level',
    `wbs_name` STRING COMMENT 'Wbs Name',
    `wbs_type` STRING COMMENT 'Wbs Type',
    `created_by` STRING COMMENT 'Created By',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Work Breakdown Structure (WBS) element master record used for project-based cost tracking including CapEx projects, new model launch programs (SOP/EOP), EV/autonomous R&D programs, and plant expansion projects. Aligned with SAP PS (Project System). Captures WBS code, project definition, WBS level, responsible cost center, planned cost, actual cost, committed cost, project status, start/end dates, and investment program linkage. Enables granular CapEx spend tracking and R&D capitalization under IFRS IAS 38.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`financial_period_close` (
    `financial_period_close_id` BIGINT COMMENT 'Financial Period Close Id',
    `employee_id` BIGINT COMMENT 'Approver Employee Id',
    `financial_employee_id` BIGINT COMMENT 'Employee Id',
    `actual_completion_date` DATE COMMENT 'Actual Completion Date',
    `approver_name` STRING COMMENT 'Approver Name',
    `blocking_issue_description` STRING COMMENT 'Blocking Issue Description',
    `close_event_timestamp` TIMESTAMP COMMENT 'Close Event Timestamp',
    `close_task_number` STRING COMMENT 'Close Task Number',
    `close_task_type` STRING COMMENT 'Close Task Type',
    `cost_center_code` STRING COMMENT 'Cost Center Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `financial_period_close_status` STRING COMMENT 'Financial Period Close Status',
    `fiscal_period` STRING COMMENT 'Fiscal Period',
    `fiscal_year` STRING COMMENT 'Fiscal Year',
    `gross_amount` DECIMAL(18,2) COMMENT 'Gross Amount',
    `is_audit_evidence` BOOLEAN COMMENT 'Is Audit Evidence',
    `lock_flag` BOOLEAN COMMENT 'Lock Flag',
    `net_amount` DECIMAL(18,2) COMMENT 'Net Amount',
    `notes` STRING COMMENT 'Notes',
    `planned_completion_date` DATE COMMENT 'Planned Completion Date',
    `profit_center_code` STRING COMMENT 'Profit Center Code',
    `responsible_team` STRING COMMENT 'Responsible Team',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax Amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_financial_period_close PRIMARY KEY(`financial_period_close_id`)
) COMMENT 'Financial period-end close task and status record tracking the completion of all period-end close activities required before a fiscal period can be locked. Captures close task type (depreciation run, accrual posting, intercompany reconciliation, inventory valuation, FX revaluation, cost allocation), responsible team, planned completion date, actual completion date, status (pending, in-progress, completed, blocked), blocking issues, and sign-off approver. Supports FY close governance, SOX control evidence, and audit readiness.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`dealer_incentive` (
    `dealer_incentive_id` BIGINT COMMENT 'Dealer Incentive Id',
    `employee_id` BIGINT COMMENT 'Created By Employee Id',
    `dealership_id` BIGINT COMMENT 'Dealer Dealership Id',
    `accounting_period` STRING COMMENT 'Accounting Period',
    `accrual_basis` STRING COMMENT 'Accrual Basis',
    `actual_payment_amount` DECIMAL(18,2) COMMENT 'Actual Payment Amount',
    `actual_units_accrued` STRING COMMENT 'Actual Units Accrued',
    `audit_user` STRING COMMENT 'Audit User',
    `budget_version` STRING COMMENT 'Budget Version',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `dealer_incentive_status` STRING COMMENT 'Dealer Incentive Status',
    `dealer_incentive_description` STRING COMMENT 'Dealer Incentive Description',
    `eligibility_criteria` STRING COMMENT 'Eligibility Criteria',
    `end_date` DATE COMMENT 'End Date',
    `gl_account_code` STRING COMMENT 'Gl Account Code',
    `incentive_amount_per_unit` DECIMAL(18,2) COMMENT 'Incentive Amount Per Unit',
    `incentive_category` STRING COMMENT 'Incentive Category',
    `is_taxable` BOOLEAN COMMENT 'Is Taxable',
    `max_units` STRING COMMENT 'Max Units',
    `model_year` STRING COMMENT 'Model Year',
    `notes` STRING COMMENT 'Notes',
    `payment_date` DATE COMMENT 'Payment Date',
    `payment_method` STRING COMMENT 'Payment Method',
    `payment_reference` STRING COMMENT 'Payment Reference',
    `payment_status` STRING COMMENT 'Payment Status',
    `payment_trigger_threshold` DECIMAL(18,2) COMMENT 'Payment Trigger Threshold',
    `payment_trigger_type` STRING COMMENT 'Payment Trigger Type',
    `program_code` STRING COMMENT 'Program Code',
    `program_name` STRING COMMENT 'Program Name',
    `program_type` STRING COMMENT 'Program Type',
    `region_code` STRING COMMENT 'Region Code',
    `start_date` DATE COMMENT 'Start Date',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax Rate',
    `total_budget` DECIMAL(18,2) COMMENT 'Total Budget',
    `updated_by` STRING COMMENT 'Updated By',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    `vehicle_line` STRING COMMENT 'Vehicle Line',
    CONSTRAINT pk_dealer_incentive PRIMARY KEY(`dealer_incentive_id`)
) COMMENT 'Dealer financial incentive and sales program record capturing monetary incentives, volume bonuses, holdback payments, floor plan assistance, and marketing co-op funds issued to dealers. Captures incentive program type, dealer ID, vehicle line, model year (MY), incentive amount per unit, total program budget, accrual basis, payment trigger (volume threshold, OTD performance, NPS score), payment date, and GL account. Supports dealer network profitability management, MSRP-to-net revenue reconciliation, and sales incentive cost accounting.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`vehicle_profitability` (
    `vehicle_profitability_id` BIGINT COMMENT 'Vehicle Profitability Id',
    `homologation_record_id` BIGINT COMMENT 'Homologation Record Id',
    `model_id` BIGINT COMMENT 'Model Id',
    `dealership_id` BIGINT COMMENT 'Primary Vehicle Dealership Id',
    `party_id` BIGINT COMMENT 'Customer Party Id',
    `vehicle_dealership_id` BIGINT COMMENT 'Dealership Id',
    `vehicle_party_id` BIGINT COMMENT 'Party Id',
    `vin_registry_id` BIGINT COMMENT 'Vin Registry Id',
    `actual_manufacturing_cost` DECIMAL(18,2) COMMENT 'Actual Manufacturing Cost',
    `cost_center_code` STRING COMMENT 'Cost Center Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `ebitda_contribution` DECIMAL(18,2) COMMENT 'Ebitda Contribution',
    `emission_rating` STRING COMMENT 'Emission Rating',
    `fi_revenue_amount` DECIMAL(18,2) COMMENT 'Finance & Insurance revenue amount attributed to this vehicle sale.',
    `fiscal_period` STRING COMMENT 'Fiscal Period',
    `fiscal_year` STRING COMMENT 'Fiscal Year',
    `fuel_type` STRING COMMENT 'Fuel Type',
    `gross_margin` DECIMAL(18,2) COMMENT 'Gross Margin',
    `gross_revenue_msrp` DECIMAL(18,2) COMMENT 'Gross Revenue Msrp',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Incentive Amount',
    `is_eligible_for_subsidy` BOOLEAN COMMENT 'Is Eligible For Subsidy',
    `market_region` STRING COMMENT 'Market Region',
    `model_year` STRING COMMENT 'Model Year',
    `net_contribution_margin` DECIMAL(18,2) COMMENT 'Net Contribution Margin',
    `net_revenue` DECIMAL(18,2) COMMENT 'Net Revenue',
    `plant_code` STRING COMMENT 'Plant Code',
    `profit_center_code` STRING COMMENT 'Profit Center Code',
    `sales_channel` STRING COMMENT 'Sales Channel',
    `selling_distribution_cost` DECIMAL(18,2) COMMENT 'Selling Distribution Cost',
    `standard_manufacturing_cost` DECIMAL(18,2) COMMENT 'Standard Manufacturing Cost',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Subsidy Amount',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax Amount',
    `transaction_date` DATE COMMENT 'Transaction Date',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    `vehicle_category` STRING COMMENT 'Vehicle Category',
    `vehicle_height_mm` STRING COMMENT 'Vehicle Height Mm',
    `vehicle_length_mm` STRING COMMENT 'Vehicle Length Mm',
    `vehicle_line` STRING COMMENT 'Vehicle Line',
    `vehicle_profitability_status` STRING COMMENT 'Vehicle Profitability Status',
    `vehicle_weight_kg` DECIMAL(18,2) COMMENT 'Vehicle Weight Kg',
    `vehicle_width_mm` STRING COMMENT 'Vehicle Width Mm',
    `warranty_miles` STRING COMMENT 'Warranty Miles',
    `warranty_reserve_charge` DECIMAL(18,2) COMMENT 'Warranty Reserve Charge',
    `warranty_years` STRING COMMENT 'Warranty Years',
    CONSTRAINT pk_vehicle_profitability PRIMARY KEY(`vehicle_profitability_id`)
) COMMENT 'Vehicle-level profitability record capturing the contribution margin and net profitability for each vehicle unit sold, by VIN, vehicle line, plant, market region, and sales channel. Captures gross revenue (MSRP), net revenue (after dealer incentives and discounts), standard manufacturing cost, actual manufacturing cost, gross margin, selling and distribution cost, warranty reserve charge, and net contribution margin. Supports EBITDA reporting by vehicle line/plant/region and management accounting for product portfolio decisions.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`finance_project` (
    `finance_project_id` BIGINT COMMENT 'Primary key',
    `company_code_id` BIGINT COMMENT 'FK to company code',
    `profit_center_id` BIGINT COMMENT 'FK to profit center',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost',
    `budget_amount` DECIMAL(18,2) COMMENT 'Budget amount',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `end_date` DATE COMMENT 'End date',
    `project_code` STRING COMMENT 'Project code',
    `project_manager` STRING COMMENT 'Project manager',
    `project_name` STRING COMMENT 'Project name',
    `project_status` STRING COMMENT 'Project status',
    `project_type` STRING COMMENT 'Project type',
    `start_date` DATE COMMENT 'Start date',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    CONSTRAINT pk_finance_project PRIMARY KEY(`finance_project_id`)
) COMMENT 'Master reference table for project. Referenced by related_project_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`payment_settlement` (
    `payment_settlement_id` BIGINT COMMENT 'Payment Settlement Id',
    `invoice_id` BIGINT COMMENT 'Invoice Id',
    `party_id` BIGINT COMMENT 'Counterparty Id',
    `order_id` BIGINT COMMENT 'Purchase Order Id',
    `reversed_payment_settlement_id` BIGINT COMMENT 'Reversed Payment Settlement Id',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustment Amount',
    `batch_number` STRING COMMENT 'Batch Number',
    `cost_center_code` STRING COMMENT 'Cost Center Code',
    `counterparty_type` STRING COMMENT 'Counterparty Type',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `payment_settlement_description` STRING COMMENT 'Description',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount Amount',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange Rate',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fee Amount',
    `gross_amount` DECIMAL(18,2) COMMENT 'Gross Amount',
    `is_cross_border` BOOLEAN COMMENT 'Is Cross Border',
    `is_manual_settlement` BOOLEAN COMMENT 'Is Manual Settlement',
    `net_amount` DECIMAL(18,2) COMMENT 'Net Amount',
    `original_currency_code` STRING COMMENT 'Original Currency Code',
    `payment_reference` STRING COMMENT 'Payment Reference',
    `project_code` STRING COMMENT 'Project Code',
    `reconciliation_date` DATE COMMENT 'Reconciliation Date',
    `reconciliation_status` STRING COMMENT 'Reconciliation Status',
    `settlement_approval_timestamp` TIMESTAMP COMMENT 'Settlement Approval Timestamp',
    `settlement_approved_by` STRING COMMENT 'Settlement Approved By',
    `settlement_batch_sequence` STRING COMMENT 'Settlement Batch Sequence',
    `settlement_category` STRING COMMENT 'Settlement Category',
    `settlement_channel` STRING COMMENT 'Settlement Channel',
    `settlement_comment` STRING COMMENT 'Settlement Comment',
    `settlement_created_by` STRING COMMENT 'Settlement Created By',
    `settlement_due_date` DATE COMMENT 'Settlement Due Date',
    `settlement_external_reference` STRING COMMENT 'Settlement External Reference',
    `settlement_legal_entity_code` STRING COMMENT 'Settlement Legal Entity Code',
    `settlement_method` STRING COMMENT 'Settlement Method',
    `settlement_number` STRING COMMENT 'Settlement Number',
    `settlement_priority` STRING COMMENT 'Settlement Priority',
    `settlement_processed_date` DATE COMMENT 'Settlement Processed Date',
    `settlement_reason_code` STRING COMMENT 'Settlement Reason Code',
    `settlement_source_system` STRING COMMENT 'Settlement Source System',
    `settlement_status` STRING COMMENT 'Settlement Status',
    `settlement_timestamp` TIMESTAMP COMMENT 'Settlement Timestamp',
    `settlement_type` STRING COMMENT 'Settlement Type',
    `settlement_version` STRING COMMENT 'Settlement Version',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax Amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_payment_settlement PRIMARY KEY(`payment_settlement_id`)
) COMMENT 'Master reference table for payment_settlement. Referenced by payment_settlement_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`intercompany_group` (
    `intercompany_group_id` BIGINT COMMENT 'Intercompany Group Id',
    `parent_intercompany_group_id` BIGINT COMMENT 'Parent Intercompany Group Id',
    `consolidation_method` STRING COMMENT 'Consolidation Method',
    `cost_center_code` STRING COMMENT 'Cost Center Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `intercompany_group_description` STRING COMMENT 'Description',
    `effective_from` DATE COMMENT 'Effective From',
    `effective_until` DATE COMMENT 'Effective Until',
    `external_reference_number` STRING COMMENT 'External Reference Number',
    `group_code` STRING COMMENT 'Group Code',
    `group_name` STRING COMMENT 'Group Name',
    `group_type` STRING COMMENT 'Group Type',
    `intercompany_accounting_rule` STRING COMMENT 'Intercompany Accounting Rule',
    `is_cross_border` BOOLEAN COMMENT 'Is Cross Border',
    `is_taxable` BOOLEAN COMMENT 'Is Taxable',
    `last_review_date` DATE COMMENT 'Last Review Date',
    `next_review_date` DATE COMMENT 'Next Review Date',
    `notes` STRING COMMENT 'Notes',
    `profit_center_code` STRING COMMENT 'Profit Center Code',
    `region_code` STRING COMMENT 'Region Code',
    `reporting_currency` STRING COMMENT 'Reporting Currency',
    `secondary_legal_entity_ids` STRING COMMENT 'Secondary Legal Entity Ids',
    `intercompany_group_status` STRING COMMENT 'Status',
    `tax_regime` STRING COMMENT 'Tax Regime',
    `updated_by` STRING COMMENT 'Updated By',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    `created_by` STRING COMMENT 'Created By',
    CONSTRAINT pk_intercompany_group PRIMARY KEY(`intercompany_group_id`)
) COMMENT 'Master reference table for intercompany_group. Referenced by intercompany_group_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`allocation_cycle` (
    `allocation_cycle_id` BIGINT COMMENT 'Allocation Cycle Id',
    `previous_allocation_cycle_id` BIGINT COMMENT 'Previous Allocation Cycle Id',
    `actual_amount` DECIMAL(18,2) COMMENT 'Actual Amount',
    `allocation_basis` STRING COMMENT 'Allocation Basis',
    `allocation_method` STRING COMMENT 'Allocation Method',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Allocation Percentage',
    `approved_by` STRING COMMENT 'Approved By',
    `approved_timestamp` TIMESTAMP COMMENT 'Approved Timestamp',
    `budget_amount` DECIMAL(18,2) COMMENT 'Budget Amount',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `cycle_code` STRING COMMENT 'Cycle Code',
    `cycle_name` STRING COMMENT 'Cycle Name',
    `cycle_type` STRING COMMENT 'Cycle Type',
    `allocation_cycle_description` STRING COMMENT 'Description',
    `end_date` DATE COMMENT 'End Date',
    `fiscal_year` STRING COMMENT 'Fiscal Year',
    `is_current` BOOLEAN COMMENT 'Is Current',
    `period_number` STRING COMMENT 'Period Number',
    `start_date` DATE COMMENT 'Start Date',
    `allocation_cycle_status` STRING COMMENT 'Status',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    `version_number` STRING COMMENT 'Version Number',
    CONSTRAINT pk_allocation_cycle PRIMARY KEY(`allocation_cycle_id`)
) COMMENT 'Master reference table for allocation_cycle. Referenced by allocation_cycle_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`intercompany_loan` (
    `intercompany_loan_id` BIGINT COMMENT 'Intercompany Loan Id',
    `company_code_id` BIGINT COMMENT 'Borrower Company Company Code Id',
    `intercompany_company_code_id` BIGINT COMMENT 'Company Code Id',
    `accounting_code` STRING COMMENT 'Accounting Code',
    `accrued_interest` DECIMAL(18,2) COMMENT 'Accrued Interest',
    `amortization_method` STRING COMMENT 'Amortization Method',
    `approval_date` DATE COMMENT 'Approval Date',
    `approved_by` STRING COMMENT 'Approved By',
    `collateral_type` STRING COMMENT 'Collateral Type',
    `collateral_value` DECIMAL(18,2) COMMENT 'Collateral Value',
    `covenant_details` STRING COMMENT 'Covenant Details',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `default_date` DATE COMMENT 'Default Date',
    `default_flag` BOOLEAN COMMENT 'Default Flag',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Early Termination Fee',
    `effective_from` DATE COMMENT 'Effective From',
    `effective_until` DATE COMMENT 'Effective Until',
    `exchange_rate_at_inception` DECIMAL(18,2) COMMENT 'Exchange Rate At Inception',
    `guarantee_type` STRING COMMENT 'Guarantee Type',
    `interest_accrual_method` STRING COMMENT 'Interest Accrual Method',
    `interest_cap` DECIMAL(18,2) COMMENT 'Interest Cap',
    `interest_rate` DECIMAL(18,2) COMMENT 'Interest Rate',
    `interest_rate_type` STRING COMMENT 'Interest Rate Type',
    `internal_audit_status` STRING COMMENT 'Internal Audit Status',
    `is_cross_border` BOOLEAN COMMENT 'Is Cross Border',
    `last_payment_date` DATE COMMENT 'Last Payment Date',
    `legal_document_reference` STRING COMMENT 'Legal Document Reference',
    `loan_agreement_number` STRING COMMENT 'Loan Agreement Number',
    `loan_category` STRING COMMENT 'Loan Category',
    `loan_purpose` STRING COMMENT 'Loan Purpose',
    `loan_status` STRING COMMENT 'Loan Status',
    `loan_type` STRING COMMENT 'Loan Type',
    `next_payment_date` DATE COMMENT 'Next Payment Date',
    `notes` STRING COMMENT 'Notes',
    `outstanding_principal` DECIMAL(18,2) COMMENT 'Outstanding Principal',
    `principal_amount` DECIMAL(18,2) COMMENT 'Principal Amount',
    `repayment_frequency` STRING COMMENT 'Repayment Frequency',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_intercompany_loan PRIMARY KEY(`intercompany_loan_id`)
) COMMENT 'Master reference table for intercompany_loan. Referenced by related_loan_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Legal Entity Id',
    `company_code_id` BIGINT COMMENT 'Company Code Id',
    `parent_legal_entity_id` BIGINT COMMENT 'Parent Legal Entity Id',
    `country_code` STRING COMMENT 'Country Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `entity_code` STRING COMMENT 'Entity Code',
    `entity_name` STRING COMMENT 'Entity Name',
    `entity_status` STRING COMMENT 'Entity Status',
    `entity_type` STRING COMMENT 'Entity Type',
    `functional_currency` STRING COMMENT 'Functional Currency',
    `incorporation_date` DATE COMMENT 'Incorporation Date',
    `primary_contact_name` STRING COMMENT 'Primary Contact Name',
    `registration_number` STRING COMMENT 'Registration Number',
    `reporting_currency` STRING COMMENT 'Reporting Currency',
    `tax_identification_number` STRING COMMENT 'Tax Id',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master reference table for legal_entity. Referenced by primary_legal_entity_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_intercompany_group_id` FOREIGN KEY (`intercompany_group_id`) REFERENCES `vibe_automotive_v1`.`finance`.`intercompany_group`(`intercompany_group_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_automotive_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_automotive_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_automotive_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_automotive_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_automotive_v1`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_payment_settlement_id` FOREIGN KEY (`payment_settlement_id`) REFERENCES `vibe_automotive_v1`.`finance`.`payment_settlement`(`payment_settlement_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_automotive_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_ar_intercompany_entity_company_code_id` FOREIGN KEY (`ar_intercompany_entity_company_code_id`) REFERENCES `vibe_automotive_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_finance_project_id` FOREIGN KEY (`finance_project_id`) REFERENCES `vibe_automotive_v1`.`finance`.`finance_project`(`finance_project_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_automotive_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `vibe_automotive_v1`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ADD CONSTRAINT `fk_finance_manufacturing_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ADD CONSTRAINT `fk_finance_warranty_reserve_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ADD CONSTRAINT `fk_finance_warranty_reserve_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ADD CONSTRAINT `fk_finance_finance_inventory_valuation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ADD CONSTRAINT `fk_finance_finance_inventory_valuation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_automotive_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ADD CONSTRAINT `fk_finance_finance_inventory_valuation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_automotive_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_automotive_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_intercompany_group_id` FOREIGN KEY (`intercompany_group_id`) REFERENCES `vibe_automotive_v1`.`finance`.`intercompany_group`(`intercompany_group_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_intercompany_loan_id` FOREIGN KEY (`intercompany_loan_id`) REFERENCES `vibe_automotive_v1`.`finance`.`intercompany_loan`(`intercompany_loan_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_allocation_cycle_id` FOREIGN KEY (`allocation_cycle_id`) REFERENCES `vibe_automotive_v1`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_automotive_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_automotive_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_automotive_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_finance_project_id` FOREIGN KEY (`finance_project_id`) REFERENCES `vibe_automotive_v1`.`finance`.`finance_project`(`finance_project_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`currency_rate` ADD CONSTRAINT `fk_finance_currency_rate_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_automotive_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_parent_wbs_wbs_element_id` FOREIGN KEY (`parent_wbs_wbs_element_id`) REFERENCES `vibe_automotive_v1`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_finance_project_id` FOREIGN KEY (`finance_project_id`) REFERENCES `vibe_automotive_v1`.`finance`.`finance_project`(`finance_project_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_project` ADD CONSTRAINT `fk_finance_finance_project_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_automotive_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_project` ADD CONSTRAINT `fk_finance_finance_project_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_automotive_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`payment_settlement` ADD CONSTRAINT `fk_finance_payment_settlement_reversed_payment_settlement_id` FOREIGN KEY (`reversed_payment_settlement_id`) REFERENCES `vibe_automotive_v1`.`finance`.`payment_settlement`(`payment_settlement_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_group` ADD CONSTRAINT `fk_finance_intercompany_group_parent_intercompany_group_id` FOREIGN KEY (`parent_intercompany_group_id`) REFERENCES `vibe_automotive_v1`.`finance`.`intercompany_group`(`intercompany_group_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_previous_allocation_cycle_id` FOREIGN KEY (`previous_allocation_cycle_id`) REFERENCES `vibe_automotive_v1`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_loan` ADD CONSTRAINT `fk_finance_intercompany_loan_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_automotive_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_loan` ADD CONSTRAINT `fk_finance_intercompany_loan_intercompany_company_code_id` FOREIGN KEY (`intercompany_company_code_id`) REFERENCES `vibe_automotive_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_automotive_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_automotive_v1`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `vibe_automotive_v1`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_automotive_v1`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` SET TAGS ('dbx_layer' = 'master');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` SET TAGS ('dbx_source_system' = 'SAP FI/SAP CO');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Identifier');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `balance_type` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet vs. Profit & Loss Classification');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `balance_type` SET TAGS ('dbx_value_regex' = 'profit_and_loss|balance_sheet');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts_version` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts Version');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_description` SET TAGS ('dbx_business_glossary_term' = 'GL Account Description');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_business_glossary_term' = 'GL Account Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `is_budgeted` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Account Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `is_consolidation_account` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `is_reconciliation_account` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `is_tax_relevant` SET TAGS ('dbx_business_glossary_term' = 'Tax Relevance Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `last_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Last Posting Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `reporting_level` SET TAGS ('dbx_business_glossary_term' = 'Reporting Level');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `reporting_level` SET TAGS ('dbx_value_regex' = 'company|division|plant|region|country');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'OEM|Aftermarket|Service|R&D');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_value_regex' = 'taxable|exempt|zero|reverse');
ALTER TABLE `vibe_automotive_v1`.`finance`.`gl_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` SET TAGS ('dbx_layer' = 'master');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'fixed|percentage|activity_based|none');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'cost_center|profit_center|investment_center');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'production|administration|research|sales|service');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `reporting_level` SET TAGS ('dbx_business_glossary_term' = 'Reporting Level');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `reporting_level` SET TAGS ('dbx_value_regex' = 'plant|division|global');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_center` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` SET TAGS ('dbx_layer' = 'master');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Owner Identifier');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Owner Identifier');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center Identifier');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `primary_profit_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Profit Manager Employee Id');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `primary_profit_manager_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `profit_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Manager Identifier');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `profit_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `profit_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount (USD)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Log');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (USD)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_category` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Category');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|NonCompliant|Pending');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `ebitda_amount` SET TAGS ('dbx_business_glossary_term' = 'EBITDA Amount (USD)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Path');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_level` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Level');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Percentage');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Owner Name');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount (USD)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_group` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Group');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Planned|Closed');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'Legal|Operating|Reporting');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = 'NA|EU|APAC|LATAM|MEA');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'Annual|Quarterly');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Segment (Segment)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'EV|ICE|HEV|PHEV|Commercial|Luxury');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`profit_center` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` SET TAGS ('dbx_subdomain' = 'corporate_structure');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` SET TAGS ('dbx_layer' = 'master');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `intercompany_group_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Group Identifier');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `business_line` SET TAGS ('dbx_business_glossary_term' = 'Business Line');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts Assignment');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code (SAP)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_business_glossary_term' = 'Entity Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 alpha-3)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'legal_entity|joint_venture|subsidiary|branch|holding');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = 'FY01|FY02|FY03|FY04|FY05|FY06');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `functional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `industry_sector` SET TAGS ('dbx_value_regex' = 'passenger_vehicles|commercial_vehicles|components|services|software');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `local_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Company Registration Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Standard');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_value_regex' = 'IFRS|GAAP|IFRS_FOR_SME|US_GAAP|EU_GAAP');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Reporting Segment');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Short Name');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`company_code` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` SET TAGS ('dbx_subdomain' = 'corporate_structure');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` SET TAGS ('dbx_layer' = 'master');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Identifier');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `accrual_cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Cutoff Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_description` SET TAGS ('dbx_business_glossary_term' = 'Period Description');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_status` SET TAGS ('dbx_value_regex' = 'open|closed|locked');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `is_current_period` SET TAGS ('dbx_business_glossary_term' = 'Current Period Indicator');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `is_interim` SET TAGS ('dbx_business_glossary_term' = 'Interim Period Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `lock_date` SET TAGS ('dbx_business_glossary_term' = 'Period Lock Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Period Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'regular|adjustment|special');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `posting_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Deadline Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fiscal_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` SET TAGS ('dbx_source_system' = 'SAP FI/SAP CO');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posting User ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_posting_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posting User ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_posting_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_posting_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Document Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CUR)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator (DC)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `document_language` SET TAGS ('dbx_business_glossary_term' = 'Document Language');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Document Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type (DT)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'SA|KR|AB|DR|CR');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `is_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `is_manual_entry` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `is_test_entry` SET TAGS ('dbx_business_glossary_term' = 'Test Entry Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending|error');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant (PLANT)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_category` SET TAGS ('dbx_business_glossary_term' = 'Posting Category');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_reference` SET TAGS ('dbx_business_glossary_term' = 'Posting Reference');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_text` SET TAGS ('dbx_business_glossary_term' = 'Posting Text');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_user_role` SET TAGS ('dbx_business_glossary_term' = 'Posting User Role');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Reporting Segment');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `source_module` SET TAGS ('dbx_business_glossary_term' = 'Source Module');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_cc` SET TAGS ('dbx_business_glossary_term' = 'Posting Amount (Company Code Currency)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `amount_tc` SET TAGS ('dbx_business_glossary_term' = 'Posting Amount (Transaction Currency)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `assignment` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `currency_cc` SET TAGS ('dbx_business_glossary_term' = 'Company Code Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `currency_cc` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `currency_tc` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `currency_tc` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Quantity');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_item` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Item');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`journal_entry_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'payables_settlement');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Invoice ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `trade_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Record Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number (GR_NO)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number (INV_NO)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|open|approved|paid|rejected|cancelled');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `is_credit_memo` SET TAGS ('dbx_business_glossary_term' = 'Is Credit Memo');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|Wire|Check|CreditCard|Cash');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_TERM)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'Net30|Net45|Net60|EOM|2%_10');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `ppap_status` SET TAGS ('dbx_business_glossary_term' = 'PPAP Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `ppap_status` SET TAGS ('dbx_value_regex' = 'NotStarted|InProgress|Approved|Rejected');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO_NO)');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = 'VAT|GST|SALES|NONE');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_invoice` ALTER COLUMN `warranty_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Warranty Reserve Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` SET TAGS ('dbx_subdomain' = 'payables_settlement');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Payment ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Settlement ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Payment Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CNY|CAD');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `early_payment_discount_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Applied');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `house_bank_code` SET TAGS ('dbx_business_glossary_term' = 'House Bank Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated Payment');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'online|batch|manual');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_comments` SET TAGS ('dbx_business_glossary_term' = 'Payment Comments');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_error_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Error Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_gl_account` SET TAGS ('dbx_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire|check|eft');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_original_currency` SET TAGS ('dbx_business_glossary_term' = 'Original Currency');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_original_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CNY|CAD');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_priority` SET TAGS ('dbx_business_glossary_term' = 'Payment Priority');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_priority` SET TAGS ('dbx_value_regex' = 'high|normal|low');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'External Payment Reference');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Settlement Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|cleared|failed|reversed');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'outbound|inbound');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_vat_amount` SET TAGS ('dbx_business_glossary_term' = 'VAT Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ap_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'receivables_billing');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'AR Invoice ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `accounting_date` SET TAGS ('dbx_business_glossary_term' = 'Accounting Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_status` SET TAGS ('dbx_business_glossary_term' = 'AR Invoice Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `billing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Document Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `discount_reason` SET TAGS ('dbx_business_glossary_term' = 'Discount Reason');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_category` SET TAGS ('dbx_business_glossary_term' = 'Invoice Category');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `sales_org_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Org Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `warranty_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Warranty Reserve Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_invoice` ALTER COLUMN `warranty_reserve_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Reserve Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` SET TAGS ('dbx_subdomain' = 'receivables_billing');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_id` SET TAGS ('dbx_business_glossary_term' = 'AR Payment ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_posted_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_posted_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_status` SET TAGS ('dbx_business_glossary_term' = 'AR Payment Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `cash_application_status` SET TAGS ('dbx_business_glossary_term' = 'Cash Application Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `is_partial_payment` SET TAGS ('dbx_business_glossary_term' = 'Is Partial Payment');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_source` SET TAGS ('dbx_business_glossary_term' = 'Payment Source');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `remittance_reference` SET TAGS ('dbx_business_glossary_term' = 'Remittance Reference');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`ar_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Request ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `capex_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `capex_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `capex_requested_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `capex_requested_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `capex_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `capex_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `primary_capex_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `primary_capex_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `capex_request_status` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Request Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `depreciation_years` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Years');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `capex_request_description` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Request Description');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `external_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'External Funding Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `has_external_funding` SET TAGS ('dbx_business_glossary_term' = 'Has External Funding');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `investment_category` SET TAGS ('dbx_business_glossary_term' = 'Investment Category');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `irr` SET TAGS ('dbx_business_glossary_term' = 'IRR');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `is_capitalized` SET TAGS ('dbx_business_glossary_term' = 'Is Capitalized');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `is_compliant` SET TAGS ('dbx_business_glossary_term' = 'Is Compliant');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Justification');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `npv` SET TAGS ('dbx_business_glossary_term' = 'NPV');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `payback_period_years` SET TAGS ('dbx_business_glossary_term' = 'Payback Period Years');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `supporting_document_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document URL');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `tax_implication` SET TAGS ('dbx_business_glossary_term' = 'Tax Implication');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`capex_request` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'WBS Element');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` SET TAGS ('dbx_layer' = 'planning');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `budget_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'GL Account');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `is_forecast` SET TAGS ('dbx_business_glossary_term' = 'Is Forecast');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Is Locked');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `planning_period` SET TAGS ('dbx_business_glossary_term' = 'Planning Period');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `scenario` SET TAGS ('dbx_business_glossary_term' = 'Scenario');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` SET TAGS ('dbx_layer' = 'planning');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `amount_type` SET TAGS ('dbx_business_glossary_term' = 'Amount Type');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `is_manual` SET TAGS ('dbx_business_glossary_term' = 'Is Manual');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Justification');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `line_quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Quantity');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`budget_line` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `manufacturing_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Cost ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `actual_energy_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Energy Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `actual_fixed_overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Fixed Overhead Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `actual_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Material Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `actual_scrap_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Scrap Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `actual_tooling_amortization_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Tooling Amortization Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `actual_variable_overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Variable Overhead Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `cost_calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cost Calculation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `cost_record_number` SET TAGS ('dbx_business_glossary_term' = 'Cost Record Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `cost_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `cost_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Percent');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `costing_date` SET TAGS ('dbx_business_glossary_term' = 'Costing Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `costing_version` SET TAGS ('dbx_business_glossary_term' = 'Costing Version');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `is_variance_exceed_threshold` SET TAGS ('dbx_business_glossary_term' = 'Is Variance Exceed Threshold');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `manufacturing_cost_status` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Cost Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `standard_energy_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Energy Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `standard_fixed_overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Fixed Overhead Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `standard_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Labor Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `standard_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Material Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `standard_scrap_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Scrap Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `standard_tooling_amortization_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Tooling Amortization Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `standard_variable_overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Variable Overhead Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `total_actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `total_standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Standard Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `variance_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `vehicle_line` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Line');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `vehicle_model_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Model Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`manufacturing_cost` ALTER COLUMN `vehicle_model_year` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Model Year');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `warranty_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Warranty Reserve ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `accrual_basis` SET TAGS ('dbx_business_glossary_term' = 'Accrual Basis');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `actuarial_review_date` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Review Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `claims_charged` SET TAGS ('dbx_business_glossary_term' = 'Claims Charged');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `estimated_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Per Unit');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `is_ifrs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Is IFRS Compliant');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `is_sox_controlled` SET TAGS ('dbx_business_glossary_term' = 'Is SOX Controlled');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `last_actuarial_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Actuarial Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `reserve_adequacy_ratio` SET TAGS ('dbx_business_glossary_term' = 'Reserve Adequacy Ratio');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `reserve_balance` SET TAGS ('dbx_business_glossary_term' = 'Reserve Balance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `reserve_description` SET TAGS ('dbx_business_glossary_term' = 'Reserve Description');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `reserve_number` SET TAGS ('dbx_business_glossary_term' = 'Reserve Number');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `reserve_source` SET TAGS ('dbx_business_glossary_term' = 'Reserve Source');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `units_sold` SET TAGS ('dbx_business_glossary_term' = 'Units Sold');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `vehicle_line` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Line');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `warranty_claims_amount` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claims Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `warranty_claims_count` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claims Count');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `warranty_reserve_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Reserve Status');
ALTER TABLE `vibe_automotive_v1`.`finance`.`warranty_reserve` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `finance_inventory_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Inventory Valuation ID');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `actual_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Unit Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `is_consignment` SET TAGS ('dbx_business_glossary_term' = 'Is Consignment');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `obsolescence_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Provision Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `standard_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Unit Cost');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `total_valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Valuation Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_inventory_valuation` ALTER COLUMN `write_down_amount` SET TAGS ('dbx_business_glossary_term' = 'Write Down Amount');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_layer' = 'master');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`depreciation_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`depreciation_run` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_automotive_v1`.`finance`.`depreciation_run` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`depreciation_run` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`depreciation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`depreciation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_settlement` SET TAGS ('dbx_subdomain' = 'corporate_structure');
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_settlement` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_settlement` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`tax_posting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`tax_posting` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_automotive_v1`.`finance`.`tax_posting` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`tax_posting` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`accrual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`accrual` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_automotive_v1`.`finance`.`accrual` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`accrual` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`currency_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`currency_rate` SET TAGS ('dbx_subdomain' = 'corporate_structure');
ALTER TABLE `vibe_automotive_v1`.`finance`.`currency_rate` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`currency_rate` SET TAGS ('dbx_layer' = 'master');
ALTER TABLE `vibe_automotive_v1`.`finance`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`wbs_element` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_automotive_v1`.`finance`.`wbs_element` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`wbs_element` SET TAGS ('dbx_layer' = 'master');
ALTER TABLE `vibe_automotive_v1`.`finance`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_responsible_person_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`wbs_element` ALTER COLUMN `wbs_responsible_person_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`financial_period_close` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`financial_period_close` SET TAGS ('dbx_subdomain' = 'ledger_accounting');
ALTER TABLE `vibe_automotive_v1`.`finance`.`financial_period_close` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`financial_period_close` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`financial_period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`financial_period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`financial_period_close` ALTER COLUMN `financial_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`financial_period_close` ALTER COLUMN `approver_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`finance`.`dealer_incentive` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`dealer_incentive` SET TAGS ('dbx_subdomain' = 'receivables_billing');
ALTER TABLE `vibe_automotive_v1`.`finance`.`dealer_incentive` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`dealer_incentive` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`dealer_incentive` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`dealer_incentive` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`vehicle_profitability` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`vehicle_profitability` SET TAGS ('dbx_subdomain' = 'receivables_billing');
ALTER TABLE `vibe_automotive_v1`.`finance`.`vehicle_profitability` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`vehicle_profitability` SET TAGS ('dbx_layer' = 'analytics');
ALTER TABLE `vibe_automotive_v1`.`finance`.`vehicle_profitability` ALTER COLUMN `fi_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'F&I Revenue');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_project` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_project` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`finance_project` SET TAGS ('dbx_layer' = 'master');
ALTER TABLE `vibe_automotive_v1`.`finance`.`payment_settlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`payment_settlement` SET TAGS ('dbx_subdomain' = 'payables_settlement');
ALTER TABLE `vibe_automotive_v1`.`finance`.`payment_settlement` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`payment_settlement` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_group` SET TAGS ('dbx_subdomain' = 'corporate_structure');
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_group` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_group` SET TAGS ('dbx_layer' = 'master');
ALTER TABLE `vibe_automotive_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `vibe_automotive_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_layer' = 'master');
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_loan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_loan` SET TAGS ('dbx_subdomain' = 'corporate_structure');
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_loan` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`intercompany_loan` SET TAGS ('dbx_layer' = 'transaction');
ALTER TABLE `vibe_automotive_v1`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'corporate_structure');
ALTER TABLE `vibe_automotive_v1`.`finance`.`legal_entity` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_automotive_v1`.`finance`.`legal_entity` SET TAGS ('dbx_layer' = 'master');
ALTER TABLE `vibe_automotive_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_automotive_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_sensitivity' = 'pii');
