-- Schema for Domain: billing | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 18:57:24

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`billing` COMMENT 'Revenue cycle management including consumption-based billing, rate structures, invoice generation, payment processing, payment plans, collections, delinquency management, billing adjustments, dispute resolution, and revenue recognition. SSOT for all financial transactions with customers including water, wastewater, stormwater, and other utility charges.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Primary key',
    `billing_cycle_id` BIGINT COMMENT 'FK to billing cycle',
    `cip_project_id` BIGINT COMMENT 'FK to CIP project',
    `customer_account_id` BIGINT COMMENT 'FK to customer account',
    `fund_id` BIGINT COMMENT 'FK to fund',
    `point_id` BIGINT COMMENT 'FK to service point',
    `service_line_id` BIGINT COMMENT 'FK to service line',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustments applied',
    `billing_period_end_date` DATE COMMENT 'End date of billing period',
    `billing_period_start_date` DATE COMMENT 'Start date of billing period',
    `ccr_included` BOOLEAN COMMENT 'Consumer Confidence Report included flag',
    `conservation_message` STRING COMMENT 'Conservation message text',
    `created_by_user` STRING COMMENT 'User who created the record',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'ISO currency code',
    `delivery_method` STRING COMMENT 'Invoice delivery method',
    `disconnection_date` DATE COMMENT 'Scheduled disconnection date',
    `dispute_flag` BOOLEAN COMMENT 'Invoice disputed flag',
    `due_date` DATE COMMENT 'Payment due date',
    `generation_method` DECIMAL(18,2) COMMENT 'Invoice generation method',
    `invoice_date` DATE COMMENT 'Invoice issue date',
    `invoice_number` STRING COMMENT 'Unique invoice number',
    `invoice_status` STRING COMMENT 'Invoice status',
    `invoice_type` STRING COMMENT 'Invoice type',
    `is_estimated` BOOLEAN COMMENT 'Estimated consumption flag',
    `is_final` BOOLEAN COMMENT 'Final invoice flag',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Late fee amount',
    `modified_by_user` STRING COMMENT 'User who last modified',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `other_charges_amount` DECIMAL(18,2) COMMENT 'Other charges amount',
    `payment_terms_days` DECIMAL(18,2) COMMENT 'Payment terms in days',
    `previous_balance_amount` DECIMAL(18,2) COMMENT 'Previous balance amount',
    `print_date` DATE COMMENT 'Invoice print date',
    `rate_schedule_code` DECIMAL(18,2) COMMENT 'Rate schedule code',
    `stormwater_area` DECIMAL(18,2) COMMENT 'Stormwater billing area',
    `stormwater_charge_amount` DECIMAL(18,2) COMMENT 'Stormwater charge amount',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount',
    `total_amount_due` DECIMAL(18,2) COMMENT 'Total amount due',
    `wastewater_charge_amount` DECIMAL(18,2) COMMENT 'Wastewater charge amount',
    `wastewater_volume` DECIMAL(18,2) COMMENT 'Wastewater volume',
    `water_charge_amount` DECIMAL(18,2) COMMENT 'Water charge amount',
    `water_consumption_uom` STRING COMMENT 'Water consumption unit of measure',
    `water_consumption_volume` DECIMAL(18,2) COMMENT 'Water consumption volume',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Customer invoice for water, wastewater, and stormwater services';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Primary key',
    `agreement_id` BIGINT COMMENT 'FK to service agreement',
    `billing_rate_schedule_id` DECIMAL(18,2) COMMENT 'FK to billing rate schedule',
    `general_ledger_id` BIGINT COMMENT 'FK to GL account',
    `interval_consumption_id` BIGINT COMMENT 'FK to interval consumption',
    `invoice_id` BIGINT COMMENT 'FK to invoice',
    `point_id` BIGINT COMMENT 'FK to service point',
    `rate_tier_id` BIGINT COMMENT 'FK to rate tier',
    `service_line_id` BIGINT COMMENT 'FK to service line',
    `facility_id` BIGINT COMMENT 'FK to treatment facility',
    `adjustment_reason_code` STRING COMMENT 'Adjustment reason code',
    `adjustment_reference_number` STRING COMMENT 'Adjustment reference number',
    `billing_determinant` STRING COMMENT 'Billing determinant',
    `billing_period_end_date` DATE COMMENT 'Billing period end date',
    `billing_period_start_date` DATE COMMENT 'Billing period start date',
    `charge_description` DECIMAL(18,2) COMMENT 'Charge description',
    `charge_type_code` DECIMAL(18,2) COMMENT 'Charge type code',
    `created_by_user` STRING COMMENT 'Created by user',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `is_disputed` BOOLEAN COMMENT 'Disputed flag',
    `is_prorated` BOOLEAN COMMENT 'Prorated flag',
    `is_taxable` BOOLEAN COMMENT 'Taxable flag',
    `last_modified_by_user` STRING COMMENT 'Last modified by user',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp',
    `line_amount` DECIMAL(18,2) COMMENT 'Line amount',
    `line_sequence_number` STRING COMMENT 'Line sequence number',
    `line_status` STRING COMMENT 'Line status',
    `print_sequence` STRING COMMENT 'Print sequence',
    `proration_factor` DECIMAL(18,2) COMMENT 'Proration factor',
    `revenue_class` DECIMAL(18,2) COMMENT 'Revenue class',
    `service_days` STRING COMMENT 'Service days',
    `service_type` STRING COMMENT 'Service type',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'Tax rate percentage',
    `total_line_amount` DECIMAL(18,2) COMMENT 'Total line amount',
    `unit_rate` DECIMAL(18,2) COMMENT 'Unit rate',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual line items on customer invoices';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Primary key',
    `ar_transaction_id` BIGINT COMMENT 'FK to AR transaction',
    `bank_account_id` BIGINT COMMENT 'FK to bank account',
    `cip_project_id` BIGINT COMMENT 'FK to CIP project',
    `customer_account_id` BIGINT COMMENT 'FK to customer account',
    `journal_entry_id` BIGINT COMMENT 'FK to journal entry',
    `invoice_id` BIGINT COMMENT 'FK to invoice',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `payment_invoice_id` BIGINT COMMENT 'FK to invoice',
    `payment_plan_id` BIGINT COMMENT 'FK to payment plan',
    `payment_received_by_user_employee_id` BIGINT COMMENT 'FK to employee who received payment',
    `reversed_by_payment_id` BIGINT COMMENT 'FK to reversing payment',
    `amount` DECIMAL(18,2) COMMENT 'Payment amount',
    `applied_amount` DECIMAL(18,2) COMMENT 'Applied amount',
    `authorization_code` STRING COMMENT 'Authorization code',
    `bank_account_last_four` STRING COMMENT 'Bank account last four digits',
    `batch_number` STRING COMMENT 'Batch number',
    `card_last_four` STRING COMMENT 'Card last four digits',
    `card_type` STRING COMMENT 'Card type',
    `channel` STRING COMMENT 'Payment channel',
    `check_number` STRING COMMENT 'Check number',
    `cleared_date` DATE COMMENT 'Cleared date',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `is_auto_pay` BOOLEAN COMMENT 'Auto pay flag',
    `is_recurring` BOOLEAN COMMENT 'Recurring flag',
    `location_code` STRING COMMENT 'Location code',
    `lockbox_number` STRING COMMENT 'Lockbox number',
    `method` DECIMAL(18,2) COMMENT 'Payment method',
    `modified_timestamp` TIMESTAMP COMMENT 'Modified timestamp',
    `notes` STRING COMMENT 'Notes',
    `nsf_fee_amount` DECIMAL(18,2) COMMENT 'NSF fee amount',
    `nsf_indicator` BOOLEAN COMMENT 'NSF indicator',
    `payment_date` DATE COMMENT 'Payment date',
    `payment_number` DECIMAL(18,2) COMMENT 'Payment number',
    `payment_status` DECIMAL(18,2) COMMENT 'Payment status',
    `payment_timestamp` TIMESTAMP COMMENT 'Payment timestamp',
    `payment_type` DECIMAL(18,2) COMMENT 'Payment type',
    `posting_date` DATE COMMENT 'Posting date',
    `processor_name` STRING COMMENT 'Processor name',
    `reference_number` STRING COMMENT 'Reference number',
    `reversal_reason` STRING COMMENT 'Reversal reason',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'Unapplied amount',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Customer payments received';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` (
    `payment_application_id` BIGINT COMMENT 'Primary key',
    `billing_account_id` BIGINT COMMENT 'FK to billing account',
    `invoice_id` BIGINT COMMENT 'FK to invoice',
    `employee_id` BIGINT COMMENT 'FK to employee who applied payment',
    `dispute_id` BIGINT COMMENT 'FK to dispute',
    `payment_dispute_id` BIGINT COMMENT 'FK to dispute',
    `payment_employee_id` BIGINT COMMENT 'FK to employee',
    `payment_id` BIGINT COMMENT 'FK to payment',
    `invoice_line_id` BIGINT COMMENT 'FK to invoice line',
    `payment_invoice_line_item_invoice_line_id` BIGINT COMMENT 'FK to invoice line item',
    `payment_plan_id` BIGINT COMMENT 'FK to payment plan',
    `adjustment_date` DATE COMMENT 'Adjustment date',
    `adjustment_indicator` BOOLEAN COMMENT 'Adjustment indicator',
    `adjustment_reason_code` STRING COMMENT 'Adjustment reason code',
    `allocation_method` STRING COMMENT 'Allocation method',
    `application_date` DATE COMMENT 'Application date',
    `application_number` STRING COMMENT 'Application number',
    `application_sequence` STRING COMMENT 'Application sequence',
    `application_source` STRING COMMENT 'Application source',
    `application_status` STRING COMMENT 'Application status',
    `application_timestamp` TIMESTAMP COMMENT 'Application timestamp',
    `applied_amount` DECIMAL(18,2) COMMENT 'Applied amount',
    `ar_reconciliation_status` STRING COMMENT 'AR reconciliation status',
    `balance_bucket_code` DECIMAL(18,2) COMMENT 'Balance bucket code',
    `charge_type` DECIMAL(18,2) COMMENT 'Charge type',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `dispute_indicator` BOOLEAN COMMENT 'Dispute indicator',
    `gl_account_code` STRING COMMENT 'GL account code',
    `is_overpayment` BOOLEAN COMMENT 'Overpayment flag',
    `is_prepayment` BOOLEAN COMMENT 'Prepayment flag',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp',
    `notes` STRING COMMENT 'Notes',
    `overpayment_handling` DECIMAL(18,2) COMMENT 'Overpayment handling',
    `revenue_recognition_date` DATE COMMENT 'Revenue recognition date',
    `reversal_date` DATE COMMENT 'Reversal date',
    `reversal_indicator` BOOLEAN COMMENT 'Reversal indicator',
    `reversal_reason_code` STRING COMMENT 'Reversal reason code',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'Unapplied amount',
    CONSTRAINT pk_payment_application PRIMARY KEY(`payment_application_id`)
) COMMENT 'Application of payments to invoices';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` (
    `billing_account_id` BIGINT COMMENT 'Primary key',
    `agreement_id` BIGINT COMMENT 'FK to service agreement',
    `facility_id` BIGINT COMMENT 'FK to treatment facility',
    `customer_account_id` BIGINT COMMENT 'FK to customer account',
    `account_number` STRING COMMENT 'Account number',
    `account_status` STRING COMMENT 'Account status',
    `account_type` STRING COMMENT 'Account type',
    `aging_30_days` DECIMAL(18,2) COMMENT 'Aging 30 days',
    `aging_60_days` DECIMAL(18,2) COMMENT 'Aging 60 days',
    `aging_90_days` DECIMAL(18,2) COMMENT 'Aging 90 days',
    `aging_current` DECIMAL(18,2) COMMENT 'Aging current',
    `aging_over_90_days` DECIMAL(18,2) COMMENT 'Aging over 90 days',
    `autopay_enrolled` BOOLEAN COMMENT 'Autopay enrolled',
    `autopay_method` STRING COMMENT 'Autopay method',
    `balance_forward` DECIMAL(18,2) COMMENT 'Balance forward',
    `billing_cycle_code` STRING COMMENT 'Billing cycle code',
    `billing_frequency` STRING COMMENT 'Billing frequency',
    `billing_ssot_customer_account_ref_id` BIGINT COMMENT 'Foreign key to the canonical customer_account record in customer domain',
    `budget_billing_amount` DECIMAL(18,2) COMMENT 'Budget billing amount',
    `budget_billing_enrolled` DECIMAL(18,2) COMMENT 'Budget billing enrolled',
    `closed_date` DATE COMMENT 'Closed date',
    `collection_status` STRING COMMENT 'Collection status',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `credit_limit` DECIMAL(18,2) COMMENT 'Credit limit',
    `credit_rating` STRING COMMENT 'Credit rating',
    `current_balance` DECIMAL(18,2) COMMENT 'Current balance',
    `current_charges` DECIMAL(18,2) COMMENT 'Current charges',
    `deposit_on_file` DECIMAL(18,2) COMMENT 'Deposit on file',
    `disconnection_date` DATE COMMENT 'Disconnection date',
    `final_bill_issued` BOOLEAN COMMENT 'Final bill issued',
    `last_bill_date` DATE COMMENT 'Last bill date',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Last payment amount',
    `last_payment_date` DATE COMMENT 'Last payment date',
    `late_fee_assessed` DECIMAL(18,2) COMMENT 'Late fee assessed',
    `modified_timestamp` TIMESTAMP COMMENT 'Modified timestamp',
    `next_bill_date` DATE COMMENT 'Next bill date',
    `opened_date` DATE COMMENT 'Opened date',
    `paperless_billing` BOOLEAN COMMENT 'Paperless billing',
    `past_due_amount` DECIMAL(18,2) COMMENT 'Past due amount',
    `payment_plan_active` DECIMAL(18,2) COMMENT 'Payment plan active',
    `payment_plan_balance` DECIMAL(18,2) COMMENT 'Payment plan balance',
    `payment_terms` DECIMAL(18,2) COMMENT 'Payment terms',
    `reconnection_fee` DECIMAL(18,2) COMMENT 'Reconnection fee',
    `tax_exempt` DECIMAL(18,2) COMMENT 'Tax exempt',
    `tax_exempt_certificate` DECIMAL(18,2) COMMENT 'Tax exempt certificate',
    CONSTRAINT pk_billing_account PRIMARY KEY(`billing_account_id`)
) COMMENT 'Billing account master [DEPRECATED: Single source of truth is customer.customer_account]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` (
    `billing_rate_schedule_id` DECIMAL(18,2) COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `service_rate_schedule_id` BIGINT COMMENT 'FK to service rate schedule',
    `billing_ssot_service_rate_schedule_ref_id` BIGINT COMMENT 'Foreign key to the canonical service_rate_schedule record in service domain',
    `finance_rate_case_id` BIGINT COMMENT 'FK to finance rate case',
    `offering_id` BIGINT COMMENT 'FK to service offering',
    `superseded_by_rate_schedule_billing_rate_schedule_id` DECIMAL(18,2) COMMENT 'FK to superseding rate schedule',
    `base_charge_amount` DECIMAL(18,2) COMMENT 'Base charge amount',
    `billing_frequency` STRING COMMENT 'Billing frequency',
    `billing_rate_schedule_status` DECIMAL(18,2) COMMENT 'Rate schedule status',
    `conservation_rate_indicator` DECIMAL(18,2) COMMENT 'Conservation rate indicator',
    `consumption_unit_of_measure` STRING COMMENT 'Consumption unit of measure',
    `created_by_user` STRING COMMENT 'Created by user',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `customer_class` STRING COMMENT 'Customer class',
    `billing_rate_schedule_description` DECIMAL(18,2) COMMENT 'Rate schedule description',
    `drought_surcharge_applicable` DECIMAL(18,2) COMMENT 'Drought surcharge applicable',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `jurisdiction` STRING COMMENT 'Jurisdiction',
    `last_modified_by_user` STRING COMMENT 'Last modified by user',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp',
    `maximum_charge_amount` DECIMAL(18,2) COMMENT 'Maximum charge amount',
    `meter_size_applicability` STRING COMMENT 'Meter size applicability',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'Minimum charge amount',
    `notes` STRING COMMENT 'Notes',
    `rate_schedule_code` DECIMAL(18,2) COMMENT 'Rate schedule code',
    `rate_schedule_name` DECIMAL(18,2) COMMENT 'Rate schedule name',
    `rate_structure_type` DECIMAL(18,2) COMMENT 'Rate structure type',
    `regulatory_approval_date` DATE COMMENT 'Regulatory approval date',
    `regulatory_approval_reference` STRING COMMENT 'Regulatory approval reference',
    `seasonal_indicator` BOOLEAN COMMENT 'Seasonal indicator',
    `service_type` STRING COMMENT 'Service type',
    CONSTRAINT pk_billing_rate_schedule PRIMARY KEY(`billing_rate_schedule_id`)
) COMMENT 'Billing rate schedules [DEPRECATED: Single source of truth is service.service_rate_schedule]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` (
    `rate_component_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `billing_rate_schedule_id` DECIMAL(18,2) COMMENT 'FK to billing rate schedule',
    `approval_authority` STRING COMMENT 'Approval authority',
    `approval_date` DATE COMMENT 'Approval date',
    `bill_print_label` STRING COMMENT 'Bill print label',
    `calculation_formula` STRING COMMENT 'Calculation formula',
    `calculation_method` STRING COMMENT 'Calculation method',
    `component_code` STRING COMMENT 'Component code',
    `component_name` STRING COMMENT 'Component name',
    `component_type` STRING COMMENT 'Component type',
    `conservation_tier_flag` BOOLEAN COMMENT 'Conservation tier flag',
    `cost_center` DECIMAL(18,2) COMMENT 'Cost center',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `rate_component_description` DECIMAL(18,2) COMMENT 'Rate component description',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `flat_amount` DECIMAL(18,2) COMMENT 'Flat amount',
    `gl_account_code` STRING COMMENT 'GL account code',
    `is_prorated` BOOLEAN COMMENT 'Is prorated',
    `is_taxable` BOOLEAN COMMENT 'Is taxable',
    `is_volumetric` BOOLEAN COMMENT 'Is volumetric',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp',
    `meter_size_applicability` STRING COMMENT 'Meter size applicability',
    `percentage_rate` DECIMAL(18,2) COMMENT 'Percentage rate',
    `print_on_bill_flag` BOOLEAN COMMENT 'Print on bill flag',
    `rate_case_number` DECIMAL(18,2) COMMENT 'Rate case number',
    `rate_component_status` DECIMAL(18,2) COMMENT 'Rate component status',
    `regulatory_reporting_category` STRING COMMENT 'Regulatory reporting category',
    `revenue_class` DECIMAL(18,2) COMMENT 'Revenue class',
    `seasonal_indicator` BOOLEAN COMMENT 'Seasonal indicator',
    `sequence_number` STRING COMMENT 'Sequence number',
    `service_type` STRING COMMENT 'Service type',
    `tier_high_threshold` DECIMAL(18,2) COMMENT 'Tier high threshold',
    `tier_low_threshold` DECIMAL(18,2) COMMENT 'Tier low threshold',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    `unit_rate` DECIMAL(18,2) COMMENT 'Unit rate',
    CONSTRAINT pk_rate_component PRIMARY KEY(`rate_component_id`)
) COMMENT 'Rate components within rate schedules';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `adjustment_initiated_by_user_employee_id` BIGINT COMMENT 'FK to employee',
    `cip_project_id` BIGINT COMMENT 'FK to CIP project',
    `customer_account_id` BIGINT COMMENT 'FK to customer account',
    `invoice_id` BIGINT COMMENT 'FK to invoice',
    `journal_entry_id` BIGINT COMMENT 'FK to journal entry',
    `main_break_id` BIGINT COMMENT 'FK to main break',
    `network_isolation_event_id` BIGINT COMMENT 'FK to network isolation event',
    `original_adjustment_id` BIGINT COMMENT 'FK to original adjustment',
    `payment_plan_id` BIGINT COMMENT 'FK to payment plan',
    `primary_adjustment_employee_id` BIGINT COMMENT 'FK to employee',
    `registry_id` BIGINT COMMENT 'FK to asset registry',
    `service_line_id` BIGINT COMMENT 'FK to service line',
    `test_result_id` BIGINT COMMENT 'FK to test result',
    `water_sample_id` BIGINT COMMENT 'FK to water sample',
    `adjustment_number` STRING COMMENT 'Adjustment number',
    `adjustment_status` STRING COMMENT 'Adjustment status',
    `adjustment_type` STRING COMMENT 'Adjustment type',
    `amount` DECIMAL(18,2) COMMENT 'Amount',
    `applied_timestamp` TIMESTAMP COMMENT 'Applied timestamp',
    `approval_required_flag` BOOLEAN COMMENT 'Approval required flag',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'Approval threshold amount',
    `approval_timestamp` TIMESTAMP COMMENT 'Approval timestamp',
    `billing_period_end_date` DATE COMMENT 'Billing period end date',
    `billing_period_start_date` DATE COMMENT 'Billing period start date',
    `charge_category` DECIMAL(18,2) COMMENT 'Charge category',
    `consumption_unit_of_measure` STRING COMMENT 'Consumption unit of measure',
    `consumption_volume_adjusted` DECIMAL(18,2) COMMENT 'Consumption volume adjusted',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Customer notification sent flag',
    `dispute_reference_number` STRING COMMENT 'Dispute reference number',
    `effective_date` DATE COMMENT 'Effective date',
    `external_reference_number` STRING COMMENT 'External reference number',
    `gl_account_code` STRING COMMENT 'GL account code',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp',
    `leak_allowance_flag` BOOLEAN COMMENT 'Leak allowance flag',
    `leak_verification_date` DATE COMMENT 'Leak verification date',
    `notes` STRING COMMENT 'Notes',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Notification sent timestamp',
    `rate_case_reference` DECIMAL(18,2) COMMENT 'Rate case reference',
    `reason_code` STRING COMMENT 'Reason code',
    `reason_description` STRING COMMENT 'Reason description',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Regulatory compliance flag',
    `reversal_flag` BOOLEAN COMMENT 'Reversal flag',
    `reversal_reason` STRING COMMENT 'Reversal reason',
    `service_type` STRING COMMENT 'Service type',
    `tax_exempt_flag` BOOLEAN COMMENT 'Tax exempt flag',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Billing adjustments';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` (
    `payment_plan_id` BIGINT COMMENT 'Primary key',
    `assistance_program_id` BIGINT COMMENT 'FK to assistance program',
    `billing_account_id` BIGINT COMMENT 'FK to billing account',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `payment_employee_id` BIGINT COMMENT 'FK to employee',
    `approved_timestamp` TIMESTAMP COMMENT 'Approved timestamp',
    `broken_date` DATE COMMENT 'Broken date',
    `broken_reason` STRING COMMENT 'Broken reason',
    `cancellation_reason` STRING COMMENT 'Cancellation reason',
    `cancelled_date` DATE COMMENT 'Cancelled date',
    `completed_date` DATE COMMENT 'Completed date',
    `completed_installments` STRING COMMENT 'Completed installments',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `current_balance_amount` DECIMAL(18,2) COMMENT 'Current balance amount',
    `down_payment_amount` DECIMAL(18,2) COMMENT 'Down payment amount',
    `down_payment_received_date` DATE COMMENT 'Down payment received date',
    `enrolled_balance_amount` DECIMAL(18,2) COMMENT 'Enrolled balance amount',
    `grace_period_days` STRING COMMENT 'Grace period days',
    `installment_amount` DECIMAL(18,2) COMMENT 'Installment amount',
    `installment_frequency` STRING COMMENT 'Installment frequency',
    `liheap_eligible` BOOLEAN COMMENT 'LIHEAP eligible',
    `modified_timestamp` TIMESTAMP COMMENT 'Modified timestamp',
    `next_installment_due_date` DATE COMMENT 'Next installment due date',
    `notes` STRING COMMENT 'Notes',
    `plan_end_date` DATE COMMENT 'Plan end date',
    `plan_number` STRING COMMENT 'Plan number',
    `plan_start_date` DATE COMMENT 'Plan start date',
    `plan_status` STRING COMMENT 'Plan status',
    `plan_type` STRING COMMENT 'Plan type',
    `requires_current_charges_paid` DECIMAL(18,2) COMMENT 'Requires current charges paid',
    `total_installments` STRING COMMENT 'Total installments',
    CONSTRAINT pk_payment_plan PRIMARY KEY(`payment_plan_id`)
) COMMENT 'Payment plans for delinquent accounts';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` (
    `billing_assistance_enrollment_id` BIGINT COMMENT 'Primary key for billing_assistance_enrollment',
    `customer_assistance_enrollment_id` BIGINT COMMENT 'Foreign key to the canonical customer_assistance_enrollment record in customer domain',
    `billing_assistance_enrollment_name` STRING COMMENT 'Human readable name.',
    `billing_assistance_enrollment_description` STRING COMMENT 'Free-text description.',
    `billing_assistance_enrollment_code` STRING COMMENT 'Short code identifier.',
    `billing_assistance_enrollment_status` STRING COMMENT 'Current lifecycle status.',
    `status_reason` STRING COMMENT 'Reason for the current status.',
    `billing_assistance_enrollment_category` STRING COMMENT 'Classification category.',
    `subcategory` STRING COMMENT 'Secondary classification.',
    `type_code` STRING COMMENT 'Type classification code.',
    `priority` STRING COMMENT 'Priority level.',
    `quantity` STRING COMMENT 'Quantity value.',
    `amount` STRING COMMENT 'Monetary or numeric amount.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `measured_value` STRING COMMENT 'Measured numeric value.',
    `measured_unit` STRING COMMENT 'Unit of the measured value.',
    `min_value` STRING COMMENT 'Minimum threshold value.',
    `max_value` STRING COMMENT 'Maximum threshold value.',
    `target_value` STRING COMMENT 'Target value.',
    `percent_value` STRING COMMENT 'Percentage value.',
    `latitude` STRING COMMENT 'Geographic latitude.',
    `longitude` STRING COMMENT 'Geographic longitude.',
    `address_line` STRING COMMENT 'Address line text.',
    `region` STRING COMMENT 'Region designation.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `start_timestamp` TIMESTAMP COMMENT 'Start timestamp.',
    `end_timestamp` TIMESTAMP COMMENT 'End timestamp.',
    `recorded_at` TIMESTAMP COMMENT 'When the record was captured.',
    `due_date` DATE COMMENT 'Due date.',
    `completed_date` DATE COMMENT 'Completion date.',
    `is_active` BOOLEAN COMMENT 'Active flag.',
    `is_verified` BOOLEAN COMMENT 'Verification flag.',
    `sequence_number` BIGINT COMMENT 'Ordering sequence number.',
    `version_number` BIGINT COMMENT 'Record version number.',
    `source_system` STRING COMMENT 'Originating source system.',
    `external_reference` STRING COMMENT 'External reference identifier.',
    `notes` STRING COMMENT 'Additional notes.',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp.',
    `updated_at` TIMESTAMP COMMENT 'Last update timestamp.',
    `updated_by` STRING COMMENT 'Last updater identity.',
    `created_by` STRING COMMENT 'Creator identity.',
    CONSTRAINT pk_billing_assistance_enrollment PRIMARY KEY(`billing_assistance_enrollment_id`)
) COMMENT 'Billing assistance enrollment [DEPRECATED: Single source of truth is customer.customer_assistance_enrollment]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`dispute` (
    `dispute_id` BIGINT COMMENT 'Primary key for dispute',
    `dispute_name` STRING COMMENT 'Human readable name.',
    `dispute_description` STRING COMMENT 'Free-text description.',
    `dispute_code` STRING COMMENT 'Short code identifier.',
    `dispute_status` STRING COMMENT 'Current lifecycle status.',
    `status_reason` STRING COMMENT 'Reason for the current status.',
    `dispute_category` STRING COMMENT 'Classification category.',
    `subcategory` STRING COMMENT 'Secondary classification.',
    `type_code` STRING COMMENT 'Type classification code.',
    `priority` STRING COMMENT 'Priority level.',
    `quantity` STRING COMMENT 'Quantity value.',
    `amount` STRING COMMENT 'Monetary or numeric amount.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `measured_value` STRING COMMENT 'Measured numeric value.',
    `measured_unit` STRING COMMENT 'Unit of the measured value.',
    `min_value` STRING COMMENT 'Minimum threshold value.',
    `max_value` STRING COMMENT 'Maximum threshold value.',
    `target_value` STRING COMMENT 'Target value.',
    `percent_value` STRING COMMENT 'Percentage value.',
    `latitude` STRING COMMENT 'Geographic latitude.',
    `longitude` STRING COMMENT 'Geographic longitude.',
    `address_line` STRING COMMENT 'Address line text.',
    `region` STRING COMMENT 'Region designation.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `start_timestamp` TIMESTAMP COMMENT 'Start timestamp.',
    `end_timestamp` TIMESTAMP COMMENT 'End timestamp.',
    `recorded_at` TIMESTAMP COMMENT 'When the record was captured.',
    `due_date` DATE COMMENT 'Due date.',
    `completed_date` DATE COMMENT 'Completion date.',
    `is_active` BOOLEAN COMMENT 'Active flag.',
    `is_verified` BOOLEAN COMMENT 'Verification flag.',
    `sequence_number` BIGINT COMMENT 'Ordering sequence number.',
    `version_number` BIGINT COMMENT 'Record version number.',
    `source_system` STRING COMMENT 'Originating source system.',
    `external_reference` STRING COMMENT 'External reference identifier.',
    `notes` STRING COMMENT 'Additional notes.',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp.',
    `updated_at` TIMESTAMP COMMENT 'Last update timestamp.',
    `updated_by` STRING COMMENT 'Last updater identity.',
    `comments` STRING COMMENT 'Reviewer comments.',
    `created_by` STRING COMMENT 'Creator identity.',
    CONSTRAINT pk_dispute PRIMARY KEY(`dispute_id`)
) COMMENT 'Billing disputes';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` (
    `rate_tier_id` BIGINT COMMENT 'Primary key for rate_tier',
    `billing_rate_schedule_id` DECIMAL(18,2) COMMENT 'Foreign key to billing rate schedule; rate tiers belong to billing rate schedules',
    `rate_tier_name` STRING COMMENT 'Human readable name.',
    `rate_tier_description` STRING COMMENT 'Free-text description.',
    `rate_tier_code` STRING COMMENT 'Short code identifier.',
    `rate_tier_status` STRING COMMENT 'Current lifecycle status.',
    `status_reason` STRING COMMENT 'Reason for the current status.',
    `rate_tier_category` STRING COMMENT 'Classification category.',
    `subcategory` STRING COMMENT 'Secondary classification.',
    `type_code` STRING COMMENT 'Type classification code.',
    `priority` STRING COMMENT 'Priority level.',
    `quantity` STRING COMMENT 'Quantity value.',
    `amount` STRING COMMENT 'Monetary or numeric amount.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `measured_value` STRING COMMENT 'Measured numeric value.',
    `measured_unit` STRING COMMENT 'Unit of the measured value.',
    `min_value` STRING COMMENT 'Minimum threshold value.',
    `max_value` STRING COMMENT 'Maximum threshold value.',
    `target_value` STRING COMMENT 'Target value.',
    `percent_value` STRING COMMENT 'Percentage value.',
    `latitude` STRING COMMENT 'Geographic latitude.',
    `longitude` STRING COMMENT 'Geographic longitude.',
    `address_line` STRING COMMENT 'Address line text.',
    `region` STRING COMMENT 'Region designation.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `start_timestamp` TIMESTAMP COMMENT 'Start timestamp.',
    `end_timestamp` TIMESTAMP COMMENT 'End timestamp.',
    `recorded_at` TIMESTAMP COMMENT 'When the record was captured.',
    `due_date` DATE COMMENT 'Due date.',
    `completed_date` DATE COMMENT 'Completion date.',
    `is_active` BOOLEAN COMMENT 'Active flag.',
    `is_verified` BOOLEAN COMMENT 'Verification flag.',
    `sequence_number` BIGINT COMMENT 'Ordering sequence number.',
    `version_number` BIGINT COMMENT 'Record version number.',
    `source_system` STRING COMMENT 'Originating source system.',
    `external_reference` STRING COMMENT 'External reference identifier.',
    `notes` STRING COMMENT 'Additional notes.',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp.',
    `updated_at` TIMESTAMP COMMENT 'Last update timestamp.',
    `updated_by` STRING COMMENT 'Last updater identity.',
    `created_by` STRING COMMENT 'Creator identity.',
    CONSTRAINT pk_rate_tier PRIMARY KEY(`rate_tier_id`)
) COMMENT 'Rate tiers';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` (
    `billing_cycle_id` BIGINT COMMENT 'Primary key for billing_cycle',
    `billing_cycle_name` STRING COMMENT 'Human readable name.',
    `billing_cycle_description` STRING COMMENT 'Free-text description.',
    `billing_cycle_code` STRING COMMENT 'Short code identifier.',
    `billing_cycle_status` STRING COMMENT 'Current lifecycle status.',
    `status_reason` STRING COMMENT 'Reason for the current status.',
    `billing_cycle_category` STRING COMMENT 'Classification category.',
    `subcategory` STRING COMMENT 'Secondary classification.',
    `type_code` STRING COMMENT 'Type classification code.',
    `priority` STRING COMMENT 'Priority level.',
    `quantity` STRING COMMENT 'Quantity value.',
    `amount` STRING COMMENT 'Monetary or numeric amount.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `measured_value` STRING COMMENT 'Measured numeric value.',
    `measured_unit` STRING COMMENT 'Unit of the measured value.',
    `min_value` STRING COMMENT 'Minimum threshold value.',
    `max_value` STRING COMMENT 'Maximum threshold value.',
    `target_value` STRING COMMENT 'Target value.',
    `percent_value` STRING COMMENT 'Percentage value.',
    `latitude` STRING COMMENT 'Geographic latitude.',
    `longitude` STRING COMMENT 'Geographic longitude.',
    `address_line` STRING COMMENT 'Address line text.',
    `region` STRING COMMENT 'Region designation.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `start_timestamp` TIMESTAMP COMMENT 'Start timestamp.',
    `end_timestamp` TIMESTAMP COMMENT 'End timestamp.',
    `recorded_at` TIMESTAMP COMMENT 'When the record was captured.',
    `due_date` DATE COMMENT 'Due date.',
    `completed_date` DATE COMMENT 'Completion date.',
    `is_active` BOOLEAN COMMENT 'Active flag.',
    `is_verified` BOOLEAN COMMENT 'Verification flag.',
    `sequence_number` BIGINT COMMENT 'Ordering sequence number.',
    `version_number` BIGINT COMMENT 'Record version number.',
    `source_system` STRING COMMENT 'Originating source system.',
    `external_reference` STRING COMMENT 'External reference identifier.',
    `notes` STRING COMMENT 'Additional notes.',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp.',
    `updated_at` TIMESTAMP COMMENT 'Last update timestamp.',
    `updated_by` STRING COMMENT 'Last updater identity.',
    `comments` STRING COMMENT 'Reviewer comments.',
    `created_by` STRING COMMENT 'Creator identity.',
    CONSTRAINT pk_billing_cycle PRIMARY KEY(`billing_cycle_id`)
) COMMENT 'Billing cycles';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_rate_tier_id` FOREIGN KEY (`rate_tier_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`rate_tier`(`rate_tier_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_invoice_id` FOREIGN KEY (`payment_invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_reversed_by_payment_id` FOREIGN KEY (`reversed_by_payment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`dispute`(`dispute_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_payment_dispute_id` FOREIGN KEY (`payment_dispute_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`dispute`(`dispute_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_payment_invoice_line_item_invoice_line_id` FOREIGN KEY (`payment_invoice_line_item_invoice_line_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_superseded_by_rate_schedule_billing_rate_schedule_id` FOREIGN KEY (`superseded_by_rate_schedule_billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_original_adjustment_id` FOREIGN KEY (`original_adjustment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ADD CONSTRAINT `fk_billing_rate_tier_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_water_utilities_v1`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `fund_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `point_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `service_line_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `ccr_included` SET TAGS ('dbx_business_glossary_term' = 'CCR Included');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `conservation_message` SET TAGS ('dbx_business_glossary_term' = 'Conservation Message');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `disconnection_date` SET TAGS ('dbx_business_glossary_term' = 'Disconnection Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `generation_method` SET TAGS ('dbx_business_glossary_term' = 'Generation Method');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `is_final` SET TAGS ('dbx_business_glossary_term' = 'Is Final');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `other_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Charges');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `previous_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Previous Balance');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `print_date` SET TAGS ('dbx_business_glossary_term' = 'Print Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `stormwater_area` SET TAGS ('dbx_business_glossary_term' = 'Stormwater Area');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `stormwater_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Stormwater Charge');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Due');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `wastewater_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Charge');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `wastewater_volume` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Volume');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `water_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Water Charge');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `water_consumption_uom` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption UOM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ALTER COLUMN `water_consumption_volume` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption Volume');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `agreement_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `interval_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Rated Consumption');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `interval_consumption_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `point_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `rate_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `rate_tier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `service_line_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'WTP Facility');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reference');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_determinant` SET TAGS ('dbx_business_glossary_term' = 'Billing Determinant');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `charge_description` SET TAGS ('dbx_business_glossary_term' = 'Charge Description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `charge_type_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `is_disputed` SET TAGS ('dbx_business_glossary_term' = 'Is Disputed');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `is_prorated` SET TAGS ('dbx_business_glossary_term' = 'Is Prorated');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `print_sequence` SET TAGS ('dbx_business_glossary_term' = 'Print Sequence');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `proration_factor` SET TAGS ('dbx_business_glossary_term' = 'Proration Factor');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `revenue_class` SET TAGS ('dbx_business_glossary_term' = 'Revenue Class');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `service_days` SET TAGS ('dbx_business_glossary_term' = 'Service Days');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `total_line_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Line Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'AR Transaction');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Invoice');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_invoice_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_received_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_received_by_user_employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_received_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_received_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `reversed_by_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed By Payment');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `reversed_by_payment_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Last Four');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Cleared Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `is_auto_pay` SET TAGS ('dbx_business_glossary_term' = 'Is Auto Pay');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `lockbox_number` SET TAGS ('dbx_business_glossary_term' = 'Lockbox Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `nsf_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'NSF Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `nsf_indicator` SET TAGS ('dbx_business_glossary_term' = 'NSF Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `processor_name` SET TAGS ('dbx_business_glossary_term' = 'Processor Name');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Application ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_application_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `invoice_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Applied By');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `dispute_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_dispute_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_invoice_line_item_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Item');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_invoice_line_item_invoice_line_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `adjustment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `application_sequence` SET TAGS ('dbx_business_glossary_term' = 'Application Sequence');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `application_source` SET TAGS ('dbx_business_glossary_term' = 'Application Source');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `application_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `ar_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'AR Reconciliation Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `balance_bucket_code` SET TAGS ('dbx_business_glossary_term' = 'Balance Bucket');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `dispute_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dispute Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `is_overpayment` SET TAGS ('dbx_business_glossary_term' = 'Is Overpayment');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `is_prepayment` SET TAGS ('dbx_business_glossary_term' = 'Is Prepayment');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `overpayment_handling` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Handling');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` SET TAGS ('dbx_deprecated' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` SET TAGS ('dbx_ssot_reference' = 'customer.customer_account');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `agreement_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'WTP Facility');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `aging_30_days` SET TAGS ('dbx_business_glossary_term' = 'Aging 30 Days');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `aging_60_days` SET TAGS ('dbx_business_glossary_term' = 'Aging 60 Days');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `aging_90_days` SET TAGS ('dbx_business_glossary_term' = 'Aging 90 Days');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `aging_current` SET TAGS ('dbx_business_glossary_term' = 'Aging Current');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `aging_over_90_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Over 90 Days');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `autopay_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Autopay Enrolled');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `autopay_method` SET TAGS ('dbx_business_glossary_term' = 'Autopay Method');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `balance_forward` SET TAGS ('dbx_business_glossary_term' = 'Balance Forward');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `billing_ssot_customer_account_ref_id` SET TAGS ('dbx_business_glossary_term' = 'Reference to single source of truth in customer.customer_account');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `billing_ssot_customer_account_ref_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `billing_ssot_customer_account_ref_id` SET TAGS ('dbx_ssot_mvm_resolved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `budget_billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `budget_billing_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Enrolled');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `current_charges` SET TAGS ('dbx_business_glossary_term' = 'Current Charges');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `deposit_on_file` SET TAGS ('dbx_business_glossary_term' = 'Deposit On File');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `disconnection_date` SET TAGS ('dbx_business_glossary_term' = 'Disconnection Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `final_bill_issued` SET TAGS ('dbx_business_glossary_term' = 'Final Bill Issued');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `last_bill_date` SET TAGS ('dbx_business_glossary_term' = 'Last Bill Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `late_fee_assessed` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Assessed');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `next_bill_date` SET TAGS ('dbx_business_glossary_term' = 'Next Bill Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Opened Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `paperless_billing` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `past_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Past Due Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `payment_plan_active` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Active');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `payment_plan_balance` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Balance');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `reconnection_fee` SET TAGS ('dbx_business_glossary_term' = 'Reconnection Fee');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ALTER COLUMN `tax_exempt_certificate` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Certificate');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` SET TAGS ('dbx_subdomain' = 'tariff_structure');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` SET TAGS ('dbx_deprecated' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` SET TAGS ('dbx_ssot_reference' = 'service.service_rate_schedule');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Schedule ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Rate Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `service_rate_schedule_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_ssot_service_rate_schedule_ref_id` SET TAGS ('dbx_business_glossary_term' = 'Reference to single source of truth in service.service_rate_schedule');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_ssot_service_rate_schedule_ref_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_ssot_service_rate_schedule_ref_id` SET TAGS ('dbx_ssot_mvm_resolved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `finance_rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Rate Case');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `finance_rate_case_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `offering_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `superseded_by_rate_schedule_billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `superseded_by_rate_schedule_billing_rate_schedule_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `base_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_rate_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `conservation_rate_indicator` SET TAGS ('dbx_business_glossary_term' = 'Conservation Rate Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `consumption_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Consumption UOM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_rate_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `drought_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Drought Surcharge Applicable');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `maximum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `meter_size_applicability` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Applicability');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `rate_schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `seasonal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` SET TAGS ('dbx_subdomain' = 'tariff_structure');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Component ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `rate_component_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `bill_print_label` SET TAGS ('dbx_business_glossary_term' = 'Bill Print Label');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `calculation_formula` SET TAGS ('dbx_business_glossary_term' = 'Calculation Formula');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `component_code` SET TAGS ('dbx_business_glossary_term' = 'Component Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `component_name` SET TAGS ('dbx_business_glossary_term' = 'Component Name');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `conservation_tier_flag` SET TAGS ('dbx_business_glossary_term' = 'Conservation Tier Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `rate_component_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `flat_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `is_prorated` SET TAGS ('dbx_business_glossary_term' = 'Is Prorated');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `is_volumetric` SET TAGS ('dbx_business_glossary_term' = 'Is Volumetric');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `meter_size_applicability` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Applicability');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `percentage_rate` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rate');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `print_on_bill_flag` SET TAGS ('dbx_business_glossary_term' = 'Print On Bill Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `rate_case_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `rate_component_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `revenue_class` SET TAGS ('dbx_business_glossary_term' = 'Revenue Class');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `seasonal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `tier_high_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier High Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `tier_low_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier Low Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_initiated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By User');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_initiated_by_user_employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_initiated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_initiated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `main_break_id` SET TAGS ('dbx_business_glossary_term' = 'Main Break');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `main_break_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `network_isolation_event_id` SET TAGS ('dbx_business_glossary_term' = 'Network Isolation Event');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `network_isolation_event_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `original_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Adjustment');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `original_adjustment_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `primary_adjustment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Employee');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `primary_adjustment_employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `primary_adjustment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `primary_adjustment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `registry_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `service_line_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `test_result_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Applied Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `consumption_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Consumption UOM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `consumption_volume_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Consumption Volume Adjusted');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `dispute_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reference');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `leak_allowance_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Allowance');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `leak_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Leak Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `rate_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Reference');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` SET TAGS ('dbx_subdomain' = 'collections_management');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan ID');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `assistance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Assistance Program');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `assistance_program_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `broken_date` SET TAGS ('dbx_business_glossary_term' = 'Broken Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `broken_reason` SET TAGS ('dbx_business_glossary_term' = 'Broken Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `cancelled_date` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Completed Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `completed_installments` SET TAGS ('dbx_business_glossary_term' = 'Completed Installments');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `current_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `down_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Down Payment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `down_payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Down Payment Received Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `enrolled_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Balance');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `installment_amount` SET TAGS ('dbx_business_glossary_term' = 'Installment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Installment Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `liheap_eligible` SET TAGS ('dbx_business_glossary_term' = 'LIHEAP Eligible');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `next_installment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Installment Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan End Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Number');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `requires_current_charges_paid` SET TAGS ('dbx_business_glossary_term' = 'Requires Current Charges Paid');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ALTER COLUMN `total_installments` SET TAGS ('dbx_business_glossary_term' = 'Total Installments');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` SET TAGS ('dbx_subdomain' = 'collections_management');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` SET TAGS ('dbx_deprecated' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` SET TAGS ('dbx_ssot_reference' = 'customer.customer_assistance_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_assistance_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'billing_assistance_enrollment Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `customer_assistance_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Reference to single source of truth in customer.customer_assistance_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `customer_assistance_enrollment_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_assistance_enrollment_name` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_assistance_enrollment_name` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_assistance_enrollment_description` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_assistance_enrollment_description` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_assistance_enrollment_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_assistance_enrollment_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_assistance_enrollment_status` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_assistance_enrollment_status` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `status_reason` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `status_reason` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_assistance_enrollment_category` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `billing_assistance_enrollment_category` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `subcategory` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `subcategory` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `type_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `type_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `priority` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `priority` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `quantity` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `quantity` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `amount` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `amount` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `measured_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `measured_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `measured_unit` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `measured_unit` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `min_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `min_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `max_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `max_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `target_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `target_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `percent_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `percent_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `latitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `latitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `longitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `longitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `address_line` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `address_line` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `region` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `region` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `recorded_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `recorded_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `due_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `due_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `completed_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `completed_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `is_active` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `is_active` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `is_verified` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `is_verified` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `sequence_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `sequence_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `version_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `version_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `source_system` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `source_system` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `external_reference` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `external_reference` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `created_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `created_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `updated_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `updated_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `updated_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `updated_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `created_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ALTER COLUMN `created_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'dispute Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_name` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_name` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_description` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_description` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `status_reason` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `status_reason` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_category` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `dispute_category` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `subcategory` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `subcategory` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `type_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `type_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `quantity` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `quantity` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `amount` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `amount` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `measured_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `measured_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `measured_unit` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `measured_unit` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `min_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `min_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `max_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `max_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `target_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `target_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `percent_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `percent_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `latitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `latitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `longitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `longitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `address_line` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `address_line` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `region` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `region` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `effective_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `effective_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `expiration_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `expiration_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `recorded_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `recorded_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `due_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `due_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `completed_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `completed_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `is_active` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `is_active` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `is_verified` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `is_verified` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `sequence_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `sequence_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `version_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `version_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `source_system` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `source_system` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `external_reference` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `external_reference` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `notes` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `notes` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `created_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `created_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `updated_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `updated_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `updated_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `updated_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `comments` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `comments` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `created_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ALTER COLUMN `created_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` SET TAGS ('dbx_subdomain' = 'tariff_structure');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `rate_tier_id` SET TAGS ('dbx_business_glossary_term' = 'rate_tier Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `rate_tier_name` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `rate_tier_name` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `rate_tier_description` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `rate_tier_description` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `rate_tier_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `rate_tier_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `rate_tier_status` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `rate_tier_status` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `status_reason` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `status_reason` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `rate_tier_category` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `rate_tier_category` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `subcategory` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `subcategory` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `type_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `type_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `priority` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `priority` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `quantity` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `quantity` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `amount` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `amount` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `measured_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `measured_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `measured_unit` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `measured_unit` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `min_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `min_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `max_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `max_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `target_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `target_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `percent_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `percent_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `latitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `latitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `longitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `longitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `address_line` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `address_line` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `region` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `region` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `effective_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `effective_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `expiration_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `expiration_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `recorded_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `recorded_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `due_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `due_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `completed_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `completed_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `is_active` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `is_active` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `is_verified` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `is_verified` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `sequence_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `sequence_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `version_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `version_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `source_system` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `source_system` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `external_reference` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `external_reference` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `notes` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `notes` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `created_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `created_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `updated_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `updated_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `updated_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `updated_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `created_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_tier` ALTER COLUMN `created_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` SET TAGS ('dbx_subdomain' = 'tariff_structure');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'billing_cycle Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_name` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_name` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_description` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_description` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_status` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_status` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `status_reason` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `status_reason` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_category` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_category` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `subcategory` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `subcategory` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `type_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `type_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `priority` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `priority` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `quantity` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `quantity` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `amount` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `amount` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `measured_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `measured_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `measured_unit` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `measured_unit` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `min_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `min_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `max_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `max_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `target_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `target_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `percent_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `percent_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `latitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `latitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `longitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `longitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `address_line` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `address_line` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `region` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `region` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `effective_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `effective_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `expiration_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `expiration_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `recorded_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `recorded_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `due_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `due_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `completed_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `completed_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `is_active` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `is_active` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `is_verified` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `is_verified` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `sequence_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `sequence_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `version_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `version_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `source_system` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `source_system` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `external_reference` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `external_reference` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `notes` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `notes` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `created_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `created_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `updated_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `updated_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `updated_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `updated_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `comments` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `comments` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `created_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_cycle` ALTER COLUMN `created_by` SET TAGS ('dbx_from' = 'description');
