-- Schema for Domain: finance | Business: Automotive | Version: v1_mvm
-- Generated on: 2026-05-07 02:20:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `automotive_ecm`.`finance` COMMENT 'Core financial management including general ledger, accounts payable, accounts receivable, cost center accounting, and financial reporting. Manages CapEx (Capital Expenditure) tracking, budget planning, FY (Fiscal Year) close, EBITDA reporting, profitability analysis by vehicle line/plant/region, and intercompany settlements. Tracks manufacturing cost (material, labor, overhead), warranty reserves, and inventory valuation. Supports SOX compliance, IFRS/GAAP reporting. Integrates with SAP FI/CO.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `automotive_ecm`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'System-generated unique identifier for the GL account record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: gl_account.cost_center_code is a denormalized string reference to the cost center. Adding cost_center_id FK normalizes this relationship, allowing JOIN to cost_center for all cost center attributes. T',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: gl_account.profit_center_code is a denormalized string reference to the profit center. Adding profit_center_id FK normalizes this relationship. In SAP FI, GL accounts are assigned to profit centers fo',
    `account_code` STRING COMMENT 'External business code used to identify the GL account in the chart of accounts.',
    `account_group` STRING COMMENT 'Higher‑level grouping used for reporting and posting rules.',
    `account_name` STRING COMMENT 'Human‑readable name or title of the GL account.',
    `account_type` STRING COMMENT 'Classification of the account as asset, liability, equity, revenue, or expense.. Valid values are `asset|liability|equity|revenue|expense`',
    `balance_type` STRING COMMENT 'Indicates whether the account is reported on the balance sheet or the profit & loss statement.. Valid values are `profit_and_loss|balance_sheet`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget amount allocated to the account for the fiscal year, expressed in the account currency.',
    `chart_of_accounts_version` STRING COMMENT 'Version identifier of the chart of accounts in which this account is defined.',
    `closing_balance` DECIMAL(18,2) COMMENT 'Balance of the account at the end of the fiscal year.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the GL account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code in which the account balances are expressed.',
    `effective_from` DATE COMMENT 'Date on which the GL account becomes active for posting.',
    `effective_to` DATE COMMENT 'Date on which the GL account is retired or becomes inactive; null if open‑ended.',
    `fiscal_year` STRING COMMENT 'Fiscal year (FY) to which the account is primarily associated for budgeting.',
    `gl_account_description` STRING COMMENT 'Free‑form description providing additional context about the account.',
    `gl_account_status` STRING COMMENT 'Current lifecycle status of the account.. Valid values are `active|inactive|blocked|pending`',
    `is_budgeted` BOOLEAN COMMENT 'True if the account has an associated budget for the fiscal year.',
    `is_consolidation_account` BOOLEAN COMMENT 'Indicates whether the account participates in legal entity consolidation reporting.',
    `is_deprecated` BOOLEAN COMMENT 'True if the account is scheduled for phase‑out and should no longer be used for new postings.',
    `is_reconciliation_account` BOOLEAN COMMENT 'True if the account is used as a reconciliation (clearing) account for sub‑ledger postings.',
    `is_tax_relevant` BOOLEAN COMMENT 'Indicates whether the account participates in tax calculations.',
    `last_posting_date` DATE COMMENT 'Date of the most recent posting to this GL account.',
    `last_reconciliation_date` DATE COMMENT 'Date when the account was last reconciled with sub‑ledger balances.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Balance of the account at the start of the fiscal year.',
    `reporting_level` STRING COMMENT 'Level in the reporting hierarchy at which the account is aggregated.. Valid values are `company|division|plant|region|country`',
    `segment` STRING COMMENT 'Business segment to which the account belongs (e.g., OEM, Aftermarket, Service, R&D).. Valid values are `OEM|Aftermarket|Service|R&D`',
    `tax_category` STRING COMMENT 'Category defining the tax treatment applied to postings in this account.. Valid values are `taxable|exempt|zero|reverse`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the GL account record.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'General Ledger (GL) account master record aligned with SAP FI chart of accounts. Defines each account in the corporate chart of accounts including account type (asset, liability, equity, revenue, expense), account group, P&L vs balance sheet classification, currency, tax category, and reconciliation account flags. SSOT for all GL account definitions used across FI/CO postings, IFRS/GAAP reporting, and SOX compliance controls.';

CREATE OR REPLACE TABLE `automotive_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique surrogate key for the cost center master record.',
    `parent_cost_center_id` BIGINT COMMENT 'Identifier of the immediate parent cost center in the hierarchy (null for top‑level).',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant to which the cost center is assigned.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Cumulative actual expenses posted to the cost center.',
    `allocation_method` STRING COMMENT 'Method used to allocate indirect costs to the cost center.. Valid values are `fixed|percentage|activity_based|none`',
    `approval_status` STRING COMMENT 'Current approval state of the cost centers budget.. Valid values are `pending|approved|rejected`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned budget amount allocated to the cost center for the fiscal year.',
    `cost_center_category` STRING COMMENT 'Higher‑level classification of the cost center for reporting purposes.. Valid values are `cost_center|profit_center|investment_center`',
    `cost_center_code` STRING COMMENT 'External business code assigned to the cost center (e.g., SAP CO cost center code).',
    `cost_center_description` STRING COMMENT 'Free‑form description of the cost center purpose and scope.',
    `cost_center_name` STRING COMMENT 'Human‑readable name of the cost center used in reports and UI.',
    `cost_center_status` STRING COMMENT 'Current operational status of the cost center.. Valid values are `active|inactive|planned|closed`',
    `cost_center_type` STRING COMMENT 'Category of the cost center indicating its primary function within the organization.. Valid values are `production|administration|research|sales|service`',
    `country` STRING COMMENT 'Three‑letter ISO country code of the cost centers primary location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost center record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code used for budgeting and reporting.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'Date when the cost center becomes valid for posting costs.',
    `effective_to` DATE COMMENT 'Date when the cost center is retired or no longer valid (nullable).',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the budget is defined (e.g., FY2025).',
    `hierarchy_level` STRING COMMENT 'Depth of the cost center within the organizational hierarchy (1 = top level).',
    `last_review_date` DATE COMMENT 'Date when the cost centers budget and performance were last reviewed.',
    `region` STRING COMMENT 'Business region (e.g., North America, Europe) where the cost center operates.',
    `reporting_level` STRING COMMENT 'Level at which the cost center is aggregated for financial reporting.. Valid values are `plant|division|global`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cost center record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between budgeted and actual spend (budget – actual).',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Cost center master record representing an organizational unit to which manufacturing costs, labor, overhead, and indirect expenses are assigned. Aligned with SAP CO cost center accounting (CCA). Captures cost center hierarchy, responsible manager, plant assignment, profit center linkage, valid-from/to dates, currency, and cost center category (production, administration, R&D, sales). Supports EBITDA reporting and profitability analysis by plant, vehicle line, and region.';

CREATE OR REPLACE TABLE `automotive_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique surrogate key for the profit center record.',
    `parent_profit_center_id` BIGINT COMMENT 'Identifier of the immediate parent profit center in the hierarchy.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant associated with the profit center.',
    `actual_amount` DECIMAL(18,2) COMMENT 'Actual realized amount for the profit center in the current period.',
    `audit_trail` STRING COMMENT 'JSON‑encoded log of significant changes to the profit center record.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget for the profit center for the fiscal year.',
    `closure_date` DATE COMMENT 'Date on which the profit center was officially closed.',
    `company_code` STRING COMMENT 'SAP company code to which the profit center belongs.',
    `compliance_status` STRING COMMENT 'Current compliance status with internal and external regulatory requirements.. Valid values are `Compliant|NonCompliant|Pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the profit center record was first created.',
    `currency_code` STRING COMMENT 'Currency in which the profit center records its transactions.. Valid values are `^[A-Z]{3}$`',
    `ebitda_amount` DECIMAL(18,2) COMMENT 'Earnings before interest, taxes, depreciation, and amortization for the profit center.',
    `effective_from` DATE COMMENT 'Date when the profit center became operational.',
    `effective_to` DATE COMMENT 'Date when the profit center is scheduled to be retired (nullable for open‑ended).',
    `external_reference` STRING COMMENT 'Identifier used in external ERP or reporting systems to reference this profit center.',
    `hierarchy_path` STRING COMMENT 'Slash‑delimited path showing the profit centers position in the hierarchy (e.g., /1000/2000/3000).',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the profit center is included in corporate consolidation.',
    `is_intercompany` BOOLEAN COMMENT 'True if the profit center participates in intercompany transactions.',
    `last_review_date` DATE COMMENT 'Date of the most recent financial or operational review.',
    `margin_percent` DECIMAL(18,2) COMMENT 'Profit margin expressed as a percentage of revenue.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the profit center.',
    `owner` STRING COMMENT 'Name of the business owner or sponsor of the profit center.',
    `plan_amount` DECIMAL(18,2) COMMENT 'Planned financial amount for the upcoming period.',
    `profit_center_category` STRING COMMENT 'High‑level category such as Vehicle Line, Service, Parts, or Finance.',
    `profit_center_code` STRING COMMENT 'Business identifier code used in SAP and external reports.',
    `profit_center_description` STRING COMMENT 'Free‑form description of the profit centers purpose and scope.',
    `profit_center_group` STRING COMMENT 'Logical grouping used for internal reporting (e.g., Group A, Group B).',
    `profit_center_level` STRING COMMENT 'Numeric depth of the profit center within the organizational hierarchy.',
    `profit_center_name` STRING COMMENT 'Human‑readable name of the profit center.',
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

