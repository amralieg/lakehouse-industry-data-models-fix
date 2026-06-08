-- Schema for Domain: finance | Business: Staffing Hr | Version: v1_ecm
-- Generated on: 2026-05-02 15:53:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `staffing_hr_ecm`.`finance` COMMENT 'Owns all financial accounting, accounts receivable, accounts payable, general ledger, revenue recognition, and financial reporting data for the staffing enterprise';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the general ledger account. Primary key for the chart of accounts.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key reference to the legal entity that owns this GL account. Supports multi-entity accounting and consolidation for staffing enterprises operating multiple legal entities.',
    `parent_account_gl_account_id` BIGINT COMMENT 'Foreign key reference to the parent GL account in the chart of accounts hierarchy. Enables roll-up reporting and consolidation. Null for top-level accounts.',
    `parent_gl_account_id` BIGINT COMMENT 'Self-referencing FK on gl_account (parent_gl_account_id)',
    `accepts_postings` BOOLEAN COMMENT 'Boolean flag indicating whether this account can accept direct journal entry postings (True) or is restricted to rollup/consolidation only (False). Detail accounts accept postings; summary accounts typically do not.',
    `account_class` STRING COMMENT 'The sub-classification or category within the account type (e.g., Current Asset, Fixed Asset, Operating Expense, Cost of Goods Sold). Provides additional granularity for financial statement presentation and analysis.',
    `account_description` STRING COMMENT 'Extended textual description providing additional context, usage guidelines, and business purpose for this GL account. Used for training, documentation, and audit trail purposes.',
    `account_level` STRING COMMENT 'The depth level of this account in the chart of accounts hierarchy (e.g., 1 for top-level summary accounts, 2 for sub-accounts, 3 for detail accounts). Supports hierarchical rollup and drill-down reporting.',
    `account_name` STRING COMMENT 'The human-readable descriptive name of the GL account (e.g., Cash - Operating Account, Accounts Receivable - Trade, Payroll Tax Expense - FICA).',
    `account_number` STRING COMMENT 'The externally-known unique account number used to identify this GL account in financial transactions, journal entries, and reporting. Typically a 4-10 digit numeric code structured to reflect account hierarchy and classification.. Valid values are `^[0-9]{4,10}$`',
    `account_status` STRING COMMENT 'The current lifecycle status of the GL account. Active accounts accept postings; inactive accounts are temporarily disabled; suspended accounts are under review; closed accounts are permanently retired and no longer accept postings.. Valid values are `active|inactive|suspended|closed`',
    `account_type` STRING COMMENT 'The fundamental accounting classification of the account per the accounting equation: Asset, Liability, Equity, Revenue, or Expense. Determines placement on balance sheet or income statement.. Valid values are `asset|liability|equity|revenue|expense`',
    `audit_trail_required` BOOLEAN COMMENT 'Boolean flag indicating whether all transactions posted to this account require enhanced audit trail documentation and approval workflows. Typically True for high-risk accounts subject to SOX or internal control requirements.',
    `budget_account` BOOLEAN COMMENT 'Boolean flag indicating whether this account is included in the annual budgeting and forecasting process. Typically True for expense and revenue accounts; False for balance sheet accounts.',
    `cash_flow_classification` STRING COMMENT 'The cash flow statement category for this account: Operating Activities, Investing Activities, or Financing Activities. Used for automated cash flow statement preparation per GAAP ASC 230 or IFRS IAS 7.. Valid values are `operating|investing|financing`',
    `consolidation_account` STRING COMMENT 'The mapped consolidation account code or identifier used when rolling up financial results across multiple legal entities or business units for consolidated financial reporting.',
    `cost_center_applicable` BOOLEAN COMMENT 'Boolean flag indicating whether transactions posted to this account require a cost center assignment for departmental or divisional cost tracking and allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this GL account record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for this account (e.g., USD, CAD, GBP). Supports multi-currency accounting for international staffing operations.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'The default department or cost center code associated with this account for departmental expense allocation and management reporting. May be overridden at the journal entry level.',
    `effective_end_date` DATE COMMENT 'The date on which this GL account is retired or becomes inactive. Null for accounts with no planned end date. Supports temporal validity and historical chart of accounts tracking.',
    `effective_start_date` DATE COMMENT 'The date from which this GL account becomes active and available for use in journal entries and financial transactions. Supports temporal validity and chart of accounts versioning.',
    `external_reporting_code` STRING COMMENT 'The mapped account code or identifier used for external regulatory reporting to agencies such as the U.S. Department of Labor (DOL), Equal Employment Opportunity Commission (EEOC), or industry bodies like the American Staffing Association (ASA).',
    `gaap_classification` STRING COMMENT 'The specific GAAP financial statement line item classification for this account (e.g., Cash and Cash Equivalents, Accounts Receivable, Net, Accrued Payroll Liabilities). Used for GAAP-compliant financial statement preparation.',
    `ifrs_classification` STRING COMMENT 'The specific IFRS financial statement line item classification for this account. Used when the staffing enterprise operates internationally and must prepare IFRS-compliant financial statements.',
    `intercompany_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this account is used for intercompany transactions between legal entities within the staffing enterprise. Used for consolidation elimination entries.',
    `is_summary_account` BOOLEAN COMMENT 'Boolean flag indicating whether this is a summary/parent account used for rollup reporting (True) or a detail/leaf account that accepts direct postings (False). Summary accounts typically do not accept journal entries.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified this GL account record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this GL account record was last modified. Used for audit trail, change tracking, and data lineage.',
    `normal_balance` STRING COMMENT 'Indicates whether this account normally carries a debit or credit balance per double-entry bookkeeping conventions. Assets and expenses typically have debit balances; liabilities, equity, and revenue have credit balances.. Valid values are `debit|credit`',
    `reconciliation_frequency` STRING COMMENT 'The required frequency for reconciling this account (daily, weekly, monthly, quarterly, annually). Applicable only when reconciliation_required is True. Supports internal control compliance and audit readiness.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `reconciliation_required` BOOLEAN COMMENT 'Boolean flag indicating whether this account requires periodic reconciliation to external statements or subsidiary ledgers (e.g., bank reconciliation for cash accounts, AR sub-ledger reconciliation). Used for internal control and SOX compliance.',
    `statistical_account` BOOLEAN COMMENT 'Boolean flag indicating whether this is a statistical (non-monetary) account used to track operational metrics such as headcount, FTE (Full-Time Equivalent), placement count, or billable hours. Statistical accounts do not impact financial statements.',
    `tax_line_mapping` STRING COMMENT 'The mapped tax return line item or schedule reference for this account (e.g., Form 1120 Line 1a, Schedule C Line 8). Used for automated tax return preparation and IRS compliance.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for statistical accounts (e.g., FTE, Headcount, Hours, Placements). Applicable only when statistical_account is True. Null for monetary accounts.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this GL account record. Used for audit trail and accountability.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'Chart of Accounts master record defining every general ledger account used in the staffing enterprise. Captures account number, account name, account type (asset, liability, equity, revenue, expense), account class, normal balance (debit/credit), parent account for hierarchy rollup, cost center applicability, intercompany flag, consolidation account mapping, GAAP/IFRS classification, active status, and effective date range. SSOT for all GL account definitions used across journal entries, cost allocations, and financial reporting.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center record. Primary key.',
    `business_unit_id` BIGINT COMMENT 'Reference to the owning business unit or operating entity. Links cost center to the organizational hierarchy for consolidated financial reporting.',
    `last_modified_by_user_staff_profile_id` BIGINT COMMENT 'User identifier of the person who last modified this cost center record. Used for audit trail and accountability.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that owns this cost center. Used for statutory financial reporting, tax filings, and legal compliance. Critical for multi-entity staffing organizations.',
    `parent_cost_center_id` BIGINT COMMENT 'Reference to the parent cost center in a hierarchical cost center structure. Enables roll-up reporting and multi-level profitability analysis. Null for top-level cost centers.',
    `primary_cost_staff_profile_id` BIGINT COMMENT 'Reference to the employee who manages this cost center. Responsible for operational performance and budget adherence.',
    `staff_profile_id` BIGINT COMMENT 'User identifier of the person who created this cost center record. Used for audit trail and accountability.',
    `allocation_method` STRING COMMENT 'Method used to allocate shared costs or overhead to this cost center. Direct = costs directly attributable; Headcount = allocated by employee count; Revenue = allocated by revenue contribution; FTE = allocated by Full-Time Equivalent count; Square Footage = allocated by physical space; Transaction Volume = allocated by activity volume.. Valid values are `direct|headcount|revenue|fte|square_footage|transaction_volume`',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total budgeted amount for the current fiscal year for this cost center. Used for budget vs. actual variance analysis and financial planning. Expressed in the reporting currency.',
    `cost_center_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the cost center. Used in general ledger postings, financial reports, and ERP integrations. Typically follows organizational coding standards (e.g., branch codes, division codes, department codes).. Valid values are `^[A-Z0-9]{4,12}$`',
    `cost_center_description` STRING COMMENT 'Detailed description of the cost centers purpose, scope, and responsibilities. Provides context for financial accountability and reporting.',
    `cost_center_name` STRING COMMENT 'Human-readable name of the cost center. Used for display in financial reports, dashboards, and user interfaces.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active = operational and accepting transactions; Inactive = temporarily not in use; Suspended = under review or restricted; Pending Closure = scheduled for deactivation; Closed = permanently deactivated and archived.. Valid values are `active|inactive|suspended|pending_closure|closed`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by organizational function. Branch = field office or local staffing branch; Division = business unit or service line; Corporate = headquarters or enterprise functions; Shared Services = centralized support functions (HR, IT, Finance); Regional = multi-branch geographic area; Department = functional unit within a larger entity.. Valid values are `branch|division|corporate|shared_services|regional|department`',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the cost center operates. Used for international financial consolidation and statutory reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost center record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for financial transactions and reporting associated with this cost center. Used for multi-currency consolidation and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this cost center ceased or will cease to be active. Null for currently active cost centers with no planned end date. Used for historical reporting and cost center lifecycle management.',
    `effective_start_date` DATE COMMENT 'Date when this cost center became or will become active and eligible for financial transactions. Used for temporal reporting and historical analysis.',
    `external_reporting_code` STRING COMMENT 'Code used for external financial reporting, regulatory filings, or industry benchmarking. May differ from internal cost center code to meet external reporting requirements (e.g., EEOC, OFCCP, SIA benchmarking).',
    `gl_account_segment` STRING COMMENT 'The cost center segment value used in the chart of accounts structure within the general ledger. Enables automated posting and financial statement mapping.. Valid values are `^[0-9]{4,8}$`',
    `industry_vertical` STRING COMMENT 'Primary industry vertical or sector focus for this cost center (e.g., Healthcare, IT, Finance, Manufacturing, Logistics). Used for vertical-specific performance analysis and market segmentation. [ENUM-REF-CANDIDATE: healthcare|information_technology|finance|manufacturing|logistics|retail|hospitality|energy|construction — promote to reference product]',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this cost center participates in intercompany transactions (True) requiring elimination entries during consolidation, or operates solely within a single legal entity (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost center record was last updated. Used for change tracking and audit trail.',
    `notes` STRING COMMENT 'Free-form notes or comments about the cost center. Used for documenting special circumstances, organizational changes, or operational context.',
    `overhead_rate_percentage` DECIMAL(18,2) COMMENT 'Standard overhead allocation rate applied to this cost center, expressed as a percentage. Used for burden rate calculations and full-cost profitability analysis. Example: 15.50 represents 15.50%.',
    `profit_center_flag` BOOLEAN COMMENT 'Indicates whether this cost center is also a profit center (True) or purely a cost center (False). Profit centers track both revenue and expenses for full P&L accountability; pure cost centers track only expenses.',
    `region_code` STRING COMMENT 'Geographic region code for the cost center. Used for regional P&L reporting and geographic performance analysis. Examples: NE (Northeast), SE (Southeast), MW (Midwest), W (West), CAN (Canada).. Valid values are `^[A-Z]{2,4}$`',
    `revenue_generating_flag` BOOLEAN COMMENT 'Indicates whether this cost center directly generates revenue (True) such as a staffing branch, or is a support/overhead function (False) such as corporate HR or IT.',
    `service_line` STRING COMMENT 'Primary service line or business offering associated with this cost center. Used for service-line profitability analysis and strategic planning. RPO = Recruitment Process Outsourcing; MSP = Managed Service Provider. [ENUM-REF-CANDIDATE: temporary_staffing|permanent_placement|rpo|msp|payroll_services|workforce_consulting|executive_search — 7 candidates stripped; promote to reference product]',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction identifier for this cost center. Used for SUTA (State Unemployment Tax Act), local tax reporting, and workers compensation allocation. Format varies by country (e.g., US state codes, Canadian province codes).',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Organizational cost center master record representing a financial accountability unit within the staffing enterprise. Captures cost center code, name, description, cost center type (branch, division, corporate, shared services), owning business unit, regional hierarchy, manager, budget owner, active status, and effective dates. Used to allocate revenues and expenses across branches, divisions, and service lines for internal P&L reporting and profitability analysis.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record. Primary key for the journal entry entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Journal entry should link to accounting period master for proper period management. Currently uses accounting_period (STRING) and fiscal_year (INT) which should be normalized to FK. Removes redundant ',
    `staff_profile_id` BIGINT COMMENT 'Unique identifier of the user or employee who approved the journal entry. Used for audit trail and segregation of duties compliance.',
    `business_unit_id` BIGINT COMMENT 'FK to finance.business_unit',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Journal entry should link to legal entity master for proper entity-level accounting. Currently uses legal_entity_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `primary_journal_staff_profile_id` BIGINT COMMENT 'Unique identifier of the user or employee who prepared the journal entry. Used for audit trail and segregation of duties.',
    `schedule_id` BIGINT COMMENT 'Identifier linking this journal entry to its recurring schedule template. Used for automated recurring journal entry processing.',
    `reversed_journal_entry_id` BIGINT COMMENT 'Reference to the original journal entry that this entry reverses. Creates a link between reversing entries and their originals.',
    `reversing_journal_entry_id` BIGINT COMMENT 'Self-referencing FK on journal_entry (reversing_journal_entry_id)',
    `adjustment_reason` STRING COMMENT 'Explanation or reason code for adjusting journal entries. Documents the business justification for period-end adjustments and corrections.',
    `approval_date` DATE COMMENT 'The date on which the journal entry was approved for posting. Part of the approval workflow audit trail.',
    `approver_name` STRING COMMENT 'Name of the individual who approved the journal entry for posting to the general ledger.',
    `audit_trail_notes` STRING COMMENT 'Additional notes or comments added during the journal entry lifecycle for audit trail purposes. Captures reviewer comments and change justifications.',
    `batch_number` STRING COMMENT 'Identifier for the batch or group of journal entries processed together. Used for bulk posting and reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when the journal entry record was first created in the general ledger system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the journal entry amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert foreign currency amounts to the functional currency. Applicable for multi-currency journal entries.',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 code for the functional currency of the reporting entity. Used for multi-currency translation.. Valid values are `^[A-Z]{3}$`',
    `intercompany_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this journal entry represents an intercompany transaction between legal entities within the enterprise.',
    `journal_date` DATE COMMENT 'The business date on which the journal entry transaction occurred. Represents the effective date of the accounting event.',
    `journal_entry_description` STRING COMMENT 'Detailed narrative description of the journal entry explaining the business purpose and nature of the accounting transaction.',
    `journal_entry_number` STRING COMMENT 'Business identifier for the journal entry. Human-readable unique number assigned to the journal entry for external reference and audit trail purposes.',
    `journal_type` STRING COMMENT 'Classification of the journal entry indicating its purpose and nature in the accounting cycle.. Valid values are `standard|adjusting|reversing|accrual|intercompany|reclassification`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when the journal entry record was last modified. Used for audit trail and change tracking.',
    `posted_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when the journal entry was posted to the general ledger. Marks the point at which the entry became part of the official books.',
    `posting_date` DATE COMMENT 'The date on which the journal entry was posted to the general ledger. May differ from journal date for period-end adjustments and accruals.',
    `posting_status` STRING COMMENT 'Current lifecycle status of the journal entry in the posting workflow. Indicates whether the entry is draft, awaiting approval, posted to GL, or cancelled.. Valid values are `draft|pending_approval|approved|posted|rejected|cancelled`',
    `preparer_name` STRING COMMENT 'Name of the individual who prepared or created the journal entry.',
    `recurring_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this journal entry is part of a recurring journal entry template that posts automatically each period.',
    `reference_number` STRING COMMENT 'External reference number linking this journal entry to source documents such as invoices, payroll runs, or vendor bills.',
    `reversal_date` DATE COMMENT 'The date on which this journal entry will be or was reversed. Applicable only for reversing journal entries.',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this journal entry is a reversing entry that will be automatically reversed in a subsequent period.',
    `source_system` STRING COMMENT 'The originating system or module that generated this journal entry. Identifies whether the entry came from payroll processing, billing, AP, AR, or was manually created.. Valid values are `payroll|billing|accounts_payable|accounts_receivable|manual|revenue_recognition`',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'The sum of all credit amounts across all line items in this journal entry. Must equal total debit amount for a balanced entry.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'The sum of all debit amounts across all line items in this journal entry. Must equal total credit amount for a balanced entry.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'General ledger journal entry header record representing a balanced accounting transaction posted to the staffing enterprises general ledger. Captures journal entry number, journal date, posting date, period, fiscal year, journal type (standard, adjusting, reversing, accrual, intercompany), source system (payroll, billing, AP, AR), description, total debit amount, total credit amount, currency, exchange rate, preparer, approver, approval date, reversal flag, reversal date, and posting status. Core transactional record for all financial accounting activity.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line. Primary key for this entity.',
    `assignment_id` BIGINT COMMENT 'Reference to the specific placement or assignment for direct cost and revenue attribution. Links financial transactions to workforce placements.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: JE lines may adjust billing account balances for corrections, reclassifications, or manual adjustments during period close.',
    `conversion_id` BIGINT COMMENT 'Foreign key linking to placement.conversion. Business justification: Conversion fees generate revenue that must be journalized. Accountants trace journal entries to specific conversions for audit, revenue recognition, financial reporting, and conversion fee reconciliat',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entry line should link to cost center master for organizational tracking. Currently uses cost_center_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `credit_memo_id` BIGINT COMMENT 'Foreign key linking to billing.credit_memo. Business justification: JE lines may reference credit memos for revenue adjustments and manual corrections during period close.',
    `department_id` BIGINT COMMENT 'FK to employee.department',
    `direct_hire_id` BIGINT COMMENT 'Foreign key linking to placement.direct_hire. Business justification: Direct hire placements generate fee revenue that must be journalized. Accountants trace journal entries to specific direct hire placements for revenue recognition, audit trail, fee reconciliation, and',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Journal entry line should link to GL account master for proper accounting classification. Currently uses gl_account_code (STRING) and gl_account_name (STRING) which should be normalized to FK. Removes',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header. Each line must belong to a journal entry that contains balanced debits and credits.',
    `location_id` BIGINT COMMENT 'Foreign key linking to client.location. Business justification: JE lines for location-specific adjustments (lease accruals, site closure costs, location cost reclassifications) require location tracking for accurate site P&L and financial reporting. Standard in mu',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: JE lines for managed program adjustments (MSP fee accruals, program cost corrections) need program linkage for accurate program financials and audit trail. Essential for managed program P&L integrity.',
    `profile_id` BIGINT COMMENT 'Reference to the candidate or worker for payroll and compensation-related journal entries. Enables worker-level cost tracking.',
    `reversed_line_journal_entry_line_id` BIGINT COMMENT 'Reference to the original journal entry line ID that this line reverses. Null if this is not a reversal entry.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Journal entry lines for revenue, COGS, and expense accruals often reference the SOW for project accounting, margin analysis, and SOW-level P&L reporting. Critical for project-based financial reporting',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_agreement. Business justification: Journal entry lines for vendor payments, accruals, and adjustments should reference the vendor agreement for contract compliance tracking, spend analysis, and vendor performance reporting. Enables ven',
    `vms_program_id` BIGINT COMMENT 'Foreign key linking to client.vms_program. Business justification: Manual journal entry lines for program-specific adjustments (fee accruals, revenue corrections, program cost reclassifications) need program attribution for accurate program financials and audit trail',
    `offset_journal_entry_line_id` BIGINT COMMENT 'Self-referencing FK on journal_entry_line (offset_journal_entry_line_id)',
    `approval_date` DATE COMMENT 'The date on which this journal entry line was approved. Used for audit trail and compliance reporting.',
    `approval_status` STRING COMMENT 'Current approval status of this journal entry line. Tracks workflow state for journal entry approval processes.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'The user ID or name of the person who approved this journal entry line. Provides accountability and audit trail for financial controls.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this journal entry line record was first created in the system. Provides audit trail for data lineage.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The credit amount for this journal entry line in the functional currency. Null or zero if this is a debit line.',
    `debit_amount` DECIMAL(18,2) COMMENT 'The debit amount for this journal entry line in the functional currency. Null or zero if this is a credit line.',
    `effective_date` DATE COMMENT 'The business effective date of the transaction represented by this line. May differ from posting date for accruals and adjustments.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate used to convert transaction currency to functional currency. Null if no currency conversion was required.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year. Typically 1-12 for monthly periods or 1-13 for 13-period calendars.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this journal entry line belongs. Used for year-over-year financial analysis and reporting.',
    `functional_currency_code` STRING COMMENT 'The functional currency code (ISO 4217 3-letter code) in which the debit and credit amounts are recorded. Typically USD for US-based staffing operations.. Valid values are `^[A-Z]{3}$`',
    `intercompany_entity_code` STRING COMMENT 'Legal entity or intercompany code for multi-entity consolidation and intercompany elimination. Required for consolidated financial reporting.',
    `line_description` STRING COMMENT 'Detailed description of the business purpose and nature of this journal entry line. Provides audit trail and business context.',
    `line_number` STRING COMMENT 'Sequential line number within the journal entry. Determines the display order of lines within the entry.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this journal entry line record was last modified. Tracks the most recent update for audit and change tracking.',
    `posting_date` DATE COMMENT 'The accounting date on which this journal entry line was posted to the general ledger. Determines the financial period for reporting.',
    `project_code` STRING COMMENT 'Project or job code for project-based accounting and cost tracking. Used for client engagement profitability analysis in staffing operations.',
    `reconciled_by` STRING COMMENT 'The user ID or name of the person who performed the reconciliation. Provides accountability and audit trail.',
    `reconciliation_date` DATE COMMENT 'The date on which this journal entry line was reconciled. Used for audit trail and compliance reporting.',
    `reconciliation_status` STRING COMMENT 'Current reconciliation status of this journal entry line. Tracks whether the line has been reconciled to supporting documentation or subledger.. Valid values are `unreconciled|reconciled|pending_review|exception`',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this journal entry line is a reversal of a previous entry. True if this line reverses a prior posting.',
    `source_document_reference` STRING COMMENT 'The unique identifier of the source document in the originating system. Enables traceability to the original business transaction.',
    `source_document_type` STRING COMMENT 'The type of source document that originated this journal entry line. Enables drill-back to originating transaction. [ENUM-REF-CANDIDATE: invoice|payment|payroll|expense|adjustment|accrual|reversal|allocation — 8 candidates stripped; promote to reference product]',
    `source_system_code` STRING COMMENT 'The originating system or module that generated this journal entry line. Examples: AR (Accounts Receivable), AP (Accounts Payable), PR (Payroll), GL (General Ledger).',
    `statistical_flag` BOOLEAN COMMENT 'Indicates whether this is a statistical journal entry line (non-monetary) used for allocation bases or KPI tracking. True for statistical entries.',
    `statistical_quantity` DECIMAL(18,2) COMMENT 'The statistical quantity for non-monetary journal entries. Examples: headcount, FTE (Full-Time Equivalent), hours worked, units produced.',
    `statistical_unit` STRING COMMENT 'The unit of measure for the statistical quantity. Examples: FTE, hours, headcount, units, placements.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount associated with this journal entry line if applicable. Used for tax reconciliation and reporting.',
    `tax_code` STRING COMMENT 'Tax code or tax type associated with this line for tax reporting and compliance. Examples include FICA, FUTA, SUTA, sales tax codes.',
    `transaction_credit_amount` DECIMAL(18,2) COMMENT 'The credit amount in the original transaction currency before currency conversion. Null if transaction currency equals functional currency.',
    `transaction_currency_code` STRING COMMENT 'The original transaction currency code (ISO 4217 3-letter code) if different from functional currency. Used for foreign currency transactions.. Valid values are `^[A-Z]{3}$`',
    `transaction_debit_amount` DECIMAL(18,2) COMMENT 'The debit amount in the original transaction currency before currency conversion. Null if transaction currency equals functional currency.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit or credit line within a general ledger journal entry. Captures line sequence number, GL account, cost center, department, project code, intercompany entity, debit amount, credit amount, functional currency amount, transaction currency amount, exchange rate, line description, tax code, and reconciliation status. Each journal entry must have balanced lines (total debits = total credits). Enables granular GL drill-down and account-level financial analysis.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`accounting_period` (
    `accounting_period_id` BIGINT COMMENT 'Unique identifier for the accounting period record. Primary key.',
    `budget_period_id` BIGINT COMMENT 'Reference to the corresponding budget period for variance analysis and budget vs actual reporting.',
    `close_coordinator_staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: Accounting periods need designated close coordinator for month-end/quarter-end task orchestration, checklist management, cross-functional coordination, and executive sign-off - standard practice in st',
    `created_by_user_staff_profile_id` BIGINT COMMENT 'Identifier of the user who created this accounting period record.',
    `fiscal_calendar_id` BIGINT COMMENT 'Reference to the fiscal calendar that defines this accounting period structure.',
    `locked_by_user_staff_profile_id` BIGINT COMMENT 'Identifier of the user who locked the accounting period.',
    `modified_by_user_staff_profile_id` BIGINT COMMENT 'Identifier of the user who last modified this accounting period record.',
    `prior_year_period_accounting_period_id` BIGINT COMMENT 'Reference to the equivalent accounting period in the prior fiscal year for year-over-year comparative reporting.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the user who closed the accounting period.',
    `prior_accounting_period_id` BIGINT COMMENT 'Self-referencing FK on accounting_period (prior_accounting_period_id)',
    `accounting_period_description` STRING COMMENT 'Additional descriptive information about the accounting period, including any special characteristics or notes.',
    `ap_open` BOOLEAN COMMENT 'Flag indicating whether the Accounts Payable sub-ledger is open for posting transactions in this period.',
    `ar_open` BOOLEAN COMMENT 'Flag indicating whether the Accounts Receivable sub-ledger is open for posting transactions in this period.',
    `billing_open` BOOLEAN COMMENT 'Flag indicating whether the Billing sub-ledger is open for posting billing transactions in this period.',
    `close_date` DATE COMMENT 'The date when the accounting period was officially closed and no further standard entries are allowed.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this accounting period record was first created in the system.',
    `end_date` DATE COMMENT 'The last day of the accounting period when transactions can be posted to this period.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this accounting period belongs (e.g., 2024).',
    `gl_open` BOOLEAN COMMENT 'Flag indicating whether the General Ledger is open for posting journal entries in this period.',
    `is_adjustment_period` BOOLEAN COMMENT 'Flag indicating whether this is a special adjustment period (typically period 13 or 14) used for year-end adjustments and corrections.',
    `is_year_end_period` BOOLEAN COMMENT 'Flag indicating whether this is the final period of the fiscal year.',
    `lock_date` DATE COMMENT 'The date when the accounting period was locked, preventing any further changes including adjustments.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this accounting period record was last modified.',
    `payroll_open` BOOLEAN COMMENT 'Flag indicating whether the Payroll sub-ledger is open for posting payroll transactions in this period.',
    `period_name` STRING COMMENT 'Human-readable name of the accounting period (e.g., January 2024, Q1 2024, FY2024).',
    `period_number` STRING COMMENT 'Sequential number of the period within the fiscal year (e.g., 1 for January, 2 for February, or 1 for Q1).',
    `period_status` STRING COMMENT 'Current lifecycle status of the accounting period controlling whether transactions can be posted. Open allows posting, closed prevents new entries, locked prevents any changes, adjusting allows only adjustment entries, future indicates not yet active.. Valid values are `open|closed|locked|adjusting|future`',
    `period_type` STRING COMMENT 'Classification of the accounting period by duration and purpose (monthly, quarterly, annual, semi-annual, or adjusting period).. Valid values are `monthly|quarterly|annual|semi-annual|adjusting`',
    `quarter_number` STRING COMMENT 'The fiscal quarter number (1-4) to which this period belongs within the fiscal year.',
    `start_date` DATE COMMENT 'The first day of the accounting period when transactions can be posted to this period.',
    CONSTRAINT pk_accounting_period PRIMARY KEY(`accounting_period_id`)
) COMMENT 'Fiscal accounting period master record defining the financial calendar for the staffing enterprise. Captures period number, period name, fiscal year, period start date, period end date, period type (monthly, quarterly, annual), period status (open, closed, locked, adjusting), close date, closed by, and associated fiscal calendar. Controls which periods are open for journal entry posting and drives financial reporting period alignment across AR, AP, payroll, and billing sub-ledgers.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`ar_account` (
    `ar_account_id` BIGINT COMMENT 'Unique identifier for the accounts receivable account record. Primary key for the AR account entity.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account that owns this AR account. Links to the client master record in the client domain.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AR account sub-ledger should link to the GL account master. Currently uses gl_account_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the collections specialist or account manager responsible for managing this AR account and pursuing past due balances.',
    `parent_ar_account_id` BIGINT COMMENT 'Self-referencing FK on ar_account (parent_ar_account_id)',
    `account_close_date` DATE COMMENT 'Date when the AR account was closed. Null for active accounts. Set when client relationship ends and all balances are settled or written off.',
    `account_open_date` DATE COMMENT 'Date when the AR account was first established for the client. Marks the beginning of the financial relationship.',
    `account_status` STRING COMMENT 'Current lifecycle status of the AR account. Indicates whether the account is actively accepting charges, suspended from new billing, closed, in collections, written off, or in legal proceedings.. Valid values are `active|suspended|closed|collections|write_off|legal`',
    `aging_30_days_amount` DECIMAL(18,2) COMMENT 'Portion of the AR balance that is 1-30 days past due. Invoices overdue by 1 to 30 days beyond payment terms.',
    `aging_60_days_amount` DECIMAL(18,2) COMMENT 'Portion of the AR balance that is 31-60 days past due. Invoices overdue by 31 to 60 days beyond payment terms.',
    `aging_90_days_amount` DECIMAL(18,2) COMMENT 'Portion of the AR balance that is 61-90 days past due. Invoices overdue by 61 to 90 days beyond payment terms.',
    `aging_over_90_days_amount` DECIMAL(18,2) COMMENT 'Portion of the AR balance that is more than 90 days past due. Invoices overdue by more than 90 days beyond payment terms. High risk of non-collection.',
    `ar_account_number` STRING COMMENT 'Business identifier for the AR account. Externally visible account number used in invoices, statements, and client communications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `auto_pay_enabled` BOOLEAN COMMENT 'Indicates whether automatic payment processing is enabled for this account. True if client has authorized automatic debit or ACH payments.',
    `available_credit` DECIMAL(18,2) COMMENT 'Remaining credit capacity for the client. Calculated as credit limit minus current balance. Indicates how much additional billing the client can receive before hitting credit limit.',
    `bad_debt_reserve` DECIMAL(18,2) COMMENT 'Amount reserved for potential uncollectible receivables on this account. Allowance for doubtful accounts based on aging, payment history, and credit risk assessment.',
    `billing_cycle` STRING COMMENT 'Frequency at which invoices are generated for this client. Defines the regular billing schedule (e.g., weekly for temporary staffing, monthly for permanent placements).. Valid values are `weekly|biweekly|monthly|semimonthly|on_demand`',
    `collection_status` STRING COMMENT 'Current stage in the collections process. Indicates the level of collection activity and escalation for past due balances. [ENUM-REF-CANDIDATE: current|reminder_sent|first_notice|second_notice|final_notice|collections|legal — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this AR account record was first created in the system. Audit trail for record creation.',
    `credit_hold_date` DATE COMMENT 'Date when the account was placed on credit hold. Null if account is not currently on hold. Used to track duration of credit restrictions.',
    `credit_hold_flag` BOOLEAN COMMENT 'Indicates whether the account is on credit hold. True if new billing or service delivery is blocked due to past due balance, credit limit breach, or credit risk concerns.',
    `credit_hold_reason` STRING COMMENT 'Business justification for placing the account on credit hold. Free-text explanation of the credit risk or payment issue that triggered the hold.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed for this client account. Credit exposure threshold approved by credit management. Billing may be blocked if balance exceeds this limit.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for this AR account. All balances and transactions are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'Total outstanding receivable balance owed by the client. Sum of all unpaid invoices minus payments and adjustments. Represents the current amount due.',
    `current_bucket_amount` DECIMAL(18,2) COMMENT 'Portion of the AR balance that is current (not yet past due). Invoices within the payment terms window (e.g., Net 30 days).',
    `days_sales_outstanding` STRING COMMENT 'Average number of days it takes to collect payment from this client. Key performance indicator (KPI) for AR efficiency and client payment behavior.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether there are active billing disputes on this account. True if client has contested one or more invoices or charges.',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Total amount currently under dispute by the client. Sum of all invoice line items or charges that the client has formally contested.',
    `dunning_level` STRING COMMENT 'Numeric indicator of collection escalation intensity. Higher numbers indicate more aggressive collection efforts (e.g., 0=current, 1=first reminder, 2=second notice, 3=final notice, 4=collections).',
    `last_invoice_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent invoice issued to the client. Provides context for billing patterns and revenue trends.',
    `last_invoice_date` DATE COMMENT 'Date of the most recent invoice issued to the client. Used to track billing activity and account aging calculations.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment received from the client. Provides context for payment patterns and client behavior.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received from the client. Used to track payment frequency and identify delinquent accounts.',
    `last_statement_date` DATE COMMENT 'Date of the most recent account statement sent to the client. Used to track statement generation and client communication cycles.',
    `next_statement_date` DATE COMMENT 'Scheduled date for the next account statement to be generated and sent to the client. Based on billing cycle configuration.',
    `notes` STRING COMMENT 'Free-text notes and comments about the AR account. Used by collections staff and account managers to document special circumstances, payment arrangements, or client communications.',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the client. Defines the number of days from invoice date by which payment is due (e.g., Net 30 means payment due within 30 days).. Valid values are `net_15|net_30|net_45|net_60|net_90|due_on_receipt`',
    `statement_delivery_method` STRING COMMENT 'Preferred method for delivering account statements and invoices to the client. Supports electronic and paper delivery channels.. Valid values are `email|postal_mail|portal|edi`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this AR account record was last modified. Audit trail for record changes and balance updates.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of receivables written off as uncollectible for this account. Historical total of bad debt recognized over the life of the account.',
    CONSTRAINT pk_ar_account PRIMARY KEY(`ar_account_id`)
) COMMENT 'Accounts receivable sub-ledger account master record representing the outstanding receivable balance owed by a client to the staffing firm. Captures client billing account reference, AR account number, current balance, aging buckets (current, 30, 60, 90, 90+ days), credit limit, payment terms (Net 30, Net 45, Net 60), currency, last payment date, last invoice date, collection status, dunning level, assigned collector, and account open/close dates. SSOT for client-level AR balance and aging within the finance domain.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` (
    `ar_transaction_id` BIGINT COMMENT 'Unique identifier for the accounts receivable transaction record. Primary key for the AR transaction ledger.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: AR transaction should link to accounting period master for proper period management. Currently uses gl_period (STRING) which should be normalized to FK. Removes redundant period string.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to finance.ar_account. Business justification: AR transaction should link to the AR account sub-ledger to track outstanding receivables. This is a critical relationship for AR aging and balance tracking. No redundant columns to remove as ar_transa',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account structure under which this AR transaction is organized. Supports multi-account client hierarchies.',
    `billing_dispute_id` BIGINT COMMENT 'Reference to the dispute case record if this transaction is under dispute. Null if no active dispute exists.',
    `credit_memo_id` BIGINT COMMENT 'Reference to the credit memo document when transaction type is credit memo application. Null for non-credit-memo transactions.',
    `invoice_id` BIGINT COMMENT 'Reference to the source invoice document when transaction type is invoice posting. Null for non-invoice transactions.',
    `payment_id` BIGINT COMMENT 'Reference to the payment record when transaction type is payment application. Null for non-payment transactions.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: AR transactions need assigned processor for payment application, cash posting, dispute investigation, write-off processing, and customer communication - critical for staffing firms with high-volume bi',
    `reversed_transaction_ar_transaction_id` BIGINT COMMENT 'Reference to the original AR transaction that this entry reverses. Null if this is not a reversal transaction.',
    `reversal_ar_transaction_id` BIGINT COMMENT 'Self-referencing FK on ar_transaction (reversal_ar_transaction_id)',
    `adjustment_notes` STRING COMMENT 'Free-text explanation providing additional context for adjustments, write-offs, or manual corrections. Used for audit trail and dispute resolution.',
    `adjustment_reason_code` STRING COMMENT 'Standardized code indicating the business reason for adjustments or write-offs (e.g., billing error, client dispute, bad debt, pricing correction).',
    `aging_bucket` STRING COMMENT 'Classification of the receivable based on days outstanding from due date. Used for AR aging reports and collection prioritization.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `applied_amount` DECIMAL(18,2) COMMENT 'Portion of the transaction amount that has been applied or allocated to specific invoices or receivables. Relevant for payments and credit memos.',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved this transaction for posting. Required for adjustments and write-offs per SOX controls.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this transaction was approved for posting. Part of the audit trail for financial controls.',
    `batch_number` STRING COMMENT 'Identifier of the batch or processing run in which this transaction was posted. Supports batch reconciliation and error tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this AR transaction record was first created in the system. Part of the complete audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount (e.g., USD, EUR, GBP). Supports multi-currency AR operations.. Valid values are `^[A-Z]{3}$`',
    `deferred_revenue_amount` DECIMAL(18,2) COMMENT 'Portion of the transaction amount that is deferred and not yet recognized as revenue. Relevant for advance billings and multi-period services.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the transaction (early payment discount, volume discount, promotional discount). Reduces the net receivable.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this transaction is under dispute by the client. True if disputed, false otherwise. Affects collections strategy.',
    `due_date` DATE COMMENT 'Date by which payment is expected for invoice transactions. Used for aging analysis and collections management. Null for non-invoice transactions.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert foreign currency transaction amounts to the functional currency. Set to 1.0 for domestic currency transactions.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Transaction amount converted to the organizations functional currency using the exchange rate. Used for consolidated financial reporting.',
    `modified_by` STRING COMMENT 'User ID or name of the person or system process that last modified this AR transaction record. Supports change tracking and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this AR transaction record was last modified. Tracks the most recent change for audit and reconciliation purposes.',
    `payment_terms` STRING COMMENT 'Contractual payment terms applicable to this transaction (e.g., Net 30, Net 45, Due on Receipt). Determines due date calculation.',
    `posting_date` DATE COMMENT 'Date on which the transaction was posted to the general ledger. May differ from transaction date due to period-end processing or batch posting.',
    `posting_status` STRING COMMENT 'Current posting state of the AR transaction: draft (not yet posted), posted (committed to GL), reversed (corrected by reversal entry), voided (cancelled before posting).. Valid values are `draft|posted|reversed|voided`',
    `revenue_recognition_status` STRING COMMENT 'Indicates whether revenue associated with this AR transaction has been recognized per ASC 606 guidelines: recognized (fully earned), deferred (not yet earned), partial (partially earned), pending (awaiting review).. Valid values are `recognized|deferred|partial|pending`',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this transaction is a reversal entry created to correct or cancel a previously posted transaction. True if reversal, false otherwise.',
    `source_system` STRING COMMENT 'Name of the operational system that originated this AR transaction (e.g., Oracle NetSuite ERP, Salesforce Revenue Cloud). Supports data lineage and reconciliation.',
    `source_transaction_reference` STRING COMMENT 'Unique identifier of this transaction in the source system. Enables traceability back to the originating system for audit and reconciliation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount included in the transaction (sales tax, VAT, GST). Supports tax reporting and reconciliation.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the AR transaction. Positive for debits (invoices, debit memos), negative for credits (payments, credit memos, write-offs).',
    `transaction_date` DATE COMMENT 'Business date on which the AR transaction event occurred. Determines the accounting period for revenue recognition and aging analysis.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number assigned to this AR movement event. Used for external reference and audit trail.',
    `transaction_type` STRING COMMENT 'Classification of the AR movement event: invoice (new receivable), payment (cash receipt), credit_memo (reduction), debit_memo (increase), write_off (bad debt), adjustment (correction).. Valid values are `invoice|payment|credit_memo|debit_memo|write_off|adjustment`',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'Portion of the transaction amount that remains unapplied or unallocated. Represents on-account credits or prepayments awaiting application.',
    `write_off_reason` STRING COMMENT 'Business justification for write-off transactions (e.g., bad debt, client bankruptcy, uncollectible, small balance). Required for write-off transaction types.',
    `created_by` STRING COMMENT 'User ID or name of the person or system process that created this AR transaction record. Supports audit trail and accountability.',
    CONSTRAINT pk_ar_transaction PRIMARY KEY(`ar_transaction_id`)
) COMMENT 'Accounts receivable transactional record capturing every AR movement event for a client — invoice postings, payment applications, credit memo applications, adjustments, and write-offs. Captures transaction date, transaction type (invoice, payment, credit memo, debit memo, write-off, adjustment), source document reference (invoice_id, payment_id, credit_memo_id), transaction amount, applied amount, unapplied amount, currency, exchange rate, GL period, and posting status. Provides the complete AR activity ledger for client account reconciliation.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`ap_account` (
    `ap_account_id` BIGINT COMMENT 'Unique identifier for the accounts payable account record. Primary key for the AP account entity.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: AP accounts need assigned staff for vendor relationship management, payment term negotiation, dispute resolution, and 1099 reporting coordination - standard practice in staffing firm vendor management',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AP account should link to cost center master for organizational tracking. Currently uses cost_center_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AP account sub-ledger should link to the GL account master. Currently uses gl_account_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: AP accounts for MSP/managed program vendors need program linkage for cost allocation and program P&L. Enables tracking of program-specific vendor costs (supplier invoices, MSP platform fees) for accur',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor, supplier, or service provider to whom the payable balance is owed. Links to the vendor master record.',
    `vms_program_id` BIGINT COMMENT 'Reference to the VMS program under which this vendor operates. Links to the VMS program master for program-specific terms, rates, and compliance requirements.',
    `parent_ap_account_id` BIGINT COMMENT 'Self-referencing FK on ap_account (parent_ap_account_id)',
    `account_closed_date` DATE COMMENT 'Date when the AP account was closed or terminated. Populated when the vendor relationship ends and all outstanding balances are settled.',
    `account_number` STRING COMMENT 'Business identifier for the AP account. Externally-known unique account number used in vendor communications and financial reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `account_opened_date` DATE COMMENT 'Date when the AP account was first established for this vendor. Marks the beginning of the vendor relationship for historical analysis.',
    `account_status` STRING COMMENT 'Current lifecycle status of the AP account. Indicates whether the account is actively accepting charges, suspended due to disputes, or closed.. Valid values are `active|inactive|suspended|closed|disputed|under_review`',
    `account_type` STRING COMMENT 'Classification of the AP account based on the nature of the payable obligation. Distinguishes between trade payables, subcontractor obligations, service vendor payables, and tax liabilities.. Valid values are `trade_payable|expense_payable|subcontractor_payable|service_payable|tax_payable|other`',
    `aging_31_60` DECIMAL(18,2) COMMENT 'Portion of the outstanding balance aged 31-60 days from invoice date. Indicates payables approaching or past standard payment terms.',
    `aging_61_90` DECIMAL(18,2) COMMENT 'Portion of the outstanding balance aged 61-90 days from invoice date. May indicate payment delays or disputes requiring attention.',
    `aging_current` DECIMAL(18,2) COMMENT 'Portion of the outstanding balance that is current or aged 0-30 days from invoice date. Used for aging analysis and cash flow forecasting.',
    `aging_over_90` DECIMAL(18,2) COMMENT 'Portion of the outstanding balance aged over 90 days from invoice date. Represents significantly overdue payables that may be disputed or require escalation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this AP account record was first created in the system. Audit trail for data lineage and record creation tracking.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit limit or exposure allowed for this vendor relationship. Used to manage vendor risk and control spending.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the AP account balance and transactions. Supports multi-currency vendor relationships.. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'Total outstanding payable balance currently owed to the vendor. Represents the sum of all unpaid invoices and charges minus any credits or payments applied.',
    `hold_payment_flag` BOOLEAN COMMENT 'Indicates whether payments to this vendor are currently on hold. True when payments are suspended due to disputes, compliance issues, or vendor performance problems.',
    `hold_reason` STRING COMMENT 'Explanation for why payments are on hold. Examples: invoice dispute, missing documentation, compliance violation, vendor performance issue, pending investigation.',
    `is_1099_reportable` BOOLEAN COMMENT 'Indicates whether payments to this vendor are subject to IRS Form 1099 reporting requirements. True for independent contractors and service providers meeting IRS thresholds.',
    `is_msp_vms_vendor` BOOLEAN COMMENT 'Indicates whether this vendor is part of a managed service provider program or vendor management system. True for staffing suppliers operating under MSP/VMS arrangements.',
    `last_invoice_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent invoice received from this vendor. Provides context for typical transaction sizes and spending patterns.',
    `last_invoice_date` DATE COMMENT 'Date of the most recent invoice received from this vendor. Indicates recency of vendor activity and relationship status.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment made to this vendor. Provides quick reference for payment patterns and vendor relationship value.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment made to this vendor. Used for payment history analysis and vendor relationship management.',
    `lifetime_payment_total` DECIMAL(18,2) COMMENT 'Cumulative total of all payments made to this vendor since account inception. Indicates the total value of the vendor relationship over time.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this AP account record. Supports accountability and change tracking for audit purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this AP account record was last modified. Audit trail for tracking changes to account attributes, balances, or status.',
    `notes` STRING COMMENT 'Free-text notes and comments about the AP account. Used to document special payment instructions, relationship history, or account-specific considerations.',
    `payment_method` STRING COMMENT 'Preferred payment method for settling payables to this vendor. Determines payment processing workflow and timing.. Valid values are `ach|wire|check|credit_card|eft|other`',
    `payment_priority` STRING COMMENT 'Priority level assigned to this AP account for payment processing. High-priority vendors may receive expedited payment to maintain critical relationships.. Valid values are `high|medium|low|standard`',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the vendor. Examples include Net 30, Net 60, 2/10 Net 30 (2% discount if paid within 10 days, net due in 30 days).. Valid values are `^[A-Z0-9 /]{1,50}$`',
    `tax_identifier` STRING COMMENT 'Vendors federal tax identification number (EIN or SSN). Required for 1099 reporting and tax compliance. Format: XX-XXXXXXX (EIN) or XXX-XX-XXXX (SSN).. Valid values are `^[0-9]{2}-[0-9]{7}$|^[0-9]{3}-[0-9]{2}-[0-9]{4}$`',
    `vendor_category` STRING COMMENT 'Business classification of the vendor relationship. Examples: staffing supplier, subcontractor, background check provider, technology vendor, professional services, facilities. [ENUM-REF-CANDIDATE: staffing_supplier|subcontractor|background_check|technology|professional_services|facilities|insurance|benefits_provider|marketing|legal|consulting — promote to reference product]',
    `ytd_payment_total` DECIMAL(18,2) COMMENT 'Total amount paid to this vendor in the current fiscal year. Used for 1099 reporting, budget tracking, and vendor spend analysis.',
    CONSTRAINT pk_ap_account PRIMARY KEY(`ap_account_id`)
) COMMENT 'Accounts payable sub-ledger account master record representing the outstanding payable balance owed by the staffing firm to a vendor, supplier, or service provider. Captures vendor/supplier reference, AP account number, current balance, aging buckets, payment terms, preferred payment method (ACH, check, wire), currency, last payment date, last invoice date, 1099 reporting flag, tax ID, and account status. Manages the firms obligations to third-party staffing suppliers, subcontractors, and service vendors within MSP/VMS programs.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts payable invoice record. Primary key for the AP invoice entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: AP invoice should link to accounting period master for proper period management. Currently uses gl_period (STRING) which should be normalized to FK. Removes redundant period string.',
    `ap_account_id` BIGINT COMMENT 'Foreign key linking to finance.ap_account. Business justification: AP invoice should link to the AP account sub-ledger to track outstanding payables. This is a critical relationship for AP aging and balance tracking. No redundant columns to remove as ap_invoice alrea',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center or department to which this invoice expense is allocated. Enables departmental expense tracking and budget management.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AP invoice should link to GL account master for proper accounting classification. Currently uses gl_account_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `location_id` BIGINT COMMENT 'Foreign key linking to client.location. Business justification: Supplier invoices often relate to specific client locations (on-site services, location-specific vendors, facilities costs). Required for location P&L analysis and cost allocation by site in staffing ',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that authorized the goods or services for which this invoice was received. Used in three-way match validation.',
    `sow_engagement_id` BIGINT COMMENT 'Foreign key linking to placement.sow_engagement. Business justification: SOW engagements often involve vendor invoices for subcontractor payments or independent contractor costs. AP must track which SOW engagement each vendor invoice supports for project accounting, cost t',
    `sow_id` BIGINT COMMENT 'Reference to the statement of work that governs the services for which this invoice was issued. Links invoice to the contractual scope and deliverables.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the employee or manager who approved this invoice for payment. Used for audit trails and accountability.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier who issued this invoice. Links to the vendor master record for staffing suppliers, subcontractors, and third-party service providers.',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_agreement. Business justification: AP invoices from staffing suppliers must reference the vendor agreement for rate validation, markup verification, and contract compliance. Critical for three-way match (PO/receipt/invoice) and vendor ',
    `vms_program_id` BIGINT COMMENT 'Reference to the VMS program under which this invoice was generated. Applicable for invoices from staffing suppliers participating in managed service provider programs.',
    `credit_memo_ap_invoice_id` BIGINT COMMENT 'Self-referencing FK on ap_invoice (credit_memo_ap_invoice_id)',
    `ap_invoice_description` STRING COMMENT 'Free-text description of the goods or services covered by this invoice. Provides business context for the expense.',
    `approval_status` STRING COMMENT 'Current approval status of the invoice in the accounts payable workflow. Tracks whether the invoice has been reviewed and authorized for payment.. Valid values are `Pending|Approved|Rejected|On Hold|Escalated`',
    `approved_date` DATE COMMENT 'The date the invoice was approved for payment. Marks the completion of the approval workflow and authorization to proceed with payment.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the accounts payable system. Used for audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the invoice is denominated. Critical for multi-currency operations and foreign exchange management.. Valid values are `USD|CAD|GBP|EUR|AUD|MXN`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount applied to the invoice, such as early payment discounts, volume discounts, or negotiated rate reductions.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether this invoice is currently under dispute. True indicates the invoice has been challenged for accuracy, pricing, or service delivery issues.',
    `dispute_reason` STRING COMMENT 'Free-text explanation of why the invoice is disputed. Captures issues such as pricing discrepancies, service quality problems, or billing errors.',
    `due_date` DATE COMMENT 'The date by which payment is due to the vendor per the agreed payment terms. Critical for cash flow management and avoiding late payment penalties.',
    `hold_flag` BOOLEAN COMMENT 'Boolean indicator of whether payment for this invoice is on hold. True indicates payment has been suspended pending resolution of issues or additional approvals.',
    `hold_reason` STRING COMMENT 'Free-text explanation of why payment is on hold. Captures reasons such as missing documentation, approval escalation, or vendor compliance issues.',
    `invoice_amount` DECIMAL(18,2) COMMENT 'The gross invoice amount before taxes and adjustments. Represents the base charge for services or goods provided by the vendor.',
    `invoice_category` STRING COMMENT 'Business category of the invoice based on the type of goods or services purchased. Enables spend analysis and vendor management reporting.. Valid values are `Staffing Supplier|Subcontractor|Professional Services|Software License|Office Supplies|Utilities`',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. This is the principal business event timestamp representing when the invoice was created by the vendor.',
    `invoice_number` STRING COMMENT 'The externally-known unique invoice number assigned by the vendor. This is the business identifier used for vendor communication, payment reconciliation, and audit trails.',
    `invoice_type` STRING COMMENT 'Classification of the invoice type. Standard invoices are regular vendor bills, credit memos reduce amounts owed, debit memos increase amounts, prepayments are advance payments, and recurring invoices are for subscription services.. Valid values are `Standard|Credit Memo|Debit Memo|Prepayment|Recurring`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last modified. Tracks the most recent update to any field in the record for audit and change tracking purposes.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the invoice. Used for internal communication and documentation of special handling instructions.',
    `payment_date` DATE COMMENT 'The date the payment was issued to the vendor. Used for cash flow reporting and vendor payment history tracking.',
    `payment_method` STRING COMMENT 'The payment instrument used to pay the vendor, such as ACH, wire transfer, check, or credit card.. Valid values are `ACH|Wire Transfer|Check|Credit Card|EFT`',
    `payment_reference_number` STRING COMMENT 'The unique reference number or transaction ID for the payment issued to the vendor. Used for payment reconciliation and bank statement matching.',
    `payment_status` STRING COMMENT 'Current payment status of the invoice. Tracks whether the invoice has been paid, is pending payment, or has been cancelled.. Valid values are `Unpaid|Partially Paid|Paid|Voided|Cancelled`',
    `payment_terms` STRING COMMENT 'The agreed payment terms between the staffing firm and the vendor, defining when payment is due and any early payment discounts available. [ENUM-REF-CANDIDATE: Net 15|Net 30|Net 45|Net 60|Net 90|Due on Receipt|2/10 Net 30|1/15 Net 30 — 8 candidates stripped; promote to reference product]',
    `receipt_reference` BIGINT COMMENT 'Reference to the goods or services receipt record confirming delivery. Used in three-way match validation to ensure services were received before payment.',
    `received_date` DATE COMMENT 'The date the staffing firm received the invoice from the vendor. Used for tracking invoice processing cycle time and aging analysis.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applied to the invoice, including sales tax, VAT, GST, or other applicable taxes based on jurisdiction.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match validation comparing the purchase order, goods receipt, and invoice. Critical control for preventing payment errors and fraud.. Valid values are `Matched|Unmatched|Partially Matched|Exception|Not Applicable`',
    `total_amount` DECIMAL(18,2) COMMENT 'The net total amount due to the vendor after applying taxes, discounts, and adjustments. This is the final payment amount.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts payable invoice record representing a vendor or supplier bill received by the staffing firm for services rendered. Captures vendor reference, invoice number, invoice date, received date, due date, payment terms, invoice amount, tax amount, total amount, currency, GL period, cost center allocation, approval status, approver, approved date, payment status, payment date, and 3-way match status (PO, receipt, invoice). Covers vendor staffing supplier invoices, subcontractor bills, and third-party service provider charges within MSP programs.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'Unique identifier for the accounts payable payment disbursement record. Primary key for the AP payment entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: AP payment should link to accounting period master for proper period management. Currently uses gl_posting_date but no FK to period. No redundant columns to remove as date fields serve operational pur',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: AP payment should link to the AP invoice it pays. This is a critical relationship for payment application tracking. No redundant columns to remove as payment can apply to multiple invoices (would need',
    `bank_account_id` BIGINT COMMENT 'Identifier of the company bank account from which the payment was disbursed. Links to the bank account master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AP payment should link to cost center master for organizational tracking. Currently uses cost_center_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AP payment should link to GL account master for proper accounting classification. Currently uses gl_account_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `payment_batch_id` BIGINT COMMENT 'Identifier of the payment batch or payment run in which this payment was grouped for processing. Null for individual ad-hoc payments.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: AP payments need assigned processor for payment run execution, exception handling, vendor inquiry resolution, and bank file transmission - standard control in staffing AP operations to ensure proper s',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier receiving this payment. Links to the vendor master record.',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_agreement. Business justification: AP payments to vendors should reference the vendor agreement for payment terms validation, spend analysis, and vendor performance tracking. Enables vendor spend reconciliation and payment terms compli',
    `voided_ap_payment_id` BIGINT COMMENT 'Self-referencing FK on ap_payment (voided_ap_payment_id)',
    `ach_trace_number` STRING COMMENT 'The unique trace number assigned by the ACH network to track the electronic payment. Null for non-ACH payment methods.',
    `approval_status` STRING COMMENT 'The approval workflow status of the payment. Indicates whether the payment has been approved for disbursement by authorized personnel.. Valid values are `Pending|Approved|Rejected`',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved the payment for disbursement. Null if payment has not been approved.',
    `approved_date` DATE COMMENT 'The date on which the payment was approved for disbursement. Null if payment has not been approved.',
    `check_number` STRING COMMENT 'The physical check number printed on the check if payment method is check. Null for non-check payment methods.',
    `cleared_date` DATE COMMENT 'The date on which the payment cleared the companys bank account and funds were successfully transferred to the vendor. Null if payment has not yet cleared.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the payment record was first created in the accounts payable system. Represents the initial capture of the payment transaction.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the payment was made (e.g., USD, CAD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total early payment discount amount taken on the invoices settled by this payment. Zero if no discount was applied.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the payment amount to the companys functional currency. Null if payment is in functional currency.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The payment amount converted to the companys functional currency (typically USD) using the exchange rate. Used for consolidated financial reporting.',
    `gl_posting_date` DATE COMMENT 'The accounting period date on which the payment transaction was posted to the general ledger. May differ from payment_date for period-end adjustments.',
    `modified_by` STRING COMMENT 'The username or identifier of the person or system process that last modified the payment record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the payment record was last modified or updated. Used for audit trail and change tracking purposes.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The net amount actually disbursed to the vendor after applying discounts, withholding taxes, and other adjustments. Equals payment_amount minus discount_amount minus withholding_tax_amount.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The total monetary value of the payment disbursed to the vendor in the payment currency. Represents the gross payment amount before any adjustments.',
    `payment_date` DATE COMMENT 'The date on which the payment was issued or scheduled to be disbursed to the vendor. Represents the business event date for the payment transaction.',
    `payment_description` STRING COMMENT 'Free-text description or memo field providing additional context about the payment purpose, invoice references, or special instructions.',
    `payment_method` STRING COMMENT 'The disbursement instrument or mechanism used to make the payment. Common methods include ACH (Automated Clearing House), physical check, wire transfer, virtual card, electronic funds transfer, or cash.. Valid values are `ACH|Check|Wire Transfer|Virtual Card|EFT|Cash`',
    `payment_notes` STRING COMMENT 'Additional free-text notes or comments about the payment for internal reference, audit trail, or special handling instructions.',
    `payment_number` STRING COMMENT 'Business-facing unique payment reference number assigned by the accounts payable system. Used for tracking and reconciliation purposes.',
    `payment_priority` STRING COMMENT 'The processing priority assigned to the payment. Urgent or rush payments may be expedited for faster disbursement.. Valid values are `Standard|Urgent|Rush|Hold`',
    `payment_source_system` STRING COMMENT 'The name or identifier of the source system that originated the payment transaction (e.g., Oracle NetSuite ERP, SAP, manual entry).',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment disbursement. Tracks the payment from scheduling through bank clearance or failure. [ENUM-REF-CANDIDATE: Scheduled|Issued|In Transit|Cleared|Voided|Cancelled|Failed|Returned — 8 candidates stripped; promote to reference product]',
    `payment_terms` STRING COMMENT 'The payment terms code or description applied to this payment (e.g., Net 30, 2/10 Net 30, Due on Receipt). Reflects the negotiated payment terms with the vendor.',
    `reconciled_date` DATE COMMENT 'The date on which the payment was successfully reconciled with bank statements. Null if payment has not been reconciled.',
    `reconciliation_status` STRING COMMENT 'Indicates whether the payment has been reconciled with bank statements and vendor records. Used for cash management and audit purposes.. Valid values are `Unreconciled|Reconciled|Exception`',
    `remittance_email` STRING COMMENT 'The email address to which the remittance advice or payment notification was sent. Used for vendor communication and payment reconciliation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `remittance_sent_date` DATE COMMENT 'The date on which the remittance advice or payment notification was sent to the vendor. Null if remittance has not been sent.',
    `void_date` DATE COMMENT 'The date on which the payment was voided or cancelled. Null if payment has not been voided.',
    `void_reason` STRING COMMENT 'Business reason or explanation for why the payment was voided or cancelled. Null if payment has not been voided.',
    `wire_reference_number` STRING COMMENT 'The unique reference or confirmation number assigned by the bank for wire transfer payments. Null for non-wire payment methods.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of tax withheld from the payment as required by tax regulations. Zero if no withholding tax applies.',
    `created_by` STRING COMMENT 'The username or identifier of the person or system process that created the payment record. Used for audit trail and accountability.',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Accounts payable payment disbursement record capturing each payment made by the staffing firm to a vendor or supplier. Captures payment date, payment method (ACH, check, wire transfer, virtual card), payment amount, currency, exchange rate, bank account, check number or ACH trace number, payment status (scheduled, issued, cleared, voided), void date, void reason, and associated AP invoices settled. Tracks the full disbursement lifecycle from payment scheduling through bank clearance for vendor and supplier payments.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` (
    `revenue_recognition_event_id` BIGINT COMMENT 'Unique identifier for the revenue recognition event record. Primary key for this entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Revenue recognition event should link to accounting period master for proper period management. Currently uses gl_period (STRING), fiscal_year (INT), and fiscal_quarter (STRING) which should be normal',
    `assignment_id` BIGINT COMMENT 'Reference to the placement or assignment that generated this revenue recognition event. Links to temporary or permanent placement records.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for which revenue is being recognized. Enables revenue reporting by client.',
    `msa_id` BIGINT COMMENT 'Reference to the master service agreement or contract governing this revenue recognition event.',
    `conversion_id` BIGINT COMMENT 'Foreign key linking to placement.conversion. Business justification: Conversion fees are revenue recognition events under ASC 606. Finance tracks which conversion generated each revenue event for compliance, reporting, and minimum tenure/guarantee period revenue recogn',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue recognition event should link to cost center master for organizational tracking. Currently uses cost_center (STRING) which should be normalized to FK. Removes redundant string column.',
    `credit_memo_id` BIGINT COMMENT 'Foreign key linking to billing.credit_memo. Business justification: Credit memos trigger revenue recognition adjustments. Required for ASC 606 compliance and accurate revenue reporting.',
    `direct_hire_id` BIGINT COMMENT 'Foreign key linking to placement.direct_hire. Business justification: Direct hire fees are recognized as revenue events under ASC 606. Finance teams must track which direct hire placement generated each revenue recognition event for compliance, fee revenue reporting, an',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue recognition event should link to GL account master for proper accounting classification. Currently uses gl_account_code (STRING) which should be normalized to FK. Removes redundant code column',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice associated with this revenue recognition event. Links billing to revenue recognition.',
    `original_event_revenue_recognition_event_id` BIGINT COMMENT 'Reference to the original revenue recognition event if this is a reversal or adjustment. Maintains audit trail for revenue corrections.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: Revenue recognition events require assigned accountant for ASC 606 compliance review, performance obligation assessment, milestone verification, and audit trail documentation - critical for staffing f',
    `sow_engagement_id` BIGINT COMMENT 'Reference to the SOW engagement that generated this revenue recognition event. Used for project-based or RPO engagements.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Revenue recognition events must tie to SOWs for ASC 606 compliance, performance obligation tracking, and revenue waterfall reporting. SOW is the contract vehicle defining performance obligations; crit',
    `reversal_revenue_recognition_event_id` BIGINT COMMENT 'Self-referencing FK on revenue_recognition_event (reversal_revenue_recognition_event_id)',
    `adjustment_reason` STRING COMMENT 'Explanation for why this revenue recognition event was reversed or adjusted. Required for audit and compliance purposes.',
    `approved_by` STRING COMMENT 'The user or role who approved this revenue recognition event for posting to the general ledger.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this revenue recognition event was approved for posting.',
    `billed_amount` DECIMAL(18,2) COMMENT 'The amount billed to the client associated with this revenue recognition event. May differ from recognized revenue due to timing differences.',
    `contract_liability_amount` DECIMAL(18,2) COMMENT 'The total contract liability balance after this recognition event. Represents the obligation to transfer goods or services for which payment has been received.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this revenue recognition event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this revenue recognition event.. Valid values are `^[A-Z]{3}$`',
    `deferred_revenue_amount` DECIMAL(18,2) COMMENT 'The amount of revenue deferred to future periods. Represents unearned revenue for services not yet delivered.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate used to convert foreign currency amounts to the reporting currency. Applied at recognition date.',
    `milestone_description` STRING COMMENT 'Description of the milestone achieved that triggered this revenue recognition event. Used for milestone-based revenue recognition.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this revenue recognition event record was last modified.',
    `notes` STRING COMMENT 'Additional notes or comments regarding this revenue recognition event. Used for documentation and audit purposes.',
    `percentage_complete` DECIMAL(18,2) COMMENT 'The percentage of the performance obligation completed at the time of this recognition event. Used for percentage-of-completion revenue recognition method.',
    `performance_obligation_reference` STRING COMMENT 'Reference identifier for the specific performance obligation being satisfied. Links to contract terms and deliverables.',
    `posted_timestamp` TIMESTAMP COMMENT 'The date and time when this revenue recognition event was posted to the general ledger.',
    `recognition_date` DATE COMMENT 'The date on which revenue is recognized in the general ledger. Represents the point in time when the performance obligation is satisfied per ASC 606.',
    `recognition_event_number` STRING COMMENT 'Human-readable business identifier for the revenue recognition event. Format: RRE-YYYYMMDD-NNNNNN.. Valid values are `^RRE-[0-9]{8}-[0-9]{6}$`',
    `recognition_method` STRING COMMENT 'The method used to recognize revenue for this event. Determines how and when revenue is recorded based on the nature of the performance obligation.. Valid values are `time_and_materials|milestone|percentage_of_completion|fixed_fee|point_in_time|over_time`',
    `recognition_status` STRING COMMENT 'The current status of the revenue recognition event in the approval and posting workflow.. Valid values are `draft|pending_approval|approved|posted|reversed|adjusted`',
    `recognized_revenue_amount` DECIMAL(18,2) COMMENT 'The amount of revenue recognized in this event. Represents the portion of contract value earned during the service period.',
    `revenue_category` STRING COMMENT 'The category of staffing revenue being recognized. Enables revenue reporting by service line.. Valid values are `temporary_staffing|permanent_placement|contract_staffing|sow_project|rpo_services|payroll_services`',
    `revenue_stream` STRING COMMENT 'The specific revenue stream or product line generating this revenue. Provides granular revenue segmentation.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition event is a reversal of a previously recognized amount. True if this is a reversal entry.',
    `service_period_end_date` DATE COMMENT 'The end date of the service period for which revenue is being recognized. Defines the period over which services were delivered.',
    `service_period_start_date` DATE COMMENT 'The start date of the service period for which revenue is being recognized. Used for time-and-materials and contract placements.',
    `source_system` STRING COMMENT 'The operational system that originated this revenue recognition event. Typically Oracle NetSuite ERP or Salesforce Revenue Cloud.',
    `source_system_code` STRING COMMENT 'The unique identifier of this revenue recognition event in the source system. Enables traceability back to the originating system.',
    `unbilled_receivable_amount` DECIMAL(18,2) COMMENT 'The amount of revenue recognized but not yet billed to the client. Represents contract asset for services delivered but not invoiced.',
    CONSTRAINT pk_revenue_recognition_event PRIMARY KEY(`revenue_recognition_event_id`)
) COMMENT 'Revenue recognition event record capturing the point-in-time recognition of staffing revenue in accordance with ASC 606 / IFRS 15. Captures recognition date, recognition method (time-and-materials, milestone, percentage-of-completion, fixed-fee), recognized revenue amount, deferred revenue amount, contract liability amount, performance obligation reference, placement or SOW engagement reference, GL period, cost center, and recognition status. Ensures revenue is recognized in the correct period as performance obligations are satisfied — critical for staffing firms with temp, contract, and SOW billing models.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` (
    `deferred_revenue_id` BIGINT COMMENT 'Unique identifier for the deferred revenue liability record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Deferred revenue should link to accounting period master for proper period management. Currently uses reporting_period (STRING) and fiscal_year (INT) which should be normalized to FK. Removes redundan',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: Deferred revenue balances need assigned analyst for monthly recognition calculations, contract term review, performance obligation tracking, and balance sheet reconciliation - essential for staffing f',
    `client_account_id` BIGINT COMMENT 'Reference to the client account that generated this deferred revenue liability.',
    `msa_id` BIGINT COMMENT 'Reference to the master service agreement, statement of work, or contract under which this deferred revenue was generated.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Deferred revenue should link to cost center master for organizational tracking. Currently uses cost_center_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `credit_memo_id` BIGINT COMMENT 'Foreign key linking to billing.credit_memo. Business justification: Credit memos may reduce deferred revenue balances. Essential for accurate liability tracking and revenue recognition schedules.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Deferred revenue should link to GL account master for proper accounting classification. Currently uses gl_account_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice that generated this deferred revenue liability, if applicable.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Deferred revenue schedules must reference the SOW for performance obligation tracking, revenue waterfall reporting, and ASC 606 compliance. SOW defines the service delivery terms that drive revenue re',
    `prior_deferred_revenue_id` BIGINT COMMENT 'Self-referencing FK on deferred_revenue (prior_deferred_revenue_id)',
    `arrangement_type` STRING COMMENT 'Type of revenue arrangement that generated this deferred revenue: retainer (ongoing advisory), prepaid staffing contract, statement of work fixed-fee engagement, recruitment process outsourcing program fee, managed service provider program fee, or other.. Valid values are `retainer|prepaid_staffing|sow_fixed_fee|rpo_program|msp_program|other`',
    `audit_trail_notes` STRING COMMENT 'Audit notes documenting adjustments, corrections, or significant changes to this deferred revenue record.',
    `billing_frequency` STRING COMMENT 'Frequency at which the client is billed for this arrangement: one-time upfront, monthly, quarterly, semi-annual, annual, or milestone-based.. Valid values are `one_time|monthly|quarterly|semi_annual|annual|milestone_based`',
    `contract_term_months` STRING COMMENT 'Total duration of the contract or arrangement in months over which revenue will be recognized.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this deferred revenue liability record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record.. Valid values are `^[A-Z]{3}$`',
    `deferred_amount` DECIMAL(18,2) COMMENT 'Total amount of revenue deferred at inception of the liability, representing cash received or billed but not yet earned.',
    `is_refundable` BOOLEAN COMMENT 'Indicates whether the deferred revenue is refundable to the client if the contract is terminated early or performance obligations are not met.',
    `last_recognition_date` DATE COMMENT 'Date of the most recent revenue recognition transaction against this deferred revenue liability.',
    `liability_status` STRING COMMENT 'Current status of the deferred revenue liability: active (ongoing recognition), fully recognized (all revenue earned), partially recognized (in progress), reversed (adjustment or refund), or cancelled (contract terminated).. Valid values are `active|fully_recognized|partially_recognized|reversed|cancelled`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this deferred revenue liability record was last modified.',
    `monthly_recognition_amount` DECIMAL(18,2) COMMENT 'Standard monthly revenue recognition amount for straight-line recognition schedules.',
    `next_recognition_date` DATE COMMENT 'Scheduled date for the next revenue recognition transaction against this deferred revenue liability.',
    `performance_obligation_description` STRING COMMENT 'Description of the performance obligation or service deliverable that must be satisfied before revenue can be recognized under ASC 606.',
    `period_end_balance` DECIMAL(18,2) COMMENT 'Deferred revenue liability balance as of the end of the reporting period, used for financial statement reporting.',
    `recognition_end_date` DATE COMMENT 'Date when revenue recognition is scheduled to complete for this deferred revenue liability. Null for open-ended arrangements.',
    `recognition_method_notes` STRING COMMENT 'Additional notes or details about the revenue recognition method, including any special considerations, milestones, or performance criteria.',
    `recognition_schedule_type` STRING COMMENT 'Method by which deferred revenue is recognized over time: straight-line (ratable over period), milestone (upon achievement of deliverables), usage-based (as services consumed), time and materials (as hours worked), performance obligation (ASC 606 specific obligations), or event-driven (upon specific trigger).. Valid values are `straight_line|milestone|usage_based|time_and_materials|performance_obligation|event_driven`',
    `recognition_start_date` DATE COMMENT 'Date when revenue recognition begins for this deferred revenue liability.',
    `recognized_to_date_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of revenue recognized from this deferred revenue liability as of the current reporting period.',
    `remaining_deferred_balance` DECIMAL(18,2) COMMENT 'Current outstanding deferred revenue liability balance, calculated as deferred amount minus recognized to date amount.',
    `revenue_category` STRING COMMENT 'Category of revenue stream this deferred revenue represents: placement fee, staffing services, recruitment process outsourcing services, managed service provider services, consulting, training, or other. [ENUM-REF-CANDIDATE: placement_fee|staffing_services|rpo_services|msp_services|consulting|training|other — 7 candidates stripped; promote to reference product]',
    `reversal_date` DATE COMMENT 'Date when the deferred revenue liability was reversed or cancelled, if applicable.',
    `reversal_reason` STRING COMMENT 'Reason for reversal or cancellation of the deferred revenue liability, if applicable (e.g., contract termination, client refund, billing error).',
    `service_line` STRING COMMENT 'Business service line that generated this deferred revenue: temporary staffing, permanent placement, contract staffing, executive search, recruitment process outsourcing, managed service provider, payroll services, or workforce consulting. [ENUM-REF-CANDIDATE: temporary_staffing|permanent_placement|contract_staffing|executive_search|rpo|msp|payroll_services|workforce_consulting — 8 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'Source system from which this deferred revenue record originated: Oracle NetSuite ERP, Salesforce Revenue Cloud, manual entry, or other.. Valid values are `netsuite_erp|salesforce_revenue_cloud|manual_entry|other`',
    `source_system_code` STRING COMMENT 'Unique identifier for this deferred revenue record in the source system of record.',
    CONSTRAINT pk_deferred_revenue PRIMARY KEY(`deferred_revenue_id`)
) COMMENT 'Deferred revenue liability record tracking revenue received or billed but not yet earned under ASC 606 / IFRS 15 for the staffing enterprise. Captures client reference, contract reference, deferred amount, recognition start date, recognition end date, recognition schedule type (straight-line, milestone, usage-based), recognized-to-date amount, remaining deferred balance, GL account, cost center, and period-end balance. Applies to retainer arrangements, prepaid staffing contracts, SOW fixed-fee engagements, and RPO program fees billed in advance.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique identifier for the intercompany transaction record. Primary key for this entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Intercompany transaction should link to accounting period master for proper period management. Currently uses accounting_period (STRING) and fiscal_year (INT) which should be normalized to FK. Removes',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Intercompany transaction should link to cost center master for organizational tracking. Currently uses cost_center_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `original_transaction_intercompany_transaction_id` BIGINT COMMENT 'Reference to the original intercompany transaction ID if this record is a reversal, adjustment, or correction of a prior transaction.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Intercompany transaction should link to GL account master for the originating side. Currently uses originating_gl_account_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity initiating or originating the intercompany transaction (the entity being charged or providing the service/funding).',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: Intercompany transactions require assigned preparer for transfer pricing documentation, intercompany reconciliation, elimination entry preparation, and audit support - required for multi-entity staffi',
    `receiving_legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity receiving the intercompany transaction (the entity receiving the charge, service, or funding).',
    `reversal_intercompany_transaction_id` BIGINT COMMENT 'Self-referencing FK on intercompany_transaction (reversal_intercompany_transaction_id)',
    `approval_status` STRING COMMENT 'Current approval workflow status of the intercompany transaction indicating whether it has been reviewed and approved by authorized personnel.. Valid values are `draft|pending_approval|approved|rejected|cancelled`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the intercompany transaction, required for audit trail and internal controls.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction was approved, used for audit trail and compliance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was first created in the system.',
    `department_code` STRING COMMENT 'The department code associated with the intercompany transaction, identifying the organizational unit responsible for or benefiting from the transaction.',
    `elimination_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this intercompany transaction should be eliminated during the consolidation process to avoid double-counting in consolidated financial statements.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the transaction amount from the transaction currency to the reporting currency for consolidation purposes.',
    `intercompany_transaction_description` STRING COMMENT 'Detailed narrative description of the intercompany transaction, including the business purpose, service provided, or nature of the charge.',
    `invoice_number` STRING COMMENT 'The invoice number associated with the intercompany transaction, if an intercompany invoice was generated to document the charge.',
    `is_reversal` BOOLEAN COMMENT 'Boolean flag indicating whether this transaction is a reversal or correction of a previously recorded intercompany transaction.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was last modified or updated.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the intercompany transaction, used for clarification or special instructions.',
    `payment_date` DATE COMMENT 'The date on which the intercompany transaction was settled or paid, if applicable.',
    `payment_status` STRING COMMENT 'Current payment status of the intercompany transaction indicating whether the amount has been settled between the legal entities.. Valid values are `unpaid|partially_paid|paid|waived|written_off`',
    `payment_terms` STRING COMMENT 'The payment terms governing the settlement of the intercompany transaction (e.g., Net 30, Due on Receipt, Quarterly Settlement).',
    `project_code` STRING COMMENT 'Optional project or job code associated with the intercompany transaction, used when the transaction relates to a specific project or client engagement.',
    `receiving_gl_account_code` STRING COMMENT 'The general ledger account code in the receiving legal entitys chart of accounts where this intercompany transaction is recorded.',
    `reconciled_by` STRING COMMENT 'Name or identifier of the person who reconciled the intercompany transaction between the originating and receiving entities.',
    `reconciled_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction was reconciled, used for audit trail and period-end close tracking.',
    `reconciliation_status` STRING COMMENT 'Current status of the intercompany reconciliation process indicating whether the transaction has been matched and reconciled between the originating and receiving entities.. Valid values are `matched|unmatched|pending|exception|resolved`',
    `reporting_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the reporting currency using the applicable exchange rate, used for consolidated financial reporting.',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the consolidated reporting currency for the enterprise group.. Valid values are `^[A-Z]{3}$`',
    `source_system_code` STRING COMMENT 'Code identifying the source system or module from which the intercompany transaction originated (e.g., NetSuite, SAP, manual entry).',
    `source_transaction_reference` STRING COMMENT 'The unique transaction identifier from the source system, used for traceability and audit purposes.',
    `tax_jurisdiction` STRING COMMENT 'The tax jurisdiction or country code relevant to the intercompany transaction for transfer pricing and tax reporting purposes.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary value of the intercompany transaction in the transaction currency, representing the gross amount before any adjustments.',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the intercompany transaction was denominated.. Valid values are `^[A-Z]{3}$`',
    `transaction_date` DATE COMMENT 'The business date on which the intercompany transaction occurred or was recognized for accounting purposes.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number or reference code for the intercompany transaction, used for tracking and reconciliation purposes.',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction indicating the nature of the financial activity between legal entities. [ENUM-REF-CANDIDATE: shared_service_charge|management_fee|intercompany_loan|dividend|royalty|interest|payroll_funding|cost_allocation|transfer_pricing|other — 10 candidates stripped; promote to reference product]',
    `transfer_pricing_method` STRING COMMENT 'The transfer pricing methodology applied to determine the arms length price for the intercompany transaction, required for tax compliance. [ENUM-REF-CANDIDATE: comparable_uncontrolled_price|resale_price|cost_plus|profit_split|transactional_net_margin|other|not_applicable — 7 candidates stripped; promote to reference product]',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax applied to the intercompany transaction, if applicable based on cross-border tax regulations.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'The withholding tax rate percentage applied to the intercompany transaction based on applicable tax treaties or regulations.',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Intercompany transaction record capturing financial activity between legal entities within the staffing enterprise group — including shared service charges, management fee allocations, intercompany loans, and cross-entity payroll funding. Captures originating entity, receiving entity, transaction type (charge, allocation, loan, dividend), transaction date, amount, currency, exchange rate, GL accounts on both sides, elimination flag, reconciliation status, and approval status. Essential for consolidated financial reporting and intercompany elimination during period-end close.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key for the budget entity.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: Budgets need designated approver for annual budget authorization, mid-year revision approval, and variance accountability - standard budgeting process in staffing firms. Reuses existing approved_by na',
    `business_unit_id` BIGINT COMMENT 'Identifier of the business unit, division, branch, or cost center that owns this budget. Enables budget tracking at organizational hierarchy levels (enterprise, division, branch).',
    `client_account_id` BIGINT COMMENT 'Foreign key linking to client.client_account. Business justification: Client-specific budgets (key account revenue targets, client-specific cost budgets) need client linkage for account planning and performance tracking. Essential for strategic account management and cl',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget should link to cost center master for organizational tracking. Currently uses cost_center_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Budget should be scoped to a legal entity for proper financial planning and consolidation. No redundant columns to remove as budget does not currently have legal_entity_code.',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: Managed programs require budgets for MSP fees, program overhead, and revenue targets. Critical for program financial planning and performance management in staffing MSP operations.',
    `parent_budget_id` BIGINT COMMENT 'Identifier of the parent or master budget from which this budget is derived. Supports hierarchical budget structures where enterprise budgets roll up from division or branch budgets.',
    `vms_program_id` BIGINT COMMENT 'Foreign key linking to client.vms_program. Business justification: VMS programs have dedicated budgets for program costs and revenue targets. Essential for program financial planning, budget vs actual tracking, and program profitability management. Standard practice ',
    `revised_budget_id` BIGINT COMMENT 'Self-referencing FK on budget (revised_budget_id)',
    `allocation_method` STRING COMMENT 'The method used to allocate or distribute this budget across organizational units or time periods. Direct allocation assigns to a single entity, proportional spreads by percentage, activity-based allocates by usage, headcount allocates by FTE count, and revenue allocates by revenue contribution.. Valid values are `direct|proportional|activity_based|headcount|revenue`',
    `approval_date` DATE COMMENT 'The date on which this budget was formally approved by the authorized approver. Establishes the official start of budget enforcement.',
    `budget_category` STRING COMMENT 'High-level financial category of the budget. Revenue tracks income targets, gross margin tracks profitability, SG&A (Selling, General & Administrative) tracks operating expenses, COGS (Cost of Goods Sold) tracks direct costs, payroll tracks compensation, recruiting tracks talent acquisition costs, overhead tracks indirect costs, and other captures miscellaneous items. [ENUM-REF-CANDIDATE: revenue|gross_margin|sga|cogs|payroll|recruiting|overhead|other — 8 candidates stripped; promote to reference product]',
    `budget_name` STRING COMMENT 'Human-readable name or title of the budget (e.g., FY2024 Operating Budget, Q2 Headcount Plan, Branch Expansion Capital Budget). Provides business context and identification.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget. Draft indicates work in progress, submitted indicates pending approval, approved indicates executive sign-off, locked indicates no further changes allowed, rejected indicates not approved, and archived indicates historical record.. Valid values are `draft|submitted|approved|locked|rejected|archived`',
    `budget_type` STRING COMMENT 'Classification of the budget by its purpose. Operating budgets cover day-to-day expenses, capital budgets cover long-term investments, headcount budgets track FTE (Full-Time Equivalent) planning, revenue budgets track income targets, expense budgets track cost allocations, and project budgets track initiative-specific funding.. Valid values are `operating|capital|headcount|revenue|expense|project`',
    `budgeted_amount` DECIMAL(18,2) COMMENT 'The planned or allocated monetary amount for this budget line. Represents the financial target or limit for the specified period, account, and organizational unit.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was first created in the system. Provides audit trail for budget lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budgeted amount (e.g., USD, EUR, GBP). Supports multi-currency budget management for international operations.. Valid values are `^[A-Z]{3}$`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget applies (e.g., 2024, 2025). Represents the annual financial planning period.',
    `headcount_fte` DECIMAL(18,2) COMMENT 'The budgeted headcount expressed in Full-Time Equivalents. Used for workforce planning budgets to track planned staffing levels. Supports fractional FTE for part-time or contract roles.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this budget is currently active and in use. True for active budgets, false for superseded or archived budgets.',
    `is_capital_expenditure` BOOLEAN COMMENT 'Boolean flag indicating whether this budget line represents a capital expenditure (CapEx) rather than an operating expense (OpEx). True for long-term asset investments, false for day-to-day operational costs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was last updated or modified. Tracks the most recent change for audit and version control purposes.',
    `modified_by` STRING COMMENT 'Name or identifier of the user who last modified this budget record. Provides accountability for budget changes.',
    `notes` STRING COMMENT 'Free-text notes, comments, or justifications related to this budget. Captures assumptions, rationale for amounts, special conditions, or variance explanations.',
    `owner` STRING COMMENT 'Name or identifier of the individual responsible for managing and monitoring this budget (e.g., department head, branch manager, finance controller). Accountable for budget performance.',
    `period` STRING COMMENT 'The time granularity of the budget (annual, quarterly, monthly, or weekly). Defines the planning and reporting frequency.. Valid values are `annual|quarterly|monthly|weekly`',
    `period_end_date` DATE COMMENT 'The end date of the budget period. Defines when the budget expires or is superseded.',
    `period_start_date` DATE COMMENT 'The start date of the budget period. Defines when the budget becomes effective.',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'The acceptable variance percentage threshold for this budget line (e.g., 5.00 for 5%). Used to trigger alerts or reviews when actual spending deviates from budget by more than this threshold.',
    `version` STRING COMMENT 'Version or iteration of the budget. Tracks whether this is the original approved budget, a revised budget after adjustments, a forecast update, or actual results for comparison.. Valid values are `original|revised|forecast|actual`',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Annual or periodic financial budget master record for the staffing enterprise. Captures budget name, budget version (original, revised, forecast), fiscal year, budget period, budget type (operating, capital, headcount), owning cost center or business unit, GL account, budgeted amount, currency, budget status (draft, approved, locked), approved by, approval date, and budget notes. Supports branch-level, division-level, and enterprise-level budget management for revenue, gross margin, SG&A, and headcount planning.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique identifier for the budget line item record. Primary key for the budget line entity.',
    `budget_id` BIGINT COMMENT 'Reference to the parent budget header that this line item belongs to. Links to the master budget record.',
    `client_account_id` BIGINT COMMENT 'Foreign key linking to client.client_account. Business justification: Budget lines for client-specific revenue or cost targets need client attribution for detailed account-level budget tracking and variance analysis. Enables granular financial planning by client in staf',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `department_id` BIGINT COMMENT 'FK to employee.department',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: Budget lines for managed program costs/fees require program attribution for detailed program budget tracking. Enables granular financial planning and variance analysis for MSP programs.',
    `vms_program_id` BIGINT COMMENT 'Foreign key linking to client.vms_program. Business justification: Budget lines for program-specific costs/revenue need program linkage for detailed program budget management and variance analysis. Essential for granular VMS program financial planning and control.',
    `prior_budget_line_id` BIGINT COMMENT 'Self-referencing FK on budget_line (prior_budget_line_id)',
    `allocation_basis` STRING COMMENT 'The methodology or driver used to allocate this budget amount. Indicates whether the budget was allocated based on headcount, revenue projections, facility size, transaction volume, historical trends, or strategic initiatives.. Valid values are `headcount|revenue|square_footage|transaction_volume|historical|strategic`',
    `approval_status` STRING COMMENT 'The current approval status of this budget line within the budget approval workflow. Tracks the lifecycle state from draft through final approval.. Valid values are `draft|pending|approved|rejected|revised`',
    `approved_by` STRING COMMENT 'The username or identifier of the person who approved this budget line. Provides audit trail for budget authorization.',
    `approved_date` DATE COMMENT 'The date on which this budget line was approved. Provides temporal audit trail for budget authorization.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The planned or allocated budget amount for this GL account and cost center combination for the specified period. Represents the financial target or constraint.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget line record was first created in the system. Provides audit trail for budget line origination.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the budget amount (e.g., USD, EUR, GBP). Enables multi-currency budget management.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date from which this budget line version becomes effective. Supports temporal tracking of budget changes throughout the fiscal year.',
    `fiscal_period` STRING COMMENT 'The fiscal period within the year to which this budget line applies. Values include Q1-Q4 for quarterly, M01-M12 for monthly, or FY for full year.. Valid values are `^(Q[1-4]|M(0[1-9]|1[0-2])|FY)$`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget line applies. Four-digit year representation (e.g., 2024).',
    `is_discretionary` BOOLEAN COMMENT 'Indicates whether this budget line represents discretionary spending that can be adjusted or deferred. True means the expense is optional; False means it is mandatory or committed.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether this budget line is locked from further edits. True means the line is finalized and cannot be modified without special approval; False means it is still editable.',
    `last_updated_by` STRING COMMENT 'The username or identifier of the person who last modified this budget line record. Provides accountability for budget changes.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget line record was last modified. Provides audit trail for budget maintenance and change tracking.',
    `line_sequence` STRING COMMENT 'The sequential order of this line item within the parent budget. Used for sorting and display purposes in budget reports.',
    `period_end_date` DATE COMMENT 'The end date of the fiscal period covered by this budget line. Defines the temporal boundary for budget applicability.',
    `period_start_date` DATE COMMENT 'The start date of the fiscal period covered by this budget line. Enables time-series analysis and period-over-period comparisons.',
    `prior_year_actual_amount` DECIMAL(18,2) COMMENT 'The actual amount spent or earned in the same period of the prior fiscal year. Used for year-over-year variance analysis and budget benchmarking.',
    `service_line_code` STRING COMMENT 'The service line or business unit code (e.g., temporary staffing, permanent placement, RPO) to which this budget line is allocated. Enables budget analysis by revenue stream.. Valid values are `^[A-Z0-9]{2,8}$`',
    `variance_to_prior_year` DECIMAL(18,2) COMMENT 'The calculated variance between the current budget amount and the prior year actual amount. Positive values indicate budget increase, negative values indicate decrease.',
    `variance_to_prior_year_percent` DECIMAL(18,2) COMMENT 'The percentage variance between the current budget amount and the prior year actual amount. Calculated as (budget_amount - prior_year_actual_amount) / prior_year_actual_amount * 100.',
    `version_number` STRING COMMENT 'The version number of this budget line. Increments with each revision to support budget versioning and historical comparison (e.g., original budget vs. revised budget vs. final budget).',
    `created_by` STRING COMMENT 'The username or identifier of the person who created this budget line record. Provides accountability for budget line origination.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Individual line-item record within a financial budget, capturing the granular GL account and cost center level budget allocation. Captures budget reference, GL account, cost center, department, period (monthly/quarterly), budgeted amount, prior year actual amount, variance to prior year, budget notes, and last updated timestamp. Enables detailed budget-vs-actual variance analysis at the account and cost center level across branches, divisions, and service lines.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the bank account record. Primary key for the bank account entity.',
    `administrator_staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: Bank accounts need assigned administrator for signatory management, online banking access control, reconciliation oversight, and bank relationship coordination - treasury management standard in staffi',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Bank account should link to GL account master for the cash account. Currently uses gl_cash_account_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that owns this bank account. Links to the legal entity master for corporate structure and ownership tracking.',
    `master_account_bank_account_id` BIGINT COMMENT 'Reference to the master concentration account if this is a zero balance account or subsidiary account in a cash pooling structure. Null for standalone accounts.',
    `modified_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who last modified this bank account record in the system.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the user who created this bank account record in the system.',
    `parent_bank_account_id` BIGINT COMMENT 'Self-referencing FK on bank_account (parent_bank_account_id)',
    `account_closed_date` DATE COMMENT 'The date when the bank account was closed. Null for active accounts.',
    `account_name` STRING COMMENT 'The official name or title of the bank account as registered with the financial institution. Used for identification and reconciliation purposes.',
    `account_number` STRING COMMENT 'The bank account number. Should be stored in masked or encrypted format for security. Full account number access restricted to authorized treasury and finance personnel only.',
    `account_number_last_four` STRING COMMENT 'Last four digits of the bank account number for display and reference purposes without exposing full account details.. Valid values are `^[0-9]{4}$`',
    `account_opened_date` DATE COMMENT 'The date when the bank account was originally opened with the financial institution.',
    `account_status` STRING COMMENT 'Current operational status of the bank account. Active accounts are in use, dormant accounts have no recent activity, closed accounts are terminated, frozen accounts are temporarily restricted, and pending activation accounts are awaiting setup completion.. Valid values are `active|dormant|closed|frozen|pending_activation`',
    `account_type` STRING COMMENT 'Classification of the bank account by its business purpose. Operating accounts handle general business transactions, payroll accounts fund employee and contractor payments, trust accounts hold client funds, concentration accounts aggregate cash from multiple sources, escrow accounts hold funds pending conditions, and tax reserve accounts segregate funds for tax obligations.. Valid values are `operating|payroll|trust|concentration|escrow|tax_reserve`',
    `ach_enabled` BOOLEAN COMMENT 'Indicates whether the account is enabled for ACH transactions. Critical for payroll processing and vendor payments in staffing operations.',
    `available_balance_amount` DECIMAL(18,2) COMMENT 'The available balance in the account after accounting for holds, pending transactions, and reserved funds. Represents funds available for immediate use.',
    `bank_branch_address` STRING COMMENT 'The physical address of the bank branch where the account is held. Includes street address, city, state, and postal code.',
    `bank_branch_name` STRING COMMENT 'The name of the specific bank branch where the account is maintained.',
    `bank_contact_email` STRING COMMENT 'The email address of the bank relationship manager or primary contact for account communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `bank_contact_name` STRING COMMENT 'The name of the primary bank relationship manager or contact person for this account.',
    `bank_contact_phone` STRING COMMENT 'The phone number of the bank relationship manager or primary contact for account inquiries and support.',
    `bank_name` STRING COMMENT 'The legal name of the financial institution where the account is held.',
    `bank_routing_number` STRING COMMENT 'The nine-digit American Bankers Association (ABA) Routing Transit Number (RTN) that identifies the financial institution for electronic funds transfers, ACH transactions, and wire transfers.. Valid values are `^[0-9]{9}$`',
    `bank_swift_code` STRING COMMENT 'The Society for Worldwide Interbank Financial Telecommunication (SWIFT) Bank Identifier Code (BIC) used for international wire transfers and cross-border payments. Required for accounts used in international operations.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the denomination of the account (e.g., USD for US Dollar, CAD for Canadian Dollar, GBP for British Pound).. Valid values are `^[A-Z]{3}$`',
    `current_balance_amount` DECIMAL(18,2) COMMENT 'The current balance in the bank account as of the last reconciliation or update. Used for cash management and liquidity monitoring.',
    `daily_transaction_limit_amount` DECIMAL(18,2) COMMENT 'The maximum total amount of transactions allowed per day. Used for fraud prevention and cash management controls.',
    `interest_bearing` BOOLEAN COMMENT 'Indicates whether the account earns interest on deposited funds.',
    `interest_rate_percent` DECIMAL(18,2) COMMENT 'The annual interest rate percentage earned on the account balance. Null for non-interest-bearing accounts.',
    `last_reconciliation_date` DATE COMMENT 'The date when the bank account was last reconciled against bank statements. Critical for financial controls and audit compliance.',
    `last_statement_date` DATE COMMENT 'The date of the most recent bank statement received for this account.',
    `minimum_balance_required` DECIMAL(18,2) COMMENT 'The minimum balance that must be maintained in the account to avoid fees or meet banking agreement terms. Zero if no minimum balance requirement exists.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was last modified in the system.',
    `monthly_service_fee_amount` DECIMAL(18,2) COMMENT 'The monthly service fee charged by the bank for maintaining this account. Zero if no monthly fee applies.',
    `notes` STRING COMMENT 'Free-form notes and comments about the bank account, including special instructions, restrictions, or historical context.',
    `online_banking_enabled` BOOLEAN COMMENT 'Indicates whether online banking access is enabled for this account.',
    `overdraft_limit_amount` DECIMAL(18,2) COMMENT 'The maximum overdraft or line of credit amount authorized by the bank for this account. Zero if no overdraft facility exists.',
    `positive_pay_enabled` BOOLEAN COMMENT 'Indicates whether positive pay fraud prevention service is enabled. Positive pay matches issued checks against presented checks to prevent fraud.',
    `primary_signatory_name` STRING COMMENT 'The name of the primary authorized signatory on the bank account. Typically a senior finance or treasury officer.',
    `secondary_signatory_name` STRING COMMENT 'The name of the secondary authorized signatory on the bank account. Provides backup authorization capability.',
    `signatory_requirement` STRING COMMENT 'The authorization requirement for transactions on this account. Single requires one signatory, dual requires two specific signatories, any two requires any two authorized signatories, and all requires all signatories.. Valid values are `single|dual|any_two|all`',
    `transaction_limit_amount` DECIMAL(18,2) COMMENT 'The maximum amount for a single transaction without requiring additional approval. Used for fraud prevention and internal controls.',
    `wire_transfer_enabled` BOOLEAN COMMENT 'Indicates whether the account is enabled for domestic and international wire transfers.',
    `zero_balance_account` BOOLEAN COMMENT 'Indicates whether this is a zero balance account that automatically sweeps funds to or from a master concentration account. Common in multi-account treasury structures.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Corporate bank account master record for all bank accounts maintained by the staffing enterprise. Captures bank name, bank routing number, account number (masked), account type (operating, payroll, trust, concentration), currency, legal entity owner, account status (active, dormant, closed), signatory list, overdraft limit, and associated GL cash account. Covers operating accounts, payroll funding accounts, client trust accounts, and concentration accounts used across the staffing firms treasury operations.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` (
    `bank_transaction_id` BIGINT COMMENT 'Unique identifier for the bank transaction record. Primary key for the bank transaction entity.',
    `accounting_period_id` BIGINT COMMENT 'Reference to the accounting period to which this bank transaction is assigned based on posting_date. Used for period-based financial reporting and reconciliation.',
    `bank_account_id` BIGINT COMMENT 'Reference to the corporate bank account on which this transaction occurred. Links to the bank account master record.',
    `bank_reconciliation_id` BIGINT COMMENT 'Foreign key linking to finance.bank_reconciliation. Business justification: Bank transaction should link to the bank reconciliation that matched it. This tracks which reconciliation process cleared the transaction. No redundant columns to remove as reconciliation_status and r',
    `journal_entry_line_id` BIGINT COMMENT 'Reference to the general ledger transaction or journal entry that this bank transaction has been matched to during the reconciliation process. Null if unreconciled.',
    `legal_entity_id` BIGINT COMMENT 'FK to finance.legal_entity',
    `staff_profile_id` BIGINT COMMENT 'Reference to the user who performed the reconciliation and matched this bank transaction to the general ledger. Used for audit trail and accountability.',
    `reversed_transaction_bank_transaction_id` BIGINT COMMENT 'Reference to the original bank transaction that this entry reverses. Null if this is not a reversal transaction.',
    `reversal_bank_transaction_id` BIGINT COMMENT 'Self-referencing FK on bank_transaction (reversal_bank_transaction_id)',
    `ach_trace_number` STRING COMMENT 'The unique trace number assigned to ACH (Automated Clearing House) transactions. Used for ACH transaction tracking, reconciliation, and dispute resolution.',
    `bank_reference_number` STRING COMMENT 'The banks internal reference or trace number for this transaction. May differ from transaction_number and is used for bank inquiry and dispute resolution.',
    `bank_transaction_description` STRING COMMENT 'The narrative description of the transaction as provided by the bank. Includes payee/payor name, invoice references, or other identifying information from the bank statement.',
    `batch_number` STRING COMMENT 'The identifier for the bank statement file or batch import that loaded this transaction. Used for data lineage and troubleshooting.',
    `business_unit_code` STRING COMMENT 'The code identifying the business unit or division associated with this bank transaction. Used for segment reporting and cost center allocation.',
    `check_number` STRING COMMENT 'The check number for check-based transactions. Used to match bank statement check clearances with issued checks in accounts payable.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this bank transaction record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the transaction amount (e.g., USD, EUR, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether the transaction is a debit (outflow, decrease in balance) or credit (inflow, increase in balance) to the bank account.. Valid values are `debit|credit`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert transaction_amount to functional_currency_amount. Null if transaction currency matches functional currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period number within the fiscal year (typically 1-12 for monthly periods). Used for period-based financial analysis and reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this bank transaction belongs based on posting_date. Used for annual financial reporting and year-end reconciliation.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the organizations functional (reporting) currency. Used for consolidated financial reporting when bank accounts are held in multiple currencies.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this bank transaction record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-form notes added by accounting staff during the reconciliation process. Used to document exceptions, adjustments, or special handling.',
    `payee_payor_name` STRING COMMENT 'The name of the party receiving funds (for debits) or sending funds (for credits). Extracted from bank statement remittance information.',
    `posting_date` DATE COMMENT 'The date the transaction was posted to the bank account ledger. Used for statement reconciliation and accounting period assignment.',
    `reconciliation_date` DATE COMMENT 'The date the bank transaction was reconciled and matched to internal accounting records. Null if the transaction remains unreconciled.',
    `reconciliation_status` STRING COMMENT 'The current reconciliation state of the bank transaction. Unreconciled transactions have not been matched to internal records; matched transactions have been linked to GL (General Ledger) entries; cleared transactions are fully reconciled and closed.. Valid values are `unreconciled|matched|cleared|voided|in_dispute`',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this transaction is a reversal or correction of a previous transaction. True if this is a reversal entry.',
    `running_balance` DECIMAL(18,2) COMMENT 'The cumulative account balance after this transaction was applied, as reported by the bank. Used for cash position tracking and balance verification.',
    `source_system` STRING COMMENT 'The name of the source system or bank integration channel that provided this transaction data (e.g., Oracle NetSuite Bank Feed, Manual Import, SWIFT Gateway).',
    `statement_date` DATE COMMENT 'The date of the bank statement on which this transaction appeared. Used to group transactions by statement period for reconciliation.',
    `statement_sequence_number` STRING COMMENT 'The sequential line number of this transaction within the bank statement. Used to maintain transaction order as presented by the bank.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary value of the transaction in the currency of the bank account. Always represented as a positive number; debit_credit_indicator determines the direction.',
    `transaction_code` STRING COMMENT 'The standardized bank transaction code assigned by the financial institution. Maps to BAI (Bank Administration Institute) codes or ISO 20022 transaction codes for automated processing.',
    `transaction_date` DATE COMMENT 'The date the transaction was initiated or posted by the bank. This is the business event date for the transaction.',
    `transaction_number` STRING COMMENT 'The externally-known unique transaction number or reference assigned by the bank for this transaction. Used for bank statement reconciliation and inquiry.',
    `transaction_type` STRING COMMENT 'The category of bank transaction indicating the nature of the movement. Includes deposits, withdrawals, ACH (Automated Clearing House) credits and debits, wire transfers, checks, bank fees, interest, adjustments, and reversals. [ENUM-REF-CANDIDATE: deposit|withdrawal|ach_credit|ach_debit|wire_incoming|wire_outgoing|check_deposit|check_payment|fee|interest_credit|interest_debit|adjustment|reversal|return — 14 candidates stripped; promote to reference product]',
    `value_date` DATE COMMENT 'The effective date when funds are available or debited from the account. Used for cash position and interest calculation. May differ from transaction_date due to clearing cycles.',
    `wire_reference_number` STRING COMMENT 'The unique reference number for wire transfer transactions. Includes IMAD (Input Message Accountability Data) or OMAD (Output Message Accountability Data) for Fedwire transfers.',
    CONSTRAINT pk_bank_transaction PRIMARY KEY(`bank_transaction_id`)
) COMMENT 'Bank statement transaction record capturing each debit and credit movement on a corporate bank account as reported by the bank. Captures bank account reference, transaction date, value date, transaction type (deposit, withdrawal, ACH credit, ACH debit, wire, check, fee, interest), transaction amount, currency, bank reference number, description, reconciliation status (unreconciled, matched, cleared), matched GL transaction reference, and reconciliation date. Drives the bank reconciliation process and cash position management.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` (
    `bank_reconciliation_id` BIGINT COMMENT 'Unique identifier for the bank reconciliation record. Primary key for the bank reconciliation entity.',
    `accounting_period_id` BIGINT COMMENT 'Reference to the accounting period for which this reconciliation is performed. Links to the fiscal calendar.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the user who approved the bank reconciliation. Links to the user or employee master data for final authorization and audit trail.',
    `bank_account_id` BIGINT COMMENT 'Reference to the corporate bank account being reconciled. Links to the bank account master data.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the GL journal entry created to record reconciliation adjustments. Links to the journal entry that corrects the book balance based on reconciliation findings.',
    `legal_entity_id` BIGINT COMMENT 'FK to finance.legal_entity',
    `primary_bank_staff_profile_id` BIGINT COMMENT 'Reference to the user who prepared the bank reconciliation. Links to the user or employee master data for accountability and audit trail.',
    `reviewer_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who reviewed the bank reconciliation. Links to the user or employee master data for segregation of duties and audit trail.',
    `prior_bank_reconciliation_id` BIGINT COMMENT 'Self-referencing FK on bank_reconciliation (prior_bank_reconciliation_id)',
    `adjusted_bank_balance` DECIMAL(18,2) COMMENT 'The bank statement balance after applying all reconciling items from the bank side. Should equal the adjusted book balance when reconciliation is complete.',
    `adjusted_book_balance` DECIMAL(18,2) COMMENT 'The GL book balance after applying all reconciling items from the book side. Should equal the adjusted bank balance when reconciliation is complete.',
    `approval_date` DATE COMMENT 'The date when the reconciliation was approved. Tracks when the approver provided final authorization for the reconciliation.',
    `approver_name` STRING COMMENT 'Full name of the person who approved the bank reconciliation. Denormalized for reporting convenience and historical record.',
    `auto_reconciled_flag` BOOLEAN COMMENT 'Indicates whether the reconciliation was performed automatically by the system or manually by a user. True if auto-reconciled, false if manual.',
    `bank_errors_total` DECIMAL(18,2) COMMENT 'Total amount of errors made by the bank that require adjustment to the bank statement balance. Includes incorrect charges, deposits, or other bank processing errors.',
    `bank_service_charges` DECIMAL(18,2) COMMENT 'Total bank fees and service charges deducted by the bank during the period. Includes monthly maintenance fees, transaction fees, and other bank charges.',
    `book_errors_total` DECIMAL(18,2) COMMENT 'Total amount of errors made in the companys books that require adjustment to the GL balance. Includes recording errors, omissions, or incorrect amounts.',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit or division responsible for the bank account. Used for operational segmentation and reporting.',
    `completion_date` DATE COMMENT 'The date when the reconciliation process was fully completed and closed. Represents the final closure of the reconciliation workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bank reconciliation record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the bank account being reconciled. Identifies the currency in which all monetary amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `exception_count` STRING COMMENT 'Number of reconciling items or exceptions identified during the reconciliation process. Used for tracking reconciliation complexity and quality metrics.',
    `gl_book_balance` DECIMAL(18,2) COMMENT 'The cash account balance recorded in the general ledger as of the reconciliation date. Represents the companys internal record of the bank account balance.',
    `interest_earned` DECIMAL(18,2) COMMENT 'Interest income earned on the bank account during the reconciliation period. Represents bank interest credited to the account.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the bank reconciliation record was last modified. Audit trail for tracking changes to the reconciliation.',
    `nsf_charges` DECIMAL(18,2) COMMENT 'Total charges for returned checks or payments due to insufficient funds. Includes NSF fees and returned item charges.',
    `other_adjustments_total` DECIMAL(18,2) COMMENT 'Total of all other reconciling items not categorized elsewhere. Includes miscellaneous adjustments, wire transfer fees, or other unique items.',
    `outstanding_checks_total` DECIMAL(18,2) COMMENT 'Total amount of checks and electronic payments issued and recorded in the GL but not yet cleared by the bank. Represents payments in transit at period end.',
    `outstanding_deposits_total` DECIMAL(18,2) COMMENT 'Total amount of deposits recorded in the GL but not yet reflected on the bank statement. Represents deposits made near period end that have not cleared the bank.',
    `preparation_date` DATE COMMENT 'The date when the reconciliation was initially prepared. Tracks when the preparer completed the initial reconciliation work.',
    `preparer_name` STRING COMMENT 'Full name of the person who prepared the bank reconciliation. Denormalized for reporting convenience and historical record.',
    `reconciliation_date` DATE COMMENT 'The date on which the bank reconciliation was performed. Represents the business event date when the reconciliation process was executed.',
    `reconciliation_notes` STRING COMMENT 'Free-text notes and comments about the reconciliation. Captures explanations for unusual items, resolution details, or other relevant information.',
    `reconciliation_number` STRING COMMENT 'Business identifier for the bank reconciliation record. Externally visible unique number assigned to each reconciliation for tracking and audit purposes.. Valid values are `^BR-[0-9]{6,12}$`',
    `reconciliation_status` STRING COMMENT 'Current workflow status of the bank reconciliation. Tracks the reconciliation through preparation, review, and approval stages.. Valid values are `in_progress|reconciled|approved|rejected|under_review|pending_approval`',
    `requires_journal_entry_flag` BOOLEAN COMMENT 'Indicates whether the reconciliation identified items that require a GL journal entry to correct the book balance. True if journal entry is needed.',
    `review_date` DATE COMMENT 'The date when the reconciliation was reviewed. Tracks when the reviewer completed their review of the reconciliation.',
    `reviewer_name` STRING COMMENT 'Full name of the person who reviewed the bank reconciliation. Denormalized for reporting convenience and historical record.',
    `source_system` STRING COMMENT 'Identifier of the system that originated or processed the bank reconciliation. Tracks data lineage for integration and audit purposes.',
    `statement_date` DATE COMMENT 'The ending date of the bank statement being reconciled. Represents the cutoff date for transactions included in the bank statement.',
    `statement_ending_balance` DECIMAL(18,2) COMMENT 'The ending balance reported on the bank statement for the reconciliation period. Represents the banks record of the account balance as of the statement date.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between adjusted bank balance and adjusted book balance. A zero variance indicates a successful reconciliation; non-zero indicates unresolved items.',
    CONSTRAINT pk_bank_reconciliation PRIMARY KEY(`bank_reconciliation_id`)
) COMMENT 'Bank reconciliation record capturing the period-end reconciliation of a corporate bank account balance to the GL cash account balance. Captures bank account reference, reconciliation period, statement date, bank statement ending balance, GL book balance, outstanding deposits-in-transit total, outstanding checks/payments total, bank errors, book errors, adjusted bank balance, adjusted book balance, reconciliation status (in-progress, reconciled, approved), preparer, reviewer, and completion date. Ensures cash integrity across all staffing firm bank accounts.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`period_close_task` (
    `period_close_task_id` BIGINT COMMENT 'Unique identifier for the period close task record. Primary key for the period close task entity.',
    `accounting_period_id` BIGINT COMMENT 'Reference to the accounting period for which this close task applies. Links to the fiscal period being closed (monthly, quarterly, or annual).',
    `approver_staff_profile_id` BIGINT COMMENT 'Reference to the user authorized to approve or sign off on this close task. Typically a manager or controller.',
    `business_unit_id` BIGINT COMMENT 'FK to finance.business_unit',
    `created_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who created this close task record. Used for audit trail and accountability.',
    `dependency_task_id` BIGINT COMMENT 'Reference to another close task that must be completed before this task can begin. Establishes task sequencing and critical path.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Period close task should link to GL account master when the task is account-specific. Currently uses gl_account_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the journal entry created or reviewed as part of this close task. Links close task to resulting accounting transaction.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Period close task should link to legal entity master for entity-specific close tasks. Currently uses legal_entity_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `modified_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who last modified this close task record. Used for audit trail and accountability.',
    `primary_period_staff_profile_id` BIGINT COMMENT 'Reference to the user or employee responsible for completing this close task. Primary accountable party for task execution.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the user who marked this close task as completed. May differ from assigned owner if task was reassigned or delegated.',
    `waived_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who authorized waiving this close task. Typically requires controller or CFO approval.',
    `predecessor_period_close_task_id` BIGINT COMMENT 'Self-referencing FK on period_close_task (predecessor_period_close_task_id)',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual number of labor hours spent completing this close task. Used to measure close efficiency and refine future estimates.',
    `actual_start_date` DATE COMMENT 'Date when work on this close task actually began. Used to track close process adherence and identify delays.',
    `approval_date` DATE COMMENT 'Date when this close task was formally approved or signed off. Required for tasks subject to SOX or internal control requirements.',
    `assigned_owner_name` STRING COMMENT 'Full name of the user or employee assigned to complete this close task. Provides human-readable identification of the responsible party.',
    `assigned_team` STRING COMMENT 'Name of the functional team or department responsible for this close task (e.g., Payroll Accounting, Revenue Recognition, General Ledger).',
    `automation_job_reference` STRING COMMENT 'Identifier of the automated job or script that executes this close task. Applicable only when is_automated is true.',
    `completion_date` DATE COMMENT 'Date when this close task was marked as completed. Used to measure close cycle time and task duration.',
    `completion_notes` STRING COMMENT 'Free-text notes entered by the task owner upon completion. Documents work performed, issues encountered, and resolution details.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this close task record was first created in the system. Used for audit trail and data lineage.',
    `due_date` DATE COMMENT 'Target completion date for this close task. Used to manage close timeline and identify tasks at risk of delaying the period lock.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'Planned number of labor hours required to complete this close task. Used for resource planning and capacity management.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether this close task is executed by an automated process or script (true) or requires manual execution (false).',
    `is_blocking` BOOLEAN COMMENT 'Indicates whether this task must be completed before the accounting period can be locked. True for critical path tasks that block period close.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this close task recurs every period (true) or is a one-time task (false). Used to auto-generate task lists for future periods.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this close task record was last modified. Used for audit trail and change tracking.',
    `priority` STRING COMMENT 'Relative importance and urgency of this close task. Critical tasks must be completed before period can be locked.. Valid values are `critical|high|medium|low`',
    `recurrence_pattern` STRING COMMENT 'Frequency at which this close task recurs. Applicable only when is_recurring is true.. Valid values are `monthly|quarterly|annually|semi_annually`',
    `requires_approval` BOOLEAN COMMENT 'Indicates whether this close task requires formal approval or sign-off before it can be marked as completed.',
    `scheduled_start_date` DATE COMMENT 'Planned date when work on this close task should begin. Used for close process planning and resource allocation.',
    `sign_off_notes` STRING COMMENT 'Free-text notes entered by the approver during sign-off. Documents review findings, approval conditions, or follow-up items.',
    `supporting_document_url` STRING COMMENT 'URL or file path to supporting documentation for this close task (e.g., reconciliation workpapers, approval emails, calculation spreadsheets).',
    `task_category` STRING COMMENT 'Functional area or accounting domain to which this close task belongs. Used to organize close activities by business function. [ENUM-REF-CANDIDATE: revenue|payroll|billing|accounts_receivable|accounts_payable|general_ledger|tax|intercompany|fixed_assets|other — 10 candidates stripped; promote to reference product]',
    `task_instructions` STRING COMMENT 'Detailed procedural instructions for completing this close task. Provides step-by-step guidance for the assigned owner.',
    `task_name` STRING COMMENT 'Descriptive name of the close task (e.g., Accrue Payroll Taxes, Reconcile Intercompany Accounts, Prepare Revenue Recognition Journal Entry).',
    `task_number` STRING COMMENT 'Business identifier for the close task, typically a sequential or hierarchical code used in the close checklist (e.g., CL-2024-Q1-010).',
    `task_sequence` STRING COMMENT 'Numeric ordering of this task within the close checklist. Used to display tasks in logical execution order.',
    `task_status` STRING COMMENT 'Current lifecycle status of the close task. Tracks progress through the close checklist and identifies tasks requiring attention.. Valid values are `not_started|in_progress|completed|overdue|waived|blocked`',
    `task_type` STRING COMMENT 'Classification of the close task by accounting activity type. Determines the nature of work to be performed during the period close process. [ENUM-REF-CANDIDATE: accrual|reconciliation|journal_entry|sub_ledger_close|consolidation|reporting|review|approval — 8 candidates stripped; promote to reference product]',
    `waiver_date` DATE COMMENT 'Date when this close task was formally waived. Used for audit trail and control compliance documentation.',
    `waiver_reason` STRING COMMENT 'Business justification for waiving or skipping this close task. Required when task status is set to waived. Subject to audit review.',
    CONSTRAINT pk_period_close_task PRIMARY KEY(`period_close_task_id`)
) COMMENT 'Financial period-end close task record tracking each step in the monthly, quarterly, and annual close process for the staffing enterprise. Captures task name, task type (accrual, reconciliation, journal entry, sub-ledger close, consolidation, reporting), assigned owner, due date, completion date, status (not started, in progress, completed, overdue, waived), dependency on prior tasks, close period reference, and sign-off notes. Manages the structured close checklist ensuring all accounting activities are completed before the period is locked.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`accrual` (
    `accrual_id` BIGINT COMMENT 'Unique identifier for the accrual record. Primary key.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Accrual records should be linked to the accounting period master for proper period management. Currently uses gl_period (STRING) and fiscal_year/quarter (INT) which should be normalized to FK. Removes',
    `approver_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who approved the accrual entry, enforcing segregation of duties and approval controls.',
    `assignment_id` BIGINT COMMENT 'Reference to the specific worker assignment related to this accrual, commonly used for payroll and unbilled revenue accruals in staffing.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for which this accrual is recorded, enabling client-level financial analysis.',
    `conversion_id` BIGINT COMMENT 'Foreign key linking to placement.conversion. Business justification: Conversion fees are accrued when conversion occurs but invoiced/collected later. Finance tracks accruals by conversion for period-end close, revenue matching, and fall-off risk reserve estimation.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `direct_hire_id` BIGINT COMMENT 'Foreign key linking to placement.direct_hire. Business justification: Direct hire fees are accrued when placement occurs but invoiced/collected later. Finance tracks accruals by specific direct hire placement for period-end close, revenue matching, and guarantee period ',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Accruals reversed when invoices are issued. Core accrual accounting process for unbilled revenue and expense matching.',
    `location_id` BIGINT COMMENT 'Foreign key linking to client.location. Business justification: Accruals for location-specific costs (utilities, on-site coordinator payroll, facilities) require location linkage for accurate site P&L and period-end financial reporting. Essential for location-leve',
    `original_accrual_id` BIGINT COMMENT 'Reference to the original accrual record if this is an adjustment or correction entry, maintaining audit lineage.',
    `placement_assignment_id` BIGINT COMMENT 'Reference to the placement record associated with this accrual, used for tracking accruals related to specific candidate placements.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the journal entry that reversed this accrual, providing audit trail for the reversal transaction.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Payroll and expense accruals for SOW-based engagements must reference the SOW for project cost tracking, margin analysis, and SOW-level P&L reporting. Critical for accurate project accounting and marg',
    `staff_profile_id` BIGINT COMMENT 'Reference to the user who prepared and recorded the accrual entry, supporting accountability and audit requirements.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor for vendor accruals, tracking amounts owed to third-party suppliers or subcontractors.',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_agreement. Business justification: Vendor cost accruals must reference the vendor agreement for rate validation, contract spend tracking, and vendor liability management. Enables accurate vendor cost accrual and spend reconciliation ag',
    `vms_program_id` BIGINT COMMENT 'Foreign key linking to client.vms_program. Business justification: Accruals for VMS program costs (pending supplier invoices, unbilled MSP fees) need program-level tracking for accurate program P&L and period-end close. Standard practice in VMS/MSP financial manageme',
    `reversal_accrual_id` BIGINT COMMENT 'Self-referencing FK on accrual (reversal_accrual_id)',
    `accrual_date` DATE COMMENT 'The date on which the accrual is recorded in the general ledger, representing the business event date for the estimated transaction.',
    `accrual_number` STRING COMMENT 'Business-facing unique accrual reference number used for tracking and reconciliation purposes.',
    `accrual_status` STRING COMMENT 'The current lifecycle status of the accrual record, indicating its state in the accounting workflow.. Valid values are `draft|posted|reversed|adjusted|cancelled`',
    `accrual_type` STRING COMMENT 'Classification of the accrual indicating the nature of the estimated expense or revenue. Critical for staffing firms where payroll and billing cycles span period boundaries.. Valid values are `payroll_accrual|unbilled_revenue|vendor_accrual|bonus_accrual|workers_comp_accrual|fica_accrual`',
    `adjustment_reason` STRING COMMENT 'Explanation for any adjustments made to the original accrual amount, supporting audit trail and variance analysis.',
    `amount` DECIMAL(18,2) COMMENT 'The estimated monetary amount of the accrual recorded in the general ledger before the actual invoice or cash transaction is received.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the accrual was approved, supporting audit trail and compliance requirements.',
    `approver_name` STRING COMMENT 'The name of the individual who approved the accrual entry for human-readable audit trail purposes.',
    `basis_of_estimate` STRING COMMENT 'The methodology used to calculate the accrual amount (e.g., hours × rate for payroll accruals, percentage of revenue, fixed contractual amount).. Valid values are `hours_times_rate|percentage|fixed_amount|historical_average|contractual`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the accrual record was first created in the system, supporting audit trail requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the accrual amount is denominated (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `estimate_hours` DECIMAL(18,2) COMMENT 'The number of hours used in the accrual calculation when basis of estimate is hours × rate, common for payroll accruals in staffing.',
    `estimate_percentage` DECIMAL(18,2) COMMENT 'The percentage applied to a base amount when the accrual is calculated as a percentage (e.g., bonus accrual as % of revenue).',
    `estimate_rate` DECIMAL(18,2) COMMENT 'The rate per hour or unit used in the accrual calculation when basis of estimate is hours × rate or unit-based.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the accrual amount to the functional currency, if applicable.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The accrual amount converted to the organizations functional currency for consolidated financial reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the accrual record was last modified, tracking changes for audit and compliance purposes.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, assumptions, or explanations for the accrual calculation and recording.',
    `posting_timestamp` TIMESTAMP COMMENT 'The date and time when the accrual was posted to the general ledger, marking the point of financial commitment.',
    `preparer_name` STRING COMMENT 'The name of the individual who prepared the accrual entry for human-readable audit trail purposes.',
    `reversal_date` DATE COMMENT 'The date on which the accrual is scheduled to be reversed, typically in the subsequent accounting period when the actual transaction is recorded.',
    `reversal_status` STRING COMMENT 'The current status of the accrual reversal process, indicating whether the accrual is awaiting reversal, has been reversed, or has been adjusted.. Valid values are `pending|reversed|cancelled|adjusted`',
    `source_reference_code` STRING COMMENT 'The unique identifier of the source document or transaction that triggered the accrual, enabling traceability back to the originating event.',
    `source_reference_type` STRING COMMENT 'The type of source document or transaction that triggered the accrual (e.g., assignment, pay period, contract, SOW).. Valid values are `assignment|pay_period|contract|sow|placement|invoice`',
    `source_system` STRING COMMENT 'The name of the source system from which the accrual data originated (e.g., Oracle NetSuite ERP, TempWorks Payroll, Salesforce Revenue Cloud).',
    `source_system_code` STRING COMMENT 'The unique identifier of the accrual record in the source system, enabling cross-system reconciliation and traceability.',
    CONSTRAINT pk_accrual PRIMARY KEY(`accrual_id`)
) COMMENT 'Accrual record capturing estimated expense or revenue amounts recorded in the general ledger before the actual invoice or cash transaction is received. Captures accrual type (payroll accrual, unbilled revenue, vendor accrual, bonus accrual, workers comp accrual), accrual date, GL period, GL account, cost center, accrual amount, currency, basis of estimate (hours × rate, percentage, fixed), source reference (assignment, pay period, contract), reversal date, reversal status, and preparer. Critical for staffing firms where payroll and billing cycles span period boundaries.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`tax_liability` (
    `tax_liability_id` BIGINT COMMENT 'Unique identifier for the corporate tax liability record. Primary key for the tax liability entity.',
    `accounting_period_id` BIGINT COMMENT 'Reference to the accounting period in which this tax liability is recognized for general ledger purposes.',
    `business_unit_id` BIGINT COMMENT 'FK to finance.business_unit',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tax liability should link to cost center master for organizational tracking. Currently uses cost_center_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Tax liability should link to GL account master for proper accounting classification. Currently uses gl_account_code (STRING) which should be normalized to FK. Removes redundant code column.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that holds this tax liability. Links to the corporate legal entity structure.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the user or system process that created this tax liability record.',
    `amended_tax_liability_id` BIGINT COMMENT 'Self-referencing FK on tax_liability (amended_tax_liability_id)',
    `calculated_tax_amount` DECIMAL(18,2) COMMENT 'The gross tax amount calculated by applying the tax rate to the taxable base amount, before any credits or adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax liability record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this tax liability record (typically USD for U.S. operations).. Valid values are `^[A-Z]{3}$`',
    `extended_due_date` DATE COMMENT 'New due date if an extension was granted. Null if no extension was requested or granted.',
    `extension_granted_flag` BOOLEAN COMMENT 'Indicates whether a filing or payment extension was granted by the tax authority for this liability.',
    `filing_date` DATE COMMENT 'Actual date on which the tax return was filed with the tax authority. Null if filing has not yet occurred.',
    `filing_due_date` DATE COMMENT 'Date by which the tax return or filing must be submitted to the tax authority. May differ from payment due date in some jurisdictions.',
    `filing_method` STRING COMMENT 'Method used to submit the tax filing to the authority (electronic filing, paper filing, or through a third-party tax service provider).. Valid values are `electronic|paper|third_party_service`',
    `filing_reference_number` STRING COMMENT 'Reference number or confirmation code from the tax authority acknowledging receipt of the tax filing (e.g., IRS confirmation number, state filing ID).',
    `filing_status` STRING COMMENT 'Current status of the tax return filing with the tax authority.. Valid values are `not_filed|filed|amended|under_review|accepted|rejected`',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter within the fiscal year (1-4) for quarterly tax reporting and analysis.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this tax liability belongs, used for financial reporting and compliance tracking.',
    `interest_amount` DECIMAL(18,2) COMMENT 'Interest charges accrued on unpaid or late-paid tax liabilities, calculated according to jurisdiction-specific interest rate rules.',
    `jurisdiction_code` STRING COMMENT 'Code identifying the specific tax jurisdiction (e.g., state abbreviation, county code, city code). For federal, typically US. For state, two-letter state code. For local, municipality or county identifier.',
    `jurisdiction_level` STRING COMMENT 'Level of government jurisdiction imposing the tax liability (federal, state, local, municipal, or county).. Valid values are `federal|state|local|municipal|county`',
    `jurisdiction_name` STRING COMMENT 'Full name of the tax jurisdiction (e.g., United States, California, Los Angeles County, City of San Francisco).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax liability record was last modified.',
    `net_tax_due` DECIMAL(18,2) COMMENT 'The final net tax amount due after applying all credits and adjustments. This is the amount the enterprise must pay to the tax authority.',
    `notes` STRING COMMENT 'Free-form notes providing additional context, explanations, or special circumstances related to this tax liability.',
    `payment_date` DATE COMMENT 'Actual date on which the tax payment was remitted to the tax authority. Null if payment has not yet been made.',
    `payment_due_date` DATE COMMENT 'Date by which the tax payment must be remitted to the tax authority to avoid penalties and interest.',
    `payment_reference_number` STRING COMMENT 'Reference number or confirmation code from the payment transaction, used for reconciliation and audit purposes.',
    `payment_status` STRING COMMENT 'Current status of the tax payment obligation indicating whether the liability has been settled.. Valid values are `unpaid|partially_paid|paid|overpaid|waived|disputed`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Total penalties assessed for late payment, late filing, underpayment, or other compliance violations.',
    `source_system` STRING COMMENT 'Name of the source system from which this tax liability record originated (e.g., Oracle NetSuite ERP, Tax Compliance Software).',
    `source_system_code` STRING COMMENT 'Unique identifier of this tax liability record in the source system, used for data lineage and reconciliation.',
    `tax_adjustments` DECIMAL(18,2) COMMENT 'Additional adjustments to the tax liability (positive or negative) due to amendments, corrections, penalties, or interest charges.',
    `tax_authority_identifier` STRING COMMENT 'Unique identifier or account number assigned by the tax authority for tracking this taxpayers obligations.',
    `tax_authority_name` STRING COMMENT 'Name of the government agency or tax authority to which this liability is owed (e.g., Internal Revenue Service, California Franchise Tax Board, City of Los Angeles Tax Collector).',
    `tax_credits_applied` DECIMAL(18,2) COMMENT 'Total amount of tax credits applied to reduce the calculated tax liability (e.g., research and development credits, investment tax credits, foreign tax credits).',
    `tax_liability_number` STRING COMMENT 'Business identifier for the tax liability record, typically generated by the ERP system for tracking and reference purposes.',
    `tax_period_end_date` DATE COMMENT 'End date of the tax period for which this liability is calculated.',
    `tax_period_start_date` DATE COMMENT 'Start date of the tax period for which this liability is calculated. Typically aligns with fiscal or calendar periods.',
    `tax_rate` DECIMAL(18,2) COMMENT 'The tax rate applied to the taxable base amount, expressed as a decimal (e.g., 0.21000 for 21% federal corporate income tax rate).',
    `tax_type` STRING COMMENT 'Classification of the corporate tax obligation. Covers the firms own corporate tax obligations distinct from employer payroll tax (which is owned by the payroll domain). [ENUM-REF-CANDIDATE: corporate_income_tax|sales_tax|use_tax|franchise_tax|gross_receipts_tax|business_license_tax|property_tax|excise_tax — 8 candidates stripped; promote to reference product]',
    `taxable_base_amount` DECIMAL(18,2) COMMENT 'The base amount upon which the tax is calculated (e.g., taxable income for corporate income tax, gross receipts for gross receipts tax, sales amount for sales tax).',
    CONSTRAINT pk_tax_liability PRIMARY KEY(`tax_liability_id`)
) COMMENT 'Corporate tax liability record tracking the staffing enterprises tax obligations across federal, state, and local jurisdictions — separate from worker-level payroll tax (owned by payroll domain). Captures tax type (corporate income tax, sales tax, use tax, franchise tax, gross receipts tax), jurisdiction (federal, state, local), tax period, taxable base amount, tax rate, calculated tax amount, credits applied, net tax due, payment due date, filing due date, payment status, and filing reference. Covers the firms own corporate tax obligations distinct from employer payroll tax.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key for the fixed asset master data.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `department_id` BIGINT COMMENT 'FK to employee.department',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Fixed asset should be owned by a legal entity for proper asset tracking and financial reporting. No redundant columns to remove as fixed_asset does not currently have legal_entity_code.',
    `msa_id` BIGINT COMMENT 'Identifier of the lease agreement if the asset is leased. Links to lease contract master data for payment schedules and terms. Nullable for owned assets.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the employee currently responsible for the asset. Used for accountability and asset tracking. Nullable for assets not assigned to individuals.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier from whom the asset was purchased. Links to vendor master data for procurement history.',
    `tertiary_fixed_modified_by_user_staff_profile_id` BIGINT COMMENT 'Identifier of the user who last modified the fixed asset record. Used for audit trail and accountability.',
    `parent_fixed_asset_id` BIGINT COMMENT 'Self-referencing FK on fixed_asset (parent_fixed_asset_id)',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since acquisition. Contra-asset account that reduces the gross book value to net book value.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total capitalized cost of the asset at acquisition, including purchase price, delivery, installation, and any costs necessary to bring the asset to its intended use.',
    `acquisition_date` DATE COMMENT 'Date the asset was purchased, leased, or placed into service. Marks the start of the depreciation schedule.',
    `asset_category` STRING COMMENT 'Classification of the fixed asset by type for accounting and depreciation purposes. Determines applicable depreciation method and useful life.. Valid values are `office_equipment|furniture|vehicles|computer_hardware|leasehold_improvements|software`',
    `asset_name` STRING COMMENT 'Human-readable name or title of the fixed asset (e.g., Dell Latitude 5520 Laptop, Herman Miller Aeron Chair, Toyota Camry 2022).',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset. Active assets are in service and depreciating; disposed assets have been sold or scrapped; fully depreciated assets remain in service but have zero net book value.. Valid values are `active|disposed|fully_depreciated|under_construction|retired|impaired`',
    `asset_subcategory` STRING COMMENT 'Detailed sub-classification within the asset category (e.g., Laptop, Desk, Sedan, Server, HVAC System).',
    `asset_tag_number` STRING COMMENT 'Externally visible unique identifier affixed to the physical asset for tracking and inventory purposes. Typically a barcode or RFID tag number.. Valid values are `^[A-Z0-9]{6,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the fixed asset record was first created in the system. Used for audit trail and data lineage.',
    `depreciation_method` STRING COMMENT 'Accounting method used to allocate the cost of the asset over its useful life. Straight-line is most common for financial reporting; MACRS (Modified Accelerated Cost Recovery System) is used for tax purposes.. Valid values are `straight_line|declining_balance|double_declining_balance|macrs|units_of_production`',
    `disposal_date` DATE COMMENT 'Date the asset was sold, scrapped, donated, or otherwise removed from service. Nullable for assets still in service.',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Cash or fair value of consideration received from the sale or disposal of the asset. Used to calculate gain or loss on disposal.',
    `gain_loss_on_disposal` DECIMAL(18,2) COMMENT 'Calculated difference between disposal proceeds and net book value at disposal date. Positive values represent gains; negative values represent losses. Recognized in the income statement.',
    `impairment_date` DATE COMMENT 'Date the impairment loss was recognized. Nullable for assets not impaired.',
    `impairment_flag` BOOLEAN COMMENT 'Indicates whether the asset has been tested for impairment and found to have a carrying value exceeding its recoverable amount. Triggers impairment loss recognition.',
    `impairment_loss_amount` DECIMAL(18,2) COMMENT 'Amount of impairment loss recognized, calculated as the excess of carrying value over fair value. Reduces net book value and is recognized in the income statement.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the insurance policy covering the asset. Used for claims processing and risk management.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance or service performed on the asset. Used for preventive maintenance scheduling.',
    `lease_flag` BOOLEAN COMMENT 'Indicates whether the asset is leased (True) or owned (False). Leased assets follow different accounting treatment under ASC 842.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the asset (e.g., Dell, Herman Miller, Toyota, Cisco).',
    `model_number` STRING COMMENT 'Manufacturer model or part number for the asset. Used for maintenance, replacement parts, and warranty claims.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the fixed asset record was last updated. Used for audit trail and change tracking.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the asset on the balance sheet, calculated as acquisition cost minus accumulated depreciation. Also known as carrying amount.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance or service. Used for maintenance planning and budgeting.',
    `notes` STRING COMMENT 'Free-form text field for additional information, special handling instructions, or historical context about the asset.',
    `physical_location` STRING COMMENT 'Current physical location of the asset (e.g., office address, warehouse, employee assignment, branch location). Used for asset tracking and inventory management.',
    `purchase_order_number` STRING COMMENT 'Reference number of the purchase order used to acquire the asset. Links to procurement records for audit trail.. Valid values are `^PO-[0-9]{6,12}$`',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. The amount expected to be recovered through sale or trade-in. Used in depreciation calculations.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number for the asset. Used for warranty tracking, maintenance records, and theft recovery.',
    `tax_depreciation_method` STRING COMMENT 'Depreciation method used for tax reporting purposes. Often differs from book depreciation method. MACRS (Modified Accelerated Cost Recovery System) is most common for US tax purposes.. Valid values are `macrs|section_179|bonus_depreciation|straight_line`',
    `useful_life_months` STRING COMMENT 'Expected useful life of the asset in months for depreciation calculation purposes. Determined by IRS guidelines and company policy.',
    `warranty_expiration_date` DATE COMMENT 'Date the manufacturer or vendor warranty expires. Used to plan maintenance budgets and replacement decisions.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master record for capital assets owned or leased by the staffing enterprise — including office equipment, leasehold improvements, furniture, vehicles, and technology infrastructure. Captures asset tag number, asset name, asset category, acquisition date, acquisition cost, useful life (months), depreciation method (straight-line, declining balance, MACRS), accumulated depreciation, net book value, salvage value, disposal date, disposal proceeds, gain/loss on disposal, physical location, assigned cost center, and asset status (active, disposed, fully depreciated). Supports capital expenditure tracking and depreciation scheduling.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` (
    `depreciation_schedule_id` BIGINT COMMENT 'Unique identifier for the depreciation schedule record. Primary key for the depreciation schedule entity.',
    `accounting_period_id` BIGINT COMMENT 'Reference to the accounting period for which this depreciation is calculated. Links to the fiscal calendar period.',
    `business_unit_id` BIGINT COMMENT 'FK to finance.business_unit',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `department_id` BIGINT COMMENT 'FK to employee.department',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset being depreciated. Links this depreciation schedule entry to the specific asset in the fixed asset register.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the journal entry that posted this depreciation expense to the general ledger. Links the depreciation schedule to the actual GL transaction.',
    `legal_entity_id` BIGINT COMMENT 'FK to finance.legal_entity',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `staff_profile_id` BIGINT COMMENT 'Reference to the user who approved this depreciation schedule entry for posting. Supports financial controls and audit requirements.',
    `tertiary_depreciation_modified_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who last modified this depreciation schedule record. Supports audit trail and accountability requirements.',
    `prior_depreciation_schedule_id` BIGINT COMMENT 'Self-referencing FK on depreciation_schedule (prior_depreciation_schedule_id)',
    `accumulated_depreciation_amount` DECIMAL(18,2) COMMENT 'The total accumulated depreciation for the asset through the end of this period. Represents the cumulative depreciation expense since the asset was placed in service.',
    `adjustment_flag` BOOLEAN COMMENT 'Indicates whether this is an adjustment entry to correct a prior period depreciation calculation. True for adjustments, false for regular scheduled depreciation.',
    `adjustment_reason` STRING COMMENT 'Explanation for any adjustment made to the depreciation calculation. Required when adjustment_flag is true.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this depreciation schedule entry was approved for posting. Null if not yet approved.',
    `beginning_net_book_value` DECIMAL(18,2) COMMENT 'The net book value of the asset at the start of the depreciation period. Calculated as original cost minus accumulated depreciation from prior periods.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this depreciation schedule record was first created in the system. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this depreciation schedule entry. Ensures proper currency context for financial reporting.. Valid values are `^[A-Z]{3}$`',
    `depreciation_expense_amount` DECIMAL(18,2) COMMENT 'The depreciation expense calculated and recognized for this specific period. This amount is posted to the general ledger as a period expense.',
    `depreciation_method` STRING COMMENT 'The depreciation calculation method applied for this period. Determines how the assets cost is allocated over its useful life.. Valid values are `straight_line|declining_balance|double_declining_balance|sum_of_years_digits|units_of_production|macrs`',
    `depreciation_rate_percent` DECIMAL(18,2) COMMENT 'The depreciation rate percentage applied for this period. Used in declining balance and other rate-based depreciation methods.',
    `ending_net_book_value` DECIMAL(18,2) COMMENT 'The net book value of the asset at the end of the depreciation period. Calculated as beginning net book value minus current period depreciation expense.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1-4) in which this depreciation period falls. Supports quarterly financial reporting requirements.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this depreciation period falls. Used for annual financial reporting and year-over-year analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this depreciation schedule record was last modified. Supports audit trail and change tracking requirements.',
    `notes` STRING COMMENT 'Free-form notes or comments about this depreciation schedule entry. Used for documenting special circumstances, adjustments, or other relevant information.',
    `period_end_date` DATE COMMENT 'The last day of the depreciation period covered by this schedule entry. Defines the end of the calculation window.',
    `period_start_date` DATE COMMENT 'The first day of the depreciation period covered by this schedule entry. Defines the beginning of the calculation window.',
    `posted_date` DATE COMMENT 'The date when this depreciation entry was posted to the general ledger. Null if not yet posted.',
    `posting_status` STRING COMMENT 'The current status of this depreciation schedule entry in the financial posting workflow. Indicates whether the entry has been posted to the general ledger.. Valid values are `draft|pending_approval|approved|posted|reversed|cancelled`',
    `remaining_useful_life_months` STRING COMMENT 'The remaining useful life of the asset in months at the end of this depreciation period. Used for future depreciation projections.',
    `reversal_date` DATE COMMENT 'The date when this depreciation entry was reversed. Null if not reversed.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this depreciation entry has been reversed. True if reversed, false otherwise.',
    `reversal_reason` STRING COMMENT 'Explanation for why this depreciation entry was reversed. Supports audit trail and financial control requirements.',
    `salvage_value_amount` DECIMAL(18,2) COMMENT 'The estimated residual value of the asset at the end of its useful life. This amount is not depreciated and represents the expected recovery value.',
    `schedule_sequence_number` STRING COMMENT 'Sequential number indicating the order of this depreciation entry within the assets depreciation lifecycle. Used for chronological ordering and tracking.',
    `source_system` STRING COMMENT 'The name of the source system that generated or calculated this depreciation schedule entry. Typically the fixed asset or ERP system.',
    `source_system_record_reference` STRING COMMENT 'The unique identifier for this depreciation schedule entry in the source system. Enables traceability back to the originating system.',
    `useful_life_months` STRING COMMENT 'The total useful life of the asset in months as determined at the time of this depreciation calculation. Used in depreciation method calculations.',
    CONSTRAINT pk_depreciation_schedule PRIMARY KEY(`depreciation_schedule_id`)
) COMMENT 'Depreciation schedule record capturing the period-by-period depreciation calculation for each fixed asset. Captures fixed asset reference, depreciation period, depreciation method, beginning net book value, depreciation expense for period, accumulated depreciation to date, ending net book value, GL account, cost center, and posting status. Drives the automated depreciation journal entries posted each accounting period and supports fixed asset sub-ledger reconciliation to the GL.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity record. Primary key for the legal entity master table.',
    `controller_staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: Legal entities require designated financial controller for regulatory filings, audit coordination, financial statement certification, and SOX compliance - critical for multi-entity staffing firms with',
    `modified_by_user_staff_profile_id` BIGINT COMMENT 'Foreign key reference to the user who last modified this legal entity record. Used for audit trail and accountability.',
    `parent_legal_entity_id` BIGINT COMMENT 'Foreign key reference to the parent legal entity if this entity is a subsidiary or branch. Null if this is the top-level parent entity.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key reference to the user who created this legal entity record. Used for audit trail and accountability.',
    `accounting_standard` STRING COMMENT 'The primary accounting framework used by the entity for financial reporting. US GAAP is standard for US entities; IFRS may apply for international subsidiaries.. Valid values are `US GAAP|IFRS|Statutory|Tax Basis`',
    `consolidation_group` STRING COMMENT 'Identifier for the group of entities that are consolidated together for financial reporting purposes. Used to aggregate financials across related entities.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this legal entity record was first created in the system. Used for audit trail and data lineage tracking.',
    `dissolution_date` DATE COMMENT 'The date the entity was legally dissolved, terminated, or ceased operations. Null if the entity is still active.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet to identify the business entity. Used for credit reporting, vendor registration, and government contracting.. Valid values are `^[0-9]{9}$`',
    `ein` STRING COMMENT 'Federal tax identification number issued by the IRS. Also known as Federal Tax ID. Used for all federal tax filings, payroll tax reporting, and IRS correspondence. Format: XX-XXXXXXX.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `entity_type` STRING COMMENT 'The legal structure of the entity as defined by state and federal law. Determines tax treatment, liability, and regulatory obligations.. Valid values are `C-Corporation|S-Corporation|LLC|Partnership|Sole Proprietorship|Branch`',
    `fiscal_year_end_day` STRING COMMENT 'The day of the month on which the fiscal year ends, represented as an integer 1-31. Combined with fiscal_year_end_month to determine the exact fiscal year end date.',
    `fiscal_year_end_month` STRING COMMENT 'The month in which the entitys fiscal year ends, represented as an integer 1-12 (1=January, 12=December). Used to determine accounting period alignment and annual close schedules.',
    `functional_currency_code` STRING COMMENT 'The primary currency in which the entity conducts business and maintains its books and records. Three-letter ISO 4217 currency code (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `incorporation_date` DATE COMMENT 'The date the entity was legally formed or incorporated as recorded in the state filing. This is the official formation date for the legal entity.',
    `intercompany_elimination_flag` BOOLEAN COMMENT 'Indicates whether intercompany transactions involving this entity should be eliminated during consolidation. True if elimination is required; False otherwise.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the legal entity is currently active and operational. True if active; False if dissolved, inactive, or dormant.',
    `is_disregarded_entity` BOOLEAN COMMENT 'Indicates whether the entity is treated as a disregarded entity for federal tax purposes (e.g., single-member LLC). True if disregarded; False if separate tax entity.',
    `is_public_company` BOOLEAN COMMENT 'Indicates whether the entity is a publicly traded company subject to SEC reporting requirements. True if public; False if private.',
    `legal_entity_code` STRING COMMENT 'Short alphanumeric code used internally to identify the legal entity in financial systems, general ledger, and reporting. Typically 2-10 characters.',
    `legal_entity_name` STRING COMMENT 'The full legal name of the incorporated business entity as registered with the state or jurisdiction of incorporation. This is the official name used in contracts, tax filings, and regulatory submissions.',
    `lei_code` STRING COMMENT 'Twenty-character alphanumeric code that uniquely identifies the legal entity in global financial markets. Required for entities engaging in financial transactions subject to regulatory reporting.. Valid values are `^[A-Z0-9]{20}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this legal entity record was last modified. Updated whenever any field in the record changes.',
    `naics_code` STRING COMMENT 'Six-digit code that classifies the entitys primary business activity. Used for statistical analysis, regulatory reporting, and industry benchmarking. Staffing agencies typically use 561320 (Temporary Help Services).. Valid values are `^[0-9]{6}$`',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to the legal entity. Used for documenting exceptions, historical context, or operational guidance.',
    `primary_business_description` STRING COMMENT 'A brief narrative description of the entitys primary business activities, products, and services. Used for internal documentation and external disclosures.',
    `registered_address_line1` STRING COMMENT 'First line of the official registered address for the legal entity as filed with the state. This is the address where legal notices and service of process are delivered.',
    `registered_address_line2` STRING COMMENT 'Second line of the registered address (suite, floor, building, etc.). Optional field.',
    `registered_agent_name` STRING COMMENT 'The name of the individual or company designated as the registered agent for service of process in the state of incorporation.',
    `registered_city` STRING COMMENT 'City of the registered address.',
    `registered_country_code` STRING COMMENT 'Three-letter ISO country code of the registered address. Typically USA for domestic entities.. Valid values are `^[A-Z]{3}$`',
    `registered_postal_code` STRING COMMENT 'ZIP code of the registered address. Format: XXXXX or XXXXX-XXXX.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `registered_state` STRING COMMENT 'Two-letter US state code of the registered address.. Valid values are `^[A-Z]{2}$`',
    `sec_cik_number` STRING COMMENT 'Ten-digit unique identifier assigned by the SEC to entities that file disclosure documents. Required for public companies and certain private filers.. Valid values are `^[0-9]{10}$`',
    `sic_code` STRING COMMENT 'Four-digit code that classifies the entitys industry. Legacy classification system still used by some regulatory agencies. Staffing agencies typically use 7363 (Help Supply Services).. Valid values are `^[0-9]{4}$`',
    `state_of_incorporation` STRING COMMENT 'Two-letter US state code where the entity was legally incorporated or formed. Determines which state corporate law governs the entity.. Valid values are `^[A-Z]{2}$`',
    `stock_exchange` STRING COMMENT 'The name of the stock exchange where the entitys shares are traded, if applicable. Examples: NYSE, NASDAQ, LSE. Null if not publicly traded.',
    `stock_ticker_symbol` STRING COMMENT 'The ticker symbol used to identify the entitys publicly traded stock. Null if not publicly traded.',
    `tax_jurisdiction` STRING COMMENT 'The primary tax jurisdiction to which the entity reports and pays income taxes. Typically the state of incorporation or principal place of business.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Legal entity master record for each incorporated business entity within the staffing enterprise group. Captures legal entity name, entity type (corporation, LLC, partnership, branch), EIN/tax ID, state of incorporation, registered address, functional currency, fiscal year end, consolidation group, parent entity, intercompany elimination flag, GAAP/IFRS reporting standard, active status, and formation/dissolution dates. SSOT for the corporate structure used in intercompany accounting, consolidated financial reporting, and regulatory filings.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` (
    `budget_allocation_id` BIGINT COMMENT 'Unique identifier for this budget allocation record. Primary key for the budget_allocation association.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to the budget being allocated. References the master budget record that defines the total budgeted amount, fiscal year, budget type, and approval status.',
    `department_id` BIGINT COMMENT 'Foreign key linking to the department receiving the budget allocation. References the organizational department that will consume and be accountable for the allocated budget amount.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The monetary amount allocated from the budget to this specific department. Represents the portion of the total budget assigned to this department for the allocation period.',
    `allocated_by` STRING COMMENT 'Name or identifier of the finance user who created or approved this budget allocation. Provides accountability for allocation decisions.',
    `allocation_date` DATE COMMENT 'The date when this budget allocation was formally created or approved. Used for audit trail and allocation history tracking.',
    `allocation_notes` STRING COMMENT 'Free-text notes or justifications for this specific allocation. Captures business rationale, special conditions, or allocation assumptions for this department.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total budget amount allocated to this department. Used for proportional budget distribution and variance analysis. Should sum to 100% across all departments for a given budget.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this budget allocation. Draft indicates pending approval, Approved indicates ready for use, Active indicates in-use, Frozen indicates temporarily locked, Closed indicates period ended, Revised indicates superseded by a new allocation.',
    `budget_category` STRING COMMENT 'The financial category of this budget allocation. Classifies the allocation by its purpose (e.g., Headcount, SG&A, Technology, Facilities). Enables category-level tracking and reporting by department.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget allocation record was first created in the system. Provides audit trail for allocation creation.',
    `effective_end_date` DATE COMMENT 'The date when this budget allocation expires or is superseded. Defines the end of the period during which the department can utilize this allocation. Null indicates an open-ended allocation.',
    `effective_start_date` DATE COMMENT 'The date when this budget allocation becomes effective. Defines when the department can begin utilizing the allocated budget amount.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this budget allocation is currently active and in effect. True means the allocation is operational, false means it has been superseded or closed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget allocation record was last updated or modified. Tracks changes to allocation amounts, dates, or status.',
    `modified_by` STRING COMMENT 'Name or identifier of the user who last modified this budget allocation record. Provides accountability for allocation changes.',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'The acceptable variance percentage threshold for this specific allocation. Overrides the budget-level threshold when department-specific variance tolerances are needed.',
    CONSTRAINT pk_budget_allocation PRIMARY KEY(`budget_allocation_id`)
) COMMENT 'This association product represents the allocation of budget amounts across organizational departments within Staffing Hr. It captures the distribution of financial budgets (operating, capital, headcount) to specific departments for a defined time period. Each record links one budget to one department with allocation-specific attributes including allocated amount, allocation percentage, effective dates, and budget category. This enables multi-department budget distribution, departmental cost tracking, and variance analysis by department.. Existence Justification: In staffing firms, budgets are allocated across multiple departments to distribute financial resources for different purposes (headcount, operations, technology, facilities). A single enterprise or division-level budget is split among multiple departments (recruiting, sales, operations, support), and each department receives allocations from multiple budget categories and fiscal periods. The business actively manages these allocations with specific amounts, percentages, effective dates, and approval workflows.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`fiscal_calendar` (
    `fiscal_calendar_id` BIGINT COMMENT 'Primary key for fiscal_calendar',
    `prior_fiscal_calendar_id` BIGINT COMMENT 'Self-referencing FK on fiscal_calendar (prior_fiscal_calendar_id)',
    `business_days_in_period` STRING COMMENT 'The total number of business days in the fiscal period. Used for productivity calculations and service level agreement tracking.',
    `calendar_date` DATE COMMENT 'The actual calendar date in Gregorian calendar format. Bridge between fiscal periods and calendar dates for transaction mapping.',
    `calendar_month` STRING COMMENT 'The Gregorian calendar month number (1-12). Used for calendar-based reporting and reconciliation with fiscal periods.',
    `calendar_month_name` STRING COMMENT 'The full name of the Gregorian calendar month. Used for user-friendly reporting and dashboards. [ENUM-REF-CANDIDATE: January|February|March|April|May|June|July|August|September|October|November|December — promote to reference product]',
    `calendar_quarter` STRING COMMENT 'The Gregorian calendar quarter (1-4). Used for calendar-based quarterly reporting and reconciliation with fiscal quarters.',
    `calendar_year` STRING COMMENT 'The Gregorian calendar year (YYYY). Used for calendar-based reporting and reconciliation with fiscal periods.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fiscal calendar record was first created in the system. Used for audit trail and data lineage tracking.',
    `day_of_month` STRING COMMENT 'The day number within the calendar month (1-31). Used for monthly reporting and date-based business rules.',
    `day_of_week` STRING COMMENT 'The name of the day of the week for the calendar date. Used for business day calculations and operational scheduling.',
    `day_of_week_number` STRING COMMENT 'The numeric representation of the day of week (1=Monday through 7=Sunday per ISO 8601). Used for business day logic and reporting.',
    `day_of_year` STRING COMMENT 'The day number within the calendar year (1-365 or 1-366 for leap years). Used for year-to-date calculations and trend analysis.',
    `days_in_period` STRING COMMENT 'The total number of days in the fiscal period. Used for pro-rata calculations and period normalization in financial analysis.',
    `fiscal_period` STRING COMMENT 'The fiscal period or month within the fiscal year (1-12 or 1-13 for 13-period calendars). Primary unit for monthly financial close and reporting.',
    `fiscal_period_end_date` DATE COMMENT 'The end date of the fiscal period or month. Defines the closing boundary for monthly financial close and reporting.',
    `fiscal_period_name` STRING COMMENT 'The display name or label for the fiscal period (e.g., P01, Period 1, Jan 2024). Used for user-friendly reporting and financial close communication.',
    `fiscal_period_start_date` DATE COMMENT 'The start date of the fiscal period or month. Defines the opening boundary for monthly financial transactions and accruals.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter within the fiscal year (1-4). Used for quarterly financial reporting and performance analysis.',
    `fiscal_quarter_end_date` DATE COMMENT 'The end date of the fiscal quarter. Used for quarterly financial close and reporting cutoff.',
    `fiscal_quarter_start_date` DATE COMMENT 'The start date of the fiscal quarter. Used for quarterly financial period boundary identification.',
    `fiscal_week` STRING COMMENT 'The fiscal week number within the fiscal year (1-52 or 1-53). Used for weekly payroll cycles and operational reporting in staffing operations.',
    `fiscal_week_end_date` DATE COMMENT 'The end date of the fiscal week. Used for weekly payroll cutoff and operational reporting in staffing operations.',
    `fiscal_week_start_date` DATE COMMENT 'The start date of the fiscal week. Used for weekly payroll processing and operational reporting cycles in staffing operations.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this calendar period belongs. Represents the annual financial reporting cycle for the staffing enterprise.',
    `fiscal_year_end_date` DATE COMMENT 'The end date of the fiscal year to which this calendar record belongs. Defines the close of the annual financial reporting cycle.',
    `fiscal_year_name` STRING COMMENT 'The display name or label for the fiscal year (e.g., FY2024, 2024-2025). Used for user-friendly reporting and financial statement presentation.',
    `fiscal_year_start_date` DATE COMMENT 'The start date of the fiscal year to which this calendar record belongs. Defines the beginning of the annual financial reporting cycle.',
    `holiday_name` STRING COMMENT 'The name of the holiday if the date is a recognized holiday. Used for payroll processing and employee communication.',
    `is_business_day` BOOLEAN COMMENT 'Indicates whether the calendar date is a business day (True) or non-business day (False). Used for business day calculations in financial processing and service level agreements.',
    `is_holiday` BOOLEAN COMMENT 'Indicates whether the calendar date is a recognized company or statutory holiday. Used for payroll premium calculations and business day adjustments.',
    `is_period_end` BOOLEAN COMMENT 'Indicates whether the calendar date is the last day of a fiscal period. Used for financial close processes and period-end reporting triggers.',
    `is_quarter_end` BOOLEAN COMMENT 'Indicates whether the calendar date is the last day of a fiscal quarter. Used for quarterly financial close and regulatory reporting.',
    `is_weekend` BOOLEAN COMMENT 'Indicates whether the calendar date falls on a weekend (Saturday or Sunday). Used for operational scheduling and payroll processing.',
    `is_year_end` BOOLEAN COMMENT 'Indicates whether the calendar date is the last day of a fiscal year. Used for annual financial close and year-end reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this fiscal calendar record was last modified. Used for audit trail and change tracking.',
    `period_status` STRING COMMENT 'The current status of the fiscal period. Open periods accept transactions, closed periods are locked for reporting, future periods are not yet active.',
    CONSTRAINT pk_fiscal_calendar PRIMARY KEY(`fiscal_calendar_id`)
) COMMENT 'Master reference table for fiscal_calendar. Referenced by fiscal_calendar_id.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Primary key for purchase_order',
    `approved_by_staff_profile_id` BIGINT COMMENT 'Reference to the employee or manager who approved this purchase order.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center or department to which this purchase order expense will be allocated.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Purchase orders need GL account linkage for proper accounting classification. The schema currently has general_ledger_account_id which is a domain-level FK pattern (general_ledger is the domain name',
    `requisition_id` BIGINT COMMENT 'Reference to the originating purchase requisition that initiated this purchase order.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the employee or procurement specialist responsible for creating and managing this purchase order.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier from whom goods or services are being purchased.',
    `amended_purchase_order_id` BIGINT COMMENT 'Self-referencing FK on purchase_order (amended_purchase_order_id)',
    `actual_delivery_date` DATE COMMENT 'The actual date when goods were received or services were completed.',
    `approval_date` DATE COMMENT 'The date when the purchase order was formally approved by authorized personnel.',
    `billing_address_line1` STRING COMMENT 'The first line of the billing address for invoice and payment purposes.',
    `billing_address_line2` STRING COMMENT 'The second line of the billing address, typically used for suite, building, or department information.',
    `billing_city` STRING COMMENT 'The city for the billing address.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address.',
    `billing_postal_code` STRING COMMENT 'The postal or ZIP code for the billing address.',
    `billing_state_province` STRING COMMENT 'The state or province for the billing address.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the purchase order is denominated.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total discount amount applied to this purchase order, including volume discounts and promotional offers.',
    `is_blanket_release` BOOLEAN COMMENT 'Boolean flag indicating whether this purchase order is a release against a blanket purchase agreement.',
    `is_urgent` BOOLEAN COMMENT 'Boolean flag indicating whether this purchase order requires expedited processing and delivery.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order record was last updated or modified.',
    `payment_terms` STRING COMMENT 'The agreed-upon payment terms with the vendor, such as Net 30, Net 60, or 2/10 Net 30.',
    `po_date` DATE COMMENT 'The date when the purchase order was officially created and issued to the vendor.',
    `po_number` STRING COMMENT 'Externally visible, human-readable purchase order number used for vendor communication and document tracking.',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order in the procurement workflow.',
    `po_type` STRING COMMENT 'Classification of the purchase order based on procurement method and usage pattern.',
    `promised_delivery_date` DATE COMMENT 'The date the vendor has committed to deliver the goods or complete the services.',
    `requested_delivery_date` DATE COMMENT 'The date by which the buyer requests delivery of goods or completion of services.',
    `shipping_address_line1` STRING COMMENT 'The first line of the delivery address where goods should be shipped.',
    `shipping_address_line2` STRING COMMENT 'The second line of the delivery address, typically used for suite, building, or department information.',
    `shipping_amount` DECIMAL(18,2) COMMENT 'The shipping and handling charges associated with this purchase order.',
    `shipping_city` STRING COMMENT 'The city where goods should be delivered.',
    `shipping_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the delivery destination.',
    `shipping_method` STRING COMMENT 'The method of shipment or delivery specified for this purchase order, such as ground, air, or freight.',
    `shipping_postal_code` STRING COMMENT 'The postal or ZIP code for the delivery address.',
    `shipping_state_province` STRING COMMENT 'The state or province where goods should be delivered.',
    `special_instructions` STRING COMMENT 'Additional instructions, notes, or requirements communicated to the vendor regarding delivery, handling, or service execution.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'The total amount of all line items before taxes, fees, and discounts are applied.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applied to this purchase order.',
    `total_amount` DECIMAL(18,2) COMMENT 'The final total amount of the purchase order including all taxes, fees, shipping, and discounts.',
    `vendor_contact_email` STRING COMMENT 'The email address of the vendor contact person for communication regarding this purchase order.',
    `vendor_contact_name` STRING COMMENT 'The name of the primary contact person at the vendor organization for this purchase order.',
    `vendor_contact_phone` STRING COMMENT 'The phone number of the vendor contact person for inquiries and coordination.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Master reference table for purchase_order. Referenced by purchase_order_id.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`payment_batch` (
    `payment_batch_id` BIGINT COMMENT 'Primary key for payment_batch',
    `approved_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who approved this payment batch for processing.',
    `bank_account_id` BIGINT COMMENT 'Reference to the company bank account from which payments in this batch will be disbursed.',
    `department_id` BIGINT COMMENT 'Reference to the department or cost center responsible for this payment batch.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Payment batches must be associated with a legal entity for proper financial reporting and compliance. The schema currently has company_id which is semantically equivalent to legal_entity_id in finan',
    `staff_profile_id` BIGINT COMMENT 'Reference to the user who created this payment batch in the system.',
    `reprocessed_payment_batch_id` BIGINT COMMENT 'Self-referencing FK on payment_batch (reprocessed_payment_batch_id)',
    `approval_required` BOOLEAN COMMENT 'Indicates whether this payment batch requires explicit approval before processing, based on business rules or payment amount thresholds.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this payment batch was approved for processing by an authorized approver.',
    `auto_generated` BOOLEAN COMMENT 'Indicates whether this payment batch was automatically generated by the system (e.g., recurring payroll) or manually created by a user.',
    `batch_number` STRING COMMENT 'Human-readable business identifier for the payment batch, typically used in external communications and reporting.',
    `batch_type` STRING COMMENT 'Classification of the payment batch based on the nature of payments included (e.g., payroll for employee wages, vendor for supplier payments, contractor for contingent worker payments).',
    `completed_timestamp` TIMESTAMP COMMENT 'The date and time when all payments in this batch were successfully processed and the batch was marked as complete.',
    `confirmation_number` STRING COMMENT 'The confirmation or reference number provided by the bank or payment processor upon successful receipt and processing of the payment batch.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment batch record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code indicating the currency in which payments in this batch are denominated (e.g., USD, CAD, GBP).',
    `payment_batch_description` STRING COMMENT 'A free-text description providing additional context or details about the purpose or contents of this payment batch.',
    `error_message` STRING COMMENT 'Detailed error message or reason for failure if the payment batch processing encountered errors or was rejected.',
    `failed_payment_count` STRING COMMENT 'The number of payment transactions in this batch that failed to process due to errors or validation issues.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which the total batch amount will be posted for accounting purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payment batch record was last modified or updated.',
    `notes` STRING COMMENT 'Internal notes or comments added by users regarding this payment batch, used for operational communication and documentation.',
    `payment_file_name` STRING COMMENT 'The name of the electronic payment file generated for this batch and transmitted to the bank or payment processor.',
    `payment_file_path` STRING COMMENT 'The storage location or file path where the payment file for this batch is stored in the system.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to execute payments in this batch (e.g., ACH for automated clearing house, wire for wire transfer, direct deposit for employee payroll).',
    `payment_period_end_date` DATE COMMENT 'The end date of the period for which payments in this batch are being made (e.g., the end of a pay period for payroll batches).',
    `payment_period_start_date` DATE COMMENT 'The start date of the period for which payments in this batch are being made (e.g., the beginning of a pay period for payroll batches).',
    `priority` STRING COMMENT 'The priority level assigned to this payment batch, determining the order in which it should be processed relative to other batches.',
    `processing_date` DATE COMMENT 'The actual date on which the payment batch was processed by the financial system.',
    `reconciled_timestamp` TIMESTAMP COMMENT 'The date and time when this payment batch was successfully reconciled against bank statements and accounting records.',
    `reconciliation_status` STRING COMMENT 'The current status of the reconciliation process for this payment batch, indicating whether payments have been matched against bank statements and accounting records.',
    `scheduled_date` DATE COMMENT 'The date on which payments in this batch are scheduled to be processed and disbursed to recipients.',
    `payment_batch_status` STRING COMMENT 'Current lifecycle status of the payment batch indicating its position in the payment processing workflow.',
    `successful_payment_count` STRING COMMENT 'The number of payment transactions in this batch that were successfully processed and disbursed.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total monetary value of all payments included in this batch, representing the gross amount to be disbursed.',
    `total_payment_count` STRING COMMENT 'The total number of individual payment transactions included in this batch.',
    `transmission_timestamp` TIMESTAMP COMMENT 'The date and time when the payment file for this batch was transmitted to the bank or payment processor.',
    CONSTRAINT pk_payment_batch PRIMARY KEY(`payment_batch_id`)
) COMMENT 'Master reference table for payment_batch. Referenced by payment_batch_id.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`business_unit` (
    `business_unit_id` BIGINT COMMENT 'Primary key for business_unit',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity under which this business unit operates for regulatory and tax purposes.',
    `parent_business_unit_id` BIGINT COMMENT 'Reference to the parent business unit in the organizational hierarchy. Null for top-level units.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the employee who serves as the manager or director of this business unit.',
    `address_line_1` STRING COMMENT 'Primary street address line for the business unit headquarters or primary location.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, floor, or building information.',
    `business_unit_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the business unit for reporting and integration purposes.',
    `city` STRING COMMENT 'City or municipality where the business unit is located.',
    `consolidation_method` STRING COMMENT 'Method used to consolidate this business unit into group financial statements.',
    `cost_center_code` STRING COMMENT 'General ledger cost center code assigned to this business unit for expense tracking and allocation.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code where the business unit is domiciled.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this business unit record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the functional currency of the business unit.',
    `business_unit_description` STRING COMMENT 'Detailed description of the business unit purpose, scope, and operational focus.',
    `effective_end_date` DATE COMMENT 'Date when the business unit ceased operations or was closed. Null for currently active units.',
    `effective_start_date` DATE COMMENT 'Date when the business unit became operational and active in the organization.',
    `email_address` STRING COMMENT 'Primary email address for business unit correspondence and inquiries.',
    `fax_number` STRING COMMENT 'Fax number for the business unit, if applicable.',
    `gl_account_segment` STRING COMMENT 'The segment or dimension value in the chart of accounts that represents this business unit for financial reporting.',
    `industry_code` STRING COMMENT 'NAICS or SIC code representing the primary industry classification of the business unit.',
    `is_intercompany_enabled` BOOLEAN COMMENT 'Indicates whether this business unit participates in intercompany transactions and eliminations.',
    `is_revenue_generating` BOOLEAN COMMENT 'Indicates whether this business unit directly generates revenue or is a support/overhead unit.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this business unit record was last modified.',
    `business_unit_name` STRING COMMENT 'Full legal or operational name of the business unit.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the business unit.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the business unit location.',
    `profit_center_code` STRING COMMENT 'General ledger profit center code assigned to this business unit for revenue and profitability tracking.',
    `short_name` STRING COMMENT 'Abbreviated or display name of the business unit used in reports and user interfaces.',
    `state_province` STRING COMMENT 'State, province, or region where the business unit is located.',
    `business_unit_status` STRING COMMENT 'Current operational status of the business unit in its lifecycle.',
    `tax_identification_number` STRING COMMENT 'Tax identification number or employer identification number assigned to the business unit by tax authorities.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the business unit location used for scheduling and reporting.',
    `business_unit_type` STRING COMMENT 'Classification of the business unit indicating its organizational role and hierarchy level.',
    CONSTRAINT pk_business_unit PRIMARY KEY(`business_unit_id`)
) COMMENT 'Master reference table for business_unit. Referenced by business_unit_id.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`finance`.`requisition` (
    `requisition_id` BIGINT COMMENT 'Primary key for requisition',
    `amended_requisition_id` BIGINT COMMENT 'Self-referencing FK on requisition (amended_requisition_id)',
    `account_manager_id` BIGINT COMMENT 'Reference to the account manager responsible for the client relationship associated with this requisition.',
    `approval_date` DATE COMMENT 'The date when the requisition was approved for processing.',
    `approved_by_id` BIGINT COMMENT 'Reference to the employee who approved this requisition.',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether a background check is required for candidates filling this requisition.',
    `bill_rate` DECIMAL(18,2) COMMENT 'The hourly or daily rate charged to the client for the candidates services.',
    `cancellation_reason` STRING COMMENT 'The reason provided when a requisition is cancelled, such as client budget constraints or position elimination.',
    `candidate_id` BIGINT COMMENT 'Reference to the candidate being placed through this requisition.',
    `client_id` BIGINT COMMENT 'Reference to the client organization requesting the staffing requisition.',
    `closed_timestamp` TIMESTAMP COMMENT 'The timestamp when this requisition was formally closed, either due to successful fill or cancellation.',
    `cost_center` STRING COMMENT 'The cost center code used for financial tracking and allocation of requisition expenses.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this requisition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this requisition (e.g., USD, GBP, EUR).',
    `department` STRING COMMENT 'The client department or business unit where the candidate will be assigned.',
    `drug_test_required` BOOLEAN COMMENT 'Indicates whether a drug screening test is required for candidates filling this requisition.',
    `end_date` DATE COMMENT 'The scheduled or actual end date for the candidates assignment or employment. Nullable for permanent placements.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'The estimated total hours for the assignment or project duration.',
    `estimated_revenue` DECIMAL(18,2) COMMENT 'The projected total revenue expected from this requisition based on bill rate and estimated hours or duration.',
    `fill_date` DATE COMMENT 'The date when the requisition was successfully filled with a candidate placement.',
    `general_ledger_account` STRING COMMENT 'The general ledger account code to which revenue and expenses from this requisition are posted.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this requisition generates billable revenue to the client (true) or is non-billable (false).',
    `is_overtime_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for overtime compensation under applicable labor laws.',
    `job_description` STRING COMMENT 'Detailed description of the job responsibilities, requirements, and qualifications for the requisition.',
    `job_order_id` BIGINT COMMENT 'Reference to the job order that this requisition fulfills.',
    `job_title` STRING COMMENT 'The job title or position name for the requisition.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied to the pay rate to determine the bill rate, representing the staffing agencys margin.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this requisition record was last modified or updated.',
    `notes` STRING COMMENT 'Additional free-form notes or comments related to the requisition, including special instructions or client preferences.',
    `number_of_positions` STRING COMMENT 'The quantity of positions or candidates required to fulfill this requisition.',
    `pay_rate` DECIMAL(18,2) COMMENT 'The hourly or daily rate paid to the candidate for their services.',
    `placement_fee` DECIMAL(18,2) COMMENT 'The one-time fee charged to the client for permanent or contract-to-hire placements, typically a percentage of annual salary.',
    `placement_id` BIGINT COMMENT 'Reference to the placement record associated with this requisition.',
    `positions_filled` STRING COMMENT 'The number of positions that have been successfully filled for this requisition.',
    `priority_level` STRING COMMENT 'The urgency or priority level assigned to filling this requisition (low, medium, high, urgent, critical).',
    `recruiter_id` BIGINT COMMENT 'Reference to the internal recruiter responsible for filling this requisition.',
    `requisition_date` DATE COMMENT 'The date when the requisition was formally created or submitted by the client.',
    `requisition_number` STRING COMMENT 'Externally-known unique business identifier for the requisition, typically formatted as REQ-XXXXXXXX.',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the requisition (draft, submitted, approved, in-progress, filled, cancelled, closed).',
    `requisition_type` STRING COMMENT 'Classification of the requisition based on employment arrangement (temporary, permanent, contract, contract-to-hire, temp-to-perm, project-based).',
    `start_date` DATE COMMENT 'The scheduled start date for the candidates assignment or employment.',
    `work_location` STRING COMMENT 'The physical or remote work location where the candidate will perform their duties.',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Master reference table for requisition. Referenced by requisition_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_parent_account_gl_account_id` FOREIGN KEY (`parent_account_gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_parent_gl_account_id` FOREIGN KEY (`parent_gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `staffing_hr_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `staffing_hr_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_reversed_journal_entry_id` FOREIGN KEY (`reversed_journal_entry_id`) REFERENCES `staffing_hr_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_reversing_journal_entry_id` FOREIGN KEY (`reversing_journal_entry_id`) REFERENCES `staffing_hr_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `staffing_hr_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_reversed_line_journal_entry_line_id` FOREIGN KEY (`reversed_line_journal_entry_line_id`) REFERENCES `staffing_hr_ecm`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_offset_journal_entry_line_id` FOREIGN KEY (`offset_journal_entry_line_id`) REFERENCES `staffing_hr_ecm`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ADD CONSTRAINT `fk_finance_accounting_period_budget_period_id` FOREIGN KEY (`budget_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ADD CONSTRAINT `fk_finance_accounting_period_fiscal_calendar_id` FOREIGN KEY (`fiscal_calendar_id`) REFERENCES `staffing_hr_ecm`.`finance`.`fiscal_calendar`(`fiscal_calendar_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ADD CONSTRAINT `fk_finance_accounting_period_prior_year_period_accounting_period_id` FOREIGN KEY (`prior_year_period_accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ADD CONSTRAINT `fk_finance_accounting_period_prior_accounting_period_id` FOREIGN KEY (`prior_accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ADD CONSTRAINT `fk_finance_ar_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ADD CONSTRAINT `fk_finance_ar_account_parent_ar_account_id` FOREIGN KEY (`parent_ar_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_reversed_transaction_ar_transaction_id` FOREIGN KEY (`reversed_transaction_ar_transaction_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_reversal_ar_transaction_id` FOREIGN KEY (`reversal_ar_transaction_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ADD CONSTRAINT `fk_finance_ap_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ADD CONSTRAINT `fk_finance_ap_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ADD CONSTRAINT `fk_finance_ap_account_parent_ap_account_id` FOREIGN KEY (`parent_ap_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ap_account`(`ap_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_ap_account_id` FOREIGN KEY (`ap_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ap_account`(`ap_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `staffing_hr_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_credit_memo_ap_invoice_id` FOREIGN KEY (`credit_memo_ap_invoice_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_payment_batch_id` FOREIGN KEY (`payment_batch_id`) REFERENCES `staffing_hr_ecm`.`finance`.`payment_batch`(`payment_batch_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_voided_ap_payment_id` FOREIGN KEY (`voided_ap_payment_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ap_payment`(`ap_payment_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_original_event_revenue_recognition_event_id` FOREIGN KEY (`original_event_revenue_recognition_event_id`) REFERENCES `staffing_hr_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_reversal_revenue_recognition_event_id` FOREIGN KEY (`reversal_revenue_recognition_event_id`) REFERENCES `staffing_hr_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_prior_deferred_revenue_id` FOREIGN KEY (`prior_deferred_revenue_id`) REFERENCES `staffing_hr_ecm`.`finance`.`deferred_revenue`(`deferred_revenue_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_original_transaction_intercompany_transaction_id` FOREIGN KEY (`original_transaction_intercompany_transaction_id`) REFERENCES `staffing_hr_ecm`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_receiving_legal_entity_id` FOREIGN KEY (`receiving_legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_reversal_intercompany_transaction_id` FOREIGN KEY (`reversal_intercompany_transaction_id`) REFERENCES `staffing_hr_ecm`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `staffing_hr_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_parent_budget_id` FOREIGN KEY (`parent_budget_id`) REFERENCES `staffing_hr_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_revised_budget_id` FOREIGN KEY (`revised_budget_id`) REFERENCES `staffing_hr_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `staffing_hr_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_prior_budget_line_id` FOREIGN KEY (`prior_budget_line_id`) REFERENCES `staffing_hr_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_master_account_bank_account_id` FOREIGN KEY (`master_account_bank_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_parent_bank_account_id` FOREIGN KEY (`parent_bank_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_bank_reconciliation_id` FOREIGN KEY (`bank_reconciliation_id`) REFERENCES `staffing_hr_ecm`.`finance`.`bank_reconciliation`(`bank_reconciliation_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_journal_entry_line_id` FOREIGN KEY (`journal_entry_line_id`) REFERENCES `staffing_hr_ecm`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_reversed_transaction_bank_transaction_id` FOREIGN KEY (`reversed_transaction_bank_transaction_id`) REFERENCES `staffing_hr_ecm`.`finance`.`bank_transaction`(`bank_transaction_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_reversal_bank_transaction_id` FOREIGN KEY (`reversal_bank_transaction_id`) REFERENCES `staffing_hr_ecm`.`finance`.`bank_transaction`(`bank_transaction_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `staffing_hr_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_prior_bank_reconciliation_id` FOREIGN KEY (`prior_bank_reconciliation_id`) REFERENCES `staffing_hr_ecm`.`finance`.`bank_reconciliation`(`bank_reconciliation_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ADD CONSTRAINT `fk_finance_period_close_task_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ADD CONSTRAINT `fk_finance_period_close_task_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `staffing_hr_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ADD CONSTRAINT `fk_finance_period_close_task_dependency_task_id` FOREIGN KEY (`dependency_task_id`) REFERENCES `staffing_hr_ecm`.`finance`.`period_close_task`(`period_close_task_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ADD CONSTRAINT `fk_finance_period_close_task_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ADD CONSTRAINT `fk_finance_period_close_task_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `staffing_hr_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ADD CONSTRAINT `fk_finance_period_close_task_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ADD CONSTRAINT `fk_finance_period_close_task_predecessor_period_close_task_id` FOREIGN KEY (`predecessor_period_close_task_id`) REFERENCES `staffing_hr_ecm`.`finance`.`period_close_task`(`period_close_task_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_original_accrual_id` FOREIGN KEY (`original_accrual_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accrual`(`accrual_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `staffing_hr_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_reversal_accrual_id` FOREIGN KEY (`reversal_accrual_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accrual`(`accrual_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ADD CONSTRAINT `fk_finance_tax_liability_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ADD CONSTRAINT `fk_finance_tax_liability_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `staffing_hr_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ADD CONSTRAINT `fk_finance_tax_liability_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ADD CONSTRAINT `fk_finance_tax_liability_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ADD CONSTRAINT `fk_finance_tax_liability_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ADD CONSTRAINT `fk_finance_tax_liability_amended_tax_liability_id` FOREIGN KEY (`amended_tax_liability_id`) REFERENCES `staffing_hr_ecm`.`finance`.`tax_liability`(`tax_liability_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_parent_fixed_asset_id` FOREIGN KEY (`parent_fixed_asset_id`) REFERENCES `staffing_hr_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `staffing_hr_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `staffing_hr_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `staffing_hr_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_prior_depreciation_schedule_id` FOREIGN KEY (`prior_depreciation_schedule_id`) REFERENCES `staffing_hr_ecm`.`finance`.`depreciation_schedule`(`depreciation_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ADD CONSTRAINT `fk_finance_budget_allocation_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `staffing_hr_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`fiscal_calendar` ADD CONSTRAINT `fk_finance_fiscal_calendar_prior_fiscal_calendar_id` FOREIGN KEY (`prior_fiscal_calendar_id`) REFERENCES `staffing_hr_ecm`.`finance`.`fiscal_calendar`(`fiscal_calendar_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `staffing_hr_ecm`.`finance`.`requisition`(`requisition_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_amended_purchase_order_id` FOREIGN KEY (`amended_purchase_order_id`) REFERENCES `staffing_hr_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_reprocessed_payment_batch_id` FOREIGN KEY (`reprocessed_payment_batch_id`) REFERENCES `staffing_hr_ecm`.`finance`.`payment_batch`(`payment_batch_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_parent_business_unit_id` FOREIGN KEY (`parent_business_unit_id`) REFERENCES `staffing_hr_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`requisition` ADD CONSTRAINT `fk_finance_requisition_amended_requisition_id` FOREIGN KEY (`amended_requisition_id`) REFERENCES `staffing_hr_ecm`.`finance`.`requisition`(`requisition_id`);

-- ========= TAGS =========
ALTER SCHEMA `staffing_hr_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `staffing_hr_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `parent_account_gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent General Ledger (GL) Account ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `parent_gl_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `accepts_postings` SET TAGS ('dbx_business_glossary_term' = 'Accepts Postings Indicator');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `account_class` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Class');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `account_description` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Description');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `account_level` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Level');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Indicator');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `budget_account` SET TAGS ('dbx_business_glossary_term' = 'Budget Account Indicator');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Statement Classification');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `cash_flow_classification` SET TAGS ('dbx_value_regex' = 'operating|investing|financing');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `consolidation_account` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Mapping');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_center_applicable` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Applicable Indicator');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `external_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `gaap_classification` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Classification');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `ifrs_classification` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Classification');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Account Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `is_summary_account` SET TAGS ('dbx_business_glossary_term' = 'Summary Account Indicator');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `normal_balance` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance Indicator');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `normal_balance` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `reconciliation_required` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Required Indicator');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `statistical_account` SET TAGS ('dbx_business_glossary_term' = 'Statistical Account Indicator');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_line_mapping` SET TAGS ('dbx_business_glossary_term' = 'Tax Return Line Mapping');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `staffing_hr_ecm`.`finance`.`gl_account` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `primary_cost_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|headcount|revenue|fte|square_footage|transaction_volume');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_closure|closed');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'branch|division|corporate|shared_services|regional|department');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `external_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `gl_account_segment` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Segment');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `gl_account_segment` SET TAGS ('dbx_value_regex' = '^[0-9]{4,8}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `overhead_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overhead Rate Percentage');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `overhead_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_flag` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `revenue_generating_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Generating Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Recurring Schedule ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Journal Entry ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversing_journal_entry_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_date` SET TAGS ('dbx_business_glossary_term' = 'Journal Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Description');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_type` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_type` SET TAGS ('dbx_value_regex' = 'standard|adjusting|reversing|accrual|intercompany|reclassification');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|rejected|cancelled');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `recurring_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurring Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'payroll|billing|accounts_payable|accounts_receivable|manual|revenue_recognition');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `conversion_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `credit_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `department_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `direct_hire_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversed_line_journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Journal Entry Line ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vms Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `offset_journal_entry_line_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `intercompany_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Entity Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reconciled_by` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By User');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|pending_review|exception');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `source_document_type` SET TAGS ('dbx_business_glossary_term' = 'Source Document Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `statistical_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `statistical_quantity` SET TAGS ('dbx_business_glossary_term' = 'Statistical Quantity');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `statistical_unit` SET TAGS ('dbx_business_glossary_term' = 'Statistical Unit of Measure');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Credit Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `transaction_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Debit Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `budget_period_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Period ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `close_coordinator_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Close Coordinator Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `fiscal_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Calendar ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `locked_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Locked By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `locked_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `locked_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `prior_year_period_accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Period ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `prior_accounting_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `accounting_period_description` SET TAGS ('dbx_business_glossary_term' = 'Period Description');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `ap_open` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Open');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `ar_open` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Open');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `billing_open` SET TAGS ('dbx_business_glossary_term' = 'Billing Open');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Period Close Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `gl_open` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Open');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `is_adjustment_period` SET TAGS ('dbx_business_glossary_term' = 'Is Adjustment Period');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `is_year_end_period` SET TAGS ('dbx_business_glossary_term' = 'Is Year End Period');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `lock_date` SET TAGS ('dbx_business_glossary_term' = 'Period Lock Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `payroll_open` SET TAGS ('dbx_business_glossary_term' = 'Payroll Open');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Period Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'open|closed|locked|adjusting|future');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|semi-annual|adjusting');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `quarter_number` SET TAGS ('dbx_business_glossary_term' = 'Quarter Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` SET TAGS ('dbx_subdomain' = 'subledger_operations');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Account ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Collector ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `parent_ar_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `account_close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `account_open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|collections|write_off|legal');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `aging_30_days_amount` SET TAGS ('dbx_business_glossary_term' = 'Aging 30 Days Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `aging_60_days_amount` SET TAGS ('dbx_business_glossary_term' = 'Aging 60 Days Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `aging_90_days_amount` SET TAGS ('dbx_business_glossary_term' = 'Aging 90 Days Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `aging_over_90_days_amount` SET TAGS ('dbx_business_glossary_term' = 'Aging Over 90 Days Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `ar_account_number` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Account Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `ar_account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `ar_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `ar_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `auto_pay_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Enabled');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `available_credit` SET TAGS ('dbx_business_glossary_term' = 'Available Credit');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `bad_debt_reserve` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Reserve');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|semimonthly|on_demand');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `credit_hold_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `credit_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Reason');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `current_bucket_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Bucket Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `days_sales_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `last_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `last_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `next_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Next Statement Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|net_90|due_on_receipt');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `statement_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Statement Delivery Method');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `statement_delivery_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|portal|edi');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` SET TAGS ('dbx_subdomain' = 'subledger_operations');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Transaction ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `credit_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Processor Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `reversed_transaction_ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Accounts Receivable (AR) Transaction ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `reversal_ar_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `adjustment_notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Aging Bucket');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `deferred_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|voided');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `revenue_recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `revenue_recognition_status` SET TAGS ('dbx_value_regex' = 'recognized|deferred|partial|pending');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Transaction Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Transaction Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Transaction Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Transaction Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'invoice|payment|credit_memo|debit_memo|write_off|adjustment');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` SET TAGS ('dbx_subdomain' = 'subledger_operations');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `ap_account_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Account ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `parent_ap_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `account_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Account Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `account_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|disputed|under_review');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'trade_payable|expense_payable|subcontractor_payable|service_payable|tax_payable|other');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `aging_31_60` SET TAGS ('dbx_business_glossary_term' = 'Aging 31-60 Days');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `aging_61_90` SET TAGS ('dbx_business_glossary_term' = 'Aging 61-90 Days');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `aging_current` SET TAGS ('dbx_business_glossary_term' = 'Aging Current (0-30 Days)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `aging_over_90` SET TAGS ('dbx_business_glossary_term' = 'Aging Over 90 Days');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `hold_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Payment Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `is_1099_reportable` SET TAGS ('dbx_business_glossary_term' = '1099 Reportable Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `is_msp_vms_vendor` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Provider (MSP) / Vendor Management System (VMS) Vendor Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `last_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `last_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `lifetime_payment_total` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Payment Total');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire|check|credit_card|eft|other');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `payment_priority` SET TAGS ('dbx_business_glossary_term' = 'Payment Priority');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `payment_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low|standard');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9 /]{1,50}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$|^[0-9]{3}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `vendor_category` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ALTER COLUMN `ytd_payment_total` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Payment Total');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'subledger_operations');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ap_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `sow_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Placement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `credit_memo_ap_invoice_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Pending|Approved|Rejected|On Hold|Escalated');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR|AUD|MXN');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Hold Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Hold Reason');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_category` SET TAGS ('dbx_business_glossary_term' = 'Invoice Category');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_category` SET TAGS ('dbx_value_regex' = 'Staffing Supplier|Subcontractor|Professional Services|Software License|Office Supplies|Utilities');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'Standard|Credit Memo|Debit Memo|Prepayment|Recurring');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|Wire Transfer|Check|Credit Card|EFT');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'Unpaid|Partially Paid|Paid|Voided|Cancelled');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `receipt_reference` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'Matched|Unmatched|Partially Matched|Exception|Not Applicable');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` SET TAGS ('dbx_subdomain' = 'subledger_operations');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Payment ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Processor Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `voided_ap_payment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Trace Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Pending|Approved|Rejected');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Cleared Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|Check|Wire Transfer|Virtual Card|EFT|Cash');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_priority` SET TAGS ('dbx_business_glossary_term' = 'Payment Priority');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_priority` SET TAGS ('dbx_value_regex' = 'Standard|Urgent|Rush|Hold');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Payment Source System');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `reconciled_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciled Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'Unreconciled|Reconciled|Exception');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `remittance_email` SET TAGS ('dbx_business_glossary_term' = 'Remittance Email Address');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `remittance_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `remittance_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `remittance_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Sent Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Void Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Reference Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` SET TAGS ('dbx_subdomain' = 'subledger_operations');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `conversion_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `credit_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `direct_hire_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `original_event_revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Original Revenue Recognition Event ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Accountant Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `sow_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Engagement ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `reversal_revenue_recognition_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Revenue Adjustment Reason');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `contract_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Liability Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `deferred_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `percentage_complete` SET TAGS ('dbx_business_glossary_term' = 'Percentage of Completion');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `performance_obligation_reference` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Reference');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted to General Ledger (GL) Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_event_number` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_event_number` SET TAGS ('dbx_value_regex' = '^RRE-[0-9]{8}-[0-9]{6}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'time_and_materials|milestone|percentage_of_completion|fixed_fee|point_in_time|over_time');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognition_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|reversed|adjusted');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `recognized_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Revenue Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `revenue_category` SET TAGS ('dbx_value_regex' = 'temporary_staffing|permanent_placement|contract_staffing|sow_project|rpo_services|payroll_services');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `revenue_stream` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `service_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period End Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `service_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ALTER COLUMN `unbilled_receivable_amount` SET TAGS ('dbx_business_glossary_term' = 'Unbilled Receivable Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` SET TAGS ('dbx_subdomain' = 'subledger_operations');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `deferred_revenue_id` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `credit_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `prior_deferred_revenue_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `arrangement_type` SET TAGS ('dbx_value_regex' = 'retainer|prepaid_staffing|sow_fixed_fee|rpo_program|msp_program|other');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|semi_annual|annual|milestone_based');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Months');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `deferred_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `is_refundable` SET TAGS ('dbx_business_glossary_term' = 'Is Refundable');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `last_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Last Recognition Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `liability_status` SET TAGS ('dbx_business_glossary_term' = 'Liability Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `liability_status` SET TAGS ('dbx_value_regex' = 'active|fully_recognized|partially_recognized|reversed|cancelled');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `monthly_recognition_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Recognition Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `next_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recognition Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `performance_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Description');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `period_end_balance` SET TAGS ('dbx_business_glossary_term' = 'Period End Balance');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `recognition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition End Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `recognition_method_notes` SET TAGS ('dbx_business_glossary_term' = 'Recognition Method Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `recognition_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Recognition Schedule Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `recognition_schedule_type` SET TAGS ('dbx_value_regex' = 'straight_line|milestone|usage_based|time_and_materials|performance_obligation|event_driven');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `recognition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition Start Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `recognized_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized to Date Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `remaining_deferred_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Deferred Balance');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'netsuite_erp|salesforce_revenue_cloud|manual_entry|other');
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'subledger_operations');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `original_transaction_intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Legal Entity ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Legal Entity ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_intercompany_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|cancelled');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Elimination Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Invoice Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partially_paid|paid|waived|written_off');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving General Ledger (GL) Account Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciled_by` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Reconciliation Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|pending|exception|resolved');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reporting_amount` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `parent_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Budget ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vms Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `revised_budget_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Method');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|proportional|activity_based|headcount|revenue');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|locked|rejected|archived');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'operating|capital|headcount|revenue|expense|project');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `headcount_fte` SET TAGS ('dbx_business_glossary_term' = 'Headcount Full-Time Equivalent (FTE)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Budget');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `is_capital_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Is Capital Expenditure (CapEx)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Budget Modified By');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `period` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|weekly');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `variance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|actual');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `department_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vms Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `prior_budget_line_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'headcount|revenue|square_footage|transaction_volume|historical|strategic');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|revised');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(Q[1-4]|M(0[1-9]|1[0-2])|FY)$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `is_discretionary` SET TAGS ('dbx_business_glossary_term' = 'Is Discretionary Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Is Locked Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `prior_year_actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Actual Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `service_line_code` SET TAGS ('dbx_business_glossary_term' = 'Service Line Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `service_line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_to_prior_year` SET TAGS ('dbx_business_glossary_term' = 'Variance to Prior Year');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `variance_to_prior_year_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance to Prior Year Percentage');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'treasury_management');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `administrator_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Administrator Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `master_account_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Master Account ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `master_account_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `master_account_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `parent_bank_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `account_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_last_four` SET TAGS ('dbx_business_glossary_term' = 'Account Number Last Four Digits');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_last_four` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `account_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|dormant|closed|frozen|pending_activation');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'operating|payroll|trust|concentration|escrow|tax_reserve');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `ach_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Enabled');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `available_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Balance Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `available_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Address');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Email Address');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Phone Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number (ABA RTN)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('dbx_business_glossary_term' = 'Bank SWIFT Code (BIC)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_swift_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `current_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Balance Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `current_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `daily_transaction_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `daily_transaction_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_bearing` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Account');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percentage');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `minimum_balance_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Required');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `monthly_service_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Service Fee Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `online_banking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Online Banking Enabled');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `positive_pay_enabled` SET TAGS ('dbx_business_glossary_term' = 'Positive Pay Enabled');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Signatory Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `primary_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `secondary_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Secondary Signatory Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `secondary_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Signatory Requirement');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_requirement` SET TAGS ('dbx_value_regex' = 'single|dual|any_two|all');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `transaction_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `transaction_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `wire_transfer_enabled` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Enabled');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ALTER COLUMN `zero_balance_account` SET TAGS ('dbx_business_glossary_term' = 'Zero Balance Account (ZBA)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` SET TAGS ('dbx_subdomain' = 'treasury_management');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `bank_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Transaction ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `bank_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Reconciliation Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Matched GL (General Ledger) Transaction ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `reversed_transaction_bank_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Transaction ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `reversal_bank_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_business_glossary_term' = 'ACH (Automated Clearing House) Trace Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `bank_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Reference Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `bank_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Batch ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit Credit Indicator');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `payee_payor_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Payor Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|matched|cleared|voided|in_dispute');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `running_balance` SET TAGS ('dbx_business_glossary_term' = 'Running Balance');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `statement_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Statement Sequence Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Transaction Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Transaction Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Reference Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` SET TAGS ('dbx_subdomain' = 'treasury_management');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Reconciliation ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `primary_bank_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `reviewer_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `prior_bank_reconciliation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `adjusted_bank_balance` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Bank Balance');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `adjusted_book_balance` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Book Balance');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `auto_reconciled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Reconciled Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_errors_total` SET TAGS ('dbx_business_glossary_term' = 'Bank Errors Total');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_service_charges` SET TAGS ('dbx_business_glossary_term' = 'Bank Service Charges');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `book_errors_total` SET TAGS ('dbx_business_glossary_term' = 'Book Errors Total');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `gl_book_balance` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Book Balance');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `interest_earned` SET TAGS ('dbx_business_glossary_term' = 'Interest Earned');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `nsf_charges` SET TAGS ('dbx_business_glossary_term' = 'Non-Sufficient Funds (NSF) Charges');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `other_adjustments_total` SET TAGS ('dbx_business_glossary_term' = 'Other Adjustments Total');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `outstanding_checks_total` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Checks and Payments Total');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `outstanding_deposits_total` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Deposits in Transit Total');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `preparation_date` SET TAGS ('dbx_business_glossary_term' = 'Preparation Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Reconciliation Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_value_regex' = '^BR-[0-9]{6,12}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'in_progress|reconciled|approved|rejected|under_review|pending_approval');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `requires_journal_entry_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Journal Entry Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_ending_balance` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Ending Balance');
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `period_close_task_id` SET TAGS ('dbx_business_glossary_term' = 'Period Close Task ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `approver_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `dependency_task_id` SET TAGS ('dbx_business_glossary_term' = 'Dependency Task ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `primary_period_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Completed By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `waived_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waived By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `waived_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `waived_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `predecessor_period_close_task_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `assigned_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `assigned_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `automation_job_reference` SET TAGS ('dbx_business_glossary_term' = 'Automation Job ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated Task');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `is_blocking` SET TAGS ('dbx_business_glossary_term' = 'Is Blocking Task');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Task');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Task Priority');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|semi_annually');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `requires_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Approval');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `sign_off_notes` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `supporting_document_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document URL');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `task_category` SET TAGS ('dbx_business_glossary_term' = 'Task Category');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `task_instructions` SET TAGS ('dbx_business_glossary_term' = 'Task Instructions');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Task Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Task Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `task_sequence` SET TAGS ('dbx_business_glossary_term' = 'Task Sequence');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue|waived|blocked');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `approver_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `approver_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `approver_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `conversion_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `direct_hire_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `original_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Original Accrual Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `placement_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Journal Entry Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer User Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vms Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `reversal_accrual_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_number` SET TAGS ('dbx_business_glossary_term' = 'Accrual Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|adjusted|cancelled');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_business_glossary_term' = 'Accrual Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_value_regex' = 'payroll_accrual|unbilled_revenue|vendor_accrual|bonus_accrual|workers_comp_accrual|fica_accrual');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `basis_of_estimate` SET TAGS ('dbx_business_glossary_term' = 'Basis of Estimate');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `basis_of_estimate` SET TAGS ('dbx_value_regex' = 'hours_times_rate|percentage|fixed_amount|historical_average|contractual');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `estimate_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimate Hours');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `estimate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Estimate Percentage');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `estimate_rate` SET TAGS ('dbx_business_glossary_term' = 'Estimate Rate');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Accrual Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `reversal_status` SET TAGS ('dbx_business_glossary_term' = 'Reversal Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `reversal_status` SET TAGS ('dbx_value_regex' = 'pending|reversed|cancelled|adjusted');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source Reference Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `source_reference_type` SET TAGS ('dbx_business_glossary_term' = 'Source Reference Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `source_reference_type` SET TAGS ('dbx_value_regex' = 'assignment|pay_period|contract|sow|placement|invoice');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` SET TAGS ('dbx_subdomain' = 'treasury_management');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `tax_liability_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Liability ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `amended_tax_liability_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `calculated_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Calculated Tax Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `extended_due_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Due Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `extension_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Granted Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `filing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Due Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Method');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|third_party_service');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|amended|under_review|accepted|rejected');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Level');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_value_regex' = 'federal|state|local|municipal|county');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `net_tax_due` SET TAGS ('dbx_business_glossary_term' = 'Net Tax Due');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partially_paid|paid|overpaid|waived|disputed');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `tax_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Tax Adjustments');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `tax_authority_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Identifier');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `tax_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `tax_credits_applied` SET TAGS ('dbx_business_glossary_term' = 'Tax Credits Applied');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `tax_liability_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Liability Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `tax_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Period End Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `tax_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ALTER COLUMN `taxable_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Base Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'treasury_management');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `department_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Employee ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tertiary_fixed_modified_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `parent_fixed_asset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_value_regex' = 'office_equipment|furniture|vehicles|computer_hardware|leasehold_improvements|software');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|disposed|fully_depreciated|under_construction|retired|impaired');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Asset Subcategory');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|double_declining_balance|macrs|units_of_production');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `gain_loss_on_disposal` SET TAGS ('dbx_business_glossary_term' = 'Gain or Loss on Disposal');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_date` SET TAGS ('dbx_business_glossary_term' = 'Impairment Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_flag` SET TAGS ('dbx_business_glossary_term' = 'Impairment Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_flag` SET TAGS ('dbx_business_glossary_term' = 'Lease Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Asset Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `physical_location` SET TAGS ('dbx_business_glossary_term' = 'Physical Location');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{6,12}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Depreciation Method');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_value_regex' = 'macrs|section_179|bonus_depreciation|straight_line');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_months` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Months)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` SET TAGS ('dbx_subdomain' = 'treasury_management');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Schedule ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `department_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `tertiary_depreciation_modified_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `prior_depreciation_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `accumulated_depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `beginning_net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Beginning Net Book Value');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Expense Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|double_declining_balance|sum_of_years_digits|units_of_production|macrs');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `depreciation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate Percent');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `ending_net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Ending Net Book Value');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `posted_date` SET TAGS ('dbx_business_glossary_term' = 'Posted Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|reversed|cancelled');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `remaining_useful_life_months` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life Months');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `salvage_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `schedule_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Sequence Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ALTER COLUMN `useful_life_months` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Months');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `controller_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Controller Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `parent_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Legal Entity ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'US GAAP|IFRS|Statutory|Tax Basis');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `ein` SET TAGS ('dbx_business_glossary_term' = 'Employer Identification Number (EIN)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `ein` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `ein` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'C-Corporation|S-Corporation|LLC|Partnership|Sole Proprietorship|Branch');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_end_day` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Day');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_end_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Month');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `intercompany_elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `is_disregarded_entity` SET TAGS ('dbx_business_glossary_term' = 'Is Disregarded Entity');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `is_public_company` SET TAGS ('dbx_business_glossary_term' = 'Is Public Company');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_business_description` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Description');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Registered Agent Name');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Country Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state` SET TAGS ('dbx_business_glossary_term' = 'Registered State');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `sec_cik_number` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Central Index Key (CIK) Number');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `sec_cik_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `state_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'State of Incorporation');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `state_of_incorporation` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `stock_exchange` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `stock_ticker_symbol` SET TAGS ('dbx_business_glossary_term' = 'Stock Ticker Symbol');
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` SET TAGS ('dbx_association_edges' = 'finance.budget,employee.department');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `budget_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Identifier');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation - Budget Id');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation - Department Id');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `allocated_by` SET TAGS ('dbx_business_glossary_term' = 'Allocated By');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ALTER COLUMN `variance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fiscal_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fiscal_calendar` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fiscal_calendar` ALTER COLUMN `fiscal_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Calendar Identifier');
ALTER TABLE `staffing_hr_ecm`.`finance`.`fiscal_calendar` ALTER COLUMN `prior_fiscal_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` SET TAGS ('dbx_subdomain' = 'subledger_operations');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `amended_purchase_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`payment_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`payment_batch` SET TAGS ('dbx_subdomain' = 'subledger_operations');
ALTER TABLE `staffing_hr_ecm`.`finance`.`payment_batch` ALTER COLUMN `payment_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Identifier');
ALTER TABLE `staffing_hr_ecm`.`finance`.`payment_batch` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`finance`.`payment_batch` ALTER COLUMN `reprocessed_payment_batch_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`payment_batch` ALTER COLUMN `payment_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`finance`.`requisition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`finance`.`requisition` SET TAGS ('dbx_subdomain' = 'subledger_operations');
ALTER TABLE `staffing_hr_ecm`.`finance`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Identifier');
ALTER TABLE `staffing_hr_ecm`.`finance`.`requisition` ALTER COLUMN `amended_requisition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
