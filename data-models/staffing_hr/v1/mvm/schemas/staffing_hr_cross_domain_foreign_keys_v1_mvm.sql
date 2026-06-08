-- Cross-Domain Foreign Keys for Business: Staffing Hr | Version: v1_mvm
-- Generated on: 2026-05-02 22:45:39
-- Total cross-domain FK constraints: 1220
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: billing, candidate, client, compliance, contract, credentialing, joborder, payroll, placement, recruitment, timesheet, vendor

-- ========= billing --> candidate (6 constraint(s)) =========
-- Requires: billing schema, candidate schema
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`assessment`(`assessment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_right_to_represent_id` FOREIGN KEY (`right_to_represent_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`right_to_represent`(`right_to_represent_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_orientation_session_id` FOREIGN KEY (`orientation_session_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`orientation_session`(`orientation_session_id`);

-- ========= billing --> client (26 constraint(s)) =========
-- Requires: billing schema, client schema
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`collection_activity` ADD CONSTRAINT `fk_billing_collection_activity_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);

-- ========= billing --> compliance (21 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`requirement`(`requirement_id`);

-- ========= billing --> contract (26 constraint(s)) =========
-- Requires: billing schema, contract schema
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);

-- ========= billing --> credentialing (18 constraint(s)) =========
-- Requires: billing schema, credentialing schema
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_drug_screen_id` FOREIGN KEY (`drug_screen_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`drug_screen`(`drug_screen_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_license_verification_id` FOREIGN KEY (`license_verification_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`license_verification`(`license_verification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`training_record`(`training_record_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_drug_screen_id` FOREIGN KEY (`drug_screen_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`drug_screen`(`drug_screen_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_work_authorization_id` FOREIGN KEY (`work_authorization_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`work_authorization`(`work_authorization_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_drug_screen_id` FOREIGN KEY (`drug_screen_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`drug_screen`(`drug_screen_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_license_verification_id` FOREIGN KEY (`license_verification_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`license_verification`(`license_verification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`training_record`(`training_record_id`);

-- ========= billing --> joborder (10 constraint(s)) =========
-- Requires: billing schema, joborder schema
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_rate_override_id` FOREIGN KEY (`rate_override_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`rate_override`(`rate_override_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);

-- ========= billing --> payroll (6 constraint(s)) =========
-- Requires: billing schema, payroll schema
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_pay_run_id` FOREIGN KEY (`pay_run_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`pay_run`(`pay_run_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_earnings_line_id` FOREIGN KEY (`earnings_line_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`earnings_line`(`earnings_line_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_pay_rate_id` FOREIGN KEY (`pay_rate_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`pay_rate`(`pay_rate_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_pay_stub_id` FOREIGN KEY (`pay_stub_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`pay_stub`(`pay_stub_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_burden_rate_id` FOREIGN KEY (`burden_rate_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`burden_rate`(`burden_rate_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_pay_rate_id` FOREIGN KEY (`pay_rate_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`pay_rate`(`pay_rate_id`);

-- ========= billing --> placement (23 constraint(s)) =========
-- Requires: billing schema, placement schema
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`rate`(`rate_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_conversion_id` FOREIGN KEY (`conversion_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`conversion`(`conversion_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_fall_off_id` FOREIGN KEY (`fall_off_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`fall_off`(`fall_off_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_assignment_extension_id` FOREIGN KEY (`assignment_extension_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment_extension`(`assignment_extension_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_conversion_id` FOREIGN KEY (`conversion_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`conversion`(`conversion_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_conversion_id` FOREIGN KEY (`conversion_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`conversion`(`conversion_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`offer`(`offer_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);

-- ========= billing --> recruitment (7 constraint(s)) =========
-- Requires: billing schema, recruitment schema
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_sourcing_campaign_id` FOREIGN KEY (`sourcing_campaign_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign`(`sourcing_campaign_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_hiring_decision_id` FOREIGN KEY (`hiring_decision_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision`(`hiring_decision_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_recruiter_assignment_id` FOREIGN KEY (`recruiter_assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment`(`recruiter_assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`submittal`(`submittal_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement`(`onboarding_engagement_id`);

-- ========= billing --> timesheet (6 constraint(s)) =========
-- Requires: billing schema, timesheet schema
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_pay_period_id` FOREIGN KEY (`pay_period_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`pay_period`(`pay_period_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`timesheet`(`timesheet_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_labor_category_id` FOREIGN KEY (`labor_category_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`labor_category`(`labor_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_ot_rule_id` FOREIGN KEY (`ot_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`ot_rule`(`ot_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`timesheet`(`timesheet_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`timesheet`(`timesheet_id`);

-- ========= billing --> vendor (17 constraint(s)) =========
-- Requires: billing schema, vendor schema
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_sow_agreement_id` FOREIGN KEY (`sow_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`sow_agreement`(`sow_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_vms_enrollment_id` FOREIGN KEY (`vms_enrollment_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vms_enrollment`(`vms_enrollment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_tier_classification_id` FOREIGN KEY (`tier_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`tier_classification`(`tier_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_tier_classification_id` FOREIGN KEY (`tier_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`tier_classification`(`tier_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_vms_enrollment_id` FOREIGN KEY (`vms_enrollment_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vms_enrollment`(`vms_enrollment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);

-- ========= candidate --> client (28 constraint(s)) =========
-- Requires: candidate schema, client schema
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`orientation_session` ADD CONSTRAINT `fk_candidate_orientation_session_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`orientation_session` ADD CONSTRAINT `fk_candidate_orientation_session_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`orientation_session` ADD CONSTRAINT `fk_candidate_orientation_session_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`work_history` ADD CONSTRAINT `fk_candidate_work_history_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`interaction` ADD CONSTRAINT `fk_candidate_interaction_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`interaction` ADD CONSTRAINT `fk_candidate_interaction_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`interaction` ADD CONSTRAINT `fk_candidate_interaction_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`assessment` ADD CONSTRAINT `fk_candidate_assessment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`assessment` ADD CONSTRAINT `fk_candidate_assessment_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`talent_pool_membership` ADD CONSTRAINT `fk_candidate_talent_pool_membership_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`talent_pool_membership` ADD CONSTRAINT `fk_candidate_talent_pool_membership_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`talent_pool_membership` ADD CONSTRAINT `fk_candidate_talent_pool_membership_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`talent_pool_membership` ADD CONSTRAINT `fk_candidate_talent_pool_membership_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`talent_pool` ADD CONSTRAINT `fk_candidate_talent_pool_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`talent_pool` ADD CONSTRAINT `fk_candidate_talent_pool_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`talent_pool` ADD CONSTRAINT `fk_candidate_talent_pool_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);

-- ========= candidate --> compliance (6 constraint(s)) =========
-- Requires: candidate schema, compliance schema
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`orientation_session` ADD CONSTRAINT `fk_candidate_orientation_session_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`assessment` ADD CONSTRAINT `fk_candidate_assessment_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`talent_pool` ADD CONSTRAINT `fk_candidate_talent_pool_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`requirement`(`requirement_id`);

-- ========= candidate --> contract (5 constraint(s)) =========
-- Requires: candidate schema, contract schema
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`assessment` ADD CONSTRAINT `fk_candidate_assessment_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);

-- ========= candidate --> credentialing (7 constraint(s)) =========
-- Requires: candidate schema, credentialing schema
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`orientation_session` ADD CONSTRAINT `fk_candidate_orientation_session_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`orientation_session` ADD CONSTRAINT `fk_candidate_orientation_session_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`work_history` ADD CONSTRAINT `fk_candidate_work_history_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`talent_pool_membership` ADD CONSTRAINT `fk_candidate_talent_pool_membership_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`talent_pool` ADD CONSTRAINT `fk_candidate_talent_pool_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);

-- ========= candidate --> joborder (18 constraint(s)) =========
-- Requires: candidate schema, joborder schema
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`orientation_session` ADD CONSTRAINT `fk_candidate_orientation_session_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`orientation_session` ADD CONSTRAINT `fk_candidate_orientation_session_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`profile` ADD CONSTRAINT `fk_candidate_profile_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`work_history` ADD CONSTRAINT `fk_candidate_work_history_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`availability` ADD CONSTRAINT `fk_candidate_availability_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`interaction` ADD CONSTRAINT `fk_candidate_interaction_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`assessment` ADD CONSTRAINT `fk_candidate_assessment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`assessment` ADD CONSTRAINT `fk_candidate_assessment_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`assessment` ADD CONSTRAINT `fk_candidate_assessment_skill_requirement_id` FOREIGN KEY (`skill_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`skill_requirement`(`skill_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_rate_override_id` FOREIGN KEY (`rate_override_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`rate_override`(`rate_override_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`talent_pool_membership` ADD CONSTRAINT `fk_candidate_talent_pool_membership_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`talent_pool` ADD CONSTRAINT `fk_candidate_talent_pool_headcount_plan_id` FOREIGN KEY (`headcount_plan_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`headcount_plan`(`headcount_plan_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`talent_pool` ADD CONSTRAINT `fk_candidate_talent_pool_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);

-- ========= candidate --> payroll (6 constraint(s)) =========
-- Requires: candidate schema, payroll schema
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`orientation_session` ADD CONSTRAINT `fk_candidate_orientation_session_task_checklist_id` FOREIGN KEY (`task_checklist_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`task_checklist`(`task_checklist_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`assessment` ADD CONSTRAINT `fk_candidate_assessment_task_checklist_id` FOREIGN KEY (`task_checklist_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`task_checklist`(`task_checklist_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_burden_rate_id` FOREIGN KEY (`burden_rate_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`burden_rate`(`burden_rate_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_pay_rate_id` FOREIGN KEY (`pay_rate_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`pay_rate`(`pay_rate_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_wc_policy_id` FOREIGN KEY (`wc_policy_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`wc_policy`(`wc_policy_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`talent_pool_membership` ADD CONSTRAINT `fk_candidate_talent_pool_membership_task_checklist_id` FOREIGN KEY (`task_checklist_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`task_checklist`(`task_checklist_id`);

-- ========= candidate --> placement (5 constraint(s)) =========
-- Requires: candidate schema, placement schema
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`orientation_session` ADD CONSTRAINT `fk_candidate_orientation_session_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`interaction` ADD CONSTRAINT `fk_candidate_interaction_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`talent_pool_membership` ADD CONSTRAINT `fk_candidate_talent_pool_membership_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);

-- ========= candidate --> recruitment (5 constraint(s)) =========
-- Requires: candidate schema, recruitment schema
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`status_history` ADD CONSTRAINT `fk_candidate_status_history_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`submittal`(`submittal_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`interaction` ADD CONSTRAINT `fk_candidate_interaction_interview_id` FOREIGN KEY (`interview_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`interview`(`interview_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`assessment` ADD CONSTRAINT `fk_candidate_assessment_candidate_screening_id` FOREIGN KEY (`candidate_screening_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`candidate_screening`(`candidate_screening_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement` ADD CONSTRAINT `fk_candidate_pay_rate_agreement_hiring_decision_id` FOREIGN KEY (`hiring_decision_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision`(`hiring_decision_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_rtr_agreement_id` FOREIGN KEY (`rtr_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`rtr_agreement`(`rtr_agreement_id`);

-- ========= candidate --> vendor (3 constraint(s)) =========
-- Requires: candidate schema, vendor schema
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`orientation_session` ADD CONSTRAINT `fk_candidate_orientation_session_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`work_history` ADD CONSTRAINT `fk_candidate_work_history_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`candidate`.`right_to_represent` ADD CONSTRAINT `fk_candidate_right_to_represent_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);

-- ========= client --> contract (11 constraint(s)) =========
-- Requires: client schema, contract schema
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ADD CONSTRAINT `fk_client_account_hierarchy_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ADD CONSTRAINT `fk_client_client_rate_card_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ADD CONSTRAINT `fk_client_client_rate_card_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ADD CONSTRAINT `fk_client_vms_program_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ADD CONSTRAINT `fk_client_vms_program_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ADD CONSTRAINT `fk_client_engagement_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ADD CONSTRAINT `fk_client_program_supplier_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`nda`(`nda_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ADD CONSTRAINT `fk_client_program_supplier_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ADD CONSTRAINT `fk_client_sla_measurement_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ADD CONSTRAINT `fk_client_managed_program_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ADD CONSTRAINT `fk_client_managed_program_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);

-- ========= client --> credentialing (1 constraint(s)) =========
-- Requires: client schema, credentialing schema
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ADD CONSTRAINT `fk_client_program_supplier_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);

-- ========= client --> joborder (3 constraint(s)) =========
-- Requires: client schema, joborder schema
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ADD CONSTRAINT `fk_client_engagement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ADD CONSTRAINT `fk_client_account_segment_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ADD CONSTRAINT `fk_client_rate_card_line_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);

-- ========= client --> recruitment (1 constraint(s)) =========
-- Requires: client schema, recruitment schema
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ADD CONSTRAINT `fk_client_engagement_sourcing_campaign_id` FOREIGN KEY (`sourcing_campaign_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign`(`sourcing_campaign_id`);

-- ========= client --> vendor (3 constraint(s)) =========
-- Requires: client schema, vendor schema
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ADD CONSTRAINT `fk_client_engagement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ADD CONSTRAINT `fk_client_program_supplier_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ADD CONSTRAINT `fk_client_sla_measurement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);

-- ========= compliance --> candidate (7 constraint(s)) =========
-- Requires: compliance schema, candidate schema
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`i9_verification` ADD CONSTRAINT `fk_compliance_i9_verification_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);

-- ========= compliance --> client (24 constraint(s)) =========
-- Requires: compliance schema, client schema
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`eeoc_filing` ADD CONSTRAINT `fk_compliance_eeoc_filing_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`eeoc_filing` ADD CONSTRAINT `fk_compliance_eeoc_filing_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`eeoc_filing` ADD CONSTRAINT `fk_compliance_eeoc_filing_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);

-- ========= compliance --> contract (38 constraint(s)) =========
-- Requires: compliance schema, contract schema
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`i9_verification` ADD CONSTRAINT `fk_compliance_i9_verification_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`i9_verification` ADD CONSTRAINT `fk_compliance_i9_verification_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`i9_verification` ADD CONSTRAINT `fk_compliance_i9_verification_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`eeoc_filing` ADD CONSTRAINT `fk_compliance_eeoc_filing_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule` ADD CONSTRAINT `fk_compliance_state_compliance_rule_template_id` FOREIGN KEY (`template_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`template`(`template_id`);

-- ========= compliance --> credentialing (19 constraint(s)) =========
-- Requires: compliance schema, credentialing schema
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`i9_verification` ADD CONSTRAINT `fk_compliance_i9_verification_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`i9_verification` ADD CONSTRAINT `fk_compliance_i9_verification_work_authorization_id` FOREIGN KEY (`work_authorization_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`work_authorization`(`work_authorization_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_work_authorization_id` FOREIGN KEY (`work_authorization_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`work_authorization`(`work_authorization_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`training_record`(`training_record_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential`(`credential_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_drug_screen_id` FOREIGN KEY (`drug_screen_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`drug_screen`(`drug_screen_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_license_verification_id` FOREIGN KEY (`license_verification_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`license_verification`(`license_verification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_skills_assessment_id` FOREIGN KEY (`skills_assessment_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`skills_assessment`(`skills_assessment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`training_record`(`training_record_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule` ADD CONSTRAINT `fk_compliance_state_compliance_rule_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);

-- ========= compliance --> joborder (8 constraint(s)) =========
-- Requires: compliance schema, joborder schema
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`eeoc_filing` ADD CONSTRAINT `fk_compliance_eeoc_filing_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);

-- ========= compliance --> placement (6 constraint(s)) =========
-- Requires: compliance schema, placement schema
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`i9_verification` ADD CONSTRAINT `fk_compliance_i9_verification_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);

-- ========= compliance --> recruitment (1 constraint(s)) =========
-- Requires: compliance schema, recruitment schema
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement`(`onboarding_engagement_id`);

-- ========= compliance --> timesheet (1 constraint(s)) =========
-- Requires: compliance schema, timesheet schema
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_offboarding_record_id` FOREIGN KEY (`offboarding_record_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record`(`offboarding_record_id`);

-- ========= compliance --> vendor (9 constraint(s)) =========
-- Requires: compliance schema, vendor schema
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`i9_verification` ADD CONSTRAINT `fk_compliance_i9_verification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`everify_case` ADD CONSTRAINT `fk_compliance_everify_case_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`worker_classification` ADD CONSTRAINT `fk_compliance_worker_classification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`eeoc_filing` ADD CONSTRAINT `fk_compliance_eeoc_filing_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination` ADD CONSTRAINT `fk_compliance_wage_hour_determination_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check` ADD CONSTRAINT `fk_compliance_placement_compliance_check_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);

-- ========= contract --> candidate (2 constraint(s)) =========
-- Requires: contract schema, candidate schema
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`nda` ADD CONSTRAINT `fk_contract_nda_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`ic_agreement` ADD CONSTRAINT `fk_contract_ic_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);

-- ========= contract --> client (20 constraint(s)) =========
-- Requires: contract schema, client schema
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`msa` ADD CONSTRAINT `fk_contract_msa_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`msa` ADD CONSTRAINT `fk_contract_msa_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`nda` ADD CONSTRAINT `fk_contract_nda_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`sla` ADD CONSTRAINT `fk_contract_sla_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`sla` ADD CONSTRAINT `fk_contract_sla_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`sla` ADD CONSTRAINT `fk_contract_sla_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule` ADD CONSTRAINT `fk_contract_contract_rate_schedule_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule` ADD CONSTRAINT `fk_contract_contract_rate_schedule_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule` ADD CONSTRAINT `fk_contract_contract_rate_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule` ADD CONSTRAINT `fk_contract_contract_rate_schedule_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`vendor_agreement` ADD CONSTRAINT `fk_contract_vendor_agreement_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`vendor_agreement` ADD CONSTRAINT `fk_contract_vendor_agreement_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`ic_agreement` ADD CONSTRAINT `fk_contract_ic_agreement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`ic_agreement` ADD CONSTRAINT `fk_contract_ic_agreement_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);

-- ========= contract --> vendor (2 constraint(s)) =========
-- Requires: contract schema, vendor schema
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`nda` ADD CONSTRAINT `fk_contract_nda_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`contract`.`vendor_agreement` ADD CONSTRAINT `fk_contract_vendor_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);

-- ========= credentialing --> candidate (9 constraint(s)) =========
-- Requires: credentialing schema, candidate schema
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_instance` ADD CONSTRAINT `fk_credentialing_credential_instance_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`bgc_result` ADD CONSTRAINT `fk_credentialing_bgc_result_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`license_verification` ADD CONSTRAINT `fk_credentialing_license_verification_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`skills_assessment` ADD CONSTRAINT `fk_credentialing_skills_assessment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`training_record` ADD CONSTRAINT `fk_credentialing_training_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`work_authorization` ADD CONSTRAINT `fk_credentialing_work_authorization_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_document` ADD CONSTRAINT `fk_credentialing_credential_document_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);

-- ========= credentialing --> client (19 constraint(s)) =========
-- Requires: credentialing schema, client schema
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`license_verification` ADD CONSTRAINT `fk_credentialing_license_verification_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`license_verification` ADD CONSTRAINT `fk_credentialing_license_verification_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`skills_assessment` ADD CONSTRAINT `fk_credentialing_skills_assessment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`training_record` ADD CONSTRAINT `fk_credentialing_training_record_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`training_record` ADD CONSTRAINT `fk_credentialing_training_record_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`work_authorization` ADD CONSTRAINT `fk_credentialing_work_authorization_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_document` ADD CONSTRAINT `fk_credentialing_credential_document_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);

-- ========= credentialing --> compliance (1 constraint(s)) =========
-- Requires: credentialing schema, compliance schema
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_instance` ADD CONSTRAINT `fk_credentialing_credential_instance_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`requirement`(`requirement_id`);

-- ========= credentialing --> contract (20 constraint(s)) =========
-- Requires: credentialing schema, contract schema
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_instance` ADD CONSTRAINT `fk_credentialing_credential_instance_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`bgc_result` ADD CONSTRAINT `fk_credentialing_bgc_result_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`license_verification` ADD CONSTRAINT `fk_credentialing_license_verification_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`skills_assessment` ADD CONSTRAINT `fk_credentialing_skills_assessment_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`training_record` ADD CONSTRAINT `fk_credentialing_training_record_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`work_authorization` ADD CONSTRAINT `fk_credentialing_work_authorization_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_document` ADD CONSTRAINT `fk_credentialing_credential_document_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);

-- ========= credentialing --> joborder (10 constraint(s)) =========
-- Requires: credentialing schema, joborder schema
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`license_verification` ADD CONSTRAINT `fk_credentialing_license_verification_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`skills_assessment` ADD CONSTRAINT `fk_credentialing_skills_assessment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`skills_assessment` ADD CONSTRAINT `fk_credentialing_skills_assessment_skill_requirement_id` FOREIGN KEY (`skill_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`skill_requirement`(`skill_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement` ADD CONSTRAINT `fk_credentialing_credential_requirement_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_package` ADD CONSTRAINT `fk_credentialing_credential_package_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`credential_document` ADD CONSTRAINT `fk_credentialing_credential_document_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);

-- ========= credentialing --> placement (3 constraint(s)) =========
-- Requires: credentialing schema, placement schema
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`bgc_result` ADD CONSTRAINT `fk_credentialing_bgc_result_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`training_record` ADD CONSTRAINT `fk_credentialing_training_record_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);

-- ========= credentialing --> vendor (6 constraint(s)) =========
-- Requires: credentialing schema, vendor schema
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`bgc_order` ADD CONSTRAINT `fk_credentialing_bgc_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`bgc_result` ADD CONSTRAINT `fk_credentialing_bgc_result_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`drug_screen` ADD CONSTRAINT `fk_credentialing_drug_screen_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`license_verification` ADD CONSTRAINT `fk_credentialing_license_verification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`skills_assessment` ADD CONSTRAINT `fk_credentialing_skills_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`credentialing`.`training_record` ADD CONSTRAINT `fk_credentialing_training_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);

-- ========= joborder --> billing (1 constraint(s)) =========
-- Requires: joborder schema, billing schema
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= joborder --> candidate (2 constraint(s)) =========
-- Requires: joborder schema, candidate schema
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`tax_form_submission` ADD CONSTRAINT `fk_joborder_tax_form_submission_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_status_history` ADD CONSTRAINT `fk_joborder_order_status_history_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);

-- ========= joborder --> client (18 constraint(s)) =========
-- Requires: joborder schema, client schema
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`sla_commitment` ADD CONSTRAINT `fk_joborder_sla_commitment_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`sla_commitment` ADD CONSTRAINT `fk_joborder_sla_commitment_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_location` ADD CONSTRAINT `fk_joborder_order_location_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);

-- ========= joborder --> contract (19 constraint(s)) =========
-- Requires: joborder schema, contract schema
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`position_requirement` ADD CONSTRAINT `fk_joborder_position_requirement_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`position_requirement` ADD CONSTRAINT `fk_joborder_position_requirement_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`rate_override` ADD CONSTRAINT `fk_joborder_rate_override_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`rate_override` ADD CONSTRAINT `fk_joborder_rate_override_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`rate_override` ADD CONSTRAINT `fk_joborder_rate_override_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`sla_commitment` ADD CONSTRAINT `fk_joborder_sla_commitment_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`sla_commitment` ADD CONSTRAINT `fk_joborder_sla_commitment_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_extension` ADD CONSTRAINT `fk_joborder_order_extension_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_extension` ADD CONSTRAINT `fk_joborder_order_extension_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_extension` ADD CONSTRAINT `fk_joborder_order_extension_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);

-- ========= joborder --> credentialing (1 constraint(s)) =========
-- Requires: joborder schema, credentialing schema
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`position_requirement` ADD CONSTRAINT `fk_joborder_position_requirement_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);

-- ========= joborder --> placement (3 constraint(s)) =========
-- Requires: joborder schema, placement schema
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`tax_form_submission` ADD CONSTRAINT `fk_joborder_tax_form_submission_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_status_history` ADD CONSTRAINT `fk_joborder_order_status_history_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_extension` ADD CONSTRAINT `fk_joborder_order_extension_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);

-- ========= joborder --> recruitment (2 constraint(s)) =========
-- Requires: joborder schema, recruitment schema
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`tax_form_submission` ADD CONSTRAINT `fk_joborder_tax_form_submission_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`tax_form_submission` ADD CONSTRAINT `fk_joborder_tax_form_submission_task_assignment_id` FOREIGN KEY (`task_assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`task_assignment`(`task_assignment_id`);

-- ========= joborder --> vendor (19 constraint(s)) =========
-- Requires: joborder schema, vendor schema
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_preferred_supplier_list_id` FOREIGN KEY (`preferred_supplier_list_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`preferred_supplier_list`(`preferred_supplier_list_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_sow_agreement_id` FOREIGN KEY (`sow_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`sow_agreement`(`sow_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_header` ADD CONSTRAINT `fk_joborder_order_header_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`rate_override` ADD CONSTRAINT `fk_joborder_rate_override_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`rate_override` ADD CONSTRAINT `fk_joborder_rate_override_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`sla_commitment` ADD CONSTRAINT `fk_joborder_sla_commitment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`sla_commitment` ADD CONSTRAINT `fk_joborder_sla_commitment_tier_classification_id` FOREIGN KEY (`tier_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`tier_classification`(`tier_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_status_history` ADD CONSTRAINT `fk_joborder_order_status_history_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`fulfillment_team` ADD CONSTRAINT `fk_joborder_fulfillment_team_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_program_allocation_id` FOREIGN KEY (`program_allocation_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`program_allocation`(`program_allocation_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_tier_classification_id` FOREIGN KEY (`tier_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`tier_classification`(`tier_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_vms_enrollment_id` FOREIGN KEY (`vms_enrollment_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vms_enrollment`(`vms_enrollment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_extension` ADD CONSTRAINT `fk_joborder_order_extension_sow_agreement_id` FOREIGN KEY (`sow_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`sow_agreement`(`sow_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`order_extension` ADD CONSTRAINT `fk_joborder_order_extension_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_tier_classification_id` FOREIGN KEY (`tier_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`tier_classification`(`tier_classification_id`);

-- ========= payroll --> candidate (8 constraint(s)) =========
-- Requires: payroll schema, candidate schema
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_line` ADD CONSTRAINT `fk_payroll_tax_line_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`deduction_line` ADD CONSTRAINT `fk_payroll_deduction_line_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_form` ADD CONSTRAINT `fk_payroll_tax_form_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_withholding_election` ADD CONSTRAINT `fk_payroll_tax_withholding_election_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`document_collection` ADD CONSTRAINT `fk_payroll_document_collection_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);

-- ========= payroll --> client (15 constraint(s)) =========
-- Requires: payroll schema, client schema
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_filing` ADD CONSTRAINT `fk_payroll_tax_filing_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`task_checklist` ADD CONSTRAINT `fk_payroll_task_checklist_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`task_checklist` ADD CONSTRAINT `fk_payroll_task_checklist_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`task_checklist` ADD CONSTRAINT `fk_payroll_task_checklist_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`task_checklist` ADD CONSTRAINT `fk_payroll_task_checklist_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);

-- ========= payroll --> compliance (23 constraint(s)) =========
-- Requires: payroll schema, compliance schema
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_everify_case_id` FOREIGN KEY (`everify_case_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`everify_case`(`everify_case_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_i9_verification_id` FOREIGN KEY (`i9_verification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`i9_verification`(`i9_verification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_line` ADD CONSTRAINT `fk_payroll_tax_line_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`deduction_line` ADD CONSTRAINT `fk_payroll_deduction_line_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_filing` ADD CONSTRAINT `fk_payroll_tax_filing_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_filing` ADD CONSTRAINT `fk_payroll_tax_filing_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_form` ADD CONSTRAINT `fk_payroll_tax_form_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_withholding_election` ADD CONSTRAINT `fk_payroll_tax_withholding_election_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_withholding_election` ADD CONSTRAINT `fk_payroll_tax_withholding_election_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`task_checklist` ADD CONSTRAINT `fk_payroll_task_checklist_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`document_collection` ADD CONSTRAINT `fk_payroll_document_collection_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);

-- ========= payroll --> contract (20 constraint(s)) =========
-- Requires: payroll schema, contract schema
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_filing` ADD CONSTRAINT `fk_payroll_tax_filing_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_form` ADD CONSTRAINT `fk_payroll_tax_form_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_form` ADD CONSTRAINT `fk_payroll_tax_form_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_withholding_election` ADD CONSTRAINT `fk_payroll_tax_withholding_election_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`task_checklist` ADD CONSTRAINT `fk_payroll_task_checklist_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`task_checklist` ADD CONSTRAINT `fk_payroll_task_checklist_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`document_collection` ADD CONSTRAINT `fk_payroll_document_collection_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`document_collection` ADD CONSTRAINT `fk_payroll_document_collection_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`nda`(`nda_id`);

-- ========= payroll --> credentialing (13 constraint(s)) =========
-- Requires: payroll schema, credentialing schema
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_work_authorization_id` FOREIGN KEY (`work_authorization_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`work_authorization`(`work_authorization_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_work_authorization_id` FOREIGN KEY (`work_authorization_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`work_authorization`(`work_authorization_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`training_record`(`training_record_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_form` ADD CONSTRAINT `fk_payroll_tax_form_work_authorization_id` FOREIGN KEY (`work_authorization_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`work_authorization`(`work_authorization_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`task_checklist` ADD CONSTRAINT `fk_payroll_task_checklist_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`document_collection` ADD CONSTRAINT `fk_payroll_document_collection_credential_document_id` FOREIGN KEY (`credential_document_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_document`(`credential_document_id`);

-- ========= payroll --> joborder (11 constraint(s)) =========
-- Requires: payroll schema, joborder schema
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`task_checklist` ADD CONSTRAINT `fk_payroll_task_checklist_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);

-- ========= payroll --> placement (25 constraint(s)) =========
-- Requires: payroll schema, placement schema
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`rate`(`rate_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`deduction_line` ADD CONSTRAINT `fk_payroll_deduction_line_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_form` ADD CONSTRAINT `fk_payroll_tax_form_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_form` ADD CONSTRAINT `fk_payroll_tax_form_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_withholding_election` ADD CONSTRAINT `fk_payroll_tax_withholding_election_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_withholding_election` ADD CONSTRAINT `fk_payroll_tax_withholding_election_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_withholding_election` ADD CONSTRAINT `fk_payroll_tax_withholding_election_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`task_checklist` ADD CONSTRAINT `fk_payroll_task_checklist_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`document_collection` ADD CONSTRAINT `fk_payroll_document_collection_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`document_collection` ADD CONSTRAINT `fk_payroll_document_collection_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`document_collection` ADD CONSTRAINT `fk_payroll_document_collection_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);

-- ========= payroll --> recruitment (6 constraint(s)) =========
-- Requires: payroll schema, recruitment schema
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_hiring_decision_id` FOREIGN KEY (`hiring_decision_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision`(`hiring_decision_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_withholding_election` ADD CONSTRAINT `fk_payroll_tax_withholding_election_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`document_collection` ADD CONSTRAINT `fk_payroll_document_collection_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement`(`onboarding_engagement_id`);

-- ========= payroll --> timesheet (10 constraint(s)) =========
-- Requires: payroll schema, timesheet schema
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_run` ADD CONSTRAINT `fk_payroll_pay_run_pay_period_id` FOREIGN KEY (`pay_period_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`pay_period`(`pay_period_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_direct_deposit_setup_id` FOREIGN KEY (`direct_deposit_setup_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`direct_deposit_setup`(`direct_deposit_setup_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_pay_period_id` FOREIGN KEY (`pay_period_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`pay_period`(`pay_period_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`timesheet`(`timesheet_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_labor_category_id` FOREIGN KEY (`labor_category_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`labor_category`(`labor_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_absence_record_id` FOREIGN KEY (`absence_record_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`absence_record`(`absence_record_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_time_entry_id` FOREIGN KEY (`time_entry_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`time_entry`(`time_entry_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`earnings_line` ADD CONSTRAINT `fk_payroll_earnings_line_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`timesheet`(`timesheet_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`deduction_line` ADD CONSTRAINT `fk_payroll_deduction_line_pay_period_id` FOREIGN KEY (`pay_period_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`pay_period`(`pay_period_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`document_collection` ADD CONSTRAINT `fk_payroll_document_collection_offboarding_record_id` FOREIGN KEY (`offboarding_record_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record`(`offboarding_record_id`);

-- ========= payroll --> vendor (9 constraint(s)) =========
-- Requires: payroll schema, vendor schema
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_stub` ADD CONSTRAINT `fk_payroll_pay_stub_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`pay_rate` ADD CONSTRAINT `fk_payroll_pay_rate_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`burden_rate` ADD CONSTRAINT `fk_payroll_burden_rate_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`wc_policy` ADD CONSTRAINT `fk_payroll_wc_policy_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_filing` ADD CONSTRAINT `fk_payroll_tax_filing_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`payroll`.`tax_form` ADD CONSTRAINT `fk_payroll_tax_form_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);

-- ========= placement --> billing (9 constraint(s)) =========
-- Requires: placement schema, billing schema
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_bill_rate_id` FOREIGN KEY (`bill_rate_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`bill_rate`(`bill_rate_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_placement_fee_id` FOREIGN KEY (`placement_fee_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`placement_fee`(`placement_fee_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);

-- ========= placement --> candidate (16 constraint(s)) =========
-- Requires: placement schema, candidate schema
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_right_to_represent_id` FOREIGN KEY (`right_to_represent_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`right_to_represent`(`right_to_represent_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_talent_pool_id` FOREIGN KEY (`talent_pool_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`talent_pool`(`talent_pool_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_right_to_represent_id` FOREIGN KEY (`right_to_represent_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`right_to_represent`(`right_to_represent_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_status_history` ADD CONSTRAINT `fk_placement_assignment_status_history_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_availability_id` FOREIGN KEY (`availability_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`availability`(`availability_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_talent_pool_id` FOREIGN KEY (`talent_pool_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`talent_pool`(`talent_pool_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_right_to_represent_id` FOREIGN KEY (`right_to_represent_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`right_to_represent`(`right_to_represent_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_compliance` ADD CONSTRAINT `fk_placement_assignment_compliance_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`assessment`(`assessment_id`);

-- ========= placement --> client (21 constraint(s)) =========
-- Requires: placement schema, client schema
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_status_history` ADD CONSTRAINT `fk_placement_assignment_status_history_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_status_history` ADD CONSTRAINT `fk_placement_assignment_status_history_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_target_client_client_account_id` FOREIGN KEY (`target_client_client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`work_location` ADD CONSTRAINT `fk_placement_work_location_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`work_location` ADD CONSTRAINT `fk_placement_work_location_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`supervisor` ADD CONSTRAINT `fk_placement_supervisor_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`supervisor` ADD CONSTRAINT `fk_placement_supervisor_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`supervisor` ADD CONSTRAINT `fk_placement_supervisor_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`supervisor` ADD CONSTRAINT `fk_placement_supervisor_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);

-- ========= placement --> compliance (14 constraint(s)) =========
-- Requires: placement schema, compliance schema
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`rate` ADD CONSTRAINT `fk_placement_rate_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`work_location` ADD CONSTRAINT `fk_placement_work_location_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_compliance` ADD CONSTRAINT `fk_placement_assignment_compliance_primary_assignment_requirement_id` FOREIGN KEY (`primary_assignment_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_compliance` ADD CONSTRAINT `fk_placement_assignment_compliance_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_compliance` ADD CONSTRAINT `fk_placement_assignment_compliance_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);

-- ========= placement --> contract (23 constraint(s)) =========
-- Requires: placement schema, contract schema
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`rate` ADD CONSTRAINT `fk_placement_rate_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`work_location` ADD CONSTRAINT `fk_placement_work_location_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`supervisor` ADD CONSTRAINT `fk_placement_supervisor_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`nda`(`nda_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);

-- ========= placement --> credentialing (12 constraint(s)) =========
-- Requires: placement schema, credentialing schema
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_work_authorization_id` FOREIGN KEY (`work_authorization_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`work_authorization`(`work_authorization_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_work_authorization_id` FOREIGN KEY (`work_authorization_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`work_authorization`(`work_authorization_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_compliance` ADD CONSTRAINT `fk_placement_assignment_compliance_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);

-- ========= placement --> joborder (18 constraint(s)) =========
-- Requires: placement schema, joborder schema
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_fulfillment_team_id` FOREIGN KEY (`fulfillment_team_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`fulfillment_team`(`fulfillment_team_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_vms_order_id` FOREIGN KEY (`vms_order_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`vms_order`(`vms_order_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_fulfillment_team_id` FOREIGN KEY (`fulfillment_team_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`fulfillment_team`(`fulfillment_team_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_order_extension_id` FOREIGN KEY (`order_extension_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_extension`(`order_extension_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_status_history` ADD CONSTRAINT `fk_placement_assignment_status_history_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`work_location` ADD CONSTRAINT `fk_placement_work_location_order_location_id` FOREIGN KEY (`order_location_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_location`(`order_location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_vms_order_id` FOREIGN KEY (`vms_order_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`vms_order`(`vms_order_id`);

-- ========= placement --> recruitment (19 constraint(s)) =========
-- Requires: placement schema, recruitment schema
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_hiring_decision_id` FOREIGN KEY (`hiring_decision_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision`(`hiring_decision_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`submittal`(`submittal_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_hiring_decision_id` FOREIGN KEY (`hiring_decision_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision`(`hiring_decision_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_hiring_decision_id` FOREIGN KEY (`hiring_decision_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision`(`hiring_decision_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`submittal`(`submittal_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_status_history` ADD CONSTRAINT `fk_placement_assignment_status_history_req_pipeline_id` FOREIGN KEY (`req_pipeline_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline`(`req_pipeline_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_recruiter_assignment_id` FOREIGN KEY (`recruiter_assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment`(`recruiter_assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_req_pipeline_id` FOREIGN KEY (`req_pipeline_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline`(`req_pipeline_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`submittal`(`submittal_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_hiring_decision_id` FOREIGN KEY (`hiring_decision_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision`(`hiring_decision_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_req_pipeline_id` FOREIGN KEY (`req_pipeline_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline`(`req_pipeline_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`submittal`(`submittal_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_req_pipeline_id` FOREIGN KEY (`req_pipeline_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline`(`req_pipeline_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_hiring_decision_id` FOREIGN KEY (`hiring_decision_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision`(`hiring_decision_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_interview_feedback_id` FOREIGN KEY (`interview_feedback_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`interview_feedback`(`interview_feedback_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_req_pipeline_id` FOREIGN KEY (`req_pipeline_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline`(`req_pipeline_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`submittal`(`submittal_id`);

-- ========= placement --> timesheet (8 constraint(s)) =========
-- Requires: placement schema, timesheet schema
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_labor_category_id` FOREIGN KEY (`labor_category_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`labor_category`(`labor_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_pay_period_id` FOREIGN KEY (`pay_period_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`pay_period`(`pay_period_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_pay_period_id` FOREIGN KEY (`pay_period_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`pay_period`(`pay_period_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_pay_period_id` FOREIGN KEY (`pay_period_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`pay_period`(`pay_period_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`rate` ADD CONSTRAINT `fk_placement_rate_labor_category_id` FOREIGN KEY (`labor_category_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`labor_category`(`labor_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`rate` ADD CONSTRAINT `fk_placement_rate_pay_period_id` FOREIGN KEY (`pay_period_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`pay_period`(`pay_period_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`work_location` ADD CONSTRAINT `fk_placement_work_location_ot_rule_id` FOREIGN KEY (`ot_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`ot_rule`(`ot_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_pay_period_id` FOREIGN KEY (`pay_period_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`pay_period`(`pay_period_id`);

-- ========= placement --> vendor (15 constraint(s)) =========
-- Requires: placement schema, vendor schema
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment` ADD CONSTRAINT `fk_placement_assignment_tier_classification_id` FOREIGN KEY (`tier_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`tier_classification`(`tier_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`direct_hire` ADD CONSTRAINT `fk_placement_direct_hire_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`assignment_extension` ADD CONSTRAINT `fk_placement_assignment_extension_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`conversion` ADD CONSTRAINT `fk_placement_conversion_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`redeployment` ADD CONSTRAINT `fk_placement_redeployment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`rate` ADD CONSTRAINT `fk_placement_rate_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`supervisor` ADD CONSTRAINT `fk_placement_supervisor_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`fall_off` ADD CONSTRAINT `fk_placement_fall_off_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_sow_agreement_id` FOREIGN KEY (`sow_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`sow_agreement`(`sow_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`sow_engagement` ADD CONSTRAINT `fk_placement_sow_engagement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`placement`.`offer` ADD CONSTRAINT `fk_placement_offer_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);

-- ========= recruitment --> candidate (17 constraint(s)) =========
-- Requires: recruitment schema, candidate schema
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_orientation_session_id` FOREIGN KEY (`orientation_session_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`orientation_session`(`orientation_session_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_orientation_session_id` FOREIGN KEY (`orientation_session_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`orientation_session`(`orientation_session_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`status_event` ADD CONSTRAINT `fk_recruitment_status_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_talent_pool_id` FOREIGN KEY (`talent_pool_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`talent_pool`(`talent_pool_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_resume_id` FOREIGN KEY (`resume_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`resume`(`resume_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`interview_feedback` ADD CONSTRAINT `fk_recruitment_interview_feedback_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`candidate_screening` ADD CONSTRAINT `fk_recruitment_candidate_screening_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_referral_referrer_candidate_profile_id` FOREIGN KEY (`referral_referrer_candidate_profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);

-- ========= recruitment --> client (37 constraint(s)) =========
-- Requires: recruitment schema, client schema
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_program_supplier_id` FOREIGN KEY (`program_supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`program_supplier`(`program_supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_rate_card_line_id` FOREIGN KEY (`rate_card_line_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`rate_card_line`(`rate_card_line_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`interview_feedback` ADD CONSTRAINT `fk_recruitment_interview_feedback_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_rate_card_line_id` FOREIGN KEY (`rate_card_line_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`rate_card_line`(`rate_card_line_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_program_supplier_id` FOREIGN KEY (`program_supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`program_supplier`(`program_supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);

-- ========= recruitment --> compliance (17 constraint(s)) =========
-- Requires: recruitment schema, compliance schema
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_i9_verification_id` FOREIGN KEY (`i9_verification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`i9_verification`(`i9_verification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_i9_verification_id` FOREIGN KEY (`i9_verification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`i9_verification`(`i9_verification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`candidate_screening` ADD CONSTRAINT `fk_recruitment_candidate_screening_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`candidate_screening` ADD CONSTRAINT `fk_recruitment_candidate_screening_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);

-- ========= recruitment --> contract (23 constraint(s)) =========
-- Requires: recruitment schema, contract schema
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`status_event` ADD CONSTRAINT `fk_recruitment_status_event_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`nda`(`nda_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);

-- ========= recruitment --> credentialing (38 constraint(s)) =========
-- Requires: recruitment schema, credentialing schema
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_work_authorization_id` FOREIGN KEY (`work_authorization_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`work_authorization`(`work_authorization_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_drug_screen_id` FOREIGN KEY (`drug_screen_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`drug_screen`(`drug_screen_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_license_verification_id` FOREIGN KEY (`license_verification_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`license_verification`(`license_verification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_skills_assessment_id` FOREIGN KEY (`skills_assessment_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`skills_assessment`(`skills_assessment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`training_record`(`training_record_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`status_event` ADD CONSTRAINT `fk_recruitment_status_event_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`status_event` ADD CONSTRAINT `fk_recruitment_status_event_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`status_event` ADD CONSTRAINT `fk_recruitment_status_event_drug_screen_id` FOREIGN KEY (`drug_screen_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`drug_screen`(`drug_screen_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`status_event` ADD CONSTRAINT `fk_recruitment_status_event_license_verification_id` FOREIGN KEY (`license_verification_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`license_verification`(`license_verification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`status_event` ADD CONSTRAINT `fk_recruitment_status_event_work_authorization_id` FOREIGN KEY (`work_authorization_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`work_authorization`(`work_authorization_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_work_authorization_id` FOREIGN KEY (`work_authorization_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`work_authorization`(`work_authorization_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_license_verification_id` FOREIGN KEY (`license_verification_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`license_verification`(`license_verification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_work_authorization_id` FOREIGN KEY (`work_authorization_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`work_authorization`(`work_authorization_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_work_authorization_id` FOREIGN KEY (`work_authorization_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`work_authorization`(`work_authorization_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_bgc_order_id` FOREIGN KEY (`bgc_order_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`bgc_order`(`bgc_order_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`candidate_screening` ADD CONSTRAINT `fk_recruitment_candidate_screening_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`candidate_screening` ADD CONSTRAINT `fk_recruitment_candidate_screening_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`candidate_screening` ADD CONSTRAINT `fk_recruitment_candidate_screening_work_authorization_id` FOREIGN KEY (`work_authorization_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`work_authorization`(`work_authorization_id`);

-- ========= recruitment --> joborder (24 constraint(s)) =========
-- Requires: recruitment schema, joborder schema
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_headcount_plan_id` FOREIGN KEY (`headcount_plan_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`headcount_plan`(`headcount_plan_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_order_location_id` FOREIGN KEY (`order_location_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_location`(`order_location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_submittal_req_order_header_id` FOREIGN KEY (`submittal_req_order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`interview_feedback` ADD CONSTRAINT `fk_recruitment_interview_feedback_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`candidate_screening` ADD CONSTRAINT `fk_recruitment_candidate_screening_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`candidate_screening` ADD CONSTRAINT `fk_recruitment_candidate_screening_position_requirement_id` FOREIGN KEY (`position_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`position_requirement`(`position_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`candidate_screening` ADD CONSTRAINT `fk_recruitment_candidate_screening_skill_requirement_id` FOREIGN KEY (`skill_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`skill_requirement`(`skill_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);

-- ========= recruitment --> payroll (4 constraint(s)) =========
-- Requires: recruitment schema, payroll schema
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_task_checklist_id` FOREIGN KEY (`task_checklist_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`task_checklist`(`task_checklist_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_document_collection_id` FOREIGN KEY (`document_collection_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`document_collection`(`document_collection_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_task_checklist_id` FOREIGN KEY (`task_checklist_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`task_checklist`(`task_checklist_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`status_event` ADD CONSTRAINT `fk_recruitment_status_event_document_collection_id` FOREIGN KEY (`document_collection_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`document_collection`(`document_collection_id`);

-- ========= recruitment --> placement (7 constraint(s)) =========
-- Requires: recruitment schema, placement schema
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`status_event` ADD CONSTRAINT `fk_recruitment_status_event_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`interview_feedback` ADD CONSTRAINT `fk_recruitment_interview_feedback_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);

-- ========= recruitment --> timesheet (7 constraint(s)) =========
-- Requires: recruitment schema, timesheet schema
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_direct_deposit_setup_id` FOREIGN KEY (`direct_deposit_setup_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`direct_deposit_setup`(`direct_deposit_setup_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`shift`(`shift_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_offboarding_record_id` FOREIGN KEY (`offboarding_record_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record`(`offboarding_record_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`task_assignment` ADD CONSTRAINT `fk_recruitment_task_assignment_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`schedule`(`schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`status_event` ADD CONSTRAINT `fk_recruitment_status_event_offboarding_record_id` FOREIGN KEY (`offboarding_record_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record`(`offboarding_record_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_labor_category_id` FOREIGN KEY (`labor_category_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`labor_category`(`labor_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_labor_category_id` FOREIGN KEY (`labor_category_id`) REFERENCES `staffing_hr_ecm_v1`.`timesheet`.`labor_category`(`labor_category_id`);

-- ========= recruitment --> vendor (23 constraint(s)) =========
-- Requires: recruitment schema, vendor schema
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_sow_agreement_id` FOREIGN KEY (`sow_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`sow_agreement`(`sow_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_vendor_contact_id` FOREIGN KEY (`vendor_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vendor_contact`(`vendor_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement` ADD CONSTRAINT `fk_recruitment_onboarding_engagement_vms_enrollment_id` FOREIGN KEY (`vms_enrollment_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vms_enrollment`(`vms_enrollment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign` ADD CONSTRAINT `fk_recruitment_sourcing_campaign_vms_enrollment_id` FOREIGN KEY (`vms_enrollment_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vms_enrollment`(`vms_enrollment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`job_posting` ADD CONSTRAINT `fk_recruitment_job_posting_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_sow_agreement_id` FOREIGN KEY (`sow_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`sow_agreement`(`sow_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`submittal` ADD CONSTRAINT `fk_recruitment_submittal_vendor_contact_id` FOREIGN KEY (`vendor_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vendor_contact`(`vendor_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`rtr_agreement` ADD CONSTRAINT `fk_recruitment_rtr_agreement_vendor_contact_id` FOREIGN KEY (`vendor_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vendor_contact`(`vendor_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`interview` ADD CONSTRAINT `fk_recruitment_interview_vendor_contact_id` FOREIGN KEY (`vendor_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vendor_contact`(`vendor_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`hiring_decision` ADD CONSTRAINT `fk_recruitment_hiring_decision_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`req_pipeline` ADD CONSTRAINT `fk_recruitment_req_pipeline_tier_classification_id` FOREIGN KEY (`tier_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`tier_classification`(`tier_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`candidate_screening` ADD CONSTRAINT `fk_recruitment_candidate_screening_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment` ADD CONSTRAINT `fk_recruitment_recruiter_assignment_vms_enrollment_id` FOREIGN KEY (`vms_enrollment_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vms_enrollment`(`vms_enrollment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`recruitment`.`referral` ADD CONSTRAINT `fk_recruitment_referral_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);

-- ========= timesheet --> billing (7 constraint(s)) =========
-- Requires: timesheet schema, billing schema
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_credit_memo_id` FOREIGN KEY (`credit_memo_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`credit_memo`(`credit_memo_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`dispute`(`dispute_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_placement_fee_id` FOREIGN KEY (`placement_fee_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`placement_fee`(`placement_fee_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_bill_rate_id` FOREIGN KEY (`bill_rate_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`bill_rate`(`bill_rate_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approval_workflow` ADD CONSTRAINT `fk_timesheet_approval_workflow_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= timesheet --> candidate (14 constraint(s)) =========
-- Requires: timesheet schema, candidate schema
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`labor_category` ADD CONSTRAINT `fk_timesheet_labor_category_skill_id` FOREIGN KEY (`skill_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`skill`(`skill_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`direct_deposit_setup` ADD CONSTRAINT `fk_timesheet_direct_deposit_setup_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_pay_rate_agreement_id` FOREIGN KEY (`pay_rate_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement`(`pay_rate_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_right_to_represent_id` FOREIGN KEY (`right_to_represent_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`right_to_represent`(`right_to_represent_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approval_workflow` ADD CONSTRAINT `fk_timesheet_approval_workflow_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`absence_record` ADD CONSTRAINT `fk_timesheet_absence_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_availability_id` FOREIGN KEY (`availability_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`availability`(`availability_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `staffing_hr_ecm_v1`.`candidate`.`profile`(`profile_id`);

-- ========= timesheet --> client (21 constraint(s)) =========
-- Requires: timesheet schema, client schema
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`labor_category` ADD CONSTRAINT `fk_timesheet_labor_category_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approval_workflow` ADD CONSTRAINT `fk_timesheet_approval_workflow_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approval_workflow` ADD CONSTRAINT `fk_timesheet_approval_workflow_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approval_workflow` ADD CONSTRAINT `fk_timesheet_approval_workflow_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`absence_record` ADD CONSTRAINT `fk_timesheet_absence_record_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`absence_record` ADD CONSTRAINT `fk_timesheet_absence_record_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`absence_record` ADD CONSTRAINT `fk_timesheet_absence_record_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);

-- ========= timesheet --> compliance (20 constraint(s)) =========
-- Requires: timesheet schema, compliance schema
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`labor_category` ADD CONSTRAINT `fk_timesheet_labor_category_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_placement_compliance_check_id` FOREIGN KEY (`placement_compliance_check_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check`(`placement_compliance_check_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_i9_verification_id` FOREIGN KEY (`i9_verification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`i9_verification`(`i9_verification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`absence_record` ADD CONSTRAINT `fk_timesheet_absence_record_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`absence_record` ADD CONSTRAINT `fk_timesheet_absence_record_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_worker_classification_id` FOREIGN KEY (`worker_classification_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`worker_classification`(`worker_classification_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`ot_rule` ADD CONSTRAINT `fk_timesheet_ot_rule_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`ot_rule` ADD CONSTRAINT `fk_timesheet_ot_rule_wage_hour_determination_id` FOREIGN KEY (`wage_hour_determination_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`(`wage_hour_determination_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`pay_period` ADD CONSTRAINT `fk_timesheet_pay_period_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);

-- ========= timesheet --> contract (12 constraint(s)) =========
-- Requires: timesheet schema, contract schema
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`labor_category` ADD CONSTRAINT `fk_timesheet_labor_category_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_ic_agreement_id` FOREIGN KEY (`ic_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`ic_agreement`(`ic_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approval_workflow` ADD CONSTRAINT `fk_timesheet_approval_workflow_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);

-- ========= timesheet --> credentialing (4 constraint(s)) =========
-- Requires: timesheet schema, credentialing schema
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`labor_category` ADD CONSTRAINT `fk_timesheet_labor_category_credential_requirement_id` FOREIGN KEY (`credential_requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`(`credential_requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_credential_instance_id` FOREIGN KEY (`credential_instance_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_instance`(`credential_instance_id`);

-- ========= timesheet --> joborder (9 constraint(s)) =========
-- Requires: timesheet schema, joborder schema
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_rate_override_id` FOREIGN KEY (`rate_override_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`rate_override`(`rate_override_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`labor_category` ADD CONSTRAINT `fk_timesheet_labor_category_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_order_location_id` FOREIGN KEY (`order_location_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_location`(`order_location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approval_workflow` ADD CONSTRAINT `fk_timesheet_approval_workflow_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm_v1`.`joborder`.`order_header`(`order_header_id`);

-- ========= timesheet --> payroll (10 constraint(s)) =========
-- Requires: timesheet schema, payroll schema
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_pay_stub_id` FOREIGN KEY (`pay_stub_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`pay_stub`(`pay_stub_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_earnings_line_id` FOREIGN KEY (`earnings_line_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`earnings_line`(`earnings_line_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_pay_run_id` FOREIGN KEY (`pay_run_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`pay_run`(`pay_run_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`labor_category` ADD CONSTRAINT `fk_timesheet_labor_category_burden_rate_id` FOREIGN KEY (`burden_rate_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`burden_rate`(`burden_rate_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_task_checklist_id` FOREIGN KEY (`task_checklist_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`task_checklist`(`task_checklist_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_pay_rate_id` FOREIGN KEY (`pay_rate_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`pay_rate`(`pay_rate_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_pay_run_id` FOREIGN KEY (`pay_run_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`pay_run`(`pay_run_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approval_workflow` ADD CONSTRAINT `fk_timesheet_approval_workflow_pay_run_id` FOREIGN KEY (`pay_run_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`pay_run`(`pay_run_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`absence_record` ADD CONSTRAINT `fk_timesheet_absence_record_pay_run_id` FOREIGN KEY (`pay_run_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`pay_run`(`pay_run_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_pay_rate_id` FOREIGN KEY (`pay_rate_id`) REFERENCES `staffing_hr_ecm_v1`.`payroll`.`pay_rate`(`pay_rate_id`);

-- ========= timesheet --> placement (25 constraint(s)) =========
-- Requires: timesheet schema, placement schema
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`direct_deposit_setup` ADD CONSTRAINT `fk_timesheet_direct_deposit_setup_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`direct_deposit_setup` ADD CONSTRAINT `fk_timesheet_direct_deposit_setup_direct_hire_id` FOREIGN KEY (`direct_hire_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`direct_hire`(`direct_hire_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`time_entry` ADD CONSTRAINT `fk_timesheet_time_entry_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approval_workflow` ADD CONSTRAINT `fk_timesheet_approval_workflow_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approval_workflow` ADD CONSTRAINT `fk_timesheet_approval_workflow_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`absence_record` ADD CONSTRAINT `fk_timesheet_absence_record_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`absence_record` ADD CONSTRAINT `fk_timesheet_absence_record_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_supervisor_id` FOREIGN KEY (`supervisor_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`supervisor`(`supervisor_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`schedule` ADD CONSTRAINT `fk_timesheet_schedule_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`work_location`(`work_location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`assignment`(`assignment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_sow_engagement_id` FOREIGN KEY (`sow_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`sow_engagement`(`sow_engagement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`shift` ADD CONSTRAINT `fk_timesheet_shift_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `staffing_hr_ecm_v1`.`placement`.`work_location`(`work_location_id`);

-- ========= timesheet --> recruitment (1 constraint(s)) =========
-- Requires: timesheet schema, recruitment schema
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`direct_deposit_setup` ADD CONSTRAINT `fk_timesheet_direct_deposit_setup_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement`(`onboarding_engagement_id`);

-- ========= timesheet --> vendor (10 constraint(s)) =========
-- Requires: timesheet schema, vendor schema
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approved_hours_summary` ADD CONSTRAINT `fk_timesheet_approved_hours_summary_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`adjustment` ADD CONSTRAINT `fk_timesheet_adjustment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`labor_category` ADD CONSTRAINT `fk_timesheet_labor_category_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`offboarding_record` ADD CONSTRAINT `fk_timesheet_offboarding_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_sow_agreement_id` FOREIGN KEY (`sow_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`sow_agreement`(`sow_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`timesheet` ADD CONSTRAINT `fk_timesheet_timesheet_vms_enrollment_id` FOREIGN KEY (`vms_enrollment_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`vms_enrollment`(`vms_enrollment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`timesheet`.`approval_workflow` ADD CONSTRAINT `fk_timesheet_approval_workflow_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `staffing_hr_ecm_v1`.`vendor`.`supplier`(`supplier_id`);

-- ========= vendor --> client (23 constraint(s)) =========
-- Requires: vendor schema, client schema
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`tier_classification` ADD CONSTRAINT `fk_vendor_tier_classification_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vms_enrollment` ADD CONSTRAINT `fk_vendor_vms_enrollment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vms_enrollment` ADD CONSTRAINT `fk_vendor_vms_enrollment_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vms_enrollment` ADD CONSTRAINT `fk_vendor_vms_enrollment_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vms_enrollment` ADD CONSTRAINT `fk_vendor_vms_enrollment_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vendor_rate_card` ADD CONSTRAINT `fk_vendor_vendor_rate_card_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`rate_agreement` ADD CONSTRAINT `fk_vendor_rate_agreement_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vendor_contact` ADD CONSTRAINT `fk_vendor_vendor_contact_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`program_allocation` ADD CONSTRAINT `fk_vendor_program_allocation_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`program_allocation` ADD CONSTRAINT `fk_vendor_program_allocation_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`program_allocation` ADD CONSTRAINT `fk_vendor_program_allocation_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`preferred_supplier_list` ADD CONSTRAINT `fk_vendor_preferred_supplier_list_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_rate_card`(`client_rate_card_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`preferred_supplier_list` ADD CONSTRAINT `fk_vendor_preferred_supplier_list_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`preferred_supplier_list` ADD CONSTRAINT `fk_vendor_preferred_supplier_list_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`diversity_certification` ADD CONSTRAINT `fk_vendor_diversity_certification_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);

-- ========= vendor --> compliance (3 constraint(s)) =========
-- Requires: vendor schema, compliance schema
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_state_compliance_rule_id` FOREIGN KEY (`state_compliance_rule_id`) REFERENCES `staffing_hr_ecm_v1`.`compliance`.`state_compliance_rule`(`state_compliance_rule_id`);

-- ========= vendor --> contract (27 constraint(s)) =========
-- Requires: vendor schema, contract schema
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`tier_classification` ADD CONSTRAINT `fk_vendor_tier_classification_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`tier_classification` ADD CONSTRAINT `fk_vendor_tier_classification_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`tier_classification` ADD CONSTRAINT `fk_vendor_tier_classification_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vms_enrollment` ADD CONSTRAINT `fk_vendor_vms_enrollment_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`nda`(`nda_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vms_enrollment` ADD CONSTRAINT `fk_vendor_vms_enrollment_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vendor_rate_card` ADD CONSTRAINT `fk_vendor_vendor_rate_card_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vendor_rate_card` ADD CONSTRAINT `fk_vendor_vendor_rate_card_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`rate_agreement` ADD CONSTRAINT `fk_vendor_rate_agreement_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`rate_agreement` ADD CONSTRAINT `fk_vendor_rate_agreement_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`rate_agreement` ADD CONSTRAINT `fk_vendor_rate_agreement_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sow`(`sow_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`program_allocation` ADD CONSTRAINT `fk_vendor_program_allocation_contract_rate_schedule_id` FOREIGN KEY (`contract_rate_schedule_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`(`contract_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`program_allocation` ADD CONSTRAINT `fk_vendor_program_allocation_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`program_allocation` ADD CONSTRAINT `fk_vendor_program_allocation_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`nda`(`nda_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`sla`(`sla_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`preferred_supplier_list` ADD CONSTRAINT `fk_vendor_preferred_supplier_list_msa_id` FOREIGN KEY (`msa_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`msa`(`msa_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`preferred_supplier_list` ADD CONSTRAINT `fk_vendor_preferred_supplier_list_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`diversity_certification` ADD CONSTRAINT `fk_vendor_diversity_certification_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `staffing_hr_ecm_v1`.`contract`.`vendor_agreement`(`vendor_agreement_id`);

-- ========= vendor --> credentialing (4 constraint(s)) =========
-- Requires: vendor schema, credentialing schema
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vms_enrollment` ADD CONSTRAINT `fk_vendor_vms_enrollment_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`sow_agreement` ADD CONSTRAINT `fk_vendor_sow_agreement_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`program_allocation` ADD CONSTRAINT `fk_vendor_program_allocation_credential_package_id` FOREIGN KEY (`credential_package_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential_package`(`credential_package_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`vendor`.`vendor_compliance` ADD CONSTRAINT `fk_vendor_vendor_compliance_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `staffing_hr_ecm_v1`.`credentialing`.`credential`(`credential_id`);