CREATE OR REPLACE TABLE `automotive_ecm`.`finance`.`company_code` (
    `company_code_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying the company code record.',
    `address_line1` STRING COMMENT 'Primary street address of the legal entity.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `business_line` STRING COMMENT 'Primary business line or functional area of the entity. [ENUM-REF-CANDIDATE: design_engineering|manufacturing|sales|after_sales|r&d|finance|procurement — 7 candidates stripped; promote to reference product]',
    `chart_of_accounts` STRING COMMENT 'Identifier of the chart of accounts used for financial posting.',
    `city` STRING COMMENT 'City where the legal entity is located.',
    `company_code` STRING COMMENT 'Alphanumeric identifier used in SAP FI to represent the legal entity (e.g., US01, DE02).',
    `company_code_status` STRING COMMENT 'Current operational status of the legal entity.. Valid values are `active|inactive|closed|pending`',
    `consolidation_group` STRING COMMENT 'Group identifier used for legal consolidation of financial statements.',
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

CREATE OR REPLACE TABLE `automotive_ecm`.`finance`.`fiscal_period` (
    `fiscal_period_id` BIGINT COMMENT 'System-generated unique identifier for the fiscal period record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: fiscal_period.company_code is a denormalized STRING attribute. In SAP FI, fiscal periods are defined per company code (fiscal year variant is company-code-specific). Adding company_code_id FK normaliz',
    `accrual_cutoff_date` DATE COMMENT 'Date after which accruals are no longer allowed for this period.',
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

CREATE OR REPLACE TABLE `automotive_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Replace string company_code with FK to company_code for proper relational integrity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Reference cost_center master instead of free‑text code.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Link journal entry to fiscal period master for consistent period handling.',
    `party_id` BIGINT COMMENT 'Identifier of the business partner (vendor, customer, or other) associated with the entry.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Reference profit_center master for reporting consistency.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Automotive OEMs track compliance-related costs (certification fees, testing expenses, regulatory fines, remediation costs) in journal entries. Finance teams need to report compliance spending by regul',
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
    `source_system` STRING COMMENT 'Source system that generated the entry (e.g., SAP S/4HANA).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount calculated for the entry.',
    `tax_code` STRING COMMENT 'Tax code applied to the entry for tax determination.',
    `tax_jurisdiction` STRING COMMENT 'Tax jurisdiction code applicable to the entry.',
    `transaction_code` STRING COMMENT 'Code representing the business transaction (e.g., AP, AR).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the journal entry record.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'General ledger journal entry header record capturing all financial postings in the SAP FI ledger. Represents the primary transactional record for every accounting document including goods issue postings, vendor invoice postings, customer payments, accruals, depreciation runs, intercompany settlements, and manual adjustments. Captures document type, posting date, fiscal year/period, company code, reference document, posting user, reversal indicator, and ledger group (IFRS vs local GAAP). SSOT for all GL postings.';

CREATE OR REPLACE TABLE `automotive_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'System-generated unique identifier for the journal entry line record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Link line to cost_center master for cost allocation.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: journal_entry_line has fiscal_period (STRING) and fiscal_year (STRING) as denormalized attributes. The journal_entry header already has fiscal_period_id FK. Adding fiscal_period_id to the line item no',
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

CREATE OR REPLACE TABLE `automotive_ecm`.`finance`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'System-generated unique identifier for the AR invoice record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ar_invoice.cost_center_code is a denormalized STRING reference to the cost center. Adding cost_center_id FK normalizes this relationship, enabling cost center-based AR reporting and profitability anal',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: ar_invoice has fiscal_period (STRING) and fiscal_year (STRING) as denormalized attributes. Adding fiscal_period_id FK normalizes the fiscal period reference on AR invoices, enabling proper period-base',
    `homologation_record_id` BIGINT COMMENT 'Foreign key linking to compliance.homologation_record. Business justification: OEMs invoice customers for homologation and certification services (type approval testing, emissions certification). Invoices reference specific homologation records for billing accuracy and audit tra',
    `company_code_id` BIGINT COMMENT 'Identifier of the related legal entity in an intercompany invoice.',
    `party_id` BIGINT COMMENT 'Unique identifier of the customer or dealer billed on the invoice.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: ar_invoice.profit_center_code is a denormalized STRING reference to the profit center. Adding profit_center_id FK normalizes this relationship, enabling profit center-based revenue and AR reporting. T',
    `vehicle_order_id` BIGINT COMMENT 'Foreign key linking to sales.vehicle_order. Business justification: Invoices must reference originating vehicle order for reconciliation, warranty start date tracking, and dispute resolution. Essential for automotive order-to-cash process and customer service operatio',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Accounts receivable invoices for vehicle sales must reference the VIN registry to validate warranty eligibility and tax reporting.',
    `accounting_date` DATE COMMENT 'Date used for accounting period posting.',
    `aging_bucket` STRING COMMENT 'Age category of the invoice based on days past due.. Valid values are `current|1_30|31_60|61_90|90_plus|unknown`',
    `ar_invoice_status` STRING COMMENT 'Current processing state of the invoice.. Valid values are `draft|open|posted|cancelled|paid|reversed`',
    `billing_document_number` STRING COMMENT 'Reference number of the SAP billing document linked to this invoice.',
    `collection_status` STRING COMMENT 'Status of the invoice in the collections process.. Valid values are `on_time|late|defaulted|written_off|disputed|unknown`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the invoice.',
    `delivery_note_number` STRING COMMENT 'Delivery document associated with the shipped goods.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of any discount applied to the invoice.',
    `discount_reason` STRING COMMENT 'Explanation or code for the discount granted.',
    `distribution_channel` STRING COMMENT 'Channel through which the product was sold (e.g., dealer, fleet, direct).',
    `due_date` DATE COMMENT 'Date by which payment is expected according to payment terms.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, and adjustments.',
    `intercompany_flag` BOOLEAN COMMENT 'True if the invoice is part of an intercompany transaction.',
    `invoice_category` STRING COMMENT 'Business segment or market category for the invoice.. Valid values are `domestic|export|internal|fleet|government|other`',
    `invoice_date` DATE COMMENT 'Date the invoice was issued to the customer.',
    `invoice_number` STRING COMMENT 'External invoice identifier assigned by the billing system.',
    `invoice_type` STRING COMMENT 'High‑level classification of the invoice content.. Valid values are `vehicle_sale|parts|service|lease|subscription|other`',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes and discounts.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Amount actually received from the customer.',
    `payment_method` STRING COMMENT 'Method used by the customer to settle the invoice.. Valid values are `credit_card|bank_transfer|cash|check|online|other`',
    `payment_received_date` DATE COMMENT 'Date on which payment was recorded.',
    `payment_status` STRING COMMENT 'Current status of the payment transaction.. Valid values are `pending|cleared|failed|reversed|partial|unknown`',
    `payment_terms` STRING COMMENT 'Standard payment condition applied to the invoice.. Valid values are `net_30|net_45|net_60|cod|prepaid|milestone`',
    `plant_code` STRING COMMENT 'Manufacturing plant where the vehicle or part was produced.',
    `posting_date` DATE COMMENT 'Date the invoice was posted to the general ledger.',
    `purchase_order_number` STRING COMMENT 'Purchase order from the customer or dealer, if applicable.',
    `region_code` STRING COMMENT 'Geographic region code for reporting and tax purposes.',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue from this invoice is recognized per accounting policy.',
    `sales_order_number` STRING COMMENT 'Sales order that triggered the invoice.',
    `sales_org_code` STRING COMMENT 'Code of the sales organization responsible for the transaction.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax calculated for the invoice.',
    `tax_code` STRING COMMENT 'Tax jurisdiction code used for tax calculation.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the invoice.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the invoice record.',
    `warranty_reserve_amount` DECIMAL(18,2) COMMENT 'Monetary amount set aside for future warranty claims related to this invoice.',
    `warranty_reserve_flag` BOOLEAN COMMENT 'Indicates whether a warranty reserve has been booked for this invoice.',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Accounts Receivable (AR) customer invoice record capturing outgoing invoices issued to dealers, fleet customers, and intercompany entities for vehicle sales, parts, and services. Aligned with SAP FI-AR and SD billing integration. Captures customer/dealer ID, invoice date, due date, payment terms, gross amount, tax amount, net amount, currency, billing document reference, vehicle line, MSRP vs net selling price, and collection status. Supports dealer billing reconciliation and revenue recognition.';

CREATE OR REPLACE TABLE `automotive_ecm`.`finance`.`ar_payment` (
    `ar_payment_id` BIGINT COMMENT 'System-generated unique identifier for the AR payment record.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: ar_payment.invoice_number is a denormalized STRING reference to the AR invoice. Payments are applied to invoices in the AR process. Adding ar_invoice_id FK establishes the proper referential relations',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: ar_payment has no company_code reference despite being a financial transaction that must be posted to a specific legal entity. Adding company_code_id FK enables legal entity-level AR payment reporting',
    `party_id` BIGINT COMMENT 'Identifier of the party (dealer, fleet account, or intercompany entity) that made the payment.',
    `ar_payment_status` STRING COMMENT 'Current lifecycle status of the payment.. Valid values are `pending|posted|cleared|rejected|void`',
    `bank_account_number` STRING COMMENT 'Bank account number where the payment was received.',
    `bank_name` STRING COMMENT 'Name of the bank that received the payment.',
    `cash_application_status` STRING COMMENT 'Status of cash application against the invoice(s).. Valid values are `unapplied|applied|partially_applied`',
    `clearance_date` DATE COMMENT 'Date the payment cleared the bank and was posted to the ledger.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the payment.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discounts applied to the payment, if any.',
    `due_date` DATE COMMENT 'Date by which the payment was expected according to terms.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency conversion rate applied when payment currency differs from functional currency.',
    `exchange_rate_date` DATE COMMENT 'Date on which the exchange rate was sourced.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount received before any deductions.',
    `is_partial_payment` BOOLEAN COMMENT 'Flag indicating whether the payment covers the full invoice amount.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount applied to the invoice after tax and discounts.',
    `notes` STRING COMMENT 'Free‑form text for any additional information about the payment.',
    `original_amount` DECIMAL(18,2) COMMENT 'Payment amount in the original foreign currency before conversion.',
    `payment_channel` STRING COMMENT 'Channel through which the payment was submitted.. Valid values are `in_person|online_portal|mobile_app|batch|auto`',
    `payment_date` DATE COMMENT 'Date the payment was received or processed.',
    `payment_method` STRING COMMENT 'Instrument used to make the payment.. Valid values are `cash|check|wire|credit_card|online|eft`',
    `payment_number` STRING COMMENT 'Unique payment reference assigned by the finance system.',
    `payment_source` STRING COMMENT 'Origin of the payment within the organization.. Valid values are `dealer|fleet|intercompany|direct_customer`',
    `payment_terms_code` STRING COMMENT 'Standard payment terms associated with the invoice.. Valid values are `NET30|NET45|NET60`',
    `posting_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment was posted to the general ledger.',
    `remittance_reference` STRING COMMENT 'Reference provided by the payer to reconcile the payment.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component deducted from the gross amount, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment record.',
    CONSTRAINT pk_ar_payment PRIMARY KEY(`ar_payment_id`)
) COMMENT 'Accounts Receivable incoming payment record capturing payments received from dealers, fleet accounts, and intercompany entities against AR invoices. Captures payment date, customer/dealer ID, payment method, amount received, currency, cleared invoice references, bank account, remittance advice reference, partial payment indicator, and cash application status. Supports dealer receivables management, DSO (Days Sales Outstanding) tracking, and cash flow forecasting.';

