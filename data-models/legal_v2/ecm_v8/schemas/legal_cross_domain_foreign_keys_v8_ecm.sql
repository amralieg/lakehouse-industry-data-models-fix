-- Cross-Domain Foreign Keys for Business: Legal | Version: v8_ecm
-- Generated on: 2026-05-21 01:11:39
-- Total cross-domain FK constraints: 1349
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: billing, client, compliance, conflict, contract, court, document, intake, ip, knowledge, matter, risk, service, trust, workforce

-- ========= billing --> client (18 constraint(s)) =========
-- Requires: billing schema, client schema
ALTER TABLE `legal_ecm_v1`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm_v1`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm_v1`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm_v1`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm_v1`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`ledes_submission` ADD CONSTRAINT `fk_billing_ledes_submission_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);

-- ========= billing --> compliance (7 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `legal_ecm_v1`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm_v1`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `legal_ecm_v1`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `legal_ecm_v1`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);

-- ========= billing --> contract (4 constraint(s)) =========
-- Requires: billing schema, contract schema
ALTER TABLE `legal_ecm_v1`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);

-- ========= billing --> document (5 constraint(s)) =========
-- Requires: billing schema, document schema
ALTER TABLE `legal_ecm_v1`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);

-- ========= billing --> intake (7 constraint(s)) =========
-- Requires: billing schema, intake schema
ALTER TABLE `legal_ecm_v1`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_intake_fee_arrangement_id` FOREIGN KEY (`intake_fee_arrangement_id`) REFERENCES `legal_ecm_v1`.`intake`.`intake_fee_arrangement`(`intake_fee_arrangement_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_intake_fee_arrangement_id` FOREIGN KEY (`intake_fee_arrangement_id`) REFERENCES `legal_ecm_v1`.`intake`.`intake_fee_arrangement`(`intake_fee_arrangement_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm_v1`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_intake_fee_arrangement_id` FOREIGN KEY (`intake_fee_arrangement_id`) REFERENCES `legal_ecm_v1`.`intake`.`intake_fee_arrangement`(`intake_fee_arrangement_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm_v1`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_intake_fee_arrangement_id` FOREIGN KEY (`intake_fee_arrangement_id`) REFERENCES `legal_ecm_v1`.`intake`.`intake_fee_arrangement`(`intake_fee_arrangement_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm_v1`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);

-- ========= billing --> ip (1 constraint(s)) =========
-- Requires: billing schema, ip schema
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);

-- ========= billing --> matter (31 constraint(s)) =========
-- Requires: billing schema, matter schema
ALTER TABLE `legal_ecm_v1`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_hearing_id` FOREIGN KEY (`hearing_id`) REFERENCES `legal_ecm_v1`.`matter`.`hearing`(`hearing_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_primary_prebill_matter_id` FOREIGN KEY (`primary_prebill_matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_hearing_id` FOREIGN KEY (`hearing_id`) REFERENCES `legal_ecm_v1`.`matter`.`hearing`(`hearing_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_retainer_matter_id` FOREIGN KEY (`retainer_matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`ledes_submission` ADD CONSTRAINT `fk_billing_ledes_submission_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`ledes_submission` ADD CONSTRAINT `fk_billing_ledes_submission_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);

-- ========= billing --> risk (3 constraint(s)) =========
-- Requires: billing schema, risk schema
ALTER TABLE `legal_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);

-- ========= billing --> service (10 constraint(s)) =========
-- Requires: billing schema, service schema
ALTER TABLE `legal_ecm_v1`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`ledes_submission` ADD CONSTRAINT `fk_billing_ledes_submission_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);

-- ========= billing --> trust (2 constraint(s)) =========
-- Requires: billing schema, trust schema
ALTER TABLE `legal_ecm_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);

-- ========= billing --> workforce (27 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `legal_ecm_v1`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`billing_office` ADD CONSTRAINT `fk_billing_billing_office_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `legal_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_primary_wip_timekeeper_id` FOREIGN KEY (`primary_wip_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_wip_approved_by_timekeeper_id` FOREIGN KEY (`wip_approved_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_prebill_approved_by_attorney_timekeeper_id` FOREIGN KEY (`prebill_approved_by_attorney_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_primary_prebill_timekeeper_id` FOREIGN KEY (`primary_prebill_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_primary_ar_timekeeper_id` FOREIGN KEY (`primary_ar_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_primary_write_timekeeper_id` FOREIGN KEY (`primary_write_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_tertiary_collection_responsible_partner_timekeeper_id` FOREIGN KEY (`tertiary_collection_responsible_partner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_tertiary_invoice_responsible_partner_timekeeper_id` FOREIGN KEY (`tertiary_invoice_responsible_partner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`billing`.`ledes_submission` ADD CONSTRAINT `fk_billing_ledes_submission_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);

-- ========= client --> compliance (7 constraint(s)) =========
-- Requires: client schema, compliance schema
ALTER TABLE `legal_ecm_v1`.`client`.`individual` ADD CONSTRAINT `fk_client_individual_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`client_contact` ADD CONSTRAINT `fk_client_client_contact_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`kyc_record` ADD CONSTRAINT `fk_client_kyc_record_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`kyc_record` ADD CONSTRAINT `fk_client_kyc_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`kyc_document` ADD CONSTRAINT `fk_client_kyc_document_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`client_engagement_scope` ADD CONSTRAINT `fk_client_client_engagement_scope_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`beneficial_owner` ADD CONSTRAINT `fk_client_beneficial_owner_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);

-- ========= client --> document (3 constraint(s)) =========
-- Requires: client schema, document schema
ALTER TABLE `legal_ecm_v1`.`client`.`client_engagement_scope` ADD CONSTRAINT `fk_client_client_engagement_scope_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm_v1`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`document_access` ADD CONSTRAINT `fk_client_document_access_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`kyc_document_verification` ADD CONSTRAINT `fk_client_kyc_document_verification_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);

-- ========= client --> intake (1 constraint(s)) =========
-- Requires: client schema, intake schema
ALTER TABLE `legal_ecm_v1`.`client`.`client_engagement_scope` ADD CONSTRAINT `fk_client_client_engagement_scope_intake_engagement_scope_id` FOREIGN KEY (`intake_engagement_scope_id`) REFERENCES `legal_ecm_v1`.`intake`.`intake_engagement_scope`(`intake_engagement_scope_id`);

-- ========= client --> matter (3 constraint(s)) =========
-- Requires: client schema, matter schema
ALTER TABLE `legal_ecm_v1`.`client`.`address` ADD CONSTRAINT `fk_client_address_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `legal_ecm_v1`.`matter`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`kyc_document` ADD CONSTRAINT `fk_client_kyc_document_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`kyc_document` ADD CONSTRAINT `fk_client_kyc_document_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);

-- ========= client --> service (4 constraint(s)) =========
-- Requires: client schema, service schema
ALTER TABLE `legal_ecm_v1`.`client`.`profile` ADD CONSTRAINT `fk_client_profile_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`outside_counsel_guideline` ADD CONSTRAINT `fk_client_outside_counsel_guideline_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`service_engagement` ADD CONSTRAINT `fk_client_service_engagement_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`subscription` ADD CONSTRAINT `fk_client_subscription_package_id` FOREIGN KEY (`package_id`) REFERENCES `legal_ecm_v1`.`service`.`package`(`package_id`);

-- ========= client --> workforce (17 constraint(s)) =========
-- Requires: client schema, workforce schema
ALTER TABLE `legal_ecm_v1`.`client`.`individual` ADD CONSTRAINT `fk_client_individual_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`individual` ADD CONSTRAINT `fk_client_individual_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`profile` ADD CONSTRAINT `fk_client_profile_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`profile` ADD CONSTRAINT `fk_client_profile_profile_relationship_partner_timekeeper_id` FOREIGN KEY (`profile_relationship_partner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`kyc_record` ADD CONSTRAINT `fk_client_kyc_record_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`kyc_document` ADD CONSTRAINT `fk_client_kyc_document_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`segment` ADD CONSTRAINT `fk_client_segment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`relationship_team` ADD CONSTRAINT `fk_client_relationship_team_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`relationship_team` ADD CONSTRAINT `fk_client_relationship_team_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`client_engagement_scope` ADD CONSTRAINT `fk_client_client_engagement_scope_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`client_status_history` ADD CONSTRAINT `fk_client_client_status_history_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`credit_standing` ADD CONSTRAINT `fk_client_credit_standing_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`service_engagement` ADD CONSTRAINT `fk_client_service_engagement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`subscription` ADD CONSTRAINT `fk_client_subscription_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`document_access` ADD CONSTRAINT `fk_client_document_access_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`document_access` ADD CONSTRAINT `fk_client_document_access_document_shared_by_timekeeper_id` FOREIGN KEY (`document_shared_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`client`.`kyc_document_verification` ADD CONSTRAINT `fk_client_kyc_document_verification_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);

-- ========= compliance --> client (8 constraint(s)) =========
-- Requires: compliance schema, client schema
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ADD CONSTRAINT `fk_compliance_dpia_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy_acknowledgement` ADD CONSTRAINT `fk_compliance_policy_acknowledgement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);

-- ========= compliance --> document (7 constraint(s)) =========
-- Requires: compliance schema, document schema
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ADD CONSTRAINT `fk_compliance_dpia_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ADD CONSTRAINT `fk_compliance_regulatory_return_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);

-- ========= compliance --> ip (4 constraint(s)) =========
-- Requires: compliance schema, ip schema
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ADD CONSTRAINT `fk_compliance_aml_risk_assessment_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm_v1`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_ownership_id` FOREIGN KEY (`ownership_id`) REFERENCES `legal_ecm_v1`.`ip`.`ownership`(`ownership_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm_v1`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);

-- ========= compliance --> knowledge (1 constraint(s)) =========
-- Requires: compliance schema, knowledge schema
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ADD CONSTRAINT `fk_compliance_training_programme_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);

-- ========= compliance --> matter (6 constraint(s)) =========
-- Requires: compliance schema, matter schema
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ADD CONSTRAINT `fk_compliance_dpia_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);

-- ========= compliance --> risk (7 constraint(s)) =========
-- Requires: compliance schema, risk schema
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ADD CONSTRAINT `fk_compliance_aml_risk_assessment_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ADD CONSTRAINT `fk_compliance_dpia_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm_v1`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `legal_ecm_v1`.`risk`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ADD CONSTRAINT `fk_compliance_compliance_control_test_risk_control_id` FOREIGN KEY (`risk_control_id`) REFERENCES `legal_ecm_v1`.`risk`.`risk_control`(`risk_control_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ADD CONSTRAINT `fk_compliance_regulatory_breach_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);

