-- Schema for Domain: finance | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 23:51:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`finance` COMMENT 'Owns enterprise financial management — general ledger (GL), accounts payable (AP), accounts receivable (AR), fixed assets (FA), cost center structures, GAAP and SAP statutory reporting, MLR calculations, and regulatory financial filings with state DOIs and NAIC. Manages capitation payments, provider incentive settlements, VBC shared savings distributions, and risk-based capital (RBC) reporting. Source system: Oracle Financials.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`ledger` (
    `ledger_id` BIGINT COMMENT 'Primary key for ledger',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `account_name` STRING COMMENT 'Name of the GL account',
    `account_number` STRING COMMENT 'GL account number',
    `account_type` STRING COMMENT 'Type of account (asset, liability, equity, revenue, expense)',
    `balance_type` DECIMAL(18,2) COMMENT 'Debit or credit normal balance',
    `budget_owner` STRING COMMENT 'Owner responsible for budget on this ledger',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'ISO currency code',
    `department_code` STRING COMMENT 'Department segment code',
    `ledger_description` STRING COMMENT 'Description of the ledger account',
    `division_code` STRING COMMENT 'Division segment code',
    `effective_from` DATE COMMENT 'Effective start date',
    `effective_to` DATE COMMENT 'Effective end date',
    `financial_reporting_category` STRING COMMENT 'Reporting category for financial statements',
    `fund_code` STRING COMMENT 'Fund code segment',
    `gaap_ledger_flag` BOOLEAN COMMENT 'Whether this is a GAAP reporting ledger',
    `is_budgeted` BOOLEAN COMMENT 'Whether account is budgeted',
    `is_consolidated` BOOLEAN COMMENT 'Whether account participates in consolidation',
    `ledger_status` STRING COMMENT 'Active/inactive status',
    `legal_entity_code` STRING COMMENT 'Legal entity segment code',
    `line_of_business` STRING COMMENT 'Line of business segment',
    `posting_allowed` BOOLEAN COMMENT 'Whether posting is allowed to this account',
    `segment1` STRING COMMENT 'Flexible segment 1',
    `segment2` STRING COMMENT 'Flexible segment 2',
    `segment3` STRING COMMENT 'Flexible segment 3',
    `segment4` STRING COMMENT 'Flexible segment 4',
    `segment5` STRING COMMENT 'Flexible segment 5',
    `statutory_ledger_flag` BOOLEAN COMMENT 'Whether this is a statutory reporting ledger',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_ledger PRIMARY KEY(`ledger_id`)
) COMMENT 'General ledger master record tracking chart of accounts, segments, and posting rules for financial reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Primary key for cost center',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `employee_id` BIGINT COMMENT 'FK to owning employee',
    `parent_cost_center_id` BIGINT COMMENT 'FK to parent cost center for hierarchy',
    `allocation_method` STRING COMMENT 'Method used for cost allocation',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The allocation percentage attribute capturing relevant data for the cost center in the finance domain.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Budgeted amount for this cost center',
    `budget_currency` STRING COMMENT 'Currency of budget',
    `cost_center_category` DECIMAL(18,2) COMMENT 'Category of cost center',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Unique code for cost center',
    `cost_center_status` DECIMAL(18,2) COMMENT 'Active/inactive status',
    `cost_center_type` DECIMAL(18,2) COMMENT 'Type classification',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_classification` STRING COMMENT 'Data classification level',
    `department_code` STRING COMMENT 'A standardized code representing the department classification.',
    `cost_center_description` DECIMAL(18,2) COMMENT 'Description of cost center',
    `division_code` STRING COMMENT 'A standardized code representing the division classification.',
    `effective_from` DATE COMMENT 'Effective start date',
    `effective_to` DATE COMMENT 'Effective end date',
    `end_date` DATE COMMENT 'End date of cost center',
    `external_reference` STRING COMMENT 'External system reference',
    `gl_account` STRING COMMENT 'GL account mapping',
    `group_name` STRING COMMENT 'Group name for reporting',
    `hierarchy_level` STRING COMMENT 'Level in cost center hierarchy',
    `is_budgeted` BOOLEAN COMMENT 'Whether cost center is budgeted',
    `is_consolidated` BOOLEAN COMMENT 'Whether included in consolidation',
    `last_review_date` DATE COMMENT 'The date value representing last review date for this cost center record.',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the cost center in the finance domain.',
    `mlr_flag` BOOLEAN COMMENT 'Whether included in MLR calculation',
    `cost_center_name` DECIMAL(18,2) COMMENT 'Name of cost center',
    `pmpm_flag` BOOLEAN COMMENT 'Whether tracked on PMPM basis',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Whether included in regulatory reporting',
    `reporting_code` STRING COMMENT 'A standardized code representing the reporting classification.',
    `review_frequency` STRING COMMENT 'Frequency of review',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'The risk adjustment factor attribute capturing relevant data for the cost center in the finance domain.',
    `start_date` DATE COMMENT 'Start date of cost center',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Organizational cost center for expense allocation and budgeting within the health plan.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to approving employee',
    `case_id` BIGINT COMMENT 'FK to appeal case if related',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `group_id` BIGINT COMMENT 'FK to employer group',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `org_unit_id` BIGINT COMMENT 'FK to org unit',
    `outcome_id` BIGINT COMMENT 'FK to appeal outcome',
    `reversal_of_journal_entry_id` BIGINT COMMENT 'FK to reversed journal entry',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `accounting_period` STRING COMMENT 'The accounting period attribute capturing relevant data for the journal entry in the finance domain.',
    `approval_status` STRING COMMENT 'The current status indicator for the approval within the workflow.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Budget amount reference',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'ISO currency code',
    `journal_entry_description` STRING COMMENT 'Description of journal entry',
    `entry_status` STRING COMMENT 'The current status indicator for the entry within the workflow.',
    `entry_timestamp` TIMESTAMP COMMENT 'The entry timestamp attribute capturing relevant data for the journal entry in the finance domain.',
    `entry_type` STRING COMMENT 'Type of journal entry',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate for multi-currency',
    `fiscal_month` STRING COMMENT 'The fiscal month attribute capturing relevant data for the journal entry in the finance domain.',
    `fiscal_year` STRING COMMENT 'The calendar or fiscal year associated with the fiscal.',
    `fund_code` STRING COMMENT 'A standardized code representing the fund classification.',
    `is_budgeted` BOOLEAN COMMENT 'Whether budgeted',
    `is_consolidation_elimination` BOOLEAN COMMENT 'Whether consolidation elimination entry',
    `is_intercompany` BOOLEAN COMMENT 'Whether intercompany entry',
    `is_statistical` BOOLEAN COMMENT 'Whether statistical entry',
    `journal_number` STRING COMMENT 'The journal number attribute capturing relevant data for the journal entry in the finance domain.',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the journal entry in the finance domain.',
    `net_amount` DECIMAL(18,2) COMMENT 'The numeric net amount value associated with this journal entry record.',
    `posting_status` STRING COMMENT 'The current status indicator for the posting within the workflow.',
    `reference_document_number` STRING COMMENT 'The reference document number attribute capturing relevant data for the journal entry in the finance domain.',
    `source_module` STRING COMMENT 'The source module attribute capturing relevant data for the journal entry in the finance domain.',
    `statistical_amount` DECIMAL(18,2) COMMENT 'The numeric statistical amount value associated with this journal entry record.',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'Total credits',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'Total debits',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Financial journal entry header recording debits and credits posted to the general ledger.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Primary key',
    `journal_entry_id` BIGINT COMMENT 'FK to journal entry header',
    `ledger_id` BIGINT COMMENT 'FK to ledger account',
    `accounted_amount` DECIMAL(18,2) COMMENT 'Accounted amount in functional currency',
    `additional_segment` STRING COMMENT 'Additional segment value',
    `cost_center_code` DECIMAL(18,2) COMMENT 'A standardized code representing the cost center classification.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Transaction currency code',
    `debit_credit_indicator` BOOLEAN COMMENT 'True=debit, False=credit',
    `journal_entry_line_description` STRING COMMENT 'Line description',
    `effective_date` DATE COMMENT 'Effective date of line',
    `entered_amount` DECIMAL(18,2) COMMENT 'Entered amount in transaction currency',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied',
    `fund_code` STRING COMMENT 'A standardized code representing the fund classification.',
    `is_budgeted` BOOLEAN COMMENT 'Whether budgeted',
    `is_statistical` BOOLEAN COMMENT 'Whether statistical',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the journal entry line in the finance domain.',
    `line_sequence` STRING COMMENT 'Sequence number within entry',
    `line_status` STRING COMMENT 'The current status indicator for the line within the workflow.',
    `line_type` STRING COMMENT 'The category or classification type of the line.',
    `natural_account` STRING COMMENT 'Natural account code',
    `posting_date` DATE COMMENT 'The date value representing posting date for this journal entry line record.',
    `reconciliation_reference` STRING COMMENT 'The reconciliation reference attribute capturing relevant data for the journal entry line in the finance domain.',
    `source_module` STRING COMMENT 'The source module attribute capturing relevant data for the journal entry line in the finance domain.',
    `statistical_amount` DECIMAL(18,2) COMMENT 'The numeric statistical amount value associated with this journal entry line record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit or credit line within a journal entry, mapped to a specific GL account.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Primary key',
    `bank_account_id` BIGINT COMMENT 'FK to bank account',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `employee_id` BIGINT COMMENT 'FK to creating employee',
    `vendor_contract_id` BIGINT COMMENT 'FK to vendor contract',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `ap_invoice_status` STRING COMMENT 'Invoice status',
    `approval_status` STRING COMMENT 'The current status indicator for the approval within the workflow.',
    `approved_by` STRING COMMENT 'Approver name',
    `approved_timestamp` TIMESTAMP COMMENT 'Approval timestamp',
    `check_number` STRING COMMENT 'Check number if paid by check',
    `cleared_date` DATE COMMENT 'Date payment cleared',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `ap_invoice_description` STRING COMMENT 'Invoice description',
    `discount_amount` DECIMAL(18,2) COMMENT 'The numeric discount amount value associated with this ap invoice record.',
    `division_code` STRING COMMENT 'A standardized code representing the division classification.',
    `due_date` DATE COMMENT 'Payment due date',
    `eft_reference` STRING COMMENT 'EFT reference number',
    `external_reference_number` STRING COMMENT 'External reference',
    `gl_posting_flag` BOOLEAN COMMENT 'Whether posted to GL',
    `gross_amount` DECIMAL(18,2) COMMENT 'Gross invoice amount',
    `hold_reason` STRING COMMENT 'Reason for hold',
    `invoice_date` DATE COMMENT 'The date value representing invoice date for this ap invoice record.',
    `invoice_number` STRING COMMENT 'The invoice number attribute capturing relevant data for the ap invoice in the finance domain.',
    `invoice_type` STRING COMMENT 'The category or classification type of the invoice.',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the ap invoice in the finance domain.',
    `n1099_flag` BOOLEAN COMMENT 'Whether 1099 reportable',
    `net_amount` DECIMAL(18,2) COMMENT 'Net invoice amount',
    `payment_date` DATE COMMENT 'The date value representing payment date for this ap invoice record.',
    `payment_method` DECIMAL(18,2) COMMENT 'The payment method attribute capturing relevant data for the ap invoice in the finance domain.',
    `payment_status` DECIMAL(18,2) COMMENT 'The current status indicator for the payment within the workflow.',
    `payment_terms` DECIMAL(18,2) COMMENT 'The payment terms attribute capturing relevant data for the ap invoice in the finance domain.',
    `reconciliation_status` STRING COMMENT 'The current status indicator for the reconciliation within the workflow.',
    `service_period_end` DATE COMMENT 'The service period end attribute capturing relevant data for the ap invoice in the finance domain.',
    `service_period_start` DATE COMMENT 'The service period start attribute capturing relevant data for the ap invoice in the finance domain.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The numeric tax amount value associated with this ap invoice record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `void_flag` BOOLEAN COMMENT 'Whether invoice is voided',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts payable invoice received from vendors, providers, or other payees.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'Primary key',
    `ap_invoice_id` BIGINT COMMENT 'FK to AP invoice',
    `bank_account_id` BIGINT COMMENT 'FK to bank account',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `employee_id` BIGINT COMMENT 'FK to processing employee',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `ap_payment_status` DECIMAL(18,2) COMMENT 'Payment status',
    `check_number` STRING COMMENT 'The check number attribute capturing relevant data for the ap payment in the finance domain.',
    `cleared_date` DATE COMMENT 'Date cleared',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `ap_payment_description` DECIMAL(18,2) COMMENT 'Payment description',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount taken',
    `division_code` STRING COMMENT 'A standardized code representing the division classification.',
    `due_date` DATE COMMENT 'The date value representing due date for this ap payment record.',
    `eft_reference` STRING COMMENT 'The eft reference attribute capturing relevant data for the ap payment in the finance domain.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The numeric exchange rate value associated with this ap payment record.',
    `external_reference_number` STRING COMMENT 'External reference',
    `gross_amount` DECIMAL(18,2) COMMENT 'Gross payment amount',
    `hold_reason` STRING COMMENT 'The hold reason attribute capturing relevant data for the ap payment in the finance domain.',
    `is_foreign_currency` BOOLEAN COMMENT 'Whether foreign currency',
    `is_reconciled` BOOLEAN COMMENT 'Whether reconciled',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the ap payment in the finance domain.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net payment amount',
    `payment_batch_number` DECIMAL(18,2) COMMENT 'The payment batch number attribute capturing relevant data for the ap payment in the finance domain.',
    `payment_channel` DECIMAL(18,2) COMMENT 'The payment channel attribute capturing relevant data for the ap payment in the finance domain.',
    `payment_date` DATE COMMENT 'The date value representing payment date for this ap payment record.',
    `payment_method` DECIMAL(18,2) COMMENT 'The payment method attribute capturing relevant data for the ap payment in the finance domain.',
    `payment_number` DECIMAL(18,2) COMMENT 'The payment number attribute capturing relevant data for the ap payment in the finance domain.',
    `payment_terms` DECIMAL(18,2) COMMENT 'The payment terms attribute capturing relevant data for the ap payment in the finance domain.',
    `payment_type` DECIMAL(18,2) COMMENT 'The category or classification type of the payment.',
    `reconciliation_date` DATE COMMENT 'The date value representing reconciliation date for this ap payment record.',
    `source_module` STRING COMMENT 'The source module attribute capturing relevant data for the ap payment in the finance domain.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The numeric tax amount value associated with this ap payment record.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Whether tax exempt',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Tax rate percentage',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `void_flag` BOOLEAN COMMENT 'Whether voided',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Accounts payable payment disbursement record linked to one or more AP invoices.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `group_id` BIGINT COMMENT 'FK to employer group',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `party_id` BIGINT COMMENT 'FK to contract party',
    `reversal_invoice_ar_invoice_id` BIGINT COMMENT 'FK to reversed invoice',
    `employee_id` BIGINT COMMENT 'FK to sales rep',
    `ar_invoice_status` STRING COMMENT 'Invoice status',
    `billing_cycle` STRING COMMENT 'The billing cycle attribute capturing relevant data for the ar invoice in the finance domain.',
    `collection_status` STRING COMMENT 'The current status indicator for the collection within the workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `ar_invoice_description` STRING COMMENT 'Invoice description',
    `discount_amount` DECIMAL(18,2) COMMENT 'The numeric discount amount value associated with this ar invoice record.',
    `division_code` STRING COMMENT 'A standardized code representing the division classification.',
    `due_date` DATE COMMENT 'The date value representing due date for this ar invoice record.',
    `external_reference_number` STRING COMMENT 'External reference',
    `grace_period_end` DATE COMMENT 'Grace period end date',
    `gross_amount` DECIMAL(18,2) COMMENT 'The numeric gross amount value associated with this ar invoice record.',
    `invoice_date` DATE COMMENT 'The date value representing invoice date for this ar invoice record.',
    `invoice_number` STRING COMMENT 'The invoice number attribute capturing relevant data for the ar invoice in the finance domain.',
    `is_void` BOOLEAN COMMENT 'Whether voided',
    `is_written_off` BOOLEAN COMMENT 'Whether written off',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the ar invoice in the finance domain.',
    `net_amount` DECIMAL(18,2) COMMENT 'The numeric net amount value associated with this ar invoice record.',
    `party_type` STRING COMMENT 'The category or classification type of the party.',
    `payment_method` DECIMAL(18,2) COMMENT 'The payment method attribute capturing relevant data for the ar invoice in the finance domain.',
    `payment_status` DECIMAL(18,2) COMMENT 'The current status indicator for the payment within the workflow.',
    `payment_terms` DECIMAL(18,2) COMMENT 'The payment terms attribute capturing relevant data for the ar invoice in the finance domain.',
    `premium_period_end` DATE COMMENT 'The premium period end attribute capturing relevant data for the ar invoice in the finance domain.',
    `premium_period_start` DATE COMMENT 'The premium period start attribute capturing relevant data for the ar invoice in the finance domain.',
    `receipt_date` DATE COMMENT 'The date value representing receipt date for this ar invoice record.',
    `receipt_method` STRING COMMENT 'The receipt method attribute capturing relevant data for the ar invoice in the finance domain.',
    `source_module` STRING COMMENT 'The source module attribute capturing relevant data for the ar invoice in the finance domain.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The numeric tax amount value associated with this ar invoice record.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'The tax rate percent attribute capturing relevant data for the ar invoice in the finance domain.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The numeric unapplied amount value associated with this ar invoice record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `writeoff_date` DATE COMMENT 'Write-off date',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Accounts receivable invoice issued to employer groups, members, or other parties for premium or fees.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` (
    `ar_receipt_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to processing employee',
    `party_id` BIGINT COMMENT 'FK to contract party',
    `reversal_receipt_ar_receipt_id` BIGINT COMMENT 'FK to reversed receipt',
    `ach_trace_number` STRING COMMENT 'The ach trace number attribute capturing relevant data for the ar receipt in the finance domain.',
    `applied_invoice_ids` STRING COMMENT 'The applied invoice ids attribute capturing relevant data for the ar receipt in the finance domain.',
    `ar_receipt_status` STRING COMMENT 'Receipt status',
    `bank_deposit_batch` STRING COMMENT 'The bank deposit batch attribute capturing relevant data for the ar receipt in the finance domain.',
    `batch_number` STRING COMMENT 'The batch number attribute capturing relevant data for the ar receipt in the finance domain.',
    `check_number` STRING COMMENT 'The check number attribute capturing relevant data for the ar receipt in the finance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `deposit_date` DATE COMMENT 'The date value representing deposit date for this ar receipt record.',
    `ar_receipt_description` STRING COMMENT 'Receipt description',
    `discount_amount` DECIMAL(18,2) COMMENT 'The numeric discount amount value associated with this ar receipt record.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The numeric exchange rate value associated with this ar receipt record.',
    `grace_period_end_date` DATE COMMENT 'The date value representing grace period end date for this ar receipt record.',
    `is_foreign_currency` BOOLEAN COMMENT 'Whether foreign currency',
    `is_locked` BOOLEAN COMMENT 'Whether locked',
    `is_reversed` BOOLEAN COMMENT 'Whether reversed',
    `lockbox_number` STRING COMMENT 'The lockbox number attribute capturing relevant data for the ar receipt in the finance domain.',
    `net_amount` DECIMAL(18,2) COMMENT 'The numeric net amount value associated with this ar receipt record.',
    `party_type` STRING COMMENT 'The category or classification type of the party.',
    `payment_channel` DECIMAL(18,2) COMMENT 'The payment channel attribute capturing relevant data for the ar receipt in the finance domain.',
    `payment_reference_number` DECIMAL(18,2) COMMENT 'The payment reference number attribute capturing relevant data for the ar receipt in the finance domain.',
    `payment_status` DECIMAL(18,2) COMMENT 'The current status indicator for the payment within the workflow.',
    `receipt_amount` DECIMAL(18,2) COMMENT 'The numeric receipt amount value associated with this ar receipt record.',
    `receipt_date` DATE COMMENT 'The date value representing receipt date for this ar receipt record.',
    `receipt_method` STRING COMMENT 'The receipt method attribute capturing relevant data for the ar receipt in the finance domain.',
    `receipt_number` STRING COMMENT 'The receipt number attribute capturing relevant data for the ar receipt in the finance domain.',
    `source_module` STRING COMMENT 'The source module attribute capturing relevant data for the ar receipt in the finance domain.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The numeric tax amount value associated with this ar receipt record.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'The tax rate percent attribute capturing relevant data for the ar receipt in the finance domain.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The numeric unapplied amount value associated with this ar receipt record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `wire_reference` STRING COMMENT 'The wire reference attribute capturing relevant data for the ar receipt in the finance domain.',
    CONSTRAINT pk_ar_receipt PRIMARY KEY(`ar_receipt_id`)
) COMMENT 'Accounts receivable receipt recording incoming payments from groups, members, or other parties.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `employee_id` BIGINT COMMENT 'FK to assigned employee',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'The accumulated depreciation attribute capturing relevant data for the fixed asset in the finance domain.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'The acquisition cost attribute capturing relevant data for the fixed asset in the finance domain.',
    `acquisition_date` DATE COMMENT 'The date value representing acquisition date for this fixed asset record.',
    `asset_category` STRING COMMENT 'The asset category attribute capturing relevant data for the fixed asset in the finance domain.',
    `asset_condition` STRING COMMENT 'The asset condition attribute capturing relevant data for the fixed asset in the finance domain.',
    `asset_description` STRING COMMENT 'A detailed textual description of the asset.',
    `asset_name` STRING COMMENT 'The descriptive name assigned to the asset for identification purposes.',
    `asset_serial_number` STRING COMMENT 'Serial number',
    `asset_status` STRING COMMENT 'The current status indicator for the asset within the workflow.',
    `asset_tag` STRING COMMENT 'The asset tag attribute capturing relevant data for the fixed asset in the finance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `depreciation_end_date` DATE COMMENT 'The date value representing depreciation end date for this fixed asset record.',
    `depreciation_method` STRING COMMENT 'The depreciation method attribute capturing relevant data for the fixed asset in the finance domain.',
    `depreciation_start_date` DATE COMMENT 'The date value representing depreciation start date for this fixed asset record.',
    `disposal_date` DATE COMMENT 'The date value representing disposal date for this fixed asset record.',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'The disposal proceeds attribute capturing relevant data for the fixed asset in the finance domain.',
    `gl_account_code` STRING COMMENT 'A standardized code representing the gl account classification.',
    `location_code` STRING COMMENT 'A standardized code representing the location classification.',
    `net_book_value` DECIMAL(18,2) COMMENT 'The net book value attribute capturing relevant data for the fixed asset in the finance domain.',
    `salvage_value` DECIMAL(18,2) COMMENT 'The salvage value attribute capturing relevant data for the fixed asset in the finance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `useful_life_years` STRING COMMENT 'Useful life in years',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset register tracking capitalized assets, depreciation, and disposal.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` (
    `depreciation_transaction_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `fixed_asset_id` BIGINT COMMENT 'FK to fixed asset',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Accumulated depreciation after this transaction',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `depreciation_amount` DECIMAL(18,2) COMMENT 'The numeric depreciation amount value associated with this depreciation transaction record.',
    `depreciation_date` DATE COMMENT 'The date value representing depreciation date for this depreciation transaction record.',
    `depreciation_method` STRING COMMENT 'The depreciation method attribute capturing relevant data for the depreciation transaction in the finance domain.',
    `depreciation_period` STRING COMMENT 'The depreciation period attribute capturing relevant data for the depreciation transaction in the finance domain.',
    `depreciation_rate` DECIMAL(18,2) COMMENT 'The numeric depreciation rate value associated with this depreciation transaction record.',
    `depreciation_transaction_status` STRING COMMENT 'Transaction status',
    `gl_account_credit` STRING COMMENT 'GL credit account',
    `gl_account_debit` STRING COMMENT 'GL debit account',
    `is_estimated` BOOLEAN COMMENT 'Whether estimated',
    `net_book_value` DECIMAL(18,2) COMMENT 'Net book value after transaction',
    `posted_flag` BOOLEAN COMMENT 'Whether posted',
    `posted_timestamp` TIMESTAMP COMMENT 'The posted timestamp attribute capturing relevant data for the depreciation transaction in the finance domain.',
    `reversal_flag` BOOLEAN COMMENT 'Whether reversal',
    `transaction_number` STRING COMMENT 'The transaction number attribute capturing relevant data for the depreciation transaction in the finance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_depreciation_transaction PRIMARY KEY(`depreciation_transaction_id`)
) COMMENT 'Individual depreciation transaction recording periodic depreciation expense for a fixed asset.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` (
    `vbc_settlement_id` BIGINT COMMENT 'Primary key',
    `practice_location_id` BIGINT COMMENT 'FK to provider',
    `employee_id` BIGINT COMMENT 'FK to settlement manager',
    `vbc_contract_id` BIGINT COMMENT 'FK to VBC contract',
    `vbc_program_id` BIGINT COMMENT 'FK to VBC program',
    `actual_expenditure_amount` DECIMAL(18,2) COMMENT 'Actual expenditure',
    `benchmark_expenditure_amount` DECIMAL(18,2) COMMENT 'Benchmark expenditure',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `vbc_settlement_description` STRING COMMENT 'Settlement description',
    `final_settlement_amount` DECIMAL(18,2) COMMENT 'The numeric final settlement amount value associated with this vbc settlement record.',
    `is_shared_risk` BOOLEAN COMMENT 'Whether shared risk arrangement',
    `payment_method` DECIMAL(18,2) COMMENT 'The payment method attribute capturing relevant data for the vbc settlement in the finance domain.',
    `payment_status` DECIMAL(18,2) COMMENT 'The current status indicator for the payment within the workflow.',
    `performance_period_end` DATE COMMENT 'The performance period end attribute capturing relevant data for the vbc settlement in the finance domain.',
    `performance_period_start` DATE COMMENT 'The performance period start attribute capturing relevant data for the vbc settlement in the finance domain.',
    `quality_score` DECIMAL(18,2) COMMENT 'The quality score attribute capturing relevant data for the vbc settlement in the finance domain.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'The risk adjustment factor attribute capturing relevant data for the vbc settlement in the finance domain.',
    `savings_amount` DECIMAL(18,2) COMMENT 'The numeric savings amount value associated with this vbc settlement record.',
    `settlement_number` STRING COMMENT 'The settlement number attribute capturing relevant data for the vbc settlement in the finance domain.',
    `settlement_status` STRING COMMENT 'The current status indicator for the settlement within the workflow.',
    `settlement_timestamp` TIMESTAMP COMMENT 'The settlement timestamp attribute capturing relevant data for the vbc settlement in the finance domain.',
    `settlement_type` STRING COMMENT 'The category or classification type of the settlement.',
    `shared_savings_percentage` DECIMAL(18,2) COMMENT 'The shared savings percentage attribute capturing relevant data for the vbc settlement in the finance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_vbc_settlement PRIMARY KEY(`vbc_settlement_id`)
) COMMENT 'Value-based care settlement recording shared savings/losses between payer and provider.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` (
    `mlr_financial_entry_id` BIGINT COMMENT 'Primary key',
    `mlr_calculation_id` BIGINT COMMENT 'FK to MLR calculation',
    `calculation_date` DATE COMMENT 'The date value representing calculation date for this mlr financial entry record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `mlr_financial_entry_description` STRING COMMENT 'Entry description',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_to` DATE COMMENT 'Effective to date',
    `incurred_claims_amount` DECIMAL(18,2) COMMENT 'The numeric incurred claims amount value associated with this mlr financial entry record.',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the mlr financial entry in the finance domain.',
    `market_segment` STRING COMMENT 'The market segment attribute capturing relevant data for the mlr financial entry in the finance domain.',
    `minimum_mlr_threshold` DECIMAL(18,2) COMMENT 'The minimum mlr threshold attribute capturing relevant data for the mlr financial entry in the finance domain.',
    `mlr_financial_entry_status` STRING COMMENT 'Entry status',
    `mlr_percentage` DECIMAL(18,2) COMMENT 'The mlr percentage attribute capturing relevant data for the mlr financial entry in the finance domain.',
    `quality_improvement_expenses` DECIMAL(18,2) COMMENT 'The quality improvement expenses attribute capturing relevant data for the mlr financial entry in the finance domain.',
    `rebate_liability_amount` DECIMAL(18,2) COMMENT 'The numeric rebate liability amount value associated with this mlr financial entry record.',
    `reporting_year` STRING COMMENT 'The calendar or fiscal year associated with the reporting.',
    `state_code` STRING COMMENT 'A standardized code representing the state classification.',
    `submission_date` DATE COMMENT 'The date value representing submission date for this mlr financial entry record.',
    `submission_status` STRING COMMENT 'The current status indicator for the submission within the workflow.',
    `total_earned_premium` DECIMAL(18,2) COMMENT 'The total earned premium attribute capturing relevant data for the mlr financial entry in the finance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_mlr_financial_entry PRIMARY KEY(`mlr_financial_entry_id`)
) COMMENT 'Medical loss ratio financial entry tracking incurred claims, earned premium, and rebate calculations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` (
    `actuarial_reserve_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `actuarial_reserve_status` STRING COMMENT 'Reserve status',
    `actuary_name` STRING COMMENT 'Name of signing actuary',
    `actuary_signature_date` DATE COMMENT 'The date value representing actuary signature date for this actuarial reserve record.',
    `confidence_interval_high` DECIMAL(18,2) COMMENT 'High confidence interval',
    `confidence_interval_low` DECIMAL(18,2) COMMENT 'Low confidence interval',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `development_method` STRING COMMENT 'Development method used',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_to` DATE COMMENT 'Effective to date',
    `gl_posting_reference` STRING COMMENT 'The gl posting reference attribute capturing relevant data for the actuarial reserve in the finance domain.',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the actuarial reserve in the finance domain.',
    `mlr_flag` BOOLEAN COMMENT 'Whether included in MLR',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the actuarial reserve in the finance domain.',
    `paid_claims_amount` DECIMAL(18,2) COMMENT 'The numeric paid claims amount value associated with this actuarial reserve record.',
    `paid_lae_amount` DECIMAL(18,2) COMMENT 'The numeric paid lae amount value associated with this actuarial reserve record.',
    `product_type` STRING COMMENT 'The category or classification type of the product.',
    `reserve_estimate_amount` DECIMAL(18,2) COMMENT 'The numeric reserve estimate amount value associated with this actuarial reserve record.',
    `reserve_period` STRING COMMENT 'The reserve period attribute capturing relevant data for the actuarial reserve in the finance domain.',
    `reserve_type` STRING COMMENT 'The category or classification type of the reserve.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'The risk adjustment factor attribute capturing relevant data for the actuarial reserve in the finance domain.',
    `total_liability_amount` DECIMAL(18,2) COMMENT 'The numeric total liability amount value associated with this actuarial reserve record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_actuarial_reserve PRIMARY KEY(`actuarial_reserve_id`)
) COMMENT 'Actuarial reserve estimate for IBNR, LAE, and other insurance liabilities.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` (
    `finance_regulatory_filing_id` BIGINT COMMENT 'Primary key',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key reference to SSOT compliance.regulatory_submission for regulatory_filing concept',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `estimated_payment_amount` DECIMAL(18,2) COMMENT 'The numeric estimated payment amount value associated with this finance regulatory filing record.',
    `filing_category` STRING COMMENT 'The filing category attribute capturing relevant data for the finance regulatory filing in the finance domain.',
    `filing_document_url` STRING COMMENT 'The filing document url attribute capturing relevant data for the finance regulatory filing in the finance domain.',
    `filing_is_amended` BOOLEAN COMMENT 'Whether amended',
    `filing_number` STRING COMMENT 'The filing number attribute capturing relevant data for the finance regulatory filing in the finance domain.',
    `filing_period_end` DATE COMMENT 'The filing period end attribute capturing relevant data for the finance regulatory filing in the finance domain.',
    `filing_period_start` DATE COMMENT 'The filing period start attribute capturing relevant data for the finance regulatory filing in the finance domain.',
    `filing_status` STRING COMMENT 'The current status indicator for the filing within the workflow.',
    `filing_submission_method` STRING COMMENT 'Submission method',
    `filing_timestamp` TIMESTAMP COMMENT 'The filing timestamp attribute capturing relevant data for the finance regulatory filing in the finance domain.',
    `filing_type` STRING COMMENT 'The category or classification type of the filing.',
    `jurisdiction_code` STRING COMMENT 'A standardized code representing the jurisdiction classification.',
    `preparer_name` STRING COMMENT 'The descriptive name assigned to the preparer for identification purposes.',
    `regulatory_body` STRING COMMENT 'The regulatory body attribute capturing relevant data for the finance regulatory filing in the finance domain.',
    `reviewer_name` STRING COMMENT 'The descriptive name assigned to the reviewer for identification purposes.',
    `submission_deadline` DATE COMMENT 'The submission deadline attribute capturing relevant data for the finance regulatory filing in the finance domain.',
    `tax_liability_amount` DECIMAL(18,2) COMMENT 'The numeric tax liability amount value associated with this finance regulatory filing record.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'The tax rate percent attribute capturing relevant data for the finance regulatory filing in the finance domain.',
    `taxable_base_amount` DECIMAL(18,2) COMMENT 'The numeric taxable base amount value associated with this finance regulatory filing record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_finance_regulatory_filing PRIMARY KEY(`finance_regulatory_filing_id`)
) COMMENT 'Regulatory filing record for financial submissions to state/federal regulators (e.g., annual statements, RBC).';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to approving employee',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `pool_id` BIGINT COMMENT 'FK to risk pool',
    `approval_timestamp` TIMESTAMP COMMENT 'The approval timestamp attribute capturing relevant data for the budget in the finance domain.',
    `budget_number` STRING COMMENT 'The budget number attribute capturing relevant data for the budget in the finance domain.',
    `budget_status` STRING COMMENT 'The current status indicator for the budget within the workflow.',
    `budget_type` STRING COMMENT 'The category or classification type of the budget.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `department_code` STRING COMMENT 'A standardized code representing the department classification.',
    `budget_description` STRING COMMENT 'A detailed textual description of the budget.',
    `division_code` STRING COMMENT 'A standardized code representing the division classification.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this budget record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this budget record.',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the budget in the finance domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the budget in the finance domain.',
    `owner_name` STRING COMMENT 'Budget owner name',
    `prior_year_actual_amount` DECIMAL(18,2) COMMENT 'The numeric prior year actual amount value associated with this budget record.',
    `total_adjusted_amount` DECIMAL(18,2) COMMENT 'The numeric total adjusted amount value associated with this budget record.',
    `total_budgeted_amount` DECIMAL(18,2) COMMENT 'The numeric total budgeted amount value associated with this budget record.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'The numeric total net amount value associated with this budget record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `variance_amount` DECIMAL(18,2) COMMENT 'The numeric variance amount value associated with this budget record.',
    `version` STRING COMMENT 'Budget version',
    `year` STRING COMMENT 'Budget year',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Budget header defining annual or periodic financial plans for cost centers and departments.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Primary key',
    `budget_id` BIGINT COMMENT 'FK to budget header',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `account_code` STRING COMMENT 'A standardized code representing the account classification.',
    `allocation_method` STRING COMMENT 'The allocation method attribute capturing relevant data for the budget line in the finance domain.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The allocation percentage attribute capturing relevant data for the budget line in the finance domain.',
    `approval_status` STRING COMMENT 'The current status indicator for the approval within the workflow.',
    `approved_timestamp` TIMESTAMP COMMENT 'The approved timestamp attribute capturing relevant data for the budget line in the finance domain.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The numeric budget amount value associated with this budget line record.',
    `budget_line_status` STRING COMMENT 'Line status',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `effective_from` DATE COMMENT 'The effective from attribute capturing relevant data for the budget line in the finance domain.',
    `effective_to` DATE COMMENT 'The effective to attribute capturing relevant data for the budget line in the finance domain.',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute capturing relevant data for the budget line in the finance domain.',
    `fiscal_year` STRING COMMENT 'The calendar or fiscal year associated with the fiscal.',
    `is_budgeted` BOOLEAN COMMENT 'Whether budgeted',
    `is_consolidated` BOOLEAN COMMENT 'Whether consolidated',
    `is_forecast` BOOLEAN COMMENT 'Whether forecast',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the budget line in the finance domain.',
    `line_sequence` STRING COMMENT 'The line sequence attribute capturing relevant data for the budget line in the finance domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the budget line in the finance domain.',
    `prior_year_actual_amount` DECIMAL(18,2) COMMENT 'Prior year actual',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `variance_amount` DECIMAL(18,2) COMMENT 'The numeric variance amount value associated with this budget line record.',
    `variance_percent` DECIMAL(18,2) COMMENT 'The variance percent attribute capturing relevant data for the budget line in the finance domain.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Individual budget line item within a budget, specifying amounts by account and period.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` (
    `premium_revenue_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to employer group',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `member_risk_score_id` BIGINT COMMENT 'FK to member risk score',
    `subscriber_id` BIGINT COMMENT 'FK to subscriber',
    `employee_id` BIGINT COMMENT 'FK to underwriter',
    `accounting_period` STRING COMMENT 'The accounting period attribute capturing relevant data for the premium revenue in the finance domain.',
    `capitation_amount` DECIMAL(18,2) COMMENT 'The numeric capitation amount value associated with this premium revenue record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `earned_premium` DECIMAL(18,2) COMMENT 'The earned premium attribute capturing relevant data for the premium revenue in the finance domain.',
    `effective_from` DATE COMMENT 'The effective from attribute capturing relevant data for the premium revenue in the finance domain.',
    `effective_to` DATE COMMENT 'The effective to attribute capturing relevant data for the premium revenue in the finance domain.',
    `fiscal_month` STRING COMMENT 'The fiscal month attribute capturing relevant data for the premium revenue in the finance domain.',
    `fiscal_year` STRING COMMENT 'The calendar or fiscal year associated with the fiscal.',
    `is_capitated` BOOLEAN COMMENT 'Whether capitated',
    `lob` STRING COMMENT 'Line of business',
    `market_segment` STRING COMMENT 'The market segment attribute capturing relevant data for the premium revenue in the finance domain.',
    `mlr_denominator_flag` BOOLEAN COMMENT 'Whether included in MLR denominator',
    `net_earned_premium` DECIMAL(18,2) COMMENT 'The net earned premium attribute capturing relevant data for the premium revenue in the finance domain.',
    `premium_revenue_status` DECIMAL(18,2) COMMENT 'Revenue status',
    `premium_type` DECIMAL(18,2) COMMENT 'The category or classification type of the premium.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Whether regulatory reporting',
    `reinsurance_ceded_premium` DECIMAL(18,2) COMMENT 'The reinsurance ceded premium attribute capturing relevant data for the premium revenue in the finance domain.',
    `revenue_date` DATE COMMENT 'The date value representing revenue date for this premium revenue record.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'The risk adjustment factor attribute capturing relevant data for the premium revenue in the finance domain.',
    `unearned_premium_reserve` DECIMAL(18,2) COMMENT 'The unearned premium reserve attribute capturing relevant data for the premium revenue in the finance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `written_premium` DECIMAL(18,2) COMMENT 'The written premium attribute capturing relevant data for the premium revenue in the finance domain.',
    CONSTRAINT pk_premium_revenue PRIMARY KEY(`premium_revenue_id`)
) COMMENT 'Premium revenue record tracking earned and written premium by member, plan, and period.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` (
    `reinsurance_transaction_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `vendor_id` BIGINT COMMENT 'FK to reinsurer vendor',
    `reinsurance_arrangement_id` BIGINT COMMENT 'FK to reinsurance arrangement',
    `attachment_point_amount` DECIMAL(18,2) COMMENT 'The numeric attachment point amount value associated with this reinsurance transaction record.',
    `ceded_loss_amount` DECIMAL(18,2) COMMENT 'The numeric ceded loss amount value associated with this reinsurance transaction record.',
    `ceded_premium_amount` DECIMAL(18,2) COMMENT 'The numeric ceded premium amount value associated with this reinsurance transaction record.',
    `coverage_end_date` DATE COMMENT 'The date value representing coverage end date for this reinsurance transaction record.',
    `coverage_start_date` DATE COMMENT 'The date value representing coverage start date for this reinsurance transaction record.',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `reinsurance_transaction_description` STRING COMMENT 'Transaction description',
    `effective_date` DATE COMMENT 'The date value representing effective date for this reinsurance transaction record.',
    `is_adjusted` BOOLEAN COMMENT 'Whether adjusted',
    `is_assumed` BOOLEAN COMMENT 'Whether assumed',
    `is_ceded` BOOLEAN COMMENT 'Whether ceded',
    `is_stop_loss` BOOLEAN COMMENT 'Whether stop loss',
    `limit_amount` DECIMAL(18,2) COMMENT 'The numeric limit amount value associated with this reinsurance transaction record.',
    `net_amount` DECIMAL(18,2) COMMENT 'The numeric net amount value associated with this reinsurance transaction record.',
    `rbc_credit_amount` DECIMAL(18,2) COMMENT 'The numeric rbc credit amount value associated with this reinsurance transaction record.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'The numeric recovery amount value associated with this reinsurance transaction record.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'The risk adjustment factor attribute capturing relevant data for the reinsurance transaction in the finance domain.',
    `sap_schedule_f_flag` BOOLEAN COMMENT 'Whether SAP Schedule F applicable',
    `settlement_date` DATE COMMENT 'The date value representing settlement date for this reinsurance transaction record.',
    `settlement_status` STRING COMMENT 'The current status indicator for the settlement within the workflow.',
    `transaction_number` STRING COMMENT 'The transaction number attribute capturing relevant data for the reinsurance transaction in the finance domain.',
    `transaction_status` STRING COMMENT 'The current status indicator for the transaction within the workflow.',
    `transaction_type` STRING COMMENT 'The category or classification type of the transaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_reinsurance_transaction PRIMARY KEY(`reinsurance_transaction_id`)
) COMMENT 'Reinsurance transaction recording ceded/assumed premium, losses, and settlements with reinsurers.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `legal_entity_id` BIGINT COMMENT 'FK to originating legal entity',
    `reversal_transaction_intercompany_transaction_id` BIGINT COMMENT 'FK to reversed transaction',
    `accounting_period` STRING COMMENT 'The accounting period attribute capturing relevant data for the intercompany transaction in the finance domain.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Gross amount',
    `amount_net` DECIMAL(18,2) COMMENT 'Net amount',
    `approval_status` STRING COMMENT 'The current status indicator for the approval within the workflow.',
    `approved_timestamp` TIMESTAMP COMMENT 'The approved timestamp attribute capturing relevant data for the intercompany transaction in the finance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `intercompany_transaction_description` STRING COMMENT 'Transaction description',
    `elimination_flag` BOOLEAN COMMENT 'Whether elimination entry',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The numeric exchange rate value associated with this intercompany transaction record.',
    `fiscal_month` STRING COMMENT 'The fiscal month attribute capturing relevant data for the intercompany transaction in the finance domain.',
    `fiscal_year` STRING COMMENT 'The calendar or fiscal year associated with the fiscal.',
    `intercompany_transaction_status` STRING COMMENT 'Transaction status',
    `is_budgeted` BOOLEAN COMMENT 'Whether budgeted',
    `is_foreign_currency` BOOLEAN COMMENT 'Whether foreign currency',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the intercompany transaction in the finance domain.',
    `posted_flag` BOOLEAN COMMENT 'Whether posted',
    `posted_timestamp` TIMESTAMP COMMENT 'The posted timestamp attribute capturing relevant data for the intercompany transaction in the finance domain.',
    `transaction_number` STRING COMMENT 'The transaction number attribute capturing relevant data for the intercompany transaction in the finance domain.',
    `transaction_timestamp` TIMESTAMP COMMENT 'The transaction timestamp attribute capturing relevant data for the intercompany transaction in the finance domain.',
    `transaction_type` STRING COMMENT 'The category or classification type of the transaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Intercompany transaction between legal entities within the organization for consolidation elimination.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `employee_id` BIGINT COMMENT 'FK to responsible employee',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `account_holder_name` STRING COMMENT 'The descriptive name assigned to the account holder for identification purposes.',
    `account_number` STRING COMMENT 'Bank account number',
    `account_open_date` DATE COMMENT 'The date value representing account open date for this bank account record.',
    `account_purpose` STRING COMMENT 'The account purpose attribute capturing relevant data for the bank account in the finance domain.',
    `account_type` STRING COMMENT 'The category or classification type of the account.',
    `bank_account_status` STRING COMMENT 'Account status',
    `bank_name` STRING COMMENT 'The descriptive name assigned to the bank for identification purposes.',
    `bank_statement_balance` DECIMAL(18,2) COMMENT 'The bank statement balance attribute capturing relevant data for the bank account in the finance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `effective_from` DATE COMMENT 'The effective from attribute capturing relevant data for the bank account in the finance domain.',
    `effective_to` DATE COMMENT 'The effective to attribute capturing relevant data for the bank account in the finance domain.',
    `gl_balance` DECIMAL(18,2) COMMENT 'The gl balance attribute capturing relevant data for the bank account in the finance domain.',
    `is_claims_disbursement_account` BOOLEAN COMMENT 'Whether claims disbursement account',
    `is_lockbox` BOOLEAN COMMENT 'Whether lockbox',
    `is_operating_account` BOOLEAN COMMENT 'Whether operating account',
    `is_payroll_account` BOOLEAN COMMENT 'Whether payroll account',
    `is_reconciled` BOOLEAN COMMENT 'Whether reconciled',
    `last_reconciliation_date` DATE COMMENT 'The date value representing last reconciliation date for this bank account record.',
    `reconciled_balance` DECIMAL(18,2) COMMENT 'The reconciled balance attribute capturing relevant data for the bank account in the finance domain.',
    `reconciliation_status` STRING COMMENT 'The current status indicator for the reconciliation within the workflow.',
    `routing_number` STRING COMMENT 'Bank routing number',
    `signatory_name` STRING COMMENT 'The descriptive name assigned to the signatory for identification purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Bank account master record for treasury management and cash reconciliation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` (
    `bank_reconciliation_id` BIGINT COMMENT 'Primary key',
    `bank_account_id` BIGINT COMMENT 'FK to bank account',
    `employee_id` BIGINT COMMENT 'FK to preparer employee',
    `approval_status` STRING COMMENT 'The current status indicator for the approval within the workflow.',
    `approval_timestamp` TIMESTAMP COMMENT 'The approval timestamp attribute capturing relevant data for the bank reconciliation in the finance domain.',
    `bank_statement_balance` DECIMAL(18,2) COMMENT 'The bank statement balance attribute capturing relevant data for the bank reconciliation in the finance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `deposits_in_transit_amount` DECIMAL(18,2) COMMENT 'Deposits in transit',
    `gl_balance` DECIMAL(18,2) COMMENT 'The gl balance attribute capturing relevant data for the bank reconciliation in the finance domain.',
    `is_adjusted` BOOLEAN COMMENT 'Whether adjusted',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the bank reconciliation in the finance domain.',
    `outstanding_checks_amount` DECIMAL(18,2) COMMENT 'The numeric outstanding checks amount value associated with this bank reconciliation record.',
    `reconciled_balance` DECIMAL(18,2) COMMENT 'The reconciled balance attribute capturing relevant data for the bank reconciliation in the finance domain.',
    `reconciliation_number` STRING COMMENT 'The reconciliation number attribute capturing relevant data for the bank reconciliation in the finance domain.',
    `reconciliation_period_end` DATE COMMENT 'Period end',
    `reconciliation_period_start` DATE COMMENT 'Period start',
    `reconciliation_status` STRING COMMENT 'The current status indicator for the reconciliation within the workflow.',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'The reconciliation timestamp attribute capturing relevant data for the bank reconciliation in the finance domain.',
    `reconciliation_type` STRING COMMENT 'The category or classification type of the reconciliation.',
    `unreconciled_items_amount` DECIMAL(18,2) COMMENT 'The numeric unreconciled items amount value associated with this bank reconciliation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_bank_reconciliation PRIMARY KEY(`bank_reconciliation_id`)
) COMMENT 'Bank reconciliation record comparing bank statement to GL for a given period.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` (
    `tax_filing_id` BIGINT COMMENT 'Primary key',
    `legal_entity_id` BIGINT COMMENT 'FK to legal entity',
    `prior_filing_tax_filing_id` BIGINT COMMENT 'FK to prior filing',
    `confirmation_number` STRING COMMENT 'The confirmation number attribute capturing relevant data for the tax filing in the finance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `estimated_payments_amount` DECIMAL(18,2) COMMENT 'The numeric estimated payments amount value associated with this tax filing record.',
    `filing_date` DATE COMMENT 'The date value representing filing date for this tax filing record.',
    `filing_description` STRING COMMENT 'A detailed textual description of the filing.',
    `filing_method` STRING COMMENT 'The filing method attribute capturing relevant data for the tax filing in the finance domain.',
    `filing_number` STRING COMMENT 'The filing number attribute capturing relevant data for the tax filing in the finance domain.',
    `filing_status` STRING COMMENT 'The current status indicator for the filing within the workflow.',
    `filing_timestamp` TIMESTAMP COMMENT 'The filing timestamp attribute capturing relevant data for the tax filing in the finance domain.',
    `final_tax_due_amount` DECIMAL(18,2) COMMENT 'Final tax due',
    `is_amended` BOOLEAN COMMENT 'Whether amended',
    `is_filed` BOOLEAN COMMENT 'Whether filed',
    `payment_amount` DECIMAL(18,2) COMMENT 'The numeric payment amount value associated with this tax filing record.',
    `payment_due_date` DATE COMMENT 'The date value representing payment due date for this tax filing record.',
    `payment_method` DECIMAL(18,2) COMMENT 'The payment method attribute capturing relevant data for the tax filing in the finance domain.',
    `tax_category` STRING COMMENT 'The tax category attribute capturing relevant data for the tax filing in the finance domain.',
    `tax_form_code` STRING COMMENT 'A standardized code representing the tax form classification.',
    `tax_jurisdiction_code` STRING COMMENT 'A standardized code representing the tax jurisdiction classification.',
    `tax_liability_amount` DECIMAL(18,2) COMMENT 'The numeric tax liability amount value associated with this tax filing record.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'The tax rate percent attribute capturing relevant data for the tax filing in the finance domain.',
    `tax_type` STRING COMMENT 'The category or classification type of the tax.',
    `tax_year` STRING COMMENT 'The calendar or fiscal year associated with the tax.',
    `taxable_base_amount` DECIMAL(18,2) COMMENT 'The numeric taxable base amount value associated with this tax filing record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_tax_filing PRIMARY KEY(`tax_filing_id`)
) COMMENT 'Tax filing record for federal, state, and local tax submissions by legal entity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key',
    `parent_legal_entity_id` BIGINT COMMENT 'FK to parent legal entity',
    `address` STRING COMMENT 'Legal entity address',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `domicile_state` STRING COMMENT 'The domicile state attribute capturing relevant data for the legal entity in the finance domain.',
    `ein` STRING COMMENT 'Employer Identification Number',
    `entity_type` STRING COMMENT 'Entity type (corporation, LLC, etc.)',
    `fax` STRING COMMENT 'Legal entity fax number',
    `incorporation_date` DATE COMMENT 'The date value representing incorporation date for this legal entity record.',
    `is_consolidated` BOOLEAN COMMENT 'Whether consolidated',
    `legal_entity_status` STRING COMMENT 'Entity status',
    `naic_number` STRING COMMENT 'NAIC company number',
    `legal_entity_name` STRING COMMENT 'The descriptive name assigned to the legal entity for identification purposes.',
    `phone` STRING COMMENT 'Legal entity phone',
    `regulatory_jurisdiction` STRING COMMENT 'The regulatory jurisdiction attribute capturing relevant data for the legal entity in the finance domain.',
    `state_license_number` STRING COMMENT 'The state license number attribute capturing relevant data for the legal entity in the finance domain.',
    `tax_identification_number` STRING COMMENT 'The tax identification number attribute capturing relevant data for the legal entity in the finance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Legal entity master record representing corporate entities for financial consolidation and regulatory reporting.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_reversal_of_journal_entry_id` FOREIGN KEY (`reversal_of_journal_entry_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_reversal_invoice_ar_invoice_id` FOREIGN KEY (`reversal_invoice_ar_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_reversal_receipt_ar_receipt_id` FOREIGN KEY (`reversal_receipt_ar_receipt_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`ar_receipt`(`ar_receipt_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ADD CONSTRAINT `fk_finance_depreciation_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ADD CONSTRAINT `fk_finance_depreciation_transaction_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` ADD CONSTRAINT `fk_finance_depreciation_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ADD CONSTRAINT `fk_finance_actuarial_reserve_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_reversal_transaction_intercompany_transaction_id` FOREIGN KEY (`reversal_transaction_intercompany_transaction_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ADD CONSTRAINT `fk_finance_tax_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` ADD CONSTRAINT `fk_finance_tax_filing_prior_filing_tax_filing_id` FOREIGN KEY (`prior_filing_tax_filing_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`tax_filing`(`tax_filing_id`);
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `vibe_health_insurance_v1`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_health_insurance_v1`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ledger` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `group_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`journal_entry_line` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_invoice` ALTER COLUMN `grace_period_end` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`ar_receipt` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_treasury');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` SET TAGS ('dbx_subdomain' = 'asset_treasury');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`depreciation_transaction` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` SET TAGS ('dbx_subdomain' = 'insurance_reporting');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`vbc_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` SET TAGS ('dbx_subdomain' = 'insurance_reporting');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`mlr_financial_entry` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` SET TAGS ('dbx_subdomain' = 'insurance_reporting');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `actuary_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `actuary_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`actuarial_reserve` ALTER COLUMN `actuary_signature_date` SET TAGS ('dbx_pii_type' = 'signature');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('dbx_subdomain' = 'insurance_reporting');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `owner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_category' = 'person_name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` SET TAGS ('dbx_subdomain' = 'insurance_reporting');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`premium_revenue` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` SET TAGS ('dbx_subdomain' = 'insurance_reporting');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`reinsurance_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'payables_receivables');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`intercompany_transaction` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'asset_treasury');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_type' = 'financial');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_type' = 'financial');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `signatory_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_account` ALTER COLUMN `signatory_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` SET TAGS ('dbx_subdomain' = 'asset_treasury');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`bank_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` SET TAGS ('dbx_subdomain' = 'insurance_reporting');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`tax_filing` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` SET TAGS ('dbx_FHIR_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `address` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `domicile_state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `ein` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `ein` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `fax` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `fax` SET TAGS ('dbx_pii_category' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `phone` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_sensitivity' = 'pii');