CREATE OR REPLACE TABLE `automotive_ecm`.`finance`.`capex_request` (
    `capex_request_id` BIGINT COMMENT 'Unique surrogate key for the CapEx request record.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `plant_id` BIGINT COMMENT 'Code of the manufacturing plant where the investment will be implemented.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: CapEx requests in SAP are assigned to profit centers for management accounting and EBITDA impact analysis. capex_request currently has cost_center_id but no profit_center_id. Adding profit_center_id e',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: CapEx requests in automotive manufacturing are typically associated with capital projects (e.g., new production line, EV platform investment). capex_request already links to wbs_element which links to',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Capex requests must be tied to the specific regulatory requirement they satisfy for compliance tracking and audit.',
    `wbs_element_id` BIGINT COMMENT 'FK to finance.wbs_element',
    `actual_end_date` DATE COMMENT 'Date when the project was actually completed.',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Cumulative amount actually spent to date on the project.',
    `approval_date` TIMESTAMP COMMENT 'Timestamp when the request received final approval.',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Budget amount approved by the governance board.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Estimated total cost of the proposed investment.',
    `capex_request_description` STRING COMMENT 'Detailed narrative of the proposed capital investment, including objectives and scope.',
    `capex_request_status` STRING COMMENT 'Current lifecycle state of the request.. Valid values are `draft|submitted|under_review|approved|rejected|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the budget.. Valid values are `USD|EUR|JPY|GBP|CNY|CAD`',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the capital asset.. Valid values are `straight_line|double_declining|units_of_production|sum_of_years_digits`',
    `depreciation_years` STRING COMMENT 'Number of years over which the asset will be depreciated.',
    `external_funding_amount` DECIMAL(18,2) COMMENT 'Monetary value of external funding contributions.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the request belongs (e.g., FY2024).. Valid values are `FYd{4}`',
    `funding_source` STRING COMMENT 'Name of the external entity providing funding (e.g., government grant, joint venture).',
    `has_external_funding` BOOLEAN COMMENT 'Indicates whether part of the investment is funded by external sources.',
    `investment_category` STRING COMMENT 'Classification of the investment type.. Valid values are `tooling|machinery|it|facility|ev_r&d|autonomous_r&d`',
    `irr` DECIMAL(18,2) COMMENT 'Internal rate of return percentage for the proposed investment.',
    `is_capitalized` BOOLEAN COMMENT 'Indicates whether the expense is capitalized (true) or expensed (false).',
    `is_compliant` BOOLEAN COMMENT 'Indicates whether the request complies with all applicable regulations.',
    `justification` STRING COMMENT 'Business case narrative explaining the need and expected benefits.',
    `npv` DECIMAL(18,2) COMMENT 'Net present value of the investment calculated in the request currency.',
    `payback_period_years` DECIMAL(18,2) COMMENT 'Estimated number of years to recover the investment.',
    `priority` STRING COMMENT 'Business priority assigned to the request.. Valid values are `low|medium|high|critical`',
    `procurement_method` STRING COMMENT 'Method used to acquire the goods or services.. Valid values are `direct|tender|rfq|framework|sole_source`',
    `project_end_date` DATE COMMENT 'Planned completion date of the capital project.',
    `project_start_date` DATE COMMENT 'Planned start date of the capital project.',
    `regulatory_approval_status` STRING COMMENT 'Status of any required regulatory approvals for the investment.. Valid values are `pending|approved|rejected`',
    `request_date` TIMESTAMP COMMENT 'Timestamp when the request was initially submitted.',
    `request_number` STRING COMMENT 'Human‑readable identifier assigned to the request (e.g., CR‑2024‑001).',
    `risk_rating` STRING COMMENT 'Risk assessment rating for the proposed investment.. Valid values are `low|moderate|high|critical`',
    `supporting_document_url` STRING COMMENT 'Link to attached supporting documentation stored in the document management system.',
    `tax_implication` STRING COMMENT 'Notes on tax treatment or incentives related to the investment.',
    `title` STRING COMMENT 'Brief title describing the investment proposal.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    CONSTRAINT pk_capex_request PRIMARY KEY(`capex_request_id`)
) COMMENT 'Capital Expenditure (CapEx) appropriation request record capturing investment proposals for manufacturing equipment, tooling, plant infrastructure, EV battery production lines, and R&D facilities. Captures project title, requesting plant/department, investment category (tooling, machinery, IT, facility, EV/autonomous R&D), estimated total cost, approved budget, actual spend to date, project start/end dates, approval workflow status, NPV/IRR justification, and WBS element linkage. Supports CapEx governance and FY budget planning.';

