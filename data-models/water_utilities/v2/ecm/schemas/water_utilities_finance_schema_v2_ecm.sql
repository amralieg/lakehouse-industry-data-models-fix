-- Schema for Domain: finance | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 18:57:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`finance` COMMENT 'Enterprise financial management including general ledger, accounts payable and receivable, cost center accounting, capital and operating budgets, financial reporting, rate case preparation, GASB compliance, grant management, debt service tracking, and financial planning and analysis. Integrates with SAP FI/CO and Tyler Munis for fund accounting and municipal financial statements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` (
    `general_ledger_id` BIGINT COMMENT 'Primary key',
    `fund_id` BIGINT COMMENT 'Fund to which this GL account belongs',
    `account_category` STRING COMMENT 'Sub-classification of account type',
    `account_name` STRING COMMENT 'GL account name',
    `account_number` STRING COMMENT 'GL account number',
    `account_type` STRING COMMENT 'Asset, Liability, Equity, Revenue, Expense',
    `balance_sheet_section` STRING COMMENT 'Current/Non-current classification',
    `budget_controlled_flag` BOOLEAN COMMENT 'Whether account requires budget check',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'Date account was retired',
    `effective_start_date` DATE COMMENT 'Date account became effective',
    `encumbrance_flag` BOOLEAN COMMENT 'Whether account supports encumbrances',
    `financial_statement_line` STRING COMMENT 'Line item on financial statements',
    `gasb_classification` STRING COMMENT 'GASB 34 classification',
    `is_active` BOOLEAN COMMENT 'Whether account is active',
    `normal_balance` STRING COMMENT 'Debit or Credit',
    `restricted_flag` BOOLEAN COMMENT 'Whether account is restricted',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_general_ledger PRIMARY KEY(`general_ledger_id`)
) COMMENT 'General ledger account master for chart of accounts, fund accounting, and financial reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`fund` (
    `fund_id` BIGINT COMMENT 'Primary key',
    `budget_controlled_flag` BOOLEAN COMMENT 'Whether fund requires budget',
    `fund_category` STRING COMMENT 'General, Special Revenue, Capital Projects, Debt Service, Enterprise, Internal Service',
    `fund_code` STRING COMMENT 'Fund code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'Date fund was closed',
    `effective_start_date` DATE COMMENT 'Date fund became effective',
    `encumbrance_flag` BOOLEAN COMMENT 'Whether fund supports encumbrances',
    `fund_type` STRING COMMENT 'Governmental, Proprietary, Fiduciary',
    `gasb_54_classification` STRING COMMENT 'Nonspendable, Restricted, Committed, Assigned, Unassigned',
    `is_active` BOOLEAN COMMENT 'Whether fund is active',
    `legal_authority` STRING COMMENT 'Legal authority establishing fund',
    `fund_name` STRING COMMENT 'Fund name',
    `restricted_purpose` STRING COMMENT 'Purpose for which fund is restricted',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_fund PRIMARY KEY(`fund_id`)
) COMMENT 'Fund master for governmental fund accounting per GASB 34.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Primary key',
    `fund_id` BIGINT COMMENT 'Fund to which cost center belongs',
    `employee_id` BIGINT COMMENT 'Manager responsible for cost center',
    `parent_cost_center_id` BIGINT COMMENT 'Parent cost center for hierarchy',
    `budget_controlled_flag` BOOLEAN COMMENT 'Whether cost center requires budget',
    `cost_center_code` STRING COMMENT 'Cost center code',
    `cost_center_type` STRING COMMENT 'Operational, Administrative, Capital',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `department` STRING COMMENT 'Department name',
    `effective_end_date` DATE COMMENT 'Date cost center was closed',
    `effective_start_date` DATE COMMENT 'Date cost center became effective',
    `is_active` BOOLEAN COMMENT 'Whether cost center is active',
    `cost_center_name` STRING COMMENT 'Cost center name',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Cost center master for departmental and operational cost tracking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Primary key',
    `fund_id` BIGINT COMMENT 'Fund for this entry',
    `employee_id` BIGINT COMMENT 'Employee who approved entry',
    `journal_created_by_employee_id` BIGINT COMMENT 'Employee who created entry',
    `reversed_journal_entry_id` BIGINT COMMENT 'Original entry being reversed',
    `approval_date` DATE COMMENT 'Date entry was approved',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `journal_entry_description` STRING COMMENT 'Journal entry description',
    `fiscal_period` STRING COMMENT 'Fiscal period',
    `fiscal_year` STRING COMMENT 'Fiscal year',
    `journal_category` STRING COMMENT 'Manual, Recurring, Adjusting, Closing',
    `journal_entry_date` DATE COMMENT 'Date of journal entry',
    `journal_entry_number` STRING COMMENT 'Journal entry number',
    `journal_source` STRING COMMENT 'Source system or module',
    `posting_date` DATE COMMENT 'Date entry was posted',
    `reference_number` STRING COMMENT 'External reference number',
    `reversal_flag` BOOLEAN COMMENT 'Whether this is a reversal entry',
    `journal_entry_status` STRING COMMENT 'Draft, Posted, Reversed',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Journal entry header for financial transactions.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project if applicable',
    `cost_center_id` BIGINT COMMENT 'Cost center',
    `fund_id` BIGINT COMMENT 'Fund',
    `general_ledger_id` BIGINT COMMENT 'GL account',
    `grant_id` BIGINT COMMENT 'Grant if applicable',
    `journal_entry_id` BIGINT COMMENT 'Parent journal entry',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credit_amount` DECIMAL(18,2) COMMENT 'Credit amount',
    `currency_code` STRING COMMENT 'Currency code',
    `debit_amount` DECIMAL(18,2) COMMENT 'Debit amount',
    `line_description` STRING COMMENT 'Line description',
    `line_number` STRING COMMENT 'Line sequence number',
    `reference_1` STRING COMMENT 'Additional reference',
    `reference_2` STRING COMMENT 'Additional reference',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Journal entry line detail for individual debits and credits.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'Cost center',
    `fund_id` BIGINT COMMENT 'Fund',
    `purchase_order_id` BIGINT COMMENT 'Purchase order',
    `vendor_id` BIGINT COMMENT 'Vendor',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `ap_invoice_description` STRING COMMENT 'Invoice description',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount',
    `due_date` DATE COMMENT 'Payment due date',
    `invoice_amount` DECIMAL(18,2) COMMENT 'Total invoice amount',
    `invoice_date` DATE COMMENT 'Invoice date',
    `invoice_number` STRING COMMENT 'Vendor invoice number',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount due',
    `paid_amount` DECIMAL(18,2) COMMENT 'Amount paid',
    `payment_terms` STRING COMMENT 'Payment terms',
    `ap_invoice_status` STRING COMMENT 'Pending, Approved, Paid, Cancelled',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts payable invoice for vendor payments.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'Primary key',
    `bank_account_id` BIGINT COMMENT 'Bank account',
    `payment_run_id` BIGINT COMMENT 'Payment run',
    `vendor_id` BIGINT COMMENT 'Vendor',
    `check_number` STRING COMMENT 'Check number',
    `cleared_date` DATE COMMENT 'Date payment cleared bank',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `payment_amount` DECIMAL(18,2) COMMENT 'Payment amount',
    `payment_date` DATE COMMENT 'Payment date',
    `payment_method` STRING COMMENT 'Check, ACH, Wire',
    `payment_number` STRING COMMENT 'Payment number',
    `ap_payment_status` STRING COMMENT 'Pending, Cleared, Voided',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `void_date` DATE COMMENT 'Date payment was voided',
    `void_reason` STRING COMMENT 'Reason for void',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Accounts payable payment to vendors.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` (
    `ar_transaction_id` BIGINT COMMENT 'Primary key',
    `customer_account_id` BIGINT COMMENT 'Customer account',
    `fund_id` BIGINT COMMENT 'Fund',
    `invoice_id` BIGINT COMMENT 'Invoice',
    `balance_impact` DECIMAL(18,2) COMMENT 'Impact on customer balance',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `ar_transaction_description` STRING COMMENT 'Transaction description',
    `reference_number` STRING COMMENT 'Reference number',
    `ar_transaction_status` STRING COMMENT 'Posted, Reversed',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Transaction amount',
    `transaction_date` DATE COMMENT 'Transaction date',
    `transaction_type` STRING COMMENT 'Invoice, Payment, Adjustment, Write-off',
    CONSTRAINT pk_ar_transaction PRIMARY KEY(`ar_transaction_id`)
) COMMENT 'Accounts receivable transaction for customer billing and payments.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` (
    `finance_budget_id` BIGINT COMMENT 'Primary key',
    `fund_id` BIGINT COMMENT 'Fund',
    `adoption_date` DATE COMMENT 'Date budget was adopted',
    `budget_name` STRING COMMENT 'Budget name',
    `budget_status` STRING COMMENT 'Draft, Proposed, Adopted, Amended',
    `budget_type` STRING COMMENT 'Operating, Capital, Grant',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'Budget effective end date',
    `effective_start_date` DATE COMMENT 'Budget effective start date',
    `fiscal_year` STRING COMMENT 'Fiscal year',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total budget amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_finance_budget PRIMARY KEY(`finance_budget_id`)
) COMMENT 'Budget master for annual operating and capital budgets.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'Cost center',
    `finance_budget_id` BIGINT COMMENT 'Parent budget',
    `fund_id` BIGINT COMMENT 'Fund',
    `general_ledger_id` BIGINT COMMENT 'GL account',
    `actual_amount` DECIMAL(18,2) COMMENT 'Actual amount spent',
    `available_amount` DECIMAL(18,2) COMMENT 'Available budget amount',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `encumbered_amount` DECIMAL(18,2) COMMENT 'Encumbered amount',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'Original budget amount',
    `period_10_amount` DECIMAL(18,2) COMMENT 'Period 10 budget',
    `period_11_amount` DECIMAL(18,2) COMMENT 'Period 11 budget',
    `period_12_amount` DECIMAL(18,2) COMMENT 'Period 12 budget',
    `period_1_amount` DECIMAL(18,2) COMMENT 'Period 1 budget',
    `period_2_amount` DECIMAL(18,2) COMMENT 'Period 2 budget',
    `period_3_amount` DECIMAL(18,2) COMMENT 'Period 3 budget',
    `period_4_amount` DECIMAL(18,2) COMMENT 'Period 4 budget',
    `period_5_amount` DECIMAL(18,2) COMMENT 'Period 5 budget',
    `period_6_amount` DECIMAL(18,2) COMMENT 'Period 6 budget',
    `period_7_amount` DECIMAL(18,2) COMMENT 'Period 7 budget',
    `period_8_amount` DECIMAL(18,2) COMMENT 'Period 8 budget',
    `period_9_amount` DECIMAL(18,2) COMMENT 'Period 9 budget',
    `revised_budget_amount` DECIMAL(18,2) COMMENT 'Revised budget amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Budget line detail for account-level budget allocations.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Primary key',
    `registry_id` BIGINT COMMENT 'Physical asset registry',
    `fund_id` BIGINT COMMENT 'Fund',
    `general_ledger_id` BIGINT COMMENT 'GL account',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Accumulated depreciation',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Acquisition cost',
    `acquisition_date` DATE COMMENT 'Acquisition date',
    `asset_class` STRING COMMENT 'Asset class',
    `asset_description` STRING COMMENT 'Asset description',
    `asset_number` STRING COMMENT 'Asset number',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `depreciation_method` STRING COMMENT 'Straight-line, Declining Balance',
    `disposal_date` DATE COMMENT 'Disposal date',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Disposal proceeds',
    `in_service_date` DATE COMMENT 'In service date',
    `net_book_value` DECIMAL(18,2) COMMENT 'Net book value',
    `salvage_value` DECIMAL(18,2) COMMENT 'Salvage value',
    `fixed_asset_status` STRING COMMENT 'Active, Disposed, Retired',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `useful_life_years` STRING COMMENT 'Useful life in years',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset register for capitalized assets and depreciation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`grant` (
    `grant_id` BIGINT COMMENT 'Primary key',
    `fund_id` BIGINT COMMENT 'Fund receiving grant proceeds',
    `award_amount` DECIMAL(18,2) COMMENT 'Total award amount',
    `award_date` DATE COMMENT 'Award date',
    `cfda_number` STRING COMMENT 'Catalog of Federal Domestic Assistance number',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `grant_number` STRING COMMENT 'Grant number',
    `grant_type` STRING COMMENT 'Federal, State, Local, Private',
    `grantor_agency` STRING COMMENT 'Grantor agency',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Indirect cost rate',
    `match_percentage` DECIMAL(18,2) COMMENT 'Required match percentage',
    `match_required_amount` DECIMAL(18,2) COMMENT 'Required match amount',
    `grant_name` STRING COMMENT 'Grant name',
    `period_end_date` DATE COMMENT 'Grant period end date',
    `period_start_date` DATE COMMENT 'Grant period start date',
    `reporting_frequency` STRING COMMENT 'Monthly, Quarterly, Annual',
    `grant_status` STRING COMMENT 'Active, Closed, Suspended',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_grant PRIMARY KEY(`grant_id`)
) COMMENT 'Grant master for federal, state, and local grant awards.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` (
    `grant_expenditure_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `grant_id` BIGINT COMMENT 'Grant',
    `journal_entry_line_id` BIGINT COMMENT 'Journal entry line',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `grant_expenditure_description` STRING COMMENT 'Expenditure description',
    `expenditure_amount` DECIMAL(18,2) COMMENT 'Expenditure amount',
    `expenditure_category` STRING COMMENT 'Personnel, Equipment, Supplies, Contractual',
    `expenditure_date` DATE COMMENT 'Expenditure date',
    `is_allocable` BOOLEAN COMMENT 'Whether expenditure is allocable',
    `is_allowable` BOOLEAN COMMENT 'Whether expenditure is allowable',
    `match_amount` DECIMAL(18,2) COMMENT 'Match amount',
    CONSTRAINT pk_grant_expenditure PRIMARY KEY(`grant_expenditure_id`)
) COMMENT 'Grant expenditure tracking for compliance and reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` (
    `debt_instrument_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project funded by debt',
    `fund_id` BIGINT COMMENT 'Fund against which debt is issued',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `instrument_name` STRING COMMENT 'Debt instrument name',
    `instrument_number` STRING COMMENT 'Debt instrument number',
    `instrument_type` STRING COMMENT 'Revenue Bond, GO Bond, SRF Loan, Bank Loan',
    `interest_rate` DECIMAL(18,2) COMMENT 'Interest rate',
    `interest_rate_type` STRING COMMENT 'Fixed, Variable',
    `issue_date` DATE COMMENT 'Issue date',
    `lender_name` STRING COMMENT 'Lender or bondholder',
    `maturity_date` DATE COMMENT 'Maturity date',
    `original_principal` DECIMAL(18,2) COMMENT 'Original principal amount',
    `outstanding_principal` DECIMAL(18,2) COMMENT 'Outstanding principal balance',
    `payment_frequency` STRING COMMENT 'Monthly, Quarterly, Semi-Annual, Annual',
    `purpose` STRING COMMENT 'Purpose of debt',
    `debt_instrument_status` STRING COMMENT 'Active, Paid Off, Refunded',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_debt_instrument PRIMARY KEY(`debt_instrument_id`)
) COMMENT 'Debt instrument master for bonds, loans, and other long-term debt.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` (
    `debt_service_payment_id` BIGINT COMMENT 'Primary key',
    `bank_account_id` BIGINT COMMENT 'Bank account',
    `debt_instrument_id` BIGINT COMMENT 'Debt instrument',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `due_date` DATE COMMENT 'Due date',
    `fiscal_year` STRING COMMENT 'Fiscal year',
    `interest_amount` DECIMAL(18,2) COMMENT 'Interest amount',
    `payment_date` DATE COMMENT 'Payment date',
    `payment_status` STRING COMMENT 'Scheduled, Paid, Late',
    `principal_amount` DECIMAL(18,2) COMMENT 'Principal amount',
    `total_payment_amount` DECIMAL(18,2) COMMENT 'Total payment amount',
    CONSTRAINT pk_debt_service_payment PRIMARY KEY(`debt_service_payment_id`)
) COMMENT 'Debt service payment for principal and interest payments.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` (
    `finance_rate_case_id` BIGINT COMMENT 'Primary key',
    `territory_id` BIGINT COMMENT 'Service territory for rate case',
    `approved_rate_increase_pct` DECIMAL(18,2) COMMENT 'Approved rate increase percentage',
    `approved_revenue_requirement` DECIMAL(18,2) COMMENT 'Approved revenue requirement',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Effective date',
    `filing_date` DATE COMMENT 'Filing date',
    `rate_case_name` STRING COMMENT 'Rate case name',
    `rate_case_number` STRING COMMENT 'Rate case docket number',
    `regulatory_agency` STRING COMMENT 'Regulatory agency',
    `requested_rate_increase_pct` DECIMAL(18,2) COMMENT 'Requested rate increase percentage',
    `requested_revenue_requirement` DECIMAL(18,2) COMMENT 'Requested revenue requirement',
    `finance_rate_case_status` STRING COMMENT 'Filed, Pending, Approved, Denied',
    `test_year` STRING COMMENT 'Test year',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_finance_rate_case PRIMARY KEY(`finance_rate_case_id`)
) COMMENT 'Rate case filing for utility rate adjustments and revenue requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` (
    `revenue_requirement_id` BIGINT COMMENT 'Primary key',
    `finance_rate_case_id` BIGINT COMMENT 'Rate case',
    `amount` DECIMAL(18,2) COMMENT 'Amount',
    `calculation_method` STRING COMMENT 'Calculation method',
    `component_name` STRING COMMENT 'Component name',
    `component_type` STRING COMMENT 'O&M, Depreciation, Taxes, Return on Rate Base',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `notes` STRING COMMENT 'Notes',
    CONSTRAINT pk_revenue_requirement PRIMARY KEY(`revenue_requirement_id`)
) COMMENT 'Revenue requirement calculation for rate case filings.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` (
    `encumbrance_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'Cost center',
    `fund_id` BIGINT COMMENT 'Fund',
    `general_ledger_id` BIGINT COMMENT 'GL account',
    `purchase_order_id` BIGINT COMMENT 'Purchase order',
    `amount` DECIMAL(18,2) COMMENT 'Encumbrance amount',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `encumbrance_date` DATE COMMENT 'Encumbrance date',
    `fiscal_year` STRING COMMENT 'Fiscal year',
    `liquidated_amount` DECIMAL(18,2) COMMENT 'Liquidated amount',
    `remaining_amount` DECIMAL(18,2) COMMENT 'Remaining amount',
    `encumbrance_status` STRING COMMENT 'Open, Partially Liquidated, Fully Liquidated, Cancelled',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_encumbrance PRIMARY KEY(`encumbrance_id`)
) COMMENT 'Encumbrance for purchase orders and commitments against budget.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Primary key',
    `fund_id` BIGINT COMMENT 'Fund',
    `general_ledger_id` BIGINT COMMENT 'GL account',
    `account_name` STRING COMMENT 'Account name',
    `account_number` STRING COMMENT 'Bank account number',
    `account_type` STRING COMMENT 'Checking, Savings, Money Market',
    `bank_name` STRING COMMENT 'Bank name',
    `closing_date` DATE COMMENT 'Closing date',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `current_balance` DECIMAL(18,2) COMMENT 'Current balance',
    `is_active` BOOLEAN COMMENT 'Whether account is active',
    `opening_date` DATE COMMENT 'Opening date',
    `routing_number` STRING COMMENT 'Routing number',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Bank account master for cash management and reconciliation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` (
    `bank_reconciliation_id` BIGINT COMMENT 'Primary key',
    `bank_account_id` BIGINT COMMENT 'Bank account',
    `employee_id` BIGINT COMMENT 'Employee who approved',
    `bank_reconciled_by_employee_id` BIGINT COMMENT 'Employee who reconciled',
    `adjustments_amount` DECIMAL(18,2) COMMENT 'Adjustments amount',
    `approval_date` DATE COMMENT 'Approval date',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `deposits_in_transit_amount` DECIMAL(18,2) COMMENT 'Deposits in transit amount',
    `gl_ending_balance` DECIMAL(18,2) COMMENT 'GL ending balance',
    `outstanding_checks_amount` DECIMAL(18,2) COMMENT 'Outstanding checks amount',
    `reconciled_balance` DECIMAL(18,2) COMMENT 'Reconciled balance',
    `reconciliation_date` DATE COMMENT 'Reconciliation date',
    `statement_date` DATE COMMENT 'Statement date',
    `statement_ending_balance` DECIMAL(18,2) COMMENT 'Statement ending balance',
    `bank_reconciliation_status` STRING COMMENT 'In Progress, Reconciled, Approved',
    `variance_amount` DECIMAL(18,2) COMMENT 'Variance amount',
    CONSTRAINT pk_bank_reconciliation PRIMARY KEY(`bank_reconciliation_id`)
) COMMENT 'Bank reconciliation for monthly bank statement reconciliation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` (
    `interfund_transfer_id` BIGINT COMMENT 'Primary key',
    `fund_id` BIGINT COMMENT 'Source fund',
    `journal_entry_id` BIGINT COMMENT 'Journal entry',
    `to_fund_id` BIGINT COMMENT 'Destination fund',
    `authorization_reference` STRING COMMENT 'Authorization reference',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `fiscal_year` STRING COMMENT 'Fiscal year',
    `purpose` STRING COMMENT 'Purpose of transfer',
    `interfund_transfer_status` STRING COMMENT 'Pending, Posted, Reversed',
    `transfer_amount` DECIMAL(18,2) COMMENT 'Transfer amount',
    `transfer_date` DATE COMMENT 'Transfer date',
    `transfer_type` STRING COMMENT 'Operating Transfer, Residual Equity Transfer',
    CONSTRAINT pk_interfund_transfer PRIMARY KEY(`interfund_transfer_id`)
) COMMENT 'Interfund transfer between funds for governmental accounting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Primary key',
    `allocation_cycle_id` BIGINT COMMENT 'Allocation cycle',
    `cost_center_id` BIGINT COMMENT 'Source cost center',
    `fund_id` BIGINT COMMENT 'Source fund',
    `to_cost_center_id` BIGINT COMMENT 'Destination cost center',
    `to_fund_id` BIGINT COMMENT 'Destination fund',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Allocation amount',
    `allocation_basis` STRING COMMENT 'FTE, Square Footage, Revenue',
    `allocation_date` DATE COMMENT 'Allocation date',
    `allocation_method` STRING COMMENT 'Direct, Step-down, Reciprocal',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Allocation percentage',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `fiscal_period` STRING COMMENT 'Fiscal period',
    `fiscal_year` STRING COMMENT 'Fiscal year',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Cost allocation for indirect cost distribution across funds and cost centers.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` (
    `project_funding_allocation_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `debt_instrument_id` BIGINT COMMENT 'Debt instrument if applicable',
    `fund_id` BIGINT COMMENT 'Fund',
    `funding_source_id` BIGINT COMMENT 'Funding source',
    `grant_id` BIGINT COMMENT 'Grant if applicable',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Allocated amount',
    `allocation_date` DATE COMMENT 'Allocation date',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `expended_amount` DECIMAL(18,2) COMMENT 'Expended amount',
    `remaining_amount` DECIMAL(18,2) COMMENT 'Remaining amount',
    `project_funding_allocation_status` STRING COMMENT 'Active, Fully Expended, Cancelled',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_project_funding_allocation PRIMARY KEY(`project_funding_allocation_id`)
) COMMENT 'Project funding allocation linking CIP projects to funding sources.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` (
    `grant_allocation_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `cost_center_id` BIGINT COMMENT 'Cost center',
    `grant_id` BIGINT COMMENT 'Grant',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Allocated amount',
    `allocation_date` DATE COMMENT 'Allocation date',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `expended_amount` DECIMAL(18,2) COMMENT 'Expended amount',
    `remaining_amount` DECIMAL(18,2) COMMENT 'Remaining amount',
    `grant_allocation_status` STRING COMMENT 'Active, Fully Expended, Cancelled',
    CONSTRAINT pk_grant_allocation PRIMARY KEY(`grant_allocation_id`)
) COMMENT 'Grant allocation to projects, departments, or programs.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` (
    `grant_funded_segment_id` BIGINT COMMENT 'Primary key',
    `grant_id` BIGINT COMMENT 'Grant',
    `segment_id` BIGINT COMMENT 'Customer segment',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `eligibility_criteria` STRING COMMENT 'Eligibility criteria',
    CONSTRAINT pk_grant_funded_segment PRIMARY KEY(`grant_funded_segment_id`)
) COMMENT 'Grant-funded customer segment for tracking grant-eligible customers.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Primary key',
    `bank_account_id` BIGINT COMMENT 'Bank account',
    `employee_id` BIGINT COMMENT 'Employee who approved run',
    `payment_created_by_employee_id` BIGINT COMMENT 'Employee who created run',
    `approval_date` DATE COMMENT 'Approval date',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `payment_count` STRING COMMENT 'Number of payments',
    `payment_date` DATE COMMENT 'Payment date',
    `payment_method` STRING COMMENT 'Check, ACH, Wire',
    `run_date` DATE COMMENT 'Run date',
    `payment_run_status` STRING COMMENT 'Pending, Processed, Posted',
    `total_payment_amount` DECIMAL(18,2) COMMENT 'Total payment amount',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Payment run for batch processing of vendor payments.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` (
    `allocation_cycle_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Employee who created cycle',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cycle_date` DATE COMMENT 'Cycle date',
    `cycle_name` STRING COMMENT 'Cycle name',
    `fiscal_period` STRING COMMENT 'Fiscal period',
    `fiscal_year` STRING COMMENT 'Fiscal year',
    `allocation_cycle_status` STRING COMMENT 'Pending, Processed, Posted',
    `total_allocated_amount` DECIMAL(18,2) COMMENT 'Total allocated amount',
    CONSTRAINT pk_allocation_cycle PRIMARY KEY(`allocation_cycle_id`)
) COMMENT 'Allocation cycle for periodic cost allocation runs.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` (
    `drawdown_request_id` BIGINT COMMENT 'Primary key',
    `grant_id` BIGINT COMMENT 'Grant',
    `employee_id` BIGINT COMMENT 'Employee who submitted request',
    `approved_amount` DECIMAL(18,2) COMMENT 'Approved amount',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `period_end_date` DATE COMMENT 'Period end date',
    `period_start_date` DATE COMMENT 'Period start date',
    `received_amount` DECIMAL(18,2) COMMENT 'Received amount',
    `received_date` DATE COMMENT 'Received date',
    `request_amount` DECIMAL(18,2) COMMENT 'Request amount',
    `request_date` DATE COMMENT 'Request date',
    `drawdown_request_status` STRING COMMENT 'Pending, Approved, Received, Denied',
    CONSTRAINT pk_drawdown_request PRIMARY KEY(`drawdown_request_id`)
) COMMENT 'Drawdown request for federal and state grant reimbursements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` (
    `recurring_entry_template_id` BIGINT COMMENT 'Primary key',
    `general_ledger_id` BIGINT COMMENT '',
    `auto_post_flag` BOOLEAN COMMENT 'Whether to auto-post entries',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `frequency` STRING COMMENT 'Monthly, Quarterly, Annual',
    `is_active` BOOLEAN COMMENT 'Whether template is active',
    `last_run_date` DATE COMMENT 'Last run date',
    `next_run_date` DATE COMMENT 'Next run date',
    `template_description` STRING COMMENT 'Template description',
    `template_name` STRING COMMENT 'Template name',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_recurring_entry_template PRIMARY KEY(`recurring_entry_template_id`)
) COMMENT 'Recurring journal entry template for automated monthly entries.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_reversed_journal_entry_id` FOREIGN KEY (`reversed_journal_entry_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ADD CONSTRAINT `fk_finance_grant_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_journal_entry_line_id` FOREIGN KEY (`journal_entry_line_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ADD CONSTRAINT `fk_finance_revenue_requirement_finance_rate_case_id` FOREIGN KEY (`finance_rate_case_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_rate_case`(`finance_rate_case_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ADD CONSTRAINT `fk_finance_encumbrance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ADD CONSTRAINT `fk_finance_encumbrance_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ADD CONSTRAINT `fk_finance_encumbrance_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_to_fund_id` FOREIGN KEY (`to_fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_allocation_cycle_id` FOREIGN KEY (`allocation_cycle_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_to_cost_center_id` FOREIGN KEY (`to_cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_to_fund_id` FOREIGN KEY (`to_fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ADD CONSTRAINT `fk_finance_project_funding_allocation_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ADD CONSTRAINT `fk_finance_project_funding_allocation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ADD CONSTRAINT `fk_finance_project_funding_allocation_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ADD CONSTRAINT `fk_finance_grant_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ADD CONSTRAINT `fk_finance_grant_allocation_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ADD CONSTRAINT `fk_finance_grant_funded_segment_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ADD CONSTRAINT `fk_finance_drawdown_request_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_water_utilities_v1`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_accounting' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` SET TAGS ('dbx_gl' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'GL Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `account_category` SET TAGS ('dbx_business_glossary_term' = 'Account Category');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `balance_sheet_section` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Section');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `budget_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Controlled');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `encumbrance_flag` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `financial_statement_line` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Line');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `gasb_classification` SET TAGS ('dbx_business_glossary_term' = 'GASB Classification');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `normal_balance` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`general_ledger` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` SET TAGS ('dbx_fund_accounting' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` SET TAGS ('dbx_gasb' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `budget_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Controlled');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `fund_category` SET TAGS ('dbx_business_glossary_term' = 'Fund Category');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `encumbrance_flag` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `gasb_54_classification` SET TAGS ('dbx_business_glossary_term' = 'GASB 54 Classification');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `legal_authority` SET TAGS ('dbx_business_glossary_term' = 'Legal Authority');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `restricted_purpose` SET TAGS ('dbx_business_glossary_term' = 'Restricted Purpose');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fund` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` SET TAGS ('dbx_cost_accounting' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `budget_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Controlled');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` SET TAGS ('dbx_accounting' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` SET TAGS ('dbx_gl' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `reversed_journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Entry');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_category` SET TAGS ('dbx_business_glossary_term' = 'Journal Category');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_source` SET TAGS ('dbx_business_glossary_term' = 'Journal Source');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_accounting' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_gl' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'GL Account');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_1` SET TAGS ('dbx_business_glossary_term' = 'Reference 1');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ALTER COLUMN `reference_2` SET TAGS ('dbx_business_glossary_term' = 'Reference 2');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_accounts_payable' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_vendor' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'AP Invoice ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` SET TAGS ('dbx_accounts_payable' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` SET TAGS ('dbx_payment' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'AP Payment ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Cleared Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Void Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` SET TAGS ('dbx_accounts_receivable' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` SET TAGS ('dbx_revenue' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'AR Transaction ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `balance_impact` SET TAGS ('dbx_business_glossary_term' = 'Balance Impact');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `ar_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `ar_transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_budget' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` SET TAGS ('dbx_planning' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `adoption_date` SET TAGS ('dbx_business_glossary_term' = 'Adoption Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` SET TAGS ('dbx_budget' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` SET TAGS ('dbx_planning' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'GL Account');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `available_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `encumbered_amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbered Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `period_10_amount` SET TAGS ('dbx_business_glossary_term' = 'Period 10 Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `period_11_amount` SET TAGS ('dbx_business_glossary_term' = 'Period 11 Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `period_12_amount` SET TAGS ('dbx_business_glossary_term' = 'Period 12 Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `period_1_amount` SET TAGS ('dbx_business_glossary_term' = 'Period 1 Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `period_2_amount` SET TAGS ('dbx_business_glossary_term' = 'Period 2 Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `period_3_amount` SET TAGS ('dbx_business_glossary_term' = 'Period 3 Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `period_4_amount` SET TAGS ('dbx_business_glossary_term' = 'Period 4 Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `period_5_amount` SET TAGS ('dbx_business_glossary_term' = 'Period 5 Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `period_6_amount` SET TAGS ('dbx_business_glossary_term' = 'Period 6 Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `period_7_amount` SET TAGS ('dbx_business_glossary_term' = 'Period 7 Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `period_8_amount` SET TAGS ('dbx_business_glossary_term' = 'Period 8 Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `period_9_amount` SET TAGS ('dbx_business_glossary_term' = 'Period 9 Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `revised_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'capital_management');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_fixed_assets' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_depreciation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'GL Account');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In Service Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` SET TAGS ('dbx_grants' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` SET TAGS ('dbx_funding' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `award_amount` SET TAGS ('dbx_business_glossary_term' = 'Award Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `cfda_number` SET TAGS ('dbx_business_glossary_term' = 'CFDA Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grant_type` SET TAGS ('dbx_business_glossary_term' = 'Grant Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grantor_agency` SET TAGS ('dbx_business_glossary_term' = 'Grantor Agency');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `match_percentage` SET TAGS ('dbx_business_glossary_term' = 'Match Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `match_required_amount` SET TAGS ('dbx_business_glossary_term' = 'Match Required Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grant_name` SET TAGS ('dbx_business_glossary_term' = 'Grant Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` SET TAGS ('dbx_grants' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` SET TAGS ('dbx_expenditure' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `grant_expenditure_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Expenditure ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `grant_expenditure_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `expenditure_category` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Category');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `expenditure_date` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `is_allocable` SET TAGS ('dbx_business_glossary_term' = 'Allocable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `is_allowable` SET TAGS ('dbx_business_glossary_term' = 'Allowable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ALTER COLUMN `match_amount` SET TAGS ('dbx_business_glossary_term' = 'Match Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` SET TAGS ('dbx_subdomain' = 'capital_management');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` SET TAGS ('dbx_debt' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` SET TAGS ('dbx_bonds' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `debt_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `instrument_name` SET TAGS ('dbx_business_glossary_term' = 'Instrument Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `instrument_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `lender_name` SET TAGS ('dbx_business_glossary_term' = 'Lender Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `original_principal` SET TAGS ('dbx_business_glossary_term' = 'Original Principal');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `outstanding_principal` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Principal');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Purpose');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `debt_instrument_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` SET TAGS ('dbx_subdomain' = 'capital_management');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` SET TAGS ('dbx_debt' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` SET TAGS ('dbx_payment' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `debt_service_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Payment ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `debt_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Principal Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ALTER COLUMN `total_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_subdomain' = 'capital_management');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_rates' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `finance_rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `approved_rate_increase_pct` SET TAGS ('dbx_business_glossary_term' = 'Approved Rate Increase %');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `approved_revenue_requirement` SET TAGS ('dbx_business_glossary_term' = 'Approved Revenue Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `rate_case_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `rate_case_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `requested_rate_increase_pct` SET TAGS ('dbx_business_glossary_term' = 'Requested Rate Increase %');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `requested_revenue_requirement` SET TAGS ('dbx_business_glossary_term' = 'Requested Revenue Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `finance_rate_case_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `test_year` SET TAGS ('dbx_business_glossary_term' = 'Test Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` SET TAGS ('dbx_subdomain' = 'capital_management');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` SET TAGS ('dbx_rates' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` SET TAGS ('dbx_revenue' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `revenue_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Requirement ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `finance_rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `component_name` SET TAGS ('dbx_business_glossary_term' = 'Component Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` SET TAGS ('dbx_encumbrance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` SET TAGS ('dbx_budget' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `encumbrance_id` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'GL Account');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `encumbrance_date` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `liquidated_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `encumbrance_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` SET TAGS ('dbx_treasury' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` SET TAGS ('dbx_cash' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'GL Account');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` SET TAGS ('dbx_treasury' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` SET TAGS ('dbx_reconciliation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Reconciliation ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciled_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciled_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciled_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustments Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `deposits_in_transit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposits in Transit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `gl_ending_balance` SET TAGS ('dbx_business_glossary_term' = 'GL Ending Balance');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `outstanding_checks_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Checks Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciled_balance` SET TAGS ('dbx_business_glossary_term' = 'Reconciled Balance');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `statement_ending_balance` SET TAGS ('dbx_business_glossary_term' = 'Statement Ending Balance');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` SET TAGS ('dbx_interfund' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` SET TAGS ('dbx_transfer' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `interfund_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Interfund Transfer ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'From Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `to_fund_id` SET TAGS ('dbx_business_glossary_term' = 'To Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorization Reference');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Purpose');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `interfund_transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` SET TAGS ('dbx_cost_allocation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'From Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'From Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `to_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'To Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `to_fund_id` SET TAGS ('dbx_business_glossary_term' = 'To Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` SET TAGS ('dbx_association_edges' = 'finance.grant,project.cip_project');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` SET TAGS ('dbx_project' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` SET TAGS ('dbx_funding' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `project_funding_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Project Funding Allocation ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `debt_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `expended_amount` SET TAGS ('dbx_business_glossary_term' = 'Expended Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `project_funding_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` SET TAGS ('dbx_association_edges' = 'wastewater.lift_station,finance.grant');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` SET TAGS ('dbx_grants' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` SET TAGS ('dbx_allocation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `grant_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Allocation ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `expended_amount` SET TAGS ('dbx_business_glossary_term' = 'Expended Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ALTER COLUMN `grant_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` SET TAGS ('dbx_association_edges' = 'wastewater.sewer_network,finance.grant');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` SET TAGS ('dbx_grants' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` SET TAGS ('dbx_segment' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `grant_funded_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Funded Segment ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` SET TAGS ('dbx_accounts_payable' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` SET TAGS ('dbx_payment' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `payment_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `payment_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `payment_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `payment_count` SET TAGS ('dbx_business_glossary_term' = 'Payment Count');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Run Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `payment_run_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ALTER COLUMN `total_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_cost_allocation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` SET TAGS ('dbx_cycle' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `cycle_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Cycle Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`allocation_cycle` ALTER COLUMN `total_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Allocated Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` SET TAGS ('dbx_grants' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` SET TAGS ('dbx_drawdown' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `drawdown_request_id` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Request ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `received_amount` SET TAGS ('dbx_business_glossary_term' = 'Received Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `request_amount` SET TAGS ('dbx_business_glossary_term' = 'Request Amount');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ALTER COLUMN `drawdown_request_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_accounting' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` SET TAGS ('dbx_recurring' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `recurring_entry_template_id` SET TAGS ('dbx_business_glossary_term' = 'Recurring Entry Template ID');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_relationship' = 'fix_siloed');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `auto_post_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Post Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `last_run_date` SET TAGS ('dbx_business_glossary_term' = 'Last Run Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `next_run_date` SET TAGS ('dbx_business_glossary_term' = 'Next Run Date');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`recurring_entry_template` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