-- ========= compliance --> service (15 constraint(s)) =========
-- Requires: compliance schema, service schema
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ADD CONSTRAINT `fk_compliance_control_framework_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_kyc_program` ADD CONSTRAINT `fk_compliance_aml_kyc_program_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`aml_risk_assessment` ADD CONSTRAINT `fk_compliance_aml_risk_assessment_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_privacy_register` ADD CONSTRAINT `fk_compliance_data_privacy_register_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`dpia` ADD CONSTRAINT `fk_compliance_dpia_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ADD CONSTRAINT `fk_compliance_regulatory_return_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ADD CONSTRAINT `fk_compliance_regulatory_breach_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_policy` ADD CONSTRAINT `fk_compliance_indemnity_policy_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ADD CONSTRAINT `fk_compliance_training_programme_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);

-- ========= compliance --> workforce (31 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `legal_ecm_v1`.`compliance`.`control_framework` ADD CONSTRAINT `fk_compliance_control_framework_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_privacy_last_modified_by_user_id` FOREIGN KEY (`privacy_last_modified_by_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_return` ADD CONSTRAINT `fk_compliance_regulatory_return_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ADD CONSTRAINT `fk_compliance_compliance_control_test_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`compliance_control_test` ADD CONSTRAINT `fk_compliance_compliance_control_test_reviewer_timekeeper_id` FOREIGN KEY (`reviewer_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_breach` ADD CONSTRAINT `fk_compliance_regulatory_breach_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ADD CONSTRAINT `fk_compliance_training_programme_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`training_programme` ADD CONSTRAINT `fk_compliance_training_programme_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_regulatory_implementation_owner_timekeeper_id` FOREIGN KEY (`regulatory_implementation_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_engagement_owner_timekeeper_id` FOREIGN KEY (`engagement_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_primary_lead_auditor_timekeeper_id` FOREIGN KEY (`primary_lead_auditor_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_auditor_employee_timekeeper_id` FOREIGN KEY (`auditor_employee_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_finding_owner_timekeeper_id` FOREIGN KEY (`finding_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ADD CONSTRAINT `fk_compliance_audit_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `legal_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ADD CONSTRAINT `fk_compliance_audit_program_department_id` FOREIGN KEY (`department_id`) REFERENCES `legal_ecm_v1`.`workforce`.`department`(`department_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ADD CONSTRAINT `fk_compliance_audit_program_primary_lead_auditor_employee_id` FOREIGN KEY (`primary_lead_auditor_employee_id`) REFERENCES `legal_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `legal_ecm_v1`.`compliance`.`audit_program` ADD CONSTRAINT `fk_compliance_audit_program_program_owner_employee_id` FOREIGN KEY (`program_owner_employee_id`) REFERENCES `legal_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= conflict --> billing (1 constraint(s)) =========
-- Requires: conflict schema, billing schema
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_retainer_id` FOREIGN KEY (`retainer_id`) REFERENCES `legal_ecm_v1`.`billing`.`retainer`(`retainer_id`);

-- ========= conflict --> client (7 constraint(s)) =========
-- Requires: conflict schema, client schema
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_individual_id` FOREIGN KEY (`individual_id`) REFERENCES `legal_ecm_v1`.`client`.`individual`(`individual_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm_v1`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ADD CONSTRAINT `fk_conflict_audit_session_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);

-- ========= conflict --> compliance (28 constraint(s)) =========
-- Requires: conflict schema, compliance schema
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_training_programme_id` FOREIGN KEY (`training_programme_id`) REFERENCES `legal_ecm_v1`.`compliance`.`training_programme`(`training_programme_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_aml_risk_assessment_id` FOREIGN KEY (`aml_risk_assessment_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_risk_assessment`(`aml_risk_assessment_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm_v1`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `legal_ecm_v1`.`compliance`.`dpia`(`dpia_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `legal_ecm_v1`.`compliance`.`dpia`(`dpia_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_regulatory_return_id` FOREIGN KEY (`regulatory_return_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_return`(`regulatory_return_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_privacy_breach_id` FOREIGN KEY (`privacy_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`privacy_breach`(`privacy_breach_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_regulatory_return_id` FOREIGN KEY (`regulatory_return_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_return`(`regulatory_return_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_training_programme_id` FOREIGN KEY (`training_programme_id`) REFERENCES `legal_ecm_v1`.`compliance`.`training_programme`(`training_programme_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ADD CONSTRAINT `fk_conflict_rule_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ADD CONSTRAINT `fk_conflict_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ADD CONSTRAINT `fk_conflict_conflict_exception_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `legal_ecm_v1`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_subject_request`(`data_subject_request_id`);

-- ========= conflict --> contract (1 constraint(s)) =========
-- Requires: conflict schema, contract schema
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` ADD CONSTRAINT `fk_conflict_wall_enforcement_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);

-- ========= conflict --> document (2 constraint(s)) =========
-- Requires: conflict schema, document schema
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);

-- ========= conflict --> intake (4 constraint(s)) =========
-- Requires: conflict schema, intake schema
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `legal_ecm_v1`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm_v1`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_intake_fee_arrangement_id` FOREIGN KEY (`intake_fee_arrangement_id`) REFERENCES `legal_ecm_v1`.`intake`.`intake_fee_arrangement`(`intake_fee_arrangement_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm_v1`.`intake`.`request`(`request_id`);

-- ========= conflict --> ip (8 constraint(s)) =========
-- Requires: conflict schema, ip schema
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ADD CONSTRAINT `fk_conflict_relationship_map_ownership_id` FOREIGN KEY (`ownership_id`) REFERENCES `legal_ecm_v1`.`ip`.`ownership`(`ownership_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);

-- ========= conflict --> knowledge (5 constraint(s)) =========
-- Requires: conflict schema, knowledge schema
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`checklist`(`checklist_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ADD CONSTRAINT `fk_conflict_rule_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);

-- ========= conflict --> matter (16 constraint(s)) =========
-- Requires: conflict schema, matter schema
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_judge_id` FOREIGN KEY (`judge_id`) REFERENCES `legal_ecm_v1`.`matter`.`judge`(`judge_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_judge_id` FOREIGN KEY (`judge_id`) REFERENCES `legal_ecm_v1`.`matter`.`judge`(`judge_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ADD CONSTRAINT `fk_conflict_relationship_map_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`relationship_map` ADD CONSTRAINT `fk_conflict_relationship_map_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ADD CONSTRAINT `fk_conflict_matter_party_role_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ADD CONSTRAINT `fk_conflict_party_judge_appearance_judge_id` FOREIGN KEY (`judge_id`) REFERENCES `legal_ecm_v1`.`matter`.`judge`(`judge_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_judge_appearance` ADD CONSTRAINT `fk_conflict_party_judge_appearance_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ADD CONSTRAINT `fk_conflict_party_practice_conflict_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ADD CONSTRAINT `fk_conflict_audit_session_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);

-- ========= conflict --> risk (11 constraint(s)) =========
-- Requires: conflict schema, risk schema
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_reputational_risk_id` FOREIGN KEY (`reputational_risk_id`) REFERENCES `legal_ecm_v1`.`risk`.`reputational_risk`(`reputational_risk_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `legal_ecm_v1`.`risk`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_indemnity_exposure_id` FOREIGN KEY (`indemnity_exposure_id`) REFERENCES `legal_ecm_v1`.`risk`.`indemnity_exposure`(`indemnity_exposure_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_risk_control_id` FOREIGN KEY (`risk_control_id`) REFERENCES `legal_ecm_v1`.`risk`.`risk_control`(`risk_control_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_indemnity_exposure_id` FOREIGN KEY (`indemnity_exposure_id`) REFERENCES `legal_ecm_v1`.`risk`.`indemnity_exposure`(`indemnity_exposure_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ADD CONSTRAINT `fk_conflict_conflict_exception_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);

-- ========= conflict --> service (9 constraint(s)) =========
-- Requires: conflict schema, service schema
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`rule` ADD CONSTRAINT `fk_conflict_rule_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_exception` ADD CONSTRAINT `fk_conflict_conflict_exception_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_practice_conflict` ADD CONSTRAINT `fk_conflict_party_practice_conflict_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);

-- ========= conflict --> trust (1 constraint(s)) =========
-- Requires: conflict schema, trust schema
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);

-- ========= conflict --> workforce (37 constraint(s)) =========
-- Requires: conflict schema, workforce schema
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_check_supervising_partner_timekeeper_id` FOREIGN KEY (`check_supervising_partner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_check_timekeeper_id` FOREIGN KEY (`check_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_primary_reviewer_timekeeper_id` FOREIGN KEY (`primary_reviewer_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_execution` ADD CONSTRAINT `fk_conflict_search_execution_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_clearance_last_modified_by_user_timekeeper_id` FOREIGN KEY (`clearance_last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_clearance_responsible_party_timekeeper_id` FOREIGN KEY (`clearance_responsible_party_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_clearance_reviewing_counsel_timekeeper_id` FOREIGN KEY (`clearance_reviewing_counsel_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_clearance_timekeeper_id` FOREIGN KEY (`clearance_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_waiver_conflicts_counsel_timekeeper_id` FOREIGN KEY (`waiver_conflicts_counsel_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_waiver_last_modified_by_user_timekeeper_id` FOREIGN KEY (`waiver_last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_waiver_subject_timekeeper_id` FOREIGN KEY (`waiver_subject_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_waiver_timekeeper_id` FOREIGN KEY (`waiver_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ADD CONSTRAINT `fk_conflict_wall_membership_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ADD CONSTRAINT `fk_conflict_wall_membership_tertiary_reviewed_by_partner_timekeeper_id` FOREIGN KEY (`tertiary_reviewed_by_partner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ADD CONSTRAINT `fk_conflict_wall_membership_wall_last_modified_by_timekeeper_id` FOREIGN KEY (`wall_last_modified_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_membership` ADD CONSTRAINT `fk_conflict_wall_membership_walled_timekeeper_id` FOREIGN KEY (`walled_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_lateral_candidate_id` FOREIGN KEY (`lateral_candidate_id`) REFERENCES `legal_ecm_v1`.`workforce`.`lateral_candidate`(`lateral_candidate_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_lateral_last_modified_by_timekeeper_id` FOREIGN KEY (`lateral_last_modified_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_screening_owner_timekeeper_id` FOREIGN KEY (`screening_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ADD CONSTRAINT `fk_conflict_party_alias_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`party_alias` ADD CONSTRAINT `fk_conflict_party_alias_party_last_modified_by_timekeeper_id` FOREIGN KEY (`party_last_modified_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_audit_actor_timekeeper_id` FOREIGN KEY (`audit_actor_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`matter_party_role` ADD CONSTRAINT `fk_conflict_matter_party_role_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`wall_enforcement` ADD CONSTRAINT `fk_conflict_wall_enforcement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ADD CONSTRAINT `fk_conflict_audit_session_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ADD CONSTRAINT `fk_conflict_audit_session_audit_escalated_to_user_id` FOREIGN KEY (`audit_escalated_to_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ADD CONSTRAINT `fk_conflict_audit_session_audit_initiated_by_user_id` FOREIGN KEY (`audit_initiated_by_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ADD CONSTRAINT `fk_conflict_audit_session_audit_last_modified_by_user_id` FOREIGN KEY (`audit_last_modified_by_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`conflict`.`audit_session` ADD CONSTRAINT `fk_conflict_audit_session_reviewer_user_id` FOREIGN KEY (`reviewer_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);

-- ========= contract --> client (10 constraint(s)) =========
-- Requires: contract schema, client schema
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_individual_id` FOREIGN KEY (`individual_id`) REFERENCES `legal_ecm_v1`.`client`.`individual`(`individual_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm_v1`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);

-- ========= contract --> compliance (10 constraint(s)) =========
-- Requires: contract schema, compliance schema
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `legal_ecm_v1`.`compliance`.`dpia`(`dpia_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm_v1`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_indemnity_policy_id` FOREIGN KEY (`indemnity_policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_policy`(`indemnity_policy_id`);

-- ========= contract --> conflict (6 constraint(s)) =========
-- Requires: contract schema, conflict schema
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm_v1`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm_v1`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm_v1`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm_v1`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm_v1`.`conflict`.`check`(`check_id`);

-- ========= contract --> document (7 constraint(s)) =========
-- Requires: contract schema, document schema
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ADD CONSTRAINT `fk_contract_negotiation_round_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);

-- ========= contract --> intake (7 constraint(s)) =========
-- Requires: contract schema, intake schema
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm_v1`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm_v1`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm_v1`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm_v1`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm_v1`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_intake_fee_arrangement_id` FOREIGN KEY (`intake_fee_arrangement_id`) REFERENCES `legal_ecm_v1`.`intake`.`intake_fee_arrangement`(`intake_fee_arrangement_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm_v1`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);

-- ========= contract --> ip (1 constraint(s)) =========
-- Requires: contract schema, ip schema
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);

-- ========= contract --> knowledge (12 constraint(s)) =========
-- Requires: contract schema, knowledge schema
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`clause`(`clause_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`clause`(`clause_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ADD CONSTRAINT `fk_contract_negotiation_round_research_memo_id` FOREIGN KEY (`research_memo_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`research_memo`(`research_memo_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`clause`(`clause_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`clause`(`clause_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ADD CONSTRAINT `fk_contract_agreement_type_clause_policy_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`clause`(`clause_id`);

-- ========= contract --> matter (13 constraint(s)) =========
-- Requires: contract schema, matter schema
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ADD CONSTRAINT `fk_contract_negotiation_round_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);

-- ========= contract --> risk (4 constraint(s)) =========
-- Requires: contract schema, risk schema
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);

-- ========= contract --> service (8 constraint(s)) =========
-- Requires: contract schema, service schema
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm_v1`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type` ADD CONSTRAINT `fk_contract_agreement_type_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm_v1`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm_v1`.`service`.`pricing_model`(`pricing_model_id`);

-- ========= contract --> workforce (29 constraint(s)) =========
-- Requires: contract schema, workforce schema
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_obligation_actor_timekeeper_id` FOREIGN KEY (`obligation_actor_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ADD CONSTRAINT `fk_contract_negotiation_round_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ADD CONSTRAINT `fk_contract_negotiation_round_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`negotiation_round` ADD CONSTRAINT `fk_contract_negotiation_round_negotiation_owner_timekeeper_id` FOREIGN KEY (`negotiation_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_clause_owner_timekeeper_id` FOREIGN KEY (`clause_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_deviation_owner_timekeeper_id` FOREIGN KEY (`deviation_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_primary_afa_attorney_profile_id` FOREIGN KEY (`primary_afa_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ADD CONSTRAINT `fk_contract_agreement_type_clause_policy_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`agreement_type_clause_policy` ADD CONSTRAINT `fk_contract_agreement_type_clause_policy_agreement_last_modified_by_attorney_profile_id` FOREIGN KEY (`agreement_last_modified_by_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`contract`.`template_clause` ADD CONSTRAINT `fk_contract_template_clause_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);

-- ========= court --> client (3 constraint(s)) =========
-- Requires: court schema, client schema
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ADD CONSTRAINT `fk_court_adr_proceeding_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);

-- ========= court --> compliance (6 constraint(s)) =========
-- Requires: court schema, compliance schema
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_privacy_breach_id` FOREIGN KEY (`privacy_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`privacy_breach`(`privacy_breach_id`);
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ADD CONSTRAINT `fk_court_adr_proceeding_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ADD CONSTRAINT `fk_court_adr_proceeding_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);

-- ========= court --> document (2 constraint(s)) =========
-- Requires: court schema, document schema
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);

-- ========= court --> knowledge (3 constraint(s)) =========
-- Requires: court schema, knowledge schema
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ADD CONSTRAINT `fk_court_adr_proceeding_practice_note_id` FOREIGN KEY (`practice_note_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`practice_note`(`practice_note_id`);
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);

-- ========= court --> matter (3 constraint(s)) =========
-- Requires: court schema, matter schema
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ADD CONSTRAINT `fk_court_adr_proceeding_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);

-- ========= court --> risk (2 constraint(s)) =========
-- Requires: court schema, risk schema
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_indemnity_exposure_id` FOREIGN KEY (`indemnity_exposure_id`) REFERENCES `legal_ecm_v1`.`risk`.`indemnity_exposure`(`indemnity_exposure_id`);

-- ========= court --> trust (2 constraint(s)) =========
-- Requires: court schema, trust schema
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ADD CONSTRAINT `fk_court_adr_proceeding_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);

-- ========= document --> client (8 constraint(s)) =========
-- Requires: document schema, client schema
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm_v1`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ADD CONSTRAINT `fk_document_production_specification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `legal_ecm_v1`.`client`.`vendor`(`vendor_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ADD CONSTRAINT `fk_document_review_protocol_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);

-- ========= document --> compliance (12 constraint(s)) =========
-- Requires: document schema, compliance schema
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ADD CONSTRAINT `fk_document_doc_type_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ADD CONSTRAINT `fk_document_review_set_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);

-- ========= document --> contract (11 constraint(s)) =========
-- Requires: document schema, contract schema
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ADD CONSTRAINT `fk_document_doc_type_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `legal_ecm_v1`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `legal_ecm_v1`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ADD CONSTRAINT `fk_document_doc_template_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `legal_ecm_v1`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ADD CONSTRAINT `fk_document_doc_relationship_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);

-- ========= document --> ip (15 constraint(s)) =========
-- Requires: document schema, ip schema
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_trade_secret_id` FOREIGN KEY (`trade_secret_id`) REFERENCES `legal_ecm_v1`.`ip`.`trade_secret`(`trade_secret_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `legal_ecm_v1`.`ip`.`patent_family`(`patent_family_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `legal_ecm_v1`.`ip`.`patent`(`patent_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `legal_ecm_v1`.`ip`.`trademark`(`trademark_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ADD CONSTRAINT `fk_document_esi_custodian_inventor_id` FOREIGN KEY (`inventor_id`) REFERENCES `legal_ecm_v1`.`ip`.`inventor`(`inventor_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ADD CONSTRAINT `fk_document_doc_annotation_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm_v1`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ADD CONSTRAINT `fk_document_doc_relationship_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);

-- ========= document --> knowledge (4 constraint(s)) =========
-- Requires: document schema, knowledge schema
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`checklist`(`checklist_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` ADD CONSTRAINT `fk_document_template_clause_usage_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`clause`(`clause_id`);

-- ========= document --> matter (36 constraint(s)) =========
-- Requires: document schema, matter schema
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_tribunal_id` FOREIGN KEY (`tribunal_id`) REFERENCES `legal_ecm_v1`.`matter`.`tribunal`(`tribunal_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ADD CONSTRAINT `fk_document_doc_version_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ADD CONSTRAINT `fk_document_esi_custodian_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_matter_disbursement_id` FOREIGN KEY (`matter_disbursement_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter_disbursement`(`matter_disbursement_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ADD CONSTRAINT `fk_document_doc_annotation_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_doc_ediscovery_matter_id` FOREIGN KEY (`doc_ediscovery_matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ADD CONSTRAINT `fk_document_doc_relationship_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`custodian_hold` ADD CONSTRAINT `fk_document_custodian_hold_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`production_source` ADD CONSTRAINT `fk_document_production_source_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ADD CONSTRAINT `fk_document_review_set_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ADD CONSTRAINT `fk_document_review_session_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`production_set` ADD CONSTRAINT `fk_document_production_set_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`family_group` ADD CONSTRAINT `fk_document_family_group_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ADD CONSTRAINT `fk_document_review_batch_team_id` FOREIGN KEY (`team_id`) REFERENCES `legal_ecm_v1`.`matter`.`team`(`team_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ADD CONSTRAINT `fk_document_review_batch_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ADD CONSTRAINT `fk_document_review_batch_review_case_matter_id` FOREIGN KEY (`review_case_matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`production_batch` ADD CONSTRAINT `fk_document_production_batch_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`tar_model` ADD CONSTRAINT `fk_document_tar_model_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_project` ADD CONSTRAINT `fk_document_review_project_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ADD CONSTRAINT `fk_document_processing_batch_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ADD CONSTRAINT `fk_document_review_protocol_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);

-- ========= document --> risk (5 constraint(s)) =========
-- Requires: document schema, risk schema
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `legal_ecm_v1`.`risk`.`data_breach_incident`(`data_breach_incident_id`);

-- ========= document --> service (11 constraint(s)) =========
-- Requires: document schema, service schema
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_type` ADD CONSTRAINT `fk_document_doc_type_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ADD CONSTRAINT `fk_document_doc_template_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);

-- ========= document --> trust (3 constraint(s)) =========
-- Requires: document schema, trust schema
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_escrow_release_id` FOREIGN KEY (`escrow_release_id`) REFERENCES `legal_ecm_v1`.`trust`.`escrow_release`(`escrow_release_id`);

-- ========= document --> workforce (40 constraint(s)) =========
-- Requires: document schema, workforce schema
ALTER TABLE `legal_ecm_v1`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ADD CONSTRAINT `fk_document_doc_version_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_version` ADD CONSTRAINT `fk_document_doc_version_reviewer_timekeeper_id` FOREIGN KEY (`reviewer_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`esi_custodian` ADD CONSTRAINT `fk_document_esi_custodian_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_annotation` ADD CONSTRAINT `fk_document_doc_annotation_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_doc_user_timekeeper_id` FOREIGN KEY (`doc_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ADD CONSTRAINT `fk_document_doc_template_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_template` ADD CONSTRAINT `fk_document_doc_template_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`doc_relationship` ADD CONSTRAINT `fk_document_doc_relationship_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`template_clause_usage` ADD CONSTRAINT `fk_document_template_clause_usage_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ADD CONSTRAINT `fk_document_review_set_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `legal_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ADD CONSTRAINT `fk_document_review_set_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_set` ADD CONSTRAINT `fk_document_review_set_review_modified_by_user_id` FOREIGN KEY (`review_modified_by_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ADD CONSTRAINT `fk_document_review_session_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ADD CONSTRAINT `fk_document_review_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `legal_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ADD CONSTRAINT `fk_document_review_session_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_session` ADD CONSTRAINT `fk_document_review_session_review_modified_by_user_id` FOREIGN KEY (`review_modified_by_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ADD CONSTRAINT `fk_document_execution_workflow_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ADD CONSTRAINT `fk_document_execution_workflow_execution_modified_by_user_id` FOREIGN KEY (`execution_modified_by_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`execution_workflow` ADD CONSTRAINT `fk_document_execution_workflow_owner_user_id` FOREIGN KEY (`owner_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_owner_attorney_profile_id` FOREIGN KEY (`owner_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_workspace_created_by_user_id` FOREIGN KEY (`workspace_created_by_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_workspace_modified_by_user_id` FOREIGN KEY (`workspace_modified_by_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ADD CONSTRAINT `fk_document_review_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `legal_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ADD CONSTRAINT `fk_document_review_batch_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_batch` ADD CONSTRAINT `fk_document_review_batch_review_last_modified_by_user_id` FOREIGN KEY (`review_last_modified_by_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`production_specification` ADD CONSTRAINT `fk_document_production_specification_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ADD CONSTRAINT `fk_document_processing_batch_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`processing_batch` ADD CONSTRAINT `fk_document_processing_batch_processing_modified_by_user_id` FOREIGN KEY (`processing_modified_by_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`document`.`review_protocol` ADD CONSTRAINT `fk_document_review_protocol_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);

-- ========= intake --> billing (1 constraint(s)) =========
-- Requires: intake schema, billing schema
ALTER TABLE `legal_ecm_v1`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_guideline_id` FOREIGN KEY (`guideline_id`) REFERENCES `legal_ecm_v1`.`billing`.`guideline`(`guideline_id`);

-- ========= intake --> client (14 constraint(s)) =========
-- Requires: intake schema, client schema
ALTER TABLE `legal_ecm_v1`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_individual_id` FOREIGN KEY (`individual_id`) REFERENCES `legal_ecm_v1`.`client`.`individual`(`individual_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm_v1`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm_v1`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`intake_fee_arrangement` ADD CONSTRAINT `fk_intake_intake_fee_arrangement_client_engagement_scope_id` FOREIGN KEY (`client_engagement_scope_id`) REFERENCES `legal_ecm_v1`.`client`.`client_engagement_scope`(`client_engagement_scope_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`intake_fee_arrangement` ADD CONSTRAINT `fk_intake_intake_fee_arrangement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_outside_counsel_guideline_id` FOREIGN KEY (`outside_counsel_guideline_id`) REFERENCES `legal_ecm_v1`.`client`.`outside_counsel_guideline`(`outside_counsel_guideline_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);

-- ========= intake --> compliance (13 constraint(s)) =========
-- Requires: intake schema, compliance schema
ALTER TABLE `legal_ecm_v1`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm_v1`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm_v1`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);

-- ========= intake --> conflict (5 constraint(s)) =========
-- Requires: intake schema, conflict schema
ALTER TABLE `legal_ecm_v1`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm_v1`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm_v1`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm_v1`.`conflict`.`check`(`check_id`);

-- ========= intake --> document (9 constraint(s)) =========
-- Requires: intake schema, document schema
ALTER TABLE `legal_ecm_v1`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);

-- ========= intake --> knowledge (7 constraint(s)) =========
-- Requires: intake schema, knowledge schema
ALTER TABLE `legal_ecm_v1`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`checklist`(`checklist_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`intake_engagement_scope` ADD CONSTRAINT `fk_intake_intake_engagement_scope_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`checklist`(`checklist_id`);

-- ========= intake --> matter (7 constraint(s)) =========
-- Requires: intake schema, matter schema
ALTER TABLE `legal_ecm_v1`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_task_id` FOREIGN KEY (`task_id`) REFERENCES `legal_ecm_v1`.`matter`.`task`(`task_id`);

-- ========= intake --> risk (11 constraint(s)) =========
-- Requires: intake schema, risk schema
ALTER TABLE `legal_ecm_v1`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_reputational_risk_id` FOREIGN KEY (`reputational_risk_id`) REFERENCES `legal_ecm_v1`.`risk`.`reputational_risk`(`reputational_risk_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `legal_ecm_v1`.`risk`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `legal_ecm_v1`.`risk`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`risk_action` ADD CONSTRAINT `fk_intake_risk_action_mitigation_action_id` FOREIGN KEY (`mitigation_action_id`) REFERENCES `legal_ecm_v1`.`risk`.`mitigation_action`(`mitigation_action_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`opportunity_risk_assessment` ADD CONSTRAINT `fk_intake_opportunity_risk_assessment_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm_v1`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`opportunity_risk_assessment` ADD CONSTRAINT `fk_intake_opportunity_risk_assessment_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `legal_ecm_v1`.`risk`.`assessment`(`assessment_id`);

-- ========= intake --> service (6 constraint(s)) =========
-- Requires: intake schema, service schema
ALTER TABLE `legal_ecm_v1`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`intake_engagement_scope` ADD CONSTRAINT `fk_intake_intake_engagement_scope_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm_v1`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`intake_fee_arrangement` ADD CONSTRAINT `fk_intake_intake_fee_arrangement_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm_v1`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm_v1`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm_v1`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm_v1`.`service`.`pricing_model`(`pricing_model_id`);

-- ========= intake --> workforce (52 constraint(s)) =========
-- Requires: intake schema, workforce schema
ALTER TABLE `legal_ecm_v1`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_primary_prospect_attorney_profile_id` FOREIGN KEY (`primary_prospect_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_submission_owner_timekeeper_id` FOREIGN KEY (`submission_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_pitch_owner_timekeeper_id` FOREIGN KEY (`pitch_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_opportunity_owner_timekeeper_id` FOREIGN KEY (`opportunity_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_primary_engagement_attorney_profile_id` FOREIGN KEY (`primary_engagement_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_primary_request_approved_by_partner_attorney_profile_id` FOREIGN KEY (`primary_request_approved_by_partner_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_request_owner_timekeeper_id` FOREIGN KEY (`request_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`conflict_search` ADD CONSTRAINT `fk_intake_conflict_search_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_tertiary_conflict_escalated_to_attorney_profile_id` FOREIGN KEY (`tertiary_conflict_escalated_to_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`intake_engagement_scope` ADD CONSTRAINT `fk_intake_intake_engagement_scope_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`intake_engagement_scope` ADD CONSTRAINT `fk_intake_intake_engagement_scope_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`intake_engagement_scope` ADD CONSTRAINT `fk_intake_intake_engagement_scope_scope_owner_timekeeper_id` FOREIGN KEY (`scope_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`intake_fee_arrangement` ADD CONSTRAINT `fk_intake_intake_fee_arrangement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_loe_owner_timekeeper_id` FOREIGN KEY (`loe_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_primary_letter_attorney_profile_id` FOREIGN KEY (`primary_letter_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_originating_attorney_attorney_profile_id` FOREIGN KEY (`originating_attorney_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_primary_matter_attorney_profile_id` FOREIGN KEY (`primary_matter_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_requestor_timekeeper_id` FOREIGN KEY (`requestor_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_tertiary_matter_approved_by_attorney_attorney_profile_id` FOREIGN KEY (`tertiary_matter_approved_by_attorney_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_origination_modified_by_user_timekeeper_id` FOREIGN KEY (`origination_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_primary_credited_timekeeper_id` FOREIGN KEY (`primary_credited_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_client_created_by_user_timekeeper_id` FOREIGN KEY (`client_created_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_client_escalated_to_user_timekeeper_id` FOREIGN KEY (`client_escalated_to_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_client_modified_by_user_timekeeper_id` FOREIGN KEY (`client_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_client_waived_by_user_timekeeper_id` FOREIGN KEY (`client_waived_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_task_owner_timekeeper_id` FOREIGN KEY (`task_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`referral_source` ADD CONSTRAINT `fk_intake_referral_source_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`referral_source` ADD CONSTRAINT `fk_intake_referral_source_primary_referral_attorney_profile_id` FOREIGN KEY (`primary_referral_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`referral_source` ADD CONSTRAINT `fk_intake_referral_source_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`referral_source` ADD CONSTRAINT `fk_intake_referral_source_referral_owner_timekeeper_id` FOREIGN KEY (`referral_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_panel_modified_by_user_timekeeper_id` FOREIGN KEY (`panel_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`risk_action` ADD CONSTRAINT `fk_intake_risk_action_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`intake`.`opportunity_risk_assessment` ADD CONSTRAINT `fk_intake_opportunity_risk_assessment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);

-- ========= ip --> billing (1 constraint(s)) =========
-- Requires: ip schema, billing schema
ALTER TABLE `legal_ecm_v1`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= ip --> client (17 constraint(s)) =========
-- Requires: ip schema, client schema
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_asset` ADD CONSTRAINT `fk_ip_ip_asset_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm_v1`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`inventor` ADD CONSTRAINT `fk_ip_inventor_individual_id` FOREIGN KEY (`individual_id`) REFERENCES `legal_ecm_v1`.`client`.`individual`(`individual_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`patent_family` ADD CONSTRAINT `fk_ip_patent_family_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`valuation` ADD CONSTRAINT `fk_ip_valuation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`asset_contact_assignment` ADD CONSTRAINT `fk_ip_asset_contact_assignment_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`royalty_report` ADD CONSTRAINT `fk_ip_royalty_report_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm_v1`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`royalty_report` ADD CONSTRAINT `fk_ip_royalty_report_royalty_licensor_organisation_id` FOREIGN KEY (`royalty_licensor_organisation_id`) REFERENCES `legal_ecm_v1`.`client`.`organisation`(`organisation_id`);

-- ========= ip --> compliance (13 constraint(s)) =========
-- Requires: ip schema, compliance schema
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_asset` ADD CONSTRAINT `fk_ip_ip_asset_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_regulatory_return_id` FOREIGN KEY (`regulatory_return_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_return`(`regulatory_return_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `legal_ecm_v1`.`compliance`.`sar_filing`(`sar_filing_id`);

-- ========= ip --> contract (1 constraint(s)) =========
-- Requires: ip schema, contract schema
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);

-- ========= ip --> document (2 constraint(s)) =========
-- Requires: ip schema, document schema
ALTER TABLE `legal_ecm_v1`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);

-- ========= ip --> intake (7 constraint(s)) =========
-- Requires: ip schema, intake schema
ALTER TABLE `legal_ecm_v1`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm_v1`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm_v1`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm_v1`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`valuation` ADD CONSTRAINT `fk_ip_valuation_pitch_id` FOREIGN KEY (`pitch_id`) REFERENCES `legal_ecm_v1`.`intake`.`pitch`(`pitch_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_intake_engagement_scope_id` FOREIGN KEY (`intake_engagement_scope_id`) REFERENCES `legal_ecm_v1`.`intake`.`intake_engagement_scope`(`intake_engagement_scope_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm_v1`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_panel_appointment_id` FOREIGN KEY (`panel_appointment_id`) REFERENCES `legal_ecm_v1`.`intake`.`panel_appointment`(`panel_appointment_id`);

-- ========= ip --> knowledge (8 constraint(s)) =========
-- Requires: ip schema, knowledge schema
ALTER TABLE `legal_ecm_v1`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_research_memo_id` FOREIGN KEY (`research_memo_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`research_memo`(`research_memo_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_research_memo_id` FOREIGN KEY (`research_memo_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`research_memo`(`research_memo_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_research_memo_id` FOREIGN KEY (`research_memo_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`research_memo`(`research_memo_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`asset_precedent_usage` ADD CONSTRAINT `fk_ip_asset_precedent_usage_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);

-- ========= ip --> matter (22 constraint(s)) =========
-- Requires: ip schema, matter schema
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_asset` ADD CONSTRAINT `fk_ip_ip_asset_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`patent_family` ADD CONSTRAINT `fk_ip_patent_family_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`valuation` ADD CONSTRAINT `fk_ip_valuation_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm_v1`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`patent_prosecution_assignment` ADD CONSTRAINT `fk_ip_patent_prosecution_assignment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);

-- ========= ip --> risk (13 constraint(s)) =========
-- Requires: ip schema, risk schema
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_asset` ADD CONSTRAINT `fk_ip_ip_asset_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_third_party_risk_id` FOREIGN KEY (`third_party_risk_id`) REFERENCES `legal_ecm_v1`.`risk`.`third_party_risk`(`third_party_risk_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_reputational_risk_id` FOREIGN KEY (`reputational_risk_id`) REFERENCES `legal_ecm_v1`.`risk`.`reputational_risk`(`reputational_risk_id`);

-- ========= ip --> service (10 constraint(s)) =========
-- Requires: ip schema, service schema
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_asset` ADD CONSTRAINT `fk_ip_ip_asset_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`valuation` ADD CONSTRAINT `fk_ip_valuation_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);

-- ========= ip --> trust (7 constraint(s)) =========
-- Requires: ip schema, trust schema
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_asset` ADD CONSTRAINT `fk_ip_ip_asset_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm_v1`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm_v1`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_receipt_id` FOREIGN KEY (`receipt_id`) REFERENCES `legal_ecm_v1`.`trust`.`receipt`(`receipt_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`valuation` ADD CONSTRAINT `fk_ip_valuation_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm_v1`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);

-- ========= ip --> workforce (37 constraint(s)) =========
-- Requires: ip schema, workforce schema
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_asset` ADD CONSTRAINT `fk_ip_ip_asset_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_prosecution_modified_by_timekeeper_id` FOREIGN KEY (`prosecution_modified_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_docket_last_modified_by_user_timekeeper_id` FOREIGN KEY (`docket_last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_ip_modified_by_user_timekeeper_id` FOREIGN KEY (`ip_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_payment_owner_timekeeper_id` FOREIGN KEY (`payment_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_license_modified_by_user_timekeeper_id` FOREIGN KEY (`license_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_royalty_modified_by_user_timekeeper_id` FOREIGN KEY (`royalty_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`patent_family` ADD CONSTRAINT `fk_ip_patent_family_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`valuation` ADD CONSTRAINT `fk_ip_valuation_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_proceeding_owner_timekeeper_id` FOREIGN KEY (`proceeding_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_trade_modified_by_user_timekeeper_id` FOREIGN KEY (`trade_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_ip_modified_by_user_timekeeper_id` FOREIGN KEY (`ip_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_copyright_owner_timekeeper_id` FOREIGN KEY (`copyright_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_enforcement_modified_by_user_timekeeper_id` FOREIGN KEY (`enforcement_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`asset_contact_assignment` ADD CONSTRAINT `fk_ip_asset_contact_assignment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`patent_prosecution_assignment` ADD CONSTRAINT `fk_ip_patent_prosecution_assignment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`ip`.`royalty_report` ADD CONSTRAINT `fk_ip_royalty_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `legal_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= knowledge --> client (3 constraint(s)) =========
-- Requires: knowledge schema, client schema
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ADD CONSTRAINT `fk_knowledge_asset_usage_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ADD CONSTRAINT `fk_knowledge_contribution_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);

-- ========= knowledge --> compliance (11 constraint(s)) =========
-- Requires: knowledge schema, compliance schema
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ADD CONSTRAINT `fk_knowledge_knowledge_asset_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ADD CONSTRAINT `fk_knowledge_precedent_update_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ADD CONSTRAINT `fk_knowledge_research_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ADD CONSTRAINT `fk_knowledge_legal_update_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ADD CONSTRAINT `fk_knowledge_legal_update_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ADD CONSTRAINT `fk_knowledge_precedent_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ADD CONSTRAINT `fk_knowledge_practice_note_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ADD CONSTRAINT `fk_knowledge_clause_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ADD CONSTRAINT `fk_knowledge_form_template_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ADD CONSTRAINT `fk_knowledge_checklist_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= knowledge --> document (5 constraint(s)) =========
-- Requires: knowledge schema, document schema
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ADD CONSTRAINT `fk_knowledge_asset_usage_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ADD CONSTRAINT `fk_knowledge_precedent_update_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ADD CONSTRAINT `fk_knowledge_precedent_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ADD CONSTRAINT `fk_knowledge_clause_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);

-- ========= knowledge --> matter (4 constraint(s)) =========
-- Requires: knowledge schema, matter schema
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ADD CONSTRAINT `fk_knowledge_asset_usage_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ADD CONSTRAINT `fk_knowledge_contribution_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ADD CONSTRAINT `fk_knowledge_research_request_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);

-- ========= knowledge --> risk (9 constraint(s)) =========
-- Requires: knowledge schema, risk schema
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ADD CONSTRAINT `fk_knowledge_precedent_update_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ADD CONSTRAINT `fk_knowledge_legal_update_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ADD CONSTRAINT `fk_knowledge_control_mapping_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm_v1`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_risk_mitigation` ADD CONSTRAINT `fk_knowledge_precedent_risk_mitigation_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm_v1`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ADD CONSTRAINT `fk_knowledge_practice_note_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm_v1`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ADD CONSTRAINT `fk_knowledge_clause_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm_v1`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ADD CONSTRAINT `fk_knowledge_form_template_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm_v1`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ADD CONSTRAINT `fk_knowledge_checklist_mitigation_action_id` FOREIGN KEY (`mitigation_action_id`) REFERENCES `legal_ecm_v1`.`risk`.`mitigation_action`(`mitigation_action_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm_v1`.`risk`.`assessment`(`assessment_id`);

-- ========= knowledge --> service (11 constraint(s)) =========
-- Requires: knowledge schema, service schema
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ADD CONSTRAINT `fk_knowledge_knowledge_asset_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`external_source` ADD CONSTRAINT `fk_knowledge_external_source_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ADD CONSTRAINT `fk_knowledge_legal_update_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ADD CONSTRAINT `fk_knowledge_impact_assessment_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent` ADD CONSTRAINT `fk_knowledge_precedent_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`practice_note` ADD CONSTRAINT `fk_knowledge_practice_note_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ADD CONSTRAINT `fk_knowledge_clause_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`form_template` ADD CONSTRAINT `fk_knowledge_form_template_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`checklist` ADD CONSTRAINT `fk_knowledge_checklist_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`taxonomy` ADD CONSTRAINT `fk_knowledge_taxonomy_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);

-- ========= knowledge --> workforce (16 constraint(s)) =========
-- Requires: knowledge schema, workforce schema
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ADD CONSTRAINT `fk_knowledge_expertise_directory_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`expertise_directory` ADD CONSTRAINT `fk_knowledge_expertise_directory_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`knowledge_asset` ADD CONSTRAINT `fk_knowledge_knowledge_asset_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`asset_usage` ADD CONSTRAINT `fk_knowledge_asset_usage_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ADD CONSTRAINT `fk_knowledge_precedent_update_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`precedent_update` ADD CONSTRAINT `fk_knowledge_precedent_update_primary_precedent_timekeeper_id` FOREIGN KEY (`primary_precedent_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ADD CONSTRAINT `fk_knowledge_contribution_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`contribution` ADD CONSTRAINT `fk_knowledge_contribution_reviewer_timekeeper_id` FOREIGN KEY (`reviewer_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ADD CONSTRAINT `fk_knowledge_research_request_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_request` ADD CONSTRAINT `fk_knowledge_research_request_reviewer_timekeeper_id` FOREIGN KEY (`reviewer_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`legal_update` ADD CONSTRAINT `fk_knowledge_legal_update_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`impact_assessment` ADD CONSTRAINT `fk_knowledge_impact_assessment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`control_mapping` ADD CONSTRAINT `fk_knowledge_control_mapping_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ADD CONSTRAINT `fk_knowledge_clause_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`clause` ADD CONSTRAINT `fk_knowledge_clause_clause_author_timekeeper_id` FOREIGN KEY (`clause_author_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);

-- ========= matter --> billing (2 constraint(s)) =========
-- Requires: matter schema, billing schema
ALTER TABLE `legal_ecm_v1`.`matter`.`appearance` ADD CONSTRAINT `fk_matter_appearance_time_entry_id` FOREIGN KEY (`time_entry_id`) REFERENCES `legal_ecm_v1`.`billing`.`time_entry`(`time_entry_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_disbursement` ADD CONSTRAINT `fk_matter_matter_disbursement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= matter --> client (17 constraint(s)) =========
-- Requires: matter schema, client schema
ALTER TABLE `legal_ecm_v1`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`appearance` ADD CONSTRAINT `fk_matter_appearance_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_client_engagement_scope_id` FOREIGN KEY (`client_engagement_scope_id`) REFERENCES `legal_ecm_v1`.`client`.`client_engagement_scope`(`client_engagement_scope_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`event` ADD CONSTRAINT `fk_matter_event_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_disbursement` ADD CONSTRAINT `fk_matter_matter_disbursement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`counsel` ADD CONSTRAINT `fk_matter_counsel_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm_v1`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_individual_id` FOREIGN KEY (`individual_id`) REFERENCES `legal_ecm_v1`.`client`.`individual`(`individual_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm_v1`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`hold` ADD CONSTRAINT `fk_matter_hold_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_contact` ADD CONSTRAINT `fk_matter_matter_contact_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm_v1`.`client`.`client_contact`(`client_contact_id`);

-- ========= matter --> compliance (17 constraint(s)) =========
-- Requires: matter schema, compliance schema
ALTER TABLE `legal_ecm_v1`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_privacy_breach_id` FOREIGN KEY (`privacy_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`privacy_breach`(`privacy_breach_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_privacy_breach_id` FOREIGN KEY (`privacy_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`privacy_breach`(`privacy_breach_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_indemnity_policy_id` FOREIGN KEY (`indemnity_policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_policy`(`indemnity_policy_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`event` ADD CONSTRAINT `fk_matter_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_risk` ADD CONSTRAINT `fk_matter_matter_risk_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm_v1`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`court_filing` ADD CONSTRAINT `fk_matter_court_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_control` ADD CONSTRAINT `fk_matter_matter_control_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm_v1`.`compliance`.`compliance_control`(`compliance_control_id`);

-- ========= matter --> conflict (3 constraint(s)) =========
-- Requires: matter schema, conflict schema
ALTER TABLE `legal_ecm_v1`.`matter`.`team` ADD CONSTRAINT `fk_matter_team_clearance_id` FOREIGN KEY (`clearance_id`) REFERENCES `legal_ecm_v1`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm_v1`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`lateral_conflict` ADD CONSTRAINT `fk_matter_lateral_conflict_lateral_screening_id` FOREIGN KEY (`lateral_screening_id`) REFERENCES `legal_ecm_v1`.`conflict`.`lateral_screening`(`lateral_screening_id`);

-- ========= matter --> document (4 constraint(s)) =========
-- Requires: matter schema, document schema
ALTER TABLE `legal_ecm_v1`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`event` ADD CONSTRAINT `fk_matter_event_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);

-- ========= matter --> intake (2 constraint(s)) =========
-- Requires: matter schema, intake schema
ALTER TABLE `legal_ecm_v1`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_intake_fee_arrangement_id` FOREIGN KEY (`intake_fee_arrangement_id`) REFERENCES `legal_ecm_v1`.`intake`.`intake_fee_arrangement`(`intake_fee_arrangement_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_intake_party_id` FOREIGN KEY (`intake_party_id`) REFERENCES `legal_ecm_v1`.`intake`.`intake_party`(`intake_party_id`);

-- ========= matter --> ip (1 constraint(s)) =========
-- Requires: matter schema, ip schema
ALTER TABLE `legal_ecm_v1`.`matter`.`assertion` ADD CONSTRAINT `fk_matter_assertion_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm_v1`.`ip`.`ip_asset`(`ip_asset_id`);

-- ========= matter --> knowledge (13 constraint(s)) =========
-- Requires: matter schema, knowledge schema
ALTER TABLE `legal_ecm_v1`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`clause`(`clause_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`clause`(`clause_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`court_rule` ADD CONSTRAINT `fk_matter_court_rule_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`court_rule` ADD CONSTRAINT `fk_matter_court_rule_practice_note_id` FOREIGN KEY (`practice_note_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`practice_note`(`practice_note_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_research_memo_id` FOREIGN KEY (`research_memo_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`research_memo`(`research_memo_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`phase` ADD CONSTRAINT `fk_matter_phase_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`checklist`(`checklist_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_risk` ADD CONSTRAINT `fk_matter_matter_risk_practice_note_id` FOREIGN KEY (`practice_note_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`practice_note`(`practice_note_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`court_filing` ADD CONSTRAINT `fk_matter_court_filing_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`form_template`(`form_template_id`);

-- ========= matter --> risk (10 constraint(s)) =========
-- Requires: matter schema, risk schema
ALTER TABLE `legal_ecm_v1`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_indemnity_exposure_id` FOREIGN KEY (`indemnity_exposure_id`) REFERENCES `legal_ecm_v1`.`risk`.`indemnity_exposure`(`indemnity_exposure_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_pi_claim_id` FOREIGN KEY (`pi_claim_id`) REFERENCES `legal_ecm_v1`.`risk`.`pi_claim`(`pi_claim_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_mitigation_action_id` FOREIGN KEY (`mitigation_action_id`) REFERENCES `legal_ecm_v1`.`risk`.`mitigation_action`(`mitigation_action_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `legal_ecm_v1`.`risk`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`risk_assessment` ADD CONSTRAINT `fk_matter_risk_assessment_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm_v1`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_control` ADD CONSTRAINT `fk_matter_matter_control_risk_control_id` FOREIGN KEY (`risk_control_id`) REFERENCES `legal_ecm_v1`.`risk`.`risk_control`(`risk_control_id`);

-- ========= matter --> service (8 constraint(s)) =========
-- Requires: matter schema, service schema
ALTER TABLE `legal_ecm_v1`.`matter`.`judge` ADD CONSTRAINT `fk_matter_judge_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`court_rule` ADD CONSTRAINT `fk_matter_court_rule_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`phase` ADD CONSTRAINT `fk_matter_phase_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm_v1`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`rate` ADD CONSTRAINT `fk_matter_rate_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm_v1`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`jurisdiction_practice_coverage` ADD CONSTRAINT `fk_matter_jurisdiction_practice_coverage_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);

-- ========= matter --> trust (3 constraint(s)) =========
-- Requires: matter schema, trust schema
ALTER TABLE `legal_ecm_v1`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_trust_disbursement_id` FOREIGN KEY (`trust_disbursement_id`) REFERENCES `legal_ecm_v1`.`trust`.`trust_disbursement`(`trust_disbursement_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);

-- ========= matter --> workforce (61 constraint(s)) =========
-- Requires: matter schema, workforce schema
ALTER TABLE `legal_ecm_v1`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_docket_lead_attorney_attorney_profile_id` FOREIGN KEY (`docket_lead_attorney_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_owner_timekeeper_id` FOREIGN KEY (`owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_owner_timekeeper_id` FOREIGN KEY (`owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`appearance` ADD CONSTRAINT `fk_matter_appearance_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_owner_timekeeper_id` FOREIGN KEY (`owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_owner_timekeeper_id` FOREIGN KEY (`owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_matter_attorney_profile_id` FOREIGN KEY (`matter_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_matter_supervising_partner_attorney_profile_id` FOREIGN KEY (`matter_supervising_partner_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_originating_attorney_attorney_profile_id` FOREIGN KEY (`originating_attorney_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`phase` ADD CONSTRAINT `fk_matter_phase_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`phase` ADD CONSTRAINT `fk_matter_phase_phase_last_modified_by_user_timekeeper_id` FOREIGN KEY (`phase_last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`phase` ADD CONSTRAINT `fk_matter_phase_phase_responsible_timekeeper_id` FOREIGN KEY (`phase_responsible_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_task_approved_by_timekeeper_id` FOREIGN KEY (`task_approved_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_task_assigned_timekeeper_id` FOREIGN KEY (`task_assigned_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_task_modified_by_timekeeper_id` FOREIGN KEY (`task_modified_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_task_timekeeper_id` FOREIGN KEY (`task_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_status_history` ADD CONSTRAINT `fk_matter_matter_status_history_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_status_history` ADD CONSTRAINT `fk_matter_matter_status_history_status_owner_timekeeper_id` FOREIGN KEY (`status_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`team` ADD CONSTRAINT `fk_matter_team_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`team` ADD CONSTRAINT `fk_matter_team_team_created_by_timekeeper_id` FOREIGN KEY (`team_created_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`team` ADD CONSTRAINT `fk_matter_team_team_modified_by_timekeeper_id` FOREIGN KEY (`team_modified_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_budget_modified_by_timekeeper_id` FOREIGN KEY (`budget_modified_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_budget_timekeeper_id` FOREIGN KEY (`budget_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_owner_timekeeper_id` FOREIGN KEY (`owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`event` ADD CONSTRAINT `fk_matter_event_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`event` ADD CONSTRAINT `fk_matter_event_event_responsible_timekeeper_id` FOREIGN KEY (`event_responsible_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`event` ADD CONSTRAINT `fk_matter_event_owner_timekeeper_id` FOREIGN KEY (`owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_disbursement` ADD CONSTRAINT `fk_matter_matter_disbursement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`counsel` ADD CONSTRAINT `fk_matter_counsel_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`rate` ADD CONSTRAINT `fk_matter_rate_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_risk` ADD CONSTRAINT `fk_matter_matter_risk_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_risk` ADD CONSTRAINT `fk_matter_matter_risk_owner_timekeeper_id` FOREIGN KEY (`owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`hold` ADD CONSTRAINT `fk_matter_hold_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`hold` ADD CONSTRAINT `fk_matter_hold_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`hold` ADD CONSTRAINT `fk_matter_hold_owner_timekeeper_id` FOREIGN KEY (`owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`court_filing` ADD CONSTRAINT `fk_matter_court_filing_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`court_filing` ADD CONSTRAINT `fk_matter_court_filing_court_last_modified_by_timekeeper_id` FOREIGN KEY (`court_last_modified_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`court_filing` ADD CONSTRAINT `fk_matter_court_filing_owner_timekeeper_id` FOREIGN KEY (`owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_outcome_responsible_timekeeper_id` FOREIGN KEY (`outcome_responsible_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_owner_timekeeper_id` FOREIGN KEY (`owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`assignment` ADD CONSTRAINT `fk_matter_assignment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`assignment` ADD CONSTRAINT `fk_matter_assignment_assignment_created_by_timekeeper_id` FOREIGN KEY (`assignment_created_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`assignment` ADD CONSTRAINT `fk_matter_assignment_assignment_last_modified_by_timekeeper_id` FOREIGN KEY (`assignment_last_modified_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_contact` ADD CONSTRAINT `fk_matter_matter_contact_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`risk_assessment` ADD CONSTRAINT `fk_matter_risk_assessment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`lateral_conflict` ADD CONSTRAINT `fk_matter_lateral_conflict_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`matter`.`matter_control` ADD CONSTRAINT `fk_matter_matter_control_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);

-- ========= risk --> billing (2 constraint(s)) =========
-- Requires: risk schema, billing schema
ALTER TABLE `legal_ecm_v1`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= risk --> client (12 constraint(s)) =========
-- Requires: risk schema, client schema
ALTER TABLE `legal_ecm_v1`.`risk`.`register` ADD CONSTRAINT `fk_risk_register_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`data_breach_incident` ADD CONSTRAINT `fk_risk_data_breach_incident_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`cyber_risk_event` ADD CONSTRAINT `fk_risk_cyber_risk_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`sanctions_screening` ADD CONSTRAINT `fk_risk_sanctions_screening_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`reputational_risk` ADD CONSTRAINT `fk_risk_reputational_risk_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`matter_risk_profile` ADD CONSTRAINT `fk_risk_matter_risk_profile_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`third_party_risk` ADD CONSTRAINT `fk_risk_third_party_risk_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `legal_ecm_v1`.`client`.`vendor`(`vendor_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`escalation` ADD CONSTRAINT `fk_risk_escalation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);

-- ========= risk --> compliance (1 constraint(s)) =========
-- Requires: risk schema, compliance schema
ALTER TABLE `legal_ecm_v1`.`risk`.`risk_control` ADD CONSTRAINT `fk_risk_risk_control_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm_v1`.`compliance`.`compliance_control`(`compliance_control_id`);

-- ========= risk --> conflict (1 constraint(s)) =========
-- Requires: risk schema, conflict schema
ALTER TABLE `legal_ecm_v1`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm_v1`.`conflict`.`check`(`check_id`);

-- ========= risk --> contract (2 constraint(s)) =========
-- Requires: risk schema, contract schema
ALTER TABLE `legal_ecm_v1`.`risk`.`sanctions_screening` ADD CONSTRAINT `fk_risk_sanctions_screening_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`third_party_risk` ADD CONSTRAINT `fk_risk_third_party_risk_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);

-- ========= risk --> matter (8 constraint(s)) =========
-- Requires: risk schema, matter schema
ALTER TABLE `legal_ecm_v1`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`data_breach_incident` ADD CONSTRAINT `fk_risk_data_breach_incident_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`cyber_risk_event` ADD CONSTRAINT `fk_risk_cyber_risk_event_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`sanctions_screening` ADD CONSTRAINT `fk_risk_sanctions_screening_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`matter_risk_profile` ADD CONSTRAINT `fk_risk_matter_risk_profile_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`escalation` ADD CONSTRAINT `fk_risk_escalation_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);

-- ========= risk --> trust (7 constraint(s)) =========
-- Requires: risk schema, trust schema
ALTER TABLE `legal_ecm_v1`.`risk`.`data_breach_incident` ADD CONSTRAINT `fk_risk_data_breach_incident_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`cyber_risk_event` ADD CONSTRAINT `fk_risk_cyber_risk_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`sanctions_screening` ADD CONSTRAINT `fk_risk_sanctions_screening_receipt_id` FOREIGN KEY (`receipt_id`) REFERENCES `legal_ecm_v1`.`trust`.`receipt`(`receipt_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`sanctions_screening` ADD CONSTRAINT `fk_risk_sanctions_screening_trust_disbursement_id` FOREIGN KEY (`trust_disbursement_id`) REFERENCES `legal_ecm_v1`.`trust`.`trust_disbursement`(`trust_disbursement_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`reputational_risk` ADD CONSTRAINT `fk_risk_reputational_risk_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`matter_risk_profile` ADD CONSTRAINT `fk_risk_matter_risk_profile_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`third_party_risk` ADD CONSTRAINT `fk_risk_third_party_risk_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm_v1`.`trust`.`account`(`account_id`);

-- ========= risk --> workforce (30 constraint(s)) =========
-- Requires: risk schema, workforce schema
ALTER TABLE `legal_ecm_v1`.`risk`.`register` ADD CONSTRAINT `fk_risk_register_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`register` ADD CONSTRAINT `fk_risk_register_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`register` ADD CONSTRAINT `fk_risk_register_register_risk_owner_attorney_profile_id` FOREIGN KEY (`register_risk_owner_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_primary_assessment_attorney_profile_id` FOREIGN KEY (`primary_assessment_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_reviewer_attorney_profile_id` FOREIGN KEY (`reviewer_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`risk_control` ADD CONSTRAINT `fk_risk_risk_control_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`risk_control` ADD CONSTRAINT `fk_risk_risk_control_risk_quaternary_approved_by_attorney_profile_id` FOREIGN KEY (`risk_quaternary_approved_by_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`risk_control` ADD CONSTRAINT `fk_risk_risk_control_tertiary_remediation_owner_attorney_profile_id` FOREIGN KEY (`tertiary_remediation_owner_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`cyber_risk_event` ADD CONSTRAINT `fk_risk_cyber_risk_event_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`cyber_risk_event` ADD CONSTRAINT `fk_risk_cyber_risk_event_cyber_escalated_to_user_timekeeper_id` FOREIGN KEY (`cyber_escalated_to_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`cyber_risk_event` ADD CONSTRAINT `fk_risk_cyber_risk_event_event_owner_timekeeper_id` FOREIGN KEY (`event_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`sanctions_screening` ADD CONSTRAINT `fk_risk_sanctions_screening_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`reputational_risk` ADD CONSTRAINT `fk_risk_reputational_risk_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`matter_risk_profile` ADD CONSTRAINT `fk_risk_matter_risk_profile_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`matter_risk_profile` ADD CONSTRAINT `fk_risk_matter_risk_profile_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`appetite` ADD CONSTRAINT `fk_risk_appetite_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`appetite` ADD CONSTRAINT `fk_risk_appetite_appetite_owner_timekeeper_id` FOREIGN KEY (`appetite_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`appetite` ADD CONSTRAINT `fk_risk_appetite_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`appetite` ADD CONSTRAINT `fk_risk_appetite_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_reviewer_attorney_profile_id` FOREIGN KEY (`reviewer_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`third_party_risk` ADD CONSTRAINT `fk_risk_third_party_risk_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`escalation` ADD CONSTRAINT `fk_risk_escalation_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`escalation` ADD CONSTRAINT `fk_risk_escalation_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`risk`.`escalation` ADD CONSTRAINT `fk_risk_escalation_escalation_owner_timekeeper_id` FOREIGN KEY (`escalation_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);

-- ========= service --> billing (1 constraint(s)) =========
-- Requires: service schema, billing schema
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_guideline_id` FOREIGN KEY (`guideline_id`) REFERENCES `legal_ecm_v1`.`billing`.`guideline`(`guideline_id`);

-- ========= service --> client (5 constraint(s)) =========
-- Requires: service schema, client schema
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ADD CONSTRAINT `fk_service_tier_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `legal_ecm_v1`.`client`.`segment`(`segment_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ADD CONSTRAINT `fk_service_pricing_model_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `legal_ecm_v1`.`client`.`segment`(`segment_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ADD CONSTRAINT `fk_service_rate_card_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ADD CONSTRAINT `fk_service_scope_amendment_client_engagement_scope_id` FOREIGN KEY (`client_engagement_scope_id`) REFERENCES `legal_ecm_v1`.`client`.`client_engagement_scope`(`client_engagement_scope_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ADD CONSTRAINT `fk_service_scope_amendment_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm_v1`.`client`.`client_contact`(`client_contact_id`);

-- ========= service --> conflict (1 constraint(s)) =========
-- Requires: service schema, conflict schema
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_clearance_id` FOREIGN KEY (`clearance_id`) REFERENCES `legal_ecm_v1`.`conflict`.`clearance`(`clearance_id`);

-- ========= service --> intake (1 constraint(s)) =========
-- Requires: service schema, intake schema
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm_v1`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);

-- ========= service --> knowledge (1 constraint(s)) =========
-- Requires: service schema, knowledge schema
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ADD CONSTRAINT `fk_service_lpm_template_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);

-- ========= service --> matter (4 constraint(s)) =========
-- Requires: service schema, matter schema
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ADD CONSTRAINT `fk_service_rate_card_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ADD CONSTRAINT `fk_service_jurisdiction_coverage_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `legal_ecm_v1`.`matter`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ADD CONSTRAINT `fk_service_scope_amendment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);

-- ========= service --> risk (6 constraint(s)) =========
-- Requires: service schema, risk schema
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ADD CONSTRAINT `fk_service_practice_area_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm_v1`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ADD CONSTRAINT `fk_service_legal_service_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm_v1`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ADD CONSTRAINT `fk_service_tier_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `legal_ecm_v1`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ADD CONSTRAINT `fk_service_pricing_model_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm_v1`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`package` ADD CONSTRAINT `fk_service_package_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `legal_ecm_v1`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ADD CONSTRAINT `fk_service_delivery_model_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm_v1`.`risk`.`category`(`category_id`);

-- ========= service --> workforce (25 constraint(s)) =========
-- Requires: service schema, workforce schema
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ADD CONSTRAINT `fk_service_legal_service_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ADD CONSTRAINT `fk_service_pricing_model_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ADD CONSTRAINT `fk_service_pricing_model_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ADD CONSTRAINT `fk_service_pricing_model_pricing_last_modified_by_user_timekeeper_id` FOREIGN KEY (`pricing_last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ADD CONSTRAINT `fk_service_rate_card_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`package` ADD CONSTRAINT `fk_service_package_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`package` ADD CONSTRAINT `fk_service_package_package_owner_timekeeper_id` FOREIGN KEY (`package_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`package` ADD CONSTRAINT `fk_service_package_primary_package_approved_by_partner_timekeeper_id` FOREIGN KEY (`primary_package_approved_by_partner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ADD CONSTRAINT `fk_service_offering_version_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ADD CONSTRAINT `fk_service_offering_version_offering_last_modified_by_user_timekeeper_id` FOREIGN KEY (`offering_last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ADD CONSTRAINT `fk_service_offering_version_version_owner_timekeeper_id` FOREIGN KEY (`version_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_matter_last_modified_by_user_timekeeper_id` FOREIGN KEY (`matter_last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_primary_matter_approved_by_timekeeper_id` FOREIGN KEY (`primary_matter_approved_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_tertiary_matter_lead_associate_timekeeper_id` FOREIGN KEY (`tertiary_matter_lead_associate_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ADD CONSTRAINT `fk_service_delivery_model_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ADD CONSTRAINT `fk_service_delivery_model_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ADD CONSTRAINT `fk_service_scope_amendment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ADD CONSTRAINT `fk_service_scope_amendment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ADD CONSTRAINT `fk_service_scope_amendment_scope_modified_by_user_timekeeper_id` FOREIGN KEY (`scope_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_primary_eligibility_timekeeper_id` FOREIGN KEY (`primary_eligibility_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_rule_owner_timekeeper_id` FOREIGN KEY (`rule_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ADD CONSTRAINT `fk_service_lpm_template_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`line` ADD CONSTRAINT `fk_service_line_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);

-- ========= trust --> billing (10 constraint(s)) =========
-- Requires: trust schema, billing schema
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_retainer_id` FOREIGN KEY (`retainer_id`) REFERENCES `legal_ecm_v1`.`billing`.`retainer`(`retainer_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_retainer_id` FOREIGN KEY (`retainer_id`) REFERENCES `legal_ecm_v1`.`billing`.`retainer`(`retainer_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_ar_balance_id` FOREIGN KEY (`ar_balance_id`) REFERENCES `legal_ecm_v1`.`billing`.`ar_balance`(`ar_balance_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_payment_allocation_id` FOREIGN KEY (`payment_allocation_id`) REFERENCES `legal_ecm_v1`.`billing`.`payment_allocation`(`payment_allocation_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ADD CONSTRAINT `fk_trust_retainer_replenishment_retainer_id` FOREIGN KEY (`retainer_id`) REFERENCES `legal_ecm_v1`.`billing`.`retainer`(`retainer_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ADD CONSTRAINT `fk_trust_escrow_release_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= trust --> client (14 constraint(s)) =========
-- Requires: trust schema, client schema
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ADD CONSTRAINT `fk_trust_reconciliation_item_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ADD CONSTRAINT `fk_trust_retainer_replenishment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ADD CONSTRAINT `fk_trust_escrow_release_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);

-- ========= trust --> compliance (29 constraint(s)) =========
-- Requires: trust schema, compliance schema
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `legal_ecm_v1`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm_v1`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm_v1`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_aml_risk_assessment_id` FOREIGN KEY (`aml_risk_assessment_id`) REFERENCES `legal_ecm_v1`.`compliance`.`aml_risk_assessment`(`aml_risk_assessment_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm_v1`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm_v1`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ADD CONSTRAINT `fk_trust_bank_statement_regulatory_return_id` FOREIGN KEY (`regulatory_return_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_return`(`regulatory_return_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ADD CONSTRAINT `fk_trust_iolta_interest_remittance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm_v1`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm_v1`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm_v1`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `legal_ecm_v1`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_regulatory_return_id` FOREIGN KEY (`regulatory_return_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_return`(`regulatory_return_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `legal_ecm_v1`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_control_framework_id` FOREIGN KEY (`control_framework_id`) REFERENCES `legal_ecm_v1`.`compliance`.`control_framework`(`control_framework_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_indemnity_policy_id` FOREIGN KEY (`indemnity_policy_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_policy`(`indemnity_policy_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `legal_ecm_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm_v1`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `legal_ecm_v1`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ADD CONSTRAINT `fk_trust_trust_control_test_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm_v1`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_control_test` ADD CONSTRAINT `fk_trust_trust_control_test_compliance_control_test_id` FOREIGN KEY (`compliance_control_test_id`) REFERENCES `legal_ecm_v1`.`compliance`.`compliance_control_test`(`compliance_control_test_id`);

-- ========= trust --> contract (7 constraint(s)) =========
-- Requires: trust schema, contract schema
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm_v1`.`contract`.`contract_agreement`(`contract_agreement_id`);

-- ========= trust --> document (1 constraint(s)) =========
-- Requires: trust schema, document schema
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm_v1`.`document`.`legal_document`(`legal_document_id`);

-- ========= trust --> intake (1 constraint(s)) =========
-- Requires: trust schema, intake schema
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_intake_fee_arrangement_id` FOREIGN KEY (`intake_fee_arrangement_id`) REFERENCES `legal_ecm_v1`.`intake`.`intake_fee_arrangement`(`intake_fee_arrangement_id`);

-- ========= trust --> knowledge (5 constraint(s)) =========
-- Requires: trust schema, knowledge schema
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`checklist`(`checklist_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`checklist`(`checklist_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`precedent`(`precedent_id`);

-- ========= trust --> matter (14 constraint(s)) =========
-- Requires: trust schema, matter schema
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ADD CONSTRAINT `fk_trust_reconciliation_item_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ADD CONSTRAINT `fk_trust_retainer_replenishment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ADD CONSTRAINT `fk_trust_escrow_release_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);

-- ========= trust --> risk (5 constraint(s)) =========
-- Requires: trust schema, risk schema
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_indemnity_exposure_id` FOREIGN KEY (`indemnity_exposure_id`) REFERENCES `legal_ecm_v1`.`risk`.`indemnity_exposure`(`indemnity_exposure_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_indemnity_exposure_id` FOREIGN KEY (`indemnity_exposure_id`) REFERENCES `legal_ecm_v1`.`risk`.`indemnity_exposure`(`indemnity_exposure_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm_v1`.`risk`.`register`(`register_id`);

-- ========= trust --> service (5 constraint(s)) =========
-- Requires: trust schema, service schema
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);

-- ========= trust --> workforce (42 constraint(s)) =========
-- Requires: trust schema, workforce schema
ALTER TABLE `legal_ecm_v1`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_receipt_modified_by_user_timekeeper_id` FOREIGN KEY (`receipt_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_receipt_owner_timekeeper_id` FOREIGN KEY (`receipt_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_tertiary_disbursement_rejecting_approver_attorney_profile_id` FOREIGN KEY (`tertiary_disbursement_rejecting_approver_attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_primary_three_timekeeper_id` FOREIGN KEY (`primary_three_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_reviewer_timekeeper_id` FOREIGN KEY (`reviewer_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_item` ADD CONSTRAINT `fk_trust_reconciliation_item_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ADD CONSTRAINT `fk_trust_bank_statement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement` ADD CONSTRAINT `fk_trust_bank_statement_statement_owner_timekeeper_id` FOREIGN KEY (`statement_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ADD CONSTRAINT `fk_trust_bank_statement_line_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ADD CONSTRAINT `fk_trust_bank_statement_line_bank_reconciled_by_user_timekeeper_id` FOREIGN KEY (`bank_reconciled_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ADD CONSTRAINT `fk_trust_bank_statement_line_bank_voided_by_user_timekeeper_id` FOREIGN KEY (`bank_voided_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`bank_statement_line` ADD CONSTRAINT `fk_trust_bank_statement_line_line_owner_timekeeper_id` FOREIGN KEY (`line_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`iolta_interest_remittance` ADD CONSTRAINT `fk_trust_iolta_interest_remittance_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_transfer_modified_by_user_timekeeper_id` FOREIGN KEY (`transfer_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_transfer_owner_timekeeper_id` FOREIGN KEY (`transfer_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_transfer_reconciled_by_user_timekeeper_id` FOREIGN KEY (`transfer_reconciled_by_user_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_retainer_last_modified_by_timekeeper_id` FOREIGN KEY (`retainer_last_modified_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`retainer_replenishment` ADD CONSTRAINT `fk_trust_retainer_replenishment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`escrow_release` ADD CONSTRAINT `fk_trust_escrow_release_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ADD CONSTRAINT `fk_trust_reconciliation_period_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`trust`.`reconciliation_period` ADD CONSTRAINT `fk_trust_reconciliation_period_reconciliation_prepared_by_user_id` FOREIGN KEY (`reconciliation_prepared_by_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);

-- ========= workforce --> client (2 constraint(s)) =========
-- Requires: workforce schema, client schema
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ADD CONSTRAINT `fk_workforce_billing_rate_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm_v1`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ADD CONSTRAINT `fk_workforce_secondment_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm_v1`.`client`.`organisation`(`organisation_id`);

-- ========= workforce --> intake (1 constraint(s)) =========
-- Requires: workforce schema, intake schema
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ADD CONSTRAINT `fk_workforce_rfp_team_assignment_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm_v1`.`intake`.`rfp_submission`(`rfp_submission_id`);

-- ========= workforce --> knowledge (2 constraint(s)) =========
-- Requires: workforce schema, knowledge schema
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ADD CONSTRAINT `fk_workforce_cle_completion_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ADD CONSTRAINT `fk_workforce_practice_group_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `legal_ecm_v1`.`knowledge`.`taxonomy`(`taxonomy_id`);

-- ========= workforce --> matter (7 constraint(s)) =========
-- Requires: workforce schema, matter schema
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ADD CONSTRAINT `fk_workforce_bar_admission_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `legal_ecm_v1`.`matter`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ADD CONSTRAINT `fk_workforce_bar_admission_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ADD CONSTRAINT `fk_workforce_billing_rate_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ADD CONSTRAINT `fk_workforce_matter_assignment_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `legal_ecm_v1`.`matter`.`budget`(`budget_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ADD CONSTRAINT `fk_workforce_matter_assignment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ADD CONSTRAINT `fk_workforce_secondment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ADD CONSTRAINT `fk_workforce_disciplinary_record_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm_v1`.`matter`.`matter`(`matter_id`);

-- ========= workforce --> service (2 constraint(s)) =========
-- Requires: workforce schema, service schema
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ADD CONSTRAINT `fk_workforce_practice_group_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);