CREATE OR REPLACE TABLE `automotive_ecm`.`finance`.`budget_plan` (
    `budget_plan_id` BIGINT COMMENT 'Unique identifier for the budget plan record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Budget plans are created per legal entity (company code) in SAP. budget_plan currently has cost_center_id, profit_center_id, and gl_account_id but no company_code_id. Adding this FK enables legal enti',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Budget plans are tied to specific fiscal periods for planning and variance analysis. budget_plan has fiscal_year (INT) and planning_period (STRING) as denormalized attributes but no fiscal_period_id F',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Finance teams budget for compliance obligations (testing programs, certification costs, recall reserves). Budget plans reference specific obligations to allocate resources, track compliance spending, ',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `project_id` BIGINT COMMENT 'Identifier of the project linked to this budget plan, if applicable.',
    `sales_territory_id` BIGINT COMMENT 'Foreign key linking to sales.sales_territory. Business justification: Sales territory budgets (marketing spend, headcount, incentives) require explicit territory assignment for regional P&L planning and territory performance analysis. Standard practice for automotive re',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Budget plans in automotive manufacturing are often created at the WBS element level for project-based cost tracking (e.g., EV platform development, plant expansion). budget_plan already has project_id',
    `allocation_method` STRING COMMENT 'Method used to allocate the budget across cost objects.. Valid values are `percentage|fixed|formula`',
    `approval_date` DATE COMMENT 'Date when the budget plan received formal approval.',
    `budget_category` STRING COMMENT 'High‑level business area the budget pertains to.. Valid values are `R&D|Manufacturing|Sales|Administration|Marketing`',
    `budget_plan_status` STRING COMMENT 'Current lifecycle state of the budget plan.. Valid values are `draft|submitted|approved|rejected|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget plan record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the budget amounts.. Valid values are `USD|EUR|JPY|GBP|CNY|CAD`',
    `effective_end_date` DATE COMMENT 'Date when the budget plan expires or is superseded (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the budget plan becomes effective.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the budget applies.',
    `is_forecast` BOOLEAN COMMENT 'Indicates whether the plan is a forecast rather than a firm budget.',
    `is_locked` BOOLEAN COMMENT 'True if the budget plan is locked from further edits.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the budget plan.',
    `plan_code` STRING COMMENT 'External code used to reference the budget plan in financial systems.',
    `plan_name` STRING COMMENT 'Descriptive name of the budget plan.',
    `plan_type` STRING COMMENT 'Category of the budget plan indicating its purpose.. Valid values are `operating|capital|headcount|forecast|revised`',
    `planned_amount` DECIMAL(18,2) COMMENT 'Original budgeted monetary amount.',
    `planning_period` STRING COMMENT 'Period covered by the budget (e.g., FY2025, Q1).. Valid values are `FY|Q1|Q2|Q3|Q4`',
    `revised_amount` DECIMAL(18,2) COMMENT 'Updated budget amount after revisions.',
    `scenario` STRING COMMENT 'Analytical scenario applied to the budget (e.g., base, optimistic, pessimistic).. Valid values are `base|optimistic|pessimistic`',
    `source_system` STRING COMMENT 'Originating system for the budget data (e.g., SAP CO, BPC).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the budget plan.',
    `version_number` STRING COMMENT 'Sequential version of the budget plan for change tracking.',
    CONSTRAINT pk_budget_plan PRIMARY KEY(`budget_plan_id`)
) COMMENT 'Annual and multi-year financial budget plan record capturing planned financial targets by cost center, profit center, GL account, and fiscal year. Supports FY budget planning, rolling forecast cycles, and variance analysis. Captures budget version (original, revised, forecast), budget type (opex, capex, headcount), planning period, planned amount, currency, approval status, and responsible controller. Aligned with SAP CO planning and SAP BPC (Business Planning and Consolidation) processes.';

