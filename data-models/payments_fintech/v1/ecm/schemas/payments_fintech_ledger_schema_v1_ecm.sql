-- Schema for Domain: ledger | Business: Payments Fintech | Version: v1_ecm
-- Generated on: 2026-05-03 18:25:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`ledger` COMMENT 'General ledger and financial accounting including GL account management, journal entries, revenue recognition, expense allocation, intercompany settlements, financial period close, and SOX-compliant financial controls. Manages chart of accounts, cost centers, and financial reporting structures.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique surrogate key for the GL account record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Consolidated financial statements require each GL account to reference a currency entity for accurate reporting and conversion.',
    `parent_account_gl_account_id` BIGINT COMMENT 'Identifier of the immediate parent account in the hierarchical chart of accounts.',
    `account_group` STRING COMMENT 'Logical grouping label used for reporting roll‑ups.',
    `account_name` STRING COMMENT 'Human‑readable name or title of the GL account.',
    `account_number` STRING COMMENT 'Business identifier code for the GL account as used in accounting systems.',
    `account_owner` STRING COMMENT 'Organizational unit or department responsible for the account.',
    `account_subtype` STRING COMMENT 'Secondary classification providing more granular detail (e.g., cash, accounts receivable, prepaid expense).',
    `account_type` STRING COMMENT 'Primary classification of the account according to accounting fundamentals.. Valid values are `asset|liability|equity|revenue|expense`',
    `cost_center_code` STRING COMMENT 'Code of the cost center to which the account is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the GL account record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the account is retired; null for open‑ended accounts.',
    `effective_start_date` DATE COMMENT 'Date on which the account becomes active for posting.',
    `external_reference_code` STRING COMMENT 'Identifier of the account in an external financial system (e.g., legacy ERP).',
    `financial_statement` STRING COMMENT 'Indicates which primary financial statement the account belongs to.. Valid values are `balance_sheet|income_statement|cash_flow|equity_statement`',
    `gl_account_description` STRING COMMENT 'Free‑form text describing the purpose or usage of the account.',
    `gl_account_status` STRING COMMENT 'Current operational status of the GL account.. Valid values are `active|inactive|pending|closed`',
    `hierarchy_level` STRING COMMENT 'Depth of the account within the chart of accounts hierarchy (0 = top level).',
    `is_budgeted` BOOLEAN COMMENT 'True if the account is included in the formal budgeting process.',
    `is_consolidation` BOOLEAN COMMENT 'True if the account participates in legal entity consolidation reporting.',
    `is_intercompany` BOOLEAN COMMENT 'True if the account is used for intercompany transactions.',
    `normal_balance` STRING COMMENT 'Indicates whether the account normally carries a debit or credit balance.. Valid values are `debit|credit`',
    `profit_center_code` STRING COMMENT 'Code of the profit center associated with the account.',
    `reporting_currency` STRING COMMENT 'Currency used for consolidated reporting of this account.',
    `segment_code` STRING COMMENT 'Identifier for the business segment (e.g., retail, corporate) linked to the account.',
    `sox_control_classification` STRING COMMENT 'Indicates the SOX compliance requirement for the account.. Valid values are `required|optional|none`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the GL account record.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'Chart of accounts master record defining every general ledger account used across the enterprise. Captures account number, account type (asset, liability, equity, revenue, expense), normal balance direction, account hierarchy level, parent account reference, financial statement mapping (P&L vs balance sheet), currency, consolidation flag, intercompany flag, and SOX control classification. This is the SSOT for all GL account definitions in Oracle Financials and the authoritative reference for all journal entry postings.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique surrogate key for each cost center record.',
    `allocation_basis` STRING COMMENT 'Method used to allocate expenses to the cost center.. Valid values are `headcount|revenue|expense|custom`',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total budget allocated to this cost center when part of a shared pool.',
    `approval_date` DATE COMMENT 'Date when the cost center budget was approved.',
    `approval_status` STRING COMMENT 'Current approval state of the cost center budget.. Valid values are `approved|rejected|pending`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned monetary budget allocated to the cost center for the defined period.',
    `budget_period` STRING COMMENT 'Frequency of the budget allocation.. Valid values are `annual|quarterly|monthly`',
    `budget_year` STRING COMMENT 'Fiscal year for which the budget amount applies.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the cost center with internal policies and external regulations.. Valid values are `compliant|non_compliant|under_review`',
    `cost_center_code` STRING COMMENT 'Business identifier used in accounting and reporting systems.',
    `cost_center_description` STRING COMMENT 'Free‑form description providing additional context about the cost center.',
    `cost_center_group` STRING COMMENT 'Logical grouping of cost centers for consolidated reporting.',
    `cost_center_name` STRING COMMENT 'Human‑readable name of the cost center.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center.. Valid values are `active|inactive|planned|closed`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center for reporting and allocation purposes.. Valid values are `internal|external|project|department|shared`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the cost center record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the budget.. Valid values are `^[A-Z]{3}$`',
    `data_classification` STRING COMMENT 'Classification level applied to the cost center data for governance.. Valid values are `public|internal|confidential|restricted`',
    `department` STRING COMMENT 'Department responsible for the cost center.',
    `division` STRING COMMENT 'Division within the business unit to which the cost center belongs.',
    `effective_end_date` DATE COMMENT 'Date when the cost center ceases to be effective; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the cost center becomes effective for budgeting and reporting.',
    `external_reference` STRING COMMENT 'Identifier of the cost center in external ERP or financial systems.',
    `gl_account` STRING COMMENT 'GL account number associated with the cost center for posting transactions.',
    `hierarchy_level` STRING COMMENT 'Numeric level of the cost center within the organizational hierarchy.',
    `is_shared` BOOLEAN COMMENT 'Indicates whether the cost center is shared across multiple business units.',
    `last_review_date` DATE COMMENT 'Date when the cost center was last reviewed for budgeting or compliance.',
    `manager_email` STRING COMMENT 'Email address of the cost center manager.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `manager_name` STRING COMMENT 'Full name of the manager responsible for the cost center.',
    `owning_business_unit` STRING COMMENT 'Top‑level business unit that owns the cost center.',
    `parent_cost_center_code` STRING COMMENT 'Code of the immediate parent cost center in the hierarchy, if any.',
    `risk_level` STRING COMMENT 'Risk classification for the cost center based on financial exposure.. Valid values are `low|medium|high`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the cost center record.',
    `created_by` STRING COMMENT 'User or system identifier that created the cost center record.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Organizational cost center master record representing a financial responsibility unit within the payments fintech enterprise. Captures cost center code, name, owning business unit, division, department, manager, active status, budget period, currency, and allocation basis. Used for expense allocation, P&L reporting by business unit, and management accounting. Aligns with Oracle Financials cost center segment in the accounting flexfield.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'System-generated unique identifier for the legal entity record.',
    `consolidation_group_id` BIGINT COMMENT 'FK to ledger.consolidation_group',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: KYC and regulatory filings require each legal entity to be linked to its country of registration.',
    `parent_entity_legal_entity_id` BIGINT COMMENT 'Identifier of the immediate parent legal entity, if any.',
    `primary_ultimate_parent_legal_entity_id` BIGINT COMMENT 'Identifier of the top‑most parent in the corporate hierarchy.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: AML/CTF compliance mandates mapping each entity to the governing regulatory jurisdiction.',
    `address_line1` STRING COMMENT 'Primary street address of the legal entity.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `aml_screening_status` STRING COMMENT 'Result of anti‑money‑laundering screening for the entity.. Valid values are `clear|matched|pending_review`',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Total revenue reported for the most recent fiscal year.',
    `city` STRING COMMENT 'City component of the entitys address.',
    `compliance_document_reference` STRING COMMENT 'Reference to the most recent compliance documentation (e.g., audit report ID).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the legal entity record was first created in the system.',
    `data_source_system` STRING COMMENT 'Originating operational system that supplied the record (e.g., ERP, CRM).',
    `dissolution_date` DATE COMMENT 'Date on which the entity was legally dissolved, if applicable.',
    `effective_date` DATE COMMENT 'Date when the entity became operational for reporting purposes.',
    `email_address` STRING COMMENT 'Primary email address used for official communications.',
    `employee_count` STRING COMMENT 'Number of full‑time equivalent employees employed by the entity.',
    `financial_reporting_period` STRING COMMENT 'Standard period used for financial statements (Fiscal Year or Quarter).. Valid values are `FY|Q1|Q2|Q3|Q4`',
    `functional_currency` STRING COMMENT 'Currency used for day‑to‑day operations of the entity.. Valid values are `^[A-Z]{3}$`',
    `iban` STRING COMMENT 'Standardized bank account number for international transfers.. Valid values are `^[A-Z0-9]{15,34}$`',
    `incorporation_date` DATE COMMENT 'Date on which the entity was legally formed.',
    `industry_code` STRING COMMENT 'Standard industry classification code for the entitys primary business.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance or financial audit.',
    `legal_entity_name` STRING COMMENT 'Common name used to refer to the legal entity in business contexts.',
    `legal_entity_status` STRING COMMENT 'Current operational state of the entity within the organization.. Valid values are `active|inactive|suspended|closed|pending`',
    `legal_entity_type` STRING COMMENT 'Category describing the legal structure of the entity.. Valid values are `corporation|subsidiary|branch|joint_venture|partnership|sole_proprietorship`',
    `ofac_sanctions_status` STRING COMMENT 'Result of OFAC sanctions screening for the entity.. Valid values are `clear|matched|pending_review`',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the entity.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the entitys address.',
    `registration_jurisdiction` STRING COMMENT 'Country or region where the entity is legally registered.',
    `registration_number` STRING COMMENT 'Official registration identifier assigned by the jurisdiction of incorporation.',
    `regulatory_license_number` STRING COMMENT 'Identifier of the license authorizing the entity to provide payment services.',
    `regulatory_license_type` STRING COMMENT 'Category of the regulatory licence held by the entity.. Valid values are `payment_service|money_transmitter|e_money|other`',
    `reporting_currency` STRING COMMENT 'Currency in which the entity reports financial results for consolidation.. Valid values are `^[A-Z]{3}$`',
    `risk_rating` STRING COMMENT 'Internal risk assessment category for the entity.. Valid values are `low|medium|high|critical`',
    `state_province` STRING COMMENT 'State or province component of the entitys address.',
    `swift_bic` STRING COMMENT 'International bank identifier used for cross‑border payments.. Valid values are `^[A-Z0-9]{8,11}$`',
    `tax_id_type` STRING COMMENT 'Classification of the tax identification number format.. Valid values are `EIN|VAT|GST|Other`',
    `tax_identification_number` STRING COMMENT 'Government‑issued tax identifier for the entity (e.g., EIN, VAT number).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the legal entity record.',
    `website_url` STRING COMMENT 'Public website address of the legal entity.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Legal entity master record representing each incorporated company, subsidiary, or branch within the payments fintech corporate group. Captures legal entity name, registration number, jurisdiction of incorporation, tax identification number, functional currency, consolidation group, SWIFT BIC, regulatory license references, and OFAC/sanctions screening status. Serves as the top-level organizational anchor for all financial reporting and intercompany accounting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` (
    `accounting_period_id` BIGINT COMMENT 'System-generated unique identifier for the accounting period record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Period‑level reporting and closing balances depend on the periods functional currency, mandated by accounting standards.',
    `ledger_config_id` BIGINT COMMENT 'Reference to the ledger to which this accounting period belongs.',
    `ledger_ledger_config_id` BIGINT COMMENT 'Reference to the ledger to which this accounting period belongs.',
    `close_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the period was closed for posting.',
    `closing_balance_amount` DECIMAL(18,2) COMMENT 'Total ledger balance recorded at the moment the period was closed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the accounting period record was first created in the system.',
    `end_date` DATE COMMENT 'Last calendar date on which the accounting period ends.',
    `fiscal_year` STRING COMMENT 'Four‑digit calendar year to which the period belongs, e.g., 2023.',
    `is_adjustment_period` BOOLEAN COMMENT 'Indicates whether the period is used for post‑close adjustments rather than regular transaction posting.',
    `is_archived` BOOLEAN COMMENT 'Indicates whether the period has been archived for historical reference and is read‑only.',
    `is_current` BOOLEAN COMMENT 'True if this period is the active period for posting at the current point in time.',
    `open_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the period was opened for posting.',
    `period_category` STRING COMMENT 'High‑level classification of the periods primary purpose, e.g., financial reporting, tax reporting, or internal reporting.. Valid values are `financial|tax|reporting`',
    `period_code` STRING COMMENT 'Business-facing code that uniquely identifies the period within the fiscal calendar, often used in journal entries and reporting.',
    `period_description` STRING COMMENT 'Optional free‑text description providing additional context about the period.',
    `period_name` STRING COMMENT 'Human‑readable name of the period, e.g., "FY2023 Q1" or "2023‑01".',
    `period_number` STRING COMMENT 'Sequential number of the period within its fiscal year (1‑12 for months, 1‑4 for quarters).',
    `period_sequence` STRING COMMENT 'Numeric order of the period within the fiscal year, useful for sorting (e.g., 1 for Jan, 2 for Feb).',
    `period_status` STRING COMMENT 'Current lifecycle state of the period: open (accepting postings), closed (postings stopped), locked (no changes allowed), or pending (not yet active).. Valid values are `open|closed|locked|pending`',
    `period_type` STRING COMMENT 'Classification of the period granularity: month, quarter, year, or adjustment.. Valid values are `month|quarter|year|adjustment`',
    `period_version` STRING COMMENT 'Version number of the period record to support re‑open/re‑close scenarios and audit trails.',
    `start_date` DATE COMMENT 'First calendar date on which the accounting period begins.',
    `updated_by` STRING COMMENT 'Identifier of the user or process that last modified the accounting period record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the accounting period record.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the accounting period record.',
    CONSTRAINT pk_accounting_period PRIMARY KEY(`accounting_period_id`)
) COMMENT 'Financial accounting period master defining the fiscal calendar used for GL posting, period-end close, and financial reporting. Captures period name, fiscal year, period number, period type (month, quarter, year), open/closed status, period open date, period close date, adjustment period flag, and the ledger it belongs to. Controls which periods accept journal entry postings and drives the financial period close workflow.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique surrogate key for the journal entry record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Journal entries are posted to a specific accounting period; FK supports period‑level queries.',
    `approver_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the journal entry for posting.',
    `approver_id` BIGINT COMMENT 'Identifier of the employee who approved the journal entry for posting.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Journal entries are posted in a specific currency; linking enables automated FX conversion.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who prepared the journal entry.',
    `primary_journal_employee_id` BIGINT COMMENT 'Identifier of the employee who prepared the journal entry.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Required for FX gain/loss reconciliation report linking each journal entry to the exact FX rate used in the conversion.',
    `related_party_id` BIGINT COMMENT 'Identifier of the counter‑party (merchant, cardholder, or other) associated with the entry.',
    `reversal_of_journal_entry_id` BIGINT COMMENT 'Identifier of the original journal entry that this entry reverses, if applicable.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the processing batch that contains this entry.',
    `accounting_date` DATE COMMENT 'The fiscal date to which the entry is posted for financial reporting.',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the business reason for the adjustment.. Valid values are `error_correction|policy_change|revaluation|other`',
    `cost_center_code` STRING COMMENT 'Code identifying the cost center charged by the entry.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the journal entry record was first created in the system.',
    `department_code` STRING COMMENT 'Organizational department associated with the entry.',
    `entry_number` STRING COMMENT 'Business identifier assigned to the journal entry, often used in accounting reports.',
    `entry_type` STRING COMMENT 'Classification of the journal entry source such as payment processing, settlement, manual adjustment, intercompany, or recurring.. Valid values are `payment|settlement|manual|intercompany|recurring`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'FX rate applied when the entry involves a foreign currency.',
    `exchange_rate_date` DATE COMMENT 'Date for which the exchange rate is applicable.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year of the entry.',
    `intercompany_flag` BOOLEAN COMMENT 'True if the entry records an intercompany transaction.',
    `is_adjustment` BOOLEAN COMMENT 'True if the entry represents an accounting adjustment.',
    `journal_entry_description` STRING COMMENT 'Free‑form text describing the purpose or nature of the journal entry.',
    `journal_entry_status` STRING COMMENT 'Current lifecycle status of the journal entry.. Valid values are `draft|open|posted|reversed|cancelled`',
    `ledger_code` STRING COMMENT 'Identifier of the ledger (e.g., general, subsidiary) where the entry is posted.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after tax and adjustments, used for reporting.',
    `period` STRING COMMENT 'Accounting period identifier (e.g., 2023‑04) to which the entry belongs.',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the entry was posted to the general ledger.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this entry is a reversal of a prior entry.',
    `segment_code` STRING COMMENT 'Analytical segment identifier for reporting (e.g., product line, geography).',
    `source_module` STRING COMMENT 'Specific module within the source system that produced the entry.. Valid values are `GL|AP|AR|FA`',
    `source_system` STRING COMMENT 'Originating system that generated the journal entry.. Valid values are `ERP|Gateway|Settlement|Dispute`',
    `sox_control_reference` STRING COMMENT 'Reference to the specific SOX control that governs this entry.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component captured in the entry, if applicable.',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'Aggregate credit amount for the journal entry, expressed in the entry currency.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'Aggregate debit amount for the journal entry, expressed in the entry currency.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Exact time the underlying business event occurred (e.g., payment authorization).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the journal entry record.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'General ledger journal entry header record representing a balanced accounting transaction posted to the GL. Captures journal entry number, journal source (payment processing, settlement, manual, intercompany, recurring), journal category, accounting date, currency, total debit amount, total credit amount, posting status, reversal flag, reversal period, preparer, approver, SOX control reference, and description. The primary transactional record for all financial activity in Oracle Financials GL module.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`journal_line` (
    `journal_line_id` BIGINT COMMENT 'Unique surrogate key for each line item within a general ledger journal entry.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Journal lines inherit the period of their parent entry; explicit FK improves traceability.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SOX audit requires tracking which employee created each journal line; adding created_by_employee_id links to employee.',
    `gl_account_id` BIGINT COMMENT 'FK to ledger.gl_account',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the parent journal entry to which this line belongs.',
    `journal_journal_entry_id` BIGINT COMMENT 'Identifier of the parent journal entry to which this line belongs.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Needed for detailed audit of each journal line recording foreign exchange amounts, supporting regulatory FX reporting.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Line‑level transactions may have a distinct transaction currency; required for accurate posting.',
    `adjustment_type` STRING COMMENT 'Categorization of the adjustment line (e.g., correction, reversal, write‑off).. Valid values are `correction|reversal|writeoff`',
    `business_unit_code` STRING COMMENT 'Identifier of the business unit owning the transaction for internal reporting.',
    `cost_center_code` STRING COMMENT 'Code of the cost center to which the transaction cost is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the journal line was initially created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Monetary amount credited on this line, expressed in the functional currency of the entity.',
    `debit_amount` DECIMAL(18,2) COMMENT 'Monetary amount debited on this line, expressed in the functional currency of the entity.',
    `functional_currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the functional currency used for accounting.. Valid values are `^[A-Z]{3}$`',
    `fx_rate` DECIMAL(18,2) COMMENT 'Rate used to convert the transaction amount from transaction currency to functional currency for this line.',
    `fx_rate_date` DATE COMMENT 'Calendar date of the foreign‑exchange rate used for conversion.',
    `fx_rate_source` STRING COMMENT 'Name of the provider or system that supplied the foreign‑exchange rate.',
    `intercompany_entity_code` STRING COMMENT 'Identifier of the related inter‑company entity for intercompany journal entries.',
    `is_adjustment` BOOLEAN COMMENT 'True if the line represents an adjustment (correction, reversal, write‑off) rather than a regular transaction.',
    `legal_entity_code` STRING COMMENT 'Identifier of the legal entity (e.g., subsidiary) owning the transaction.',
    `line_description` STRING COMMENT 'Narrative text describing the purpose of the line item.',
    `line_number` STRING COMMENT 'Ordinal position of the line within the journal entry.',
    `line_status` STRING COMMENT 'Lifecycle status indicating whether the line is posted, pending, reversed, or encountered an error.. Valid values are `posted|pending|reversed|error`',
    `posting_date` DATE COMMENT 'Calendar date on which the line is posted to the general ledger.',
    `project_code` STRING COMMENT 'Code of the project or initiative associated with the line for cost allocation.',
    `reconciliation_reference` STRING COMMENT 'External identifier (such as ARN, MID, or payment token) used to reconcile this line with source systems.',
    `segment_code` STRING COMMENT 'Code used to group lines for segment‑level financial reporting.',
    `source_system` STRING COMMENT 'Name of the upstream operational system that originated the journal line.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax amount associated with the line, expressed in functional currency.',
    `tax_code` STRING COMMENT 'Code representing the tax rule or jurisdiction applicable to this line.',
    `updated_by` STRING COMMENT 'Identifier of the user or automated process that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the journal line.',
    CONSTRAINT pk_journal_line PRIMARY KEY(`journal_line_id`)
) COMMENT 'Individual debit or credit line within a GL journal entry. Captures line number, GL account, cost center, legal entity, project, intercompany entity, debit amount, credit amount, functional currency amount, transaction currency amount, FX rate, line description, tax code, and reconciliation reference. Each journal entry must have balanced lines (total debits = total credits). Supports drill-through from financial statements to source transactions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` (
    `gl_balance_id` BIGINT COMMENT 'Unique surrogate identifier for each GL balance snapshot.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center associated with the balance for internal reporting.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Balance calculations and revaluations need a normalized currency reference for audit trails.',
    `gl_account_id` BIGINT COMMENT 'Unique identifier of the GL account for which the balance is recorded.',
    `ledger_config_id` BIGINT COMMENT 'Identifier of the ledger (e.g., primary ledger, sub‑ledger) to which the balance belongs.',
    `ledger_ledger_config_id` BIGINT COMMENT 'Identifier of the ledger (e.g., primary ledger, sub‑ledger) to which the balance belongs.',
    `balance_status` STRING COMMENT 'Lifecycle state of the balance (e.g., posted after close, provisional during interim).. Valid values are `posted|provisional|adjusted`',
    `balance_type` STRING COMMENT 'Indicates whether the balance is in functional currency or reporting currency.. Valid values are `functional|reporting`',
    `closing_balance` DECIMAL(18,2) COMMENT 'Balance after applying period debits and credits; used for financial statements.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate applied to convert functional currency balance to reporting currency.',
    `fiscal_period` STRING COMMENT 'Numeric period within the fiscal year (e.g., 1‑12 for monthly, 1‑4 for quarterly).',
    `fiscal_year` STRING COMMENT 'Four‑digit calendar year of the accounting period (e.g., 2024).',
    `is_consolidated` BOOLEAN COMMENT 'True if the balance aggregates multiple legal entities; otherwise false.',
    `last_reconciled_timestamp` TIMESTAMP COMMENT 'Date‑time when the balance was last validated against source ledgers.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Balance amount carried forward from the prior period.',
    `period_credits` DECIMAL(18,2) COMMENT 'Aggregate credit amount posted to the account in the period.',
    `period_debits` DECIMAL(18,2) COMMENT 'Aggregate debit amount posted to the account in the period.',
    `period_end_date` DATE COMMENT 'Last calendar date of the reporting period.',
    `period_start_date` DATE COMMENT 'First calendar date of the reporting period.',
    `reconciliation_status` STRING COMMENT 'Result of the most recent reconciliation process.. Valid values are `matched|unmatched|pending`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date‑time when the balance snapshot was initially persisted.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the balance record.',
    `source_system` STRING COMMENT 'Name of the upstream system (e.g., Transaction Processing Platform) that produced the record.',
    `translated_balance` DECIMAL(18,2) COMMENT 'Closing balance expressed in the reporting currency after applying exchange rate.',
    CONSTRAINT pk_gl_balance PRIMARY KEY(`gl_balance_id`)
) COMMENT 'Period-end GL account balance record capturing the opening balance, period activity (debits and credits), and closing balance for each GL account per accounting period per ledger. Supports financial statement generation, variance analysis, and period-over-period comparisons. Captures account, period, ledger, currency type (functional/reporting), beginning balance, period debit, period credit, ending balance, and translated balance for multi-currency reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` (
    `ledger_config_id` BIGINT COMMENT 'Unique surrogate key for the ledger configuration record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Ledger configuration defines the functional currency used for all postings, required for regulatory compliance.',
    `accounting_calendar` STRING COMMENT 'Accounting calendar associated with the ledger.',
    `audit_status` STRING COMMENT 'Result of the most recent audit of the ledger configuration (e.g., passed, failed, pending).',
    `audit_trail_enabled` BOOLEAN COMMENT 'Specifies whether changes to this ledger are captured in an audit trail.',
    `chart_of_accounts` STRING COMMENT 'Reference to the chart of accounts used by the ledger.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework(s) that this ledger must satisfy (e.g., SOX, PCI DSS, GDPR).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ledger configuration record was created.',
    `currency_precision` STRING COMMENT 'Number of decimal places used for monetary amounts in the ledger.',
    `effective_from` DATE COMMENT 'Date when the ledger becomes effective.',
    `effective_to` DATE COMMENT 'Date when the ledger ceases to be effective (null if open‑ended).',
    `fiscal_year_start_month` STRING COMMENT 'Month (1‑12) that marks the start of the fiscal year for this ledger.',
    `intercompany_settlement_flag` BOOLEAN COMMENT 'Indicates whether intercompany transactions are settled in this ledger.',
    `is_consolidation_ledger` BOOLEAN COMMENT 'Indicates whether this ledger is used for consolidation reporting.',
    `is_multi_currency` BOOLEAN COMMENT 'Indicates if the ledger supports multiple functional currencies.',
    `last_modified_by` STRING COMMENT 'User identifier who last modified the ledger configuration.',
    `ledger_code` STRING COMMENT 'Business identifier or code assigned to the ledger.',
    `ledger_config_description` STRING COMMENT 'Free‑form description of the ledger purpose and scope.',
    `ledger_config_status` STRING COMMENT 'Current lifecycle status of the ledger.. Valid values are `active|inactive|pending|closed`',
    `ledger_name` STRING COMMENT 'Human‑readable name of the ledger.',
    `ledger_owner` STRING COMMENT 'Business unit or department responsible for the ledger.',
    `ledger_timezone` STRING COMMENT 'Timezone in which ledger processing timestamps are recorded.',
    `ledger_type` STRING COMMENT 'Classification of the ledger (e.g., primary, secondary, reporting).. Valid values are `primary|secondary|reporting|auxiliary`',
    `period_type` STRING COMMENT 'Granularity of accounting periods used by the ledger.. Valid values are `monthly|quarterly|annual`',
    `posting_rule` STRING COMMENT 'Rule that determines when transactions are recognized in the ledger.. Valid values are `accrual|cash|hybrid`',
    `primary_legal_entity` STRING COMMENT 'Legal entity that owns the ledger.',
    `reporting_currency` STRING COMMENT 'Currency used for external reporting from this ledger.',
    `retained_earnings_account` STRING COMMENT 'Account code where retained earnings are posted.',
    `subledger_method` STRING COMMENT 'Method used for subledger accounting.. Valid values are `accounting|costing|none`',
    `tax_reporting_flag` BOOLEAN COMMENT 'Indicates if the ledger is used for tax reporting purposes.',
    `translation_method` STRING COMMENT 'Method applied to translate foreign currency balances.. Valid values are `average_rate|closing_rate|spot_rate|historical_rate`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ledger configuration.',
    `version_number` STRING COMMENT 'Version of the ledger configuration for change management.',
    `created_by` STRING COMMENT 'User identifier who created the ledger configuration.',
    CONSTRAINT pk_ledger_config PRIMARY KEY(`ledger_config_id`)
) COMMENT 'Ledger configuration master defining each accounting ledger (primary, secondary, reporting) within Oracle Financials. Captures ledger name, ledger type, chart of accounts, accounting calendar, functional currency, subledger accounting method, consolidation ledger flag, reporting currency, translation method, and retained earnings account. A payments fintech enterprise typically maintains multiple ledgers for different legal entities and regulatory reporting jurisdictions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` (
    `subledger_entry_id` BIGINT COMMENT 'Unique surrogate key for the subledger entry record.',
    `cardholder_cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder involved in the transaction.',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder involved in the transaction.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Sub‑ledger entries must be tied to a currency for correct posting and settlement.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the transaction.',
    `settlement_id` BIGINT COMMENT 'Identifier of the settlement run associated with this entry.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the processing batch that includes this entry.',
    `transaction_id` BIGINT COMMENT 'Identifier of the originating transaction that generated this subledger entry.',
    `accounting_date` DATE COMMENT 'Date on which the entry is accounted in the ledger, per accounting period.',
    `adjustment_reason` STRING COMMENT 'Reason code for the adjustment, if applicable.',
    `audit_trail` STRING COMMENT 'JSON string capturing audit events for the entry.',
    `compliance_flag` STRING COMMENT 'Indicates if the entry triggered any compliance checks.. Valid values are `aml|sanctions|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subledger entry record was created in the data lake.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Credit monetary amount for the entry.',
    `debit_amount` DECIMAL(18,2) COMMENT 'Debit monetary amount for the entry.',
    `entry_number` STRING COMMENT 'Business identifier for the subledger entry, often sequential per source system.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact time when the underlying business event occurred.',
    `event_type` STRING COMMENT 'Type of accounting event represented by this subledger entry.. Valid values are `authorization|capture|settlement|refund|chargeback|fee`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'FX rate applied if transaction involves currency conversion.',
    `gl_account_code` STRING COMMENT 'Chart of accounts code to which this entry is posted.',
    `gl_derivation_rule` STRING COMMENT 'Rule applied to derive the GL account from transaction attributes.',
    `is_adjustment` BOOLEAN COMMENT 'Indicates whether the entry is an adjustment (true) or original transaction (false).',
    `is_reconciled` BOOLEAN COMMENT 'Indicates whether the entry has been reconciled with the GL.',
    `line_sequence` STRING COMMENT 'Sequence order of the subledger entry within its parent transaction.',
    `notes` STRING COMMENT 'Free-text field for additional comments or remarks.',
    `original_amount` DECIMAL(18,2) COMMENT 'Original transaction amount before any conversion.',
    `original_currency` STRING COMMENT 'Currency of the original amount before conversion.. Valid values are `^[A-Z]{3}$`',
    `payment_instrument_token` STRING COMMENT 'Token representing the payment instrument used, per tokenization standards.',
    `posting_status` STRING COMMENT 'Current status of posting this entry to the General Ledger.. Valid values are `pending|posted|rejected`',
    `quantity` DECIMAL(18,2) COMMENT 'Numeric quantity associated with the entry, e.g., number of units or amount of service.',
    `reconciliation_date` DATE COMMENT 'Date when the entry was reconciled.',
    `risk_score` DECIMAL(18,2) COMMENT 'Fraud risk score assigned to the transaction at time of entry.',
    `source_module` STRING COMMENT 'Specific module within the source system (e.g., Authorization Engine, Settlement Engine).',
    `source_system` STRING COMMENT 'Originating operational system that generated the subledger entry.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the subledger entry record.',
    CONSTRAINT pk_subledger_entry PRIMARY KEY(`subledger_entry_id`)
) COMMENT 'Subledger accounting entry record generated by operational subsystems (payment gateway, settlement engine, merchant billing, dispute management) before posting to the GL. Captures subledger application (AP, AR, FA, payment processing), event type, event date, accounting date, transaction reference, GL account derivation rule applied, debit/credit amounts, currency, and transfer-to-GL status. Provides the audit trail linking operational transactions to GL postings per SOX requirements.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` (
    `revenue_recognition_schedule_id` BIGINT COMMENT 'Unique surrogate key for the revenue recognition schedule record.',
    `audit_trail_id` BIGINT COMMENT 'Reference to audit trail entry for changes.',
    `contract_id` BIGINT COMMENT 'Identifier of the underlying contract or agreement generating the revenue.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Revenue schedules allocate amounts in a specific currency; compliance with ASC 606/IFRS 15 requires currency linkage.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the schedule.',
    `performance_obligation_id` BIGINT COMMENT 'Identifier of the specific performance obligation within the contract.',
    `primary_revenue_employee_id` BIGINT COMMENT 'Identifier of the user who created the schedule.',
    `updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last updated the schedule.',
    `accounting_period` STRING COMMENT 'Financial accounting period associated with the schedule.. Valid values are `FYd{4}|Q[1-4]d{4}`',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Portion of total price allocated to this schedule.',
    `business_identifier` STRING COMMENT 'External reference number or code for the revenue schedule as used by finance.',
    `classification_or_type` STRING COMMENT 'Category of revenue type for the schedule.. Valid values are `subscription|transaction_fee|bnpl_fee|saas|licensing`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was created.',
    `effective_from` DATE COMMENT 'Date when revenue recognition starts according to the contract.',
    `effective_until` DATE COMMENT 'Date when revenue recognition ends; null if indefinite.',
    `frequency_interval` STRING COMMENT 'Numeric interval for the frequency (e.g., every 2 months).',
    `is_partial_recognition_allowed` BOOLEAN COMMENT 'Flag indicating if partial recognition is permitted before full amount.',
    `is_prorated` BOOLEAN COMMENT 'Indicates if the schedule uses prorated amounts.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the revenue schedule.. Valid values are `draft|active|suspended|completed|cancelled`',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the schedule.',
    `recognition_end_date` DATE COMMENT 'Scheduled end date for the final recognition event.',
    `recognition_frequency` STRING COMMENT 'Frequency at which revenue is recognized.. Valid values are `daily|weekly|monthly|quarterly|annually|once`',
    `recognition_method` STRING COMMENT 'Method used to recognize revenue.. Valid values are `point_in_time|over_time`',
    `recognition_start_date` DATE COMMENT 'Scheduled start date for the first recognition event.',
    `recognized_to_date_amount` DECIMAL(18,2) COMMENT 'Cumulative amount recognized to date.',
    `total_transaction_price` DECIMAL(18,2) COMMENT 'Total contract transaction price allocated to this performance obligation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule.',
    CONSTRAINT pk_revenue_recognition_schedule PRIMARY KEY(`revenue_recognition_schedule_id`)
) COMMENT 'Revenue recognition schedule master defining the rules and timeline for recognizing deferred revenue in compliance with ASC 606 / IFRS 15. Captures contract reference, performance obligation description, total transaction price, allocated amount, recognition method (point-in-time vs over-time), recognition start date, recognition end date, recognition frequency, and recognized-to-date amount. Critical for payments fintech revenue streams including MDR, SaaS platform fees, and BNPL origination fees.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` (
    `revenue_recognition_event_id` BIGINT COMMENT 'Unique identifier for the revenue recognition event.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Each recognition event records currency to calculate realized revenue and tax impact.',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the GL journal entry created for this revenue recognition.',
    `revenue_line_id` BIGINT COMMENT 'Identifier of the revenue line item associated with this event.',
    `revenue_recognition_schedule_id` BIGINT COMMENT 'Identifier of the revenue schedule to which this recognition event belongs.',
    `reversal_event_revenue_recognition_event_id` BIGINT COMMENT 'If this event reverses a prior recognition, reference to that event.',
    `transaction_id` BIGINT COMMENT 'Identifier of the underlying payment transaction linked to this revenue event.',
    `accounting_period` STRING COMMENT 'Fiscal period code (e.g., 2023Q1) for the recognized revenue.. Valid values are `^d{4}Q[1-4]$`',
    `adjustment_reason` STRING COMMENT 'Reason for the adjustment, if applicable.. Valid values are `error_correction|policy_change|other`',
    `approval_status` STRING COMMENT 'Approval workflow status for the revenue recognition event.. Valid values are `unapproved|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the event was approved.',
    `approved_by` STRING COMMENT 'User or system that approved the revenue recognition.',
    `audit_comment` STRING COMMENT 'Free‑form comment for audit or review purposes.',
    `compliance_flag` STRING COMMENT 'Indicates any compliance action required for this event.. Valid values are `none|audit_required|review_needed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the revenue recognition event record was created.',
    `cumulative_recognized_amount` DECIMAL(18,2) COMMENT 'Total amount recognized to date for the schedule, including this event.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'FX rate applied if the revenue is recorded in a foreign currency.',
    `is_adjustment` BOOLEAN COMMENT 'Indicates whether this event is an adjustment to a prior recognition.',
    `is_foreign_currency` BOOLEAN COMMENT 'True if the recognized amount was originally in a foreign currency.',
    `is_manual_entry` BOOLEAN COMMENT 'True if the event was entered manually rather than automatically.',
    `original_currency_code` STRING COMMENT 'Currency of the underlying transaction before conversion.. Valid values are `^[A-Z]{3}$`',
    `posted_date` DATE COMMENT 'Date the revenue recognition entry was posted to the accounting system.',
    `recognition_status` STRING COMMENT 'Current processing status of the revenue recognition event.. Valid values are `pending|recognized|reversed|adjusted`',
    `recognition_timestamp` TIMESTAMP COMMENT 'Date and time when the revenue was recognized.',
    `recognition_trigger` STRING COMMENT 'Mechanism that caused the revenue to be recognized (time‑based, milestone, or usage).. Valid values are `time_based|milestone|usage`',
    `recognized_amount` DECIMAL(18,2) COMMENT 'Monetary amount recognized in this event.',
    `regulatory_reporting_code` STRING COMMENT 'Code used for regulatory reporting of the revenue event.',
    `remaining_deferred_amount` DECIMAL(18,2) COMMENT 'Deferred revenue remaining after this recognition event.',
    `reversal_reason` STRING COMMENT 'Reason for reversing the revenue recognition.',
    `settlement_date` DATE COMMENT 'Date on which the revenue was settled in the ledger.',
    `source_record_reference` STRING COMMENT 'Identifier of the originating record in the source system.',
    `source_system` STRING COMMENT 'System that generated the revenue recognition event (e.g., ERP, Data Warehouse).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the recognized revenue.',
    `tax_code` STRING COMMENT 'Standard tax code applied to the revenue.. Valid values are `VAT|GST|NONE`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the revenue recognition event record.',
    CONSTRAINT pk_revenue_recognition_event PRIMARY KEY(`revenue_recognition_event_id`)
) COMMENT 'Individual revenue recognition event record capturing each instance of revenue being recognized against a schedule. Captures schedule reference, recognition date, accounting period, recognized amount, cumulative recognized amount, remaining deferred amount, GL journal entry reference, recognition trigger (time-based, milestone, usage), and recognition status. Provides the transactional audit trail for ASC 606 compliance and SOX revenue controls.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'System-generated unique identifier for the intercompany transaction record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Intercompany transactions are settled within a fiscal period; FK enables period‑based reconciliation.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center associated with the transaction for internal reporting.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity that originated the intercompany transaction.',
    `receiving_entity_legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity that is the counter‑party to the transaction.',
    `transaction_id` BIGINT COMMENT 'Identifier of the original transaction when this record is a reversal or adjustment.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Intercompany amounts are settled in a transaction currency; proper FX handling needs a currency reference.',
    `amount_adjustment` DECIMAL(18,2) COMMENT 'Sum of fees, taxes, or other adjustments applied to the gross amount.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total monetary value before any adjustments, expressed in the transaction currency.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount after adjustments; the amount that is settled between entities.',
    `approval_status` STRING COMMENT 'Result of the internal approval process for the transaction.. Valid values are `approved|rejected|under_review`',
    `elimination_flag` BOOLEAN COMMENT 'True when the transaction should be eliminated during consolidation to avoid double counting.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied when converting from transaction currency to reporting currency, if applicable.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any fee charged as part of the intercompany transaction (e.g., service fee).',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter (1‑4) of the transaction.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the transaction belongs.',
    `intercompany_account_pair` STRING COMMENT 'Combined GL account codes representing the debit and credit sides of the intercompany posting (e.g., "4000-5000").',
    `intercompany_transaction_description` STRING COMMENT 'Free‑form text describing the purpose or nature of the intercompany transaction.',
    `lifecycle_status` STRING COMMENT 'Current processing state of the transaction within the intercompany workflow.. Valid values are `pending|approved|rejected|posted|settled|cancelled`',
    `netting_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the transaction is eligible for netting against other intercompany balances.',
    `posting_date` DATE COMMENT 'Date on which the transaction is posted to the general ledger.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transaction record was first created in the lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the transaction record.',
    `reference_number` STRING COMMENT 'Reference to external documents such as an Acquirer Reference Number (ARN) or internal voucher.',
    `reversal_indicator` BOOLEAN COMMENT 'True if the transaction is a reversal of a previously posted intercompany entry.',
    `settlement_date` DATE COMMENT 'Date on which the intercompany amount is settled between entities.',
    `source_system` STRING COMMENT 'System of record that originated the transaction (e.g., ERP, Payment Gateway).. Valid values are `ERP|Gateway|TPP|DW`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the transaction, if applicable.',
    `transaction_number` STRING COMMENT 'External business identifier assigned to the transaction (e.g., journal reference).',
    `transaction_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the intercompany transaction was recorded in the source system.',
    `transaction_type` STRING COMMENT 'Category of the intercompany activity such as loan, service charge, royalty, cost allocation, or settlement.. Valid values are `loan|service_charge|royalty|cost_allocation|settlement`',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Intercompany transaction record capturing financial activity between legal entities within the payments fintech corporate group. Captures transaction type (loan, service charge, royalty, cost allocation, settlement), initiating entity, receiving entity, transaction date, currency, amount, intercompany account pair, netting eligibility, elimination flag, and approval status. Essential for consolidated financial reporting and intercompany reconciliation across the global payments network.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` (
    `period_close_task_id` BIGINT COMMENT 'Unique identifier for the period close task record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Period tasks belong to a specific accounting period; linking enables period‑based reporting and scheduling.',
    `dependent_task_id` BIGINT COMMENT 'Identifier of a prerequisite task that must be completed first.',
    `employee_id` BIGINT COMMENT 'Identifier of the person or team responsible for executing the task.',
    `owner_employee_id` BIGINT COMMENT 'Identifier of the person or team responsible for executing the task.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Recorded effort spent on the task, expressed in hours.',
    `blocking_flag` BOOLEAN COMMENT 'Indicates whether the task blocks downstream close activities.',
    `completion_date` DATE COMMENT 'Actual date when the task was finished.',
    `compliance_review_flag` BOOLEAN COMMENT 'Indicates if the task requires a compliance or regulatory review.',
    `due_date` DATE COMMENT 'Planned date by which the task should be completed.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Projected effort required to complete the task, expressed in hours.',
    `is_critical` BOOLEAN COMMENT 'Flag indicating whether the task is deemed critical for timely close.',
    `last_updated_by` BIGINT COMMENT 'Identifier of the user who performed the latest update.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the task.',
    `owner_role` STRING COMMENT 'Business role of the task owner.. Valid values are `accountant|controller|manager|analyst`',
    `period_close_task_status` STRING COMMENT 'Current lifecycle state of the task.. Valid values are `not_started|in_progress|completed|blocked|deferred`',
    `priority` STRING COMMENT 'Business priority assigned to the task.. Valid values are `low|medium|high|critical`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the task record was initially created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the task record.',
    `regulatory_review_status` STRING COMMENT 'Current status of any required regulatory review for the task.. Valid values are `pending|approved|rejected|escalated`',
    `risk_level` STRING COMMENT 'Risk rating associated with the tasks impact on the close process.. Valid values are `low|medium|high|critical`',
    `sign_off_reference` STRING COMMENT 'Reference to the sign‑off record or approval document for the task.',
    `task_description` STRING COMMENT 'Detailed description of the work to be performed for the task.',
    `task_name` STRING COMMENT 'Descriptive name of the close task (e.g., "Month-End Revenue Reconciliation").',
    `task_sequence` STRING COMMENT 'Ordinal position of the task within the overall close workflow.',
    `task_type` STRING COMMENT 'Category of the task within the financial close workflow.. Valid values are `reconciliation|accrual|allocation|consolidation|reporting`',
    CONSTRAINT pk_period_close_task PRIMARY KEY(`period_close_task_id`)
) COMMENT 'Financial period close task record representing a discrete step in the month-end, quarter-end, or year-end close checklist. Captures task name, task type (reconciliation, accrual, allocation, consolidation, reporting), assigned owner, due date, completion date, status, dependency on prior tasks, blocking flag, and sign-off reference. Supports the structured financial close workflow required for SOX compliance and timely financial reporting in a payments fintech enterprise.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` (
    `account_reconciliation_id` BIGINT COMMENT 'System-generated unique identifier for the account reconciliation record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Account reconciliation records are generated per accounting period; FK provides direct period context.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Reconciliation reports must state the currency of the GL account to validate balances.',
    `gl_account_id` BIGINT COMMENT 'Identifier of the General Ledger account being reconciled.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Reconciliation process records the employee who prepared the reconciliation; required for internal control reports.',
    `account_reconciliation_status` STRING COMMENT 'Current lifecycle state of the reconciliation record.. Valid values are `open|in_progress|completed|closed|rejected`',
    `adjusted_balance` DECIMAL(18,2) COMMENT 'Balance after applying reconciling adjustments.',
    `aging_days` STRING COMMENT 'Number of days unresolved reconciling items have been outstanding.',
    `approval_status` STRING COMMENT 'SOX‑compliant approval outcome for the reconciliation.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation was approved or rejected.',
    `closed_reconciling_items_count` STRING COMMENT 'Count of reconciling items that have been resolved.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework(s) governing the reconciliation (e.g., SOX).. Valid values are `SOX|PCI_DSS|GDPR|CCPA|FATF`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation record was first created.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to translate foreign‑currency balances to the functional currency.',
    `fiscal_period` STRING COMMENT 'Numeric period within the fiscal year (e.g., month number).',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the reconciliation belongs.',
    `gl_balance_book` DECIMAL(18,2) COMMENT 'Balance of the GL account as recorded in the books for the period.',
    `is_auto_reconciled` BOOLEAN COMMENT 'Flag indicating whether the reconciliation was performed automatically by the system.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the GL account is part of a consolidated reporting hierarchy.',
    `last_reconciled_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful reconciliation run for this account/period.',
    `notes` STRING COMMENT 'Free‑form comments or observations entered by the preparer or reviewer.',
    `open_reconciling_items_count` STRING COMMENT 'Count of reconciling items that remain unresolved.',
    `period_end_date` DATE COMMENT 'Last calendar date of the reconciliation period.',
    `period_start_date` DATE COMMENT 'First calendar date of the reconciliation period.',
    `reconciliation_cycle` STRING COMMENT 'Scheduled frequency of the reconciliation (e.g., monthly).. Valid values are `monthly|quarterly|annual|ad_hoc`',
    `reconciliation_method` STRING COMMENT 'Technique used to perform the reconciliation.. Valid values are `manual|automated|rule_based|ml_assisted`',
    `reconciliation_number` STRING COMMENT 'Business‑visible identifier or reference number for the reconciliation run.',
    `reconciling_items_total` DECIMAL(18,2) COMMENT 'Aggregate amount of all reconciling items identified for the period.',
    `reviewed_by` BIGINT COMMENT 'Identifier of the employee who reviewed the reconciliation.',
    `sign_off_date` DATE COMMENT 'Date on which the reconciliation was formally signed off.',
    `supporting_document_reference` STRING COMMENT 'Reference (e.g., URL or document ID) to supporting evidence for the reconciliation.',
    `total_reconciling_items_amount` DECIMAL(18,2) COMMENT 'Sum of monetary values of all reconciling items for the period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reconciliation record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between book balance and adjusted balance.',
    `variance_reason` STRING COMMENT 'Narrative explanation for the variance (e.g., timing difference, error).',
    CONSTRAINT pk_account_reconciliation PRIMARY KEY(`account_reconciliation_id`)
) COMMENT 'GL account reconciliation record capturing the formal balance reconciliation performed for each GL account at period end. Captures account, accounting period, GL balance per books, reconciling items, adjusted balance, supporting documentation reference, preparer, reviewer, approval status, and sign-off date. Mandatory SOX control for all balance sheet accounts. Tracks open reconciling items and aging of unresolved differences.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` (
    `accrual_entry_id` BIGINT COMMENT 'System-generated unique identifier for the accrual journal entry.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center associated with the accrual.',
    `gl_account_id` BIGINT COMMENT 'Identifier of the GL account to which the accrual is posted.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity (company) that owns the accrual.',
    `segment_id` BIGINT COMMENT 'Identifier of the reporting segment (e.g., business line or geography) for the accrual.',
    `accrual_basis` STRING COMMENT 'Accounting basis applied to the entry (accrual, cash, or adjustment).. Valid values are `accrual|cash|adjustment`',
    `accrual_entry_description` STRING COMMENT 'Free‑form description or notes about the accrual entry.',
    `accrual_entry_status` STRING COMMENT 'Current lifecycle status of the accrual entry.. Valid values are `pending|posted|reversed|cancelled`',
    `accrual_number` STRING COMMENT 'Business-visible identifier or code for the accrual entry, used for tracking and reconciliation.',
    `accrual_period_end_date` DATE COMMENT 'End date of the accounting period for which the accrual is recognized.',
    `accrual_period_start_date` DATE COMMENT 'Start date of the accounting period for which the accrual is recognized.',
    `accrual_type` STRING COMMENT 'Category of accrual such as expense, revenue, interchange income, scheme fee, or settlement float.. Valid values are `expense|revenue|interchange|scheme_fee|settlement_float`',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustment component (e.g., tax, fee, discount) applied to the gross amount.',
    `calculation_methodology` STRING COMMENT 'Description of the calculation method or model used to derive the accrual amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the accrual entry record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the accrual amounts.. Valid values are `^[A-Z]{3}$`',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of the business event that triggered the accrual (e.g., period‑end processing).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied when converting foreign currency amounts to the functional currency.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before any adjustments, expressed in the entry currency.',
    `intercompany_flag` BOOLEAN COMMENT 'True if the accrual relates to an intercompany transaction.',
    `is_estimated` BOOLEAN COMMENT 'Indicates whether the accrual amount is an estimate (true) or a final calculated amount (false).',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after adjustments, the amount posted to the GL.',
    `posting_date` DATE COMMENT 'Date on which the accrual entry is posted to the ledger.',
    `posting_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the accrual entry is posted.',
    `reversal_journal_reference` STRING COMMENT 'Reference to the journal entry that reverses this accrual, if applicable.',
    `reversal_period_end_date` DATE COMMENT 'End date of the period when the accrual is scheduled to be reversed.',
    `reversal_period_start_date` DATE COMMENT 'Start date of the period when the accrual is scheduled to be reversed.',
    `source_system` STRING COMMENT 'Originating system that generated the accrual entry (e.g., Transaction Processing Platform, Payment Gateway, ERP).. Valid values are `tpp|gateway|erp`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the accrual, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the accrual entry record.',
    CONSTRAINT pk_accrual_entry PRIMARY KEY(`accrual_entry_id`)
) COMMENT 'Accrual journal entry record capturing period-end accruals for expenses and revenues not yet invoiced or received. Captures accrual type (expense accrual, revenue accrual, interchange accrual, scheme fee accrual), accrual basis, accrual amount, currency, GL account, cost center, accrual period, reversal period, reversal journal reference, and supporting calculation methodology. Payments fintech-specific accruals include interchange income, scheme fee accruals, and settlement float accruals.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` (
    `expense_allocation_id` BIGINT COMMENT 'Unique system-generated identifier for each expense allocation record.',
    `allocation_journal_journal_entry_id` BIGINT COMMENT 'Identifier of the journal entry created for this allocation.',
    `gl_account_id` BIGINT COMMENT 'Internal identifier of the GL account used for the allocation.',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the journal entry created for this allocation.',
    `cost_center_id` BIGINT COMMENT 'Internal identifier of the cost center from which the expense is allocated.',
    `target_cost_center_id` BIGINT COMMENT 'Internal identifier of the cost center receiving the allocated expense.',
    `allocation_basis` STRING COMMENT 'Basis used to calculate the allocation (headcount, total payment volume, revenue, or fixed percentage).. Valid values are `headcount|tpv|revenue|fixed_percentage`',
    `allocation_basis_value` DECIMAL(18,2) COMMENT 'Numeric value associated with the allocation basis (e.g., percentage or factor).',
    `allocation_journal_reference` STRING COMMENT 'External reference (e.g., journal number) for the allocation journal entry.',
    `allocation_method` STRING COMMENT 'Indicates whether the allocation was generated automatically by the system or entered manually.. Valid values are `automatic|manual`',
    `allocation_note` STRING COMMENT 'Free‑form text for additional context or justification of the allocation.',
    `allocation_period_end` DATE COMMENT 'Last day of the fiscal period for which the expense is allocated.',
    `allocation_period_start` DATE COMMENT 'First day of the fiscal period for which the expense is allocated.',
    `allocation_reference_number` STRING COMMENT 'External reference number assigned to the allocation for audit and traceability.',
    `allocation_rule_name` STRING COMMENT 'Descriptive name of the allocation rule applied (e.g., "Headcount Pro Rata").',
    `allocation_rule_version` STRING COMMENT 'Version number of the allocation rule to support rule changes over time.',
    `allocation_status` STRING COMMENT 'Current processing state of the allocation.. Valid values are `pending|applied|reversed|error`',
    `allocation_timestamp` TIMESTAMP COMMENT 'Date‑time when the allocation was executed in the system.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework governing the allocation record.. Valid values are `SOX|PCI_DSS|GDPR|CCPA|FATF|AML`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the allocation amounts (e.g., "USD").',
    `effective_from` TIMESTAMP COMMENT 'Date‑time from which the allocation becomes effective for reporting.',
    `effective_until` TIMESTAMP COMMENT 'Date‑time after which the allocation is no longer effective (nullable).',
    `is_intercompany` BOOLEAN COMMENT 'Indicates whether the allocation is between legal entities within the same corporate group.',
    `target_allocation_amount` DECIMAL(18,2) COMMENT 'Monetary amount allocated to the target cost center.',
    `total_allocation_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary amount allocated from the source cost center.',
    `transfer_pricing_flag` BOOLEAN COMMENT 'True if the allocation is subject to transfer‑pricing rules for cross‑border reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the allocation record.',
    CONSTRAINT pk_expense_allocation PRIMARY KEY(`expense_allocation_id`)
) COMMENT 'Expense allocation record capturing the distribution of shared costs across cost centers, legal entities, or business units using defined allocation rules. Captures allocation rule name, source cost center, target cost centers, allocation basis (headcount, TPV, revenue, fixed percentage), allocation period, total amount allocated, per-target amounts, GL accounts, and allocation journal reference. Supports management P&L reporting and transfer pricing compliance for cross-border payments entities.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique system-generated identifier for each fixed asset record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Asset acquisition cost and depreciation are currency‑specific; regulatory asset registers require a currency FK.',
    `vendor_id` BIGINT COMMENT 'FK to ledger.vendor',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recorded to date for the asset.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original cost incurred to acquire the asset, expressed in the functional currency.',
    `acquisition_date` DATE COMMENT 'Date the asset was purchased or otherwise acquired.',
    `asset_category` STRING COMMENT 'High‑level classification of the asset type.. Valid values are `hardware|software|infrastructure|license`',
    `asset_description` STRING COMMENT 'Free‑form description providing additional details about the asset.',
    `asset_name` STRING COMMENT 'Human‑readable name or title of the asset (e.g., "POS Terminal 12A").',
    `asset_serial_number` STRING COMMENT 'Manufacturer‑assigned serial number of the asset.',
    `asset_tag` STRING COMMENT 'Unique alphanumeric tag assigned to the asset for inventory tracking.',
    `asset_type` STRING COMMENT 'Specific type within the category (e.g., "POS Terminal", "HSM", "Server", "Software License").',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier to which the asset expense is charged.',
    `custodian` STRING COMMENT 'Name of the individual or team responsible for day‑to‑day care of the asset.',
    `depreciation_end_date` DATE COMMENT 'Projected date when the asset will be fully depreciated.',
    `depreciation_expense_current_period` DECIMAL(18,2) COMMENT 'Depreciation expense recognized for the current accounting period.',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate depreciation.. Valid values are `straight_line|double_declining|units_of_production|sum_of_years`',
    `depreciation_rate_percent` DECIMAL(18,2) COMMENT 'Annual depreciation rate expressed as a percentage.',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation calculations begin.',
    `disposal_date` DATE COMMENT 'Date the asset was removed from service or sold.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the asset.. Valid values are `sale|scrap|donation|recycle|return_to_vendor`',
    `disposal_status` STRING COMMENT 'Current status of the disposal process.. Valid values are `pending|completed|not_applicable`',
    `fixed_asset_status` STRING COMMENT 'Current operational state of the asset.. Valid values are `in_service|maintenance|retired|disposed|pending`',
    `geographic_country_code` STRING COMMENT 'Three‑letter ISO country code of the assets primary location. [ENUM-REF-CANDIDATE: USA|CAN|GBR|DEU|FRA|JPN|AUS|CHN|IND|BRA — promote to reference product]',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount covered by the insurance policy.',
    `insurance_policy_number` STRING COMMENT 'Policy number of any insurance covering the asset.',
    `insurance_provider` STRING COMMENT 'Name of the insurer providing coverage for the asset.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance activity was performed.',
    `location` STRING COMMENT 'Physical site or room where the asset resides (e.g., "Data Center 3 – Rack 12").',
    `maintenance_cost` DECIMAL(18,2) COMMENT 'Cost incurred for the most recent maintenance activity.',
    `maintenance_schedule` STRING COMMENT 'Regular maintenance cadence for the asset.. Valid values are `quarterly|annual|semi_annual|monthly`',
    `manufacturer` STRING COMMENT 'Company that produced the asset.',
    `model_number` STRING COMMENT 'Model identifier assigned by the manufacturer.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying amount of the asset (cost minus accumulated depreciation).',
    `owner_department` STRING COMMENT 'Business department that owns the asset.',
    `purchase_order_number` STRING COMMENT 'Reference number of the purchase order that funded the acquisition.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the asset record.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life.',
    `useful_life_years` STRING COMMENT 'Estimated economic life of the asset expressed in years.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty on the asset expires.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master record for capitalized assets owned by the payments fintech enterprise including data center hardware, HSM devices, POS terminal infrastructure, and software licenses. Captures asset number, asset description, asset category, acquisition date, acquisition cost, accumulated depreciation, net book value, depreciation method, useful life, salvage value, location, custodian, and disposal status. Managed in Oracle Financials Fixed Assets (FA) module.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` (
    `depreciation_schedule_id` BIGINT COMMENT 'Unique identifier for the depreciation schedule record.',
    `cost_center_id` BIGINT COMMENT 'Cost center associated with the depreciation expense.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Depreciation expense is recorded in a currency; linking supports consolidated reporting.',
    `fixed_asset_id` BIGINT COMMENT 'Identifier of the fixed asset to which this depreciation schedule applies.',
    `gl_account_id` BIGINT COMMENT 'General Ledger account used to post the depreciation expense.',
    `journal_entry_id` BIGINT COMMENT 'Journal entry identifier that records the depreciation transaction.',
    `accumulated_depreciation_to_date` DECIMAL(18,2) COMMENT 'Total accumulated depreciation up to the end of this period.',
    `beginning_net_book_value` DECIMAL(18,2) COMMENT 'Net book value of the asset at the beginning of the period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the depreciation schedule record was created.',
    `depreciation_basis` STRING COMMENT 'Basis used for depreciation calculation (e.g., cost, revaluation, fair value).. Valid values are `cost|revaluation|fair_value`',
    `depreciation_comment` STRING COMMENT 'Free-text comment or note regarding the depreciation calculation.',
    `depreciation_expense_amount` DECIMAL(18,2) COMMENT 'Depreciation expense recognized for the period.',
    `depreciation_method` STRING COMMENT 'Method used to calculate depreciation for the period.. Valid values are `straight_line|double_declining|sum_of_years_digits|units_of_production|macrs`',
    `depreciation_rate` DECIMAL(18,2) COMMENT 'Depreciation rate applied for the period (e.g., 0.2000 for 20%).',
    `depreciation_sequence` STRING COMMENT 'Sequence number of the depreciation period within the assets depreciation schedule.',
    `depreciation_status` STRING COMMENT 'Current processing status of the depreciation record.. Valid values are `pending|posted|reversed|adjusted`',
    `ending_net_book_value` DECIMAL(18,2) COMMENT 'Net book value of the asset at the end of the period.',
    `fiscal_period` STRING COMMENT 'Fiscal period within the fiscal year (e.g., FY, Q1).. Valid values are `FY|Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'Fiscal year for the depreciation period.',
    `is_estimated` BOOLEAN COMMENT 'Indicates whether the depreciation amount is an estimate (true) or based on actual usage (false).',
    `period_end_date` DATE COMMENT 'End date of the depreciation period.',
    `period_label` STRING COMMENT 'Human-readable label for the depreciation period (e.g., FY2023 Q1).',
    `period_start_date` DATE COMMENT 'Start date of the depreciation period.',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the depreciation expense was posted to the ledger.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Flag indicating if the depreciation entry complies with relevant accounting standards (e.g., IFRS, GAAP).',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated salvage value of the asset at the end of its useful life.',
    `source_system` STRING COMMENT 'Name of the source system that generated the depreciation schedule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the depreciation schedule record.',
    `useful_life_years` STRING COMMENT 'Estimated useful life of the asset in years.',
    `version_number` STRING COMMENT 'Version number for the depreciation schedule record for concurrency control.',
    CONSTRAINT pk_depreciation_schedule PRIMARY KEY(`depreciation_schedule_id`)
) COMMENT 'Depreciation schedule record capturing the periodic depreciation calculation for each fixed asset. Captures asset reference, depreciation period, depreciation method applied, beginning net book value, depreciation expense amount, accumulated depreciation to date, ending net book value, GL account, cost center, and journal entry reference. Supports asset lifecycle accounting and financial statement accuracy for capitalized payments infrastructure.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`payable` (
    `payable_id` BIGINT COMMENT 'Unique system-generated identifier for the payable (invoice) record.',
    `cost_center_id` BIGINT COMMENT 'Cost center that will bear the expense of the payable.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Payable invoices are settled in a specific currency; regulatory tax reporting requires a normalized currency link.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: Payments of invoices can be funded directly from a digital wallet; tracking the source wallet is essential for cash‑flow and audit trails.',
    `gl_account_id` BIGINT COMMENT 'GL account to which the payable is posted for accounting.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor (supplier) to whom the payable is owed.',
    `approval_status` STRING COMMENT 'Result of the internal approval workflow for the payable.. Valid values are `pending|approved|rejected`',
    `approved_by` BIGINT COMMENT 'Identifier of the employee who approved the payable.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the payable was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payable record was first created in the system.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early‑payment or promotional discount applied to the invoice.',
    `discount_code` STRING COMMENT 'Code representing the discount program or agreement.',
    `due_date` DATE COMMENT 'Date by which payment must be made to avoid late fees.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'FX rate applied when converting foreign‑currency invoice to functional currency.',
    `exchange_rate_date` DATE COMMENT 'Date on which the exchange rate was sourced.',
    `expense_category` STRING COMMENT 'Business classification of the expense (e.g., Marketing, Operations).',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Invoice amount expressed in the companys functional currency.',
    `invoice_amount` DECIMAL(18,2) COMMENT 'Total amount billed on the invoice before taxes, discounts, or adjustments.',
    `invoice_date` DATE COMMENT 'Date the invoice was issued by the vendor.',
    `invoice_number` STRING COMMENT 'External invoice number assigned by the vendor or generated by the system.',
    `is_consolidated` BOOLEAN COMMENT 'True if the payable has been consolidated with other invoices for payment.',
    `is_early_payment_discount_applied` BOOLEAN COMMENT 'Indicates whether an early‑payment discount was applied to this payable.',
    `is_recurring` BOOLEAN COMMENT 'True if the payable is part of a recurring billing schedule.',
    `is_tax_exempt` BOOLEAN COMMENT 'True if the invoice is exempt from tax under applicable regulations.',
    `net_amount` DECIMAL(18,2) COMMENT 'Invoice amount after tax and discount adjustments (payable amount).',
    `original_currency_amount` DECIMAL(18,2) COMMENT 'Invoice amount in the vendors original currency.',
    `payable_description` STRING COMMENT 'Free‑form description or memo entered on the invoice.',
    `payable_status` STRING COMMENT 'Current lifecycle status of the payable.. Valid values are `draft|approved|paid|rejected|cancelled`',
    `payment_date` DATE COMMENT 'Date on which the payable was settled.',
    `payment_method` STRING COMMENT 'Means used to settle the payable (e.g., ACH, Wire Transfer).. Valid values are `ACH|Wire|Check|Card|Internal`',
    `payment_reference` STRING COMMENT 'External reference such as check number, ACH trace number, or transaction ID.',
    `payment_status` STRING COMMENT 'Current payment processing state of the payable.. Valid values are `unpaid|partial|paid|failed|reversed`',
    `payment_terms` STRING COMMENT 'Standard payment terms (e.g., Net 30, Net 45) governing the payable.',
    `scheme_invoice_reference` STRING COMMENT 'Reference number assigned by card scheme (Visa/Mastercard) for fee invoices.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charged on the invoice.',
    `tax_code` STRING COMMENT 'Tax jurisdiction or code applicable to the invoice.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payable record.',
    `vendor_name` STRING COMMENT 'Legal name of the vendor as recorded in the master vendor catalog.',
    CONSTRAINT pk_payable PRIMARY KEY(`payable_id`)
) COMMENT 'Accounts payable invoice record representing amounts owed by the payments fintech enterprise to vendors, card schemes, and service providers. Captures supplier reference, invoice number, invoice date, due date, payment terms, invoice amount, currency, tax amount, GL account distribution, cost center, approval status, payment status, and scheme invoice reference (for Visa/Mastercard scheme fee invoices). Managed in Oracle Financials AP module.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`receivable` (
    `receivable_id` BIGINT COMMENT 'Unique identifier for the receivable record.',
    `cost_center_id` BIGINT COMMENT 'FK to ledger.cost_center',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Receivable amounts are recorded in a currency; linking enables proper foreign‑exchange gain/loss calculation.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: Incoming payments are often settled into a specific digital wallet; linking receivables to that wallet enables accurate revenue recognition and reconciliation.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the partner associated with the invoice, if applicable.',
    `gl_account_id` BIGINT COMMENT 'FK to ledger.gl_account',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant billed.',
    `aging_bucket` STRING COMMENT 'Aging bucket based on days past due.. Valid values are `current|1-30|31-60|61-90|90_plus`',
    `audit_trail_enabled` BOOLEAN COMMENT 'Indicates if audit trail is enabled for this invoice.',
    `collection_status` STRING COMMENT 'Current collection status of the invoice.. Valid values are `uncollected|partial|collected|written_off`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was created.',
    `currency_exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied if invoice currency differs from functional currency.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the invoice is under dispute.',
    `due_date` DATE COMMENT 'Date by which payment is due.',
    `exchange_rate_date` DATE COMMENT 'Date of the exchange rate used.',
    `external_reference` STRING COMMENT 'External reference number from partner or third‑party system.',
    `fiscal_period` STRING COMMENT 'Fiscal period (e.g., month) of the invoice.',
    `fiscal_year` STRING COMMENT 'Fiscal year of the invoice.',
    `interchange_income` DECIMAL(18,2) COMMENT 'Interchange fee income component of the invoice.',
    `invoice_amount` DECIMAL(18,2) COMMENT 'Total amount billed before taxes and fees.',
    `invoice_date` DATE COMMENT 'Date the invoice was issued.',
    `invoice_number` STRING COMMENT 'Unique invoice identifier assigned by the enterprise.',
    `invoice_status` STRING COMMENT 'Lifecycle status of the invoice.. Valid values are `draft|issued|sent|paid|cancelled|void`',
    `is_consolidated` BOOLEAN COMMENT 'Indicates if the invoice is part of a consolidated statement.',
    `mdr_fee` DECIMAL(18,2) COMMENT 'Fee charged to the merchant based on MDR.',
    `net_amount` DECIMAL(18,2) COMMENT 'Invoice amount after tax and fees.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the invoice.',
    `payment_channel` STRING COMMENT 'Channel through which payment was made.. Valid values are `web|mobile|pos|api`',
    `payment_method` STRING COMMENT 'Primary payment method used for settlement.. Valid values are `card|bank_transfer|ach|digital_wallet|cash`',
    `payment_received_timestamp` TIMESTAMP COMMENT 'Timestamp of the first payment received against the invoice.',
    `payment_terms` STRING COMMENT 'Standard payment terms associated with the invoice.. Valid values are `net_30|net_45|net_60|due_on_receipt`',
    `platform_fee` DECIMAL(18,2) COMMENT 'Fee for platform services associated with the invoice.',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was posted to the ledger.',
    `profit_center_code` STRING COMMENT 'Profit center associated with the invoice.',
    `receivable_description` STRING COMMENT 'Free-text description of invoice purpose or line items.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Flag indicating inclusion in regulatory reporting.',
    `segment_code` STRING COMMENT 'Business segment code for reporting.',
    `source_system` STRING COMMENT 'Source system where the invoice originated (e.g., ERP, AR module).',
    `sox_control_classification` STRING COMMENT 'SOX control classification for the invoice.. Valid values are `critical|significant|non_critical`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the invoice.',
    `tax_code` STRING COMMENT 'Tax code applied to the invoice.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates if the invoice is tax‑exempt.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was last updated.',
    CONSTRAINT pk_receivable PRIMARY KEY(`receivable_id`)
) COMMENT 'Accounts receivable invoice record representing amounts owed to the payments fintech enterprise by merchants, partners, and customers. Captures customer/merchant reference, invoice number, invoice date, due date, payment terms, invoice amount, currency, tax amount, GL account distribution, collection status, aging bucket, and dispute flag. Includes MDR billing, platform fee invoices, and interchange income receivables. Managed in Oracle Financials AR module.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the budget record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Budgets are defined for a fiscal period; linking to accounting_period enables period‑driven budgeting.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center associated with the budget.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Budgets are prepared in a specific currency; compliance reports require a currency reference.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for the budget.',
    `gl_account_id` BIGINT COMMENT 'Identifier of the GL account to which the budget amount is allocated.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity (company) owning the budget.',
    `owner_employee_id` BIGINT COMMENT 'Identifier of the employee responsible for the budget.',
    `allocation_basis` STRING COMMENT 'Basis used to allocate the budget across cost centers or accounts.. Valid values are `headcount|revenue|expense|fixed`',
    `amount` DECIMAL(18,2) COMMENT 'Planned monetary amount for the budget line.',
    `approval_date` DATE COMMENT 'Date when the budget was formally approved.',
    `approved_by` BIGINT COMMENT 'Identifier of the employee who approved the budget.',
    `budget_category` STRING COMMENT 'High‑level classification of the budget purpose.. Valid values are `operational|capital|project|marketing|R&D`',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget record.. Valid values are `draft|submitted|approved|rejected|closed`',
    `budget_type` STRING COMMENT 'Classification of the budget as original, revised, or forecast.. Valid values are `original|revised|forecast`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget record was first created.',
    `currency_exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied when converting the budget amount to the reporting currency.',
    `effective_end_date` DATE COMMENT 'Date when the budget expires or is superseded.',
    `effective_start_date` DATE COMMENT 'Date when the budget becomes effective.',
    `fiscal_period` STRING COMMENT 'Numeric period within the fiscal year (e.g., month number).',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the budget applies.',
    `forecast_method` STRING COMMENT 'Technique used to generate forecast budgets.. Valid values are `historical|trend|machine_learning`',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the budget contains confidential information.',
    `last_review_date` DATE COMMENT 'Date of the most recent budget review.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or explanations about the budget.',
    `review_cycle` STRING COMMENT 'Frequency at which the budget is reviewed.. Valid values are `monthly|quarterly|annually`',
    `revision_number` STRING COMMENT 'Numeric indicator of how many times the budget has been revised.',
    `source_system` STRING COMMENT 'Name of the source system that originated the budget record.',
    `updated_by` BIGINT COMMENT 'Identifier of the employee who last updated the budget record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the budget record.',
    `variance_method` STRING COMMENT 'Method used to calculate variance between budget and actuals.. Valid values are `none|fixed|percentage`',
    `version_number` STRING COMMENT 'Sequential version number of the budget record for tracking revisions.',
    `created_by` BIGINT COMMENT 'Identifier of the employee who created the budget record.',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Annual and periodic budget record capturing the financial plan for each GL account, cost center, and legal entity. Captures budget version (original, revised, forecast), budget period, GL account, cost center, legal entity, budget amount, currency, budget owner, approval status, and variance-to-actuals. Supports financial planning and analysis (FP&A) for the payments fintech enterprise including TPV-based revenue budgeting and technology infrastructure cost planning.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`sox_control` (
    `sox_control_id` BIGINT COMMENT 'Unique identifier for the SOX internal control record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: SOX controls apply to specific GL accounts; replace textual scope with FK to gl_account for enforceable linkage.',
    `control_assessment_date` DATE COMMENT 'Date when the control was last assessed for design effectiveness.',
    `control_assessment_result` STRING COMMENT 'Result of the most recent design effectiveness assessment.. Valid values are `pass|fail|partial`',
    `control_audit_trail_enabled` BOOLEAN COMMENT 'Indicates whether an immutable audit trail is captured for this control.',
    `control_code` STRING COMMENT 'Business identifier or code assigned to the control.',
    `control_comments` STRING COMMENT 'Free‑form comments or notes about the control.',
    `control_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the control record was created.',
    `control_data_classification` STRING COMMENT 'Data classification level for the control record.. Valid values are `restricted|confidential|internal|public`',
    `control_document_reference` STRING COMMENT 'Reference (e.g., URL or document ID) to the formal control documentation.',
    `control_effectiveness_rating` STRING COMMENT 'Rating of how effective the control is perceived to be.. Valid values are `effective|ineffective|needs_improvement`',
    `control_frequency` STRING COMMENT 'How often the control is performed.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `control_last_modified_by` STRING COMMENT 'User or system that performed the last modification.',
    `control_name` STRING COMMENT 'Human‑readable name of the internal control.',
    `control_objective` STRING COMMENT 'Statement of the business objective the control is designed to achieve.',
    `control_owner_department` STRING COMMENT 'Department that owns the control.',
    `control_performer` STRING COMMENT 'Person or system that executes the control.',
    `control_regulatory_framework` STRING COMMENT 'Regulatory frameworks applicable to the control (e.g., SOX, PCI DSS, GDPR).',
    `control_remediation_action` STRING COMMENT 'Planned or executed action to remediate a deficiency.',
    `control_risk_rating` STRING COMMENT 'Risk rating assigned to the control.. Valid values are `low|medium|high|critical`',
    `control_testing_method` STRING COMMENT 'Methodology used to test the control (e.g., walkthrough, sampling).',
    `control_type` STRING COMMENT 'Classification of the control (preventive, detective, or directive).. Valid values are `preventive|detective|directive`',
    `control_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the control record.',
    `deficiency_classification` STRING COMMENT 'Classification of any identified deficiency.. Valid values are `significant_deficiency|material_weakness|none`',
    `effective_from` DATE COMMENT 'Date when the control becomes effective.',
    `effective_until` DATE COMMENT 'Date when the control expires or is superseded (nullable).',
    `evidence_requirements` STRING COMMENT 'Documentation or artifacts required to demonstrate control execution.',
    `last_test_date` DATE COMMENT 'Date of the most recent control test.',
    `process_owner` STRING COMMENT 'Individual or team responsible for the process the control covers.',
    `remediation_due_date` DATE COMMENT 'Target date for completing remediation.',
    `remediation_status` STRING COMMENT 'Current status of remediation activities.. Valid values are `open|in_progress|closed|deferred`',
    `sox_control_status` STRING COMMENT 'Current lifecycle status of the control.. Valid values are `active|inactive|retired`',
    `test_result` STRING COMMENT 'Outcome of the most recent control test.. Valid values are `pass|fail|exception|not_tested`',
    `testing_frequency` STRING COMMENT 'How often the control is tested for effectiveness.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    CONSTRAINT pk_sox_control PRIMARY KEY(`sox_control_id`)
) COMMENT 'SOX internal control record defining each financial reporting control required under Sarbanes-Oxley Act compliance. Captures control ID, control name, control objective, control type (preventive/detective), frequency (daily, monthly, quarterly), GL account scope, process owner, control performer, evidence requirements, testing frequency, last test date, test result, deficiency classification (significant deficiency, material weakness), and remediation status. Critical for payments fintech regulatory compliance.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` (
    `sox_control_test_id` BIGINT COMMENT 'Unique identifier for the SOX control test execution record.',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to ledger.sox_control. Business justification: SOX control tests are executed against a specific SOX control; linking provides traceability.',
    `audit_trail` STRING COMMENT 'Immutable log of changes and actions related to the test record.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework(s) applicable to the control test.. Valid values are `SOX404|SOX302|PCI_DSS|GDPR|FISMA|HIPAA`',
    `control_category` STRING COMMENT 'Broad category of the control (e.g., financial reporting, IT general controls).. Valid values are `financial_reporting|it_general|operational|compliance|security|other`',
    `control_frequency` STRING COMMENT 'Scheduled frequency at which the control is performed.. Valid values are `annual|quarterly|monthly|weekly|daily|ad_hoc`',
    `control_name` STRING COMMENT 'Descriptive name of the control under test.',
    `control_owner` STRING COMMENT 'Name of the individual or team responsible for the control.',
    `control_reference` STRING COMMENT 'External identifier or code of the internal control being tested.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test record was initially created in the system.',
    `deficiency_details` STRING COMMENT 'Narrative description of any control deficiencies identified during testing.',
    `evidence_documentation` STRING COMMENT 'Reference or link to supporting documentation and evidence collected for the test.',
    `exceptions_identified` STRING COMMENT 'Count of exceptions or deviations discovered in the test sample.',
    `is_critical` BOOLEAN COMMENT 'Flag indicating whether the control is deemed critical to financial reporting.',
    `management_response` STRING COMMENT 'Managements response to identified deficiencies, including corrective action plans.',
    `remediation_action_taken` STRING COMMENT 'Description of corrective actions performed to address identified deficiencies.',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation actions must be completed.',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the control based on the test outcome.. Valid values are `high|medium|low`',
    `sample_size` STRING COMMENT 'Number of items, transactions, or records sampled during the test.',
    `test_conclusion` STRING COMMENT 'Overall result of the test indicating whether the control is effective or ineffective.. Valid values are `effective|ineffective`',
    `test_date` DATE COMMENT 'Calendar date on which the control test was performed.',
    `test_duration_minutes` STRING COMMENT 'Total time in minutes spent executing the test.',
    `test_location` STRING COMMENT 'Physical or logical location where the test was performed.',
    `test_methodology` STRING COMMENT 'Method used to test the control (e.g., inquiry, observation, inspection, reperformance).. Valid values are `inquiry|observation|inspection|reperformance`',
    `test_period_end` DATE COMMENT 'End date of the financial period covered by the test.',
    `test_period_start` DATE COMMENT 'Start date of the financial period covered by the test.',
    `test_status` STRING COMMENT 'Current processing status of the test record.. Valid values are `pending|completed|failed`',
    `test_time` TIMESTAMP COMMENT 'Exact timestamp when the test execution started.',
    `tester_name` STRING COMMENT 'Full name of the individual who executed the control test.',
    `tester_type` STRING COMMENT 'Indicates whether the test was performed by internal audit staff or an external auditor.. Valid values are `internal_audit|external_auditor`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the test record.',
    CONSTRAINT pk_sox_control_test PRIMARY KEY(`sox_control_test_id`)
) COMMENT 'SOX control test execution record capturing each instance of a SOX control being tested by internal or external auditors. Captures control reference, test date, test period, tester identity (internal audit, external auditor), test methodology (inquiry, observation, inspection, reperformance), sample size, exceptions identified, test conclusion (effective/ineffective), deficiency details, and management response. Provides the audit evidence trail required for SOX 404 certification.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` (
    `fx_revaluation_id` BIGINT COMMENT 'System-generated unique identifier for the FX revaluation record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: FX revaluation entries must reference the functional currency entity for auditability.',
    `gl_account_id` BIGINT COMMENT 'Identifier of the GL account whose balance is being revalued.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the GL journal entry generated for the revaluation.',
    `accounting_period` STRING COMMENT 'Period identifier (year and month) to which the revaluation belongs.. Valid values are `^d{6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the revaluation record was first created in the system.',
    `fiscal_period` STRING COMMENT 'Numeric period within the fiscal year (e.g., 1‑12).',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year of the revaluation.',
    `functional_currency_code` STRING COMMENT 'Three‑letter ISO code of the entitys functional reporting currency.. Valid values are `^[A-Z]{3}$`',
    `is_manual_adjustment` BOOLEAN COMMENT 'Indicates whether the revaluation was entered manually (true) or generated automatically (false).',
    `notes` STRING COMMENT 'Free‑form text for additional context or comments about the revaluation.',
    `original_balance` DECIMAL(18,2) COMMENT 'Monetary amount of the GL account balance before revaluation, expressed in the original currency.',
    `original_currency_code` STRING COMMENT 'Three‑letter ISO code of the currency in which the original balance is recorded.. Valid values are `^[A-Z]{3}$`',
    `revaluation_number` STRING COMMENT 'Business identifier assigned to the revaluation event for tracking and reconciliation.',
    `revaluation_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert the original balance to the functional currency at the revaluation date.',
    `revaluation_status` STRING COMMENT 'Current lifecycle status of the revaluation record.. Valid values are `pending|posted|reversed|error`',
    `revaluation_timestamp` TIMESTAMP COMMENT 'Date and time when the FX revaluation was performed.',
    `revalued_balance` DECIMAL(18,2) COMMENT 'Balance amount after applying the FX revaluation rate, expressed in the functional currency.',
    `source_system` STRING COMMENT 'System of origin that produced the revaluation record.. Valid values are `ERP|GL|DW`',
    `unrealized_gain_loss_amount` DECIMAL(18,2) COMMENT 'Difference between revalued balance and original balance, representing unrealized foreign‑exchange gain or loss.',
    `unrealized_gain_loss_type` STRING COMMENT 'Indicator whether the FX impact is a gain or a loss.. Valid values are `gain|loss`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the revaluation record.',
    CONSTRAINT pk_fx_revaluation PRIMARY KEY(`fx_revaluation_id`)
) COMMENT 'Foreign currency revaluation record capturing the period-end revaluation of monetary GL account balances denominated in non-functional currencies. Captures revaluation date, accounting period, GL account, original currency, functional currency, original balance, revaluation rate, revalued balance, unrealized gain/loss amount, and GL journal entry reference. Essential for payments fintech enterprises operating across 200+ countries with multi-currency settlement and FX exposure.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` (
    `consolidation_entry_id` BIGINT COMMENT 'Unique identifier for the consolidation journal entry record.',
    `audit_trail_id` BIGINT COMMENT 'Identifier linking to the detailed audit trail for this entry.',
    `gl_account_id` BIGINT COMMENT 'General Ledger account impacted by the consolidation entry.',
    `consolidation_group_id` BIGINT COMMENT 'FK to ledger.consolidation_group',
    `cost_center_id` BIGINT COMMENT 'FK to ledger.cost_center',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Consolidation entries aggregate amounts across entities; a unified currency reference is required for elimination.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity to which the consolidation entry applies.',
    `adjustment_reason_code` STRING COMMENT 'Code that identifies the business reason for the adjustment.',
    `adjustment_type` STRING COMMENT 'Category of adjustment applied to the entry.. Valid values are `reversal|correction|reclassification`',
    `consolidation_entry_description` STRING COMMENT 'Free‑text description providing context for the consolidation entry.',
    `consolidation_entry_status` STRING COMMENT 'Current processing status of the consolidation entry.. Valid values are `draft|pending|posted|reversed|rejected`',
    `consolidation_period` STRING COMMENT 'Fiscal period for which the consolidation entry is prepared, expressed as year and quarter (e.g., 2023-Q4).. Valid values are `^d{4}-Q[1-4]$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consolidation entry record was first created.',
    `elimination_amount` DECIMAL(18,2) COMMENT 'Monetary amount eliminated or adjusted in the consolidation entry, expressed in functional currency.',
    `entry_date` DATE COMMENT 'Date the consolidation entry was generated in the business process.',
    `entry_number` STRING COMMENT 'Unique business number assigned to the consolidation entry.',
    `entry_type` STRING COMMENT 'Category of the consolidation entry indicating its purpose.. Valid values are `intercompany_elimination|minority_interest|goodwill_amortization|currency_translation|adjustment`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied when translating foreign currency amounts.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter (1‑4) of the entry.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year of the entry.',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether the entry relates to intercompany elimination.',
    `is_adjustment` BOOLEAN COMMENT 'True if the entry represents an adjustment rather than a primary transaction.',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks.',
    `period` STRING COMMENT 'Fiscal period identifier in YYYY‑MM format.. Valid values are `^d{4}-d{2}$`',
    `posting_date` DATE COMMENT 'Date the consolidation entry was posted to the ledger.',
    `project_code` STRING COMMENT 'Project identifier related to the entry, if applicable.',
    `segment_code` STRING COMMENT 'Reporting segment code associated with the entry.',
    `source_legal_entity_ids` STRING COMMENT 'Comma‑separated list of source legal entity identifiers participating in the consolidation.',
    `sox_control_reference` STRING COMMENT 'Reference to the Sarbanes‑Oxley control governing this entry.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consolidation entry record.',
    CONSTRAINT pk_consolidation_entry PRIMARY KEY(`consolidation_entry_id`)
) COMMENT 'Consolidation journal entry record capturing elimination and adjustment entries required for consolidated financial statement preparation. Captures consolidation group, consolidation period, entry type (intercompany elimination, minority interest, goodwill amortization, currency translation adjustment), source legal entities, elimination amount, currency, and consolidated GL account. Supports the global consolidation process for a payments fintech enterprise with subsidiaries across multiple jurisdictions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` (
    `tax_provision_id` BIGINT COMMENT 'Primary key for tax provision record. _canonical_skip_reason: Entity does not fit predefined roles; treated as OTHER.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Tax provision calculations depend on the reporting currency for accurate tax expense recognition.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the journal entry that records the tax provision.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity to which the tax provision applies.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the tax provision was approved.',
    `approved_by` STRING COMMENT 'User identifier who approved the tax provision.',
    `calculation_method` STRING COMMENT 'Methodology used to calculate the tax provision.. Valid values are `ASC_740|IAS_12|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tax provision record was created.',
    `current_tax_expense` DECIMAL(18,2) COMMENT 'Current tax expense recognized in the period.',
    `data_source_system` STRING COMMENT 'Name of the source system that generated the tax provision (e.g., ERP‑Oracle).',
    `deferred_tax_asset` DECIMAL(18,2) COMMENT 'Deferred tax asset amount arising from temporary differences.',
    `deferred_tax_liability` DECIMAL(18,2) COMMENT 'Deferred tax liability amount arising from temporary differences.',
    `effective_tax_rate` DECIMAL(18,2) COMMENT 'Effective tax rate applied to pre‑tax income (percentage).',
    `exchange_rate_to_reporting_currency` DECIMAL(18,2) COMMENT 'Exchange rate used to convert amounts to the reporting currency.',
    `fiscal_period` STRING COMMENT 'Period code within the fiscal year (e.g., Q1, Q2, H1).',
    `fiscal_year` STRING COMMENT 'Fiscal year associated with the tax provision.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the tax provision.',
    `pre_tax_income` DECIMAL(18,2) COMMENT 'Income before tax for the legal entity and period.',
    `tax_account_code` STRING COMMENT 'GL account code used for the tax provision posting.',
    `tax_jurisdiction_code` STRING COMMENT 'Code representing the tax jurisdiction (e.g., country or region) for the provision.',
    `tax_period_end_date` DATE COMMENT 'End date of the tax reporting period covered by this provision.',
    `tax_period_start_date` DATE COMMENT 'Start date of the tax reporting period covered by this provision.',
    `tax_status` STRING COMMENT 'Current status of the tax provision record.. Valid values are `pending|finalized|adjusted|reversed`',
    `tax_type` STRING COMMENT 'Classification of tax (e.g., income, sales, property).. Valid values are `income|sales|property|other`',
    `uncertain_tax_position_reserve` DECIMAL(18,2) COMMENT 'Reserve for uncertain tax positions per ASC 740 / IAS 12.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tax provision record.',
    CONSTRAINT pk_tax_provision PRIMARY KEY(`tax_provision_id`)
) COMMENT 'Corporate tax provision record capturing the current and deferred tax calculations for each legal entity per accounting period. Captures legal entity, tax jurisdiction, tax period, pre-tax income, current tax expense, deferred tax asset, deferred tax liability, effective tax rate, uncertain tax position reserve, and tax provision journal entry reference. Supports income tax accounting under ASC 740 / IAS 12 for payments fintech entities operating across multiple tax jurisdictions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` (
    `financial_statement_id` BIGINT COMMENT 'Unique identifier for the financial statement record. _canonical_skip_reason: role inferred as OTHER, no minimum categories required.',
    `approved_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who approved the statement.',
    `consolidation_group_id` BIGINT COMMENT 'Identifier of the consolidation group, if applicable.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who prepared the statement.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity for which the statement is prepared.',
    `primary_financial_employee_id` BIGINT COMMENT 'Identifier of the user who prepared the statement.',
    `cash_flow_from_financing` DECIMAL(18,2) COMMENT 'Cash flow from financing activities.',
    `cash_flow_from_investing` DECIMAL(18,2) COMMENT 'Cash flow from investing activities.',
    `cash_flow_from_operations` DECIMAL(18,2) COMMENT 'Cash flow from operating activities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the statement record was created.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code of the statement amounts. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|... — promote to reference product]',
    `data_classification` STRING COMMENT 'Data classification level of the statement record.. Valid values are `restricted|confidential|internal|public`',
    `equity` DECIMAL(18,2) COMMENT 'Equity (shareholders equity) reported.',
    `expense` DECIMAL(18,2) COMMENT 'Total expense reported (for income statement).',
    `external_audit_signoff` BOOLEAN COMMENT 'Indicates whether an external auditor has signed off the statement.',
    `filing_reference` STRING COMMENT 'Reference number for regulatory filing (e.g., SEC accession number).',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter (1-4) of the statement.',
    `fiscal_year` STRING COMMENT 'Fiscal year associated with the statement.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates if the statement is consolidated across multiple entities.',
    `net_income` DECIMAL(18,2) COMMENT 'Net income (profit) reported.',
    `notes` STRING COMMENT 'Free‑text notes or comments about the statement.',
    `preparation_status` STRING COMMENT 'Current preparation status of the statement.. Valid values are `draft|in_review|finalized|archived`',
    `reporting_entity_name` STRING COMMENT 'Legal name of the reporting entity.',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period covered by the statement.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period covered by the statement.',
    `reporting_standard` STRING COMMENT 'Accounting standard used for the statement.. Valid values are `GAAP|IFRS`',
    `restatement_flag` BOOLEAN COMMENT 'Indicates if the statement is a restatement of a prior filing.',
    `revenue` DECIMAL(18,2) COMMENT 'Total revenue reported (for income statement).',
    `review_status` STRING COMMENT 'Review status after internal audit.. Valid values are `pending|approved|rejected`',
    `statement_type` STRING COMMENT 'Type of financial statement (e.g., income statement, balance sheet, cash flow, statement of equity).. Valid values are `income_statement|balance_sheet|cash_flow|statement_of_equity`',
    `total_assets` DECIMAL(18,2) COMMENT 'Total assets reported in the statement.',
    `total_liabilities` DECIMAL(18,2) COMMENT 'Total liabilities reported in the statement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the statement record.',
    `version_number` STRING COMMENT 'Version number of the statement (incremented on revisions).',
    CONSTRAINT pk_financial_statement PRIMARY KEY(`financial_statement_id`)
) COMMENT 'Published financial statement record representing a formal financial report (income statement, balance sheet, cash flow statement, statement of equity) for a legal entity or consolidated group for a reporting period. Captures statement type, reporting entity, reporting period, reporting standard (GAAP/IFRS), currency, preparation status, review status, external audit sign-off, filing reference (SEC, regulatory), and restatement flag. The authoritative record of financial reporting outputs.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` (
    `allocation_rule_id` BIGINT COMMENT 'System-generated unique identifier for the allocation rule.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Allocation rules are defined per GL account; FK enables direct association.',
    `allocation_basis_metric` STRING COMMENT 'Metric that drives the allocation (e.g., headcount, TPV).. Valid values are `headcount|transaction_volume|revenue|employee_count|custom_metric`',
    `allocation_fixed_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount allocated when allocation_method is fixed_amount.',
    `allocation_method` STRING COMMENT 'Algorithm used to calculate the allocation (e.g., fixed percentage, headcount based).. Valid values are `fixed_percentage|headcount|tpv_weighted|statistical|custom`',
    `allocation_metric_unit` STRING COMMENT 'Unit of measure for the allocation_basis_metric (e.g., "employees", "transactions").',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage value used when allocation_method is fixed_percentage.',
    `allocation_rule_code` STRING COMMENT 'Business code used to reference the rule in external systems.',
    `allocation_rule_description` STRING COMMENT 'Detailed free‑text description of the rules purpose and logic.',
    `allocation_rule_name` STRING COMMENT 'Human‑readable name of the allocation rule.',
    `allocation_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|pending|retired`',
    `allocation_rule_type` STRING COMMENT 'Category of entity to which the rule applies (e.g., cost center, legal entity).. Valid values are `cost_center|legal_entity|business_unit|project`',
    `approval_status` STRING COMMENT 'Current approval state of the rule.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the rule.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the rule was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the rule record was created.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for monetary values in the rule.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'Date on which the rule becomes effective.',
    `effective_time_zone` STRING COMMENT 'Time zone used for interpreting effective_from and effective_until dates.',
    `effective_until` DATE COMMENT 'Date on which the rule expires (null for open‑ended).',
    `is_system_defined` BOOLEAN COMMENT 'Indicates whether the rule is defined by the platform (true) or by a business user (false).',
    `last_applied_by` STRING COMMENT 'User or process that last applied the rule.',
    `last_applied_date` DATE COMMENT 'Date when the rule was last executed in a cost allocation run.',
    `notes` STRING COMMENT 'Additional free‑form comments or audit notes.',
    `priority` STRING COMMENT 'Numeric priority determining rule evaluation order (lower = higher priority).',
    `rule_condition` STRING COMMENT 'Logical expression defining when the rule applies (e.g., "transaction_type = FX AND amount > 1000").',
    `rule_owner` STRING COMMENT 'Business owner responsible for the rule.',
    `rule_scope` STRING COMMENT 'Scope of applicability for the rule.. Valid values are `global|entity|cost_center|project`',
    `updated_by` STRING COMMENT 'Identifier of the user or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the rule.',
    `version_number` STRING COMMENT 'Incremental version of the rule for change tracking.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the rule.',
    CONSTRAINT pk_allocation_rule PRIMARY KEY(`allocation_rule_id`)
) COMMENT 'Expense and cost allocation rule configuration defining how shared costs are distributed across cost centers, legal entities, or business units. Captures rule name, allocation type (fixed percentage, statistical basis, headcount, TPV-weighted), source account range, target account range, allocation basis metric, effective date range, approval status, and last applied date. Supports management accounting and transfer pricing governance for the payments fintech enterprise.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` (
    `audit_trail_id` BIGINT COMMENT 'Primary key for audit_trail',
    `device_id` BIGINT COMMENT 'Identifier of the device used to perform the action.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who performed the action.',
    `request_id` BIGINT COMMENT 'Unique identifier for the request that triggered the event.',
    `audit_session_id` BIGINT COMMENT 'Identifier of the user session during which the event occurred.',
    `transaction_id` BIGINT COMMENT 'Identifier of the related business transaction, if any.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was inserted into the audit trail.',
    `audit_trail_version` STRING COMMENT 'Version number of the audit trail schema for this record.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit record.',
    `change_reason` STRING COMMENT 'Business reason or comment for the change.',
    `changed_entity` STRING COMMENT 'Name of the entity/table that was changed.',
    `changed_entity_reference` BIGINT COMMENT 'Primary key of the entity record that was changed.',
    `changed_fields` STRING COMMENT 'Comma-separated list of fields that were modified.',
    `compliance_status` STRING COMMENT 'Compliance verification status of the audited change.',
    `correlation_key` STRING COMMENT 'Identifier used to correlate this event with other related events.',
    `data_classification` STRING COMMENT 'Classification level of the data involved in the event.',
    `deletion_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was marked as deleted.',
    `error_code` STRING COMMENT 'Error code if the operation failed.',
    `error_message` STRING COMMENT 'Human readable error message for failed operation.',
    `event_source_identifier` STRING COMMENT 'Unique identifier of the source system or component that generated the event.',
    `event_source_type` STRING COMMENT 'Category of the source that generated the event.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the audited event occurred.',
    `event_type` STRING COMMENT 'Classification of the audited action.',
    `ip_address` STRING COMMENT 'IP address from which the action was performed.',
    `is_deleted` BOOLEAN COMMENT 'Indicates whether the audited record has been logically deleted.',
    `is_sensitive` BOOLEAN COMMENT 'Flag indicating if the changed data contains sensitive information.',
    `jurisdiction` STRING COMMENT 'Regulatory jurisdiction applicable to the event.',
    `new_values` STRING COMMENT 'JSON string capturing the values after the change.',
    `operation_context` STRING COMMENT 'Additional context describing the operation (e.g., batch, real-time).',
    `previous_values` STRING COMMENT 'JSON string capturing the values before the change.',
    `retention_expiry_date` DATE COMMENT 'Date when the audit record is scheduled for archival or deletion per data retention policy.',
    `source_application` STRING COMMENT 'Name of the application that generated the event.',
    `source_module` STRING COMMENT 'Specific module or component within the application that generated the event.',
    `success_flag` BOOLEAN COMMENT 'Indicates whether the operation completed successfully.',
    `user_email` STRING COMMENT 'Email address of the user who performed the action.',
    `user_name` STRING COMMENT 'Full name of the user who performed the action.',
    CONSTRAINT pk_audit_trail PRIMARY KEY(`audit_trail_id`)
) COMMENT 'Master reference table for audit_trail. Referenced by audit_trail_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`consolidation_group` (
    `consolidation_group_id` BIGINT COMMENT 'Primary key for consolidation_group',
    `currency_id` BIGINT COMMENT 'FK to reference.currency',
    `parent_group_id` BIGINT COMMENT 'Identifier of the immediate parent group in a hierarchical consolidation structure.',
    `parent_consolidation_group_id` BIGINT COMMENT 'Self-referencing FK on consolidation_group (parent_consolidation_group_id)',
    `consolidation_method` STRING COMMENT 'Method used to aggregate subsidiary results into the group.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consolidation group record was first created in the system.',
    `consolidation_group_description` STRING COMMENT 'Free‑form text describing the purpose, scope, or special characteristics of the group.',
    `effective_from` DATE COMMENT 'Date when the consolidation group becomes effective for financial reporting.',
    `effective_until` DATE COMMENT 'Date when the consolidation group ceases to be effective; null for open‑ended groups.',
    `group_code` STRING COMMENT 'External code used by finance and reporting systems to reference the consolidation group.',
    `group_name` STRING COMMENT 'Human‑readable name of the consolidation group.',
    `group_type` STRING COMMENT 'Category that defines the nature of the group for reporting purposes.',
    `is_internal` BOOLEAN COMMENT 'True if the consolidation group is used for internal reporting only.',
    `region_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 code representing the primary geographic region of the group.',
    `reporting_frequency` STRING COMMENT 'How often the group consolidates financial results.',
    `consolidation_group_status` STRING COMMENT 'Current lifecycle state of the consolidation group.',
    `tax_identifier` STRING COMMENT 'Legal tax identification number for the consolidation group (e.g., EIN, VAT number).',
    `updated_by` STRING COMMENT 'Identifier of the user or process that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consolidation group record.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the record.',
    CONSTRAINT pk_consolidation_group PRIMARY KEY(`consolidation_group_id`)
) COMMENT 'Master reference table for consolidation_group. Referenced by consolidation_group_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`related_party` (
    `related_party_id` BIGINT COMMENT 'Primary key for related_party',
    `ultimate_parent_related_party_id` BIGINT COMMENT 'Self-referencing FK on related_party (ultimate_parent_related_party_id)',
    `address_line1` STRING COMMENT 'First line of the related partys mailing address.',
    `address_line2` STRING COMMENT 'Second line of the related partys mailing address (optional).',
    `city` STRING COMMENT 'City component of the related partys address.',
    `contact_email` STRING COMMENT 'Primary email address for the related party.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the related party.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the related partys primary location. [ENUM-REF-CANDIDATE: USA|CAN|GBR|AUS|DEU|FRA — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the related party record was first created.',
    `effective_end_date` DATE COMMENT 'Date when the related party ceased to be active (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the related party became active in the system.',
    `industry_classification` STRING COMMENT 'Standard industry code (e.g., NAICS) describing the partys primary business sector.',
    `notes` STRING COMMENT 'Free‑form text for additional information or comments about the related party.',
    `party_name` STRING COMMENT 'Legal or display name of the related party (individual or organization).',
    `party_type` STRING COMMENT 'Category describing the nature of the party.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the related partys address.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for contacting the related party.',
    `registration_number` STRING COMMENT 'Official registration number assigned to the party by a regulatory authority.',
    `risk_score` DECIMAL(18,2) COMMENT 'Internal risk rating for the related party, expressed as a numeric score.',
    `source_system` STRING COMMENT 'Name of the upstream operational system that supplied the record.',
    `state_province` STRING COMMENT 'State or province component of the related partys address.',
    `related_party_status` STRING COMMENT 'Current lifecycle state of the related party.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax ID (e.g., EIN, VAT number) for the related party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the related party record.',
    CONSTRAINT pk_related_party PRIMARY KEY(`related_party_id`)
) COMMENT 'Master reference table for related_party. Referenced by related_party_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Primary key for vendor',
    `parent_vendor_id` BIGINT COMMENT 'Self-referencing FK on vendor (parent_vendor_id)',
    `address_line1` STRING COMMENT 'First line of the vendors street address.',
    `address_line2` STRING COMMENT 'Second line of the vendors street address (optional).',
    `bank_account_number` STRING COMMENT 'Bank account number for payments to the vendor.',
    `bank_routing_number` STRING COMMENT 'Routing number (or SWIFT/BIC) for the vendors bank.',
    `city` STRING COMMENT 'City component of the vendors address.',
    `compliance_status` STRING COMMENT 'Current compliance standing of the vendor.',
    `contract_number` STRING COMMENT 'Reference number of the primary contract with the vendor.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the vendors location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was first created.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount extended to the vendor.',
    `currency` STRING COMMENT 'Default currency used for transactions with the vendor.',
    `data_source` STRING COMMENT 'Origin system or source of the vendor record.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the vendor.',
    `email` STRING COMMENT 'Primary email address for the vendor.',
    `industry_code` STRING COMMENT 'Standard industry classification code (e.g., NAICS) for the vendor.',
    `is_preferred` BOOLEAN COMMENT 'Indicates whether the vendor is a preferred supplier.',
    `is_tax_exempt` BOOLEAN COMMENT 'True if the vendor is exempt from tax withholding.',
    `last_review_date` DATE COMMENT 'Date of the most recent vendor performance review.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the vendor.',
    `onboarding_date` DATE COMMENT 'Date the vendor was first onboarded into the system.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the vendor.',
    `phone` STRING COMMENT 'Primary telephone number for the vendor.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the vendors address.',
    `primary_contact_method` STRING COMMENT 'Preferred communication channel for the primary contact.',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person for the vendor.',
    `rating` STRING COMMENT 'Internal rating of the vendors performance.',
    `review_score` DECIMAL(18,2) COMMENT 'Numeric score from the latest vendor review (0.00‑10.00).',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk rating for the vendor (0.00‑99.99).',
    `state` STRING COMMENT 'State or province component of the vendors address.',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax identifier for the vendor.',
    `termination_date` DATE COMMENT 'Date the vendor relationship was terminated, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the vendor record.',
    `vat_number` STRING COMMENT 'Value‑Added Tax registration number for the vendor.',
    `vendor_category` STRING COMMENT 'Business category used for reporting and analytics.',
    `vendor_code` STRING COMMENT 'Internal business code used to reference the vendor.',
    `vendor_group` STRING COMMENT 'Higher‑level grouping or division the vendor belongs to.',
    `vendor_name` STRING COMMENT 'Legal name of the vendor organization.',
    `vendor_status_detail` STRING COMMENT 'Additional free‑text detail describing the vendors current status.',
    `vendor_type` STRING COMMENT 'Category of vendor (e.g., service, product, software, hardware, consulting).',
    `website_url` STRING COMMENT 'Public website address of the vendor.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master reference table for vendor. Referenced by vendor_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`revenue_line` (
    `revenue_line_id` BIGINT COMMENT 'Primary key for revenue_line',
    `card_program_id` BIGINT COMMENT 'Identifier of the product or service that generated the revenue.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Revenue line records reference a cost center; using a FK removes the redundant code column and enforces referential integrity.',
    `currency_id` BIGINT COMMENT 'FK to reference.currency',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Revenue line amounts belong to a GL account; a properly named FK (gl_account_id) replaces the ambiguous ledger_account_id.',
    `revenue_recognition_schedule_id` BIGINT COMMENT 'Identifier of the parent revenue transaction header to which this line belongs.',
    `parent_revenue_line_id` BIGINT COMMENT 'Self-referencing FK on revenue_line (parent_revenue_line_id)',
    `amount` DECIMAL(18,2) COMMENT 'Pre-tax, pre-discount monetary amount for the line.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the revenue line record was first created in the system.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discounts or rebates subtracted from the gross amount.',
    `effective_from` DATE COMMENT 'Start date when the revenue line becomes effective (used for deferred revenue).',
    `effective_until` DATE COMMENT 'End date when the revenue line ceases to be effective; null if open‑ended.',
    `line_number` STRING COMMENT 'Sequential order of the line within the revenue header.',
    `line_type` STRING COMMENT 'Classification of the revenue line (e.g., sale, refund, fee).',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after tax and discount adjustments.',
    `notes` STRING COMMENT 'Free‑form text for additional context or comments about the revenue line.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or amount of service that the revenue line represents.',
    `revenue_recognition_date` DATE COMMENT 'Date on which the revenue is recognized for accounting purposes.',
    `source_system` STRING COMMENT 'Name of the upstream operational system that originated the revenue line.',
    `revenue_line_status` STRING COMMENT 'Current processing state of the revenue line.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the gross amount.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., transaction, hour, GB).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the revenue line record.',
    CONSTRAINT pk_revenue_line PRIMARY KEY(`revenue_line_id`)
) COMMENT 'Master reference table for revenue_line. Referenced by revenue_line_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`contract` (
    `contract_id` BIGINT COMMENT 'Primary key for contract',
    `contract_manager_employee_id` BIGINT COMMENT 'Party tasked with day‑to‑day management of the contract.',
    `employee_id` BIGINT COMMENT 'Party responsible for the contract on the organization side.',
    `master_contract_id` BIGINT COMMENT 'Self-referencing FK on contract (master_contract_id)',
    `amendment_number` STRING COMMENT 'Counter for the number of amendments applied to the contract.',
    `approved_by` STRING COMMENT 'Identifier of the user who approved the contract.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract received final approval.',
    `auto_renewal` BOOLEAN COMMENT 'True if the contract renews automatically at term end.',
    `billing_cycle` STRING COMMENT 'Frequency at which invoices are generated under the contract.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission percentage earned on contract revenue.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the contract record.',
    `contract_category` STRING COMMENT 'Higher‑level grouping of contracts for reporting.',
    `contract_description` STRING COMMENT 'Free‑form description of the contract purpose and scope.',
    `contract_document_hash` STRING COMMENT 'SHA‑256 hash of the contract document for integrity verification.',
    `contract_expiration_notice_sent` BOOLEAN COMMENT 'True if an expiration reminder has been sent to the counter‑party.',
    `contract_last_review_date` DATE COMMENT 'Date when the contract was last reviewed for compliance or renewal.',
    `contract_line_of_business` STRING COMMENT 'Business line or product area the contract belongs to.',
    `contract_name` STRING COMMENT 'Human‑readable name or title of the contract.',
    `contract_number` STRING COMMENT 'External contract number used in business communications and legal documents.',
    `contract_risk_score` DECIMAL(18,2) COMMENT 'Risk rating assigned to the contract based on credit and compliance factors.',
    `contract_source_system` STRING COMMENT 'Originating operational system that created the contract record.',
    `contract_status_reason` STRING COMMENT 'Explanation for the current status, e.g., pending approval, under negotiation.',
    `contract_type` STRING COMMENT 'Category describing the nature of the agreement.',
    `contract_url` STRING COMMENT 'Link to the stored contract document.',
    `contract_value_amount` DECIMAL(18,2) COMMENT 'Monetary value of the contract at inception.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the contract value.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base contract price.',
    `effective_end_date` DATE COMMENT 'Date when the contract expires or ends; null for open‑ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the contract becomes legally binding.',
    `is_active` BOOLEAN COMMENT 'True if the contract is currently active.',
    `is_archived` BOOLEAN COMMENT 'True if the contract has been archived and is read‑only.',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the legal jurisdiction governing the contract.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed for the contract.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the contract meets all applicable payments‑fintech regulations.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract is eligible for renewal.',
    `renewal_term_months` STRING COMMENT 'Length of the renewal period in months.',
    `signing_date` DATE COMMENT 'Date the contract was signed by all parties.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the contract.',
    `termination_date` DATE COMMENT 'Date the contract was terminated, if applicable.',
    `termination_reason` STRING COMMENT 'Reason provided for contract termination.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `version_number` STRING COMMENT 'Sequential version number for contract revisions.',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Master reference table for contract. Referenced by contract_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`performance_obligation` (
    `performance_obligation_id` BIGINT COMMENT 'Primary key for performance_obligation',
    `parent_performance_obligation_id` BIGINT COMMENT 'Self-referencing FK on performance_obligation (parent_performance_obligation_id)',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Quantity actually delivered or achieved to date.',
    `billing_frequency` STRING COMMENT 'How often the obligation is billed to the counter‑party.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance obligation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for total_amount.',
    `performance_obligation_description` STRING COMMENT 'Free‑form text describing the scope, deliverables, and conditions of the performance obligation.',
    `due_date` DATE COMMENT 'Date by which payment for the obligation is due.',
    `effective_from` DATE COMMENT 'Date on which the performance obligation becomes binding.',
    `effective_until` DATE COMMENT 'Date on which the performance obligation expires or is scheduled to end; null for open‑ended obligations.',
    `fulfillment_status` STRING COMMENT 'Current state of obligation fulfillment against the performance metric.',
    `measurement_unit` STRING COMMENT 'Unit of measure for target_quantity and actual_quantity.',
    `obligation_name` STRING COMMENT 'Descriptive name of the performance obligation for easy identification.',
    `obligation_number` STRING COMMENT 'External contract number or code assigned to the performance obligation.',
    `obligation_type` STRING COMMENT 'Category of the performance obligation indicating the nature of the promised deliverable.',
    `payment_terms` STRING COMMENT 'Textual description of payment terms (e.g., Net 30, due on receipt).',
    `penalty_clause` STRING COMMENT 'Description of any penalties for non‑fulfillment or late performance.',
    `performance_metric` STRING COMMENT 'Metric used to measure fulfillment of the obligation.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the obligation is eligible for automatic renewal.',
    `renewal_term_months` STRING COMMENT 'Length of the renewal period in months if renewal_flag is true.',
    `revenue_recognition_method` STRING COMMENT 'Method used to recognize revenue for this obligation per IFRS 15 / ASC 606.',
    `performance_obligation_status` STRING COMMENT 'Current lifecycle status of the performance obligation.',
    `target_quantity` DECIMAL(18,2) COMMENT 'Planned quantity or volume to be delivered as defined by the performance metric.',
    `termination_date` DATE COMMENT 'Date on which the performance obligation was terminated, if applicable.',
    `termination_reason` STRING COMMENT 'Reason for early termination of the performance obligation.',
    `total_amount` DECIMAL(18,2) COMMENT 'Monetary value associated with the performance obligation as defined in the contract.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the performance obligation record.',
    CONSTRAINT pk_performance_obligation PRIMARY KEY(`performance_obligation_id`)
) COMMENT 'Master reference table for performance_obligation. Referenced by performance_obligation_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`audit_session` (
    `audit_session_id` BIGINT COMMENT 'Primary key for audit_session',
    `parent_audit_session_id` BIGINT COMMENT 'Self-referencing FK on audit_session (parent_audit_session_id)',
    `action` STRING COMMENT 'Business action recorded in the audit session.',
    `audit_source` STRING COMMENT 'Channel through which the audit session was initiated.',
    `device_id` STRING COMMENT 'Identifier of the device used during the audit session.',
    `duration_seconds` STRING COMMENT 'Total duration of the audit session in seconds.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit session ended.',
    `error_code` STRING COMMENT 'Error code returned when the outcome is failure or partial.',
    `ip_address` STRING COMMENT 'Source IP address from which the audit session was initiated.',
    `notes` STRING COMMENT 'Free‑form notes or comments captured for the audit session.',
    `object_id` STRING COMMENT 'Identifier of the specific business object involved in the action.',
    `object_type` STRING COMMENT 'Type of business object that was accessed or modified.',
    `outcome` STRING COMMENT 'Result of the audited action.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this audit session record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this audit session record.',
    `session_type` STRING COMMENT 'Classification of the audit session (e.g., full audit, partial, system‑initiated, admin).',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit session began.',
    `user_id` BIGINT COMMENT 'System identifier of the user who performed the audited actions.',
    `user_name` STRING COMMENT 'Full legal name of the user associated with the audit session.',
    CONSTRAINT pk_audit_session PRIMARY KEY(`audit_session_id`)
) COMMENT 'Master reference table for audit_session. Referenced by session_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_parent_account_gl_account_id` FOREIGN KEY (`parent_account_gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_consolidation_group_id` FOREIGN KEY (`consolidation_group_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`consolidation_group`(`consolidation_group_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_parent_entity_legal_entity_id` FOREIGN KEY (`parent_entity_legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_primary_ultimate_parent_legal_entity_id` FOREIGN KEY (`primary_ultimate_parent_legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_ledger_config_id` FOREIGN KEY (`ledger_config_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`ledger_config`(`ledger_config_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_ledger_ledger_config_id` FOREIGN KEY (`ledger_ledger_config_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`ledger_config`(`ledger_config_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_related_party_id` FOREIGN KEY (`related_party_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`related_party`(`related_party_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_reversal_of_journal_entry_id` FOREIGN KEY (`reversal_of_journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ADD CONSTRAINT `fk_ledger_journal_line_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ADD CONSTRAINT `fk_ledger_journal_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ADD CONSTRAINT `fk_ledger_journal_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ADD CONSTRAINT `fk_ledger_journal_line_journal_journal_entry_id` FOREIGN KEY (`journal_journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ADD CONSTRAINT `fk_ledger_gl_balance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ADD CONSTRAINT `fk_ledger_gl_balance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ADD CONSTRAINT `fk_ledger_gl_balance_ledger_config_id` FOREIGN KEY (`ledger_config_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`ledger_config`(`ledger_config_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ADD CONSTRAINT `fk_ledger_gl_balance_ledger_ledger_config_id` FOREIGN KEY (`ledger_ledger_config_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`ledger_config`(`ledger_config_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_ledger_revenue_recognition_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`contract`(`contract_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_ledger_revenue_recognition_schedule_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ADD CONSTRAINT `fk_ledger_revenue_recognition_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ADD CONSTRAINT `fk_ledger_revenue_recognition_event_revenue_line_id` FOREIGN KEY (`revenue_line_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`revenue_line`(`revenue_line_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ADD CONSTRAINT `fk_ledger_revenue_recognition_event_revenue_recognition_schedule_id` FOREIGN KEY (`revenue_recognition_schedule_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule`(`revenue_recognition_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ADD CONSTRAINT `fk_ledger_revenue_recognition_event_reversal_event_revenue_recognition_event_id` FOREIGN KEY (`reversal_event_revenue_recognition_event_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_receiving_entity_legal_entity_id` FOREIGN KEY (`receiving_entity_legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ADD CONSTRAINT `fk_ledger_period_close_task_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ADD CONSTRAINT `fk_ledger_period_close_task_dependent_task_id` FOREIGN KEY (`dependent_task_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`period_close_task`(`period_close_task_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ADD CONSTRAINT `fk_ledger_account_reconciliation_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ADD CONSTRAINT `fk_ledger_account_reconciliation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ADD CONSTRAINT `fk_ledger_accrual_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ADD CONSTRAINT `fk_ledger_accrual_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ADD CONSTRAINT `fk_ledger_accrual_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ADD CONSTRAINT `fk_ledger_expense_allocation_allocation_journal_journal_entry_id` FOREIGN KEY (`allocation_journal_journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ADD CONSTRAINT `fk_ledger_expense_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ADD CONSTRAINT `fk_ledger_expense_allocation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ADD CONSTRAINT `fk_ledger_expense_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ADD CONSTRAINT `fk_ledger_expense_allocation_target_cost_center_id` FOREIGN KEY (`target_cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ADD CONSTRAINT `fk_ledger_fixed_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`vendor`(`vendor_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ADD CONSTRAINT `fk_ledger_depreciation_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ADD CONSTRAINT `fk_ledger_depreciation_schedule_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ADD CONSTRAINT `fk_ledger_depreciation_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ADD CONSTRAINT `fk_ledger_depreciation_schedule_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ADD CONSTRAINT `fk_ledger_payable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ADD CONSTRAINT `fk_ledger_payable_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ADD CONSTRAINT `fk_ledger_payable_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`vendor`(`vendor_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ADD CONSTRAINT `fk_ledger_budget_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ADD CONSTRAINT `fk_ledger_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ADD CONSTRAINT `fk_ledger_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ADD CONSTRAINT `fk_ledger_budget_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ADD CONSTRAINT `fk_ledger_sox_control_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ADD CONSTRAINT `fk_ledger_sox_control_test_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`sox_control`(`sox_control_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ADD CONSTRAINT `fk_ledger_fx_revaluation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ADD CONSTRAINT `fk_ledger_fx_revaluation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ADD CONSTRAINT `fk_ledger_consolidation_entry_audit_trail_id` FOREIGN KEY (`audit_trail_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`audit_trail`(`audit_trail_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ADD CONSTRAINT `fk_ledger_consolidation_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ADD CONSTRAINT `fk_ledger_consolidation_entry_consolidation_group_id` FOREIGN KEY (`consolidation_group_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`consolidation_group`(`consolidation_group_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ADD CONSTRAINT `fk_ledger_consolidation_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ADD CONSTRAINT `fk_ledger_consolidation_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ADD CONSTRAINT `fk_ledger_tax_provision_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ADD CONSTRAINT `fk_ledger_tax_provision_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ADD CONSTRAINT `fk_ledger_financial_statement_consolidation_group_id` FOREIGN KEY (`consolidation_group_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`consolidation_group`(`consolidation_group_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ADD CONSTRAINT `fk_ledger_financial_statement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ADD CONSTRAINT `fk_ledger_allocation_rule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ADD CONSTRAINT `fk_ledger_audit_trail_audit_session_id` FOREIGN KEY (`audit_session_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`audit_session`(`audit_session_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_group` ADD CONSTRAINT `fk_ledger_consolidation_group_parent_group_id` FOREIGN KEY (`parent_group_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`consolidation_group`(`consolidation_group_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_group` ADD CONSTRAINT `fk_ledger_consolidation_group_parent_consolidation_group_id` FOREIGN KEY (`parent_consolidation_group_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`consolidation_group`(`consolidation_group_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ADD CONSTRAINT `fk_ledger_related_party_ultimate_parent_related_party_id` FOREIGN KEY (`ultimate_parent_related_party_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`related_party`(`related_party_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ADD CONSTRAINT `fk_ledger_vendor_parent_vendor_id` FOREIGN KEY (`parent_vendor_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`vendor`(`vendor_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_line` ADD CONSTRAINT `fk_ledger_revenue_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_line` ADD CONSTRAINT `fk_ledger_revenue_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_line` ADD CONSTRAINT `fk_ledger_revenue_line_revenue_recognition_schedule_id` FOREIGN KEY (`revenue_recognition_schedule_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule`(`revenue_recognition_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_line` ADD CONSTRAINT `fk_ledger_revenue_line_parent_revenue_line_id` FOREIGN KEY (`parent_revenue_line_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`revenue_line`(`revenue_line_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`contract` ADD CONSTRAINT `fk_ledger_contract_master_contract_id` FOREIGN KEY (`master_contract_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`contract`(`contract_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`performance_obligation` ADD CONSTRAINT `fk_ledger_performance_obligation_parent_performance_obligation_id` FOREIGN KEY (`parent_performance_obligation_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_session` ADD CONSTRAINT `fk_ledger_audit_session_parent_audit_session_id` FOREIGN KEY (`parent_audit_session_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`audit_session`(`audit_session_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`ledger` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `payments_fintech_ecm`.`ledger` SET TAGS ('dbx_domain' = 'ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `parent_account_gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent GL Account Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'Account Group');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_owner` SET TAGS ('dbx_business_glossary_term' = 'Account Owner');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_subtype` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Subtype');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External System Reference ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `financial_statement` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Mapping');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `financial_statement` SET TAGS ('dbx_value_regex' = 'balance_sheet|income_statement|cash_flow|equity_statement');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `gl_account_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Level');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `is_budgeted` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `is_consolidation` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `normal_balance` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance Direction');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `normal_balance` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Business Segment Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `sox_control_classification` SET TAGS ('dbx_business_glossary_term' = 'SOX Control Classification');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `sox_control_classification` SET TAGS ('dbx_value_regex' = 'required|optional|none');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'headcount|revenue|expense|custom');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `budget_period` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'internal|external|project|department|shared');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `is_shared` SET TAGS ('dbx_business_glossary_term' = 'Shared Cost Center Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Manager Email');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `manager_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Manager Name');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `owning_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `parent_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `consolidation_group_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Legal Entity ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `primary_ultimate_parent_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Legal Entity ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'clear|matched|pending_review');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `compliance_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Reference');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `financial_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Period');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `financial_reporting_period` SET TAGS ('dbx_value_regex' = 'FY|Q1|Q2|Q3|Q4');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `functional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{15,34}$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `industry_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `legal_entity_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `legal_entity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `legal_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `legal_entity_type` SET TAGS ('dbx_value_regex' = 'corporation|subsidiary|branch|joint_venture|partnership|sole_proprietorship');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `ofac_sanctions_status` SET TAGS ('dbx_business_glossary_term' = 'OFAC Sanctions Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `ofac_sanctions_status` SET TAGS ('dbx_value_regex' = 'clear|matched|pending_review');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registration_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Registration Jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Registration Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `regulatory_license_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory License Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `regulatory_license_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory License Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `regulatory_license_type` SET TAGS ('dbx_value_regex' = 'payment_service|money_transmitter|e_money|other');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `swift_bic` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Business Identifier Code (BIC)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `swift_bic` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,11}$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `swift_bic` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `swift_bic` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_business_glossary_term' = 'Tax ID Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_value_regex' = 'EIN|VAT|GST|Other');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Identifier (API_ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `ledger_config_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Identifier (LEDGER_ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `ledger_ledger_config_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Identifier (LEDGER_ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `close_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period Close Timestamp (PCT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `closing_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance Amount (CBA)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date (PED)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `is_adjustment_period` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Period Flag (APF)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Archived Period Flag (APF)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Current Period Flag (CPF)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period Open Timestamp (POT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_category` SET TAGS ('dbx_business_glossary_term' = 'Period Category (PC)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_category` SET TAGS ('dbx_value_regex' = 'financial|tax|reporting');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Code (APC)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_description` SET TAGS ('dbx_business_glossary_term' = 'Period Description (PD)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Name (APN)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Period Sequence Number (PSN)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_sequence` SET TAGS ('dbx_business_glossary_term' = 'Period Sequence Within Year (PSY)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status (PS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'open|closed|locked|pending');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type (PT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'month|quarter|year|adjustment');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `period_version` SET TAGS ('dbx_business_glossary_term' = 'Period Version Number (PVN)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date (PSD)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User (UBU)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CBU)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID (JEID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID (APPROVER_ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `approver_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID (APPROVER_ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer Employee ID (PREP_ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer Employee ID (PREP_ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `related_party_id` SET TAGS ('dbx_business_glossary_term' = 'Related Party ID (PARTY_ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `reversal_of_journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Journal Entry ID (REV_JE_ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (BATCH_ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `accounting_date` SET TAGS ('dbx_business_glossary_term' = 'Accounting Date (ACC_DATE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code (ADJ_REASON_CODE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = 'error_correction|policy_change|revaluation|other');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (COST_CENTER)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code (DEPT_CODE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Number (JE_NUM)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Type (JE_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'payment|settlement|manual|intercompany|recurring');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate (EXCH_RATE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date (EXCH_RATE_DATE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Flag (IS_INTERCOMPANY)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `is_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Indicator (IS_ADJUSTMENT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Description (JE_DESC)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `journal_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Status (JE_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `journal_entry_status` SET TAGS ('dbx_value_regex' = 'draft|open|posted|reversed|cancelled');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `ledger_code` SET TAGS ('dbx_business_glossary_term' = 'Ledger Code (LEDGER_CODE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (NET_AMT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Financial Period (FIN_PERIOD)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp (POSTED_TS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag (IS_REVERSAL)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code (SEGMENT_CODE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `source_module` SET TAGS ('dbx_business_glossary_term' = 'Source Module (SRC_MODULE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `source_module` SET TAGS ('dbx_value_regex' = 'GL|AP|AR|FA');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'ERP|Gateway|Settlement|Dispute');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `sox_control_reference` SET TAGS ('dbx_business_glossary_term' = 'SOX Control Reference (SOX_CTRL_REF)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount (CREDIT_AMT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Amount (DEBIT_AMT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp (TXN_TS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `journal_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Line Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `journal_journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'correction|reversal|writeoff');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount (Functional Currency)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount (Functional Currency)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign‑Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `fx_rate_date` SET TAGS ('dbx_business_glossary_term' = 'FX Rate Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `fx_rate_source` SET TAGS ('dbx_business_glossary_term' = 'FX Rate Source');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `intercompany_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Entity Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `is_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Journal Line Description');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Journal Line Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|error');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `reconciliation_reference` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Reference');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Segment Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (Functional Currency)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `gl_balance_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Balance ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `ledger_config_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `ledger_ledger_config_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'posted|provisional|adjusted');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `balance_type` SET TAGS ('dbx_business_glossary_term' = 'Balance Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `balance_type` SET TAGS ('dbx_value_regex' = 'functional|reporting');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `last_reconciled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciled Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `period_credits` SET TAGS ('dbx_business_glossary_term' = 'Period Credits');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `period_debits` SET TAGS ('dbx_business_glossary_term' = 'Period Debits');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|pending');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `translated_balance` SET TAGS ('dbx_business_glossary_term' = 'Translated Balance');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `ledger_config_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Configuration ID (LEDGER_CONFIG_ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `accounting_calendar` SET TAGS ('dbx_business_glossary_term' = 'Accounting Calendar (CALENDAR)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status (AUDIT_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `audit_trail_enabled` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag (AUDIT_TRAIL_ENABLED)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Compliance Regulation (COMPLIANCE_REGULATION)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `currency_precision` SET TAGS ('dbx_business_glossary_term' = 'Currency Precision (CURRENCY_PRECISION)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_TO)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `fiscal_year_start_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Start Month (FISCAL_YEAR_START_MONTH)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `intercompany_settlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Settlement Flag (INTERCOMPANY_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `is_consolidation_ledger` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Ledger Flag (CONSOLIDATION_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `is_multi_currency` SET TAGS ('dbx_business_glossary_term' = 'Multi‑Currency Ledger Flag (MULTI_CURRENCY_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User (LAST_MODIFIED_BY)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `ledger_code` SET TAGS ('dbx_business_glossary_term' = 'Ledger Code (LEDGER_CODE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `ledger_config_description` SET TAGS ('dbx_business_glossary_term' = 'Ledger Description (LEDGER_DESC)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `ledger_config_status` SET TAGS ('dbx_business_glossary_term' = 'Ledger Status (LEDGER_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `ledger_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `ledger_name` SET TAGS ('dbx_business_glossary_term' = 'Ledger Name (LEDGER_NAME)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `ledger_owner` SET TAGS ('dbx_business_glossary_term' = 'Ledger Owner Department (LEDGER_OWNER)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `ledger_timezone` SET TAGS ('dbx_business_glossary_term' = 'Ledger Timezone (LEDGER_TIMEZONE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `ledger_type` SET TAGS ('dbx_business_glossary_term' = 'Ledger Type (LEDGER_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `ledger_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|reporting|auxiliary');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Type (PERIOD_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `posting_rule` SET TAGS ('dbx_business_glossary_term' = 'Posting Rule (POSTING_RULE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `posting_rule` SET TAGS ('dbx_value_regex' = 'accrual|cash|hybrid');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `primary_legal_entity` SET TAGS ('dbx_business_glossary_term' = 'Primary Legal Entity Identifier (LEGAL_ENTITY_ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `retained_earnings_account` SET TAGS ('dbx_business_glossary_term' = 'Retained Earnings Account (RETAINED_EARNINGS_ACCT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `subledger_method` SET TAGS ('dbx_business_glossary_term' = 'Subledger Accounting Method (SUBLEDGER_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `subledger_method` SET TAGS ('dbx_value_regex' = 'accounting|costing|none');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `tax_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Flag (TAX_REPORTING_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `translation_method` SET TAGS ('dbx_business_glossary_term' = 'Currency Translation Method (TRANSLATION_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `translation_method` SET TAGS ('dbx_value_regex' = 'average_rate|closing_rate|spot_rate|historical_rate');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Ledger Configuration Version Number (VERSION_NUMBER)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CREATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `subledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Entry ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID (BATCH_ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `accounting_date` SET TAGS ('dbx_business_glossary_term' = 'Accounting Date (ACC_DATE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason (ADJ_REASON)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail (AUDIT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag (COMP_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'aml|sanctions|none');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount (CR_AMT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount (DR_AMT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Subledger Entry Number (SEQ)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp (EVENT_TIME)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Subledger Event Type (EVENT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'authorization|capture|settlement|refund|chargeback|fee');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate (EXCH_RATE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Code (GL_ACCT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `gl_derivation_rule` SET TAGS ('dbx_business_glossary_term' = 'GL Derivation Rule (GL_RULE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `is_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Is Adjustment Flag (IS_ADJ)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `is_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Flag (RECONCILED)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Amount (ORIG_AMT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `original_currency` SET TAGS ('dbx_business_glossary_term' = 'Original Currency (ORIG_CUR)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `original_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `payment_instrument_token` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument Token (TOKEN)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `payment_instrument_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `payment_instrument_token` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status (POST_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'pending|posted|rejected');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity (QTY)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date (RECON_DATE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `source_module` SET TAGS ('dbx_business_glossary_term' = 'Source Module (SRC_MOD)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `revenue_recognition_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `audit_trail_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `primary_revenue_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `primary_revenue_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `primary_revenue_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = 'FYd{4}|Q[1-4]d{4}');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `business_identifier` SET TAGS ('dbx_business_glossary_term' = 'Revenue Schedule Business Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Classification or Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_value_regex' = 'subscription|transaction_fee|bnpl_fee|saas|licensing');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `frequency_interval` SET TAGS ('dbx_business_glossary_term' = 'Frequency Interval');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `is_partial_recognition_allowed` SET TAGS ('dbx_business_glossary_term' = 'Partial Recognition Allowed');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `is_prorated` SET TAGS ('dbx_business_glossary_term' = 'Is Prorated');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Schedule Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|completed|cancelled');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `recognition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition End Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `recognition_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recognition Frequency');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `recognition_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|once');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Recognition Method');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `recognition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition Start Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `recognized_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized To Date Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `total_transaction_price` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Price');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Journal Entry ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `revenue_line_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Line ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `reversal_event_revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Event ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^d{4}Q[1-4]$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_value_regex' = 'error_correction|policy_change|other');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'unapproved|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `audit_comment` SET TAGS ('dbx_business_glossary_term' = 'Audit Comment');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'none|audit_required|review_needed');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `cumulative_recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Recognized Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `is_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Is Adjustment');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `is_foreign_currency` SET TAGS ('dbx_business_glossary_term' = 'Is Foreign Currency');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `is_manual_entry` SET TAGS ('dbx_business_glossary_term' = 'Is Manual Entry');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `posted_date` SET TAGS ('dbx_business_glossary_term' = 'Posted Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Recognition Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `recognition_status` SET TAGS ('dbx_value_regex' = 'pending|recognized|reversed|adjusted');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `recognition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recognition Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `recognition_trigger` SET TAGS ('dbx_business_glossary_term' = 'Recognition Trigger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `recognition_trigger` SET TAGS ('dbx_value_regex' = 'time_based|milestone|usage');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `regulatory_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `remaining_deferred_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Deferred Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = 'VAT|GST|NONE');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Legal Entity ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `receiving_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Legal Entity ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Related Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `amount_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Transaction Adjustment Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Approval Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|under_review');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Elimination Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `intercompany_account_pair` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Account Pair');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|posted|settled|cancelled');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `netting_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Netting Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'ERP|Gateway|TPP|DW');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'loan|service_charge|royalty|cost_allocation|settlement');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `period_close_task_id` SET TAGS ('dbx_business_glossary_term' = 'Period Close Task ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `dependent_task_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Task Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort (Hours)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `blocking_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocking Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Task Completion Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `compliance_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Task Due Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort (Hours)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Task Indicator');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Owner Role (e.g., Accountant, Controller, Manager, Analyst)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `owner_role` SET TAGS ('dbx_value_regex' = 'accountant|controller|manager|analyst');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `period_close_task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status (e.g., Not Started, In Progress, Completed, Blocked, Deferred)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `period_close_task_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|blocked|deferred');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Task Priority (e.g., Low, Medium, High, Critical)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Status (e.g., Pending, Approved, Rejected, Escalated)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (e.g., Low, Medium, High, Critical)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `sign_off_reference` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Reference');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Task Name');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `task_sequence` SET TAGS ('dbx_business_glossary_term' = 'Task Sequence Order');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type (e.g., Reconciliation, Accrual, Allocation, Consolidation, Reporting)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'reconciliation|accrual|allocation|consolidation|reporting');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `account_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Account Reconciliation ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'GL Account ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `account_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `account_reconciliation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|closed|rejected');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `adjusted_balance` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Balance');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `closed_reconciling_items_count` SET TAGS ('dbx_business_glossary_term' = 'Closed Reconciling Items Count');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'SOX|PCI_DSS|GDPR|CCPA|FATF');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to Functional Currency');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `gl_balance_book` SET TAGS ('dbx_business_glossary_term' = 'GL Balance (Book)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `is_auto_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Is Auto‑Reconciled');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated Account');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `last_reconciled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciled Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `open_reconciling_items_count` SET TAGS ('dbx_business_glossary_term' = 'Open Reconciling Items Count');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `reconciliation_cycle` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Cycle');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `reconciliation_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|ad_hoc');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Method');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_value_regex' = 'manual|automated|rule_based|ml_assisted');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `reconciling_items_total` SET TAGS ('dbx_business_glossary_term' = 'Total Reconciling Items Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By User ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Sign‑Off Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `total_reconciling_items_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Reconciling Items Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `accrual_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Entry ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `accrual_basis` SET TAGS ('dbx_business_glossary_term' = 'Accrual Basis');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `accrual_basis` SET TAGS ('dbx_value_regex' = 'accrual|cash|adjustment');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `accrual_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Accrual Description');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `accrual_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Entry Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `accrual_entry_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|cancelled');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `accrual_number` SET TAGS ('dbx_business_glossary_term' = 'Accrual Entry Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `accrual_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period End Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `accrual_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `accrual_type` SET TAGS ('dbx_business_glossary_term' = 'Accrual Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `accrual_type` SET TAGS ('dbx_value_regex' = 'expense|revenue|interchange|scheme_fee|settlement_float');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Adjustment Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Accrual Calculation Methodology');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Accrual Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Accrual Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Accrual Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Accrual Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Accrual Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Posting Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Accrual Posting Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `reversal_journal_reference` SET TAGS ('dbx_business_glossary_term' = 'Reversal Journal Reference');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `reversal_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Period End Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `reversal_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'tpp|gateway|erp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Accrual Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `expense_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Expense Allocation Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_journal_journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Journal Entry Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Journal Entry Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Source Cost Center Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `target_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Center Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'headcount|tpv|revenue|fixed_percentage');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_basis_value` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Value');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_journal_reference` SET TAGS ('dbx_business_glossary_term' = 'Allocation Journal Reference');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'automatic|manual');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_note` SET TAGS ('dbx_business_glossary_term' = 'Allocation Note');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period End Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Reference Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Name');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_rule_version` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Version');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'pending|applied|reversed|error');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Execution Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'SOX|PCI_DSS|GDPR|CCPA|FATF|AML');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Allocation Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `target_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Allocation Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `total_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Allocation Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `transfer_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`expense_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation (ACC_DEP)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost (COST)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date (DATE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category (CAT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_value_regex' = 'hardware|software|infrastructure|license');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description (DESC)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name (NAME)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `asset_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Serial Number (SERIAL)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag (TAG)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type (TYPE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (CC)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `custodian` SET TAGS ('dbx_business_glossary_term' = 'Asset Custodian (CUSTODIAN)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date (END_DATE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `depreciation_expense_current_period` SET TAGS ('dbx_business_glossary_term' = 'Current Period Depreciation Expense (DEP_EXP_CUR)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method (METHOD)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|units_of_production|sum_of_years');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `depreciation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate Percent (DEP_RATE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date (START_DATE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date (DISPOSAL_DATE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method (DISPOSAL_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sale|scrap|donation|recycle|return_to_vendor');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `disposal_status` SET TAGS ('dbx_business_glossary_term' = 'Disposal Status (DISPOSAL_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `disposal_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `fixed_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `fixed_asset_status` SET TAGS ('dbx_value_regex' = 'in_service|maintenance|retired|disposed|pending');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount (INS_AMT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number (INS_POL)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `insurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Insurance Provider (INS_PROV)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date (LAST_MAINT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Asset Physical Location (LOC)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `maintenance_cost` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cost (MAINT_COST)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `maintenance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule (MAINT_SCH)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `maintenance_schedule` SET TAGS ('dbx_value_regex' = 'quarterly|annual|semi_annual|monthly');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer (MFG)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number (MODEL)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department (DEPT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value (SALVAGE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (YEARS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date (WARRANTY_EXP)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `depreciation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `accumulated_depreciation_to_date` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation To Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `beginning_net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Beginning Net Book Value');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `depreciation_basis` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Basis');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `depreciation_basis` SET TAGS ('dbx_value_regex' = 'cost|revaluation|fair_value');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `depreciation_comment` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Comment');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `depreciation_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Expense Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|sum_of_years_digits|units_of_production|macrs');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `depreciation_rate` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `depreciation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Sequence');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `depreciation_status` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `depreciation_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|adjusted');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `ending_net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Ending Net Book Value');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = 'FY|Q1|Q2|Q3|Q4');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Period End Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `period_label` SET TAGS ('dbx_business_glossary_term' = 'Period Label');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `payable_id` SET TAGS ('dbx_business_glossary_term' = 'Payable ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (Employee ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `discount_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Expense Category');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Amount (Gross)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Payable Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `is_early_payment_discount_applied` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Applied Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Recurring Payable Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `is_tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `original_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `payable_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `payable_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `payable_status` SET TAGS ('dbx_value_regex' = 'draft|approved|paid|rejected|cancelled');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|Wire|Check|Card|Internal');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partial|paid|failed|reversed');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `scheme_invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Scheme Invoice Reference');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Receivable ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1-30|31-60|61-90|90_plus');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `audit_trail_enabled` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'uncollected|partial|collected|written_off');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `currency_exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `interchange_income` SET TAGS ('dbx_business_glossary_term' = 'Interchange Income');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Amount (Gross)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|issued|sent|paid|cancelled|void');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `mdr_fee` SET TAGS ('dbx_business_glossary_term' = 'Merchant Discount Rate (MDR) Fee');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|pos|api');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'card|bank_transfer|ach|digital_wallet|cash');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `payment_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|due_on_receipt');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `platform_fee` SET TAGS ('dbx_business_glossary_term' = 'Platform Service Fee');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `receivable_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Business Segment Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `sox_control_classification` SET TAGS ('dbx_business_glossary_term' = 'SOX Control Classification');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `sox_control_classification` SET TAGS ('dbx_value_regex' = 'critical|significant|non_critical');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'headcount|revenue|expense|fixed');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'operational|capital|project|marketing|R&D');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|closed');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'original|revised|forecast');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `currency_exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `currency_exchange_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `forecast_method` SET TAGS ('dbx_business_glossary_term' = 'Forecast Method');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `forecast_method` SET TAGS ('dbx_value_regex' = 'historical|trend|machine_learning');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By Employee ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `variance_method` SET TAGS ('dbx_business_glossary_term' = 'Variance Method');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `variance_method` SET TAGS ('dbx_value_regex' = 'none|fixed|percentage');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` SET TAGS ('dbx_subdomain' = 'compliance_controls');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'SOX Control ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Assessment Result');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_assessment_result` SET TAGS ('dbx_value_regex' = 'pass|fail|partial');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_audit_trail_enabled` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_code` SET TAGS ('dbx_business_glossary_term' = 'Control Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_comments` SET TAGS ('dbx_business_glossary_term' = 'Control Comments');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Control Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_data_classification` SET TAGS ('dbx_business_glossary_term' = 'Control Data Classification');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Control Document Reference');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|ineffective|needs_improvement');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Frequency');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Control Last Modified By');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Control Name');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_objective` SET TAGS ('dbx_business_glossary_term' = 'Control Objective');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Department');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_performer` SET TAGS ('dbx_business_glossary_term' = 'Control Performer');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_testing_method` SET TAGS ('dbx_business_glossary_term' = 'Testing Method');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|directive');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `control_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Control Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `deficiency_classification` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Classification');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `deficiency_classification` SET TAGS ('dbx_value_regex' = 'significant_deficiency|material_weakness|none');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `evidence_requirements` SET TAGS ('dbx_business_glossary_term' = 'Evidence Requirements');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `process_owner` SET TAGS ('dbx_business_glossary_term' = 'Process Owner');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|deferred');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `sox_control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `sox_control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|exception|not_tested');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `testing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Testing Frequency');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control` ALTER COLUMN `testing_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` SET TAGS ('dbx_subdomain' = 'compliance_controls');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `sox_control_test_id` SET TAGS ('dbx_business_glossary_term' = 'SOX Control Test ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'SOX404|SOX302|PCI_DSS|GDPR|FISMA|HIPAA');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `control_category` SET TAGS ('dbx_business_glossary_term' = 'Control Category');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `control_category` SET TAGS ('dbx_value_regex' = 'financial_reporting|it_general|operational|compliance|security|other');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `control_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Frequency');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `control_frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|weekly|daily|ad_hoc');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Control Name');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `control_owner` SET TAGS ('dbx_business_glossary_term' = 'Control Owner');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `control_owner` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `control_owner` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `control_reference` SET TAGS ('dbx_business_glossary_term' = 'Control Reference');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `deficiency_details` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Details');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `evidence_documentation` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documentation');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `exceptions_identified` SET TAGS ('dbx_business_glossary_term' = 'Exceptions Identified');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `remediation_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Taken');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `test_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Test Conclusion');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `test_conclusion` SET TAGS ('dbx_value_regex' = 'effective|ineffective');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `test_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Minutes)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `test_methodology` SET TAGS ('dbx_business_glossary_term' = 'Test Methodology');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `test_methodology` SET TAGS ('dbx_value_regex' = 'inquiry|observation|inspection|reperformance');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `test_period_end` SET TAGS ('dbx_business_glossary_term' = 'Test Period End Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `test_period_start` SET TAGS ('dbx_business_glossary_term' = 'Test Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `test_time` SET TAGS ('dbx_business_glossary_term' = 'Test Time');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `tester_name` SET TAGS ('dbx_business_glossary_term' = 'Tester Name');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `tester_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `tester_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `tester_type` SET TAGS ('dbx_business_glossary_term' = 'Tester Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `tester_type` SET TAGS ('dbx_value_regex' = 'internal_audit|external_auditor');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`sox_control_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `fx_revaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Foreign Currency Revaluation ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period (YYYYMM)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `is_manual_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Manual Adjustment Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Notes');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `original_balance` SET TAGS ('dbx_business_glossary_term' = 'Original Balance Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `revaluation_number` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Reference Number (RRN)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `revaluation_rate` SET TAGS ('dbx_business_glossary_term' = 'FX Revaluation Rate');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `revaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `revaluation_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|error');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `revaluation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `revalued_balance` SET TAGS ('dbx_business_glossary_term' = 'Revalued Balance Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'ERP|GL|DW');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `unrealized_gain_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain/Loss Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `unrealized_gain_loss_type` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain/Loss Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `unrealized_gain_loss_type` SET TAGS ('dbx_value_regex' = 'gain|loss');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `consolidation_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `audit_trail_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidated GL Account ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `consolidation_group_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'reversal|correction|reclassification');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `consolidation_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Description');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `consolidation_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `consolidation_entry_status` SET TAGS ('dbx_value_regex' = 'draft|pending|posted|reversed|rejected');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `consolidation_period` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Period');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `consolidation_period` SET TAGS ('dbx_value_regex' = '^d{4}-Q[1-4]$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `elimination_amount` SET TAGS ('dbx_business_glossary_term' = 'Elimination Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'intercompany_elimination|minority_interest|goodwill_amortization|currency_translation|adjustment');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `is_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Is Adjustment Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Entry Notes');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `period` SET TAGS ('dbx_value_regex' = '^d{4}-d{2}$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `source_legal_entity_ids` SET TAGS ('dbx_business_glossary_term' = 'Source Legal Entity IDs');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `sox_control_reference` SET TAGS ('dbx_business_glossary_term' = 'SOX Control Reference');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `tax_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Identifier (TPID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Journal Entry Identifier (TPJEID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (AT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User (ABU)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Calculation Method (TCM)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'ASC_740|IAS_12|other');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `current_tax_expense` SET TAGS ('dbx_business_glossary_term' = 'Current Tax Expense (CTE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name (SSN)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `deferred_tax_asset` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Asset (DTA)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `deferred_tax_liability` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Liability (DTL)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `effective_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Effective Tax Rate (ETR)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `exchange_rate_to_reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to Reporting Currency (ERRC)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Code (FPC)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (Notes)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `pre_tax_income` SET TAGS ('dbx_business_glossary_term' = 'Pre-Tax Income (PTI)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `tax_account_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Code (TAC)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code (TJC)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `tax_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Period End Date (TPED)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `tax_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Period Start Date (TPSD)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `tax_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Status (TPS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `tax_status` SET TAGS ('dbx_value_regex' = 'pending|finalized|adjusted|reversed');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type (TT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'income|sales|property|other');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `uncertain_tax_position_reserve` SET TAGS ('dbx_business_glossary_term' = 'Uncertain Tax Position Reserve (UTPR)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `financial_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `consolidation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Legal Entity Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `primary_financial_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `primary_financial_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `primary_financial_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `cash_flow_from_financing` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow from Financing');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `cash_flow_from_investing` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow from Investing');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `cash_flow_from_operations` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow from Operations');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Statement Currency Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `equity` SET TAGS ('dbx_business_glossary_term' = 'Equity');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `expense` SET TAGS ('dbx_business_glossary_term' = 'Expense');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `external_audit_signoff` SET TAGS ('dbx_business_glossary_term' = 'External Audit Sign‑off Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Statement Indicator');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `net_income` SET TAGS ('dbx_business_glossary_term' = 'Net Income');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Statement Notes');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `preparation_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Preparation Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `preparation_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|finalized|archived');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `reporting_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Reporting Legal Entity Name');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Reporting Standard');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_value_regex' = 'GAAP|IFRS');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `restatement_flag` SET TAGS ('dbx_business_glossary_term' = 'Restatement Indicator');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `revenue` SET TAGS ('dbx_business_glossary_term' = 'Revenue');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Review Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_value_regex' = 'income_statement|balance_sheet|cash_flow|statement_of_equity');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `total_assets` SET TAGS ('dbx_business_glossary_term' = 'Total Assets');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `total_liabilities` SET TAGS ('dbx_business_glossary_term' = 'Total Liabilities');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Statement Version Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `allocation_basis_metric` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Metric');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `allocation_basis_metric` SET TAGS ('dbx_value_regex' = 'headcount|transaction_volume|revenue|employee_count|custom_metric');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `allocation_fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Fixed Amount');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'fixed_percentage|headcount|tpv_weighted|statistical|custom');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `allocation_metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Allocation Metric Unit');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `allocation_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `allocation_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Description');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `allocation_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Name');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `allocation_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `allocation_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `allocation_rule_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `allocation_rule_type` SET TAGS ('dbx_value_regex' = 'cost_center|legal_entity|business_unit|project');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `effective_time_zone` SET TAGS ('dbx_business_glossary_term' = 'Effective Time Zone');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `is_system_defined` SET TAGS ('dbx_business_glossary_term' = 'System Defined Flag');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `last_applied_by` SET TAGS ('dbx_business_glossary_term' = 'Last Applied By');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `last_applied_date` SET TAGS ('dbx_business_glossary_term' = 'Last Applied Date');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Priority');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `rule_condition` SET TAGS ('dbx_business_glossary_term' = 'Rule Condition Expression');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `rule_owner` SET TAGS ('dbx_business_glossary_term' = 'Rule Owner');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `rule_scope` SET TAGS ('dbx_business_glossary_term' = 'Rule Scope');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `rule_scope` SET TAGS ('dbx_value_regex' = 'global|entity|cost_center|project');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`allocation_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` SET TAGS ('dbx_subdomain' = 'compliance_controls');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ALTER COLUMN `audit_trail_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ALTER COLUMN `device_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ALTER COLUMN `user_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ALTER COLUMN `user_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ALTER COLUMN `user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ALTER COLUMN `user_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_group` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_group` ALTER COLUMN `consolidation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_group` ALTER COLUMN `currency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_group` ALTER COLUMN `parent_consolidation_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_group` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_group` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` SET TAGS ('dbx_subdomain' = 'compliance_controls');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `related_party_id` SET TAGS ('dbx_business_glossary_term' = 'Related Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `ultimate_parent_related_party_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`related_party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` SET TAGS ('dbx_subdomain' = 'compliance_controls');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `parent_vendor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `vat_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`vendor` ALTER COLUMN `vat_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_line` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_line` ALTER COLUMN `revenue_line_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Line Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_line` ALTER COLUMN `currency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_line` ALTER COLUMN `parent_revenue_line_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`contract` SET TAGS ('dbx_subdomain' = 'compliance_controls');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`contract` ALTER COLUMN `master_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`performance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`performance_obligation` SET TAGS ('dbx_subdomain' = 'compliance_controls');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`performance_obligation` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`performance_obligation` ALTER COLUMN `parent_performance_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_session` SET TAGS ('dbx_subdomain' = 'compliance_controls');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_session` ALTER COLUMN `audit_session_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Session Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_session` ALTER COLUMN `parent_audit_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_session` ALTER COLUMN `device_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_session` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_session` ALTER COLUMN `user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_session` ALTER COLUMN `user_name` SET TAGS ('dbx_pii_name' = 'true');
