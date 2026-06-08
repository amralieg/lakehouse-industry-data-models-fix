-- Cross-Domain Foreign Keys for Business: Staffing Hr | Version: v1_ecm
-- Generated on: 2026-05-02 15:53:32
-- Total cross-domain FK constraints: 1387
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: billing, candidate, client, compliance, contract, credentialing, employee, finance, joborder, onboarding, payroll, placement, recruitment, shared, timesheet, vendor

-- ========= billing --> candidate (4 constraint(s)) =========
-- Requires: billing schema, candidate schema
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`assessment`(`assessment_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);

-- ========= billing --> client (22 constraint(s)) =========
-- Requires: billing schema, client schema
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ADD CONSTRAINT `fk_billing_collection_activity_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ADD CONSTRAINT `fk_billing_collection_activity_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ADD CONSTRAINT `fk_billing_sow_billing_milestone_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);

-- ========= billing --> compliance (7 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`worker_classification`(`worker_classification_id`);

-- ========= billing --> contract (18 constraint(s)) =========
-- Requires: billing schema, contract schema
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ADD CONSTRAINT `fk_billing_sow_billing_milestone_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);

-- ========= billing --> credentialing (4 constraint(s)) =========
-- Requires: billing schema, credentialing schema
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_drug_screen_id` FOREIGN KEY (`drug_screen_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`drug_screen`(`drug_screen_id`);

-- ========= billing --> employee (11 constraint(s)) =========
-- Requires: billing schema, employee schema
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_approved_by_user_staff_profile_id` FOREIGN KEY (`approved_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ADD CONSTRAINT `fk_billing_collection_activity_created_by_user_staff_profile_id` FOREIGN KEY (`created_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ADD CONSTRAINT `fk_billing_collection_activity_modified_by_user_staff_profile_id` FOREIGN KEY (`modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ADD CONSTRAINT `fk_billing_collection_activity_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_tertiary_spread_approved_by_user_staff_profile_id` FOREIGN KEY (`tertiary_spread_approved_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);

-- ========= billing --> finance (39 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `staffing_hr_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ADD CONSTRAINT `fk_billing_collection_activity_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ADD CONSTRAINT `fk_billing_collection_activity_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ADD CONSTRAINT `fk_billing_sow_billing_milestone_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ADD CONSTRAINT `fk_billing_sow_billing_milestone_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= billing --> joborder (10 constraint(s)) =========
-- Requires: billing schema, joborder schema
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);

-- ========= billing --> onboarding (3 constraint(s)) =========
-- Requires: billing schema, onboarding schema
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);

-- ========= billing --> payroll (3 constraint(s)) =========
-- Requires: billing schema, payroll schema
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_pay_run_id` FOREIGN KEY (`pay_run_id`) REFERENCES `staffing_hr_ecm`.`payroll`.`pay_run`(`pay_run_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_pay_rate_id` FOREIGN KEY (`pay_rate_id`) REFERENCES `staffing_hr_ecm`.`payroll`.`pay_rate`(`pay_rate_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_pay_rate_id` FOREIGN KEY (`pay_rate_id`) REFERENCES `staffing_hr_ecm`.`payroll`.`pay_rate`(`pay_rate_id`);

-- ========= billing --> placement (25 constraint(s)) =========
-- Requires: billing schema, placement schema
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `staffing_hr_ecm`.`placement`.`rate`(`rate_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_conversion_id` FOREIGN KEY (`conversion_id`) REFERENCES `staffing_hr_ecm`.`placement`.`conversion`(`conversion_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_conversion_id` FOREIGN KEY (`conversion_id`) REFERENCES `staffing_hr_ecm`.`placement`.`conversion`(`conversion_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_conversion_id` FOREIGN KEY (`conversion_id`) REFERENCES `staffing_hr_ecm`.`placement`.`conversion`(`conversion_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ADD CONSTRAINT `fk_billing_sow_billing_milestone_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_conversion_id` FOREIGN KEY (`conversion_id`) REFERENCES `staffing_hr_ecm`.`placement`.`conversion`(`conversion_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);

-- ========= billing --> recruitment (6 constraint(s)) =========
-- Requires: billing schema, recruitment schema
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_sourcing_campaign_id` FOREIGN KEY (`sourcing_campaign_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`sourcing_campaign`(`sourcing_campaign_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_req_pipeline_id` FOREIGN KEY (`req_pipeline_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`req_pipeline`(`req_pipeline_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_recruitment_sla_target_id` FOREIGN KEY (`recruitment_sla_target_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`recruitment_sla_target`(`recruitment_sla_target_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_sla_breach_id` FOREIGN KEY (`sla_breach_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`sla_breach`(`sla_breach_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_hiring_decision_id` FOREIGN KEY (`hiring_decision_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`hiring_decision`(`hiring_decision_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_recruiter_assignment_id` FOREIGN KEY (`recruiter_assignment_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`recruiter_assignment`(`recruiter_assignment_id`);

-- ========= billing --> timesheet (6 constraint(s)) =========
-- Requires: billing schema, timesheet schema
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `staffing_hr_ecm`.`timesheet`.`timesheet`(`timesheet_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `staffing_hr_ecm`.`timesheet`.`timesheet`(`timesheet_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_timesheet_dispute_id` FOREIGN KEY (`timesheet_dispute_id`) REFERENCES `staffing_hr_ecm`.`timesheet`.`timesheet_dispute`(`timesheet_dispute_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `staffing_hr_ecm`.`timesheet`.`timesheet`(`timesheet_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `staffing_hr_ecm`.`timesheet`.`timesheet`(`timesheet_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_per_diem_claim_id` FOREIGN KEY (`per_diem_claim_id`) REFERENCES `staffing_hr_ecm`.`timesheet`.`per_diem_claim`(`per_diem_claim_id`);

-- ========= billing --> vendor (9 constraint(s)) =========
-- Requires: billing schema, vendor schema
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ADD CONSTRAINT `fk_billing_sow_billing_milestone_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= candidate --> client (13 constraint(s)) =========
-- Requires: candidate schema, client schema
ALTER TABLE `staffing_hr_ecm`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`interaction` ADD CONSTRAINT `fk_candidate_interaction_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`interaction` ADD CONSTRAINT `fk_candidate_interaction_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`talent_pool_membership` ADD CONSTRAINT `fk_candidate_talent_pool_membership_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`talent_pool_membership` ADD CONSTRAINT `fk_candidate_talent_pool_membership_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`talent_pool_membership` ADD CONSTRAINT `fk_candidate_talent_pool_membership_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`talent_pool` ADD CONSTRAINT `fk_candidate_talent_pool_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);

-- ========= candidate --> compliance (4 constraint(s)) =========
-- Requires: candidate schema, compliance schema
ALTER TABLE `staffing_hr_ecm`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`diversity_profile` ADD CONSTRAINT `fk_candidate_diversity_profile_privacy_request_id` FOREIGN KEY (`privacy_request_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`privacy_request`(`privacy_request_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`candidate_compliance` ADD CONSTRAINT `fk_candidate_candidate_compliance_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`audit_sample` ADD CONSTRAINT `fk_candidate_audit_sample_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`audit`(`audit_id`);

-- ========= candidate --> credentialing (1 constraint(s)) =========
-- Requires: candidate schema, credentialing schema
ALTER TABLE `staffing_hr_ecm`.`candidate`.`skill` ADD CONSTRAINT `fk_candidate_skill_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);

-- ========= candidate --> employee (10 constraint(s)) =========
-- Requires: candidate schema, employee schema
ALTER TABLE `staffing_hr_ecm`.`candidate`.`profile` ADD CONSTRAINT `fk_candidate_profile_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_office_location_id` FOREIGN KEY (`office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`interaction` ADD CONSTRAINT `fk_candidate_interaction_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`assessment` ADD CONSTRAINT `fk_candidate_assessment_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`talent_pool_membership` ADD CONSTRAINT `fk_candidate_talent_pool_membership_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`talent_pool` ADD CONSTRAINT `fk_candidate_talent_pool_team_id` FOREIGN KEY (`team_id`) REFERENCES `staffing_hr_ecm`.`employee`.`team`(`team_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`talent_pool` ADD CONSTRAINT `fk_candidate_talent_pool_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);

-- ========= candidate --> joborder (5 constraint(s)) =========
-- Requires: candidate schema, joborder schema
ALTER TABLE `staffing_hr_ecm`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`interaction` ADD CONSTRAINT `fk_candidate_interaction_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`assessment` ADD CONSTRAINT `fk_candidate_assessment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);

-- ========= candidate --> payroll (1 constraint(s)) =========
-- Requires: candidate schema, payroll schema
ALTER TABLE `staffing_hr_ecm`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_pay_rate_id` FOREIGN KEY (`pay_rate_id`) REFERENCES `staffing_hr_ecm`.`payroll`.`pay_rate`(`pay_rate_id`);

-- ========= candidate --> placement (4 constraint(s)) =========
-- Requires: candidate schema, placement schema
ALTER TABLE `staffing_hr_ecm`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`interaction` ADD CONSTRAINT `fk_candidate_interaction_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`candidate`.`talent_pool_membership` ADD CONSTRAINT `fk_candidate_talent_pool_membership_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);

-- ========= candidate --> recruitment (1 constraint(s)) =========
-- Requires: candidate schema, recruitment schema
ALTER TABLE `staffing_hr_ecm`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`submittal`(`submittal_id`);

-- ========= candidate --> vendor (1 constraint(s)) =========
-- Requires: candidate schema, vendor schema
ALTER TABLE `staffing_hr_ecm`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= client --> compliance (2 constraint(s)) =========
-- Requires: client schema, compliance schema
ALTER TABLE `staffing_hr_ecm`.`client`.`program_compliance_requirement` ADD CONSTRAINT `fk_client_program_compliance_requirement_compliance_requirement_id` FOREIGN KEY (`compliance_requirement_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`program_compliance_requirement` ADD CONSTRAINT `fk_client_program_compliance_requirement_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`requirement`(`requirement_id`);

-- ========= client --> contract (7 constraint(s)) =========
-- Requires: client schema, contract schema
ALTER TABLE `staffing_hr_ecm`.`client`.`account_hierarchy` ADD CONSTRAINT `fk_client_account_hierarchy_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`client_rate_card` ADD CONSTRAINT `fk_client_client_rate_card_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`client_rate_card` ADD CONSTRAINT `fk_client_client_rate_card_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`vms_program` ADD CONSTRAINT `fk_client_vms_program_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`sla_measurement` ADD CONSTRAINT `fk_client_sla_measurement_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`managed_program` ADD CONSTRAINT `fk_client_managed_program_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`managed_program` ADD CONSTRAINT `fk_client_managed_program_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);

-- ========= client --> credentialing (1 constraint(s)) =========
-- Requires: client schema, credentialing schema
ALTER TABLE `staffing_hr_ecm`.`client`.`program_credential_requirement` ADD CONSTRAINT `fk_client_program_credential_requirement_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential`(`credential_id`);

-- ========= client --> employee (15 constraint(s)) =========
-- Requires: client schema, employee schema
ALTER TABLE `staffing_hr_ecm`.`client`.`client_account` ADD CONSTRAINT `fk_client_client_account_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`client_account` ADD CONSTRAINT `fk_client_client_account_client_staff_profile_id` FOREIGN KEY (`client_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`client_contact` ADD CONSTRAINT `fk_client_client_contact_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`account_hierarchy` ADD CONSTRAINT `fk_client_account_hierarchy_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`account_hierarchy` ADD CONSTRAINT `fk_client_account_hierarchy_territory_assignment_id` FOREIGN KEY (`territory_assignment_id`) REFERENCES `staffing_hr_ecm`.`employee`.`territory_assignment`(`territory_assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`vms_program` ADD CONSTRAINT `fk_client_vms_program_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`client_engagement` ADD CONSTRAINT `fk_client_client_engagement_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`nps_response` ADD CONSTRAINT `fk_client_nps_response_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`nps_response` ADD CONSTRAINT `fk_client_nps_response_survey_id` FOREIGN KEY (`survey_id`) REFERENCES `staffing_hr_ecm`.`employee`.`survey`(`survey_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`account_segment` ADD CONSTRAINT `fk_client_account_segment_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`sla_measurement` ADD CONSTRAINT `fk_client_sla_measurement_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`credit_profile` ADD CONSTRAINT `fk_client_credit_profile_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`managed_program` ADD CONSTRAINT `fk_client_managed_program_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`territory` ADD CONSTRAINT `fk_client_territory_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`opportunity` ADD CONSTRAINT `fk_client_opportunity_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);

-- ========= client --> finance (6 constraint(s)) =========
-- Requires: client schema, finance schema
ALTER TABLE `staffing_hr_ecm`.`client`.`client_account` ADD CONSTRAINT `fk_client_client_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`location` ADD CONSTRAINT `fk_client_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`location` ADD CONSTRAINT `fk_client_location_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`vms_program` ADD CONSTRAINT `fk_client_vms_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`managed_program` ADD CONSTRAINT `fk_client_managed_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`location_budget_allocation` ADD CONSTRAINT `fk_client_location_budget_allocation_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `staffing_hr_ecm`.`finance`.`budget`(`budget_id`);

-- ========= client --> joborder (2 constraint(s)) =========
-- Requires: client schema, joborder schema
ALTER TABLE `staffing_hr_ecm`.`client`.`client_engagement` ADD CONSTRAINT `fk_client_client_engagement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`rate_card_line` ADD CONSTRAINT `fk_client_rate_card_line_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`job_category`(`job_category_id`);

-- ========= client --> placement (2 constraint(s)) =========
-- Requires: client schema, placement schema
ALTER TABLE `staffing_hr_ecm`.`client`.`client_engagement` ADD CONSTRAINT `fk_client_client_engagement_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`nps_response` ADD CONSTRAINT `fk_client_nps_response_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);

-- ========= client --> recruitment (1 constraint(s)) =========
-- Requires: client schema, recruitment schema
ALTER TABLE `staffing_hr_ecm`.`client`.`client_engagement` ADD CONSTRAINT `fk_client_client_engagement_sourcing_campaign_id` FOREIGN KEY (`sourcing_campaign_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`sourcing_campaign`(`sourcing_campaign_id`);

-- ========= client --> vendor (4 constraint(s)) =========
-- Requires: client schema, vendor schema
ALTER TABLE `staffing_hr_ecm`.`client`.`client_engagement` ADD CONSTRAINT `fk_client_client_engagement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`nps_response` ADD CONSTRAINT `fk_client_nps_response_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`program_supplier` ADD CONSTRAINT `fk_client_program_supplier_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`client`.`sla_measurement` ADD CONSTRAINT `fk_client_sla_measurement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= compliance --> candidate (7 constraint(s)) =========
-- Requires: compliance schema, candidate schema
ALTER TABLE `staffing_hr_ecm`.`compliance`.`i9_verification` ADD CONSTRAINT `fk_compliance_i9_verification_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);

-- ========= compliance --> client (16 constraint(s)) =========
-- Requires: compliance schema, client schema
ALTER TABLE `staffing_hr_ecm`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`ofccp_compliance` ADD CONSTRAINT `fk_compliance_ofccp_compliance_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`coe_risk_assessment` ADD CONSTRAINT `fk_compliance_coe_risk_assessment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);

-- ========= compliance --> contract (26 constraint(s)) =========
-- Requires: compliance schema, contract schema
ALTER TABLE `staffing_hr_ecm`.`compliance`.`i9_verification` ADD CONSTRAINT `fk_compliance_i9_verification_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`i9_verification` ADD CONSTRAINT `fk_compliance_i9_verification_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`eeoc_filing` ADD CONSTRAINT `fk_compliance_eeoc_filing_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`ofccp_compliance` ADD CONSTRAINT `fk_compliance_ofccp_compliance_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`coe_risk_assessment` ADD CONSTRAINT `fk_compliance_coe_risk_assessment_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`coe_risk_assessment` ADD CONSTRAINT `fk_compliance_coe_risk_assessment_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`coe_risk_assessment` ADD CONSTRAINT `fk_compliance_coe_risk_assessment_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`workers_comp_policy` ADD CONSTRAINT `fk_compliance_workers_comp_policy_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);

-- ========= compliance --> credentialing (9 constraint(s)) =========
-- Requires: compliance schema, credentialing schema
ALTER TABLE `staffing_hr_ecm`.`compliance`.`i9_verification` ADD CONSTRAINT `fk_compliance_i9_verification_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`coe_risk_assessment` ADD CONSTRAINT `fk_compliance_coe_risk_assessment_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential`(`credential_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_drug_screen_id` FOREIGN KEY (`drug_screen_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`drug_screen`(`drug_screen_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`state_credential_requirement` ADD CONSTRAINT `fk_compliance_state_credential_requirement_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential`(`credential_id`);

-- ========= compliance --> employee (18 constraint(s)) =========
-- Requires: compliance schema, employee schema
ALTER TABLE `staffing_hr_ecm`.`compliance`.`i9_verification` ADD CONSTRAINT `fk_compliance_i9_verification_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_office_location_id` FOREIGN KEY (`office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`eeoc_filing` ADD CONSTRAINT `fk_compliance_eeoc_filing_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`ofccp_compliance` ADD CONSTRAINT `fk_compliance_ofccp_compliance_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`coe_risk_assessment` ADD CONSTRAINT `fk_compliance_coe_risk_assessment_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`onboarding_compliance_checkpoint` ADD CONSTRAINT `fk_compliance_onboarding_compliance_checkpoint_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`checklist_compliance_rule` ADD CONSTRAINT `fk_compliance_checklist_compliance_rule_last_modified_by_user_staff_profile_id` FOREIGN KEY (`last_modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`checklist_compliance_rule` ADD CONSTRAINT `fk_compliance_checklist_compliance_rule_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`staff_compliance_certification` ADD CONSTRAINT `fk_compliance_staff_compliance_certification_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`staff_compliance_certification` ADD CONSTRAINT `fk_compliance_staff_compliance_certification_verified_by_staff_staff_profile_id` FOREIGN KEY (`verified_by_staff_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);

-- ========= compliance --> finance (6 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `staffing_hr_ecm`.`compliance`.`eeoc_filing` ADD CONSTRAINT `fk_compliance_eeoc_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`workers_comp_policy` ADD CONSTRAINT `fk_compliance_workers_comp_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`workers_comp_policy` ADD CONSTRAINT `fk_compliance_workers_comp_policy_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`establishment` ADD CONSTRAINT `fk_compliance_establishment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= compliance --> joborder (4 constraint(s)) =========
-- Requires: compliance schema, joborder schema
ALTER TABLE `staffing_hr_ecm`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`coe_risk_assessment` ADD CONSTRAINT `fk_compliance_coe_risk_assessment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);

-- ========= compliance --> onboarding (8 constraint(s)) =========
-- Requires: compliance schema, onboarding schema
ALTER TABLE `staffing_hr_ecm`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_offboarding_record_id` FOREIGN KEY (`offboarding_record_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`offboarding_record`(`offboarding_record_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`coe_risk_assessment` ADD CONSTRAINT `fk_compliance_coe_risk_assessment_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_task_checklist_id` FOREIGN KEY (`task_checklist_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`task_checklist`(`task_checklist_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`onboarding_compliance_checkpoint` ADD CONSTRAINT `fk_compliance_onboarding_compliance_checkpoint_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`checklist_compliance_rule` ADD CONSTRAINT `fk_compliance_checklist_compliance_rule_task_checklist_id` FOREIGN KEY (`task_checklist_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`task_checklist`(`task_checklist_id`);

-- ========= compliance --> placement (8 constraint(s)) =========
-- Requires: compliance schema, placement schema
ALTER TABLE `staffing_hr_ecm`.`compliance`.`i9_verification` ADD CONSTRAINT `fk_compliance_i9_verification_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`coe_risk_assessment` ADD CONSTRAINT `fk_compliance_coe_risk_assessment_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);

-- ========= compliance --> vendor (10 constraint(s)) =========
-- Requires: compliance schema, vendor schema
ALTER TABLE `staffing_hr_ecm`.`compliance`.`i9_verification` ADD CONSTRAINT `fk_compliance_i9_verification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`ofccp_compliance` ADD CONSTRAINT `fk_compliance_ofccp_compliance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`coe_risk_assessment` ADD CONSTRAINT `fk_compliance_coe_risk_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`compliance`.`workers_comp_policy` ADD CONSTRAINT `fk_compliance_workers_comp_policy_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= contract --> candidate (3 constraint(s)) =========
-- Requires: contract schema, candidate schema
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ADD CONSTRAINT `fk_contract_nda_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ADD CONSTRAINT `fk_contract_non_compete_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ADD CONSTRAINT `fk_contract_ic_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);

-- ========= contract --> client (22 constraint(s)) =========
-- Requires: contract schema, client schema
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ADD CONSTRAINT `fk_contract_msa_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ADD CONSTRAINT `fk_contract_nda_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ADD CONSTRAINT `fk_contract_non_compete_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ADD CONSTRAINT `fk_contract_non_compete_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ADD CONSTRAINT `fk_contract_sla_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ADD CONSTRAINT `fk_contract_contract_rate_schedule_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ADD CONSTRAINT `fk_contract_contract_rate_schedule_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ADD CONSTRAINT `fk_contract_contract_rate_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ADD CONSTRAINT `fk_contract_contract_rate_schedule_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ADD CONSTRAINT `fk_contract_vendor_agreement_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ADD CONSTRAINT `fk_contract_vendor_agreement_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ADD CONSTRAINT `fk_contract_ic_agreement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ADD CONSTRAINT `fk_contract_sla_breach_event_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ADD CONSTRAINT `fk_contract_sla_breach_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ADD CONSTRAINT `fk_contract_sla_breach_event_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ADD CONSTRAINT `fk_contract_sla_breach_event_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);

-- ========= contract --> credentialing (2 constraint(s)) =========
-- Requires: contract schema, credentialing schema
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa_credential_requirement` ADD CONSTRAINT `fk_contract_msa_credential_requirement_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential`(`credential_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow_credential_requirement` ADD CONSTRAINT `fk_contract_sow_credential_requirement_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential`(`credential_id`);

-- ========= contract --> employee (21 constraint(s)) =========
-- Requires: contract schema, employee schema
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ADD CONSTRAINT `fk_contract_msa_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ADD CONSTRAINT `fk_contract_sla_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_template_legal_reviewer_user_staff_profile_id` FOREIGN KEY (`template_legal_reviewer_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_template_staff_profile_id` FOREIGN KEY (`template_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ADD CONSTRAINT `fk_contract_vendor_agreement_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ADD CONSTRAINT `fk_contract_ic_agreement_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_document` ADD CONSTRAINT `fk_contract_contract_document_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_quaternary_contract_escalated_to_user_staff_profile_id` FOREIGN KEY (`quaternary_contract_escalated_to_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_quinary_contract_final_approver_user_staff_profile_id` FOREIGN KEY (`quinary_contract_final_approver_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_tertiary_contract_delegated_to_user_staff_profile_id` FOREIGN KEY (`tertiary_contract_delegated_to_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla_breach_event` ADD CONSTRAINT `fk_contract_sla_breach_event_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ADD CONSTRAINT `fk_contract_allocation_last_updated_by_user_staff_profile_id` FOREIGN KEY (`last_updated_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ADD CONSTRAINT `fk_contract_allocation_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ADD CONSTRAINT `fk_contract_vendor_cost_center_allocation_authorized_by_staff_profile_id` FOREIGN KEY (`authorized_by_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ADD CONSTRAINT `fk_contract_vendor_cost_center_allocation_last_modified_by_user_staff_profile_id` FOREIGN KEY (`last_modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ADD CONSTRAINT `fk_contract_vendor_cost_center_allocation_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);

-- ========= contract --> finance (9 constraint(s)) =========
-- Requires: contract schema, finance schema
ALTER TABLE `staffing_hr_ecm`.`contract`.`msa` ADD CONSTRAINT `fk_contract_msa_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`sla` ADD CONSTRAINT `fk_contract_sla_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`contract_rate_schedule` ADD CONSTRAINT `fk_contract_contract_rate_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ADD CONSTRAINT `fk_contract_vendor_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`ic_agreement` ADD CONSTRAINT `fk_contract_ic_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`allocation` ADD CONSTRAINT `fk_contract_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation` ADD CONSTRAINT `fk_contract_vendor_cost_center_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= contract --> placement (1 constraint(s)) =========
-- Requires: contract schema, placement schema
ALTER TABLE `staffing_hr_ecm`.`contract`.`non_compete` ADD CONSTRAINT `fk_contract_non_compete_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);

-- ========= contract --> vendor (2 constraint(s)) =========
-- Requires: contract schema, vendor schema
ALTER TABLE `staffing_hr_ecm`.`contract`.`nda` ADD CONSTRAINT `fk_contract_nda_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`contract`.`vendor_agreement` ADD CONSTRAINT `fk_contract_vendor_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= credentialing --> candidate (15 constraint(s)) =========
-- Requires: credentialing schema, candidate schema
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_instance` ADD CONSTRAINT `fk_credentialing_credential_instance_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`bgc_result` ADD CONSTRAINT `fk_credentialing_bgc_result_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`license_verification` ADD CONSTRAINT `fk_credentialing_license_verification_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`skills_assessment` ADD CONSTRAINT `fk_credentialing_skills_assessment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`training_record` ADD CONSTRAINT `fk_credentialing_training_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`adverse_action` ADD CONSTRAINT `fk_credentialing_adverse_action_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`readiness_status` ADD CONSTRAINT `fk_credentialing_readiness_status_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`work_authorization` ADD CONSTRAINT `fk_credentialing_work_authorization_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_document` ADD CONSTRAINT `fk_credentialing_credential_document_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`education_verification` ADD CONSTRAINT `fk_credentialing_education_verification_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`employment_verification` ADD CONSTRAINT `fk_credentialing_employment_verification_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`employment_verification` ADD CONSTRAINT `fk_credentialing_employment_verification_work_history_id` FOREIGN KEY (`work_history_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`work_history`(`work_history_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`reference_check` ADD CONSTRAINT `fk_credentialing_reference_check_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);

-- ========= credentialing --> client (17 constraint(s)) =========
-- Requires: credentialing schema, client schema
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`license_verification` ADD CONSTRAINT `fk_credentialing_license_verification_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`skills_assessment` ADD CONSTRAINT `fk_credentialing_skills_assessment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`training_record` ADD CONSTRAINT `fk_credentialing_training_record_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`adverse_action` ADD CONSTRAINT `fk_credentialing_adverse_action_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`readiness_status` ADD CONSTRAINT `fk_credentialing_readiness_status_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`work_authorization` ADD CONSTRAINT `fk_credentialing_work_authorization_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_document` ADD CONSTRAINT `fk_credentialing_credential_document_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`education_verification` ADD CONSTRAINT `fk_credentialing_education_verification_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`reference_check` ADD CONSTRAINT `fk_credentialing_reference_check_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);

-- ========= credentialing --> compliance (1 constraint(s)) =========
-- Requires: credentialing schema, compliance schema
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_instance` ADD CONSTRAINT `fk_credentialing_credential_instance_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`requirement`(`requirement_id`);

-- ========= credentialing --> contract (8 constraint(s)) =========
-- Requires: credentialing schema, contract schema
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`readiness_status` ADD CONSTRAINT `fk_credentialing_readiness_status_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_document` ADD CONSTRAINT `fk_credentialing_credential_document_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);

-- ========= credentialing --> employee (6 constraint(s)) =========
-- Requires: credentialing schema, employee schema
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`readiness_status` ADD CONSTRAINT `fk_credentialing_readiness_status_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`package_requirement` ADD CONSTRAINT `fk_credentialing_package_requirement_last_modified_by_user_staff_profile_id` FOREIGN KEY (`last_modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`package_requirement` ADD CONSTRAINT `fk_credentialing_package_requirement_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);

-- ========= credentialing --> finance (15 constraint(s)) =========
-- Requires: credentialing schema, finance schema
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_ap_account_id` FOREIGN KEY (`ap_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`ap_account`(`ap_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`license_verification` ADD CONSTRAINT `fk_credentialing_license_verification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`license_verification` ADD CONSTRAINT `fk_credentialing_license_verification_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`skills_assessment` ADD CONSTRAINT `fk_credentialing_skills_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`skills_assessment` ADD CONSTRAINT `fk_credentialing_skills_assessment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`training_record` ADD CONSTRAINT `fk_credentialing_training_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`training_record` ADD CONSTRAINT `fk_credentialing_training_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`adverse_action` ADD CONSTRAINT `fk_credentialing_adverse_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`adverse_action` ADD CONSTRAINT `fk_credentialing_adverse_action_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= credentialing --> joborder (10 constraint(s)) =========
-- Requires: credentialing schema, joborder schema
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`license_verification` ADD CONSTRAINT `fk_credentialing_license_verification_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`skills_assessment` ADD CONSTRAINT `fk_credentialing_skills_assessment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`adverse_action` ADD CONSTRAINT `fk_credentialing_adverse_action_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`readiness_status` ADD CONSTRAINT `fk_credentialing_readiness_status_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_document` ADD CONSTRAINT `fk_credentialing_credential_document_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`education_verification` ADD CONSTRAINT `fk_credentialing_education_verification_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`reference_check` ADD CONSTRAINT `fk_credentialing_reference_check_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);

-- ========= credentialing --> onboarding (1 constraint(s)) =========
-- Requires: credentialing schema, onboarding schema
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`checklist_credential_requirement` ADD CONSTRAINT `fk_credentialing_checklist_credential_requirement_task_checklist_id` FOREIGN KEY (`task_checklist_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`task_checklist`(`task_checklist_id`);

-- ========= credentialing --> placement (10 constraint(s)) =========
-- Requires: credentialing schema, placement schema
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`bgc_result` ADD CONSTRAINT `fk_credentialing_bgc_result_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`license_verification` ADD CONSTRAINT `fk_credentialing_license_verification_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`training_record` ADD CONSTRAINT `fk_credentialing_training_record_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`adverse_action` ADD CONSTRAINT `fk_credentialing_adverse_action_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`readiness_status` ADD CONSTRAINT `fk_credentialing_readiness_status_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`credential_document` ADD CONSTRAINT `fk_credentialing_credential_document_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`education_verification` ADD CONSTRAINT `fk_credentialing_education_verification_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`reference_check` ADD CONSTRAINT `fk_credentialing_reference_check_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);

-- ========= credentialing --> vendor (8 constraint(s)) =========
-- Requires: credentialing schema, vendor schema
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`license_verification` ADD CONSTRAINT `fk_credentialing_license_verification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`skills_assessment` ADD CONSTRAINT `fk_credentialing_skills_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`training_record` ADD CONSTRAINT `fk_credentialing_training_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`education_verification` ADD CONSTRAINT `fk_credentialing_education_verification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`employment_verification` ADD CONSTRAINT `fk_credentialing_employment_verification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`reference_check` ADD CONSTRAINT `fk_credentialing_reference_check_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`credentialing`.`service` ADD CONSTRAINT `fk_credentialing_service_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= employee --> billing (1 constraint(s)) =========
-- Requires: employee schema, billing schema
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ADD CONSTRAINT `fk_employee_commission_earning_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= employee --> client (4 constraint(s)) =========
-- Requires: employee schema, client schema
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ADD CONSTRAINT `fk_employee_team_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ADD CONSTRAINT `fk_employee_recruiter_desk_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ADD CONSTRAINT `fk_employee_recruiter_desk_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ADD CONSTRAINT `fk_employee_territory_assignment_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);

-- ========= employee --> credentialing (1 constraint(s)) =========
-- Requires: employee schema, credentialing schema
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ADD CONSTRAINT `fk_employee_internal_training_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential`(`credential_id`);

-- ========= employee --> finance (3 constraint(s)) =========
-- Requires: employee schema, finance schema
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ADD CONSTRAINT `fk_employee_team_membership_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ADD CONSTRAINT `fk_employee_role_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`accrual_policy` ADD CONSTRAINT `fk_employee_accrual_policy_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= employee --> joborder (1 constraint(s)) =========
-- Requires: employee schema, joborder schema
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ADD CONSTRAINT `fk_employee_commission_earning_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);

-- ========= employee --> placement (1 constraint(s)) =========
-- Requires: employee schema, placement schema
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ADD CONSTRAINT `fk_employee_commission_earning_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);

-- ========= finance --> billing (12 constraint(s)) =========
-- Requires: finance schema, billing schema
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `staffing_hr_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_credit_memo_id` FOREIGN KEY (`credit_memo_id`) REFERENCES `staffing_hr_ecm`.`billing`.`credit_memo`(`credit_memo_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `staffing_hr_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `staffing_hr_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_credit_memo_id` FOREIGN KEY (`credit_memo_id`) REFERENCES `staffing_hr_ecm`.`billing`.`credit_memo`(`credit_memo_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `staffing_hr_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_credit_memo_id` FOREIGN KEY (`credit_memo_id`) REFERENCES `staffing_hr_ecm`.`billing`.`credit_memo`(`credit_memo_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_credit_memo_id` FOREIGN KEY (`credit_memo_id`) REFERENCES `staffing_hr_ecm`.`billing`.`credit_memo`(`credit_memo_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= finance --> candidate (1 constraint(s)) =========
-- Requires: finance schema, candidate schema
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);

-- ========= finance --> client (19 constraint(s)) =========
-- Requires: finance schema, client schema
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ADD CONSTRAINT `fk_finance_ar_account_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ADD CONSTRAINT `fk_finance_ap_account_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ADD CONSTRAINT `fk_finance_ap_account_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);

-- ========= finance --> contract (12 constraint(s)) =========
-- Requires: finance schema, contract schema
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);

-- ========= finance --> employee (53 constraint(s)) =========
-- Requires: finance schema, employee schema
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_last_modified_by_user_staff_profile_id` FOREIGN KEY (`last_modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_primary_cost_staff_profile_id` FOREIGN KEY (`primary_cost_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_journal_staff_profile_id` FOREIGN KEY (`primary_journal_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_department_id` FOREIGN KEY (`department_id`) REFERENCES `staffing_hr_ecm`.`employee`.`department`(`department_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ADD CONSTRAINT `fk_finance_accounting_period_close_coordinator_staff_profile_id` FOREIGN KEY (`close_coordinator_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ADD CONSTRAINT `fk_finance_accounting_period_created_by_user_staff_profile_id` FOREIGN KEY (`created_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ADD CONSTRAINT `fk_finance_accounting_period_locked_by_user_staff_profile_id` FOREIGN KEY (`locked_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ADD CONSTRAINT `fk_finance_accounting_period_modified_by_user_staff_profile_id` FOREIGN KEY (`modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accounting_period` ADD CONSTRAINT `fk_finance_accounting_period_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_account` ADD CONSTRAINT `fk_finance_ar_account_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ADD CONSTRAINT `fk_finance_ap_account_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_department_id` FOREIGN KEY (`department_id`) REFERENCES `staffing_hr_ecm`.`employee`.`department`(`department_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_administrator_staff_profile_id` FOREIGN KEY (`administrator_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_modified_by_user_staff_profile_id` FOREIGN KEY (`modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_transaction` ADD CONSTRAINT `fk_finance_bank_transaction_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_primary_bank_staff_profile_id` FOREIGN KEY (`primary_bank_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_reviewer_user_staff_profile_id` FOREIGN KEY (`reviewer_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ADD CONSTRAINT `fk_finance_period_close_task_approver_staff_profile_id` FOREIGN KEY (`approver_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ADD CONSTRAINT `fk_finance_period_close_task_created_by_user_staff_profile_id` FOREIGN KEY (`created_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ADD CONSTRAINT `fk_finance_period_close_task_modified_by_user_staff_profile_id` FOREIGN KEY (`modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ADD CONSTRAINT `fk_finance_period_close_task_primary_period_staff_profile_id` FOREIGN KEY (`primary_period_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ADD CONSTRAINT `fk_finance_period_close_task_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`period_close_task` ADD CONSTRAINT `fk_finance_period_close_task_waived_by_user_staff_profile_id` FOREIGN KEY (`waived_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_approver_user_staff_profile_id` FOREIGN KEY (`approver_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`tax_liability` ADD CONSTRAINT `fk_finance_tax_liability_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_department_id` FOREIGN KEY (`department_id`) REFERENCES `staffing_hr_ecm`.`employee`.`department`(`department_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_tertiary_fixed_modified_by_user_staff_profile_id` FOREIGN KEY (`tertiary_fixed_modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_department_id` FOREIGN KEY (`department_id`) REFERENCES `staffing_hr_ecm`.`employee`.`department`(`department_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`depreciation_schedule` ADD CONSTRAINT `fk_finance_depreciation_schedule_tertiary_depreciation_modified_by_user_staff_profile_id` FOREIGN KEY (`tertiary_depreciation_modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_controller_staff_profile_id` FOREIGN KEY (`controller_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_modified_by_user_staff_profile_id` FOREIGN KEY (`modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`budget_allocation` ADD CONSTRAINT `fk_finance_budget_allocation_department_id` FOREIGN KEY (`department_id`) REFERENCES `staffing_hr_ecm`.`employee`.`department`(`department_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_approved_by_staff_profile_id` FOREIGN KEY (`approved_by_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_approved_by_user_staff_profile_id` FOREIGN KEY (`approved_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_department_id` FOREIGN KEY (`department_id`) REFERENCES `staffing_hr_ecm`.`employee`.`department`(`department_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);

-- ========= finance --> placement (12 constraint(s)) =========
-- Requires: finance schema, placement schema
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_conversion_id` FOREIGN KEY (`conversion_id`) REFERENCES `staffing_hr_ecm`.`placement`.`conversion`(`conversion_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_conversion_id` FOREIGN KEY (`conversion_id`) REFERENCES `staffing_hr_ecm`.`placement`.`conversion`(`conversion_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_conversion_id` FOREIGN KEY (`conversion_id`) REFERENCES `staffing_hr_ecm`.`placement`.`conversion`(`conversion_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_placement_assignment_id` FOREIGN KEY (`placement_assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);

-- ========= finance --> timesheet (1 constraint(s)) =========
-- Requires: finance schema, timesheet schema
ALTER TABLE `staffing_hr_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `staffing_hr_ecm`.`timesheet`.`schedule`(`schedule_id`);

-- ========= finance --> vendor (6 constraint(s)) =========
-- Requires: finance schema, vendor schema
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_account` ADD CONSTRAINT `fk_finance_ap_account_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= joborder --> candidate (1 constraint(s)) =========
-- Requires: joborder schema, candidate schema
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ADD CONSTRAINT `fk_joborder_order_status_history_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);

-- ========= joborder --> client (19 constraint(s)) =========
-- Requires: joborder schema, client schema
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ADD CONSTRAINT `fk_joborder_sla_commitment_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ADD CONSTRAINT `fk_joborder_order_location_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ADD CONSTRAINT `fk_joborder_demand_forecast_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ADD CONSTRAINT `fk_joborder_demand_forecast_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ADD CONSTRAINT `fk_joborder_capacity_plan_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ADD CONSTRAINT `fk_joborder_capacity_plan_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ADD CONSTRAINT `fk_joborder_fte_actuals_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ADD CONSTRAINT `fk_joborder_fte_actuals_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ADD CONSTRAINT `fk_joborder_fte_actuals_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ADD CONSTRAINT `fk_joborder_fte_actuals_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);

-- ========= joborder --> contract (7 constraint(s)) =========
-- Requires: joborder schema, contract schema
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ADD CONSTRAINT `fk_joborder_rate_override_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ADD CONSTRAINT `fk_joborder_sla_commitment_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ADD CONSTRAINT `fk_joborder_order_modification_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `staffing_hr_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);

-- ========= joborder --> employee (10 constraint(s)) =========
-- Requires: joborder schema, employee schema
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ADD CONSTRAINT `fk_joborder_skill_requirement_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ADD CONSTRAINT `fk_joborder_skill_requirement_tertiary_skill_deactivated_by_user_staff_profile_id` FOREIGN KEY (`tertiary_skill_deactivated_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ADD CONSTRAINT `fk_joborder_order_status_history_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ADD CONSTRAINT `fk_joborder_order_status_history_tertiary_order_account_manager_staff_profile_id` FOREIGN KEY (`tertiary_order_account_manager_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ADD CONSTRAINT `fk_joborder_order_modification_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ADD CONSTRAINT `fk_joborder_order_modification_primary_order_staff_profile_id` FOREIGN KEY (`primary_order_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ADD CONSTRAINT `fk_joborder_fulfillment_team_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ADD CONSTRAINT `fk_joborder_joborder_approval_workflow_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ADD CONSTRAINT `fk_joborder_joborder_approval_workflow_tertiary_joborder_escalated_to_staff_profile_id` FOREIGN KEY (`tertiary_joborder_escalated_to_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ADD CONSTRAINT `fk_joborder_capacity_plan_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);

-- ========= joborder --> finance (16 constraint(s)) =========
-- Requires: joborder schema, finance schema
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ADD CONSTRAINT `fk_joborder_position_requirement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ADD CONSTRAINT `fk_joborder_rate_override_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ADD CONSTRAINT `fk_joborder_order_status_history_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ADD CONSTRAINT `fk_joborder_fulfillment_team_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ADD CONSTRAINT `fk_joborder_order_extension_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ADD CONSTRAINT `fk_joborder_demand_forecast_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ADD CONSTRAINT `fk_joborder_capacity_plan_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ADD CONSTRAINT `fk_joborder_capacity_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ADD CONSTRAINT `fk_joborder_fte_actuals_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ADD CONSTRAINT `fk_joborder_fte_actuals_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= joborder --> placement (2 constraint(s)) =========
-- Requires: joborder schema, placement schema
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ADD CONSTRAINT `fk_joborder_order_status_history_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ADD CONSTRAINT `fk_joborder_order_extension_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);

-- ========= joborder --> vendor (18 constraint(s)) =========
-- Requires: joborder schema, vendor schema
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_preferred_supplier_list_id` FOREIGN KEY (`preferred_supplier_list_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`preferred_supplier_list`(`preferred_supplier_list_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_sow_agreement_id` FOREIGN KEY (`sow_agreement_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`sow_agreement`(`sow_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ADD CONSTRAINT `fk_joborder_rate_override_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ADD CONSTRAINT `fk_joborder_sla_commitment_performance_scorecard_id` FOREIGN KEY (`performance_scorecard_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`performance_scorecard`(`performance_scorecard_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ADD CONSTRAINT `fk_joborder_sla_commitment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_program_allocation_id` FOREIGN KEY (`program_allocation_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`program_allocation`(`program_allocation_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_tier_classification_id` FOREIGN KEY (`tier_classification_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`tier_classification`(`tier_classification_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_vms_enrollment_id` FOREIGN KEY (`vms_enrollment_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`vms_enrollment`(`vms_enrollment_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ADD CONSTRAINT `fk_joborder_order_extension_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ADD CONSTRAINT `fk_joborder_demand_forecast_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ADD CONSTRAINT `fk_joborder_capacity_plan_program_allocation_id` FOREIGN KEY (`program_allocation_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`program_allocation`(`program_allocation_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ADD CONSTRAINT `fk_joborder_capacity_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ADD CONSTRAINT `fk_joborder_fte_actuals_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= onboarding --> candidate (10 constraint(s)) =========
-- Requires: onboarding schema, candidate schema
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ADD CONSTRAINT `fk_onboarding_offboarding_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ADD CONSTRAINT `fk_onboarding_tax_form_submission_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ADD CONSTRAINT `fk_onboarding_direct_deposit_setup_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ADD CONSTRAINT `fk_onboarding_document_collection_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ADD CONSTRAINT `fk_onboarding_lms_enrollment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ADD CONSTRAINT `fk_onboarding_equipment_provisioning_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ADD CONSTRAINT `fk_onboarding_status_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ADD CONSTRAINT `fk_onboarding_communication_log_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);

-- ========= onboarding --> client (15 constraint(s)) =========
-- Requires: onboarding schema, client schema
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ADD CONSTRAINT `fk_onboarding_offboarding_record_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ADD CONSTRAINT `fk_onboarding_offboarding_record_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ADD CONSTRAINT `fk_onboarding_task_checklist_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ADD CONSTRAINT `fk_onboarding_task_checklist_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ADD CONSTRAINT `fk_onboarding_orientation_session_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ADD CONSTRAINT `fk_onboarding_orientation_session_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ADD CONSTRAINT `fk_onboarding_lms_enrollment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ADD CONSTRAINT `fk_onboarding_onboarding_sla_target_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ADD CONSTRAINT `fk_onboarding_onboarding_sla_target_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ADD CONSTRAINT `fk_onboarding_requirement_rule_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ADD CONSTRAINT `fk_onboarding_requirement_rule_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ADD CONSTRAINT `fk_onboarding_requirement_rule_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ADD CONSTRAINT `fk_onboarding_communication_log_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);

-- ========= onboarding --> contract (6 constraint(s)) =========
-- Requires: onboarding schema, contract schema
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ADD CONSTRAINT `fk_onboarding_offboarding_record_non_compete_id` FOREIGN KEY (`non_compete_id`) REFERENCES `staffing_hr_ecm`.`contract`.`non_compete`(`non_compete_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ADD CONSTRAINT `fk_onboarding_document_collection_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ADD CONSTRAINT `fk_onboarding_document_collection_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ADD CONSTRAINT `fk_onboarding_document_collection_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `staffing_hr_ecm`.`contract`.`nda`(`nda_id`);

-- ========= onboarding --> credentialing (13 constraint(s)) =========
-- Requires: onboarding schema, credentialing schema
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_readiness_status_id` FOREIGN KEY (`readiness_status_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`readiness_status`(`readiness_status_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_drug_screen_id` FOREIGN KEY (`drug_screen_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`drug_screen`(`drug_screen_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_license_verification_id` FOREIGN KEY (`license_verification_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`license_verification`(`license_verification_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_skills_assessment_id` FOREIGN KEY (`skills_assessment_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`skills_assessment`(`skills_assessment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`training_record`(`training_record_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ADD CONSTRAINT `fk_onboarding_document_collection_credential_document_id` FOREIGN KEY (`credential_document_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_document`(`credential_document_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ADD CONSTRAINT `fk_onboarding_lms_enrollment_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`training_record`(`training_record_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ADD CONSTRAINT `fk_onboarding_status_event_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ADD CONSTRAINT `fk_onboarding_status_event_drug_screen_id` FOREIGN KEY (`drug_screen_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`drug_screen`(`drug_screen_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ADD CONSTRAINT `fk_onboarding_status_event_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ADD CONSTRAINT `fk_onboarding_status_event_readiness_status_id` FOREIGN KEY (`readiness_status_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`readiness_status`(`readiness_status_id`);

-- ========= onboarding --> employee (22 constraint(s)) =========
-- Requires: onboarding schema, employee schema
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_created_by_user_staff_profile_id` FOREIGN KEY (`created_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_last_modified_by_user_staff_profile_id` FOREIGN KEY (`last_modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ADD CONSTRAINT `fk_onboarding_offboarding_record_created_by_user_staff_profile_id` FOREIGN KEY (`created_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ADD CONSTRAINT `fk_onboarding_offboarding_record_last_modified_by_user_staff_profile_id` FOREIGN KEY (`last_modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ADD CONSTRAINT `fk_onboarding_offboarding_record_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_tertiary_task_waived_by_user_staff_profile_id` FOREIGN KEY (`tertiary_task_waived_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ADD CONSTRAINT `fk_onboarding_direct_deposit_setup_modified_by_user_staff_profile_id` FOREIGN KEY (`modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ADD CONSTRAINT `fk_onboarding_direct_deposit_setup_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ADD CONSTRAINT `fk_onboarding_document_collection_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ADD CONSTRAINT `fk_onboarding_lms_enrollment_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ADD CONSTRAINT `fk_onboarding_equipment_provisioning_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ADD CONSTRAINT `fk_onboarding_status_event_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ADD CONSTRAINT `fk_onboarding_onboarding_sla_target_created_by_user_staff_profile_id` FOREIGN KEY (`created_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ADD CONSTRAINT `fk_onboarding_onboarding_sla_target_modified_by_user_staff_profile_id` FOREIGN KEY (`modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ADD CONSTRAINT `fk_onboarding_onboarding_sla_target_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ADD CONSTRAINT `fk_onboarding_requirement_rule_modified_by_user_staff_profile_id` FOREIGN KEY (`modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ADD CONSTRAINT `fk_onboarding_requirement_rule_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ADD CONSTRAINT `fk_onboarding_communication_log_modified_by_user_staff_profile_id` FOREIGN KEY (`modified_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ADD CONSTRAINT `fk_onboarding_communication_log_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` ADD CONSTRAINT `fk_onboarding_orientation_attendance_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);

-- ========= onboarding --> finance (5 constraint(s)) =========
-- Requires: onboarding schema, finance schema
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ADD CONSTRAINT `fk_onboarding_offboarding_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ADD CONSTRAINT `fk_onboarding_orientation_session_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ADD CONSTRAINT `fk_onboarding_equipment_provisioning_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ADD CONSTRAINT `fk_onboarding_equipment_provisioning_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `staffing_hr_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= onboarding --> joborder (4 constraint(s)) =========
-- Requires: onboarding schema, joborder schema
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ADD CONSTRAINT `fk_onboarding_task_checklist_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ADD CONSTRAINT `fk_onboarding_onboarding_sla_target_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ADD CONSTRAINT `fk_onboarding_requirement_rule_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`job_category`(`job_category_id`);

-- ========= onboarding --> placement (10 constraint(s)) =========
-- Requires: onboarding schema, placement schema
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ADD CONSTRAINT `fk_onboarding_offboarding_record_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ADD CONSTRAINT `fk_onboarding_tax_form_submission_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ADD CONSTRAINT `fk_onboarding_direct_deposit_setup_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ADD CONSTRAINT `fk_onboarding_document_collection_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ADD CONSTRAINT `fk_onboarding_lms_enrollment_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ADD CONSTRAINT `fk_onboarding_equipment_provisioning_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ADD CONSTRAINT `fk_onboarding_status_event_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ADD CONSTRAINT `fk_onboarding_communication_log_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);

-- ========= onboarding --> recruitment (2 constraint(s)) =========
-- Requires: onboarding schema, recruitment schema
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`submittal`(`submittal_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ADD CONSTRAINT `fk_onboarding_communication_log_sourcing_campaign_id` FOREIGN KEY (`sourcing_campaign_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`sourcing_campaign`(`sourcing_campaign_id`);

-- ========= onboarding --> timesheet (1 constraint(s)) =========
-- Requires: onboarding schema, timesheet schema
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `staffing_hr_ecm`.`timesheet`.`shift`(`shift_id`);

-- ========= onboarding --> vendor (9 constraint(s)) =========
-- Requires: onboarding schema, vendor schema
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_sow_agreement_id` FOREIGN KEY (`sow_agreement_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`sow_agreement`(`sow_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_vendor_contact_id` FOREIGN KEY (`vendor_contact_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`vendor_contact`(`vendor_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ADD CONSTRAINT `fk_onboarding_offboarding_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ADD CONSTRAINT `fk_onboarding_tax_form_submission_vendor_document_id` FOREIGN KEY (`vendor_document_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`vendor_document`(`vendor_document_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ADD CONSTRAINT `fk_onboarding_direct_deposit_setup_vendor_document_id` FOREIGN KEY (`vendor_document_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`vendor_document`(`vendor_document_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ADD CONSTRAINT `fk_onboarding_requirement_rule_vendor_compliance_id` FOREIGN KEY (`vendor_compliance_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`vendor_compliance`(`vendor_compliance_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ADD CONSTRAINT `fk_onboarding_requirement_rule_vms_enrollment_id` FOREIGN KEY (`vms_enrollment_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`vms_enrollment`(`vms_enrollment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ADD CONSTRAINT `fk_onboarding_communication_log_vendor_document_id` FOREIGN KEY (`vendor_document_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`vendor_document`(`vendor_document_id`);

-- ========= payroll --> candidate (10 constraint(s)) =========
-- Requires: payroll schema, candidate schema
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`tax_line` ADD CONSTRAINT `fk_payroll_tax_line_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`deduction_line` ADD CONSTRAINT `fk_payroll_deduction_line_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`tax_form` ADD CONSTRAINT `fk_payroll_tax_form_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pto_accrual` ADD CONSTRAINT `fk_payroll_pto_accrual_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`garnishment_order` ADD CONSTRAINT `fk_payroll_garnishment_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_adjustment` ADD CONSTRAINT `fk_payroll_pay_adjustment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`tax_withholding_election` ADD CONSTRAINT `fk_payroll_tax_withholding_election_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);

-- ========= payroll --> client (11 constraint(s)) =========
-- Requires: payroll schema, client schema
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`eor_arrangement` ADD CONSTRAINT `fk_payroll_eor_arrangement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`eor_arrangement` ADD CONSTRAINT `fk_payroll_eor_arrangement_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`eor_arrangement` ADD CONSTRAINT `fk_payroll_eor_arrangement_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`eor_arrangement` ADD CONSTRAINT `fk_payroll_eor_arrangement_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);

-- ========= payroll --> compliance (19 constraint(s)) =========
-- Requires: payroll schema, compliance schema
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_run` ADD CONSTRAINT `fk_payroll_pay_run_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_everify_case_id` FOREIGN KEY (`everify_case_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`everify_case`(`everify_case_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_i9_verification_id` FOREIGN KEY (`i9_verification_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`i9_verification`(`i9_verification_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_coe_risk_assessment_id` FOREIGN KEY (`coe_risk_assessment_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`coe_risk_assessment`(`coe_risk_assessment_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_osha_incident_id` FOREIGN KEY (`osha_incident_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`osha_incident`(`osha_incident_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`tax_filing` ADD CONSTRAINT `fk_payroll_tax_filing_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pto_accrual` ADD CONSTRAINT `fk_payroll_pto_accrual_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`garnishment_order` ADD CONSTRAINT `fk_payroll_garnishment_order_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_adjustment` ADD CONSTRAINT `fk_payroll_pay_adjustment_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`tax_withholding_election` ADD CONSTRAINT `fk_payroll_tax_withholding_election_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`eor_arrangement` ADD CONSTRAINT `fk_payroll_eor_arrangement_i9_verification_id` FOREIGN KEY (`i9_verification_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`i9_verification`(`i9_verification_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`eor_arrangement` ADD CONSTRAINT `fk_payroll_eor_arrangement_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`arrangement_compliance_requirement` ADD CONSTRAINT `fk_payroll_arrangement_compliance_requirement_compliance_requirement_id` FOREIGN KEY (`compliance_requirement_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`arrangement_compliance_requirement` ADD CONSTRAINT `fk_payroll_arrangement_compliance_requirement_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub_compliance_validation` ADD CONSTRAINT `fk_payroll_pay_stub_compliance_validation_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`requirement`(`requirement_id`);

-- ========= payroll --> contract (10 constraint(s)) =========
-- Requires: payroll schema, contract schema
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`tax_form` ADD CONSTRAINT `fk_payroll_tax_form_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_adjustment` ADD CONSTRAINT `fk_payroll_pay_adjustment_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`eor_arrangement` ADD CONSTRAINT `fk_payroll_eor_arrangement_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);

-- ========= payroll --> credentialing (7 constraint(s)) =========
-- Requires: payroll schema, credentialing schema
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`tax_withholding_election` ADD CONSTRAINT `fk_payroll_tax_withholding_election_work_authorization_id` FOREIGN KEY (`work_authorization_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`work_authorization`(`work_authorization_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`eor_arrangement` ADD CONSTRAINT `fk_payroll_eor_arrangement_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_package`(`credential_package_id`);

-- ========= payroll --> employee (5 constraint(s)) =========
-- Requires: payroll schema, employee schema
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_run` ADD CONSTRAINT `fk_payroll_pay_run_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`deduction_line` ADD CONSTRAINT `fk_payroll_deduction_line_benefit_enrollment_id` FOREIGN KEY (`benefit_enrollment_id`) REFERENCES `staffing_hr_ecm`.`employee`.`benefit_enrollment`(`benefit_enrollment_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`eor_arrangement` ADD CONSTRAINT `fk_payroll_eor_arrangement_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);

-- ========= payroll --> finance (26 constraint(s)) =========
-- Requires: payroll schema, finance schema
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_run` ADD CONSTRAINT `fk_payroll_pay_run_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_run` ADD CONSTRAINT `fk_payroll_pay_run_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `staffing_hr_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_run` ADD CONSTRAINT `fk_payroll_pay_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`tax_line` ADD CONSTRAINT `fk_payroll_tax_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`deduction_line` ADD CONSTRAINT `fk_payroll_deduction_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`deduction_line` ADD CONSTRAINT `fk_payroll_deduction_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`tax_filing` ADD CONSTRAINT `fk_payroll_tax_filing_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`tax_form` ADD CONSTRAINT `fk_payroll_tax_form_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pto_accrual` ADD CONSTRAINT `fk_payroll_pto_accrual_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pto_accrual` ADD CONSTRAINT `fk_payroll_pto_accrual_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`garnishment_order` ADD CONSTRAINT `fk_payroll_garnishment_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`garnishment_order` ADD CONSTRAINT `fk_payroll_garnishment_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_adjustment` ADD CONSTRAINT `fk_payroll_pay_adjustment_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_adjustment` ADD CONSTRAINT `fk_payroll_pay_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `staffing_hr_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`tax_withholding_election` ADD CONSTRAINT `fk_payroll_tax_withholding_election_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`eor_arrangement` ADD CONSTRAINT `fk_payroll_eor_arrangement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `staffing_hr_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= payroll --> joborder (6 constraint(s)) =========
-- Requires: payroll schema, joborder schema
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pto_accrual` ADD CONSTRAINT `fk_payroll_pto_accrual_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_adjustment` ADD CONSTRAINT `fk_payroll_pay_adjustment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);

-- ========= payroll --> onboarding (6 constraint(s)) =========
-- Requires: payroll schema, onboarding schema
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pto_accrual` ADD CONSTRAINT `fk_payroll_pto_accrual_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`garnishment_order` ADD CONSTRAINT `fk_payroll_garnishment_order_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`tax_withholding_election` ADD CONSTRAINT `fk_payroll_tax_withholding_election_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);

-- ========= payroll --> placement (25 constraint(s)) =========
-- Requires: payroll schema, placement schema
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `staffing_hr_ecm`.`placement`.`rate`(`rate_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pto_accrual` ADD CONSTRAINT `fk_payroll_pto_accrual_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pto_accrual` ADD CONSTRAINT `fk_payroll_pto_accrual_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pto_accrual` ADD CONSTRAINT `fk_payroll_pto_accrual_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`garnishment_order` ADD CONSTRAINT `fk_payroll_garnishment_order_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`garnishment_order` ADD CONSTRAINT `fk_payroll_garnishment_order_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_adjustment` ADD CONSTRAINT `fk_payroll_pay_adjustment_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_adjustment` ADD CONSTRAINT `fk_payroll_pay_adjustment_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`tax_withholding_election` ADD CONSTRAINT `fk_payroll_tax_withholding_election_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`tax_withholding_election` ADD CONSTRAINT `fk_payroll_tax_withholding_election_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`eor_arrangement` ADD CONSTRAINT `fk_payroll_eor_arrangement_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`eor_arrangement` ADD CONSTRAINT `fk_payroll_eor_arrangement_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`eor_arrangement` ADD CONSTRAINT `fk_payroll_eor_arrangement_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm`.`placement`.`sow_engagement`(`sow_engagement_id`);

-- ========= payroll --> timesheet (3 constraint(s)) =========
-- Requires: payroll schema, timesheet schema
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `staffing_hr_ecm`.`timesheet`.`timesheet`(`timesheet_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_labor_category_id` FOREIGN KEY (`labor_category_id`) REFERENCES `staffing_hr_ecm`.`timesheet`.`labor_category`(`labor_category_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `staffing_hr_ecm`.`timesheet`.`timesheet`(`timesheet_id`);

-- ========= payroll --> vendor (5 constraint(s)) =========
-- Requires: payroll schema, vendor schema
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`payroll`.`eor_arrangement` ADD CONSTRAINT `fk_payroll_eor_arrangement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= placement --> billing (2 constraint(s)) =========
-- Requires: placement schema, billing schema
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= placement --> candidate (19 constraint(s)) =========
-- Requires: placement schema, candidate schema
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_right_to_represent_id` FOREIGN KEY (`right_to_represent_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`right_to_represent`(`right_to_represent_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_right_to_represent_id` FOREIGN KEY (`right_to_represent_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`right_to_represent`(`right_to_represent_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ADD CONSTRAINT `fk_placement_assignment_status_history_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ADD CONSTRAINT `fk_placement_backfill_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ADD CONSTRAINT `fk_placement_backfill_backfill_replacement_candidate_profile_id` FOREIGN KEY (`backfill_replacement_candidate_profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_right_to_represent_id` FOREIGN KEY (`right_to_represent_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`right_to_represent`(`right_to_represent_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ADD CONSTRAINT `fk_placement_per_diem_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ADD CONSTRAINT `fk_placement_bench_roster_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ADD CONSTRAINT `fk_placement_dispatch_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ADD CONSTRAINT `fk_placement_worker_schedule_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ADD CONSTRAINT `fk_placement_schedule_exception_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);

-- ========= placement --> client (25 constraint(s)) =========
-- Requires: placement schema, client schema
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ADD CONSTRAINT `fk_placement_assignment_status_history_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ADD CONSTRAINT `fk_placement_assignment_status_history_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_target_client_client_account_id` FOREIGN KEY (`target_client_client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ADD CONSTRAINT `fk_placement_backfill_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ADD CONSTRAINT `fk_placement_rate_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ADD CONSTRAINT `fk_placement_work_location_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ADD CONSTRAINT `fk_placement_work_location_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ADD CONSTRAINT `fk_placement_supervisor_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ADD CONSTRAINT `fk_placement_supervisor_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ADD CONSTRAINT `fk_placement_per_diem_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ADD CONSTRAINT `fk_placement_bench_roster_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ADD CONSTRAINT `fk_placement_dispatch_order_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`worker_schedule` ADD CONSTRAINT `fk_placement_worker_schedule_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`schedule_exception` ADD CONSTRAINT `fk_placement_schedule_exception_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`shift_template` ADD CONSTRAINT `fk_placement_shift_template_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);

-- ========= placement --> compliance (12 constraint(s)) =========
-- Requires: placement schema, compliance schema
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ADD CONSTRAINT `fk_placement_backfill_osha_incident_id` FOREIGN KEY (`osha_incident_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`osha_incident`(`osha_incident_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ADD CONSTRAINT `fk_placement_work_location_ofccp_compliance_id` FOREIGN KEY (`ofccp_compliance_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`ofccp_compliance`(`ofccp_compliance_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ADD CONSTRAINT `fk_placement_per_diem_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ADD CONSTRAINT `fk_placement_assignment_compliance_compliance_requirement_id` FOREIGN KEY (`compliance_requirement_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ADD CONSTRAINT `fk_placement_assignment_compliance_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ADD CONSTRAINT `fk_placement_location_compliance_mandate_compliance_requirement_id` FOREIGN KEY (`compliance_requirement_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ADD CONSTRAINT `fk_placement_location_compliance_mandate_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`requirement`(`requirement_id`);

-- ========= placement --> contract (18 constraint(s)) =========
-- Requires: placement schema, contract schema
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ADD CONSTRAINT `fk_placement_work_location_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ADD CONSTRAINT `fk_placement_supervisor_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `staffing_hr_ecm`.`contract`.`nda`(`nda_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ADD CONSTRAINT `fk_placement_per_diem_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`per_diem` ADD CONSTRAINT `fk_placement_per_diem_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_sla_measurement` ADD CONSTRAINT `fk_placement_assignment_sla_measurement_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sla`(`sla_id`);

-- ========= placement --> credentialing (10 constraint(s)) =========
-- Requires: placement schema, credentialing schema
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_readiness_status_id` FOREIGN KEY (`readiness_status_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`readiness_status`(`readiness_status_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_readiness_status_id` FOREIGN KEY (`readiness_status_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`readiness_status`(`readiness_status_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ADD CONSTRAINT `fk_placement_work_location_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_readiness_status_id` FOREIGN KEY (`readiness_status_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`readiness_status`(`readiness_status_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_readiness_status_id` FOREIGN KEY (`readiness_status_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`readiness_status`(`readiness_status_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ADD CONSTRAINT `fk_placement_bench_roster_readiness_status_id` FOREIGN KEY (`readiness_status_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`readiness_status`(`readiness_status_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ADD CONSTRAINT `fk_placement_assignment_credential_compliance_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential`(`credential_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_credential_requirement` ADD CONSTRAINT `fk_placement_location_credential_requirement_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential`(`credential_id`);

-- ========= placement --> employee (22 constraint(s)) =========
-- Requires: placement schema, employee schema
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_branch_office_location_id` FOREIGN KEY (`branch_office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_conversion_staff_profile_id` FOREIGN KEY (`conversion_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_office_location_id` FOREIGN KEY (`office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ADD CONSTRAINT `fk_placement_assignment_status_history_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ADD CONSTRAINT `fk_placement_assignment_status_history_quaternary_assignment_approved_by_user_staff_profile_id` FOREIGN KEY (`quaternary_assignment_approved_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ADD CONSTRAINT `fk_placement_assignment_status_history_tertiary_assignment_account_manager_staff_profile_id` FOREIGN KEY (`tertiary_assignment_account_manager_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ADD CONSTRAINT `fk_placement_backfill_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_office_location_id` FOREIGN KEY (`office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_offer_staff_profile_id` FOREIGN KEY (`offer_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`bench_roster` ADD CONSTRAINT `fk_placement_bench_roster_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ADD CONSTRAINT `fk_placement_dispatch_order_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_compliance` ADD CONSTRAINT `fk_placement_assignment_compliance_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_credential_compliance` ADD CONSTRAINT `fk_placement_assignment_credential_compliance_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`location_compliance_mandate` ADD CONSTRAINT `fk_placement_location_compliance_mandate_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);

-- ========= placement --> joborder (11 constraint(s)) =========
-- Requires: placement schema, joborder schema
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_status_history` ADD CONSTRAINT `fk_placement_assignment_status_history_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ADD CONSTRAINT `fk_placement_backfill_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`dispatch_order` ADD CONSTRAINT `fk_placement_dispatch_order_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);

-- ========= placement --> onboarding (2 constraint(s)) =========
-- Requires: placement schema, onboarding schema
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);

-- ========= placement --> recruitment (6 constraint(s)) =========
-- Requires: placement schema, recruitment schema
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`submittal`(`submittal_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`submittal`(`submittal_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`submittal`(`submittal_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ADD CONSTRAINT `fk_placement_backfill_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`submittal`(`submittal_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`submittal`(`submittal_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `staffing_hr_ecm`.`recruitment`.`submittal`(`submittal_id`);

-- ========= placement --> timesheet (1 constraint(s)) =========
-- Requires: placement schema, timesheet schema
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ADD CONSTRAINT `fk_placement_work_location_ot_rule_id` FOREIGN KEY (`ot_rule_id`) REFERENCES `staffing_hr_ecm`.`timesheet`.`ot_rule`(`ot_rule_id`);

-- ========= placement --> vendor (12 constraint(s)) =========
-- Requires: placement schema, vendor schema
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_tier_classification_id` FOREIGN KEY (`tier_classification_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`tier_classification`(`tier_classification_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`backfill` ADD CONSTRAINT `fk_placement_backfill_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`rate` ADD CONSTRAINT `fk_placement_rate_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`work_location` ADD CONSTRAINT `fk_placement_work_location_vms_enrollment_id` FOREIGN KEY (`vms_enrollment_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`vms_enrollment`(`vms_enrollment_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`supervisor` ADD CONSTRAINT `fk_placement_supervisor_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= recruitment --> candidate (11 constraint(s)) =========
-- Requires: recruitment schema, candidate schema
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_resume_id` FOREIGN KEY (`resume_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`resume`(`resume_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`interview_feedback` ADD CONSTRAINT `fk_recruitment_interview_feedback_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`candidate_screening` ADD CONSTRAINT `fk_recruitment_candidate_screening_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_referral_referrer_candidate_profile_id` FOREIGN KEY (`referral_referrer_candidate_profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);

-- ========= recruitment --> client (21 constraint(s)) =========
-- Requires: recruitment schema, client schema
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`interview_feedback` ADD CONSTRAINT `fk_recruitment_interview_feedback_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sourcing_activity` ADD CONSTRAINT `fk_recruitment_sourcing_activity_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruitment_sla_target` ADD CONSTRAINT `fk_recruitment_recruitment_sla_target_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruitment_sla_target` ADD CONSTRAINT `fk_recruitment_recruitment_sla_target_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sla_breach` ADD CONSTRAINT `fk_recruitment_sla_breach_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_board_integration` ADD CONSTRAINT `fk_recruitment_job_board_integration_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_board_integration` ADD CONSTRAINT `fk_recruitment_job_board_integration_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);

-- ========= recruitment --> compliance (4 constraint(s)) =========
-- Requires: recruitment schema, compliance schema
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_ofccp_compliance_id` FOREIGN KEY (`ofccp_compliance_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`ofccp_compliance`(`ofccp_compliance_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`submittal_compliance_check` ADD CONSTRAINT `fk_recruitment_submittal_compliance_check_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`requirement`(`requirement_id`);

-- ========= recruitment --> contract (13 constraint(s)) =========
-- Requires: recruitment schema, contract schema
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `staffing_hr_ecm`.`contract`.`nda`(`nda_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`candidate_screening` ADD CONSTRAINT `fk_recruitment_candidate_screening_template_id` FOREIGN KEY (`template_id`) REFERENCES `staffing_hr_ecm`.`contract`.`template`(`template_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruitment_sla_target` ADD CONSTRAINT `fk_recruitment_recruitment_sla_target_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruitment_sla_target` ADD CONSTRAINT `fk_recruitment_recruitment_sla_target_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sla_breach` ADD CONSTRAINT `fk_recruitment_sla_breach_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_board_integration` ADD CONSTRAINT `fk_recruitment_job_board_integration_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);

-- ========= recruitment --> credentialing (14 constraint(s)) =========
-- Requires: recruitment schema, credentialing schema
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`candidate_screening` ADD CONSTRAINT `fk_recruitment_candidate_screening_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_readiness_status_id` FOREIGN KEY (`readiness_status_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`readiness_status`(`readiness_status_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruitment_sla_target` ADD CONSTRAINT `fk_recruitment_recruitment_sla_target_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sla_breach` ADD CONSTRAINT `fk_recruitment_sla_breach_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_board_integration` ADD CONSTRAINT `fk_recruitment_job_board_integration_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential`(`credential_id`);

-- ========= recruitment --> employee (18 constraint(s)) =========
-- Requires: recruitment schema, employee schema
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_submittal_staff_profile_id` FOREIGN KEY (`submittal_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`interview_feedback` ADD CONSTRAINT `fk_recruitment_interview_feedback_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sourcing_activity` ADD CONSTRAINT `fk_recruitment_sourcing_activity_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_recruiter_desk_id` FOREIGN KEY (`recruiter_desk_id`) REFERENCES `staffing_hr_ecm`.`employee`.`recruiter_desk`(`recruiter_desk_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_team_id` FOREIGN KEY (`team_id`) REFERENCES `staffing_hr_ecm`.`employee`.`team`(`team_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_tertiary_recruiter_approved_by_manager_staff_profile_id` FOREIGN KEY (`tertiary_recruiter_approved_by_manager_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruitment_sla_target` ADD CONSTRAINT `fk_recruitment_recruitment_sla_target_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sla_breach` ADD CONSTRAINT `fk_recruitment_sla_breach_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_referral_staff_profile_id` FOREIGN KEY (`referral_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);

-- ========= recruitment --> finance (12 constraint(s)) =========
-- Requires: recruitment schema, finance schema
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `staffing_hr_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_accrual_id` FOREIGN KEY (`accrual_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accrual`(`accrual_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_accrual_id` FOREIGN KEY (`accrual_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accrual`(`accrual_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `staffing_hr_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruitment_sla_target` ADD CONSTRAINT `fk_recruitment_recruitment_sla_target_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `staffing_hr_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sla_breach` ADD CONSTRAINT `fk_recruitment_sla_breach_accrual_id` FOREIGN KEY (`accrual_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accrual`(`accrual_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_accrual_id` FOREIGN KEY (`accrual_id`) REFERENCES `staffing_hr_ecm`.`finance`.`accrual`(`accrual_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_board_integration` ADD CONSTRAINT `fk_recruitment_job_board_integration_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `staffing_hr_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_board_integration` ADD CONSTRAINT `fk_recruitment_job_board_integration_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= recruitment --> joborder (16 constraint(s)) =========
-- Requires: recruitment schema, joborder schema
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_submittal_req_order_header_id` FOREIGN KEY (`submittal_req_order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`interview_feedback` ADD CONSTRAINT `fk_recruitment_interview_feedback_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`candidate_screening` ADD CONSTRAINT `fk_recruitment_candidate_screening_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sourcing_activity` ADD CONSTRAINT `fk_recruitment_sourcing_activity_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruitment_sla_target` ADD CONSTRAINT `fk_recruitment_recruitment_sla_target_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sla_breach` ADD CONSTRAINT `fk_recruitment_sla_breach_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_board_integration` ADD CONSTRAINT `fk_recruitment_job_board_integration_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);

-- ========= recruitment --> placement (6 constraint(s)) =========
-- Requires: recruitment schema, placement schema
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`interview_feedback` ADD CONSTRAINT `fk_recruitment_interview_feedback_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);

-- ========= recruitment --> shared (1 constraint(s)) =========
-- Requires: recruitment schema, shared schema
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruitment_sla_target` ADD CONSTRAINT `fk_recruitment_recruitment_sla_target_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `staffing_hr_ecm`.`shared`.`holiday_calendar`(`holiday_calendar_id`);

-- ========= recruitment --> vendor (14 constraint(s)) =========
-- Requires: recruitment schema, vendor schema
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`interview_feedback` ADD CONSTRAINT `fk_recruitment_interview_feedback_performance_scorecard_id` FOREIGN KEY (`performance_scorecard_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`performance_scorecard`(`performance_scorecard_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`candidate_screening` ADD CONSTRAINT `fk_recruitment_candidate_screening_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sourcing_activity` ADD CONSTRAINT `fk_recruitment_sourcing_activity_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`recruitment_sla_target` ADD CONSTRAINT `fk_recruitment_recruitment_sla_target_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`sla_breach` ADD CONSTRAINT `fk_recruitment_sla_breach_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= timesheet --> billing (3 constraint(s)) =========
-- Requires: timesheet schema, billing schema
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`per_diem_claim` ADD CONSTRAINT `fk_timesheet_per_diem_claim_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= timesheet --> candidate (12 constraint(s)) =========
-- Requires: timesheet schema, candidate schema
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet_approval_workflow` ADD CONSTRAINT `fk_timesheet_timesheet_approval_workflow_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`absence_record` ADD CONSTRAINT `fk_timesheet_absence_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`per_diem_claim` ADD CONSTRAINT `fk_timesheet_per_diem_claim_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`punch_event` ADD CONSTRAINT `fk_timesheet_punch_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet_dispute` ADD CONSTRAINT `fk_timesheet_timesheet_dispute_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`vms_timesheet_sync` ADD CONSTRAINT `fk_timesheet_vms_timesheet_sync_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm`.`candidate`.`profile`(`profile_id`);

-- ========= timesheet --> client (20 constraint(s)) =========
-- Requires: timesheet schema, client schema
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet_approval_workflow` ADD CONSTRAINT `fk_timesheet_timesheet_approval_workflow_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet_approval_workflow` ADD CONSTRAINT `fk_timesheet_timesheet_approval_workflow_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`absence_record` ADD CONSTRAINT `fk_timesheet_absence_record_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`absence_record` ADD CONSTRAINT `fk_timesheet_absence_record_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`per_diem_claim` ADD CONSTRAINT `fk_timesheet_per_diem_claim_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`per_diem_claim` ADD CONSTRAINT `fk_timesheet_per_diem_claim_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet_dispute` ADD CONSTRAINT `fk_timesheet_timesheet_dispute_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`vms_timesheet_sync` ADD CONSTRAINT `fk_timesheet_vms_timesheet_sync_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`vms_timesheet_sync` ADD CONSTRAINT `fk_timesheet_vms_timesheet_sync_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`vms_timesheet_sync` ADD CONSTRAINT `fk_timesheet_vms_timesheet_sync_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);

-- ========= timesheet --> compliance (10 constraint(s)) =========
-- Requires: timesheet schema, compliance schema
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_i9_verification_id` FOREIGN KEY (`i9_verification_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`i9_verification`(`i9_verification_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`absence_record` ADD CONSTRAINT `fk_timesheet_absence_record_i9_verification_id` FOREIGN KEY (`i9_verification_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`i9_verification`(`i9_verification_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`ot_rule` ADD CONSTRAINT `fk_timesheet_ot_rule_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`labor_category` ADD CONSTRAINT `fk_timesheet_labor_category_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet_dispute` ADD CONSTRAINT `fk_timesheet_timesheet_dispute_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);

-- ========= timesheet --> contract (8 constraint(s)) =========
-- Requires: timesheet schema, contract schema
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_template_id` FOREIGN KEY (`template_id`) REFERENCES `staffing_hr_ecm`.`contract`.`template`(`template_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`labor_category` ADD CONSTRAINT `fk_timesheet_labor_category_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);

-- ========= timesheet --> credentialing (3 constraint(s)) =========
-- Requires: timesheet schema, credentialing schema
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_readiness_status_id` FOREIGN KEY (`readiness_status_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`readiness_status`(`readiness_status_id`);

-- ========= timesheet --> employee (11 constraint(s)) =========
-- Requires: timesheet schema, employee schema
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet_approval_workflow` ADD CONSTRAINT `fk_timesheet_timesheet_approval_workflow_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet_approval_workflow` ADD CONSTRAINT `fk_timesheet_timesheet_approval_workflow_tertiary_timesheet_delegated_approver_staff_profile_id` FOREIGN KEY (`tertiary_timesheet_delegated_approver_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`per_diem_claim` ADD CONSTRAINT `fk_timesheet_per_diem_claim_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_adjustment_staff_profile_id` FOREIGN KEY (`adjustment_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`punch_event` ADD CONSTRAINT `fk_timesheet_punch_event_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet_dispute` ADD CONSTRAINT `fk_timesheet_timesheet_dispute_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);

-- ========= timesheet --> finance (12 constraint(s)) =========
-- Requires: timesheet schema, finance schema
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`per_diem_claim` ADD CONSTRAINT `fk_timesheet_per_diem_claim_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`per_diem_claim` ADD CONSTRAINT `fk_timesheet_per_diem_claim_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`punch_event` ADD CONSTRAINT `fk_timesheet_punch_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`labor_category` ADD CONSTRAINT `fk_timesheet_labor_category_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `staffing_hr_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`labor_category` ADD CONSTRAINT `fk_timesheet_labor_category_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `staffing_hr_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= timesheet --> joborder (4 constraint(s)) =========
-- Requires: timesheet schema, joborder schema
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);

-- ========= timesheet --> payroll (6 constraint(s)) =========
-- Requires: timesheet schema, payroll schema
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_pay_run_id` FOREIGN KEY (`pay_run_id`) REFERENCES `staffing_hr_ecm`.`payroll`.`pay_run`(`pay_run_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`absence_record` ADD CONSTRAINT `fk_timesheet_absence_record_pto_accrual_id` FOREIGN KEY (`pto_accrual_id`) REFERENCES `staffing_hr_ecm`.`payroll`.`pto_accrual`(`pto_accrual_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_pay_stub_id` FOREIGN KEY (`pay_stub_id`) REFERENCES `staffing_hr_ecm`.`payroll`.`pay_stub`(`pay_stub_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_pay_stub_id` FOREIGN KEY (`pay_stub_id`) REFERENCES `staffing_hr_ecm`.`payroll`.`pay_stub`(`pay_stub_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_pay_run_id` FOREIGN KEY (`pay_run_id`) REFERENCES `staffing_hr_ecm`.`payroll`.`pay_run`(`pay_run_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet_dispute` ADD CONSTRAINT `fk_timesheet_timesheet_dispute_pay_adjustment_id` FOREIGN KEY (`pay_adjustment_id`) REFERENCES `staffing_hr_ecm`.`payroll`.`pay_adjustment`(`pay_adjustment_id`);

-- ========= timesheet --> placement (17 constraint(s)) =========
-- Requires: timesheet schema, placement schema
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet_approval_workflow` ADD CONSTRAINT `fk_timesheet_timesheet_approval_workflow_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`absence_record` ADD CONSTRAINT `fk_timesheet_absence_record_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_supervisor_id` FOREIGN KEY (`supervisor_id`) REFERENCES `staffing_hr_ecm`.`placement`.`supervisor`(`supervisor_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`per_diem_claim` ADD CONSTRAINT `fk_timesheet_per_diem_claim_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`punch_event` ADD CONSTRAINT `fk_timesheet_punch_event_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`punch_event` ADD CONSTRAINT `fk_timesheet_punch_event_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`timesheet_dispute` ADD CONSTRAINT `fk_timesheet_timesheet_dispute_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`vms_timesheet_sync` ADD CONSTRAINT `fk_timesheet_vms_timesheet_sync_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm`.`placement`.`assignment`(`assignment_id`);

-- ========= timesheet --> vendor (2 constraint(s)) =========
-- Requires: timesheet schema, vendor schema
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`labor_category` ADD CONSTRAINT `fk_timesheet_labor_category_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `staffing_hr_ecm`.`timesheet`.`vms_timesheet_sync` ADD CONSTRAINT `fk_timesheet_vms_timesheet_sync_vms_enrollment_id` FOREIGN KEY (`vms_enrollment_id`) REFERENCES `staffing_hr_ecm`.`vendor`.`vms_enrollment`(`vms_enrollment_id`);

-- ========= vendor --> client (22 constraint(s)) =========
-- Requires: vendor schema, client schema
ALTER TABLE `staffing_hr_ecm`.`vendor`.`tier_classification` ADD CONSTRAINT `fk_vendor_tier_classification_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vms_enrollment` ADD CONSTRAINT `fk_vendor_vms_enrollment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vms_enrollment` ADD CONSTRAINT `fk_vendor_vms_enrollment_client_program_id` FOREIGN KEY (`client_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vms_enrollment` ADD CONSTRAINT `fk_vendor_vms_enrollment_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vendor_rate_card` ADD CONSTRAINT `fk_vendor_vendor_rate_card_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`rate_agreement` ADD CONSTRAINT `fk_vendor_rate_agreement_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`rate_agreement` ADD CONSTRAINT `fk_vendor_rate_agreement_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`program_allocation` ADD CONSTRAINT `fk_vendor_program_allocation_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`program_allocation` ADD CONSTRAINT `fk_vendor_program_allocation_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`program_allocation` ADD CONSTRAINT `fk_vendor_program_allocation_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`preferred_supplier_list` ADD CONSTRAINT `fk_vendor_preferred_supplier_list_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`preferred_supplier_list` ADD CONSTRAINT `fk_vendor_preferred_supplier_list_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`diversity_certification` ADD CONSTRAINT `fk_vendor_diversity_certification_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`exclusion` ADD CONSTRAINT `fk_vendor_exclusion_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`exclusion` ADD CONSTRAINT `fk_vendor_exclusion_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vendor_document` ADD CONSTRAINT `fk_vendor_vendor_document_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`supplier_checklist_assignment` ADD CONSTRAINT `fk_vendor_supplier_checklist_assignment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm`.`client`.`client_account`(`client_account_id`);

-- ========= vendor --> compliance (2 constraint(s)) =========
-- Requires: vendor schema, compliance schema
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`supplier_compliance_obligation` ADD CONSTRAINT `fk_vendor_supplier_compliance_obligation_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm`.`compliance`.`requirement`(`requirement_id`);

-- ========= vendor --> contract (24 constraint(s)) =========
-- Requires: vendor schema, contract schema
ALTER TABLE `staffing_hr_ecm`.`vendor`.`tier_classification` ADD CONSTRAINT `fk_vendor_tier_classification_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vms_enrollment` ADD CONSTRAINT `fk_vendor_vms_enrollment_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vendor_rate_card` ADD CONSTRAINT `fk_vendor_vendor_rate_card_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`rate_agreement` ADD CONSTRAINT `fk_vendor_rate_agreement_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`rate_agreement` ADD CONSTRAINT `fk_vendor_rate_agreement_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`rate_agreement` ADD CONSTRAINT `fk_vendor_rate_agreement_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`program_allocation` ADD CONSTRAINT `fk_vendor_program_allocation_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`program_allocation` ADD CONSTRAINT `fk_vendor_program_allocation_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`program_allocation` ADD CONSTRAINT `fk_vendor_program_allocation_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`preferred_supplier_list` ADD CONSTRAINT `fk_vendor_preferred_supplier_list_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`preferred_supplier_list` ADD CONSTRAINT `fk_vendor_preferred_supplier_list_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`exclusion` ADD CONSTRAINT `fk_vendor_exclusion_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`exclusion` ADD CONSTRAINT `fk_vendor_exclusion_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vendor_document` ADD CONSTRAINT `fk_vendor_vendor_document_envelope_id` FOREIGN KEY (`envelope_id`) REFERENCES `staffing_hr_ecm`.`contract`.`envelope`(`envelope_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vendor_document` ADD CONSTRAINT `fk_vendor_vendor_document_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm`.`contract`.`vendor_agreement`(`vendor_agreement_id`);

-- ========= vendor --> credentialing (5 constraint(s)) =========
-- Requires: vendor schema, credentialing schema
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vms_enrollment` ADD CONSTRAINT `fk_vendor_vms_enrollment_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`program_allocation` ADD CONSTRAINT `fk_vendor_program_allocation_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential`(`credential_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`supplier_package_qualification` ADD CONSTRAINT `fk_vendor_supplier_package_qualification_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm`.`credentialing`.`credential_package`(`credential_package_id`);

-- ========= vendor --> employee (14 constraint(s)) =========
-- Requires: vendor schema, employee schema
ALTER TABLE `staffing_hr_ecm`.`vendor`.`supplier` ADD CONSTRAINT `fk_vendor_supplier_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`tier_classification` ADD CONSTRAINT `fk_vendor_tier_classification_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`rate_agreement` ADD CONSTRAINT `fk_vendor_rate_agreement_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vendor_contact` ADD CONSTRAINT `fk_vendor_vendor_contact_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`preferred_supplier_list` ADD CONSTRAINT `fk_vendor_preferred_supplier_list_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`exclusion` ADD CONSTRAINT `fk_vendor_exclusion_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`vendor_document` ADD CONSTRAINT `fk_vendor_vendor_document_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`desk_supplier_allocation` ADD CONSTRAINT `fk_vendor_desk_supplier_allocation_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`desk_supplier_allocation` ADD CONSTRAINT `fk_vendor_desk_supplier_allocation_recruiter_desk_id` FOREIGN KEY (`recruiter_desk_id`) REFERENCES `staffing_hr_ecm`.`employee`.`recruiter_desk`(`recruiter_desk_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`supplier_package_qualification` ADD CONSTRAINT `fk_vendor_supplier_package_qualification_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`supplier_checklist_assignment` ADD CONSTRAINT `fk_vendor_supplier_checklist_assignment_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);

-- ========= vendor --> onboarding (2 constraint(s)) =========
-- Requires: vendor schema, onboarding schema
ALTER TABLE `staffing_hr_ecm`.`vendor`.`supplier_checklist_assignment` ADD CONSTRAINT `fk_vendor_supplier_checklist_assignment_task_checklist_id` FOREIGN KEY (`task_checklist_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`task_checklist`(`task_checklist_id`);
ALTER TABLE `staffing_hr_ecm`.`vendor`.`supplier_orientation_attendance` ADD CONSTRAINT `fk_vendor_supplier_orientation_attendance_orientation_session_id` FOREIGN KEY (`orientation_session_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`orientation_session`(`orientation_session_id`);

