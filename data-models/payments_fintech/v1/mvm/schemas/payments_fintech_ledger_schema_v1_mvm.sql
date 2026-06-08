-- Schema for Domain: ledger | Business: Payments Fintech | Version: v1_mvm
-- Generated on: 2026-05-03 21:29:50

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`ledger` COMMENT 'General ledger and financial accounting including GL account management, journal entries, revenue recognition, expense allocation, intercompany settlements, financial period close, and SOX-compliant financial controls. Manages chart of accounts, cost centers, and financial reporting structures.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique surrogate key for the GL account record.',
    `config_id` BIGINT COMMENT 'Foreign key linking to ledger.ledger_config. Business justification: The chart of accounts is defined per ledger configuration. Each GL account belongs to a specific ledger (primary, secondary, reporting). Linking gl_account to ledger_config enables proper account vali',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: In a multi-entity payments fintech, GL accounts in the chart of accounts are often entity-specific, particularly intercompany accounts (gl_account.is_intercompany = true). Linking gl_account to legal_',
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
    `config_id` BIGINT COMMENT 'Foreign key linking to ledger.ledger_config. Business justification: Cost centers operate within a specific ledger configuration (primary, secondary, or reporting ledger). Linking cost_center to ledger_config enables proper GL posting rules and currency precision to be',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Every cost center belongs to a specific legal entity for financial reporting, intercompany settlement, and regulatory compliance. In a multi-entity payments fintech, cost centers must be attributed to',
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
    `risk_level` STRING COMMENT 'Risk classification for the cost center based on financial exposure.. Valid values are `low|medium|high`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the cost center record.',
    `created_by` STRING COMMENT 'User or system identifier that created the cost center record.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Organizational cost center master record representing a financial responsibility unit within the payments fintech enterprise. Captures cost center code, name, owning business unit, division, department, manager, active status, budget period, currency, and allocation basis. Used for expense allocation, P&L reporting by business unit, and management accounting. Aligns with Oracle Financials cost center segment in the accounting flexfield.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'System-generated unique identifier for the legal entity record.',
    `parent_entity_legal_entity_id` BIGINT COMMENT 'Identifier of the immediate parent legal entity, if any.',
    `primary_ultimate_parent_legal_entity_id` BIGINT COMMENT 'Identifier of the top‑most parent in the corporate hierarchy.',
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
    `config_id` BIGINT COMMENT 'Reference to the ledger to which this accounting period belongs.',
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
    `config_id` BIGINT COMMENT 'Foreign key linking to ledger.ledger_config. Business justification: journal_entry has ledger_code (STRING) referencing the ledger it was posted to. Normalizing this to ledger_config_id FK enables proper ledger validation, posting rule enforcement, and multi-ledger acc',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Journal entries are posted to a specific legal entitys books. In a multi-entity payments fintech spanning 200+ countries, every journal entry must be attributed to the correct legal entity for statut',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Required for FX gain/loss reconciliation report linking each journal entry to the exact FX rate used in the conversion.',
    `reversal_of_journal_entry_id` BIGINT COMMENT 'Identifier of the original journal entry that this entry reverses, if applicable.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: journal_line has cost_center_code (STRING) for cost allocation. Normalizing to cost_center_id FK enables proper cost center validation, hierarchical rollup, and budget vs. actual reporting. The cost_c',
    `gl_account_id` BIGINT COMMENT 'FK to ledger.gl_account',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: journal_line has legal_entity_code (STRING) for entity attribution at the line level. Normalizing to legal_entity_id FK enables proper entity validation and supports intercompany journal line processi',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the parent journal entry to which this line belongs.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Needed for detailed audit of each journal line recording foreign exchange amounts, supporting regulatory FX reporting.',
    `adjustment_type` STRING COMMENT 'Categorization of the adjustment line (e.g., correction, reversal, write‑off).. Valid values are `correction|reversal|writeoff`',
    `business_unit_code` STRING COMMENT 'Identifier of the business unit owning the transaction for internal reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the journal line was initially created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Monetary amount credited on this line, expressed in the functional currency of the entity.',
    `debit_amount` DECIMAL(18,2) COMMENT 'Monetary amount debited on this line, expressed in the functional currency of the entity.',
    `functional_currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the functional currency used for accounting.. Valid values are `^[A-Z]{3}$`',
    `fx_rate` DECIMAL(18,2) COMMENT 'Rate used to convert the transaction amount from transaction currency to functional currency for this line.',
    `fx_rate_date` DATE COMMENT 'Calendar date of the foreign‑exchange rate used for conversion.',
    `fx_rate_source` STRING COMMENT 'Name of the provider or system that supplied the foreign‑exchange rate.',
    `intercompany_entity_code` STRING COMMENT 'Identifier of the related inter‑company entity for intercompany journal entries.',
    `is_adjustment` BOOLEAN COMMENT 'True if the line represents an adjustment (correction, reversal, write‑off) rather than a regular transaction.',
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
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: gl_balance has fiscal_period (INT) and fiscal_year (INT) but no accounting_period_id FK. GL balances are computed per accounting period. Linking to accounting_period enables period-end close validatio',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center associated with the balance for internal reporting.',
    `gl_account_id` BIGINT COMMENT 'Unique identifier of the GL account for which the balance is recorded.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: GL balances are entity-specific in a multi-entity payments fintech. Each balance record must be attributed to a legal entity for consolidated financial reporting, intercompany elimination, and statuto',
    `config_id` BIGINT COMMENT 'Identifier of the ledger (e.g., primary ledger, sub‑ledger) to which the balance belongs.',
    `balance_status` STRING COMMENT 'Lifecycle state of the balance (e.g., posted after close, provisional during interim).. Valid values are `posted|provisional|adjusted`',
    `balance_type` STRING COMMENT 'Indicates whether the balance is in functional currency or reporting currency.. Valid values are `functional|reporting`',
    `closing_balance` DECIMAL(18,2) COMMENT 'Balance after applying period debits and credits; used for financial statements.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate applied to convert functional currency balance to reporting currency.',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`config` (
    `config_id` BIGINT COMMENT 'Unique surrogate key for the ledger configuration record.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: ledger_config has primary_legal_entity (STRING) referencing the legal entity that owns this ledger configuration. Normalizing to legal_entity_id FK enables proper entity validation, supports multi-ent',
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
    `reporting_currency` STRING COMMENT 'Currency used for external reporting from this ledger.',
    `retained_earnings_account` STRING COMMENT 'Account code where retained earnings are posted.',
    `subledger_method` STRING COMMENT 'Method used for subledger accounting.. Valid values are `accounting|costing|none`',
    `tax_reporting_flag` BOOLEAN COMMENT 'Indicates if the ledger is used for tax reporting purposes.',
    `translation_method` STRING COMMENT 'Method applied to translate foreign currency balances.. Valid values are `average_rate|closing_rate|spot_rate|historical_rate`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ledger configuration.',
    `version_number` STRING COMMENT 'Version of the ledger configuration for change management.',
    `created_by` STRING COMMENT 'User identifier who created the ledger configuration.',
    CONSTRAINT pk_config PRIMARY KEY(`config_id`)
) COMMENT 'Ledger configuration master defining each accounting ledger (primary, secondary, reporting) within Oracle Financials. Captures ledger name, ledger type, chart of accounts, accounting calendar, functional currency, subledger accounting method, consolidation ledger flag, reporting currency, translation method, and retained earnings account. A payments fintech enterprise typically maintains multiple ledgers for different legal entities and regulatory reporting jurisdictions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` (
    `subledger_entry_id` BIGINT COMMENT 'Unique surrogate key for the subledger entry record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Subledger entries are posted within specific accounting periods. Linking subledger_entry to accounting_period enables period-end close validation, ensures subledger entries are posted to open periods,',
    `capture_id` BIGINT COMMENT 'Foreign key linking to transaction.capture. Business justification: Capture events trigger subledger postings for settlement receivables and interchange income. Direct link from subledger_entry to capture enables capture-level subledger reconciliation — a named operat',
    `cardholder_account_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_account. Business justification: Subledger entries in card accounting are posted against specific cardholder accounts (not just profiles) for account-level balance reconciliation, statement generation, and credit limit utilization tr',
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: Subledger entries track transactional counterparties for AML screening, sanctions checks, audit trail requirements, and party-level risk aggregation in payments fintech transaction processing and comp',
    `fx_conversion_id` BIGINT COMMENT 'Foreign key linking to transaction.fx_conversion. Business justification: FX conversion events generate subledger entries for realized/unrealized FX gains and losses. Payments fintech multi-currency operations require direct traceability from FX subledger postings to conver',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: subledger_entry has gl_account_code (STRING) referencing the GL account for posting. Normalizing to gl_account_id FK enables proper GL account validation, account type enforcement, and subledger-to-GL',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Subledger entries are summarized and transferred to the general ledger via journal entries. Linking subledger_entry to journal_entry enables subledger-to-GL reconciliation, audit trail tracing from op',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the transaction.',
    `payment_txn_id` BIGINT COMMENT 'Foreign key linking to transaction.payment_txn. Business justification: Subledger entries are atomic GL postings for individual payment events. Payments fintech subledger reconciliation operates at payment_txn level (MDR income, interchange posting, settlement entries). D',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder involved in the transaction.',
    `refund_id` BIGINT COMMENT 'Foreign key linking to transaction.refund. Business justification: Refunds generate distinct subledger entries (debit revenue, credit refund payable) that must be traceable to the originating refund event. Payments fintech subledger reconciliation teams require this ',
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
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: revenue_recognition_schedule has accounting_period (STRING) referencing the period for recognition. Normalizing to accounting_period_id FK enables proper period validation, period-end close integratio',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant. Business justification: Revenue recognition schedules for merchant acquiring contracts (multi-year agreements, deferred setup fees) must reference the merchant for ASC 606/IFRS 15 compliance reporting. Enables merchant-level',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: IFRS 15 revenue recognition requires tracking which payment product generated deferred revenue. Revenue schedules must link to products for contract liability reporting, performance obligation trackin',
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
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: revenue_recognition_event has accounting_period (STRING) referencing the period in which revenue was recognized. Normalizing to accounting_period_id FK enables period-level revenue reporting, period-e',
    `capture_id` BIGINT COMMENT 'Foreign key linking to transaction.capture. Business justification: Capture is the primary revenue recognition trigger in card payments under ASC 606 (performance obligation satisfied at capture). Direct link from revenue_recognition_event to capture enables capture-t',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the GL journal entry created for this revenue recognition.',
    `payment_txn_id` BIGINT COMMENT 'Foreign key linking to transaction.payment_txn. Business justification: Revenue recognition events are triggered by payment milestones. Direct link to payment_txn enables payment-level recognition audit trail for ASC 606/IFRS 15 compliance reporting, eliminating the join ',
    `revenue_recognition_schedule_id` BIGINT COMMENT 'Identifier of the revenue schedule to which this recognition event belongs.',
    `reversal_event_revenue_recognition_event_id` BIGINT COMMENT 'If this event reverses a prior recognition, reference to that event.',
    `transaction_id` BIGINT COMMENT 'Identifier of the underlying payment transaction linked to this revenue event.',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` (
    `account_reconciliation_id` BIGINT COMMENT 'System-generated unique identifier for the account reconciliation record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Account reconciliation records are generated per accounting period; FK provides direct period context.',
    `config_id` BIGINT COMMENT 'Foreign key linking to ledger.ledger_config. Business justification: Account reconciliations are performed within a specific ledger configuration. Linking account_reconciliation to ledger_config enables reconciliation scoping by ledger type (primary vs. secondary), sup',
    `gl_account_id` BIGINT COMMENT 'Identifier of the General Ledger account being reconciled.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Account reconciliations are entity-specific in a multi-entity payments fintech. Each reconciliation must be attributed to a legal entity for statutory reporting, audit purposes, and SOX compliance. No',
    `transaction_batch_id` BIGINT COMMENT 'Foreign key linking to transaction.transaction_batch. Business justification: GL account reconciliation in payments fintech is performed against settlement batches — reconciling GL balances to batch settlement amounts. Direct link enables batch-level reconciliation workflow, a ',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`payable` (
    `payable_id` BIGINT COMMENT 'Unique system-generated identifier for the payable (invoice) record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Accounts payable invoices are recorded in specific accounting periods for accrual accounting. Linking payable to accounting_period enables period-end AP accrual reporting, aging analysis by period, an',
    `cost_center_id` BIGINT COMMENT 'Cost center that will bear the expense of the payable.',
    `gl_account_id` BIGINT COMMENT 'GL account to which the payable is posted for accounting.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Accounts payable invoices belong to a specific legal entity that owes the payment. In a multi-entity payments fintech, payables must be attributed to the correct legal entity for statutory reporting, ',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant. Business justification: Processors owe payables to merchants for settlement funds, chargeback reversals, and refund disbursements. Linking payables to merchants enables merchant-level AP aging reports, settlement dispute res',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Payables to partners (scheme fees, network assessments, revenue share payments) require direct partner attribution for AP processing, vendor management, and partner financial reconciliation. Core acco',
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: Payables reference vendor/supplier parties requiring KYC verification, sanctions screening before payment, and ongoing compliance monitoring for third-party risk management in payments fintech operati',
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
    CONSTRAINT pk_payable PRIMARY KEY(`payable_id`)
) COMMENT 'Accounts payable invoice record representing amounts owed by the payments fintech enterprise to vendors, card schemes, and service providers. Captures supplier reference, invoice number, invoice date, due date, payment terms, invoice amount, currency, tax amount, GL account distribution, cost center, approval status, payment status, and scheme invoice reference (for Visa/Mastercard scheme fee invoices). Managed in Oracle Financials AP module.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`receivable` (
    `receivable_id` BIGINT COMMENT 'Unique identifier for the receivable record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: receivable has fiscal_period (INT) and fiscal_year (INT) but no accounting_period_id FK. Accounts receivable invoices are recorded in specific accounting periods. Linking to accounting_period enables ',
    `cardholder_account_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_account. Business justification: Receivables in card issuing represent amounts owed by specific cardholder accounts. Linking enables AR aging by account, collections workflow triggering, IFRS 9 ECL provisioning at account level, and ',
    `cost_center_id` BIGINT COMMENT 'FK to ledger.cost_center',
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: Receivables reference customer/merchant parties requiring ongoing AML monitoring, compliance status tracking, and party-level risk assessment for revenue recognition and credit risk management in paym',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the partner associated with the invoice, if applicable.',
    `gl_account_id` BIGINT COMMENT 'FK to ledger.gl_account',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Accounts receivable invoices belong to a specific legal entity that is owed the payment. In a multi-entity payments fintech, receivables must be attributed to the correct legal entity for statutory re',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant billed.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Merchant invoices for MDR and interchange are product-specific. Accounts receivable aging reports and product revenue tracking require linking receivables to payment products for accurate revenue reco',
    `payment_txn_id` BIGINT COMMENT 'Foreign key linking to transaction.payment_txn. Business justification: Acquirer receivables (MDR fees, interchange income, platform fees) are generated from individual payment transactions. Payments fintech AR teams track receivables at payment_txn level for collection m',
    `transaction_batch_id` BIGINT COMMENT 'Foreign key linking to transaction.transaction_batch. Business justification: Scheme settlement receivables and batch-level interchange income are generated at transaction batch level. Payments fintech AR teams reconcile receivables against settlement batches for scheme invoici',
    `aging_bucket` STRING COMMENT 'Aging bucket based on days past due.. Valid values are `current|1-30|31-60|61-90|90_plus`',
    `audit_trail_enabled` BOOLEAN COMMENT 'Indicates if audit trail is enabled for this invoice.',
    `collection_status` STRING COMMENT 'Current collection status of the invoice.. Valid values are `uncollected|partial|collected|written_off`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was created.',
    `currency_exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied if invoice currency differs from functional currency.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the invoice is under dispute.',
    `due_date` DATE COMMENT 'Date by which payment is due.',
    `exchange_rate_date` DATE COMMENT 'Date of the exchange rate used.',
    `external_reference` STRING COMMENT 'External reference number from partner or third‑party system.',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` (
    `financial_statement_id` BIGINT COMMENT 'Unique identifier for the financial statement record. _canonical_skip_reason: role inferred as OTHER, no minimum categories required.',
    `config_id` BIGINT COMMENT 'Foreign key linking to ledger.ledger_config. Business justification: Financial statements are produced from a specific ledger configuration (primary ledger for statutory, reporting ledger for management accounts). Linking financial_statement to ledger_config enables tr',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity for which the statement is prepared.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_config_id` FOREIGN KEY (`config_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`config`(`config_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_parent_account_gl_account_id` FOREIGN KEY (`parent_account_gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ADD CONSTRAINT `fk_ledger_cost_center_config_id` FOREIGN KEY (`config_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`config`(`config_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ADD CONSTRAINT `fk_ledger_cost_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_parent_entity_legal_entity_id` FOREIGN KEY (`parent_entity_legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_primary_ultimate_parent_legal_entity_id` FOREIGN KEY (`primary_ultimate_parent_legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_config_id` FOREIGN KEY (`config_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`config`(`config_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_config_id` FOREIGN KEY (`config_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`config`(`config_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_reversal_of_journal_entry_id` FOREIGN KEY (`reversal_of_journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ADD CONSTRAINT `fk_ledger_journal_line_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ADD CONSTRAINT `fk_ledger_journal_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ADD CONSTRAINT `fk_ledger_journal_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ADD CONSTRAINT `fk_ledger_journal_line_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ADD CONSTRAINT `fk_ledger_journal_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ADD CONSTRAINT `fk_ledger_gl_balance_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ADD CONSTRAINT `fk_ledger_gl_balance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ADD CONSTRAINT `fk_ledger_gl_balance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ADD CONSTRAINT `fk_ledger_gl_balance_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ADD CONSTRAINT `fk_ledger_gl_balance_config_id` FOREIGN KEY (`config_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`config`(`config_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ADD CONSTRAINT `fk_ledger_config_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_ledger_revenue_recognition_schedule_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ADD CONSTRAINT `fk_ledger_revenue_recognition_event_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ADD CONSTRAINT `fk_ledger_revenue_recognition_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ADD CONSTRAINT `fk_ledger_revenue_recognition_event_revenue_recognition_schedule_id` FOREIGN KEY (`revenue_recognition_schedule_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule`(`revenue_recognition_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ADD CONSTRAINT `fk_ledger_revenue_recognition_event_reversal_event_revenue_recognition_event_id` FOREIGN KEY (`reversal_event_revenue_recognition_event_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ADD CONSTRAINT `fk_ledger_account_reconciliation_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ADD CONSTRAINT `fk_ledger_account_reconciliation_config_id` FOREIGN KEY (`config_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`config`(`config_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ADD CONSTRAINT `fk_ledger_account_reconciliation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ADD CONSTRAINT `fk_ledger_account_reconciliation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ADD CONSTRAINT `fk_ledger_payable_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ADD CONSTRAINT `fk_ledger_payable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ADD CONSTRAINT `fk_ledger_payable_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ADD CONSTRAINT `fk_ledger_payable_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ADD CONSTRAINT `fk_ledger_financial_statement_config_id` FOREIGN KEY (`config_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`config`(`config_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ADD CONSTRAINT `fk_ledger_financial_statement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`ledger` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `payments_fintech_ecm`.`ledger` SET TAGS ('dbx_domain' = 'ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `config_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `config_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`cost_center` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Legal Entity ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ALTER COLUMN `primary_ultimate_parent_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Legal Entity ID');
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
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Identifier (API_ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ALTER COLUMN `config_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Identifier (LEDGER_ID)');
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
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `config_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ALTER COLUMN `reversal_of_journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Journal Entry ID (REV_JE_ID)');
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
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'correction|reversal|writeoff');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
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
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `config_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Status');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'posted|provisional|adjusted');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `balance_type` SET TAGS ('dbx_business_glossary_term' = 'Balance Type');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `balance_type` SET TAGS ('dbx_value_regex' = 'functional|reporting');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
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
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `config_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Configuration ID (LEDGER_CONFIG_ID)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `accounting_calendar` SET TAGS ('dbx_business_glossary_term' = 'Accounting Calendar (CALENDAR)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status (AUDIT_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `audit_trail_enabled` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag (AUDIT_TRAIL_ENABLED)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Compliance Regulation (COMPLIANCE_REGULATION)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `currency_precision` SET TAGS ('dbx_business_glossary_term' = 'Currency Precision (CURRENCY_PRECISION)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_TO)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `fiscal_year_start_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Start Month (FISCAL_YEAR_START_MONTH)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `intercompany_settlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Settlement Flag (INTERCOMPANY_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `is_consolidation_ledger` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Ledger Flag (CONSOLIDATION_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `is_multi_currency` SET TAGS ('dbx_business_glossary_term' = 'Multi‑Currency Ledger Flag (MULTI_CURRENCY_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User (LAST_MODIFIED_BY)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `ledger_code` SET TAGS ('dbx_business_glossary_term' = 'Ledger Code (LEDGER_CODE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `ledger_config_description` SET TAGS ('dbx_business_glossary_term' = 'Ledger Description (LEDGER_DESC)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `ledger_config_status` SET TAGS ('dbx_business_glossary_term' = 'Ledger Status (LEDGER_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `ledger_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `ledger_name` SET TAGS ('dbx_business_glossary_term' = 'Ledger Name (LEDGER_NAME)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `ledger_owner` SET TAGS ('dbx_business_glossary_term' = 'Ledger Owner Department (LEDGER_OWNER)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `ledger_timezone` SET TAGS ('dbx_business_glossary_term' = 'Ledger Timezone (LEDGER_TIMEZONE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `ledger_type` SET TAGS ('dbx_business_glossary_term' = 'Ledger Type (LEDGER_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `ledger_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|reporting|auxiliary');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Type (PERIOD_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `posting_rule` SET TAGS ('dbx_business_glossary_term' = 'Posting Rule (POSTING_RULE)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `posting_rule` SET TAGS ('dbx_value_regex' = 'accrual|cash|hybrid');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `retained_earnings_account` SET TAGS ('dbx_business_glossary_term' = 'Retained Earnings Account (RETAINED_EARNINGS_ACCT)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `subledger_method` SET TAGS ('dbx_business_glossary_term' = 'Subledger Accounting Method (SUBLEDGER_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `subledger_method` SET TAGS ('dbx_value_regex' = 'accounting|costing|none');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `tax_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Flag (TAX_REPORTING_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `translation_method` SET TAGS ('dbx_business_glossary_term' = 'Currency Translation Method (TRANSLATION_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `translation_method` SET TAGS ('dbx_value_regex' = 'average_rate|closing_rate|spot_rate|historical_rate');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Ledger Configuration Version Number (VERSION_NUMBER)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`config` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CREATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `subledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Entry ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Party Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `fx_conversion_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Conversion Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Txn Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` SET TAGS ('dbx_subdomain' = 'revenue_management');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `revenue_recognition_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` SET TAGS ('dbx_subdomain' = 'revenue_management');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Journal Entry ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Txn Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `reversal_event_revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Event ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
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
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `account_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Account Reconciliation ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `config_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'GL Account ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Batch Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `payable_id` SET TAGS ('dbx_business_glossary_term' = 'Payable ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Party Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Receivable ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Party Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Txn Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Batch Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `financial_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement ID');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `config_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Legal Entity Identifier');
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
