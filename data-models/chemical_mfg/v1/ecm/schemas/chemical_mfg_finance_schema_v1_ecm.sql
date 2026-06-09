-- Schema for Domain: finance | Business: Chemical Mfg | Version: v1_ecm
-- Generated on: 2026-05-06 12:33:19

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`finance` COMMENT 'Corporate finance domain managing general ledger, cost centers, cost accounting, CapEx/OpEx tracking, COGS analysis, EBITDA reporting, budgeting, financial planning, financial consolidation, and statutory reporting. Supports management reporting, profitability analysis, plant-level cost accounting, standard costing for formulations, and financial audits. Integrates with SAP FI/CO and supports SOX and FASB compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique surrogate key for each cost center record.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the manager accountable for the cost center.',
    `parent_cost_center_id` BIGINT COMMENT 'Identifier of the immediate parent cost center in the hierarchy.',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Total actual expenses recorded against the cost center for the fiscal year.',
    `allocation_method` STRING COMMENT 'Methodology used to allocate costs to the center.. Valid values are `direct|activity_based|standard|none`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned expense amount allocated to the cost center for the budget year.',
    `budget_year` STRING COMMENT 'Fiscal year to which the budget amounts apply.',
    `cost_center_category` STRING COMMENT 'High‑level business category for cost allocation.. Valid values are `overhead|production|r&d|sales|logistics`',
    `cost_center_code` STRING COMMENT 'Business identifier used in accounting and reporting (e.g., "CC‑0012").',
    `cost_center_description` STRING COMMENT 'Free‑form description providing additional context.',
    `cost_center_level` STRING COMMENT 'Numeric level indicating position in multi‑level hierarchy.',
    `cost_center_name` STRING COMMENT 'Human‑readable name of the cost center (e.g., "North Plant Operations").',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center.. Valid values are `active|inactive|closed|pending`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by organizational role.. Valid values are `plant|department|function|project|shared_service`',
    `cost_driver` STRING COMMENT 'Primary driver used for allocating costs (e.g., labor hours, machine hours).',
    `country` STRING COMMENT 'Three‑letter ISO country code where the cost center operates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost center record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code used for budgeting and reporting (e.g., "USD").',
    `external_reference` STRING COMMENT 'Identifier of the cost center in external ERP or legacy systems.',
    `group` STRING COMMENT 'Logical grouping of cost centers for consolidated reporting.',
    `hierarchy_level` STRING COMMENT 'Depth of the cost center within the organizational hierarchy (1 = top level).',
    `is_capex` BOOLEAN COMMENT 'Indicates whether the cost center is used for capital expenditures.',
    `last_review_date` DATE COMMENT 'Date when the cost center was last reviewed for relevance and accuracy.',
    `owner_department` STRING COMMENT 'Name of the department that owns the cost center.',
    `region` STRING COMMENT 'Geographic region identifier (e.g., "North America").',
    `reporting_code` STRING COMMENT 'Code used for statutory reporting and SOX audit trails.',
    `review_cycle` STRING COMMENT 'Frequency at which the cost center is reviewed.. Valid values are `annual|quarterly|monthly`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the cost center record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between budgeted and actual spend (budget – actual).',
    `variance_percent` DECIMAL(18,2) COMMENT 'Percentage variance calculated as (variance_amount / budget_amount) * 100.',
    `valid_from` DATE COMMENT 'Date when the cost center becomes effective for accounting.',
    `valid_to` DATE COMMENT 'Date when the cost center is retired or no longer valid (nullable).',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Master record for organizational cost centers used in management accounting and cost controlling. Represents a plant, department, or functional unit to which operating costs are allocated. Tracks hierarchy position, responsible manager, profit center assignment, currency, validity period, and budget ownership. Serves as the primary cost collection point for OpEx tracking, overhead allocation, and variance-to-budget reporting across chemical manufacturing facilities including production plants, R&D labs, and shared services.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique surrogate key for the profit center master record.',
    `cost_center_id` BIGINT COMMENT 'Cost center linked to the profit center for internal cost allocation.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for the profit center.',
    `parent_profit_center_id` BIGINT COMMENT 'Identifier of the parent profit center in the hierarchy (null for top‑level).',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned total budget allocated to the profit center for the fiscal year.',
    `capex_budget` DECIMAL(18,2) COMMENT 'Capital expenditure budget assigned to the profit center.',
    `controlling_area` STRING COMMENT 'Controlling area to which the profit center belongs for cost accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the profit center record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code used for financial reporting of the profit center.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `ebitda_amount` DECIMAL(18,2) COMMENT 'Actual EBITDA (Earnings Before Interest, Taxes, Depreciation, and Amortization) realized by the profit center.',
    `effective_from` DATE COMMENT 'Date on which the profit center becomes operational.',
    `effective_until` DATE COMMENT 'Date on which the profit center is retired or becomes inactive (null if open‑ended).',
    `hierarchy_level` STRING COMMENT 'Numeric level of the profit center within the organizational hierarchy.',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether the profit center is included in statutory and management reporting.',
    `opex_budget` DECIMAL(18,2) COMMENT 'Operating expenditure budget assigned to the profit center.',
    `profit_center_code` STRING COMMENT 'Business identifier (alphanumeric code) assigned to the profit center.',
    `profit_center_description` STRING COMMENT 'Free‑form description providing additional context about the profit center.',
    `profit_center_group` STRING COMMENT 'Grouping of profit centers for consolidated reporting.. Valid values are `global|regional|local`',
    `profit_center_name` STRING COMMENT 'Human‑readable name of the profit center used in reports and dashboards.',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center.. Valid values are `active|inactive|planned|closed`',
    `profit_center_type` STRING COMMENT 'Classification of the profit center indicating its organizational role.. Valid values are `segment|plant|product_line|business_unit|region|function`',
    `segment` STRING COMMENT 'High‑level market segment to which the profit center belongs.. Valid values are `specialty_chemicals|performance_materials|agricultural_solutions|pharma|consumer_goods`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the profit center record.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Master record for profit centers representing business segments, product lines, or plant units for which profitability is measured independently. Tracks profit center hierarchy, controlling area, responsible manager, currency, segment classification, and validity dates. Supports EBITDA reporting, segment profitability analysis under FASB ASC 280, and statutory reporting for chemical product lines including specialty chemicals, performance materials, and agricultural solutions.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'System-generated unique identifier for the GL account record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each GL account has an accountable accountant; linking provides ownership reporting and segregation of duties.',
    `parent_account_gl_account_id` BIGINT COMMENT 'Identifier of the immediate parent account for hierarchical roll‑up.',
    `account_group` STRING COMMENT 'Higher‑level grouping used for reporting and roll‑up (e.g., assets, liabilities, revenue, expense).',
    `account_name` STRING COMMENT 'Human‑readable name or title of the GL account.',
    `account_number` STRING COMMENT 'External account code used in financial postings and reporting.',
    `account_type` STRING COMMENT 'Category indicating whether the account appears on the balance sheet, profit & loss statement, equity, or off‑balance sheet.. Valid values are `balance_sheet|profit_and_loss|equity|off_balance`',
    `controlling_area` STRING COMMENT 'Controlling (CO) area identifier for cost accounting integration.',
    `cost_center` STRING COMMENT 'Cost center linked to the account for cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the GL account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code in which the account is denominated.',
    `depreciation_key` STRING COMMENT 'Key linking the account to a depreciation rule set.',
    `effective_from` DATE COMMENT 'Date when the account becomes valid for posting.',
    `effective_to` DATE COMMENT 'Date when the account is retired; null if open‑ended.',
    `financial_statement_line` STRING COMMENT 'Line item name on the financial statement where the account is reported.',
    `gl_account_description` STRING COMMENT 'Free‑form text describing the purpose or usage of the account.',
    `gl_account_status` STRING COMMENT 'Current lifecycle status of the GL account.. Valid values are `active|inactive|blocked|pending`',
    `hierarchy_level` STRING COMMENT 'Numeric level of the account within the chart of accounts hierarchy.',
    `is_budget_enabled` BOOLEAN COMMENT 'Indicates whether the account is included in budgeting and variance analysis.',
    `is_capitalized` BOOLEAN COMMENT 'True if expenditures posted to this account are capitalized as assets.',
    `is_consolidation_account` BOOLEAN COMMENT 'Indicates if the account is used in legal entity consolidation.',
    `is_currency_fixed` BOOLEAN COMMENT 'Indicates whether the account’s currency is locked and cannot be changed.',
    `is_depreciable` BOOLEAN COMMENT 'Indicates whether the account is used for depreciable assets.',
    `is_intercompany` BOOLEAN COMMENT 'True if the account is designated for intercompany transactions.',
    `is_legal_entity_account` BOOLEAN COMMENT 'Indicates whether the account is tied to a specific legal entity.',
    `is_locked` BOOLEAN COMMENT 'True if posting to the account is temporarily blocked.',
    `is_reconciliation_account` BOOLEAN COMMENT 'Indicates if the account is used for automatic reconciliation of sub‑ledger postings.',
    `is_tax_relevant` BOOLEAN COMMENT 'True if the account participates in tax reporting calculations.',
    `posting_block` STRING COMMENT 'Type of posting block applied to the account.. Valid values are `none|period|year|account`',
    `profit_center` STRING COMMENT 'Profit center to which the account is assigned for profitability reporting.',
    `segment` STRING COMMENT 'Business segment used for internal reporting and analysis.',
    `tax_category` STRING COMMENT 'Tax treatment applied to postings against this account.. Valid values are `taxable|exempt|zero|non_taxable`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the GL account record.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'General ledger account master defining the chart of accounts structure for the chemical manufacturing enterprise. Includes account type (P&L, balance sheet), account group, reconciliation account flag, tax category, currency, controlling integration flag, and account description. Serves as the foundational classification for all financial postings, statutory reporting, trial balance generation, and SOX compliance across all legal entities.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'System-generated unique identifier for the journal entry record.',
    `business_unit_id` BIGINT COMMENT 'Identifier of the business unit or division responsible for the entry.',
    `cost_center_id` BIGINT COMMENT 'Cost center to which the cost of the transaction is charged.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SOX audit requires identifying the employee who created each journal entry for accountability.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Journal entries belong to a fiscal period; linking to the fiscal_period master enables period-based reporting and removes the redundant string field.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity (company code) that owns the transaction.',
    `profit_center_id` BIGINT COMMENT 'Profit center that receives the revenue or expense impact.',
    `reversed_journal_entry_id` BIGINT COMMENT 'Identifier of the original journal entry that is being reversed.',
    `created_by_user` STRING COMMENT 'User ID of the person who created the journal entry.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the journal entry record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the transaction amount.. Valid values are `USD|EUR|JPY|GBP|CAD|CHF`',
    `document_number` STRING COMMENT 'External document number assigned to the journal entry for reference and audit.',
    `document_status` STRING COMMENT 'Current processing status of the journal entry.. Valid values are `posted|pending|reversed|error`',
    `document_type` STRING COMMENT 'Category of the journal entry indicating its business purpose (e.g., SA=Sales, AB=Asset, AR=Accounts Receivable).. Valid values are `SA|AB|AR|AP|GL|TR`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert the transaction currency to the corporate group currency.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the posting belongs.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total monetary value before tax, discounts, or adjustments.',
    `intercompany_indicator` BOOLEAN COMMENT 'True if the entry represents an intercompany transaction.',
    `journal_entry_description` STRING COMMENT 'Free‑text description providing context for the posting.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle stage of the journal entry for compliance tracking.. Valid values are `draft|open|posted|closed|cancelled`',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Amount expressed in the legal entitys local currency.',
    `net_amount` DECIMAL(18,2) COMMENT 'Amount after tax and other adjustments.',
    `party_reference` BIGINT COMMENT 'Identifier of the external party (customer, vendor, etc.) associated with the entry.',
    `posting_date` DATE COMMENT 'Date on which the journal entry is posted to the general ledger.',
    `posting_key` STRING COMMENT 'Key that determines the posting type (debit/credit) and account type.',
    `posting_period` STRING COMMENT 'Period code (e.g., "0010") indicating the posting window.',
    `posting_reference` STRING COMMENT 'Reference text used by the posting program for traceability.',
    `reference_number` STRING COMMENT 'Reference number from an external system (e.g., purchase order, invoice).',
    `reversal_indicator` BOOLEAN COMMENT 'True if this entry reverses a prior posting.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the journal entry.',
    `tax_code` STRING COMMENT 'Tax code determining tax rate and jurisdiction.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Exact time the business event that generated the journal entry occurred.',
    `updated_by_user` STRING COMMENT 'User ID of the person who last modified the journal entry.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the journal entry.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Core general ledger posting document capturing all financial transactions across the chemical manufacturing enterprise. Includes document type, posting date, fiscal period, legal entity, reference number, currency, exchange rate, reversal indicator, and audit trail fields. Represents the authoritative record for all accounting events including accruals, reversals, intercompany eliminations, period-end adjustments, tax postings, and reclassifications. Subject to SOX controls, FASB retention requirements, and statutory audit trail obligations.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique surrogate key for each journal entry line.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Journal entry line should reference the GL account via FK for accurate posting.',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the parent journal entry header.',
    `amount_document_currency` DECIMAL(18,2) COMMENT 'Monetary amount of the line in the document currency.',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'Monetary amount of the line converted to the company’s local currency.',
    `assignment_field` STRING COMMENT 'Custom assignment field for additional cost allocation (e.g., order number, asset).',
    `business_segment_code` STRING COMMENT 'Business segment code for segment‑level reporting.',
    `cost_center_code` STRING COMMENT 'Cost center identifier for cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the document amount.',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether the line is a debit or a credit.. Valid values are `debit|credit`',
    `document_date` DATE COMMENT 'Date on the source document for the line.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert from document currency to local currency.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) of the posting.',
    `fiscal_year` STRING COMMENT 'Fiscal year of the posting.',
    `journal_entry_line_status` STRING COMMENT 'Current processing status of the line.. Valid values are `open|posted|reversed|cancelled`',
    `line_quantity` DECIMAL(18,2) COMMENT 'Quantity associated with the line (e.g., units, liters).',
    `line_sequence` STRING COMMENT 'Sequence number of the line within the journal entry.',
    `line_text` STRING COMMENT 'Narrative description of the journal entry line.',
    `posting_date` DATE COMMENT 'Date the line is posted to the ledger.',
    `profit_center_code` STRING COMMENT 'Profit center identifier for profitability reporting.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates if this line is a reversal of a prior line.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount calculated for the line.',
    `tax_code` STRING COMMENT 'Tax code applicable to the line for tax calculation.',
    `updated_by` STRING COMMENT 'User identifier who last updated the line.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the line record.',
    `wbs_element` STRING COMMENT 'Work breakdown structure element or project code associated with the line.',
    `created_by` STRING COMMENT 'User identifier who created the line.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual line item within a general ledger journal entry representing one side of a double-entry posting. Captures GL account, cost center, profit center, project/WBS element, business segment, debit/credit indicator, amount in local and document currency, tax code, assignment field, and line item text. Enables granular cost allocation, plant-level cost accounting, and detailed financial audit trails required for SOX and FASB compliance in chemical manufacturing operations.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`cost_element` (
    `cost_element_id` BIGINT COMMENT 'System-generated unique identifier for the cost element master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost element belongs to a cost center; replace code with FK for proper hierarchy.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each cost element is owned by a cost accountant; the FK supports cost allocation and audit trails.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Cost element may be posted to a GL account; add FK for accurate accounting linkage.',
    `allocation_method` STRING COMMENT 'Method used to allocate the cost element to cost objects (e.g., direct, absorption, activity‑based).. Valid values are `direct|absorption|activity_based|standard`',
    `cost_element_category` STRING COMMENT 'Classification of the cost element indicating its accounting purpose (e.g., primary cost, secondary overhead, revenue).. Valid values are `primary|secondary|revenue|overhead|allocation|other`',
    `cost_element_code` STRING COMMENT 'Business code used to reference the cost element in financial transactions and reporting.',
    `cost_element_description` STRING COMMENT 'Detailed description of the cost element, including business rules and usage notes.',
    `cost_element_name` STRING COMMENT 'Human‑readable name describing the cost element.',
    `cost_element_status` STRING COMMENT 'Current lifecycle status of the cost element.. Valid values are `active|inactive|deprecated|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost element record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the default rate.. Valid values are `USD|EUR|GBP|JPY|CNY`',
    `default_rate` DECIMAL(18,2) COMMENT 'Default monetary rate applied per unit of measure when the cost element is used.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether the cost element is subject to tax.',
    `overhead_rate` DECIMAL(18,2) COMMENT 'Default overhead rate applied when the cost element is used for overhead absorption.',
    `quantity_based_flag` BOOLEAN COMMENT 'Indicates whether the cost element is calculated on a per‑quantity basis.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the cost element must be tracked for regulatory reporting (e.g., REACH, EPA).',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate (percentage) when the cost element is taxable.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure associated with the cost element (e.g., kg, hour, liter).',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the cost element record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cost element record.',
    `version_number` STRING COMMENT 'Version of the cost element definition for change management and audit.',
    `valid_from` DATE COMMENT 'Date from which the cost element becomes valid for posting.',
    `valid_to` DATE COMMENT 'Date after which the cost element is no longer valid (null if open‑ended).',
    `created_by` STRING COMMENT 'User identifier of the person who created the cost element record.',
    CONSTRAINT pk_cost_element PRIMARY KEY(`cost_element_id`)
) COMMENT 'Cost element master defining the nature of costs and revenues tracked in management accounting. Classifies costs as primary (directly linked to GL accounts for external reporting) or secondary (internal allocations, overhead absorption, activity-based costing). Includes cost element category, unit of measure, quantity-based costing flag, and validity period. Critical for standard costing of chemical formulations, overhead rate application, and COGS analysis across batch and continuous manufacturing processes.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`internal_order` (
    `internal_order_id` BIGINT COMMENT 'System-generated unique identifier for the internal order record.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center responsible for the orders expenses.',
    `employee_id` BIGINT COMMENT 'Identifier of the user responsible for the internal order.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the orders activities occur.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred to date against the internal order.',
    `approval_date` DATE COMMENT 'Date on which the internal order received final approval.',
    `approval_status` STRING COMMENT 'Current approval state of the internal order.. Valid values are `Pending|Approved|Rejected`',
    `asset_tag` STRING COMMENT 'Identifier of the fixed asset to which the order is settled, if applicable.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget for the internal order.',
    `budget_month` STRING COMMENT 'Fiscal month (1‑12) of the budget allocation.',
    `budget_version` STRING COMMENT 'Version identifier of the budget (e.g., initial, revised).',
    `budget_year` STRING COMMENT 'Fiscal year to which the budget applies.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Amount of funds that have been committed but not yet spent.',
    `cost_element_code` STRING COMMENT 'Code representing the cost element category for accounting purposes.. Valid values are `COGS|CAPEX|OPEX|R&D|MAINT`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `department` STRING COMMENT 'Organizational department owning the internal order.',
    `external_reference` STRING COMMENT 'Reference to an external document such as a purchase order or contract.',
    `financial_period` STRING COMMENT 'Period identifier used for financial reporting (e.g., FY2025Q1).',
    `internal_order_description` STRING COMMENT 'Free‑text description of the purpose and scope of the internal order.',
    `internal_order_number` STRING COMMENT 'Business-visible alphanumeric identifier assigned to the internal order.',
    `is_capitalized` BOOLEAN COMMENT 'Indicates whether the orders costs are capitalized as an asset.',
    `is_external` BOOLEAN COMMENT 'True if the order pertains to external projects or vendors.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the internal order.. Valid values are `Planned|Approved|InProgress|Closed|Cancelled`',
    `order_date` TIMESTAMP COMMENT 'Timestamp when the internal order was initially created in the system.',
    `order_type` STRING COMMENT 'Classification of the order indicating whether it is capital expenditure, operating expense, research & development, or maintenance.. Valid values are `CapEx|OpEx|R&D|Maintenance`',
    `project_code` STRING COMMENT 'Code of the project or initiative to which the internal order is linked.',
    `project_manager` STRING COMMENT 'Name of the manager overseeing the project linked to the internal order.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first captured in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `remaining_budget` DECIMAL(18,2) COMMENT 'Budget remaining after actual and committed amounts are deducted.',
    `settlement_rule` STRING COMMENT 'Rule that determines how costs are settled (e.g., capitalized to an asset or expensed).. Valid values are `AssetCapitalization|Expense|Deferred`',
    `source_system` STRING COMMENT 'Name of the source system that originated the internal order record.',
    CONSTRAINT pk_internal_order PRIMARY KEY(`internal_order_id`)
) COMMENT 'Cost collection object for tracking expenditures on specific initiatives including capital projects, plant turnarounds, R&D programs, EHS compliance investments, and maintenance campaigns in chemical manufacturing. Captures order type (CapEx, OpEx, R&D, maintenance), budget, actual costs, commitments, settlement rules, responsible cost center, and lifecycle status. Enables project-level cost monitoring, CapEx/OpEx classification per FASB ASC 360, and settlement to fixed assets upon project completion.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` (
    `standard_cost_id` BIGINT COMMENT 'System-generated unique identifier for each standard cost record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Standard cost is defined per cost center; FK replaces code for normalization.',
    `cost_element_id` BIGINT COMMENT 'Foreign key linking to finance.cost_element. Business justification: Standard cost is associated with a cost element; FK enables detailed cost tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cost owners are responsible for cost element accuracy; linking enables cost accountability reporting.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the cost applies.',
    `approval_status` STRING COMMENT 'Current approval state of the cost record.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Identifier of the user who approved the cost record.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost record received approval.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Standard cost per unit of the product, expressed in the specified currency.',
    `cost_name` STRING COMMENT 'Human‑readable name describing the cost record (e.g., "Standard Cost for Polyethylene 2024 Q1").',
    `cost_type` STRING COMMENT 'Classification of the cost record indicating its purpose (standard, planned, budget, or actual).. Valid values are `standard|planned|budget|actual`',
    `cost_uom` STRING COMMENT 'Unit of measure for the cost amount (e.g., kilogram, liter, unit).. Valid values are `kg|lb|ton|liter|gallon|unit`',
    `cost_version_number` STRING COMMENT 'Sequential version number for revisions of the standard cost.',
    `costing_lot_size` DECIMAL(18,2) COMMENT 'Quantity of product units for which the standard cost is calculated.',
    `costing_method` STRING COMMENT 'Method used to derive the standard cost (e.g., FIFO, LIFO, weighted average, standard).. Valid values are `FIFO|LIFO|WeightedAverage|Standard`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `department_code` STRING COMMENT 'Internal department responsible for the cost record.',
    `effective_from` DATE COMMENT 'Date from which the standard cost becomes valid for valuation.',
    `effective_to` DATE COMMENT 'Date after which the standard cost is no longer valid (nullable for open‑ended).',
    `expiration_date` DATE COMMENT 'Date when the standard cost expires (mirrors effective_to).',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the cost record.',
    `product_code` STRING COMMENT 'Unique product or material identifier to which this standard cost applies.',
    `release_date` DATE COMMENT 'Date when the standard cost was officially released for use in valuation.',
    `source_system` STRING COMMENT 'Name of the source system that supplied the cost data (e.g., SAP FI/CO).',
    `standard_cost_status` STRING COMMENT 'Current lifecycle status of the cost record.. Valid values are `active|inactive|draft|released|obsolete`',
    `updated_by` STRING COMMENT 'Identifier of the user or process that last updated the cost record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the cost record.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the cost record.',
    CONSTRAINT pk_standard_cost PRIMARY KEY(`standard_cost_id`)
) COMMENT 'Standard cost estimate for chemical finished goods, intermediates, and formulations used for inventory valuation and COGS determination. Captures cost component breakdown (raw materials, direct labor, energy, manufacturing overhead, depreciation), standard price per unit, costing lot size, validity period, and release status. Supports product costing for complex multi-step chemical synthesis, make-vs-buy decisions, transfer pricing, and variance analysis against actual production costs in batch and continuous process environments.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` (
    `budget_plan_id` BIGINT COMMENT 'System-generated unique identifier for each budget plan record.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget plan is prepared for a specific cost center; FK replaces code.',
    `cost_element_id` BIGINT COMMENT 'Foreign key linking to finance.cost_element. Business justification: Budget plan allocates amounts by cost element; FK enables detailed reporting.',
    `internal_order_id` BIGINT COMMENT 'Identifier of the internal order linked to the budget plan for project‑level cost tracking.',
    `primary_budget_employee_id` BIGINT COMMENT 'System identifier of the employee who approved the budget plan.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budget plan also targets a profit center; FK provides direct linkage.',
    `tertiary_budget_approved_by_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `approval_date` DATE COMMENT 'Date when the budget plan received final approval.',
    `approval_outcome` STRING COMMENT 'Enum indicating the final outcome of the budget plan approval process.. Valid values are `pending|approved|rejected`',
    `approval_status` STRING COMMENT 'Result of the approval workflow (e.g., Pending, Approved, Rejected).',
    `budget_plan_status` STRING COMMENT 'Current lifecycle status of the budget plan (e.g., Draft, Submitted, Approved, Closed).',
    `budget_type` STRING COMMENT 'Classification of the budget plan indicating whether it is the original budget, a supplemental addition, or a return of funds.. Valid values are `original|supplement|return`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the budget amounts (e.g., USD, EUR).',
    `effective_end_date` DATE COMMENT 'Date on which the budget plan expires; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the budget plan becomes effective for financial posting.',
    `fiscal_year` STRING COMMENT 'Four‑digit calendar year to which the budget applies (e.g., 2025).',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the budget plan is locked from further edits.',
    `last_review_date` DATE COMMENT 'Date of the most recent review or re‑forecast of the budget plan.',
    `lifecycle_status` STRING COMMENT 'Standardized lifecycle state of the budget plan used for workflow routing.. Valid values are `draft|submitted|approved|closed|rejected`',
    `notes` STRING COMMENT 'Free‑form text field for additional comments, rationale, or special instructions.',
    `plan_number` STRING COMMENT 'Business-visible identifier or code for the budget plan, often used in reporting and approvals.',
    `plan_version` STRING COMMENT 'Version number of the budget plan to support revisions and re‑approvals.',
    `planned_amount` DECIMAL(18,2) COMMENT 'Total amount budgeted for the specified cost element and period.',
    `planning_period` STRING COMMENT 'Period within the fiscal year for which the budget is planned (quarter, half‑year, or full year). [ENUM-REF-CANDIDATE: Q1|Q2|Q3|Q4|H1|H2|Annual — 7 candidates stripped; promote to reference product]',
    `scenario` STRING COMMENT 'Descriptive label for the budgeting scenario (e.g., Base, Optimistic, Pessimistic).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the budget plan record.',
    `variance_allowed` DECIMAL(18,2) COMMENT 'Maximum permissible variance (percentage) between actual spend and planned amount before alerts are raised.',
    CONSTRAINT pk_budget_plan PRIMARY KEY(`budget_plan_id`)
) COMMENT 'Annual and multi-year budget plan record for cost centers, profit centers, and internal orders. Captures budget version, fiscal year, planning period, budget type (original, supplement, return), planned amounts by cost element, currency, approval status, and planner identity. Supports financial planning, annual budgeting cycles, variance-to-budget reporting, and management reporting for chemical manufacturing operations including plant-level OpEx budgets and R&D investment planning.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`capex_request` (
    `capex_request_id` BIGINT COMMENT 'System-generated unique identifier for the capital expenditure request.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Capex request is charged to a cost center; FK provides proper cost allocation.',
    `plant_id` BIGINT COMMENT 'Identifier of the plant or facility where the investment will be implemented.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who created the CapEx request.',
    `tertiary_capex_project_manager_employee_id` BIGINT COMMENT 'Employee responsible for day‑to‑day execution of the project.',
    `actual_end_date` DATE COMMENT 'Real calendar date when work was completed.',
    `actual_start_date` DATE COMMENT 'Real calendar date when work actually began.',
    `approval_workflow_status` STRING COMMENT 'Current stage of the internal approval workflow.. Valid values are `not_started|in_review|final_approval|completed`',
    `approved_budget` DECIMAL(18,2) COMMENT 'Budget amount formally approved for the project.',
    `budget_year` STRING COMMENT 'Calendar year in which the budget was allocated.',
    `business_justification` STRING COMMENT 'Explanation of the strategic and financial rationale for the investment.',
    `capex_classification` STRING COMMENT 'Indicates whether the asset is tangible or intangible.. Valid values are `tangible|intangible`',
    `capex_request_status` STRING COMMENT 'Current lifecycle status of the request.. Valid values are `draft|submitted|approved|rejected|cancelled`',
    `compliance_status` STRING COMMENT 'Indicates whether the project complies with internal and external regulations.. Valid values are `compliant|non_compliant`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `depreciation_method` STRING COMMENT 'Method used to depreciate the capitalized asset.. Valid values are `straight_line|double_declining|units_of_production`',
    `environmental_impact_assessment_flag` BOOLEAN COMMENT 'Indicates whether an environmental impact assessment is required.',
    `estimated_total_cost` DECIMAL(18,2) COMMENT 'Projected total cost of the investment before approval.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the CapEx budget is allocated.',
    `funding_source` STRING COMMENT 'Source of capital funding for the project.. Valid values are `internal|external|loan|grant`',
    `investment_category` STRING COMMENT 'Business classification of the capital project.. Valid values are `new_capacity|replacement|ehs_compliance|r_and_d|maintenance`',
    `net_capex_amount` DECIMAL(18,2) COMMENT 'Approved budget less any offsets or rebates.',
    `priority` STRING COMMENT 'Priority level assigned to the request by the governance board.. Valid values are `low|medium|high|critical`',
    `project_description` STRING COMMENT 'Detailed narrative describing the scope and purpose of the project.',
    `project_end_date` DATE COMMENT 'Planned calendar date for project completion.',
    `project_start_date` DATE COMMENT 'Planned calendar date for project commencement.',
    `project_title` STRING COMMENT 'Short, descriptive title of the capital project.',
    `regulatory_approval_required` BOOLEAN COMMENT 'True if external regulatory sign‑off is needed for the project.',
    `regulatory_approval_status` STRING COMMENT 'Current status of any required regulatory approvals.. Valid values are `not_required|pending|approved|rejected`',
    `request_date` TIMESTAMP COMMENT 'Timestamp when the request was initially submitted.',
    `request_number` STRING COMMENT 'Human‑readable reference number assigned to the request.. Valid values are `CAPEX-d{4}-d{4}`',
    `risk_rating` STRING COMMENT 'Overall risk assessment for the capital project.. Valid values are `low|moderate|high|critical`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the approved budget.',
    `total_expected_savings` DECIMAL(18,2) COMMENT 'Projected cost savings or efficiency gains resulting from the investment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `useful_life_years` STRING COMMENT 'Expected economic life of the asset in years.',
    CONSTRAINT pk_capex_request PRIMARY KEY(`capex_request_id`)
) COMMENT 'Capital expenditure request and approval record for plant investments, equipment acquisitions, and facility upgrades in chemical manufacturing. Captures project description, requesting plant/cost center, investment category (new capacity, replacement, EHS compliance, R&D), estimated total cost, approved budget, CapEx classification (tangible/intangible), business justification, approval workflow status, and expected useful life. Supports CapEx governance, FASB ASC 360 compliance, and capital planning.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique surrogate key for the fixed asset record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Asset management requires a designated custodian employee for maintenance, audit, and compliance.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation recorded to date for the asset.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original cost incurred to acquire the asset.',
    `acquisition_date` DATE COMMENT 'Date the asset was acquired.',
    `asset_category` STRING COMMENT 'High-level classification of the asset type.. Valid values are `building|machinery|equipment|vehicle|infrastructure`',
    `asset_condition` STRING COMMENT 'Physical condition of the asset.. Valid values are `new|good|fair|poor|scrapped`',
    `asset_name` STRING COMMENT 'Descriptive name of the asset used for reporting and identification.',
    `asset_subcategory` STRING COMMENT 'More detailed classification within the asset category.',
    `asset_tag` STRING COMMENT 'Unique asset tag or inventory number assigned to the asset.. Valid values are `^[A-Z0-9_-]+$`',
    `capitalized_flag` BOOLEAN COMMENT 'Indicates whether the cost has been capitalized on the balance sheet.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of the asset.. Valid values are `compliant|non_compliant|pending`',
    `cost_center_code` STRING COMMENT 'Cost center to which the asset expense is charged.. Valid values are `^[A-Z0-9]{3,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset record was first created in the system.',
    `depreciation_end_date` DATE COMMENT 'Date depreciation is scheduled to end (or actual end if retired).',
    `depreciation_method` STRING COMMENT 'Method used to calculate depreciation for the asset.. Valid values are `straight_line|double_declining|units_of_production`',
    `depreciation_rate_percent` DECIMAL(18,2) COMMENT 'Annual depreciation rate expressed as a percentage.',
    `depreciation_start_date` DATE COMMENT 'Date depreciation began for the asset.',
    `disposal_date` DATE COMMENT 'Date the asset was disposed of or retired.',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Monetary proceeds received from disposing of the asset.',
    `ehs_classification` STRING COMMENT 'Environmental, Health, and Safety risk classification for the asset.. Valid values are `low|medium|high|critical`',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the assets environmental impact.',
    `fixed_asset_status` STRING COMMENT 'Current operational status of the asset.. Valid values are `in_service|retired|under_maintenance|disposed`',
    `impairment_amount` DECIMAL(18,2) COMMENT 'Amount of loss recognized due to asset impairment.',
    `impairment_indicator` BOOLEAN COMMENT 'Flag indicating whether the asset has been deemed impaired.',
    `insurance_value` DECIMAL(18,2) COMMENT 'Insured value of the asset for risk management.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent compliance or safety inspection.',
    `location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the assets primary location.',
    `location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the assets primary location.',
    `maintenance_contract_flag` BOOLEAN COMMENT 'Indicates whether the asset is covered by a maintenance contract.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the asset.',
    `model_number` STRING COMMENT 'Model identifier assigned by the manufacturer.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying amount of the asset (cost less accumulated depreciation).',
    `plant_location` STRING COMMENT 'Identifier of the plant or site where the asset is installed.',
    `regulatory_code` STRING COMMENT 'CAS number or other regulatory identifier associated with the asset.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `residual_value` DECIMAL(18,2) COMMENT 'Estimated salvage value of the asset after disposal.',
    `serial_number` STRING COMMENT 'Unique serial number stamped on the asset.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the asset record.',
    `useful_life_years` STRING COMMENT 'Estimated useful life of the asset in years for depreciation purposes.',
    `warranty_expiration_date` DATE COMMENT 'Date the manufacturers warranty expires.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Master record for capitalized plant property and equipment including chemical reactors, distillation columns, storage tanks, control systems, buildings, and infrastructure. Captures asset class, acquisition date and cost, accumulated depreciation, net book value, useful life, depreciation method, plant/cost center assignment, and retirement status. Supports balance sheet reporting, depreciation scheduling, insurance valuation, and regulatory compliance under FASB ASC 360 for impairment testing.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` (
    `asset_transaction_id` BIGINT COMMENT 'System-generated unique identifier for each asset transaction record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Asset transaction should reference the cost center responsible for the transaction.',
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier of the fixed asset affected by the transaction.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Asset transaction needs to be linked to the GL account for proper posting.',
    `reversal_transaction_asset_transaction_id` BIGINT COMMENT 'Identifier of the transaction that reverses this one, if applicable.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total monetary value before taxes, fees, or adjustments.',
    `amount_net` DECIMAL(18,2) COMMENT 'Net monetary value after tax/fee adjustments.',
    `amount_tax` DECIMAL(18,2) COMMENT 'Tax or fee component associated with the transaction.',
    `asset_acquisition_date` DATE COMMENT 'Date the asset was originally acquired or placed in service.',
    `asset_category` STRING COMMENT 'Classification of the asset (e.g., reactor, tank, column, infrastructure).',
    `asset_life_years` STRING COMMENT 'Planned useful life of the asset expressed in years.',
    `asset_location_code` STRING COMMENT 'Plant or site code where the asset is physically located.',
    `asset_retirement_date` DATE COMMENT 'Date the asset was retired or disposed of, if applicable.',
    `asset_status` STRING COMMENT 'Current operational status of the asset.. Valid values are `in_service|retired|under_maintenance|disposed`',
    `asset_sub_location_code` STRING COMMENT 'Specific area or department within the plant where the asset resides.',
    `asset_tag` STRING COMMENT 'Physical tag or barcode assigned to the asset.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the transaction currency.',
    `depreciation_amount` DECIMAL(18,2) COMMENT 'Monetary amount posted for depreciation in this transaction.',
    `depreciation_area` STRING COMMENT 'Depreciation area (e.g., main, special, tax) for the posting.. Valid values are `main|special|tax`',
    `depreciation_book` STRING COMMENT 'Depreciation book identifier used for accounting purposes.',
    `depreciation_end_date` DATE COMMENT 'Date when depreciation calculations cease (asset fully depreciated or retired).',
    `depreciation_method` STRING COMMENT 'Method used to calculate depreciation for the asset.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits`',
    `depreciation_rate_percent` DECIMAL(18,2) COMMENT 'Annual depreciation rate expressed as a percentage.',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation calculations begin for the asset.',
    `document_number` STRING COMMENT 'Reference number of the originating document (e.g., purchase order, invoice).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate applied when converting from transaction currency to reporting currency.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year of the posting.',
    `is_manual` BOOLEAN COMMENT 'Indicates whether the transaction was entered manually (True) or generated automatically (False).',
    `posting_date` DATE COMMENT 'Financial period date on which the transaction was posted to the general ledger.',
    `posting_period` STRING COMMENT 'Fiscal period identifier used for the posting (e.g., 2023M04).',
    `source_system` STRING COMMENT 'Name of the source ERP/system that generated the transaction (e.g., SAP FI/CO).',
    `tax_code` STRING COMMENT 'Tax code used to determine tax treatment for the transaction.',
    `transaction_description` STRING COMMENT 'Free‑text description providing context or notes for the transaction.',
    `transaction_number` STRING COMMENT 'Business-visible identifier assigned to the transaction (e.g., journal entry number).',
    `transaction_status` STRING COMMENT 'Current processing state of the transaction.. Valid values are `draft|posted|reversed|cancelled`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Exact date and time the transaction event occurred in the source system.',
    `transaction_type` STRING COMMENT 'Category of the asset value movement.. Valid values are `acquisition|retirement|transfer|write_up|write_down|depreciation`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the transaction record.',
    CONSTRAINT pk_asset_transaction PRIMARY KEY(`asset_transaction_id`)
) COMMENT 'Fixed asset transaction record capturing all asset value movements including acquisitions, retirements, transfers, write-ups, write-downs, and periodic depreciation postings. Includes transaction type, posting date, amount, document reference, asset value date, depreciation area, and GL account assignment. Provides the complete financial history of plant assets (reactors, columns, tanks, infrastructure) for FASB ASC 360 compliance, audit trails, and SOX controls.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'Unique system-generated identifier for the WBS element.',
    `cost_center_id` BIGINT COMMENT 'Cost center responsible for the expenses recorded against this WBS element.',
    `employee_id` BIGINT COMMENT 'Employee responsible for overall ownership of the WBS element.',
    `parent_wbs_element_id` BIGINT COMMENT 'Identifier of the immediate parent WBS element in the hierarchy.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant to which the WBS element is assigned.',
    `project_id` BIGINT COMMENT 'Higher‑level project to which this WBS element belongs.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred to date for the WBS element.',
    `actual_end_date` DATE COMMENT 'Date when work on the WBS element was completed.',
    `actual_start_date` DATE COMMENT 'Date when work on the WBS element actually began.',
    `approval_status` STRING COMMENT 'Current approval state of the WBS element.. Valid values are `pending|approved|rejected`',
    `asset_class` STRING COMMENT 'Classification of the asset for accounting purposes (e.g., building, equipment).',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned budget allocated to the WBS element.',
    `budget_version` STRING COMMENT 'Version label of the budget (e.g., baseline, revised).',
    `capitalization_eligible` BOOLEAN COMMENT 'Indicates whether costs on this element are eligible for capitalization under ASC 360.',
    `change_control_number` STRING COMMENT 'Identifier of the change request that modified this WBS element.',
    `committed_cost` DECIMAL(18,2) COMMENT 'Cost that has been committed (e.g., purchase orders) but not yet incurred.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the WBS element record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `depreciation_life_years` STRING COMMENT 'Estimated useful life in years for depreciation calculations.',
    `depreciation_method` STRING COMMENT 'Method used to depreciate capitalized costs associated with this element.. Valid values are `straight_line|declining_balance|units_of_production`',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation of capitalized costs begins.',
    `effective_from` DATE COMMENT 'Date from which the WBS element becomes effective for reporting.',
    `effective_until` DATE COMMENT 'Date after which the WBS element is no longer effective (null if open‑ended).',
    `end_date` DATE COMMENT 'Planned end date of the WBS element.',
    `external_reference` STRING COMMENT 'Reference code from external systems (e.g., ERP, PMIS) linked to this WBS element.',
    `hierarchy_level` STRING COMMENT 'Depth of the element within the WBS hierarchy (root = 1).',
    `hierarchy_path` STRING COMMENT 'Delimited string representing the full path from the root to this element (e.g., 001/005/012).',
    `is_milestone` BOOLEAN COMMENT 'Indicates whether the WBS element represents a project milestone.',
    `last_review_date` DATE COMMENT 'Date when the WBS element was last reviewed for status or scope changes.',
    `milestone_date` DATE COMMENT 'Target date for the milestone, if applicable.',
    `planned_cost` DECIMAL(18,2) COMMENT 'Cost forecast for the remainder of the elements lifecycle.',
    `priority` STRING COMMENT 'Priority level assigned to the WBS element for execution sequencing.. Valid values are `high|medium|low`',
    `risk_level` STRING COMMENT 'Assessed risk level for the WBS element.. Valid values are `high|medium|low|none`',
    `start_date` DATE COMMENT 'Planned start date of the WBS element.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the WBS element record.',
    `wbs_code` STRING COMMENT 'Business identifier code assigned to the WBS element, used in project accounting and reporting.',
    `wbs_element_description` STRING COMMENT 'Detailed description of the scope and purpose of the WBS element.',
    `wbs_name` STRING COMMENT 'Human‑readable name of the WBS element.',
    `wbs_status` STRING COMMENT 'Current lifecycle status of the WBS element.. Valid values are `planned|active|completed|on_hold|cancelled`',
    `wbs_type` STRING COMMENT 'Classification of the element within the project hierarchy (e.g., project, phase, task).. Valid values are `project|phase|task|package|activity`',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Work Breakdown Structure element for hierarchical project cost tracking of capital investments, plant turnaround shutdowns, capacity expansions, and R&D programs. Captures project hierarchy position, responsible cost center, plant assignment, budget, actual costs, commitments, and capitalization eligibility. Enables multi-year project cost control, milestone-based budget release, and FASB ASC 360 capitalization decisions for chemical manufacturing infrastructure investments.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'System-generated unique identifier for the bank account master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Bank account oversight is assigned to a treasury employee; linking enables responsibility tracking and regulatory reporting.',
    `gl_account_id` BIGINT COMMENT 'Link to the General Ledger account used for posting cash movements related to this bank account.',
    `sweep_target_bank_account_id` BIGINT COMMENT 'Self-referencing FK on bank_account (sweep_target_bank_account_id)',
    `account_limit` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed on the account, expressed in the account currency.',
    `account_number` STRING COMMENT 'Full bank account number used for treasury cash management; classified as PCI financial data.',
    `account_type` STRING COMMENT 'Classification of the account for treasury purposes (e.g., operating, payroll, investment, escrow).. Valid values are `operating|payroll|investment|escrow`',
    `bank_account_description` STRING COMMENT 'Free‑form description or notes about the account purpose or special conditions.',
    `bank_account_status` STRING COMMENT 'Current lifecycle status of the bank account.. Valid values are `active|inactive|closed|suspended|pending`',
    `bank_country` STRING COMMENT 'Three‑letter ISO 3166‑1 alpha‑3 country code where the bank is located.',
    `bank_name` STRING COMMENT 'Legal name of the banking institution holding the account.',
    `bank_swift_code` STRING COMMENT 'International Bank Identifier Code (SWIFT) for the banking institution, per ISO 9362.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the account with internal and external regulations (e.g., SOX, FASB).. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the account.. Valid values are `USD|EUR|JPY|GBP|CNY|CHF`',
    `effective_from` DATE COMMENT 'Date when the bank account became effective for treasury operations.',
    `effective_until` DATE COMMENT 'Date when the bank account is scheduled to be terminated or become inactive; null for open‑ended.',
    `is_overdraft_allowed` BOOLEAN COMMENT 'Indicates whether the account permits overdraft facilities.',
    `last_reconciliation_date` DATE COMMENT 'Date of the most recent bank statement reconciliation.',
    `last_statement_date` DATE COMMENT 'Date of the most recent bank statement received from the bank.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'Maximum overdraft amount permitted, if overdraft is allowed.',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates if the account requires explicit regulatory approval (e.g., for foreign currency exposure).',
    `regulatory_approval_status` STRING COMMENT 'Current status of any required regulatory approval for the account.. Valid values are `approved|rejected|pending`',
    `signatory_primary_name` STRING COMMENT 'Legal name of the primary authorized signatory for the account.',
    `signatory_primary_title` STRING COMMENT 'Job title or role of the primary signatory within Chemical Mfg.',
    `signatory_secondary_name` STRING COMMENT 'Legal name of the secondary authorized signatory, if applicable.',
    `signatory_secondary_title` STRING COMMENT 'Job title or role of the secondary signatory.',
    `treasury_center_code` STRING COMMENT 'Internal code identifying the treasury operating unit responsible for the account.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the bank account record.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Master record for corporate bank accounts used in treasury operations and cash management for the chemical manufacturing enterprise. Captures bank identifier, account number, account type (operating, payroll, investment, escrow), currency, bank name, country, GL account assignment, signatory authorities, and account status. Supports cash position reporting, payment execution, bank statement reconciliation, and liquidity planning across multiple banking relationships and jurisdictions.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` (
    `fx_exposure_id` BIGINT COMMENT 'System-generated unique identifier for the FX exposure record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: FX exposure is reported per cost center; FK aligns exposure with cost accounting.',
    `hedge_instrument_id` BIGINT COMMENT 'Identifier of the specific hedge contract (e.g., forward contract number).',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity (company) that owns the exposure.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: FX risk monitoring is performed by a designated risk‑manager employee; the link supports exposure reporting and audit.',
    `netted_fx_exposure_id` BIGINT COMMENT 'Self-referencing FK on fx_exposure (netted_fx_exposure_id)',
    `accounting_designation` STRING COMMENT 'ASC 815 hedge accounting classification for the exposure.. Valid values are `fair_value_hedge|cash_flow_hedge|none`',
    `approval_status` STRING COMMENT 'Current approval state of the exposure for hedge accounting.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the exposure was approved.',
    `approved_by` BIGINT COMMENT 'User identifier of the person who approved the exposure.',
    `audit_trail_reference` BIGINT COMMENT 'Reference to the audit‑trail record capturing change history for this exposure.',
    `base_currency` STRING COMMENT 'ISO 4217 code of the currency in which the notional amount is expressed.. Valid values are `^[A-Z]{3}$`',
    `comments` STRING COMMENT 'Free‑form notes or remarks about the exposure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exposure record was first created in the system.',
    `currency_pair` STRING COMMENT 'Combined ISO 4217 codes of the base and quote currencies (e.g., USD/EUR).. Valid values are `^[A-Z]{3}/[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date the exposure becomes effective for accounting and risk purposes.',
    `exchange_rate_at_valuation` DECIMAL(18,2) COMMENT 'FX rate used to convert the exposure to the reporting currency on the valuation date.',
    `exposure_category` STRING COMMENT 'High‑level classification of the exposure purpose.. Valid values are `market|transactional|operational`',
    `exposure_number` STRING COMMENT 'Business identifier assigned to the exposure for tracking and reporting.',
    `exposure_type` STRING COMMENT 'Classifies the exposure as arising from a transactional event or from translation of foreign‑currency balances.. Valid values are `transactional|translational`',
    `fair_value` DECIMAL(18,2) COMMENT 'Current fair value of the hedge instrument in the reporting currency.',
    `fx_exposure_status` STRING COMMENT 'Current lifecycle status of the exposure record.. Valid values are `open|closed|settled|cancelled`',
    `hedge_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for the hedge instrument, expressed in reporting currency.',
    `hedge_effectiveness` DECIMAL(18,2) COMMENT 'Percentage (0‑100) indicating how effectively the hedge offsets the exposure.',
    `hedge_instrument_type` STRING COMMENT 'Type of derivative used to hedge the exposure.. Valid values are `forward|option|swap|future`',
    `hedge_ratio` DECIMAL(18,2) COMMENT 'Proportion of the exposure that is covered by the hedge (0‑100%).',
    `is_exposure_active` BOOLEAN COMMENT 'Flag indicating whether the exposure is still open and subject to risk.',
    `is_hedge_active` BOOLEAN COMMENT 'Flag indicating whether the hedge is currently active.',
    `last_valuation_timestamp` TIMESTAMP COMMENT 'Exact time when the most recent valuation of the exposure was performed.',
    `maturity_date` DATE COMMENT 'Date on which the hedge instrument expires or settles.',
    `notional_amount` DECIMAL(18,2) COMMENT 'Principal amount of the exposure expressed in the base currency.',
    `quote_currency` STRING COMMENT 'ISO 4217 code of the currency used to value the exposure.. Valid values are `^[A-Z]{3}$`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the exposure must be disclosed in regulatory filings.',
    `reporting_currency` STRING COMMENT 'Currency in which the exposure is reported for financial statements.. Valid values are `^[A-Z]{3}$`',
    `risk_metric_delta` DECIMAL(18,2) COMMENT 'Sensitivity of the exposure value to a one‑unit change in the underlying rate.',
    `risk_metric_vega` DECIMAL(18,2) COMMENT 'Sensitivity of the exposure value to volatility changes in the underlying instrument.',
    `settlement_date` DATE COMMENT 'Date on which the exposure is expected to be settled or realized.',
    `source_system` STRING COMMENT 'Originating source system that supplied the exposure data (e.g., SAP FI/CO).',
    `source_transaction_reference` BIGINT COMMENT 'Identifier of the underlying transaction that generated the exposure (e.g., purchase order).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the exposure record.',
    `valuation_date` DATE COMMENT 'Date on which the exposure and hedge were last valued.',
    `version_number` STRING COMMENT 'Incremental version of the exposure record for concurrency control.',
    CONSTRAINT pk_fx_exposure PRIMARY KEY(`fx_exposure_id`)
) COMMENT 'Foreign exchange exposure and hedging record tracking currency risk positions arising from cross-border raw material purchases, international product sales, and intercompany transactions in chemical manufacturing. Captures exposure type (transactional, translational), currency pair, notional amount, hedge instrument (forward, option, swap), hedge effectiveness, fair value, maturity date, and FASB ASC 815 hedge accounting designation. Supports treasury risk management and financial reporting of derivative instruments.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`fiscal_period` (
    `fiscal_period_id` BIGINT COMMENT 'Primary key for fiscal_period',
    `prior_fiscal_period_id` BIGINT COMMENT 'Self-referencing FK on fiscal_period (prior_fiscal_period_id)',
    `adjustment_reason` STRING COMMENT 'Explanation for any adjustment applied to the period.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the fiscal period record was first created in the system.',
    `days_in_period` STRING COMMENT 'Total count of calendar days covered by the period.',
    `fiscal_period_description` STRING COMMENT 'Optional free‑text description providing additional context about the period.',
    `fiscal_quarter` STRING COMMENT 'Quarter number (1‑4) within the fiscal year.',
    `fiscal_year` STRING COMMENT 'Four‑digit calendar year to which the period belongs.',
    `is_adjusted` BOOLEAN COMMENT 'True if the period dates or length were adjusted for accounting reasons.',
    `is_current` BOOLEAN COMMENT 'True if this period is the active reporting period.',
    `period_code` STRING COMMENT 'Standardized code representing the fiscal period (e.g., FY2023Q1, 2023M01, 2023).',
    `period_end_date` DATE COMMENT 'Last calendar date of the fiscal period.',
    `period_name` STRING COMMENT 'Human‑readable name of the fiscal period, such as "Fiscal Q1 2023".',
    `period_start_date` DATE COMMENT 'First calendar date of the fiscal period.',
    `period_type` STRING COMMENT 'Granularity of the period – month, quarter, or year.',
    `fiscal_period_status` STRING COMMENT 'Lifecycle status of the period for reporting purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the fiscal period record.',
    CONSTRAINT pk_fiscal_period PRIMARY KEY(`fiscal_period_id`)
) COMMENT 'Master reference table for fiscal_period. Referenced by period_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`hedge_instrument` (
    `hedge_instrument_id` BIGINT COMMENT 'Primary key for hedge_instrument',
    `party_id` BIGINT COMMENT 'Identifier of the counterparty to the hedge contract.',
    `fixed_asset_id` BIGINT COMMENT 'Identifier of the underlying asset or reference entity for the hedge instrument.',
    `rolled_hedge_instrument_id` BIGINT COMMENT 'Self-referencing FK on hedge_instrument (rolled_hedge_instrument_id)',
    `accounting_treatment` STRING COMMENT 'Accounting classification for the hedge instrument under financial reporting standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hedge instrument record was created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code of the hedge instruments notional amount.',
    `hedge_instrument_description` STRING COMMENT 'Free-text description providing additional details about the hedge instrument.',
    `effective_from` DATE COMMENT 'Date when the hedge instrument becomes effective.',
    `effective_until` DATE COMMENT 'Date when the hedge instrument ceases to be effective, if applicable.',
    `hedge_ratio` DECIMAL(18,2) COMMENT 'Proportion of exposure covered by the hedge instrument.',
    `instrument_category` STRING COMMENT 'Broad classification of the hedge instrument based on underlying risk factor.',
    `instrument_code` STRING COMMENT 'External reference code or ticker for the hedge instrument.',
    `instrument_name` STRING COMMENT 'Descriptive name of the hedge instrument.',
    `instrument_type` STRING COMMENT 'Category of derivative instrument used for hedging.',
    `last_valuation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent valuation performed on the hedge instrument.',
    `maturity_date` DATE COMMENT 'Date when the hedge instrument expires or settles.',
    `notional_amount` DECIMAL(18,2) COMMENT 'Principal amount on which the hedge instruments cash flows are based.',
    `risk_rating` STRING COMMENT 'Internal risk rating assigned to the hedge instrument.',
    `settlement_method` STRING COMMENT 'Method by which the hedge instrument is settled.',
    `hedge_instrument_status` STRING COMMENT 'Current lifecycle status of the hedge instrument.',
    `strike_price` DECIMAL(18,2) COMMENT 'Fixed price agreed for options or caps/floors.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the hedge instrument record.',
    `valuation_method` STRING COMMENT 'Approach used to value the hedge instrument for accounting.',
    CONSTRAINT pk_hedge_instrument PRIMARY KEY(`hedge_instrument_id`)
) COMMENT 'Master reference table for hedge_instrument. Referenced by hedge_instrument_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
    `parent_entity_id` BIGINT COMMENT 'Identifier of the parent legal entity in a corporate hierarchy.',
    `parent_legal_entity_id` BIGINT COMMENT 'Self-referencing FK on legal_entity (parent_legal_entity_id)',
    `address_line1` STRING COMMENT 'First line of the entitys registered street address.',
    `address_line2` STRING COMMENT 'Second line of the entitys registered street address (optional).',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Total revenue reported for the most recent fiscal year, in US dollars.',
    `city` STRING COMMENT 'City of the entitys registered address.',
    `compliance_status` STRING COMMENT 'Current status of the entitys compliance with industry regulations.',
    `country_code` STRING COMMENT 'Three-letter country code where the entity is incorporated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the legal entity record was first created in the system.',
    `credit_rating` STRING COMMENT 'External credit rating assigned to the entity.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 code of the entitys functional currency.',
    `data_classification` STRING COMMENT 'Classification level assigned to the entitys data.',
    `end_date` DATE COMMENT 'Date when the entity ceased to exist (if applicable).',
    `entity_category` STRING COMMENT 'Broad category describing the entitys relationship to the organization.',
    `entity_type` STRING COMMENT 'Classification of the entitys legal structure.',
    `industry_code` STRING COMMENT 'North American Industry Classification System code representing the entitys primary industry.',
    `is_public_company` BOOLEAN COMMENT 'True if the entity is publicly listed on a stock exchange.',
    `legal_name` STRING COMMENT 'Full registered legal name of the entity as per incorporation documents.',
    `legal_entity_name` STRING COMMENT 'Primary display name of the legal entity (e.g., company name).',
    `notes` STRING COMMENT 'Free-text field for any supplemental information about the entity.',
    `number_of_employees` STRING COMMENT 'Total headcount employed by the entity.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the entitys registered address.',
    `primary_contact_email` STRING COMMENT 'Email address for the primary contact of the entity.',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person for the entity.',
    `primary_contact_phone` STRING COMMENT 'Phone number for the primary contact of the entity.',
    `registration_number` STRING COMMENT 'Government issued registration number (e.g., company registration).',
    `sic_code` STRING COMMENT 'SIC code representing the entitys industry.',
    `start_date` DATE COMMENT 'Date when the entity was legally established.',
    `state_province` STRING COMMENT 'State or province of the entitys registered address.',
    `legal_entity_status` STRING COMMENT 'Current operational status of the legal entity.',
    `stock_ticker` STRING COMMENT 'Ticker symbol if the entity is publicly traded.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the entity is exempt from certain taxes.',
    `tax_number` STRING COMMENT 'Tax ID used for reporting to tax authorities.',
    `trade_name` STRING COMMENT 'Doing Business As name under which the entity operates commercially.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the legal entity record.',
    `website_url` STRING COMMENT 'Public website address of the entity.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master reference table for legal_entity. Referenced by legal_entity_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`finance`.`business_unit` (
    `business_unit_id` BIGINT COMMENT 'Primary key for business_unit',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `parent_business_unit_id` BIGINT COMMENT 'Identifier of the immediate parent unit in the organizational hierarchy.',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `address` STRING COMMENT 'Street address of the business units main location.',
    `annual_budget` DECIMAL(18,2) COMMENT 'Approved budget for the fiscal year, expressed in the corporate currency.',
    `business_unit_code` STRING COMMENT 'External business identifier or code used in ERP and reporting systems.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code representing the primary country of operation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the business unit record was first created in the system.',
    `business_unit_description` STRING COMMENT 'Free‑form text describing the purpose, scope, and responsibilities of the unit.',
    `effective_end_date` DATE COMMENT 'Date when the business unit ceased to be operational; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the business unit became operational or effective.',
    `headcount` STRING COMMENT 'Total number of employees assigned to the business unit.',
    `business_unit_name` STRING COMMENT 'Human‑readable name of the business unit (e.g., North America Manufacturing).',
    `phone_number` STRING COMMENT 'Primary telephone number for the business unit office.',
    `region` STRING COMMENT 'Broad geographic region where the business unit operates.',
    `business_unit_status` STRING COMMENT 'Current lifecycle status of the business unit.',
    `business_unit_type` STRING COMMENT 'Category that defines the nature of the unit within the organization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the business unit record.',
    CONSTRAINT pk_business_unit PRIMARY KEY(`business_unit_id`)
) COMMENT 'Master reference table for business_unit. Referenced by business_unit_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_parent_account_gl_account_id` FOREIGN KEY (`parent_account_gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_reversed_journal_entry_id` FOREIGN KEY (`reversed_journal_entry_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ADD CONSTRAINT `fk_finance_cost_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ADD CONSTRAINT `fk_finance_cost_element_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_reversal_transaction_asset_transaction_id` FOREIGN KEY (`reversal_transaction_asset_transaction_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`asset_transaction`(`asset_transaction_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_parent_wbs_element_id` FOREIGN KEY (`parent_wbs_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_sweep_target_bank_account_id` FOREIGN KEY (`sweep_target_bank_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ADD CONSTRAINT `fk_finance_fx_exposure_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ADD CONSTRAINT `fk_finance_fx_exposure_hedge_instrument_id` FOREIGN KEY (`hedge_instrument_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`hedge_instrument`(`hedge_instrument_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ADD CONSTRAINT `fk_finance_fx_exposure_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ADD CONSTRAINT `fk_finance_fx_exposure_netted_fx_exposure_id` FOREIGN KEY (`netted_fx_exposure_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fx_exposure`(`fx_exposure_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_prior_fiscal_period_id` FOREIGN KEY (`prior_fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`hedge_instrument` ADD CONSTRAINT `fk_finance_hedge_instrument_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`hedge_instrument` ADD CONSTRAINT `fk_finance_hedge_instrument_rolled_hedge_instrument_id` FOREIGN KEY (`rolled_hedge_instrument_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`hedge_instrument`(`hedge_instrument_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_entity_id` FOREIGN KEY (`parent_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_parent_business_unit_id` FOREIGN KEY (`parent_business_unit_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `chemical_mfg_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|activity_based|standard|none');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Fiscal Year');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'overhead|production|r&d|sales|logistics');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_level` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Level');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'plant|department|function|project|shared_service');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_driver` SET TAGS ('dbx_business_glossary_term' = 'Cost Driver');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Country');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `group` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Hierarchy Level');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `is_capex` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Region');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percent');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'organizational_ledger');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Cost Center Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Manager Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `capex_budget` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Budget');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `ebitda_amount` SET TAGS ('dbx_business_glossary_term' = 'EBITDA Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `is_reportable` SET TAGS ('dbx_business_glossary_term' = 'Reportable Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `opex_budget` SET TAGS ('dbx_business_glossary_term' = 'OPEX Budget');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_group` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Group');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_group` SET TAGS ('dbx_value_regex' = 'global|regional|local');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'segment|plant|product_line|business_unit|region|function');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'specialty_chemicals|performance_materials|agricultural_solutions|pharma|consumer_goods');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'organizational_ledger');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Owner Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `parent_account_gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account ID');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Group');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Name');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Number');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Type');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'balance_sheet|profit_and_loss|equity|off_balance');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `depreciation_key` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Key');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `financial_statement_line` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Line');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `is_budget_enabled` SET TAGS ('dbx_business_glossary_term' = 'Budget Enabled Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `is_capitalized` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `is_consolidation_account` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `is_currency_fixed` SET TAGS ('dbx_business_glossary_term' = 'Currency Fixed Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `is_depreciable` SET TAGS ('dbx_business_glossary_term' = 'Depreciable Asset Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Account Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `is_legal_entity_account` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Account Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Posting Lock Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `is_reconciliation_account` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `is_tax_relevant` SET TAGS ('dbx_business_glossary_term' = 'Tax Relevance Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `posting_block` SET TAGS ('dbx_business_glossary_term' = 'Posting Block Type');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `posting_block` SET TAGS ('dbx_value_regex' = 'none|period|year|account');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Reporting Segment');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_value_regex' = 'taxable|exempt|zero|non_taxable');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'organizational_ledger');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (JE ID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier (Business Unit ID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (Cost Center ID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (Legal Entity ID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (Profit Center ID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Journal Entry Identifier (Reversed JE ID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (Created By)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|CHF');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Document Number (JE Number)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|error');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Document Type (Document Type)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'SA|AB|AR|AP|GL|TR');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to Group Currency (Exchange Rate)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Amount (Gross Amount)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Description');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|open|posted|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount (Net Amount)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `party_reference` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (Party ID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_reference` SET TAGS ('dbx_business_glossary_term' = 'Posting Reference');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Event Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (Updated By)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'organizational_ledger');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_document_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount (Document Currency)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount (Local Currency)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `business_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Business Segment Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_status` SET TAGS ('dbx_value_regex' = 'open|posted|reversed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Quantity');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_text` SET TAGS ('dbx_business_glossary_term' = 'Line Text');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Element');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Owner Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|absorption|activity_based|standard');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|revenue|overhead|allocation|other');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `cost_element_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Description');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `cost_element_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Name');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `cost_element_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `cost_element_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `default_rate` SET TAGS ('dbx_business_glossary_term' = 'Default Cost Rate');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `overhead_rate` SET TAGS ('dbx_business_glossary_term' = 'Overhead Rate');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `quantity_based_flag` SET TAGS ('dbx_business_glossary_term' = 'Quantity‑Based Cost Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Identifier (IO_ID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (CC_ID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner User Identifier (OWNER_UID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (PLANT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (ACT_COST)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DT)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STS)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Pending|Approved|Rejected');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag (ASSET_TAG)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (BUDGET_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_month` SET TAGS ('dbx_business_glossary_term' = 'Budget Month (BUDGET_MTH)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version (BUDGET_VER)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year (BUDGET_YR)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount (COMMIT_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code (COST_ELEM)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_value_regex' = 'COGS|CAPEX|OPEX|R&D|MAINT');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department (DEPT)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference (EXT_REF)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `financial_period` SET TAGS ('dbx_business_glossary_term' = 'Financial Period (FIN_PERIOD)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `internal_order_description` SET TAGS ('dbx_business_glossary_term' = 'Order Description (DESC)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number (IO_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `is_capitalized` SET TAGS ('dbx_business_glossary_term' = 'Is Capitalized Flag (CAPITALIZED_FLG)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `is_external` SET TAGS ('dbx_business_glossary_term' = 'Is External Order Flag (EXTERNAL_FLG)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STS)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'Planned|Approved|InProgress|Closed|Cancelled');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date (ORDER_DT)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type (OTYPE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'CapEx|OpEx|R&D|Maintenance');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code (PRJ_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `project_manager` SET TAGS ('dbx_business_glossary_term' = 'Project Manager (PM)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created (AUDIT_CREATED)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated (AUDIT_UPDATED)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `remaining_budget` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget (REMAIN_BUDGET)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule (SETTLE_RULE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_value_regex' = 'AssetCapitalization|Expense|Deferred');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Owner Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_name` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Name');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_type` SET TAGS ('dbx_value_regex' = 'standard|planned|budget|actual');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_uom` SET TAGS ('dbx_business_glossary_term' = 'Cost Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_uom` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|liter|gallon|unit');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_version_number` SET TAGS ('dbx_business_glossary_term' = 'Cost Version Number');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `costing_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Costing Lot Size');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `costing_method` SET TAGS ('dbx_business_glossary_term' = 'Costing Method');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `costing_method` SET TAGS ('dbx_value_regex' = 'FIFO|LIFO|WeightedAverage|Standard');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Cost Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Notes');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code (Material Number)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Cost Release Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `standard_cost_status` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `standard_cost_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|released|obsolete');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `primary_budget_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `primary_budget_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `primary_budget_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `tertiary_budget_approved_by_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `approval_outcome` SET TAGS ('dbx_business_glossary_term' = 'Approval Outcome');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `approval_outcome` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'original|supplement|return');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Lock Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|closed|rejected');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Notes');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Number');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Version');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Budget Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `planning_period` SET TAGS ('dbx_business_glossary_term' = 'Planning Period');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `scenario` SET TAGS ('dbx_business_glossary_term' = 'Budget Scenario');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ALTER COLUMN `variance_allowed` SET TAGS ('dbx_business_glossary_term' = 'Allowed Variance Percentage');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'CapEx Request Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `tertiary_capex_project_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Employee Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `tertiary_capex_project_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `tertiary_capex_project_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Project End Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Project Start Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_value_regex' = 'not_started|in_review|final_approval|completed');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `approved_budget` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `capex_classification` SET TAGS ('dbx_business_glossary_term' = 'CapEx Classification');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `capex_classification` SET TAGS ('dbx_value_regex' = 'tangible|intangible');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `capex_request_status` SET TAGS ('dbx_business_glossary_term' = 'CapEx Request Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `capex_request_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|units_of_production');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `environmental_impact_assessment_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `estimated_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Cost');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'internal|external|loan|grant');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `investment_category` SET TAGS ('dbx_business_glossary_term' = 'Investment Category');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `investment_category` SET TAGS ('dbx_value_regex' = 'new_capacity|replacement|ehs_compliance|r_and_d|maintenance');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `net_capex_amount` SET TAGS ('dbx_business_glossary_term' = 'Net CapEx Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Project Priority');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Project End Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Project Start Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `project_title` SET TAGS ('dbx_business_glossary_term' = 'Project Title');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'CapEx Request Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'CapEx Request Number (CAPEX_REQ_NUM)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = 'CAPEX-d{4}-d{4}');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `total_expected_savings` SET TAGS ('dbx_business_glossary_term' = 'Total Expected Savings');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost (COST)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category (CATEGORY)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_value_regex' = 'building|machinery|equipment|vehicle|infrastructure');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_condition` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_condition` SET TAGS ('dbx_value_regex' = 'new|good|fair|poor|scrapped');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Asset Subcategory');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag (ASSET TAG)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]+$');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalized_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalized Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method (METHOD)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|units_of_production');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate Percent');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `ehs_classification` SET TAGS ('dbx_business_glossary_term' = 'EHS Classification');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `ehs_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `environmental_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Score');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Status (STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|under_maintenance|disposed');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_value` SET TAGS ('dbx_business_glossary_term' = 'Insurance Value');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Location Latitude');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Location Longitude');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `maintenance_contract_flag` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `plant_location` SET TAGS ('dbx_business_glossary_term' = 'Plant Location');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `regulatory_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Code (CAS NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `regulatory_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `residual_value` SET TAGS ('dbx_business_glossary_term' = 'Residual Value');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (YEARS)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Transaction ID');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `reversal_transaction_asset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Transaction ID');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `amount_tax` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Acquisition Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_life_years` SET TAGS ('dbx_business_glossary_term' = 'Asset Useful Life (Years)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_location_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Retirement Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|under_maintenance|disposed');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_sub_location_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Sub‑Location Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_value_regex' = 'main|special|tax');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `depreciation_book` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Book');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `depreciation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate Percent');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Source Document Number');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `is_manual` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'acquisition|retirement|transfer|write_up|write_down|depreciation');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`asset_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Element ID');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (COST CENTER ID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Identifier (OWNER ID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `parent_wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Breakdown Structure Element ID (PARENT WBS ID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (PLANT ID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (PROJECT ID)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (ACTUAL COST)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date (ACTUAL END DATE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date (ACTUAL START DATE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class (ASSET CLASS)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (BUDGET AMOUNT)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version (BUDGET VERSION)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `capitalization_eligible` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Eligible (CAPITALIZATION ELIGIBLE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number (CHANGE CONTROL NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `committed_cost` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost (COMMITTED COST)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY CODE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `depreciation_life_years` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Life (DEPRECIATION LIFE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method (DEPRECIATION METHOD)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date (DEPRECIATION START DATE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFFECTIVE FROM)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFFECTIVE UNTIL)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date (END DATE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference (EXTERNAL REFERENCE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level (HIERARCHY LEVEL)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path (HIERARCHY PATH)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `is_milestone` SET TAGS ('dbx_business_glossary_term' = 'Milestone Flag (IS MILESTONE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LAST REVIEW DATE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Date (MILESTONE DATE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost (PLANNED COST)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority (PRIORITY)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK LEVEL)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date (START DATE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Code (WBS CODE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_description` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Description (WBS DESCRIPTION)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_name` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Name (WBS NAME)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_status` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Status (WBS STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|on_hold|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_type` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Type (WBS TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_type` SET TAGS ('dbx_value_regex' = 'project|phase|task|package|activity');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `sweep_target_bank_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `account_limit` SET TAGS ('dbx_business_glossary_term' = 'Account Credit Limit');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'operating|payroll|investment|escrow');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_description` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Description');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_description` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended|pending');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_country` SET TAGS ('dbx_business_glossary_term' = 'Bank Country Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('dbx_business_glossary_term' = 'Bank SWIFT/BIC Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CNY|CHF');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `is_overdraft_allowed` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Allowed Indicator');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Bank Statement Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Credit Limit');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_primary_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Signatory Full Name');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_primary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_primary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_primary_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Signatory Title');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_secondary_name` SET TAGS ('dbx_business_glossary_term' = 'Secondary Signatory Full Name');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_secondary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_secondary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_secondary_title` SET TAGS ('dbx_business_glossary_term' = 'Secondary Signatory Title');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `treasury_center_code` SET TAGS ('dbx_business_glossary_term' = 'Treasury Center Code');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `fx_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Exposure ID');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `hedge_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Hedge Instrument Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `netted_fx_exposure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `accounting_designation` SET TAGS ('dbx_business_glossary_term' = 'Accounting Designation');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `accounting_designation` SET TAGS ('dbx_value_regex' = 'fair_value_hedge|cash_flow_hedge|none');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `base_currency` SET TAGS ('dbx_business_glossary_term' = 'Base Currency');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `base_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `currency_pair` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `currency_pair` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}/[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `exchange_rate_at_valuation` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate at Valuation');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `exposure_category` SET TAGS ('dbx_business_glossary_term' = 'Exposure Category');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `exposure_category` SET TAGS ('dbx_value_regex' = 'market|transactional|operational');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `exposure_number` SET TAGS ('dbx_business_glossary_term' = 'Exposure Number');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `exposure_type` SET TAGS ('dbx_business_glossary_term' = 'Exposure Type');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `exposure_type` SET TAGS ('dbx_value_regex' = 'transactional|translational');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `fair_value` SET TAGS ('dbx_business_glossary_term' = 'Fair Value of Hedge');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `fx_exposure_status` SET TAGS ('dbx_business_glossary_term' = 'Exposure Status');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `fx_exposure_status` SET TAGS ('dbx_value_regex' = 'open|closed|settled|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `hedge_cost` SET TAGS ('dbx_business_glossary_term' = 'Hedge Cost');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `hedge_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `hedge_instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Hedge Instrument Type');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `hedge_instrument_type` SET TAGS ('dbx_value_regex' = 'forward|option|swap|future');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `hedge_ratio` SET TAGS ('dbx_business_glossary_term' = 'Hedge Ratio');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `is_exposure_active` SET TAGS ('dbx_business_glossary_term' = 'Is Exposure Active');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `is_hedge_active` SET TAGS ('dbx_business_glossary_term' = 'Is Hedge Active');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `last_valuation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Valuation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Amount');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `quote_currency` SET TAGS ('dbx_business_glossary_term' = 'Quote Currency');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `quote_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `risk_metric_delta` SET TAGS ('dbx_business_glossary_term' = 'Delta Risk Metric');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `risk_metric_vega` SET TAGS ('dbx_business_glossary_term' = 'Vega Risk Metric');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Related Transaction ID');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_subdomain' = 'organizational_ledger');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fiscal_period` ALTER COLUMN `prior_fiscal_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`hedge_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`hedge_instrument` SET TAGS ('dbx_subdomain' = 'treasury_operations');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `hedge_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Hedge Instrument Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`hedge_instrument` ALTER COLUMN `rolled_hedge_instrument_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'organizational_ledger');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` ALTER COLUMN `parent_legal_entity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`business_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`business_unit` SET TAGS ('dbx_subdomain' = 'organizational_ledger');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`business_unit` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`business_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`business_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`business_unit` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`business_unit` ALTER COLUMN `address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`business_unit` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`business_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`finance`.`business_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