CREATE OR REPLACE TABLE `automotive_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique system-generated identifier for the fixed asset record.',
    `capex_request_id` BIGINT COMMENT 'Foreign key linking to finance.capex_request. Business justification: Fixed assets are created from approved CapEx requests in the automotive manufacturing capital investment process. Linking fixed_asset to capex_request enables tracking of the full CapEx lifecycle: req',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Fixed assets in SAP AA are always assigned to a company code as the primary organizational unit. fixed_asset currently only has plant_id (cross-domain) but no company_code_id. Adding this FK enables l',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: fixed_asset.cost_center_code is a denormalized STRING reference to the cost center. Fixed assets are assigned to cost centers for depreciation cost allocation in SAP AA. Adding cost_center_id FK norma',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the asset is located.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: In SAP AA, fixed assets can be linked to WBS elements for project-based asset tracking (e.g., assets created during a plant expansion project). Adding wbs_element_id FK enables project-level asset rep',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recorded to date for the asset.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original cost incurred to acquire the asset, recorded in the functional currency.',
    `acquisition_date` DATE COMMENT 'Date the asset was acquired or placed into service.',
    `asset_class` STRING COMMENT 'Classification of the asset according to the companys asset class hierarchy (e.g., machinery, building, IT equipment).',
    `asset_condition` STRING COMMENT 'Current physical condition of the asset.. Valid values are `new|good|fair|poor|scrapped`',
    `asset_description` STRING COMMENT 'Detailed description of the asset, including purpose and key characteristics.',
    `asset_name` STRING COMMENT 'Human‑readable name or title of the asset.',
    `asset_status` STRING COMMENT 'Current operational status of the asset.. Valid values are `in_service|retired|under_maintenance|disposed|pending`',
    `asset_tag` STRING COMMENT 'Internal asset tag or number used for tracking the asset within the organization.',
    `asset_type` STRING COMMENT 'Specific type of asset within its class (e.g., stamping press, paint shop robot, battery assembly line).',
    `capitalized_flag` BOOLEAN COMMENT 'Indicates whether the cost has been capitalized (true) or expensed (false).',
    `condition_rating` STRING COMMENT 'Numeric rating (1‑5) of the asset’s condition, where 5 is best.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the acquisition cost.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Method used to calculate depreciation (e.g., straight‑line, declining balance, units of production).. Valid values are `straight_line|declining_balance|units_of_production`',
    `depreciation_rate_percent` DECIMAL(18,2) COMMENT 'Annual depreciation rate expressed as a percentage.',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation calculations begin for the asset.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the asset (e.g., sale, scrap, donation).',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount covered by the insurance policy.',
    `insurance_expiry_date` DATE COMMENT 'Date when the insurance coverage expires.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the insurance covering the asset.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection or audit of the asset.',
    `location_code` STRING COMMENT 'Code representing the specific physical location (e.g., warehouse, line, bay) of the asset.',
    `maintenance_schedule` STRING COMMENT 'Reference to the maintenance plan applicable to the asset.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the asset.',
    `model` STRING COMMENT 'Model designation or number assigned by the manufacturer.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying amount of the asset (acquisition cost minus accumulated depreciation).',
    `next_inspection_date` DATE COMMENT 'Planned date for the next scheduled inspection.',
    `responsible_department` STRING COMMENT 'Department accountable for the asset’s operation and maintenance.',
    `retirement_date` DATE COMMENT 'Date the asset was officially retired from service.',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number uniquely identifying the physical unit.',
    `tax_depreciation_amount` DECIMAL(18,2) COMMENT 'Depreciation amount recognized for tax reporting purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the asset record.',
    `useful_life_years` STRING COMMENT 'Estimated economic life of the asset expressed in years for depreciation purposes.',
    `warranty_end_date` DATE COMMENT 'Date when the asset warranty period expires.',
    `warranty_provider` STRING COMMENT 'Name of the party providing the warranty for the asset.',
    `warranty_start_date` DATE COMMENT 'Date when the asset warranty period begins.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master record for all capitalized assets including manufacturing machinery, production tooling, dies, stamping presses, paint shop equipment, EV battery assembly lines, plant buildings, and IT infrastructure. Aligned with SAP FI-AA (Asset Accounting). Captures asset class, asset description, acquisition date, acquisition cost, useful life, depreciation method (straight-line, declining balance), accumulated depreciation, net book value, plant assignment, cost center, and retirement date. Supports CapEx tracking and IFRS/GAAP asset disclosure.';

CREATE OR REPLACE TABLE `automotive_ecm`.`finance`.`currency_rate` (
    `currency_rate_id` BIGINT COMMENT 'System-generated unique identifier for each currency rate record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Currency rates are maintained per legal entity; linking to company_code provides context and eliminates the isolated lookup table.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: currency_rate has fiscal_year (STRING) and period (STRING) as denormalized attributes. Currency rates in SAP are period-specific (monthly average rates, period-end rates). Adding fiscal_period_id FK n',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the currency rate record was first created in the system.',
    `currency_from` STRING COMMENT 'Three‑letter ISO 4217 code of the currency being converted from.. Valid values are `^[A-Z]{3}$`',
    `currency_rate_description` STRING COMMENT 'Free‑form text providing additional context or notes about the rate (e.g., special market conditions).',
    `currency_to` STRING COMMENT 'Three‑letter ISO 4217 code of the currency being converted to.. Valid values are `^[A-Z]{3}$`',
    `is_historical` BOOLEAN COMMENT 'Indicates whether the rate is a historical record (true) or a current/forecast rate (false).',
    `rate_date` DATE COMMENT 'Calendar date to which the exchange rate applies (e.g., daily rate).',
    `rate_type` STRING COMMENT 'Classification of the rate: spot, average, period‑end, or planning.. Valid values are `spot|average|period_end|planning`',
    `rate_value` DECIMAL(18,2) COMMENT 'Numeric exchange rate value expressed as the amount of target currency per one unit of source currency.',
    `source` STRING COMMENT 'Origin of the rate data, such as European Central Bank, Bloomberg, or internal treasury.. Valid values are `ECB|Bloomberg|Internal_Treasury`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the currency rate record.',
    `valid_from` DATE COMMENT 'Start date of the period during which the rate is valid.',
    `valid_to` DATE COMMENT 'End date of the period during which the rate is valid; null if open‑ended.',
    CONSTRAINT pk_currency_rate PRIMARY KEY(`currency_rate_id`)
) COMMENT 'Foreign exchange (FX) currency rate reference record capturing daily, monthly average, and period-end exchange rates used for multi-currency financial reporting and transaction conversion. Captures currency pair (from/to), rate type (spot, average, period-end, planning), valid date, exchange rate, rate source (ECB, Bloomberg, internal treasury), and company code applicability. Supports IFRS translation of foreign subsidiary financials, transaction currency conversion, and FX exposure reporting.';

CREATE OR REPLACE TABLE `automotive_ecm`.`finance`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'System-generated unique identifier for the WBS element.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center entity linked to this WBS element.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: wbs_element has fiscal_period (STRING) and fiscal_year (INT) as denormalized attributes. WBS elements are tied to fiscal periods for project cost tracking and period-based reporting. Adding fiscal_per',
    `parent_wbs_wbs_element_id` BIGINT COMMENT 'Identifier of the immediate parent WBS element, establishing the hierarchy.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant associated with the WBS element.',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `project_id` BIGINT COMMENT 'Reference to the overarching project definition to which this WBS element belongs.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: WBS elements representing project work need a FK to the regulatory requirement they address for compliance reporting.',
    `accounting_status` STRING COMMENT 'Accounting posting status of the WBS element.. Valid values are `open|posted|reversed`',
    `actual_cost` DECIMAL(18,2) COMMENT 'Incurred cost amount recorded to date for the WBS element.',
    `approval_date` DATE COMMENT 'Date when the WBS element received final approval.',
    `approval_status` STRING COMMENT 'Current approval workflow status.. Valid values are `pending|approved|rejected`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget amount for the WBS element, may differ from planned cost.',
    `committed_cost` DECIMAL(18,2) COMMENT 'Cost commitments (e.g., purchase orders) associated with the WBS element.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the WBS record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'Planned or actual completion date of the WBS element.',
    `external_reference` STRING COMMENT 'Reference to external systems (e.g., ERP document number).',
    `investment_program_code` STRING COMMENT 'Code linking the WBS element to a corporate investment program (e.g., new model launch, plant expansion).',
    `is_capex` BOOLEAN COMMENT 'True if the element captures capital expenditure, false otherwise.',
    `is_r_and_d` BOOLEAN COMMENT 'True if the element is part of research & development projects.',
    `milestone_flag` BOOLEAN COMMENT 'Indicates whether the WBS element represents a project milestone.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the WBS element.',
    `planned_cost` DECIMAL(18,2) COMMENT 'Budgeted cost amount originally planned for the WBS element.',
    `plant_location` STRING COMMENT 'Geographic location or site name of the plant.',
    `project_phase` STRING COMMENT 'Current phase of the overall project to which the WBS element belongs.. Valid values are `initiation|planning|execution|monitoring|closure`',
    `revision_number` STRING COMMENT 'Version number of the WBS element record.',
    `start_date` DATE COMMENT 'Effective start date when the WBS element becomes active.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the WBS record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the WBS record.',
    `wbs_code` STRING COMMENT 'External business identifier for the WBS element, typically used in SAP PS and project documentation.',
    `wbs_element_status` STRING COMMENT 'Current lifecycle status of the WBS element.. Valid values are `planned|active|completed|closed|cancelled`',
    `wbs_hierarchy_path` STRING COMMENT 'Delimited path representing the full hierarchy (e.g., 1.2.3).',
    `wbs_level` STRING COMMENT 'Hierarchical level of the element within the WBS tree (1 = top level).',
    `wbs_name` STRING COMMENT 'Human‑readable name or title of the WBS element.',
    `wbs_type` STRING COMMENT 'Classification of the WBS element by business purpose.. Valid values are `capex|r_and_d|maintenance|operational`',
    `created_by` STRING COMMENT 'User identifier of the person who created the WBS record.',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Work Breakdown Structure (WBS) element master record used for project-based cost tracking including CapEx projects, new model launch programs (SOP/EOP), EV/autonomous R&D programs, and plant expansion projects. Aligned with SAP PS (Project System). Captures WBS code, project definition, WBS level, responsible cost center, planned cost, actual cost, committed cost, project status, start/end dates, and investment program linkage. Enables granular CapEx spend tracking and R&D capitalization under IFRS IAS 38.';

CREATE OR REPLACE TABLE `automotive_ecm`.`finance`.`project` (
    `project_id` BIGINT COMMENT 'Primary key for project',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Projects in automotive manufacturing are executed within a specific legal entity (company code). project currently has cost_center_id but no company_code_id. Adding this FK enables legal entity-level ',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `parent_project_id` BIGINT COMMENT 'Self-referencing FK on project (parent_project_id)',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant associated with the project.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Projects in automotive manufacturing are tracked by profit center for management accounting and EBITDA analysis (e.g., EV platform project assigned to the EV profit center). project currently has cost',
    `actual_end_date` DATE COMMENT 'Actual date the project was closed or completed.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Cumulative actual expenditures incurred by the project.',
    `approval_date` DATE COMMENT 'Date when the project received formal approval.',
    `approved_by` BIGINT COMMENT 'Identifier of the employee who approved the project budget.',
    `audit_comments` STRING COMMENT 'Free‑text comments from auditors regarding the project.',
    `audit_status` STRING COMMENT 'Current status of the SOX audit for the project.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Original approved budget for the project.',
    `capital_expenditure_flag` BOOLEAN COMMENT 'Indicates whether the project is classified as CapEx.',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code for the project location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the project record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary values.',
    `expected_roi_percent` DECIMAL(18,2) COMMENT 'Projected return on investment expressed as a percentage.',
    `external_project_number` STRING COMMENT 'Identifier used by external partners or regulatory bodies.',
    `forecasted_total_cost` DECIMAL(18,2) COMMENT 'Projected total cost at project completion.',
    `funding_source` STRING COMMENT 'Origin of the funds used for the project.',
    `location` STRING COMMENT 'Physical location or site where the project is executed.',
    `operational_expenditure_flag` BOOLEAN COMMENT 'Indicates whether the project is classified as OpEx.',
    `phase` STRING COMMENT 'Current phase of the project lifecycle.',
    `phase_end_date` DATE COMMENT 'Planned end date of the current project phase.',
    `phase_start_date` DATE COMMENT 'Start date of the current project phase.',
    `planned_end_date` DATE COMMENT 'Planned completion date of the project.',
    `priority` STRING COMMENT 'Business priority assigned to the project.',
    `project_category` STRING COMMENT 'High‑level business category for the project.',
    `project_code` STRING COMMENT 'External business code used to identify the project in finance and reporting systems.',
    `project_description` STRING COMMENT 'Detailed textual description of the projects purpose, scope, and objectives.',
    `project_name` STRING COMMENT 'Descriptive name of the project as used by business users.',
    `project_status` STRING COMMENT 'Current lifecycle status of the project.',
    `project_type` STRING COMMENT 'Category of the project indicating its primary nature.',
    `region` STRING COMMENT 'Broad geographic region of the project.',
    `revised_budget_amount` DECIMAL(18,2) COMMENT 'Updated budget after revisions.',
    `risk_level` STRING COMMENT 'Assessed risk level for the project.',
    `sox_compliance_flag` BOOLEAN COMMENT 'Indicates whether the project is subject to SOX internal controls.',
    `start_date` DATE COMMENT 'Planned start date of the project.',
    `status_reason` STRING COMMENT 'Explanation for the current status, e.g., reason for hold or cancellation.',
    `subcategory` STRING COMMENT 'More granular classification within the project category.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the project record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between revised budget and actual spend.',
    `variance_percent` DECIMAL(18,2) COMMENT 'Percentage variance between revised budget and actual spend.',
    CONSTRAINT pk_project PRIMARY KEY(`project_id`)
) COMMENT 'Master reference table for project. Referenced by related_project_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `automotive_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `automotive_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `automotive_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_project_id` FOREIGN KEY (`project_id`) REFERENCES `automotive_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `automotive_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `automotive_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `automotive_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_capex_request_id` FOREIGN KEY (`capex_request_id`) REFERENCES `automotive_ecm`.`finance`.`capex_request`(`capex_request_id`);
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `automotive_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ADD CONSTRAINT `fk_finance_currency_rate_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ADD CONSTRAINT `fk_finance_currency_rate_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_parent_wbs_wbs_element_id` FOREIGN KEY (`parent_wbs_wbs_element_id`) REFERENCES `automotive_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_project_id` FOREIGN KEY (`project_id`) REFERENCES `automotive_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `automotive_ecm`.`finance`.`project` ADD CONSTRAINT `fk_finance_project_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`finance`.`project` ADD CONSTRAINT `fk_finance_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`finance`.`project` ADD CONSTRAINT `fk_finance_project_parent_project_id` FOREIGN KEY (`parent_project_id`) REFERENCES `automotive_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `automotive_ecm`.`finance`.`project` ADD CONSTRAINT `fk_finance_project_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= TAGS =========
ALTER SCHEMA `automotive_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `automotive_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Identifier');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `balance_type` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet vs. Profit & Loss Classification');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `balance_type` SET TAGS ('dbx_value_regex' = 'profit_and_loss|balance_sheet');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `chart_of_accounts_version` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts Version');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_description` SET TAGS ('dbx_business_glossary_term' = 'GL Account Description');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_business_glossary_term' = 'GL Account Status');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `is_budgeted` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Account Flag');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `is_consolidation_account` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Flag');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Flag');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `is_reconciliation_account` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Flag');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `is_tax_relevant` SET TAGS ('dbx_business_glossary_term' = 'Tax Relevance Flag');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `last_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Last Posting Date');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `reporting_level` SET TAGS ('dbx_business_glossary_term' = 'Reporting Level');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `reporting_level` SET TAGS ('dbx_value_regex' = 'company|division|plant|region|country');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'OEM|Aftermarket|Service|R&D');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_value_regex' = 'taxable|exempt|zero|reverse');
ALTER TABLE `automotive_ecm`.`finance`.`gl_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'fixed|percentage|activity_based|none');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'cost_center|profit_center|investment_center');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'production|administration|research|sales|service');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `reporting_level` SET TAGS ('dbx_business_glossary_term' = 'Reporting Level');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `reporting_level` SET TAGS ('dbx_value_regex' = 'plant|division|global');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center Identifier');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount (USD)');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Log');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (USD)');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|NonCompliant|Pending');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `ebitda_amount` SET TAGS ('dbx_business_glossary_term' = 'EBITDA Amount (USD)');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Path');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Flag');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Percentage');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Owner Name');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount (USD)');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_category` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Category');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_group` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Group');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_level` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Level');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Planned|Closed');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'Legal|Operating|Reporting');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = 'NA|EU|APAC|LATAM|MEA');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'Annual|Quarterly');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Segment (Segment)');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'EV|ICE|HEV|PHEV|Commercial|Luxury');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `business_line` SET TAGS ('dbx_business_glossary_term' = 'Business Line');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts Assignment');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code (SAP)');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_business_glossary_term' = 'Entity Status');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 alpha-3)');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'legal_entity|joint_venture|subsidiary|branch|holding');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = 'FY01|FY02|FY03|FY04|FY05|FY06');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `functional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `industry_sector` SET TAGS ('dbx_value_regex' = 'passenger_vehicles|commercial_vehicles|components|services|software');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated Flag');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `local_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Company Registration Number');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Standard');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_value_regex' = 'IFRS|GAAP|IFRS_FOR_SME|US_GAAP|EU_GAAP');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Reporting Segment');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Short Name');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`company_code` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Identifier');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `accrual_cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Cutoff Date');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_description` SET TAGS ('dbx_business_glossary_term' = 'Period Description');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_status` SET TAGS ('dbx_value_regex' = 'open|closed|locked');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `is_current_period` SET TAGS ('dbx_business_glossary_term' = 'Current Period Indicator');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `is_interim` SET TAGS ('dbx_business_glossary_term' = 'Interim Period Flag');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `lock_date` SET TAGS ('dbx_business_glossary_term' = 'Period Lock Date');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Period Number');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'regular|adjustment|special');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `posting_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Deadline Date');
ALTER TABLE `automotive_ecm`.`finance`.`fiscal_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner ID');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Document Amount');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CUR)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator (DC)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_language` SET TAGS ('dbx_business_glossary_term' = 'Document Language');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Document Number');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type (DT)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'SA|KR|AB|DR|CR');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `is_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Flag');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Flag');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `is_manual_entry` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Flag');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `is_test_entry` SET TAGS ('dbx_business_glossary_term' = 'Test Entry Flag');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Status');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending|error');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant (PLANT)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_category` SET TAGS ('dbx_business_glossary_term' = 'Posting Category');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_reference` SET TAGS ('dbx_business_glossary_term' = 'Posting Reference');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_text` SET TAGS ('dbx_business_glossary_term' = 'Posting Text');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_user_role` SET TAGS ('dbx_business_glossary_term' = 'Posting User Role');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Reporting Segment');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_module` SET TAGS ('dbx_business_glossary_term' = 'Source Module');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Code');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_cc` SET TAGS ('dbx_business_glossary_term' = 'Posting Amount (Company Code Currency)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_tc` SET TAGS ('dbx_business_glossary_term' = 'Posting Amount (Transaction Currency)');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `currency_cc` SET TAGS ('dbx_business_glossary_term' = 'Company Code Currency Code');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `currency_cc` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `currency_tc` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `currency_tc` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Quantity');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_item` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Item');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'receivables_management');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Invoice ID');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `homologation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Homologation Record Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Entity ID');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `vehicle_order_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `accounting_date` SET TAGS ('dbx_business_glossary_term' = 'Accounting Date');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30|31_60|61_90|90_plus|unknown');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Lifecycle Status');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_status` SET TAGS ('dbx_value_regex' = 'draft|open|posted|cancelled|paid|reversed');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Document Number');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'on_time|late|defaulted|written_off|disputed|unknown');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `discount_reason` SET TAGS ('dbx_business_glossary_term' = 'Discount Reason');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Flag');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_category` SET TAGS ('dbx_business_glossary_term' = 'Invoice Category');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_category` SET TAGS ('dbx_value_regex' = 'domestic|export|internal|fleet|government|other');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'vehicle_sale|parts|service|lease|subscription|other');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|cash|check|online|other');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|failed|reversed|partial|unknown');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|cod|prepaid|milestone');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `sales_org_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `warranty_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Warranty Reserve Amount');
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ALTER COLUMN `warranty_reserve_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Reserve Flag');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` SET TAGS ('dbx_subdomain' = 'receivables_management');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Payment ID (AR_PAYMENT_ID)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (PAYER_ID)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PAYMENT_STATUS)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `ar_payment_status` SET TAGS ('dbx_value_regex' = 'pending|posted|cleared|rejected|void');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number (BANK_ACCOUNT_NUMBER)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name (BANK_NAME)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `cash_application_status` SET TAGS ('dbx_business_glossary_term' = 'Cash Application Status (CASH_APPLICATION_STATUS)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `cash_application_status` SET TAGS ('dbx_value_regex' = 'unapplied|applied|partially_applied');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Clearance Date (CLEARANCE_DATE)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURRENCY_CODE)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount Applied to Payment (DISCOUNT_AMOUNT)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date (DUE_DATE)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to Functional Currency (EXCHANGE_RATE)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date (EXCHANGE_RATE_DATE)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Payment Amount (GROSS_AMOUNT)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `is_partial_payment` SET TAGS ('dbx_business_glossary_term' = 'Partial Payment Indicator (IS_PARTIAL_PAYMENT)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount (NET_AMOUNT)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes (NOTES)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Amount in Foreign Currency (ORIGINAL_AMOUNT)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel (PAYMENT_CHANNEL)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'in_person|online_portal|mobile_app|batch|auto');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date (PAYMENT_DATE)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAYMENT_METHOD)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'cash|check|wire|credit_card|online|eft');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number (PAYMENT_NUMBER)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_source` SET TAGS ('dbx_business_glossary_term' = 'Payment Source (PAYMENT_SOURCE)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_source` SET TAGS ('dbx_value_regex' = 'dealer|fleet|intercompany|direct_customer');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code (PAYMENT_TERMS_CODE)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = 'NET30|NET45|NET60');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp (POSTING_TIMESTAMP)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `remittance_reference` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Reference (REMITTANCE_REFERENCE)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount Applied to Payment (TAX_AMOUNT)');
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` SET TAGS ('dbx_subdomain' = 'capital_investment');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Request ID');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Project End Date');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'CapEx Approval Date');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Budget Amount');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `capex_request_description` SET TAGS ('dbx_business_glossary_term' = 'CapEx Request Description');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `capex_request_status` SET TAGS ('dbx_business_glossary_term' = 'CapEx Request Status');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `capex_request_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|closed');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CNY|CAD');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|units_of_production|sum_of_years_digits');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `depreciation_years` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Period (Years)');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `external_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'External Funding Amount');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `external_funding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = 'FYd{4}');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `has_external_funding` SET TAGS ('dbx_business_glossary_term' = 'External Funding Flag');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `investment_category` SET TAGS ('dbx_business_glossary_term' = 'Investment Category (CAPEX)');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `investment_category` SET TAGS ('dbx_value_regex' = 'tooling|machinery|it|facility|ev_r&d|autonomous_r&d');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `irr` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR)');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `irr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `is_capitalized` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Flag');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `is_compliant` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Investment Justification');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `npv` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV)');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `npv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `payback_period_years` SET TAGS ('dbx_business_glossary_term' = 'Payback Period (Years)');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `payback_period_years` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'CapEx Request Priority');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `procurement_method` SET TAGS ('dbx_value_regex' = 'direct|tender|rfq|framework|sole_source');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Project End Date');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Project Start Date');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'CapEx Request Date');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'CapEx Request Number');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (CAPEX)');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `supporting_document_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document URL');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `tax_implication` SET TAGS ('dbx_business_glossary_term' = 'Tax Implication');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'CapEx Request Title');
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan ID');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Related Project ID');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'percentage|fixed|formula');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'R&D|Manufacturing|Sales|Administration|Marketing');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Status');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|closed');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CNY|CAD');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `is_forecast` SET TAGS ('dbx_business_glossary_term' = 'Is Forecast');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Is Locked');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Notes');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Code');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Name');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Type');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'operating|capital|headcount|forecast|revised');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `planning_period` SET TAGS ('dbx_business_glossary_term' = 'Planning Period');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `planning_period` SET TAGS ('dbx_value_regex' = 'FY|Q1|Q2|Q3|Q4');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `scenario` SET TAGS ('dbx_business_glossary_term' = 'Budget Scenario');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `scenario` SET TAGS ('dbx_value_regex' = 'base|optimistic|pessimistic');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'capital_investment');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Identifier');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Request Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_condition` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_condition` SET TAGS ('dbx_value_regex' = 'new|good|fair|poor|scrapped');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|under_maintenance|disposed|pending');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalized_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalized Flag');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate Percent');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `maintenance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Model');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Date');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Depreciation Amount');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_provider` SET TAGS ('dbx_business_glossary_term' = 'Warranty Provider');
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` SET TAGS ('dbx_subdomain' = 'general_accounting');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `currency_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Rate ID');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `currency_from` SET TAGS ('dbx_business_glossary_term' = 'Source Currency Code (ISO 4217)');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `currency_from` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `currency_rate_description` SET TAGS ('dbx_business_glossary_term' = 'Currency Rate Description');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `currency_to` SET TAGS ('dbx_business_glossary_term' = 'Target Currency Code (ISO 4217)');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `currency_to` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `is_historical` SET TAGS ('dbx_business_glossary_term' = 'Historical Rate Flag');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `rate_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Date');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'spot|average|period_end|planning');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Value');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'ECB|Bloomberg|Internal_Treasury');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `automotive_ecm`.`finance`.`currency_rate` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_subdomain' = 'capital_investment');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `parent_wbs_wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Parent WBS Element ID');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Definition ID');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `accounting_status` SET TAGS ('dbx_business_glossary_term' = 'Accounting Status');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `accounting_status` SET TAGS ('dbx_value_regex' = 'open|posted|reversed');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `committed_cost` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `investment_program_code` SET TAGS ('dbx_business_glossary_term' = 'Investment Program Code');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `is_capex` SET TAGS ('dbx_business_glossary_term' = 'Is CapEx');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `is_r_and_d` SET TAGS ('dbx_business_glossary_term' = 'Is R&D');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `milestone_flag` SET TAGS ('dbx_business_glossary_term' = 'Milestone Flag');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `plant_location` SET TAGS ('dbx_business_glossary_term' = 'Plant Location');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'initiation|planning|execution|monitoring|closure');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_status` SET TAGS ('dbx_business_glossary_term' = 'WBS Element Status');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|closed|cancelled');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'WBS Hierarchy Path');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_level` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Level');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_name` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Name');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_type` SET TAGS ('dbx_business_glossary_term' = 'WBS Element Type');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_type` SET TAGS ('dbx_value_regex' = 'capex|r_and_d|maintenance|operational');
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `automotive_ecm`.`finance`.`project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`finance`.`project` SET TAGS ('dbx_subdomain' = 'capital_investment');
ALTER TABLE `automotive_ecm`.`finance`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `automotive_ecm`.`finance`.`project` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`finance`.`project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`project` ALTER COLUMN `parent_project_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `automotive_ecm`.`finance`.`project` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
